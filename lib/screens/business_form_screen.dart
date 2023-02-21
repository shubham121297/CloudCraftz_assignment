import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import './qrcode_screen.dart';
import '../models/details.dart';

class BusinessFormScreen extends StatefulWidget {
  //const BusinessFormScreen({super.key});

  @override
  State<BusinessFormScreen> createState() => _BusinessFormScreenState();
}

class _BusinessFormScreenState extends State<BusinessFormScreen> {
  final _lastNameFocusNode = FocusNode();
  final _workPhoneFocusNode = FocusNode();
  final _workEmailFocusNode = FocusNode();
  final _designationFocusNode = FocusNode();
  final _companyFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  var cardDetails = Details(
      company: "",
      designation: "",
      firstName: "",
      lastName: "",
      workEmail: "",
      workPhone: 0);

  void dispose() {
    _lastNameFocusNode.dispose();
    _workPhoneFocusNode.dispose();
    _workEmailFocusNode.dispose();
    _designationFocusNode.dispose();
    _companyFocusNode.dispose();
  }

  void _saveForm() {
    final isValid = _formkey.currentState!.validate();
    if (!isValid) return;
    _formkey.currentState!.save();
    _formkey.currentState!.reset();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return QRCodeScreen(cardDetails: cardDetails);
    }));
  }
  // void NavigateToQRCodeScreen(BuildContext context){

  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Color.fromARGB(255, 4, 11, 52),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://www.cloudcraftz.com/wp-content/uploads/2020/12/Cloudcraftz_logo-e1608656227668.png',
                  height: 45,
                  alignment: Alignment.topLeft,
                ),
                // SizedBox(height: 15,),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color.fromARGB(255, 61, 104, 178),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) return "First Name is required.";
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_lastNameFocusNode);
                        },
                        onSaved: (value) {
                          cardDetails.firstName = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Last Name',
                            errorStyle: TextStyle(height: 1),
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color.fromARGB(255, 61, 104, 178),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                        focusNode: _lastNameFocusNode,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) return "Last Name is required.";
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_workPhoneFocusNode);
                        },
                        onSaved: (value) {
                          cardDetails.lastName = value;
                        },
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 20,),
                IntlPhoneField(
                  decoration: InputDecoration(
                      labelText: 'Work Phone',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromARGB(255, 61, 104, 178),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  initialCountryCode: 'IN',
                  textInputAction: TextInputAction.next,
                  focusNode: _workPhoneFocusNode,
                  validator: (value) {
                    if (value.isEmpty)
                      return "Work Phone is required.";
                    else if (double.tryParse(value) == null)
                      return "Please enter a valid phone number.";
                    else if (value.length < 10)
                      return "must be 10 digits long";
                    else
                      return null;
                  },
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_workEmailFocusNode);
                  },
                  onSaved: (value) {
                    cardDetails.workPhone = value.countryCode + value.number;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Work Email',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromARGB(255, 61, 104, 178),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  textInputAction: TextInputAction.next,
                  focusNode: _workEmailFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) return "Work Email is required.";
                    if (!value.contains('@')) return "Email must have @ symbol";
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_designationFocusNode);
                  },
                  onSaved: (value) {
                    cardDetails.workEmail = value;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Designation',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromARGB(255, 61, 104, 178),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  textInputAction: TextInputAction.next,
                  focusNode: _designationFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) return "Designation is required.";
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_companyFocusNode);
                  },
                  onSaved: (value) {
                    cardDetails.designation = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Company',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromARGB(255, 61, 104, 178),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  textInputAction: TextInputAction.next,
                  focusNode: _companyFocusNode,
                  validator: (value) {
                    if (value!.isEmpty) return "Company is required.";
                  },
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  onSaved: (value) {
                    cardDetails.company = value;
                  },
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.more_horiz_outlined),
                ),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    padding: EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // <-- Radius
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
