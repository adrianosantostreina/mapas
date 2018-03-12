unit UntLib;

interface

uses
  System.JSON;

type
  TLib = class
  private
  class var
    FLatitude: Double;
    FLongitude: Double;
  protected


  public
    class function GetUserCoordinates: TJSONObject;
    class property Latitude : Double read FLatitude write FLatitude;
    class property Longitude: Double read FLongitude write FLongitude;
  end;

implementation


{ TLib }

class function TLib.GetUserCoordinates: TJSONObject;
var
  jnCOORD          : TJSONObject;
begin
  {Crio o JSON com dados do cliente}
  try
    jnCOORD          := TJSONObject.Create;
    jnCOORD.AddPair('Latitude', '456');
    jnCOORD.AddPair('Longitude', '789');

    Result := jnCOORD;
  finally
    jnCOORD.DisposeOf;
  end;
end;

end.
