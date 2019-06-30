import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:merhaba_dunya/Modal/Contact.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merhaba_dunya/database/db_helper.dart';


class AddContactPage extends StatelessWidget{
    final Contact contact;

      const AddContactPage({Key key, @required this.contact}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(contact.id == null ? "Add New Contact" : contact.name),),
      body: SingleChildScrollView(
        child: ContactForm(contact: contact, child: addContactState())
      )
    );
  } 

}
class ContactForm extends InheritedWidget {
  final Contact contact;

  ContactForm({Key key, @required Widget child, @required this.contact}) : super(key: key, child: child);

  static ContactForm of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ContactForm);
  }

  @override
  bool updateShouldNotify(ContactForm oldWidget) {
    return contact.id != oldWidget.contact.id;
  }
}

class addContactState extends StatefulWidget {
  @override
  _addContactStateState createState() => _addContactStateState();
}

class _addContactStateState extends State<addContactState> {
  final _formKey=GlobalKey<FormState>();
  File _file;
        DbHelper dbHelper;


  @override
  void initState() {
    dbHelper=DbHelper();
     super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
       Contact contact = ContactForm.of(context).contact;

    return Column(
      children: <Widget>[
        Stack(children:[
          Image.asset(
            contact.avatar ==null ? "assets/rehber.jpg":contact.avatar,
            fit: BoxFit.fill,
            width: double.infinity,
            ),
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              onPressed: getFile,
                            icon: Icon(Icons.camera_alt),
                            color: Colors.white,
                            ))
                      ]), 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Contact name",),
                                   initialValue: contact.name,
                                    validator: (value){
                                      if(value.isEmpty){
                                        return "Name required";
                                      }
                                    },
                                  onSaved: (value){
                                    contact.name=value;
                                  },
                                ),
                              ),
                              Padding(
              
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Phone number",),
                                    initialValue: contact.phone,

                                     validator: (value){
                                      if(value.isEmpty){
                                        return "Password required";
                                      }
                                    },
                                  keyboardType: TextInputType.phone,
                                   onSaved: (value){
                                    contact.phone=value;
                                  },
                                ),
                                
                              ),
                              RaisedButton(color:Colors.blue,textColor:Colors.white,child:Text("Submit"),onPressed: () async{
                                if(_formKey.currentState.validate()){
                                  _formKey.currentState.save();

                                   if (contact.id == null) {
                                      await dbHelper.insertContact(contact);
                                    } else {
                                      await dbHelper.updateContact(contact);
                                    }

                                 
                                  var snackbar=Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(milliseconds:500),
                                    content: Text("${contact.name} add the succesfull."),
                                  ));
                                  snackbar.closed.then((onValue){
                                        Navigator.pop(context);
              
                                  });
              
                                }
                              },)
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              
                void getFile() async {
                      Contact contact = ContactForm.of(context).contact;

                  var image= await ImagePicker.pickImage(source: ImageSource.camera);
                  setState(() {
                    contact.avatar = image.path;
                  });
  }
}
