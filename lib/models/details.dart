import 'package:flutter/foundation.dart';
class Details with ChangeNotifier{
  var firstName; 
  var lastName;
  var workPhone;
  var workEmail;
  var designation;
  var company;

  Details({
    @required this.firstName,
    @required this.lastName,
    @required this.workPhone,
    @required this.workEmail,
    @required this.designation,
    @required this.company
  });
}