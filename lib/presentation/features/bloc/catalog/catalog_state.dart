part of 'catalog_bloc.dart';

@immutable
abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Book> books;

  const CatalogLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class CatalogError extends CatalogState {
  final String errorMessage;

  const CatalogError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
