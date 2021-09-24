import 'dart:convert';

import 'package:alumniapp/Service/CutomUser.dart';
import 'package:alumniapp/Service/Server.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatefulWidget {
  final Server server;
  final CustomUser user;
  final double? radius;
  CustomAvatar({required this.user, required this.server, this.radius});
  @override
  _CustomAvatarState createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: widget.server.streamUser(widget.user.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!["profileImage"] != null) {
            return CircleAvatar(
              radius: widget.radius ?? 15,
              backgroundImage:
                  MemoryImage(base64Decode(snapshot.data!["profileImage"])),
            );
          }
        }
        return CircleAvatar(
            backgroundColor: Color(0xff04009A),
            radius: widget.radius ?? 15,
            child: Center(
                child: Text(
              widget.user.firstName![0] + widget.user.lastName![0],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            )));
      },
    );
  }
}
