import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shambatestbavon/Forever/AllFatherFunctions.dart';
import 'package:shambatestbavon/Forever/AuthLogic.dart';
import 'package:shambatestbavon/Forever/Constants.dart';
import 'package:shambatestbavon/Models/User.dart';
import 'package:shambatestbavon/widgets/BavonButton.dart';

import '../HomePage.dart';

UserAuth _userAuth = new UserAuth();

class LoginPage extends StatefulWidget {
  LoginPage({Key key, @required this.doctor}) : super(key: key);
  final bool doctor;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool resize = false;
  _resize() {
    delayTime(
        then: () {
          setState(() {
            resize = true;
          });
        },
        seconds: 1);
  }

  @override
  void initState() {
    super.initState();
    _resize();
  }

  String password;
  String userID;
  bool show = false;
  bool createAccount = false;
  String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Align(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  height: HEIGHT(context: context) * .20,
                  width: WIDTH(context: context) * .45,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HEIGHT(context: context)),
                    ),
                    shadowColor: ALPHALIGHT,
                    child: Lottie.asset(
                      LOTTIEJSON,
                    ),
                  ),
                ),
              ),
              spaceAnime(context: context, animated: true),
              Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: WIDTH(context: context) * .10,
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Login As a ${widget.doctor ? 'Doctor' : 'Patient'}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: WIDTH(context: context) * .05),
                ),
              )),
              AnimatedCrossFade(
                firstCurve: Curves.easeOutBack,
                secondCurve: Curves.easeInBack,
                firstChild: Container(),
                secondChild: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person_add,
                            color: ALPHACOLOR,
                          ),
                          labelText: 'Your Name',
                          hintText: ' Bavon',
                          labelStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                crossFadeState: !createAccount
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(seconds: 1),
              ),
              spaceAnime(context: context, animated: createAccount),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    userID = value;
                  });
                },
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: ALPHACOLOR,
                    ),
                    labelText: 'Your ID',
                    hintText: '1955',
                    labelStyle: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.w600)),
              ),
              spaceAnime(context: context, animated: true),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: !show,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        child: Icon(
                          !show ? Icons.visibility : Icons.visibility_off,
                          color: ALPHACOLOR,
                        )),
                    icon: Icon(
                      Icons.lock_open,
                      color: ALPHACOLOR,
                    ),
                    labelText: 'Password',
                    hintText: 'odinson',
                    labelStyle: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.w600)),
              ),
              spaceAnime(context: context, animated: true),
              BavonButton(
                  color: createAccount ? ALPHAMEDIUM : null,
                  onTap: () {
                    if (!createAccount) {
                      if (password != null && userID != null) {
                        _userAuth
                            .getUser(
                                doctor: widget.doctor,
                                id: userID,
                                pass: password,
                                then: (message) => showToast(message: message))
                            .then((user) {
                          if (user != null) {
                            
                            Navigator.pushReplacement(
                                context,
                                getRoute(
                                    childto: HomePage(
                                  user: user,
                                )));
                          }
                        });
                      } else {
                        showToast(
                            message: 'Please Provide  login details',
                            color: Colors.red);
                      }
                    } else {
                      if (userID != null &&
                          username != null &&
                          password != null) {
                        User user = new User(
                            password: password,
                            name: username,
                            userId: userID,
                            doctor: widget.doctor,
                            data: null);
                        _userAuth
                            .registerUser(
                                doctor: widget.doctor,
                                user: user,
                                then: (message) => showToast(message: message))
                            .then((created) {
                          if (created) {
                            
                            Navigator.pushReplacement(
                                context,
                                getRoute(
                                    childto: HomePage(
                                  user: user,
                                )));
                          }
                        });
                      } else {
                        showToast(
                            message: 'Please Provide  login details',
                            color: Colors.red);
                      }
                    }
                  },
                  text: !createAccount ? 'LOGIN' : 'REGISTER'),
                   spaceAnime(context: context, animated: true),
              TextButton(
                  onPressed: () {
                    setState(() {
                      createAccount = !createAccount;
                    });
                  },
                  child: Text(createAccount ? 'Login' : 'Register'))
            ],
          ),
        ),
      ),
    );
  }
}
