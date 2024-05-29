import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_storage/firebase_ui_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_book_shop/model/book.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.book});

  final Book book;

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late PageController _pageViewController;
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> images = [
      StorageImage(
        ref: FirebaseStorage.instance.ref('books/${widget.book.id}/cover.webp'),
        height: 280,
        alignment: Alignment.bottomCenter,
        loadingStateVariant:
            LoadingStateVariant.solidColor(color: Colors.white),
      ),
      StorageImage(
        ref:
            FirebaseStorage.instance.ref('books/${widget.book.id}/ph_001.webp'),
        height: 280,
        alignment: Alignment.bottomCenter,
        loadingStateVariant:
            LoadingStateVariant.solidColor(color: Colors.white),
      ),
      StorageImage(
        ref: FirebaseStorage.instance.ref('books/${widget.book.id}/ph_01.webp'),
        height: 280,
        alignment: Alignment.bottomCenter,
        loadingStateVariant:
            LoadingStateVariant.solidColor(color: Colors.white),
      ),
      StorageImage(
        ref: FirebaseStorage.instance.ref('books/${widget.book.id}/ph_02.webp'),
        height: 280,
        alignment: Alignment.bottomCenter,
        loadingStateVariant:
            LoadingStateVariant.solidColor(color: Colors.white),
      ),
    ];

    YoutubePlayerController _ytcontroller = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );

    List<Widget> indicators(imagesLength, currentIndex) {
      return List<Widget>.generate(imagesLength, (index) {
        return Container(
          margin: const EdgeInsets.all(3),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: currentIndex == index ? Colors.black : Colors.black26,
              shape: BoxShape.circle),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Книга'),
        actions: [
          IconButton.outlined(
              style: ButtonStyle(
                  side: MaterialStatePropertyAll(BorderSide(
                      width: 2, color: Theme.of(context).colorScheme.primary))),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: images.length,
                pageSnapping: true,
                controller: _pageViewController,
                onPageChanged: (page) {
                  setState(() {
                    activePage = page;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  return images[pagePosition];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(images.length, activePage)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.book.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 4),
              child: Text(
                'Автор: ${widget.book.author}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 4),
              child: Text(
                'Жанр: ${widget.book.genre}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 4),
              child: Text(
                'Издатель: ${widget.book.publisher}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 4, bottom: 25),
              child: Text(
                'Страниц: ${widget.book.pages}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'Видео',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            YoutubePlayer(
              controller: _ytcontroller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Theme.of(context).colorScheme.primary,
              progressColors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.redAccent,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: FilledButton(
                          onPressed: () {}, child: const Text('В корзину')),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: OutlinedButton(
                          onPressed: () {}, child: const Text('Купить сейчас')),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      )),
    );
  }
}
