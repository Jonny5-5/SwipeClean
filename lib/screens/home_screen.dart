import 'package:flutter/material.dart';
import 'package:swipe_clean/screens/widgets/swipe_app_bar.dart';
import 'package:swipe_clean/screens/widgets/swipe_area.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SwipeAppBar(
        title: "Home",
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              // TODO
            },
          )
        ],
      ),
      body: Column(
        children: [
          Center(child: SizedBox()),
          Center(
            child: Text("Hello World"),
          ),
          Expanded(child: SwipeArea()),
        ],
      ),
    );
  }
}
