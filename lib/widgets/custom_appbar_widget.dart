import 'package:feed_me/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/utils_provider.dart';

class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final double? fontSize;
  final bool? centerTitle;
  final bool? disappearWhenScrolled;
  final bool? isUsingDefaultColorTheme;
  final List<Widget>? slivers;
  final Widget? image;
  final Color? color;
  final Widget? imageTitle;
  final ScrollController? scrollController;
  final IconThemeData? iconTheme;
  final Widget? leading;
  final List<Widget>? actionList;

  const CustomAppBarWidget({
    super.key,
    this.title,
    this.titleWidget,
    this.fontSize = 25,
    this.centerTitle = true,
    this.disappearWhenScrolled = false,
    this.isUsingDefaultColorTheme = true,
    this.slivers,
    this.color,
    this.image,
    this.imageTitle,
    this.scrollController,
    this.iconTheme,
    this.leading,
    this.actionList,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarWidgetState createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  void onBackButtonPressed() {
    Provider.of<UtilsProvider>(context, listen: false).resetSelectedPages();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disappearWhenScrolled == true) {
      return CustomScrollView(
        controller: widget.scrollController,
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () => onBackButtonPressed(),
            ),
            iconTheme: widget.iconTheme,
            floating: true,
            backgroundColor: widget.isUsingDefaultColorTheme == true
                ? primaryColor
                : Colors.transparent,
            centerTitle: widget.centerTitle,
            title: widget.titleWidget ??
                Text(
                  widget.title ?? '',
                  style: TextStyle(
                    fontSize: widget.fontSize,
                  ),
                ),
            stretch: true,
            elevation: 0,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: widget.imageTitle,
              background: widget.image,
            ),
          ),
          ...widget.slivers ?? [],
        ],
      );
    }
    return AppBar(
      backgroundColor: widget.isUsingDefaultColorTheme == true
          ? primaryColor
          : Colors.transparent,
      centerTitle: widget.centerTitle,
      title: widget.titleWidget ??
          Text(
            widget.title!,
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
          ),
      actions: widget.actionList,
    );
  }
}
