unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    edtEmail: TEdit;
    btnEmail: TButton;
    Input: TMemo;
    Output: TMemo;
    btnRegex: TButton;
    Log: TMemo;
    edtReLabel: TEdit;
    btnReLabel: TButton;
    procedure btnEmailClick(Sender: TObject);
    procedure btnRegexClick(Sender: TObject);
    procedure btnReLabelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  RegularExpressions, StrUtils;

{$R *.dfm}

(*
http://docwiki.embarcadero.com/RADStudio/XE7/en/Regular_Expressions
http://aurelio.net/regex/
http://www.princeton.edu/~mlovett/reference/Regular-Expressions.pdf
http://www.regular-expressions.info/delphi.html
http://regexpal.com/
*)

procedure TfrmPrincipal.btnEmailClick(Sender: TObject);
const
  P_EMAIL = '^([\w\-]+|\.)+@([\w\-]+|\.)+([\w\-]{2,3})+(\.[\w\-]{2,2})?$';
begin
  if TRegEx.IsMatch(edtEmail.Text, P_EMAIL) then
    ShowMessage('Email ok')
  else
    ShowMessage('Email inválido');
end;

function BoolToSN(Value: Boolean): string;
begin
  Result := IfThen(Value, 'Sim', 'Não');
end;

procedure TfrmPrincipal.btnRegexClick(Sender: TObject);
const
  Pattern = '(.+) .+\)([0-9]+)';
var
  vLinha: string;
  vMatch: TMatch;
  vGroup: TGroup;
begin
  Log.Clear;
  Output.Clear;
  for vLinha in Input.Lines do
  begin
    if vLinha = EmptyStr then
      Continue;

    vMatch := TRegEx.Match(vLinha, Pattern);
    Output.Lines.Add(vMatch.Groups.Item[1].Value +';'+  vMatch.Groups.Item[2].Value);
    Log.Lines.Add('Success: '+ BoolToSN(vMatch.Success) +' / Value: '+ vMatch.Value);

    if vMatch.Success and (vMatch.Groups.Count > 0) then
    begin
      for vGroup in vMatch.Groups do
        Log.Lines.Add('Group '+ IntToStr(vGroup.Index) +': '+ vGroup.Value);
    end;
  end;
end;

procedure TfrmPrincipal.btnReLabelClick(Sender: TObject);
var
  vRegEx: TRegEx;
  vMatch: TMatch;
  vGroup: TGroup;
begin
  Log.Clear;
  vRegEx := TRegEx.Create('.+\((?P<value>.*)\)');
  vMatch := vRegEx.Match(edtReLabel.Text);
  vGroup := vMatch.Groups.Item['value'];
  Log.Lines.Add(vGroup.Value);
end;

{
TRegEx.
 IsMatch(Input, Pattern)
 Escape()
 Match()
 Matches()
 Replace()
 Split()
}

end.

