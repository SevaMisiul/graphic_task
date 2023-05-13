program Graphic;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainFrom};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFrom, MainFrom);
  Application.Run;
end.
