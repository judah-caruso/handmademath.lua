--[[
    HandmadeMath.lua - HandmadeMath bindings for LuaJIT

    INFORMATION
    -----------

    This library exposes HandmadeMath's API's to LuaJIT
    via the FFI package.

    LICENSE
    -------

    This software is in the public domain. Where that dedication is not
    recognized, you are granted a perpetual, irrevocable license to copy,
    distribute, and modify this file as you see fit.
--]]

assert(pcall(require, 'ffi') and pcall(require, 'jit'), 'Error: HandmadeMath requires LuaJIT.')

local ffi = require 'ffi'

local lib_path    = nil
local search_path = package.path .. ';lib/?.lua'

if ffi.os == 'Windows' then
    lib_path = package.searchpath('HandmadeMath', search_path:gsub('lua', 'dll'))
elseif ffi.os == 'OSX' then
    lib_path = package.searchpath('HandmadeMath', search_path:gsub('lua', 'dylib'))
elseif ffi.os == 'Linux' then
    lib_path = package.searchpath('HandmadeMath', search_path:gsub('lua', 'so'))
else
    error(("Error: unsupported operating system '%s'"):format(ffi.os))
end

if lib_path == nil then
    error('Error: unable to find library for HandmadeMath! Does it exist?')
end

local lib = ffi.load(lib_path or 'HandmadeMath', false)

-- Types
--------

ffi.cdef[[
   typedef signed int HMM_Bool;

   typedef union HMM_Vec2
   {
       struct
       {
           float X, Y;
       };

       struct
       {
           float U, V;
       };

       struct
       {
           float Left, Right;
       };

       struct
       {
           float Width, Height;
       };
   } HMM_Vec2;

   typedef union HMM_Vec3
   {
       struct
       {
           float X, Y, Z;
       };

       struct
       {
           float U, V, W;
       };

       struct
       {
           float R, G, B;
       };

       struct
       {
           HMM_Vec2 XY;
           float _Ignored0;
       };

       struct
       {
           float _Ignored1;
           HMM_Vec2 YZ;
       };

       struct
       {
           HMM_Vec2 UV;
           float _Ignored2;
       };

       struct
       {
           float _Ignored3;
           HMM_Vec2 VW;
       };
   } HMM_Vec3;

   typedef union HMM_Vec4
   {
       struct
       {
           union
           {
               HMM_Vec3 XYZ;
               struct
               {
                   float X, Y, Z;
               };
           };

           float W;
       };
       struct
       {
           union
           {
               HMM_Vec3 RGB;
               struct
               {
                   float R, G, B;
               };
           };

           float A;
       };

       struct
       {
           HMM_Vec2 XY;
           float _Ignored0;
           float _Ignored1;
       };

       struct
       {
           float _Ignored2;
           HMM_Vec2 YZ;
           float _Ignored3;
       };

       struct
       {
           float _Ignored4;
           float _Ignored5;
           HMM_Vec2 ZW;
       };
   } HMM_Vec4;

   typedef struct HMM_Mat2
   {
       HMM_Vec2 Columns[2];
   } HMM_Mat2;

   typedef struct HMM_Mat3
   {
       HMM_Vec3 Columns[3];
   } HMM_Mat3;

   typedef struct HMM_Mat4
   {
       HMM_Vec4 Columns[4];
   } HMM_Mat4;

   typedef union HMM_Quat
   {
       struct
       {
           union
           {
               HMM_Vec3 XYZ;
               struct
               {
                   float X, Y, Z;
               };
           };

           float W;
       };
   } HMM_Quat;
]]


-- Functions
------------

