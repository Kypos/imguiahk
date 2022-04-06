_ImGui_Load_dll()

__imgui_created := False
ImDrawList_ptr := 0, ImDraw_offset_x := 0, ImDraw_offset_y := 0

FLT_MAX         				          :=  3.402823466e+38

ImGuiWindowFlags_None                   :=  0
ImGuiWindowFlags_NoTitleBar             := 1<<0
ImGuiWindowFlags_NoResize               := 1<<1
ImGuiWindowFlags_NoMove                 := 1<<2
ImGuiWindowFlags_NoScrollbar            := 1<<3
ImGuiWindowFlags_NoScrollWithMouse      := 1<<4
ImGuiWindowFlags_NoCollapse             := 1<<5
ImGuiWindowFlags_AlwaysAutoResize       := 1<<6
ImGuiWindowFlags_NoBackground           := 1<<7
ImGuiWindowFlags_NoSavedSettings        := 1<<8
ImGuiWindowFlags_NoMouseInputs          := 1<<9
ImGuiWindowFlags_MenuBar                := 1<<10
ImGuiWindowFlags_HorizontalScrollbar    := 1<<11
ImGuiWindowFlags_NoFocusOnAppearing     := 1<<12
ImGuiWindowFlags_NoBringToFrontOnFocus  := 1<<13
ImGuiWindowFlags_AlwaysVerticalScrollbar:= 1<<14
ImGuiWindowFlags_AlwaysHorizontalScrollbar:= 1<<15
ImGuiWindowFlags_AlwaysUseWindowPadding := 1<<16
ImGuiWindowFlags_NoNavInputs            := 1<<18
ImGuiWindowFlags_NoNavFocus             := 1<<19
ImGuiWindowFlags_UnsavedDocument        := 1<<20
ImGuiWindowFlags_NoDocking              := 1<<21
ImGuiWindowFlags_NoNav                  :=  ImGuiWindowFlags_NoNavInputs |  ImGuiWindowFlags_NoNavFocus
ImGuiWindowFlags_NoDecoration           :=  ImGuiWindowFlags_NoTitleBar| ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoScrollbar |  ImGuiWindowFlags_NoCollapse
ImGuiWindowFlags_NoInputs               :=  ImGuiWindowFlags_NoMouseInputs | ImGuiWindowFlags_NoNavInputs |  ImGuiWindowFlags_NoNavFocus
ImGuiWindowFlags_NavFlattened           := 1<<23
ImGuiWindowFlags_ChildWindow            := 1<<24
ImGuiWindowFlags_Tooltip                := 1<<25
ImGuiWindowFlags_Popup                  := 1<<26
ImGuiWindowFlags_Modal                  := 1<<27
ImGuiWindowFlags_ChildMenu              := 1<<28
ImGuiWindowFlags_DockNodeHost           := 1<<29

ImGuiInputTextFlags_None                := 0
ImGuiInputTextFlags_CharsDecimal        := 1<< 0
ImGuiInputTextFlags_CharsHexadecimal    := 1<<1
ImGuiInputTextFlags_CharsUppercase      := 1<<2
ImGuiInputTextFlags_CharsNoBlank        := 1<<3
ImGuiInputTextFlags_AutoSelectAll       := 1<<4
ImGuiInputTextFlags_EnterReturnsTrue    := 1<<5
ImGuiInputTextFlags_CallbackCompletion  := 1<<6
ImGuiInputTextFlags_CallbackHistory     := 1<<7
ImGuiInputTextFlags_CallbackAlways      := 1<<8
ImGuiInputTextFlags_CallbackCharFilter  := 1<<9
ImGuiInputTextFlags_AllowTabInput       := 1<<10
ImGuiInputTextFlags_CtrlEnterForNewLine := 1<<11
ImGuiInputTextFlags_NoHorizontalScroll  := 1<<12
ImGuiInputTextFlags_AlwaysInsertMode    := 1<<13
ImGuiInputTextFlags_ReadOnly            := 1<<14
ImGuiInputTextFlags_Password            := 1<<15
ImGuiInputTextFlags_NoUndoRedo          := 1<<16
ImGuiInputTextFlags_CharsScientific     := 1<<17
ImGuiInputTextFlags_CallbackResize      := 1<<18
ImGuiInputTextFlags_Multiline           := 1<<20
ImGuiInputTextFlags_NoMarkEdited        := 1<<21

ImGuiTreeNodeFlags_None                 :=  0
ImGuiTreeNodeFlags_Selected             := 1<<0
ImGuiTreeNodeFlags_Framed               := 1<<1
ImGuiTreeNodeFlags_AllowItemOverlap     := 1<<2
ImGuiTreeNodeFlags_NoTreePushOnOpen     := 1<<3
ImGuiTreeNodeFlags_NoAutoOpenOnLog      := 1<<4
ImGuiTreeNodeFlags_DefaultOpen          := 1<<5
ImGuiTreeNodeFlags_OpenOnDoubleClick    := 1<<6
ImGuiTreeNodeFlags_OpenOnArrow          := 1<<7
ImGuiTreeNodeFlags_Leaf                 := 1<<8
ImGuiTreeNodeFlags_Bullet               := 1<<9
ImGuiTreeNodeFlags_FramePadding         := 1<<10
ImGuiTreeNodeFlags_SpanAvailWidth       := 1<<11
ImGuiTreeNodeFlags_SpanFullWidth        := 1<<12
ImGuiTreeNodeFlags_NavLeftJumpsBackHere := 1<<13
ImGuiTreeNodeFlags_CollapsingHeader     := ImGuiTreeNodeFlags_Framed | ImGuiTreeNodeFlags_NoTreePushOnOpen |  ImGuiTreeNodeFlags_NoAutoOpenOnLog

ImGuiPopupFlags_None                    :=  0
ImGuiPopupFlags_MouseButtonLeft         :=  0
ImGuiPopupFlags_MouseButtonRight        :=  1
ImGuiPopupFlags_MouseButtonMiddle       :=  2
ImGuiPopupFlags_MouseButtonMask_        :=  0x1F
ImGuiPopupFlags_MouseButtonDefault_     :=  1
ImGuiPopupFlags_NoOpenOverExistingPopup := 1<<5
ImGuiPopupFlags_NoOpenOverItems         := 1<<6
ImGuiPopupFlags_AnyPopupId              := 1<<7
ImGuiPopupFlags_AnyPopupLevel           := 1<<8
ImGuiPopupFlags_AnyPopup                := ImGuiPopupFlags_AnyPopupId |  ImGuiPopupFlags_AnyPopupLevel

ImGuiSelectableFlags_None               :=  0
ImGuiSelectableFlags_DontClosePopups    := 1<<0
ImGuiSelectableFlags_SpanAllColumns     := 1<<1
ImGuiSelectableFlags_AllowDoubleClick   := 1<<2
ImGuiSelectableFlags_Disabled           := 1<<3
ImGuiSelectableFlags_AllowItemOverlap   := 1<<4

ImGuiComboFlags_None                    :=  0
ImGuiComboFlags_PopupAlignLeft          := 1<<0
ImGuiComboFlags_HeightSmall             := 1<<1
ImGuiComboFlags_HeightRegular           := 1<<2
ImGuiComboFlags_HeightLarge             := 1<<3
ImGuiComboFlags_HeightLargest           := 1<<4
ImGuiComboFlags_NoArrowButton           := 1<<5
ImGuiComboFlags_NoPreview               := 1<<6
ImGuiComboFlags_HeightMask_             := ImGuiComboFlags_HeightSmall | ImGuiComboFlags_HeightRegular | ImGuiComboFlags_HeightLarge |  ImGuiComboFlags_HeightLargest

ImGuiTabBarFlags_None                           :=  0
ImGuiTabBarFlags_Reorderable                    := 1<<0
ImGuiTabBarFlags_AutoSelectNewTabs              := 1<<1
ImGuiTabBarFlags_TabListPopupButton             := 1<<2
ImGuiTabBarFlags_NoCloseWithMiddleMouseButton   := 1<<3
ImGuiTabBarFlags_NoTabListScrollingButtons      := 1<<4
ImGuiTabBarFlags_NoTooltip                      := 1<<5
ImGuiTabBarFlags_FittingPolicyResizeDown        := 1<<6
ImGuiTabBarFlags_FittingPolicyScroll            := 1<<7
ImGuiTabBarFlags_FittingPolicyMask_             := ImGuiTabBarFlags_FittingPolicyResizeDown |  ImGuiTabBarFlags_FittingPolicyScroll
ImGuiTabBarFlags_FittingPolicyDefault_          := ImGuiTabBarFlags_FittingPolicyResizeDown

ImGuiTabItemFlags_None                          :=  0
ImGuiTabItemFlags_UnsavedDocument               := 1<<0
ImGuiTabItemFlags_SetSelected                   := 1<<1
ImGuiTabItemFlags_NoCloseWithMiddleMouseButton  := 1<<2
ImGuiTabItemFlags_NoPushId                      := 1<<3
ImGuiTabItemFlags_NoTooltip                     := 1<<4

ImGuiFocusedFlags_None                          :=  0
ImGuiFocusedFlags_ChildWindows                  := 1<<0
ImGuiFocusedFlags_RootWindow                    := 1<<1
ImGuiFocusedFlags_AnyWindow                     := 1<<2
ImGuiFocusedFlags_RootAndChildWindows           := ImGuiFocusedFlags_RootWindow |  ImGuiFocusedFlags_ChildWindows


ImGuiHoveredFlags_None                          :=  0
ImGuiHoveredFlags_ChildWindows                  := 1<<0
ImGuiHoveredFlags_RootWindow                    := 1<<1
ImGuiHoveredFlags_AnyWindow                     := 1<<2
ImGuiHoveredFlags_AllowWhenBlockedByPopup       := 1<<3
ImGuiHoveredFlags_AllowWhenBlockedByActiveItem  := 1<<5
ImGuiHoveredFlags_AllowWhenOverlapped           := 1<<6
ImGuiHoveredFlags_AllowWhenDisabled             := 1<<7
ImGuiHoveredFlags_RectOnly                      := ImGuiHoveredFlags_AllowWhenBlockedByPopup | ImGuiHoveredFlags_AllowWhenBlockedByActiveItem |  ImGuiHoveredFlags_AllowWhenOverlapped
ImGuiHoveredFlags_RootAndChildWindows           := ImGuiHoveredFlags_RootWindow |  ImGuiHoveredFlags_ChildWindows


ImGuiDockNodeFlags_None                         :=  0
ImGuiDockNodeFlags_KeepAliveOnly                := 1<<0
ImGuiDockNodeFlags_NoDockingInCentralNode       := 1<<2
ImGuiDockNodeFlags_PassthruCentralNode          := 1<<3
ImGuiDockNodeFlags_NoSplit                      := 1<<4
ImGuiDockNodeFlags_NoResize                     := 1<<5
ImGuiDockNodeFlags_AutoHideTabBar               := 1<<6

ImGuiDragDropFlags_None                         :=  0
ImGuiDragDropFlags_SourceNoPreviewTooltip       := 1<<0
ImGuiDragDropFlags_SourceNoDisableHover         := 1<<1
ImGuiDragDropFlags_SourceNoHoldToOpenOthers     := 1<<2
ImGuiDragDropFlags_SourceAllowNullID            := 1<<3
ImGuiDragDropFlags_SourceExtern                 := 1<<4
ImGuiDragDropFlags_SourceAutoExpirePayload      := 1<<5
ImGuiDragDropFlags_AcceptBeforeDelivery         := 1<<10
ImGuiDragDropFlags_AcceptNoDrawDefaultRect      := 1<<11
ImGuiDragDropFlags_AcceptNoPreviewTooltip       := 1<<12
ImGuiDragDropFlags_AcceptPeekOnly               := ImGuiDragDropFlags_AcceptBeforeDelivery |  ImGuiDragDropFlags_AcceptNoDrawDefaultRect

