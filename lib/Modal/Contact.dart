class Contact {
  int id;
  String name;
  String phone;
  String avatar;
    static List<Contact> contacts=[


  ];
  Contact({this.name,this.phone,this.avatar});
  
  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["name"]=name;
    map["phone_number"]=phone;
    map["avatar"]=avatar;
    return map;

  }
  Contact.fromMap(Map<String,dynamic> map){
      id=map["id"];
      name=map["name"];
      phone=map["phone_number"];
      avatar=map["avatar"];
      
  }
}