#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; For AHK it translates:
;Bool = int
;LONG  = int
;HWND = Ptr
;LPRECT = Ptr
; PVOID: Ptr
; DWORD: UInt
; SIZE_T: UPtr

CoordMode, Mouse, Client
CoordMode,Pixel, Screen 2
#NoEnv
#InstallKeybdHook
#UseHook
#Persistent
#UseHook
#MaxThreads 255
#MaxThreadsPerHotkey, 1
#NoEnv
#SingleInstance force
    #MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
Thread, interrupt, 0

;OnExit("_ShutDown")

_ShutDown(ExitReason){
    if ExitReason not in Logoff,Shutdown
    {
        MsgBox, 4, , Are you sure you want to exit?
        IfMsgBox, Yes
            DllCall("imgui\ShutDown", "Cdecl")
        IfMsgBox, No
            return 1  ; OnExit functions must return non-zero to prevent exit.
    }
}

global ImGui := new ImGui()

;// Configuration (fill once)                // Default values
;//------------------------------------------------------------------
{
    Global FLT_MAX         				          :=  3.402823466e+38
    
    ;// Flags for ImGui::Begin()
    ;//------------------------------------------------------------------
    {
        Global ImGuiWindowFlags_None                   = 0
        Global ImGuiWindowFlags_NoTitleBar             = 1 << 0   ; Disable title-bar
        Global ImGuiWindowFlags_NoResize               = 1 << 1   ; Disable user resizing with the lower-right grip
        Global ImGuiWindowFlags_NoMove                 = 1 << 2   ; Disable user moving the window
        Global ImGuiWindowFlags_NoScrollbar            = 1 << 3   ; Disable scrollbars (window can still scroll with mouse or programmatically)
        Global ImGuiWindowFlags_NoScrollWithMouse      = 1 << 4   ; Disable user vertically scrolling with mouse wheel. On child window mouse wheel will be forwarded to the parent unless NoScrollbar is also set.
        Global ImGuiWindowFlags_NoCollapse             = 1 << 5   ; Disable user collapsing window by double-clicking on it
        Global ImGuiWindowFlags_AlwaysAutoResize       = 1 << 6   ; Resize every window to its content every frame
        Global ImGuiWindowFlags_NoBackground           = 1 << 7   ; Disable drawing background color (WindowBg etc.) and outside border. Similar as using SetNextWindowBgAlpha(0.0f).
        Global ImGuiWindowFlags_NoSavedSettings        = 1 << 8   ; Never load/save settings in .ini file
        Global ImGuiWindowFlags_NoMouseInputs          = 1 << 9   ; Disable catching mouse hovering test with pass through.
        Global ImGuiWindowFlags_MenuBar                = 1 << 10  ; Has a menu-bar
        Global ImGuiWindowFlags_HorizontalScrollbar    = 1 << 11  ; Allow horizontal scrollbar to appear (off by default). You may use SetNextWindowContentSize(ImVec2(width0.0f)); prior to calling Begin() to specify width. Read code in imgui_demo in the "Horizontal Scrolling" section.
        Global ImGuiWindowFlags_NoFocusOnAppearing     = 1 << 12  ; Disable taking focus when transitioning from hidden to visible state
        Global ImGuiWindowFlags_NoBringToFrontOnFocus  = 1 << 13  ; Disable bringing window to front when taking focus (e.g. clicking on it or programmatically giving it focus)
        Global ImGuiWindowFlags_AlwaysVerticalScrollbar= 1 << 14  ; Always show vertical scrollbar (even if ContentSize.y < Size.y)
        Global ImGuiWindowFlags_AlwaysHorizontalScrollbar=1<< 15  ; Always show horizontal scrollbar (even if ContentSize.x < Size.x)
        Global ImGuiWindowFlags_AlwaysUseWindowPadding = 1 << 16  ; Ensure child windows without border uses style.WindowPadding (ignored by default for non-bordered child windows because more convenient)
        Global ImGuiWindowFlags_NoNavInputs            = 1 << 18  ; No gamepad/keyboard navigation within the window
        Global ImGuiWindowFlags_NoNavFocus             = 1 << 19  ; No focusing toward this window with gamepad/keyboard navigation (e.g. skipped by CTRL+TAB)
        Global ImGuiWindowFlags_UnsavedDocument        = 1 << 20  ; Append '*' to title without affecting the ID as a convenience to avoid using the ### operator. When used in a tab/docking context tab is selected on closure and closure is deferred by one frame to allow code to cancel the closure (with a confirmation popup etc.) without flicker.
        Global ImGuiWindowFlags_NoNav                  = ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus
        Global ImGuiWindowFlags_NoDecoration           = ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoCollapse
        Global ImGuiWindowFlags_NoInputs               = ImGuiWindowFlags_NoMouseInputs | ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus
    }
    ;//------------------------------------------------------------------
    ;// Flags for ImGui::InputText()
    ;//------------------------------------------------------------------
    {
        Global ImGuiInputTextFlags_None                = 0
        Global ImGuiInputTextFlags_CharsDecimal        = 1 << 0   ; Allow 0123456789.+-*/
        Global ImGuiInputTextFlags_CharsHexadecimal    = 1 << 1   ; Allow 0123456789ABCDEFabcdef
        Global ImGuiInputTextFlags_CharsUppercase      = 1 << 2   ; Turn a..z into A..Z
        Global ImGuiInputTextFlags_CharsNoBlank        = 1 << 3   ; Filter out spaces tabs
        Global ImGuiInputTextFlags_AutoSelectAll       = 1 << 4   ; Select entire text when first taking mouse focus
        Global ImGuiInputTextFlags_EnterReturnsTrue    = 1 << 5   ; Return 'true' when Enter is pressed (as opposed to every time the value was modified). Consider looking at the IsItemDeactivatedAfterEdit() function.
        Global ImGuiInputTextFlags_CallbackCompletion  = 1 << 6   ; Callback on pressing TAB (for completion handling)
        Global ImGuiInputTextFlags_CallbackHistory     = 1 << 7   ; Callback on pressing Up/Down arrows (for history handling)
        Global ImGuiInputTextFlags_CallbackAlways      = 1 << 8   ; Callback on each iteration. User code may query cursor position modify text buffer.
        Global ImGuiInputTextFlags_CallbackCharFilter  = 1 << 9   ; Callback on character inputs to replace or discard them. Modify 'EventChar' to replace or discard or return 1 in callback to discard.
        Global ImGuiInputTextFlags_AllowTabInput       = 1 << 10  ; Pressing TAB input a '\t' character into the text field
        Global ImGuiInputTextFlags_CtrlEnterForNewLine = 1 << 11  ; In multi-line mode unfocus with Enter add new line with Ctrl+Enter (default is opposite: unfocus with Ctrl+Enter add line with Enter).
            Global ImGuiInputTextFlags_NoHorizontalScroll  = 1 << 12  ; Disable following the cursor horizontally
        Global ImGuiInputTextFlags_AlwaysInsertMode    = 1 << 13  ; Insert mode
        Global ImGuiInputTextFlags_ReadOnly            = 1 << 14  ; Read-only mode
        Global ImGuiInputTextFlags_Password            = 1 << 15  ; Password mode display all characters as '*'
        Global ImGuiInputTextFlags_NoUndoRedo          = 1 << 16  ; Disable undo/redo. Note that input text owns the text data while active if you want to provide your own undo/redo stack you need e.g. to call ClearActiveID().
        Global ImGuiInputTextFlags_CharsScientific     = 1 << 17  ; Allow 0123456789.+-*/eE (Scientific notation input)
            Global ImGuiInputTextFlags_CallbackResize      = 1 << 18  ; Callback on buffer capacity changes request (beyond 'buf_size' parameter value) allowing the string to grow. Notify when the string wants to be resized (for string types which hold a cache of their Size). You will be provided a new BufSize in the callback and NEED to honor it. (see misc/cpp/imgui_stdlib.h for an example of using this)
    }
    
    ;//------------------------------------------------------------------
    ;// Flags for ImGui::TreeNodeEx() ImGui::CollapsingHeader*()
    ;//------------------------------------------------------------------
    {
        Global ImGuiTreeNodeFlags_None                 = 0
        Global ImGuiTreeNodeFlags_Selected             = 1 << 0   ; Draw as selected
        Global ImGuiTreeNodeFlags_Framed               = 1 << 1   ; Full colored frame (e.g. for CollapsingHeader)
        Global ImGuiTreeNodeFlags_AllowItemOverlap     = 1 << 2   ; Hit testing to allow subsequent widgets to overlap this one
        Global ImGuiTreeNodeFlags_NoTreePushOnOpen     = 1 << 3   ; Don't do a TreePush() when open (e.g. for CollapsingHeader) = no extra indent nor pushing on ID stack
        Global ImGuiTreeNodeFlags_NoAutoOpenOnLog      = 1 << 4   ; Don't automatically and temporarily open node when Logging is active (by default logging will automatically open tree nodes)
        Global ImGuiTreeNodeFlags_DefaultOpen          = 1 << 5   ; Default node to be open
        Global ImGuiTreeNodeFlags_OpenOnDoubleClick    = 1 << 6   ; Need double-click to open node
        Global ImGuiTreeNodeFlags_OpenOnArrow          = 1 << 7   ; Only open when clicking on the arrow part. If ImGuiTreeNodeFlags_OpenOnDoubleClick is also set single-click arrow or double-click all box to open.
        Global ImGuiTreeNodeFlags_Leaf                 = 1 << 8   ; No collapsing no arrow (use as a convenience for leaf nodes).
        Global ImGuiTreeNodeFlags_Bullet               = 1 << 9   ; Display a bullet instead of arrow
        Global ImGuiTreeNodeFlags_FramePadding         = 1 << 10  ; Use FramePadding (even for an unframed text node) to vertically align text baseline to regular widget height. Equivalent to calling AlignTextToFramePadding().
        Global ImGuiTreeNodeFlags_SpanAvailWidth       = 1 << 11  ; Extend hit box to the right-most edge even if not framed. This is not the default in order to allow adding other items on the same line. In the future we may refactor the hit system to be front-to-back allowing natural overlaps and then this can become the default.
        Global ImGuiTreeNodeFlags_SpanFullWidth        = 1 << 12  ; Extend hit box to the left-most and right-most edges (bypass the indented area).
        Global ImGuiTreeNodeFlags_NavLeftJumpsBackHere = 1 << 13  ; (WIP) Nav: left direction may move to this TreeNode() from any of its child (items submitted between TreeNode and TreePop)
        ;ImGuiTreeNodeFlags_NoScrollOnOpen     = 1 << 14  ; FIXME: TODO: Disable automatic scroll on TreePop() if node got just open and contents is not visible
        Global ImGuiTreeNodeFlags_CollapsingHeader     = ImGuiTreeNodeFlags_Framed | ImGuiTreeNodeFlags_NoTreePushOnOpen | ImGuiTreeNodeFlags_NoAutoOpenOnLog
    }
    
    ;//------------------------------------------------------------------
    ;//   Flags for OpenPopup*() BeginPopupContext*() IsPopupOpen() functions.
    ;// - To be backward compatible with older API which took an 'int mouse_button = 1' argument we need to treat
    ;//   small flags values as a mouse button index so we encode the mouse button in the first few bits of the flags.
    ;//   It is therefore guaranteed to be legal to pass a mouse button index in ImGuiPopupFlags.
    ;// - For the same reason we exceptionally default the ImGuiPopupFlags argument of BeginPopupContextXXX functions to 1 instead of 0.
    ;// - Multiple buttons currently cannot be combined/or-ed in those functions (we could allow it later).
    ;//------------------------------------------------------------------    
    {
        Global ImGuiPopupFlags_None                    = 0
        Global ImGuiPopupFlags_MouseButtonLeft         = 0        ; For BeginPopupContext*(): open on Left Mouse release. Guaranted to always be == 0 (same as ImGuiMouseButton_Left)
        Global ImGuiPopupFlags_MouseButtonRight        = 1        ; For BeginPopupContext*(): open on Right Mouse release. Guaranted to always be == 1 (same as ImGuiMouseButton_Right)
        Global ImGuiPopupFlags_MouseButtonMiddle       = 2        ; For BeginPopupContext*(): open on Middle Mouse release. Guaranted to always be == 2 (same as ImGuiMouseButton_Middle)
        Global ImGuiPopupFlags_MouseButtonMask_        = 0x1F
        Global ImGuiPopupFlags_MouseButtonDefault_     = 1
        Global ImGuiPopupFlags_NoOpenOverExistingPopup = 1 << 5   ; For OpenPopup*() BeginPopupContext*(): don't open if there's already a popup at the same level of the popup stack
        Global ImGuiPopupFlags_NoOpenOverItems         = 1 << 6   ; For BeginPopupContextWindow(): don't return true when hovering items only when hovering empty space
        Global ImGuiPopupFlags_AnyPopupId              = 1 << 7   ; For IsPopupOpen(): ignore the ImGuiID parameter and test for any popup.
        Global ImGuiPopupFlags_AnyPopupLevel           = 1 << 8   ; For IsPopupOpen(): search/test at any level of the popup stack (default test in the current level)
        Global ImGuiPopupFlags_AnyPopup                = ImGuiPopupFlags_AnyPopupId | ImGuiPopupFlags_AnyPopupLevel
    }
    
    ;//------------------------------------------------------------------
    ;// Flags for ImGui::Selectable()
    ;//------------------------------------------------------------------
    {
        Global ImGuiSelectableFlags_None               = 0
        Global ImGuiSelectableFlags_DontClosePopups    = 1 << 0   ; Clicking this don't close parent popup window
        Global ImGuiSelectableFlags_SpanAllColumns     = 1 << 1   ; Selectable frame can span all columns (text will still fit in current column)
        Global ImGuiSelectableFlags_AllowDoubleClick   = 1 << 2   ; Generate press events on double clicks too
        Global ImGuiSelectableFlags_Disabled           = 1 << 3   ; Cannot be selected display grayed out text
        Global ImGuiSelectableFlags_AllowItemOverlap   = 1 << 4    ; (WIP) Hit testing to allow subsequent widgets to overlap this one
    }
    
    ;//------------------------------------------------------------------
    ;// ImGui::BeginCombo()
    ;//------------------------------------------------------------------
    {
        Global ImGuiComboFlags_None                    = 0
        Global ImGuiComboFlags_PopupAlignLeft          = 1 << 0   ; Align the popup toward the left by default
        Global ImGuiComboFlags_HeightSmall             = 1 << 1   ; Max ~4 items visible. Tip: If you want your combo popup to be a specific size you can use SetNextWindowSizeConstraints() prior to calling BeginCombo()
        Global ImGuiComboFlags_HeightRegular           = 1 << 2   ; Max ~8 items visible (default)
        Global ImGuiComboFlags_HeightLarge             = 1 << 3   ; Max ~20 items visible
        Global ImGuiComboFlags_HeightLargest           = 1 << 4   ; As many fitting items as possible
        Global ImGuiComboFlags_NoArrowButton           = 1 << 5   ; Display on the preview box without the square arrow button
        Global ImGuiComboFlags_NoPreview               = 1 << 6   ; Display only a square arrow button
        Global ImGuiComboFlags_HeightMask_             = ImGuiComboFlags_HeightSmall | ImGuiComboFlags_HeightRegular | ImGuiComboFlags_HeightLarge | ImGuiComboFlags_HeightLargest
    }
    
    ;//------------------------------------------------------------------
    ;// ImGui::BeginTabBar()
    ;//------------------------------------------------------------------
    {
        Global ImGuiTabBarFlags_None                           = 0
        Global ImGuiTabBarFlags_Reorderable                    = 1 << 0   ; Allow manually dragging tabs to re-order them + New tabs are appended at the end of list
        Global ImGuiTabBarFlags_AutoSelectNewTabs              = 1 << 1   ; Automatically select new tabs when they appear
        Global ImGuiTabBarFlags_TabListPopupButton             = 1 << 2   ; Disable buttons to open the tab list popup
        Global ImGuiTabBarFlags_NoCloseWithMiddleMouseButton   = 1 << 3   ; Disable behavior of closing tabs (that are submitted with p_open != NULL) with middle mouse button. You can still repro this behavior on user's side with if (IsItemHovered() && IsMouseClicked(2)) *p_open = false.
        Global ImGuiTabBarFlags_NoTabListScrollingButtons      = 1 << 4   ; Disable scrolling buttons (apply when fitting policy is ImGuiTabBarFlags_FittingPolicyScroll)
        Global ImGuiTabBarFlags_NoTooltip                      = 1 << 5   ; Disable tooltips when hovering a tab
        Global ImGuiTabBarFlags_FittingPolicyResizeDown        = 1 << 6   ; Resize tabs when they don't fit
        Global ImGuiTabBarFlags_FittingPolicyScroll            = 1 << 7   ; Add scroll buttons when tabs don't fit
        Global ImGuiTabBarFlags_FittingPolicyMask_             = ImGuiTabBarFlags_FittingPolicyResizeDown | ImGuiTabBarFlags_FittingPolicyScroll
        Global ImGuiTabBarFlags_FittingPolicyDefault_          = ImGuiTabBarFlags_FittingPolicyResizeDown
    }
    ;//------------------------------------------------------------------
    ;// ImGui::BeginTabItem()
    ;//------------------------------------------------------------------
    
    Global ImGuiTabItemFlags_None                          = 0
    Global ImGuiTabItemFlags_UnsavedDocument               = 1 << 0   ; Append '*' to title without affecting the ID as a convenience to avoid using the ### operator. Also: tab is selected on closure and closure is deferred by one frame to allow code to undo it without flicker.
    Global ImGuiTabItemFlags_SetSelected                   = 1 << 1   ; Trigger flag to programmatically make the tab selected when calling BeginTabItem()
    Global ImGuiTabItemFlags_NoCloseWithMiddleMouseButton  = 1 << 2   ; Disable behavior of closing tabs (that are submitted with p_open != NULL) with middle mouse button. You can still repro this behavior on user's side with if (IsItemHovered() && IsMouseClicked(2)) *p_open = false.
    Global ImGuiTabItemFlags_NoPushId                      = 1 << 3   ; Don't call PushID(tab->ID)/PopID() on BeginTabItem()/EndTabItem()
    Global ImGuiTabItemFlags_NoTooltip                     = 1 << 4    ; Disable tooltip for the given tab
    
    ; Flags for ImGui::IsWindowFocused()
    Global ImGuiFocusedFlags_None                          = 0
        Global ImGuiFocusedFlags_ChildWindows                  = 1 << 0   ; IsWindowFocused(): Return true if any children of the window is focused
        Global ImGuiFocusedFlags_RootWindow                    = 1 << 1   ; IsWindowFocused(): Test from root window (top most parent of the current hierarchy)
        Global ImGuiFocusedFlags_AnyWindow                     = 1 << 2   ; IsWindowFocused(): Return true if any window is focused. Important: If you are trying to tell how to dispatch your low-level inputs do NOT use this. Use 'io.WantCaptureMouse' instead! Please read the FAQ!
        Global ImGuiFocusedFlags_RootAndChildWindows           = ImGuiFocusedFlags_RootWindow | ImGuiFocusedFlags_ChildWindows
        
    ; Flags for ImGui::IsItemHovered() ImGui::IsWindowHovered()
    ; Note: if you are trying to check whether your mouse should be dispatched to Dear ImGui or to your app you should use 'io.WantCaptureMouse' instead! Please read the FAQ!
    ; Note: windows with the ImGuiWindowFlags_NoInputs flag are ignored by IsWindowHovered() calls.
    Global ImGuiHoveredFlags_None                          = 0        ; Return true if directly over the item/window not obstructed by another window not obstructed by an active popup or modal blocking inputs under them.
    Global ImGuiHoveredFlags_ChildWindows                  = 1 << 0   ; IsWindowHovered() only: Return true if any children of the window is hovered
    Global ImGuiHoveredFlags_RootWindow                    = 1 << 1   ; IsWindowHovered() only: Test from root window (top most parent of the current hierarchy)
    Global ImGuiHoveredFlags_AnyWindow                     = 1 << 2   ; IsWindowHovered() only: Return true if any window is hovered
    Global ImGuiHoveredFlags_AllowWhenBlockedByPopup       = 1 << 3   ; Return true even if a popup window is normally blocking access to this item/window
    ;ImGuiHoveredFlags_AllowWhenBlockedByModal     = 1 << 4   ; Return true even if a modal popup window is normally blocking access to this item/window. FIXME-TODO: Unavailable yet.
    Global ImGuiHoveredFlags_AllowWhenBlockedByActiveItem  = 1 << 5   ; Return true even if an active item is blocking access to this item/window. Useful for Drag and Drop patterns.
    Global ImGuiHoveredFlags_AllowWhenOverlapped           = 1 << 6   ; Return true even if the position is obstructed or overlapped by another window
    Global ImGuiHoveredFlags_AllowWhenDisabled             = 1 << 7   ; Return true even if the item is disabled
    Global ImGuiHoveredFlags_RectOnly                      = ImGuiHoveredFlags_AllowWhenBlockedByPopup | ImGuiHoveredFlags_AllowWhenBlockedByActiveItem | ImGuiHoveredFlags_AllowWhenOverlapped
    Global ImGuiHoveredFlags_RootAndChildWindows           = ImGuiHoveredFlags_RootWindow | ImGuiHoveredFlags_ChildWindows
    
    ; Flags for ImGui::BeginDragDropSource() ImGui::AcceptDragDropPayload()
    Global ImGuiDragDropFlags_None                         = 0
    ; BeginDragDropSource() flags
    Global ImGuiDragDropFlags_SourceNoPreviewTooltip       = 1 << 0   ; By default a successful call to BeginDragDropSource opens a tooltip so you can display a preview or description of the source contents. This flag disable this behavior.
    Global ImGuiDragDropFlags_SourceNoDisableHover         = 1 << 1   ; By default when dragging we clear data so that IsItemHovered() will return false to avoid subsequent user code submitting tooltips. This flag disable this behavior so you can still call IsItemHovered() on the source item.
    Global ImGuiDragDropFlags_SourceNoHoldToOpenOthers     = 1 << 2   ; Disable the behavior that allows to open tree nodes and collapsing header by holding over them while dragging a source item.
    Global ImGuiDragDropFlags_SourceAllowNullID            = 1 << 3   ; Allow items such as Text() Image() that have no unique identifier to be used as drag source by manufacturing a temporary identifier based on their window-relative position. This is extremely unusual within the dear imgui ecosystem and so we made it explicit.
    Global ImGuiDragDropFlags_SourceExtern                 = 1 << 4   ; External source (from outside of dear imgui) won't attempt to read current item/window info. Will always return true. Only one Extern source can be active simultaneously.
    Global ImGuiDragDropFlags_SourceAutoExpirePayload      = 1 << 5   ; Automatically expire the payload if the source cease to be submitted (otherwise payloads are persisting while being dragged)
    ; AcceptDragDropPayload() flags
    Global ImGuiDragDropFlags_AcceptBeforeDelivery         = 1 << 10  ; AcceptDragDropPayload() will returns true even before the mouse button is released. You can then call IsDelivery() to test if the payload needs to be delivered.
        Global ImGuiDragDropFlags_AcceptNoDrawDefaultRect      = 1 << 11  ; Do not draw the default highlight rectangle when hovering over target.
    Global ImGuiDragDropFlags_AcceptNoPreviewTooltip       = 1 << 12  ; Request hiding the BeginDragDropSource tooltip from the BeginDragDropTarget site.
    Global ImGuiDragDropFlags_AcceptPeekOnly               = ImGuiDragDropFlags_AcceptBeforeDelivery | ImGuiDragDropFlags_AcceptNoDrawDefaultRect  ; For peeking ahead and inspecting the payload before delivery.
        
    ; A primary data type
    Global ImGuiDataType_S8 = 0
    Global ImGuiDataType_U8 = 1
    Global ImGuiDataType_S16 = 2
    Global ImGuiDataType_U16 = 3
    Global ImGuiDataType_S32 = 4
    Global ImGuiDataType_U32 = 5
    Global ImGuiDataType_S64 = 6
    Global ImGuiDataType_U64 = 7
    Global ImGuiDataType_Float = 8
    Global ImGuiDataType_Double = 9
    Global ImGuiDataType_COUNT = 10
    
    ; A cardinal direction
    Global ImGuiDir_None    =  -1
    Global ImGuiDir_Left    =  0
    Global ImGuiDir_Right   =  1
    Global ImGuiDir_Up      =  2
    Global ImGuiDir_Down    =  3
    
    ; User fill ImGuiIO.KeyMap[] array with indices into the ImGuiIO.KeysDown[512] array
    Global ImGuiKey_Tab = 0
    Global ImGuiKey_LeftArrow = 1
    Global ImGuiKey_RightArrow = 2
    Global ImGuiKey_UpArrow = 3
    Global ImGuiKey_DownArrow = 4
    Global ImGuiKey_PageUp = 5
    Global ImGuiKey_PageDown = 6
    Global ImGuiKey_Home = 7
    Global ImGuiKey_End = 8
    Global ImGuiKey_Insert = 9
    Global ImGuiKey_Delete = 10
    Global ImGuiKey_Backspace = 11
    Global ImGuiKey_Space = 12
    Global ImGuiKey_Enter = 13
    Global ImGuiKey_Escape = 14
    Global ImGuiKey_KeyPadEnter = 15
    Global ImGuiKey_A = 16
    Global ImGuiKey_C = 17
    Global ImGuiKey_V = 18
    Global ImGuiKey_X = 19
    Global ImGuiKey_Y = 20
    Global ImGuiKey_Z = 21
    
    ; To test io.KeyMods (which is a combination of individual fields io.KeyCtrl, io.KeyShift, io.KeyAlt set by user/back-end)
    Global ImGuiKeyModFlags_None       = 0
    Global ImGuiKeyModFlags_Ctrl       = 1 << 0
    Global ImGuiKeyModFlags_Shift      = 1 << 1
        Global ImGuiKeyModFlags_Alt        = 1 << 2
    Global ImGuiKeyModFlags_Super      = 1 << 3
    
    ; Gamepad Mapping
    Global ImGuiNavInput_Activate = 0
    Global ImGuiNavInput_Cancel = 1
    Global ImGuiNavInput_Input = 2
    Global ImGuiNavInput_Menu = 3
    Global ImGuiNavInput_DpadLeft = 4
    Global ImGuiNavInput_DpadRight = 5
    Global ImGuiNavInput_DpadUp = 6
    Global ImGuiNavInput_DpadDown = 7
    Global ImGuiNavInput_LStickLeft = 8
    Global ImGuiNavInput_LStickRight = 9
    Global ImGuiNavInput_LStickUp = 10
    Global ImGuiNavInput_LStickDown = 11
    Global ImGuiNavInput_FocusPrev = 12
    Global ImGuiNavInput_FocusNext = 13
    Global ImGuiNavInput_TweakSlow = 14
    Global ImGuiNavInput_TweakFast = 15
    
    ; [Internal] Don't use directly! This is used internally to differentiate keyboard from gamepad inputs for behaviors that require to differentiate them.
    ; Keyboard behavior that have no corresponding gamepad mapping (e.g. CTRL+TAB) will be directly reading from io.KeysDown[] instead of io.NavInputs[].
    Global ImGuiNavInput_KeyMenu_ = 16
    Global ImGuiNavInput_KeyLeft_ = 17
    Global ImGuiNavInput_KeyRight_ = 18
    Global ImGuiNavInput_KeyUp_ = 19
    Global ImGuiNavInput_KeyDown_ = 20
    Global ImGuiNavInput_COUNT = 21
    Global ImGuiNavInput_InternalStart_ =  ImGuiNavInput_KeyMenu_
    
    ; Configuration flags stored in io.ConfigFlags. Set by user/application.
    Global ImGuiConfigFlags_None                   = 0,
    Global ImGuiConfigFlags_NavEnableKeyboard      = 1 << 0,   ; Master keyboard navigation enable flag. NewFrame() will automatically fill io.NavInputs[] based on io.KeysDown[].
    Global ImGuiConfigFlags_NavEnableGamepad       = 1 << 1,   ; Master gamepad navigation enable flag. This is mostly to instruct your imgui back-end to fill io.NavInputs[]. Back-end also needs to set ImGuiBackendFlags_HasGamepad.
    Global ImGuiConfigFlags_NavEnableSetMousePos   = 1 << 2,   ; Instruct navigation to move the mouse cursor. May be useful on TV/console systems where moving a virtual mouse is awkward. Will update io.MousePos and set io.WantSetMousePos=true. If enabled you MUST honor io.WantSetMousePos requests in your binding, otherwise ImGui will react as if the mouse is jumping around back and forth.
    Global ImGuiConfigFlags_NavNoCaptureKeyboard   = 1 << 3,   ; Instruct navigation to not set the io.WantCaptureKeyboard flag when io.NavActive is set.
    Global ImGuiConfigFlags_NoMouse                = 1 << 4,   ; Instruct imgui to clear mouse position/buttons in NewFrame(). This allows ignoring the mouse information set by the back-end.
    Global ImGuiConfigFlags_NoMouseCursorChange    = 1 << 5,   ; Instruct back-end to not alter mouse cursor shape and visibility. Use if the back-end cursor changes are interfering with yours and you don't want to use SetMouseCursor() to change mouse cursor. You may want to honor requests from imgui by reading GetMouseCursor() yourself instead.
    
    ; User storage (to allow your back-end/engine to communicate to code that may be shared between multiple projects. Those flags are not used by core Dear ImGui)
    Global ImGuiConfigFlags_IsSRGB                 = 1 << 20,  ; Application is SRGB-aware.
    Global ImGuiConfigFlags_IsTouchScreen          = 1 << 21   ; Application is using a touch screen instead of a mouse.
    
    ; Back-end capabilities flags stored in io.BackendFlags. Set by imgui_impl_xxx or custom back-end.
    Global ImGuiBackendFlags_None                  = 0,
    Global ImGuiBackendFlags_HasGamepad            = 1 << 0,   ; Back-end Platform supports gamepad and currently has one connected.
    Global ImGuiBackendFlags_HasMouseCursors       = 1 << 1,   ; Back-end Platform supports honoring GetMouseCursor() value to change the OS cursor shape.
    Global ImGuiBackendFlags_HasSetMousePos        = 1 << 2,   ; Back-end Platform supports io.WantSetMousePos requests to reposition the OS mouse position (only used if ImGuiConfigFlags_NavEnableSetMousePos is set).
    Global ImGuiBackendFlags_RendererHasVtxOffset  = 1 << 3    ; Back-end Renderer supports ImDrawCmd::VtxOffset. This enables output of large meshes (64K+ vertices) while still using 16-bit indices.
    
    ; Enumeration for PushStyleColor() / PopStyleColor()
    Global ImGuiCol_Text = 0
    Global ImGuiCol_TextDisabled = 1
    Global ImGuiCol_WindowBg = 2
    Global ImGuiCol_ChildBg = 3
    Global ImGuiCol_PopupBg = 4
    Global ImGuiCol_Border = 5
    Global ImGuiCol_BorderShadow = 6
    Global ImGuiCol_FrameBg = 7
    Global ImGuiCol_FrameBgHovered = 8
    Global ImGuiCol_FrameBgActive = 9
    Global ImGuiCol_TitleBg = 10
    Global ImGuiCol_TitleBgActive = 11
    Global ImGuiCol_TitleBgCollapsed = 12
    Global ImGuiCol_MenuBarBg = 13
    Global ImGuiCol_ScrollbarBg = 14
    Global ImGuiCol_ScrollbarGrab = 15
    Global ImGuiCol_ScrollbarGrabHovered = 16
    Global ImGuiCol_ScrollbarGrabActive = 17
    Global ImGuiCol_CheckMark = 18
    Global ImGuiCol_SliderGrab = 19
    Global ImGuiCol_SliderGrabActive = 20
    Global ImGuiCol_Button = 21
    Global ImGuiCol_ButtonHovered = 22
    Global ImGuiCol_ButtonActive = 23
    Global ImGuiCol_Header = 24
    Global ImGuiCol_HeaderHovered = 25
    Global ImGuiCol_HeaderActive = 26
    Global ImGuiCol_Separator = 27
    Global ImGuiCol_SeparatorHovered = 28
    Global ImGuiCol_SeparatorActive = 29
    Global ImGuiCol_ResizeGrip = 30
    Global ImGuiCol_ResizeGripHovered = 31
    Global ImGuiCol_ResizeGripActive = 32
    Global ImGuiCol_Tab = 33
    Global ImGuiCol_TabHovered = 34
    Global ImGuiCol_TabActive = 35
    Global ImGuiCol_TabUnfocused = 36
    Global ImGuiCol_TabUnfocusedActive = 37
    Global ImGuiCol_DockingPreview = 38
    Global ImGuiCol_DockingEmptyBg = 39
    Global ImGuiCol_PlotLines = 40
    Global ImGuiCol_PlotLinesHovered = 41
    Global ImGuiCol_PlotHistogram = 42
    Global ImGuiCol_PlotHistogramHovered = 43
    Global ImGuiCol_TextSelectedBg = 44
    Global ImGuiCol_DragDropTarget = 45
    Global ImGuiCol_NavHighlight = 46
    Global ImGuiCol_NavWindowingHighlight = 47
    Global ImGuiCol_NavWindowingDimBg = 48
    Global ImGuiCol_ModalWindowDimBg = 49
    
    ; Enumeration for PushStyleVar() / PopStyleVar() to temporarily modify the ImGuiStyle structure.
    ; - The enum only refers to fields of ImGuiStyle which makes sense to be pushed/popped inside UI code.
    ;   During initialization or between frames, feel free to just poke into ImGuiStyle directly.
    ; - Tip: Use your programming IDE navigation facilities on the names in the _second column_ below to find the actual members and their description.
    ;   In Visual Studio IDE: CTRL+comma ("Edit.NavigateTo") can follow symbols in comments, whereas CTRL+F12 ("Edit.GoToImplementation") cannot.
    ;   With Visual Assist installed: ALT+G ("VAssistX.GoToImplementation") can also follow symbols in comments.
    ; - When changing this enum, you need to update the associated internal table GStyleVarInfo[] accordingly. This is where we link enum values to members offset/type.
    ; Enum name --------------------- ; Member in ImGuiStyle structure (see ImGuiStyle for descriptions)
    Global ImGuiStyleVar_Alpha = 0
    Global ImGuiStyleVar_WindowPadding = 1
    Global ImGuiStyleVar_WindowRounding = 2
    Global ImGuiStyleVar_WindowBorderSize = 3
    Global ImGuiStyleVar_WindowMinSize = 4
    Global ImGuiStyleVar_WindowTitleAlign = 5
    Global ImGuiStyleVar_ChildRounding = 6
    Global ImGuiStyleVar_ChildBorderSize = 7
    Global ImGuiStyleVar_PopupRounding = 8
    Global ImGuiStyleVar_PopupBorderSize = 9
    Global ImGuiStyleVar_FramePadding = 10
    Global ImGuiStyleVar_FrameRounding = 11
    Global ImGuiStyleVar_FrameBorderSize = 12
    Global ImGuiStyleVar_ItemSpacing = 13
    Global ImGuiStyleVar_ItemInnerSpacing = 14
    Global ImGuiStyleVar_IndentSpacing = 15
    Global ImGuiStyleVar_ScrollbarSize = 16
    Global ImGuiStyleVar_ScrollbarRounding = 17
    Global ImGuiStyleVar_GrabMinSize = 18
    Global ImGuiStyleVar_GrabRounding = 19
    Global ImGuiStyleVar_TabRounding = 20
    Global ImGuiStyleVar_ButtonTextAlign = 21
    Global ImGuiStyleVar_SelectableTextAlign = 22
    
    Global ImGuiColorEditFlags_None            = 0,
    ; Flags for ColorEdit3() / ColorEdit4() / ColorPicker3() / ColorPicker4() / ColorButton()
    Global ImGuiColorEditFlags_NoAlpha         = 1 << 1,   ;              ; ColorEdit, ColorPicker, ColorButton: ignore Alpha component (will only read 3 components from the input pointer).
    Global ImGuiColorEditFlags_NoPicker        = 1 << 2,   ;              ; ColorEdit: disable picker when clicking on colored square.
    Global ImGuiColorEditFlags_NoOptions       = 1 << 3,   ;              ; ColorEdit: disable toggling options menu when right-clicking on inputs/small preview.
    Global ImGuiColorEditFlags_NoSmallPreview  = 1 << 4,   ;              ; ColorEdit, ColorPicker: disable colored square preview next to the inputs. (e.g. to show only the inputs)
    Global ImGuiColorEditFlags_NoInputs        = 1 << 5,   ;              ; ColorEdit, ColorPicker: disable inputs sliders/text widgets (e.g. to show only the small preview colored square).
    Global ImGuiColorEditFlags_NoTooltip       = 1 << 6,   ;              ; ColorEdit, ColorPicker, ColorButton: disable tooltip when hovering the preview.
    Global ImGuiColorEditFlags_NoLabel         = 1 << 7,   ;              ; ColorEdit, ColorPicker: disable display of inline text label (the label is still forwarded to the tooltip and picker).
    Global ImGuiColorEditFlags_NoSidePreview   = 1 << 8,   ;              ; ColorPicker: disable bigger color preview on right side of the picker, use small colored square preview instead.
    Global ImGuiColorEditFlags_NoDragDrop      = 1 << 9,   ;              ; ColorEdit: disable drag and drop target. ColorButton: disable drag and drop source.
    Global ImGuiColorEditFlags_NoBorder        = 1 << 10,  ;              ; ColorButton: disable border (which is enforced by default)
    
    ; User Options (right-click on widget to change some of them).
    Global ImGuiColorEditFlags_AlphaBar        = 1 << 16,  ;              ; ColorEdit, ColorPicker: show vertical alpha bar/gradient in picker.
    Global ImGuiColorEditFlags_AlphaPreview    = 1 << 17,  ;              ; ColorEdit, ColorPicker, ColorButton: display preview as a transparent color over a checkerboard, instead of opaque.
    Global ImGuiColorEditFlags_AlphaPreviewHalf= 1 << 18,  ;              ; ColorEdit, ColorPicker, ColorButton: display half opaque / half checkerboard, instead of opaque.
    Global ImGuiColorEditFlags_HDR             = 1 << 19,  ;              ; (WIP) ColorEdit: Currently only disable 0.0f..1.0f limits in RGBA edition (note: you probably want to use ImGuiColorEditFlags_Float flag as well).
    Global ImGuiColorEditFlags_DisplayRGB      = 1 << 20,  ; [Display]    ; ColorEdit: override _display_ type among RGB/HSV/Hex. ColorPicker: select any combination using one or more of RGB/HSV/Hex.
    Global ImGuiColorEditFlags_DisplayHSV      = 1 << 21,  ; [Display]    ; "
    Global ImGuiColorEditFlags_DisplayHex      = 1 << 22,  ; [Display]    ; "
    Global ImGuiColorEditFlags_Uint8           = 1 << 23,  ; [DataType]   ; ColorEdit, ColorPicker, ColorButton: _display_ values formatted as 0..255.
    Global ImGuiColorEditFlags_Float           = 1 << 24,  ; [DataType]   ; ColorEdit, ColorPicker, ColorButton: _display_ values formatted as 0.0f..1.0f floats instead of 0..255 integers. No round-trip of value via integers.
    Global ImGuiColorEditFlags_PickerHueBar    = 1 << 25,  ; [Picker]     ; ColorPicker: bar for Hue, rectangle for Sat/Value.
    Global ImGuiColorEditFlags_PickerHueWheel  = 1 << 26,  ; [Picker]     ; ColorPicker: wheel for Hue, triangle for Sat/Value.
    Global ImGuiColorEditFlags_InputRGB        = 1 << 27,  ; [Input]      ; ColorEdit, ColorPicker: input and output data in RGB format.
    Global ImGuiColorEditFlags_InputHSV        = 1 << 28,  ; [Input]      ; ColorEdit, ColorPicker: input and output data in HSV format.
    
    ; Identify a mouse button.
    ; Those values are guaranteed to be stable and we frequently use 0/1 directly. Named enums provided for convenience.
    Global ImGuiMouseButton_Left = 0
    Global ImGuiMouseButton_Right = 1
    Global ImGuiMouseButton_Middle = 2
    Global ImGuiMouseButton_COUNT = 5
    
    ; Enumeration for GetMouseCursor()
    ; User code may request binding to display given cursor by calling SetMouseCursor(), which is why we have some cursors that are marked unused here
    Global ImGuiMouseCursor_None =  -1
    Global ImGuiMouseCursor_Arrow =  0
    Global ImGuiMouseCursor_TextInput = 0
    Global ImGuiMouseCursor_ResizeAll = 1
    Global ImGuiMouseCursor_ResizeNS = 2
    Global ImGuiMouseCursor_ResizeEW = 3
    Global ImGuiMouseCursor_ResizeNESW = 4
    Global ImGuiMouseCursor_ResizeNWSE = 5
    Global ImGuiMouseCursor_Hand = 6
    Global ImGuiMouseCursor_NotAllowed = 7
    
    Global ImDrawCornerFlags_None      = 0,
    Global ImDrawCornerFlags_TopLeft   = 1 << 0, ; 0x1
    Global ImDrawCornerFlags_TopRight  = 1 << 1, ; 0x2
    Global ImDrawCornerFlags_BotLeft   = 1 << 2, ; 0x4
    Global ImDrawCornerFlags_BotRight  = 1 << 3, ; 0x8
    Global ImDrawCornerFlags_Top       = ImDrawCornerFlags_TopLeft | ImDrawCornerFlags_TopRight,   ; 0x3
    Global ImDrawCornerFlags_Bot       = ImDrawCornerFlags_BotLeft | ImDrawCornerFlags_BotRight,   ; 0xC
    Global ImDrawCornerFlags_Left      = ImDrawCornerFlags_TopLeft | ImDrawCornerFlags_BotLeft,    ; 0x5
    Global ImDrawCornerFlags_Right     = ImDrawCornerFlags_TopRight | ImDrawCornerFlags_BotRight,  ; 0xA
    Global ImDrawCornerFlags_All       = 0xF     ; In your function calls you may use ~0 (= all bits sets) instead of ImDrawCornerFlags_All, as a convenience
    
    ; Flags for ImDrawList. Those are set automatically by ImGui:: functions from ImGuiIO settings, and generally not manipulated directly.
    ; It is however possible to temporarily alter flags between calls to ImDrawList:: functions.
    Global ImDrawListFlags_None                    = 0,
    Global ImDrawListFlags_AntiAliasedLines        = 1 << 0,  ; Enable anti-aliased lines/borders (*2 the number of triangles for 1.0f wide line or lines thin enough to be drawn using textures, otherwise *3 the number of triangles)
    Global ImDrawListFlags_AntiAliasedLinesUseTex  = 1 << 1,  ; Enable anti-aliased lines/borders using textures when possible. Require back-end to render with bilinear filtering.
    Global ImDrawListFlags_AntiAliasedFill         = 1 << 2,  ; Enable anti-aliased edge around filled shapes (rounded rectangles, circles).
    Global ImDrawListFlags_AllowVtxOffset          = 1 << 3   ; Can emit 'VtxOffset > 0' to allow large meshes. Set when 'ImGuiBackendFlags_RendererHasVtxOffset' is enabled.
}
;//------------------------------------------------------------------

