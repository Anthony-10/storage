import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../image/image_display/image_display.dart';
import '../upload_screen.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logIn({required String email, required String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) => Get.off(() => const ImageDisplay()));
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error login account", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      rethrow;
    }
  }

  /*Future<void> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) => Get.off(() => UploadScreen()));
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error creating account", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      rethrow;
    }
  }*/
}
