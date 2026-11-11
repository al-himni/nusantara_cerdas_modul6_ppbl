import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../models/layanan.dart';

class HalamanDetailLayanan extends StatefulWidget {
  const HalamanDetailLayanan({super.key, required this.layanan});

  final Layanan layanan;

  @override
  State<HalamanDetailLayanan> createState() => _HalamanDetailLayananState();
}

class _HalamanDetailLayananState extends State<HalamanDetailLayanan> {
  bool sedangMengirim = false;

  Future<void> ajukanPermohonan() async {
    if (sedangMengirim) return;

    setState(() => sedangMengirim = true);

    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    context.read<PengajuanCubit>().tambah(widget.layanan);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.account_balance,
              size: 52,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              widget.layanan.nama,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(widget.layanan.deskripsi),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: sedangMengirim ? null : ajukanPermohonan,
                child: sedangMengirim
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Ajukan Permohonan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
