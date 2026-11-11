import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'models/layanan.dart';
import 'pages/halaman_detail_layanan.dart';
import 'pages/halaman_layanan.dart';
import 'pages/halaman_warga.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoritCubit()),
        BlocProvider(create: (_) => PengajuanCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nusantara Cerdas Mobile',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          home: const MainNavigationPage(),
          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              final layanan = settings.arguments! as Layanan;

              return MaterialPageRoute<bool>(
                builder: (_) {
                  return HalamanDetailLayanan(layanan: layanan);
                },
              );
            }

            return null;
          },
        );
      },
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int index = 0;

  final halaman = const [HalamanBeranda(), HalamanLayanan(), HalamanWarga()];

  final judul = const ['Beranda', 'Layanan', 'Warga'];
  final ikon = const [
    Icons.home_outlined,
    Icons.grid_view,
    Icons.person_outline,
  ];

  void pilihHalaman(int nilai) {
    setState(() => index = nilai);
  }

  Widget ikonTujuan(int nilai) {
    if (nilai != 2) return Icon(ikon[nilai]);

    return BlocSelector<PengajuanCubit, List<Layanan>, int>(
      selector: (daftar) => daftar.length,
      builder: (context, jumlah) {
        return Badge(
          isLabelVisible: jumlah > 0,
          label: Text('$jumlah'),
          child: Icon(ikon[nilai]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tujuanBawah = [
      for (var i = 0; i < judul.length; i++)
        NavigationDestination(icon: ikonTujuan(i), label: judul[i]),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final lebar = constraints.maxWidth;
        final layarLebar = lebar >= 800;
        final layarSedang = lebar >= 600;

        return Scaffold(
          appBar: AppBar(title: Text(judul[index])),
          drawer: NavigationDrawer(
            selectedIndex: index,
            onDestinationSelected: (nilai) {
              pilihHalaman(nilai);
              Navigator.pop(context);
            },
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(28, 16, 16, 8),
                child: Text('Nusantara Cerdas Mobile'),
              ),
              for (var i = 0; i < judul.length; i++)
                NavigationDrawerDestination(
                  icon: ikonTujuan(i),
                  label: Text(judul[i]),
                ),
            ],
          ),
          body: Row(
            children: [
              if (layarLebar)
                NavigationRail(
                  extended: lebar >= 1100,
                  selectedIndex: index,
                  onDestinationSelected: pilihHalaman,
                  labelType: lebar >= 1100 ? null : NavigationRailLabelType.all,
                  destinations: [
                    for (var i = 0; i < judul.length; i++)
                      NavigationRailDestination(
                        icon: ikonTujuan(i),
                        label: Text(judul[i]),
                      ),
                  ],
                ),
              if (layarLebar) const VerticalDivider(width: 1),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: layarSedang ? 16 : 0,
                  ),
                  child: halaman[index],
                ),
              ),
            ],
          ),
          bottomNavigationBar: layarLebar
              ? null
              : NavigationBar(
                  selectedIndex: index,
                  onDestinationSelected: pilihHalaman,
                  destinations: tujuanBawah,
                ),
        );
      },
    );
  }
}

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Selamat datang di layanan digital warga.',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        const Text(
          'Jelajahi layanan Perizinan, Kesehatan, dan Transportasi. '
          'Simpan layanan favorit atau ajukan beberapa layanan melalui '
          'tujuan Warga.',
        ),
        const SizedBox(height: 20),
        const Card(
          child: ListTile(
            leading: Icon(Icons.location_city),
            title: Text('Nusantara Cerdas Mobile'),
            subtitle: Text('Layanan publik dalam satu aplikasi'),
          ),
        ),
      ],
    );
  }
}
