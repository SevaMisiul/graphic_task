unit SkierUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  TSkier = class(TObject)
  private
    FNeckLen, FHeadRadius, FShoulderKen, FArmLen, FForearmLen, FBodyLen, FLegLenU, FLegLenL, FStickLen, FSkyLen, FBodyX,
      FBodyY: Word;
    FBmp: TBitMap;
  public
    constructor Create(const ParentBmp: TBitMap);
    destructor Destroy; overload;
    procedure Draw;

    property Bmp: TBitMap read FBmp;
  end;

implementation

{ TSkier }

constructor TSkier.Create(const ParentBmp: TBitMap);
begin
  inherited Create;
  FBmp := ParentBmp;
end;

destructor TSkier.Destroy;
begin
  inherited Destroy;

end;

procedure TSkier.Draw;
begin

end;

end.
