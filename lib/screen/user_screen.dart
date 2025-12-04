import 'package:flutter/material.dart';
import '../api/user_api.dart';
import '../model/User.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // Future contenant la liste des users (chargés depuis l’API)
  late Future<List<UserModel>> futureUsers;
  @override
  void initState() {
    super.initState();
    // Appel de l'API dès l'ouverture de l'écran
    futureUsers = UserApi().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre supérieure de la page
      appBar: AppBar(title: const Text('Users')),
      // FutureBuilder permet d’afficher du contenu une fois la Future terminée
      body: FutureBuilder<List<UserModel>>(
        future: futureUsers,
        // builder = fonction appelée à chaque changement d’état du Future
        builder: (context, snapshot) {
          // 1. Affichage d’un loader pendant le chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Affichage d’un message d’erreur si l'API échoue
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          // 3. Cas où aucune donnée n'est retournée
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun utilisateur trouvé.'));
          }
          // Liste des users une fois chargés
          final users = snapshot.data!;
          // 4. Affichage de la liste sous forme de ListView
          return ListView.builder(
            itemCount: users.length, // nombre de users
            itemBuilder: (context, index) {
              final u = users[index]; // user courant
              return Card(
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
                      Row(
                        children: [
                          Text(u.nom, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 4),
                          Text(u.prenom, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Inscrit depuis le "
                        "${u.dateInscription.day.toString().padLeft(2, '0')}/"
                        "${u.dateInscription.month.toString().padLeft(2, '0')}/"
                        "${u.dateInscription.year} "
                        "à "
                        "${u.dateInscription.hour.toString().padLeft(2, '0')}:"
                        "${u.dateInscription.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
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