;// struct ImGuiIO
;//------------------------------------------------------------------
{
    VarSetCapacity(_ImGuiIO, 4754, 0)
    
    ImGuiIO_BackendFlags := NumGet(ImGuiIO, 0, "Int")
    ImGuiIO_DisplaySize := NumGet(ImGuiIO, 4, "Double")
    ImGuiIO_DeltaTime := NumGet(ImGuiIO, 12, "Float")
    ImGuiIO_IniSavingRate := NumGet(ImGuiIO, 16, "Float")
    ImGuiIO_IniFilename := NumGet(ImGuiIO, 20, "Ptr")
        ImGuiIO_LogFilename := NumGet(ImGuiIO, 28, "Ptr")
    ImGuiIO_MouseDoubleClickTime := NumGet(ImGuiIO, 36, "Float")
    ImGuiIO_MouseDoubleClickMaxDist := NumGet(ImGuiIO, 40, "Float")
    ImGuiIO_MouseDragThreshold := NumGet(ImGuiIO, 44, "Float")
    ImGuiIO_KeyMap[%index%] := NumGet(ImGuiIO, 48 + index*4, "Int"), ImGuiIO_KeyMap_length := 22
    ImGuiIO_KeyRepeatDelay := NumGet(ImGuiIO, 136, "Float")
    ImGuiIO_KeyRepeatRate := NumGet(ImGuiIO, 140, "Float")
    ImGuiIO_UserData := NumGet(ImGuiIO, 144, "Ptr")
    ImGuiIO_Fonts := NumGet(ImGuiIO, 152, "Ptr")
    ImGuiIO_FontGlobalScale := NumGet(ImGuiIO, 160, "Float")
    ImGuiIO_FontAllowUserScaling := NumGet(ImGuiIO, 164, "UChar")
    ImGuiIO_FontDefault := NumGet(ImGuiIO, 165, "Ptr")
    ImGuiIO_DisplayFramebufferScale := NumGet(ImGuiIO, 173, "Double")
    ImGuiIO_MouseDrawCursor := NumGet(ImGuiIO, 181, "UChar")
    ImGuiIO_ConfigMacOSXBehaviors := NumGet(ImGuiIO, 182, "UChar")
    ImGuiIO_ConfigInputTextCursorBlink := NumGet(ImGuiIO, 183, "UChar")
    ImGuiIO_ConfigWindowsResizeFromEdges := NumGet(ImGuiIO, 184, "UChar")
    ImGuiIO_ConfigWindowsMoveFromTitleBarOnly := NumGet(ImGuiIO, 185, "UChar")
    ImGuiIO_ConfigWindowsMemoryCompactTimer := NumGet(ImGuiIO, 186, "Float")
    ImGuiIO_BackendPlatformName := NumGet(ImGuiIO, 190, "Ptr")
        ImGuiIO_BackendRendererName := NumGet(ImGuiIO, 198, "Ptr")
    ImGuiIO_BackendPlatformUserData := NumGet(ImGuiIO, 206, "Ptr")
        ImGuiIO_BackendRendererUserData := NumGet(ImGuiIO, 214, "Ptr")
    ImGuiIO_BackendLanguageUserData := NumGet(ImGuiIO, 222, "Ptr")
    ImGuiIO_GetClipboardTextFn := NumGet(ImGuiIO, 230, "Ptr")
    ImGuiIO_SetClipboardTextFn := NumGet(ImGuiIO, 238, "Ptr")
    ImGuiIO_ClipboardUserData := NumGet(ImGuiIO, 246, "Ptr")
    ImGuiIO_ImeWindowHandle := NumGet(ImGuiIO, 254, "Ptr")
    ImGuiIO_RenderDrawListsFnUnused := NumGet(ImGuiIO, 262, "Ptr")
    ImGuiIO_MousePos := NumGet(ImGuiIO, 270, "Double")
    ImGuiIO_MouseDown := NumGet(ImGuiIO, 278, "UChar")
    ImGuiIO_MouseWheel := NumGet(ImGuiIO, 279, "Float")
    ImGuiIO_MouseWheelH := NumGet(ImGuiIO, 283, "Float")
    ImGuiIO_KeyCtrl := NumGet(ImGuiIO, 287, "UChar")
    ImGuiIO_KeyShift := NumGet(ImGuiIO, 288, "UChar")
        ImGuiIO_KeyAlt := NumGet(ImGuiIO, 289, "UChar")
    ImGuiIO_KeySuper := NumGet(ImGuiIO, 290, "UChar")
    ImGuiIO_KeysDown := NumGet(ImGuiIO, 291, "UChar")
    ImGuiIO_WantCaptureMouse := NumGet(ImGuiIO, 292, "UChar")
    ImGuiIO_WantCaptureKeyboard := NumGet(ImGuiIO, 293, "UChar")
    ImGuiIO_WantTextInput := NumGet(ImGuiIO, 294, "UChar")
    ImGuiIO_WantSetMousePos := NumGet(ImGuiIO, 295, "UChar")
    ImGuiIO_WantSaveIniSettings := NumGet(ImGuiIO, 296, "UChar")
    ImGuiIO_NavActive := NumGet(ImGuiIO, 297, "UChar")
    ImGuiIO_NavVisible := NumGet(ImGuiIO, 298, "UChar")
    ImGuiIO_Framerate := NumGet(ImGuiIO, 299, "Float")
    ImGuiIO_MetricsRenderVertices := NumGet(ImGuiIO, 303, "Int")
    ImGuiIO_MetricsRenderIndices := NumGet(ImGuiIO, 307, "Int")
    ImGuiIO_MetricsRenderWindows := NumGet(ImGuiIO, 311, "Int")
    ImGuiIO_MetricsActiveWindows := NumGet(ImGuiIO, 315, "Int")
    ImGuiIO_MetricsActiveAllocations := NumGet(ImGuiIO, 319, "Int")
    ImGuiIO_MouseDelta := NumGet(ImGuiIO, 323, "Double")
    ImGuiIO_KeyMods := NumGet(ImGuiIO, 331, "Int")
    ImGuiIO_MousePosPrev := NumGet(ImGuiIO, 335, "Float")
    ImGuiIO_MouseClickedPos[%index%] := NumGet(ImGuiIO, 339 + index*4, "Float"), ImGuiIO_MouseClickedPos_length := 5
    ImGuiIO_MouseClickedTime[%index%] := NumGet(ImGuiIO, 359 + index*8, "Double"), ImGuiIO_MouseClickedTime_length := 5
    ImGuiIO_MouseClicked := NumGet(ImGuiIO, 399, "UChar")
    ImGuiIO_MouseDoubleClicked := NumGet(ImGuiIO, 400, "UChar")
    ImGuiIO_MouseReleased := NumGet(ImGuiIO, 401, "UChar")
    ImGuiIO_MouseDownOwned := NumGet(ImGuiIO, 402, "UChar")
    ImGuiIO_MouseDownWasDoubleClick := NumGet(ImGuiIO, 403, "UChar")
    ImGuiIO_MouseDownDuration[%index%] := NumGet(ImGuiIO, 404 + index*4, "Float"), ImGuiIO_MouseDownDuration_length := 5
    ImGuiIO_MouseDownDurationPrev[%index%] := NumGet(ImGuiIO, 424 + index*4, "Float"), ImGuiIO_MouseDownDurationPrev_length := 5
    ImGuiIO_MouseDragMaxDistanceAbs[%index%] := NumGet(ImGuiIO, 444 + index*4, "Float"), ImGuiIO_MouseDragMaxDistanceAbs_length := 5
    ImGuiIO_MouseDragMaxDistanceSqr[%index%] := NumGet(ImGuiIO, 464 + index*4, "Float"), ImGuiIO_MouseDragMaxDistanceSqr_length := 5
    ImGuiIO_KeysDownDuration[%index%] := NumGet(ImGuiIO, 484 + index*4, "Float"), ImGuiIO_KeysDownDuration_length := 512
    ImGuiIO_KeysDownDurationPrev[%index%] := NumGet(ImGuiIO, 2532 + index*4, "Float"), ImGuiIO_KeysDownDurationPrev_length := 512
    ImGuiIO_NavInputsDownDuration[%index%] := NumGet(ImGuiIO, 4580 + index*4, "Float"), ImGuiIO_NavInputsDownDuration_length := 21
    ImGuiIO_NavInputsDownDurationPrev[%index%] := NumGet(ImGuiIO, 4664 + index*4, "Float"), ImGuiIO_NavInputsDownDurationPrev_length := 21
    ImGuiIO_PenPressure := NumGet(ImGuiIO, 4748, "Float")
    ImGuiIO_InputQueueSurrogate := NumGet(ImGuiIO, 4752, "UShort")
    
    NumPut(ImGuiIO_BackendFlags, ImGuiIO, 0, "Int")
    NumPut(ImGuiIO_DisplaySize, ImGuiIO, 4, "Double")
    NumPut(ImGuiIO_DeltaTime, ImGuiIO, 12, "Float")
    NumPut(ImGuiIO_IniSavingRate, ImGuiIO, 16, "Float")
    NumPut(ImGuiIO_IniFilename, ImGuiIO, 20, "Ptr")
        NumPut(ImGuiIO_LogFilename, ImGuiIO, 28, "Ptr")
    NumPut(ImGuiIO_MouseDoubleClickTime, ImGuiIO, 36, "Float")
    NumPut(ImGuiIO_MouseDoubleClickMaxDist, ImGuiIO, 40, "Float")
    NumPut(ImGuiIO_MouseDragThreshold, ImGuiIO, 44, "Float")
    NumPut(ImGuiIO_KeyMap[%index%], ImGuiIO, 48 + index*4, "Int")
    NumPut(ImGuiIO_KeyRepeatDelay, ImGuiIO, 136, "Float")
    NumPut(ImGuiIO_KeyRepeatRate, ImGuiIO, 140, "Float")
    NumPut(ImGuiIO_UserData, ImGuiIO, 144, "Ptr")
    NumPut(ImGuiIO_Fonts, ImGuiIO, 152, "Ptr")
    NumPut(ImGuiIO_FontGlobalScale, ImGuiIO, 160, "Float")
    NumPut(ImGuiIO_FontAllowUserScaling, ImGuiIO, 164, "UChar")
    NumPut(ImGuiIO_FontDefault, ImGuiIO, 165, "Ptr")
    NumPut(ImGuiIO_DisplayFramebufferScale, ImGuiIO, 173, "Double")
    NumPut(ImGuiIO_MouseDrawCursor, ImGuiIO, 181, "UChar")
    NumPut(ImGuiIO_ConfigMacOSXBehaviors, ImGuiIO, 182, "UChar")
    NumPut(ImGuiIO_ConfigInputTextCursorBlink, ImGuiIO, 183, "UChar")
    NumPut(ImGuiIO_ConfigWindowsResizeFromEdges, ImGuiIO, 184, "UChar")
    NumPut(ImGuiIO_ConfigWindowsMoveFromTitleBarOnly, ImGuiIO, 185, "UChar")
    NumPut(ImGuiIO_ConfigWindowsMemoryCompactTimer, ImGuiIO, 186, "Float")
    NumPut(ImGuiIO_BackendPlatformName, ImGuiIO, 190, "Ptr")
        NumPut(ImGuiIO_BackendRendererName, ImGuiIO, 198, "Ptr")
    NumPut(ImGuiIO_BackendPlatformUserData, ImGuiIO, 206, "Ptr")
        NumPut(ImGuiIO_BackendRendererUserData, ImGuiIO, 214, "Ptr")
    NumPut(ImGuiIO_BackendLanguageUserData, ImGuiIO, 222, "Ptr")
    NumPut(ImGuiIO_GetClipboardTextFn, ImGuiIO, 230, "Ptr")
    NumPut(ImGuiIO_SetClipboardTextFn, ImGuiIO, 238, "Ptr")
    NumPut(ImGuiIO_ClipboardUserData, ImGuiIO, 246, "Ptr")
    NumPut(ImGuiIO_ImeWindowHandle, ImGuiIO, 254, "Ptr")
    NumPut(ImGuiIO_RenderDrawListsFnUnused, ImGuiIO, 262, "Ptr")
    NumPut(ImGuiIO_MousePos, ImGuiIO, 270, "Double")
    NumPut(ImGuiIO_MouseDown, ImGuiIO, 278, "UChar")
    NumPut(ImGuiIO_MouseWheel, ImGuiIO, 279, "Float")
    NumPut(ImGuiIO_MouseWheelH, ImGuiIO, 283, "Float")
    NumPut(ImGuiIO_KeyCtrl, ImGuiIO, 287, "UChar")
    NumPut(ImGuiIO_KeyShift, ImGuiIO, 288, "UChar")
        NumPut(ImGuiIO_KeyAlt, ImGuiIO, 289, "UChar")
    NumPut(ImGuiIO_KeySuper, ImGuiIO, 290, "UChar")
    NumPut(ImGuiIO_KeysDown, ImGuiIO, 291, "UChar")
    NumPut(ImGuiIO_WantCaptureMouse, ImGuiIO, 292, "UChar")
    NumPut(ImGuiIO_WantCaptureKeyboard, ImGuiIO, 293, "UChar")
    NumPut(ImGuiIO_WantTextInput, ImGuiIO, 294, "UChar")
    NumPut(ImGuiIO_WantSetMousePos, ImGuiIO, 295, "UChar")
    NumPut(ImGuiIO_WantSaveIniSettings, ImGuiIO, 296, "UChar")
    NumPut(ImGuiIO_NavActive, ImGuiIO, 297, "UChar")
    NumPut(ImGuiIO_NavVisible, ImGuiIO, 298, "UChar")
    NumPut(ImGuiIO_Framerate, ImGuiIO, 299, "Float")
    NumPut(ImGuiIO_MetricsRenderVertices, ImGuiIO, 303, "Int")
    NumPut(ImGuiIO_MetricsRenderIndices, ImGuiIO, 307, "Int")
    NumPut(ImGuiIO_MetricsRenderWindows, ImGuiIO, 311, "Int")
    NumPut(ImGuiIO_MetricsActiveWindows, ImGuiIO, 315, "Int")
    NumPut(ImGuiIO_MetricsActiveAllocations, ImGuiIO, 319, "Int")
    NumPut(ImGuiIO_MouseDelta, ImGuiIO, 323, "Double")
    NumPut(ImGuiIO_KeyMods, ImGuiIO, 331, "Int")
    NumPut(ImGuiIO_MousePosPrev, ImGuiIO, 335, "Float")
    NumPut(ImGuiIO_MouseClickedPos[%index%], ImGuiIO, 339 + index*4, "Float")
    NumPut(ImGuiIO_MouseClickedTime[%index%], ImGuiIO, 359 + index*8, "Double")
    NumPut(ImGuiIO_MouseClicked, ImGuiIO, 399, "UChar")
    NumPut(ImGuiIO_MouseDoubleClicked, ImGuiIO, 400, "UChar")
    NumPut(ImGuiIO_MouseReleased, ImGuiIO, 401, "UChar")
    NumPut(ImGuiIO_MouseDownOwned, ImGuiIO, 402, "UChar")
    NumPut(ImGuiIO_MouseDownWasDoubleClick, ImGuiIO, 403, "UChar")
    NumPut(ImGuiIO_MouseDownDuration[%index%], ImGuiIO, 404 + index*4, "Float")
    NumPut(ImGuiIO_MouseDownDurationPrev[%index%], ImGuiIO, 424 + index*4, "Float")
    NumPut(ImGuiIO_MouseDragMaxDistanceAbs[%index%], ImGuiIO, 444 + index*4, "Float")
    NumPut(ImGuiIO_MouseDragMaxDistanceSqr[%index%], ImGuiIO, 464 + index*4, "Float")
    NumPut(ImGuiIO_KeysDownDuration[%index%], ImGuiIO, 484 + index*4, "Float")
    NumPut(ImGuiIO_KeysDownDurationPrev[%index%], ImGuiIO, 2532 + index*4, "Float")
    NumPut(ImGuiIO_NavInputsDownDuration[%index%], ImGuiIO, 4580 + index*4, "Float")
    NumPut(ImGuiIO_NavInputsDownDurationPrev[%index%], ImGuiIO, 4664 + index*4, "Float")
    NumPut(ImGuiIO_PenPressure, ImGuiIO, 4748, "Float")
    NumPut(ImGuiIO_InputQueueSurrogate, ImGuiIO, 4752, "UShort")
}
;//------------------------------------------------------------------

