import 'package:flutter/material.dart';
import 'package:qrscanner/routes/app_pages.dart';

import '../bloc/bloc.dart';

class AddproductPage extends StatelessWidget {
  const AddproductPage({super.key});

  @override
  Widget build(BuildContext context) {
    var tecCode = TextEditingController();
    var tecName = TextEditingController();
    var tecQty = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Tmabah Produk")),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          TextField(
            autocorrect: false,
            controller: tecCode,
            keyboardType: TextInputType.number,
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
                  ProductEventAdd(
                    code: int.tryParse(tecCode.text) ?? 0,
                    name: tecName.text,
                    qty: int.tryParse(tecQty.text) ?? 0,
                  ),
                ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20.0)),
            child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state is ProductStateError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.msg.toString())));
                }
                if (state is ProductStateComplete) context.pop();
              },
              builder: (context, state) {
                if (state is ProductStateLoading) {
                  return const Text("Loading ...");
                }
                return const Text("TAMBAH");
              },
            ),
          ),
        ],
      ),
    );
  }
}
