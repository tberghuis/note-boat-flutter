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
  KeyboardVisibilityNotification _kvn;

  @override
  void initState() {
    super.initState();
    _kvn = KeyboardVisibilityNotification();
    _sId = _kvn.addNewListener(
      onChange: widget.onChange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  // is this needed???
  @override
  void dispose() {
    _kvn.removeListener(_sId);
    super.dispose();
  }
}
