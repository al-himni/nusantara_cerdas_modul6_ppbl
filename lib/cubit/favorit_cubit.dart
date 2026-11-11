import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(<String>{});

  void tandai(String idLayanan) {
    emit({...state, idLayanan});
  }

  void batalTandai(String idLayanan) {
    emit(state.where((id) => id != idLayanan).toSet());
  }

  void toggle(String idLayanan) {
    if (state.contains(idLayanan)) {
      batalTandai(idLayanan);
    } else {
      tandai(idLayanan);
    }
  }
}
