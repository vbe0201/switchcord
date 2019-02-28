// Copyright 2019 Valentin B. All rights reserved.
// Licensed under GNU GPLv3 or any later version.
// Refer to the LICENSE file included.

#ifndef SWITCHCORD_INCLUDE_VOICE_H_
#define SWITCHCORD_INCLUDE_VOICE_H_

namespace switchcord {
  enum VoiceRegions {
    kUsWest = "us-west",
    kUsEast = "us-east",
    kUsSouth = "us-south",
    kUsCentral = "us-central",
    kEuWest = "eu-west",
    kEuCentral = "eu-central",
    kSingapore = "singapore",
    kLondon = "london",
    kSydney = "sydney",
    kAmsterdam = "amsterdam",
    kFrankfurt = "frankfurt",
    kBrazil = "brazil",
    kHongKong = "hongkong",
    kRussia = "russia",
    kJapan = "japan",
    kSouthafrica = "southafrica",
    kVipUsEast = "vip-us-east",
    kVipUsWest = "vip-us-west",
    kVipAmsterdam = "vip-amsterdam",
  };

  enum SpeakingStates {
    kNone = 0,
    kVoice = 1,
    kSoundshare = 2,
    kPriority = 4,
  };

  enum VoiceOpcodes {
    kIdentify = 0,
    kSelectProtocol = 1,
    kReady = 2,
    kHeartbeat = 3,
    kSessionDescription = 4,
    kSpeaking = 5,
    kHeartbeatAck = 6,
    kResume = 7,
    kHello = 8,
    kResumed = 9,
    kClientConnect = 12,
    kClientDisconnect = 13,
  };
}

#endif // SWITCHCORD_INCLUDE_VOICE_H_