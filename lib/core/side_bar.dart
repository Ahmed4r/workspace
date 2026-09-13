import 'package:flutter/material.dart';
import 'package:workspace/core/app_colors.dart';
import 'package:workspace/main.dart';

/// ---------------------------------------------------------------------------
/// Sidebar (desktop rail / mobile drawer content)
/// ---------------------------------------------------------------------------
class Sidebar extends StatelessWidget {
  const Sidebar({required this.selected, required this.onSelected});
  final NavSection selected;
  final ValueChanged<NavSection> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 16),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(left: 4), child: Brand()),
          const SizedBox(height: 31),
          for (final section in NavSection.values)
            NavItem(
              section: section,
              selected: section == selected,
              onTap: () => onSelected(section),
            ),
          const Spacer(),
          const _WorkspaceCard(),
          const SizedBox(height: 28),
          const _AccountTile(),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    required this.section,
    required this.selected,
    required this.onTap,
  });

  final NavSection section;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.navSelected : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Icon(
              section.icon,
              size: 16,
              color: selected ? Colors.white : AppColors.muted,
            ),
            const SizedBox(width: 9),
            Text(
              section.label,
              style: TextStyle(
                fontSize: 14,
                color: selected ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkspaceCard extends StatelessWidget {
  const _WorkspaceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Workspace', style: TextStyle(fontSize: 10)),
                Text(
                  "Ahmed's workspace",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: AppColors.muted, size: 16),
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.avatarBg,
            child: const Text(
              'A',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ahmed Rady',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text('prod · admin', style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Brand
/// ---------------------------------------------------------------------------
class Brand extends StatelessWidget {
  const Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.brand,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text('D', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
        const SizedBox(width: 8),
        const Text(
          'DeployMate',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
