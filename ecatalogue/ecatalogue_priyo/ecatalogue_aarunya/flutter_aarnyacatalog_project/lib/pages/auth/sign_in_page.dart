import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aarnyacatalog_project/base/custom_loader.dart';
import 'package:flutter_aarnyacatalog_project/base/show_custom_snackbar.dart';
import 'package:flutter_aarnyacatalog_project/pages/auth/sign_up_page.dart';
import 'package:flutter_aarnyacatalog_project/routes/route_helper.dart';
import 'package:flutter_aarnyacatalog_project/utils/colors.dart';
import 'package:flutter_aarnyacatalog_project/utils/dimensions.dart';
import 'package:flutter_aarnyacatalog_project/widgets/app_text_field.dart';
import 'package:flutter_aarnyacatalog_project/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        ShowCustomSnackBar("Type in your email address",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomSnackBar("Type in a valid email address",
            title: "Email address");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("Type in your password", title: "password");
      } else if (password.length < 6) {
        ShowCustomSnackBar("Password can not less than six characters",
            title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
                //applogo
                Container(
                  height: Dimensions.screenHeight * 0.25,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: Dimensions.radius20 * 4,
                      backgroundImage: AssetImage("assets/images/logo3.png"),
                    ),
                  ),
                ),
                //Welcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.widht20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                            fontSize:
                                Dimensions.font20 * 3 + Dimensions.font20 / 2,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Sign into your account ",
                        style: TextStyle(
                            fontSize: Dimensions.font20,
                            color: Colors.grey[500]),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //Your email
                AppTextField(
                    textController: emailController,
                    hintText: "Email",
                    iconData: Icons.email),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //Your Passwords
                AppTextField(
                  textController: passwordController,
                  hintText: "Password",
                  iconData: Icons.password_sharp,
                  isObscure: true,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),

                //tag line
                Row(
                  children: [
                    Expanded(child: Container()),
                    RichText(
                        text: TextSpan(
                            text: "Sign into your account",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20))),
                    SizedBox(
                      width: Dimensions.widht20,
                    )
                  ],
                ),

                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
                //sign in button
                GestureDetector(
                  onTap: () {
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth / 2,
                    height: Dimensions.screenHeight / 13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: BigText(
                        text: "Sign in",
                        size: Dimensions.font20 + Dimensions.font20 / 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
                //sign up options
                RichText(
                    text: TextSpan(
                        text: "Don\'t an account?",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20),
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => SignUpPage(),
                                transition: Transition.fade),
                          text: " Create",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20))
                    ])),
              ],
            ),
          ):const CustomLoader();
        }));
  }
}
