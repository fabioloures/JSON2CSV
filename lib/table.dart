import 'package:flutter/material.dart';

class WidgetTable extends StatefulWidget {

  String descricao;
  String slump1;
  String slump2;

  WidgetTable( {this.descricao , this.slump1, this.slump2} );  // {}  opcional


  @override
  _WidgetTableState createState() => _WidgetTableState();
}


class _WidgetTableState extends State<WidgetTable> {

  @override
  void initState() {
    super.initState();

    print("temp DESCRIÇÃO build pagina table: ${widget.descricao} ");
    print("temp slump1 build pagina table: ${widget.slump1} ");

    List<String> listArrayteste=new List();
    listArrayteste = "${widget.slump1}".split('#');
    for (int i = 0; i < listArrayteste.length-1; i++) {
      print("listArrayteste teste:"+listArrayteste[i] );
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabela->Resultado"),
        backgroundColor: Colors.blue,
      ),

      body: criaTabela(),



    );
  }


  criaTabela() {

    List<String> listArrayfinal=new List();
    listArrayfinal = "${widget.slump1}".split('#');
    for (int i = 0; i < listArrayfinal.length-1; i++) {
      print("listArrayfinal teste:"+listArrayfinal[i] );
    }
    return ListView.builder(
      itemCount: listArrayfinal.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(listArrayfinal[index]),

        );
      },
    );

  }




}