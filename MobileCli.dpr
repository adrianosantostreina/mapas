program MobileCli;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form1},
  Proxy in 'Proxy.pas',
  UntCM in 'UntCM.pas' {CM: TDataModule},
  UntdmRest in 'UntdmRest.pas' {dmREST: TDataModule},
  UntLib in 'UntLib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmREST, dmREST);
  Application.CreateForm(TCM, CM);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
