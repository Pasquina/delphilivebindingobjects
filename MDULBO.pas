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

  { Disable the Delphi Generated form creation. Form creation is handled by the
    View (Main form) }

  // var MDLBO: TMDLBO;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TMDLBO }

{ When the Adapter Bind Source for Branches is created, this event handler creates the
  necessry BranchListBSWrapper and passes it back to the Bind Source Adapter. }

procedure TMDLBO.absBranchesCreateAdapter(
  Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin

  { Begin by creating the BranchWrapper and saving it in the current form }

  BranchWrapper := BranchListBSWrapper.Create( // create the Branch Wrapper
    self,                                      // (a TypeDef for TListBindSourceAdapter<TBranch>)
    Corp.CorpBranches,                         // The Wrapper points to TObjectList<TBranch>
    False);                                    // we keep responsibility for ownership

  { Set up the event handlers for the BranchWrapper. This completes the construction of the BranchWrapper }

  BranchWrapper.AfterScroll := AfterBranchScroll;
  BranchWrapper.AfterDelete := AfterBranchScroll;
  BranchWrapper.AfterInsert := AfterBranchScroll;

  { Return the BranchWrapper to the AdapterBindSource }

  ABindSourceAdapter := BranchWrapper; // this gives the TAdapterBindSource the ability to display the branch list
end;

{ When the Adapter Bind Source for the Corp is created, this event handler creates the
  necessary CorpBSWrapper and passes it back to the Bind Source Adapter }

procedure TMDLBO.absCorpCreateAdapter(
  Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin

  { Begin by creating the CorpWrapper and saving it in the current form }

  CorpWrapper := CorpObjectBSWrapper.Create( // create the Corp Wrapper
    self,                                    // (a TypeDef for TObjectBindSourceAdapter<TCorp>)
    Corp,                                    // The Wrapper points to TCorp
    False);                                  // we keep responsibility for ownership

  { Return the CorpWrapper to the AdapterBindSource }

  ABindSourceAdapter := CorpWrapper;         // this gives the TAdapterBindSource the ability to display the Corp object
end;

{ When the Adapter Bind Source for the Employees is created, this event handlere creates the
  necessary EmployeeWrapper and passes it back to the Bind Source Adapter }

procedure TMDLBO.absEmployeesCreateAdapter(
  Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin

  { Begin by creating the EmployeeWrapper and saving it in the current form }

  EmployeeWrapper := EmployeeListBSWrapper.Create(  // crate the Employee wrapper
    self,                                           // (a TypeDef for TListBindSourceAdapter<TEmployee>)
    TBranch(BranchWrapper.Current).BranchEmployees, // the wrapper points to TObjectList<TEmployee>
    False);                                         // we keep responsibility for ownership

  { Return the EmployeeWrapper to the AdapterBindSource }

  ABindSourceAdapter := EmployeeWrapper;            // this gives the TAdapterBindSource the ability to display the Employee list
end;

{ When the Branch list changes, either because of a scroll, or add or delete, this routine adjusts the
  Employee list to display the appropriate employees }

procedure TMDLBO.AfterBranchScroll(ABindSourceAdapter: TBindSourceAdapter);
var
  LBranch: TBranch;                                                       // currently displayed Branch
begin

  { A series of casts extracts the current TBranch object being displayed }

  LBranch := TBranch(TListBindSourceAdapter(ABindSourceAdapter).Current); // obtain the current TBranch object
  if Assigned(LBranch) then                                               // might be an empty list if all entries have been deleted
    begin
      EmployeeWrapper.SetList(                                            // change the Employee Wrapper to point to
        LBranch.BranchEmployees,                                          // the TObjectList<TEmployee> in the currently
        False);                                                           // displayed Branch

      EmployeeWrapper.First;                                              // position to the first Employee
      EmployeeWrapper.Active := True;                                     // this will populate the list and make it visible
    end
  else
    begin
      EmployeeWrapper.SetList(                                            // If there is no current branch
        nil,                                                              // there can be no current employees
        False);
    end;
end;

{ The overridden constructor for the data module first creates the data objects that are
  displayed by the view. This is done by creating the TCorp object which will cascade
  through the TBranch and TEmployee objects to create the entire data tree. It is important
  that the data objects be created BEFORE the data module (this form's) objects because the
  OnCreate event for the TAdapterBindSource objects will need the data objects to function
  properly. This is accomplished by creating TCorp FIRST, and then calling the inherited Create.
  The inherited Create will actually create the objects in this TDataModule. }

constructor TMDLBO.Create(AOwner: TComponent);
begin
  Corp := TCorp.Create(      // Important: Create the data objects before anything else
    'Acme Distributors',     // these are
    '5237 N Ravenswood Ave', // arbitrary values
    'Chicago',               // displayed by
    'IL',                    // the view
    'United States',         // in the
    '+1 312 555-5555');      // top banner
  inherited;                 // now create the objects on this data module
end;

destructor TMDLBO.Destroy;
begin
  Corp.Free;
  inherited;
end;

{ This class is a singleton. The following code is used to create/obtain the only instance }

class function TMDLBO.MDLBOGet: TMDLBO;
begin
  if not Assigned(FMDLBO) then      // test for already instantiated
    begin
      FMDLBO := TMDLBO.Create(nil); // instantiate and save the pointer
    end;
  Result := FMDLBO;                 // in any case, return the pointer
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
