; ********************************* 
; version 2.03
; - November 23, 2008 - corrupt
; ********************************* 
; Create a new struct 
; ********************************* 
; Params: "Structure Name", "VarType", "VarName", "Type", "Name", etc... 
; - Currently a maximum of 32 variables in a structure is supported 
;   (to add support for more, add to the list below) 
; 
; Optional alternate syntax allowed: "Structure Name", "VarName As Type", "VarName As Type", ... 
; - mixing of the 2 different syntax styles in the same call is not currently supported 
; *********************************

Struct_Create(struct_name ,s_type1, s_var1 ,s_type2="", s_var2="" ,s_type3="", s_var3="" 
,s_type4="" , s_var4=""  ,s_type5="" , s_var5=""  ,s_type6="" , s_var6=""  ,s_type7="" , s_var7="" 
,s_type8="" , s_var8=""  ,s_type9="" , s_var9=""  ,s_type10="", s_var10="" ,s_type11="", s_var11="" 
,s_type12="", s_var12="" ,s_type13="", s_var13="" ,s_type14="", s_var14="" ,s_type15="", s_var15="" 
,s_type16="", s_var16="" ,s_type17="", s_var17="" ,s_type18="", s_var18="" ,s_type19="", s_var19="" 
,s_type20="", s_var20="" ,s_type21="", s_var21="" ,s_type22="", s_var22="" ,s_type23="", s_var23="" 
,s_type24="", s_var24="" ,s_type25="", s_var25="" ,s_type26="", s_var26="" ,s_type27="", s_var27="" 
,s_type28="", s_var28="" ,s_type29="", s_var29="" ,s_type30="", s_var30="" ,s_type31="", s_var31="" 
,s_type32="", s_var32=""){ 
  Global 
  Local struct_sizeA, struct_sizeB, struct_temp1, struct_temp2, struct_temp3, struct_temp4 
  , struct_temp40, struct_temp41, struct_temp42, struct_temp5, struct_temp6, struct_templast 
  struct_sizeA = 0 
  Local Static Int = 4
  Local Static UInt = 4
  Local Static Str = 4
  Local Static Short = 2
  Local Static Ushort = 2
  Local Static Uchar = 1
  Local Static Char = 1
  Local Static Int64 = 8
  Local Static UInt64 = 8  

  If (!A_AhkScriptProcessID) { 
    Process, Exist 
    A_AhkScriptProcessID = %ErrorLevel%i 
  } 
  struct_temp3 = %struct_name%_%A_AhkScriptProcessID% 
  %struct_name%= init 
  %struct_name%= 
  ; Process elements 
  Loop, 32 { 
    struct_temp42 := s_type%A_Index% 
    struct_temp41 := s_var%A_Index% 
    struct_temp5 = 1 
    ; check for As syntax 
    StringReplace, struct_temp42, struct_temp42, %A_Tab%, %A_Space%, All 
    If (InStr(struct_temp42, " As ")) { 
      StringReplace, struct_temp42, struct_temp42, %A_Space%As%A_Space%, `, 
      struct_temp4 = %struct_temp42% 
      StringSplit, struct_temp4, struct_temp4, `,, %A_Space% 
      struct_temp4 := s_var%A_Index% 
      struct_temp5 = 2 
    } 
    Loop, %struct_temp5% 
    { 
      If (A_Index = "2") { 
        struct_temp41 = %struct_temp4% 
        StringReplace, struct_temp41, struct_temp41, %A_Tab%, %A_Space%, All 
        StringReplace, struct_temp41, struct_temp41, %A_Space%As%A_Space%, `, 
        struct_temp4 = %struct_temp41% 
        StringSplit, struct_temp4, struct_temp4, `,, %A_Space% 
      } 
      ; Check Type (u - unsigned, p - pointer) 
      If (struct_temp42="Int" OR struct_temp42="long" OR struct_temp42="4") 
        struct_temp2 = Int
      Else If (struct_temp42="dword" OR struct_temp42="hwnd" OR struct_temp42="4u") 
        struct_temp2 = UInt 
      Else If (struct_temp42="4up")
        struct_temp2 = Str 
      Else If (struct_temp42="2") 
        struct_temp2 = Short
      Else If (struct_temp42="word" OR struct_temp42="2u") 
        struct_temp2 = Ushort 
      Else If (struct_temp42="byte" OR struct_temp42="1u") 
        struct_temp2 = Uchar 
      Else If (struct_temp42="1") 
        struct_temp2 = Char 
      Else If (struct_temp42="8") 
        struct_temp2 = Int64 
      Else If (struct_temp42="8u") 
        struct_temp2 = UInt64 
      Else 
        struct_temp2 = %struct_temp42%
      If struct_temp2 =
        struct_temp2 = Int
      If struct_temp41= 
      { 
        struct_temp6 = 1 
        break 
      } 
      ; ** Create variables ** 
      struct_temp1 := "#" . struct_temp41 
      If (!InStr(struct_temp2, "p")) 
        %struct_name%%struct_temp1% = 0 
      Else { 
        %struct_name%%struct_temp1%=init 
        %struct_name%%struct_temp1%= 
      } 
      ; ** Create reference ** 
      %struct_temp3% := %struct_temp3% . struct_temp2 . ":" . struct_temp41 "|" 
      struct_sizeA += (%struct_temp2%)
    } 
    If (struct_temp6) 
      break 
  } 
  VarSetCapacity(%struct_name%, struct_sizeA, 0) 
Return, True 
} 


