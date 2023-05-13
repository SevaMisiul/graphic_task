unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TMainFrom = class(TForm)
    pbAnimate: TPaintBox;
    menuMain: TMainMenu;
    menuRunAnimation: TMenuItem;
    alActions: TActionList;
    actRunAnimation: TAction;
    procedure FormCreate(Sender: TObject);
  private
    FBuff: TBitMap;
  public
    { Public declarations }
  end;

var
  MainFrom: TMainFrom;

implementation

{$R *.dfm}

procedure TMainFrom.FormCreate(Sender: TObject);
begin
  FBuff := TBitmap.Create;
  FBuff.SetSize(ClientWidth, ClientHeight);
end;

end.
