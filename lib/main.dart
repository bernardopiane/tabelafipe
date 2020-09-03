import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'JSON/marcas.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// api  AIzaSyDnyrJiQON8WnYI_uQ5Dm3jE36LWws0O58

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _data;
  bool isLoaded = false;

  var _modelos;
  bool modeloLoaded = false;

  var _anos;
  bool anoLoaded = false;

  var selectedMarca;

  var _valor;

  bool valorLoaded = false;
  var selectedModelo;

  String tipo;
  List<String> tipos = ["carros", "motos", "caminhoes"];

  var selectedAno;

  String filter = "";

  bool isLoading = false;

  Future getMarcas() async {
    var url = "https://parallelum.com.br/fipe/api/v1/$tipo/marcas";
    var response = await http.get(url);
    if (response.statusCode == 200) {
//        print(response.toString());
//        print(response.body.toString());
//        final marcas = Marcas.fromJson(response.body);
      var test = json.decode(response.body);
      setState(() {
//          _data = marcas;
        _data = test;
        isLoaded = true;
      });
      print(test.toString());
      return test;
    }
  }

  getModelos(String marca) async {
    var url = "https://parallelum.com.br/fipe/api/v1/$tipo/marcas/$marca/modelos";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      setState(() {
        _modelos = decode;
        modeloLoaded = true;
      });
      print(_modelos.toString());
    }
  }

  getAnos(String marca, String modelo) async {
    var url = "https://parallelum.com.br/fipe/api/v1/$tipo/marcas/$marca/modelos/$modelo/anos";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      setState(() {
        _anos = decode;
        anoLoaded = true;
      });
      print(_anos.toString());
    }
  }

  getValor(String marca, String modelo, String id) async {
    var url = "https://parallelum.com.br/fipe/api/v1/$tipo/marcas/$marca/modelos/$modelo/anos/$id";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);
      setState(() {
        _valor = decode;
        valorLoaded = true;
      });
      print(_valor.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoaded = false;
      modeloLoaded = false;
      anoLoaded = false;
      valorLoaded = false;
      tipo = "carros";
      isLoading = false;
      getMarcas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.blue, // transparent status bar
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
//              AnimatedContainer(
//                color: valorLoaded ? Colors.blue.shade200 : Colors.grey.shade200,
//                duration: Duration(milliseconds: 350),
//              ),
              Container(
                color: Colors.grey.shade200,
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.ease,
//                  height: anoLoaded ? 270 : 0.0,
                  height: anoLoaded ? 375 : 0.0,
                  color: Colors.blue.shade900,
                ),
              ),
//              AnimatedOpacity(
//                duration: Duration(milliseconds: 350),
//                opacity: anoLoaded ? 1.0 : 0.0,
//                child: ClipRRect(
//                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
//                  child: Container(
//                    height: 270,
//                    color: Colors.blue.shade900,
//                  ),
//                ),
//              ),
              ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 350),
