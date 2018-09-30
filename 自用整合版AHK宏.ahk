#IfWinActive,ahk_class D3 Main Window Class

;圣教军天谴流自动钢甲速刷AHK宏
; 1. 宏开关触发挪到了鼠标侧键（按 F2 还要左手操作，懒，只想单手扣脚），喝药水我在游戏按键绑定的鼠标侧键1。
; 2. shift 键长按用于做出强制原地攻击，躲地面元素伤，站立核眼buff圈等场景使用。
; 3. 左键自动连点特性可通过鼠标滚轮上划开启，下滑关闭。方便装备杨裤后快速切换，以及Boss战时安全走位，防止误触发左键普攻。
; 4. 右键自动连点特性（自动钢甲）通过 F1 键开启/关闭，由于切换频次较低，因此采用了单键切换，并弹出提示框方便确认当前开关状态。
;关于哪里可以修改，注释里注明可改动的地方需要改，其他地方保持不变即可
;对于那些按键设置并不是1天谴2挑衅3律法4勇士x强制移动左键回能右键钢甲的玩家，请进游戏按esc-选项-按键绑定，可看到界面上指令、按键1、按键2，按键1对应的指令设成自己的习惯按键，按键2对应的指令设成1234x就行，这样天谴宏不影响你玩其他职业也不影响你之前的按键习惯


SetKeyDelay,-1
SetMouseDelay,-1

v_package_x_p:=1475 ;背包一个格的x坐标--------（可以修改）
v_package_y_p:=585 ;背包一个格的y坐标---------（可以修改）
v_package_x_to_x:=50 ; 背包两行中心点的距离---（无需更改）
v_package_y_to_y:=50 ; 背包两列中心点的距离---（无需更改）
v_decompose_page_x:=515 ;铁匠分解页面的x坐标--（可以修改）
v_decompose_page_y:=480 ;铁匠分解页面的y坐标--（可以修改）
v_decompose_x:=165 ;分解按钮的x坐标-----------（可以修改）
v_decompose_y:=290 ;分解按钮的y坐标-----------（可以修改）
v_chat_icon_x:=30 ; 聊天按钮x坐标-------------（可以修改）
v_chat_icon_y:=883 ;聊天按钮x坐标-------------（可以修改）


x_package_x_p:=560 ;背包一个格的x坐标--------（可以修改）
x_package_y_p:=355 ;背包一个格的y坐标---------（可以修改）
x_package_x_to_x:=30 ; 背包两行中心点的距离---（无需更改）
x_package_y_to_y:=30 ; 背包两列中心点的距离---（无需更改）
x_decompose_page_x:=290 ;铁匠分解页面的x坐标--（可以修改）
x_decompose_page_y:=300 ;铁匠分解页面的y坐标--（可以修改）
x_decompose_x:=100 ;分解按钮的x坐标-----------（可以修改）
x_decompose_y:=195 ;分解按钮的y坐标-----------（可以修改）




v_loop:=0 ;停止循环
v_Enable=0  ;宏开关变量
v_Tab=0     ;按Tab查看小地图暂停宏变量
v_LeftBtnAutoClick=1     ;是否连点左键
v_RightBtnAutoClick=1    ;是否连点右键

;开关键，鼠标有侧键的玩家，可以将F2换成鼠标侧键对应的代码XButton1、XButton2
$XButton2::
{
    v_Enable:=!v_Enable
    If (v_Enable=0)
        Gosub, StopScript
    Else
        Gosub, RunScript
}
Return

~Enter::
~T::
~S::
~I::
~M::
;回车打字、按T回城、按S查看技能、按I查看装备、按M查看悬赏关闭宏
{
    Gosub, StopScript
}
Return

~Tab::
;按Tab查看地形暂停宏和自动恢复
If (v_Enable)
{
    v_Tab:=!v_Tab
    If (v_Tab)
        Gosub, PauseScript
    Else
        Gosub, RunScript
}
Return

~*LButton::  ;按住左键停止强制移动
If (v_Enable)
    SetAutoMove(false)
Return

*LButton Up::  ;松开左键恢复强制移动
If (v_Enable)
    SetAutoMove(true)
Return

