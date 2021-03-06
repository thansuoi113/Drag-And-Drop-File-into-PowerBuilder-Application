$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_close from commandbutton within w_main
end type
type cb_reset from commandbutton within w_main
end type
type lb_files from listbox within w_main
end type
end forward

global type w_main from window
integer width = 2395
integer height = 1068
boolean titlebar = true
string title = "Drag And Drop Files"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_reset cb_reset
lb_files lb_files
end type
global w_main w_main

type prototypes
Subroutine DragAcceptFiles(Long hWnd, Boolean fAccept) Library "shell32.dll"
subroutine DragFinish(long hDrop) library "shell32.dll"
Function ULong DragQueryFileW(Long hDrop, ULong iFile, Ref String szFileName, ULong cch) Library "shell32.dll" Alias For "DragQueryFileW"
Function ULong DragQueryFileA(Long hDrop, ULong iFile, Ref String szFileName, ULong cch) Library "shell32.dll" Alias For "DragQueryFileA"


end prototypes
on w_main.create
this.cb_close=create cb_close
this.cb_reset=create cb_reset
this.lb_files=create lb_files
this.Control[]={this.cb_close,&
this.cb_reset,&
this.lb_files}
end on

on w_main.destroy
destroy(this.cb_close)
destroy(this.cb_reset)
destroy(this.lb_files)
end on

event open;// Enable Drag Accept Files
DragAcceptFiles(Handle(lb_files), True)

end event

event close;// Disable Drag Accept Files
DragAcceptFiles(Handle(lb_files), False)

end event

type cb_close from commandbutton within w_main
integer x = 1998
integer y = 864
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type cb_reset from commandbutton within w_main
integer x = 37
integer y = 864
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reset"
end type

event clicked;lb_files.reset()
end event

type lb_files from listbox within w_main
event wm_dropfiles pbm_dropfiles
integer x = 37
integer y = 32
integer width = 2304
integer height = 800
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event wm_dropfiles;
Constant ULong FILECOUNT = 4294967295
ULong lul_index, lul_chars, lul_idx, lul_max
String ls_FileName
ULong lul_size = 1023 //260

lul_max = DragQueryFileW(Handle, FILECOUNT, ls_FileName, lul_size)

For lul_idx = 1 To lul_max
	lul_index = lul_idx - 1
	ls_FileName = Space(lul_size)
	lul_chars = DragQueryFileW(Handle, lul_index, ls_FileName, lul_size)
	lb_files.AddItem(ls_FileName)
Next

DragFinish(Handle)

end event

