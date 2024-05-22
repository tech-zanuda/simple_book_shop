part of 'catalog_bloc.dart';

@immutable
abstract class CatalogState {}

final class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Book> books;

  CatalogLoaded(this.books);
}

class CatalogError extends CatalogState {
  final String errorMessage;

  CatalogError(this.errorMessage);
}