;// struct ImGuiStyle
;//------------------------------------------------------------------
{
    VarSetCapacity(ImGuiStyle, 143, 0)
    
    ImGuiStyle_Alpha := NumGet(ImGuiStyle, 0, "Float")
    ImGuiStyle_WindowPadding := NumGet(ImGuiStyle, 4, "Float")
    ImGuiStyle_WindowRounding := NumGet(ImGuiStyle, 8, "Float")
    ImGuiStyle_WindowBorderSize := NumGet(ImGuiStyle, 12, "Float")
    ImGuiStyle_WindowMinSize := NumGet(ImGuiStyle, 16, "Float")
    ImGuiStyle_WindowTitleAlign := NumGet(ImGuiStyle, 20, "Float")
    ImGuiStyle_WindowMenuButtonPosition := NumGet(ImGuiStyle, 24, "Int")
    ImGuiStyle_ChildRounding := NumGet(ImGuiStyle, 28, "Float")
    ImGuiStyle_ChildBorderSize := NumGet(ImGuiStyle, 32, "Float")
    ImGuiStyle_PopupRounding := NumGet(ImGuiStyle, 36, "Float")
    ImGuiStyle_PopupBorderSize := NumGet(ImGuiStyle, 40, "Float")
    ImGuiStyle_FramePadding := NumGet(ImGuiStyle, 44, "Float")
    ImGuiStyle_FrameRounding := NumGet(ImGuiStyle, 48, "Float")
    ImGuiStyle_FrameBorderSize := NumGet(ImGuiStyle, 52, "Float")
    ImGuiStyle_ItemSpacing := NumGet(ImGuiStyle, 56, "Float")
    ImGuiStyle_ItemInnerSpacing := NumGet(ImGuiStyle, 60, "Float")
    ImGuiStyle_TouchExtraPadding := NumGet(ImGuiStyle, 64, "Float")
    ImGuiStyle_IndentSpacing := NumGet(ImGuiStyle, 68, "Float")
    ImGuiStyle_ColumnsMinSpacing := NumGet(ImGuiStyle, 72, "Float")
    ImGuiStyle_ScrollbarSize := NumGet(ImGuiStyle, 76, "Float")
    ImGuiStyle_ScrollbarRounding := NumGet(ImGuiStyle, 80, "Float")
    ImGuiStyle_GrabMinSize := NumGet(ImGuiStyle, 84, "Float")
    ImGuiStyle_GrabRounding := NumGet(ImGuiStyle, 88, "Float")
    ImGuiStyle_LogSliderDeadzone := NumGet(ImGuiStyle, 92, "Float")
    ImGuiStyle_TabRounding := NumGet(ImGuiStyle, 96, "Float")
    ImGuiStyle_TabBorderSize := NumGet(ImGuiStyle, 100, "Float")
    ImGuiStyle_TabMinWidthForUnselectedCloseButton := NumGet(ImGuiStyle, 104, "Float")
        ImGuiStyle_ColorButtonPosition := NumGet(ImGuiStyle, 108, "Int")
    ImGuiStyle_ButtonTextAlign := NumGet(ImGuiStyle, 112, "Float")
    ImGuiStyle_SelectableTextAlign := NumGet(ImGuiStyle, 116, "Float")
    ImGuiStyle_DisplayWindowPadding := NumGet(ImGuiStyle, 120, "Float")
    ImGuiStyle_DisplaySafeAreaPadding := NumGet(ImGuiStyle, 124, "Float")
    ImGuiStyle_MouseCursorScale := NumGet(ImGuiStyle, 128, "Float")
    ImGuiStyle_AntiAliasedLines := NumGet(ImGuiStyle, 132, "UChar")
    ImGuiStyle_AntiAliasedLinesUseTex := NumGet(ImGuiStyle, 133, "UChar")
    ImGuiStyle_AntiAliasedFill := NumGet(ImGuiStyle, 134, "UChar")
    ImGuiStyle_CurveTessellationTol := NumGet(ImGuiStyle, 135, "Float")
    ImGuiStyle_CircleSegmentMaxError := NumGet(ImGuiStyle, 139, "Float")
    
    NumPut(ImGuiStyle_Alpha, ImGuiStyle, 0, "Float")
    NumPut(ImGuiStyle_WindowPadding, ImGuiStyle, 4, "Float")
    NumPut(ImGuiStyle_WindowRounding, ImGuiStyle, 8, "Float")
    NumPut(ImGuiStyle_WindowBorderSize, ImGuiStyle, 12, "Float")
    NumPut(ImGuiStyle_WindowMinSize, ImGuiStyle, 16, "Float")
    NumPut(ImGuiStyle_WindowTitleAlign, ImGuiStyle, 20, "Float")
    NumPut(ImGuiStyle_WindowMenuButtonPosition, ImGuiStyle, 24, "Int")
    NumPut(ImGuiStyle_ChildRounding, ImGuiStyle, 28, "Float")
    NumPut(ImGuiStyle_ChildBorderSize, ImGuiStyle, 32, "Float")
    NumPut(ImGuiStyle_PopupRounding, ImGuiStyle, 36, "Float")
    NumPut(ImGuiStyle_PopupBorderSize, ImGuiStyle, 40, "Float")
    NumPut(ImGuiStyle_FramePadding, ImGuiStyle, 44, "Float")
    NumPut(ImGuiStyle_FrameRounding, ImGuiStyle, 48, "Float")
    NumPut(ImGuiStyle_FrameBorderSize, ImGuiStyle, 52, "Float")
    NumPut(ImGuiStyle_ItemSpacing, ImGuiStyle, 56, "Float")
    NumPut(ImGuiStyle_ItemInnerSpacing, ImGuiStyle, 60, "Float")
    NumPut(ImGuiStyle_TouchExtraPadding, ImGuiStyle, 64, "Float")
    NumPut(ImGuiStyle_IndentSpacing, ImGuiStyle, 68, "Float")
    NumPut(ImGuiStyle_ColumnsMinSpacing, ImGuiStyle, 72, "Float")
    NumPut(ImGuiStyle_ScrollbarSize, ImGuiStyle, 76, "Float")
    NumPut(ImGuiStyle_ScrollbarRounding, ImGuiStyle, 80, "Float")
    NumPut(ImGuiStyle_GrabMinSize, ImGuiStyle, 84, "Float")
    NumPut(ImGuiStyle_GrabRounding, ImGuiStyle, 88, "Float")
    NumPut(ImGuiStyle_LogSliderDeadzone, ImGuiStyle, 92, "Float")
    NumPut(ImGuiStyle_TabRounding, ImGuiStyle, 96, "Float")
    NumPut(ImGuiStyle_TabBorderSize, ImGuiStyle, 100, "Float")
    NumPut(ImGuiStyle_TabMinWidthForUnselectedCloseButton, ImGuiStyle, 104, "Float")
        NumPut(ImGuiStyle_ColorButtonPosition, ImGuiStyle, 108, "Int")
    NumPut(ImGuiStyle_ButtonTextAlign, ImGuiStyle, 112, "Float")
    NumPut(ImGuiStyle_SelectableTextAlign, ImGuiStyle, 116, "Float")
    NumPut(ImGuiStyle_DisplayWindowPadding, ImGuiStyle, 120, "Float")
    NumPut(ImGuiStyle_DisplaySafeAreaPadding, ImGuiStyle, 124, "Float")
    NumPut(ImGuiStyle_MouseCursorScale, ImGuiStyle, 128, "Float")
    NumPut(ImGuiStyle_AntiAliasedLines, ImGuiStyle, 132, "UChar")
    NumPut(ImGuiStyle_AntiAliasedLinesUseTex, ImGuiStyle, 133, "UChar")
    NumPut(ImGuiStyle_AntiAliasedFill, ImGuiStyle, 134, "UChar")
    NumPut(ImGuiStyle_CurveTessellationTol, ImGuiStyle, 135, "Float")
    NumPut(ImGuiStyle_CircleSegmentMaxError, ImGuiStyle, 139, "Float")
}
;//------------------------------------------------------------------

