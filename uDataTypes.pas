unit uDataTypes;

interface

uses
{$ifdef android}
System.UITypes,
{$else}
Graphics,
{$endif}
System.Classes,System.SysUtils;

type

  ItemProps = class
  public
    ForecastModMin,ForecastModMax,forecastWindowsStep,forecastWindowsSize,forecastPointsCount:integer;
    percetage:double;
  end;

  TElementName = record
    Name,Value:string;
  end;

  TLocalisation = record
    Lang:string;
    Names:array of TElementName;
  end;

  TSpecParam = (frequency,amplitude,damping,phase);

  TMyPoint = record
    X,Y:double;
  end;
  TColoredPoint = record
    X,Y:double;
    color,fillColor:{$ifdef android}TAlphaColor{$else}TColor{$endif};
  end;
  PMyPoint=^TMyPoint;
  PColoredPoint=^TColoredPoint;
  
  TComplex = record
    Re, Im: double;
    class operator Add(a, b: TComplex): TComplex;
    class operator Add(a: TComplex; b: double): TComplex;
    class operator Add(b: double; a: TComplex): TComplex;
    class operator Subtract(a, b: TComplex): TComplex;
    class operator Subtract(a: TComplex; b: double): TComplex;
    class operator Subtract(b: double; a: TComplex): TComplex;
    class operator Multiply(a, b: TComplex): TComplex; overload;
    class operator Multiply(a: TComplex; b: double): TComplex; overload;
    class operator Divide(a, b: TComplex): TComplex; overload;
    class operator Divide(a: TComplex; b: double): TComplex; overload;
    class operator Negative(a: TComplex): TComplex;
    class operator Equal(a, b: TComplex): boolean;
    class operator NotEqual(a, b: TComplex): boolean;
  end;

  TComplexArray = array of TComplex;
  PComplexArray = ^TComplexArray;



function Complex(a, b: double): TComplex; // создание комплексного числа
function CExp(a: TComplex): TComplex; // комплексная экспонента
function Conjg(a: TComplex): TComplex; // сопряженное число



implementation

uses uGraphic;

class operator TComplex.Add(a, b: TComplex): TComplex;
begin
  Result.Re := a.Re + b.Re;
  Result.Im := a.Im + b.Im;
end;

class operator TComplex.Add(a: TComplex; b: double): TComplex;
begin
  Result.Re := a.Re + b;
  Result.Im := a.Im;
end;

class operator TComplex.Add(b: double; a: TComplex): TComplex;
begin
  Result.Re := a.Re + b;
  Result.Im := a.Im;
end;

class operator TComplex.Subtract(a, b: TComplex): TComplex;
begin
  Result.Re := a.Re - b.Re;
  Result.Im := a.Im - b.Im;
end;

class operator TComplex.Subtract(a: TComplex; b: double): TComplex;
begin
  Result.Re := a.Re - b;
  Result.Im := a.Im;
end;

class operator TComplex.Subtract(b: double; a: TComplex): TComplex;
begin
  Result.Re := b - a.Re;
  Result.Im := -a.Im;
end;

class operator TComplex.Multiply(a, b: TComplex): TComplex;
begin
  Result.Re := a.Re * b.Re - a.Im * b.Im;
  Result.Im := a.Re * b.Im + a.Im * b.Re;
end;

class operator TComplex.Multiply(a: TComplex; b: double): TComplex;
begin
  Result.Re := a.Re * b;
  Result.Im := a.Im * b;
end;

class operator TComplex.Divide(a, b: TComplex): TComplex;
begin
  if (sqr(b.Re) + sqr(b.Im)) > 0 then
  begin
    Result.Re := (a.Re * b.Re + a.Im * b.Im) / (sqr(b.Re) + sqr(b.Im));
    Result.Im := (a.Im * b.Re - a.Re * b.Im) / (sqr(b.Re) + sqr(b.Im));
  end
  else
  begin
    Result.Re := 0;
    Result.Im := 0;
  end;
end;

class operator TComplex.Divide(a: TComplex; b: double): TComplex;
begin
  if b <> 0 then
  begin
    Result.Re := a.Re / b;
    Result.Im := a.Im / b;
  end
  else
  begin
    Result.Re := 0;
    Result.Im := 0;
  end;
end;

class operator TComplex.Negative(a: TComplex): TComplex;
begin
  Result.Re := -a.Re;
  Result.Im := -a.Im;
end;

class operator TComplex.Equal(a, b: TComplex): boolean;
begin
  Result := (a.Re = b.Re) and (a.Im = b.Im);
end;

class operator TComplex.NotEqual(a, b: TComplex): boolean;
begin
  Result := not((a.Re = b.Re) and (a.Im = b.Im));
end;

function Complex(a, b: double): TComplex;
begin
  Result.Re := a;
  Result.Im := b;
end;

function CExp(a: TComplex): TComplex;
var
  X, y: double;
begin
  X := a.Re;
  y := a.Im;
  Result.Re := Exp(X) * cos(y);
  Result.Im := Exp(X) * sin(y);
end;

function Conjg;
begin
  Result.Re := a.Re;
  Result.Im := -a.Im;
end;

end.
