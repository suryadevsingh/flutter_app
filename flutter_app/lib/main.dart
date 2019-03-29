 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
 {
   runApp(
     MaterialApp(
       debugShowCheckedModeBanner: false,
       title:"simple interest calculator app",
       home: SIForm(),
       theme: ThemeData(
         primaryColor: Colors.deepPurple,
         accentColor: Colors.pinkAccent,
         brightness: Brightness.dark,
       ),
        )
   );
 }
 class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
 }
 class _SIFormState extends State<SIForm>{
  var _formKey =GlobalKey<FormState>();
  var _currencies =["rupees","dollars","pounds"];
  final _miniumPadding = 5.0;
  var _currentItemSelected ="";
  void initState(){
    super.initState();
    _currentItemSelected =_currencies[0];
  }
  TextEditingController principalController =TextEditingController();
  TextEditingController roiController =TextEditingController();
  TextEditingController termController =TextEditingController();
  var displayResult ="";
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
     // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("SIMPLE INTEREST CALCULATOR"),
      ),
      body: Form(
        key: _formKey,
        child:Padding(
          padding:EdgeInsets.all(_miniumPadding * 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
         Padding(padding: EdgeInsets.only(top:_miniumPadding,bottom: _miniumPadding),
             child:TextFormField(
            keyboardType: TextInputType.number,
            style: textStyle,
            controller: principalController,
            validator: (String value){
              if (value.isEmpty){
                return "please enter prinicipal amount";
              }
            },
            decoration: InputDecoration(
                labelText:"principal",
                hintText: "enter principal e.g 12000",
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  color: Colors.tealAccent,
                      fontSize: 15.0
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
            ),
          )),
          Padding(
              padding: EdgeInsets.only(top: _miniumPadding,bottom: _miniumPadding),
              child:TextFormField(
            keyboardType: TextInputType.number,
            style: textStyle,
            controller: roiController ,
            validator: (String  value){
              return "please enter rate of inerest";
            },
            decoration: InputDecoration(
                labelText:"rate of interest",
                hintText: "in percent",
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 15.0
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                )
            ),
          )),
            Padding(
              padding: EdgeInsets.only(top: _miniumPadding,bottom: _miniumPadding),
              child:Row(
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: termController,
                validator: (String value ){
                  if (value.isEmpty){
                    return "please enter time";
                  }
                },
                decoration: InputDecoration(
                    labelText:"term",
                    hintText: "time in years",
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.tealAccent,
                      fontSize: 15.0
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0) 
                    )
                ),
              )
                ),
              Container(width: _miniumPadding * 5),
              Expanded(child:DropdownButton<String>(
                items: _currencies.map((String value){
                  return DropdownMenuItem<String>
                    (
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _currentItemSelected,
                onChanged: (String newValueSelected){
               _onDropDownItemSelected(newValueSelected);
                },
              ))

              ],
            )),
         Padding(
           padding: EdgeInsets.only(bottom: _miniumPadding, top: _miniumPadding),
             child: Row(children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColorDark,
                child: Text("Calculate",textScaleFactor: 1.5,),
                onPressed: (){
                  setState(() {
                    if (_formKey.currentState.validate()) {
                      this.displayResult = _calculateTotalReturns();
                    }
                  });
                },
              ),
            ),
            Expanded(
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text("Reset",textScaleFactor: 1.5,),
                onPressed: (){
                  setState(() {
                    _reset();
                  });
                },
              ),
            ),
          ],
         )),
            Padding(
              padding: EdgeInsets.all(_miniumPadding * 2),
              child: Text(this.displayResult,style: textStyle,),
            )
          ],
        )),
      ),
    );
  }
Widget getImageAsset(){
    AssetImage assetImage = AssetImage("images/bank.png");
    Image image = Image(image: assetImage,width: 125.0,height: 125.0,);
    return Container(child: image,margin: EdgeInsets.all(_miniumPadding * 10),);
}
void _onDropDownItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
}
String _calculateTotalReturns(){
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term =double.parse(termController.text);
    double totalAmountPayble =principal +(principal * roi * term)/100;
    String result ="after $term years, your investment will be worth $totalAmountPayble $_currentItemSelected";
return result;
  }
  void _reset(){
    principalController.text="";
    roiController.text="";
    termController.text="";
    displayResult="";
    _currentItemSelected = _currencies[0];
  }
 }