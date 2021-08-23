object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Graphic'
  ClientHeight = 461
  ClientWidth = 763
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    763
    461)
  PixelsPerInch = 96
  TextHeight = 13
  object mainGraph: TImage
    Left = 8
    Top = 39
    Width = 747
    Height = 354
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnMouseMove = mainGraphMouseMove
  end
  object bOpen: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Open File'
    TabOrder = 0
    OnClick = bOpenClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 442
    Width = 763
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object cbShowGrid: TCheckBox
    Left = 8
    Top = 399
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Show Grid'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = cbPropertyClick
  end
  object cbShowAxis: TCheckBox
    Left = 8
    Top = 422
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Show Axis'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = cbPropertyClick
  end
  object cbShowPoints: TCheckBox
    Left = 136
    Top = 399
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Show Points'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = cbPropertyClick
  end
  object cbShowGraphs: TCheckBox
    Left = 136
    Top = 422
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Show Graphs'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = cbPropertyClick
  end
  object cbVerticalDiagram: TCheckBox
    Left = 272
    Top = 399
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Vertical Lines'
    TabOrder = 6
    OnClick = cbPropertyClick
  end
  object cbTrustDiagram: TCheckBox
    Left = 272
    Top = 422
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Trust Diagram'
    TabOrder = 7
    OnClick = cbPropertyClick
  end
end
