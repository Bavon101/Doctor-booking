import 'package:flutter/material.dart';
import 'package:shambatestbavon/Forever/AllFatherFunctions.dart';
import 'package:shambatestbavon/Forever/AppointMentLogic.dart';
import 'package:shambatestbavon/Forever/Constants.dart';
import 'package:shambatestbavon/Models/User.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shambatestbavon/Models/appointMent.dart';
import 'package:shambatestbavon/widgets/BavonButton.dart';

AppointmentHandle _appointmentHandle = new AppointmentHandle();

class AddAppontment extends StatefulWidget {
  AddAppontment({Key key, @required this.user, @required this.then})
      : super(key: key);
  final User user;
  final Function then;

  @override
  _AddAppontmentState createState() => _AddAppontmentState();
}

class _AddAppontmentState extends State<AddAppontment> {
  String details = 'Not Provided';
  String date;
  bool adding = false;
  DateTime when;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: HEIGHT(context: context),
      child: Center(
        child: !adding
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add Appointment Details',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: WIDTH(context: context) * .10),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (keyed) {
                        setState(() {
                          details = keyed;
                        });
                      },
                      autofocus: false,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.edit,
                            color: ALPHACOLOR,
                          ),
                          labelText: 'Added Details',
                          labelStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: ALPHACOLOR),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                date == null ? 'Select appointment date' : date,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: WIDTH(context: context) * .05)),
                          ],
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ALPHACOLOR,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: selectdate,
                            child: Text(
                              date == null ? 'Select' : 'Edit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  spaceAnime(context: context, animated: true),
                  BavonButton(
                      onTap: () {
                        if (date != null) {
                          setState(() {
                            adding = true;
                          });
                          AppointmentModel appointmentModel =
                              new AppointmentModel(
                                  appontmentID: getUUID(),
                                  description: details,
                                  doctor: null,
                                  past: false,
                                  patient: widget.user.name,
                                  patientID: widget.user.userId,
                                  when: date);
                          _appointmentHandle.setAppointment(
                              appointmentModel: appointmentModel,
                              then: (message) {
                                showToast(message: message);
                                setState(() {
                                  adding = false;
                                });
                                if (message.toString().contains('logged')) {
                                  widget.then();
                                  exit(context: context);
                                }
                              });
                        } else {
                          showToast(message: 'Please select Appointment date');
                        }
                      },
                      text: '    Set Appointment    ')
                ],
              )
            : CircularProgressIndicator.adaptive(),
      ),
    );
  }

  selectdate() {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        theme: DatePickerTheme(
            itemStyle: TextStyle(
                color: ALPHACOLOR, fontWeight: FontWeight.bold, fontSize: 18),
            doneStyle: TextStyle(color: ALPHACOLOR, fontSize: 16)),
        minTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        maxTime: DateTime(
            DateTime.now().year + 10, DateTime.now().month, DateTime.now().day),
        onChanged: (date) {}, onConfirm: (selecteddate) {
      setState(() {
        date = selecteddate.year.toString() +
            '/' +
            selecteddate.month.toString() +
            '/' +
            selecteddate.day.toString() +
            ' - ' +
             ( selecteddate.hour > 9 ? selecteddate.hour.toString():'0' + selecteddate.hour.toString() ) +
            ':' +
            ( selecteddate.minute > 9 ? selecteddate.minute.toString():'0' + selecteddate.minute.toString());
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}
