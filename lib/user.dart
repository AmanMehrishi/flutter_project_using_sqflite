import 'dart:core';
import 'dart:ffi';

import 'package:flutter/material.dart';

class User
{
  int? _id;
  String? _name;
  String? _interest1;
  String? _interest2;
  String? _interest3;
  String? _about;
  int? _priority;

  User(this._name, this._interest1, this._interest2,this._interest3, this._priority,[this._about]);

  User.withId(this._id,this._name, this._interest1, this._interest2, this._interest3,[this._about]);

  int get id => _id!.toInt();
  String get name  => _name.toString();
  String get interest1 => _interest1.toString();

  String get interest2 => _interest2.toString();

  String get interest3 => _interest3.toString();

  String get about => _about.toString();

  int get priority => _priority!.toInt();

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }

  set about(String newAbout) {
    if (newAbout.length <= 255) {
      this._about = newAbout;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set interest1(String newInterest1) {
    this._interest1 = newInterest1;
  }

  set interest2(String newInterest2) {
    this._interest2 = newInterest2;
  }

  set interest3(String newInterest3) {
    this._interest3 = newInterest3;
  }


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if(id != null)
      {
        map['id'] = _id;
      }
    map['name'] = _name;
    map['about'] = _about;
    map['priority'] = _priority;
    map['interest1'] = _interest1;
    map['interest2'] = _interest2;
    map['interest3'] = _interest3;

    return map;
  }

  // Extract a Note object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    this._name = map['name'];
    this._interest1 = map['interest1'];
    this._about = map['about'];
    this._priority = map['priority'];
    this._interest2 = map['interest2'];
    this._interest3 = map['interest3'];
  }
}



