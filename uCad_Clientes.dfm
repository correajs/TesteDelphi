object frCad_Clientes: TfrCad_Clientes
  Left = 0
  Top = 0
  Width = 1010
  Height = 579
  TabOrder = 0
  object tbAcoes: TToolBar
    Left = 0
    Top = 0
    Width = 1010
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
    Width = 1010
    Height = 326
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 48
      Top = 28
      Width = 20
      Height = 13
      Caption = 'Tipo'
    end
    object Label10: TLabel
      Left = 573
      Top = 158
      Width = 51
      Height = 13
      Caption = 'Telefone 2'
    end
    object Label11: TLabel
      Left = 675
      Top = 158
      Width = 33
      Height = 13
      Caption = 'Celular'
    end
    object Label12: TLabel
      Left = 785
      Top = 158
      Width = 18
      Height = 13
      Caption = 'Fax'
    end
    object Label14: TLabel
      Left = 47
      Top = 204
      Width = 28
      Height = 13
      Caption = 'E-mail'
    end
    object Label15: TLabel
      Left = 472
      Top = 204
      Width = 39
      Height = 13
      Caption = 'Contato'
    end
    object Label16: TLabel
      Left = 47
      Top = 248
      Width = 41
      Height = 13
      Caption = 'C.N.P.J.'
    end
    object Label17: TLabel
      Left = 201
      Top = 248
      Width = 87
      Height = 13
      Caption = 'Inscri'#231#227'o Estadual'
    end
    object Label18: TLabel
      Left = 472
      Top = 248
      Width = 22
      Height = 13
      Caption = 'R.G.'
    end
    object Label19: TLabel
      Left = 344
      Top = 248
      Width = 31
      Height = 13
      Caption = 'C.P.F.'
    end
    object Label2: TLabel
      Left = 48
      Top = 70
      Width = 97
      Height = 13
      Caption = 'Raz'#227'o Social / Nome'
    end
    object Label3: TLabel
      Left = 472
      Top = 70
      Width = 71
      Height = 13
      Caption = 'Nome Fantasia'
    end
    object Label4: TLabel
      Left = 48
      Top = 114
      Width = 55
      Height = 13
      Caption = 'Logradouro'
    end
    object Label5: TLabel
      Left = 472
      Top = 114
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object Label6: TLabel
      Left = 48
      Top = 158
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object Label7: TLabel
      Left = 308
      Top = 158
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object Label8: TLabel
      Left = 379
      Top = 158
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object Label9: TLabel
      Left = 471
      Top = 158
      Width = 51
      Height = 13
      Caption = 'Telefone 1'
    end
    object cbTipo: TComboBox
      Left = 48
      Top = 43
      Width = 109
      Height = 21
      ItemIndex = 0
      TabOrder = 0
      Text = 'F'#205'SICA'
      Items.Strings = (
        'F'#205'SICA'
        'JUR'#205'DICA')
    end
    object cbUf: TComboBox
      Left = 308
      Top = 173
      Width = 38
      Height = 21
      ItemIndex = 3
      TabOrder = 1
      Text = 'AM'
      Items.Strings = (
        'AC'
        'AL'
        'AP'
        'AM'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MT'
        'MS'
        'MG'
        'PA'
        'PB'
        'PR'
        'PE'
        'PI'
        'RJ'
        'RN'
        'RS'
        'RO'
        'RR'
        'SC'
        'SP'
        'SE'
        'TO')
    end
    object chkStatus: TCheckBox
      Left = 765
      Top = 265
      Width = 106
      Height = 17
      BiDiMode = bdRightToLeft
      Caption = 'Cliente Ativo'
      Checked = True
      ParentBiDiMode = False
      State = cbChecked
      TabOrder = 2
    end
    object edBairro: TEdit
      Left = 472
      Top = 129
      Width = 400
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 3
    end
    object edCelular: TMaskEdit
      Left = 675
      Top = 173
      Width = 92
      Height = 21
      EditMask = '!\(999\) 99999-9999;0; '
      MaxLength = 16
      TabOrder = 4
      Text = ''
    end
    object edCep: TMaskEdit
      Left = 379
      Top = 173
      Width = 69
      Height = 21
      EditMask = '00000\-999;0; '
      MaxLength = 9
      TabOrder = 5
      Text = ''
    end
    object edCidade: TEdit
      Left = 48
      Top = 173
      Width = 214
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 6
    end
    object edCnpj: TMaskEdit
      Left = 47
      Top = 263
      Width = 117
      Height = 21
      EditMask = '000\.000\.000\/0000\-00;0; '
      MaxLength = 19
      TabOrder = 7
      Text = ''
    end
    object edContato: TEdit
      Left = 472
      Top = 219
      Width = 400
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 8
    end
    object edCpf: TMaskEdit
      Left = 344
      Top = 263
      Width = 103
      Height = 21
      EditMask = '000\.000\.000\-00;0; '
      MaxLength = 14
      TabOrder = 9
      Text = ''
    end
    object edEmail: TEdit
      Left = 47
      Top = 219
      Width = 400
      Height = 21
      CharCase = ecLowerCase
      MaxLength = 50
      TabOrder = 10
    end
    object edFantasia: TEdit
      Left = 472
      Top = 85
      Width = 400
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 11
    end
    object edFax: TMaskEdit
      Left = 785
      Top = 173
      Width = 87
      Height = 21
      EditMask = '!\(999\) 9999-9999;0; '
      MaxLength = 15
      TabOrder = 12
      Text = ''
    end
    object edFone1: TMaskEdit
      Left = 472
      Top = 173
      Width = 83
      Height = 21
      EditMask = '!\(999\) 9999-9999;0; '
      MaxLength = 15
      TabOrder = 13
      Text = ''
    end
    object edFone2: TMaskEdit
      Left = 573
      Top = 173
      Width = 81
      Height = 21
      EditMask = '!\(999\) 9999-9999;0; '
      MaxLength = 15
      TabOrder = 14
      Text = ''
    end
    object edIe: TEdit
      Left = 201
      Top = 263
      Width = 102
      Height = 21
      MaxLength = 15
      TabOrder = 15
    end
    object edLogradouro: TEdit
      Left = 48
      Top = 129
      Width = 400
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 16
    end
    object edRazaoSocial: TEdit
      Left = 48
      Top = 85
      Width = 400
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 17
    end
    object edRg: TEdit
      Left = 472
      Top = 263
      Width = 109
      Height = 21
      MaxLength = 10
      TabOrder = 18
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 361
    Width = 1010
    Height = 57
    Align = alTop
    TabOrder = 2
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
      Text = 'RAZ'#195'O SOCIAL'
      Items.Strings = (
        'RAZ'#195'O SOCIAL'
        'NOME FANTASIA'
        'LOGRADOURO'
        'BAIRRO'
        'CNPJ'
        'CPF'
        'RG'
        'ATIVO')
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
    Top = 418
    Width = 1010
    Height = 161
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 3
    object gridClientes: TDBGrid
      Left = 1
      Top = 1
      Width = 1008
      Height = 159
      Align = alClient
      DataSource = dm.dsGeral
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = gridClientesCellClick
      OnKeyUp = gridClientesKeyUp
      Columns = <
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'RAZ'#195'O SOCIAL / NOME'
          Width = 339
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNPJ'
          Title.Caption = 'C.N.P.J.'
          Width = 113
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CPF'
          Title.Caption = 'C.P.F.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENDERECO_BAIRROS'
          Title.Caption = 'BAIRRO'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ENDERECO_RUA'
          Title.Caption = 'LOGRADOURO'
          Width = 400
          Visible = True
        end>
    end
  end
end
