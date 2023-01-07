import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:sample1/loading.dart';
import 'package:provider/provider.dart';
import 'package:sample1/database.dart';
import 'globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ResApp',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          //'/prefirst': (context) => const MyNavigationBar(),
          '/first': (context) => MyHomePage(),
          '/login': (context) => Login(),
          '/signup': (context) => Signup(),
          '/grids': (context) => const MyGridScreen(),
          '/visitors': (context) => Visitors(),
          '/notice': (context) => NB(),
          '/noticeAdmin': (context) => const NoticeBoardAdmin(),
          '/services': (context) => const services(),
          '/servicesSec': (context) => SR(),
          '/complains': (context) => const Complain(),
          '/complainAdmin': (context) => C(),
          '/directory': (context) => SD(),
          '/activities': (context) => SA(),
          '/activitycreate': (context) => societyActivityA(),
          '/activityview': (context) => SA1(),
          '/profile': (context) => const Profile(),
          '/sos': (context) => SOS(),
        });
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.deepPurple[100],
      seconds: 2,
      navigateAfterSeconds: MyHomePage(),
      title: const Text(
        'ResApp',
        textScaleFactor: 3,
      ),
      image: Image.network('https://i.gifer.com/UH9g.gif'),
      //loadingText: const Text("Setting up your society"),
      photoSize: 100.0,
      loaderColor: Colors.deepPurple[300],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Text('ResApp'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to ResApp",
              style: TextStyle(fontSize: 26, fontStyle: FontStyle.normal),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                child: const Text(
                  "LogIn",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              ElevatedButton(
                child: const Text(
                  "SignUp",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                  //Navigator.pop(context);
                },
              ),
            ])
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, '/first');
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: const Text("You have successfully logged out"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    const MyGridScreen(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text('ResApp'),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.deepPurpleAccent),
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: "Dashboard",
                backgroundColor: Colors.deepPurpleAccent),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.deepPurpleAccent,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String type = '';
  String tower = '';
  String flat = '';
  String phone = globals.uphone;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: Scaffold(
              backgroundColor: Colors.deepPurple[100],
              appBar: AppBar(
                title: const Text('ResApp'),
                centerTitle: true,
              ),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Icon(
                        Icons.account_circle_rounded,
                        size: 70,
                        color: Colors.deepPurple[200],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: globals.uname,
                          hintText: 'Name',
                          suffixIcon: const Icon(Icons.edit),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          Future.delayed(Duration.zero, () {
                            setState(() => name = value);
                            globals.uname = name;
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: globals.uemail,
                          hintText: 'Email',
                          suffixIcon: const Icon(Icons.edit),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          Future.delayed(Duration.zero, () {
                            setState(() => email = value);
                            globals.uemail = email;
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: globals.utype,
                          hintText: 'Resident/Admin/Security',
                          suffixIcon: const Icon(Icons.edit),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          Future.delayed(Duration.zero, () {
                            setState(() => type = value);
                            globals.utype = type;
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: globals.utower,
                          hintText: 'Tower',
                          suffixIcon: const Icon(Icons.edit),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          Future.delayed(Duration.zero, () {
                            setState(() => tower = value);
                            globals.utower = tower;
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: globals.uflat,
                          hintText: 'Flat',
                          suffixIcon: const Icon(Icons.edit),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          Future.delayed(Duration.zero, () {
                            setState(() => flat = value);
                            globals.uflat = flat;
                          });
                          return null;
                        },
                      ),
                    ),
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                child: const Text('Go Back'),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/grids');
                                }),
                            ElevatedButton(
                                child: const Text('Save Changes'),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                    final user =
                                        FirebaseAuth.instance.currentUser;
                                    if (user != null) {
                                      final uid = user.uid;
                                      final DatabaseService _databaseService =
                                          DatabaseService(uid: uid);
                                      await _databaseService.updateUserData(
                                          type, name, phone, tower, flat);
                                    }
                                    Navigator.pushNamed(context, '/grids');
                                  }
                                }),
                          ]),
                    )
                  ]),
                ),
              ),
            ),
          );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;

  late BuildContext context;

  Future login(String email, String password) async {
    try {
      //UserCredential userCredential =
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User was not found')),
        );
        return null;
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect password')),
        );
        return null;
      }
    }
  }

  Future signup(String email, String password) async {
    try {
      //UserCredential userCredential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Account already exists for that email')),
        );
      }
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter correct credentials')),
      );
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with InputValidationMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  String email = '';
  String password = '';
  final AuthService _auth = AuthService();
  bool loading = false;

  getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      DocumentSnapshot variable = await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(uid)
          .get();
      globals.uname = variable['name'];
      globals.uemail = variable['email'];
      globals.upassword = variable['password'];
      globals.uphone = variable['number'];
      globals.utower = variable['tower'];
      globals.uflat = variable['flat'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.deepPurple[100],
            appBar: AppBar(
              title: const Text('ResApp'),
              centerTitle: true,
            ),
            body: Form(
                key: _formKey1,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              '',
                              style: TextStyle(fontSize: 20),
                            )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'User Name',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid email id';
                              } else if (!(isEmailValid(value))) {
                                return 'Please enter valid email id';
                              }
                              Future.delayed(Duration.zero, () {
                                setState(() => email = value);
                              });
                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid password';
                              } else if (!(isPasswordValid(value))) {
                                return 'Please enter password with more than 6 characters';
                              }
                              Future.delayed(Duration.zero, () {
                                setState(() => password = value);
                              });
                              return null;
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            showAlertDialog1(context);
                          },
                          child: const Text(
                            'Forgot Password',
                          ),
                        ),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Login'),
                              onPressed: () async {
                                if (_formKey1.currentState!.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.login(email, password);
                                  if (result != null) {
                                    getCurrentUser();
                                    Navigator.pushNamed(context, '/grids');
                                  }
                                  if (result == null) {
                                    setState(() => loading = false);
                                  }
                                }
                              },
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Do not have an account?'),
                            TextButton(
                              child: const Text(
                                'Sign in',
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                            )
                          ],
                        ),
                      ],
                    ))));
  }
}

