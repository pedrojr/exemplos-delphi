program Tests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  XmlBuilderTests in 'XmlBuilderTests.pas',
  XmlBuilder in 'XmlBuilder.pas',
  XmlElement in 'XmlElement.pas',
  Generics.Utils in 'Generics.Utils.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  DUnitTestRunner.RunRegisteredTests;
end.