;// struct ImGuiViewport
;//------------------------------------------------------------------
{
    VarSetCapacity(ImGuiStyle, 88, 0)
    
    ImGuiStyle_ID := NumGet(ImGuiStyle, 0, "Int")
    ImGuiStyle_Flags := NumGet(ImGuiStyle, 4, "Int")
    ImGuiStyle_Pos_x := NumGet(ImGuiStyle, 8, "Float")
    ImGuiStyle_Pos_y := NumGet(ImGuiStyle, 12, "Float")
    ImGuiStyle_Size_x := NumGet(ImGuiStyle, 16, "Float")
    ImGuiStyle_Size_y := NumGet(ImGuiStyle, 20, "Float")
    ImGuiStyle_WorkOffsetMin_x := NumGet(ImGuiStyle, 24, "Float")
    ImGuiStyle_WorkOffsetMin_y := NumGet(ImGuiStyle, 28, "Float")
    ImGuiStyle_WorkOffsetMax_x := NumGet(ImGuiStyle, 32, "Float")
    ImGuiStyle_WorkOffsetMax_y := NumGet(ImGuiStyle, 36, "Float")
    ImGuiStyle_DpiScale := NumGet(ImGuiStyle, 40, "Float")
    ImGuiStyle_DrawData := NumGet(ImGuiStyle, 44, "Ptr")
    ImGuiStyle_ParentViewportId := NumGet(ImGuiStyle, 52, "Int")
    ImGuiStyle_RendererUserData := NumGet(ImGuiStyle, 56, "Ptr")
    ImGuiStyle_PlatformUserData := NumGet(ImGuiStyle, 64, "Ptr")
        ImGuiStyle_PlatformHandle := NumGet(ImGuiStyle, 72, "Ptr")
        ImGuiStyle_PlatformHandleRaw := NumGet(ImGuiStyle, 80, "Ptr")
        
    NumPut(ImGuiStyle_ID, ImGuiStyle, 0, "Int")
    NumPut(ImGuiStyle_Flags, ImGuiStyle, 4, "Int")
    NumPut(ImGuiStyle_Pos_x, ImGuiStyle, 8, "Float")
    NumPut(ImGuiStyle_Pos_y, ImGuiStyle, 12, "Float")
    NumPut(ImGuiStyle_Size_x, ImGuiStyle, 16, "Float")
    NumPut(ImGuiStyle_Size_y, ImGuiStyle, 20, "Float")
    NumPut(ImGuiStyle_WorkOffsetMin_x, ImGuiStyle, 24, "Float")
    NumPut(ImGuiStyle_WorkOffsetMin_y, ImGuiStyle, 28, "Float")
    NumPut(ImGuiStyle_WorkOffsetMax_x, ImGuiStyle, 32, "Float")
    NumPut(ImGuiStyle_WorkOffsetMax_y, ImGuiStyle, 36, "Float")
    NumPut(ImGuiStyle_DpiScale, ImGuiStyle, 40, "Float")
    NumPut(ImGuiStyle_DrawData, ImGuiStyle, 44, "Ptr")
    NumPut(ImGuiStyle_ParentViewportId, ImGuiStyle, 52, "Int")
    NumPut(ImGuiStyle_RendererUserData, ImGuiStyle, 56, "Ptr")
    NumPut(ImGuiStyle_PlatformUserData, ImGuiStyle, 64, "Ptr")
        NumPut(ImGuiStyle_PlatformHandle, ImGuiStyle, 72, "Ptr")
        NumPut(ImGuiStyle_PlatformHandleRaw, ImGuiStyle, 80, "Ptr")
    }
