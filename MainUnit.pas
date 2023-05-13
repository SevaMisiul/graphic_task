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
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure pbAnimatePaint(Sender: TObject);
    procedure SetPen(var colP, colB: TColor; var pW: Word);
  private
    FIsCreating: Boolean;
    FBuff: TBitMap;
    FSkier: TSkier;
    procedure DrawTree(XL, YD, Count: Word);
  public
    destructor Destroy; overload;
    procedure DrawBackground;
  end;

var
  MainFrom: TMainFrom;

implementation

{$R *.dfm}

procedure TMainFrom.Button1Click(Sender: TObject);
begin
  FSkier.Draw(400, 400);
  pbAnimate.Invalidate;
end;

destructor TMainFrom.Destroy;
begin
  FBuff.Destroy;

  inherited Destroy;
end;

procedure TMainFrom.DrawBackground;
var
  X, Y: Word;
begin
  with FBuff, FBuff.Canvas do
  begin
    MoveTo(0, ClientHeight div 6);
    LineTo(ClientWidth - ClientWidth * 2 div 5, ClientHeight);
    MoveTo(ClientHeight div 6, 0);
    LineTo(ClientWidth, ClientHeight - ClientHeight * 2 div 5);

    X := 0;
    Y := 0;
    while X < ClientWidth do
    begin
      MoveTo(X, Y);
      Inc(X, ClientWidth div 9);
      Inc(Y, ClientHeight div 9);
      LineTo(X, Y);
      Inc(X, ClientWidth div 12);
      Inc(Y, ClientHeight div 12);
    end;

    DrawTree(800, 400, 3);
  end;
end;

procedure TMainFrom.DrawTree(XL, YD, Count: Word);
var
  H, W, XR, YT, XM, pW: Word;
  I: Integer;
  colP, colB: TColor;
begin
  colP := 51;
  colB := 51;
  pW := 3;
  SetPen(colP, colB, pW);

  H := ClientHeight;
  W := ClientWidth;
  with FBuff, FBuff.Canvas do
  begin
    XR := XL + W div 60;
    YT := YD - H div 20;
    XM := XL + W div 120;
    FillRect(Rect(XL, YD, XR, YT));
    Brush.Color := clGreen;
    Pen.Color := $0D5A0F;
    for I := 1 to Count do
    begin
      Polygon([Point(XL - W div 20, YT), Point(XR + W div 20, YT), Point(XM, YT - H div 15)]);
      Dec(YT, H div 20);
      Dec(W, W div 4);
      Dec(H, H div 40);
    end;
  end;

  SetPen(colP, colB, pW);
end;

procedure TMainFrom.FormCreate(Sender: TObject);
begin
  FIsCreating := True;
end;

procedure TMainFrom.FormResize(Sender: TObject);
begin
  if FIsCreating then
  begin
    FBuff := TBitMap.Create;
    FBuff.SetSize(pbAnimate.Width, pbAnimate.Height);
    FSkier := TSkier.Create(FBuff);
    FIsCreating := False;
    Constraints.MinWidth := Screen.Width;
    Constraints.MinHeight := Screen.Height;
  end;

end;

procedure TMainFrom.pbAnimatePaint(Sender: TObject);
begin
  pbAnimate.Canvas.Draw(0, 0, FBuff);
  DrawBackground;
end;

procedure TMainFrom.SetPen(var colP, colB: TColor; var pW: Word);
var
  tmpColP, tmpColB: TColor;
  tmpPW: Word;
begin
  with FBuff, FBuff.Canvas do
  begin
    tmpColP := Pen.Color;
    tmpColB := Brush.Color;
    tmpPW := Pen.Width;

    Pen.Color := colP;
    Brush.Color := colB;
    Pen.Width := pW;

    colP := tmpColP;
    colB := tmpColB;
    pW := tmpPW;
  end;
end;

end.
