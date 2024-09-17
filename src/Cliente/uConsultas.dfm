object Fconsulta: TFconsulta
  Left = 0
  Top = 0
  Caption = 'Fconsultas'
  ClientHeight = 427
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 502
    Height = 17
    Align = alTop
    Alignment = taCenter
    Caption = 'Consulta por ID Cidade e Cidad'#227'os'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ExplicitWidth = 214
  end
  object Label3: TLabel
    Left = 24
    Top = 31
    Width = 53
    Height = 15
    Caption = 'ID Cidade'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 256
    Top = 29
    Width = 59
    Height = 15
    Caption = 'ID Cidad'#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 24
    Top = 88
    Width = 121
    Height = 15
    Caption = 'Resposta WebService'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object EdtCidade: TEdit
    Left = 24
    Top = 48
    Width = 105
    Height = 21
    NumbersOnly = True
    TabOrder = 0
  end
  object BtnConsultarCidade: TButton
    Left = 135
    Top = 46
    Width = 106
    Height = 25
    Caption = 'Consultar Cidade'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BtnConsultarCidadeClick
  end
  object Memo: TMemo
    Left = 24
    Top = 109
    Width = 457
    Height = 300
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object EdtCidadao: TEdit
    Left = 256
    Top = 48
    Width = 105
    Height = 21
    NumbersOnly = True
    TabOrder = 3
  end
  object BtnConsultarCidadao: TButton
    Left = 367
    Top = 46
    Width = 114
    Height = 25
    Caption = 'Consultar Cidad'#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BtnConsultarCidadaoClick
  end
end