ffi.cdef[[
   float HMM_SinF(float);
   float HMM_CosF(float);
   float HMM_TanF(float);
   float HMM_ACosF(float);
   float HMM_SqrtF(float);
   float HMM_InvSqrtF(float);
   float HMM_Lerp(float, float, float);
   float HMM_Clamp(float, float, float);


   HMM_Vec2 HMM_V2(float, float);
   HMM_Vec2 HMM_AddV2(HMM_Vec2, HMM_Vec2);
   HMM_Vec2 HMM_AddV2F(HMM_Vec2, float);
   HMM_Vec2 HMM_SubV2(HMM_Vec2, HMM_Vec2);
   HMM_Vec2 HMM_MulV2(HMM_Vec2, HMM_Vec2);
   HMM_Vec2 HMM_MulV2F(HMM_Vec2, float);
   HMM_Vec2 HMM_DivV2(HMM_Vec2, HMM_Vec2);
   HMM_Vec2 HMM_DivV2F(HMM_Vec2, float);
   HMM_Bool HMM_EqV2(HMM_Vec2, HMM_Vec2);
   float HMM_DotV2(HMM_Vec2, HMM_Vec2);
   float HMM_LenSqrV2(HMM_Vec2);
   float HMM_LenV2(HMM_Vec2);
   HMM_Vec2 HMM_NormV2(HMM_Vec2);
   HMM_Vec2 HMM_LerpV2(HMM_Vec2, float, HMM_Vec2);
   HMM_Vec2 HMM_RotateV2(HMM_Vec2 V, float Angle);


   HMM_Vec3 HMM_V3(float, float, float);
   HMM_Vec3 HMM_AddV3(HMM_Vec3, HMM_Vec3);
   HMM_Vec3 HMM_AddV3F(HMM_Vec3, float);
   HMM_Vec3 HMM_SubV3(HMM_Vec3, HMM_Vec3);
   HMM_Vec3 HMM_MulV3(HMM_Vec3, HMM_Vec3);
   HMM_Vec3 HMM_MulV3F(HMM_Vec3, float);
   HMM_Vec3 HMM_DivV3(HMM_Vec3, HMM_Vec3);
   HMM_Vec3 HMM_DivV3F(HMM_Vec3, float);
   HMM_Bool HMM_EqV3(HMM_Vec3, HMM_Vec3);
   float HMM_DotV3(HMM_Vec3, HMM_Vec3);
   float HMM_LenSqrV3(HMM_Vec3);
   float HMM_LenV3(HMM_Vec3);
   HMM_Vec3 HMM_NormV3(HMM_Vec3);
   HMM_Vec3 HMM_LerpV3(HMM_Vec3, float, HMM_Vec3);
   HMM_Vec3 HMM_Cross(HMM_Vec3, HMM_Vec3);
   HMM_Vec3 HMM_RotateV3Q(HMM_Vec3 V, HMM_Quat Q);
   HMM_Vec3 HMM_RotateV3AxisAngle_LH(HMM_Vec3 V, HMM_Vec3 Axis, float Angle);
   HMM_Vec3 HMM_RotateV3AxisAngle_RH(HMM_Vec3 V, HMM_Vec3 Axis, float Angle);


   HMM_Vec4 HMM_V4(float, float, float, float);
   HMM_Vec4 HMM_V4V(HMM_Vec3, float);
   HMM_Vec4 HMM_AddV4(HMM_Vec4, HMM_Vec4);
   HMM_Vec4 HMM_AddV4F(HMM_Vec4, float);
   HMM_Vec4 HMM_SubV4(HMM_Vec4, HMM_Vec4);
   HMM_Vec4 HMM_MulV4(HMM_Vec4, HMM_Vec4);
   HMM_Vec4 HMM_MulV4F(HMM_Vec4, float);
   HMM_Vec4 HMM_DivV4(HMM_Vec4, HMM_Vec4);
   HMM_Vec4 HMM_DivV4F(HMM_Vec4, float);
   HMM_Bool HMM_EqV4(HMM_Vec4, HMM_Vec4);
   float HMM_DotV4(HMM_Vec4, HMM_Vec4);
   float HMM_LenSqrV4(HMM_Vec4);
   float HMM_LenV4(HMM_Vec4);
   HMM_Vec4 HMM_NormV4(HMM_Vec4);
   HMM_Vec4 HMM_LerpV4(HMM_Vec4, float, HMM_Vec4);


   HMM_Mat2 HMM_M2(void);
   HMM_Mat2 HMM_M2D(float);
   HMM_Mat2 HMM_TransposeM2(HMM_Mat2 Matrix);
   HMM_Mat2 HMM_AddM2(HMM_Mat2 Left, HMM_Mat2 Right);
   HMM_Mat2 HMM_SubM2(HMM_Mat2 Left, HMM_Mat2 Right);
   HMM_Vec2 HMM_MulM2V2(HMM_Mat2 Matrix, HMM_Vec2 Vector);
   HMM_Mat2 HMM_MulM2(HMM_Mat2 Left, HMM_Mat2 Right);
   HMM_Mat2 HMM_MulM2F(HMM_Mat2 Matrix, float Scalar);
   HMM_Mat2 HMM_DivM2F(HMM_Mat2 Matrix, float Scalar);
   float HMM_DeterminantM2(HMM_Mat2 Matrix);
   HMM_Mat2 HMM_InvGeneralM2(HMM_Mat2 Matrix);


   HMM_Mat3 HMM_M3(void);
   HMM_Mat3 HMM_M3D(float);
   HMM_Mat3 HMM_M3D(float Diagonal);
   HMM_Mat3 HMM_TransposeM3(HMM_Mat3 Matrix);
   HMM_Mat3 HMM_AddM3(HMM_Mat3 Left, HMM_Mat3 Right);
   HMM_Mat3 HMM_SubM3(HMM_Mat3 Left, HMM_Mat3 Right);
   HMM_Vec3 HMM_MulM3V3(HMM_Mat3 Matrix, HMM_Vec3 Vector);
   HMM_Mat3 HMM_MulM3(HMM_Mat3 Left, HMM_Mat3 Right);
   HMM_Mat3 HMM_MulM3F(HMM_Mat3 Matrix, float Scalar);
   HMM_Mat3 HMM_DivM3F(HMM_Mat3 Matrix, float Scalar);
   float HMM_DeterminantM3(HMM_Mat3 Matrix);
   HMM_Mat3 HMM_InvGeneralM3(HMM_Mat3 Matrix);


   HMM_Mat4 HMM_M4(void);
   HMM_Mat4 HMM_M4D(float);
   HMM_Vec4 HMM_LinearCombineV4M4(HMM_Vec4, HMM_Mat4);
   HMM_Mat4 HMM_M4D(float Diagonal);
   HMM_Mat4 HMM_TransposeM4(HMM_Mat4 Matrix);
   HMM_Mat4 HMM_AddM4(HMM_Mat4 Left, HMM_Mat4 Right);
   HMM_Mat4 HMM_SubM4(HMM_Mat4 Left, HMM_Mat4 Right);
   HMM_Mat4 HMM_MulM4(HMM_Mat4 Left, HMM_Mat4 Right);
   HMM_Mat4 HMM_MulM4F(HMM_Mat4 Matrix, float Scalar);
   HMM_Vec4 HMM_MulM4V4(HMM_Mat4 Matrix, HMM_Vec4 Vector);
   HMM_Mat4 HMM_DivM4F(HMM_Mat4 Matrix, float Scalar);
   float HMM_DeterminantM4(HMM_Mat4 Matrix);
   HMM_Mat4 HMM_InvGeneralM4(HMM_Mat4 Matrix);
   HMM_Mat4 HMM_Orthographic_RH_NO(float Left, float Right, float Bottom, float Top, float Near, float Far);
   HMM_Mat4 HMM_Orthographic_RH_ZO(float Left, float Right, float Bottom, float Top, float Near, float Far);
   HMM_Mat4 HMM_Orthographic_LH_NO(float Left, float Right, float Bottom, float Top, float Near, float Far);
   HMM_Mat4 HMM_Orthographic_LH_ZO(float Left, float Right, float Bottom, float Top, float Near, float Far);
   HMM_Mat4 HMM_InvOrthographic(HMM_Mat4 OrthoMatrix);
   HMM_Mat4 HMM_Perspective_RH_NO(float FOV, float AspectRatio, float Near, float Far);
   HMM_Mat4 HMM_Perspective_RH_ZO(float FOV, float AspectRatio, float Near, float Far);
   HMM_Mat4 HMM_Perspective_LH_NO(float FOV, float AspectRatio, float Near, float Far);
   HMM_Mat4 HMM_Perspective_LH_ZO(float FOV, float AspectRatio, float Near, float Far);
   HMM_Mat4 HMM_InvPerspective_RH(HMM_Mat4 PerspectiveMatrix);
   HMM_Mat4 HMM_InvPerspective_LH(HMM_Mat4 PerspectiveMatrix);
   HMM_Mat4 HMM_Translate(HMM_Vec3 Translation);
   HMM_Mat4 HMM_InvTranslate(HMM_Mat4 TranslationMatrix);
   HMM_Mat4 HMM_Rotate_RH(float Angle, HMM_Vec3 Axis);
   HMM_Mat4 HMM_Rotate_LH(float Angle, HMM_Vec3 Axis);
   HMM_Mat4 HMM_InvRotate(HMM_Mat4 RotationMatrix);
   HMM_Mat4 HMM_Scale(HMM_Vec3 Scale);
   HMM_Mat4 HMM_InvScale(HMM_Mat4 ScaleMatrix);


   HMM_Quat HMM_Q(float, float, float, float);
   HMM_Quat HMM_QV4(HMM_Vec4);
   HMM_Mat4 HMM_LookAt_RH(HMM_Vec3 Eye, HMM_Vec3 Center, HMM_Vec3 Up);
   HMM_Mat4 HMM_LookAt_LH(HMM_Vec3 Eye, HMM_Vec3 Center, HMM_Vec3 Up);
   HMM_Mat4 HMM_InvLookAt(HMM_Mat4 Matrix);
   HMM_Quat HMM_QV4(HMM_Vec4 Vector);
   HMM_Quat HMM_AddQ(HMM_Quat Left, HMM_Quat Right);
   HMM_Quat HMM_SubQ(HMM_Quat Left, HMM_Quat Right);
   HMM_Quat HMM_MulQ(HMM_Quat Left, HMM_Quat Right);
   HMM_Quat HMM_MulQF(HMM_Quat Left, float Multiplicative);
   HMM_Quat HMM_DivQF(HMM_Quat Left, float Divnd);
   float HMM_DotQ(HMM_Quat Left, HMM_Quat Right);
   HMM_Quat HMM_InvQ(HMM_Quat Left);
   HMM_Quat HMM_NormQ(HMM_Quat Quat);
   HMM_Quat HMM_Norm(HMM_Quat A);
   HMM_Quat HMM_NLerp(HMM_Quat Left, float Time, HMM_Quat Right);
   HMM_Quat HMM_SLerp(HMM_Quat Left, float Time, HMM_Quat Right);
   HMM_Mat4 HMM_QToM4(HMM_Quat Left);
   HMM_Quat HMM_M4ToQ_RH(HMM_Mat4 M);
   HMM_Quat HMM_M4ToQ_LH(HMM_Mat4 M);
   HMM_Quat HMM_QFromAxisAngle_RH(HMM_Vec3 Axis, float Angle);
   HMM_Quat HMM_QFromAxisAngle_LH(HMM_Vec3 Axis, float Angle);
   HMM_Quat HMM_QFromNormPair(HMM_Vec3 Left, HMM_Vec3 Right);
   HMM_Quat HMM_QFromVecPair(HMM_Vec3 Left, HMM_Vec3 Right);
]]


