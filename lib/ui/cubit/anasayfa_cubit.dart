import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order/data/entity/yemek.dart';
import 'package:food_order/data/repo/yemekler_repo.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{
  AnasayfaCubit() : super(<Yemekler>[]);

  var yrepo =YemeklerRepository();

  Future<void> yemeklisteGetir() async {
    var liste = await yrepo.yemeklisteGetir();
    emit(liste);
  }


}