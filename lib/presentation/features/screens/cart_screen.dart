import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 800,
              width: 250,
              color: Colors.black87,
            ),
            Container(
              height: 800,
              width: 250,
              color: Colors.black54,
            ),
            Container(
              height: 800,
              width: 250,
              color: Colors.black45,
            ),
            Container(
              height: 800,
              width: 250,
              color: Colors.black38,
            ),
          ],
        ),
      ),
    );
  }
}
