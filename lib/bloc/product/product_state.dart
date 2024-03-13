part of 'product_bloc.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateComplete extends ProductState {}

class ProductStateCompleteExport extends ProductState {}

class ProductStateError extends ProductState {
  ProductStateError(this.msg);
  String msg;
}