//                  height: modeloLoaded ? 210 : 0.0,
                  height: modeloLoaded ? 295 : 0.0,
                  curve: Curves.ease,
                  color: Colors.blue.shade700,
                ),
              ),
              ClipRRect(
                borderRadius: valorLoaded
                    ? BorderRadius.circular(0)
                    : BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                child: AnimatedContainer(
//                  duration: Duration(milliseconds: valorLoaded ? 775 : 500),
                  duration: Duration(milliseconds: 500),
//                  height: valorLoaded ? MediaQuery.of(context).size.height : isLoaded ? 150 : 0,
                  height: valorLoaded ? MediaQuery.of(context).size.height : isLoaded ? 205 : 0,
                  color: Colors.blue,
                  curve: Curves.ease,
                ),
              ),
              ListView(
                padding: EdgeInsets.all(8),
                children: <Widget>[
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              new Radio(
                                value: "carros",
                                groupValue: tipo,
                                onChanged: changeTipo,
                              ),
                              new Text(
                                'Carros',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              new Radio(
                                value: "motos",
                                groupValue: tipo,
                                onChanged: changeTipo,
                              ),
                              new Text(
                                'Motos',
                                style: new TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              new Radio(
                                value: "caminhoes",
                                groupValue: tipo,
                                onChanged: changeTipo,
                              ),
                              new Text(
                                'Caminhões',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
//                  AnimatedSwitcher(
//                    child: isLoaded
//                        ? modeloLoaded
//                            ? ListTile(
//                                title: Text(
//                                  selectedMarca['nome'],
//                                  style: TextStyle(color: Colors.grey),
//                                  maxLines: 1,
//                                  overflow: TextOverflow.ellipsis,
//                                  softWrap: true,
//                                ),
//                                trailing: IconButton(
//                                  onPressed: () {
//                                    setState(() {
//                                      filter = "";
//                                      modeloLoaded = false;
//                                      anoLoaded = false;
//                                      valorLoaded = false;
//                                      selectedMarca = null;
//                                      selectedModelo = null;
//                                      selectedAno = null;
//                                    });
//                                  },
//                                  icon: Icon(Icons.clear),
//                                ),
//                              )
//                            : SizedBox()
//                        : Center(
//                            child: Container(
//                              height: 32,
//                              width: 32,
//                              child: CircularProgressIndicator(),
//                            ),
//                          ),
//                    duration: Duration(milliseconds: 350),
//                  ),
                  SizedBox(
                    height: 24,
                  ),
                  AnimatedContainer(
                    height: modeloLoaded ? 64 : MediaQuery.of(context).size.height - 180,
                    duration: Duration(milliseconds: 350),
                    child: Card(
                      elevation: 3.0,
                      child: isLoaded
                          ? modeloLoaded
                              ? ListTile(
                                  title: Text(
                                    selectedMarca['nome'],
                                    style: TextStyle(color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        filter = "";
                                        modeloLoaded = false;
                                        anoLoaded = false;
                                        valorLoaded = false;
                                        selectedMarca = null;
                                        selectedModelo = null;
                                        selectedAno = null;
                                      });
                                    },
                                    icon: Icon(Icons.clear),
                                  ),
                                )
                              : Column(
                                  children: <Widget>[
                                    TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          filter = value.toLowerCase();
                                        });
                                      },
                                      style: TextStyle(fontSize: 15.0),
                                      decoration: InputDecoration(
                                          hintText: "Filtro",
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                          labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                        itemCount: _data.length,
                                        itemBuilder: (ctx, index) {
                                          return filter == null || filter == ""
                                              ? ListTile(
                                                  title: Text(_data[index]['nome']),
                                                  onTap: () async {
                                                    setState(() {
                                                      isLoading = true;
//                                                    filter = "";
                                                      selectedMarca = _data[index];
                                                    });
                                                    await getModelos(_data[index]['codigo']);
                                                    setState(() {
                                                      isLoading = false;
                                                      filter = "";
                                                    });
                                                  },
                                                )
                                              : _data[index]['nome'].toLowerCase().contains(filter)
                                                  ? ListTile(
                                                      title: Text(_data[index]['nome']),
                                                      onTap: () async {
                                                        setState(() {
                                                          isLoading = true;
                                                          selectedMarca = _data[index];
                                                        });
                                                        await getModelos(_data[index]['codigo']);
                                                        setState(() {
                                                          isLoading = false;
                                                          filter = "";
                                                        });
                                                      },
                                                    )
                                                  : new SizedBox();
                                        },
                                      ),
                                    )
                                  ],
                                )
                          : Center(
                              child: Container(
                                height: 32,
                                width: 32,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    ),
                  ),
                  modeloLoaded
                      ? SizedBox(
                          height: 24,
                        )
                      : SizedBox(),
                  modeloLoaded
                      ? AnimatedContainer(
                          height: anoLoaded ? 64 : MediaQuery.of(context).size.height - 270,
                          duration: Duration(milliseconds: 350),
                          child: modeloLoaded
                              ? Card(
                                  elevation: 3.0,
                                  child: anoLoaded
                                      ? ListTile(
                                          title: Text(
                                            selectedModelo['nome'].toString(),
                                            style: TextStyle(color: Colors.grey),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                filter = "";
                                                anoLoaded = false;
                                                valorLoaded = false;
                                                selectedModelo = null;
                                                selectedAno = null;
                                              });
                                            },
                                            icon: Icon(Icons.clear),
                                          ),
                                        )
                                      : Column(
                                          children: <Widget>[
                                            TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  filter = value.toLowerCase();
                                                });
                                              },
                                              style: TextStyle(fontSize: 15.0),
                                              decoration: InputDecoration(
                                                  hintText: "Filtro",
                                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                                  border:
                                                      UnderlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                                  labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: _modelos['modelos'].length,
                                                itemBuilder: (ctx, index) {
                                                  return filter == null || filter == ""
                                                      ? ListTile(
                                                          title: Text(_modelos['modelos'][index]['nome']),
                                                          onTap: () async {
                                                            setState(() {
                                                              isLoading = true;
                                                              selectedModelo = _modelos['modelos'][index];
                                                            });
                                                            await getAnos(selectedMarca['codigo'],
                                                                _modelos['modelos'][index]['codigo'].toString());
                                                            setState(() {
                                                              isLoading = false;
                                                              filter = "";
                                                            });
                                                          },
                                                        )
                                                      : _modelos['modelos'][index]['nome']
                                                              .toLowerCase()
                                                              .contains(filter)
                                                          ? ListTile(
                                                              title: Text(_modelos['modelos'][index]['nome']),
                                                              onTap: () async {
                                                                setState(() {
                                                                  isLoading = true;
                                                                  selectedModelo = _modelos['modelos'][index];
                                                                });
                                                                await getAnos(selectedMarca['codigo'],
                                                                    _modelos['modelos'][index]['codigo'].toString());
                                                                setState(() {
                                                                  isLoading = false;
                                                                  filter = "";
                                                                });
                                                              },
                                                            )
                                                          : new SizedBox();
                                                },
                                              ),
                                            ),
                                          ],
                                        ))
                              : SizedBox(),
                        )
                      : SizedBox(),
                  anoLoaded
                      ? SizedBox(
                          height: 24,
                        )
                      : SizedBox(),
                  anoLoaded
                      ? AnimatedContainer(
                          height: valorLoaded ? 64 : MediaQuery.of(context).size.height - 350,
                          duration: Duration(milliseconds: 350),
                          child: anoLoaded
                              ? Card(
                                  elevation: 3.0,
                                  child: valorLoaded
                                      ? ListTile(
                                          title: Text(
                                            selectedAno['nome'],
                                            style: TextStyle(color: Colors.grey),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                filter = "";
                                                valorLoaded = false;
                                                selectedAno = null;
                                              });
                                            },
                                            icon: Icon(Icons.clear),
                                          ),
                                        )
                                      : Column(
                                          children: <Widget>[
                                            TextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  filter = value.toLowerCase();
                                                });
                                              },
                                              style: TextStyle(fontSize: 15.0),
                                              decoration: InputDecoration(
                                                  hintText: "Filtro",
                                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                                  border:
                                                      UnderlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                                  labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount: _anos.length,
                                                itemBuilder: (ctx, index) {
                                                  return filter == null || filter == ""
                                                      ? ListTile(
                                                          title: Text(_anos[index]['nome'].toString()),
                                                          enabled: valorLoaded ? false : true,
                                                          onTap: () async {
                                                            setState(() {
                                                              isLoading = true;
                                                              selectedAno = _anos[index];
                                                            });
                                                            await getValor(
                                                                selectedMarca['codigo'],
                                                                selectedModelo['codigo'].toString(),
                                                                _anos[index]['codigo'].toString());
                                                            setState(() {
                                                              isLoading = false;
                                                              filter = "";
                                                            });
                                                            print(_anos[index]['codigo']);
                                                          },
                                                        )
                                                      : _anos[index]['nome'].toLowerCase().contains(filter)
                                                          ? ListTile(
                                                              title: Text(_anos[index]['nome'].toString()),
                                                              enabled: valorLoaded ? false : true,
                                                              onTap: () async {
                                                                setState(() {
                                                                  isLoading = true;
                                                                  selectedAno = _anos[index];
                                                                });
                                                                await getValor(
                                                                    selectedMarca['codigo'],
                                                                    selectedModelo['codigo'].toString(),
                                                                    _anos[index]['codigo'].toString());
                                                                setState(() {
                                                                  isLoading = false;
                                                                  filter = "";
                                                                });
                                                                print(_anos[index]['codigo']);
                                                              },
                                                            )
                                                          : new SizedBox();
                                                },
                                              ),
                                            ),
                                          ],
                                        ))
                              : SizedBox(),
                        )
                      : SizedBox(),
                  valorLoaded
                      ? SizedBox(
                          height: 24,
                        )
                      : SizedBox(),
                  valorLoaded
                      ? Card(
                          elevation: 3.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("Marca: ${_valor['Marca'].toString()}"),
                                    ),
                                    ListTile(
                                      title: Text("Modelo: ${_valor['Modelo'].toString()}"),
                                    ),
                                    ListTile(
                                      title: Text("Ano: ${_valor['AnoModelo'].toString()}"),
                                    ),
                                    ListTile(
                                      title: Text("Combustivel: ${_valor['Combustivel'].toString()}"),
                                    ),
                                    ListTile(
                                      title: Text("Mês de referência: ${_valor['MesReferencia'].toString()}"),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        "Valor: ${_valor['Valor'].toString()}",
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Image.network(
                                          "http://via.placeholder.com/200",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              isLoading
                  ? Container(
                      color: Colors.white.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  void changeTipo(String value) {
    print(value);
    setState(() {
      tipo = value;
      selectedModelo = null;
      selectedMarca = null;
      selectedAno = null;
      valorLoaded = false;
      anoLoaded = false;
      modeloLoaded = false;
      isLoaded = false;
      filter = "";
    });
    getMarcas();
  }
}
