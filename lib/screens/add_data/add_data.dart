import 'package:flutter/material.dart';

import '../../constant/url.dart';
import 'package:http/http.dart' as http;

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final formKey = GlobalKey<FormState>();
  // String? nama, posisi, alamat, gaji;

  TextEditingController nama = TextEditingController();
  TextEditingController posisi = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController gaji = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              controller: nama,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Nama', border: InputBorder.none),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              controller: posisi,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Posisi tidak boleh kosong';
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Posisi', border: InputBorder.none),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: gaji,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Gaji tidak boleh kosong';
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Gaji', border: InputBorder.none),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              controller: alamat,
              maxLines: 5,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Alamat tidak boleh kosong';
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Alamat', border: InputBorder.none),
            ),
          )
        ],
      ),
      bottomNavigationBar: MaterialButton(
          onPressed: () {
            uploadData(nama.text, posisi.text, gaji.text, alamat.text);
          },
          child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Center(
                  child: Text(
                'Simpan',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )))),
    );
  }

  uploadData(String nama, String posisi, String gaji, String alamat) {
    tambahData(nama, posisi, gaji, alamat);
    Navigator.pop(context);
  }

  Future<http.Response> tambahData(
      String nama, String posisi, String gaji, String alamat) async {
    final url = Uri.parse(BaseUrl.addData);
    final response = await http.post(
      url,
      body: {
        'nama': nama,
        'posisi': posisi,
        'gaji': gaji,
        'alamat': alamat,
        'created_at': DateTime.now().toString(),
        'update_at': DateTime.now().toString(),
      },
    );
    return response;
  }
}
