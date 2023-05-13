object MainFrom: TMainFrom
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 421
  ClientWidth = 862
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menuMain
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pbAnimate: TPaintBox
    Left = 0
    Top = 0
    Width = 862
    Height = 421
    Align = alClient
    OnPaint = pbAnimatePaint
    ExplicitLeft = 568
    ExplicitTop = 232
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object Button1: TButton
    Left = 616
    Top = 176
    Width = 65
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object menuMain: TMainMenu
    Left = 112
    Top = 104
    object menuRunAnimation: TMenuItem
      Action = actRunAnimation
    end
  end
  object alActions: TActionList
    Left = 472
    Top = 224
    object actRunAnimation: TAction
      Caption = 'Run animation'
      ShortCut = 120
    end
  end
end
