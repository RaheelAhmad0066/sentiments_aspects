import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../view/sidebar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool ispasswordvisible = true;
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffC3ECFE),
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Image.asset(
              "assets/images/logo.jpg",
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Color.fromARGB(255, 139, 208, 237),
              child: Padding(
                padding: const EdgeInsets.only(left: 60, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      "Sentiments Anaylsis",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Log in",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        // fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                      width: size.width * 0.32,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter you email',
                            hintStyle: TextStyle(fontSize: 13),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(
                        // fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                      width: size.width * 0.32,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextField(
                          controller: passwordController,
                          obscureText: ispasswordvisible,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Enter you password',
                            filled: true,
                            hintStyle: TextStyle(fontSize: 13),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  ispasswordvisible = !ispasswordvisible;
                                });
                              },
                              icon: Icon(
                                ispasswordvisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                      width: size.width * 0.31,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffC3ECFE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            // Check if the entered credentials belong to an admin
                            if (emailController.text ==
                                    "sameerch1091@gmail.com" &&
                                passwordController.text == "sameer123") {
                              // Login as admin
                              await authController.loginAdmin(
                                emailController.text,
                                passwordController.text,
                              );

                              // Check if login was successful to navigate
                              if (authController.isLoading.value == false) {
                                Get.to(
                                    Sidebar()); // Navigate to home screen using GetX
                              }
                            } else {
                              Get.snackbar(
                                  'Error', 'Invalid credentials for admin',
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          } else {
                            Get.snackbar('Error', 'Please fill in all fields',
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        child: Obx(
                          () => authController.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : Text(
                                  "Log in",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
