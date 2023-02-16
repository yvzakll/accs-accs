import 'package:flutter/material.dart';
import 'package:pin_generator/storage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({key, this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _pinResult = "N/A";
  TextEditingController authCode = TextEditingController();
  TextEditingController refKey = TextEditingController();
  int deneme;
  String pc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deneme = int.parse(box.read("authKey"));
    pc = box.read("name");
  }

  @override
  Color appcolor = const Color.fromRGBO(58, 66, 86, 1.0);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      appBar: AppBar(
        title: Text(pc),
        backgroundColor: appcolor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*  Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "AUTH KEY: ${deneme}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ), */
              /* Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                child: TextField(
                  controller: authCode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Auth Code", // pass the hint text parameter here
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ), */
              /* Text(
                "${pc}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ), */
              SizedBox(
                height: 15,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 150.0, vertical: 5),
                  child: Image.asset("assets/images/logo2.png")),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 55.0, vertical: 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: refKey,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.white,
                      size: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                    hintText: "Ref Key", // pass the hint text parameter here
                    hintStyle: const TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15)),
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.orange)))),
                onPressed: () {
                  setState(() {
                    _pinResult = getPinCode(deneme, int.parse(refKey.text));
                  });
                },
                child: const Text("Generate Password"),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _pinResult,
                style: const TextStyle(
                  color: Color.fromARGB(255, 10, 230, 17),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              /*  ElevatedButton(
                  onPressed: () {}, child: const Text("Yeni Giriş Ekle")), */
            ],
          ),
        ),
      ),
    );
  }

  String getPinCode(int key, int data) {
    String result = "";
    try {
      int sonuc;
      sonuc = data + key;

      result = sonuc.toString().substring(0, 6);
    } catch (e) {
      return result;
    }

    return result;
  }
}


/*
String getPinCode(String key, String data) {
    String result = "";
    try {
      String ascList = "";
      for (var i = 0; i <= data.length - 1; i++) {
        String k = key[i];
        String d = data[i];
        ascList += (d.codeUnitAt(0) + k.codeUnitAt(0)).toString();
        ascList = ascList;
      }
      result = ascList.substring(1, 7);
    } catch (e) {
      return result;
    }

    return result;
  }

*/
