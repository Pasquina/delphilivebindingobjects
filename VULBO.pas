unit VULBO;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, MDULBO, DBLBO;

type
  TVLBO = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FMDLBO: TMDLBO;
    procedure SetMDLBO(const Value: TMDLBO);
    { Private declarations }
    property MDLBO: TMDLBO read FMDLBO write SetMDLBO;
  public
    { Public declarations }
  end;

var
  VLBO: TVLBO;

implementation

{$R *.fmx}

procedure TVLBO.FormCreate(Sender: TObject);
begin
  MDLBO := TMDLBO.MDLBOGet;
end;

procedure TVLBO.FormDestroy(Sender: TObject);
begin
  MDLBO.Free;
end;

procedure TVLBO.SetMDLBO(const Value: TMDLBO);
begin
  FMDLBO := Value;
end;

end.
