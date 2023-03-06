import 'package:crud_data_pegawai/constant/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/PegawaiModel.dart';

class EditDataPage extends StatefulWidget {
  final Data pegawaiModel;
  final String id_data;

  const EditDataPage({
    super.key,
    required this.pegawaiModel,
    required this.id_data,
  });


  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {

  // late String id = "";
  // late String nama = "";
  // late String posisi = "";
  // late String gaji = "";
  // late String alamat = "";
  
  TextEditingController id = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController posisi = TextEditingController();
  TextEditingController gaji = TextEditingController();
  TextEditingController alamat = TextEditingController();

  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    nama.text = "${widget.pegawaiModel.nama}";
    posisi.text = "${widget.pegawaiModel.posisi}";
    gaji.text = "${widget.pegawaiModel.gaji}";
    alamat.text = "${widget.pegawaiModel.alamat}";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Data'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                controller: nama,
                // initialValue: widget.pegawaiModel.nama,
                // onSaved: (e) => setState(() {
                //   e = nama;
                // }),
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
                // initialValue: widget.pegawaiModel.posisi,
                // onSaved: (e) => setState(() {
                //   e = posisi;
                // }),
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
                // initialValue: widget.pegawaiModel.gaji,
                // onSaved: (e) => setState(() {
                //   e = gaji;
                // }),
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
                // initialValue: widget.pegawaiModel.alamat,
                // onSaved: (e) => setState(() {
                //   e = alamat;
                // }),
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: MaterialButton(
          onPressed: () {
            check(nama.text, posisi.text, gaji.text, alamat.text);
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

  check(String nama, String posisi, String gaji, String alamat) {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      ubahData(nama, posisi, gaji, alamat);
      Navigator.pop(context);
    }
  }

  Future<http.Response> ubahData(
       String nama, String posisi, String gaji, String alamat) async {
    final url = Uri.parse(BaseUrl.editData);
    final response = await http.post(
      url,
      body: {
        'nama': nama,
        'posisi': posisi,
        'gaji': gaji,
        'alamat': alamat,
        'id': widget.id_data.toString(),
        'update_at': DateTime.now().toString()
      },
    );
    return response;
  }
}
