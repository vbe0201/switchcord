// Copyright 2019 Valentin B. All rights reserved.
// Licensed under GNU GPLv3 or any later version.
// Refer to the LICENSE file included.

#ifndef SWITCHCORD_INCLUDE_USER_H_
#define SWITCHCORD_INCLUDE_USER_H_

namespace switchcord {
enum StatusTypes {
  kOnline = "online",
  kOffline = "offline",
  kIdle = "idle",
  kDnd = "dnd",
  kDoNotDisturb = "dnd",
  kInvisible = "invisible",
};

enum DefaultAvatars {
  kBlurple = 0,
  kGrey = 1,
  kGray = 1,
  kGreen = 2,
  kOrange = 3,
  kRed = 4,
};

enum RelationshipTypes {
  kFriend = 1,
  kBlocked = 2,
  kIncomingRequest = 3,
  kOutgoingRequest = 4,
};

enum UserFlags {
  kStaff = 1,
  kPartner = 2,
  kHypesquad = 4,
  kBugHunter = 8,
  kHypesquadBravery = 64,
  kHypesquadBrilliance = 128,
  kHypesquadBalance = 256,
  kEarlySupporter = 512,
};

enum ActivityTypes {
  kUnknown = -1,
  kPlaying = 0,
  kStreaming = 1,
  kListening = 2,
  kWatching = 3,
};

enum HypesquadHouses {
  kBravery = 1,
  kBrilliance = 2,
  kBalance = 3,
};

enum PremiumType {
  kNitroClassic = 1,
  kNitro = 2,
};
}  // namespace switchcord

#endif  // SWITCHCORD_INCLUDE_USER_H_