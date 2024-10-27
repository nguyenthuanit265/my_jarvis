import 'package:get/get.dart';
import '../../chat/repositories/chat_repository.dart';
import '../controller/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRepository>(
      () => ChatRepository(),
      fenix: true,
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        chatRepository: Get.find<ChatRepository>(),
      ),
    );
  }
}
