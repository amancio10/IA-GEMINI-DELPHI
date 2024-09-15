unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmPrincipal = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    memResposta: TMemo;
    pnTop: TPanel;
    edtPergunta: TEdit;
    btnPergunta: TButton;
    GroupBox1: TGroupBox;
    edtURLBase: TEdit;
    edtKey: TEdit;
    btnGerarkey: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnPerguntaClick(Sender: TObject);
    procedure edtPerguntaKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarkeyClick(Sender: TObject);
  private
    procedure OpenLink(const URL: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

Uses
 System.JSON,
 System.SysUtils,
 //
 ShellAPI;

{$R *.dfm}

procedure TfrmPrincipal.btnPerguntaClick(Sender: TObject);
{$Region 'Var'}
var
  Retorno       : TJSONObject;
  JSONBody      : TJSONObject;
  Content       : TJSONObject;
  //
  Parts         : TJSONArray;
  Candidates    : TJSONArray;
  ContentsArray : TJSONArray;
  PartsArray    : TJSONArray;
  //
  Prompt        : TStringList;
  Text          : string;
  lURLBase      : string;
  lKey          : string;
{$EndRegion 'Var'}
begin

  lURLBase := edtURLBase.Text;
  lKey     := edtKey.Text;

  if (lURLBase = '') or (lKey = '') then
  begin
    ShowMessage('Preencha os dados de acesso para continuar!');
    Exit;
  end;

 {$Region 'POST'}
  RESTClient1.BaseURL := lURLBase + lKey;

  Prompt      := TStringList.Create;
  JSONBody := TJSONObject.Create;
  try
    Prompt.Add(edtPergunta.Text);

    ContentsArray := TJSONArray.Create;
    PartsArray := TJSONArray.Create;
    PartsArray.AddElement(TJSONObject.Create.AddPair('text', Prompt.Text));
    ContentsArray.AddElement(TJSONObject.Create.AddPair('parts', PartsArray));
    JSONBody.AddPair('contents', ContentsArray);

    RESTRequest1.Params.ParameterByName('body4E6B89C7FD1E4198BD64C5BE65C5188E').Value := JSONBody.ToString;
  finally
    JSONBody.Free;
    Prompt.Free;
  end;

  RESTRequest1.Execute;
 {$EndRegion 'POST'}

 {$Region 'Retorno'}
  Retorno := RESTRequest1.Response.JSONValue as TJSONObject;

  Candidates := Retorno.GetValue<TJSONArray>('candidates');
  if Candidates.Count > 0 then
  begin
    Content := Candidates.Items[0].GetValue<TJSONObject>('content');
    Parts := Content.GetValue<TJSONArray>('parts');
    if Parts.Count > 0 then
    begin
      Text := Parts.Items[0].GetValue<string>('text');
      memResposta.Text := Text;
    end;
  end;
 {$EndRegion 'Retorno'}

end;

procedure TfrmPrincipal.btnGerarkeyClick(Sender: TObject);
var
 GerarKeyGoogle : String;
begin
  GerarKeyGoogle := 'https://aistudio.google.com/app/apikey';
  OpenLink(GerarKeyGoogle);
end;

procedure TfrmPrincipal.edtPerguntaKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
 begin
   key := #0;
   btnPergunta.Click;
 end;
end;

procedure TfrmPrincipal.OpenLink(const URL: string);
begin
  ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

end.
