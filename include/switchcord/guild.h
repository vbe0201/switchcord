// Copyright 2019 Valentin B. All rights reserved.
// Licensed under GNU GPLv3 or any later version.
// Refer to the LICENSE file included.

#ifndef SWITCHCORD_INCLUDE_GUILD_H_
#define SWITCHCORD_INCLUDE_GUILD_H_

namespace switchcord {
enum VerificationLevels {
  kNone = 0,
  kLow = 1,
  kMedium = 2,
  kHigh = 3,
  kTableFlip = 3,
  kExtreme = 4,
  kDoubleTableFlip = 4,
};

enum ContentFilters {
  kDisabled = 0,
  kNoRoles = 1,
  kAllMembers = 2,
};

enum NotificationLevels {
  kAllMessages = 0,
  kOnlyMentions = 1,
};

enum AuditLogActionCategories {
  kCreate = 1,
  kDelete = 2,
  kUpdate = 3,
};

enum AuditLogActions {
  kGuildUpdate = 1,
  kChannelCreate = 10,
  kChannelUpdate = 11,
  kChannelDelete = 12,
  kOverwriteCreate = 13,
  kOverwriteUpdate = 14,
  kOverwriteDelete = 15,
  kKick = 20,
  kMemberPrune = 21,
  kBan = 22,
  kUnban = 23,
  kMemberUpdate = 24,
  kMemberRoleUpdate = 25,
  kRoleCreate = 30,
  kRoleUpdate = 31,
  kRoleDelete = 32,
  kInviteCreate = 40,
  kInviteUpdate = 41,
  kInviteDelete = 42,
  kWebhookCreate = 50,
  kWebhookUpdate = 51,
  kWebhookDelete = 52,
  kEmojiCreate = 60,
  kEmojiUpdate = 61,
  kEmojiDelete = 62,
  kMessageDelete = 72,
};
}  // namespace switchcord

#endif  // SWITCHCORD_INCLUDE_GUILD_H_