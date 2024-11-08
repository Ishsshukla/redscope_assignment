import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepoListScreen extends StatefulWidget {
  @override
  _RepoListScreenState createState() => _RepoListScreenState();
}

class _RepoListScreenState extends State<RepoListScreen> {
  List<dynamic> _gists = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGists();
  }

  Future<void> _fetchGists() async {
    final url = Uri.parse('https://api.github.com/gists/public');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _gists = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load gists');
      }
    } catch (error) {
      print('Error fetching gists: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _gists.length,
              itemBuilder: (context, index) {
                final gist = _gists[index];
                return ListTile(
                  title: Text(gist['description'] ?? 'No description'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Comments: ${gist['comments']}"),
                      Text("Created: ${gist['created_at']}"),
                      Text("Updated: ${gist['updated_at']}"),
                    ],
                  ),
                  onTap: () {
                    // Navigate to file listing page (to be implemented)
                  },
                  onLongPress: () {
                    // Show owner information popup (to be implemented)
                  },
                );
              },
            ),
    );
  }
}
