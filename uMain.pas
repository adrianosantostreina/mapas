unit uMain;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Generics.Collections,
  System.JSON,
  System.Sensors,
  System.Sensors.Components,
  System.StrUtils,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.Layouts,
  FMX.TabControl,
  FMX.ListBox,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Grid.Style,
  FMX.Grid,
  FMX.Bind.DBEngExt,
  FMX.Bind.Grid,
  FMX.Bind.Editors,
  FMX.Maps,
  FMX.ImgList,
  FMX.Objects,

  System.Rtti,
  System.Bindings.Outputs,
  System.ImageList,

  Data.Bind.EngExt,
  Data.Bind.Components,
  Data.Bind.Grid,
  Data.Bind.DBScope,
  Data.Db,

  UntLib;

type
  TForm1 = class(TForm)
    mpView: TMapView;
    locGPS: TLocationSensor;
    ImageList1: TImageList;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure locGPSLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure Button1Click(Sender: TObject);
  private
    FLatitude : Double;
    FLongitude : Double;
    Marcador : TMapMarkerDescriptor;
    MapCoordenadas: TMapCoordinate;
    FMarcadores : TList<TMapMarker>;
    FMostrarMarcadores: Boolean;
    FGeoCoord : TGeocoder;

    procedure Inicializar;
    procedure Centralizar;
    procedure LimparMarcadores;
    procedure OnGeocodeReverseEvent(const Address: TCivicAddress);
    procedure SimularPontos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  UntCM,
  UntdmRest;

procedure TForm1.OnGeocodeReverseEvent(const Address: TCivicAddress);
begin
end;

procedure TForm1.SimularPontos;
var
  StrPontos : TStringList;
  strLinha  : String;
  fLatitude, fLongitude : Double;
  sCodigo: String;

  I: Integer;
begin
  try
    StrPontos := TStringList.Create;
    StrPontos.Add('PONTO001;-23,554807;-46,545326');
    StrPontos.Add('PONTO002;-23,559790;-46,546385');
    StrPontos.Add('PONTO003;-23,551032;-46,201023');

    for I := 0 to Pred(StrPontos.Count) do
    begin
      strLinha   := StrPontos[I];
      sCodigo    :=  (SplitString(StrPontos[I], ';'))[0];
      fLatitude  := ((SplitString(StrPontos[I], ';'))[1]).ToDouble();
      fLongitude := ((SplitString(StrPontos[I], ';'))[2]).ToDouble();

      //Criando as coordenadas do aplicativo
      MapCoordenadas := TMapCoordinate.Create(FLatitude, FLongitude);
      MapCoordenadas.Latitude  := fLatitude;
      MapCoordenadas.Longitude := fLongitude;

      //Criando nosso marcador
      Marcador := TMapMarkerDescriptor.Create(MapCoordenadas, sCodigo);
      Marcador.Draggable := True;
      Marcador.Visible   := True;
      Marcador.Icon      := ImageList1.Bitmap(TSizeF.Create(64,64),1);

      mpView.Zoom := 15;

      FMarcadores.Add(mpView.AddMarker(Marcador));
    end;
  finally
    StrPontos.DisposeOf;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SimularPontos;
end;

procedure TForm1.Centralizar;
begin
  if FMarcadores.Count > 0
  then mpView.Location := FMarcadores.Last.Descriptor.Position
  else mpView.Location := TMapCoordinate.Zero;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TForm1.Inicializar;
begin
  FMarcadores             := TList<TMapMarker>.Create;
  FMostrarMarcadores      := True;
  locGPS.Active           := True;
end;

procedure TForm1.LimparMarcadores;
var
  LocalMarker: TMapMarker;
begin
  {$IFDEF Android}
  for LocalMarker in FMarcadores do
    LocalMarker.Remove;

  FMarcadores.Clear;
  {$EndIf}
end;

procedure TForm1.locGPSLocationChanged(Sender: TObject; const OldLocation,
  NewLocation: TLocationCoord2D);
begin
  {$IFDEF iOS}
    FLatitude  := -23.55662902;
    FLongitude := -46.54179548;
  {$ELSE}
    FLatitude  := NewLocation.Latitude;
    FLongitude := NewLocation.Longitude;
  {$ENDIF}

  LimparMarcadores;

  //Criando as coordenadas do aplicativo
  MapCoordenadas := TMapCoordinate.Create(FLatitude, FLongitude);
  MapCoordenadas.Latitude  := FLatitude;
  MapCoordenadas.Longitude := FLongitude;

  //Criando nosso marcador
  Marcador := TMapMarkerDescriptor.Create(MapCoordenadas, 'Minha Localização');
  Marcador.Draggable := True;
  Marcador.Visible   := FMostrarMarcadores;
  Marcador.Icon      := ImageList1.Bitmap(TSizeF.Create(64,64), 0);

  mpView.Zoom := 15;

  FMarcadores.Add(mpView.AddMarker(Marcador));
  Centralizar;
  mpView.Zoom := 15;

  locGPS.Active := False;
end;

end.
