import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscanner/bloc/bloc.dart';
import 'package:qrscanner/routes/app_pages.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    var stream = context.read<ProductBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text("Semua Produk")),
      body: StreamBuilder(
        stream: stream.fStrimProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Belum ada produk"));
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan"));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs.elementAt(index).data();
              var uid = snapshot.data!.docs.elementAt(index).id;
              return Card(
                elevation: 5,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    context.goNamed(
                      Routes.detailProduct,
                      pathParameters: {"id": uid},
                      extra: data,
                    );
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    textColor: Colors.black,
                    title: Text(data.code.toString()),
                    titleTextStyle:
                        const TextStyle(fontWeight: FontWeight.bold),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.name.toString()),
                        Text("Total = ${data.qty}"),
                      ],
                    ),
                    trailing: SizedBox.square(
                      dimension: 50,
                      child: QrImageView(
                        data: data.code.toString(),
                        size: 200,
                        version: QrVersions.auto,
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        },
      ),
    );
  }
}
