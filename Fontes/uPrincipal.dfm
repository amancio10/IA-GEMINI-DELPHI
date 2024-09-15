object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Chat com Gemini Google'
  ClientHeight = 392
  ClientWidth = 664
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object memResposta: TMemo
    Left = 0
    Top = 161
    Width = 664
    Height = 231
    Align = alClient
    TabOrder = 0
    ExplicitTop = 49
    ExplicitWidth = 751
    ExplicitHeight = 152
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 664
    Height = 161
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object edtPergunta: TEdit
      Left = 6
      Top = 129
      Width = 567
      Height = 23
      TabOrder = 0
      OnKeyPress = edtPerguntaKeyPress
    end
    object btnPergunta: TButton
      Left = 581
      Top = 127
      Width = 75
      Height = 25
      Caption = '&Perguntar'
      TabOrder = 1
      OnClick = btnPerguntaClick
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 8
      Width = 656
      Height = 113
      Caption = 'Acesso'
      TabOrder = 2
      object Label1: TLabel
        Left = 6
        Top = 18
        Width = 48
        Height = 15
        Caption = 'URL Base'
      end
      object Label2: TLabel
        Left = 6
        Top = 65
        Width = 19
        Height = 15
        Caption = 'Key'
      end
      object edtURLBase: TEdit
        Left = 6
        Top = 33
        Width = 625
        Height = 23
        TabOrder = 0
        Text = 
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1' +
          '.5-flash-latest:generateContent?key='
      end
      object edtKey: TEdit
        Left = 6
        Top = 82
        Width = 481
        Height = 23
        TabOrder = 1
      end
      object btnGerarkey: TButton
        Left = 503
        Top = 81
        Width = 138
        Height = 25
        Caption = '&Gerar key'
        TabOrder = 2
        OnClick = btnGerarkeyClick
      end
    end
  end
  object RESTClient1: TRESTClient
    BaseURL = 
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1' +
      '.5-flash-latest:generateContent?key=AIzaSyBTB62ox4J_wSkLS6_68q6O' +
      'MiRZGYyg0mQ'
    Params = <>
    SynchronizedEvents = False
    Left = 152
    Top = 192
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body4E6B89C7FD1E4198BD64C5BE65C5188E'
        Value = 
          '{"contents":[{"parts":[{"text":"Oi, me fale brevemente sobre voc' +
          #195#170', voc'#195#170' '#195#169' gratis?"}]}]}'
        ContentTypeStr = 'application/atom+xml'
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 56
    Top = 192
  end
  object RESTResponse1: TRESTResponse
    Left = 264
    Top = 192
  end
end
