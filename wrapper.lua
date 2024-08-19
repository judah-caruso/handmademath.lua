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

local wrapper = {}

function wrapper.RadToDeg(a)  return a * hmm.RadToDeg  end
function wrapper.RadToTurn(a) return a * hmm.RadToTurn end
function wrapper.DegToRad(a)  return a * hmm.DegToRad  end
function wrapper.DegToTurn(a) return a * hmm.DegToTurn end
function wrapper.TurnToRad(a) return a * hmm.TurnToRad end
function wrapper.TurnToDeg(a) return a * hmm.TurnToDeg end

function wrapper.AngleRad(a)  return a * hmm.RadToTurn end
function wrapper.AngleDeg(a)  return a * hmm.DegToTurn end
function wrapper.AngleTurn(a) return a                 end

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
function wrapper.invsqrt(f)         return hmm.InvSqrtF(f)        end
function wrapper.lerp(a, t, b)      return hmm.Lerp(a, t, b)      end
function wrapper.clamp(min, v, max) return hmm.Clamp(min, v, max) end



-- V2 wrapper
---------------

---@class V2
---@field x number
---@field y number
---@field z number
---@field u number
---@field v number
---@field w number
---@field r number
---@field g number
---@field b number
---@field elements number[]
local V2 = {}
V2.__fields = {
   ['x'] = 'X',
   ['y'] = 'Y',

   ['u'] = 'U',
   ['v'] = 'V',

   ['left']  = 'Left',
   ['right'] = 'Right',

   ['width']  = 'Width',
   ['height'] = 'Height',

   ['elements'] = 'Elements',
}

wrapper.V2 = V2

---@return V2
local function wrapV2(hmm_vec2)
   return setmetatable({ __c = hmm_vec2 }, V2)
end

function wrapper.v2(x, y)
   x = x or 0
   y = y or 0
   return wrapV2(hmm.V2(x, y))
end

---@return number
function V2.dot(a, b)
   return hmm.DotV2(a.__c, b.__c)
end

---@return number
function V2.lenSqr(v)
   return hmm.LenSqrV2(v.__c)
end

---@return number
function V2.len(v)
   return hmm.LenV2(v.__c)
end

function V2.norm(v)
   return wrapV2(hmm.NormV2(v.__c))
end

function V2.lerp(a, t, b)
   return wrapV2(hmm.LerpV2(a.__c, t, b.__c))
end

function V2.rotate(v, angle)
   return wrapV2(hmm.RotateV2(v.__c, angle))
end

function V2.__add(l, r)
   if type(r) == 'number' then
      return wrapV2(hmm.AddV2(l.__c, hmm.V2(r, r)))
   else
      return wrapV2(hmm.AddV2(l.__c, r.__c))
   end
end

function V2.__sub(l, r)
   if type(r) == 'number' then
      return wrapV2(hmm.SubV2(l.__c, hmm.V2(r, r)))
   else
      return wrapV2(hmm.SubV2(l.__c, r.__c))
   end
end

function V2.__mul(l, r)
   if type(r) == 'number' then
      return wrapV2(hmm.MulV2F(l.__c, r))
   else
      return wrapV2(hmm.MulV2(l.__c, r.__c))
   end
end

function V2.__div(l, r)
   if type(r) == 'number' then
      return wrapV2(hmm.DivV2F(l.__c, r))
   else
      return wrapV2(hmm.DivV2(l.__c, r.__c))
   end
end

function V2.__eq(l, r)
   return hmm.EqV2(l.__c, r.__c) == 1
end

function V2.__tostring(v)
   return ('(%.2f, %.2f)'):format(v.__c.X, v.__c.Y)
end

function V2.__index(v, k)
   local f = V2.__fields[k]
   if f ~= nil then
      return v.__c[f]
   end

   if type(V2[k]) == 'function' then
      return V2[k]
   end

   return rawget(v, k)
end

function V2.__newindex(v, k, val)
   local f = V2.__fields[k]
   if f ~= nil then
      v.__c[f] = val
   else
      rawset(v, k, val)
   end
