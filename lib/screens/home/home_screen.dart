import 'dart:convert';

import 'package:crud_data_pegawai/model/PegawaiModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constant/url.dart';
import '../add_data/add_data.dart';

import '../edit_data/edit_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final list = <Data>[];
  var loading = false;

  @override
  void initState() {
    super.initState();
    lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: lihatData,
        child: ListView.builder(
            itemCount: list.length,
            // shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = list[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditDataPage(
                              id_data: list[index].id.toString(), 
                              pegawaiModel: list[index],
                            ))),
                child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xfff2f2f2),
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(0, 3))
                        ],
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.nama!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(data.posisi!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(data.alamat!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                        IconButton(
                            onPressed: () => dialogDelete(list[index].id.toString()),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    )),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddDataPage())),
        child: const Icon(Icons.add),
      ),
    );
  }

  delete(String idData) async {
      final response = await http.post(Uri.parse(BaseUrl.deleteData), body: {
        "id": idData,
      });

      final data = jsonDecode(response.body);
      int value = data['value'];
      String pesan = data['message'];

      if (value == 1) {
        print(idData);
        lihatData();
      } else {
        print(pesan);
      }
    }

    dialogDelete(String idData) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Hapus Data"),
              content:
                  const Text("Apakah anda yakin ingin menghapus data ini?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Tidak")),
                TextButton(
                    onPressed: () {
                      delete(idData);
                      Navigator.pop(context);
                    },
                    child: const Text("Ya")),
              ],
            );
          });
    }

  Future lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(Uri.parse(BaseUrl.getData));
    if (response.contentLength == null) {
      print(response.statusCode);
    } else {
      final data = jsonDecode(response.body)['data'];
      data.forEach((api) {
        final ab = Data(api['id'], api['nama'], api['posisi'], api['gaji'],
            api['alamat'], api['created_at'], api['updated_at']);
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }
}
