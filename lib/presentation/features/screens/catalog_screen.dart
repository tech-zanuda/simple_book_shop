import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_shop/presentation/features/bloc/catalog/catalog_bloc.dart';
import 'package:simple_book_shop/presentation/features/widgets/books_catalog.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
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
    );
  }
}
