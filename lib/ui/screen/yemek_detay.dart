import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'dart:core';
import 'package:flutter/foundation.dart';

import 'package:food_order/ui/cubit/anasayfa_cubit.dart';


import 'package:food_order/ui/cubit/yemek_detay_cubit.dart';
import 'package:food_order/ui/screen/anasayfa.dart';
import 'package:food_order/ui/screen/sepet.dart';


import '../../data/entity/yemek.dart';



class YemekDetay extends StatefulWidget {
  const YemekDetay({Key? key}) : super(key: key);


  @override
  State<YemekDetay> createState() => _YemekDetayState();
}

class _YemekDetayState extends State<YemekDetay> {

  int simpleInput = 0;
  int selectedIndex=0;

  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemeklisteGetir();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.red[500],
        title: Center(
            child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("Yemekler Detay"),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>Sepet()));
                  print("Sepet sayfasına geçildi");

                }, icon: Icon(Icons.shopping_basket))
              ],

            ),




        ),


      ),
      body: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
        builder: (context,yemeklerListesi){
          if(yemeklerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: yemeklerListesi.length,//3
              itemBuilder: (context,indeks){//0,1,2
                var yemek = yemeklerListesi[indeks];
                return GestureDetector(
                  onTap: (){

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(

                   color: Colors.green[500],

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
             child: Image.network('http://kasimadalan.pe.hu/yemekler/resimler/${yemeklerListesi[indeks].yemek_resim_adi}') //linkte büyük küçük harf duyarlıydı

                     ),
                    ),
                     ],),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all( 4.0),
                                child: Text( " ${yemeklerListesi[indeks].yemek_adi} ", style: TextStyle(fontWeight: FontWeight.bold),),
                              ),

                              Padding(
                                padding: const EdgeInsets.all( 4.0),
                                child: Text( "Fiyat : ${yemeklerListesi[indeks].yemek_fiyat} ₺"),
                              ),

                              Padding(
                                padding: const EdgeInsets.all( 4.0),
                                child: Text( "Adet : ${simpleInput} adet"),
                              ),

                              Padding(
                                padding: const EdgeInsets.all( 4.0),
                                child: Text( "Fiyat : ${yemeklerListesi[indeks].yemek_fiyat} ₺"),
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

                             simpleInput --;

                           });

                                 },
                                       child: Text("-", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                      //child: new Icon(const IconData(0xe15b, fontFamily: 'MaterialIcons'), color: Colors.black),
                                       backgroundColor: Colors.black12),




                                 ),

                                 ),

                          Text(
                            '$simpleInput',style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),

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




                            Row(
                              children: [
                                TextButton.icon(onPressed: (){

                                  context.read<YemekDetayCubit>().yemekEkle(
                                      yemek.yemek_adi,
                                      yemek.yemek_resim_adi,
                                      yemek.yemek_fiyat,
                                      simpleInput,
                                      "asiye_yildirim" //veri kayıt ediliyor
                                  );



                                },


                                  icon:   Icon(Icons.shopping_basket),
                                    label: Text("Sepet"), style: TextButton.styleFrom(backgroundColor: Colors.green[600], foregroundColor: Colors.black),)
                              ],
                            ),





                        ],
                      ),






                    ),
                  ),

                );
              },


            );


          }
          else{
            return const Center();
          }
        },



      ),






      bottomNavigationBar: BottomNavigationBar(

        onTap: (index) {
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
            currentIndex: 1,
        selectedFontSize: 16,
        selectedItemColor: Colors.green,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme: IconThemeData(color: Colors.deepOrange,),
        unselectedItemColor: Colors.deepOrangeAccent,
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

