import 'package:flutter/material.dart';
import 'package:qrscanner/bloc/bloc.dart';
import 'package:qrscanner/routes/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.all(20),
        itemCount: 4,
        itemBuilder: (context, index) {
          late String title;
          late IconData icon;
          late VoidCallback onTap;

          switch (index) {
            case 0:
              title = "Tambah Produk";
              icon = Icons.post_add_rounded;
              onTap = () => context.goNamed(Routes.addProduct);
              break;
            case 1:
              title = "Daftar Produk";
              icon = Icons.list_alt_rounded;
              onTap = () => context.goNamed(Routes.product);
              break;
            case 2:
              title = "QR Code";
              icon = Icons.qr_code_rounded;
              onTap = () {};
              break;
            case 3:
              title = "Katalog";
              icon = Icons.document_scanner_rounded;
              onTap = () =>
                  context.read<ProductBloc>().add(ProductEventExportPdf());
              break;
          }

          BorderRadius borderRadius = BorderRadius.circular(15);

          return Material(
            color: Colors.grey.shade300,
            borderRadius: borderRadius,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 50),
                  const SizedBox(height: 10),
                  Text(title),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
