// Copyright 2019 Valentin B. All rights reserved.
// Licensed under GNU GPLv3 or any later version.
// Refer to the LICENSE file included.

#ifndef SWITCHCORD_INCLUDE_CHANNEL_H_
#define SWITCHCORD_INCLUDE_CHANNEL_H_

namespace switchcord {
  enum ChannelTypes {
    kText = 0,
    kPrivate = 1,
    kVoice = 2,
    kGroup = 3,
    kCategory = 4,
  };
}

#endif // SWITCHCORD_INCLUDE_CHANNEL_H_