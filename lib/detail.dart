import 'package:flutter/material.dart';
import 'package:quiz_rafli/home.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Velg? _velg;
  int _stok = -1;

  void plusstok() {
    setState(() {
      _stok++;
    });
  }

  void minstok() {
    if (_stok > 0) {
      setState(() {
        _stok--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    if (args.containsKey('velg')) {
      var velg = args['velg'];
      if (velg is Velg) {
        _velg = velg;
        if (_stok < 0) {
          _stok = _velg?.stok ?? 0;
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Velg Detail'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            "${_velg?.gambar}",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Text('Nama : ${_velg?.nama}',
              style: const TextStyle(
                fontSize: 20,
              )),
          Text(
            'Harga : Rp ${_velg?.harga}',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const Text('Stok', style: TextStyle(fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(onPressed: minstok, icon: Icon(Icons.remove)),
              Text(
                '$_stok',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(onPressed: plusstok, icon: Icon(Icons.add)),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Navigator.of(context).pop({
                  'stok': _stok,
                });
              },
              child: Text('Submit')),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
