class ChatThreadModel {
  final String id;
  final String? title;
  final String? lastMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int messageCount;

  ChatThreadModel({
    required this.id,
    this.title,
    this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
    this.messageCount = 0,
  });

  factory ChatThreadModel.fromJson(Map<String, dynamic> json) {
    return ChatThreadModel(
      id: json['id'],
      title: json['title'],
      lastMessage: json['lastMessage'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      messageCount: json['messageCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lastMessage': lastMessage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'messageCount': messageCount,
    };
  }
}