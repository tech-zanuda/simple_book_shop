import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AppBarProfileIcon extends StatelessWidget {
  const AppBarProfileIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<ProfileScreen>(
            builder: (context) => ProfileScreen(
              appBar: AppBar(
                title: const Text('Личный кабинет'),
              ),
              actions: [
                SignedOutAction((context) {
                  Navigator.of(context).pop();
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
