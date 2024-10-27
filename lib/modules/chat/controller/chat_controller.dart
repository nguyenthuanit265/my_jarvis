import 'package:get/get.dart';
import '../models/message_model.dart';
import '../repositories/chat_repository.dart';

class ChatController extends GetxController {
  final ChatRepository repository;
  final messages = <MessageModel>[].obs;
  final isLoading = false.obs;

  ChatController({required this.repository});

  Future<void> sendMessage(String content) async {
    try {
      isLoading.value = true;
      final response = await repository.sendMessage(content);
      messages.add(response);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadChatHistory() async {
    try {
      isLoading.value = true;
      final history = await repository.getChatHistory();
      messages.assignAll(history);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
