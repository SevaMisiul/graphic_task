unit SkierUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, Vcl.Menus;

type
  TSkier = class(TObject)
  private
    FScale: Single;
    FHeadRadius, FBodyLen, FLegLenL, FNeck: Word;
    FArm, FForearm, FShoulder, FLegU, FStick, FSki, FBody, FStart: TPoint;
    FBmp: TBitMap;
  public
    constructor Create(const ParentBmp: TBitMap; X, Y: integer);
    destructor Destroy; overload;
    procedure Draw(X, Y: Word; Sc: Single; angle: Single);
    procedure Scale(Scale: Single);

    property Bmp: TBitMap read FBmp;
  end;

implementation

{ TSkier }

constructor TSkier.Create(const ParentBmp: TBitMap; X, Y: integer);
begin
  inherited Create;
  FScale := 1;
  FStart.X := X - 20 - 50 div 2;
  FStart.Y := Y + 15 + 50 - 30 div 2;
  Scale(FScale);
  FBmp := ParentBmp;
end;

destructor TSkier.Destroy;
begin
  inherited Destroy;
end;

procedure TSkier.Draw(X, Y: Word; Sc: Single; angle: Single);
begin
  angle := angle * Pi / 180;
  Scale(Sc);
  with Bmp, Bmp.Canvas do
  begin
    Pen.Width := 2;

    MoveTo(X, Y);
    LineTo(X + FLegU.X, Y + FLegU.Y);
    LineTo(X + FLegU.X, Y + FLegU.Y + FLegLenL);
    // лыжи
    LineTo(X + FLegU.X - FSki.X div 2, Y + FLegU.Y + FLegLenL - FSki.Y div 2);

    Pen.Width := 5;
    Pen.Color := Rgb(235, 230, 230);
    LineTo(FStart.X, FStart.Y - FLegU.X);
    Pen.Width := 2;
    Pen.Color := clBlack;

    MoveTo(X + FLegU.X - FSki.X div 2, Y + FLegU.Y + FLegLenL - FSki.Y div 2);
    LineTo(X + FLegU.X + FSki.X, Y + FLegU.Y + FLegLenL + FSki.Y);

    MoveTo(X, Y);
    LineTo(X - FLegU.X, Y + FLegU.Y);
    LineTo(X - FLegU.X, Y + FLegU.Y + FLegLenL);
    // лыжи
    LineTo(X - FLegU.X - FSki.X div 2, Y + FLegU.Y + FLegLenL - FSki.Y div 2);
    Pen.Width := 5;
    Pen.Color := Rgb(235, 230, 230);
    LineTo(FStart.X, FStart.Y);
    Pen.Width := 2;
    Pen.Color := clBlack;
    MoveTo(X - FLegU.X - FSki.X div 2, Y + FLegU.Y + FLegLenL - FSki.Y div 2);
    LineTo(X - FLegU.X + FSki.X, Y + FLegU.Y + FLegLenL + FSki.Y);

    // тело
    MoveTo(X, Y);
    LineTo(Round(X + 40 * cos(angle)), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle)));
    // left плечо
    LineTo(Round(X + 40 * cos(angle) - FShoulder.X), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle) + FShoulder.Y));
    // рука
    LineTo(Round(X + 40 * cos(angle) - FShoulder.X - (-FForearm.X + FForearm.X div 2) * cos(angle * 5 / 3)),
      Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle) + FShoulder.Y + FForearm.Y + (FForearm.Y div 5) *
      cos(90 - 4 / 3 * angle)));
    // предплечье
    LineTo(Round(X + 40 * cos(angle) - FShoulder.X - (-FForearm.X + FForearm.X div 2) * cos(angle * 5 / 3) + FArm.X *
      cos(angle * 5 / 6)), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle) + FShoulder.Y + FForearm.Y +
      (FForearm.Y div 5) * cos(90 - 4 / 3 * angle) + FArm.Y + FArm.Y * cos(90 - angle)));
    // палка вверх
    LineTo(Round(X + 40 * cos(angle) - FShoulder.X - (-FForearm.X + FForearm.X div 2) * cos(angle * 5 / 3) + FArm.X *
      cos(angle * 5 / 6) + 3 + 6 * cos(90 - angle)), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle) + FShoulder.Y +
      FForearm.Y + (FForearm.Y div 5) * cos(90 - 7 / 3 * angle) + FArm.Y + FArm.Y * cos(90 - angle) - 5 - 5 *
      cos(angle)));
    // палка вниз
    LineTo(Round(X - FLegU.X - 10 * Sc - 30 * Sc * cos(90 - angle)),
      Round(Y + FLegU.Y + FLegLenL + 30 - 30 * Sc * cos(90 - angle)));
    // right
    MoveTo(Round(X + 40 * cos(angle)), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle)));
    // плечо
    LineTo(Round(X + 40 * cos(angle) + FShoulder.X), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle) - FShoulder.Y));
    // рука
    LineTo(Round(X + 40 * cos(angle) + FShoulder.X + FForearm.X * cos(angle * 5 / 6)),
      Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle) - FShoulder.Y + FForearm.Y + (FForearm.Y div 2) *
      cos(90 - 4 / 3 * angle)));
    // предплечье
    LineTo(Round(X + 40 * cos(angle) + FShoulder.X + FForearm.X * cos(angle * 5 / 6) + (FArm.X + FArm.X div 4) *
      cos(angle * 5 / 6)), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle) - FShoulder.Y + FForearm.Y +
      (FForearm.Y div 2) * cos(90 - 4 / 3 * angle) + FArm.Y div 2 + 2 * FArm.Y * cos(90 - angle)));
    // палка вверх
    LineTo(Round(X + 40 * cos(angle) + FShoulder.X + FForearm.X * cos(angle * 5 / 6) + (FArm.X + FArm.X div 4) *
      cos(angle * 5 / 6) + 3), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle) - FShoulder.Y + FForearm.Y +
      (FForearm.Y div 2) * cos(90 - 4 / 3 * angle) + FArm.Y div 2 + 2 * FArm.Y * cos(90 - angle) - 10));
    // палка вниз
    LineTo(Round(X + 40 * cos(angle) + FLegU.X + 20 - 40 * cos(90 - angle)),
      Round(Y + FLegU.Y + FLegLenL - 30 - 50 * cos(90 - angle)));

    MoveTo(Round(X + 40 * cos(angle)), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle)));
    LineTo(Round(X + 45 * cos(angle)), Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle)) - FNeck);
    Ellipse(Round(X + 45 * cos(angle)) - FHeadRadius div 2,
      Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle) - FNeck - 2 * FHeadRadius + FHeadRadius div 2),
      Round(X + 45 * cos(angle)) + FHeadRadius div 2, Round(Y - FBodyLen + (FBodyLen div 3) * cos(angle)) - FNeck);

  end;
end;

procedure TSkier.Scale(Scale: Single);
begin
  FScale := Scale;
  FHeadRadius := Round(30 * FScale);
  FShoulder.X := Round(20 * FScale);
  FShoulder.Y := Round(15 * FScale);
  FBodyLen := Round(90 * FScale);
  FLegLenL := Round(50 * FScale);
  FNeck := Round(10 * FScale);
  FArm.X := Round(20 * FScale);
  FArm.Y := Round(10 * FScale);
  FForearm.X := Round(15 * FScale);
  FForearm.Y := Round(15 * FScale);
  FLegU.X := Round(20 * FScale);
  FLegU.Y := Round(15 * FScale);
  FStick.X := Round(10 * FScale);
  FStick.Y := Round(70 * FScale);
  FSki.X := Round(50 * FScale);
  FSki.Y := Round(30 * FScale);
end;

end.
