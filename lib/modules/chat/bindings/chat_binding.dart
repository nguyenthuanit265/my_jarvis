import 'package:get/get.dart';
import '../controller/chat_controller.dart';
import '../repositories/chat_repository.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRepository>(
      () => ChatRepository(),
    );

    Get.lazyPut<ChatController>(
      () => ChatController(
        repository: Get.find<ChatRepository>(),
      ),
    );
  }
}
