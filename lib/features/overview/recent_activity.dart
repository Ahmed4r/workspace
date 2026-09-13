
import 'package:flutter/material.dart';
import 'package:workspace/core/app_colors.dart';
import 'package:workspace/core/app_text_style.dart';
import 'package:workspace/main.dart';

/// ---------------------------------------------------------------------------
/// Lower panels
/// ---------------------------------------------------------------------------
class LowerPanels extends StatelessWidget {
  const LowerPanels();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_Activity(), SizedBox(height: 38), _Infrastructure()],
          );
        }
        return const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _Activity()),
            SizedBox(width: 60),
            Expanded(flex: 2, child: _Infrastructure()),
          ],
        );
      },
    );
  }
}

class _ActivityData {
  const _ActivityData(this.title, this.detail, this.color);
  final String title;
  final String detail;
  final Color color;
}

class _Activity extends StatelessWidget {
  const _Activity();

  static const _items = [
    _ActivityData(
      'Book Library deployed successfully',
      'production · v24 · 2 minutes ago',
      AppColors.success,
    ),
    _ActivityData(
      'Payment Service deployment failed',
      'production · v18 · 3 hours ago',
      AppColors.dangerDark,
    ),
    _ActivityData(
      'Redis service restarted',
      'services · 5 hours ago',
      AppColors.neutralDot,
    ),
    _ActivityData(
      'New GitHub repository connected',
      'todo-api · yesterday',
      AppColors.neutralDot,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent activity', style: AppTextStyles.sectionTitle),
        const SizedBox(height: 24),
        for (final item in _items) _ActivityItem(item: item),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({required this.item});
  final _ActivityData item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: item.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  item.detail,
                  style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Infrastructure extends StatelessWidget {
  const _Infrastructure();

  static const _rows = [
    ('Primary region', 'eu-west-1'),
    ('Healthy servers', '4 / 4'),
    ('Active containers', '12'),
    ('Last checked', 'just now'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text('Infrastructure', style: AppTextStyles.sectionTitle),
        const SizedBox(height: 18),
        for (final (label, value) in _rows)
          _InfoRow(label: label, value: value),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }
}
