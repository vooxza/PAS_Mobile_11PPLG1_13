import 'package:flutter/material.dart';

typedef BookmarkChanged = void Function(bool isBookmarked);

typedef BookmarkConfirm = Future<bool> Function(bool newValue);

class WidgetBookmark extends StatefulWidget {
  final bool initialValue;
  final BookmarkChanged? onChanged;
  final BookmarkConfirm? onConfirm;

  const WidgetBookmark({Key? key, this.initialValue = false, this.onChanged, this.onConfirm}) : super(key: key);

  @override
  State<WidgetBookmark> createState() => _WidgetBookmarkState();
}

class _WidgetBookmarkState extends State<WidgetBookmark> {
  late bool _bookmarked;

  @override
  void initState() {
    super.initState();
    _bookmarked = widget.initialValue;
  }

  Future<void> _toggle() async {
    final newValue = !_bookmarked;
    if (widget.onConfirm != null) {
      final allowed = await widget.onConfirm!.call(newValue);
      if (!allowed) return;
    }
    setState(() {
      _bookmarked = newValue;
    });
    widget.onChanged?.call(_bookmarked);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _bookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: _bookmarked ? Colors.amber : null,
      ),
      onPressed: () => _toggle(),
      tooltip: _bookmarked ? 'Remove bookmark' : 'Add bookmark',
    );
  }
}
