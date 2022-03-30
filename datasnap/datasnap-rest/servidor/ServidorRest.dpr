program ServidorRest;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormServico in 'FormServico.pas' {FrmServico},
  ServerMethods in 'ServerMethods.pas',
  WebModule in 'WebModule.pas' {WebModule1: TWebModule},
  ServerClasses in 'ServerClasses.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFrmServico, FrmServico);
  Application.Run;
end.
