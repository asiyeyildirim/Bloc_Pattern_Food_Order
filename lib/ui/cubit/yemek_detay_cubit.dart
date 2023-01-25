import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order/data/repo/yemekler_repo.dart';

class YemekDetayCubit extends Cubit <void>{
  YemekDetayCubit():super(0);
  var yrepo=YemeklerRepository();


  Future<void> yemekEkle (String yemek_adi,String yemek_resim_adi, String yemek_fiyat, int yemek_siparis_adet,String kullanici_adi) async {
    await yrepo.yemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }

}

