import 'package:carigari_admin/Arrangements/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carigari_admin/Arrangements/variables.dart' as global;

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  final GlobalKey<FormState> _contactFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController aInput;
  TextEditingController imageInput;
  TextEditingController priceInput;
  @override
  initState() {
    aInput = new TextEditingController();
    imageInput = new TextEditingController();
    priceInput = new TextEditingController();
  }

  //  void callSnackBar(String msg,[int er])
  // {

  //     // msg="There is no record with this user, please register first by clicking Register";
  //     final SnackBar=new SnackBar(
  //     content: new Text(msg),
  //     duration: new Duration(seconds: 3),
  //   //   action: new SnackBarAction(label: "Register",
  //   //   onPressed: (){
  //   //     Navigator.pushNamed(context, "Register");
  //   //   },),
  //   );
  //    _scaffoldKey.currentState.showSnackBar(SnackBar);
  //   }

  void callSnackBar(String msg) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return new Scaffold(
        key: _scaffoldKey,
        drawer: theDrawer(context),
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Details Of The Product"),
          backgroundColor: Colors.orangeAccent,
        ),
        // key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: WillPopScope(
            onWillPop: () {
              Navigator.pushNamed(context, "InterfaceHomeScreen");
            },
            child: SizedBox(
              child: Form(
                key: _contactFormKey,
                child: ListView(
                  children: <Widget>[
                    // Text("\n\n"),
                    Padding(
                      padding: EdgeInsets.only(
                        top:5.0,
                        //  SizeConfig.blockSizeVertical * 1.5,
                        bottom: 5.0,
                        // SizeConfig.blockSizeVertical * 1.5
                      ),
                      child: TextFormField(
                        controller: aInput,
                        validator: nameValidator,
                        style: textStyle,
                        // keyboardType: Text(),
                        decoration: InputDecoration(
                            labelStyle: textStyle,
                            labelText: "Crop",
                            hintText: " Name of the product/crop to be displayed",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(500.0
                                    // SizeConfig.blockSizeVertical*1.5
                                    ))),
                      ),
                    ),
                      Padding(
                      padding: EdgeInsets.only(
                        top:5.0,
                        //  SizeConfig.blockSizeVertical * 1.5,
                        bottom: 5.0,
                        // SizeConfig.blockSizeVertical * 1.5
                      ),
                      child: TextFormField(
                        // controller: aInput,
                        validator: nameValidator,
                        style: textStyle,
                        // keyboardType: Text(),
                        decoration: InputDecoration(
                            labelStyle: textStyle,
                            labelText: "Name",
                            hintText: " Farmer's Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(500.0
                                    // SizeConfig.blockSizeVertical*1.5
                                    ))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        //  SizeConfig.blockSizeVertical * 1.5,
                        bottom: 10.0,
                        // SizeConfig.blockSizeVertical * 1.5
                      ),
                      child: TextFormField(
                        controller: imageInput,
                        // validator: linkValidator,
                        style: textStyle,
                        // keyboardType: Text(),
                        decoration: InputDecoration(
                            labelStyle: textStyle,
                            labelText: "Image Link (Optional)",
                            hintText: " Paste image URL",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(500.0
                                    // SizeConfig.blockSizeVertical*1.5
                                    ))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0
                          // top: SizeConfig.blockSizeVertical*1.5,bottom:SizeConfig.blockSizeVertical*1.5
                          ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: priceInput,
                        style: textStyle,
                        maxLength: 7,
                        validator: phoneValidator,
                        decoration: InputDecoration(
                            labelStyle: textStyle,
                            labelText: "Price ₹",
                            hintText: "Enter Price in ₹ per Quintal",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(500.0
                                    // SizeConfig.blockSizeVertical*1.5
                                    ))),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0
                          // top: SizeConfig.blockSizeVertical*1.5,bottom:SizeConfig.blockSizeVertical*1.5
                          ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        // controller: priceInput,
                        style: textStyle,
                        maxLength: 10,
                        validator: phoneValidator,
                        decoration: InputDecoration(
                            labelStyle: textStyle,
                            labelText: "Mobile",
                            hintText: "Enter Mobile Number (+91)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(500.0
                                    // SizeConfig.blockSizeVertical*1.5
                                    ))),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Center(
                            child: FlatButton(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      // backgroundColor: Colors.blueAccent,
                                      fontSize: 40),
                                ),

                                color: Colors.lightGreen,
                                onPressed: () async {
                                  print("jhg");
                                  if (_contactFormKey.currentState.validate()) {
                                    //  callSnackBar("Submitting !!!");

                                    callSnackBar("Uploading Please wait");
                                    Firestore.instance
                                        .collection('farmers')
                                        .document(aInput.text)
                                        .setData({
                                          "name": aInput.text,
                                          // "uid": currentUser.uid,
                                          "image": imageInput.text,
                                          "price": priceInput.text,
                                        })
                                        .then((result) => {
                                              callSnackBar("Uploaded!!!"),
                                              Navigator.pushNamed(
                                                  context, "InterfaceHomeScreen"),
                                              aInput.clear(),
                                              imageInput.clear(),
                                              priceInput.clear(),
                                            })
                                        .catchError((err) => print(
                                            "Something went wrong!!please check internet Connectivity"));
                                  } else {
                                    callSnackBar(
                                        "Please Enter the details properly");
                                  }
                                })))
                  ],
                ),
              ),
            )));
  }

  String nameValidator(String value) {
    if (value.length < 3) {
      return "please fill this field with atleast 3 characters";
    } else {
      return null;
    }
  }

  String phoneValidator(String value) {
    if (value.length == 0) {
      return 'Phone Number must be of 1 digits';
    } else {
      return null;
    }
  }

  String linkValidator(String value) {
    if (value.length == 0) {
      return 'It must be a Link';
    } else {
      return null;
    }
  }
}
