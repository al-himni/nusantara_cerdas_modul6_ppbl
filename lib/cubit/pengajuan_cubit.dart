import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';

class PengajuanCubit extends Cubit<List<Layanan>> {
  PengajuanCubit() : super(const []);

  void tambah(Layanan layanan) {
    emit([...state, layanan]);
  }

  void hapus(String id) {
    emit(state.where((layanan) => layanan.id != id).toList());
  }

  void kosongkan() {
    emit(const []);
  }

  int get totalPengajuan => state.length;
}
