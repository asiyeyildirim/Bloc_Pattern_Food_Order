
import 'package:dio/dio.dart';
import 'package:food_order/data/entity/sepet_yemek.dart';
import 'package:food_order/data/entity/yemek.dart';
import 'package:food_order/data/entity/yemekler_cevap.dart';
import 'dart:convert';




class YemeklerRepository{


  List<Yemekler> parseYemeklerCevap(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;

  }


  List<Sepet_Yemekler> parseSepetYemeklerCevap(String cevap){

    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;

  }


  Future<List<Yemekler>> yemeklisteGetir() async{
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await Dio().getUri(url);
    return parseYemeklerCevap(cevap.data.toString());
  }



  Future<List<Sepet_Yemekler>> sepetyemekGetir() async{
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumSepettekiYemekleriGetir.php");
    var cevap = await Dio().getUri(url);
    return parseSepetYemeklerCevap(cevap.data.toString());
  }





  //sepete yemek ekleme


  Future<void> yemekEkle(String yemek_adi,String yemek_resim_adi, String yemek_fiyat, int yemek_siparis_adet,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {

       "yemek_adi" :yemek_adi,
       "yemek_resim_adi" :yemek_resim_adi,
       "yemek_fiyat" :yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adet,
      "kullanici_adi":kullanici_adi
    };

    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Yemek ekle: ${cevap.data.toString()}");

  }

  Future<List<Sepet_Yemekler>> ara(String aramaKelimesi) async {


    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi":aramaKelimesi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    return parseSepetYemeklerCevap(cevap.data.toString());
  }


  Future<void> sil(int sepet_yemek_id,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id": sepet_yemek_id,
                  "kullanici_adi": kullanici_adi

    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Yemek sil: ${cevap.data.toString()}");
  }



}