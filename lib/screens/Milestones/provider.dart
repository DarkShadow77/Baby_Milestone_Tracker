import 'dart:convert';

import 'package:babylid/main.dart';
import 'package:babylid/models/milestones.dart';
import 'package:flutter/material.dart';

class MilestoneProvider with ChangeNotifier {
  List<BabyMilestone> _milestones = [];

  List<BabyMilestone> get milestones {
    return [..._milestones];
  }

  Future<void> addMilestone(BabyMilestone milestone) async {
    final key = 'milestones';

    if (prefs.containsKey(key)) {
      List<dynamic> savedMilestones = jsonDecode(prefs.getString(key));
      savedMilestones.add(milestone.toJson());
      prefs.setString(key, jsonEncode(savedMilestones));
    } else {
      prefs.setString(key, jsonEncode([milestone.toJson()]));
    }

    _milestones.add(milestone);
    notifyListeners();
  }

  Future<void> fetchMilestones() async {
    final key = 'milestones';

    if (prefs.containsKey(key)) {
      List<dynamic> savedMilestones = jsonDecode(prefs.getString(key));
      _milestones = savedMilestones
          .map((milestone) => BabyMilestone.fromJson(milestone))
          .toList();
    }

    notifyListeners();
  }

  Future<void> editMilestone(int index, BabyMilestone newMilestone) async {
    final key = 'milestones';

    if (prefs.containsKey(key)) {
      List<dynamic> savedMilestones = jsonDecode(prefs.getString(key));
      savedMilestones[index] = newMilestone.toJson();
      prefs.setString(key, jsonEncode(savedMilestones));
    }

    _milestones[index] = newMilestone;
    notifyListeners();
  }

  Future<void> deleteMilestone(int index) async {
    final key = 'milestones';

    if (prefs.containsKey(key)) {
      List<dynamic> savedMilestones = jsonDecode(prefs.getString(key));
      savedMilestones.removeAt(index);
      prefs.setString(key, jsonEncode(savedMilestones));
    }

    _milestones.removeAt(index);
    notifyListeners();
  }
}
