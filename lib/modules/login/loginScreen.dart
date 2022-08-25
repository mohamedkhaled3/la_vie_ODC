import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/cubit/login_cubit/cubit.dart';
import 'package:la_vie/shared/cubit/login_cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var loginCubit = LoginCubit.get(context);
          var emailController = TextEditingController();
          var passwordController = TextEditingController();
          var formKey = GlobalKey<FormState>();

          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
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
                      passwordShow: loginCubit.isPasswordShow,
                      suffix: loginCubit.suffix,
                      // suffixColor: loginCubit.suffixColor,
                      suffixPressed: () {
                        loginCubit.changeSuffixIcon();
                      },
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      onSubmit: (value) async {
                        if (formKey.currentState!.validate()) {
                          loginCubit.logIn(context,
                              email: emailController.text,
                              password: passwordController.text);
                          // dio.options.headers = {
                          //   'Authorization': 'Bearer ${token ?? ''}',
                          // };
                          // return await dio.post(url, data: data).then((value) {
                          //   return value;
                          // }).catchError((onError) {
                          //   if (onError is DioError) {
                          //     print('vaerrrr--------->');
                          //     print(onError.response!.statusCode);
                          //     showToast(
                          //         message: onError.response!.data['message'].toString(),
                          //         color: Colors.red);
                          //   }
                          // });

                          // await Dio(
                          //   BaseOptions(
                          //     baseUrl:
                          //         'https://lavie.orangedigitalcenteregypt.com',
                          //     receiveDataWhenStatusError: true,
                          //     headers: {
                          //       'Accept': 'application/json',
                          //       'Content-Type': 'application/json'
                          //     },
                          //   ),
                          // ).post(LOGIN, data: {
                          //   'email': emailController.text,
                          //   'password': passwordController.text
                          // });

//                                 LoginCubit.get(context).userLogin(
//                                     email: emailController.text,
//                                     password: passwordController.text);
// // navigateTo(context, HomeLayoutScreen());
                        }
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  ConditionalBuilder(
                    condition: state is! LoginLoadingState,
                    builder: (BuildContext context) {
                      return startButton(
                          text: "Login",
                          ontap: () async {
                            if (formKey.currentState!.validate()) {
                              loginCubit.logIn(context,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          });
                    },
                    fallback: (BuildContext context) =>
                        CircularProgressIndicator(
                      color: HexColor("#1ABC00"),
                    ),
                  ),
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
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var emailController = TextEditingController();
//     var passwordController = TextEditingController();
//     var formKey = GlobalKey<FormState>();
//     Map<String, dynamic>? query;
//     Map<String, dynamic> data;
//     return SingleChildScrollView(
//       child: Form(
//         key: formKey,
//         child: Column(
//           children: [
//             itemLogin(
//               title: "Email",
//               controller: emailController,
//               typeInput: TextInputType.emailAddress,
//               validate: (value) {
//                 if (value!.isEmpty) {
//                   return "This field is required";
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             itemLogin(
//               title: "Password",
//               controller: passwordController,
//               typeInput: TextInputType.visiblePassword,
//               validate: (value) {
//                 if (value!.isEmpty) {
//                   return "This field is required";
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             startButton(
//                 text: "Login",
//                 ontap: () async {
//                   if (formKey.currentState!.validate()) {
//                     try {
//                       var response = await Dio().post(
//                           "https://lavie.orangedigitalcenteregypt.com",
//                           queryParameters: {},
//                           data: {
//                             emailController.text,
//                             passwordController.text,
//                           });
//                       print(response);
//                     } catch (e) {
//                       print(e);
//                     }
//
//     if (formKey.currentState!.validate()) {
//                                 LoginCubit.get(context).userLogin(
//                                     email: emailController.text,
//                                     password: passwordController.text);
// // navigateTo(context, HomeLayoutScreen());
//                               }
//
//                   }
//                 }),
//             const SizedBox(
//               height: 25,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Divider(
//                       thickness: 1,
//                       endIndent: 10,
//                       color: HexColor("#979797"),
//                     ),
//                   ),
//                   const Text(
//                     "Or continue with",
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   Expanded(
//                     child: Divider(
//                       thickness: 1,
//                       endIndent: 10,
//                       color: HexColor("#979797"),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () {},
//                   child: SvgPicture.asset("assets/icons/Google.svg"),
//                 ),
//                 const SizedBox(
//                   width: 25,
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: SvgPicture.asset("assets/icons/Facebook.svg"),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
