//
// Created by the DataSnap proxy generator.
// 06/03/2018 19:16:35
//

unit Proxy;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TSrvMetodosClient = class(TDSAdminRestClient)
  private
    FSolicitarServicoCommand: TDSRestCommand;
    FConfirmarServicoCommand: TDSRestCommand;
    FGetPosicaoEntregaCommand: TDSRestCommand;
    FCapturarServicoCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function SolicitarServico(AOrigem: string; ADestino: string; ALatitude: Double; ALongitude: Double; const ARequestFilter: string = ''): string;
    function ConfirmarServico(AOrigem: string; ADestino: string; ALatitude: Double; ALongitude: Double; const ARequestFilter: string = ''): Boolean;
    function GetPosicaoEntrega(AID_Entrega: Integer; const ARequestFilter: string = ''): string;
    function CapturarServico(AID_Entregador: Integer; const ARequestFilter: string = ''): Boolean;
  end;

const
  TSrvMetodos_SolicitarServico: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'AOrigem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ADestino'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ALatitude'; Direction: 1; DBXType: 7; TypeName: 'Double'),
    (Name: 'ALongitude'; Direction: 1; DBXType: 7; TypeName: 'Double'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TSrvMetodos_ConfirmarServico: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'AOrigem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ADestino'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'ALatitude'; Direction: 1; DBXType: 7; TypeName: 'Double'),
    (Name: 'ALongitude'; Direction: 1; DBXType: 7; TypeName: 'Double'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TSrvMetodos_GetPosicaoEntrega: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AID_Entrega'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TSrvMetodos_CapturarServico: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'AID_Entregador'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

function TSrvMetodosClient.SolicitarServico(AOrigem: string; ADestino: string; ALatitude: Double; ALongitude: Double; const ARequestFilter: string): string;
begin
  if FSolicitarServicoCommand = nil then
  begin
    FSolicitarServicoCommand := FConnection.CreateCommand;
    FSolicitarServicoCommand.RequestType := 'GET';
    FSolicitarServicoCommand.Text := 'TSrvMetodos.SolicitarServico';
    FSolicitarServicoCommand.Prepare(TSrvMetodos_SolicitarServico);
  end;
  FSolicitarServicoCommand.Parameters[0].Value.SetWideString(AOrigem);
  FSolicitarServicoCommand.Parameters[1].Value.SetWideString(ADestino);
  FSolicitarServicoCommand.Parameters[2].Value.SetDouble(ALatitude);
  FSolicitarServicoCommand.Parameters[3].Value.SetDouble(ALongitude);
  FSolicitarServicoCommand.Execute(ARequestFilter);
  Result := FSolicitarServicoCommand.Parameters[4].Value.GetWideString;
end;

function TSrvMetodosClient.ConfirmarServico(AOrigem: string; ADestino: string; ALatitude: Double; ALongitude: Double; const ARequestFilter: string): Boolean;
begin
  if FConfirmarServicoCommand = nil then
  begin
    FConfirmarServicoCommand := FConnection.CreateCommand;
    FConfirmarServicoCommand.RequestType := 'GET';
    FConfirmarServicoCommand.Text := 'TSrvMetodos.ConfirmarServico';
    FConfirmarServicoCommand.Prepare(TSrvMetodos_ConfirmarServico);
  end;
  FConfirmarServicoCommand.Parameters[0].Value.SetWideString(AOrigem);
  FConfirmarServicoCommand.Parameters[1].Value.SetWideString(ADestino);
  FConfirmarServicoCommand.Parameters[2].Value.SetDouble(ALatitude);
  FConfirmarServicoCommand.Parameters[3].Value.SetDouble(ALongitude);
  FConfirmarServicoCommand.Execute(ARequestFilter);
  Result := FConfirmarServicoCommand.Parameters[4].Value.GetBoolean;
end;

function TSrvMetodosClient.GetPosicaoEntrega(AID_Entrega: Integer; const ARequestFilter: string): string;
begin
  if FGetPosicaoEntregaCommand = nil then
  begin
    FGetPosicaoEntregaCommand := FConnection.CreateCommand;
    FGetPosicaoEntregaCommand.RequestType := 'GET';
    FGetPosicaoEntregaCommand.Text := 'TSrvMetodos.GetPosicaoEntrega';
    FGetPosicaoEntregaCommand.Prepare(TSrvMetodos_GetPosicaoEntrega);
  end;
  FGetPosicaoEntregaCommand.Parameters[0].Value.SetInt32(AID_Entrega);
  FGetPosicaoEntregaCommand.Execute(ARequestFilter);
  Result := FGetPosicaoEntregaCommand.Parameters[1].Value.GetWideString;
end;

function TSrvMetodosClient.CapturarServico(AID_Entregador: Integer; const ARequestFilter: string): Boolean;
begin
  if FCapturarServicoCommand = nil then
  begin
    FCapturarServicoCommand := FConnection.CreateCommand;
    FCapturarServicoCommand.RequestType := 'GET';
    FCapturarServicoCommand.Text := 'TSrvMetodos.CapturarServico';
    FCapturarServicoCommand.Prepare(TSrvMetodos_CapturarServico);
  end;
  FCapturarServicoCommand.Parameters[0].Value.SetInt32(AID_Entregador);
  FCapturarServicoCommand.Execute(ARequestFilter);
  Result := FCapturarServicoCommand.Parameters[1].Value.GetBoolean;
end;

constructor TSrvMetodosClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TSrvMetodosClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TSrvMetodosClient.Destroy;
begin
  FSolicitarServicoCommand.DisposeOf;
  FConfirmarServicoCommand.DisposeOf;
  FGetPosicaoEntregaCommand.DisposeOf;
  FCapturarServicoCommand.DisposeOf;
  inherited;
end;

end.

