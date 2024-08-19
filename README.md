# Handmade Math

LuaJIT bindings for [Handmade Math](https://github.com/HandmadeMath/HandmadeMath).


## Usage:

There are two versions of this module:
   - Bindings (Simple exposure of the C API to Lua)
   - Wrapper (A thin wrapper over the bindings; recommended)

```lua
-- To use the bindings:
local hmm = require 'path.to.hmm' -- See: hmm.lua for caveats

-- To use the wrapper:
local hmm = require 'path.to.wrapper' -- See: wrapper.lua for caveats
```


## Installation:

```sh
git clone https://github.com/judah-caruso/lua-handmademath hmm
```

## Building & Customization:

The `lib` directory contains the Handmade Math header and a few build scripts to
generate a dynamic library for LuaJIT to load. Running the `build_[os]` script
will compile Handmade Math for your platform.

To customize this module, modify `lib/HandmadeMath.c` and recompile.


## License:

Public Domain
