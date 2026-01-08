/// Centralized configuration for Rive assets
class RiveAssets {
  RiveAssets._();

  /// Base path for Rive assets
  static const String basePath = 'assets/rive';

  /// Map of client name to list of their Rive files
  static const Map<String, List<String>> _clientFiles = {
    'client_name_0': [
      'cheeky_chops.riv',
      'choose_your_avatar.riv',
    ],
    'client_name_1': [
      'cheeky_chops copy 2.riv',
      'cheeky_chops copy.riv',
      'cheeky_chops.riv',
      'choose_your_avatar.riv',
    ],
  };

  /// Map of client name to their unique password
  static const Map<String, String> _clientPasswords = {
    'client_name_0': 'W[^@]P@If=Zs2UI!',
    'client_name_1': 'n7)-9:f9euK*-UDDOx<*,AHg]s',
  };

  /// Get list of all available clients
  static List<String> get clients => _clientFiles.keys.toList();

  /// Get list of Rive files for a specific client
  static List<String> getClientFiles(String clientName) {
    return _clientFiles[clientName] ?? [];
  }

  /// Check if the provided password matches the client's password
  static bool checkClientPassword(String clientName, String password) {
    return _clientPasswords[clientName] == password;
  }

  /// Get full asset path for a client's Rive file
  static String getAssetPath(String clientName, String fileName) {
    return '$basePath/$clientName/$fileName';
  }

  /// Check if a file exists for a specific client
  static bool isValidFile(String clientName, String fileName) {
    return _clientFiles[clientName]?.contains(fileName) ?? false;
  }
}
