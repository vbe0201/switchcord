<div align="center">
    <h1>Switchcord</h1>
    <strong>An unofficial Discord client for the Nintendo Switch console.</strong>
    <!-- Place badges here -->
</div>

## Disclaimer

At this point I need to clarify that using this project is at your own risk.
Quote from the [Discord ToS](https://discordapp.com/terms):  
```
RIGHTS TO USE THE SERVICE
[...] 
you agree not to (and not to attempt to) (i) use the Service for any use or purpose other than
as expressly permitted by these Terms;(ii) copy, adapt, modify, prepare derivative works based
upon, distribute, license, sell, transfer, publicly display, publicly perform, transmit, stream,
broadcast, attempt to discover any source code, reverse engineer, decompile, dissemble, or
otherwise exploit the Service or any portion of the Service, except as expressly permitted in
these Terms; or (iii) use data mining, robots, spiders, or similar data gathering and extraction
tools on the Service.
[...]
```

And a short summary:  
```
You agree not to (and not to attempt to) [...] exploit the service or any porition of the
service [...] or use data mining, robots, or similar data gathering and extraction tools
on the Service.
```

And here's another [official statement about selfbotting](https://support.discordapp.com/hc/en-us/articles/115002192352).

Literally **any** interaction with the Discord API from user accounts is prohibited and counts as selfbotting
unless it was made by official Discord services/clients.

## Support

Need help with this project? Either DM `Vale#5252` on Discord or create an issue on GitHub.

## How to build

This project is based on the [libnx](https://github.com/switchbrew/libnx) library by
[SwitchBrew](https://switchbrew.org/wiki/Main_Page). First of all, you need to setup a
[development environment](https://switchbrew.org/w/index.php?title=Setting_up_Development_Environment).

To build your .nro binary, follow these steps:
```bash
# You might want to separate all the CMake helpers from your project files.
mkdir build && cd build

# Then generate your Makefile (assuming you're inside the build directory).
cmake .. -DCMAKE_TOOLCHAIN_FILE=../devkita64-libnx.cmake

# Finally build the project.
make
```

You should now have a `switchcord.nro` binary located inside a `bin/` directory.
