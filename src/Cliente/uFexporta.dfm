object Fexporta: TFexporta
  Left = 0
  Top = 0
  Caption = 'Fexporta'
  ClientHeight = 109
  ClientWidth = 601
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
  object Label2: TLabel
    Left = 0
    Top = 0
    Width = 601
    Height = 17
    Align = alTop
    Alignment = taCenter
    Caption = 'Selecione um local para Exportar .CSV'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ExplicitWidth = 234
  end
  object EdPath: TEdit
    Left = 8
    Top = 32
    Width = 497
    Height = 21
    TabOrder = 0
  end
  object BtnSelecione: TButton
    Left = 511
    Top = 30
    Width = 75
    Height = 25
    Caption = 'Selecione'
    TabOrder = 1
    OnClick = BtnSelecioneClick
  end
  object BtnExportar: TButton
    Left = 8
    Top = 59
    Width = 107
    Height = 32
    Caption = 'Exportar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtnExportarClick
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'Arquivos CSV|*.csv'
    Left = 464
  end
  object cdCSV: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 24
    object cdCSVID: TLargeintField
      FieldName = 'ID'
    end
    object cdCSVNOME: TStringField
      FieldName = 'NOME'
    end
    object cdCSVENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object cdCSVCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 100
    end
    object cdCSVBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 50
    end
    object cdCSVCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object cdCSVUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdCSVCEP: TStringField
      FieldName = 'CEP'
      Size = 8
    end
  end
end
