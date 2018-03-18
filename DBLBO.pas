unit DBLBO;

interface

uses
  Data.Bind.ObjectScope, System.Generics.Collections;

type
  TPersGender = (pgFemale, pgMale, pgUnknown);

  TCorp = class;
  TBranch = class;
  TEmployee = class;

  CorpObjectBSA = TObjectBindSourceAdapter<TCorp>;
  BranchListBSA = TListBindSourceAdapter<TBranch>;
  EmployeeListBSA = TListBindSourceAdapter<TEmployee>;

  TCorp = class(TObject)
  strict private
  private
    FCorpMainPhone: String;
    FCorpCountry: String;
    FCorpStateProvince: String;
    FCorpCity: String;
    FCorpBranches: TObjectList<TBranch>;
    FCorpStreetAddress: String;
    FCorpName: String;
    procedure SetCorpBranches(const Value: TObjectList<TBranch>);
    procedure SetCorpCity(const Value: String);
    procedure SetCorpCountry(const Value: String);
    procedure SetCorpMainPhone(const Value: String);
    procedure SetCorpName(const Value: String);
    procedure SetCorpStateProvince(const Value: String);
    procedure SetCorpStreetAddress(const Value: String);
  protected
  public
    constructor Create(
      const ACorpName: String;
      const ACorpStreetAddress: String;
      const ACorpCity: String;
      const ACorpStateProvince: String;
      const ACorpCountry: String;
      const ACorpMainPhone: String);
    destructor Destroy; override;
    property CorpName: String
      read FCorpName
      write SetCorpName;
    property CorpStreetAddress: String
      read FCorpStreetAddress
      write SetCorpStreetAddress;
    property CorpCity: String
      read FCorpCity
      write SetCorpCity;
    property CorpStateProvince: String
      read FCorpStateProvince
      write SetCorpStateProvince;
    property CorpCountry: String
      read FCorpCountry
      write SetCorpCountry;
    property CorpMainPhone: String
      read FCorpMainPhone
      write SetCorpMainPhone;
    property CorpBranches: TObjectList<TBranch>
      read FCorpBranches
      write SetCorpBranches;
  end;

  TBranch = class(TObject)
  strict private
  private
    FBranchCountry: String;
    FBranchStateProvince: String;
    FBranchCity: String;
    FBranchEmployees: TObjectList<TEmployee>;
    FBranchStreetAddress: String;
    FBranchName: String;
    FBranchMainPhone: String;
    procedure SetBranchCity(const Value: String);
    procedure SetBranchCountry(const Value: String);
    procedure SetBranchEmployees(const Value: TObjectList<TEmployee>);
    procedure SetBranchMainPhone(const Value: String);
    procedure SetBranchName(const Value: String);
    procedure SetBranchStateProvince(const Value: String);
    procedure SetBranchStreetAddress(const Value: String);
  protected
  public
    constructor Create(
      const ABranchName: String;
      const ABranchStreetAddress: String;
      const ABranchCity: String;
      const ABranchStateProvince: String;
      const ABranchCountry: String;
      const ABranchMainPhone: String);
    destructor Destroy; override;
    property BranchName: String
      read FBranchName
      write SetBranchName;
    property BranchStreetAddress: String
      read FBranchStreetAddress
      write SetBranchStreetAddress;
    property BranchCity: String
      read FBranchCity
      write SetBranchCity;
    property BranchStateProvince: String
      read FBranchStateProvince
      write SetBranchStateProvince;
    property BranchCountry: String
      read FBranchCountry
      write SetBranchCountry;
    property BranchMainPhone: String
      read FBranchMainPhone
      write SetBranchMainPhone;
    property BranchEmployees: TObjectList<TEmployee>
      read FBranchEmployees
      write SetBranchEmployees;
  end;

  TEmployee = class(TObject)
  strict private
  private
    FEmpMiddleName: String;
    FEmpFirstName: String;
    FEmpSurname: String;
    procedure SetEmpFirstName(const Value: String);
    procedure SetEmpMiddleName(const Value: String);
    procedure SetEmpSurname(const Value: String);
    function GetEmpFullName: String;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    property EmpFirstName: String read FEmpFirstName write SetEmpFirstName;
    property EmpMiddleName: String read FEmpMiddleName write SetEmpMiddleName;
    property EmpSurname: String read FEmpSurname write SetEmpSurname;
    property EmpFullName: String read GetEmpFullName;
  end;

implementation

{ TCorp }

