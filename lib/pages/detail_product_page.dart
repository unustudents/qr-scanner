import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscanner/bloc/bloc.dart';
import 'package:qrscanner/models/product_model.dart';
import 'package:qrscanner/routes/app_pages.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({super.key, required this.id, required this.data});

  final String id;
  final ProductModel data;

  @override
  Widget build(BuildContext context) {
    var tecQty = TextEditingController(text: data.qty.toString());
    var tecCode = TextEditingController(text: data.code.toString());
    var tecName = TextEditingController(text: data.name);
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Product")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: SizedBox.square(
              dimension: 250,
              child: QrImageView(
                data: data.code.toString(),
                size: 250,
                version: QrVersions.auto,
              ),
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: tecCode,
            enabled: false,
            decoration: InputDecoration(
              labelText: "Kode Barang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            autocorrect: false,
            controller: tecName,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: "Nama Barang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            autocorrect: false,
            controller: tecQty,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Jumlah Barang",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () => context.read<ProductBloc>().add(
                  ProductEventEdit(
                    name: tecName.text,
                    qty: int.tryParse(tecQty.text) ?? 0,
                    id: id,
                  ),
                ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductStateError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.msg)));
                }
                if (state is ProductStateLoading) context.pop();
              },
              builder: (context, state) {
                return Text(
                    state is ProductStateLoading ? "Loading ..." : "UPDATE");
              },
            ),
          ),
          const SizedBox(height: 15),
          TextButton.icon(
            style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.pink)),
            onPressed: () =>
                context.read<ProductBloc>().add(ProductEventDelete(id)),
            icon: const Icon(Icons.delete_forever_rounded),
            label: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductStateError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.msg)));
                }
                if (state is ProductStateLoading) context.pop();
              },
              builder: (context, state) {
                // if (state is ProductStateLoading) {
                //   return const Text("Loading ...");
                // }
                return Text(state is ProductStateLoading
                    ? "Loading ..."
                    : "Delete Produk");
              },
            ),
          ),
        ],
      ),
    );
  }
}
