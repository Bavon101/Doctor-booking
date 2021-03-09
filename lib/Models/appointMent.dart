import 'dart:convert';

import 'package:flutter/material.dart';
AppointmentModel appointmentFromJson(String str) => AppointmentModel.fromJson(json.decode(str));

String appointmentToJson(AppointmentModel data) => json.encode(data.toJson());
class AppointmentModel {
  final String patient;
  final String patientID;
  final String description;
  final String appontmentID;
  final String doctor;
  final bool past;
  final String when;

  AppointmentModel(
      {@required this.appontmentID,
      @required this.description,
      @required this.doctor,
      @required this.past,
      @required this.patient,
      @required this.patientID,
      @required this.when});
  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
          appontmentID: json['appontmentID'],
          description: json['description'],
          doctor: json['doctor'],
          past: json['past'],
          patient: json['patient'],
          patientID: json['patientID'],
          when: json['when']);

  Map<String, dynamic> toJson() => {
    'appontmentID':this.appontmentID,
    'description':this.description,
    'doctor':this.doctor,
    'past':this.past,
    'patient':this.patient,
    'patientID':this.patientID,
    'when':this.when
  };
}