showAlertDialog1(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("Ok"),
    onPressed: () {
      Login();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: const Text("Verification email sent!"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 7;

  bool isNumberValid(String number) => number.length == 10;

  bool isCarnumValid(String number) => number.length == 10;

  bool isEmailValid(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }
}

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with InputValidationMixin {
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  final _formKey2 = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String name = '';
  String phone = '';
  String tower = '';
  String flat = '';
  String type = '';
  final AuthService _auth = AuthService();
  bool loading = false;

  getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final DatabaseService _databaseService = DatabaseService(uid: uid);
      await _databaseService.updateUserData(type, name, phone, tower, flat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: loading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.deepPurple[100],
              //resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('ResApp'),
                centerTitle: false,
              ),
              body: Form(
                  key: _formKey2,
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const Text(
                            'Enter Details ',
                            style: TextStyle(fontSize: 17.0),
                          ), //Text
                          Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const SizedBox(width: 10), //SizedBox
                                const Text(
                                  'Select type of user',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                CheckboxListTile(
                                  title: const Text('Resident'),
                                  value: value1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      value1 = value!;
                                      value2 = false;
                                      value3 = false;
                                      type = 'Resident';
                                      globals.utype = type;
                                    });
                                  },
                                  //controlAffinity: ListTileControlAffinity.leading,
                                ),
                                CheckboxListTile(
                                  //controlAffinity: ListTileControlAffinity.trailing,
                                  title: const Text('Admin'),
                                  value: value2,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      value2 = value!;
                                      value1 = false;
                                      value3 = false;
                                      type = 'Admin';
                                      globals.utype = type;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  //controlAffinity: ListTileControlAffinity.trailing,
                                  title: const Text('Security'),
                                  value: value3,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      value3 = value!;
                                      value1 = false;
                                      value2 = false;
                                      type = 'Security';
                                      globals.utype = type;
                                    });
                                  },
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              //obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                hintText: 'Enter Name',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                Future.delayed(Duration.zero, () {
                                  setState(() => name = value);
                                  globals.uname = name;
                                });
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              //obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email ID',
                                hintText: 'Enter Email ID',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid email id';
                                } else if (!isEmailValid(value)) {
                                  return "Please enter valid email id";
                                }
                                Future.delayed(Duration.zero, () {
                                  setState(() => email = value);
                                  globals.uemail = email;
                                });
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter Password',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid password';
                                } else if (!(isPasswordValid(value))) {
                                  return 'Please enter a password with more than 6 characters';
                                }
                                Future.delayed(Duration.zero, () {
                                  setState(() => password = value);
                                });
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              //obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone Number',
                                hintText: 'Enter Phone Number',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid phone number';
                                } else if (!(isNumberValid(value))) {
                                  return 'Enter a 10 digit phone number';
                                }
                                Future.delayed(Duration.zero, () {
                                  setState(() => phone = value);
                                  globals.uphone = phone;
                                });
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              //obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Tower',
                                hintText: 'Enter Tower',
                              ),
                              //autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (globals.utype == 'Security') {
                                  globals.utower = '0';
                                  return null;
                                }
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid tower';
                                }
                                Future.delayed(Duration.zero, () {
                                  setState(() => tower = value);
                                  globals.utower = tower;
                                });
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              //obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Flat Number',
                                hintText: 'Enter Flat Number',
                              ),
                              //autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (globals.utype == 'Security') {
                                  globals.uflat = '0';
                                  return null;
                                }
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid Flat No.';
                                }
                                Future.delayed(Duration.zero, () {
                                  setState(() => flat = value);
                                  globals.uflat = flat;
                                });
                                return null;
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Already have an account?'),
                              TextButton(
                                child: const Text(
                                  'LogIn',
                                  style: TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                              )
                            ],
                          ),
                          ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () async {
                              if (_formKey2.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signup(email, password);
                                if (result != null) {
                                  getCurrentUser();
                                  Navigator.pushNamed(context, '/grids');
                                }
                                if (result == null) {
                                  setState(() => loading = false);
                                }
                              }
                            },
                          )
                        ],
                      ))),
            ),
    );
  }
}

