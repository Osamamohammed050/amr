import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _isScrolled = false;
  bool get isScrolled => _isScrolled;

  void updateScroll(bool value) {
    if (_isScrolled != value) {
      _isScrolled = value;
      notifyListeners();
    }
  }
}
