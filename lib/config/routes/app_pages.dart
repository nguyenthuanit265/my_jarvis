import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_jarvis/modules/chat/views/chat_detail_screen.dart';
import 'package:my_jarvis/modules/chat/views/chat_view.dart';

import '../../modules/chat/bindings/chat_binding.dart';
import '../../modules/home/binding/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(
        key: UniqueKey(), // Add unique key
      ),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
      children: [
        GetPage(name: Routes.CHAT_DETAIL, page: () => ChatDetailScreen()),
      ],
    ),
  ];
}
