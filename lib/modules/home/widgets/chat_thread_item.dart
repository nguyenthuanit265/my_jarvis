import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/chat_thread_model.dart';

class ChatThreadItem extends StatelessWidget {
  final ChatThreadModel thread;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ChatThreadItem({
    Key? key,
    required this.thread,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          child: Icon(Icons.chat),
        ),
        title: Text(
          thread.title ?? 'New Chat',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          thread.lastMessage ?? 'No messages yet',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              timeago.format(thread.updatedAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'delete',
                  child: const Text('Delete'),
                  onTap: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}