;SetTimer, mytimer , 1000

;#++++++++++++++++++++++++++++++++++++++++++++++++++++#
;#  環境設定
;#++++++++++++++++++++++++++++++++++++++++++++++++++++#
;1: A window's title must start with the specified WinTitle to be a match.
;2: A window's title can contain WinTitle anywhere inside it to be a match. 
;3: A window's title must exactly match WinTitle to be a match.
SetTitleMatchMode, 2
SetTitleMatchMode, slow

;////////////////////////////////////////////////////////////////////////////////////////////////////
;//
;//  キー設定
;//
;////////////////////////////////////////////////////////////////////////////////////////////////////

;#------------------------------------------------------------#
;#-  キーの無効化
;#------------------------------------------------------------#
F1::
	return

;#------------------------------------------------------------#
;#-  共通キー設定
;#------------------------------------------------------------#
;// ウィンドウを閉じる
Pause::
	Send, ^{F4}
	return
!Pause::
	Send, !{F4}
	return
;// ボリューム調整
~AppsKey & Up::
	Send, {Volume_Up}
	return
~AppsKey & Down::
	Send, {Volume_Down}
	return
;// バックライト調整
;AppsKey & Left::
;	Send, {F21}
;	return
;AppsKey & Right::
;	Send, {F22}
;	return

;常に手前に表示する
#t::
	WinSet, AlwaysOnTop, Toggle, A
	return

;アクティブウィンドウ以外を黒くする
#b::
	If(!Flag){
		Gui,Add,Text
		Gui,Color,0x000000
		Gui,Show,W2000 H2000 NA
		Flag = 1
	}Else{
		Gui,Destroy
		Flag = 0
	}
	return

;#------------------------------------------------------------#
;#-  Toggle Window
;#------------------------------------------------------------#

	^F8::
		IfWinExist, ahk_class Console_2_Main
		{
			ToggleWindow("ahk_class Console_2_Main", FALSE)
		}Else{
			Run "D:\My Program Files\Console2\Console.exe"
		}
		return

	+F8::
		IfWinExist, ahk_class Vim
		{
			ToggleWindow("ahk_class Vim", FALSE)
		}Else{
			Run "D:\My Program Files\vim73-kaoriya-win64\gvim.exe"
		}
		return
		
	!F9::
		IfWinExist, ahk_class Chrome_WidgetWin_1
		{
			ToggleWindow("ahk_class Chrome_WidgetWin_1", TRUE)
		}Else{
			Run Chrome
		}
		return
	SC07B::
		IfWinExist, ahk_class CabinetWClass
		{
			ToggleWindow("ahk_class CabinetWClass", FALSE)
		}Else{
			Send, #e
		}
		return
	#s::
		IfWinExist, Google Keep
		{
			ToggleWindow("Google Keep", FALSE)
		}Else{

		}
		return
	#x::
		IfWinExist, ahk_class TfMain
		{
			ToggleWindow("ahk_class TfMain", FALSE)
		}Else{
			Run "C:\Users\jtanaka\ShortCuts\xampp-control.exe.lnk"
		}
		return

;#------------------------------------------------------------#
;#-  Google Chrome
;#------------------------------------------------------------#
#IfWinActive, ahk_class Chrome_WidgetWin_1

	;// Speed Dial
	^1::
		OpenURL( "Facebook", "http://www.facebook.com/?ref=logo" )
		return
	^2::
		OpenURL( "[mixi]", "http://mixi.jp/" )
		return
	^3::
		OpenURL( "YouTube", "http://www.youtube.com/?gl=JP&hl=ja" )
		return
	^4::
		OpenURL( "ニコニコ動画", "http://www.nicovideo.jp/" )
		return
	^7::
		OpenURL( "楽天ゴールデンイーグルス", "http://www.rakuteneagles.jp/" )
		return

#IfWinActive

;#------------------------------------------------------------#
;#-  Steam TF2
;#------------------------------------------------------------#
#IfWinActive, ahk_class Valve001
	LWin::
		return

#IfWinActive

;#------------------------------------------------------------#
;#-  kobo Desktop
;#------------------------------------------------------------#
#IfWinActive, ahk_class QWidget
	Left::
		Send, {WheelDown}
		return
	Right::
		Send, {WheelUp}
		return
#IfWinActive

;////////////////////////////////////////////////////////////////////////////////////////////////////
;//
;//  共通関数
;//
;////////////////////////////////////////////////////////////////////////////////////////////////////

;//
;// 指定したURLを開く
;// title	: 行き先URLのタイトル（連打抑制にしかなってない）
;// url		: 行き先URL
;//
OpenURL( title, url ){

	IfWinExist, %title%
	{
		WinActivate
	}else
	{
		Run %url%
	}
	
	return
}

;//
;// ウィンドウの 表示/非表示 切り替え
;//
;//
ToggleWindow( target, maximize ){

	IfWinActive, %target%
	{
		WinMinimize
	}else
	{
		IfWinExist, %target%
		{
			WinActivate
			If( %maximize% = TRUE )
			{
				WinMaximize
			}
		}
	}
	
	return
}

;//
;// IMEをoffにしてからキーを送信する
;//
SafeSend( keys ){
	IME_SET(0)
	Send, %keys%
	return
}

;// タイマー処理
mytimer:

	;// Excelのライセンス画面を閉じる
	IfWinExist, ahk_class XLMAIN
	{
		IfWinExist, ahk_class NUIDialog
		{	
			WinClose
		}
	}
	
return