constructor TCorp.Create(
  const ACorpName: String;
  const ACorpStreetAddress: String;
  const ACorpCity: String;
  const ACorpStateProvince: String;
  const ACorpCountry: String;
  const ACorpMainPhone: String);
begin
  CorpName := ACorpName;
  CorpStreetAddress := ACorpStreetAddress;
  CorpCity := ACorpCity;
  CorpStateProvince := ACorpStateProvince;
  CorpCountry := ACorpCountry;
  CorpMainPhone := ACorpMainPhone;
  CorpBranches := TObjectList<TBranch>.Create;
  CorpBranches.Add(TBranch.Create('Cincinnati', '368 W 9th St', 'Cincinnati', 'OH', 'United States', '+1 387 555-5555'));
  CorpBranches.Add(TBranch.Create('Phoenix', '3009 W Indian School Rd', 'Phoenix', 'AZ', 'United States', '+1 986 555-5555'));
  CorpBranches.Add(TBranch.Create('Toronto', '38 Parliament St', 'Toronto', 'ON', 'Canada', '+1 298 555-5555'));
end;

destructor TCorp.Destroy;
begin
  CorpBranches.Free;
  inherited;
end;

procedure TCorp.SetCorpBranches(const Value: TObjectList<TBranch>);
begin
  FCorpBranches := Value;
end;

procedure TCorp.SetCorpCity(const Value: String);
begin
  FCorpCity := Value;
end;

procedure TCorp.SetCorpCountry(const Value: String);
begin
  FCorpCountry := Value;
end;

procedure TCorp.SetCorpMainPhone(const Value: String);
begin
  FCorpMainPhone := Value;
end;

procedure TCorp.SetCorpName(const Value: String);
begin
  FCorpName := Value;
end;

procedure TCorp.SetCorpStateProvince(const Value: String);
begin
  FCorpStateProvince := Value;
end;

procedure TCorp.SetCorpStreetAddress(const Value: String);
begin
  FCorpStreetAddress := Value;
end;

{ TBranch }

constructor TBranch.Create(
      const ABranchName: String;
      const ABranchStreetAddress: String;
      const ABranchCity: String;
      const ABranchStateProvince: String;
      const ABranchCountry: String;
      const ABranchMainPhone: String);
begin
  BranchName := ABranchName;
  BranchStreetAddress := ABranchStreetAddress;
  BranchCity := ABranchCity;
  BranchStateProvince := ABranchStateProvince;
  BranchCountry := ABranchCountry;
  BranchMainPhone := ABranchMainPhone;
  BranchEmployees := TObjectList<TEmployee>.Create;
end;

destructor TBranch.Destroy;
begin
  BranchEmployees.Free;
  inherited;
end;

procedure TBranch.SetBranchCity(const Value: String);
begin
  FBranchCity := Value;
end;

procedure TBranch.SetBranchCountry(const Value: String);
begin
  FBranchCountry := Value;
end;

procedure TBranch.SetBranchEmployees(const Value: TObjectList<TEmployee>);
begin
  FBranchEmployees := Value;
end;

procedure TBranch.SetBranchMainPhone(const Value: String);
begin
  FBranchMainPhone := Value;
end;

procedure TBranch.SetBranchName(const Value: String);
begin
  FBranchName := Value;
end;

procedure TBranch.SetBranchStateProvince(const Value: String);
begin
  FBranchStateProvince := Value;
end;

procedure TBranch.SetBranchStreetAddress(const Value: String);
begin
  FBranchStreetAddress := Value;
end;

{ TEmployee }

constructor TEmployee.Create;
begin

end;

destructor TEmployee.Destroy;
begin

  inherited;
end;

function TEmployee.GetEmpFullName: String;
var
  LSep: String;
begin
  LSep := '';
  Result := '';
  if EmpFirstName <> '' then
    begin
      Result := Result + LSep + EmpFirstName;
      LSep := ' ';
    end;
  if EmpMiddleName <> '' then
    begin
      Result := Result + LSep + EmpMiddleName;
      LSep := ' ';
    end;
  if EmpSurname <> ' ' then
    begin
      Result := Result + LSep + EmpSurname;
      LSep := ' ';
    end;
end;

procedure TEmployee.SetEmpFirstName(const Value: String);
begin
  FEmpFirstName := Value;
end;

procedure TEmployee.SetEmpMiddleName(const Value: String);
begin
  FEmpMiddleName := Value;
end;

procedure TEmployee.SetEmpSurname(const Value: String);
begin
  FEmpSurname := Value;
end;

end.
