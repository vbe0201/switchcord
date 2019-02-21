// Copyright 2019 Valentin B. All rights reserved.
// Licensed under GNU GPLv3 or any later version.
// Refer to the LICENSE file included.

#include <iostream>

#include <switch.h>

int main(int argc, char **argv) {
    consoleInit(nullptr);

    std::cout << "Hello World!" << std::endl;

    // main loop
    while (appletMainLoop()) {
        // Scan all the inputs. This should be done once for each frame.
        hidScanInput();

        u64 key_down = hidKeysDown(CONTROLLER_P1_AUTO);

        if (key_down & KEY_PLUS) break; // break in order to return to hbmenu

        consoleUpdate(nullptr);
    }

    consoleExit(nullptr);
    return 0;
}