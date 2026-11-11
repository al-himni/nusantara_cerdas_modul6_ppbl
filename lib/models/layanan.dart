class Layanan {
  final String id;
  final String nama;
  final String bidang;
  final String deskripsi;

  const Layanan({
    required this.id,
    required this.nama,
    required this.bidang,
    required this.deskripsi,
  });
}

const semuaLayanan = <Layanan>[
  Layanan(
    id: 'izin-1',
    nama: 'Perizinan Usaha',
    bidang: 'Perizinan',
    deskripsi: 'Pengajuan izin usaha warga.',
  ),
  Layanan(
    id: 'izin-2',
    nama: 'Izin Mendirikan Bangunan',
    bidang: 'Perizinan',
    deskripsi: 'Informasi dan pengajuan izin bangunan.',
  ),
  Layanan(
    id: 'izin-3',
    nama: 'Administrasi Kependudukan',
    bidang: 'Perizinan',
    deskripsi: 'Layanan dokumen kependudukan.',
  ),
  Layanan(
    id: 'sehat-1',
    nama: 'Jadwal Puskesmas',
    bidang: 'Kesehatan',
    deskripsi: 'Informasi jadwal pelayanan puskesmas.',
  ),
  Layanan(
    id: 'sehat-2',
    nama: 'Konsultasi Kesehatan',
    bidang: 'Kesehatan',
    deskripsi: 'Ajukan konsultasi kesehatan warga.',
  ),
  Layanan(
    id: 'sehat-3',
    nama: 'Vaksinasi',
    bidang: 'Kesehatan',
    deskripsi: 'Informasi jadwal vaksinasi.',
  ),
  Layanan(
    id: 'trans-1',
    nama: 'Kartu Transportasi',
    bidang: 'Transportasi',
    deskripsi: 'Informasi kartu transportasi warga.',
  ),
  Layanan(
    id: 'trans-2',
    nama: 'Pengaduan Jalan',
    bidang: 'Transportasi',
    deskripsi: 'Laporkan kerusakan jalan.',
  ),
  Layanan(
    id: 'trans-3',
    nama: 'Jadwal Angkutan',
    bidang: 'Transportasi',
    deskripsi: 'Informasi rute dan jadwal angkutan.',
  ),
];
