import 'package:flutter/material.dart';
import 'package:shambatestbavon/Models/User.dart';
import 'package:shambatestbavon/Pages/Splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AllFatherFunctions.dart';

class UserAuth {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> isUserLoggedIn({bool markloged}) async {
    final SharedPreferences prefs = await _prefs;
    if (markloged == null) {
      return prefs.getBool('isin') ?? false;
    } else {
      prefs.setBool('isin', markloged);
      return null;
    }
  }

  Future<User> getUser(
      {@required String id,
      @required String pass,
      @required Function then,
      @required bool doctor}) async {
    final SharedPreferences prefs = await _prefs;

    String userStored = prefs.getString(id + (doctor ? 'd' : 'p')) ?? null;
    User user = userStored != null ? (userFromJson(userStored) ?? null) : null;
    if (user != null) {
      if (pass == user.password) {
        then('Verified');
        isUserLoggedIn(markloged: true);
       
        return user;
      } else {
        then('Invalid Password or ID');
        return null;
      }
    } else {
      then('No Account found Matching your ID');
      return null;
    }
  }

  Future<User> saveGetUser({User user, bool delete}) async {
    final SharedPreferences prefs = await _prefs;
    if (delete != null) {
      prefs.setString('current', '');
      return null;
    } else if (user == null && delete == null) {
      String userStored = prefs.getString('current') ?? null;
      User user =
          userStored != null  && userStored != '' ? (userFromJson(userStored) ?? null) : null;
      return user;
    } else {
      String userToSave = userToJson(user);
      prefs.setString('current', userToSave);
      return null;
    }
  }

  Future<void> logout({@required BuildContext context}) {
    isUserLoggedIn(markloged: false);
    
    Navigator.pushReplacement(context, getRoute(childto: SplashPage(delete: true,)));
    return null;
  }

  Future<bool> registerUser(
      {@required User user,
      @required Function then,
      @required bool doctor}) async {
    final SharedPreferences prefs = await _prefs;
    String userToSave = userToJson(user);

    try {
      prefs.setString(user.userId + (doctor ? 'd' : 'p'), userToSave);
      isUserLoggedIn(markloged: true);
      then('Success');
      
      return true;
    } catch (e) {
      then('Could not create an Account');
      return false;
    }
  }
}