ImGuiDataType_S8 := 0
ImGuiDataType_U8 := 1
ImGuiDataType_S16 := 2
ImGuiDataType_U16 := 3
ImGuiDataType_S32 := 4
ImGuiDataType_U32 := 5
ImGuiDataType_S64 := 6
ImGuiDataType_U64 := 7
ImGuiDataType_Float := 8
ImGuiDataType_Double := 9
ImGuiDataType_COUNT := 10

ImGuiDir_None    :=  -1
ImGuiDir_Left    :=  0
ImGuiDir_Right   :=  1
ImGuiDir_Up      :=  2
ImGuiDir_Down    :=  3

ImGuiKey_Tab := 0
ImGuiKey_LeftArrow := 1
ImGuiKey_RightArrow := 2
ImGuiKey_UpArrow := 3
ImGuiKey_DownArrow := 4
ImGuiKey_PageUp := 5
ImGuiKey_PageDown := 6
ImGuiKey_Home := 7
ImGuiKey_End := 8
ImGuiKey_Insert := 9
ImGuiKey_Delete := 10
ImGuiKey_Backspace := 11
ImGuiKey_Space := 12
ImGuiKey_Enter := 13
ImGuiKey_Escape := 14
ImGuiKey_KeyPadEnter := 15
ImGuiKey_A := 16
ImGuiKey_C := 17
ImGuiKey_V := 18
ImGuiKey_X := 19
ImGuiKey_Y := 20
ImGuiKey_Z := 21

ImGuiKeyModFlags_None       :=  0
ImGuiKeyModFlags_Ctrl       := 1<<0
ImGuiKeyModFlags_Shift      := 1<<1
ImGuiKeyModFlags_Alt        := 1<<2
ImGuiKeyModFlags_Super      := 1<<3
ImGuiNavInput_Activate := 0
ImGuiNavInput_Cancel := 1
ImGuiNavInput_Input := 2
ImGuiNavInput_Menu := 3
ImGuiNavInput_DpadLeft := 4
ImGuiNavInput_DpadRight := 5
ImGuiNavInput_DpadUp := 6
ImGuiNavInput_DpadDown := 7
ImGuiNavInput_LStickLeft := 8
ImGuiNavInput_LStickRight := 9
ImGuiNavInput_LStickUp := 10
ImGuiNavInput_LStickDown := 11
ImGuiNavInput_FocusPrev := 12
ImGuiNavInput_FocusNext := 13
ImGuiNavInput_TweakSlow := 14
ImGuiNavInput_TweakFast := 15

ImGuiNavInput_KeyMenu_ := 16
ImGuiNavInput_KeyLeft_ := 17
ImGuiNavInput_KeyRight_ := 18
ImGuiNavInput_KeyUp_ := 19
ImGuiNavInput_KeyDown_ := 20
ImGuiNavInput_COUNT := 21
ImGuiNavInput_InternalStart_ :=  ImGuiNavInput_KeyMenu_


ImGuiConfigFlags_None                   :=  0
ImGuiConfigFlags_NavEnableKeyboard      := 1<<0
ImGuiConfigFlags_NavEnableGamepad       := 1<<1
ImGuiConfigFlags_NavEnableSetMousePos   := 1<<2
ImGuiConfigFlags_NavNoCaptureKeyboard   := 1<<3
ImGuiConfigFlags_NoMouse                := 1<<4
ImGuiConfigFlags_NoMouseCursorChange    := 1<<5
ImGuiConfigFlags_DockingEnable          := 1<<6

ImGuiConfigFlags_ViewportsEnable        := 1<<10
ImGuiConfigFlags_DpiEnableScaleViewports:= 1<<14
ImGuiConfigFlags_DpiEnableScaleFonts    := 1<<15
ImGuiConfigFlags_IsSRGB                 := 1<<20
ImGuiConfigFlags_IsTouchScreen          := 1<<21

ImGuiBackendFlags_None                  :=  0
ImGuiBackendFlags_HasGamepad            := 1<<0
ImGuiBackendFlags_HasMouseCursors       := 1<<1
ImGuiBackendFlags_HasSetMousePos        := 1<<2
ImGuiBackendFlags_RendererHasVtxOffset  := 1<<3
ImGuiBackendFlags_PlatformHasViewports  := 1<<10
ImGuiBackendFlags_HasMouseHoveredViewport:= 1<<11
ImGuiBackendFlags_RendererHasViewports  := 1<<12

ImGuiCol_Text := 0
ImGuiCol_TextDisabled := 1
ImGuiCol_WindowBg := 2
ImGuiCol_ChildBg := 3
ImGuiCol_PopupBg := 4
ImGuiCol_Border := 5
ImGuiCol_BorderShadow := 6
ImGuiCol_FrameBg := 7
ImGuiCol_FrameBgHovered := 8
ImGuiCol_FrameBgActive := 9
ImGuiCol_TitleBg := 10
ImGuiCol_TitleBgActive := 11
ImGuiCol_TitleBgCollapsed := 12
ImGuiCol_MenuBarBg := 13
ImGuiCol_ScrollbarBg := 14
ImGuiCol_ScrollbarGrab := 15
ImGuiCol_ScrollbarGrabHovered := 16
ImGuiCol_ScrollbarGrabActive := 17
ImGuiCol_CheckMark := 18
ImGuiCol_SliderGrab := 19
ImGuiCol_SliderGrabActive := 20
ImGuiCol_Button := 21
ImGuiCol_ButtonHovered := 22
ImGuiCol_ButtonActive := 23
ImGuiCol_Header := 24
ImGuiCol_HeaderHovered := 25
ImGuiCol_HeaderActive := 26
ImGuiCol_Separator := 27
ImGuiCol_SeparatorHovered := 28
ImGuiCol_SeparatorActive := 29
ImGuiCol_ResizeGrip := 30
ImGuiCol_ResizeGripHovered := 31
ImGuiCol_ResizeGripActive := 32
ImGuiCol_Tab := 33
ImGuiCol_TabHovered := 34
ImGuiCol_TabActive := 35
ImGuiCol_TabUnfocused := 36
ImGuiCol_TabUnfocusedActive := 37
ImGuiCol_DockingPreview := 38
ImGuiCol_DockingEmptyBg := 39
ImGuiCol_PlotLines := 40
ImGuiCol_PlotLinesHovered := 41
ImGuiCol_PlotHistogram := 42
ImGuiCol_PlotHistogramHovered := 43
ImGuiCol_TextSelectedBg := 44
ImGuiCol_DragDropTarget := 45
ImGuiCol_NavHighlight := 46
ImGuiCol_NavWindowingHighlight := 47
ImGuiCol_NavWindowingDimBg := 48
ImGuiCol_ModalWindowDimBg := 49
ImGuiCol_DockingPreview_1 := 50
ImGuiCol_DockingOutLine := 51
ImGuiCol_DockingLine := 52

ImGuiStyleVar_Alpha := 0
ImGuiStyleVar_WindowPadding := 1
ImGuiStyleVar_WindowRounding := 2
ImGuiStyleVar_WindowBorderSize := 3
ImGuiStyleVar_WindowMinSize := 4
ImGuiStyleVar_WindowTitleAlign := 5
ImGuiStyleVar_ChildRounding := 6
ImGuiStyleVar_ChildBorderSize := 7
ImGuiStyleVar_PopupRounding := 8
ImGuiStyleVar_PopupBorderSize := 9
ImGuiStyleVar_FramePadding := 10
ImGuiStyleVar_FrameRounding := 11
ImGuiStyleVar_FrameBorderSize := 12
ImGuiStyleVar_ItemSpacing := 13
ImGuiStyleVar_ItemInnerSpacing := 14
ImGuiStyleVar_IndentSpacing := 15
ImGuiStyleVar_ScrollbarSize := 16
ImGuiStyleVar_ScrollbarRounding := 17
ImGuiStyleVar_GrabMinSize := 18
ImGuiStyleVar_GrabRounding := 19
ImGuiStyleVar_TabRounding := 20
ImGuiStyleVar_ButtonTextAlign := 21
ImGuiStyleVar_SelectableTextAlign := 22

ImGuiColorEditFlags_None            :=  0
ImGuiColorEditFlags_NoAlpha         := 1<<1
ImGuiColorEditFlags_NoPicker        := 1<<2
ImGuiColorEditFlags_NoOptions       := 1<<3
ImGuiColorEditFlags_NoSmallPreview  := 1<<4
ImGuiColorEditFlags_NoInputs        := 1<<5
ImGuiColorEditFlags_NoTooltip       := 1<<6
ImGuiColorEditFlags_NoLabel         := 1<<7
ImGuiColorEditFlags_NoSidePreview   := 1<<8
ImGuiColorEditFlags_NoDragDrop      := 1<<9
ImGuiColorEditFlags_NoBorder        := 1<<10
ImGuiColorEditFlags_AlphaBar        := 1<<16
ImGuiColorEditFlags_AlphaPreview    := 1<<17
ImGuiColorEditFlags_AlphaPreviewHalf:= 1<<18
ImGuiColorEditFlags_HDR             := 1<<19
ImGuiColorEditFlags_DisplayRGB      := 1<<20
ImGuiColorEditFlags_DisplayHSV      := 1<<21
ImGuiColorEditFlags_DisplayHex      := 1<<22
ImGuiColorEditFlags_Uint8           := 1<<23
ImGuiColorEditFlags_Float           := 1<<24
ImGuiColorEditFlags_PickerHueBar    := 1<<25
ImGuiColorEditFlags_PickerHueWheel  := 1<<26
ImGuiColorEditFlags_InputRGB        := 1<<27
ImGuiColorEditFlags_InputHSV        := 1<<28

ImGuiColorEditFlags__OptionsDefault := ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_DisplayRGB | ImGuiColorEditFlags_InputRGB |  ImGuiColorEditFlags_PickerHueBar
ImGuiColorEditFlags__DisplayMask    := ImGuiColorEditFlags_DisplayRGB | ImGuiColorEditFlags_DisplayHSV |  ImGuiColorEditFlags_DisplayHex
ImGuiColorEditFlags__DataTypeMask   := ImGuiColorEditFlags_Uint8 |  ImGuiColorEditFlags_Float
ImGuiColorEditFlags__PickerMask     := ImGuiColorEditFlags_PickerHueWheel |  ImGuiColorEditFlags_PickerHueBar
ImGuiColorEditFlags__InputMask      := ImGuiColorEditFlags_InputRGB |  ImGuiColorEditFlags_InputHSV

ImGuiMouseButton_Left :=  0
ImGuiMouseButton_Right :=  1
ImGuiMouseButton_Middle :=  2
ImGuiMouseButton_COUNT :=  5

ImGuiMouseCursor_None :=  -1
ImGuiMouseCursor_Arrow :=  0
ImGuiMouseCursor_TextInput := 0
ImGuiMouseCursor_ResizeAll := 1
ImGuiMouseCursor_ResizeNS := 2
ImGuiMouseCursor_ResizeEW := 3
ImGuiMouseCursor_ResizeNESW := 4
ImGuiMouseCursor_ResizeNWSE := 5
ImGuiMouseCursor_Hand := 6
ImGuiMouseCursor_NotAllowed := 7


ImGuiCond_None          :=  0
ImGuiCond_Always        := 1<<0
ImGuiCond_Once          := 1<<1
ImGuiCond_FirstUseEver  := 1<<2
ImGuiCond_Appearing     := 1<<3


