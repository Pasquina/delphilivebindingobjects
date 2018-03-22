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
    FCorpBinder: CorpObjectBSWrapper;
    FBranchBinder: BranchListBSWrapper;
    FEmployeeBinder: EmployeeListBSWrapper;
    procedure SetCorp(const Value: TCorp);
    procedure SetCorpBinder(const Value: CorpObjectBSWrapper);
    procedure SetBranchBinder(const Value: BranchListBSWrapper);
    procedure SetEmployeeBinder(const Value: EmployeeListBSWrapper);
    procedure AfterBranchScroll(ABindSourceAdapter: TBindSourceAdapter);
    property Corp: TCorp
      read FCorp
      write SetCorp;
    property CorpWrapper: CorpObjectBSWrapper
      read FCorpBinder
      write SetCorpBinder;
    property BranchWrapper: BranchListBSWrapper
      read FBranchBinder
      write SetBranchBinder;
    property EmployeeWrapper: EmployeeListBSWrapper
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
  BranchWrapper := BranchListBSWrapper.Create(
    self,
    Corp.CorpBranches,
    False);

  BranchWrapper.AfterScroll := AfterBranchScroll;
  BranchWrapper.AfterDelete := AfterBranchScroll;
  BranchWrapper.AfterInsert := AfterBranchScroll;

  ABindSourceAdapter := BranchWrapper;
end;

procedure TMDLBO.absCorpCreateAdapter(
  Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  CorpWrapper := CorpObjectBSWrapper.Create(
    self,
    Corp,
    False);
  ABindSourceAdapter := CorpWrapper;
end;

procedure TMDLBO.absEmployeesCreateAdapter(
  Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  EmployeeWrapper := EmployeeListBSWrapper.Create(
    self,
    TBranch(BranchWrapper.Current).BranchEmployees,
    False);
  ABindSourceAdapter := EmployeeWrapper;
end;

procedure TMDLBO.AfterBranchScroll(ABindSourceAdapter: TBindSourceAdapter);
var
  LBranch: TBranch;
begin
  LBranch := TBranch(TListBindSourceAdapter(ABindSourceAdapter).Current);
  if Assigned(LBranch) then
    begin
      EmployeeWrapper.SetList(
        LBranch.BranchEmployees,
        False);

      EmployeeWrapper.First;
      EmployeeWrapper.Active := True;
    end
  else
    begin
      EmployeeWrapper.SetList(
        nil,
        False);
    end;
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

procedure TMDLBO.SetBranchBinder(const Value: BranchListBSWrapper);
begin
  FBranchBinder := Value;
end;

procedure TMDLBO.SetCorp(const Value: TCorp);
begin
  FCorp := Value;
end;

procedure TMDLBO.SetCorpBinder(const Value: CorpObjectBSWrapper);
begin
  FCorpBinder := Value;
end;

procedure TMDLBO.SetEmployeeBinder(const Value: EmployeeListBSWrapper);
begin
  FEmployeeBinder := Value;
end;

end.
