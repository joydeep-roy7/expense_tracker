import 'package:animated_notch_bottom_bar/src/notch_bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import '../../utils/app_constants.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required NotchBottomBarController controller,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final Color primaryGreen = const Color(0xff0B5D46);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        drawer: appDrawer(),
        appBar: AppBar(
          backgroundColor: Color(0xFF6C63FF),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Text(
            AppConstants.page2,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Symbols.app_badging, color: Colors.white, size: 30.0),
            ),
            SizedBox(width: 10.0),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF6C63FF),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "👋 Welcome back,",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Expense Tracker",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.account_balance_wallet),
                                SizedBox(width: 8),
                                Text(
                                  "Total Balance",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          const Text(
                            "৳ 74000.00",
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 30),

                          const Divider(),

                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _incomeExpense(
                                Icons.arrow_downward,
                                Colors.green,
                                "Income",
                                "৳ 105000",
                              ),
                              _incomeExpense(
                                Icons.arrow_upward,
                                Colors.red,
                                "Expenses",
                                "৳ 31000",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        color: const Color(0xFF6C63FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///----------------- Custom App Drawer -------------------------------
  Widget appDrawer() {
    return Drawer(
      backgroundColor: Color(0XFFFFFFFF),
      child: Column(
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF6C63FF),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100.0),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 30.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 12.0,
                              ),
                            ),

                            SizedBox(width: 5.0),

                            Icon(Symbols.edit, color: Colors.green, size: 18.0),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20.0),

                    Row(
                      children: [
                        CircleAvatar(radius: 40, backgroundColor: Colors.white),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Joysurjyo Roy",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                "Joysurjyodev@gmail.com",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20.0),

          ListTile(
            leading: Icon(
              Symbols.home_app_logo,
              color: Colors.blueGrey,
              size: 30.0,
            ),
            title: Text(
              AppConstants.page2,
              style: TextStyle(
                color: Color(0xFF6C63FF),
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(
              Symbols.history_edu,
              color: Colors.blueGrey,
              size: 30.0,
            ),
            title: Text(
              AppConstants.page1,
              style: TextStyle(
                color: Color(0xFF6C63FF),
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(
              Symbols.finance_mode,
              color: Colors.blueGrey,
              size: 30.0,
            ),
            title: Text(
              AppConstants.page3,
              style: TextStyle(
                color: Color(0xFF6C63FF),
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(
              Symbols.data_loss_prevention,
              color: Colors.blueGrey,
              size: 30.0,
            ),
            title: Text(
              "About Us",
              style: TextStyle(
                color: Color(0xFF6C63FF),
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            onTap: () {},
          ),

          Spacer(),

          Center(
            child: Text(
              AppConstants.copyrights,
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),

          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  ///----------------- Top Header - Income,Expense -----------------------
  static Widget _incomeExpense(
    IconData icon,
    Color color,
    String title,
    String amount,
  ) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(
              amount,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ],
    );

  }
}
