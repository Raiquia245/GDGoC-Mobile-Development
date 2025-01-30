import 'dart:io';

double budgetAwal = 0;
double sisaBudget = 0;
Map<String, double> pengeluaran = {};

void main() {
  stdout.write("Masukkan budget awal kamu: ");
  String? budget = stdin.readLineSync();
  budgetAwal = double.tryParse(budget ?? '') ?? 0;
  sisaBudget = budgetAwal;

  while (true) {
    print("\n=== Pencatat Pengeluaran Harian By Valdez ===");
    print("1. Tambah Pengeluaran");
    print("2. Hapus Pengeluaran");
    print("3. Lihat Pengeluaran");
    print("4. Lihat Sisa Budget");
    print("5. Keluar");
    stdout.write("Pilih menu: ");

    String? pilihan = stdin.readLineSync();
    switch (pilihan) {
      case '1':
        tambahPengeluaran();
        break;
      case '2':
        hapusPengeluaran();
        break;
      case '3':
        lihatPengeluaran();
        break;
      case '4':
        lihatSisaBudget();
        break;
      case '5':
        print("Terima kasih telah menggunakan aplikasi ini!");
        return;
      default:
        print("Pilihan kamu tidak valid, coba pilihan yang lain.");
    }
  }
}

void tambahPengeluaran() {
  try {
    stdout.write("Masukkan nama pengeluaran: ");
    String? nama = stdin.readLineSync();
    if (nama?.toLowerCase() == "gajadi") {
      print("Tindakan dibatalkan.");
      return; 
    }
    stdout.write("Masukkan jumlah pengeluaran: ");
    String? jumlahStr = stdin.readLineSync();
    double? jumlah = double.tryParse(jumlahStr ?? '');

    if (nama != null && jumlah != null && jumlah > 0) {
      if (sisaBudget >= jumlah) {
        sisaBudget -= jumlah;
        pengeluaran[nama] = jumlah;

        print("Pengeluaran '$nama' sebesar Rp${jumlah.toStringAsFixed(2)} telah ditambahkan.");
      } else {
        print("Pengeluaran melebihi sisa budget!");
      }
    } else {
      print("Input tidak valid.");
    }
  } catch (e) {
    print("Terjadi kesalahan: $e");
  }
}

void hapusPengeluaran() {
  try {
    lihatPengeluaran();
    stdout.write("Masukkan nama pengeluaran yang ingin dihapus: ");
    String? nama = stdin.readLineSync();
    if (nama?.toLowerCase() == "gajadi") {
      print("Tindakan dibatalkan.");
      return; 
    }

    if (nama != null && pengeluaran.containsKey(nama)) {
      double jumlah = pengeluaran[nama]!;
      sisaBudget += jumlah;
      pengeluaran.remove(nama);

      print("Pengeluaran '$nama' sebesar Rp${jumlah.toStringAsFixed(2)} telah dihapus.");
    } else {
      print("Pengeluaran dengan nama '$nama' tidak ditemukan.");
    }
  } catch (e) {
    print("Terjadi kesalahan saat menghapus pengeluaran: $e");
  }
}

void lihatPengeluaran() {
  if (pengeluaran.isEmpty) {
    print("Belum ada pengeluaran.");
    return;
  }

  print("\nDaftar Pengeluaran:");
  pengeluaran.forEach((nama, jumlah) {
    print("- $nama: Rp${jumlah.toStringAsFixed(2)}");
  });
}

void lihatSisaBudget() {
  print("Sisa budget: Rp${sisaBudget.toStringAsFixed(2)}");
}
