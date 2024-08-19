# Handmade Math

LuaJIT bindings for [Handmade Math](https://github.com/HandmadeMath/HandmadeMath).


## Installation:

```sh
git clone https://github.com/judah-caruso/handmademath hmm
```

## Building & Customization:

The `lib` directory contains the Handmade Math library and a few build scripts to
generate a dynamic library for LuaJIT to load.

Simply run the `build_[os]` script for your platform.

To customize the library, modify `HandmadeMath.c` and recompile.


## Usage:

There's two versions of this library:
   - Bindings (HMM how you'd use it from C)
   - Wrapper (A thin lua-like wrapper over the bindings)

```lua
-- To use the bindings:
local hmm = require 'path.to.lib.hmm' -- See: hmm.lua for caveats/differences

-- To use the wrapper:
local hmm = require 'path.to.lib.wrapper' -- See: wrapper.lua for usage information
```


## License:

Public Domain
