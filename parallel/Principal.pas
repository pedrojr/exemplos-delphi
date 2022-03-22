unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Threading,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TProcPos = reference to procedure(APos: Integer);
  TProcesso = reference to procedure(PassoAtual, Total: Integer);

  TfrmPrincipal = class(TForm)
    btnMA1: TButton;
    btnMA2: TButton;
    Memo: TMemo;
    ListBox: TListBox;
    ProgressBar: TProgressBar;
    Button1: TButton;
    Button2: TButton;
    procedure btnMA1Click(Sender: TObject);
    procedure btnMA2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.Diagnostics;

{$R *.dfm}

procedure PercorreLista(ALista: TStrings; AProc: TProcPos);
var
  I: Integer;
begin
  for I := 0 to ALista.Count -1 do
    AProc(I);
end;

procedure TfrmPrincipal.btnMA1Click(Sender: TObject);
begin
  Memo.Clear;
  PercorreLista(
    ListBox.Items,
    procedure(APos: Integer)
    begin
      Memo.Lines.Add( LowerCase(ListBox.Items[APos]) );
    end
  );

  PercorreLista(
    ListBox.Items,
    procedure(APos: Integer)
    begin
      Memo.Lines.Add( IntToStr(APos) );
    end
  );

end;

procedure Processar(Progress: TProgressBar; Processo: TProcesso);
var
  I: Integer;
begin
  if Progress <> nil then
  begin
    Progress.Step := 1;
    for I := Progress.Min to Progress.Max do
    begin
      Processo(Progress.Position, Progress.Max);
      Progress.StepIt;
    end;
    Progress.Position := 0;
  end;
end;

procedure TfrmPrincipal.btnMA2Click(Sender: TObject);
begin
  Memo.Clear;
  Processar(ProgressBar,
    procedure (PassoAtual, Total: Integer)
    begin
      Memo.Lines.Add(Format('Passo %d de %d', [PassoAtual, Total]));
      Sleep(100);
    end);
end;

{System.Threading
TThreadPool
ITask - WaitForAll, WaitForAny
IFuture<T> - ITask usando Generics
TParallel
}

function IsPrime(N: Integer): Boolean;
var
  Test: Integer;
begin
  IsPrime := True;
  for Test := 2 to N -1 do
  begin
    if (N mod Test) = 0 then
    begin
      IsPrime := False;
      Break;
    end;
  end;
end;

const
  Max = 500000;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
var
  I, Tot: Integer;
  Tmp: TStopwatch;
begin
  Tot := 0;
  Tmp := TStopwatch.StartNew;

  for I := 1 to Max do
  begin
    if IsPrime(I) then
      Inc(Tot);
  end;

  Tmp.Stop;
  Memo.Clear;
  Memo.Lines.Add('Normal Tot: '+ IntToStr(Tot));
  Memo.Lines.Add('ElapsedMilliseconds: '+ IntToStr(Tmp.ElapsedMilliseconds));
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
var
  Tot: Integer;
  Tmp: TStopwatch;
begin
  Tot := 0;
  Tmp := TStopwatch.StartNew;

  TParallel.For(1, Max,
    procedure (I: Integer)
    begin
      if IsPrime (I) then
        InterlockedIncrement(Tot);
    end
  );

  Tmp.Stop;
  Memo.Lines.Add('Parallel Tot: '+ IntToStr(Tot));
  Memo.Lines.Add('ElapsedMilliseconds: '+ IntToStr(Tmp.ElapsedMilliseconds));
end;

end.
