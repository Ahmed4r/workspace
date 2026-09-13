import 'package:flutter/material.dart';
import 'package:workspace/core/app_breakpoints.dart';
import 'package:workspace/core/app_colors.dart';
import 'package:workspace/core/side_bar.dart';
import 'package:workspace/features/githubrepos/github_repos.dart';
import 'package:workspace/features/overview/over_view_page.dart';

void main() => runApp(const DeployMateApp());

/// ---------------------------------------------------------------------------
/// App
/// ---------------------------------------------------------------------------
class DeployMateApp extends StatelessWidget {
  const DeployMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(fontFamily: 'Arial', useMaterial3: true),
      home: const DashboardPage(),
    );
  }
}



/// ---------------------------------------------------------------------------
/// Nav model
/// ---------------------------------------------------------------------------
enum NavSection {
  overview(Icons.dashboard_outlined, 'Overview'),
  projects(Icons.hub_outlined, 'Projects'),
  deployments(Icons.rocket_launch_outlined, 'Deployments'),
  servers(Icons.dns_outlined, 'Servers'),
  activity(Icons.show_chart_outlined, 'Activity'),
  repos(Icons.folder, 'Repositories'),
  settings(Icons.settings_outlined, 'Settings');

  const NavSection(this.icon, this.label);
  final IconData icon;
  final String label;
}

/// ---------------------------------------------------------------------------
/// Dashboard scaffold
/// ---------------------------------------------------------------------------
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  NavSection _section = NavSection.overview;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSelect(NavSection section) {
    setState(() => _section = section);
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context); // Safe drawer closure on mobile
    }
  }

  /// Map each NavSection enum directly to its designated Page view
  Widget _getPageForSection(NavSection section) {
    switch (section) {
      case NavSection.overview:
        return const OverViewPage();
      case NavSection.projects:
        return const _SectionPage(section: NavSection.projects);
      case NavSection.deployments:
        return const _SectionPage(section: NavSection.deployments);
      case NavSection.servers:
        return const _SectionPage(section: NavSection.servers);
      case NavSection.activity:
        return const _SectionPage(section: NavSection.activity);
      case NavSection.repos:
        return const GitHubRepoList(
          username: 'Ahmed4r',
        ); // Updated to render GitHubRepoList
      case NavSection.settings:
        return const _SectionPage(section: NavSection.settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < AppBreakpoints.desktop;

    return Scaffold(
      key: _scaffoldKey,
      appBar: compact
          ? AppBar(
              backgroundColor: AppColors.scaffold,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              title: const Brand(),
              centerTitle: false,
            )
          : null,
      drawer: compact
          ? Drawer(
              child: SafeArea(
                child: Sidebar(selected: _section, onSelected: _onSelect),
              ),
            )
          : null,
      body: SafeArea(
        top: !compact,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!compact) Sidebar(selected: _section, onSelected: _onSelect),
            Expanded(
              child: IndexedStack(
                index: _section.index,
                children: NavSection.values
                    .map((section) => _getPageForSection(section))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionPage extends StatelessWidget {
  const _SectionPage({required this.section});
  final NavSection section;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < AppBreakpoints.desktop;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        compact ? 20 : 64,
        36,
        compact ? 20 : 48,
        44,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.label,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Text(
            'Manage your ${section.label.toLowerCase()} here.',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
