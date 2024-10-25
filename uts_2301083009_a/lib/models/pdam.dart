class Pdam {
  final String kodePembayaran;
  final String namaPelanggan;
  final String jenisPelanggan;
  final DateTime tanggal;
  final int meterBulanIni;
  final int meterBulanLalu;
  
  Pdam({
    required this.kodePembayaran,
    required this.namaPelanggan,
    required this.jenisPelanggan,
    required this.tanggal,
    required this.meterBulanIni,
    required this.meterBulanLalu,
  });

  int get meterPakai => meterBulanIni - meterBulanLalu;

  double calculateTotalBayar() {
    int pemakaian = meterPakai;
    double total = 0.0;
    
    if (jenisPelanggan == 'GOLD') {
      if (pemakaian <= 10) {
        total = pemakaian * 5000;
      } else if (pemakaian <= 20) {
        total = (10 * 5000) + ((pemakaian - 10) * 10000);
      } else {
        total = (10 * 5000) + (10 * 10000) + ((pemakaian - 20) * 20000);
      }
    } else if (jenisPelanggan == 'SILVER') {
      if (pemakaian <= 10) {
        total = pemakaian * 4000;
      } else if (pemakaian <= 20) {
        total = (10 * 4000) + ((pemakaian - 10) * 8000);
      } else {
        total = (10 * 4000) + (10 * 8000) + ((pemakaian - 20) * 10000);
      }
    } else if (jenisPelanggan == 'UMUM') {
      if (pemakaian <= 10) {
        total = pemakaian * 2000;
      } else if (pemakaian <= 20) {
        total = (10 * 2000) + ((pemakaian - 10) * 3000);
      } else {
        total = (10 * 2000) + (10 * 3000) + ((pemakaian - 20) * 5000);
      }
    }
    
    return total;
  }
}
