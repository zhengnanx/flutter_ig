import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseStorageRepository {
  Future<String> uploadProfileImage({required String url, required File image});
  Future<String> uploadPostImage({required File image});
}
