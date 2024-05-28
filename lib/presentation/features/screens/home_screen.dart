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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.40),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StorageImage(
                                ref: FirebaseStorage.instance
                                    .ref('books/${book.id}/cover.webp'),
                                height: 280,
                                alignment: Alignment.bottomCenter,
                                loadingStateVariant:
                                    LoadingStateVariant.shimmer(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                book.title,
                                softWrap: true,
                                maxLines: 3,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                book.author,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Цена: ${book.price} руб.'),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FilledButton(
                                      onPressed: () {},
                                      child: const Text('В корзину')),
                                  IconButton.outlined(
                                      style: ButtonStyle(
                                          side: MaterialStatePropertyAll(
                                              BorderSide(
                                                  width: 2.0,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary))),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ))
                                ],
                              )
                            ],
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
