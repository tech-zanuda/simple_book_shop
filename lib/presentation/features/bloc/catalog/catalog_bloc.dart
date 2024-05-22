import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_book_shop/model/book.dart';
import 'package:simple_book_shop/service/firestore_sevice.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final FirestoreService _firestoreService;

  CatalogBloc(this._firestoreService) : super(CatalogInitial()) {
    on<LoadCatalog>((event, emit) async {
      try {
        emit(CatalogLoading());
        final books = await _firestoreService.getBooks().first;
        emit(CatalogLoaded(books));
      } catch (e) {
        emit(CatalogError('Ошибка загрузки каталога.'));
      }
    });
  }
}
