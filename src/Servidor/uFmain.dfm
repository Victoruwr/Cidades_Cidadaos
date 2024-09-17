object FMain: TFMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Servidor'
  ClientHeight = 178
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object lbStatus: TLabel
    Left = 60
    Top = 25
    Width = 35
    Height = 13
    Caption = 'Status:'
  end
  object Label1: TLabel
    Left = 34
    Top = 70
    Width = 59
    Height = 13
    Caption = 'Port Server:'
  end
  object Label4: TLabel
    Left = 27
    Top = 97
    Width = 66
    Height = 13
    Caption = 'Path Log uso:'
  end
  object ChaveServidor: TToggleSwitch
    Left = 99
    Top = 20
    Width = 72
    Height = 20
    FrameColor = clRed
    TabOrder = 0
    ThumbColor = clRed
    OnClick = ChaveServidorClick
  end
  object EditPortaHorse: TEdit
    Left = 99
    Top = 67
    Width = 65
    Height = 21
    TabOrder = 1
  end
  object EdtPathLog: TEdit
    Left = 99
    Top = 94
    Width = 260
    Height = 21
    TabOrder = 2
  end
  object BbGravarConf: TButton
    Left = 276
    Top = 145
    Width = 83
    Height = 25
    Caption = '&Gravar Config'
    TabOrder = 3
    OnClick = BbGravarConfClick
  end
end
