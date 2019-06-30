import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:merhaba_dunya/add_contact_page.dart';
import 'package:merhaba_dunya/database/db_helper.dart';
import 'Modal/Contact.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget{

  @override
  _ContactPageState createState()=> _ContactPageState();

}
class _ContactPageState extends State<ContactPage>{
  List<Contact> contacts;
     DbHelper _dbHelper;
     @override
  void initState() {
    contacts = Contact.contacts;
    _dbHelper=new DbHelper();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Contact.contacts.sort((Contact a,Contact b)=>a.name[0].compareTo(b.name[0]));
    Contact.contacts.sort(
      (Contact a, Contact b) => a.name[0].toLowerCase().compareTo(b.name[0].toLowerCase()),
    );
    return Scaffold(
        appBar: AppBar(title: Text("My Contact"),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
           // print(Contact.contacts.length);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddContactPage()));
        },child: Icon(Icons.add),),
        body:
        FutureBuilder(
          future: _dbHelper.getContacts(),
          builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            if(!snapshot.hasData) return CircularProgressIndicator();
            if(snapshot.data.isEmpty) return Text("Listeniz şuan boş."); 
           return ListView.builder(
           itemCount:  snapshot.data.length,
          itemBuilder: (BuildContext context,int index){
                Contact contact = snapshot.data[index];
            return GestureDetector(
              onTap:() {
               Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage(contact: contact,)));

              },
                          child: Dismissible(
                            child: ListTile(
                  leading:CircleAvatar(
                    backgroundImage: AssetImage(
                      contact.avatar.isEmpty ? "assets/logins.png" :contact.avatar,
                      ),
                  child: Text(contact.name[0].toUpperCase(),
                  style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  ) ,
                  title:Text(contact.name) ,
                  subtitle:Text(contact.phone) ,
                  trailing: IconButton(icon: Icon(Icons.phone_in_talk,color: Colors.lightBlue,),onPressed: () async=>_callContact(contact.phone)),
                                  ), key:UniqueKey(),
                                  background: Container(color:Colors.cyan),
                                  onDismissed:(direction) async{
                                      _dbHelper.removeContact(contact.id);
                  
                                    setState(() {});
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('${contact.name} deleted.'),
                                      action: SnackBarAction(
                                        label: "UNDO",
                                        onPressed: () async {
                                          _dbHelper.insertContact(contact);
                                          setState(() {});
                                        },
                                      ),));
                                  },
                                ),
                              );
                             
                          },
                          );
                            },),
                          
                      );
                        
                    }
                  
                  }
                  
                  _callContact(String phone) async {
                    String tel="tel:$phone";
                    if(await canLaunch(tel)){
                      await launch(tel);
                    }
}



