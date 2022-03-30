program ClienteRest;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FrmPrincipal},
  WinHttp in 'WinHttp.pas',
  WinHttp_TLB in 'WinHttp_TLB.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
