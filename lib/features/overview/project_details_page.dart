import 'package:flutter/material.dart';
import 'package:workspace/core/app_breakpoints.dart';
import 'package:workspace/core/app_colors.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({super.key, required this.projectName});

  final String projectName;

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage>
    with SingleTickerProviderStateMixin {
  static const _tabs = [
    'Overview',
    'Deployments',
    'Logs',
    'Environment',
    'Settings',
  ];

  late final _tabController = TabController(length: _tabs.length, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.projectName,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: AppColors.muted,
          indicatorColor: AppColors.accent,
          tabs: [for (final t in _tabs) Tab(text: t)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ProjectOverviewTab(projectName: widget.projectName),
          const _PlaceholderTab(label: 'Deployments list'),
          const _BuildLogsTab(),
          const _PlaceholderTab(label: 'Environment variables editor'),
          const _PlaceholderTab(label: 'Project settings'),
        ],
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label, style: const TextStyle(color: AppColors.muted)),
    );
  }
}

class _ProjectOverviewTab extends StatelessWidget {
  const _ProjectOverviewTab({required this.projectName});
  final String projectName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < AppBreakpoints.mobile;
        return SingleChildScrollView(
          padding: EdgeInsets.all(compact ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Production deployment',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: compact
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _DeploymentInfo(projectName: projectName),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: _RedeployButton(),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _DeploymentInfo(projectName: projectName),
                            ),
                            const SizedBox(width: 16),
                            _RedeployButton(),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DeploymentInfo extends StatelessWidget {
  const _DeploymentInfo({required this.projectName});
  final String projectName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          projectName,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          'Deployed 2 minutes ago via GitHub push',
          style: TextStyle(fontSize: 12, color: AppColors.muted),
        ),
      ],
    );
  }
}

class _RedeployButton extends StatelessWidget {
  const _RedeployButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.refresh, size: 16),
      label: const Text('Redeploy', style: TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}

class _BuildLogsTab extends StatelessWidget {
  const _BuildLogsTab();

  static const _log =
      '[INFO] Starting build process...\n'
      '[INFO] Running: docker build -t deploymate/book-api:latest .\n'
      '[INFO] Step 1/8 : FROM openjdk:17-jdk-slim\n'
      '[INFO] Step 2/8 : WORKDIR /app\n'
      '[SUCCESS] Container deployed successfully at port 8080.';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const SingleChildScrollView(
          child: SelectableText(
            _log,
            style: TextStyle(
              color: Colors.greenAccent,
              fontFamily: 'monospace',
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
