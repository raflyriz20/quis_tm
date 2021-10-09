import 'package:flutter/material.dart';

class Velg {
  String nama, gambar;
  int harga, stok;
  Velg(
      {required this.nama,
      required this.harga,
      required this.stok,
      required this.gambar});
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var listVelg = [
    Velg(nama: 'Velg 1', harga: 1000000, stok: 1, gambar: 'assets/velg1.png'),
    Velg(nama: 'Velg 2', harga: 3000000, stok: 2, gambar: 'assets/velg2.png'),
    Velg(nama: 'Velg 3', harga: 5000000, stok: 3, gambar: 'assets/velg3.png'),
    Velg(nama: 'Velg 4', harga: 7000000, stok: 4, gambar: 'assets/velg4.png'),
  ];

  void _handleNavResult(Object? result, Velg velg) {
    if (result != null) {
      var resultMap = result as Map<String, Object>;
      if (resultMap.containsKey('stok')) {
        var stok = resultMap['stok'];
        if (stok is int) {
          int _stok = stok;
          var index = listVelg.indexOf(velg);
          if (index >= 0) {
            setState(() {
              listVelg[index] = Velg(
                nama: velg.nama,
                harga: velg.harga,
                stok: _stok,
                gambar: velg.gambar,
              );
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for (var i = 0; i < listVelg.length; i++) {
      total += listVelg[i].harga * listVelg[i].stok;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Toko Velg'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: Container(
        height: 80,
        alignment: Alignment.center,
        color: Colors.red,
        child: Text(
          'Total Rp. $total',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: ListView(
          children: listVelg
              .map(
                (velg) => Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  elevation: 10,
                  shadowColor: Colors.red,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          '${velg.gambar}',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama :${velg.nama}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  )),
                              Text('Harga : Rp ${velg.harga}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  )),
                              Text('Stok : ${velg.stok}',
                                  style: const TextStyle(fontSize: 16)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                  onPressed: () async {
                                    var result = await Navigator.of(context)
                                        .pushNamed('/detail', arguments: {
                                      'velg': velg,
                                    });
                                    _handleNavResult(result, velg);
                                  },
                                  child: const Text('Lihat Detail'))
                            ]),
                      ),
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
