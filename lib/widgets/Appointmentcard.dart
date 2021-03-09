import 'package:flutter/material.dart';
import 'package:shambatestbavon/Forever/AllFatherFunctions.dart';
import 'package:shambatestbavon/Forever/Constants.dart';
import 'package:shambatestbavon/Models/User.dart';
import 'package:shambatestbavon/Models/appointMent.dart';
import 'package:shambatestbavon/widgets/ViewAppointment.dart';

class Appointmentcard extends StatelessWidget {
  const Appointmentcard(
      {Key key,
      @required this.appointmentModel,
      @required this.doctor,
      @required this.models,
      @required this.index,
      @required this.then,
      @required this.user
      })
      : super(key: key);
  final AppointmentModel appointmentModel;
  final bool doctor;
  final List<AppointmentModel> models;
  final int index;
  final User user;
  final Function then;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showBottom(
          context: context,
          child: Viewappointment(
            user: user,
            then: then,
            index: index,
              appointmentModel: appointmentModel,
              doctor: doctor,
              models: models)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(doctor
                      ? 'Appoinment for: ${appointmentModel.patient}'
                      : 'Appointment for date: ${appointmentModel.when}'),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: appointmentModel.past
                            ? ALPHACOLOR
                            : Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () => showBottom(
                          context: context,
                          child: Viewappointment(
                            user: user,
                            then: then,
                            index: index,
                              appointmentModel: appointmentModel,
                              doctor: doctor,
                              models: models)),
                      child: Text(
                        appointmentModel.past ? 'Attended' : 'Awaiting',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
