unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Client;

type
  TFrmPrincipal = class(TForm)
    Retorno: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses
  WinHttp;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
  Http: TWinHttp;
begin
  Http := TWinHttp.Create('http://localhost:8090/api/rest/');
  if Http.Prepare.GET('vendas/produtos') then
    Retorno.Text := Http.ResponseData;
end;

end.
