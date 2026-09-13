import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class GitHubRepoService {
  final String username;
  final String?
  personalAccessToken; // Required for private repos or higher rate limits
  static const String clientId = 'YOUR_GITHUB_CLIENT_ID';
  GitHubRepoService({required this.username, this.personalAccessToken});

  Future<List<dynamic>> fetchPublicRepositories() async {
    final url = Uri.parse('https://api.github.com/users/$username/repos');
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          if (personalAccessToken != null)
            'Authorization': 'Bearer $personalAccessToken',
        },
      );

      if (response.statusCode == 200) {
        log(response.body);
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to load repositories: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      return [e.toString()];
    }
  }

  Future<void> signInWithGitHub() async {
    final Uri authUri = Uri.https('github.com', '/login/oauth/authorize', {
      'client_id': clientId,
      'scope': 'repo read:user',
    });

    if (await canLaunchUrl(authUri)) {
      await launchUrl(authUri, webOnlyWindowName: '_self');
    } else {
      throw Exception('Could not launch GitHub authentication URL.');
    }
  }
}
