unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Menus, SkierUnit, Vcl.StdCtrls,
  Vcl.MPlayer;

type
  TMainFrom = class(TForm)
    pbAnimate: TPaintBox;
    menuMain: TMainMenu;
    menuRunAnimation: TMenuItem;
    alActions: TActionList;
    actRunAnimation: TAction;
    MediaPlayer1: TMediaPlayer;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pbAnimatePaint(Sender: TObject);
    procedure SetPen(var colP, colB: TColor; var pW: SmallInt);
    procedure actRunAnimationExecute(Sender: TObject);
    procedure Animate(Sender: TObject);
  private
    FStartTime: Integer;
    FIsCreating: Boolean;
    FBuff: TBitMap;
    FSkier: TSkier;
    procedure ComleteAnimation;
    procedure DrawTree(XL, YD, Count: SmallInt);
    procedure DrawFinishGates;
  public
    destructor Destroy; overload;
    procedure DrawBackground;
  end;

var
  MainFrom: TMainFrom;

implementation

{$R *.dfm}

procedure TMainFrom.actRunAnimationExecute(Sender: TObject);
begin
  pbAnimate.OnPaint := Animate;
  FStartTime := GetTickCount;
  Invalidate;
end;

procedure TMainFrom.Animate(Sender: TObject);
var
  tDelta, X, Y: Integer;
begin
  tDelta := GetTickCount - FStartTime;
  if tDelta >= 15000 then
    ComleteAnimation
  else
  begin
    FBuff.Canvas.FillRect(Rect(0, 0, ClientWidth, ClientHeight));
    X := Round(ClientWidth * 4 div 5 * tDelta / 15000);
    FSkier.Draw(X, ClientHeight - Round(X * (-ClientHeight / ClientWidth) + ClientHeight * 10 div 11),
      1 + 1.8 * tDelta / 15000);
    DrawBackground;
    pbAnimate.Canvas.Draw(0, 0, FBuff);
    Sleep(0);
    pbAnimate.Invalidate;
  end;
end;

procedure TMainFrom.ComleteAnimation;
begin
  pbAnimate.OnPaint := pbAnimatePaint;
  pbAnimate.Invalidate;
end;

destructor TMainFrom.Destroy;
begin
  FBuff.Destroy;
  inherited Destroy;
end;

procedure TMainFrom.DrawBackground;
var
  X, Y, rW, trC: Word;
  I: Integer;
begin
  with FBuff, FBuff.Canvas do
  begin
    MoveTo(0, ClientHeight div 6);
    LineTo(ClientWidth * 3 div 5, ClientHeight);
    MoveTo(ClientHeight div 6, 0);
    LineTo(ClientWidth, ClientHeight * 3 div 5);
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
    for I := 2 to 7 do
    begin
      rW := ClientWidth * I div 7;
      DrawTree(rW, -Round(rW * (3 / 5) * ClientHeight / (ClientHeight / 6 - ClientWidth) -
        (sqr(ClientHeight) / (10 * (ClientHeight / 6 - ClientWidth)))) - ClientHeight div 40, 3 + I mod 2);
    end;
    for I := 0 to 4 do
    begin
      rW := ClientWidth * I div 10 + ClientWidth div 20;
      trC := 3 + I mod 2;
      DrawTree(rW, ClientHeight - Round(rW * (-5 / 6) * ClientHeight / ((3 / 5) * ClientWidth) + 5 / 6 * ClientHeight -
        19 * ClientHeight div 60), trC);
    end;
    DrawFinishGates;
  end;
end;

procedure TMainFrom.DrawFinishGates;

  function TopLine(X: Integer): Integer;
  begin
    Result := Round(((ClientHeight div 3) * (ClientWidth * 3 div 5 - X)) / (ClientWidth - 10 - ClientWidth * 3 div 5)) + ClientHeight div 3;
  end;

var
  pW, LX, RX, LY, RY, TxtHeight, LetterWidth: SmallInt;
  colP, colB: TColor;
