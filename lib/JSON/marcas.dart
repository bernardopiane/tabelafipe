// To parse this JSON data, do
//
//     final marcas = marcasFromJson(jsonString);

import 'dart:convert';

class Marcas {
  String nome;
  String codigo;

  Marcas({
    this.nome,
    this.codigo,
  });

  factory Marcas.fromJson(String str) => Marcas.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Marcas.fromMap(Map<String, dynamic> json) => Marcas(
    nome: json["nome"] == null ? null : json["nome"],
    codigo: json["codigo"] == null ? null : json["codigo"],
  );

  Map<String, dynamic> toMap() => {
    "nome": nome == null ? null : nome,
    "codigo": codigo == null ? null : codigo,
  };
}
