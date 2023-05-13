unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Menus, SkierUnit, Vcl.StdCtrls;

type
  TMainFrom = class(TForm)
    pbAnimate: TPaintBox;
    menuMain: TMainMenu;
    menuRunAnimation: TMenuItem;
    alActions: TActionList;
    actRunAnimation: TAction;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FBuff: TBitMap;
  public
    Skier: TSkier;
  end;

var
  MainFrom: TMainFrom;

implementation

{$R *.dfm}

procedure TMainFrom.Button1Click(Sender: TObject);
begin
  Skier.Bmp.Canvas.LineTo(1000, 1000);
  pbAnimate.Canvas.Draw(0,0, FBuff);
end;

procedure TMainFrom.FormResize(Sender: TObject);
begin
  FBuff := TBitMap.Create;
  FBuff.SetSize(pbAnimate.Width, pbAnimate.Height);
  Skier := TSkier.Create(FBuff);
end;

end.