~*LShift::  ;按住原地不动攻击
If (v_Enable)
{
    SetAutoMove(false)
    Send {LShift down}
}
Return

*LShift Up::  ;按住原地不动攻击
If (v_Enable)
{
    SetAutoMove(true)
    Send {LShift up}
}
Return

~*RButton::  ;按住右键跑马暂停123和左键连点，保持强制移动，保持勇士连点
If (v_Enable)
{
SetTimer, Label1, off
SetTimer, Label2, off
SetTimer, Label3, off
SetTimer, MouseLButton, off
Send {x down}
}
Return

*RButton Up::  ;松开右键跑马恢复123和左键连点，保持强制移动，保持勇士连点
If (v_Enable)
{
SetTimer, Label1, 650
SetTimer, Label2, 600
SetTimer, Label3, 600
SetTimer, MouseLButton, 150
Send {x down}
}
Return

;==============================================

$F1::
    Gosub, StopScript
    v_RightBtnAutoClick:=!v_RightBtnAutoClick
Return

$F4::  ;卡达拉赌血岩
    Send {RButton 30}
Return

~*XButton1:: ;按住侧键连点捡装备
    SetAutoLeftBtnClick(true)
Return

~*XButton1 Up:: ;松开侧键关闭连点捡装备
    SetAutoLeftBtnClick(false)
Return

~WheelUp::  ; 开启左键连点
    v_LeftBtnAutoClick = 1
    If (v_Enable)
        SetAutoLeftBtnClick(true)
Return

~WheelDown::  ; 关闭左键连点
    v_LeftBtnAutoClick = 0
    If (v_Enable)
        SetAutoLeftBtnClick(false)
Return

;==============================================

Label1:
    Send {1} ;动作条技能1键对应按键
Return

Label2:
    Send {2} ;动作条技能2键对应按键
Return

Label3:
    Send {3} ;动作条技能3键对应按键
Return

Label4:
    Send {4}  ;动作条技能4键对应按键
Return

MouseLButton:
    Click    ;点击鼠标左键，对应主要技能
Return

MouseRButton:
    Click Right ;点击鼠标右键，对应钢甲技能
Return

RunScript:
    SetTimer, Label1, 650  ;动作条技能1键600毫秒连点，对应天谴技能，600可改动
    SetTimer, Label2, 600  ;动作条技能2键600毫秒连点，对应挑衅技能，600可改动
    SetTimer, Label3, 600  ;动作条技能3键600毫秒连点，对应律法技能，600可改动
    SetTimer, Label4, 600  ;动作条技能4键600毫秒连点，对应勇士技能，600可改动

    SetAutoLeftBtnClick(v_LeftBtnAutoClick)
    SetAutoRightBtnClick(v_RightBtnAutoClick)

    Send {x down}   ;自动按住强制移动键x，关闭强制移动down换up，down可改动

    SetTimer, StopScriptIfD3NotActive, 150
Return

PauseScript:
    SetTimer, Label1, off  ;关闭技能1连点计时器
    SetTimer, Label2, off  ;关闭技能2连点计时器
    SetTimer, Label3, off  ;关闭技能3连点计时器
    SetTimer, Label4, off  ;关闭技能4连点计时器

    SetAutoLeftBtnClick(false)  ;关闭左键连点计时器
    SetAutoRightBtnClick(false) ;关闭右键连点计时器

    Send {x up}    ;松开强制移动键x，

    SetTimer, StopScriptIfD3NotActive, off
Return

StopScript:
    Gosub, PauseScript
    v_Enable=0
Return

SetAutoMove(isON)
{
    If (isON)
        Send {x down}
    Else
        Send {x up}
}

SetAutoLeftBtnClick(isON)
{
    If (isON)
        SetTimer, MouseLButton, 100  ;鼠标左键150毫秒连点，150可改动，只有这里需要改动
    Else
        SetTimer, MouseLButton, off
}

SetAutoRightBtnClick(isON)
{
    If (isON)
        SetTimer, MouseRButton, 600  ;鼠标右键600毫秒连点，钢甲手动触发，自动钢甲off换成600，off可改动
    Else
        SetTimer, MouseRButton, off
}

