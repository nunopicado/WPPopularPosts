object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Popular Posts'
  ClientHeight = 580
  ClientWidth = 1076
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMenu: TPanel
    Left = 824
    Top = 0
    Width = 252
    Height = 580
    Align = alRight
    Caption = 'pnlMenu'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      252
      580)
    object lblTitle: TLabel
      Left = 16
      Top = 16
      Width = 217
      Height = 33
      Alignment = taCenter
      AutoSize = False
      Caption = 'WP Popular Posts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblHostname: TLabel
      Left = 16
      Top = 72
      Width = 54
      Height = 13
      Caption = 'Hostaname'
    end
    object lblDatabase: TLabel
      Left = 16
      Top = 128
      Width = 46
      Height = 13
      Caption = 'Database'
    end
    object lblUsername: TLabel
      Left = 16
      Top = 184
      Width = 48
      Height = 13
      Caption = 'Username'
    end
    object lblPassword: TLabel
      Left = 16
      Top = 240
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object lblPort: TLabel
      Left = 182
      Top = 94
      Width = 4
      Height = 13
      Caption = ':'
    end
    object lblHowTo: TLabel
      Left = 16
      Top = 336
      Width = 78
      Height = 16
      Caption = 'How to use:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblHowToDetail: TLabel
      Left = 16
      Top = 355
      Width = 217
      Height = 166
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = 'lblHowToDetail'
      WordWrap = True
    end
    object edHostname: TEdit
      Left = 16
      Top = 91
      Width = 161
      Height = 21
      TabOrder = 0
    end
    object edDatabase: TEdit
      Left = 16
      Top = 147
      Width = 217
      Height = 21
      TabOrder = 2
    end
    object edUsername: TEdit
      Left = 16
      Top = 203
      Width = 217
      Height = 21
      TabOrder = 3
    end
    object edPassword: TEdit
      Left = 16
      Top = 259
      Width = 217
      Height = 21
      PasswordChar = '*'
      TabOrder = 4
    end
    object bConnect: TButton
      Left = 16
      Top = 296
      Width = 217
      Height = 25
      Caption = 'Connect'
      TabOrder = 5
      OnClick = bConnectClick
    end
    object bExit: TButton
      Left = 16
      Top = 538
      Width = 217
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Exit'
      TabOrder = 6
      OnClick = bExitClick
    end
    object edPort: TEdit
      Left = 190
      Top = 91
      Width = 43
      Height = 21
      Alignment = taCenter
      NumbersOnly = True
      TabOrder = 1
    end
  end
  object gridPosts: TDBGrid
    Left = 0
    Top = 0
    Width = 824
    Height = 580
    Align = alClient
    DataSource = dsPosts
    Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = gridPostsDblClick
    OnKeyPress = gridPostsKeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Caption = 'Post ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'post_title'
        Title.Alignment = taCenter
        Title.Caption = 'Post Title'
        Width = 600
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pageviews'
        Title.Alignment = taCenter
        Title.Caption = 'Page Views'
        Width = 100
        Visible = True
      end>
  end
  object dsPosts: TDataSource
    Left = 32
    Top = 56
  end
end