;//------------------------------------------------------------------

;// ImGui Class
;//------------------------------------------------------------------
class ImGui
{
    __New(){    
        bitness := A_PtrSize == 8 ? "x64" : "x86"
        dllName := "imgui.dll"
        if (A_IsCompiled){
            __imgui_created = False
            dllFile := "Lib\" bitness "\" dllName
            FileCreateDir, Lib
            FileInstall, Lib\imgui.dll, Lib\imgui.dll
            if (bitness == "x86"){
                FileCreateDir, Lib\x86
                FileInstall, Lib\x86\imgui.dll, Lib\x86\imgui.dll
            } else {
                FileCreateDir, Lib\x64
                FileInstall, Lib\x64\imgui.dll, Lib\x64\imgui.dll
            }
        } else {
            dllFile := "Lib\" bitness "\" dllName
        }
        if (!FileExist(dllFile)) {
            MsgBox % "Unable to find " dllFile ""
            __imgui_created = False
            ExitApp
        }
        
        hModule := DllCall("LoadLibrary", "Str", dllFile, "Ptr")
        if (hModule == 0) {
            this_bitness := A_PtrSize == 8 ? "64-bit" : "32-bit"
            other_bitness := A_PtrSize == 4 ? "64-bit" : "32-bit"
            MsgBox % "Bitness of " dllName " does not match bitness of AHK.`nAHK is " this_bitness ", but " dllName " is " other_bitness "."
            __imgui_created = False
            ExitApp
        }
        If __imgui_created Then 
            this.ShutDown()
        DllCall("FreeLibrary", "Ptr", hModule)
        
        try {
            DllCall("LoadLibrary", "Str", dllFile, "Ptr")
        }
        catch {
            MsgBox % Make sure DirectX is installed
            __imgui_created = False
            ExitApp
        }
    }
    
