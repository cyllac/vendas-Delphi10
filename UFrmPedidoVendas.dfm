object PedidoVendasView: TPedidoVendasView
  Left = 0
  Top = 0
  Caption = 'PedidoVendasView'
  ClientHeight = 522
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 806
    Height = 522
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = -278
    ExplicitTop = -237
    ExplicitWidth = 832
    ExplicitHeight = 526
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 806
      Height = 129
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 832
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 806
        Height = 65
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 832
        object Button2: TButton
          AlignWithMargins = True
          Left = 246
          Top = 10
          Width = 49
          Height = 0
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 100
          Align = alLeft
          Caption = 'Button1'
          TabOrder = 0
        end
        object Button3: TButton
          AlignWithMargins = True
          Left = 10
          Top = 10
          Width = 49
          Height = 45
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 0
          Margins.Bottom = 10
          Align = alLeft
          TabOrder = 1
        end
        object Button4: TButton
          AlignWithMargins = True
          Left = 69
          Top = 10
          Width = 49
          Height = 45
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 0
          Margins.Bottom = 10
          Align = alLeft
          TabOrder = 2
        end
        object Button5: TButton
          AlignWithMargins = True
          Left = 128
          Top = 10
          Width = 49
          Height = 45
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 0
          Margins.Bottom = 10
          Align = alLeft
          TabOrder = 3
        end
        object Button6: TButton
          AlignWithMargins = True
          Left = 187
          Top = 10
          Width = 49
          Height = 45
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 0
          Margins.Bottom = 10
          Align = alLeft
          TabOrder = 4
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 65
        Width = 806
        Height = 64
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitWidth = 832
        object Label1: TLabel
          Left = 10
          Top = 7
          Width = 37
          Height = 13
          Caption = 'Cliente:'
        end
        object DBEdit2: TDBEdit
          Left = 144
          Top = 26
          Width = 377
          Height = 21
          TabOrder = 0
        end
        object DBEdit1: TDBEdit
          Left = 10
          Top = 26
          Width = 108
          Height = 21
          TabOrder = 1
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 129
      Width = 806
      Height = 347
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 832
      ExplicitHeight = 351
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 806
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitWidth = 832
        object DBEdit3: TDBEdit
          Left = 10
          Top = 14
          Width = 108
          Height = 21
          TabOrder = 0
        end
        object DBEdit4: TDBEdit
          Left = 144
          Top = 14
          Width = 289
          Height = 21
          TabOrder = 1
        end
        object DBEdit5: TDBEdit
          Left = 439
          Top = 14
          Width = 89
          Height = 21
          TabOrder = 2
        end
        object DBEdit6: TDBEdit
          Left = 534
          Top = 14
          Width = 89
          Height = 21
          TabOrder = 3
        end
        object DBEdit7: TDBEdit
          Left = 629
          Top = 14
          Width = 89
          Height = 21
          TabOrder = 4
        end
        object Button1: TButton
          Left = 724
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 5
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 41
        Width = 806
        Height = 306
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 8
        TabOrder = 1
        ExplicitWidth = 832
        ExplicitHeight = 310
        object DBGrid1: TDBGrid
          Left = 8
          Top = 8
          Width = 790
          Height = 290
          Align = alClient
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 476
      Width = 806
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitTop = 480
      ExplicitWidth = 832
      object DBEdit8: TDBEdit
        Left = 696
        Top = 6
        Width = 89
        Height = 21
        TabOrder = 0
      end
    end
  end
end
