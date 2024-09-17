object FCadCidadao: TFCadCidadao
  Left = 0
  Top = 0
  Caption = 'Cadastro de Cidad'#227'os'
  ClientHeight = 536
  ClientWidth = 1041
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
    Width = 1041
    Height = 121
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 26
      Width = 34
      Height = 15
      Caption = 'Nome'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 760
      Top = 48
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
    object Label4: TLabel
      Left = 449
      Top = 25
      Width = 52
      Height = 15
      Caption = 'Endere'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 15
      Top = 66
      Width = 79
      Height = 15
      Caption = 'Complemento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 1039
      Height = 17
      Align = alTop
      Alignment = taCenter
      Caption = 'Insira um Novo Cidad'#227'o'
      Color = clWindow
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitWidth = 149
    end
    object Label6: TLabel
      Left = 361
      Top = 66
      Width = 34
      Height = 15
      Caption = 'Bairro'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 577
      Top = 66
      Width = 37
      Height = 15
      Caption = 'Cidade'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 793
      Top = 66
      Width = 21
      Height = 15
      Caption = 'Cep'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnInserir: TButton
      Left = 923
      Top = 42
      Width = 105
      Height = 62
      Caption = 'Inserir Cidad'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = BtnInserirClick
    end
    object DbedtNome: TDBEdit
      Left = 16
      Top = 42
      Width = 425
      Height = 21
      DataField = 'NOME'
      DataSource = dsCidadao
      TabOrder = 0
    end
    object DbedtUF: TDBEdit
      Left = 361
      Top = 83
      Width = 197
      Height = 21
      DataField = 'BAIRRO'
      DataSource = dsCidadao
      TabOrder = 3
    end
    object DBEdit1: TDBEdit
      Left = 447
      Top = 42
      Width = 466
      Height = 21
      DataField = 'ENDERECO'
      DataSource = dsCidadao
      TabOrder = 1
    end
    object DBEdit2: TDBEdit
      Left = 16
      Top = 83
      Width = 329
      Height = 21
      DataField = 'COMPLEMENTO'
      DataSource = dsCidadao
      TabOrder = 2
    end
    object DblCidade: TDBLookupComboBox
      Left = 577
      Top = 83
      Width = 198
      Height = 21
      DataField = 'CIDADE_ID'
      DataSource = dsCidadao
      KeyField = 'ID'
      ListField = 'NOME'
      ListSource = dsCidades
      TabOrder = 4
    end
    object DBEdit3: TDBEdit
      Left = 793
      Top = 83
      Width = 120
      Height = 21
      DataField = 'CEP'
      DataSource = dsCidadao
      TabOrder = 5
    end
  end
  object pnlcentral: TPanel
    Left = 0
    Top = 121
    Width = 1041
    Height = 415
    Align = alClient
    TabOrder = 1
    object GridCidadao: TDBGrid
      Left = 1
      Top = 1
      Width = 1039
      Height = 413
      Align = alClient
      DataSource = DsTodosCidadaos
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
          Width = 264
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENDERECO'
          Title.Caption = 'Endere'#231'o'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 292
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMPLEMENTO'
          Title.Caption = 'Complemento'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 247
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BAIRRO'
          Title.Caption = 'Bairro'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 222
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CIDADE_ID'
          Title.Caption = 'Cidade ID'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CEP'
          Title.Caption = 'Cep'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USERCAD'
          Title.Caption = 'User Cad'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAHCAD'
          Title.Caption = 'Datah Cad'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAHULTALTER'
          Title.Caption = 'Datah Ult Alter'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'Segoe UI'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
  end
  object cdTodosCidadaos: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeDelete = cdTodosCidadaosBeforeDelete
    Left = 224
    Top = 384
    object cdTodosCidadaosID: TLargeintField
      FieldName = 'ID'
    end
    object cdTodosCidadaosNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object cdTodosCidadaosENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object cdTodosCidadaosCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 100
    end
    object cdTodosCidadaosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 50
    end
    object cdTodosCidadaosCIDADE_ID: TLargeintField
      FieldName = 'CIDADE_ID'
    end
    object cdTodosCidadaosCEP: TStringField
      FieldName = 'CEP'
      Size = 8
    end
    object cdTodosCidadaosUSERCAD: TLargeintField
      FieldName = 'USERCAD'
    end
    object cdTodosCidadaosDATAHCAD: TDateTimeField
      FieldName = 'DATAHCAD'
    end
    object cdTodosCidadaosDATAHULTALTER: TDateTimeField
      FieldName = 'DATAHULTALTER'
    end
  end
  object DsTodosCidadaos: TDataSource
    DataSet = cdTodosCidadaos
    Left = 208
    Top = 312
  end
  object CdCidadao: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterInsert = CdCidadaoAfterInsert
    Left = 136
    Top = 368
    object CdCidadaoNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object CdCidadaoENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object CdCidadaoCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 100
    end
    object CdCidadaoBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 50
    end
    object CdCidadaoCIDADE_ID: TLargeintField
      FieldName = 'CIDADE_ID'
    end
    object CdCidadaoCEP: TStringField
      FieldName = 'CEP'
      Size = 8
    end
    object CdCidadaoUSERCAD: TLargeintField
      FieldName = 'USERCAD'
    end
    object CdCidadaoDATAHCAD: TDateTimeField
      FieldName = 'DATAHCAD'
    end
    object CdCidadaoDATAHULTALTER: TDateTimeField
      FieldName = 'DATAHULTALTER'
    end
  end
  object dsCidadao: TDataSource
    DataSet = CdCidadao
    Left = 136
    Top = 312
  end
  object cdCidades: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterInsert = CdCidadaoAfterInsert
    Left = 56
    Top = 384
    object cdCidadesID: TLargeintField
      FieldName = 'ID'
    end
    object StringField1: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  object dsCidades: TDataSource
    DataSet = cdCidades
    Left = 56
    Top = 320
  end
end
