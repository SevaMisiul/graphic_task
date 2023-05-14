program Graphic;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  SkierUnit in 'SkierUnit.pas',
  FanUnit in 'FanUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
