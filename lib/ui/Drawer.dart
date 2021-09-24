import 'package:alumniapp/Service/CutomUser.dart';
import 'package:alumniapp/Service/LocalDatabase.dart';
import 'package:alumniapp/Service/Server.dart';
import 'package:alumniapp/screens/Events.dart';
import 'package:alumniapp/screens/InternationalStudents.dart';
import 'package:alumniapp/screens/Jobs.dart';
import 'package:alumniapp/screens/ProfilePage.dart';
import 'package:alumniapp/screens/dipsitegroup.dart';
import 'package:alumniapp/screens/discussions.dart';
import 'package:alumniapp/screens/searchPeople.dart';
import 'package:alumniapp/ui/CustomAvatar.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final CustomUser? user;
  final Server server;
  MyDrawer({required this.user, required this.server});
  discussions(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          DiscussionsPage(user: user, server: server),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              animation.drive(Tween(begin: Offset(-1, 0), end: Offset.zero)),
          child: child,
        );
      },
    ));
  }

  jobs(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          JobScreen(user: user, server: server),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              animation.drive(Tween(begin: Offset(1, 0), end: Offset.zero)),
          child: child,
        );
      },
    ));
  }

  events(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          EventScreen(user: user, server: server),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              animation.drive(Tween(begin: Offset(1, 0), end: Offset.zero)),
          child: child,
        );
      },
    ));
  }

  searchPeople(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          SearchPeople(user: user, server: server),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              animation.drive(Tween(begin: Offset(1, 0), end: Offset.zero)),
          child: child,
        );
      },
    ));
  }

  logout(context) async {
    await UserDatabase.clear();
    await server.destroyNotificationChannel();
    final nav = Navigator.of(context);
    while (nav.canPop()) {
      nav.pop();
    }
    nav.pushNamed("/login");
  }

  toprofile(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfilePage(user: user, server: server)));
  }

  dipsite(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DipsiteGroup(user: user!, server: server)));
  }

  ints(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            InternationalStudents(user: user!, server: server)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: BoxDecoration(
        //     borderRadius:
        //         BorderRadius.only(bottomRight: Radius.circular(60.0))),
        child: Column(
      children: [
        GestureDetector(
          onTap: () => toprofile(context),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
            // color:Color(0xff9038FF),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                border: Border.all(color: Colors.white)),
                            child: CustomAvatar(
                                user: user!, server: server, radius: 25))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                                user!.firstName.toString() +
                                    " " +
                                    user!.lastName.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                                overflow: TextOverflow.ellipsis),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                  "Dipsite " + user!.passOutYear.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white))),
                          if (user!.jobProfile != null &&
                              user!.jobProfile != "")
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(user!.jobProfile.toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            margin: EdgeInsets.zero,
                            width: 155,
                            height: 70,
                            child: Text(user!.collegeName.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white)),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
        SizedBox(height: 10),
        DrawerMenuOption(
            title: "Search People",
            onTap: () => searchPeople(context),
            icon: Icon(Icons.search_rounded, color: Color(0xff6A6A6A))),
        DrawerMenuOption(
            title: "Discussions",
            onTap: () => discussions(context),
            icon: Icon(Icons.forum_rounded, color: Color(0xff6A6A6A))),
        DrawerMenuOption(
            title: "Jobs/Internships",
            onTap: () => jobs(context),
            icon: Icon(Icons.work_rounded, color: Color(0xff6A6A6A))),
        DrawerMenuOption(
            title: "DPS Events",
            onTap: () => events(context),
            icon: Icon(Icons.apps_outlined, color: Color(0xff6A6A6A))),
        DrawerMenuOption(
            title: "Dipsite " + user!.passOutYear.toString(),
            onTap: () => dipsite(context),
            icon: Icon(Icons.group_rounded, color: Color(0xff6A6A6A))),
        DrawerMenuOption(
            title: "International Connect",
            onTap: () => ints(context),
            icon: Icon(Icons.language_rounded, color: Color(0xff6A6A6A))),
        DrawerMenuOption(
            title: "Log Out",
            onTap: () => logout(context),
            icon: Icon(Icons.exit_to_app_rounded, color: Color(0xff6A6A6A))),
        Expanded(child: Container()),
        Container(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 50),
                  Container(
                      width: 40, child: Image.asset("assets/alumni-logo.png")),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      Text("DPS RKP Alumni App",
                          style: TextStyle(
                              color: Color(0xff04009A),
                              fontWeight: FontWeight.w500)),
                      Text("v 1.0.0", style: TextStyle(color: Colors.black45))
                    ],
                  )
                ],
              )),
        )
      ],
    ));
  }
}

class DrawerMenuOption extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Icon icon;
  DrawerMenuOption(
      {required this.title, required this.onTap, required this.icon});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              child: icon),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 18), child: Text(title)),
        ],
      ),
    );
  }
}