class MyGridScreen extends StatefulWidget {
  const MyGridScreen({Key? key}) : super(key: key);

  @override
  _MyGridScreenState createState() => _MyGridScreenState();
}

class _MyGridScreenState extends State<MyGridScreen> {
  final AuthService _auth = AuthService();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.0),
            ),
            child: GridView.extent(
              primary: false,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              maxCrossAxisExtent: 200.0,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.deepPurple[200],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        "Visitors",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/visitors');
                      },
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.deepPurple[200],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        "Social Directory",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/directory');
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.deepPurple[200],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        "Notice Board",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (globals.utype == 'Admin') {
                          Navigator.pushNamed(context, '/noticeAdmin');
                        } else {
                          Navigator.pushNamed(context, '/notice');
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.deepPurple[200],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        "Services",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (globals.utype == 'Security') {
                          Navigator.pushNamed(context, '/servicesSec');
                        } else {
                          Navigator.pushNamed(context, '/services');
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.deepPurple[200],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        "Complaint Box",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (globals.utype == 'Admin') {
                          Navigator.pushNamed(context, '/complainAdmin');
                        } else {
                          Navigator.pushNamed(context, '/complains');
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.deepPurple[200],
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        "Activities Center",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/activities');
                      },
                    ),
                  ),
                ),
                Container(
            padding: const EdgeInsets.all(8),
            color: Colors.deepPurple[200],
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
            child: ElevatedButton(
              child: const Text(
                "SOS",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/sos');
              },
            ),),
          ),

                Container(
                padding: const EdgeInsets.all(8),
                color: Colors.deepPurple[200],
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
                child: ElevatedButton(
                child: Text("Domestic Help", style: TextStyle(fontSize: 20),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ),),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.deepPurple[100],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(globals.uname),
                accountEmail: Text(globals.uemail),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.deepPurple[500],
                  child: Text(
                    globals.utype,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                iconColor: Colors.deepPurple[200],
                title: const Text("Home"),
                onTap: () {
                  Navigator.pushNamed(context, '/grids');
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                iconColor: Colors.deepPurple[200],
                title: const Text("Profile"),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                iconColor: Colors.deepPurple[200],
                title: const Text("Log Out"),
                onTap: () async {
                  await _auth.signOut();
                  showAlertDialog(context);
                },
              ),
              /*ListTile(
              leading: Icon(Icons.contacts), title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ), */
            ],
          ),
        ),
      ),
    );
  }
}

class Visitors extends StatefulWidget {
  Visitors({Key? key}) : super(key: key);

  @override
  _Visitors createState() => _Visitors();
}