-- Actual library
-----------------

local HMM = {
    _version = "2.0.0",
    library  = lib,

    PI       = 3.14159265358979323846,
    DEG180   = 180.0,
    TURNHALF = 0.5,
}

function HMM.MIN(a, b) return (a > b)      and b       or a             end
function HMM.MAX(a, b) return (a < b)      and b       or a             end
function HMM.ABS(a)    return (a > 0)      and a       or -a            end
function HMM.MOD(a, m) return (a % m >= 0) and (a % m) or ((a % m) + m) end
function HMM.SQUARE(x) return x * x                                     end

HMM.RadToDeg  = HMM.DEG180   / HMM.PI
HMM.RadToTurn = HMM.TURNHALF / HMM.PI
HMM.DegToRad  = HMM.PI       / HMM.DEG180
HMM.DegToTurn = HMM.TURNHALF / HMM.DEG180
HMM.TurnToRad = HMM.PI       / HMM.TURNHALF
HMM.TurnToDeg = HMM.DEG180   / HMM.TURNHALF

HMM.Bool = ffi.typeof('HMM_Bool')
HMM.Vec2 = ffi.typeof('HMM_Vec2')
HMM.Vec3 = ffi.typeof('HMM_Vec3')
HMM.Vec4 = ffi.typeof('HMM_Vec4')
HMM.Mat2 = ffi.typeof('HMM_Mat2')
HMM.Mat3 = ffi.typeof('HMM_Mat3')
HMM.Mat4 = ffi.typeof('HMM_Mat4')
HMM.Quat = ffi.typeof('HMM_Quat')

