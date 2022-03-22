object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Regex'
  ClientHeight = 385
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edtEmail: TEdit
    Left = 8
    Top = 8
    Width = 162
    Height = 21
    TabOrder = 0
    Text = 'email@site.com.br'
  end
  object btnEmail: TButton
    Left = 176
    Top = 6
    Width = 49
    Height = 25
    Caption = 'Validar'
    TabOrder = 1
    OnClick = btnEmailClick
  end
  object Input: TMemo
    Left = 8
    Top = 37
    Width = 240
    Height = 240
    Lines.Strings = (
      'Aquiraz (23)01000'
      'Caucaia (23)03709'
      'Eus'#233'bio (23)04285'
      'Fortaleza (23)04400'
      'Guai'#250'ba (23)04954'
      'Itaitinga (23)06256'
      'Maracana'#250' (23)07650'
      'Maranguape (23)07700'
      'Pacatuba (23)09706'
      'Horizonte (23)05233'
      'Pacajus (23)09607')
    TabOrder = 2
  end
  object Output: TMemo
    Left = 286
    Top = 37
    Width = 240
    Height = 240
    TabOrder = 3
  end
  object btnRegex: TButton
    Left = 254
    Top = 37
    Width = 26
    Height = 25
    Caption = '>>'
    TabOrder = 4
    OnClick = btnRegexClick
  end
  object Log: TMemo
    Left = 8
    Top = 283
    Width = 518
    Height = 94
    TabOrder = 5
  end
  object edtReLabel: TEdit
    Left = 286
    Top = 8
    Width = 147
    Height = 21
    TabOrder = 6
    Text = 'Teste(123)'
  end
  object btnReLabel: TButton
    Left = 439
    Top = 6
    Width = 49
    Height = 25
    Caption = 'Regex'
    TabOrder = 7
    OnClick = btnReLabelClick
  end
end
