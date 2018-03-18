program LiveBindingObjects;

uses
  System.StartUpCopy,
  FMX.Forms,
  VULBO in 'VULBO.pas' {VLBO},
  MDULBO in 'MDULBO.pas' {MDLBO: TDataModule},
  DBLBO in 'DBLBO.pas';

{$R *.res}

begin

  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  Application.Initialize;
  Application.CreateForm(TVLBO, VLBO);
  Application.Run;
end.
