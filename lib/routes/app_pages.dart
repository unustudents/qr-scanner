import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../models/product_model.dart';
import '../pages/pages.dart';

export 'package:go_router/go_router.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = GoRouter(
    redirect: (context, state) {
      FirebaseAuth auth = FirebaseAuth.instance;
      return auth.currentUser == null ? "/login" : null;
    },
    routes: [
      GoRoute(
        path: "/",
        name: Routes.home,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: "product",
            name: Routes.product,
            builder: (context, state) => const ProductPage(),
            routes: [
              GoRoute(
                path: ":id",
                name: Routes.detailProduct,
                builder: (context, state) => DetailProductPage(
                  id: state.pathParameters["id"].toString(),
                  data: state.extra! as ProductModel,
                ),
              ),
            ],
          ),
          GoRoute(
            path: "add-product",
            name: Routes.addProduct,
            builder: (context, state) => const AddproductPage(),
          ),
        ],
      ),
      GoRoute(
        path: "/login",
        name: Routes.login,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}
