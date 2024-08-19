# HandmadeMath

LuaJIT bindings for HandmadeMath.


## Installation:

`git clone https://github.com/judah-caruso/handmademath hmm`


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
