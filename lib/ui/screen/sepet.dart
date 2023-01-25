
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_order/data/entity/sepet_yemek.dart';

import 'package:food_order/ui/cubit/sepet_cubit.dart';

import 'dart:core';

import 'package:food_order/ui/screen/anasayfa.dart';
import 'package:food_order/ui/screen/yemek_detay.dart';


class Sepet extends StatefulWidget {
  const Sepet({Key? key}) : super(key: key);

  @override
  State<Sepet> createState() => _SepetState();
}

class _SepetState extends State<Sepet> {

int selectedIndex=0;
  void initState() {
    super.initState();
    context.read<SepetCubit>().ara('asiye_yildirim');


  }


  int simpleInput = 0;
  bool aramaYapiliyorMu = false;
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red[500],
        title: aramaYapiliyorMu ?
        TextField(decoration: const InputDecoration(hintText: "Ara"),onChanged: (aramaSonucu){
          context.read<SepetCubit>().ara(aramaSonucu);
        },) :
        Padding(
          padding: const EdgeInsets.only(left:110.0),
          child: Text("Sepet",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),

        ),



      body: BlocBuilder<SepetCubit,List<Sepet_Yemekler>>(
        builder: (context,sepet_yemeklerListesi){
          if(sepet_yemeklerListesi.isNotEmpty){
            return ListView.builder(

              itemCount: sepet_yemeklerListesi.length,//3
              itemBuilder: (context,indeks){//0,1,2
                var sepet_yemek = sepet_yemeklerListesi[indeks];
                return GestureDetector(
                  onTap: (){

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(

                      color: Colors.green[300],

                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.greenAccent,
                        ),
                        borderRadius: BorderRadius.circular(15.0), //<-- SEE HERE
                      ),
                      child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,  //!!!!!ana tasarım!!!!!!





                        children: [

                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: SizedBox(
                                    width: 60,
                                    height: 110,
                                    child: Image.network('http://kasimadalan.pe.hu/yemekler/resimler/${sepet_yemeklerListesi[indeks].yemek_resim_adi}') //linkte büyük küçük harf duyarlıydı

                                ),
                              ),
                            ],),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all( 4.0),
                                child: Text( " ${sepet_yemeklerListesi[indeks].yemek_adi} ", style: TextStyle(fontWeight: FontWeight.bold),),
                              ),

                              Padding(
                                padding: const EdgeInsets.all( 4.0),
                                child: Text( "Fiyat : ${sepet_yemeklerListesi[indeks].yemek_fiyat} ₺"),
                              ),

                              Padding(
                                padding: const EdgeInsets.all( 4.0),
                                child: Text( "Adet: ${sepet_yemeklerListesi[indeks].yemek_siparis_adet}"),
                              ),

                              Padding(
                                padding: const EdgeInsets.all( 4.0),
                                child: Text( " ${sepet_yemeklerListesi[indeks].kullanici_adi} ", style: TextStyle(fontWeight: FontWeight.bold),),
                              ),


                            ],
                          ),

                          SizedBox(
                            height: 25,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child:FloatingActionButton(
                                  onPressed: () {
                                    setState(() {

                                      simpleInput--;

                                    });

                                  },
                                  child: Text("-", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  //child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
                                  backgroundColor: Colors.black12),




                            ),

                          ),

                          Text(
                            " ${sepet_yemeklerListesi[indeks].yemek_siparis_adet}",style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),

                          ),



                          SizedBox(
                            height: 25,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {

                                      simpleInput ++;

                                    });
                                  },
                                  child: Text("+", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  backgroundColor: Colors.black12),
                            ),
                          ),


                          IconButton(onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${sepet_yemek.yemek_adi}, silinsin mi?"),
                                action: SnackBarAction(
                                  label: "Evet",
                                  onPressed: (){
                                    context.read<SepetCubit>().sil(int.parse(sepet_yemek.sepet_yemek_id),sepet_yemek.kullanici_adi);

                                  },
                                ),
                              ),
                            );
                          }, icon: const Icon(Icons.delete_outline,color: Colors.black54,)),

                        ],
                      ),

                    ),
                  ),


                );
              },


            );
          }
          else{


            return  Center(



            child: Column(mainAxisAlignment: MainAxisAlignment.center,

              children: [


                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Sepetiniz boş gözüküyor"),
                ),

              ElevatedButton.icon(
                  icon: Icon(Icons.shopping_basket_outlined),

                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>YemekDetay()));
                    print("Yemek Detay Sayfaya geçildi");

                  }, label: Text("Sepete bir şeyler ekle", style: TextStyle(fontSize: 16),),style: ElevatedButton.styleFrom(backgroundColor: Colors.red[500], ),
              ),



              ],
            ),
            );
          }
        },


      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: 2,
        selectedFontSize: 16,
        selectedItemColor: Colors.green,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme: IconThemeData(color: Colors.deepOrange,),
        unselectedItemColor: Colors.deepOrangeAccent,


        onTap: (int index) {
          setState(() {
            selectedIndex= index;

          });

          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder:(context)=>Anasayfa()));
            print("Anasayfaya geçildi");
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder:(context)=>YemekDetay()));
            print("Yemek Detay Sayfaya geçildi");
          } else if (index == 2) {
             Navigator.push(context, MaterialPageRoute(builder:(context)=>Sepet()));
            print("Sepet sayfasına geçildi");
          }
        },

        items: const <BottomNavigationBarItem> [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Anasayfa",

          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: "Yemek Detay",

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_rounded),
              label: "Sepet Görüntüle"
          )
        ],
      ),
    );
  }
}