ImDrawCornerFlags_None      :=  0
ImDrawCornerFlags_TopLeft   := 1<<0
ImDrawCornerFlags_TopRight  := 1<<1
ImDrawCornerFlags_BotLeft   := 1<<2
ImDrawCornerFlags_BotRight  := 1<<3
ImDrawCornerFlags_Top       := ImDrawCornerFlags_TopLeft |  ImDrawCornerFlags_TopRight
ImDrawCornerFlags_Bot       := ImDrawCornerFlags_BotLeft |  ImDrawCornerFlags_BotRight
ImDrawCornerFlags_Left      := ImDrawCornerFlags_TopLeft |  ImDrawCornerFlags_BotLeft
ImDrawCornerFlags_Right     := ImDrawCornerFlags_TopRight |  ImDrawCornerFlags_BotRight
ImDrawCornerFlags_All       :=  0xF

ImDrawListFlags_None             :=  0
ImDrawListFlags_AntiAliasedLines := 1<<0
ImDrawListFlags_AntiAliasedFill  := 1<<1
ImDrawListFlags_AllowVtxOffset   := 1<<2

_ImGui_Load_dll()
{
	SplitPath(A_LineFile,,&dir)
	path := ""
	if(A_IsCompiled)
	{
		path := A_PtrSize == 4 ? (A_ScriptDir . "/lib/32/") : (A_ScriptDir . "/lib/64/")
	}
	else
	{
		path := A_PtrSize == 4 ? (dir . "/32/") : (dir . "/64/")
	}
	dllcall("SetDllDirectory", "Str", path)
	hModule := DllCall("LoadLibrary", "Str", "imgui.dll", "Ptr")
	return hModule
}

class imgui{
	static EnableViewports(enable := True)
	{
		DllCall("imgui\EnableViewports","Int", enable)
	}
	
	static EnableDocking(enable := True)
	{
		io := this.GetIO()
		ConfigFlags := NumGet(io , 0, "Int")
		set := enable ? (ConfigFlags | ImGuiConfigFlags_DockingEnable ) : (ConfigFlags ^ ImGuiConfigFlags_DockingEnable )
		NumPut("Int", set, io)
	}
	static SetWindowTitleAlign(x := 0.5, y := 0.5)
	{
		imstyle := this.GetStyle()
		NumPut("float", x, "float", y, imstyle, 28)
	}
	
	static GUICreate(title, w, h, x := -1, y := -1, style := 0, ex_style := 0, font_path := "c:/windows/fonts/BRLNSR.ttf", font_size := 20, font_range := "")
	{
		global __imgui_created 
		if(__imgui_created)
			return False
		result := DllCall("imgui\GUICreate", "wstr", title, "int", w, "int", h, "int", x, "int", y, "wstr", font_path, "float", font_size, "wstr", font_range)
		if(style != 0)
			DllCall("SetWindowLong", "Ptr", result, "Int", -16 ,"Int", style)
		if(ex_style != 0)
			DllCall("SetWindowLong", "Ptr", result, "Int", -20, "Int", ex_style)
		__imgui_created := True
		return result
	}
	static PeekMsg()
	{
		result := DllCall("imgui\PeekMsg")
		return result
	}
	
	static GetIO()
	{
		result := DllCall("imgui\GetIO", "Cdecl Ptr")
		return result
	}
	
	static GetStyle()
	{
		result := Dllcall("imgui\GetStyle", "Cdecl Ptr")
		return result
	}
	static BeginFrame()
	{
		DllCall("imgui\BeginFrame", "Cdecl")
	}
	static EndFrame()
	{
		DllCall("imgui\EndFrame", "UInt", 0x004488, "Cdecl")
	}
	;Style
	static StyleColorsLight()
	{
		DllCall("imgui\StyleColorsLight")
	}
	
	static StyleColorsDark()
	{
		DllCall("imgui\StyleColorsDark")
	}
	static StyleColorsClassic()
	{
		DllCall("imgui\StyleColorsClassic")
	}
	
	;window
	static Begin(title, close_btn := 0, flags := 0)
	{
		DllCall("imgui\Begin", "WStr", title, "Int", close_btn, "Int", flags, "Cdecl")
	}
	static End()
	{
		DllCall("imgui\End", "Cdecl")
	}
	
	; // Child Windows
	;flags := ImGuiWindowFlags_None
	static BeginChild(text, w := 0, h := 0, border := False, flags := 0)
	{
		
		result := Dllcall("imgui\BeginChild", "wstr", text, "float", w, "float", h, "int", border, "int", flags)
		Return result
	}
	static EndChild()
	{
		Dllcall("imgui\EndChild")
	}
	
	
	static IsWindowAppearing()
	{
		result := Dllcall("imgui\IsWindowAppearing")
		Return result
	}
	
	static IsWindowCollapsed()
	{
		result := Dllcall("imgui\IsWindowCollapsed")
		Return result
	}
	
	;flags := ImGuiFocusedFlags_None
	static IsWindowFocused(flags := 0)
	{
		result := Dllcall("imgui\IsWindowFocused", "int", flags)
		Return result[0]
	}
	static IsWindowHovered(flags := 0)
	{
		result := Dllcall("imgui\IsWindowHovered", "int", flags)
		Return result[0]
	}
	
	static GetWindowDrawList()
	{
		result := Dllcall("imgui\GetWindowDrawList")
		Return result
	}
	
	static GetOverlayDrawList()
	{
		result := Dllcall("imgui\GetOverlayDrawList")
		Return result
	}
	static GetBackgroundDrawList()
	{
		result := Dllcall("imgui\GetBackgroundDrawList")
		Return result
	}
	static GetForegroundDrawList()
	{
		result := Dllcall("imgui\GetForegroundDrawList")
		Return result
	}
	static GetWindowDpiScale()
	{
		result := Dllcall("imgui\GetWindowDpiScale")
		Return result
	}
	
	static GetWindowViewport()
	{
		result := Dllcall("imgui\GetWindowViewport")
		return result
	}
	
	static GetWindowPos()
	{
		Return this.RecvImVec2("none:cdecl", "GetWindowPos")
	}
	
	static GetWindowSize()
	{
		return this.RecvImVec2("none:cdecl", "GetWindowSize")
	}
	
	static GetWindowWidth()
	{
		result := Dllcall("imgui\GetWindowWidth")
		Return result
	}
	
	static GetWindowHeight()
	{
		result := Dllcall("imgui\GetWindowHeight")
		Return result
	}
	;cond := ImGuiCond_None
	SetNextWindowPos(x, y, cond := 0, pivot_x := 0, pivot_y := 0)
	{
		Dllcall("imgui\SetNextWindowPos", "float", x, "float", y, "int", cond, "float", pivot_x, "float", pivot_y)
	}
	static SetNextWindowSize(x, y, cond := 0)
	{
		Dllcall("imgui\SetNextWindowSize", "float", x, "float", y, "int", cond)
	}
	static SetNextWindowSizeConstraints(size_min_x, size_min_y, size_max_x, size_max_y)
	{
		Dllcall("imgui\SetNextWindowSizeConstraints", "float", size_min_x, "float", size_min_y, "float", size_max_x, "float", size_max_y)
	}
	
	static SetNextWindowContentSize(size_x, size_y)
	{
		Dllcall("imgui\SetNextWindowContentSize", "float", size_x, "float", size_y)
	}
	static SetNextWindowCollapsed(collapsed, cond := 0)
	{
		Dllcall("imgui\SetNextWindowCollapsed", "int", collapsed, "int", cond)
	}
	static SetNextWindowFocus()
	{
		Dllcall("imgui\SetNextWindowFocus")
	}
	static SetNextWindowBgAlpha(alpha)
	{
		Dllcall("imgui\SetNextWindowBgAlpha", "float", alpha)
	}
	static SetNextWindowViewport(id)
	{
		Dllcall("imgui\SetNextWindowViewport", "int", id)
	}
	static SetWindowPos(pos_x, pos_y, cond:=0)
	{
		Dllcall("imgui\SetWindowPosition", "float", pos_x, "float", pos_y, "int", cond)
	}
	static SetWindowSize(size_x, size_y, cond:=0)
	{
		Dllcall("imgui\SetWindowSize", "float", size_x, "float", size_y, "int", cond)
	}
	
	static SetWindowCollapsed(collapsed, cond := 0)
	{
		Dllcall("imgui\SetWindowCollapsed", "int", collapsed, "int", cond)
	}
	
	static SetWindowFocus()
	{
		Dllcall("imgui\SetWindowFocus")
	}
	
	static SetWindowFontScale(scale)
	{
		Dllcall("imgui\SetWindowFontScale", "float", scale)
	}
	static SetWindowPosByName(name, pos_x, pos_y, cond := 0)
	{
		Dllcall("imgui\SetWindowPosByName", "wstr", name, "float", pos_x, "float", pos_y, "int", cond)
	}
	
	static SetWindowSizeByName(name, size_x, size_y, cond := 0)
	{
		Dllcall("imgui\SetWindowSizeByName", "wstr", name, "float", size_x, "float", size_y, "int", cond)
	}
	
	static SetWindowCollapsedByName(name, collapsed, cond := 0)
	{
		result := Dllcall("imgui\SetWindowCollapsedByName", "wstr", name, "int", collapsed, "int", cond)
		Return result
	}
	static SetWindowFocusByName(name)
	{
		Dllcall("imgui\SetWindowFocus", "wstr", name)
	}
	
