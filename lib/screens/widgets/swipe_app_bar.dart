import 'package:flutter/material.dart';

class SwipeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackArrow;
  final List<Widget>? actions;
  final Widget? leading;

  const SwipeAppBar({
    super.key,
    required this.title,
    this.showBackArrow = false,
    this.actions,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: showBackArrow,
      leading: leading,
      title: Text(title),
      actions: actions,
    );
  }
}
