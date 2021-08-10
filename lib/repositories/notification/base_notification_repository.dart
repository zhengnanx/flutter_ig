import 'package:flutter_ig/models/models.dart';

abstract class BaseNotificationRepository {
  Stream<List<Future<Notif?>>> getUserNotifications({required String userId});
}
