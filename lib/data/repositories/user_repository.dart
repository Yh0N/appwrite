import 'package:appwrite/appwrite.dart';
import 'package:users/core/constants/appwrite_constants.dart';
import 'package:users/model/user_model.dart';

class UserRepository {
  final Databases databases;

  UserRepository(this.databases);

  Future<UserModel> createUser(UserModel user) async {
    try {
      final response = await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
        documentId: ID.unique(),
        data: user.toJson(),
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      final response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
      );

      return response.documents
          .map((doc) => UserModel.fromJson(doc.data))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// ✅ Implementación correcta del método updateUser
  Future<UserModel> updateUser(String id, UserModel updatedUser) async {
    try {
      final response = await databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.collectionId,
        documentId: id,
        data: updatedUser.toJson(),
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
  try {
    await databases.deleteDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.collectionId,
      documentId: id,
    );
  } catch (e) {
    rethrow;
  }
}


}
