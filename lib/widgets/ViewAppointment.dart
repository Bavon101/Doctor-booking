import 'package:flutter/material.dart';
import 'package:shambatestbavon/Forever/AllFatherFunctions.dart';
import 'package:shambatestbavon/Forever/AppointMentLogic.dart';
import 'package:shambatestbavon/Forever/Constants.dart';
import 'package:shambatestbavon/Models/User.dart';
import 'package:shambatestbavon/Models/appointMent.dart';
import 'package:shambatestbavon/widgets/BavonButton.dart';

AppointmentHandle _appointmentHandle = new AppointmentHandle();

class Viewappointment extends StatefulWidget {
  Viewappointment(
      {Key key,
      @required this.appointmentModel,
      @required this.doctor,
      @required this.models,
      @required this.index,
      @required this.user,
      @required this.then})
      : super(key: key);
  final AppointmentModel appointmentModel;
  final bool doctor;
  final List<AppointmentModel> models;
  final int index;
  final User user;
  final Function then;
  @override
  _ViewappointmentState createState() => _ViewappointmentState();
}

class _ViewappointmentState extends State<Viewappointment> {
  List<AppointmentModel> models = [];
  getModels() {
    setState(() {
      models = widget.models;
    });
  }

  @override
  void initState() {
    super.initState();
    getModels();
  }

  markasAttended() {
    AppointmentModel appointmentModel = new AppointmentModel(
        appontmentID: widget.appointmentModel.appontmentID,
        description: widget.appointmentModel.description,
        doctor: widget.user.name,
        past: true,
        patient: widget.appointmentModel.patient,
        patientID: widget.appointmentModel.patientID,
        when: widget.appointmentModel.when);

    setState(() {
      models[widget.index] = appointmentModel;
      models = models;
    });
    List<String> incoming =
        _appointmentHandle.getStringListFromModels(models: models);
    _appointmentHandle.updateAppointments(
        appointments: incoming,
        then: (message) {
          showToast(message: message);
          widget.then();
          exit(context: context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Appontmnet Details',
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
                fontSize: WIDTH(context: context) * .08),
          ),
          spaceAnime(context: context, animated: true),
          optioncard(
              title: widget.doctor ? 'Attending Patient' : 'Assigned Doctor',
              subtitle: widget.doctor
                  ? widget.appointmentModel.patient
                  : widget.appointmentModel.doctor ?? 'Unassigned'),
          optioncard(
              title: 'Visit Date', subtitle: widget.appointmentModel.when),
          optioncard(
              title: 'Status',
              subtitle: !widget.appointmentModel.past
                  ? 'Awaiting Attendance'
                  : 'Attended'),
          widget.appointmentModel.description != null &&
                  widget.appointmentModel.description.length > 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('More Details:',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                            fontSize: WIDTH(context: context) * .06)),
                  ),
                )
              : Container(
                  height: 0,
                ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(widget.appointmentModel.description,
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: WIDTH(context: context) * .04)),
              )),
              spaceAnime(context: context, animated: true),
           widget.doctor ?   BavonButton(onTap: markasAttended, text: '   Mark as Attended    '):Container(height: 0,)
        ],
      ),
    );
  }

  Widget optioncard({String title, String subtitle}) => Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w800,
                    fontSize: WIDTH(context: context) * .05),
              ),
              Container(
                decoration: BoxDecoration(
                    color: ALPHAMEDIUM,
                    borderRadius:
                        BorderRadius.circular(WIDTH(context: context) * .10)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(subtitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: WIDTH(context: context) * .05)),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      );
}
