object LoginView: TLoginView
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 434
  ClientWidth = 519
  Color = clBtnFace
  Constraints.MinHeight = 473
  Constraints.MinWidth = 535
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 519
    Height = 434
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 519
      Height = 81
      Align = alTop
      BevelOuter = bvNone
      Color = 4803146
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 519
        Height = 81
        Align = alClient
        Alignment = taCenter
        Caption = 'VENDAS'
        Color = 4803146
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -53
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 195
        ExplicitHeight = 64
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 81
      Width = 519
      Height = 353
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Panel6: TPanel
        AlignWithMargins = True
        Left = 50
        Top = 50
        Width = 419
        Height = 253
        Margins.Left = 50
        Margins.Top = 50
        Margins.Right = 50
        Margins.Bottom = 50
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object lblServidor: TLabel
          Left = 32
          Top = 29
          Width = 44
          Height = 13
          Caption = 'Servidor:'
          FocusControl = edtServidor
        end
        object lblUsuario: TLabel
          Left = 32
          Top = 77
          Width = 40
          Height = 13
          Caption = 'Usu'#225'rio:'
          FocusControl = edtUsuario
        end
        object lblSenha: TLabel
          Left = 171
          Top = 77
          Width = 34
          Height = 13
          Caption = 'Senha:'
          FocusControl = edtSenha
        end
        object lblDatabase: TLabel
          Left = 32
          Top = 125
          Width = 50
          Height = 13
          Caption = 'Database:'
          FocusControl = edtDatabase
        end
        object lblPorta: TLabel
          Left = 296
          Top = 29
          Width = 30
          Height = 13
          Caption = 'Porta:'
          FocusControl = edtPorta
        end
        object edtServidor: TEdit
          Left = 32
          Top = 48
          Width = 249
          Height = 21
          TabOrder = 0
          Text = 'localhost'
          OnKeyPress = edtServidorKeyPress
        end
        object edtUsuario: TEdit
          Left = 32
          Top = 96
          Width = 133
          Height = 21
          TabOrder = 2
          Text = 'root'
          OnKeyPress = edtServidorKeyPress
        end
        object edtSenha: TEdit
          Left = 171
          Top = 96
          Width = 110
          Height = 21
          PasswordChar = '*'
          TabOrder = 3
          Text = 'root'
          OnKeyPress = edtServidorKeyPress
        end
        object edtDatabase: TEdit
          Left = 32
          Top = 144
          Width = 353
          Height = 21
          TabOrder = 5
          Text = 'vendas'
          OnKeyPress = edtServidorKeyPress
        end
        object btnConectar: TButton
          Left = 136
          Top = 184
          Width = 145
          Height = 41
          Caption = 'Conectar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = btnConectarClick
        end
        object edtPorta: TEdit
          Left = 296
          Top = 48
          Width = 89
          Height = 21
          TabOrder = 1
          Text = '3306'
          OnKeyPress = edtServidorKeyPress
        end
        object ckbSalvarSenha: TCheckBox
          Left = 296
          Top = 98
          Width = 89
          Height = 17
          Caption = 'Salvar Senha'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnKeyPress = edtServidorKeyPress
        end
      end
    end
  end
end
