object MainFrom: TMainFrom
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 421
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menuMain
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pbAnimate: TPaintBox
    Left = 0
    Top = 0
    Width = 862
    Height = 421
    Align = alClient
    ExplicitLeft = 568
    ExplicitTop = 232
    ExplicitWidth = 105
    ExplicitHeight = 105
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