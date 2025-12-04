class UserModel {
  final int id;
  final String nom;
  final String prenom;
  final DateTime dateInscription;

  UserModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.dateInscription,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      dateInscription: DateTime.parse(json['dateInscription']),
    );
  }
}
