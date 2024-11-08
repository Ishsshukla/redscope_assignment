import 'package:flutter/material.dart';
import 'package:redscope_assignment/screens/Gallery_Screen.dart';
import 'package:redscope_assignment/screens/Repo_List_Screen.dart';

import 'bookmark_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    RepoListScreen(),
    FullScreenImage(imageUrl: '',),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterApp Assignment"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarkScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: "Repos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: "Gallery",
          ),
        ],
      ),
    );
  }
}
