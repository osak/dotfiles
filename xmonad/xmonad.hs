import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig

main = xmonad =<< xmobar myConfig
  
myKeys = 
  [ ("M-C-f", spawn "firefox")
  , ("M-C-m", spawn "mikutter")
  ]

myConfig = defaultConfig
  { terminal = "urxvt"
  , modMask = mod4Mask
  , borderWidth = 3
  } `additionalKeysP` myKeys

