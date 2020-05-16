import 'package:flutter/material.dart';

class Most extends StatelessWidget {

  List<Etkinlik> etkinlikler=[];

  @override
  Widget build(BuildContext context) {

    etkinlikVerileriniGetir();

    return ListView.separated(
        separatorBuilder: (context, index) {

          if(index % 10 == 0 && index != 0){
            return Container(
              height: 2, color: Colors.blue, margin: EdgeInsets.all(30),
            );
          }else{
            return Container(

            );
          }

        } ,
        itemCount: 30,
        //itemBuilder: (context, index) => Card(),
        itemBuilder: (context, index){
          return Card(
            color:  Colors.blueGrey,
            elevation: 1,
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.perm_contact_calendar),
              title: Text(etkinlikler[index]._isim),
              subtitle: Text(etkinlikler[index]._aciklama),
              trailing: Icon(Icons.favorite),
            ),
          );
        }
    );
  }

  void etkinlikVerileriniGetir(){
    etkinlikler=List.generate(300, (index)=>Etkinlik("Etkinlik $index Adı", "Etkinlik Linki"));
  }

}

class Etkinlik{
  String _isim;
  String _aciklama;

  Etkinlik(this._isim, this._aciklama);
}