	RecvImVec2(return_type, func_name)
	{
		struct_x := buffer("4", 0)
		struct_y := buffer("4", 0)
		result := DllCall("imgui\" func_name, "ptr", struct_x, "ptr", struct_y)
		ret := [NumGet(struct_x, 0, "float"), NumGet(struct_y, 0, "float")]
		Return ret
	}
	
	static GetContentRegionMax()
	{
		return this.RecvImVec2("none:cdecl", "GetContentRegionMax")
	}
	static GetContentRegionAvail()
	{
		return this.RecvImVec2("none:cdecl", "GetContentRegionAvail")
	}
	static GetWindowContentRegionMin()
	{
		return this.RecvImVec2("none:cdecl", "GetWindowContentRegionMin")
	}
	static GetWindowContentRegionMax()
	{
		return this.RecvImVec2("none:cdecl", "GetWindowContentRegionMax")
	}
	static GetItemRectMin()
	{
		return this.RecvImVec2("none:cdecl", "GetItemRectMin")
	}
	static GetItemRectMax()
	{
		return this.RecvImVec2("none:cdecl", "GetItemRectMax")
	}
	static GetItemRectSize()
	{
		return this.RecvImVec2("none:cdecl", "GetItemRectSize")
	}
	static GetMousePos()
	{
		return this.RecvImVec2("none:cdecl", "GetMousePos")
	}
	static GetMousePosOnOpeningCurrentPopup()
	{
		return this.RecvImVec2("none:cdecl", "GetMousePosOnOpeningCurrentPopup")
	}
	;button := ImGuiMouseButton_Left
	static GetMouseDragDelta(button := 0, lock_threshold := -1)
	{
		struct_x := buffer(4, 0)
		struct_y := buffer(4, 0)
		result := Dllcall("imgui\GetMouseDragDelta", "int", button, "float", lock_threshold, "ptr", struct_x,"ptr", struct_y)
		ret := [NumGet(struct_x, 0, "float"), NumGet(struct_y, 4, "float")]
		Return ret
	}
	
	static GetWindowContentRegionWidth()
	{
		result := Dllcall("imgui\GetWindowContentRegionWidth")
		Return result
	}
	static GetScrollX()
	{
		result := Dllcall("imgui\GetScrollX")
		Return result
	}
	static GetScrollY()
	{
		result := Dllcall("imgui\GetScrollY")
		Return result
	}
	static GetScrollMaxX()
	{
		result := Dllcall("imgui\GetScrollMaxX")
		Return result
	}
	static GetScrollMaxY()
	{
		result := Dllcall("imgui\GetScrollMaxY")
		Return result
	}
	static SetScrollX(scroll_x)
	{
		Dllcall("imgui\SetScrollX", "float", scroll_x)
	}
	static SetScrollY(scroll_y)
	{
		Dllcall("imgui\SetScrollY", "float", scroll_y)
	}
	static SetScrollHereX(center_x_ratio := 0.5)
	{
		Dllcall("imgui\SetScrollHereX", "float", center_x_ratio)
	}
	static SetScrollHereY(center_y_ratio := 0.5)
	{
		Dllcall("imgui\SetScrollHereY", "float", center_y_ratio)
	}
	static SetScrollFromPosX(local_x, center_x_ratio := 0.5)
	{
		Dllcall("imgui\SetScrollFromPosX", "float", local_x, "float", center_x_ratio)
	}
	static SetScrollFromPosY(local_y, center_y_ratio := 0.5)
	{
		Dllcall("imgui\SetScrollFromPosY", "float", local_y, "float", center_y_ratio)
	}
	static PushFont(font)
	{
		Dllcall("imgui\PushFont", "ptr", font)
	}
	static PopFont()
	{
		Dllcall("imgui\PopFont")
	}
	static PushStyleColor(idx, col)
	{
		Dllcall("imgui\PushStyleColor", "int", idx, "uint", col)
	}
	static PopStyleColor(count := 1)
	{
		Dllcall("imgui\PopStyleColor", "int", count)
	}
	static PushStyleVar(idx, val)
	{
		Dllcall("imgui\PushStyleVar", "int", idx, "float", val)
	}
	static PushStyleVarPos(idx, val_x, val_y)
	{
		Dllcall("imgui\PushStyleVarPos", "int", idx, "float", val_x, "float", val_y)
	}
	static PopStyleVar(count := 1)
	{
		Dllcall("imgui\PopStyleVar", "int", count)
	}
	static GetFont()
	{
		result := Dllcall("imgui\GetFont")
		Return result
	}
	static GetFontSize()
	{
		result := Dllcall("imgui\GetFontSize")
		Return result
	}
	static GetFontTexUvWhitePixel()
	{
		return this.RecvImVec2("none:cdecl", "GetFontTexUvWhitePixel")
	}
	
	
	static GetColorU32(idx, alpha_mul := 1)
	{
		result := Dllcall("imgui\GetColorU32", "int", idx, "float", alpha_mul)
		Return result
	}
	static PushItemWidth(item_width)
	{
		Dllcall("imgui\PushItemWidth", "float", item_width)
	}
	static PopItemWidth()
	{
		Dllcall("imgui\PopItemWidth")
	}
	static SetNextItemWidth(item_width)
	{
		Dllcall("imgui\SetNextItemWidth", "float", item_width)
	}
	static CalcItemWidth()
	{
		result := Dllcall("imgui\CalcItemWidth")
		Return result
	}
	static PushTextWrapPos(wrap_pos_x := 0)
	{
		Dllcall("imgui\PushTextWrapPos", "float", wrap_pos_x)
	}
	static PopTextWrapPos()
	{
		Dllcall("imgui\PopTextWrapPos")
	}
	static PushAllowKeyboardFocus(allow_keyboard_focus)
	{
		Dllcall("imgui\PushAllowKeyboardFocus", "int", allow_keyboard_focus)
	}
	static PopAllowKeyboardFocus()
	{
		Dllcall("imgui\PopAllowKeyboardFocus")
	}
	static PushButtonRepeat(repeat)
	{
		Dllcall("imgui\PushButtonRepeat", "int", repeat)
	}
	static PopButtonRepeat()
	{
		Dllcall("imgui\PopButtonRepeat")
	}
	static Separator()
	{
		Dllcall("imgui\Separator")
	}
	static SameLine(offset_from_start_x := 0, spacing_w := -1)
	{
		Dllcall("imgui\SameLine", "float", offset_from_start_x, "float", spacing_w)
	}
	static NewLine()
	{
		Dllcall("imgui\NewLine")
	}
	static Spacing()
	{
		Dllcall("imgui\Spacing")
	}
	static Dummy(size_x, size_y)
	{
		Dllcall("imgui\Dummy", "float", size_x, "float", size_y)
	}
	static Indent(indent_w := 0)
	{
		Dllcall("imgui\Indent", "float", indent_w)
	}
	static Unindent(indent_w := 0)
	{
		Dllcall("imgui\Unindent", "float", indent_w)
	}
	static BeginGroup()
	{
		Dllcall("imgui\BeginGroup")
	}
	static EndGroup()
	{
		Dllcall("imgui\EndGroup")
	}
	static GetCursorPos()
	{
		return this.RecvImVec2("none:cdecl", "GetCursorPosition")
	}
	static SetCursorPos(local_pos_x, local_pos_y)
	{
		Dllcall("imgui\SetCursorPosition", "float", local_pos_x, "float", local_pos_y)
	}
	static GetCursorPosX()
	{
		result := Dllcall("imgui\GetCursorPosX")
		Return result
	}
	static GetCursorPosY()
	{
		result := Dllcall("imgui\GetCursorPosY")
		Return result
	}
	static SetCursorPosX(x)
	{
		Dllcall("imgui\SetCursorPosX", "float", x)
	}
	static SetCursorPosY(y)
	{
		Dllcall("imgui\SetCursorPosY", "float", y)
	}
	static GetCursorStartPos()
	{
		return this.RecvImVec2("none:cdecl", "GetCursorStartPos")
	}
	static GetCursorScreenPos()
	{
		return this.RecvImVec2("none:cdecl", "GetCursorScreenPos")
	}
	static SetCursorScreenPos(pos_x, pos_y)
	{
		Dllcall("imgui\SetCursorScreenPos", "float", pos_x, "float", pos_y)
	}
	static AlignTextToFramePadding()
	{
		Dllcall("imgui\AlignTextToFramePadding")
	}
	static GetTextLineHeight()
	{
		result := Dllcall("imgui\GetTextLineHeight")
		Return result
	}
	static GetTextLineHeightWithSpacing()
	{
		result := Dllcall("imgui\GetTextLineHeightWithSpacing")
		Return result
	}
	static GetFrameHeight()
	{
		result := Dllcall("imgui\GetFrameHeight")
		Return result
	}
	static GetFrameHeightWithSpacing()
	{
		result := Dllcall("imgui\GetFrameHeightWithSpacing")
		Return result
	}
	static PushID(str_id)
	{
		Dllcall("imgui\PushID", "wstr", str_id)
	}
	static PopID()
	{
		Dllcall("imgui\PopID")
	}
	static GetID(str_id)
	{
		result := Dllcall("imgui\GetID", "wstr", str_id)
		Return result
	}
	
	static Text(text)
	{
		Dllcall("imgui\Text", "wstr", text)
	}
	
	static TextColored(text, color := 0xFFFFFFFF)
	{
		Dllcall("imgui\TextColored", "uint", color, "wstr", text)
	}
	static TextDisabled(text)
	{
		Dllcall("imgui\TextDisabled", "wstr", text)
	}
	static TextWrapped(text)
	{
		Dllcall("imgui\TextWrapped", "wstr", text)
	}
	static LabelText(label, text)
	{
		Dllcall("imgui\LabelText", "wstr", label, "wstr", text)
	}
	
	static BulletText(text)
	{
		Dllcall("imgui\BulletText", "wstr", text)
	}
	static Button(text, w := 0, h := 0)
	{
		result := DllCall("imgui\Button", "wstr", text, "float", w, "float", h)
		return result
	}
	
	static SmallButton(label)
	{
		result := Dllcall("imgui\SmallButton", "wstr", label)
		Return result
	}
	static InvisibleButton(str_id, size_x, size_y)
	{
		result := Dllcall("imgui\InvisibleButton", "wstr", str_id, "float", size_x, "float", size_y)
		Return result
	}
	;ImGuiDir_Up
	static ArrowButton(str_id, dir := 2)
	{
		result := DllCall("imgui\ArrowButton", "wstr", str_id, "int", dir)
		Return result
	}
	static Image(user_texture_id, size_x, size_y, uv0_x := 0, uv0_y := 0, uv1_x := 1, uv1_y := 1, tint_col := 0xFFFFFFFF, border_col := 0)
	{
		Dllcall("imgui\Image", "int", user_texture_id, "float", size_x, "float", size_y, "float", uv0_x, "float", uv0_y, "float", uv1_x, "float", uv1_y, "uint", tint_col, "uint", border_col)
	}
	
	static ImageButton(user_texture_id, size_x, size_y, uv0_x := 0, uv0_y := 0, uv1_x := 1, uv1_y := 1, frame_padding := -1, bg_col := 0, tint_col := 0xFFFFFFFF)
	{
		result := DllCall("imgui\ImageButton", "int", user_texture_id, "float", size_x, "float", size_y, "float", uv0_x, "float", uv0_y, "float", uv1_x, "float", uv1_y, "int", frame_padding, "uint", bg_col, "uint", tint_col)
		return result
	}
	static CheckBox(text, &active)
	{
		b_active := buffer(4, 0)
		NumPut("Int", active, b_active)
		result := DllCall("imgui\Checkbox", "wstr", text, "ptr", b_active)
		active := NumGet(b_active, 0, "Int")
		return result
	}
	
	static CheckboxFlags(label, &flags, flags_value)
	{
		struct_flags := buffer(4, 0)
		NumPut("UInt", flags, struct_flags)
		result := Dllcall("imgui\CheckboxFlags", "wstr", label, "ptr", struct_flags, "uint", flags_value)
		flags := Numget(struct_flags, 0, "uint")
		Return result
	}
	static RadioButton(label, &v, v_button)
	{
		struct_v := buffer(4, 0)
		NumPut("Int", v, struct_v)
		result := DllCall("imgui\RadioButton", "wstr", label, "ptr", struct_v, "int", v_button)
		v := NumGet(struct_v, 0, "Int")
		return result
	}
	
	static ProgressBar(fraction, size_arg_x := -1, size_arg_y := 0, overlay := "")
	{
		Dllcall("imgui\ProgressBar", "float", fraction, "float", size_arg_x, "float", size_arg_y, "wstr", overlay)
	}
	static Bullet()
	{
		Dllcall("imgui\Bullet")
	}
	;flags := ImGuiComboFlags_None
	static BeginCombo(label, preview_value, flags := 0)
	{
		result := Dllcall("imgui\BeginCombo", "wstr", label, "wstr", preview_value, "int", flags)
		Return result
	}
	static EndCombo()
	{
		Dllcall("imgui\EndCombo")
	}
	
	
	static SetStyleColor(index, color := 0xFFFFFFFF)
	{
		Dllcall("imgui\SetStyleColor", "int", index, "uint", color)
	}
	;flags := ImGuiSelectableFlags_None
	static Selectable(label, selected := False, flags := 0, size_arg_x := 0, size_arg_y := 0)
	{
		result := Dllcall("imgui\Selectable", "wstr", label, "int", selected, "int", flags, "float", size_arg_x, "float", size_arg_y)
		Return result
	}
	static Columns(columns_count := 1, id := "", border := true)
	{
		Dllcall("imgui\Columns", "int", columns_count, "wstr", id, "int", border)
	}
	static NextColumn()
	{
		Dllcall("imgui\NextColumn")
	}
	static GetColumnIndex()
	{
		result := Dllcall("imgui\GetColumnIndex")
		Return result
	}
	static GetColumnWidth(column_index := -1)
	{
		result := Dllcall("imgui\GetColumnWidth", "int", column_index)
		Return result
	}
	static SetColumnWidth(column_index, width)
	{
		Dllcall("imgui\SetColumnWidth", "int", column_index, "float", width)
	}
	static GetColumnOffset(column_index := -1)
	{
		result := Dllcall("imgui\GetColumnOffset", "int", column_index)
		Return result
	}
	static SetColumnOffset(column_index, offset)
	{
		Dllcall("imgui\SetColumnOffset", "int", column_index, "float", offset)
	}
	static GetColumnsCount()
	{
		result := Dllcall("imgui\GetColumnsCount")
		Return result
	}
	static DragFloat(label, &v, v_speed := 1, v_min := 0, v_max := 0, format := "%3.f", power := 1)
	{
		struct_v := buffer(4, 0)
		numput("float", v, struct_v)
		result := Dllcall("imgui\DragFloat", "wstr", label, "ptr", struct_v, "float", v_speed, "float", v_min, "float", v_max, "wstr", format, "float", power)
		v := numget(struct_v, 0, "float")
		Return result
	}
	static DragFloat2(label, v, v_speed := 1, v_min := 0, v_max := 0, format := "%.3f", power := 1)
	{
		return this.DragFloatN(2, label, v, v_speed, v_min, v_max, format, power)
	}
	static DragFloat3(label, v, v_speed := 1, v_min := 0, v_max := 0, format := "%.3f", power := 1)
	{
		return this.DragFloatN(3, label, v, v_speed, v_min, v_max, format, power)
	}
	static DragFloat4(label, v, v_speed := 1, v_min := 0, v_max := 0, format := "%.3f", power := 1)
	{
		return this.DragFloatN(4, label, v, v_speed, v_min, v_max, format, power)
	}
	
	DragFloatN(n, label, &v, v_speed, v_min, v_max, format, power)
	{
		if(n < 2 || n > 4 || v.Length < n)
			return false
		struct_value := buffer(4 * n, 0)
		loop(n)
			numput("float", v[A_Index], struct_value, (a_index -1) * 4)
		result := Dllcall("imgui\DragFloatN"
		"int", n
		"wstr", label
		"ptr", struct_value
		"float", v_speed
		"float", v_min
		"float", v_max
		"wstr", format
		"float", power
		)
		loop(n)
			v[A_Index] := numget(struct_value, (a_index - 1) * 4, "float")
		Return result
	}
	
	
	static DragFloatRange2(label, &v_current_min, &v_current_max, v_speed := 1, v_min := 0, v_max := 0, format := "%.3f", format_max := "", power := 1)
	{
		struct_v_current_min := buffer(4, 0)
		numput("float", v_current_min, struct_v_current_min)
		struct_v_current_max := buffer(4, 0)
		numput("float", v_current_max, struct_v_current_max)
		result := Dllcall("imgui\DragFloatRange2", "wstr", label, "ptr", struct_v_current_min, "ptr", struct_v_current_max, "float", v_speed, "float", v_min, "float", v_max, "wstr", format, "wstr", format_max, "float", power)
		v_current_min := numget(struct_v_current_min, 0, "float")
		v_current_max := numget(struct_v_current_max, 0, "float")
		Return result
	}
	
	static DragInt(label, &v, v_speed := 1, v_min := 0, v_max := 0, format := "%d")
	{
		struct_v := buffer(4, 0)
		numput("int", v, struct_v)
		result := Dllcall("imgui\DragInt", "wstr", label, "ptr", struct_v, "float", v_speed, "int", v_min, "int", v_max, "wstr", format)
		v := numget(struct_v, 0, "int")
		Return result
	}
	static DragInt2(label, &v, v_speed := 1, v_min := 0, v_max := 0, format :="%d")
	{
		this.DragIntN(2, label, v, v_speed, v_min, v_max, format)
	}
	static DragInt3(label, &v, v_speed := 1, v_min := 0, v_max := 0, format :="%d")
	{
		this.DragIntN(3, label, v, v_speed, v_min, v_max, format)
	}
	static DragInt4(label, &v, v_speed := 1, v_min := 0, v_max := 0, format :="%d")
	{
		this.DragIntN(4, label, v, v_speed, v_min, v_max, format)
	}
	DragIntN(n, label, &v, v_speed, v_min, v_max, format)
	{
		if(n < 2 || n > 4 || v.Length < n)
			return false
		struct_value := buffer(4 * n, 0)
		loop(n)
			numput("int", v[A_Index], struct_value, (a_index -1) * 4)
		result := Dllcall("imgui\DragIntN",
		"int", n,
		"wstr", label,
		"ptr", struct_value,
		"float", v_speed,
		"int", v_min,
		"int", v_max,
		"wstr", format
		)
		loop(n)
			v[A_Index] := numget(struct_value, (a_index - 1) * 4, "int")
		Return result
	}
	
	static DragIntRange2(label, &v_current_min, &v_current_max, v_speed := 1, v_min := 0, v_max := 0, format := "%.3f", format_max := "")
	{
		struct_v_current_min := buffer(4, 0)
		numput("int", v_current_min, struct_v_current_min)
		struct_v_current_max := buffer(4, 0)
		numput("int", v_current_max, struct_v_current_max)
		result := Dllcall("imgui\DragIntRange2", "wstr", label, "ptr", struct_v_current_min, "ptr", struct_v_current_max, "float", v_speed, "int", v_min, "int", v_max, "wstr", format, "wstr", format_max)
		v_current_min := numget(struct_v_current_min, 0, "int")
		v_current_max := numget(struct_v_current_max, 0, "int")
		Return result
	}
	
	static SliderFloat(text, &value, v_min, v_max, format := "%.3f", power := 1)
	{
		struct := buffer(4, 0)
		numput("float", value, struct)
		result := Dllcall("imgui\SliderFloat", "wstr", text, "ptr", struct, "float", v_min, "float", v_max, "wstr", format, "float", power)
		value := numget(struct, 0, "float")
		Return result
	}
	
	
	static SliderFloat2(label, &v, v_min, v_max, format := "%.3f", power := 1)
	{
		this.SliderFloatN(2, label, v, v_min, v_max, format, power)
	}
	static SliderFloat3(label, &v, v_min, v_max, format := "%.3f", power := 1)
	{
		this.SliderFloatN(3, label, v, v_min, v_max, format, power)
	}
	static SliderFloat4(label, &v, v_min, v_max, format := "%.3f", power := 1)
	{
		this.SliderFloatN(4, label, v, v_min, v_max, format, power)
	}
	
	SliderFloatN(n, label, &v, v_min, v_max, format, power)
	{
		if(n < 2 || n > 4 || v.Length < n)
			return false
		struct_value := buffer(4 * n, 0)
		loop(n)
			numput("float", v[A_Index], struct_value, (a_index -1) * 4)
		result := Dllcall("imgui\SliderFloatN",
		"int", n,
		"wstr", label,
		"ptr", struct_value,
		"float", v_min,
		"float", v_max,
		"wstr", format,
		"float", power
		)
		loop(n)
			v[A_Index] := numget(struct_value, (a_index - 1) * 4, "float")
		Return result
	}
	
	static SliderInt(label, &v, v_min, v_max, format := "%d")
	{
		struct := buffer(4, 0)
		numput("int", v, struct)
		result := Dllcall("imgui\SliderInt", "wstr", label, "ptr", struct, "int", v_min, "int", v_max, "wstr", format)
		v := numget(struct, 0, "int")
		Return result
	}
	
	static SliderInt2(label, &v, v_min, v_max, format := "%d")
	{
		this.SliderIntN(2, label, v, v_min, v_max, format)
	}
	static SliderInt3(label, &v, v_min, v_max, format := "%d")
	{
		this.SliderIntN(3, label, v, v_min, v_max, format)
	}
	static SliderInt4(label, &v, v_min, v_max, format := "%d")
	{
		this.SliderIntN(4, label, v, v_min, v_max, format)
	}
	
	SliderIntN(n, label, &v, v_min, v_max, format)
	{
		if(n < 2 || n > 4 || v.Length < n)
			return false
		struct_value := buffer(4 * n, 0)
		loop(n)
			numput("int", v[A_Index], struct_value, (a_index -1) * 4)
		result := Dllcall("imgui\SliderIntN",
		"int", n,
		"wstr", label,
		"ptr",struct_value,
		"int", v_min,
		"int", v_max,
		"wstr", format
		)
		loop(n)
			v[A_Index] := numget(struct_value, (a_index - 1) * 4, "int")
		Return result
	}
	
	static SliderAngle(label, &v_rad, v_degrees_min := -360, v_degrees_max := 360, format := "%.0f deg")
	{
		struct_v_rad := buffer(4, 0)
		numput("float", v_rad, struct_v_rad)
		result := Dllcall("imgui\SliderAngle", "wstr", label, "ptr", struct_v_rad, "float", v_degrees_min, "float", v_degrees_max, "wstr", format)
		v_rad := numget(struct_v_rad, 0, "float")
		Return result
	}
	static VSliderFloat(label, size_x, size_y, &v, v_min, v_max, format := "%.3f", power := 1)
	{
		struct_v := buffer(4, 0)
		numput("float", v, struct_v)
		result := Dllcall("imgui\VSliderFloat", "wstr", label, "float", size_x, "float", size_y, "ptr", struct_v, "float", v_min, "float", v_max, "wstr", format, "float", power)
		v := numget(struct_v, 0, "float")
		Return result
	}
	
	static VSliderInt(label, size_x, size_y, &v, v_min, v_max, format := "%d")
	{
		struct_v := buffer(4, 0)
		numput("int", v, struct_v)
		result := Dllcall("imgui\VSliderInt", "wstr", label, "float", size_x, "float", size_y, "ptr", struct_v, "int", v_min, "int", v_max, "wstr", format)
		v := numget(struct_v, 0, "int")
		Return result
	}
	;flags := ImGuiInputTextFlags_None := 0
	static InputText(label, &buf, flags := 0, buf_size := 128000, call_back := 0)
	{
		struct_buf := Buffer(buf_size, 0)
		StrPut(buf, struct_buf)
		result := Dllcall("imgui\InputText", "wstr", label, "ptr", struct_buf, "int", buf_size, "int", flags, "ptr", call_back, "ptr", 0)
		buf := StrGet(struct_buf, 10240)
		Return result
	}
	
	static InputTextMultiline(label, &buf, size_x := 0, size_y := 0, flags := 0, buf_size := 128000)
	{
		struct_buf := Buffer(buf_size, 0)
		StrPut(buf, struct_buf)
		result := Dllcall("imgui\InputTextMultiline", "wstr", label, "ptr", struct_buf, "int", buf_size, "float", size_x, "float", size_y, "int", flags, "ptr", 0, "ptr", 0)
		buf := StrGet(struct_buf, 10240)
		Return result
	}
	
	static InputTextWithHint(label, hint, &buf, flags := 0, buf_size := 128000)
	{
		struct_buf := Buffer(buf_size, 0)
		StrPut(buf, struct_buf)
		result := DllCall("imgui\InputTextWithHint", "wstr", label, "wstr", hint, "ptr", struct_buf, "int", buf_size, "int", flags)
		buf := StrGet(struct_buf, 10240)
	}
	
	
	static InputFloat(label, &v, step := 0, step_fast := 0, format := "%.3f", flags := 0)
	{
		struct_v := buffer(4, 0)
		numput("float", v, struct_v)
		result := Dllcall("imgui\InputFloat", "wstr", label, "ptr", struct_v, "float", step, "float", step_fast, "wstr", format, "int", flags)
		v := numget(struct_v, 0, "float")
		Return result
	}
	
	static InputFloat2(label, &v, format := "%.3f", flags := 0)
	{
		this.InputFloatN(2, label, v, format, flags)
	}
	static InputFloat3(label, &v, format := "%.3f", flags := 0)
	{
		this.InputFloatN(3, label, v, format, flags)
	}
	static InputFloat4(label, &v, format := "%.3f", flags := 0)
	{
		this.InputFloatN(4, label, v, format, flags)
	}
	InputFloatN(n, label, &v, format, flags)
	{
		if(n < 2 || n > 4 || v.Length < n)
			return false
		struct_value := buffer(4 * n, 0)
		loop(n)
			numput("float", v[A_Index], struct_value, (a_index -1) * 4)
		result := Dllcall("imgui\InputFloatN",
		"int", n,
		"wstr", label,
		"ptr", struct_value,
		"wstr", format,
		"int", flags
		)
		loop(n)
			v[A_Index] := numget(struct_value, (a_index - 1) * 4, "float")
		Return result
	}
	
	;flags := ImGuiInputTextFlags_None := 0
	static InputInt(label, &v, step := 1, step_fast := 100, flags := 0)
	{
		struct_v := buffer(4, 0)
		numput("int", v, struct_v)
		result := Dllcall("imgui\InputInt", "wstr", label, "ptr", struct_v, "int", step, "int", step_fast, "int", flags)
		v := numget(struct_v, 0, "int")
		Return result
	}
	
	static InputInt2(label, &v, flags := 0)
	{
		this.InputIntN(2, label, v, flags := 0)
	}
	static InputInt3(label, &v, flags := 0)
	{
		this.InputIntN(3, label, v, flags := 0)
	}
	static InputInt4(label, &v, flags := 0)
	{
		this.InputIntN(4, label, v, flags)
	}
	
	InputIntN(n, label, &v, flags)
	{
		if(n < 2 || n > 4 || v.Length < n)
			return false
		struct_value := buffer(4 * n, 0)
		loop(n)
			numput("int", v[A_Index], struct_value, (a_index -1) * 4)
		result := Dllcall("imgui\InputIntN",
		"int", n,
		"wstr", label,
		"ptr", struct_value,
		"int", flags
		)
		loop(n)
			v[A_Index] := numget(struct_value, (a_index - 1) * 4, "int")
		Return result
	}
	static InputDouble(label, &v, step := 0, step_fast := 0, format := "%.6f", flags := 0)
	{
		struct_v := buffer(8, 0)
		numput("double", v, struct_v)
		result := Dllcall("imgui\InputDouble", "wstr", label, "ptr", struct_v, "double", step, "double", step_fast, "wstr", format, "int", flags)
		v := numget(struct_v, 0, "double")
		Return result
	}
	;flags := ImGuiColorEditFlags_None 0
	static ColorEdit(label, &color, flags := 0)
	{
		struct_v := buffer(4, 0)
		numput("uint", color, struct_v)
		result := Dllcall("imgui\ColorEdit", "wstr", label, "ptr", struct_v, "int", flags)
		color := numget(struct_v, 0, "uint")
		Return result
	}
	static ColorPicker(label, &color, flags := 0)
	{
		struct_v := buffer(4, 0)
		numput("uint", color, struct_v)
		result := Dllcall("imgui\ColorPicker", "wstr", label, "ptr", struct_v, "int", flags)
		color := numget(struct_v, 0, "uint")
		Return result
	}
	static TreeNode(label)
	{
		result := Dllcall("imgui\TreeNode", "wstr", label)
		Return result
	}
	;flags := ImGuiTreeNodeFlags_None 0
	static TreeNodeEx(label, flags := 0)
	{
		result := Dllcall("imgui\TreeNodeEx", "wstr", label, "int", flags)
		Return result
	}
	static TreePush(str_id)
	{
		Dllcall("imgui\TreePush", "wstr", str_id)
	}
	static TreePop()
	{
		Dllcall("imgui\TreePop")
	}
	static GetTreeNodeToLabelSpacing()
	{
		result := Dllcall("imgui\GetTreeNodeToLabelSpacing")
		Return result
	}
	static CollapsingHeader(label, flags := 0)
	{
		result := Dllcall("imgui\CollapsingHeader", "wstr", label, "int", flags)
		Return result
	}
	static CollapsingHeaderEx(label, &p_open, flags := 0)
	{
		struct_p_open := buffer(4, 0)
		numput("int", p_open, struct_p_open)
		result := Dllcall("imgui\CollapsingHeaderEx", "wstr", label, "ptr", struct_p_open, "int", flags)
		p_open := numget(struct_p_open, 0, "int")
		Return result
	}
	;cond := ImGuiCond_None 0
	static SetNextItemOpen(is_open, cond := 0)
	{
		Dllcall("imgui\SetNextItemOpen", "int", is_open, "int", cond)
	}
	;item string 数组
	; 返回包含字符串的缓冲对象.
	StrBuf(str, encoding)
	{
		; 计算所需的大小并分配缓冲.
		buf := Buffer(StrPut(str, encoding))
		; 复制或转换字符串.
		StrPut(str, buf, encoding)
		return buf
	}
	static ListBox(label, &current_item, items, height_items := -1)
	{
		if(Type(items) != "Array")
			return False
		items_count := items.Length
		
		struct_current_item := buffer(4, 0)
		numput("int", current_item, struct_current_item)
		
		struct_item_count := buffer(4 * (items_count + 1), 0)
		numput("int", items_count , struct_item_count)
		
		loop(items_count)
		{
			len := StrLen(items[a_index]) + 1
			NumPut("int", len, struct_item_count,  4 * a_index)
		}
		all_str := ""
		for k,v in items
			all_str .= v . chr(0)
		struct_item := this.StrBuf(all_str, "UTF-16")
		;strcut_current_item out 当前index
		;strcut_item 字符串数组 每个item包含的字符串
		;strcut_item_count int 数组
		;[0] 总个数,  [1]-[n] 每个的个数
		result := Dllcall("imgui\ListBox", "wstr", label, "ptr", struct_current_item, "ptr", struct_item, "ptr", struct_item_count, "int", height_items)
		current_item := NumGet(struct_current_item, 0, "Int")
		Return result
	}
	
	static ListBoxHeader(label, size_arg_x := 0, size_arg_y := 0)
	{
		result := Dllcall("imgui\ListBoxHeader", "wstr", label, "float", size_arg_x, "float", size_arg_y)
		Return result
	}
	static ListBoxHeaderEx(label, items_count, height_in_items := -1)
	{
		result := Dllcall("imgui\ListBoxHeaderEx", "wstr", label, "int", items_count, "int", height_in_items)
		Return result
	}
	static ListBoxFooter()
	{
		Dllcall("imgui\ListBoxFooter")
	}
	
	static PlotLines(label, values, values_offset := 0, overlay_text := "", scale_min := 3.402823466e+38, scale_max := 3.402823466e+38, graph_size_x := 0, graph_size_y := 0, stride := 4)
	{
		if(Type(values) != "Array")
			return False
		count := values.Length
		If values_offset >= count
			values_offset := Mod(values_offset, count)
		struct_values := buffer(4 * count)
		
		loop(count)
		{
			NumPut("float", values[a_index], struct_values, (a_index - 1) * 4)
		}
		DllCall("imgui\PlotLines", "wstr", label, "ptr", struct_values, "int",
		count, "int", values_offset, "wstr", overlay_text, "float", scale_min, "float", scale_max,
	    "float", graph_size_x, "float", graph_size_y, "int", stride)
	}
	;scale_min := FLT_MAX         				          :=  3.402823466e+38
	;scale_max := FLT_MAX
	static PlotHistogram(label, values, values_offset := 0, overlay_text := "", scale_min := 3.402823466e+38, scale_max := 3.402823466e+38, graph_size_x := 0, graph_size_y := 0, stride := 4)
	{
		if(Type(values) != "Array")
			return False
		count := values.Length
		if( values_offset >= count)
			values_offset := Mod(values_offset, count)
		struct_values := buffer(4 * count, 0)
		loop(count)
			numput("float", values[A_Index], struct_values, (a_index -1) * 4)
		Dllcall("imgui\PlotHistogram", "wstr", label, "ptr", struct_values, "int", count, "int", values_offset, "wstr", overlay_text, "float", scale_min, "float", scale_max, "float", graph_size_x, "float", graph_size_y, "int", stride)
	}
	
	static ValueBool(prefix, b)
	{
		Dllcall("imgui\ValueBool", "wstr", prefix, "int", b)
	}
	static ValueInt(prefix, v)
	{
		Dllcall("imgui\ValueInt", "wstr", prefix, "int", v)
	}
	static ValueFloat(prefix, v, float_format := "")
	{
		Dllcall("imgui\ValueFloat", "wstr", prefix, "float", v, "wstr", float_format)
	}
	
	static BeginMenuBar()
	{
		result := Dllcall("imgui\BeginMenuBar")
		Return result
	}
	static EndMenuBar()
	{
		Dllcall("imgui\EndMenuBar")
	}
	static BeginMainMenuBar()
	{
		result := Dllcall("imgui\BeginMainMenuBar")
		Return result
	}
	static EndMainMenuBar()
	{
		Dllcall("imgui\EndMainMenuBar")
	}
	static BeginMenu(label, enabled := True)
	{
		result := Dllcall("imgui\BeginMenu", "wstr", label, "int", enabled)
		Return result
	}
	static EndMenu()
	{
		Dllcall("imgui\EndMenu_")
	}
	static MenuItem(label, shortcut := "", selected := False, enabled := True)
	{
		result := Dllcall("imgui\MenuItem", "wstr", label, "wstr", shortcut, "int", selected, "int", enabled)
		Return result
	}
	
	
	static MenuItemEx(label, shortcut, &p_selected, enabled := True)
	{
		struct_p_selected := buffer(4, 0)
		numput("int", p_selected, struct_p_selected)
		result := Dllcall("imgui\MenuItemEx", "wstr", label, "wstr", shortcut, "ptr", struct_p_selected, "int", enabled)
		p_selected := numget(struct_p_selected, 0, "int")
		Return result
	}
	
	static ShowDemoWindow()
	{
		Dllcall("imgui\ShowDemoWindow")
	}
	static ToolTip(text)
	{
		this.BeginTooltip()
		this.Text(text)
		this.EndTooltip()
	}
	static BeginTooltip(){
		Dllcall("imgui\BeginTooltip")
	}
	static EndTooltip()
	{
		Dllcall("imgui\EndTooltip")
	}
	static SetTooltip(text)
	{
		Dllcall("imgui\SetTooltip", "wstr", text)
	}
	;flags := ImGuiWindowFlags_None
	static BeginPopup(str_id, flags := 0)
	{
		result := Dllcall("imgui\BeginPopup", "wstr", str_id, "int", flags)
		Return result
	}
	
	static BeginPopupModal(name, flags := 0)
	{
		
		result := Dllcall("imgui\BeginPopupModal", "wstr", name, "ptr", 0, "int", flags)
		Return result
	}
	
	static BeginPopupModalEx(name, &p_open, flags := 0)
	{
		struct_p_open := buffer(4, 0)
		numput("int", p_open, struct_p_open)
		result := Dllcall("imgui\BeginPopupModal", "wstr", name, "ptr", struct_p_open, "int", flags)
		p_open := numget(struct_p_open, 0, "int")
		Return result
	}
	
	static EndPopup()
	{
		Dllcall("imgui\EndPopup")
	}
	;popup_flags := ImGuiPopupFlags_MouseButtonLeft         :=  0
	static OpenPopup(str_id, popup_flags := 0)
	{
		Dllcall("imgui\OpenPopup", "wstr", str_id, "int", popup_flags)
	}
	static OpenPopupContextItem(str_id := "", popup_flags := 0)
	{
		result := Dllcall("imgui\OpenPopupContextItem", "wstr", str_id, "int", popup_flags)
		Return result
	}
	static CloseCurrentPopup()
	{
		Dllcall("imgui\CloseCurrentPopup")
	}
	static BeginPopupContextItem(str_id := "", popup_flags := 0)
	{
		result := Dllcall("imgui\BeginPopupContextItem", "wstr", str_id, "int", popup_flags)
		Return result
	}
	static BeginPopupContextWindow(str_id := "", popup_flags := 0)
	{
		result := Dllcall("imgui\BeginPopupContextWindow", "wstr", str_id, "int", popup_flags)
		Return result
	}
	static BeginPopupContextVoid(str_id := "", popup_flags := 0)
	{
		result := Dllcall("imgui\BeginPopupContextVoid", "wstr", str_id, "int", popup_flags)
		Return result
	}
	;popup_flags := ImGuiPopupFlags_None                    :=  0
	static IsPopupOpen(str_id, popup_flags := 0)
	{
		result := Dllcall("imgui\IsPopupOpen", "wstr", str_id, "int", popup_flags)
		Return result
	}
	;flags := ImGuiTabBarFlags_None                           :=  0
	static BeginTabBar(str_id, flags := 0){
		result := Dllcall("imgui\BeginTabBar", "wstr", str_id, "int", flags)
		Return result
	}
	static EndTabBar()
	{
		Dllcall("imgui\EndTabBar")
	}
	
	;flags := ImGuiTabItemFlags_None                          :=  0
	static BeginTabItemEx(label, &p_open, flags := 0)
	{
		struct_p_open := buffer(4, 0)
		numput("float", p_open, struct_p_open)
		result := Dllcall("imgui\BeginTabItem", "wstr", label, "ptr", struct_p_open, "int", flags)
		p_open := numget(struct_p_open, 0, "int")
		Return result
	}
	
	static BeginTabItem(label, flags := 0)
	{
		result := Dllcall("imgui\BeginTabItem", "wstr", label, "ptr", 0, "int", flags)
		Return result
	}
	
	static EndTabItem(){
		Dllcall("imgui\EndTabItem")
	}
	static SetTabItemClosed(label)
	{
		Dllcall("imgui\SetTabItemClosed", "wstr", label)
	}
	;flags := ImGuiDockNodeFlags_None                         :=  0
	static DockSpace(id, size_arg_x := 0, size_arg_y := 0, flags := 0)
	{
		Dllcall("imgui\DockSpace", "int", id, "float", size_arg_x, "float", size_arg_y, "int", flags)
	}
	;f
	static DockSpaceOverViewport(viewport := 0, dockspace_flags := 0)
	{
		result := Dllcall("imgui\DockSpaceOverViewport", "ptr", viewport, "int", dockspace_flags)
		Return result
	}
	;cond := ImGuiCond_None 0
	static SetNextWindowDockID(id, cond := 0)
	{
		Dllcall("imgui\SetNextWindowDockID", "int", id, "int", cond)
	}
	static SetNextWindowClass(window_class)
	{
		Dllcall("imgui\SetNextWindowClass", "ptr", window_class)
	}
	static GetWindowDockID()
	{
		result := Dllcall("imgui\GetWindowDockID")
		Return result
	}
	static IsWindowDocked()
	{
		result := Dllcall("imgui\IsWindowDocked")
		Return result
	}
	;flags := ImGuiDragDropFlags_None                         :=  0
	static BeginDragDropSource(flags := 0)
	{
		result := Dllcall("imgui\BeginDragDropSource", "int", flags)
		Return result
	}
	static PushClipRect(clip_rect_min_x, clip_rect_min_y, clip_rect_max_x, clip_rect_max_y, intersect_with_current_clip_rect)
	{
		Dllcall("imgui\PushClipRect", "float", clip_rect_min_x, "float", clip_rect_min_y, "float", clip_rect_max_x, "float", clip_rect_max_y, "int", intersect_with_current_clip_rect)
	}
	static PopClipRect()
	{
		Dllcall("imgui\PopClipRect")
	}
	static SetItemDefaultFocus()
	{
		Dllcall("imgui\SetItemDefaultFocus")
	}
	static SetKeyboardFocusHere(offset := 0)
	{
		Dllcall("imgui\SetKeyboardFocusHere", "int", offset)
	}
	;flags := ImGuiHoveredFlags_None                          :=  0
	static IsItemHovered(flags := 0)
	{
		result := Dllcall("imgui\IsItemHovered", "int", flags)
		Return result
	}
	static IsItemActive()
	{
		result := Dllcall("imgui\IsItemActive")
		Return result
	}
	static IsItemFocused()
	{
		result := Dllcall("imgui\IsItemFocused")
		Return result
	}
	static IsItemVisible()
	{
		result := Dllcall("imgui\IsItemVisible")
		Return result
	}
	static IsItemEdited()
	{
		result := Dllcall("imgui\IsItemEdited")
		Return result
	}
	static IsItemActivated()
	{
		result := Dllcall("imgui\IsItemActivated")
		Return result
	}
	static IsItemDeactivated()
	{
		result := Dllcall("imgui\IsItemDeactivated")
		Return result
	}
	static IsItemDeactivatedAfterEdit()
	{
		result := Dllcall("imgui\IsItemDeactivatedAfterEdit")
		Return result
	}
	static IsItemToggledOpen()
	{
		result := Dllcall("imgui\IsItemToggledOpen")
		Return result
	}
	static IsAnyItemHovered()
	{
		result := Dllcall("imgui\IsAnyItemHovered")
		Return result
	}
	static IsAnyItemActive()
	{
		result := Dllcall("imgui\IsAnyItemActive")
		Return result
	}
	static IsAnyItemFocused()
	{
		result := Dllcall("imgui\IsAnyItemFocused")
		Return result
	}
	static SetItemAllowOverlap()
	{
		Dllcall("imgui\SetItemAllowOverlap")
	}
	;mouse_button := ImGuiMouseButton_Left
	static IsItemClicked(mouse_button := 0)
	{
		result := Dllcall("imgui\IsItemClicked", "int", mouse_button)
		Return result
	}
	static IsRectVisible(size_x, size_y)
	{
		result := Dllcall("imgui\IsRectVisible", "float", size_x, "float", size_y)
		Return result
	}
	static IsRectVisibleEx(rect_min_x, rect_min_y, rect_max_x, rect_max_y)
	{
		result := Dllcall("imgui\IsRectVisibleEx", "float", rect_min_x, "float", rect_min_y, "float", rect_max_x, "float", rect_max_y)
		Return result
	}
	static GetTime()
	{
		result := Dllcall("imgui\GetTime")
		Return result
	}
	static GetFrameCount()
	{
		result := Dllcall("imgui\GetFrameCount")
		Return result
	}
	;flags := ImGuiWindowFlags_None
	static BeginChildFrame(id, size_x, size_y, extra_flags := 0)
	{
		result := Dllcall("imgui\BeginChildFrame", "int", id, "float", size_x, "float", size_y, "int", extra_flags)
		Return result
	}
	static EndChildFrame()
	{
		Dllcall("imgui\EndChildFrame")
	}
	static CalcTextSize(text, hide_text_after_double_hash := false, wrap_width := -1)
	{
		struct_x := buffer(4, 0)
		struct_y := buffer(4, 0)
		result := Dllcall("imgui\CalcTextSize", "wstr", text, "int", hide_text_after_double_hash, "float", wrap_width, "ptr", struct_x, "ptr", struct_y)
		ret := [NumGet(struct_x, 0, "float"), NumGet(struct_y, 0, "float")]
		Return ret
	}
	
	static GetKeyIndex(key)
	{
		result := Dllcall("imgui\GetKeyIndex", "int", key)
		Return result
	}
	static IsKeyDown(user_key_index)
	{
		result := Dllcall("imgui\IsKeyDown", "int", user_key_index)
		Return result
	}
	static IsKeyPressed(user_key_index, repeat := true)
	{
		result := Dllcall("imgui\IsKeyPressed", "int", user_key_index, "int", repeat)
		Return result
	}
	static IsKeyReleased(user_key_index)
	{
		result := Dllcall("imgui\IsKeyReleased", "int", user_key_index)
		Return result
	}
	static GetKeyPressedAmount(key_index, repeat_delay, repeat_rate)
	{
		result := Dllcall("imgui\GetKeyPressedAmount", "int", key_index, "float", repeat_delay, "float", repeat_rate)
		Return result
	}
	static CaptureKeyboardFromApp(capture)
	{
		Dllcall("imgui\CaptureKeyboardFromApp", "int", capture)
	}
	;mouse_button := ImGuiMouseButton_Left
	static IsMouseDown(button := 0)
	{
		result := Dllcall("imgui\IsMouseDown", "int", button)
		Return result
	}
	static IsMouseClicked(button := 0, repeat := False)
	{
		result := Dllcall("imgui\IsMouseClicked", "int", button, "int", repeat)
		Return result
	}
	static IsMouseReleased(button := 0)
	{
		result := Dllcall("imgui\IsMouseReleased", "int", button)
		Return result
	}
	static IsMouseHoveringRect(r_min_x, r_min_y, r_max_x, r_max_y, clip := True)
	{
		result := Dllcall("imgui\IsMouseHoveringRect", "float", r_min_x, "float", r_min_y, "float", r_max_x, "float", r_max_y, "int", clip)
		Return result
	}
	static IsMousePosValid()
	{
		result := Dllcall("imgui\IsMousePosValid")
		Return result
	}
	static IsAnyMouseDown()
	{
		result := Dllcall("imgui\IsAnyMouseDown")
		Return result
	}
	static IsMouseDragging(button := 0, lock_threshold := -1)
	{
		result := Dllcall("imgui\IsMouseDragging", "int", button, "float", lock_threshold)
		Return result
	}
	static ResetMouseDragDelta(button := 0)
	{
		Dllcall("imgui\ResetMouseDragDelta", "int", button)
	}
	static GetMouseCursor()
	{
		result := Dllcall("imgui\GetMouseCursor")
		Return result
	}
	;cursor_type := ImGuiMouseCursor_Arrow :=  0
	static SetMouseCursor(cursor_type := 0)
	{
		Dllcall("imgui\SetMouseCursor", "int", cursor_type)
	}
	static CaptureMouseFromApp(capture)
	{
		Dllcall("imgui\CaptureMouseFromApp", "int", capture)
	}
	static LoadIniSettingsFromDisk(ini_filename)
	{
		Dllcall("imgui\LoadIniSettingsFromDisk", "wstr", ini_filename)
	}
	static SaveIniSettingsToDisk(ini_filename)
	{
		Dllcall("imgui\SaveIniSettingsToDisk", "wstr", ini_filename)
	}
	static GetMainViewport()
	{
		result := Dllcall("imgui\GetMainViewport")
		return result
	}
	static UpdatePlatformWindows()
	{
		Dllcall("imgui\UpdatePlatformWindows")
	}
	static RenderPlatformWindowsDefault(platform_render_arg, renderer_render_arg)
	{
		Dllcall("imgui\RenderPlatformWindowsDefault", "ptr", platform_render_arg, "ptr", renderer_render_arg)
	}
	static DestroyPlatformWindows()
	{
		Dllcall("imgui\DestroyPlatformWindows")
	}
	
	
	; ========================================================================================================================================== ImDraw
	
	_ImDraw_SetOffset(x, y)
	{
		ImDraw_offset_x := x
		ImDraw_offset_y := y
	}
	
	_ImDraw_SetDrawList(draw_list)
	{
		ImDrawList_ptr := draw_list
	}
	_ImDraw_GetDrawList()
	{
		Return ImDrawList_ptr
	}
	_ImDraw_AddLine(p1_x, p1_y, p2_x, p2_y, col := 0xFFFFFFFF, thickness := 1)
	{
		Dllcall("imgui\AddLine", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "uint", col, "float", thickness)
	}
	
	;rounding_corners := ImDrawCornerFlags_All       :=  0xF
	_ImDraw_AddRect(x, y, w, h, col := 0xFFFFFFFF, rounding := 0, rounding_corners := 0xF, thickness := 1)
	{
		Dllcall("imgui\AddRect",  "ptr", ImDrawList_ptr, "float", x, "float", y, "float", x+w, "float", y+h, "uint", col, "float", rounding, "int", rounding_corners, "float", thickness)
	}
	;rounding_corners := ImDrawCornerFlags_All       :=  0xF
	_ImDraw_AddRectFilled( x, y, w, h, col := 0xFFFFFFFF, rounding := 0, rounding_corners := 0xF)
	{
		Dllcall("imgui\AddRectFilled", "ptr", ImDrawList_ptr, "float", x, "float", y, "float", x+w, "float", y+h, "uint", col, "float", rounding, "int", rounding_corners)
	}
	_ImDraw_AddBezierCurve(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, col := 0xFFFFFFFF, thickness := 1, num_segments := 30)
	{
		Dllcall("imgui\AddBezierCurve", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "uint", col, "float", thickness, "int", num_segments)
	}
	_ImDraw_AddCircle(center_x, center_y, radius, col := 0xFFFFFFFF, num_segments := 30, thickness := 1)
	{
		Dllcall("imgui\AddCircle", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "uint", col, "int", num_segments, "float", thickness)
	}
	_ImDraw_AddCircleFilled(center_x, center_y, radius, col := 0xFFFFFFFF, num_segments := 0)
	{
		if(!IsSet(p))
			num_segments := radius /3 + 10
		if(ImGuiTreeNodeFlags_DefaultOpen)
			Dllcall("imgui\AddCircleFilled", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "uint", col, "int", num_segments)
	}
	
	
	_ImDraw_AddConvexPolyFilled(points, col := 0xFFFFFFFF)
	{
		if(Type(points) != "Array")
			return false
		
		points_count := points.Length
		struct_points := buffer(4 * points_count * 2, 0)
		loop(points_count)
		{
			NumPut("float", points[A_Index][0], 2 * 4 * A_Index)
			NumPut("float", points[A_Index][1], 2 * 4 * A_Index + 1)
		}
		Dllcall("imgui\AddConvexPolyFilled", "ptr", ImDrawList_ptr, "ptr", struct_points, "int", points_count, "uint", col)
	}
	
	_ImDraw_AddImage(user_texture_id, p_min_x, p_min_y, p_max_x, p_max_y, uv_min_x := 0, uv_min_y := 0, uv_max_x := 1, uv_max_y := 1, col := 0xFFFFFFFF)
	{
		Dllcall("imgui\AddImage", "ptr", ImDrawList_ptr, "int", user_texture_id, "float", p_min_x, "float", p_min_y, "float", p_max_x, "float", p_max_y, "float", uv_min_x, "float", uv_min_y, "float", uv_max_x, "float", uv_max_y, "uint", col)
	}
	_ImDraw_AddImageQuad(user_texture_id, p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, uv1_x := 0, uv1_y := 0, uv2_x := 1, uv2_y := 0, uv3_x := 1, uv3_y := 1, uv4_x := 0, uv4_y := 1, col := 0xFFFFFFFF)
	{
		Dllcall("imgui\AddImageQuad", "ptr", ImDrawList_ptr, "int", user_texture_id, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "float", uv1_x, "float", uv1_y, "float", uv2_x, "float", uv2_y, "float", uv3_x, "float", uv3_y, "float", uv4_x, "float", uv4_y, "uint", col)
	}
	;rounding_corners := ImDrawCornerFlags_All       :=  0xF
	_ImDraw_AddImageRounded(user_texture_id, p_min_x, p_min_y, p_max_x, p_max_y, uv_min_x := 0, uv_min_y := 0, uv_max_x := 1, uv_max_y := 1, col := 0xFFFFFFFF, rounding := 5, rounding_corners := 0xF)
	{
		Dllcall("imgui\AddImageRounded", "ptr", ImDrawList_ptr, "int", user_texture_id, "float", p_min_x, "float", p_min_y, "float", p_max_x, "float", p_max_y, "float", uv_min_x, "float", uv_min_y, "float", uv_max_x, "float", uv_max_y, "uint", col, "float", rounding, "int", rounding_corners)
	}
	_ImDraw_AddNgon(center_x, center_y, radius, col := 0xFFFFFFFF, num_segments := 5, thickness := 1)
	{
		Dllcall("imgui\AddNgon", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "uint", col, "int", num_segments, "float", thickness)
	}
	_ImDraw_AddNgonFilled(center_x, center_y, radius, col := 0xFFFFFFFF, num_segments := 5)
	{
		Dllcall("imgui\AddNgonFilled", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "uint", col, "int", num_segments)
	}
	
	_ImDraw_AddPolyline(points, col := 0xFFFFFFFF, closed := True, thickness := 1)
	{
		if(Type(points) != "Array")
			return false
		points_count := points.Length
		struct_points := buffer(4 * points_count * 2, 0)
		loop(points_count)
		{
			NumPut("float", points[A_Index][0], 2 * 4 * A_Index)
			NumPut("float", points[A_Index][1], 2 * 4 * A_Index + 1)
		}
		Dllcall("imgui\AddPolyline", "ptr", ImDrawList_ptr, "ptr", struct_points, "int", points_count, "uint", col, "int", closed, "float", thickness)
	}
	
	ImDraw_AddQuad(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, col := 0xFFFFFFFF, thickness := 1)
	{
		Dllcall("imgui\AddQuad", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "uint", col, "float", thickness)
	}
	_ImDraw_AddQuadFilled(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, col := 0xFFFFFFFF)
	{
		Dllcall("imgui\AddQuadFilled", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "uint", col)
	}
	_ImDraw_AddRectFilledMultiColor(p_min_x, p_min_y, p_max_x, p_max_y, col_upr_left, col_upr_right, col_bot_right, col_bot_left)
	{
		Dllcall("imgui\AddRectFilledMultiColor", "ptr", ImDrawList_ptr, "float", p_min_x, "float", p_min_y, "float", p_max_x, "float", p_max_y, "uint", col_upr_left, "uint", col_upr_right, "uint", col_bot_right, "uint", col_bot_left)
	}
	_ImDraw_AddText(text, font, font_size, pos_x, pos_y, col := 0xFFFFFFFF, wrap_width := 0)
	{
		Dllcall("imgui\AddText", "ptr", ImDrawList_ptr, "ptr", font, "float", font_size, "float", pos_x, "float", pos_y, "uint", col, "wstr", text, "float", wrap_width)
	}
	_ImDraw_AddTriangle(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, col := 0xFFFFFFFF, thickness := 1)
	{
		Dllcall("imgui\AddTriangle", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "uint", col, "float", thickness)
	}
	_ImDraw_AddTriangleFilled(p1_x, p1_y, p2_x, p2_y, p3_x, p3_y, col := 0xFFFFFFFF)
	{
		Dllcall("imgui\AddTriangleFilled", "ptr", ImDrawList_ptr, "float", p1_x, "float", p1_y, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "uint", col)
	}
	_ImDraw_PathClear()
	{
		Dllcall("imgui\PathClear", "ptr", ImDrawList_ptr)
	}
	_ImDraw_PathLineTo(pos_x, pos_y)
	{
		Dllcall("imgui\PathLineTo", "ptr", ImDrawList_ptr, "float", pos_x, "float", pos_y)
	}
	_ImDraw_PathLineToMergeDuplicate(pos_x, pos_y)
	{
		Dllcall("imgui\PathLineToMergeDuplicate", "ptr", ImDrawList_ptr, "float", pos_x, "float", pos_y)
	}
	_ImDraw_PathFillConvex(col)
	{
		Dllcall("imgui\PathFillConvex", "ptr", ImDrawList_ptr, "uint", col)
	}
	_ImDraw_PathStroke(col, closed, thickness := 1)
	{
		Dllcall("imgui\PathStroke", "ptr", ImDrawList_ptr, "uint", col, "boolean", closed, "float", thickness)
	}
	_ImDraw_PathArcTo(center_x, center_y, radius, a_min_a, a_max, num_segments := 20)
	{
		Dllcall("imgui\PathArcTo", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "float", a_min, "float", a_max, "int", num_segments)
	}
	_ImDraw_PathArcToFast(center_x, center_y, radius, a_min_of_12, a_max_of_12)
	{
		Dllcall("imgui\PathArcToFast", "ptr", ImDrawList_ptr, "float", center_x, "float", center_y, "float", radius, "int", a_min_of_12, "int", a_max_of_12)
	}
	_ImDraw_PathBezierCurveTo(p2_x, p2_y, p3_x, p3_y, p4_x, p4_y, num_segments := 0)
	{
		Dllcall("imgui\PathBezierCurveTo", "ptr", ImDrawList_ptr, "float", p2_x, "float", p2_y, "float", p3_x, "float", p3_y, "float", p4_x, "float", p4_y, "int", num_segments)
	}
	;rounding_corners := ImDrawCornerFlags_All       :=  0xF
	_ImDraw_PathRect(rect_min_x, rect_min_y, rect_max_x, rect_max_y, rounding := 0, rounding_corners := 0xf)
	{
		Dllcall("imgui\PathRect", "ptr", ImDrawList_ptr, "float", rect_min_x, "float", rect_min_y, "float", rect_max_x, "float", rect_max_y, "float", rounding, "int", rounding_corners)
	}
	
	;rounding_corners := ImDrawCornerFlags_All       :=  0xF
	_ImDraw_AddImageFit(user_texture_id, pos_x, pos_y, size_x := 0, size_y := 0, crop_area := True, rounding := 0, tint_col := 0xFFFFFFFF, rounding_corners := 0xf)
	{
		Dllcall("imgui\AddImageFit",
	"ptr", ImDrawList_ptr,
	"ptr", user_texture_id,
	"float", pos_x,
	"float", pos_y,
	"float", size_x,
	"float", size_y,
	"boolean", crop_area,
	"float", rounding,
	"uint", tint_col,
	"int", rounding_corners)
	}
	;rounding_corners := ImDrawCornerFlags_All       :=  0xF
	static ImageFit(user_texture_id, size_x := 0, size_y := 0, crop_area := True, rounding := 0, tint_col := 0xFFFFFFFF, rounding_corners := 0xF)
	{
		DllCall("imgui\ImageFit",
	    "ptr", user_texture_id,
        "float", size_x,
        "float", size_y,
        "int", crop_area,
        "float", rounding,
        "uint", tint_col,
        "int", rounding_corners)
	}
	static ImageFromFile(file_path)
	{
		result := Dllcall("imgui\ImageFromFile", "wstr", file_path)
		Return result
	}
	static ImageFromURL(url)
	{
		result := Dllcall("imgui\ImageFromURL", "str", url)
		Return result
	}
	static ImageGetSize(user_texture_id)
	{
		if(user_texture_id == 0)
			return false
		struct_x := buffer(4, 0)
		struct_y := buffer(4, 0)
		result := Dllcall("imgui\ImageGetSize", "ptr", user_texture_id, "ptr", struct_x,"ptr", struct_y)
		ret := [NumGet(struct_x, 0, "float"), NumGet(struct_y, 0, "float")]
		Return ret
	}
	
	static LoadFont(font_path, font_size)
	{
		result := DllCall("imgui\LoadFont", "wstr", font_size, "float", font_size)
	}
}