class _Visitors extends State<Visitors> with InputValidationMixin {
  final _formKey2 = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String carnum = '';

  // String tower = '';
  // String flat = '';
  bool loading = false;

  Visitor() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final DatabaseService _databaseService = DatabaseService(uid: uid);
      await _databaseService.updateVisitorData(name, phone, carnum);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: Scaffold(
              backgroundColor: Colors.deepPurple[100],
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('ResApp'),
                centerTitle: false,
              ),
              body: Form(
                  key: _formKey2,
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Visitors',
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.deepPurple[300]),
                          ), //Text
                          const SizedBox(
                            width: 10,
                            height: 20,
                          ),
                          Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const SizedBox(width: 10), //SizedBox
                              ]),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              //obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                hintText: 'Enter Visitor Name',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter visitor name';
                                }
                                Future.delayed(Duration.zero, () {
                                  setState(() => name = value);
                                });
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              //obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone Number',
                                hintText: 'Enter Visitor Phone Number',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid phone number';
                                } else if (!isCarnumValid(value)) {
                                  return "Please enter valid phone number";
                                }
                                Future.delayed(Duration.zero, () {
                                  setState(() => phone = value);
                                });
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              //obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Car Number',
                                hintText: 'Enter Car Number',
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid car number';
                                } else if (!(isCarnumValid(value))) {
                                  return 'Car number should be of 10 letters only';
                                }
                                Future.delayed(Duration.zero, () {
                                  setState(() => carnum = value);
                                });
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                            height: 10,
                          ),
                          ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () async {
                              if (_formKey2.currentState!.validate()) {
                                setState(() => loading = true);
                                Visitor();
                                showVisitorDialog(context);
                              }
                            },
                          )
                        ],
                      ))),
            ),
          );
  }
}

showVisitorDialog(BuildContext context) {
  // Create button
  var otp = Random();
  late var code = otp.nextInt(900000) + 100000;
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, '/grids');
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
        "The 6-digit-verification code generated is as follows. Please share this with security when asked to permit visitor inside"),
    content: Text(code.toString()),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class NoticeBoardAdmin extends StatefulWidget {
  const NoticeBoardAdmin({Key? key}) : super(key: key);

  @override
  _NoticeBoardAdminState createState() => _NoticeBoardAdminState();
}

class _NoticeBoardAdminState extends State<NoticeBoardAdmin> {
  final _formKey4 = GlobalKey<FormState>();
  bool loading = false;
  String date = '';
  String notice = '';

  getNotice() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final DatabaseService _databaseService = DatabaseService(uid: uid);
      await _databaseService.addNotice(date, notice);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateToday = DateTime.now();
    date = dateToday.toString().substring(0, 10);
    return loading
        ? Loading()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: Scaffold(
              backgroundColor: Colors.deepPurple[100],
              appBar: AppBar(
                title: const Text('Notice Board'),
                centerTitle: false,
              ),
              body: Form(
                key: _formKey4,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Submit a new notice',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            Future.delayed(Duration.zero, () {
                              setState(() => notice = value);
                            });
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Notice',
                            hintText: 'Enter details',
                          ),
                        ),
                      ),
                      ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () async {
                            if (_formKey4.currentState!.validate()) {
                              setState(() => loading = true);
                              getNotice();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Your notice has been successfully registered')),
                              );
                              Navigator.pushNamed(context, '/grids');
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class NB extends StatelessWidget {
  late final String uid;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    return StreamProvider<List<Notices>>.value(
      value: DatabaseService(uid: uid).notice,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.deepPurple[300],
        appBar: AppBar(
          title: const Text('Notice Board'),
          backgroundColor: Colors.deepPurple[200],
        ),
        body: NoticeBoard(),
      ),
    );
  }
}

class NoticeBoard extends StatefulWidget {
  @override
  NoticeBoardState createState() => NoticeBoardState();
}

class NoticeBoardState extends State<NoticeBoard> {
  @override
  Widget build(BuildContext context) {
    final notices = Provider.of<List<Notices>>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: ListView.builder(
        itemCount: notices.length,
        itemBuilder: (context, index) {
          return NoticeTile(notice: notices[index]);
        },
      ),
    );
  }
}

class NoticeTile extends StatelessWidget {
  final Notices notice;

