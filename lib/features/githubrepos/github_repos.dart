import 'package:flutter/material.dart';
import 'package:workspace/services/github_service.dart';

class GitHubRepoList extends StatefulWidget {
  final String username;

  const GitHubRepoList({super.key, required this.username});

  @override
  State<GitHubRepoList> createState() => _GitHubRepoListState();
}

class _GitHubRepoListState extends State<GitHubRepoList> {
  late final Future<List<dynamic>> _reposFuture;

  @override
  void initState() {
    super.initState();
    // Cache the future so it doesn't refetch on rebuilds
    _reposFuture = GitHubRepoService(username: widget.username)
        .fetchPublicRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _reposFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No repositories found'));
        }

        final repos = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: repos.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final repo = repos[index];
            return ListTile(
              leading: const Icon(Icons.folder_outlined),
              title: Text(
                repo['name'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(repo['description'] ?? 'No description provided'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text('${repo['stargazers_count'] ?? 0}'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
