part of 'product_bloc.dart';

sealed class ProductEvent {}

class ProductEventAdd extends ProductEvent {
  ProductEventAdd({required this.code, required this.name, required this.qty});
  int code;
  String name;
  int qty;
}

class ProductEventEdit extends ProductEvent {
  ProductEventEdit({required this.id, required this.name, required this.qty});
  String id;
  String name;
  int qty;
}

class ProductEventDelete extends ProductEvent {
  ProductEventDelete(this.id);
  String id;
}

class ProductEventExportPdf extends ProductEvent {}
