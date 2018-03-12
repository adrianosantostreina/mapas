unit UntdmRest;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TdmREST = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
  private
    { Private declarations }
    function GetBaseURL: String;
    function GetURL: String;
    function GetPort: String;
  public
    { Public declarations }
  end;

var
  dmREST: TdmREST;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdmREST }

function TdmREST.GetBaseURL: String;
begin
  //
end;

function TdmREST.GetPort: String;
begin
  //
end;

function TdmREST.GetURL: String;
begin
  //
end;

end.
