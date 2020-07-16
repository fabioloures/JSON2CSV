import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json2csv/table.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';


class TelaPrincipal extends StatefulWidget {


  // Passando dados entre telas
  String descricao;   // cidade digitada CENTRAL.CODIGO
  String slump1; // traço : NORMAL / ESPECIAL
  List<String> slump2;

  TelaPrincipal( {this.descricao,this.slump1,this.slump2} );  // {}  opcional
  // Passando dados entre telas


  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

   final _DescricaoController = TextEditingController();  // JSON
  String DescricaoDigitada = null;

  final Slump1Controller = TextEditingController(); // CVS
  String SumpDigitado1 = null;

  String slump2d = "";


  //função que irá apagar o texto de todos os campos:
  void _clearAll(){
    _DescricaoController.text = "";
    Slump1Controller.text = "";
  }

  void _converteCSV(){

    var string = _DescricaoController.text;


    string = string.replaceAll('},', '#');
    string = string.replaceAll('{', '');
    string = string.replaceAll('}', '#');

      string = string.replaceAll('[', '');
      string = string.replaceAll(']', '');




      string = string.replaceAll('":', ':');//string = string.replaceAll('":', ',');
      string =  string.replaceAll('": ', ':');//string =  string.replaceAll('": ', ',');
      string = string.replaceAll('" :', ':'); //string = string.replaceAll('" :', ',');

      string = string.replaceAll('",', ',');
      string = string.replaceAll('",', ',');

      string = string.replaceAll('",', ',');
      string = string.replaceAll('", ', ',');
      string = string.replaceAll(' ", ', ',');

      string = string.replaceAll('"', '');

      string = string.replaceAll('"', '');

      Slump1Controller.text = string.replaceAll('#', '\n');

      SumpDigitado1 = string;

       List<String> listArray=new List();
      listArray = SumpDigitado1.split('#');
      for (int i = 0; i < listArray.length-1; i++) {
        print("listArray:"+listArray[i] );
      }

      List<String> slump2d = listArray;
      for (int i = 0; i < slump2d.length-1; i++) {
        print("slump2d:"+slump2d[i] );
      }

   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Conversor JSON para CSV"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[

              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _DescricaoController,
                decoration: InputDecoration(labelText: "Cole o código JSON abaixo"),
                onChanged: (text){
                  setState(() {
                    DescricaoDigitada = text;
                    print("JSON digitado: "+DescricaoDigitada);
                  });
                },
              ),


              RaisedButton(
                onPressed: () {
                  if(_DescricaoController.text.contains('{') && _DescricaoController.text.contains('}') ){
                    print("contem barras de json"+_DescricaoController.text);
                  }

                  if(_DescricaoController.text=='null' || _DescricaoController.text=='') {
                    infJsonpreenchido(context);
                  }else if ( _DescricaoController.text.contains('{') && _DescricaoController.text.contains('}')   ) {
                    _converteCSV();
                  }else {
                    infJsonforapadrao(context);
                  }
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'Converter para CSV',
                      style: TextStyle(fontSize: 15)
                  ),
                ),
              ),


              RaisedButton(
                onPressed: () {
                  _clearAll();
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'Limpar campos',
                      style: TextStyle(fontSize: 15)
                  ),
                ),
              ),



              //espaço
              Padding(
                padding: EdgeInsets.only(top: 1),
                child: Text(
                    ""
                ),
              ),



              TextField(
                //maxLength: 10,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: Slump1Controller,
                decoration: InputDecoration(labelText: "CSV"),
                onChanged: (text){
                  setState(() {
                    SumpDigitado1  = text;
                    print("Texto CSV transformado: "+SumpDigitado1);
                    //_editedContact.name = text;
                  });
                },
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode()); // desabilita edição desse campo
                },
              ),



              RaisedButton(
                onPressed: () {

                  if( Slump1Controller.text=='null' || Slump1Controller.text=='') {
                    infCSVnpreenchido(context);
                  }else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                WidgetTable(descricao: DescricaoDigitada,
                                    slump1: SumpDigitado1,
                                    slump2: slump2d)
                        )
                    );
                  }

                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'Ver tabela',
                      style: TextStyle(fontSize: 15)
                  ),
                ),
              ),


              RaisedButton(
                onPressed: () {
                  _clearAll();
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'Limpar campos',
                      style: TextStyle(fontSize: 15)
                  ),
                ),
              )



            ],
          ),
        ),
      ),
    );
  }

  // Tela com a informação de campo em branco
  infJsonpreenchido(context) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Campo JSON em branco",
      desc: "Deve Colar em formato JSON.\nAtençao: tem  que ser jSON nao aninhados!",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  // Tela com a informação de campo em branco
  infCSVnpreenchido(context) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Campo CSV em branco",
      desc: "Campo CSV em branco.\nAtençao: Deve Colar UM formato JSON valido e clicar em CONVERTER!",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }


// Tela com a informação de campo json fora do padrao
  infJsonforapadrao(context) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Campo JSON não válido",
      desc: "Deve Colar em formato JSON.\nAtençao: tem  que ser jSON nao aninhados!",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }


}
