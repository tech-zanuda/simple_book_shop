import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_shop/presentation/features/bloc/catalog/catalog_bloc.dart';
import 'package:simple_book_shop/presentation/features/widgets/appbar_profile_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<CatalogBloc>(context).add(LoadCatalog());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CatalogBloc _catalogBloc = BlocProvider.of<CatalogBloc>(context);
    return Scaffold(
      appBar: AppBar(
        actions: const [AppBarProfileIcon()],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Каталог',
              style: TextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
