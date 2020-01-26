object Form1: TForm1
  Left = 239
  Top = 302
  Width = 870
  Height = 640
  Cursor = crCross
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 184
    Top = 512
    Width = 185
    Height = 57
    Caption = 'RESTART'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 488
    Top = 512
    Width = 185
    Height = 57
    Caption = 'QUIT'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 20
    OnTimer = Timer1Timer
    Left = 8
    Top = 8
  end
end
