// Copyright 2019 Valentin B. All rights reserved.
// Licensed under GNU GPLv3 or any later version.
// Refer to the LICENSE file included.

#ifndef SWITCHCORD_INCLUDE_MESSAGE_H_
#define SWITCHCORD_INCLUDE_MESSAGE_H_

namespace switchcord {
enum MessageTypes {
  kDefault = 0,
  kRecipientAdd = 1,
  kRecipientRemove = 2,
  kCall = 3,
  kChannelNameChange = 4,
  kChannelIconChange = 5,
  kPinsAdd = 6,
  kNewMember = 7,
};
}

#endif  // SWITCHCORD_INCLUDE_MESSAGE_H_