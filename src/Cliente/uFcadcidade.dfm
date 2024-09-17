object FCadCidade: TFCadCidade
  Left = 0
  Top = 0
  Caption = 'Cadastro de Cidades'
  ClientHeight = 441
  ClientWidth = 731
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
  object PnlTop: TPanel
    Left = 0
    Top = 0
    Width = 731
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 147
      Height = 17
      Align = alTop
      Alignment = taCenter
      Caption = 'Insira uma Nova Cidade'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 18
      Width = 74
      Height = 15
      Caption = 'Nome Cidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 472
      Top = 18
      Width = 15
      Height = 15
      Caption = 'UF'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnInserir: TButton
      Left = 600
      Top = 18
      Width = 105
      Height = 40
      Caption = 'Inserir Cidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BtnInserirClick
    end
    object DbedtNome: TDBEdit
      Left = 24
      Top = 34
      Width = 425
      Height = 21
      DataField = 'NOME'
      DataSource = dsCidade
      TabOrder = 0
    end
    object DbedtUF: TDBEdit
      Left = 473
      Top = 34
      Width = 86
      Height = 21
      DataField = 'UF'
      DataSource = dsCidade
      TabOrder = 1
    end
  end
  object PnlCentro: TPanel
    Left = 0
    Top = 65
    Width = 731
    Height = 376
    Align = alClient
    TabOrder = 1
    object GridCidade: TDBGrid
      Left = 1
      Top = 1
      Width = 729
      Height = 374
      Align = alClient
      DataSource = DsTodasCidade
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
          Title.Caption = 'Id'
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
          FieldName = 'NOME'
          Title.Caption = 'Nome'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 183
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USERCAD'
          Title.Caption = 'Usu'#225'rio Cad'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAHCAD'
          Title.Caption = 'Data Hora Cad'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 118
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAHULTALTER'
          Title.Caption = 'Data Hora Ult Alt'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 132
          Visible = True
        end>
    end
  end
  object cdTodasCidades: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeDelete = cdTodasCidadesBeforeDelete
    Left = 664
    Top = 368
    object cdTodasCidadesID: TLargeintField
      FieldName = 'ID'
    end
    object cdTodasCidadesNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdTodasCidadesUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdTodasCidadesUSERCAD: TIntegerField
      FieldName = 'USERCAD'
    end
    object cdTodasCidadesDATAHCAD: TDateTimeField
      FieldName = 'DATAHCAD'
    end
    object cdTodasCidadesDATAHULTALTER: TDateTimeField
      FieldName = 'DATAHULTALTER'
    end
  end
  object DsTodasCidade: TDataSource
    DataSet = cdTodasCidades
    Left = 664
    Top = 320
  end
  object CdCidade: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterInsert = CdCidadeAfterInsert
    Left = 600
    Top = 368
    object StringField1: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object StringField2: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object IntegerField1: TIntegerField
      FieldName = 'USERCAD'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DATAHCAD'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'DATAHULTALTER'
    end
  end
  object dsCidade: TDataSource
    DataSet = CdCidade
    Left = 600
    Top = 320
  end
end
