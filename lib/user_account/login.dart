import 'package:eshop/home/home_page/home_page.dart';
import 'package:eshop/models/api_models.dart';
import 'package:eshop/user_account/sign_up.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/utils/user_interface_utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;
  bool remember = false;
  int passVal = 0;
  String email = "";
  String pass = "";
  String truePass = "Test123";
  String trueEmail = "test@test.com";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Log In",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 0,
                ),
              ],
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 16),
            child: const Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/google.png",
                        height: 20,
                        width: 20,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Log In With Google",
                        style: TextStyle(fontSize: 16),
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 24,
            ),
            getTitle("Email"),
            getDecoratedContainer(TextFormField(
              decoration: getDecoation("example@mail.com"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email Cannot be Epty";
                } else if (!emailValidatorRegExp.hasMatch(value)) {
                  return "Please Enter a Valid Email Address";
                }
                return null;
              },
              onChanged: (val) {},
              onSaved: (val) {
                email = val!;
              },
            )),
            getTitle("Password"),
            getDecoratedContainer(Stack(
              children: [
                TextFormField(
                  decoration: getDecoation("at least 8 characters"),
                  obscureText: isObscure,
                  onChanged: (val) {},
                  onSaved: (val) {
                    pass = val!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password Cannot be Epty";
                    } else if (value.length < 5) {
                      return "Password should be of atleast 5 characters";
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                      color: kGreyColor,
                    ),
                  ),
                ),
              ],
            )),
            Row(
              children: [
                Checkbox(
                  value: remember,
                  onChanged: (val) {
                    setState(() {
                      remember = val!;
                    });
                  },
                  side: const BorderSide(
                    color: kGreyColor,
                    width: 2,
                  ),
                ),
                Text(
                  "Remember Me",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.kSecondayTextColor),
                )
              ],
            ),
            const SizedBox(
              height: SizeConstants.smallSpacing,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                    primary: Colors.white, backgroundColor: Colors.blue),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    OnlineModel.login(
                        email: email,
                        password: pass,
                        success: (resp) {
                          UserInterfaceUtils.showSnackBar(
                              "Login Succed", context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (__) {
                            return const HomePage();
                          }));
                        },
                        fail: (msg) {
                          UserInterfaceUtils.showSnackBar(msg, context);
                        });
                  }
                },
                child: const Text('Log In'),
              ),
            ),
            const SizedBox(
              height: SizeConstants.largeSpacing,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: SizeConstants.largeSpacing,
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: SizeConstants.largeSpacing * 2,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Already Have an Account?",
                style: TextStyle(
                    fontSize: 16, color: ColorConstants.kSecondayTextColor),
              ),
            ),
            const SizedBox(
              height: SizeConstants.smallSpacing,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (__) {
                    return const SignUpPage();
                  }));
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  getPassowrdContainer({color = false}) {
    return Expanded(
      child: Container(
        height: 5,
        decoration: BoxDecoration(
            color: color ? Colors.green : ColorConstants.kGreyColor,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  getDecoratedContainer(child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: child,
    );
  }

  getDecoation(hint) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: ColorConstants.kGreyColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: ColorConstants.kGreyColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 1.0),
        ),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10));
  }

  Text getTitle(value) {
    return Text(
      value,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
