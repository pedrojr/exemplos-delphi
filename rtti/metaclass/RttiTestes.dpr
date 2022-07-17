program RttiTestes;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  ClassesTestes in 'ClassesTestes.pas',
  MetaclassType in 'MetaclassType.pas',
  MetaclassTypeTests in 'MetaclassTypeTests.pas';

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown := True;
  DUnitTestRunner.RunRegisteredTests;
end.
