import 'package:flutter/material.dart';
import 'package:redscope_assignment/screens/Gallery_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<String> _bookmarkedImages = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarkedImages = prefs.getStringList('bookmarks') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Images'),
      ),
      body: _bookmarkedImages.isEmpty
          ? Center(child: Text("No bookmarks yet."))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: _bookmarkedImages.length,
              itemBuilder: (context, index) {
                final imageUrl = _bookmarkedImages[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(imageUrl: imageUrl),
                      ),
                    );
                  },
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                );
              },
            ),
    );
  }
}
