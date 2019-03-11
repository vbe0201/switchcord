// Copyright 2019 Valentin B. All rights reserved.
// Licensed under GNU GPLv3 or any later version.
// Refer to the LICENSE file included.

#ifndef SWITCHCORD_INCLUDE_VOICE_H_
#define SWITCHCORD_INCLUDE_VOICE_H_

namespace switchcord {
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
}  // namespace switchcord

#endif  // SWITCHCORD_INCLUDE_VOICE_H_