import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/chat_controller.dart';
import '../widgets/chat_input.dart';
import '../widgets/message_bubble.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key}); // Add key parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                reverse: true,
                padding: const EdgeInsets.only(top: 16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final isLast = index == 0;

                  return MessageBubble(
                    key: ValueKey(message.id), // Add key for list items
                    message: message,
                    isLast: isLast,
                  );
                },
              ),
            ),
          ),
          Obx(() => ChatInput(
            key: const ValueKey('chatInput'), // Add key for input
            isLoading: controller.isLoading.value,
            onSend: (message) {
              controller.sendMessage(message);
            },
            onAttachmentTap: () {
              _handleAttachment();
            },
            onCameraTap: () {
              _handleCamera();
            },
          )),
        ],
      ),
    );
  }

  void _handleAttachment() async {
    final result = await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Photo Library'),
              onTap: () {
                Get.back(result: 'photo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_copy),
              title: const Text('Document'),
              onTap: () {
                Get.back(result: 'document');
              },
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      switch (result) {
        case 'photo':
        // Handle photo selection
          break;
        case 'document':
        // Handle document selection
          break;
      }
    }
  }

  void _handleCamera() async {
    // Handle camera functionality
  }
}