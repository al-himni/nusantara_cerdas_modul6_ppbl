import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../models/layanan.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    const bidang = ['Perizinan', 'Kesehatan', 'Transportasi'];

    return DefaultTabController(
      length: bidang.length,
      child: Column(
        children: [
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Perizinan'),
              Tab(text: 'Kesehatan'),
              Tab(text: 'Transportasi'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: bidang.map((namaBidang) {
                final daftar = semuaLayanan.where(
                  (layanan) => layanan.bidang == namaBidang,
                );

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: daftar
                      .map((layanan) => _KartuLayanan(layanan: layanan))
                      .toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _KartuLayanan extends StatelessWidget {
  const _KartuLayanan({required this.layanan});

  final Layanan layanan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(layanan.nama),
        subtitle: Text(layanan.deskripsi),
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: layanan);
        },
        trailing: BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favorit) {
            final sudahFavorit = favorit.contains(layanan.id);

            return IconButton(
              tooltip: sudahFavorit
                  ? 'Hapus dari favorit'
                  : 'Tambah ke favorit',
              onPressed: () {
                context.read<FavoritCubit>().toggle(layanan.id);
              },
              icon: Icon(
                sudahFavorit ? Icons.star : Icons.star_border,
                color: sudahFavorit
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
