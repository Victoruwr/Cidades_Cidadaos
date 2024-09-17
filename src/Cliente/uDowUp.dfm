object FDowUp: TFDowUp
  Left = 0
  Top = 0
  Caption = 'Arquivos Download e Upload'
  ClientHeight = 329
  ClientWidth = 569
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
    Width = 569
    Height = 17
    Align = alTop
    Alignment = taCenter
    Caption = 'Fa'#231'a Download ou Upload dos Arquivos'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ExplicitWidth = 247
  end
  object Panel1: TPanel
    Left = 0
    Top = 17
    Width = 569
    Height = 271
    Align = alClient
    TabOrder = 0
    ExplicitTop = 312
    ExplicitWidth = 640
    ExplicitHeight = 63
    object grid: TDBGrid
      Left = 1
      Top = 1
      Width = 567
      Height = 266
      Align = alClient
      DataSource = DsTodosArquivos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TITULO'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EXT'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ARQ'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 118
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 288
    Width = 569
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BtnDownload: TBitBtn
      Left = 191
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Download'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BtnDownloadClick
    end
    object BtnUpload: TBitBtn
      Left = 272
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Upload'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BtnUploadClick
    end
  end
  object cdArquivo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 208
    object cdArquivoTITULO: TStringField
      FieldName = 'TITULO'
      Size = 50
    end
    object cdArquivoEXT: TStringField
      FieldName = 'EXT'
      Size = 6
    end
    object cdArquivoARQ: TBlobField
      FieldName = 'ARQ'
    end
  end
  object OpenDialog: TOpenDialog
    Left = 320
    Top = 224
  end
  object SaveDialog: TSaveDialog
    Left = 256
    Top = 208
  end
  object CdTodosArquivos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 200
    object CdTodosArquivosID: TLargeintField
      FieldName = 'ID'
    end
    object StringField1: TStringField
      FieldName = 'TITULO'
      Size = 50
    end
    object StringField2: TStringField
      FieldName = 'EXT'
      Size = 6
    end
    object BlobField1: TBlobField
      FieldName = 'ARQ'
    end
  end
  object DsTodosArquivos: TDataSource
    DataSet = CdTodosArquivos
    Left = 56
    Top = 204
  end
end
