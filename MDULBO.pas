unit MDULBO;

interface

uses
  System.SysUtils, System.Classes, DBLBO;

type
  TMDLBO = class(TDataModule)
  strict private
    class var FMDLBO: TMDLBO;
    constructor Create(AOwner: TComponent); override;
  private
    { Private declarations }
    FCorp: TCorp;
    procedure SetCorp(const Value: TCorp);
    property Corp: TCorp read FCorp write SetCorp;
  public
    { Public declarations }
    class function MDLBOGet: TMDLBO;
    destructor Destroy; override;
  end;
//
//var
//  MDLBO: TMDLBO;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TMDLBO }

constructor TMDLBO.Create(AOwner: TComponent);
begin
  Corp := TCorp.Create('Acme Distributors', '5237 N Ravenswood Ave', 'Chicago', 'IL', 'United States', '+1 312 555-5555');
  inherited;
end;

destructor TMDLBO.Destroy;
begin
  Corp.Free;
  inherited;
end;

class function TMDLBO.MDLBOGet: TMDLBO;
begin
  if not Assigned(FMDLBO) then
    begin
      FMDLBO := TMDLBO.Create(nil);
    end;
  Result := FMDLBO;
end;

procedure TMDLBO.SetCorp(const Value: TCorp);
begin
  FCorp := Value;
end;

end.
