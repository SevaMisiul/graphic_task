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

    FArm, FForearm, FShoulder, FLegU, FStick, FSki, FBody: TPoint;
    FBmp: TBitMap;
  public
    constructor Create(const ParentBmp: TBitMap);
    destructor Destroy; overload;
    procedure Draw(X, Y: Word; Sc: Single);
    procedure Scale(Scale: Single);

    property Bmp: TBitMap read FBmp;
  end;

implementation

{ TSkier }

constructor TSkier.Create(const ParentBmp: TBitMap);
begin
  inherited Create;
  FScale := 1;
  Scale(FScale);
  FBmp := ParentBmp;
end;

destructor TSkier.Destroy;
begin
  inherited Destroy;
end;

procedure TSkier.Draw(X, Y: Word; Sc: Single);
begin
  Scale(Sc);
  with Bmp, Bmp.Canvas do
  begin
    Pen.Width := 2;
    MoveTo(X, Y);
    LineTo(X - FLegU.X, Y + FLegU.Y);
    LineTo(X - FLegU.X, Y + FLegU.Y + FLegLenL);
    LineTo(X - FLegU.X - FSki.X div 2, Y + FLegU.Y + FLegLenL - FSki.Y div 2);
    LineTo(X - FLegU.X + FSki.X, Y + FLegU.Y + FLegLenL + FSki.Y);
    // Arc(X - FLegU.X + FSki.X , Y + FLegU.Y + FLegLenL + FSki.Y - 10,
    // X - FLegU.X + FSki.X+10 , Y + FLegU.Y + FLegLenL + FSki.Y,
    // X - FLegU.X + FSki.X , Y + FLegU.Y + FLegLenL + FSki.Y,
    // X - FLegU.X + FSki.X + 10 , Y + FLegU.Y + FLegLenL + FSki.Y - 10);

    MoveTo(X, Y);
    LineTo(X + FLegU.X, Y + FLegU.Y);
    LineTo(X + FLegU.X, Y + FLegU.Y + FLegLenL);
    LineTo(X + FLegU.X - FSki.X div 2, Y + FLegU.Y + FLegLenL - FSki.Y div 2);
    LineTo(X + FLegU.X + FSki.X, Y + FLegU.Y + FLegLenL + FSki.Y);

    MoveTo(X, Y);
    LineTo(X, Y - FBodyLen);
    LineTo(X - FShoulder.X, Y - FBodyLen + FShoulder.Y);
    LineTo(X - FShoulder.X - FForearm.X + FForearm.X div 2, Y - FBodyLen + FShoulder.Y + FForearm.Y);
    LineTo(X - FShoulder.X - FForearm.X + FForearm.X div 2 + FArm.X, Y - FBodyLen + FShoulder.Y + FForearm.Y + FArm.Y);
    LineTo(X - FShoulder.X - FForearm.X + FForearm.X div 2 + FArm.X + 3, Y - FBodyLen + FShoulder.Y + FForearm.Y +
      FArm.Y - 10);
    LineTo(X - FLegU.X - 30, Y + FLegU.Y + FLegLenL + 30);

    MoveTo(X, Y - FBodyLen);
    LineTo(X + FShoulder.X, Y - FBodyLen - FShoulder.Y);
    LineTo(X + FShoulder.X + FForearm.X, Y - FBodyLen - FShoulder.Y + FForearm.Y);
    LineTo(X + FShoulder.X + FForearm.X + FArm.X + FArm.X div 4, Y - FBodyLen - FShoulder.Y + FForearm.Y +
      FArm.Y div 2);
    LineTo(X + FShoulder.X + FForearm.X + FArm.X + FArm.X div 4 + 3, Y - FBodyLen - FShoulder.Y + FForearm.Y +
      FArm.Y div 2 - 10);
    LineTo(X + FLegU.X + 20, Y + FLegU.Y + FLegLenL - 30);

    MoveTo(X, Y - FBodyLen);
    LineTo(X, Y - FBodyLen - FNeck);
    Ellipse(X - FHeadRadius div 2, Y - FBodyLen - FNeck - 2 * FHeadRadius + FHeadRadius div 2, X + FHeadRadius div 2,
      Y - FBodyLen - FNeck);
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