begin
  pW := 10;
  colP := 0;
  colB := $3F00CF;
  SetPen(colP, colB, pW);

  LX := ClientWidth * 3 div 5;
  LY := ClientHeight div 3;
  RX := ClientWidth - 10;
  RY := ClientHeight * 3 div 5;

  with FBuff.Canvas do
  begin
    MoveTo(LX, ClientHeight);
    LineTo(LX, LY);
    LineTo(RX, 0);
    LineTo(RX, RY);
    MoveTo(LX, LY + ClientHeight div 7);
    LineTo(RX, ClientHeight div 7);
    Polygon([Point(LX, LY), Point(LX, LY + ClientHeight div 7), Point(RX, ClientHeight div 7), Point(RX, 0)]);

    LetterWidth := (RX - LX) div ('FINISH'.Length + 12);
    TxtHeight := ClientHeight div 20;

      Inc(LX, (RX - LX) div 3);                               {F}
      MoveTo(LX, LY);
      LineTo(LX, TopLine(LX) + ClientHeight div 30);
      LineTo(LX + LetterWidth, TopLine(LX + LetterWidth) + ClientHeight div 30);
      MoveTo(LX, TopLine(LX) + 2 * ClientHeight div 30);
      LineTo(LX + LetterWidth div 2, TopLine(LX + LetterWidth div 2) + 2 * ClientHeight div 30);

      Inc(LX, ClientWidth div 30);                                          {I}
      Dec(LY, LetterWidth);
      MoveTo(LX, LY);
      LineTo(LX, TopLine(LX) + ClientHeight div 30);

      Inc(LX, ClientWidth div 50);                                   {N}
      Dec(LY, LetterWidth div 2);
      MoveTo(LX, LY);
      LineTo(LX, TopLine(LX) + ClientHeight div 30);
      LineTo(LX + LetterWidth, TopLine(LX + LetterWidth)+ ClientHeight div 20 + TxtHeight);
      LineTo(LX + LetterWidth, TopLine(LX + LetterWidth) + ClientHeight div 30 );

      Inc(LX, ClientWidth div 25);                                          {I}
      Dec(LY, LetterWidth);
      MoveTo(LX, LY);
      LineTo(LX, TopLine(LX) + ClientHeight div 30);

      Inc(LX, ClientWidth div 50);                                          {S}
      Dec(LY, LetterWidth div 2);
      MoveTo(LX, LY);
      LineTo(LX + LetterWidth, TopLine(LX + LetterWidth)+ ClientHeight div 23 + TxtHeight);
      LineTo(LX + LetterWidth, TopLine(LX + LetterWidth)+ ClientHeight div 23 + TxtHeight div 2);
      LineTo(LX, TopLine(LX) + 2 * ClientHeight div 28);
      LineTo(LX, TopLine(LX) + ClientHeight div 30);
      LineTo(LX + LetterWidth, TopLine(LX + LetterWidth)+ ClientHeight div 31);

      Inc(LX, ClientWidth div 30);                                          {H}
      Dec(LY, ClientHeight div 30);
      MoveTo(LX, LY);
      LineTo(LX, TopLine(LX) + ClientHeight div 30);
     MoveTo(LX, TopLine(LX) + 2 * ClientHeight div 30);
     LineTo(LX + LetterWidth, TopLine(LX + LetterWidth) + 2 * ClientHeight div 30);
      MoveTo(LX + LetterWidth, TopLine(LX + LetterWidth) + ClientHeight div 30);
      LineTo(LX + LetterWidth , TopLine(LX + LetterWidth) + ClientHeight div 25 + TxtHeight);
  end;

  SetPen(colP, colB, pW);
end;

procedure TMainFrom.DrawTree(XL, YD, Count: SmallInt);
var
  H, W, XR, YT, XM, pW: SmallInt;
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
  FBuff.Canvas.FillRect(Rect(0, 0, ClientWidth, ClientHeight));
  DrawBackground;
  FSkier.Draw(1800, 1000, 2.3);
  pbAnimate.Canvas.Draw(0, 0, FBuff);
end;

procedure TMainFrom.SetPen(var colP, colB: TColor; var pW: SmallInt);
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
