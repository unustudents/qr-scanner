import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStLogout()) {
    FirebaseAuth auth = FirebaseAuth.instance;
    on<AuthEvLogin>((event, emit) async {
      // ketika klik tombol login
      // event digunakan untuk memanggil nilai di dalam authevent
      // emit digunakan untuk memperbarui suatu data, cara getx nya ya obs
      emit(AuthStLoading());
      await auth
          .signInWithEmailAndPassword(email: event.email, password: event.pass)
          .then((value) => emit(AuthStLogin()))
          .catchError((e) => emit(AuthStError(msg: e.toString())));
    });
    on<AuthEvLogout>((event, emit) async {
      // ketika klik tombol logout
      emit(AuthStLoading());
      await auth
          .signOut()
          .then((value) => emit(AuthStLogout()))
          .catchError((e) => emit(AuthStError(msg: e.toString())));
    });
  }
}
