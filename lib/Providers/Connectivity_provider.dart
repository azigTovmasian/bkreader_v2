import "package:flutter/material.dart";

class ConnectivityProv with ChangeNotifier {
  bool _hasEntredApp = false;

  hasEntredApp() => _hasEntredApp;

  setHasEntredApp(bool hasEntredApp) {
    _hasEntredApp = hasEntredApp;
    notifyListeners();
  }
}
