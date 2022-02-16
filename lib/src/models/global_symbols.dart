import 'dart:convert';

class GlobalSymbols {
  GlobalSymbols({
    this.global,
    this.success,
  });

  final Global? global;
  final bool? success;

  factory GlobalSymbols.fromRawJson(String str) =>
      GlobalSymbols.fromJson(json.decode(str));

  factory GlobalSymbols.fromJson(Map<String, dynamic> json) => GlobalSymbols(
        global: Global.fromJson(json["global"]),
        success: json["success"],
      );
}

class Global {
  Global({
    this.symbols,
  });

  final List<String>? symbols;

  factory Global.fromRawJson(String str) => Global.fromJson(json.decode(str));

  factory Global.fromJson(Map<String, dynamic> json) => Global(
        symbols: List<String>.from(json["symbols"].map((x) => x)),
      );
}
