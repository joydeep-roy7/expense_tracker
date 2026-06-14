import 'dart:math';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:expense_tracker/screen_views/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/screen_views/statistics/statistics_screen.dart';
import 'package:expense_tracker/screen_views/transaction/transaction_list_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarState extends StatefulWidget {
  const BottomNavigationBarState({super.key});

  @override
  State<BottomNavigationBarState> createState() => _BottomNavigationBarStateState();
}

class _BottomNavigationBarStateState extends State<BottomNavigationBarState> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );
  int maxCount = 3;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DashboardScreen(controller: (_controller)),
      const StatisticsScreen(),
      const TransactionListScreen(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(pages.length, (index) => pages[index]),
      ),

      extendBody: true,

      bottomNavigationBar: (pages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: Colors.black87,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,

              itemLabelStyle: const TextStyle(fontSize: 10),

              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(Icons.home_filled, color: Colors.blueGrey),

                  activeItem: Icon(Icons.home_filled, color: Colors.blueAccent),
                  itemLabel: 'Page 1',
                ),

                BottomBarItem(
                  inActiveItem: Icon(Icons.star, color: Colors.blueGrey),
                  activeItem: Icon(Icons.star, color: Colors.blueAccent),
                  itemLabel: 'Page 2',
                ),

                BottomBarItem(
                  inActiveItem: Icon(Icons.settings, color: Colors.blueGrey),
                  activeItem: Icon(Icons.settings, color: Colors.pink),
                  itemLabel: 'Page 3',
                ),
              ],

              onTap: (index) {
                log("current selected index $index" as num);
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