  NoticeTile({required this.notice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.deepPurple[70],
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepPurple[100],
          ),
          title: Text(notice.notice),
          subtitle: Text('published on ${notice.date}'),
        ),
      ),
    );
  }
}

class Complain extends StatefulWidget {
  const Complain({Key? key}) : super(key: key);

  @override
  _ComplainState createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
  final _formKey = GlobalKey<FormState>();
  int _value = 1;
  bool loading = false;
  String complaint = '';

  getComplaint() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final DatabaseService _databaseService = DatabaseService(uid: uid);
      await _databaseService.userComplaints(
          _value, complaint, globals.utower, globals.uflat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: Scaffold(
              backgroundColor: Colors.deepPurple[100],
              appBar: AppBar(
                title: const Text('Complaint'),
                centerTitle: false,
              ),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Submit your complaint',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                            Expanded(
                                child: Slider(
                              value: _value.toDouble(),
                              min: 1.0,
                              max: 5.0,
                              divisions: 4,
                              activeColor: Colors.deepPurple[600],
                              inactiveColor: Colors.deepPurple[200],
                              label: 'Set urgency of complaint',
                              onChanged: (double newValue) {
                                setState(() {
                                  _value = newValue.round();
                                });
                              },
                            )),
                          ])),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            Future.delayed(Duration.zero, () {
                              setState(() => complaint = value);
                            });
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Complaint',
                            hintText: 'Enter complaint',
                          ),
                        ),
                      ),
                      ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              getComplaint();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Your complaint has been successfully registered')),
                              );
                              Navigator.pushNamed(context, '/grids');
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class C extends StatelessWidget {
  late final String uid;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    return StreamProvider<List<Complains>>.value(
      value: DatabaseService(uid: uid).complain,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          title: const Text('Registered Complains'),
          backgroundColor: Colors.deepPurple[200],
        ),
        body: complainAdmin(),
      ),
    );
  }
}

class complainAdmin extends StatefulWidget {
  @override
  complainAdminState createState() => complainAdminState();
}

class complainAdminState extends State<complainAdmin> {
  @override
  Widget build(BuildContext context) {
    final complains = Provider.of<List<Complains>>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: ListView.builder(
        itemCount: complains.length,
        itemBuilder: (context, index) {
          return ComplainTile(complain: complains[index]);
        },
      ),
    );
  }
}

class ComplainTile extends StatelessWidget {
  final Complains complain;

  ComplainTile({required this.complain});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.deepPurple[70],
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepPurple[200],
          ),
          title: Text('${complain.complaint} - ${complain.urgency}'),
          subtitle: Text('by ${complain.tower}, ${complain.flat}'),
        ),
      ),
    );
  }
}

class SOS extends StatelessWidget {
  static const String _title = 'SOS';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: SOSRadio(),
        ),
      ),
    );
  }
}

enum sosmessages { stateemergency, firealarm, waterpipeburst }

class SOSRadio extends StatefulWidget {
  // SOSRadio({Key key}) : super(key: key);

  @override
  _SOSRadioState createState() => _SOSRadioState();
}

class _SOSRadioState extends State<SOSRadio> {
  sosmessages? _site = sosmessages.stateemergency;
  bool loading = false;
  String msg = '';

  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Column(
            children: <Widget>[
              ListTile(
                title: const Text('State Emergency'),
                leading: Radio(
                  value: sosmessages.stateemergency,
                  groupValue: _site,
                  onChanged: (sosmessages? valued) {
                    setState(() {
                      _site = valued;
                      msg = 'State Emergency';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Fire Alarm'),
                leading: Radio(
                  value: sosmessages.firealarm,
                  groupValue: _site,
                  onChanged: (sosmessages? value) {
                    setState(() {
                      _site = value;
                      msg = 'Fire Alarm';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Water Pipe Burst'),
                leading: Radio(
                  value: sosmessages.waterpipeburst,
                  groupValue: _site,
                  onChanged: (sosmessages? value) {
                    setState(() {
                      _site = value;
                      msg = 'Water Pipe Burst';
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() => loading = true);
                  showAlertDialogBox(context);
                  _sendingSMS(msg);
                  _sendingMails;
                },
                child: const Text(
                  'Send',
                ),
              ),
            ],
          );
  }
}

_sendingSMS(String msg) async {
  var url = Uri.parse(
      'sms:+91 9310204084 ? body= SOS emergency in ${globals.utower} , ${globals.uflat} - $msg');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_sendingMails() async {
  var url = Uri.parse('mailto:anukansha123@gmail.com');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class SOSAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: const Text('Show alert'),
        onPressed: () {
          showAlertDialogBox(context);
        },
      ),
    );
  }
}

showAlertDialogBox(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, '/grids');
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("MESSAGE"),
    content: const Text("Admin and security have been informed"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class SD extends StatelessWidget {
  late final String uid;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    return StreamProvider<List<Users>>.value(
      value: DatabaseService(uid: uid).user,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          title: const Text('Social Directory'),
          backgroundColor: Colors.deepPurple[200],
        ),
        body: socialDirectory(),
      ),
    );
  }
}

class socialDirectory extends StatefulWidget {
  @override
  socialDirectoryState createState() => socialDirectoryState();
}

class socialDirectoryState extends State<socialDirectory> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Users>>(context);
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserTile(user: users[index]);
        },
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final Users user;

  UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.deepPurple[70],
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepPurple[200],
          ),
          title: Text(user.name),
          subtitle:
              Text('is ${user.type}  \nlives in ${user.tower} , ${user.flat}'),
        ),
      ),
    );
  }
}

