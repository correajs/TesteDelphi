object frCad_Produtos: TfrCad_Produtos
  Left = 0
  Top = 0
  Width = 985
  Height = 581
  TabOrder = 0
  object tbAcoes: TToolBar
    Left = 0
    Top = 0
    Width = 985
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
    ExplicitLeft = -25
    ExplicitWidth = 1010
    object btNovo: TToolButton
      Left = 0
      Top = 0
      Hint = 'Novo'
      Caption = 'btNovo'
      ImageIndex = 0
      OnClick = btNovoClick
    end
    object btSalvar: TToolButton
      Left = 35
      Top = 0
      Hint = 'Salvar'
      Caption = 'btSalvar'
      ImageIndex = 1
      OnClick = btSalvarClick
    end
    object btExcluir: TToolButton
      Left = 70
      Top = 0
      Hint = 'Excluir'
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
    Width = 985
    Height = 198
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 48
      Top = 28
      Width = 27
      Height = 13
      Caption = 'Nome'
    end
    object Label2: TLabel
      Left = 48
      Top = 76
      Width = 39
      Height = 13
      Caption = 'Unidade'
    end
    object Label3: TLabel
      Left = 48
      Top = 126
      Width = 27
      Height = 13
      Caption = 'Pre'#231'o'
    end
    object cbUnidade: TComboBox
      Left = 48
      Top = 91
      Width = 109
      Height = 21
      ItemIndex = 0
      TabOrder = 0
      Text = 'UND'
      Items.Strings = (
        'UND'
        'KG'
        'CX'
        'SC'
        'P'#199
        'M')
    end
    object edPreco: TEdit
      Left = 48
      Top = 141
      Width = 109
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      OnKeyPress = edPrecoKeyPress
    end
    object edNome: TEdit
      Left = 48
      Top = 43
      Width = 376
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 233
    Width = 985
    Height = 57
    Align = alTop
    TabOrder = 2
    ExplicitLeft = -25
    ExplicitTop = 361
    ExplicitWidth = 1010
    object Label13: TLabel
      Left = 48
      Top = 21
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pesquisar por:   '
      Layout = tlCenter
    end
    object Label20: TLabel
      Left = 472
      Top = 21
      Width = 60
      Height = 13
      Caption = 'No campo:   '
      Layout = tlCenter
    end
    object cbPesquisa: TComboBox
      Left = 538
      Top = 18
      Width = 139
      Height = 21
      ItemIndex = 0
      TabOrder = 0
      Text = 'NOME'
      Items.Strings = (
        'NOME'
        'UNIDADE')
    end
    object edPesquisa: TEdit
      Left = 132
      Top = 18
      Width = 292
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      OnKeyUp = edPesquisaKeyUp
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 290
    Width = 985
    Height = 291
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 3
    ExplicitLeft = -25
    ExplicitTop = 418
    ExplicitWidth = 1010
    ExplicitHeight = 161
    object gridProdutos: TDBGrid
      Left = 1
      Top = 1
      Width = 983
      Height = 289
      Align = alClient
      DataSource = dm.dsGeral
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = gridProdutosCellClick
      OnKeyUp = gridProdutosKeyUp
      Columns = <
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'NOME / DESCRI'#199#195'O DO PRODUTO'
          Width = 339
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
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PRECO'
          Title.Caption = 'PRE'#199'O'
          Width = 100
          Visible = True
        end>
    end
  end
end
