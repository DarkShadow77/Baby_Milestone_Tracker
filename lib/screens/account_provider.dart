
import 'package:babylid/main.dart';
import 'package:babylid/models/account.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _name;
  DateTime? _dob;
  int? _gender;
  int? _relationship;

  String? get name => _name;

  DateTime? get dob => _dob;

  int? get gender => _gender;

  int? get relationship => _relationship;

  Future<void> saveData() async {
    prefs.setString('name', _name);
    prefs.setString('dob', _dob.toString());
    prefs.setInt('gender', _gender);
    prefs.setInt('relationship', _relationship);
  }

  Future<void> loadData() async {
    this._name = prefs.getString('name') ?? 'default name';
    this._dob = DateTime.tryParse(prefs.getString('dob')) ?? DateTime.now();
    this._gender = prefs.getString('gender') ?? 'default gender';
    notifyListeners();
  }

  Future<void> loadUser() async {
    _name = prefs.getString('name') ?? '';
    _dob = DateTime.tryParse(prefs.getString('dateOfBirth') ?? '') ??
        DateTime.now();
    _gender = prefs.getInt('gender') ?? 0;
    _relationship = prefs.getInt('relationship') ?? 1;
    notifyListeners();
  }

  Future<void> saveUser(BabyAccount user) async {
    _name = user.name;
    _dob = user.dateOfBirth;
    _gender = user.gender;
    _relationship = user.relationship;
    prefs.setString('name', _name);
    prefs.setString('dateOfBirth', _dob.toString());
    prefs.setInt('gender', _gender);
    prefs.setInt('relationship', _relationship);
    notifyListeners();
  }
}
