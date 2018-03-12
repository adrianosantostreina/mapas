unit UntCM;

interface

uses
  System.SysUtils, System.Classes, Proxy, Datasnap.DSClientRest;

type
  TCM = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FSrvMetodosClient: TSrvMetodosClient;
    function GetSrvMetodosClient: TSrvMetodosClient;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property SrvMetodosClient: TSrvMetodosClient read GetSrvMetodosClient write FSrvMetodosClient;

end;

var
  CM: TCM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

constructor TCM.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TCM.Destroy;
begin
  FSrvMetodosClient.Free;
  inherited;
end;

function TCM.GetSrvMetodosClient: TSrvMetodosClient;
begin
  if FSrvMetodosClient = nil then
    FSrvMetodosClient:= TSrvMetodosClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FSrvMetodosClient;
end;

end.
