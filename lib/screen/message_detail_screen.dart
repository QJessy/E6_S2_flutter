import 'package:flutter/material.dart';
import '../model/Message.dart';

class MessageDetailScreen extends StatelessWidget {
  final MessageModel message; // Renommé pour plus de clarté

  const MessageDetailScreen({super.key, required this.message});

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} "
        "à "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(message.title)), // Titre du message en haut
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Ajout d'un scroll au cas où le contenu est long
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Détails du message',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Titre :',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  Text(message.title, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 15),
                  Text(
                    'Auteur :',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  Text('${message.userFirstName} ${message.userLastName}',
                      style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 15),
                  Text(
                    'Contenu :',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  Text(message.content, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  const Divider(),
                  Text(
                    'Posté le : ${_formatDate(message.postedAt)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}