class services extends StatefulWidget {
  const services({Key? key}) : super(key: key);

  @override
  _servicesState createState() => _servicesState();
}

class _servicesState extends State<services> {
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  bool value4 = false;
  bool loading = false;
  String date = '';
  String requirement = '';

  getService() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final DatabaseService _databaseService = DatabaseService(uid: uid);
      await _databaseService.serviceRequired(
          date, requirement, globals.utower, globals.uflat);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateToday = DateTime.now();
    date = dateToday.toString().substring(0, 10);
    return loading
        ? Loading()
        : MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          title: const Text('Services'),
          centerTitle: false,
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: <Widget>[
              const Text(
                'Submit service required',
                style: TextStyle(fontSize: 20.0),
              ),
              Center(
                child: Column(children: <Widget>[
                  const SizedBox(width: 10), //SizedBox
                  CheckboxListTile(
                    title: const Text('Plumber'),
                    value: value1,
                    onChanged: (bool? value) {
                      setState(() {
                        value1 = value!;
                        value2 = false;
                        value3 = false;
                        value4 = false;
                        requirement = 'Plumber';
                      });
                    },
                    //controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    //controlAffinity: ListTileControlAffinity.trailing,
                    title: const Text('Electrician'),
                    value: value2,
                    onChanged: (bool? value) {
                      setState(() {
                        value2 = value!;
                        value1 = false;
                        value3 = false;
                        value4 = false;
                        requirement = 'Electrician';
                      });
                    },
                  ),
                  CheckboxListTile(
                    //controlAffinity: ListTileControlAffinity.trailing,
                    title: const Text('Carpenter'),
                    value: value3,
                    onChanged: (bool? value) {
                      setState(() {
                        value3 = value!;
                        value1 = false;
                        value2 = false;
                        value4 = false;
                        requirement = 'Carpenter';
                      });
                    },
                  ),
                  CheckboxListTile(
                    //controlAffinity: ListTileControlAffinity.trailing,
                    title: const Text('Housekeeper'),
                    value: value4,
                    onChanged: (bool? value) {
                      setState(() {
                        value4 = value!;
                        value1 = false;
                        value2 = false;
                        value3 = false;
                        requirement = 'Housekeeper';
                      });
                    },
                  ),
                  ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () async {
                        setState(() => loading = true);
                        getService();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Your request has been successfully registered. Appropriate help will be sent soon.')),
                        );
                        Navigator.pushNamed(context, '/grids');
                      }),
                ]),
              ),
            ])),
      ),
    );
  }
}

class SR extends StatelessWidget {
  late final String uid;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    return StreamProvider<List<Services>>.value(
      value: DatabaseService(uid: uid).service,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          title: const Text('Services Required'),
          backgroundColor: Colors.deepPurple[200],
        ),
        body: serviceReqSecurity(),
      ),
    );
  }
}

class serviceReqSecurity extends StatefulWidget {
  @override
  serviceReqSecurityState createState() => serviceReqSecurityState();
}

