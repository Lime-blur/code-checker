object Form1: TForm1
  Left = 243
  Top = 221
  BorderStyle = bsDialog
  Caption = 'Code checker'
  ClientHeight = 271
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sLabelFX1: TsLabelFX
    Left = 0
    Top = -8
    Width = 281
    Height = 41
    Alignment = taCenter
    AutoSize = False
    Caption = #1051#1086#1075#1080#1085':'
    ParentFont = False
    Layout = tlCenter
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -2
    Shadow.OffsetKeeper.RightBottom = 4
    Shadow.Color = clWhite
    Shadow.BlurCount = 5
  end
  object sLabelFX2: TsLabelFX
    Left = 8
    Top = 72
    Width = 273
    Height = 41
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1072#1088#1086#1083#1100':'
    ParentFont = False
    Layout = tlCenter
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -2
    Shadow.OffsetKeeper.RightBottom = 4
    Shadow.Color = clWhite
    Shadow.BlurCount = 5
  end
  object sLabelFX3: TsLabelFX
    Left = 288
    Top = 0
    Width = 145
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 'Online:'
    ParentFont = False
    Layout = tlCenter
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    Angle = 0
    Shadow.OffsetKeeper.LeftTop = -2
    Shadow.OffsetKeeper.RightBottom = 4
    Shadow.Color = clWhite
    Shadow.BlurCount = 5
  end
  object sLabel1: TsLabel
    Left = 8
    Top = 248
    Width = 273
    Height = 25
    AutoSize = False
    Caption = #1042#1099' '#1085#1077' '#1074#1086#1096#1083#1080' '#1074' '#1072#1082#1082#1072#1091#1085#1090'.'
    Color = clBtnFace
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
  end
  object sEdit1: TsEdit
    Left = 8
    Top = 40
    Width = 273
    Height = 21
    TabOrder = 0
  end
  object sMaskEdit1: TsMaskEdit
    Left = 8
    Top = 120
    Width = 273
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    CheckOnExit = True
  end
  object sListBox1: TsListBox
    Left = 288
    Top = 40
    Width = 145
    Height = 217
    ItemHeight = 16
    TabOrder = 2
  end
  object sButton1: TsButton
    Left = 8
    Top = 150
    Width = 81
    Height = 33
    Caption = #1042#1086#1081#1090#1080
    TabOrder = 3
    OnClick = sButton1Click
  end
  object sButton2: TsButton
    Left = 96
    Top = 150
    Width = 89
    Height = 33
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
    TabOrder = 4
    OnClick = sButton2Click
  end
  object sButton3: TsButton
    Left = 192
    Top = 150
    Width = 89
    Height = 33
    Caption = #1042#1099#1081#1090#1080
    Enabled = False
    TabOrder = 5
    OnClick = sButton3Click
  end
  object sButton4: TsButton
    Left = 8
    Top = 210
    Width = 273
    Height = 33
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1095#1072#1090
    Enabled = False
    TabOrder = 6
    OnClick = sButton4Click
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 328
    Top = 56
  end
  object sSkinManager1: TsSkinManager
    AnimEffects.BlendOnMoving.Active = True
    AnimEffects.BlendOnMoving.Time = 200
    AnimEffects.BlendOnMoving.BlendValue = 150
    ButtonsOptions.OldGlyphsMode = True
    ExtendedBorders = True
    InternalSkins = <>
    Fonts.MainMode = fmFromSkin
    SkinDirectory = 
      'C:\Program Files (x86)\Borland\Delphi7\Source\AlphaControls\Skin' +
      's'
    SkinName = 'Lime'#39's Projects Skin'
    SkinInfo = '12'
    ThirdParty.ThirdEdits = ' '
    ThirdParty.ThirdButtons = 'TButton'
    ThirdParty.ThirdBitBtns = ' '
    ThirdParty.ThirdCheckBoxes = ' '
    ThirdParty.ThirdGroupBoxes = ' '
    ThirdParty.ThirdListViews = ' '
    ThirdParty.ThirdPanels = ' '
    ThirdParty.ThirdGrids = ' '
    ThirdParty.ThirdTreeViews = ' '
    ThirdParty.ThirdComboBoxes = ' '
    ThirdParty.ThirdWWEdits = ' '
    ThirdParty.ThirdVirtualTrees = ' '
    ThirdParty.ThirdGridEh = ' '
    ThirdParty.ThirdPageControl = ' '
    ThirdParty.ThirdTabControl = ' '
    ThirdParty.ThirdToolBar = ' '
    ThirdParty.ThirdStatusBar = ' '
    ThirdParty.ThirdSpeedButton = ' '
    ThirdParty.ThirdScrollControl = ' '
    ThirdParty.ThirdUpDown = ' '
    ThirdParty.ThirdScrollBar = ' '
    ThirdParty.ThirdStaticText = ' '
    ThirdParty.ThirdNativePaint = ' '
    Left = 296
    Top = 56
  end
  object Timer2: TTimer
    Interval = 80
    OnTimer = Timer2Timer
    Left = 360
    Top = 56
  end
end
