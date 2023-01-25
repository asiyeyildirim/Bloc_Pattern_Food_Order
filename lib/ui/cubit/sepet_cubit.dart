import 'package:food_order/data/entity/sepet_yemek.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_order/data/repo/yemekler_repo.dart';


class SepetCubit extends Cubit<List<Sepet_Yemekler>>{
  SepetCubit() : super(<Sepet_Yemekler>[]);

  var yrepo =YemeklerRepository();



  Future<void> ara(String aramaKelimesi) async {
    var liste = await yrepo.ara(aramaKelimesi);
    emit(liste);

  }

  Future<void> sil(int sepet_yemek_id, String kullanici_adi) async {
    await yrepo.sil(sepet_yemek_id, kullanici_adi);
    await ara('asiye_yildirim'); //arayüzü günceller son hali için

  }

}