class serviceReqSecurityState extends State<serviceReqSecurity> {
  @override
  Widget build(BuildContext context) {
    final services = Provider.of<List<Services>>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ServiceTile(service: services[index]);
        },
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final Services service;

  ServiceTile({required this.service});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.deepPurple[70],
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepPurple[100],
          ),
          title:
              Text('${service.service} by ${service.tower} , ${service.flat}'),
          subtitle: Text('requested on ${service.date}'),
        ),
      ),
    );
  }
}

class SA extends StatelessWidget {
  late final String uid;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    return StreamProvider<List<Activities>>.value(
      value: DatabaseService(uid: uid).activity,
      initialData: [],
      child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          appBar: AppBar(
            title: const Text('Activity Centre'),
            backgroundColor: Colors.deepPurple[200],
          ),
          body: Row (mainAxisAlignment: MainAxisAlignment.center,
              children: <
              Widget>[
            Padding(
                padding: const EdgeInsets.all(15),
                child:
                    Column (mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: 100, //height of button
                    width: 300,
                    child: ElevatedButton(
                        child: const Text('View'),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/activityview');
                        }),
                  ),
                Padding(
                    padding: const EdgeInsets.all(30),),
                  SizedBox(
                    height: 100, //height of button
                    width: 300,
                    child: ElevatedButton(
                        child: const Text('Schedule'),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/activitycreate');
                        }),
                  ),
                ])),
          ])),
    );
  }
}

class societyActivityA extends StatefulWidget {
  @override
  societyActivityAState createState() => societyActivityAState();
}

class societyActivityAState extends State<societyActivityA> {
  final _formKey7 = GlobalKey<FormState>();
  bool loading = false;
  String day = '';
  String activity = '';
  String time = '';
  String location = '';

  getActivity() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      final DatabaseService _databaseService = DatabaseService(uid: uid);
      await _databaseService.addActivity(
          globals.uname, globals.uphone, activity, day, time, location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.deepPurple[100],
            appBar: AppBar(
              title: const Text('Scheduled Activities'),
              centerTitle: false,
            ),
            body: Form(
              key: _formKey7,
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Activity',
                      hintText: 'Enter Activity Name',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an activity';
                      }
                      Future.delayed(Duration.zero, () {
                        setState(() => activity = value);
                      });
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    //obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date',
                      hintText:
                          'Enter date when activity is scheduled in dd:mm:yyyy format',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid time';
                      }
                      Future.delayed(Duration.zero, () {
                        setState(() => day = value);
                      });
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    //obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Time',
                      hintText:
                          'Enter time at which activity is scheduled in hh:mm format',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid time';
                      }
                      Future.delayed(Duration.zero, () {
                        setState(() => time = value);
                      });
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    //obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Location',
                      hintText: 'Enter location of activity',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter location';
                      }
                      Future.delayed(Duration.zero, () {
                        setState(() => location = value);
                      });
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () async {
                      if (_formKey7.currentState!.validate()) {
                        setState(() => loading = true);
                        getActivity();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Your activity has been successfully registered')),
                        );
                        Navigator.pushNamed(context, '/grids');
                      }
                    }),
              ]),
            ),
          );
  }
}

class SA1 extends StatelessWidget {
  late final String uid;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }
    return StreamProvider<List<Activities>>.value(
      value: DatabaseService(uid: uid).activity,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        appBar: AppBar(
          title: const Text('Activity Centre'),
          backgroundColor: Colors.deepPurple[200],
        ),
        body: societyActivity(),
      ),
    );
  }
}

class societyActivity extends StatefulWidget {
  @override
  societyActivityState createState() => societyActivityState();
}

class societyActivityState extends State<societyActivity> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<List<Activities>>(context);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.deepPurple[100],
            appBar: AppBar(
              title: const Text('Scheduled Activities'),
              centerTitle: false,
            ),
            body: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return ActivityTile(activities: activities[index]);
              },
            ),
          );
  }
}

class ActivityTile extends StatelessWidget {
  final Activities activities;

  ActivityTile({required this.activities});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: Colors.deepPurple[70],
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepPurple[200],
          ),
          title: Text(activities.activity),
          subtitle: Text(
              'On ${activities.day} at ${activities.time} in ${activities.location} \nBy- ${activities.name} , ${activities.phone}'),
        ),
      ),
    );
  }
}
