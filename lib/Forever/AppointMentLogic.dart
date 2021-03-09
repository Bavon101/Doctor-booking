import 'package:flutter/material.dart';
import 'package:shambatestbavon/Models/appointMent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentHandle {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> setAppointment(
      {@required AppointmentModel appointmentModel,
      @required Function then}) async {
    final SharedPreferences prefs = await _prefs;
    getAllApointments().then((all) {
      try {
        if (all != null) {
          List<String> incoming = all;
          String appointmentToAdd = appointmentToJson(appointmentModel);
          incoming.add(appointmentToAdd);
          incoming = incoming;
          prefs.setStringList('appointmennts', incoming);
          then('Appointment has been logged');
        } else {
          String appointmentToAdd = appointmentToJson(appointmentModel);
          List<String> incoming = [appointmentToAdd];
          prefs.setStringList('appointmennts', incoming);
          then('Appointment has been logged');
        }
      } catch (e) {
        then('Could not create your Appointment');
      }
    });
  }

  Future<List<String>> getAllApointments() async {
    final SharedPreferences prefs = await _prefs;
    List<String> appointments = prefs.getStringList('appointmennts') ?? null;
    return appointments;
  }

  Future<void> updateAppointments(
      {@required List<String> appointments, @required Function then}) async {
    final SharedPreferences prefs = await _prefs;
    try {
      prefs.setStringList('appointmennts', appointments);
      then('Update was a success');
    } catch (e) {
      then('Could not update appontments');
    }
  }

  List<AppointmentModel> getAppontmentFromListString(
      {@required List<String> appointments}) {
    List<AppointmentModel> models = [];
    if (appointments != null) {
      for (int b = 0; b < appointments.length; b++) {
        AppointmentModel appointmentModel =
            appointmentFromJson(appointments[b]);
        models.add(appointmentModel);
        models = models;
      }

      return models;
    }
    return null;
  }

  List<String> getStringListFromModels(
      {@required List<AppointmentModel> models}) {
    List<String> incoming = [];
    if (models != null) {
      for (int b = 0; b < models.length; b++) {
        String modelString = appointmentToJson(models[b]);
        incoming.add(modelString);
        incoming = incoming;
      }
      return incoming;
    }
    return null;
  }
}
