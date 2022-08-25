import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/cubit/login_cubit/cubit.dart';
import 'package:la_vie/shared/cubit/login_cubit/states.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var firstNameController = TextEditingController();
          var lastNameController = TextEditingController();
          var emailController = TextEditingController();
          var passwordController = TextEditingController();
          var formKey = GlobalKey<FormState>();
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: itemLogin(
                          title: "First Name",
                          controller: firstNameController,
                          typeInput: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: itemLogin(
                          title: "Last Name",
                          controller: lastNameController,
                          typeInput: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  itemLogin(
                    title: "Email",
                    controller: emailController,
                    typeInput: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  itemLogin(
                    title: "Password",
                    controller: passwordController,
                    typeInput: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  itemLogin(
                    title: "Confirm password",
                    controller: passwordController,
                    typeInput: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  startButton(
                      text: "Login",
                      ontap: () async {
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get(context).signUpp(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              password: passwordController.text);
                        }
                        // var response = await Dio.p('/test', data: {'id': 12, 'name': 'wendu'});
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            endIndent: 10,
                            color: HexColor("#979797"),
                          ),
                        ),
                        const Text(
                          "Or continue with",
                          style: TextStyle(fontSize: 12),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            endIndent: 10,
                            color: HexColor("#979797"),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset("assets/icons/Google.svg"),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset("assets/icons/Facebook.svg"),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
