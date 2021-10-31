import 'dart:math';
import 'package:flutter/material.dart';
import 'package:last_test/models/lanuage_model.dart';
import 'package:last_test/utils/connection_manager.dart';
class TranslatePage extends StatefulWidget {
  List<Language> languages;
  TranslatePage({required this.languages });
  @override
  _TranslatePageState createState() => _TranslatePageState();
}
class _TranslatePageState extends State<TranslatePage> {
  final formKey = GlobalKey<FormState>();
  var value;
  TextEditingController textController = TextEditingController();
  bool validate(){if (formKey.currentState!.validate() ) { return true; } else { return false;}}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value){ if (value!.isEmpty) {return"This field is required";} else { return null;}},
                  controller: textController,
                  decoration:
                  const InputDecoration(
                    hintText: "input text",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),),
                ),
              ),
              const SizedBox(height: 22,),
              DropdownButton(
                hint: const Text("select language"),
                value: value,
                onChanged: (val){
                  //print("$val");
                  setState(() {value=val;});
                  },
                //The argument type 'void Function()' can't be assigned to the parameter type 'void Function(Object?)?'.
                //  - 'Object' is from 'dart:core'.
                //                 onChanged: (){},
                items: widget.languages.map((item) {
                  return DropdownMenuItem(
                      child: Text(item.language),
                      value: item.language.toString(),//without write this line it give an error failed assertion item == null
                  );
                }).toList(),
            // items:widget.languages.map((e) => DropdownMenuItem(child: Container( child: Text(e.language),),)).toList(),
           ),
              const SizedBox(height: 22,),
              MaterialButton(
                color: Colors.blue,
                onPressed:(){
                  if (validate()){postToServer(textController.text.toString(),value);}
                  //print (textController.text.toString());
                  //print(value);
                  } ,
                child:const Text("Translate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