end



-- V3 wrapper
---------------

---@class V3
---@field x number
---@field y number
---@field z number
---@field u number
---@field v number
---@field w number
---@field r number
---@field g number
---@field b number
---@field elements number[]
local V3 = {}
V3.__fields = {
   ['x'] = 'X',
   ['y'] = 'Y',
   ['z'] = 'Z',

   ['u'] = 'U',
   ['v'] = 'V',
   ['w'] = 'W',

   ['r'] = 'R',
   ['g'] = 'G',
   ['b'] = 'B',

   ['elements'] = 'Elements',
}

wrapper.V3 = V3

---@return V3
local function wrapV3(hmm_vec3)
   return setmetatable({ __c = hmm_vec3 }, V3)
end

function wrapper.v3(x, y, z)
   x = x or 0
   y = y or 0
   z = z or 0
   return wrapV3(hmm.V3(x, y, z))
end

---@return number
function V3.dot(a, b)
   return hmm.DotV3(a.__c, b.__c)
end

---@return number
function V3.lenSqr(v)
   return hmm.LenSqrV3(v.__c)
end

---@return number
function V3.len(v)
   return hmm.LenV3(v.__c)
end

function V3.cross(a, b)
   return wrapV3(hmm.Cross(a.__c, b.__c))
end

function V3.norm(v)
   return wrapV3(hmm.NormV3(v.__c))
end

function V3.lerp(a, t, b)
   return wrapV3(hmm.LerpV3(a.__c, t, b.__c))
end

function V3.rotateLH(v, axis, angle)
   return wrapV3(hmm.RotateV3AxisAngle_LH(v.__c, axis.__c, angle))
end

function V3.rotateRH(v, axis, angle)
   return wrapV3(hmm.RotateV3AxisAngle_RH(v.__c, axis.__c, angle))
end

function V3.rotateQ(v, quat)
   return wrapV3(hmm.RotateV3Q(v.__c, quat.__c))
end

function V3.xy(v) return wrapV2(hmm.V2(v.__c.X, v.__c.Y)) end
function V3.yz(v) return wrapV2(hmm.V2(v.__c.Y, v.__c.Z)) end
function V3.uv(v) return wrapV2(hmm.V2(v.__c.U, v.__c.V)) end
function V3.vw(v) return wrapV2(hmm.V2(v.__c.V, v.__c.W)) end

function V3.__add(l, r)
   if type(r) == 'number' then
      return wrapV3(hmm.AddV3(l.__c, hmm.V3(r, r)))
   else
      return wrapV3(hmm.AddV3(l.__c, r.__c))
   end
end

function V3.__sub(l, r)
   if type(r) == 'number' then
      return wrapV3(hmm.SubV3(l.__c, hmm.V3(r, r)))
   else
      return wrapV3(hmm.SubV3(l.__c, r.__c))
   end
end

function V3.__mul(l, r)
   if type(r) == 'number' then
      return wrapV3(hmm.MulV3F(l.__c, r))
   else
      return wrapV3(hmm.MulV3(l.__c, r.__c))
   end
end

function V3.__div(l, r)
   if type(r) == 'number' then
      return wrapV3(hmm.DivV3F(l.__c, r))
   else
      return wrapV3(hmm.DivV3(l.__c, r.__c))
   end
end

function V3.__eq(l, r)
   return hmm.EqV3(l.__c, r.__c) == 1
end

function V3.__tostring(v)
   return ('(%.2f, %.2f, %.2f)'):format(v.__c.X, v.__c.Y, v.__c.Z)
end

function V3.__index(v, k)
   local f = V3.__fields[k]
   if f ~= nil then
      return v.__c[f]
   end

   if type(V3[k]) == 'function' then
      return V3[k]
   end

   return rawget(v, k)
end

function V3.__newindex(v, k, val)
   local f = V3.__fields[k]
   if f ~= nil then
      v.__c[f] = val
   else
      rawset(v, k, val)
   end
end

return wrapper
