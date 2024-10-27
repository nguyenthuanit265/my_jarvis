import 'dart:convert';

class MessageModel {
  final String id;
  final String content;
  final String senderId;
  final String recipientId;
  final DateTime timestamp;
  final MessageType type;
  final MessageStatus status;
  final bool isAI;
  final Map<String, dynamic>? metadata;

  MessageModel({
    required this.id,
    required this.content,
    required this.senderId,
    required this.recipientId,
    required this.timestamp,
    this.type = MessageType.text,
    this.status = MessageStatus.sent,
    this.isAI = false,
    this.metadata,
  });

  // Create a copy of message with updated fields
  MessageModel copyWith({
    String? id,
    String? content,
    String? senderId,
    String? recipientId,
    DateTime? timestamp,
    MessageType? type,
    MessageStatus? status,
    bool? isAI,
    Map<String, dynamic>? metadata,
  }) {
    return MessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      status: status ?? this.status,
      isAI: isAI ?? this.isAI,
      metadata: metadata ?? this.metadata,
    );
  }

  // Convert message to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'recipientId': recipientId,
      'timestamp': timestamp.toIso8601String(),
      'type': type.toString(),
      'status': status.toString(),
      'isAI': isAI,
      'metadata': metadata,
    };
  }

  // Create message from JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'],
      senderId: json['senderId'],
      recipientId: json['recipientId'],
      timestamp: DateTime.parse(json['timestamp']),
      type: MessageType.values.firstWhere(
            (e) => e.toString() == json['type'],
        orElse: () => MessageType.text,
      ),
      status: MessageStatus.values.firstWhere(
            (e) => e.toString() == json['status'],
        orElse: () => MessageStatus.sent,
      ),
      isAI: json['isAI'] ?? false,
      metadata: json['metadata'],
    );
  }

  // Create empty message
  factory MessageModel.empty() {
    return MessageModel(
      id: '',
      content: '',
      senderId: '',
      recipientId: '',
      timestamp: DateTime.now(),
    );
  }

  // String representation for debugging
  @override
  String toString() {
    return 'MessageModel(id: $id, content: $content, senderId: $senderId, '
        'recipientId: $recipientId, timestamp: $timestamp, type: $type, '
        'status: $status, isAI: $isAI, metadata: $metadata)';
  }
}

// Message type enum
enum MessageType {
  text,
  image,
  file,
  system,
  error,
  loading
}

// Message status enum
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed
}

// Extension methods for MessageType
extension MessageTypeExtension on MessageType {
  bool get isText => this == MessageType.text;
  bool get isImage => this == MessageType.image;
  bool get isFile => this == MessageType.file;
  bool get isSystem => this == MessageType.system;
  bool get isError => this == MessageType.error;
  bool get isLoading => this == MessageType.loading;
}

// Extension methods for MessageStatus
extension MessageStatusExtension on MessageStatus {
  bool get isSending => this == MessageStatus.sending;
  bool get isSent => this == MessageStatus.sent;
  bool get isDelivered => this == MessageStatus.delivered;
  bool get isRead => this == MessageStatus.read;
  bool get isFailed => this == MessageStatus.failed;
}