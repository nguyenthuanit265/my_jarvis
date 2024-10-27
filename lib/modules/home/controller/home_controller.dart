import 'package:get/get.dart';
import '../../chat/repositories/chat_repository.dart';
import '../models/chat_thread_model.dart';

class HomeController extends GetxController {
  final ChatRepository chatRepository;

  // Observable variables
  final chatThreads = <ChatThreadModel>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  HomeController({
    required this.chatRepository,
  });

  @override
  void onInit() {
    super.onInit();
    fetchChatThreads();
  }

  Future<void> fetchChatThreads() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final threads = await chatRepository.getChatThreads();
      chatThreads.assignAll(threads);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createNewChat() async {
    try {
      isLoading.value = true;
      final newThreadId = await chatRepository.createChatThread();
      Get.toNamed('/chat/detail', arguments: {'threadId': newThreadId});
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create new chat',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteThread(String threadId) async {
    try {
      await chatRepository.deleteChatThread(threadId);
      chatThreads.removeWhere((thread) => thread.id == threadId);

      Get.snackbar(
        'Success',
        'Chat deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete chat',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void refreshThreads() {
    fetchChatThreads();
  }
}