    ;need rework
    GetIO(){
        result:= DllCall("imgui\GetIO", "cdecl ptr")
        If ErrorLevel
            return
        else
            Struct_Create("b_close", "int", "value")
        return result
    }
    
    ; Allow to draw gui's without background window
    EnableViewports(enable = True){
        return DllCall("imgui\EnableViewports", "int", enable, "Cdecl")
    }
    
    
    GUICreate(name, w, h, x, y){
        ;If __imgui_created Then Return False
        
        result:= DllCall("imgui\GUICreate", "wstr", name, "int", w, "int", h, "int", x, "int", y, "Cdecl Ptr")
        If ErrorLevel
            return
        else
            __imgui_created = True
        Return result
    }
    
    BeginFrame(){
        return DllCall("imgui\BeginFrame", "Cdecl")
    }
    
    EndFrame(clear_color = 0xFF738C99){
        return DllCall("imgui\EndFrame", "uint", clear_color, "Cdecl")
    }
    
    Begin(title, close_btn = False, flags = ""){
        close_ptr = 0
        
        If close_btn
        {
            Struct_Create("b_close", "int", "value")
            b_close#value := True
            close_ptr := b_close#value
        }
        
        result := DllCall("imgui\Begin", "wstr", title, "ptr", close_ptr, "int", flags, "cdecl")
        If ErrorLevel
            return
        else
            __imgui_created = True
        If close_btn = False Then Return True
            Return b_close#value
    }
    
