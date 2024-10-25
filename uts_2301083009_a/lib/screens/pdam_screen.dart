import 'package:flutter/material.dart';
import '../models/pdam.dart';
import '../services/pdam_service.dart';

class PdamScreen extends StatefulWidget {
  @override
  _PdamScreenState createState() => _PdamScreenState();
}

class _PdamScreenState extends State<PdamScreen> {
  final _kodePembayaranController = TextEditingController();
  final _namaPelangganController = TextEditingController();
  final _meterBulanIniController = TextEditingController();
  final _meterBulanLaluController = TextEditingController();
  
  String _selectedJenisPelanggan = 'GOLD'; // Jenis pelanggan default
  double? totalBayar;

  List<String> jenisPelangganList = ['GOLD', 'SILVER', 'UMUM'];

  void _calculateTotal() {
    // Validasi input
    if (_kodePembayaranController.text.isEmpty ||
        _namaPelangganController.text.isEmpty ||
        _meterBulanIniController.text.isEmpty ||
        _meterBulanLaluController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mohon isi semua field!')),
      );
      return;
    }

    final pdam = Pdam(
      kodePembayaran: _kodePembayaranController.text,
      namaPelanggan: _namaPelangganController.text,
      jenisPelanggan: _selectedJenisPelanggan,
      tanggal: DateTime.now(),
      meterBulanIni: int.tryParse(_meterBulanIniController.text) ?? 0,
      meterBulanLalu: int.tryParse(_meterBulanLaluController.text) ?? 0,
    );

    setState(() {
      totalBayar = PdamService.calculateTotalPayment(pdam);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hitung Tagihan PDAM'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _kodePembayaranController,
              decoration: InputDecoration(labelText: 'Kode Pembayaran'),
            ),
            TextField(
              controller: _namaPelangganController,
              decoration: InputDecoration(labelText: 'Nama Pelanggan'),
            ),
            // Dropdown untuk memilih jenis pelanggan
            DropdownButtonFormField<String>(
              value: _selectedJenisPelanggan,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedJenisPelanggan = newValue!;
                });
              },
              items: jenisPelangganList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Jenis Pelanggan'),
            ),
            TextField(
              controller: _meterBulanIniController,
              decoration: InputDecoration(labelText: 'Meter Bulan Ini'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _meterBulanLaluController,
              decoration: InputDecoration(labelText: 'Meter Bulan Lalu'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _calculateTotal,
                child: Text('Hitung Total Bayar'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: totalBayar != null 
                  ? Text(
                      'Total Bayar: Rp ${totalBayar!.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : Container(), // Tampilkan kosong jika totalBayar null
            ),
          ],
        ),
      ),
    );
  }
}
