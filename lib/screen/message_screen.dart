import 'package:flutter/material.dart';
import '../api/message_api.dart';
import '../model/Message.dart';
import '../screen/message_detail_screen.dart';
import 'ajout_message_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late Future<List<MessageModel>> futureMessages;

  @override
  void initState() {
    super.initState();
    futureMessages = MessageApi().fetchMessages();
  }

  // On garde une seule fois la méthode de navigation
  void detailMessage(MessageModel message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessageDetailScreen(message: message),
      ),
    );
  }

  void _refreshMessages() {
    setState(() {
      futureMessages = MessageApi().fetchMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // On attend le résultat de la page d'ajout
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AjoutMessageScreen()),
              );
              // Si result est true, on rafraîchit la liste
              if (result == true) {
                _refreshMessages();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<MessageModel>>(
        future: futureMessages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun message trouvé.'));
          }

          final messages = snapshot.data!;

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final m = messages[index];
              return GestureDetector(
                onTap: () => detailMessage(m),
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${m.postedAt.day.toString().padLeft(2, '0')}/"
                          "${m.postedAt.month.toString().padLeft(2, '0')}/"
                          "${m.postedAt.year} à ${m.postedAt.hour.toString().padLeft(2, '0')}:${m.postedAt.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          m.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          m.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${m.userFirstName} ${m.userLastName}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}