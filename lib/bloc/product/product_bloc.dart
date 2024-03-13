import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qrscanner/models/product_model.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // VARIABLE
  var firestore = FirebaseFirestore.instance.collection("produk");

  // FUNGSI
  Stream<QuerySnapshot<ProductModel>> fStrimProduct() async* {
    yield* firestore
        .withConverter<ProductModel>(
            fromFirestore: (snapshot, options) =>
                ProductModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson())
        .snapshots();
  }

  ProductBloc() : super(ProductInitial()) {
    // FUNGSI TAMBAH
    on<ProductEventAdd>((event, emit) async {
      emit(ProductStateLoading());
      await firestore
          .add({'name': event.name, 'code': event.code, 'qty': event.qty})
          .then((value) => emit(ProductStateComplete()))
          .catchError((error) =>
              emit(ProductStateError("Tidak dapat menambah produk")));
    });

    // FUNGSI EDIT
    on<ProductEventEdit>((event, emit) async {
      emit(ProductStateLoading());
      await firestore
          .doc(event.id)
          .update({"name": event.name, "qty": event.qty})
          .then((value) => emit(ProductStateComplete()))
          .catchError((error) =>
              emit(ProductStateError("Tidak dapat emmperbarui produk")));
    });

    // FUNGSI HAPUS
    on<ProductEventDelete>((event, emit) async {
      emit(ProductStateLoading());
      await firestore
          .doc(event.id)
          .delete()
          .then((value) => emit(ProductStateComplete()))
          .catchError((error) =>
              emit(ProductStateError("Tidak dapat menghapus produk")));
    });

    // FUNGSI HAPUS
    on<ProductEventExportPdf>(
      (event, emit) async {
        emit(ProductStateLoading());
        // ambil semua data
        await firestore
            .withConverter<ProductModel>(
                fromFirestore: (snapshot, options) =>
                    ProductModel.fromJson(snapshot.data()!),
                toFirestore: (value, options) => value.toJson())
            .get();

        // buat pdf
        final pdf = pw.Document();
        pdf.addPage(
          pw.MultiPage(
              build: (context) {
                return [];
              },
              pageFormat: PdfPageFormat.a4),
        );
        Uint8List bytes = await pdf.save();

        // buka file
        final dir = await getApplicationDocumentsDirectory();
        File file = File("${dir.path}/dokumen_product.pdf");

        await file.writeAsBytes(bytes);
        await OpenFile.open(file.path);
        emit(ProductStateCompleteExport());
      },
    );
  }
}
