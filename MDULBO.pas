unit MDULBO;

interface

uses
  System.SysUtils, System.Classes, DBLBO, Data.Bind.GenData, Fmx.Bind.GenData,
  Data.Bind.ObjectScope, Data.Bind.Components;

type
  TMDLBO = class(TDataModule)
    dgCorp: TDataGeneratorAdapter;
    absCorp: TAdapterBindSource;
    dgBranches: TDataGeneratorAdapter;
    absBranches: TAdapterBindSource;
    dgEmployees: TDataGeneratorAdapter;
    absEmployees: TAdapterBindSource;
    procedure absCorpCreateAdapter(
      Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure absBranchesCreateAdapter(
      Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure absEmployeesCreateAdapter(
      Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  strict private
    class var FMDLBO: TMDLBO;
    constructor Create(AOwner: TComponent); override;
  private
    { Private declarations }
    FCorp: TCorp;
    FCorpBinder: CorpObjectBSA;
    FBranchBinder: BranchListBSA;
    FEmployeeBinder: EmployeeListBSA;
    procedure SetCorp(const Value: TCorp);
    procedure SetCorpBinder(const Value: CorpObjectBSA);
    procedure SetBranchBinder(const Value: BranchListBSA);
    procedure SetEmployeeBinder(const Value: EmployeeListBSA);
    procedure AfterBranchScroll(ABindSourceAdapter: TBindSourceAdapter);
    property Corp: TCorp
      read FCorp
      write SetCorp;
    property CorpBinder: CorpObjectBSA
      read FCorpBinder
      write SetCorpBinder;
    property BranchBinder: BranchListBSA
      read FBranchBinder
      write SetBranchBinder;
    property EmployeeBinder: EmployeeListBSA
      read FEmployeeBinder
      write SetEmployeeBinder;
  public
    { Public declarations }
    class function MDLBOGet: TMDLBO;
    destructor Destroy; override;
  end;
  //
  // var
  // MDLBO: TMDLBO;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TMDLBO }

procedure TMDLBO.absBranchesCreateAdapter(
  Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  BranchBinder := BranchListBSA.Create(
    self,
    Corp.CorpBranches,
    False);

  BranchBinder.AfterScroll := AfterBranchScroll;

  ABindSourceAdapter := BranchBinder;
end;

procedure TMDLBO.absCorpCreateAdapter(
  Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  CorpBinder := CorpObjectBSA.Create(
    self,
    Corp,
    False);
  ABindSourceAdapter := CorpBinder;
end;

procedure TMDLBO.absEmployeesCreateAdapter(
  Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  EmployeeBinder := EmployeeListBSA.Create(
    self,
    TBranch(BranchBinder.Current).BranchEmployees,
    False);
  ABindSourceAdapter := EmployeeBinder;
end;

procedure TMDLBO.AfterBranchScroll(ABindSourceAdapter: TBindSourceAdapter);
var
  LBranch: TBranch;
begin
  LBranch := TBranch(TListBindSourceAdapter(ABindSourceAdapter).Current);
  EmployeeBinder.SetList(
    LBranch.BranchEmployees,
    False);

  EmployeeBinder.First;
  EmployeeBinder.Active := True;
end;

constructor TMDLBO.Create(AOwner: TComponent);
begin
  Corp := TCorp.Create(
    'Acme Distributors',
    '5237 N Ravenswood Ave',
    'Chicago',
    'IL',
    'United States',
    '+1 312 555-5555');
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

procedure TMDLBO.SetBranchBinder(const Value: BranchListBSA);
begin
  FBranchBinder := Value;
end;

procedure TMDLBO.SetCorp(const Value: TCorp);
begin
  FCorp := Value;
end;

procedure TMDLBO.SetCorpBinder(const Value: CorpObjectBSA);
begin
  FCorpBinder := Value;
end;

procedure TMDLBO.SetEmployeeBinder(const Value: EmployeeListBSA);
begin
  FEmployeeBinder := Value;
end;

end.
