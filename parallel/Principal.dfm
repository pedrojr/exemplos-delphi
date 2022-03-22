object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'frmPrincipal'
  ClientHeight = 384
  ClientWidth = 537
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnMA1: TButton
    Left = 8
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Listar Itens'
    TabOrder = 0
    OnClick = btnMA1Click
  end
  object Memo: TMemo
    Left = 170
    Top = 39
    Width = 287
    Height = 248
    TabOrder = 1
  end
  object btnMA2: TButton
    Left = 170
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Processar'
    TabOrder = 2
    OnClick = btnMA2Click
  end
  object ListBox: TListBox
    Left = 8
    Top = 39
    Width = 156
    Height = 186
    ItemHeight = 13
    Items.Strings = (
      'ITEM 01'
      'ITEM 02'
      'ITEM 03'
      'ITEM 04'
      'ITEM 05')
    TabOrder = 3
  end
  object ProgressBar: TProgressBar
    Left = 251
    Top = 10
    Width = 206
    Height = 21
    TabOrder = 4
  end
  object Button1: TButton
    Left = 8
    Top = 231
    Width = 156
    Height = 25
    Caption = 'Loop'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 262
    Width = 156
    Height = 25
    Caption = 'TParallel.For'
    TabOrder = 6
    OnClick = Button2Click
  end
end
