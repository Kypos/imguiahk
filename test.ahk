#Include <imgui>

;// Init
ImGui.EnableViewports()

ImGui.GUICreate("Exaain window", 1,1, -100, -100)
ImGui.Style.Dark()
;//------------------------------------------------------------------
;// Vars
b_show_another_window := 0
f_value = 7
item_current = 0;
b_show_demo_window = false
;//------------------------------------------------------------------

While 1
{
    ImGui.BeginFrame()
    
    If Not ImGui.Begin("Test", True) Then Exit
    ;ImGui.ShowDemoWindow()
    If ImGui.CheckBox("Show demo window", b_show_demo_window) Then ImGui.EnableViewports(b_show_demo_window)
    
    If b_show_demo_window Then ImGui.ShowDemoWindow()
    ImGui.End()
    ImGui.EndFrame()
}

F5::Reload
