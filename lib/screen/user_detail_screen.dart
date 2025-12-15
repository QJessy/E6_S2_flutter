import 'package:flutter/material.dart';
import '../model/User.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} "
        "à "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }

  String _getOrdinalSuffix(int number) {
    if (number == 1) {
      return 'er';
    }
    return 'ème';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${user.prenom} ${user.nom}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Détails de l\'utilisateur',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                Text(
                  'Vous êtes le ${user.id}${_getOrdinalSuffix(user.id)} utilisateur de l\'application',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text('Nom: ${user.nom}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text(
                  'Prénom: ${user.prenom}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Inscrit le: ${_formatDate(user.dateInscription)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
