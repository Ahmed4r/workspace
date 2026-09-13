import 'package:flutter/material.dart';
import 'package:workspace/core/app_breakpoints.dart';
import 'package:workspace/core/app_colors.dart';
import 'package:workspace/core/app_text_style.dart';
import 'package:workspace/features/overview/model/project_data.dart';
import 'package:workspace/features/overview/project_details_page.dart';
import 'package:workspace/features/overview/view_all_projects.dart';


class RecentProjects extends StatelessWidget {
  const RecentProjects({super.key});

  static const _projects = [
    ProjectData(
      'Book Library API',
      'Running',
      '2 minutes ago',
      'api.booklibrary.dev',
    ),
    ProjectData('Todo API', 'Running', '1 hour ago', 'todo.deploymate.app'),
    ProjectData(
      'Payment Service',
      'Failed',
      '3 hours ago',
      'payments.deploymate.app',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Recent projects', style: AppTextStyles.sectionTitle),
            const Spacer(),
            TextButton(
              style: ButtonStyle(
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewAllProjectsPage(),
                  ),
                );
              },
              child: const Text(
                'View all',
                style: TextStyle(fontSize: 12, color: Colors.indigoAccent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final narrow = constraints.maxWidth < AppBreakpoints.mobile;
              return Column(
                children: [
                  if (!narrow) const _ProjectRowHeader(),
                  for (final project in _projects)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProjectDetailsPage(projectName: project.name),
                          ),
                        );
                      },
                      child: narrow
                          ? _ProjectCard(project: project)
                          : _ProjectRow(project: project),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

///-------------------------------------------------------------------
/// Recent projects
/// ---------------------------------------------------------------------------

class _ProjectRowHeader extends StatelessWidget {
  const _ProjectRowHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 19),
      color: AppColors.headerBg,
      child: Row(
        children: [
          Expanded(flex: 4, child: Text('PROJECT', style: AppTextStyles.label)),
          Expanded(flex: 2, child: Text('STATUS', style: AppTextStyles.label)),
           Expanded(
            flex: 3,
            child: Text('LAST DEPLOYMENT', style: AppTextStyles.label),
          ),
           Expanded(flex: 3, child: Text('URL', style: AppTextStyles.label)),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.status});
  final String status;

  Color get _color => status == 'Failed' ? AppColors.danger : AppColors.success;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(status, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

/// Desktop / tablet table row.
class _ProjectRow extends StatelessWidget {
  const _ProjectRow({required this.project});
  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(project.name, style: AppTextStyles.cellPrimary),
          ),
          Expanded(flex: 2, child: _StatusDot(status: project.status)),
          Expanded(
            flex: 3,
            child: Text(project.deployment, style: AppTextStyles.cellSecondary),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    project.url,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.cellSecondary,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.open_in_new,
                    size: 12,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Mobile stacked card, used instead of a squeezed table row.
class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});
  final ProjectData project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(project.name, style: AppTextStyles.cellPrimary),
              ),
              _StatusDot(status: project.status),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Deployed ${project.deployment}',
            style: AppTextStyles.cellSecondary,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Flexible(
                child: Text(
                  project.url,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.cellSecondary,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  Icons.open_in_new,
                  size: 12,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
