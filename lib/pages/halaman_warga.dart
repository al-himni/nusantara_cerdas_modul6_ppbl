import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../models/layanan.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Pengaturan', style: Theme.of(context).textTheme.titleLarge),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Mode gelap'),
              value: mode == ThemeMode.dark,
              onChanged: (_) {
                context.read<ThemeCubit>().toggle();
              },
            );
          },
        ),
        const SizedBox(height: 16),
        Text('Layanan Favorit', style: Theme.of(context).textTheme.titleLarge),
        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favorit) {
            final daftar = semuaLayanan
                .where((layanan) => favorit.contains(layanan.id))
                .toList();

            if (daftar.isEmpty) {
              return const ListTile(title: Text('Belum ada layanan favorit.'));
            }

            return Column(
              children: daftar.map((layanan) {
                return ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(layanan.nama),
                  subtitle: Text(layanan.bidang),
                  trailing: IconButton(
                    tooltip: 'Hapus favorit',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      context.read<FavoritCubit>().batalTandai(layanan.id);
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
        const Divider(height: 32),
        Text(
          'Keranjang Pengajuan',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        BlocBuilder<PengajuanCubit, List<Layanan>>(
          builder: (context, daftar) {
            if (daftar.isEmpty) {
              return const ListTile(title: Text('Belum ada pengajuan.'));
            }

            return Column(
              children: [
                ...daftar.map((layanan) {
                  return ListTile(
                    leading: const Icon(Icons.description_outlined),
                    title: Text(layanan.nama),
                    subtitle: Text(layanan.bidang),
                    trailing: IconButton(
                      tooltip: 'Hapus pengajuan',
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        context.read<PengajuanCubit>().hapus(layanan.id);
                      },
                    ),
                  );
                }),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.read<PengajuanCubit>().kosongkan();
                    },
                    child: const Text('Kosongkan'),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
