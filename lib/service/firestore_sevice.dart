import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_book_shop/model/book.dart';

class FirestoreService {
  final CollectionReference _booksCollection =
      FirebaseFirestore.instance.collection('books');

  Stream<List<Book>> getBooks() {
    return _booksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Book(
            id: doc.id,
            author: data['author'],
            genre: data['genre'],
            inStock: data['inStock'],
            pages: data['pages'],
            price: data['price'],
            publisher: data['publisher'],
            title: data['title']);
      }).toList();
    });
  }
}
