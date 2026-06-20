
import 'package:expense_tracker/data/models/profile_models.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

  ProfileModels? profile;

  void addProfile(ProfileModels newProfile) {
    profile = newProfile;
    update();
  }

  void updateProfile(ProfileModels newProfile) {
    profile = newProfile;
    update();
  }


}