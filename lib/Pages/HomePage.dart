import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shambatestbavon/Forever/AllFatherFunctions.dart';
import 'package:shambatestbavon/Forever/AppointMentLogic.dart';
import 'package:shambatestbavon/Forever/AuthLogic.dart';
import 'package:shambatestbavon/Forever/Constants.dart';
import 'package:shambatestbavon/Models/User.dart';
import 'package:shambatestbavon/Models/appointMent.dart';
import 'package:shambatestbavon/Pages/Splash.dart';
import 'package:shambatestbavon/widgets/AddApointment.dart';
import 'package:shambatestbavon/widgets/Appointmentcard.dart';

UserAuth _userAuth = new UserAuth();
AppointmentHandle _appointmentHandle = new AppointmentHandle();

class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> appointmentsCards = [];
  List<AppointmentModel> models = [];
  geTAppointments() {
    setState(() {
      has = true;
      appointmentsCards = [];
      models = [];
    });
    _appointmentHandle.getAllApointments().then((all) {
      List<String> fetched = all;
      setState(() {
        models = _appointmentHandle.getAppontmentFromListString(
            appointments: fetched);
      });
      createcards();
    });
  }

  bool has = true;
  check() {
    if (models.isEmpty) {
      setState(() {
        has = false;
      });
    }
  }

  createcards() {
    if (models != null) {
      check();
      if (widget.user.doctor) {
        for (int b = 0; b < models.length; b++) {
          setState(() {
            appointmentsCards.add(Appointmentcard(
              user: widget.user,
              then: geTAppointments,
              index: b,
              models: models,
                appointmentModel: models[b], doctor: widget.user.doctor));
            appointmentsCards = appointmentsCards;
          });
        }
      } else {
        check();
        for (int b = 0; b < models.length; b++) {
          if (widget.user.userId == models[b].patientID) {
            setState(() {
              appointmentsCards.add(Appointmentcard(
                user: widget.user,
                  then: geTAppointments,
                index: b,
                models: models,
                  appointmentModel: models[b], doctor: widget.user.doctor));
              appointmentsCards = appointmentsCards;
            });
          }
        }
      }
    } else {
      setState(() {
        has = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _userAuth..saveGetUser(user: widget.user);
    geTAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.user.name}'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => _userAuth.logout(context: context))
        ],
      ),
      body: Container(
        child: Center(
          child: has && appointmentsCards.isEmpty
              ? CircularProgressIndicator.adaptive()
              : has && appointmentsCards.isNotEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.user.doctor ? "There are: ${appointmentsCards.length} Appointment" +
                                      (appointmentsCards.length > 1 ? 's' : '')   :"You've Set Up : ${appointmentsCards.length} Appointment" +
                                  (appointmentsCards.length > 1 ? 's' : ''),
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: WIDTH(context: context) * .055)),
                        ),
                        spaceAnime(context: context, animated: true),
                        Container(
                          height: HEIGHT(context: context) * .75,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: ListView(
                              children: appointmentsCards,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.user.doctor
                            ? 'No Appointments Available login as a Patient to create appointments'
                            : 'You don\'t have any Appointments  Click on the button bellow to add',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: WIDTH(context: context) * .07,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
        ),
      ),
      floatingActionButton: widget.user.doctor
          ? null
          : FloatingActionButton(
              backgroundColor: ALPHACOLOR,
              child: CircleAvatar(
                backgroundColor: ALPHALIGHT,
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {
                showBottom(
                    context: context,
                    child: AddAppontment(
                      user: widget.user,
                      then: geTAppointments,
                    ));
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
