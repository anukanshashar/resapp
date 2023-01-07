import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:splashscreen/splashscreen.dart';s
import 'globals.dart' as globals;

// class MyComponent {
//   view() {
//     if(globals.isLoggedIn) {
//       doSomething();}
//     else {
//       doSomethingElse();
//     }
//   }
// }

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.colour, required this.title, required this.onPressed});
  final Color colour;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          //Go to login screen.
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  Future login (String email , String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      ); return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signup(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ResApp',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/prefirst': (context) => MyNavigationBar(),
          '/first': (context) => MyHomePage(),
          '/second': (context) => Page1(),
          '/login': (context) => Login(),
          '/signup': (context) => Signup(),
          '/grids': (context) => MyGridScreen(),
          '/complains': (context) => Complain(),
          '/profile' : (context) => Profile(),
          '/sos' : (context) => SOS(),
        });
  }
}


class Splash extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => MyNavigationBar()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child : new Column(
          children: [
            new Container(
              child:FlutterLogo(size:MediaQuery.of(context).size.height),
            ),
            // new Container(
            //   child: new Text('ResApp',textScaleFactor: 2,),
            // ),
          ],
        )


    );
  }
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Splash Screen Example")),
      // body: Center(
      //     child:Text("Welcome to Home Page",
      //         style: TextStyle( color: Colors.black, fontSize: 30)
      //     )
      // ),
    );
  }
}

