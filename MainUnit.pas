unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Menus, SkierUnit, Vcl.StdCtrls,
  Vcl.MPlayer, FanUnit;


type
  TMainForm = class(TForm)
    pbAnimate: TPaintBox;
    menuMain: TMainMenu;
    menuRunAnimation: TMenuItem;
    alActions: TActionList;
    actRunAnimation: TAction;
    Player: TMediaPlayer;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pbAnimatePaint(Sender: TObject);
    procedure actRunAnimationExecute(Sender: TObject);
    procedure Animate(Sender: TObject);

  private
    FStartTime: Integer;
    FIsCreating: Boolean;
    FBuff: TBitMap;
    FSkier: TSkier;
    FFanArr: array [1 .. 14] of TFan;
    procedure ComleteAnimation;
    procedure DrawTree(XL, YD, Count: SmallInt);
    procedure DrawFinishGates;
    procedure DrawFans(tDelta: Integer);
  public
    destructor Destroy; overload;
    procedure DrawBackground;
    procedure SetPen(var colP, colB: TColor; var pW: SmallInt; var Bmp: TBitMap);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.actRunAnimationExecute(Sender: TObject);
begin
  pbAnimate.OnPaint := Animate;
  Player.FileName := 'Music1.mp3';
  Player.Open;
  Player.Play;
  FStartTime := GetTickCount;
  Invalidate;
end;

procedure TMainForm.Animate(Sender: TObject);
var
  tDelta, X, Y, rW, I, cl: Integer;
  Angle: Double;
begin
  tDelta := GetTickCount - FStartTime;
  if tDelta >= 15000 then
    ComleteAnimation
  else
  begin
    FBuff.Canvas.FillRect(Rect(0, 0, ClientWidth, ClientHeight));
    X := Round(ClientWidth * 4 div 5 * tDelta / 15000);
    Angle := Abs(90 * ((tDelta div 1000) mod 2) - 90 * (tDelta mod 1000) / 1000);
    FSkier.Draw(X, ClientHeight - Round(X * (-ClientHeight / ClientWidth) + ClientHeight * 13 div 14),
      1 + 1.8 * tDelta / 15000, Angle);
    DrawFans(tDelta);
    DrawBackground;
    pbAnimate.Canvas.Draw(0, 0, FBuff);

    Sleep(0);
    pbAnimate.Invalidate;
  end;
end;

procedure TMainForm.ComleteAnimation;
begin
  Player.Stop;
  pbAnimate.OnPaint := pbAnimatePaint;
  pbAnimate.Invalidate;
end;

destructor TMainForm.Destroy;
begin
  FBuff.Destroy;
  inherited Destroy;
end;

procedure TMainForm.DrawBackground;
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

procedure TMainForm.DrawFans(tDelta: Integer);
var
  rW, I, cl: Integer;
begin
  for I := 2 to 6 do
  begin
    rW := ClientWidth div 13 + ClientWidth * I div 7;
    case I mod 3 of
      0:
        cl := clRed;
      1:
        cl := clBlue;
      2:
        cl := clYellow;
    end;
    FFanArr[I - 1].Draw(rW, ClientHeight - Round(rW * (3 / 5) * ClientHeight / (ClientHeight / 6 - ClientWidth) +
      ClientHeight - sqr(ClientHeight) / (10 * (ClientHeight / 6 - ClientWidth)) + (0.8 + 0.4 * I) * 40),
      Abs(Round(100 * (tDelta div 1000 mod 2) - 100 * (tDelta mod 1000) / 1000)), cl, True, 0.8 + 0.3 * I);
  end;

  for I := 1 to 4 do
  begin
    rW := ClientWidth * I div 10 + ClientWidth div 30;
    case I mod 3 of
      0:
        cl := clRed;
      1:
        cl := clBlue;
      2:
        cl := clYellow;
    end;
    FFanArr[I + 5].Draw(rW, ClientHeight - Round(rW * (-25 / 18 * ClientHeight / ClientWidth) + 5 / 6 * ClientHeight -
      (0.8 + 0.6 * I) * 110), Abs(Round(100 * (tDelta div 1000 mod 2) - 100 * (tDelta mod 1000) / 1000)), cl, False,
      0.8 + 0.6 * I);
  end;
end;

procedure TMainForm.DrawFinishGates;

  function TopLine(X: Integer): Integer;
  begin
    Result := Round(((ClientHeight div 3) * (ClientWidth * 3 div 5 - X)) / (ClientWidth - 10 - ClientWidth * 3 div 5)) +
      ClientHeight div 3;
  end;

var
  pW, LX, RX, LY, RY, TxtHeight, LetterWidth: SmallInt;
  colP, colB: TColor;
begin
  pW := 10;
  colP := 0;
  colB := $3F00CF;
  SetPen(colP, colB, pW, FBuff);


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
  SetPen(colP, colB, pW, FBuff);

end;

procedure TMainForm.DrawTree(XL, YD, Count: SmallInt);
var
  H, W, XR, YT, XM, pW: SmallInt;
  I: Integer;
  colP, colB: TColor;
begin
  colP := 51;
  colB := 51;
  pW := 3;
  SetPen(colP, colB, pW, FBuff);
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
  SetPen(colP, colB, pW, FBuff);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FIsCreating := True;
end;

procedure TMainForm.FormResize(Sender: TObject);
var
  X, Y, I: Integer;
begin
  if FIsCreating then
  begin
    FBuff := TBitMap.Create;
    FBuff.SetSize(pbAnimate.Width, pbAnimate.Height);
    X := 0;
    Y := ClientHeight - Round(X * (-ClientHeight / ClientWidth) + ClientHeight * 13 div 14);
    FSkier := TSkier.Create(FBuff, X, Y);
    for I := 1 to 14 do
      FFanArr[I] := TFan.Create(FBuff);
    FIsCreating := False;
    Constraints.MinWidth := Screen.Width;
    Constraints.MinHeight := Screen.Height;
  end;
end;

procedure TMainForm.pbAnimatePaint(Sender: TObject);
begin
  FBuff.Canvas.FillRect(Rect(0, 0, ClientWidth, ClientHeight));
  DrawBackground;
  pbAnimate.Canvas.Draw(0, 0, FBuff);
end;

procedure TMainForm.SetPen(var colP, colB: TColor; var pW: SmallInt; var Bmp: TBitMap);
var
  tmpColP, tmpColB: TColor;
  tmpPW: Word;
begin
  with Bmp, Bmp.Canvas do
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