    End(){
        DllCall("imgui\End", "Cdecl")
    }
    
    ;
    ;Main
    class Main{
        
        CheckBox(text, ByRef active){
            Struct_Create("checkbox_active", "Int", "value")
            checkbox_active#value:= active
            result := DllCall("imgui\Checkbox", "Str", text, "Ptr", &checkbox_active#value, "Cdecl")
            If ErrorLevel
                return
            else
                active := checkbox_active#value
            Return result
        }
        
        Button(text, w = 0, h = 0){
            result := DllCall("imgui\Button", "wstr", text, "float", w, "float", h, "cdecl")
            Return result
        }
        
        SliderFloat(text, ByRef value, v_min, v_max, format = "%3.f", power = 1){
            Struct_Create("struct", "float", "value")
            struct#value := value
            result := DllCall("imgui\SliderFloat", "wstr", text, "ptr", &struct#value, "float", v_min, "float", v_max, "wstr", format, "float", power,"cdecl float")
            If ErrorLevel
                return
            else
                value := struct#value
            Return result 
        }
        
        ToolTip(text){
            ImGui.Main.BeginTooltip()
            ImGui.Main.Text(text)
            ImGui.Main.EndTooltip()
        }
        
        Text(text){
            DllCall("imgui\Text", "wstr", text, "cdecl")
        }
        
        BeginTooltip(){
            DllCall("imgui\BeginTooltip","cdecl")
        }
        
        EndTooltip(){
            DllCall("imgui\EndTooltip","cdecl")
        }
        
        IsItemHovered(flags = "ImGuiHoveredFlags_None"){
            result := DllCall("imgui\IsItemHovered", "int", &flags, "cdecl int")
            If ErrorLevel
                return
            else
                Return result
        }
        
        ShowDemoWindow(){
            return DllCall("imgui\ShowDemoWindow","cdecl")
        }
    }
    
    
    ;Styling
    class Style{
        Light(){
            return DllCall("imgui\StyleColorsLight", "Cdecl")
        }
        Dark(){
            return DllCall("imgui\StyleColorsDark", "Cdecl")
        }
        Classic(){
            return DllCall("imgui\StyleColorsClassic", "Cdecl")
        }
    }
}
;//------------------------------------------------------------------