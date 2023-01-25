import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order/data/entity/yemek.dart';
import 'package:food_order/ui/cubit/anasayfa_cubit.dart';
import 'package:food_order/ui/screen/sepet.dart';
import 'package:food_order/ui/screen/yemek_detay.dart';


class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
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
        title: Center(child: Text("Yemekler")),


      ),

      body: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
        builder: (context,yemeklerListesi){
          if(yemeklerListesi.isNotEmpty){
            return GridView.builder(


              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                mainAxisSpacing: 15,


              ) ,
              shrinkWrap: true,
              itemCount: yemeklerListesi.length,
              physics: ScrollPhysics(),
              itemBuilder: (context,indeks){

                return Card(
                  color: Colors.green[200],

                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.greenAccent,
                    ),
                    borderRadius: BorderRadius.circular(15.0), //<-- SEE HERE
                  ),

                  child: Container(
                    height: 290,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),

                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 80,
                                height: 110,
                                child: Image.network('http://kasimadalan.pe.hu/yemekler/resimler/'+yemeklerListesi[indeks].yemek_resim_adi), //linkte büyük küçük harf duyarlıydı

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  "${yemeklerListesi[indeks].yemek_adi} ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                              ),


                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text( "Yemek fiyatı: ${yemeklerListesi[indeks].yemek_fiyat} ₺"),
                            ),


                          ],
                        )
                      ],
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
currentIndex: 0,
        selectedFontSize: 16,
        selectedItemColor: Colors.green,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedIconTheme: IconThemeData(color: Colors.green, size: 28),
        unselectedIconTheme: IconThemeData(
          color: Colors.deepOrange,
        ),
        unselectedItemColor: Colors.deepOrangeAccent,
        items: const <BottomNavigationBarItem> [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Anasayfa",

          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: "Yemek Detay"
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
