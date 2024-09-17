object fRelaotrios: TfRelaotrios
  Left = 0
  Top = 0
  Caption = 'fRelaotrios'
  ClientHeight = 265
  ClientWidth = 428
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
    Width = 428
    Height = 17
    Align = alTop
    Alignment = taCenter
    Caption = 'Selecione um Relat'#243'rio e Clique em Imprimir'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ExplicitWidth = 277
  end
  object BtnImprimir: TButton
    Left = 297
    Top = 33
    Width = 80
    Height = 35
    Caption = 'Imprimir'
    TabOrder = 0
    OnClick = BtnImprimirClick
  end
  object cbRel: TComboBox
    Left = 24
    Top = 40
    Width = 249
    Height = 21
    ItemIndex = 0
    TabOrder = 1
    Text = 'Reat'#243'rio de Cidad'#227'os'
    OnChange = cbRelChange
    Items.Strings = (
      'Reat'#243'rio de Cidad'#227'os'
      'Relat'#243'rio de Total Cidad'#227'os por Cidade'
      'Relat'#243'rio Totais por Bairros')
  end
  object DblCidade: TDBLookupComboBox
    Left = 24
    Top = 83
    Width = 249
    Height = 21
    DataField = 'CIDADE_ID'
    KeyField = 'ID'
    ListField = 'NOME'
    ListSource = dsCidades
    TabOrder = 2
  end
  object Frx: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    DataSet = CdRelatorioCidadao
    BCDToCurrency = False
    Left = 128
    Top = 176
  end
  object Relatorios: TfrxReport
    Version = '5.1.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45494.939930405100000000
    ReportOptions.LastChange = 45499.965865312500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 16
    Top = 128
    Datasets = <
      item
        DataSet = frxBairroCidadao
        DataSetName = 'frxBairroCidadao'
      end
      item
        DataSet = frxBairroTOT
        DataSetName = 'frxBairroTOT'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 264.567100000000000000
          Top = 15.118120000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Relat'#243'rio de Moradores por Bairro')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 120.944960000000000000
        Width = 718.110700000000000000
        DataSet = frxBairroTOT
        DataSetName = 'frxBairroTOT'
        RowCount = 0
        object Memo2: TfrxMemoView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Bairro:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Align = baWidth
          Left = 461.102660000000000000
          Top = 3.779530000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Tortal:')
          ParentFont = False
        end
        object frxBairroTOTBAIRRO: TfrxMemoView
          Align = baWidth
          Left = 60.472480000000000000
          Top = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataField = 'BAIRRO'
          DataSet = frxBairroTOT
          DataSetName = 'frxBairroTOT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxBairroTOT."BAIRRO"]')
          ParentFont = False
        end
        object frxBairroTOTTOT: TfrxMemoView
          Align = baWidth
          Left = 555.590910000000000000
          Top = 3.779530000000000000
          Width = 162.519790000000000000
          Height = 18.897650000000000000
          DataField = 'TOT'
          DataSet = frxBairroTOT
          DataSetName = 'frxBairroTOT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxBairroTOT."TOT"]')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 30.236240000000000000
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        DataSet = frxBairroCidadao
        DataSetName = 'frxBairroCidadao'
        RowCount = 0
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = 4.779530000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente:')
          ParentFont = False
        end
        object frxBairroCidadaoNOME: TfrxMemoView
          Left = 60.252010000000000000
          Top = 4.779530000000000000
          Width = 718.110700000000000000
          Height = 18.897650000000000000
          DataField = 'NOME'
          DataSet = frxBairroCidadao
          DataSetName = 'frxBairroCidadao'
          Memo.UTF8W = (
            '[frxBairroCidadao."NOME"]')
        end
      end
    end
  end
  object CdRelatorioCidadao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 120
    object CdRelatorioCidadaocodigo: TLargeintField
      FieldName = 'codigo'
    end
    object CdRelatorioCidadaocidadaoname: TStringField
      FieldName = 'cidadaoname'
      Size = 50
    end
    object CdRelatorioCidadaouf: TStringField
      FieldName = 'uf'
      Size = 2
    end
    object CdRelatorioCidadaocep: TStringField
      FieldName = 'cep'
      Size = 8
    end
    object CdRelatorioCidadaoenderecocompl: TStringField
      FieldName = 'enderecocompl'
      Size = 100
    end
    object CdRelatorioCidadaocidadename: TStringField
      FieldName = 'cidadename'
      Size = 100
    end
  end
  object CdRelatorioCidade: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 120
    object CdRelatorioCidadetotal: TIntegerField
      FieldName = 'total'
    end
    object CdRelatorioCidadecidadeid: TLargeintField
      FieldName = 'cidadeid'
    end
    object CdRelatorioCidadenomecidade: TStringField
      FieldName = 'nomecidade'
      Size = 100
    end
    object CdRelatorioCidadeufcidade: TStringField
      FieldName = 'ufcidade'
      Size = 2
    end
  end
  object CDRelBairroTOT: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 112
    object CDRelBairroTOTBAIRRO: TStringField
      FieldName = 'BAIRRO'
      KeyFields = 'BAIRRO'
      Size = 50
    end
    object CDRelBairroTOTTOT: TIntegerField
      FieldName = 'TOT'
    end
  end
  object frxBairroTOT: TfrxDBDataset
    UserName = 'frxBairroTOT'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 16
    Top = 176
  end
  object frxBairroCidadao: TfrxDBDataset
    UserName = 'frxBairroCidadao'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 72
    Top = 176
  end
  object DsBairroCidadao: TDataSource
    DataSet = CdRelBairroCidadao
    Left = 208
    Top = 168
  end
  object DsBairroToT: TDataSource
    DataSet = CDRelBairroTOT
    Left = 296
    Top = 168
  end
  object CdRelBairroCidadao: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'BAIRRO'
    MasterFields = 'BAIRRO'
    MasterSource = DsBairroToT
    PacketRecords = 0
    Params = <>
    Left = 216
    Top = 120
    object CdRelBairroCidadaoNOME: TStringField
      FieldName = 'NOME'
      Size = 50
    end
    object CdRelBairroCidadaoBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 50
    end
  end
  object dsCidades: TDataSource
    DataSet = cdCidades
    Left = 350
    Top = 124
  end
  object cdCidades: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 350
    Top = 180
    object cdCidadesID: TLargeintField
      FieldName = 'ID'
    end
    object StringField1: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
end
