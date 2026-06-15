import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:expense_tracker/screen_views/dashboard/dashboard_screen.dart';
import 'package:expense_tracker/screen_views/statistics/statistics_screen.dart';
import 'package:expense_tracker/screen_views/transaction/transaction_list_screen.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarState extends StatefulWidget {
  const BottomNavigationBarState({super.key});

  @override
  State<BottomNavigationBarState> createState() => _BottomNavigationBarStateState();
}

class _BottomNavigationBarStateState extends State<BottomNavigationBarState> {
  final _pageController = PageController(initialPage: 1);
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 1,
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
      const TransactionListScreen(),
      DashboardScreen(controller: (_controller)),
      const StatisticsScreen(),
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
              notchColor: Colors.white,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,

              itemLabelStyle: const TextStyle(fontSize: 10),

              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(Symbols.history_edu, color: Colors.blueGrey, size: 30.0),

                  activeItem: Icon(Symbols.history_edu, color: Colors.green,),
                  itemLabel: 'Transaction',
                ),

                BottomBarItem(
                  inActiveItem: Icon(Symbols.home_app_logo, color: Colors.blueGrey, size: 30.0),
                  activeItem: Icon(Symbols.home_app_logo, color: Colors.green,),
                  itemLabel: 'Home',
                ),

                BottomBarItem(
                  inActiveItem: Icon(Symbols.finance_mode, color: Colors.blueGrey, size: 30.0),
                  activeItem: Icon(Symbols.finance_mode, color: Colors.green,),
                  itemLabel: 'Statistics',
                ),
              ],

              onTap: (index) {
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
