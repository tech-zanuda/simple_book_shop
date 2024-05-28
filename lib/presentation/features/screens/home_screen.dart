import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_shop/presentation/features/bloc/catalog/catalog_bloc.dart';
import 'package:simple_book_shop/presentation/features/widgets/appbar_profile_icon.dart';
import 'package:simple_book_shop/presentation/features/widgets/books_catalog.dart';

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
    return Scaffold(
      appBar: AppBar(
        actions: const [AppBarProfileIcon()],
        automaticallyImplyLeading: false,
        title: Text(
          'Каталог',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          if (state is CatalogLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CatalogLoaded) {
            final books = state.books;
            return BooksCatalog(books: books);
          } else if (state is CatalogError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
