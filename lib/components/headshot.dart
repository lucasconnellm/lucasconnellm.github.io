import 'package:flutter/material.dart';

class UserHeadshot extends StatelessWidget {
  const UserHeadshot({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 80,
      backgroundImage: AssetImage('assets/images/headshot.jpeg'),
    );
  }
}
