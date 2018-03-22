unit VULBO;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, MDULBO, DBLBO,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  Data.Bind.Controls, Fmx.Bind.Navigator;

type
  TVLBO = class(TForm)
    pnCorp: TPanel;
    loCorpName: TLayout;
    gplCorp: TGridPanelLayout;
    loCorpStreetAddress: TLayout;
    loCorpCity: TLayout;
    loCorpStateProvince: TLayout;
    loCorpCountry: TLayout;
    loCorpMainPhone: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lbCorpName: TLabel;
    lbCorpStreetAddress: TLabel;
    lbCorpCity: TLabel;
    lbCorpStateProvince: TLabel;
    lbCorpCountry: TLabel;
    lbCorpMainPhone: TLabel;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    Layout1: TLayout;
    Splitter1: TSplitter;
    Layout2: TLayout;
    lvBranches: TListView;
    lvEmployees: TListView;
    LinkListControlToField2: TLinkListControlToField;
    navBranches: TBindNavigator;
    LinkListControlToField1: TLinkListControlToField;
    navEmloyee: TBindNavigator;
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
