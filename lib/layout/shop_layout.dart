import 'package:flutter/material.dart';
import 'package:shope_app/components/components.dart';
import 'package:shope_app/modules/login/login_screen.dart';

import '../network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salla'),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData(key: "token").then((value) {
            if (value) {
              navigateAndFinish(
                context,
                LoginScreen(),
              );
            }
          });
        },
        child: const Text(
          "SIGN OUT",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
