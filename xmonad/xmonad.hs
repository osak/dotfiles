import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig
import XMonad.Hooks.SetWMName
import XMonad.Config

main = xmonad =<< xmobar myConfig
  
myKeys = 
  [ ("M-C-f", spawn "firefox")
  , ("M-C-m", spawn "mikutter")
  ]

myConfig = def
  { terminal = "sakura"
  , modMask = mod4Mask
  , borderWidth = 3
  , startupHook = setWMName "LG3D"
  } `additionalKeysP` myKeys

