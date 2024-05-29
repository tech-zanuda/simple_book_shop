import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_storage/firebase_ui_storage.dart';
import 'package:flutter/material.dart';
import 'package:simple_book_shop/model/book.dart';
import 'package:simple_book_shop/presentation/features/screens/book_screen.dart';

class BooksCatalog extends StatelessWidget {
  const BooksCatalog({
    super.key,
    required this.books,
  });

  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
        child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookScreen(book: book)));
                    },
                    child: StorageImage(
                      ref: FirebaseStorage.instance
                          .ref('books/${book.id}/cover.webp'),
                      height: 280,
                      alignment: Alignment.bottomCenter,
                      loadingStateVariant: LoadingStateVariant.shimmer(),
                    ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton(
                          onPressed: () {}, child: const Text('В корзину')),
                      IconButton.outlined(
                          style: ButtonStyle(
                              side: MaterialStatePropertyAll(BorderSide(
                                  width: 2.0,
                                  color:
                                      Theme.of(context).colorScheme.primary))),
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.primary,
                          ))
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
