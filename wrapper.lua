--[[
    INFORMATION
    -----------

    A Lua-like wrapper for HandmadeMath.


    LICENSE
    -------

    This software is in the public domain. Where that dedication is not
    recognized, you are granted a perpetual, irrevocable license to copy,
    distribute, and modify this file as you see fit.
--]]

local hmm = require 'hmm'
local ffi = require 'ffi'

-- This makes a C pointer work more-or-less like a 1-based Lua array.
-- Note: Due to LuaJIT not calling __len for tables, the count
-- field should be used instead.
---@return number[]
local function wrapArrayPointer(cdata, count)
   return setmetatable({ data = cdata, count = count }, {
      __index = function(t, k)
         if type(k) == 'number' then
            local i = k - 1
            if i < 0 or i >= count then
               error(('array bounds check failed! index %d (min: 1, max: %d)'):format(k, count), 2)
            end

            return t.data[i]
         else
            error(("cannot index array with value '%s'"):format(k), 2)
         end
      end,
      __newindex = function(t, k, v)
         if type(k) == 'number' then
            local i = k - 1
            if i < 0 or i >= count then
               error(('array bounds check failed! index %d (min 1, max: %d)'):format(k, count), 2)
            end

            t.data[i] = v
         else
            error(("cannot index array with value '%s'"):format(k), 2)
         end
      end,
      __len = function()
         return count
      end,
   })
end


local wrapper = {
   _version = '0.0.1',
   bindings = hmm,
}

-- Standalone function wrappers
-------------------------------

-- HANDMADE_MATH_USE_RADIANS
function wrapper.angleRad(a)  return a                 end
function wrapper.angleDeg(a)  return a * hmm.DegToRad  end
function wrapper.angleTurn(a) return a * hmm.TurnToRad end

-- HANDMADE_MATH_USE_DEGREES
-- function wrapper.angleRad(a)  return a * hmm.RadToDeg end
-- function wrapper.angleDeg(a)  return a end
-- function wrapper.angleTurn(a) return a * hmm.TurnToDeg end

-- HANDMADE_MATH_USE_TURNS
-- function wrapper.angleRad(a)  return a * hmm.RadToTurn end
-- function wrapper.angleDeg(a)  return a * hmm.DegToTurn end
-- function wrapper.angleTurn(a) return a                 end

function wrapper.radToDeg(r)  return r * hmm.RadToDeg  end
function wrapper.radToTurn(r) return r * hmm.RadToTurn end
function wrapper.degToRad(d)  return d * hmm.DegToRad  end
function wrapper.degToTurn(d) return d * hmm.DegToTurn end
function wrapper.turnToRad(t) return t * hmm.TurnToRad end
function wrapper.turnToDeg(t) return t * hmm.TurnToDeg end

function wrapper.min(a, b) return hmm.MIN(a, b) end
function wrapper.max(a, b) return hmm.MAX(a, b) end
function wrapper.abs(a)    return hmm.ABS(a)    end
function wrapper.mod(a, m) return hmm.MOD(a, m) end
function wrapper.square(x) return hmm.SQUARE(x) end

function wrapper.sin(f)             return hmm.SinF(f)            end
function wrapper.cos(f)             return hmm.CosF(f)            end
function wrapper.tan(f)             return hmm.TanF(f)            end
function wrapper.acos(f)            return hmm.ACosF(f)           end
function wrapper.sqrt(f)            return hmm.SqrtF(f)           end
function wrapper.invSqrt(f)         return hmm.InvSqrtF(f)        end
function wrapper.lerp(a, t, b)      return hmm.Lerp(a, t, b)      end
function wrapper.clamp(min, v, max) return hmm.Clamp(min, v, max) end


-- Vec2 wrapper
---------------

---@class Vec2
---@field x number
---@field y number
---@field u number
---@field v number
---@field left number
---@field right number
---@field width number
---@field height number
local Vec2 = {}
Vec2.__fields = {
   ['x'] = 'X',
   ['y'] = 'Y',

   ['u'] = 'U',
   ['v'] = 'V',

   ['left']  = 'Left',
   ['right'] = 'Right',

   ['width']  = 'Width',
   ['height'] = 'Height',
}

wrapper.Vec2 = Vec2

---@return Vec2
local function wrapV2(cvec2)
   return setmetatable({ __c = cvec2 }, Vec2)
end

function wrapper.v2(x, y)
   x = x or 0
   y = y or 0
   return wrapV2(hmm.V2(x, y))
end

---@return number
function Vec2.dot(a, b)
   return hmm.DotV2(a.__c, b.__c)
end

---@return number
function Vec2.lenSqr(v)
   return hmm.LenSqrV2(v.__c)
end

---@return number
function Vec2.len(v)
   return hmm.LenV2(v.__c)
end

function Vec2.norm(v)
   return wrapV2(hmm.NormV2(v.__c))
end

function Vec2.lerp(a, t, b)
   return wrapV2(hmm.LerpV2(a.__c, t, b.__c))
end

function Vec2.rotate(v, angle)
   return wrapV2(hmm.RotateV2(v.__c, angle))
end

-- Note, this returns a pointer to the elements, so changes to
-- the array will affect the original Vector.
---@return number[] -- returns an array of the Vector's elements.
function Vec2.elements(v)
   return wrapArrayPointer(ffi.cast('float*', v.__c), 2)
end

function Vec2.__add(l, r)
   if type(r) == 'number' then
      return wrapV2(hmm.AddV2(l.__c, hmm.V2(r, r)))
   else
      return wrapV2(hmm.AddV2(l.__c, r.__c))
   end
end

