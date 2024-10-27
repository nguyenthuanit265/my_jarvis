class ApiConstants {
  static const String baseUrl = '';
  static const int connectionTimeout = 5000; // 5 seconds
  static const int receiveTimeout = 3000; // 3 seconds

  // API Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String profile = '/auth/profile';
  static const String changePassword = '/auth/change-password';
  static const String logout = '/auth/logout';
  static const String googleSignIn = '/auth/google';
}
