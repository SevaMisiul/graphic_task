unit FanUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, Vcl.Menus, Math;

type
  TFan = class(TObject)
  private
    FBmp: TBitMap;
    FHeadRadius, FBodyLen, FArmLen: Word;
    FLeg, FBody, FTablet: TPoint;
    procedure Scale(Sc: Single);
  public
    procedure Draw(XB, YB, Angel: SmallInt; clTablet: Integer; WithText: Boolean; Sc: Single);
    constructor Create(ParentBmp: TBitMap);
    destructor Destroy; overload;
  end;

implementation

uses MainUnit;

{ TFan }

constructor TFan.Create(ParentBmp: TBitMap);
begin
  inherited Create;
  FBmp := ParentBmp;
end;

destructor TFan.Destroy;
begin
  inherited Destroy;
end;

procedure TFan.Draw(XB, YB, Angel: SmallInt; clTablet: Integer; WithText: Boolean; Sc: Single);
var
  pW: SmallInt;
  colP, colB: TColor;
  Alpha: Extended;
begin
  Scale(Sc);
  pW := 2;
  colP := clBlack;
  colB := clWhite;
  MainForm.SetPen(colP, colB, pW, FBmp);
  with FBmp, FBmp.Canvas do
  begin
    // head
    Ellipse(Rect(XB - FHeadRadius, YB - FBodyLen - 2 * FHeadRadius, XB + FHeadRadius, YB - FBodyLen));
    // body
    MoveTo(XB, YB);
    LineTo(XB, -FBodyLen + YB);
    // right leg
    MoveTo(XB, YB);
    LineTo(XB + FLeg.X, YB + FLeg.Y);
    // left leg
    MoveTo(XB, YB);
    LineTo(XB - FLeg.X, YB + FLeg.Y);
    // left arm
    Alpha := Angel / 180 * Pi;
    MoveTo(XB, -FBodyLen * 4 div 5 + YB);
    LineTo(XB - Round(FArmLen / 2 * Cos(Alpha)), -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2));
    LineTo(XB - Round(FArmLen / 2 * Cos(Alpha) + Sin(Alpha) * FArmLen / 2),
      -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 * Cos(Alpha)));
    // tablet
    Brush.Color := clTablet;
    FillRect(Rect(XB - FTablet.X div 2, -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 *
      Cos(Alpha)) - FTablet.Y, XB - FTablet.X div 2 + FTablet.X,
      -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 * Cos(Alpha))));
    if WithText then
    begin
      // GO text
      MoveTo(XB - FTablet.X div 4, -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 * Cos(Alpha))
        - FTablet.Y div 4);
      LineTo(XB - FTablet.X div 4, -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 * Cos(Alpha))
        - FTablet.Y * 3 div 4);
      LineTo(XB - FTablet.X div 4 + FTablet.X div 5, -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen
        / 2 * Cos(Alpha)) - FTablet.Y * 3 div 4);
      MoveTo(XB - FTablet.X div 4, -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 * Cos(Alpha))
        - FTablet.Y div 4);
      LineTo(XB - FTablet.X div 4 + FTablet.X div 5, -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen
        / 2 * Cos(Alpha)) - FTablet.Y div 4);
      LineTo(XB - FTablet.X div 4 + FTablet.X div 5, -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen
        / 2 * Cos(Alpha)) - FTablet.Y div 2);
      LineTo(XB - FTablet.X div 6, -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 * Cos(Alpha))
        - FTablet.Y div 2);
      Rectangle(Rect(XB - FTablet.X div 4 + FTablet.X div 5 + FTablet.X div 10,
        -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 * Cos(Alpha)) - FTablet.Y * 3 div 4,
        XB - FTablet.X div 4 + 2 * FTablet.X div 5 + FTablet.X div 10,
        -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 * Cos(Alpha)) - FTablet.Y div 4));
    end;
    // right arm
    MoveTo(XB, -FBodyLen * 4 div 5 + YB);
    LineTo(XB + Round(FArmLen / 2 * Cos(Alpha)), -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2));
    LineTo(XB + Round(FArmLen / 2 * Cos(Alpha) + Sin(Alpha) * FArmLen / 2),
      -FBodyLen * 4 div 5 + YB - Round(Sin(Alpha) * FArmLen / 2 + FArmLen / 2 * Cos(Alpha)));
  end;
  MainForm.SetPen(colP, colB, pW, FBmp);
end;

procedure TFan.Scale(Sc: Single);
begin
  FLeg.X := Round(25 * Sc);
  FLeg.Y := Round(25 * Sc);
  FBodyLen := Round(40 * Sc);
  FArmLen := Round(30 * Sc);
  FTablet.X := Round(60 * Sc);
  FTablet.Y := Round(30 * Sc);
  FHeadRadius := Round(8 * Sc);
end;

end.
