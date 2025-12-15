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
    final dateString = json['dateInscription'] as String? ?? '';

    return UserModel(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      dateInscription: dateString.isNotEmpty
          ? DateTime.parse(dateString)
          : DateTime.now(),
    );
  }
}
