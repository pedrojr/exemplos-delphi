unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinHttp;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
const
  URL = 'https://swapi.dev/api/';
var
  Http: IWinHttp;
begin
  Http := TWinHttp.Create(URL);
  if Http.GET('films/1') then
    Memo1.Lines.Text := Http.ResponseData;
end;

end.
