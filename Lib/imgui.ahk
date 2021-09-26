#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#include _Struct.ahk
#include Class_DllStruct.ahk

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

global imgui := new imgui()

;// Configuration (fill once)                // Default values
;//------------------------------------------------------------------
{
    Global FLT_MAX         				          :=  3.402823466e+38
    Global ImDrawList_ptr = 0, ImDraw_offset_x = 0, ImDraw_offset_y = 0
    
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

class imgui
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
    
    EnableViewports(enable = True){
        DllCall("imgui\EnableViewports", "int", enable, "cdecl")
    }
    
    SetWindowTitleAlign(x = 0.5, y = 0.5){
        ;imstyle = GetStyle()
        ;imstyle.WindowTitleAlign_x = x
        ;imstyle.WindowTitleAlign_y = y
    }
    
    ; // Windows
    Begin(title, close_btn, flags := 0){
        close_ptr := 0
        
        If close_btn
        {
            
            
            b_close := new _Struct("int value")
            b_close.value:= True
            close_ptr := VarSetCapacity(v,4),NumPut(&b_close,v)
            
            ;MsgBox % b_close.value
        }
        
        result := DllCall("imgui\Begin", "wstr", title, "ptr", &close_ptr, "int", flags, "Cdecl")
        if ErrorLevel then return
            
        If close_btn = False Then Return True
            
        Return b_close_value
    }
    
    CheckBox(text, ByRef active){
        VarSetCapacity(struct, 4, 0)
        value := NumGet(struct, "Int")
 

        Result := DllCall("imgui\Checkbox", "WStr", value, "Ptr", &active, "Cdecl Int")
        active := active
        Return result
    }
    
    GUICreate(name, w, h, x, y){            
        result:= DllCall("imgui\GUICreate", "wstr", name, "int", w, "int", h, "int", x, "int", y, "Cdecl Ptr")
        If ErrorLevel
            return
        else
            __imgui_created = True
        Return result
    }
    
    PeekMsg(){
        result := DllCall("imgui\PeekMsg", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    
    ; // Main
    BeginFrame(){
        return DllCall("imgui\BeginFrame", "Cdecl")
    }
    
    EndFrame(clear_color = 0xFF738C99){
        DllCall("imgui\EndFrame", "uint", clear_color, "Cdecl")
    }
    
    
    End(){
        DllCall("imgui\End", "cdecl")
    }
    
    ; // Child Windows
    BeginChild(text, w = 0, h = 0, border = False, flags = "ImGuiWindowFlags_None"){
        
        result := DllCall("imgui\BeginChild", "wstr", text, "float", w, "float", h, "int", border, "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    
    EndChild(){
        DllCall("imgui\EndChild", "cdecl")
    }
    
    IsWindowAppearing(){
        result := DllCall("imgui\IsWindowAppearing", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsWindowCollapsed(){
        result := DllCall("imgui\IsWindowCollapsed", "cdecl int")
        
        if ErrorLevel then return
            Return result
    }
    IsWindowFocused(flags = "ImGuiFocusedFlags_None"){
        result := DllCall("imgui\IsWindowFocused", "int", flags, "cdecl int")
        
        if ErrorLevel then return
            Return result
    }
    IsWindowHovered(flags = "ImGuiFocusedFlags_None"){
        result := DllCall("imgui\IsWindowHovered", "int", flags, "cdecl int")
        
        if ErrorLevel then return
            Return result
    }
    
    GetWindowDrawList(){
        result := DllCall("imgui\GetWindowDrawList", "cdecl ptr")
        if ErrorLevel then return
            Return result
    }
    
    GetOverlayDrawList(){
        result := DllCall("imgui\GetOverlayDrawList", "cdecl ptr")
        if ErrorLevel then return
            Return result
    }
    GetBackgroundDrawList(){
        result := DllCall("imgui\GetBackgroundDrawList", "cdecl ptr")
        if ErrorLevel then return
            Return result
    }
    GetForegroundDrawList(){
        result := DllCall("imgui\GetForegroundDrawList", "cdecl ptr")
        if ErrorLevel then return
            Return result
    }
    
    GetWindowDpiScale(){
        result := DllCall("imgui\GetWindowDpiScale", "cdecl float")
        If @error Then Return False
            Return result
    }
    
    
    ; GetWindowPos(){
    ;     Return RecvImVec2("GetWindowPos", "cdecl")
    ; }
    ; GetWindowSize(){
    ;     Return RecvImVec2("GetWindowSize", "cdecl")
    ; }
    GetWindowWidth(){
        result := DllCall("imgui\GetWindowWidth", "cdecl float")
        If @error Then Return False
            Return result
    }
    GetWindowHeight(){
        result := DllCall("imgui\GetWindowHeight", "cdecl float")
        If @error Then Return False
            Return result
    }
    SetNextWindowPos(x, y, cond = "ImGuiCond_None", pivot_x = 0, pivot_y = 0){
        DllCall("imgui\SetNextWindowPos", "float", x, "float", y, "int", cond, "float", pivot_x, "float", pivot_y, "cdecl")
    }
    SetNextWindowSize(x, y, cond = "ImGuiCond_None"){
        DllCall("imgui\SetNextWindowSize", "float", x, "float", y, "int", cond,"cdecl")
    }
    SetNextWindowSizeConstraints(size_min_x, size_min_y, size_max_x, size_max_y){
        DllCall("imgui\SetNextWindowSizeConstraints", "float", size_min_x, "float", size_min_y, "float", size_max_x, "float", size_max_y,"cdecl")
    }
    
    SetNextWindowContentSize(size_x, size_y){
        DllCall("imgui\SetNextWindowContentSize", "float", size_x, "float", size_y,"cdecl")
    }
    SetNextWindowCollapsed(collapsed, cond = "ImGuiCond_None"){
        DllCall("imgui\SetNextWindowCollapsed", "int", collapsed, "int", cond,"cdecl")
    }
    SetNextWindowFocus(){
        DllCall("imgui\SetNextWindowFocus","cdecl")
    }
    SetNextWindowBgAlpha(alpha){
        DllCall("imgui\SetNextWindowBgAlpha", "float", alpha,"cdecl")
    }
    SetNextWindowViewport(id){
        DllCall("imgui\SetNextWindowViewport", "int", id,"cdecl")
    }
    SetWindowPos(pos_x, pos_y, cond=0){
        DllCall("imgui\SetWindowPosition", "float", pos_x, "float", pos_y, "int", cond,"cdecl")
    }
    SetWindowSize(size_x, size_y, cond=0){
        DllCall("imgui\SetWindowSize", "float", size_x, "float", size_y, "int", cond,"cdecl")
    }
    
    SetWindowCollapsed(collapsed, cond = "ImGuiCond_None"){
        DllCall("imgui\SetWindowCollapsed", "int", collapsed, "int", cond,"cdecl")
    }
    
    SetWindowFocus(){
        DllCall("imgui\SetWindowFocus","cdecl")
    }
    
    SetWindowFontScale(scale){
        DllCall("imgui\SetWindowFontScale", "float", scale,"cdecl")
    }
    SetWindowPosByName(name, pos_x, pos_y, cond = "ImGuiCond_None"){
        DllCall("imgui\SetWindowPosByName", "wstr", name, "float", pos_x, "float", pos_y, "int", cond,"cdecl")
    }
    
    SetWindowSizeByName(name, size_x, size_y, cond = "ImGuiCond_None"){
        DllCall("imgui\SetWindowSizeByName", "wstr", name, "float", size_x, "float", size_y, "int", cond,"cdecl")
    }
    
    SetWindowCollapsedByName(name, collapsed, cond = "ImGuiCond_None"){
        result := DllCall("imgui\SetWindowCollapsedByName", "wstr", name, "int", collapsed, "int", cond,"cdecl")
        
        if ErrorLevel then return
            Return result
    }
    SetWindowFocusByName(name){
        DllCall("imgui\SetWindowFocus", "wstr", name,"cdecl")
    }
    
    ; GetContentRegionMax(){
    ;     Return RecvImVec2("GetContentRegionMax","cdecl")
    ; }
    ; GetContentRegionAvail(){
    ;     Return RecvImVec2("GetContentRegionAvail","cdecl")
    ; }
    ; GetWindowContentRegionMin(){
    ;     Return RecvImVec2("GetWindowContentRegionMin","cdecl")
    ; }
    ; GetWindowContentRegionMax(){
    ;     Return RecvImVec2("GetWindowContentRegionMax","cdecl")
    ; }
    ; GetItemRectMin(){
    ;     Return RecvImVec2("GetItemRectMin","cdecl")
    ; }
    ; GetItemRectMax(){
    ;     Return RecvImVec2("GetItemRectMax","cdecl")
    ; }
    ; GetItemRectSize(){
    ;     Return RecvImVec2("GetItemRectSize","cdecl")
    ; }
    ; GetMousePos(){
    ;     Return RecvImVec2("GetMousePos","cdecl")
    ; }
    ; GetMousePosOnOpeningCurrentPopup(){
    ;     Return RecvImVec2("GetMousePosOnOpeningCurrentPopup","cdecl")
    ; }
    
    
    GetWindowContentRegionWidth(){
        result := DllCall("imgui\GetWindowContentRegionWidth","cdecl float")
        if ErrorLevel then return
            Return result
    }
    GetScrollX(){
        result := DllCall("imgui\GetScrollX", "cdecl float")
        
        if ErrorLevel then return
            Return result
    }
    GetScrollY(){
        result := DllCall("imgui\GetScrollY", "cdecl float")
        
        if ErrorLevel then return
            Return result
    }
    GetScrollMaxX(){
        result := DllCall("imgui\GetScrollMaxX", "cdecl float")
        
        if ErrorLevel then return
            Return result
    }
    GetScrollMaxY(){
        result := DllCall("imgui\GetScrollMaxY", "cdecl float")
        
        if ErrorLevel then return
            Return result
    }
    SetScrollX(scroll_x){
        DllCall("imgui\SetScrollX", "float", scroll_x, "cdecl")
    }
    SetScrollY(scroll_y){
        DllCall("imgui\SetScrollY", "float", scroll_y, "cdecl")
    }
    SetScrollHereX(center_x_ratio = 0.5){
        DllCall("imgui\SetScrollHereX", "float", center_x_ratio, "cdecl")
    }
    SetScrollHereY(center_y_ratio = 0.5){
        DllCall("imgui\SetScrollHereY", "float", center_y_ratio, "cdecl")
    }
    SetScrollFromPosX(local_x, center_x_ratio = 0.5){
        DllCall("imgui\SetScrollFromPosX", "float", local_x, "float", center_x_ratio, "cdecl")
    }
    SetScrollFromPosY(local_y, center_y_ratio = 0.5){
        DllCall("imgui\SetScrollFromPosY", "float", local_y, "float", center_y_ratio, "cdecl")
    }
    
    PushFont(font){
        DllCall("imgui\PushFont", "ptr", font, "cdecl")
    }
    PopFont(){
        DllCall("imgui\PopFont", "cdecl")
    }
    
    PushStyleColor(idx, col){
        DllCall("imgui\PushStyleColor", "int", idx, "uint", col, "cdecl")
    }
    PopStyleColor(count = 1){
        DllCall("imgui\PopStyleColor", "int", count, "cdecl")
    }
    PushStyleVar(idx, val){
        DllCall("imgui\PushStyleVar", "int", idx, "float", val, "cdecl")
    }
    PushStyleVarPos(idx, val_x, val_y){
        DllCall("imgui\PushStyleVarPos", "int", idx, "float", val_x, "float", val_y, "cdecl")
    }
    PopStyleVar(count = 1){
        DllCall("imgui\PopStyleVar", "int", count, "cdecl")
    }
    GetFont(){
        result := DllCall("imgui\GetFont", "cdecl")
        if ErrorLevel then return
            Return result
    }
    GetFontSize(){
        result := DllCall("imgui\GetFontSize", "cdecl float")
        
        if ErrorLevel then return
            Return result
    }
    
    ; GetFontTexUvWhitePixel(){
    ;     Return RecvImVec2("GetFontTexUvWhitePixel", "cdecl")
    ; }
    
    
    ; GetColorU32(idx, alpha_mul = 1){
    ; result := DllCall("imgui\XXXXXX", "ImU32:cdecl", "GetColorU32", "int", idx, "float", alpha_mul)
    ; if ErrorLevel then return
    ; Return result
    ; }
    
    PushItemWidth(item_width){
        DllCall("imgui\PushItemWidth", "float", item_width, "cdecl")
    }
    PopItemWidth(){
        DllCall("imgui\PopItemWidth", "cdecl")
    }
    SetNextItemWidth(item_width){
        DllCall("imgui\SetNextItemWidth", "float", item_width, "cdecl")
    }
    CalcItemWidth(){
        result := DllCall("imgui\CalcItemWidth", "cdecl float")
        if ErrorLevel then return
            Return result
    }
    PushTextWrapPos(wrap_pos_x = 0){
        DllCall("imgui\PushTextWrapPos", "float", wrap_pos_x, "cdecl")
    }
    PopTextWrapPos(){
        DllCall("imgui\PopTextWrapPos", "cdecl")
    }
    PushAllowKeyboardFocus(allow_keyboard_focus){
        DllCall("imgui\PushAllowKeyboardFocus", "int", allow_keyboard_focus, "cdecl")
    }
    PopAllowKeyboardFocus(){
        DllCall("imgui\PopAllowKeyboardFocus", "cdecl")
    }
    PushButtonRepeat(repeat){
        DllCall("imgui\PushButtonRepeat", "int", repeat, "cdecl")
    }
    PopButtonRepeat(){
        DllCall("imgui\PopButtonRepeat", "cdecl")
    }
    Separator(){
        DllCall("imgui\Separator", "cdecl")
    }
    SameLine(offset_from_start_x = 0, spacing_w = -1){
        DllCall("imgui\SameLine", "float", offset_from_start_x, "float", spacing_w, "cdecl")
    }
    NewLine(){
        DllCall("imgui\NewLine", "cdecl")
    }
    Spacing(){
        DllCall("imgui\Spacing", "cdecl")
    }
    Dummy(size_x, size_y){
        DllCall("imgui\Dummy", "float", size_x, "float", size_y, "cdecl")
    }
    Indent(indent_w = 0){
        DllCall("imgui\Indent", "float", indent_w, "cdecl")
    }
    Unindent(indent_w = 0){
        DllCall("imgui\Unindent", "float", indent_w, "cdecl")
    }
    BeginGroup(){
        DllCall("imgui\BeginGroup", "cdecl")
    }
    EndGroup(){
        DllCall("imgui\EndGroup", "cdecl")
    }
    ; GetCursorPos(){
    ;     Return RecvImVec2("GetCursorPosition", "cdecl")
    ; }
    SetCursorPos(local_pos_x, local_pos_y){
        DllCall("imgui\SetCursorPosition", "float", local_pos_x, "float", local_pos_y, "cdecl")
    }
    GetCursorPosX(){
        result := DllCall("imgui\GetCursorPosX", "cdecl float")
        If @error Then Return False
            Return result
    }
    GetCursorPosY(){
        result := DllCall("imgui\GetCursorPosY", "cdecl float")
        If @error Then Return False
            Return result
    }
    SetCursorPosX(x){
        DllCall("imgui\SetCursorPosX", "float", x, "cdecl")
    }
    SetCursorPosY(y){
        DllCall("imgui\SetCursorPosY", "float", y, "cdecl")
    }
    ; GetCursorStartPos(){
    ;     Return RecvImVec2("GetCursorStartPos", "cdecl")
    ; }
    ; GetCursorScreenPos(){
    ;     Return RecvImVec2("GetCursorScreenPos", "cdecl")
    ; }
    SetCursorScreenPos(pos_x, pos_y){
        DllCall("imgui\SetCursorScreenPos", "float", pos_x, "float", pos_y, "cdecl")
    }
    AlignTextToFramePadding(){
        DllCall("imgui\AlignTextToFramePadding", "cdecl")
    }
    GetTextLineHeight(){
        result := DllCall("imgui\GetTextLineHeight", "cdecl float")
        if ErrorLevel then return
            Return result
    }
    GetTextLineHeightWithSpacing(){
        result := DllCall("imgui\GetTextLineHeightWithSpacing", "cdecl float")
        if ErrorLevel then return
            Return result
    }
    GetFrameHeight(){
        result := DllCall("imgui\GetFrameHeight", "cdecl float")
        if ErrorLevel then return
            Return result
    }
    GetFrameHeightWithSpacing(){
        result := DllCall("imgui\GetFrameHeightWithSpacing", "cdecl float")
        if ErrorLevel then return
            Return result
    }
    PushID(str_id){
        DllCall("imguiPushID", "wstr", str_id, "cdecl")
    }
    PopID(){
        DllCall("imgui\PopID", "cdecl")
    }
    GetID(str_id){
        result := DllCall("imgui\GetID", "wstr", str_id, "cdecl uint")
        if ErrorLevel then return
            Return result
    }
    
    Text(text){
        DllCall("imgui\Text", "wstr", text, "cdecl")
    }
    
    TextColored(text, color = 0xFFFFFFFF){
        DllCall("imgui\TextColored", "uint", color, "wstr", text, "cdecl")
    }
    TextDisabled(text){
        DllCall("imgui\TextDisabled", "wstr", text, "cdecl")
    }
    TextWrapped(text){
        DllCall("imgui\TextWrapped", "wstr", text, "cdecl")
    }
    LabelText(label, text){
        DllCall("imgui\LabelText", "wstr", label, "wstr", text, "cdecl")
    }
    BulletText(text){
        DllCall("imgui\BulletText", "wstr", text, "cdecl")
    }
    
    Button(text, w = 0, h = 0){
        result := DllCall("imgui\Button", "wstr", text, "float", w, "float", h, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    SmallButton(label){
        result := DllCall("imgui\SmallButton", "wstr", label, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    InvisibleButton(str_id, size_x, size_y){
        result := DllCall("imgui\InvisibleButton", "wstr", str_id, "float", size_x, "float", size_y, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    ArrowButton(str_id, dir = "ImGuiDir_Up"){
        result := DllCall("imgui\ArrowButton", "wstr", str_id, "int", dir, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    Image(user_texture_id, size_x, size_y, uv0_x = 0, uv0_y = 0, uv1_x = 1, uv1_y = 1, tint_col = 0xFFFFFFFF, border_col = 0){
        DllCall("imgui\Image", "int", user_texture_id, "float", size_x, "float", size_y, "float", uv0_x, "float", uv0_y, "float", uv1_x, "float", uv1_y, "uint", tint_col, "uint", border_col, "cdecl")
    }
    
    ImageButton(user_texture_id, size_x, size_y, uv0_x = 0, uv0_y = 0, uv1_x = 1, uv1_y = 1, frame_padding = -1, bg_col = 0, tint_col = 0xFFFFFFFF){
        result := DllCall("imgui\ImageButton", "int", user_texture_id, "float", size_x, "float", size_y, "float", uv0_x, "float", uv0_y, "float", uv1_x, "float", uv1_y, "int", frame_padding, "uint", bg_col, "uint", tint_col, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    
    ProgressBar(fraction, size_arg_x = -1, size_arg_y = 0, overlay = ""){
        DllCall("imgui\ProgressBar", "float", fraction, "float", size_arg_x, "float", size_arg_y, "wstr", overlay, "cdecl")
    }
    Bullet(){
        DllCall("imgui\Bullet", "cdecl")
    }
    BeginCombo(label, preview_value, flags = "ImGuiComboFlags_None"){
        result := DllCall("imgui\BeginCombo", "wstr", label, "wstr", preview_value, "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    EndCombo(){
        DllCall("imgui\EndCombo", "cdecl")
    }
    
    SetStyleColor(index, color = 0xFFFFFFFF){
        DllCall("imgui\SetStyleColor", "int", index, "uint", color, "cdecl")
    }
    Selectable(label, selected = False, flags = "ImGuiSelectableFlags_None", size_arg_x = 0, size_arg_y = 0){
        result := DllCall("imgui\Selectable", "wstr", label, "int", selected, "int", flags, "float", size_arg_x, "float", size_arg_y, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    Columns(columns_count = 1, id = "", border = true){
        DllCall("imgui\Columns", "int", columns_count, "wstr", id, "int", border, "cdecl")
    }
    NextColumn(){
        DllCall("imgui\NextColumn", "cdecl")
    }
    GetColumnIndex(){
        result := DllCall("imgui\GetColumnIndex", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    GetColumnWidth(column_index = -1){
        result := DllCall("imgui\GetColumnWidth", "int", column_index, "cdecl float")
        if ErrorLevel then return
            Return result
    }
    SetColumnWidth(column_index, width){
        DllCall("imgui\SetColumnWidth", "int", column_index, "float", width, "cdecl")
    }
    GetColumnOffset(column_index = -1){
        result := DllCall("imgui\GetColumnOffset", "int", column_index, "cdecl float")
        if ErrorLevel then return
            Return result
    }
    SetColumnOffset(column_index, offset){
        DllCall("imgui\SetColumnOffset", "int", column_index, "float", offset, "cdecl")
    }
    GetColumnsCount(){
        result := DllCall("imgui\GetColumnsCount", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    
    ; DragFloat2(label, ByRef v, v_speed = 1, v_min = 0, v_max = 0, format = "%.3f", power = 1){
    ;     Return DragFloatN(2, label, v, v_speed, v_min, v_max, format, power)
    ;     }
    ; DragFloat3(label, ByRef v, v_speed = 1, v_min = 0, v_max = 0, format = "%.3f", power = 1){
    ;     Return DragFloatN(3, label, v, v_speed, v_min, v_max, format, power)
    ;     }
    ; DragFloat4(label, ByRef v, v_speed = 1, v_min = 0, v_max = 0, format = "%.3f", power = 1){
    ;     Return DragFloatN(4, label, v, v_speed, v_min, v_max, format, power)
    ;     }
    
    ; DragInt2(label, ByRef v, v_speed = 1, v_min = 0, v_max = 0, format ="%d"){
    ;     DragIntN(2, label, v, v_speed, v_min, v_max, format)
    ;     }
    ; DragInt3(label, ByRef v, v_speed = 1, v_min = 0, v_max = 0, format ="%d"){
    ;     DragIntN(3, label, v, v_speed, v_min, v_max, format)
    ;     }
    ; DragInt4(label, ByRef v, v_speed = 1, v_min = 0, v_max = 0, format ="%d"){
    ;     DragIntN(4, label, v, v_speed, v_min, v_max, format)
    ;     }
    
    ; SliderFloat2(label, ByRef v, v_min, v_max, format = "%.3f", power = 1){
    ;     SliderFloatN(2, label, v, v_min, v_max, format, power)
    ;     }
    ; SliderFloat3(label, ByRef v, v_min, v_max, format = "%.3f", power = 1){
    ;     SliderFloatN(3, label, v, v_min, v_max, format, power)
    ;     }
    ; SliderFloat4(label, ByRef v, v_min, v_max, format = "%.3f", power = 1){
    ;     SliderFloatN(4, label, v, v_min, v_max, format, power)
    ;     }
    
    ; SliderInt2(label, ByRef v, v_min, v_max, format = "%d"){
    ;     SliderIntN(2, label, v, v_min, v_max, format)
    ;     }
    ; SliderInt3(label, ByRef v, v_min, v_max, format = "%d"){
    ;     SliderIntN(3, label, v, v_min, v_max, format)
    ;     }
    ; SliderInt4(label, ByRef v, v_min, v_max, format = "%d"){
    ;     SliderIntN(4, label, v, v_min, v_max, format)
    ;     }
    
    ; InputFloat2(label, ByRef v, format = "%.3f", flags = "ImGuiInputTextFlags_None"){
    ;     InputFloatN(2, label, v, format, flags)
    ;     }
    ; InputFloat3(label, ByRef v, format = "%.3f", flags = "ImGuiInputTextFlags_None"){
    ;     InputFloatN(3, label, v, format, flags)
    ;     }
    ; InputFloat4(label, ByRef v, format = "%.3f", flags = "ImGuiInputTextFlags_None"){
    ;     InputFloatN(4, label, v, format, flags)
    ;     }
    
    ; InputInt2(label, ByRef v, flags = "ImGuiInputTextFlags_None"){
    ;     InputIntN(2, label, v, flags)
    ; }
    ; InputInt3(label, ByRef v, flags = "ImGuiInputTextFlags_None"){
    ;     InputIntN(3, label, v, flags)
    ; }
    ; InputInt4(label, ByRef v, flags = "ImGuiInputTextFlags_None"){
    ;     InputIntN(4, label, v, flags)
    ; }
    
    TreeNode(label){
        result := DllCall("imgui\TreeNode", "wstr", label, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    TreeNodeEx(label, flags = "ImGuiTreeNodeFlags_None"){
        result := DllCall("imgui\TreeNodeEx", "wstr", label, "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    TreePush(str_id){
        DllCall("imgui\TreePush", "wstr", str_id, "cdecl")
    }
    TreePop(){
        DllCall("imgui\TreePop", "cdecl")
    }
    GetTreeNodeToLabelSpacing(){
        result := DllCall("imgui\GetTreeNodeToLabelSpacing", "cdecl float")
        if ErrorLevel then return
            Return result
    }
    CollapsingHeader(label, flags = "ImGuiTreeNodeFlags_None"){
        result := DllCall("imgui\CollapsingHeader", "wstr", label, "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    
    ListBoxHeader(label, size_arg_x = 0, size_arg_y = 0){
        result := DllCall("imgui\ListBoxHeader", "wstr", label, "float", size_arg_x, "float", size_arg_y, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    ListBoxHeaderEx(label, items_count, height_in_items = -1){
        result := DllCall("imgui\ListBoxHeaderEx", "wstr", label, "int", items_count, "int", height_in_items, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    ListBoxFooter(){
        DllCall("imgui\ListBoxFooter", "cdecl")
    }
    
    ValueBool(prefix, b){
        DllCall("imgui\ValueBool", "wstr", prefix, "int", b, "cdecl")
    }
    ValueInt(prefix, v){
        DllCall("imgui\ValueInt", "wstr", prefix, "int", v, "cdecl")
    }
    ValueFloat(prefix, v, float_format = ""){
        DllCall("imgui\ValueFloat", "wstr", prefix, "float", v, "wstr", float_format, "cdecl")
        }
    
    BeginMenuBar(){
        result := DllCall("imgui\BeginMenuBar", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    EndMenuBar(){
        DllCall("imgui\EndMenuBar", "cdecl")
    }
    BeginMainMenuBar(){
        result := DllCall("imgui\BeginMainMenuBar", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    EndMainMenuBar(){
        DllCall("imgui\EndMainMenuBar", "cdecl")
    }
    BeginMenu(label, enabled = True){
        result := DllCall("imguiBeginMenu", "wstr", label, "int", "enabled", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    EndMenu(){
        DllCall("imgui\EndMenu_", "cdecl")
    }
    MenuItem(label, shortcut = "", selected = False, enabled = True){
        result := DllCall("imgui\MenuItem", "wstr", label, "wstr", shortcut, "int", selected, "int", enabled, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    
    ShowDemoWindow(){
        DllCall("imgui\ShowDemoWindow", "cdecl")
    }
    ToolTip(text){
        this.BeginTooltip()
        this.Text(text)
        this.EndTooltip()
    }
    BeginTooltip(){
        DllCall("imgui\BeginTooltip", "cdecl")
    }
    EndTooltip(){
        DllCall("imgui\EndTooltip", "cdecl")
    }
    SetTooltip(text){
        DllCall("imgui\SetTooltip", "wstr", text, "cdecl")
    }
    BeginPopup(str_id, flags = "ImGuiWindowFlags_None"){
        result := DllCall("imgui\BeginPopup", "wstr", str_id, "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    
    BeginPopupModal(name, flags = "ImGuiWindowFlags_None"){
        
        result := DllCall("imgui\BeginPopupModal", "wstr", name, "ptr", 0, "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    
    EndPopup(){
        DllCall("imgui\EndPopup", "cdecl")
    }
    OpenPopup(str_id, popup_flags = "ImGuiPopupFlags_MouseButtonLeft"){
        DllCall("imgui\OpenPopup", "wstr", str_id, "int", popup_flags, "cdecl")
    }
    OpenPopupContextItem(str_id = "", popup_flags = "ImGuiPopupFlags_MouseButtonLeft"){
        result := DllCall("imgui\OpenPopupContextItem", "wstr", str_id, "int", popup_flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    CloseCurrentPopup(){
        DllCall("imgui\CloseCurrentPopup", "cdecl")
    }
    BeginPopupContextItem(str_id = "", popup_flags = "ImGuiPopupFlags_MouseButtonLeft"){
        result := DllCall("imgui\BeginPopupContextItem", "wstr", str_id, "int", popup_flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    BeginPopupContextWindow(str_id = "", popup_flags = "ImGuiPopupFlags_MouseButtonLeft"){
        result := DllCall("imgui\BeginPopupContextWindow", "wstr", str_id, "int", popup_flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    BeginPopupContextVoid(str_id = "", popup_flags = "ImGuiPopupFlags_MouseButtonLeft"){
        result := DllCall("imgui\BeginPopupContextVoid", "wstr", str_id, "int", popup_flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsPopupOpen(str_id, popup_flags = "ImGuiPopupFlags_None"){
        result := DllCall("imgui\IsPopupOpen", "wstr", str_id, "int", popup_flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    BeginTabBar(str_id, flags = "ImGuiTabBarFlags_None"){
        result := DllCall("imgui\BeginTabBar", "wstr", str_id, "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    EndTabBar(){
        DllCall("imgui\EndTabBar", "cdecl")
    }
    
    BeginTabItem(label, flags = "ImGuiTabItemFlags_None"){
        result := DllCall("imgui\BeginTabItem", "wstr", label, "ptr", 0, "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    EndTabItem(){
        DllCall("imgui\EndTabItem", "cdecl")
    }
    SetTabItemClosed(label){
        DllCall("imgui\SetTabItemClosed", "wstr", label, "cdecl")
    }
    DockSpace(id, size_arg_x = 0, size_arg_y = 0, flags = "ImGuiDockNodeFlags_None"){
        DllCall("imgui\DockSpace", "int", id, "float", size_arg_x, "float", size_arg_y, "int", flags, "cdecl")
    }
    ; DockSpaceOverViewport(viewport = 0, dockspace_flags = "ImGuiDockNodeFlags_None"){
    
    ; result := DllCall("imgui\XXXXXX", "ImGuiID:cdecl", "DockSpaceOverViewport", "ptr", viewport, "int", dockspace_flags)
    ; if ErrorLevel then return
    ; Return result
    ; }
    
    SetNextWindowDockID(id, cond = "ImGuiCond_None"){
        DllCall("imgui\SetNextWindowDockID", "int", id, "int", cond, "cdecl")
    }
    SetNextWindowClass(window_class){
        DllCall("imgui\SetNextWindowClass", "ptr", window_class, "cdecl")
    }
    ; GetWindowDockID(){
    ; result := DllCall("imgui\XXXXXX", "ImGuiID:cdecl", "GetWindowDockID")
    ; if ErrorLevel then return
    ; Return result
    ;}
    IsWindowDocked(){
        result := DllCall("imgui\IsWindowDocked", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    BeginDragDropSource(flags = "ImGuiDragDropFlags_None"){
        result := DllCall("imgui\BeginDragDropSource", "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    PushClipRect(clip_rect_min_x, clip_rect_min_y, clip_rect_max_x, clip_rect_max_y, intersect_with_current_clip_rect){
        DllCall("imgui\PushClipRect", "float", clip_rect_min_x, "float", clip_rect_min_y, "float", clip_rect_max_x, "float", clip_rect_max_y, "int", intersect_with_current_clip_rect, "cdecl")
    }
    PopClipRect(){
        DllCall("imgui\PopClipRect", "cdecl")
    }
    SetItemDefaultFocus(){
        DllCall("imgui\SetItemDefaultFocus", "cdecl")
    }
    SetKeyboardFocusHere(offset = 0){
        DllCall("imgui\SetKeyboardFocusHere", "int", offset, "cdecl")
    }
    IsItemHovered(flags = "ImGuiHoveredFlags_None"){
        result := DllCall("imgui\IsItemHovered", "int", flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsItemActive(){
        result := DllCall("imgui\IsItemActive", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsItemFocused(){
        result := DllCall("imgui\IsItemFocused", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsItemVisible(){
        result := DllCall("imgui\IsItemVisible", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsItemEdited(){
        result := DllCall("imgui\IsItemEdited", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsItemActivated(){
        result := DllCall("imgui\IsItemActivated", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsItemDeactivated(){
        result := DllCall("imgui\IsItemDeactivated", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsItemDeactivatedAfterEdit(){
        result := DllCall("imgui\IsItemDeactivatedAfterEdit", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsItemToggledOpen(){
        result := DllCall("imgui\IsItemToggledOpen", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsAnyItemHovered(){
        result := DllCall("imgui\IsAnyItemHovered", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsAnyItemActive(){
        result := DllCall("imgui\IsAnyItemActive", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsAnyItemFocused(){
        result := DllCall("imgui\IsAnyItemFocused", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    SetItemAllowOverlap(){
        DllCall("imgui\SetItemAllowOverlap", "cdecl")
    }
    IsItemClicked(mouse_button = "ImGuiMouseButton_Left"){
        result := DllCall("imgui\IsItemClicked", "int", mouse_button, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsRectVisible(size_x, size_y){
        result := DllCall("imgui\IsRectVisible", "float", size_x, "float", size_y, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsRectVisibleEx(rect_min_x, rect_min_y, rect_max_x, rect_max_y){
        result := DllCall("imgui\IsRectVisibleEx", "float", rect_min_x, "float", rect_min_y, "float", rect_max_x, "float", rect_max_y, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    GetTime(){
        result := DllCall("imgui\GetTime", "cdecl double")
        if ErrorLevel then return
            Return result
    }
    GetFrameCount(){
        result := DllCall("imgui\GetFrameCount", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    BeginChildFrame(id, size_x, size_y, extra_flags = "ImGuiWindowFlags_None"){
        result := DllCall("imgui\BeginChildFrame", "int", id, "float", size_x, "float", size_y, "int", extra_flags, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    EndChildFrame(){
        DllCall("imgui\EndChildFrame", "cdecl")
    }
    
    GetKeyIndex(imgui_key){
        result := DllCall("imgui\GetKeyIndex", "int", imgui_key, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsKeyDown(user_key_index){
        result := DllCall("imgui\IsKeyDown", "int", user_key_index, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsKeyPressed(user_key_index, repeat = true){
        result := DllCall("imgui\IsKeyPressed", "int", user_key_index, "int", repeat, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsKeyReleased(user_key_index){
        result := DllCall("imgui\IsKeyReleased", "int", user_key_index)
        if ErrorLevel then return
            Return result
    }
    GetKeyPressedAmount(key_index, repeat_delay, repeat_rate){
        result := DllCall("imgui\GetKeyPressedAmount", "int", key_index, "float", repeat_delay, "float", repeat_rate, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    CaptureKeyboardFromApp(capture){
        DllCall("imgui\CaptureKeyboardFromApp", "int", capture, "cdecl")
    }
    IsMouseDown(button = "ImGuiMouseButton_Left"){
        result := DllCall("imgui\IsMouseDown", "int", button, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsMouseClicked(button = "ImGuiMouseButton_Left", repeat = False){
        result := DllCall("imgui\IsMouseClicked", "int", button, "int", repeat, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsMouseReleased(button = "ImGuiMouseButton_Left"){
        result := DllCall("imgui\IsMouseReleased", "int", button, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsMouseHoveringRect(r_min_x, r_min_y, r_max_x, r_max_y, clip = True){
        result := DllCall("imgui\IsMouseHoveringRect", "float", r_min_x, "float", r_min_y, "float", r_max_x, "float", r_max_y, "int", clip, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsMousePosValid(){
        result := DllCall("imgui\IsMousePosValid", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsAnyMouseDown(){
        result := DllCall("imgui\IsAnyMouseDown", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    IsMouseDragging(button = "ImGuiMouseButton_Left", lock_threshold = -1){
        result := DllCall("imgui\IsMouseDragging", "int", button, "float", lock_threshold, "cdecl int")
        if ErrorLevel then return
            Return result
    }
    ResetMouseDragDelta(button = "ImGuiMouseButton_Left"){
        DllCall("imgui\ResetMouseDragDelta", "int", button, "cdecl")
    }
    GetMouseCursor(){
        result := DllCall("imgui\GetMouseCursor", "cdecl int")
        if ErrorLevel then return
            Return result
    }
    SetMouseCursor(cursor_type = "ImGuiMouseCursor_Arrow"){
        DllCall("imgui\SetMouseCursor", "int", cursor_type, "cdecl")
    }
    CaptureMouseFromApp(capture){
        DllCall("imgui\CaptureMouseFromApp", "int", capture, "cdecl")
    }
    LoadIniSettingsFromDisk(ini_filename){
        DllCall("imgui\LoadIniSettingsFromDisk", "wstr", ini_filename, "cdecl")
    }
    SaveIniSettingsToDisk(ini_filename){
        DllCall("imgui\SaveIniSettingsToDisk", "wstr", ini_filename, "cdecl")
    }
    
    UpdatePlatformWindows(){
        DllCall("imgui\UpdatePlatformWindows", "cdecl")
        }
    RenderPlatformWindowsDefault(platform_render_arg, renderer_render_arg){
        DllCall("imgui\RenderPlatformWindowsDefault", "ptr", platform_render_arg, "ptr", renderer_render_arg, "cdecl")
        }
    DestroyPlatformWindows(){
        DllCall("imgui\DestroyPlatformWindows", "cdecl")
        }
    
    ; ========================================================================================================================================== ImDraw
    
    ImDraw_SetOffset(x, y){
        ImDraw_offset_x = x
        ImDraw_offset_y = y
    }
    
    ImDraw_SetDrawList(draw_list){
        ImDrawList_ptr = draw_list
    }
    ImDraw_GetDrawList(){
        Return ImDrawList_ptr
    }
    
    ImDraw_AddLine(p1_x, p1_y, p2_x, p2_y, col = 0xFFFFFFFF, thickness = 1){
        DllCall("imgui\AddLine", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "uint", col, "float", thickness, "cdecl")
    }
    ImDraw_AddRect(x, y, w, h, col = 0xFFFFFFFF, rounding = 0, rounding_corners = "ImDrawCornerFlags_All", thickness = 1){
        DllCall("imgui\AddRect",  "ptr", ImDrawList_ptr, "float", x, "float", y, "float", x+w, "float", y+h, "uint", col, "float", rounding, "int", rounding_corners, "float", thickness, "cdecl")
    }
    ImDraw_AddRectFilled( x, y, w, h, col = 0xFFFFFFFF, rounding = 0, rounding_corners = "ImDrawCornerFlags_All"){
        DllCall("imgui\AddRectFilled", "ptr", ImDrawList_ptr, "float", x, "float", y, "float", x+w, "float", y+h, "uint", col, "float", rounding, "int", rounding_corners, "cdecl")
    }
    ImDraw_AddBezierCurve(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, col = 0xFFFFFFFF, thickness = 1, num_segments = 30){
        DllCall("imgui\AddBezierCurve", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "uint", col, "float", thickness, "int", num_segments, "cdecl")
    }
    ImDraw_AddCircle(center_x, center_y, radius, col = 0xFFFFFFFF, num_segments = 30, thickness = 1){
        DllCall("imgui\AddCircle", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "uint", col, "int", num_segments, "float", thickness, "cdecl")
    }
    ; ImDraw_AddCircleFilled(center_x, center_y, radius, col = 0xFFFFFFFF, num_segments = radius/3+10)){
    ;     DllCall("imgui\AddCircleFilled", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "uint", col, "int", num_segments, "cdecl")
    ; }
    
    ImDraw_AddImage(user_texture_id, p_min_x, p_min_y, p_max_x, p_max_y, uv_min_x = 0, uv_min_y = 0, uv_max_x = 1, uv_max_y = 1, col = 0xFFFFFFFF){
        DllCall("imgui\AddImage", "ptr", ImDrawList_ptr, "int", user_texture_id, "float", p_min_x, "float", p_min_y, "float", p_max_x, "float", p_max_y, "float", uv_min_x, "float", uv_min_y, "float", uv_max_x, "float", uv_max_y, "uint", col, "cdecl")
    }
    ; ImDraw_AddImageQuad(user_texture_id, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, uv1_x = 0, uv1_y = 0, uv2_x = 1, uv2_y = 0, uv3_x = 1, uv3_y = 1, uv4_x = 0, uv4_y = 1, col = 0xFFFFFFFF){
    ;     DllCall("imgui\AddImageQuad", "ptr", ImDrawList_ptr, "int", user_texture_id, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "float", uv1_x, "float", uv1_y, "float", uv2_x, "float", uv2_y, "float", uv3_x, "float", uv3_y, "float", uv4_x, "float", uv4_y, "uint", col, "cdecl")
    ;     ImDraw_AddImageRounded(user_texture_id, p_min_x, p_min_y, p_max_x, p_max_y, uv_min_x = 0, uv_min_y = 0, uv_max_x = 1, uv_max_y = 1, col = 0xFFFFFFFF, rounding = 5, rounding_corners = ImDrawCornerFlags_All)
    ;     DllCall("imgui\AddImageRounded", "ptr", ImDrawList_ptr, "int", user_texture_id, "float", p_min_x, "float", p_min_y, "float", p_max_x, "float", p_max_y, "float", uv_min_x, "float", uv_min_y, "float", uv_max_x, "float", uv_max_y, "uint", col, "float", rounding, "int", rounding_corners, "cdecl")
    ; }
    
    ImDraw_AddNgon(center_x, center_y, radius, col = 0xFFFFFFFF, num_segments = 5, thickness = 1){
        DllCall("imgui\AddNgon", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "uint", col, "int", num_segments, "float", thickness, "cdecl")
    }
    ImDraw_AddNgonFilled(center_x, center_y, radius, col = 0xFFFFFFFF, num_segments = 5){
        DllCall("imgui\AddNgonFilled", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "uint", col, "int", num_segments, "cdecl")
    }
    
    ImDraw_AddQuad(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, col = 0xFFFFFFFF, thickness = 1){
        DllCall("imgui\AddQuad", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "uint", col, "float", thickness, "cdecl")
    }
    ImDraw_AddQuadFilled(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, col = 0xFFFFFFFF){
        DllCall("imgui\AddQuadFilled", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "uint", col, "cdecl")
    }
    ImDraw_AddRectFilledMultiColor(p_min_x, p_min_y, p_max_x, p_max_y, col_upr_left, col_upr_right, col_bot_right, col_bot_left){
        DllCall("imgui\AddRectFilledMultiColor", "ptr", ImDrawList_ptr, "float", p_min_x, "float", p_min_y, "float", p_max_x, "float", p_max_y, "uint", col_upr_left, "uint", col_upr_right, "uint", col_bot_right, "uint", col_bot_left, "cdecl")
    }
    ImDraw_AddText(text, font, font_size, pos_x, pos_y, col = 0xFFFFFFFF, wrap_width = 0){
        DllCall("imgui\AddText", "ptr", ImDrawList_ptr, "ptr", font, "float", font_size, "float", pos_x, "float", pos_y, "uint", col, "wstr", text, "float", wrap_width, "cdecl")
    }
    ImDraw_AddTriangle(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, col = 0xFFFFFFFF, thickness = 1){
        DllCall("imgui\AddTriangle", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "uint", col, "float", thickness, "cdecl")
    }
    ImDraw_AddTriangleFilled(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, col = 0xFFFFFFFF){
        DllCall("imgui\AddTriangleFilled", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "uint", col, "cdecl")
    }
    ImDraw_PathClear(){
        DllCall("imgui\PathClear", "ptr", ImDrawList_ptr, "cdecl")
    }
    ImDraw_PathLineTo(pos_x, pos_y){
        DllCall("imgui\PathLineTo", "ptr", ImDrawList_ptr, "float", pos_x, "float", pos_y, "cdecl")
    }
    ImDraw_PathLineToMergeDuplicate(pos_x, pos_y){
        DllCall("imgui\PathLineToMergeDuplicate", "ptr", ImDrawList_ptr, "float", pos_x, "float", pos_y, "cdecl")
    }
    ImDraw_PathFillConvex(col){
        DllCall("imgui\PathFillConvex", "ptr", ImDrawList_ptr, "uint", col, "cdecl")
    }
    ImDraw_PathStroke(col, closed, thickness = 1){
        DllCall("imgui\PathStroke", "ptr", ImDrawList_ptr, "uint", col, "int", closed, "float", thickness, "cdecl")
    }
    ; ImDraw_PathArcTo(center_x, center_y, radius, A_min, a_max, num_segments = 20){
    ;     DllCall("imgui\PathArcTo", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "float", A_min, "float", a_max, "int", num_segments, "cdecl")
    ; }
    ImDraw_PathArcToFast(center_x, center_y, radius, a_min_of_12, a_max_of_12){
        DllCall("imgui\PathArcToFast", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "int", a_min_of_12, "int", a_max_of_12, "cdecl")
    }
    ImDraw_PathBezierCurveTo(p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, num_segments = 0){
        DllCall("imgui\PathBezierCurveTo", "ptr", ImDrawList_ptr, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "int", num_segments, "cdecl")
    }
    ImDraw_PathRect(rect_min_x, rect_min_y, rect_max_x, rect_max_y, rounding = 0, rounding_corners = "ImDrawCornerFlags_All"){
        DllCall("imgui\PathRect", "ptr", ImDrawList_ptr, "float", rect_min_x, "float", rect_min_y, "float", rect_max_x, "float", rect_max_y, "float", rounding, "int", rounding_corners, "cdecl")
    }
    
    ; ImDraw_AddImageFit(user_texture_id, pos_x, pos_y, size_x = 0, size_y = 0, crop_area = True, rounding = 0, tint_col = 0xFFFFFFFF, rounding_corners = ImDrawCornerFlags_All){
    ; DllCall("imgui\XXXXXX", "cdecl", "AddImageFit", _
    ; "ptr", ImDrawList_ptr, _
    ; "ptr", user_texture_id, _
    ; "float", pos_x, _
    ; "float", pos_y, _
    ; "float", size_x, _
    ; "float", size_y, _
    ; "boolean", crop_area, _
    ; "float", rounding, _
    ; "uint", tint_col, _
    ; "int", rounding_corners)
    ; }
    
    ; ImageFit(user_texture_id, size_x = 0, size_y = 0, crop_area = True, rounding = 0, tint_col = 0xFFFFFFFF, rounding_corners = ImDrawCornerFlags_All){
    ; DllCall("imgui\XXXXXX", "cdecl", "ImageFit", _
    ; "ptr", user_texture_id, _
    ; "float", size_x, _
    ; "float", size_y, _
    ; "boolean", crop_area, _
    ; "float", rounding, _
    ; "uint", tint_col, _
    ; "int", rounding_corners)
    ; }
    
    ImageFromFile(file_path){
        result := DllCall("imgui\ImageFromFile", "wstr", file_path, "cdecl ptr")
        if ErrorLevel then return
            Return result
    }
    
    ImageFromURL(url){
        result := DllCall("imgui\ImageFromURL", "str", url, "cdecl ptr")
        if ErrorLevel then return
            Return result
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

