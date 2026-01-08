/// Session manager to track authenticated clients
class SessionManager {
  SessionManager._();

  static final SessionManager _instance = SessionManager._();
  static SessionManager get instance => _instance;

  final Set<String> _authenticatedClients = {};

  /// Check if a client is authenticated in the current session
  bool isAuthenticated(String clientName) {
    return _authenticatedClients.contains(clientName);
  }

  /// Mark a client as authenticated
  void authenticate(String clientName) {
    _authenticatedClients.add(clientName);
  }

  /// Clear authentication for a specific client
  void logout(String clientName) {
    _authenticatedClients.remove(clientName);
  }

  /// Clear all authenticated clients
  void logoutAll() {
    _authenticatedClients.clear();
  }
}
