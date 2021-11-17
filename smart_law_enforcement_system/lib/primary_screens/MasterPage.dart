import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_law_enforcement_system/primary_screens/AboutUs.dart';
import 'package:smart_law_enforcement_system/primary_screens/ContactUs.dart';

import 'package:smart_law_enforcement_system/primary_screens/HomePage.dart';
import 'package:smart_law_enforcement_system/primary_screens/Reports.dart';
import 'UserProfile.dart';

class MasterPage extends StatefulWidget {
  @override
  _MasterPageState createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {

  String UserMobileNo="";
  int NavigationBarIndex=2;


  @override
  Widget build(BuildContext context) {

    //Navigation Drawer Menu Items

    // final drawerHeader = UserAccountsDrawerHeader(
    //   accountName: Text(
    //     "Yash Kataria"
    //   ),
    //   accountEmail: Text(
    //     "katariayash007@gmail.com"
    //   ),
    //   currentAccountPicture: const CircleAvatar(
    //     child: FlutterLogo(size: 42.0),
    //   ),
    // );
    // final drawerItems = ListView(
    //   children: [
    //     drawerHeader,
    //     ListTile(
    //       title: Text(
    //         "Menu Item 1"
    //       ),
    //       leading: const Icon(Icons.favorite),
    //       onTap: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //     ListTile(
    //       title: Text(
    //           "Menu Item 2"
    //       ),
    //       leading: const Icon(Icons.comment),
    //       onTap: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //   ],
    // );

    UserMobileNo=ModalRoute.of(context)!.settings.arguments as String;

    final BottomNavigationBaritems = <Widget>
    [
      Icon(FontAwesomeIcons.infoCircle,size:22,color: Color.fromRGBO(248,248,247,1),),
      Icon(FontAwesomeIcons.headset,size:22,color: Color.fromRGBO(248,248,247,1)),
      Icon(FontAwesomeIcons.home,size:22,color: Color.fromRGBO(248,248,247,1)),
      Icon(FontAwesomeIcons.chartBar,size:22,color: Color.fromRGBO(248,248,247,1)),
      Icon(FontAwesomeIcons.user,size:22,color: Color.fromRGBO(248,248,247,1)),
    ];

    final Screens = [
      AboutUs(),
      ContactUs(),
      HomePage(),
      Reports(),
      UserProfile(UserMobileNo: UserMobileNo,),
    ];

    return Scaffold(
      appBar: buildAppBar(),
      // backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      backgroundColor: Colors.white,
      body: Screens[NavigationBarIndex],
      // drawer: Drawer(
      //   child: drawerItems,
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        items:BottomNavigationBaritems,
        height:50,
        backgroundColor: Colors.transparent,
        color: Color.fromRGBO(91, 90, 98, 1),
        index: NavigationBarIndex,
        buttonBackgroundColor: Color.fromRGBO(91, 90, 98, 1),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index)
        {
          setState(() {
            this.NavigationBarIndex = index;
            });
          },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromRGBO(91, 90, 98, 1),
      // leading: IconButton(
      //   tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //   icon: const Icon(Icons.menu),
      //   onPressed: () {},
      // ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Center(
        child: Text(
          "SLES",
          textAlign: TextAlign.center,
          style: TextStyle( fontSize: 25,letterSpacing: 5.0,fontWeight: FontWeight.w700,),
        ),
      ),
      // actions: [
      //   PopupMenuButton<Text>(
      //     itemBuilder: (context) {
      //       return [
      //         PopupMenuItem(
      //           child: Row(
      //             children: <Widget>[
      //               Icon(FeatherIcons.checkCircle,
      //                 color: Color.fromRGBO(91, 90, 98, 1)),
      //               SizedBox(width: 15),
      //               Text('About Us'),
      //             ],
      //           ),
      //         ),
      //         PopupMenuItem(
      //           child: Row(
      //             children: <Widget>[
      //               Icon(FeatherIcons.phoneCall,
      //                   color: Color.fromRGBO(91, 90, 98, 1)),
      //               SizedBox(width: 15),
      //               Text('Contact Us'),
      //             ],
      //           ),
      //         ),
      //         PopupMenuItem(
      //           child: Row(
      //             children: <Widget>[
      //               Icon(FeatherIcons.logOut,
      //                   color: Color.fromRGBO(91, 90, 98, 1)),
      //               SizedBox(width: 15),
      //               Text('Logout'),
      //             ],
      //           ),
      //         ),
      //       ];
      //     },
      //   )
      // ],
    );
  }
}




