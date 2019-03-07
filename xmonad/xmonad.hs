{-# Language DeriveDataTypeable #-}
import XMonad
import qualified XMonad.StackSet as W
import qualified XMonad.Util.ExtensibleState as XS
import XMonad.Actions.Navigation2D
import XMonad.Layout.NoBorders
-- import XMonad.Actions.UpdatePointer
import XMonad.Util.EZConfig (mkKeymap)

import qualified Data.Map as M
import Data.Map (Map)
import Data.Maybe (fromMaybe)

workspaceNames =
  [ "0:Chat", "1:Dbg", "2:Pix"
  , "3:Docs", "4:Dev", "5:Web"
  , "6:Term", "7:Hub", "8:Mail"
  ]

data WorkspacePos = WorkspacePos Int Int deriving Typeable
newtype TouchpadEnabled = TouchpadEnabled Bool

instance ExtensionClass WorkspacePos where
    initialValue = WorkspacePos 1 1

instance ExtensionClass TouchpadEnabled where
    initialValue = TouchpadEnabled True

toggleTouchpad = do
    TouchpadEnabled x <- XS.get
    XS.modify $ \(TouchpadEnabled x) -> TouchpadEnabled $ not x
    spawn "notify-send toggle-touchpad -t 1000"
    spawn "xdotool mousemove 0 2000" -- Move mouse to bottom-left corner
    case x of
        True  -> spawn "xinput --disable 12"
        False -> spawn "xinput --enable  12"

-- Todo: Fix when someonelse changes workspace
workspaceAction f d = do
    case d of
        L -> XS.modify $ \(WorkspacePos x y) -> WorkspacePos (max 0 (x-1)) y
        R -> XS.modify $ \(WorkspacePos x y) -> WorkspacePos (min 2 (x+1)) y
        U -> XS.modify $ \(WorkspacePos x y) -> WorkspacePos x (max 0 (y-1))
        D -> XS.modify $ \(WorkspacePos x y) -> WorkspacePos x (min 2 (y+1))
    XS.get >>= \(WorkspacePos x y) -> (f $ workspaceNames !! (y*3+x))

workspaceGo    = workspaceAction (windows . W.greedyView)
workspaceShift = workspaceAction $ \w ->
    windows (W.shift w) >> windows (W.greedyView w)

customKeys :: XConfig Layout -> Map (KeyMask, KeySym) (X ())
customKeys c@(XConfig {modMask = modm}) = M.fromList $
    [ ((controlMask, xK_j), windowGo D False)
    , ((controlMask, xK_k), windowGo U False)
    , ((controlMask, xK_h), windowGo L False)
    , ((controlMask, xK_l), windowGo R False)

    , ((controlMask .|. shiftMask, xK_j), windowSwap D False)
    , ((controlMask .|. shiftMask, xK_k), windowSwap U False)
    , ((controlMask .|. shiftMask, xK_h), windowSwap L False)
    , ((controlMask .|. shiftMask, xK_l), windowSwap R False)

    , ((modm, xK_F9), toggleTouchpad)

    , ((modm, xK_j), workspaceGo D)
    , ((modm, xK_k), workspaceGo U)
    , ((modm, xK_h), workspaceGo L)
    , ((modm, xK_l), workspaceGo R)

    , ((modm .|. shiftMask, xK_j), workspaceShift D)
    , ((modm .|. shiftMask, xK_k), workspaceShift U)
    , ((modm .|. shiftMask, xK_h), workspaceShift L)
    , ((modm .|. shiftMask, xK_l), workspaceShift R)

    , ((modm, xK_r), sendMessage Expand)
    , ((modm, xK_e), sendMessage Shrink)

    , ((modm, xK_m), focusScreen 0)
    , ((modm, xK_n), focusScreen 1)
    , ((modm .|. shiftMask, xK_m), shiftScreen 0)
    , ((modm .|. shiftMask, xK_n), shiftScreen 1)

    , ((controlMask,   xK_Down), mouseMoveRel "  0  15")
    , ((controlMask,     xK_Up), mouseMoveRel "  0 -15")
    , ((controlMask,   xK_Left), mouseMoveRel "-15   0")
    , ((controlMask,  xK_Right), mouseMoveRel " 15   0")
    , ((controlMask, xK_Return), spawn "xdotool click 1")
    -- , ((controlMask .|. shiftMask, xK_Return), spawn "xdotool click 2")
    , ((controlMask .|. shiftMask, xK_Return), spawn "xdotool click 3")

    , ((controlMask .|. shiftMask,   xK_Down), mouseMoveRel "  0  150")
    , ((controlMask .|. shiftMask,     xK_Up), mouseMoveRel "  0 -150")
    , ((controlMask .|. shiftMask,   xK_Left), mouseMoveRel "-150   0")
    , ((controlMask .|. shiftMask,  xK_Right), mouseMoveRel " 150   0")

    ]

focusScreen :: ScreenId -> X ()
focusScreen sn = screenWorkspace sn >>= \x -> case x of
    Nothing -> return ()
    Just sc -> windows $ W.view sc

shiftScreen :: ScreenId -> X ()
shiftScreen sn = screenWorkspace sn >>= \x -> case x of
    Nothing -> return ()
    Just sc -> windows $ W.shift sc

mouseMoveRel rel = spawn $ "xdotool mousemove_relative -- " ++ rel

customMouseBindings :: XConfig Layout -> Map (ButtonMask, Button) (Window -> X ())
customMouseBindings c@(XConfig {modMask = modm}) = M.fromList $
    -- Unset default dragging by mod + mouse button 1
    [ (oldMoveBindings, mempty)
    -- And change it to mod + shift + mouse button 1
    , ((modm .|. shiftMask, button1), moveAction)
    ]
    where
    oldMoveBindings = (modm, button1)
    moveAction = fromMaybe mempty $ M.lookup oldMoveBindings $ mouseBindings def c


main :: IO ()
main = xmonad $ withNavigation2DConfig def $ def
     { modMask           = mod4Mask
     , keys              = customKeys <+> keys def
     , mouseBindings     = customMouseBindings <+> mouseBindings def
     , workspaces        = workspaceNames
     , terminal          = "xterm"
     , layoutHook        = smartBorders (layoutHook def)
     , focusFollowsMouse = False
     }
