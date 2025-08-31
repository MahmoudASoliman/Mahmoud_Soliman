import 'package:flutter/material.dart';

class SideNavDrawer extends StatelessWidget {
  const SideNavDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final items = const ['Home', 'Skills', 'Projects', 'About', 'Contact'];

    return Drawer(
      child: SafeArea(
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            return ListTile(
              selected: selectedIndex == i,
              title: Text(items[i]),
              onTap: () => onSelect(i), // نبعت الاندكس مباشرة
            );
          },
        ),
      ),
    );
  }
}
