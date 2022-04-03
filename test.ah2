CoordMode "Pixel", "Screen"
CoordMode "Mouse", "Screen"

#include <imgui>

Persistent
#UseHook
#MaxThreads 255
#MaxThreadsPerHotkey 99
#SingleInstance force
KeyHistory 0
ListLines False
SetKeyDelay -1, -1
SetMouseDelay -1
SetDefaultMouseSpeed 0
SetWinDelay -1
SetControlDelay -1


toggleGui:=0

showdemo:=0

main()

main()
{
	
	hwnd := GUICreate("cheat", 1, 1, -100, -100, 0, 0x80)
	;hwnd := GUICreate("AHK ImGui", 1000, 1000, 500, 500, 0, 0x80)
	WinShow(hwnd)
	;WinSetAlwaysOnTop( 1,hwnd)
	
	StyleColorsLight()
	
	io := GetIO()
	;NumPut("Int", true, io, 204) ;io.ConfigWindowsMoveFromTitleBarOnly := True ; // Only drag window by title bar
	
	;SetWindowTitleAlign(0.5, 0.5)
	EnableDocking(True)
	
	while(PeekMsg())
	{
		
		BeginFrame()
		Begin("cheat", 0, ImGuiWindowFlags_MenuBar | ImGuiWindowFlags_NoScrollbar)
		
		static b_show_demo_window := false
				CheckBox("Show demo window", &b_show_demo_window)
				
				If(b_show_demo_window)
				ShowDemoWindow()
		
		
		End()
		EndFrame()
		
	}
	ExitApp()
	return	
}


sleep(value){
	return DllCall("Sleep","UInt",value)
}

_PixelSearch(X1, Y1, X2, Y2, ColorID, Variation:=0) {
	PixelSearch(&OutputVarX, &OutputVarY, X1, Y1, X2, Y2, ColorID, Variation)
	Return [OutputVarX, OutputVarY]
}

deg2rad(degrees) {
	return degrees * ((4*ATan(1)) / 180)
}

rad2deg(radians) {
	return radians * (180 / (4*ATan(1)))
}

coord2deg(delta, fov, winwidth, winheight) {
	;lookAt := delta * 2 / winwidth
	;return rad2deg(atan(lookAt*tan(deg2rad(fov*0.5)))) ;degrees
	return rad2deg(atan(((delta<<1)/winwidth)*tan(deg2rad(fov*0.5))))
}

deg2coord(delta, fov, winwidth, winheight) {
	return winwidth*0.5/tan(deg2rad(fov*0.5))*tan(deg2rad(delta))
}

;Apex Legends must use this conversion
RealFov(fov, winwidth, winheight) {
	raspectRatio := (winwidth/winheight)/(4/3)
	return 2*rad2deg(atan(tan(deg2rad(fov*0.5))*raspectRatio))
}


INSERT:: ;Toggle Gui
{
	global toggleGui:= !toggleGui
	
	If toggleGui
	{
		WinHide "ahk_class ImGui Platform"
		;global aimbot_enable := 1
	}
	Else
	{
		WinShow "ahk_class ImGui Platform"
		WinActivate "ahk_class ImGui Platform"
		;global aimbot_enable := 0
	}
}

F5::
{
	;ProcessClose "chrome.exe"
	Reload
}

END::
{
	;ProcessClose "chrome.exe"
	ExitApp()
}
