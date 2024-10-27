import 'package:dio/dio.dart';
import 'package:my_jarvis/core/api_constants.dart';
import '../../home/models/chat_thread_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  final Dio dio;

  ChatRepository() : dio = Dio() {
    dio.options.baseUrl = ApiConstants.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);

    // Add logging interceptor
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  // Send message
  Future<MessageModel> sendMessage(String content) async {
    try {
      final response = await dio.post(
        '/chat/send',
        data: {
          'content': content,
        },
      );

      return MessageModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    }
  }

  // Get chat history
  Future<List<MessageModel>> getChatHistory() async {
    try {
      final response = await dio.get('/chat/history');

      return (response.data as List)
          .map((json) => MessageModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    }
  }

  // Get chat thread
  Future<List<MessageModel>> getChatThread(String threadId) async {
    try {
      final response = await dio.get('/chat/thread/$threadId');

      return (response.data as List)
          .map((json) => MessageModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    }
  }

  // Send image message
  Future<MessageModel> sendImageMessage(String imagePath) async {
    try {
      String fileName = imagePath.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imagePath, filename: fileName),
      });

      final response = await dio.post(
        '/chat/send-image',
        data: formData,
      );

      return MessageModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    }
  }

  // Create new chat thread
  Future<String> createChatThread() async {
    try {
      final response = await dio.post('/chat/thread/create');
      return response.data['threadId'];
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    }
  }

  // Delete chat thread
  Future<void> deleteChatThread(String threadId) async {
    try {
      await dio.delete('/chat/thread/$threadId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'An unexpected error occurred';
    }
  }

  Future<List<ChatThreadModel>> getChatThreads() async {
    try {
      final response = await dio.get('/chat/threads');

      if (response.data is List) {
        return (response.data as List)
            .map((json) => ChatThreadModel.fromJson(json))
            .toList();
      }

      // If response is paginated
      if (response.data['data'] is List) {
        return (response.data['data'] as List)
            .map((json) => ChatThreadModel.fromJson(json))
            .toList();
      }

      return [];
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw 'Failed to fetch chat threads: $e';
    }
  }

  // Set token for authenticated requests
  void setToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Error Handler
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';

      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            return e.response?.data['message'] ?? 'Bad request';
          case 401:
            return 'Unauthorized. Please login again.';
          case 403:
            return 'Access denied.';
          case 404:
            return 'Chat service not found.';
          case 500:
            return 'Server error. Please try again later.';
          default:
            return 'Chat service error. Please try again.';
        }

      case DioExceptionType.cancel:
        return 'Request cancelled';

      case DioExceptionType.unknown:
        if (e.error != null && e.error.toString().contains('SocketException')) {
          return 'No internet connection';
        }
        return 'An unexpected error occurred';

      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
