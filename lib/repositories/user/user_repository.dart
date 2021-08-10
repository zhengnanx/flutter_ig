import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ig/config/paths.dart';
import 'package:flutter_ig/enums/enums.dart';
import 'package:flutter_ig/models/models.dart';
import 'package:flutter_ig/models/user_model.dart';
import 'package:flutter_ig/repositories/user/base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<User> getUserWithId({required String userId}) async {
    final doc =
        await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    return doc.exists ? User.fromDocument(doc) : User.empty;
  }

  @override
  Future<void> updateUser({required User user}) async {
    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user.id)
        .update(user.toDocument());
  }

  @override
  Future<List<User>> searchUsers({required String query}) async {
    final userSnap = await _firebaseFirestore
        .collection(Paths.users)
        .where('username', isGreaterThanOrEqualTo: query)
        .get();
    return userSnap.docs.map((doc) => User.fromDocument(doc)).toList();
  }

  @override
  void followUser({required String userId, required String followUserId}) {
    //add followUser to users' userfollowing
    _firebaseFirestore
        .collection(Paths.following)
        .doc(userId)
        .collection(Paths.userFollowing)
        .doc(followUserId)
        .set({});

    //add user to followuser's userfollowers
    _firebaseFirestore
        .collection(Paths.followers)
        .doc(followUserId)
        .collection(Paths.userFollowers)
        .doc(userId)
        .set({});
    final notification = Notif(
        type: NotifType.follow,
        fromUser: User.empty.copyWith(id: userId),
        date: DateTime.now());

    _firebaseFirestore
        .collection(Paths.notifications)
        .doc(userId)
        .collection(Paths.userNotifications)
        .add(notification.toDocument());
  }

  @override
  Future<bool> isFollowing(
      {required String userId, required String otherUserId}) async {
    // is otherUser in user's userFollowing
    final otherUserDoc = await _firebaseFirestore
        .collection(Paths.following)
        .doc(userId)
        .collection(Paths.userFollowing)
        .doc(otherUserId)
        .get();
    return otherUserDoc.exists;
  }

  @override
  void unfollowUser({required String userId, required String unfollowUserId}) {
    // remove unfollowUser from user's following
    _firebaseFirestore
        .collection(Paths.following)
        .doc(userId)
        .collection(Paths.userFollowing)
        .doc(unfollowUserId)
        .delete();

    // remove user from unfollowuser's userFollower
    _firebaseFirestore
        .collection(Paths.followers)
        .doc(unfollowUserId)
        .collection(Paths.userFollowers)
        .doc(userId)
        .delete();
  }
}