; ********************************* 
; Retrieve a value from the structure 
; ********************************* 
; Params: struct_name or struct#varname 
; - specifying struct_name will retrieve/update values for all variables in the structure 
; - specifying struct#varname will retrieve/update only the variable specified    
; ********************************* 
Struct_Get(s_query) 
{ 
  Global 
  Local struct_sizeA, struct_sizeB, struct_temp1, struct_temp2, struct_temp3, struct_temp4, struct_temp5, struct_temp6 
  , struct_temp0, struct_temp00, struct_temp01, struct_temp02
  Local Static Int = 4
  Local Static UInt = 4
  Local Static Str = 4
  Local Static Short = 2
  Local Static Ushort = 2
  Local Static Uchar = 1
  Local Static Char = 1
  Local Static Int64 = 8
  Local Static UInt64 = 8
  Local Static df_lstrcpyA  
  If !(df_lstrcpyA)
    df_lstrcpyA := DllCall("GetProcAddress", uint, DllCall("GetModuleHandle", str, "kernel32"), str, "lstrcpyA")
  StringSplit, struct_temp, s_query, # 
  struct_temp3 = %struct_temp1%_%A_AhkScriptProcessID% 
  If (!%struct_temp3%) { 
    VarSetCapacity(%struct_temp3%, 0) 
    ErrorLevel = Invalid_Struct 
    Return 
  }

  struct_sizeA = 0 
  Loop, Parse, %struct_temp3%, | 
  { 
    StringSplit, struct_temp0, A_LoopField, : 
    If struct_temp00= 
      break 
    struct_sizeA += (%struct_temp01%)
    struct_sizeB :=  (%struct_temp01%)
    struct_temp4 = %struct_temp01%
    EnvAdd, struct_temp01, 0 
    If (struct_temp02 = struct_temp2 OR struct_temp2 = "") {
      struct_temp5 := NumGet(%struct_temp1%, (struct_sizeA - struct_sizeB), %struct_temp01%)
      If (InStr(struct_temp4, "Str")) {
        DllCall(df_lstrcpyA, "Str", %struct_temp1%#%struct_temp02%, "UInt", struct_temp5)
      }
      Else
        %struct_temp1%#%struct_temp02% = %struct_temp5% 
      If (struct_temp02 = struct_temp2) 
        Return, %struct_temp1%#%struct_temp02%
      struct_temp02=
    } 
  } 
  Return 
} 

; ********************************* 
; Send a value to the structure 
; ********************************* 
; Params: struct_name or struct#varname 
; - specifying struct_name will send/update values from all variables in the structure 
; - specifying struct#varname will send/update only the variable specified    
; ********************************* 

Struct_Set(s_modify, s_value="") 
{ 
  Global 
  Local struct_sizeA, struct_sizeB, struct_temp1, struct_temp2, struct_temp3, struct_temp4, struct_temp0
  Local Static Int = 4
  Local Static UInt = 4
  Local Static Str = 4
  Local Static Short = 2
  Local Static Ushort = 2
  Local Static Uchar = 1
  Local Static Char = 1
  Local Static Int64 = 8
  Local Static UInt64 = 8  
  StringSplit, struct_temp, s_modify, # 
  struct_temp3 = %struct_temp1%_%A_AhkScriptProcessID% 
  If (!%struct_temp3%) { 
    VarSetCapacity(%struct_temp3%, 0) 
    ErrorLevel = Invalid_Struct 
    Return 
  } 
  struct_sizeA = 0 
  Loop, Parse, %struct_temp3%, | 
  {
    Loop, Parse, A_LoopField, : 
    { 
      If (A_Index = "1") { 
        struct_sizeA += (%A_LoopField%) 
        struct_sizeB := (%A_LoopField%) 
        struct_temp4 = %A_LoopField% 
        EnvAdd, struct_sizeB, 0
      } 
      Else { 
        If (A_LoopField = struct_temp2 OR struct_temp2="") { 
          If struct_temp2<> 
            %struct_temp1%#%A_LoopField% = %s_value% 
          If (InStr(struct_temp4, "Str"))
            NumPut(&(%struct_temp1%#%A_LoopField%), %struct_temp1%, (struct_sizeA - struct_sizeB), struct_sizeB)
          Else 
            NumPut(%struct_temp1%#%A_LoopField%, %struct_temp1%, (struct_sizeA - struct_sizeB), struct_sizeB)
       } 
      } 
    } 
  } 
Return 
} 

; ********************************* 
; Debug plugin 
; ********************************* 
; AHK Function Library - Structures 
; Version 2.03 
; November 23, 2008 - corrupt
; ********************************* 

; ********************************* 
; Retrieve a list of all variable names and values in a structure 
; ********************************* 
; "StructName", "DelimChar", "V" 
; - DelimChar may be character(s) to use to separate variable and value 
; - The info for each variable is separated by a `n character 
; - This function retrieves the values stored in the structure by default. 
; "V" can be specified as the 3rd param to retrieve the values from the 
; associated variables instead. 
; ********************************* 
Struct_Enum(s_query, struct_delim2="", struct_local="") 
{ 
  Global 
  Local struct_sizeA, struct_sizeB, struct_temp1, struct_temp2, struct_temp3, struct_temp4, struct_temp5, struct_temp6 
  , struct_temp0, struct_temp00, struct_temp01, struct_temp02, struct_temp7, struct_temp8
  Local Static Int = 4
  Local Static UInt = 4
  Local Static Str = 4
  Local Static Short = 2
  Local Static Ushort = 2
  Local Static Uchar = 1
  Local Static Char = 1
  Local Static Int64 = 8
  Local Static UInt64 = 8
  Local Static df_RtlMoveMemory 
  If !(df_RtlMoveMemory)
    df_RtlMoveMemory := DllCall("GetProcAddress", uint, DllCall("GetModuleHandle", str, "kernel32"), str, "RtlMoveMemory") 
  StringSplit, struct_temp, s_query, # 
  struct_temp3 = %struct_temp1%_%A_AhkScriptProcessID% 
  If (!%struct_temp3%) { 
    VarSetCapacity(%struct_temp3%, 0) 
    ErrorLevel = Invalid_Struct 
    Return 
  } 
  If struct_delim2= 
    struct_delim2 = `= 
  struct_sizeA = 0 
  Loop, Parse, %struct_temp3%, | 
  { 
    StringSplit, struct_temp0, A_LoopField, : 
    If struct_temp00 = 0 
      break 
    struct_sizeA += (%struct_temp01%)
    struct_sizeB :=  (%struct_temp01%)
    struct_temp4 = %struct_temp01%
    EnvAdd, struct_temp01, 0 
    If struct_local = V 
      struct_temp5 := %struct_temp1%#%struct_temp02% 
    Else { 
      struct_temp5 := NumGet(%struct_temp1%, (struct_sizeA - struct_sizeB), %struct_temp01%)
      If (InStr(struct_temp4, "Str")) {
                struct_temp7 = %struct_temp5% 
        struct_temp8 := DllCall("lstrlen", "UInt", struct_temp7) 
        VarSetCapacity(struct_temp5, struct_temp8, 0) 
        DllCall("RtlMoveMemory", "Str", struct_temp5, "UInt", struct_temp7, "Int", struct_temp8) 
      } 
    } 
    struct_temp6 = %struct_temp6%`n%struct_temp02%%struct_delim2%%struct_temp5% 
  } 
  Return, struct_temp6 
} 
; ********************************* 