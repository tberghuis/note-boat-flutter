import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class KeyboardListener extends StatefulWidget {
  final Widget child;
  final void Function(bool) onChange;
  KeyboardListener({@required this.child, @required this.onChange});
  @override
  _KeyboardListenerState createState() => _KeyboardListenerState();
}

class _KeyboardListenerState extends State<KeyboardListener> {
  int _sId;

  @override
  void initState() {
    super.initState();
    _sId = KeyboardVisibilityNotification().addNewListener(
      onChange: widget.onChange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    KeyboardVisibilityNotification().removeListener(_sId);
    super.dispose();
  }
}
