import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_storage/firebase_ui_storage.dart';
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
        title: Text(
          'Каталог',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<CatalogBloc, CatalogState>(
              builder: (context, state) {
                if (state is CatalogLoading) {
                  return const Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      CircularProgressIndicator(),
                    ],
                  );
                } else if (state is CatalogLoaded) {
                  final books = state.books;
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return StorageImage(
                            ref: FirebaseStorage.instance
                                .ref('books/${book.id}/cover.webp'),
                            height: 100,
                            loadingStateVariant: LoadingStateVariant.shimmer(),
                          );
                        }),
                  );
                } else if (state is CatalogError) {
                  return Center(child: Text(state.errorMessage));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
