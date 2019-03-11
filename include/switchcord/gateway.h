// Copyright 2019 Valentin B. All rights reserved.
// Licensed under GNU GPLv3 or any later version.
// Refer to the LICENSE file included.

#ifndef SWITCHCORD_INCLUDE_GATEWAY_H_
#define SWITCHCORD_INCLUDE_GATEWAY_H_

namespace switchcord {
enum GatewayOpcodes {
  kDispatch = 0,
  kHeartbeat = 1,
  kIdentify = 2,
  kPresence = 3,
  kVoiceState = 4,
  kVoicePing = 5,
  kResume = 6,
  kReconnect = 7,
  kRequestMembers = 8,
  kInvalidateSession = 9,
  kHello = 10,
  kHeartbeatAck = 11,
  kGuildSync = 12,
};
}

#endif  // SWITCHCORD_INCLUDE_GATEWAY_H_