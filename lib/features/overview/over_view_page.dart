import 'package:flutter/material.dart';
import 'package:workspace/core/app_breakpoints.dart';
import 'package:workspace/core/app_colors.dart';
import 'package:workspace/features/overview/metrics.dart';
import 'package:workspace/features/overview/recent_activity.dart';
import 'package:workspace/features/overview/recent_projects.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),

      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1084),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Hero(),
            SizedBox(height: 40),
            Metrics(
              projectNumbers: 1,
              runningNumbers: 1,
              deploymentNumbers: 1,
              failedNumbers: 2,
            ),
            SizedBox(height: 48),
            RecentProjects(),
            SizedBox(height: 40),
            LowerPanels(),
          ],
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < AppBreakpoints.mobile;
        final title = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'WORKSPACE  /  PRODUCTION',
              style: TextStyle(fontSize: 10, letterSpacing: 1),
            ),
            const SizedBox(height: 9),
            Text(
              'Good evening, Ahmed',
              style: TextStyle(
                fontSize: compact ? 28 : 38,
                height: .95,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Everything is running smoothly.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        );

        final newProjectButton = OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 16),
          label: const Text('New Project', style: TextStyle(fontSize: 12)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );

        final connectRepoButton = OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.account_tree_outlined, size: 16),
          label: const Text(
            'Connect repository',
            style: TextStyle(fontSize: 12),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              const SizedBox(height: 20),
              Align(alignment: Alignment.centerLeft, child: newProjectButton),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: title),
            newProjectButton,
            const SizedBox(width: 12),
            connectRepoButton,
          ],
        );
      },
    );
  }
}
