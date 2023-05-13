unit SkierUnit;

interface

type
  TSkier = class(TObject)
  public
    procedure Create; overload;
    procedure Destroy; overload;
  private

  end;

implementation

{ TSkier }

procedure TSkier.Create;
begin
  inherited Create;

end;

procedure TSkier.Destroy;
begin
  inherited Destroy;

end;

end.