StopScriptIfD3NotActive:
    ; IfWinNotActive,暗黑破壞神III ;外服繁体游戏端窗口切换关闭宏
    ;         Gosub, StopScript
    If not WinActive("ahk_class D3 Main Window Class")
        Gosub, StopScript
Return


$F11::
{
	; 升级宝石
	UpdateGem(3)
}
return

UpdateGem(x = 0){
	; 多个角色升级宝石

	global v_loop

	var_firstPId:=0
	;获取暗黑的游戏窗口
	WinGet, id, list, ahk_class D3 Main Window Class,, Program Manager
	WinGetPos, X, Y, Width, Height, A  ; "A" 表示获取活动窗口的位置.
	WinGet, active_id, ID, A
	var_firstPId:=active_id
	v_loop:=1
	Loop, 6
	{
		v_outIndex:=A_Index
			Loop, %id%
			{
				;获取pid
				this_id := id%A_Index%
					WinGetPos, X, Y, XWidth, XHeight, A  ; "A" 表示获取活动窗口的位置.
				if(v_loop = 1){
					if(v_outIndex<5){
						WinActivate, ahk_id %this_id%
						Sleep, 300 ;
						updateSingleGem(v_outIndex)
						Sleep, 100 ;
					}else if(v_outIndex = 5){
						if(var_firstPId=this_id){
							Send {T}
						}else{
							Sleep, 100 ;
							Gosub, moveToMe
						}
					}else{
						if(var_firstPId=this_id){
							Sleep, 3000 ;
							WinActivate, var_firstPId
							DllCall("SetCursorPos", int, 1322, int, 171)  ; 第一个数字是 X 坐标而第二个是 Y (相对于屏幕).
							Click Left ;
						}else{
							Sleep, 3000 ;
							knock(2, XWidth, XHeight)
						}
					}

				}

			}
	}
	WinActivate, first_id
	DllCall("SetCursorPos", int, Width//2, int, Height//2)  ; 第一个数字是 X 坐标而第二个是 Y (相对于屏幕).
	Click Left ;
}

;更新一次宝石
updateSingleGem(v_outIndex){
	WinGetPos, X, Y, Width, Height, A  ; "A" 表示获取活动窗口的位置.
	if(Width=1920){
		MouseMove, 260, 550 ,2
		Sleep, 100 ;
		Click Left ;
	}else{
		if(v_outIndex=1){
			MouseMove, 65, 390 ,2
			Sleep, 100 ;
			Click Left ;
		}
		MouseMove, 150, 335 ,2
		Sleep, 100 ;
		Click Left ;
	}

}





$F7:: ;批量敲碎装备 ;F7-------可以修改
{
	WinGetPos, X, Y, Width, Height, A  ; "A" 表示获取活动窗口的位置.

	global v_decompose_page_x
	global v_decompose_page_y
	global v_decompose_x
	global v_decompose_y

	global x_decompose_page_x
	global x_decompose_page_y
	global x_decompose_x
	global x_decompose_y
	if(Width=1920){
		decompose_page_x:=v_decompose_page_x
		decompose_page_y:=v_decompose_page_y
		decompose_x:=v_decompose_x
		decompose_y:=v_decompose_y
	}else{
		decompose_page_x:=x_decompose_page_x
		decompose_page_y:=x_decompose_page_y
		decompose_x:=x_decompose_x
		decompose_y:=x_decompose_y
	}

	MouseMove, decompose_page_x, decompose_page_y, 0
	Click Left ;
	MouseMove, decompose_x, decompose_y, 0
	Click Left ;
	v_loop:=1
	knock(1, Width, Height)
	Click Right ;
	Send, {Esc}
	MouseMove, Width//2, Height//2, 0



}
Return


$F8:: ; 批量扔装备 ;F8-------可以修改
{
	WinGetPos, X, Y, Width, Height, A  ; "A" 表示获取活动窗口的位置.
	v_loop:=1

	knock(2, Width, Height)

}
Return



; 敲碎或者扔到地上
killIt(x,Width,Height){


	if(x=1){
		Click Left ;
		;MouseMove, Width//2, Height//2, 0
		;Click Left ;
		Send {enter}
		Send {enter}

	}else{
		Click, down  ;
		MouseMove, Width//2, Height//2, 0
		Click, up  ;
		;Send {enter}
	}

}


; 循环执行 敲碎或者扔到地上
knock(x, Width, Height){

global v_loop
global v_package_x_p
global v_package_y_p
global v_package_x_to_x
global v_package_y_to_y

global x_package_x_p
global x_package_y_p
global x_package_x_to_x
global x_package_y_to_y

	if(Width=1920){
		package_x_p:=v_package_x_p
		package_y_p:=v_package_y_p
		package_x_to_x:=v_package_x_to_x
		package_y_to_y:=v_package_y_to_y
	}else{
		package_x_p:=x_package_x_p
		package_y_p:=x_package_y_p
		package_x_to_x:=x_package_x_to_x
		package_y_to_y:=x_package_y_to_y
	}

v_cp:=package_x_p
v_c_y:=package_y_p


Loop, 6{    ;六行物品栏
	Loop, 9   ;九列物品栏
	{

		if(v_loop=1){
			MouseMove, v_cp, v_c_y, 0
			v_cp:=v_cp+package_x_to_x
			killIt(x,Width,Height)
		}

	}
	v_cp:=package_x_p
	v_c_y:=v_c_y+package_y_to_y
}

}


;切换窗口 并执行相应的事件
; 1次 开启大秘境 和接受
; 2次 传送至我这
; 3次 升级宝石（小号升级4次）
$F12::
if pause_presses > 0
{
    pause_presses += 1
    return
}
; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动
; 计时器:
pause_presses = 1
SetTimer, KeyPause, -400 ; 在 400 毫秒内等待更多的键击.
return
KeyPause:
changeWin(pause_presses)
; 不论触发了上面的哪个动作, 都对 count 进行重置
; 为下一个系列的按下做准备:
pause_presses = 0
return


; 切换窗口 并执行相应的事件
; 1=开启大秘境 其他角色接受
; 2=传送至我这 多个角色传送我这
; 3=多个角色升级宝石
; 4=小号扔装备
; 5=
changeWin(x = 1){

	global v_loop
	var_firstPId:=0
	;获取暗黑的游戏窗口
	WinGet, id, list, ahk_class D3 Main Window Class,, Program Manager
	WinGetPos, I, J, Width, Height, A  ; "A" 表示获取活动窗口的位置.
	WinGet, active_id, ID, A
	Loop, %id%
	{
		;获取pid
		this_id := id%A_Index%

		; 前置参数
		if(A_Index = 1){
			var_firstPId := id%A_Index%
		}
		if(A_Index > 1){
		}


		; 执行方法
		if(x = 1){
			; 开启大秘境 其他角色接受
			if(A_Index = 1){
				Sleep, 50
				;点击大秘境
				Click, 266, 477
				Sleep, 50
				;点击开启
				Click, 265, 845
			}else{
				;跳转其他窗口
				WinActivate, ahk_id %this_id%
				;接受
				Send {z}
				Sleep, 500
				Click, 410, 490
			}

		}else if(x = 2){
			; 传送至我这 多个角色传送我这
			if(A_Index > 1){
				;跳转其他窗口
				Send {z}
				WinActivate, ahk_id %this_id%
				Sleep, 100
				MouseMove, 43, 165 ,2

				Sleep, 50  ;
				Click right ;

				MouseMove, 100, 245 ,2

				Sleep, 200  ;
				Click Left ;
				Sleep, 100
			}

		}else if(x = 3){
			; 多个角色回城
			if(A_Index > 1){
				;跳转其他窗口
				Send {z}
				WinActivate, ahk_id %this_id%
				Send {t}
			}

		}
	}
	WinActivate, active_id
	DllCall("SetCursorPos", int, Width//2, int, Height//2)  ; 第一个数字是 X 坐标而第二个是 Y (相对于屏幕).
	Click Left ;

}

moveToMe:
	;跳转其他窗口
	Sleep, 100
	MouseMove, 43, 165 ,2

	Sleep, 50  ;
	Click right ;

	MouseMove, 100, 245 ,2

	Sleep, 200  ;
	Click Left ;
	Sleep, 100
return
