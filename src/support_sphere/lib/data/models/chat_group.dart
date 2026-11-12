import 'package:equatable/equatable.dart';
import 'package:support_sphere/data/models/generated_classes.dart';

class ChatGroup extends Equatable {
  final String id;
  final String name;
  final String lastMessage;
  final String? description;
  final List<String> members;
  final GROUP_CHAT_TYPE type;
  final int unreadCount;
  final RESERVATION_STATUS? reservationStatus;
  final bool isRequester;

  const ChatGroup({
    required this.id,
    required this.name,
    required this.lastMessage,
    this.description,
    required this.members,
    required this.type,
    required this.unreadCount,
    this.reservationStatus,
    this.isRequester = false,
  });

  factory ChatGroup.from(
    String id,
    String name, {
    List<String> members = const [],
    String? description,
    String lastMessage = '',
    GROUP_CHAT_TYPE type = GROUP_CHAT_TYPE.chat,
    int unreadCount = 0,
    RESERVATION_STATUS? reservationStatus,
    bool isRequester = false,
  }) {
    return ChatGroup(
      id: id,
      name: name,
      lastMessage: lastMessage,
      description: description,
      members: members,
      type: type,
      unreadCount: unreadCount,
      reservationStatus: reservationStatus,
      isRequester: isRequester,
    );
  }

  /// For saving the inbox on the device (see OfflineCache).
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'last_message': lastMessage,
        'description': description,
        'members': members,
        'type': type.name,
        'unread_count': unreadCount,
        'reservation_status': reservationStatus?.name,
        'is_requester': isRequester,
      };

  factory ChatGroup.fromJson(Map<String, dynamic> json) {
    final status = json['reservation_status'] as String?;
    return ChatGroup(
      id: json['id'],
      name: json['name'],
      lastMessage: json['last_message'],
      description: json['description'],
      members: (json['members'] as List).cast<String>(),
      type: GROUP_CHAT_TYPE.values.byName(json['type']),
      unreadCount: json['unread_count'],
      reservationStatus:
          status == null ? null : RESERVATION_STATUS.values.byName(status),
      isRequester: json['is_requester'],
    );
  }

  ChatGroup copyWith({
    RESERVATION_STATUS? reservationStatus,
    bool? isRequester,
  }) {
    return ChatGroup(
      id: id,
      name: name,
      lastMessage: lastMessage,
      description: description,
      members: members,
      type: type,
      unreadCount: unreadCount,
      reservationStatus: reservationStatus ?? this.reservationStatus,
      isRequester: isRequester ?? this.isRequester,
    );
  }

  @override
  List<Object?> get props => [id, name, members, reservationStatus, isRequester];
}
