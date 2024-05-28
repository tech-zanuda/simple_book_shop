part of 'catalog_bloc.dart';

@immutable
abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object> get props => [];
}

class LoadCatalog extends CatalogEvent {}
