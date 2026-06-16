import 'package:expense_tracker/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_constants.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        // body: ,
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
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          // backgroundImage: NetworkImage(
                          //   ///
                          // ),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            Text(
                              "Joysurjyo Roy",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Joysurjyodev@gmail.com",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
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


}