/*class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new MyHomePage(),
      backgroundColor: Colors.yellow,
      title: new Text('ResApp',textScaleFactor: 2,),
      image: new Image.network(
          'https://www.google.com/search?q=building+gif&rlz=1C1CHBF_enIN919IN919&sxsrf=ALiCzsbIwAkDIiRSY7m5rBJCe353Bap2Pg:1655019109544&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjpv_vQsqf4AhWUjeYKHfVlAXMQ_AUoAXoECAEQAw&biw=1280&bih=616&dpr=1.5#imgrc=1nDSryJsaadOFM'
      ),
      loadingText: Text("Setting up the app"),
      photoSize: 150.0,
      loaderColor: Colors.red,
    );
  }
}
 */

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String brr = globals.ualpha.substring(0,1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('ResApp'),
        // centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        height: 200,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("D:/Ronit/NTCC/SocietyMgmtApp/Appbg.jpg"),
              fit: BoxFit.cover),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Residential App",
                style: TextStyle(fontSize: 32, fontStyle: FontStyle.normal),
                textAlign: TextAlign.center,
              ),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                title: 'Click to continue',
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(globals.uname),
              accountEmail: Text(globals.uemail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,

                child: Text(
                  //"A",
                  brr,
                  style: TextStyle(color: Colors.lightBlue, fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Log Out"),
              onTap: () {
                // Navigator.pop(context);
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
    );
  }
}
showAlertDialog(BuildContext context){
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed: (){
      Navigator.pushNamed(context, '/second');
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text("You have successfully logged out"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context){
      return alert;
    },
  );
}

class MyNavigationBar extends StatefulWidget {

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    MyGridScreen(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: Icon(Icons.home_sharp),
                label: "Home",

                backgroundColor: Colors.blueAccent
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded),
                label: "Dashboard",
                backgroundColor: Colors.lightBlue
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.lightBlueAccent,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ResApp'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text(
                  "LogIn",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              ElevatedButton(
                child: Text(
                  "SignUp",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                  //Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  Login ({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> with InputValidationMixin{
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  String email = '';
  String password = '';
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ResApp'),
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
                              color: Colors.cyan,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {

                          if (value == null || value.isEmpty) {
                            return 'Please enter valid email id';
                          }
                          else if (!(isEmailValid(value))) {
                            return 'Please enter valid email id';
                          }
                          Future.delayed(Duration.zero,()
                          {
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {

                          if (value == null || value.isEmpty) {
                            return 'Please enter valid password';
                          }
                          else if (!(isPasswordValid(value))){
                            return 'Please enter password with more than 6 characters';
                          }
                          Future.delayed(Duration.zero,()
                          {
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
                                _auth.login(email, password).then((user) {
                                  Navigator.pushNamed(context, '/grids');
                                  //MyGridScreen();
                                }).catchError(() =>
                                    print("not able to be reached"));
                              };
                            })),
                    Row(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ))));
  }
}
showAlertDialog1(BuildContext context){
  Widget okButton = TextButton(
    child: Text("Ok"),
    onPressed: (){
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text("Verification email sent!"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context){
      return alert;
    },
  );
}
mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 7;
  bool isNumberValid(String number) => number.length == 10;

  bool isEmailValid(String email) {
    RegExp regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }
}

class Signup extends StatefulWidget  {
  Signup({Key? key}) : super(key: key);


  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with InputValidationMixin{
  CollectionReference users = FirebaseFirestore.instance.collection('users');
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('ResApp'),
          centerTitle: false,
        ),
        body: Form(
            key: _formKey2,
            child: SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                    ),
                    Text(
                      'Enter Details ',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                    ),//Text
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(width: 10), //SizedBox
                          Text(
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
                                type = 'resident';
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
                                type = 'admin';
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
                                type = 'security';
                              });
                            },

                          ),
                        ]),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        onChanged: (value){
                          name = value;
                        },
                        //obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          hintText: 'Enter Name',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {

                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          Future.delayed(Duration.zero,()
                          {
                            setState(() => name = value);
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        onChanged: (value){
                          email = value;
                        },
                        //obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email ID',
                          hintText: 'Enter Email ID',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {

                          if (value == null || value.isEmpty) {
                            return 'Please enter valid email id';
                          }
                          else if (!isEmailValid(value)) {
                            return "Please enter valid email id";
                          }
                          Future.delayed(Duration.zero,()
                          {
                            setState(() => email = value);
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        onChanged: (value){
                          password = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {

                          if (value == null || value.isEmpty) {
                            return 'Please enter valid password';
                          }
                          else if (!(isPasswordValid(value))) {
                            return 'Please enter a password with more than 6 characters';
                          }
                          Future.delayed(Duration.zero,()
                          {
                            setState(() => password = value);
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        onChanged: (value){
                          phone = value;
                        },
                        //obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                          hintText: 'Enter Phone Number',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {

                          if (value == null || value.isEmpty) {
                            return 'Please enter valid phone number';
                          }
                          else if (!(isNumberValid(value))) {
                            return 'Enter a 10 digit phone number';
                          }
                          Future.delayed(Duration.zero,()
                          {
                            setState(() => phone = value);
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        onChanged: (value){
                          tower = value;
                        },
                        //obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tower',
                          hintText: 'Enter Tower',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {

                          if (value == null || value.isEmpty) {
                            return 'Please enter valid tower';
                          }
                          Future.delayed(Duration.zero,()
                          {
                            setState(() => tower = value);
                          });
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        onChanged: (value){
                          flat = value;
                        },
                        //obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Flat Number',
                          hintText: 'Enter Flat Number',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {

                          if (value == null || value.isEmpty) {
                            return 'Please enter valid Flat No.';
                          }
                          Future.delayed(Duration.zero,()
                          {
                            setState(() => flat = value);
                          });
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Text('Already have an account?'),
                        TextButton(
                          child: const Text(
                            'LogIn',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            Login();
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () async {
                        await users.add({
                          'name' : name,
                          'email' : email,
                          'password' : password,
                          'phone number' : phone,
                          'tower' : tower,
                          'flat number' : flat,
                          'user type' : type
                        }).then((value) => print("User Added"));
                      },
                    )
                  ],
                ))),
      ),
    );
  }
}

class MyGridScreen extends StatefulWidget {
  MyGridScreen({Key? key}) : super(key: key);

  @override
  _MyGridScreenState createState() => _MyGridScreenState();
}

class _MyGridScreenState extends State<MyGridScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: //SingleChildScrollView(
      Center(
          child: GridView.extent(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200.0,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: RoundedButton(
                  colour: Colors.cyan,
                  title: "VISITORS",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                color: Colors.white60,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: RoundedButton(
                  colour: Colors.cyan,
                  title: "SOCIAL DIRECTORY",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                color: Colors.white60,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: RoundedButton(
                  colour: Colors.cyan,
                  title: "NOTICE BOARD",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                color: Colors.white60,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: RoundedButton(
                  colour: Colors.cyan,
                  title: "GROUP/FORUM CHAT",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                color: Colors.white60,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: RoundedButton(
                  colour: Colors.cyan,
                  title: "COMPLAINT BOX",
                  onPressed: () {
                    Navigator.pushNamed(context, '/complains');
                  },
                ),
                color: Colors.white60,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: RoundedButton(
                  colour: Colors.cyan,
                  title: "SOS",
                  onPressed: () async {
                    Navigator.pushNamed(context, '/sos');
                  },
                ),
                color: Colors.white60,
              ),
              /*Container(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                child: Text("Domestic Help", style: TextStyle(fontSize: 20),),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.red,
                textColor: Colors.white,
                padding: EdgeInsets.all(10.0),
                splashColor: Colors.grey,
              ),
                color: Colors.red,
              ),*/
            ],
          )),//)
    );
  }
}

class Complain extends StatefulWidget {
  Complain({Key? key}) : super(key: key);

  @override
  _ComplainState createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
  final _formKey = GlobalKey<FormState>();
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Complaint'),
          centerTitle: false,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Submit your complaint',
                  style: TextStyle(fontSize: 20.0),
                ),
                Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          new Expanded(
                              child: Slider(
                                value: _value.toDouble(),
                                min: 1.0,
                                max: 5.0,
                                divisions: 5,
                                activeColor: Colors.red,
                                inactiveColor: Colors.yellow,
                                label: 'Set urgency of complaint',
                                onChanged: (double newValue) {
                                  setState(() {
                                    _value = newValue.round();
                                  });
                                },
                              )),
                        ])),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Complaint',
                      hintText: 'Enter complaint',
                    ),
                  ),
                ),
                ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    }),
              ],
            ),),),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class Profile extends StatefulWidget {
  Profile ({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          centerTitle: false,
        ),
        body: Form (
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 70,

                      color:Colors.lightBlueAccent,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: globals.uname,
                        //hintText: 'Name',
                        //suffixIcon:  Icon(Icons.edit),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: globals.uemail,
                        //hintText: 'Email',
                        //suffixIcon: Icon(Icons.edit),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Type',
                        //hintText: 'Resident/Admin/Security',
                        //suffixIcon: Icon(Icons.edit),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: globals.utower,
                        //hintText: 'Address',
                        //suffixIcon: Icon(Icons.edit),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                      child: Text('Done'),
                      onPressed: () async {
                        DocumentSnapshot variable = await FirebaseFirestore.instance.collection('users').doc('FEl3xTLl0OHSY7Aua5p9').get();
                        print(variable['name']);
                        //globals.uname;: variable['name'];
                        globals.uname = variable['name'];
                        globals.uemail = variable['email'];
                        globals.upassword = variable['password'];
                        globals.uphone = variable['phone'];
                        globals.utower = variable['tower'];
                        globals.uflat = variable['flat'];
                        globals.ualpha = variable['name'];
                        //print(globals.uname);
                        //Navigator.pop(context);
                        // if (_formKey.currentState!.validate()) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Processing Data')),
                        //   );
                        // }
                      }),
                ]),
          ),
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
      home: Scaffold(
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

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('State Emergency'),
          leading: Radio(
            value: sosmessages.stateemergency,
            groupValue: _site,
            onChanged: (sosmessages? valued) {
              setState(() {
                _site = valued;
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
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showAlertDialogBox(context);
          },
          child: const Text(
            'Send',
          ),
        ),
      ],
    );
  }
}

class SOSAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: Text('Show alert'),
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
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, '/grids');
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("MESSAGE"),
    content: Text("Admin and security have been informed"),
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