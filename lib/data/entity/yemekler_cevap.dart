import 'package:food_order/data/entity/sepet_yemek.dart';
import 'package:food_order/data/entity/yemek.dart';


//Sepet ve Yemekler Cevap içerir

class YemeklerCevap{

  List<Yemekler> yemekler;
  int success;

  YemeklerCevap({required this.yemekler, required this.success});


  factory YemeklerCevap.fromJson(Map<String, dynamic> json){
    var jsonArray = json["yemekler"] as List;
    var yemekler = jsonArray.map((jsonArrayNesnesi) => Yemekler.fromJson(jsonArrayNesnesi)).toList();

    return YemeklerCevap(
        yemekler: yemekler,
        success: json["success"] as int
    );
  }

}

class SepetYemeklerCevap{

  List<Sepet_Yemekler> sepet_yemekler;
  int success;


  SepetYemeklerCevap({required this.sepet_yemekler, required this.success});


  factory SepetYemeklerCevap.fromJson(Map<String, dynamic> json){
    var jsonArray = json["sepet_yemekler"] as List;
    var sepet_yemekler = jsonArray.map((jsonArrayNesnesi) => Sepet_Yemekler.fromJson(jsonArrayNesnesi)).toList();

    return SepetYemeklerCevap(
        sepet_yemekler: sepet_yemekler,
        success: json["success"] as int,

    );
  }

}
