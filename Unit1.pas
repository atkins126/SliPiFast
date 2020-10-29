unit Unit1;

interface

uses
  SysUtils, Classes, Controls, Forms, StdCtrls, Math;

type
  TForm1 = class(TForm)
    btnCalcPi: TButton;
    edtPi: TEdit;
    edtIterations: TEdit;
    lblIterations: TLabel;
    lblPi: TLabel;
    lblTime: TLabel;
    procedure btnCalcPiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  start, finish: TDateTime;

implementation


{$R *.dfm}

function PiBBP(iterations: integer): Extended;
var
  i: Integer;
  k8: longint;
  sum: Extended;
begin
{The Bailey-Borwein-Plouffe formula (BBP) for calculating π was discovered in
1995 by Simon Plouffe. Using base 16 math, the formula can compute any
particular digit of π returning the hexadecimal value of the digit without
having to compute the intervening digits (digit extraction).
PI = sum(k=0->inf) ( (1/16)^k * ( 4/(8*k+1) - 2/(8*k+4) - 1/(8*k+5) - 1/(8*k+6))}
  sum := 0.0;
  for i := 0 to iterations do
  begin
    k8 := i shl 3;
    sum := sum + (4 / (k8 + 1) - 2 / (k8 + 4) - 1 / (k8 + 5) - 1 / (k8 + 6)) / Power(16, i);
  end;
  PiBBP := sum;
end;

procedure TForm1.btnCalcPiClick(Sender: TObject);
begin
  try
    start := Now;
    edtPi.Text := FloatToStrF(PiBBP(StrToInt(edtIterations.Text)), ffGeneral, 22, 22);
    finish := Now;
    lblTime.Caption := 'Calculation time: ' + FormatDateTime('hh:mm:ss.zz', finish - start);
  except
    on E: Exception do
      edtPi.Text := E.Classname + ': ' + E.Message;
  end;
end;

end.

