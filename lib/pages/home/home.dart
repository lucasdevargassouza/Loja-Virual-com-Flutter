import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/home/tabs/home_tab.dart';
import 'package:loja_virtual/share/widgets/custom_drawer.dart';

class Home extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          endDrawer: CustomDrawer(_pageController),
          drawer: CustomDrawer(_pageController),
          body: HomeTab(),
        ),
        Scaffold(
          endDrawer: CustomDrawer(_pageController),
          drawer: CustomDrawer(_pageController),
          body: Container(color: Colors.red),
        ),
        Scaffold(
          endDrawer: CustomDrawer(_pageController),
          drawer: CustomDrawer(_pageController),
          body: Container(color: Colors.blue),
        ),
        Scaffold(
          endDrawer: CustomDrawer(_pageController),
          drawer: CustomDrawer(_pageController),
          body: Container(color: Colors.orangeAccent),
        ),
      ],
    );
  }
}
