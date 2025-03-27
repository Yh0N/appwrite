import 'package:get/get.dart';
import 'package:users/model/user_model.dart';
import 'package:users/data/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository repository;

  UserController({required this.repository});

  // Estado reactivo
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      final fetchedUsers = await repository.getUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      error.value = e.toString();
      users.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      final newUser = await repository.createUser(user);
      users.add(newUser);
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future<void> updateUser(String id, UserModel updatedUser) async {
    try {
      final updated = await repository.updateUser(id, updatedUser);
      int index = users.indexWhere((user) => user.id == id);
      if (index != -1) {
        users[index] = updated;
        users.assignAll([...users]); 
      }
    } catch (e) {
      error.value = e.toString();
    }
  }


  Future<void> deleteUser(String id) async {
    try {
      await repository.deleteUser(id);
      users.removeWhere((user) => user.id == id);
    } catch (e) {
      error.value = e.toString();
    }
  }

}