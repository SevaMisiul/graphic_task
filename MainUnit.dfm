object MainForm: TMainForm
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
  object Player: TMediaPlayer
    Left = 480
    Top = 112
    Width = 253
    Height = 30
    Display = Player
    Visible = False
    TabOrder = 0
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
      OnExecute = actRunAnimationExecute
    end
  end
end
