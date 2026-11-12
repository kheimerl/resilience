import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:support_sphere/data/models/chat_group.dart';
import 'package:support_sphere/data/models/generated_classes.dart';

void main() {
  test('a chat group survives being saved and loaded', () {
    const group = ChatGroup(
      id: 'g1',
      name: 'Water',
      lastMessage: 'On my way',
      description: null,
      members: ['a', 'b'],
      type: GROUP_CHAT_TYPE.request_consumable,
      unreadCount: 3,
      reservationStatus: RESERVATION_STATUS.tentative,
      isRequester: true,
    );
    final loaded = ChatGroup.fromJson(
        jsonDecode(jsonEncode(group.toJson())) as Map<String, dynamic>);
    expect(loaded, group);
    expect(loaded.lastMessage, group.lastMessage);
    expect(loaded.type, group.type);
    expect(loaded.unreadCount, group.unreadCount);
  });

  test('a chat group without a reservation round-trips', () {
    final group = ChatGroup.from('g2', 'Chat', members: ['a']);
    final loaded = ChatGroup.fromJson(
        jsonDecode(jsonEncode(group.toJson())) as Map<String, dynamic>);
    expect(loaded, group);
    expect(loaded.reservationStatus, isNull);
  });
}