function Vec2.__sub(l, r)
   if type(r) == 'number' then
      return wrapV2(hmm.SubV2(l.__c, hmm.V2(r, r)))
   else
      return wrapV2(hmm.SubV2(l.__c, r.__c))
   end
end

function Vec2.__mul(l, r)
   if type(r) == 'number' then
      return wrapV2(hmm.MulV2F(l.__c, r))
   else
      return wrapV2(hmm.MulV2(l.__c, r.__c))
   end
end

function Vec2.__div(l, r)
   if type(r) == 'number' then
      return wrapV2(hmm.DivV2F(l.__c, r))
   else
      return wrapV2(hmm.DivV2(l.__c, r.__c))
   end
end

function Vec2.__eq(l, r)
   return hmm.EqV2(l.__c, r.__c) == 1
end

function Vec2.__tostring(v)
   return ('(%.2f, %.2f)'):format(v.__c.X, v.__c.Y)
end

function Vec2.__index(v, k)
   local f = Vec2.__fields[k]
   if f ~= nil then
      return v.__c[f]
   end

   if type(Vec2[k]) == 'function' then
      return Vec2[k]
   end

   return rawget(v, k)
end

function Vec2.__newindex(v, k, val)
   local f = Vec2.__fields[k]
   if f ~= nil then
      v.__c[f] = val
   else
      rawset(v, k, val)
   end
end



-- Vec3 wrapper
---------------

---@class Vec3
---@field x number
---@field y number
---@field z number
---@field u number
---@field v number
---@field w number
---@field r number
---@field g number
---@field b number
local Vec3 = {}
Vec3.__fields = {
   ['x'] = 'X',
   ['y'] = 'Y',
   ['z'] = 'Z',

   ['u'] = 'U',
   ['v'] = 'V',
   ['w'] = 'W',

   ['r'] = 'R',
   ['g'] = 'G',
   ['b'] = 'B',
}

wrapper.Vec3 = Vec3

---@return Vec3
local function wrapV3(cvec3)
   return setmetatable({ __c = cvec3 }, Vec3)
end

function wrapper.v3(x, y, z)
   x = x or 0
   y = y or 0
   z = z or 0
   return wrapV3(hmm.V3(x, y, z))
end

---@return number
function Vec3.dot(a, b)
   return hmm.DotV3(a.__c, b.__c)
end

---@return number
function Vec3.lenSqr(v)
   return hmm.LenSqrV3(v.__c)
end

---@return number
function Vec3.len(v)
   return hmm.LenV3(v.__c)
end

function Vec3.cross(a, b)
   return wrapV3(hmm.Cross(a.__c, b.__c))
end

function Vec3.norm(v)
   return wrapV3(hmm.NormV3(v.__c))
end

function Vec3.lerp(a, t, b)
   return wrapV3(hmm.LerpV3(a.__c, t, b.__c))
end

function Vec3.rotateLH(v, axis, angle)
   return wrapV3(hmm.RotateV3AxisAngle_LH(v.__c, axis.__c, angle))
end

function Vec3.rotateRH(v, axis, angle)
   return wrapV3(hmm.RotateV3AxisAngle_RH(v.__c, axis.__c, angle))
end

function Vec3.rotateQ(v, quat)
   return wrapV3(hmm.RotateV3Q(v.__c, quat.__c))
end

function Vec3.xy(v) return wrapV2(hmm.V2(v.__c.X, v.__c.Y)) end
function Vec3.yz(v) return wrapV2(hmm.V2(v.__c.Y, v.__c.Z)) end
function Vec3.uv(v) return wrapV2(hmm.V2(v.__c.U, v.__c.V)) end
function Vec3.vw(v) return wrapV2(hmm.V2(v.__c.V, v.__c.W)) end

-- Note, this returns a pointer to the elements, so changes to
-- the array will affect the original Vector.
---@return number[] -- returns an array of the Vector's elements.
function Vec3.elements(v)
   return wrapArrayPointer(ffi.cast('float*', v.__c), 3)
end

function Vec3.__add(l, r)
   if type(r) == 'number' then
      return wrapV3(hmm.AddV3(l.__c, hmm.V3(r, r)))
   else
      return wrapV3(hmm.AddV3(l.__c, r.__c))
   end
end

function Vec3.__sub(l, r)
   if type(r) == 'number' then
      return wrapV3(hmm.SubV3(l.__c, hmm.V3(r, r)))
   else
      return wrapV3(hmm.SubV3(l.__c, r.__c))
   end
end

function Vec3.__mul(l, r)
   if type(r) == 'number' then
      return wrapV3(hmm.MulV3F(l.__c, r))
   else
      return wrapV3(hmm.MulV3(l.__c, r.__c))
   end
end

function Vec3.__div(l, r)
   if type(r) == 'number' then
      return wrapV3(hmm.DivV3F(l.__c, r))
   else
      return wrapV3(hmm.DivV3(l.__c, r.__c))
   end
end

function Vec3.__eq(l, r)
   return hmm.EqV3(l.__c, r.__c) == 1
end

function Vec3.__tostring(v)
   return ('(%.2f, %.2f, %.2f)'):format(v.__c.X, v.__c.Y, v.__c.Z)
end

function Vec3.__index(v, k)
   local f = Vec3.__fields[k]
   if f ~= nil then
      return v.__c[f]
   end

   if type(Vec3[k]) == 'function' then
      return Vec3[k]
   end

   return rawget(v, k)
end

function Vec3.__newindex(v, k, val)
   local f = Vec3.__fields[k]
   if f ~= nil then
      v.__c[f] = val
   else
      rawset(v, k, val)
   end
end

return wrapper
