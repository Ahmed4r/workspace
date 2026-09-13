import 'package:flutter/material.dart';
import 'package:workspace/core/app_breakpoints.dart';
import 'package:workspace/core/app_colors.dart';

class Metrics extends StatelessWidget {
  const Metrics({super.key, 
    this.projectNumbers = 0,
    this.runningNumbers = 0,
    this.failedNumbers = 0,
    this.deploymentNumbers = 0,
  });

  final int projectNumbers;
  final int runningNumbers;
  final int failedNumbers;
  final int deploymentNumbers;

  @override
  Widget build(BuildContext context) {
    final metrics = [
      _Metric(projectNumbers.toString(), 'Projects'),
      _Metric(runningNumbers.toString(), 'Running'),
      _Metric(failedNumbers.toString(), 'Failed', failed: true),
      _Metric(deploymentNumbers.toString(), 'Deployments this week'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < AppBreakpoints.mobile;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: metrics.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: compact ? 2 : 4,
            mainAxisExtent: 76,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
          ),
          itemBuilder: (context, index) => metrics[index],
        );
      },
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.value, this.label, {this.failed = false});
  final String value;
  final String label;
  final bool failed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: failed ? AppColors.danger : null,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}