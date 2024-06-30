import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  Future<void> loginAdmin(String email, String password) async {
    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        "Login",
        "Login Successfully",
        duration: const Duration(seconds: 3),
      );
      isLoading.value = false;
    } catch (e) {
      Get.snackbar(
        "Login",
        "Login Successfully",
        duration: const Duration(seconds: 3),
      );
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
