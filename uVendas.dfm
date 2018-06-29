object frVendas: TfrVendas
  Left = 0
  Top = 0
  Width = 941
  Height = 556
  TabOrder = 0
  object tbAcoes: TToolBar
    Left = 0
    Top = 0
    Width = 941
    Height = 35
    ButtonHeight = 35
    ButtonWidth = 35
    Color = clTeal
    Customizable = True
    DrawingStyle = dsGradient
    GradientEndColor = clGray
    GradientStartColor = clMoneyGreen
    Images = dm.ILImagens
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Transparent = False
    object btNovo: TToolButton
      Left = 0
      Top = 0
      Hint = 'Nova Venda'
      Caption = 'btNovo'
      ImageIndex = 0
      OnClick = btNovoClick
    end
    object btSalvar: TToolButton
      Left = 35
      Top = 0
      Hint = 'Finalizar Venda'
      Caption = 'btSalvar'
      ImageIndex = 13
      OnClick = btSalvarClick
    end
    object btExcluir: TToolButton
      Left = 70
      Top = 0
      Hint = 'Cancelar Venda'
      Caption = 'btExcluir'
      ImageIndex = 2
      OnClick = btExcluirClick
    end
    object btFechar: TToolButton
      Left = 105
      Top = 0
      Hint = 'Fechar aba'
      ImageIndex = 14
      OnClick = btFecharClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 35
    Width = 941
    Height = 246
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 48
      Top = 74
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label3: TLabel
      Left = 48
      Top = 170
      Width = 27
      Height = 13
      Caption = 'Pre'#231'o'
    end
    object Label2: TLabel
      Left = 48
      Top = 122
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Label4: TLabel
      Left = 48
      Top = 26
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object edPreco: TEdit
      Left = 48
      Top = 185
      Width = 109
      Height = 27
      TabStop = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object edProduto: TEdit
      Left = 48
      Top = 89
      Width = 376
      Height = 27
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 1
      OnEnter = edProdutoEnter
      OnKeyUp = edProdutoKeyUp
    end
    object edQuantidade: TEdit
      Left = 48
      Top = 137
      Width = 109
      Height = 27
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edQuantidadeKeyPress
    end
    object edCliente: TEdit
      Left = 48
      Top = 41
      Width = 376
      Height = 27
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 50
      ParentFont = False
      TabOrder = 0
      OnEnter = edClienteEnter
      OnKeyUp = edClienteKeyUp
    end
    object gridPesquisa: TDBGrid
      Left = 464
      Top = 1
      Width = 476
      Height = 244
      Align = alRight
      DataSource = dm.dsGeral
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Visible = False
      OnKeyUp = gridPesquisaKeyUp
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'Nome / Descri'#231#227'o do Produto'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 300
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'UNIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'Unidade'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'Tahoma'
          Title.Font.Style = [fsBold]
          Width = 50
          Visible = True
        end>
    end
    object btItem: TBitBtn
      Left = 272
      Top = 185
      Width = 152
      Height = 27
      Caption = 'Confirmar Item'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 5
      OnClick = btItemClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 499
    Width = 941
    Height = 57
    Align = alBottom
    TabOrder = 2
    object Label20: TLabel
      Left = 305
      Top = 14
      Width = 217
      Height = 29
      Alignment = taRightJustify
      Caption = 'Total do Pedido:  R$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object lbTotal: TLabel
      Left = 647
      Top = 14
      Width = 9
      Height = 29
      Alignment = taRightJustify
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 281
    Width = 941
    Height = 218
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 3
    object gridProdutos: TDBGrid
      Left = 1
      Top = 1
      Width = 939
      Height = 216
      Align = alClient
      Color = clCream
      DataSource = dm.dsVendas
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = gridProdutosCellClick
      OnDrawColumnCell = gridProdutosDrawColumnCell
      OnMouseMove = gridProdutosMouseMove
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Caption = 'QUANTIA'
          Width = 50
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'UNIDADE'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRODUTONOME'
          Title.Caption = 'NOME / DESCRI'#199#195'O DO PRODUTO'
          Width = 339
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECOVENDA'
          Title.Caption = 'PRE'#199'O'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TOTALITEM'
          Title.Caption = 'TOTAL ITEM'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          Width = 23
          Visible = True
        end>
    end
  end
end
