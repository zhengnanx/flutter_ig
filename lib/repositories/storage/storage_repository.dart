import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_ig/repositories/repositories.dart';
import 'package:uuid/uuid.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({FirebaseStorage? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> _uploadImage({
    required File image,
    required String ref,
  }) async {
    final downloadUrl = await _firebaseStorage
        .ref(ref)
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    return downloadUrl;
  }

  @override
  Future<String> uploadPostImage({required File image}) async {
    final imgaeId = Uuid().v4();
    final downloadUrl =
        await _uploadImage(image: image, ref: 'images/posts/post_$imgaeId.jpg');
    return downloadUrl;
  }

  @override
  Future<String> uploadProfileImage(
      {required String url, required File image}) async {
    var imgaeId = Uuid().v4();

    if (url.isNotEmpty) {
      final exp = RegExp(r'userProfile_(.*).jpg');
      imgaeId = exp.firstMatch(url)![1]!;
    }

    final downloadUrl = await _uploadImage(
        image: image, ref: 'images/users/userProfile_$imgaeId.jpg');
    return downloadUrl;
  }
}