HMM.V2                   = lib.HMM_V2
HMM.V3                   = lib.HMM_V3
HMM.V4                   = lib.HMM_V4
HMM.V4V                  = lib.HMM_V4V
HMM.M2                   = lib.HMM_M2
HMM.M2D                  = lib.HMM_M2D
HMM.M3                   = lib.HMM_M3
HMM.M3D                  = lib.HMM_M3D
HMM.M4                   = lib.HMM_M4
HMM.M4D                  = lib.HMM_M4D
HMM.Q                    = lib.HMM_Q
HMM.QV4                  = lib.HMM_QV4
HMM.AddV2                = lib.HMM_AddV2
HMM.AddV3                = lib.HMM_AddV3
HMM.AddV4                = lib.HMM_AddV4
HMM.SubV2                = lib.HMM_SubV2
HMM.SubV3                = lib.HMM_SubV3
HMM.SubV4                = lib.HMM_SubV4
HMM.MulV2                = lib.HMM_MulV2
HMM.MulV3                = lib.HMM_MulV3
HMM.MulV4                = lib.HMM_MulV4
HMM.MulV2F               = lib.HMM_MulV2F
HMM.MulV3F               = lib.HMM_MulV3F
HMM.MulV4F               = lib.HMM_MulV4F
HMM.DivV2                = lib.HMM_DivV2
HMM.DivV3                = lib.HMM_DivV3
HMM.DivV4                = lib.HMM_DivV4
HMM.DivV2F               = lib.HMM_DivV2F
HMM.DivV3F               = lib.HMM_DivV3F
HMM.DivV4F               = lib.HMM_DivV4F
HMM.EqV2                 = lib.HMM_EqV2
HMM.EqV3                 = lib.HMM_EqV3
HMM.EqV4                 = lib.HMM_EqV4
HMM.DotV2                = lib.HMM_DotV2
HMM.DotV3                = lib.HMM_DotV3
HMM.DotV4                = lib.HMM_DotV4
HMM.Cross                = lib.HMM_Cross
HMM.LenSqrV2             = lib.HMM_LenSqrV2
HMM.LenSqrV3             = lib.HMM_LenSqrV3
HMM.LenSqrV4             = lib.HMM_LenSqrV4
HMM.LenV2                = lib.HMM_LenV2
HMM.LenV3                = lib.HMM_LenV3
HMM.LenV4                = lib.HMM_LenV4
HMM.NormV2               = lib.HMM_NormV2
HMM.NormV3               = lib.HMM_NormV3
HMM.NormV4               = lib.HMM_NormV4
HMM.LerpV2               = lib.HMM_LerpV2
HMM.LerpV3               = lib.HMM_LerpV3
HMM.LerpV4               = lib.HMM_LerpV4
HMM.SinF                 = lib.HMM_SinF
HMM.CosF                 = lib.HMM_CosF
HMM.TanF                 = lib.HMM_TanF
HMM.ACosF                = lib.HMM_ACosF
HMM.SqrtF                = lib.HMM_SqrtF
HMM.InvSqrtF             = lib.HMM_InvSqrtF
HMM.Lerp                 = lib.HMM_Lerp
HMM.Clamp                = lib.HMM_Clamp
HMM.LinearCombineV4M4    = lib.HMM_LinearCombineV4M4
HMM.TransposeM2          = lib.HMM_TransposeM2
HMM.AddM2                = lib.HMM_AddM2
HMM.SubM2                = lib.HMM_SubM2
HMM.MulM2V2              = lib.HMM_MulM2V2
HMM.MulM2                = lib.HMM_MulM2
HMM.MulM2F               = lib.HMM_MulM2F
HMM.DivM2F               = lib.HMM_DivM2F
HMM.DeterminantM2        = lib.HMM_DeterminantM2
HMM.InvGeneralM2         = lib.HMM_InvGeneralM2
HMM.M3D                  = lib.HMM_M3D
HMM.TransposeM3          = lib.HMM_TransposeM3
HMM.AddM3                = lib.HMM_AddM3
HMM.SubM3                = lib.HMM_SubM3
HMM.MulM3V3              = lib.HMM_MulM3V3
HMM.MulM3                = lib.HMM_MulM3
HMM.MulM3F               = lib.HMM_MulM3F
HMM.DivM3F               = lib.HMM_DivM3F
HMM.DeterminantM3        = lib.HMM_DeterminantM3
HMM.InvGeneralM3         = lib.HMM_InvGeneralM3
HMM.M4D                  = lib.HMM_M4D
HMM.TransposeM4          = lib.HMM_TransposeM4
HMM.AddM4                = lib.HMM_AddM4
HMM.SubM4                = lib.HMM_SubM4
HMM.MulM4                = lib.HMM_MulM4
HMM.MulM4F               = lib.HMM_MulM4F
HMM.MulM4V4              = lib.HMM_MulM4V4
HMM.DivM4F               = lib.HMM_DivM4F
HMM.DeterminantM4        = lib.HMM_DeterminantM4
HMM.InvGeneralM4         = lib.HMM_InvGeneralM4
HMM.Orthographic_RH_NO   = lib.HMM_Orthographic_RH_NO
HMM.Orthographic_RH_ZO   = lib.HMM_Orthographic_RH_ZO
HMM.Orthographic_LH_NO   = lib.HMM_Orthographic_LH_NO
HMM.Orthographic_LH_ZO   = lib.HMM_Orthographic_LH_ZO
HMM.InvOrthographic      = lib.HMM_InvOrthographic
HMM.Perspective_RH_NO    = lib.HMM_Perspective_RH_NO
HMM.Perspective_RH_ZO    = lib.HMM_Perspective_RH_ZO
HMM.Perspective_LH_NO    = lib.HMM_Perspective_LH_NO
HMM.Perspective_LH_ZO    = lib.HMM_Perspective_LH_ZO
HMM.InvPerspective_RH    = lib.HMM_InvPerspective_RH
HMM.InvPerspective_LH    = lib.HMM_InvPerspective_LH
HMM.Translate            = lib.HMM_Translate
HMM.InvTranslate         = lib.HMM_InvTranslate
HMM.Rotate_RH            = lib.HMM_Rotate_RH
HMM.Rotate_LH            = lib.HMM_Rotate_LH
HMM.InvRotate            = lib.HMM_InvRotate
HMM.Scale                = lib.HMM_Scale
HMM.InvScale             = lib.HMM_InvScale
HMM.LookAt_RH            = lib.HMM_LookAt_RH
HMM.LookAt_LH            = lib.HMM_LookAt_LH
HMM.InvLookAt            = lib.HMM_InvLookAt
HMM.QV4                  = lib.HMM_QV4
HMM.AddQ                 = lib.HMM_AddQ
HMM.SubQ                 = lib.HMM_SubQ
HMM.MulQ                 = lib.HMM_MulQ
HMM.MulQF                = lib.HMM_MulQF
HMM.DivQF                = lib.HMM_DivQF
HMM.DotQ                 = lib.HMM_DotQ
HMM.InvQ                 = lib.HMM_InvQ
HMM.NormQ                = lib.HMM_NormQ
HMM.NLerp                = lib.HMM_NLerp
HMM.SLerp                = lib.HMM_SLerp
HMM.QToM4                = lib.HMM_QToM4
HMM.M4ToQ_RH             = lib.HMM_M4ToQ_RH
HMM.M4ToQ_LH             = lib.HMM_M4ToQ_LH
HMM.QFromAxisAngle_RH    = lib.HMM_QFromAxisAngle_RH
HMM.QFromAxisAngle_LH    = lib.HMM_QFromAxisAngle_LH
HMM.QFromNormPair        = lib.HMM_QFromNormPair
HMM.QFromVecPair         = lib.HMM_QFromVecPair
HMM.RotateV2             = lib.HMM_RotateV2
HMM.RotateV3Q            = lib.HMM_RotateV3Q
HMM.RotateV3AxisAngle_LH = lib.HMM_RotateV3AxisAngle_LH
HMM.RotateV3AxisAngle_RH = lib.HMM_RotateV3AxisAngle_RH

return HMM
