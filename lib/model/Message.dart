class MessageModel {
  final int id;
  final String title;
  final String content;
  final DateTime postedAt;
  final String userLastName;
  final String userFirstName;
  final int? parentId;

  MessageModel({
    required this.id,
    required this.title,
    required this.content,
    required this.postedAt,
    required this.userLastName,
    required this.userFirstName,
    this.parentId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};

    return MessageModel(
      id: json['id'] ?? 0,
      title: json['titre'] ?? '',
      content: json['contenu'] ?? '',
      postedAt: DateTime.parse(json['datePoste']),
      userLastName: user['nom'] ?? '',
      userFirstName: user['prenom'] ?? '',
      parentId: json['parent'] != null
          ? int.parse(json['parent']['@id'].split('/').last)
          : null,
    );
  }
}
