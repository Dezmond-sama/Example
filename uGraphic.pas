unit uGraphic;

interface

uses Generics.Collections, Generics.Defaults,
  {$ifdef android}
  FMX.Graphics, FMX.Objects, System.UITypes, FMX.Types,
  System.Math.Vectors, System.Types,FMX.DialogService,
  {$else}
  ExtCtrls, Graphics, ComObj, Windows, Vcl.ComCtrls, Vcl.forms,
  {$endif}
  SysUtils, Classes, uDataTypes,
  Math;

const
  ZERO_VALUE = 1E-8;
  {$ifdef android}
  UP_BORDER = 1;
  DOWN_BORDER = 1;
  LEFT_BORDER = 1;
  RIGHT_BORDER = 1;
  {$else}
  UP_BORDER = 25;
  DOWN_BORDER = 10;
  LEFT_BORDER = 10;
  RIGHT_BORDER = 30;
  {$endif}
  MIN_SIZE_BETWEEN_VERTICAL_MARKS = 20;
  MIN_SIZE_BETWEEN_HORISONTAL_MARKS = 50;

type
  TScaleType = (stStandard, stLogarifmic);

  TCoordSystem = (csDecart, csPolar);
  TPointType = (ptCircle, ptStar);

  TGraph = class
    constructor Create(_image: TImage);
    destructor Destroy;
  private
     {$ifdef android}
    MarkTextSizeWidth: single;
    MarkTextSizeHeight: single;
    {$else}
    MarkTextSizeWidth: integer;
    MarkTextSizeHeight: integer;
    {$endif}

    GraphList: TList;

    VerticalLinesList: TList;
    HorisontalLinesList: TList;
    VerticalFieldsList: TList;
    HorisontalFieldsList: TList;

    {$ifdef android}
    FAxisColor: TAlphaColor;
    FGridColor: TAlphaColor;
    FGraphicsColor: array [0 .. 15] of TAlphaColor;
    FVerticalLinesColor: array [0 .. 15] of TAlphaColor;
    FHorisontalLinesColor: array [0 .. 15] of TAlphaColor;
    FVerticalFieldsColor: array [0 .. 15] of TAlphaColor;
    FHorisontalFieldsColor: array [0 .. 15] of TAlphaColor;
    FTrustColor: TAlphaColor;
    FPointStyle: TBrushKind;
    {$else}
    FAxisColor: TColor;
    FGridColor: TColor;
    FGraphicsColor: array [0 .. 15] of TColor;
    FVerticalLinesColor: array [0 .. 15] of TColor;
    FHorisontalLinesColor: array [0 .. 15] of TColor;
    FVerticalFieldsColor: array [0 .. 15] of TColor;
    FHorisontalFieldsColor: array [0 .. 15] of TColor;
    FTrustColor: TColor;
    FPointStyle: TBrushStyle;
    {$endif}

    FLeftBorder: double;
    FRightBorder: double;
    FTopBorder: double;
    FBottomBorder: double;
    ScaleX, ScaleY: double;

    FShowPoints, FShowGraphs, FShowAxis, FShowGrid, FVerticalDiagram, FHorizontalDiagram: boolean;
    FVerticalShift: array of double;
    FPointType: array of TPointType;
    FPointSize: integer;
    FScaleTypeY: TScaleType;
    FScaleTypeX: TScaleType;
    FDiagramVerticalLineWidth: integer;
    FGraphLineWidth: integer;
    FDiagramHorizontalLineWidth: integer;
    FTrustDiagram: boolean;
    FTrustMethod: integer;
    FTrustPercentage: double;
    FTrustMinPercentage: double;
    FColoredPoints: boolean;
    FCoordSystem: TCoordSystem;
    FAxisXCaption: string;
    FAxisYCaption: string;
    FImage: TImage;
    FLogBase: double;
    FGraphType: integer;
    FBorderXStd: double;
    FBorderYStd: double;
    FBorderXLog10: double;
    FBorderYLog10: double;
    FFixedMarkTextSizeHeight: integer;
    FUseFixedMarkTextSizeHeight: boolean;
    FFixedMarkTextSizeWidth: integer;
    FUseFixedMarkTextSizeWidth: boolean;

    procedure SetShowPoints(const Value: boolean);
    procedure SetShowGraphs(const Value: boolean);
    procedure SetShowAxis(const Value: boolean);
    procedure SetShowGrid(const Value: boolean);

    function GetLeftBorder: double;
    procedure SetLeftBorder(const Value: double);

    function GetRightBorder: double;
    procedure SetRightBorder(const Value: double);

    function GetTopBorder: double;
    procedure SetTopBorder(const Value: double);
    function GetBottomBorder: double;
    procedure SetBottomBorder(const Value: double);

    {$ifdef android}
    procedure AddLine(x1, y1, x2, y2: double; c: TAlphaColor; w: integer;
      penStyle: TStrokeDash = TStrokeDash.sdSolid);
    procedure AddPoint(x, y: double; c,cFill: TAlphaColor;pointType:TPointType);
    procedure AddCircle(x, y: double; radius: integer; c,cFill: TAlphaColor; w: integer;
      penStyle: TStrokeDash = TStrokeDash.sdSolid; brushStyle: TBrushKind = TBrushKind.None);
    procedure AddStar(x, y: double; radius:integer; c: TAlphaColor; w: integer;
      penStyle: TStrokeDash = TStrokeDash.sdSolid);
    procedure AddText(x, y: double; Value: string; c: TAlphaColor; alignHorisontal: TAlignment; alignVertical: TVerticalAlignment);
    procedure AddTextAbs(x, y: integer; Value: string; c: TAlphaColor; alignHorisontal: TAlignment; alignVertical: TVerticalAlignment);
    procedure AddQuadrangle(x1, y1, x2, y2, x3, y3, x4, y4: double; c: TAlphaColor);
    procedure AddVerticalMark(markSize: integer; Value: double;
      lineStyle: TStrokeDash = TStrokeDash.sdSolid);
    procedure AddHorisontalMark(markSize: integer; Value: double;
      lineStyle: TStrokeDash = TStrokeDash.sdSolid);

    function GetGraphColor(Index: integer): TAlphaColor;
    procedure SetGraphColor(Index: integer; const Value: TAlphaColor);
    procedure SetAxisColor(const Value: TAlphaColor);
    procedure SetGridColor(const Value: TAlphaColor);

    procedure SetPointStyle(const Value: TBrushKind);
    procedure SetTrustColor(const Value: TAlphaColor);

    function GetHorisontalLineColor(Index: integer): TAlphaColor;
    function GetVerticalLineColor(Index: integer): TAlphaColor;
    procedure SetHorisontalLineColor(Index: integer; const Value: TAlphaColor);
    procedure SetVerticalLineColor(Index: integer; const Value: TAlphaColor);
    function GetHorisontalFieldColor(Index: integer): TAlphaColor;
    function GetVerticalFieldColor(Index: integer): TAlphaColor;
    procedure SetHorisontalFieldColor(Index: integer; const Value: TAlphaColor);
    procedure SetVerticalFieldColor(Index: integer; const Value: TAlphaColor);
    {$else}
    procedure AddLine(x1, y1, x2, y2: double; c: TColor; w: integer;
      penStyle: TPenStyle = psSolid);
    procedure AddPoint(x, y: double; c,cFill: TColor;pointType:TPointType);
    procedure AddCircle(x, y: double; radius: integer; c,cFill: TColor; w: integer;
      penStyle: TPenStyle = psSolid; brushStyle: TBrushStyle = bsClear);
    procedure AddStar(x, y: double; radius:integer; c: TColor; w: integer;
      penStyle: TPenStyle = psSolid);
    procedure AddText(x, y: double; Value: string; c: TColor; alignHorisontal: TAlignment; alignVertical: TVerticalAlignment);
    procedure AddTextAbs(x, y: integer; Value: string; c: TColor; alignHorisontal: TAlignment; alignVertical: TVerticalAlignment);
    procedure AddQuadrangle(x1, y1, x2, y2, x3, y3, x4, y4: double; c: TColor);
    procedure AddVerticalMark(markSize: integer; Value: double;
      lineStyle: TPenStyle = psSolid);
    procedure AddHorisontalMark(markSize: integer; Value: double;
      lineStyle: TPenStyle = psSolid);

    function GetGraphColor(Index: integer): TColor;
    procedure SetGraphColor(Index: integer; const Value: TColor);
    procedure SetAxisColor(const Value: TColor);
    procedure SetGridColor(const Value: TColor);

    procedure SetPointStyle(const Value: TBrushStyle);
    procedure SetTrustColor(const Value: TColor);

    function GetHorisontalLineColor(Index: integer): TColor;
    function GetVerticalLineColor(Index: integer): TColor;
    procedure SetHorisontalLineColor(Index: integer; const Value: TColor);
    procedure SetVerticalLineColor(Index: integer; const Value: TColor);
    function GetHorisontalFieldColor(Index: integer): TColor;
    function GetVerticalFieldColor(Index: integer): TColor;
    procedure SetHorisontalFieldColor(Index: integer; const Value: TColor);
    procedure SetVerticalFieldColor(Index: integer; const Value: TColor);
    {$endif}

    function RoundStepValue(Value: double): double;
    function RoundValue(Value: double;step:double): double;
    procedure CalculateMarkTextSize;

    procedure CalculateScale;
    procedure SetVerticalShift(Index: integer; const Value: double);
    procedure SetPointSize(const Value: integer);
    function GetVerticalShift(Index: integer): double;
    function GetPointType(Index: integer): TPointType;
    procedure SetPointType(Index: integer; const Value: TPointType);
    procedure SetScaleTypeY(const Value: TScaleType);
    procedure SetScaleTypeX(const Value: TScaleType);
    function ConvertLogarifm(Value: double; axis:integer): double;
    function RevertLogarifm(Value: double; axis:integer): double;
    procedure DrawAxisLogX;
    procedure DrawAxisLogY;
    procedure DrawAxisLogX10;
    procedure DrawAxisLogY10;
    procedure DrawAxisStdX;
    procedure DrawAxisStdY;
    procedure SetHorizontalDiagram(const Value: boolean);
    procedure SetVerticalDiagram(const Value: boolean);
    procedure SetDiagramHorizontalLineWidth(const Value: integer);
    procedure SetDiagramVerticalLineWidth(const Value: integer);
    procedure SetGraphLineWidth(const Value: integer);
    procedure SetTrustDiagram(const Value: boolean);
    procedure DrawTrust(data: TList; Index: integer);
    function CalculateX(x: double; scale: double): integer;
    function CalculateY(y: double; scale: double): integer;
    procedure SetTrustMethod(const Value: integer);
    procedure SetTrustPercentage(const Value: double);
    procedure SetTrustMinPercentage(const Value: double);
    procedure DrawAxis;
    procedure DrawGraph(data: TList; Index: integer);
    procedure DrawPoints(data: TList; Index: integer);
    procedure DrawVerticalDiagram(data: TList; Index: integer);
    procedure DrawHorizontalDiagram(data: TList; Index: integer);
    procedure DrawHorisontalLines(data: TList<double>; Index: integer);
    procedure DrawVerticalLines(data: TList<double>; Index: integer);
    procedure DrawHorisontalFields(data: TList; Index: integer);
    procedure DrawVerticalFields(data: TList; Index: integer);
    procedure SetColoredPoints(const Value: boolean);
    procedure SetCoordSystem(const Value: TCoordSystem);
    procedure CalculatePolar(x, y: double; var res_x, res_y: integer);
    function DoubleToStr(value:double; range: double):string;
    procedure SetAxisXCaption(const Value: string);
    procedure SetAxisYCaption(const Value: string);
    procedure SetImage(const Value: TImage);
    procedure SetLogBase(const Value: double);
    procedure SetGraphType(const Value: integer);
    procedure SetBorderXStd(const Value: double);
    procedure SetBorderYStd(const Value: double);
    procedure SetFixedMarkTextSizeHeight(const Value: integer);
    procedure SetFixedMarkTextSizeWidth(const Value: integer);
    procedure SetUseFixedMarkTextSizeHeight(const Value: boolean);
    procedure SetUseFixedMarkTextSizeWidth(const Value: boolean);
    procedure SetBorderXSLog10(const Value: double);
    procedure SetBorderYLog10(const Value: double);
  public
    function GetMarkWidth: {$ifdef android}single{$else} integer{$endif};
    function GetMarkHeight: {$ifdef android}single{$else} integer{$endif};
    property GraphType:integer read FGraphType write SetGraphType;
    property Image: TImage read FImage write SetImage;
    property LogBase:double read FLogBase write SetLogBase;
    property LeftBorder: double read GetLeftBorder write SetLeftBorder;
    property RightBorder: double read GetRightBorder write SetRightBorder;
    property TopBorder: double read GetTopBorder write SetTopBorder;
    property BottomBorder: double read GetBottomBorder write SetBottomBorder;

    property ShowPoints: boolean read FShowPoints write SetShowPoints;
    property ShowGraphs: boolean read FShowGraphs write SetShowGraphs;
    property ShowAxis: boolean read FShowAxis write SetShowAxis;
    property ShowGrid: boolean read FShowGrid write SetShowGrid;
    property isVerticalDiagram: boolean read FVerticalDiagram write SetVerticalDiagram;
    property isHorizontalDiagram: boolean read FHorizontalDiagram write SetHorizontalDiagram;
    property isTrustDiagram: boolean read FTrustDiagram write SetTrustDiagram;

    property AxisXCaption: string read FAxisXCaption write SetAxisXCaption;
    property AxisYCaption: string read FAxisYCaption write SetAxisYCaption;

    property FixedMarkTextSizeWidth: integer read FFixedMarkTextSizeWidth write SetFixedMarkTextSizeWidth;
    property FixedMarkTextSizeHeight: integer read FFixedMarkTextSizeHeight write SetFixedMarkTextSizeHeight;
    property UseFixedMarkTextSizeWidth: boolean read FUseFixedMarkTextSizeWidth write SetUseFixedMarkTextSizeWidth;
    property UseFixedMarkTextSizeHeight: boolean read FUseFixedMarkTextSizeHeight write SetUseFixedMarkTextSizeHeight;


    {$ifdef android}
    property GraphicsColor[Index: integer]: TAlphaColor read GetGraphColor
      write SetGraphColor;
    property VerticalLinesColor[Index: integer]: TAlphaColor read GetVerticalLineColor
      write SetVerticalLineColor;
    property HorisontalLinesColor[Index: integer]: TAlphaColor read GetHorisontalLineColor
      write SetHorisontalLineColor;
    property HorisontalFieldsColor[Index: integer]: TAlphaColor read GetHorisontalFieldColor
      write SetHorisontalFieldColor;
    property VerticalFieldsColor[Index: integer]: TAlphaColor read GetVerticalFieldColor
      write SetVerticalFieldColor;
    property AxisColor: TAlphaColor read FAxisColor write SetAxisColor;
    property GridColor: TAlphaColor read FGridColor write SetGridColor;
    property TrustColor: TAlphaColor read FTrustColor write SetTrustColor;

    property PointStyle: TBrushKind read FPointStyle write SetPointStyle;
    {$else}
    property GraphicsColor[Index: integer]: TColor read GetGraphColor
      write SetGraphColor;
    property VerticalLinesColor[Index: integer]: TColor read GetVerticalLineColor
      write SetVerticalLineColor;
    property HorisontalLinesColor[Index: integer]: TColor read GetHorisontalLineColor
      write SetHorisontalLineColor;
    property HorisontalFieldsColor[Index: integer]: TColor read GetHorisontalFieldColor
      write SetHorisontalFieldColor;
    property VerticalFieldsColor[Index: integer]: TColor read GetVerticalFieldColor
      write SetVerticalFieldColor;
    property AxisColor: TColor read FAxisColor write SetAxisColor;
    property GridColor: TColor read FGridColor write SetGridColor;
    property TrustColor: TColor read FTrustColor write SetTrustColor;

    property PointStyle: TBrushStyle read FPointStyle write SetPointStyle;
    {$endif}

    property VerticalShift[Index: integer]: double read GetVerticalShift
      write SetVerticalShift;

    property PointType[Index: integer]: TPointType read GetPointType
      write SetPointType;

    property ScaleTypeX: TScaleType read FScaleTypeX write SetScaleTypeX;
    property ScaleTypeY: TScaleType read FScaleTypeY write SetScaleTypeY;
    property CoordSystem: TCoordSystem read FCoordSystem write SetCoordSystem;

    property PointSize: integer read FPointSize write SetPointSize;

    property GraphLineWidth: integer read FGraphLineWidth write SetGraphLineWidth;
    property DiagramHorizontalLineWidth: integer read FDiagramHorizontalLineWidth write SetDiagramHorizontalLineWidth;
    property DiagramVerticalLineWidth: integer read FDiagramVerticalLineWidth write SetDiagramVerticalLineWidth;

    property TrustMethod: integer read FTrustMethod write SetTrustMethod;
    property TrustPercentage: double read FTrustPercentage write SetTrustPercentage;
    property TrustMinPercentage: double read FTrustMinPercentage write SetTrustMinPercentage;

    property ColoredPoints: boolean read FColoredPoints write SetColoredPoints;

    property BorderXStd: double read FBorderXStd write SetBorderXStd;
    property BorderYStd: double read FBorderYStd write SetBorderYStd;

    property BorderXLog: double read FBorderXLog10 write SetBorderXSLog10;
    property BorderYLog: double read FBorderYLog10 write SetBorderYLog10;

    procedure AddGraph(data: TList);
    procedure RemoveGraph(i: integer);
    procedure ClearGraphList;

    procedure AddVerticalLine(data: TList<double>);
    procedure RemoveVerticalLine(i: integer);
    procedure ClearVerticalLinesList;

    procedure AddHorisontalLine(data: TList<double>);
    procedure RemoveHorisontalLine(i: integer);
    procedure ClearHorisontalLinesList;

    procedure AddVerticalField(data: TList);
    procedure RemoveVerticalField(i: integer);
    procedure ClearVerticalFieldsList;

    procedure AddHorisontalField(data: TList);
    procedure RemoveHorisontalField(i: integer);
    procedure ClearHorisontalFieldsList;

    function ConvertComplexArrayToPointArray(data: TComplexArray;
      deltaT: double; startTime: double = 0;
      maxPointCount: integer = 1000): TList;
    function ConvertDoubleArrayToPointArray(data: array of double;
      deltaT: double; startTime: double = 0;
      maxPointCount: integer = 1000): TList;
    procedure ClearData();
    procedure Clear();
    procedure Repaint();

    function CalculateGraphXByMouseX(X:integer):double;
    function CalculateGraphYByMouseY(Y:integer):double;


    function GetBottomBorderAbs: double;
    function GetLeftBorderAbs: double;
    function GetRightBorderAbs: double;
    function GetTopBorderAbs: double;
  end;

implementation

{ TGraphic }

procedure TGraph.Clear;
{$ifndef android}
var
  rect1: TRect;
{$endif}
begin
  if Image = nil then exit;

  {$ifdef android}
  if Image.Bitmap = nil then Image.Bitmap := TBitmap.Create;

  Image.Bitmap.SetSize(Trunc(Image.Width * Image.Canvas.Scale),
                      Trunc(Image.Height * Image.Canvas.Scale));
  //Image.Bitmap.SetSize(Round(Image.Width), Round(Image.Height));
  //Image.Canvas.scale := 1;
  Image.Bitmap.Clear(TAlphaColorRec.White);
//  TDialogService.MessageDialog(FloatToStr(Image.Width)+ ' '+FloatToStr(Image.Height),
//                               TMsgDlgType.mtWarning,
//                               [TMsgDlgBtn.mbOk], TMsgDlgBtn.mbOk, 0, nil);
  {$else}
  Image.Picture.Bitmap.Height := Image.Height;
  Image.Picture.Bitmap.Width := Image.Width;

  Image.Canvas.Brush.color := clWhite;
  rect1 := Image.ClientRect;
  rect1.Left := rect1.Left - 2;
  rect1.Top := rect1.Top - 2;
  rect1.Right := rect1.Right + 2;
  rect1.Bottom := rect1.Bottom + 2;
  Image.Canvas.FillRect(rect1);
  {$endif}
end;

procedure TGraph.ClearData;
begin
  ClearGraphList;
  ClearVerticalLinesList;
  ClearHorisontalLinesList;
  ClearVerticalFieldsList;
  ClearHorisontalFieldsList;
end;

function TGraph.CalculateGraphXByMouseX(X: integer): double;
begin
  if FScaleTypeX <>stStandard then Result := 0
  else begin
    Result := (X - LEFT_BORDER - GetMarkWidth) / ScaleX + LeftBorder;
  end;
end;

function TGraph.CalculateGraphYByMouseY(Y: integer): double;
begin
  if FScaleTypeY <>stStandard then Result := 0
  else begin
    Result := TopBorder -(Y - UP_BORDER) / ScaleY + LeftBorder;
  end;
end;

procedure TGraph.CalculateMarkTextSize;
var
  {$ifdef android}
  Value: single;
  {$else}
  Value: integer;
  {$endif}
begin
  MarkTextSizeHeight := 0;
  MarkTextSizeWidth := 0;
  if Image = nil then exit;

  if ShowAxis then begin
    MarkTextSizeHeight := Image.Canvas.TextHeight
      (DoubleToStr(LeftBorder,RightBorder - LeftBorder));
    Value := Image.Canvas.TextHeight(DoubleToStr(RightBorder,RightBorder - LeftBorder));
    if Value > MarkTextSizeHeight then
      MarkTextSizeHeight := Value;
  end;

  if ShowAxis then begin
    if ScaleTypeY = stStandard then
      MarkTextSizeWidth := Image.Canvas.TextWidth
        (DoubleToStr(RoundValue(TopBorder, (TopBorder - BottomBorder)/20), TopBorder - BottomBorder) + '.00')
    else
      MarkTextSizeWidth := Image.Canvas.TextWidth('100000');

    Value := Image.Canvas.TextWidth(DoubleToStr(RoundValue(BottomBorder, (TopBorder - BottomBorder)/20), TopBorder - BottomBorder) + '.00');
    if Value > MarkTextSizeWidth then
      MarkTextSizeWidth := Value;
  end;

end;

procedure TGraph.CalculateScale;
begin
  ScaleX := 1;
  ScaleY := 1;
  if Image = nil then exit;

  if ScaleTypeX = stStandard then begin
    if abs(RightBorder - LeftBorder)>ZERO_VALUE then
      ScaleX := (Image.Width -
         LEFT_BORDER - RIGHT_BORDER - GetMarkWidth) /
        (RightBorder - LeftBorder);
  end else if ScaleTypeX = stLogarifmic then begin
    if abs(RightBorder - LeftBorder)>ZERO_VALUE then
      ScaleX := (Image.Width  -
         LEFT_BORDER - RIGHT_BORDER - GetMarkWidth) /
        (ConvertLogarifm(RightBorder,0) - ConvertLogarifm(LeftBorder,0));
  end;

  if ScaleTypeY = stStandard then begin
    if abs(TopBorder - BottomBorder)>ZERO_VALUE then
      ScaleY := (Image.Height  -
         UP_BORDER - DOWN_BORDER - GetMarkHeight) /
        (TopBorder - BottomBorder);
  end else if ScaleTypeY = stLogarifmic then begin
    if abs(TopBorder - BottomBorder)>ZERO_VALUE then
      ScaleY := (Image.Height  -
         UP_BORDER - DOWN_BORDER - GetMarkHeight) /
        (ConvertLogarifm(TopBorder,1) - ConvertLogarifm(BottomBorder,1));
  end;
  //if ScaleX < ZERO_VALUE then ScaleX := 1;
  //if ScaleY < ZERO_VALUE then ScaleY := 1;
end;

procedure TGraph.ClearGraphList;
var
  i: integer;
begin
  for i := 0 to GraphList.Count - 1 do
    TList(GraphList.Items[i]).Clear;
  GraphList.Clear;
end;

procedure TGraph.ClearHorisontalFieldsList;
var
  i: integer;
begin
  for i := 0 to HorisontalFieldsList.Count - 1 do
    TList(HorisontalFieldsList.Items[i]).Clear;
  HorisontalFieldsList.Clear;
end;

procedure TGraph.ClearHorisontalLinesList;
var
  i: integer;
begin
  for i := 0 to HorisontalLinesList.Count - 1 do
    TList<double>(HorisontalLinesList.Items[i]).Clear;
  HorisontalLinesList.Clear;
end;

procedure TGraph.ClearVerticalFieldsList;
var
  i: integer;
begin
  for i := 0 to VerticalFieldsList.Count - 1 do
    TList(VerticalFieldsList.Items[i]).Clear;
  VerticalFieldsList.Clear;
end;

procedure TGraph.ClearVerticalLinesList;
var
  i: integer;
begin
  for i := 0 to VerticalLinesList.Count - 1 do
    TList<double>(VerticalLinesList.Items[i]).Clear;
  VerticalLinesList.Clear;
end;

constructor TGraph.Create(_image: TImage); // ; StartTime, EndTime:double);
begin
  Image := _image;

  FixedMarkTextSizeWidth := 0;
  FixedMarkTextSizeHeight := 0;
  UseFixedMarkTextSizeWidth := false;
  UseFixedMarkTextSizeHeight := false;

  LogBase := 10;
  BorderXStd := 5;
  BorderYStd := 5;
  BorderXLog := 1;
  BorderYLog := 1;
  GraphList := TList.Create;
  HorisontalLinesList := TList.Create;
  VerticalLinesList := TList.Create;
  HorisontalFieldsList := TList.Create;
  VerticalFieldsList := TList.Create;

  ScaleX := 1;
  ScaleY := 1;

  CoordSystem := csDecart;

  FScaleTypeY := stStandard;

  FShowPoints := True;
  FShowGraphs := True;
  FShowAxis := True;
  FShowGrid := False;
  FVerticalDiagram := False;
  FHorizontalDiagram := False;

  {$ifdef android}
  FPointStyle := TBrushKind.None;

  AxisColor := TAlphaColorRec.Black;
  GridColor := TAlphaColorRec.Green;

  GraphicsColor[0] := TAlphaColorRec.Red;
  GraphicsColor[1] := TAlphaColorRec.Blue;
  GraphicsColor[2] := TAlphaColorRec.Green;
  GraphicsColor[3] := TAlphaColorRec.Fuchsia;

  VerticalLinesColor[0] := TAlphaColorRec.Red;
  VerticalLinesColor[1] := TAlphaColorRec.Blue;
  VerticalLinesColor[2] := TAlphaColorRec.Green;
  VerticalLinesColor[3] := TAlphaColorRec.Fuchsia;

  HorisontalLinesColor[0] := TAlphaColorRec.Red;
  HorisontalLinesColor[1] := TAlphaColorRec.Blue;
  HorisontalLinesColor[2] := TAlphaColorRec.Green;
  HorisontalLinesColor[3] := TAlphaColorRec.Fuchsia;

  VerticalFieldsColor[0] := TAlphaColorRec.Red;
  VerticalFieldsColor[1] := TAlphaColorRec.Blue;
  VerticalFieldsColor[2] := TAlphaColorRec.Green;
  VerticalFieldsColor[3] := TAlphaColorRec.Fuchsia;

  HorisontalFieldsColor[0] := TAlphaColorRec.Red;
  HorisontalFieldsColor[1] := TAlphaColorRec.Blue;
  HorisontalFieldsColor[2] := TAlphaColorRec.Green;
  HorisontalFieldsColor[3] := TAlphaColorRec.Fuchsia;

  TrustColor := TAlphaColorRec.Yellow;
  {$else}
  FPointStyle := bsClear;
  AxisColor := clBlack;
  GridColor := clGreen;

  GraphicsColor[0] := clRed;
  GraphicsColor[1] := clBlue;
  GraphicsColor[2] := clGreen;
  GraphicsColor[3] := clFuchsia;

  VerticalLinesColor[0] := clRed;
  VerticalLinesColor[1] := clBlue;
  VerticalLinesColor[2] := clGreen;
  VerticalLinesColor[3] := clFuchsia;

  HorisontalLinesColor[0] := clRed;
  HorisontalLinesColor[1] := clBlue;
  HorisontalLinesColor[2] := clGreen;
  HorisontalLinesColor[3] := clFuchsia;

  VerticalFieldsColor[0] := clRed;
  VerticalFieldsColor[1] := clBlue;
  VerticalFieldsColor[2] := clGreen;
  VerticalFieldsColor[3] := clFuchsia;

  HorisontalFieldsColor[0] := clRed;
  HorisontalFieldsColor[1] := clBlue;
  HorisontalFieldsColor[2] := clGreen;
  HorisontalFieldsColor[3] := clFuchsia;

  TrustColor := clYellow;
  {$endif}
  FPointSize := 3;

  FDiagramVerticalLineWidth := 1;
  FGraphLineWidth := 1;
  FDiagramHorizontalLineWidth := 1;

  FTrustMinPercentage := 5;
  FTrustPercentage := 10;
  // LowerBorder := StartTime;
  // UpperBorder := EndTime;
end;

destructor TGraph.Destroy;
begin
  ClearData;
  GraphList.Free;
  VerticalLinesList.Free;
  HorisontalLinesList.Free;
  VerticalFieldsList.Free;
  HorisontalFieldsList.Free;
end;

function TGraph.DoubleToStr(value, range: double): string;
var
  d:double;
  c:integer;
begin
  //Result := FloatToStr(value);
  //exit;
  if range <= 0 then
    Result := ''
  else
  begin
    d := 1;
    c:=0;
    while d < 100 / range do begin
      d := d * 10;
      c := c + 1;
    end;
    while d / 10 > 100 / range do begin
      d := d / 10;
      c := c - 1;
    end;
    if c <= 0 then Result := IntToStr(Round(value))
    else Result := FloatToStrF(value, ffGeneral, High(IntToStr(Round(value)))+c, c);
  end;
end;

function TGraph.GetGraphColor;
begin
  if Index < 0 then
    {$ifdef android}
    Result := TAlphaColorRec.Black
    {$else}
    Result := clBlack
    {$endif}
  else
    Result := FGraphicsColor[Index mod (High(FGraphicsColor) + 1)];
end;

function TGraph.GetHorisontalFieldColor;
begin
  if Index < 0 then
    {$ifdef android}
    Result := TAlphaColorRec.Black
    {$else}
    Result := clBlack
    {$endif}
  else
    Result := FHorisontalFieldsColor[Index mod (High(FHorisontalFieldsColor) + 1)];
end;

function TGraph.GetHorisontalLineColor;
begin
  if Index < 0 then
    {$ifdef android}
    Result := TAlphaColorRec.Black
    {$else}
    Result := clBlack
    {$endif}
  else
    Result := FHorisontalLinesColor[Index mod (High(FHorisontalLinesColor) + 1)];
end;

function TGraph.GetLeftBorder: double;
var
  step:double;
begin
  Result := FLeftBorder;
  if ScaleTypeX = stStandard then Result := Result - (FRightBorder - FLeftBorder)/100*FBorderXStd;
  if ScaleTypeX = stLogarifmic then begin
    step := 1;
    if Result > 0 then begin
      while step / 100 > Result do step := step / 10;
      if step / 5 > Result then step := step / 2;
      Result := Result - step * BorderXLog;
    end else begin
      while step * 100 < FRightBorder do step := step * 10;
      step := step / 10000;
      Result := Result - step * BorderXLog;
    end;

  end;
end;

function TGraph.GetLeftBorderAbs: double;
begin
  Result := FLeftBorder;
end;


function TGraph.GetMarkHeight;
begin
  if UseFixedMarkTextSizeHeight then begin
    Result := FixedMarkTextSizeHeight;
    exit;
  end;
  if ShowAxis then
    Result := MarkTextSizeHeight
  else
    Result := 0;
end;

function TGraph.GetMarkWidth;
begin
  if UseFixedMarkTextSizeWidth then begin
    Result := FixedMarkTextSizeWidth;
    exit;
  end;
  if ShowAxis then
    Result := MarkTextSizeWidth
  else
    Result := 0;
end;

function TGraph.GetTopBorder: double;
var
  step:double;
begin
  Result := FTopBorder;
  if ScaleTypeY = stStandard then Result := Result + (FTopBorder - FBottomBorder)/100*BorderYStd;
  if ScaleTypeY = stLogarifmic then begin
    step := 1;
    while step * 100 < Result do step := step * 10;
    if step * 5 < Result then step := step * 2;
    Result := Result + step * BorderYLog
  end;
end;
function TGraph.GetTopBorderAbs: double;
begin
  Result := FTopBorder;
end;

function TGraph.GetVerticalFieldColor;
begin
  if Index < 0 then
    {$ifdef android}
    Result := TAlphaColorRec.Black
    {$else}
    Result := clBlack
    {$endif}
  else
    Result := FVerticalFieldsColor[Index mod (High(FVerticalFieldsColor) + 1)];
end;

function TGraph.GetVerticalLineColor;
begin
  if Index < 0 then
    {$ifdef android}
    Result := TAlphaColorRec.Black
    {$else}
    Result := clBlack
    {$endif}
  else
    Result := FVerticalLinesColor[Index mod (High(FVerticalLinesColor) + 1)];
end;

function TGraph.GetVerticalShift(Index: integer): double;
begin
  if (Index >= 0) and (Index <= High(FVerticalShift)) then
    Result := FVerticalShift[Index]
  else
    Result := 0;
end;

function TGraph.GetPointType(Index: integer): TPointType;
begin
  if (Index >= 0) and (Index <= High(FPointType)) then
    Result := FPointType[Index]
  else
    Result := ptCircle;
end;

function TGraph.ConvertLogarifm(Value: double; axis:integer): double;
var
  v:double;

begin
  if axis = 0 then begin //X
    if RightBorder = LeftBorder then v := 1
    else v := 1 + (value - LeftBorder) / (RightBorder - LeftBorder)*Power(LogBase,3);
    if v < 1 then v := 1;
    Result := LogN(LogBase, v);
  end else if axis = 1 then begin //y
    if TopBorder = BottomBorder then v := 1
    else v := 1 + (value - BottomBorder) / (TopBorder - BottomBorder)*Power(LogBase,3);
    if v < 1 then v := 1;
    Result := LogN(LogBase, v);
  end;
end;

function TGraph.RevertLogarifm(Value: double; axis:integer): double;
var
  v:double;

begin
  if axis = 0 then begin //X
    if RightBorder = LeftBorder then begin
      Result := LeftBorder;
      exit;
    end
    else begin
      v := Power(LogBase,Value);
      Result := (v - 1) / Power(LogBase,3) * (RightBorder - LeftBorder) + LeftBorder;
    end;
  end else if axis = 1 then begin //y
    if TopBorder = BottomBorder then begin
      Result := BottomBorder;
      exit;
    end
    else begin
      v := Power(LogBase,Value);
      Result := (v - 1) / Power(LogBase,3) * (TopBorder - BottomBorder) + BottomBorder;
    end;
  end;
end;

function TGraph.GetBottomBorder: double;
var
  step: double;
begin
  Result := FBottomBorder;
  if ScaleTypeY = stStandard then Result := Result - (FTopBorder - FBottomBorder)/100*BorderYStd;
  if ScaleTypeY = stLogarifmic then begin
    step := 1;
    if Result > 0 then begin
      while step / 100 > Result do step := step / 10;
      if step / 5 > Result then step := step / 2;
      Result := Result - step * BorderYLog;
    end else begin
      while step * 100 < FTopBorder do step := step * 10;
      step := step / 10000;
      Result := Result - step * BorderYLog;
    end;

  end;
end;
function TGraph.GetBottomBorderAbs: double;
begin
  Result := FBottomBorder;
end;

function TGraph.GetRightBorder: double;
var
  step: double;
begin
  Result := FRightBorder;
  if ScaleTypeX = stStandard then Result := Result + (FRightBorder - FLeftBorder)/100*BorderXStd;
  if ScaleTypeX = stLogarifmic then begin
    step := 1;
    while step * 100 < Result do step := step * 10;
    if step * 5 < Result then step := step * 2;
    Result := Result + step * BorderXLog
  end;
end;
function TGraph.GetRightBorderAbs: double;
begin
  Result := FRightBorder;
end;

procedure TGraph.Repaint;
var
  i: integer;
begin
  if Image = nil then exit;
  Clear;
  CalculateMarkTextSize;
  CalculateScale;

  DrawAxis();

  if isVerticalDiagram then
    for i := 0 to GraphList.Count - 1 do
    begin
      DrawVerticalDiagram(GraphList.Items[i], i);
    end;

  if isHorizontalDiagram then
    for i := 0 to GraphList.Count - 1 do
    begin
      DrawHorizontalDiagram(GraphList.Items[i], i);
    end;

  if isTrustDiagram then
    if GraphList.Count > 0 then DrawTrust(GraphList.Items[0], 0);

  for i := 0 to VerticalFieldsList.Count - 1 do
  begin
    DrawVerticalFields(VerticalFieldsList.Items[i], i);
  end;

  for i := 0 to HorisontalFieldsList.Count - 1 do
  begin
    DrawHorisontalFields(HorisontalFieldsList.Items[i], i);
  end;

  for i := 0 to VerticalLinesList.Count - 1 do
  begin
    DrawVerticalLines(VerticalLinesList.Items[i], i);
  end;

  for i := 0 to HorisontalLinesList.Count - 1 do
  begin
    DrawHorisontalLines(HorisontalLinesList.Items[i], i);
  end;

  if ShowGraphs then
    for i := 0 to GraphList.Count - 1 do
    begin
      DrawGraph(GraphList.Items[i], i);
    end;

  if ShowPoints then
    for i := 0 to GraphList.Count - 1 do
    begin
      DrawPoints(GraphList.Items[i], i);
    end;

  if CoordSystem = csDecart then begin
    AddLine(LeftBorder, TopBorder, RightBorder, TopBorder, AxisColor, 1);
    AddLine(RightBorder, TopBorder, RightBorder, BottomBorder, AxisColor, 1);
    AddLine(RightBorder, BottomBorder, LeftBorder, BottomBorder, AxisColor, 1);
    AddLine(LeftBorder, BottomBorder, LeftBorder, TopBorder, AxisColor, 1);
  end else if CoordSystem = csPolar then begin
    AddCircle(0,BottomBorder,round((TopBorder + BottomBorder) * ScaleY / 2),AxisColor,AxisColor, 1);
  end;


end;

procedure TGraph.SetAxisColor;
begin
  FAxisColor := Value;
end;

procedure TGraph.SetAxisXCaption(const Value: string);
begin
  FAxisXCaption := Value;
end;

procedure TGraph.SetAxisYCaption(const Value: string);
begin
  FAxisYCaption := Value;
end;

procedure TGraph.SetGraphColor;
begin
  if (Index <= High(FGraphicsColor)) and (Index >= 0) then
    FGraphicsColor[Index] := Value;
end;

procedure TGraph.SetGraphLineWidth(const Value: integer);
begin
  if Value < 1 then exit;
  FGraphLineWidth := Value;
end;

procedure TGraph.SetGraphType(const Value: integer);
begin
  FGraphType := Value;
end;

procedure TGraph.SetGridColor;
begin
  FGridColor := Value;
end;

procedure TGraph.SetHorisontalFieldColor;
begin
  if (Index <= High(FHorisontalFieldsColor)) and (Index >= 0) then
    FHorisontalFieldsColor[Index] := Value;
end;

procedure TGraph.SetHorisontalLineColor;
begin
  if (Index <= High(FHorisontalLinesColor)) and (Index >= 0) then
    FHorisontalLinesColor[Index] := Value;
end;

procedure TGraph.SetHorizontalDiagram(const Value: boolean);
begin
  FHorizontalDiagram := Value;
end;

procedure TGraph.SetImage(const Value: TImage);
begin
  FImage := Value;
  CalculateMarkTextSize;
end;

procedure TGraph.SetLeftBorder(const Value: double);
begin
  CalculateMarkTextSize;
  FLeftBorder := Value;
  CalculateScale;
end;

procedure TGraph.SetLogBase(const Value: double);
begin
  if Value > 1 then FLogBase := Value
  else FLogBase := 2;
end;

procedure TGraph.SetPointSize(const Value: integer);
begin
  FPointSize := abs(Value);
end;

procedure TGraph.SetPointStyle;
begin
  FPointStyle := Value;
end;

procedure TGraph.SetTrustMethod(const Value: integer);
begin
  FTrustMethod := Value mod 3;
  if FTrustMethod = 0 then TrustMethod := 1;
end;

procedure TGraph.SetTrustMinPercentage(const Value: double);
begin
  FTrustMinPercentage := abs(Value);
end;

procedure TGraph.SetTrustPercentage(const Value: double);
begin
  FTrustPercentage := abs(Value);
end;

procedure TGraph.SetUseFixedMarkTextSizeHeight(const Value: boolean);
begin
  FUseFixedMarkTextSizeHeight := Value;
  CalculateScale;
end;

procedure TGraph.SetUseFixedMarkTextSizeWidth(const Value: boolean);
begin
  FUseFixedMarkTextSizeWidth := Value;
  CalculateScale;
end;

procedure TGraph.SetTopBorder(const Value: double);
begin
  CalculateMarkTextSize;
  FTopBorder := Value;
  CalculateScale;
end;

procedure TGraph.SetTrustDiagram(const Value: boolean);
begin
  FTrustDiagram := Value;
end;

procedure TGraph.SetTrustColor;
begin
  FTrustColor := Value;
end;

procedure TGraph.SetScaleTypeX(const Value: TScaleType);
begin
  FScaleTypeX := Value;
  CalculateMarkTextSize;
end;

procedure TGraph.SetScaleTypeY(const Value: TScaleType);
begin
  FScaleTypeY := Value;
  CalculateMarkTextSize;
end;

procedure TGraph.SetBorderXSLog10(const Value: double);
begin
  if Value > 0 then FBorderXLog10 := Value else FBorderXLog10 := 0;
end;

procedure TGraph.SetBorderXStd(const Value: double);
begin
  if Value > 0 then FBorderXStd := Value else FBorderXStd := 0;
end;

procedure TGraph.SetBorderYLog10(const Value: double);
begin
  if Value > 0 then FBorderYLog10 := Value else FBorderYLog10 := 0;
end;

procedure TGraph.SetBorderYStd(const Value: double);
begin
  if Value > 0 then FBorderYStd := Value else FBorderYStd := 0;
end;

procedure TGraph.SetBottomBorder(const Value: double);
begin
  CalculateMarkTextSize;
  FBottomBorder := Value;
  CalculateScale;
end;

procedure TGraph.SetColoredPoints(const Value: boolean);
begin
  FColoredPoints := Value;
end;

procedure TGraph.SetCoordSystem(const Value: TCoordSystem);
begin
  FCoordSystem := Value;
end;

procedure TGraph.SetDiagramHorizontalLineWidth(const Value: integer);
begin
  if Value < 1 then exit;
  FDiagramHorizontalLineWidth := Value;
end;

procedure TGraph.SetDiagramVerticalLineWidth(const Value: integer);
begin
  if Value < 1 then exit;
  FDiagramVerticalLineWidth := Value;
end;

procedure TGraph.SetFixedMarkTextSizeHeight(const Value: integer);
begin
  FFixedMarkTextSizeHeight := Value;
  CalculateScale;
end;

procedure TGraph.SetFixedMarkTextSizeWidth(const Value: integer);
begin
  FFixedMarkTextSizeWidth := Value;
  CalculateScale;
end;

procedure TGraph.SetRightBorder(const Value: double);
begin
  CalculateMarkTextSize;
  FRightBorder := Value;
  CalculateScale;
end;

procedure TGraph.SetShowAxis(const Value: boolean);
begin
  FShowAxis := Value;
end;

procedure TGraph.SetShowGraphs(const Value: boolean);
begin
  FShowGraphs := Value;
end;

procedure TGraph.SetShowGrid(const Value: boolean);
begin
  FShowGrid := Value;
end;

procedure TGraph.SetShowPoints(const Value: boolean);
begin
  FShowPoints := Value;
end;

procedure TGraph.SetVerticalDiagram(const Value: boolean);
begin
  FVerticalDiagram := Value;
end;

procedure TGraph.SetVerticalFieldColor;
begin
  if (Index <= High(FVerticalFieldsColor)) and (Index >= 0) then
    FVerticalFieldsColor[Index] := Value;
end;

procedure TGraph.SetVerticalLineColor;
begin
  if (Index <= High(FVerticalLinesColor)) and (Index >= 0) then
    FVerticalLinesColor[Index] := Value;
end;

procedure TGraph.SetVerticalShift(Index: integer; const Value: double);
begin
  if (Index >= 0) and (Index <= High(FVerticalShift)) then
    FVerticalShift[Index] := Value;
end;

procedure TGraph.SetPointType(Index: integer; const Value: TPointType);
begin
  if (Index >= 0) and (Index <= High(FPointType)) then
    FPointType[Index] := Value;
end;

procedure TGraph.AddGraph(data: TList);
begin
  GraphList.Add(data);
  SetLength(FVerticalShift, GraphList.Count);
  SetLength(FPointType, GraphList.Count);
  PointType[GraphList.Count - 1] := ptCircle;
end;

procedure TGraph.RemoveGraph(i: integer);
var
  j: integer;
begin
  if (i >= 0) and (i < GraphList.Count) then
  begin
    TList(GraphList.Items[i]).Clear;
    GraphList.Delete(i);
    for j := i to High(FVerticalShift) - 1 do
      FVerticalShift[j] := FVerticalShift[j + 1];
    SetLength(FVerticalShift, GraphList.Count);

    for j := i to High(FPointType) - 1 do
      FPointType[j] := FPointType[j + 1];
    SetLength(FPointType, GraphList.Count);
  end;
end;

procedure TGraph.RemoveHorisontalField(i: integer);
var
  j: integer;
begin
  if (i >= 0) and (i < HorisontalFieldsList.Count) then
  begin
    TList(HorisontalFieldsList.Items[i]).Clear;
    HorisontalFieldsList.Delete(i);
  end;
end;

procedure TGraph.RemoveHorisontalLine(i: integer);
var
  j: integer;
begin
  if (i >= 0) and (i < HorisontalLinesList.Count) then
  begin
    TList<double>(HorisontalLinesList.Items[i]).Clear;
    HorisontalLinesList.Delete(i);
  end;
end;

procedure TGraph.RemoveVerticalField(i: integer);
var
  j: integer;
begin
  if (i >= 0) and (i < VerticalFieldsList.Count) then
  begin
    TList(VerticalFieldsList.Items[i]).Clear;
    VerticalFieldsList.Delete(i);
  end;
end;

procedure TGraph.RemoveVerticalLine(i: integer);
var
  j: integer;
begin
  if (i >= 0) and (i < VerticalLinesList.Count) then
  begin
    TList<double>(VerticalLinesList.Items[i]).Clear;
    VerticalLinesList.Delete(i);
  end;

end;

function TGraph.CalculateX(x: double; scale: double):integer;
begin
  if ScaleTypeX = stStandard then
    Result := Round((x - LeftBorder) * scale + LEFT_BORDER + GetMarkWidth)
  else if ScaleTypeX = stLogarifmic then
    Result := Round((ConvertLogarifm(x,0) - ConvertLogarifm(LeftBorder,0)) * scale + LEFT_BORDER + GetMarkWidth)
end;


function TGraph.CalculateY(y: double; scale: double):integer;
begin
  if ScaleTypeY = stStandard then
    Result := Round((TopBorder - y) * scale + UP_BORDER)
  else if ScaleTypeY = stLogarifmic then
    Result := Round((ConvertLogarifm(TopBorder,1) - ConvertLogarifm(y,1)) * scale + UP_BORDER)
end;

procedure TGraph.CalculatePolar(x, y: double; var res_x, res_y: integer);
var
  radius,angle, scale: double;
begin
  scale := ScaleY / 2;
  res_x := 0;
  res_y := 0;
  if abs(RightBorder - LeftBorder)<ZERO_VALUE then exit;

  angle := (x - LeftBorder) / (RightBorder - LeftBorder) * 2 * PI;
  radius := y - BottomBorder;

  res_x := round(radius * scale * cos(angle) + Image.Width / 2);
  res_y := round(-radius * scale * sin(angle) + Image.Height / 2);
end;

procedure TGraph.AddQuadrangle;
var
  x1int, y1int, x2int, y2int, x3int, y3int, x4int, y4int: integer;
  i:integer;
  {$ifdef android}
  poly:TPolygon;
  {$endif}
begin
  if CoordSystem = csDecart then begin
    x1int := CalculateX(x1,ScaleX);
    x2int := CalculateX(x2,ScaleX);
    x3int := CalculateX(x3,ScaleX);
    x4int := CalculateX(x4,ScaleX);
    y1int := CalculateY(y1,ScaleY);
    y2int := CalculateY(y2,ScaleY);
    y3int := CalculateY(y3,ScaleY);
    y4int := CalculateY(y4,ScaleY);
  end else if CoordSystem = csPolar then begin
    CalculatePolar(x1,y1,x1int,y1int);
    CalculatePolar(x2,y2,x2int,y2int);
    CalculatePolar(x3,y3,x3int,y3int);
    CalculatePolar(x4,y4,x4int,y4int);
  end;
  {$ifdef android}
  SetLength(poly,5);
  poly[0] := TPointF.Create(x1int,y1int);
  poly[1] := TPointF.Create(x2int,y2int);
  poly[2] := TPointF.Create(x3int,y3int);
  poly[3] := TPointF.Create(x4int,y4int);
  poly[4] := poly[0];
  Image.Bitmap.Canvas.BeginScene;
  Image.Bitmap.Canvas.Fill.Color:=c;
  Image.Bitmap.Canvas.Stroke.Color:=c;
  Image.Bitmap.Canvas.stroke.Kind := TBrushKind.Solid;
  Image.Bitmap.Canvas.DrawPolygon(poly,1);
  Image.Bitmap.Canvas.FillPolygon(poly,1);
  Image.Bitmap.Canvas.EndScene;

  {$else}
  Image.Canvas.Pen.Color := c;
  Image.Canvas.Brush.Color := c;
  Image.Canvas.Polygon([
        Point(x1int, y1int),
        Point(x2int, y2int),
        Point(x3int, y3int),
        Point(x4int, y4int)]);
  {$endif}
end;

procedure TGraph.AddLine;
var
  startX, endX, startY, endY: integer;
  i: integer;
begin
  if CoordSystem = csDecart then begin
    startX := CalculateX(x1,ScaleX);
    startY := CalculateY(y1,ScaleY);
    endX := CalculateX(x2,ScaleX);
    endY := CalculateY(y2,ScaleY);
  end else if CoordSystem = csPolar then begin
    CalculatePolar(x1,y1,startX,startY);
    CalculatePolar(x2,y2,endX,endY);
  end;
  {$ifdef android}
  if Image.Bitmap.Canvas.BeginScene then begin
    Image.Bitmap.Canvas.stroke.Color := c;
    Image.Bitmap.Canvas.stroke.Thickness := w;
    Image.Bitmap.Canvas.stroke.Kind := TBrushKind.Solid;

    Image.Bitmap.Canvas.stroke.Dash := penStyle;
    Image.Bitmap.Canvas.DrawLine(TPointF.Create(startX, startY),TPointF.Create(endX, endY),1);
    Image.Bitmap.Canvas.EndScene;
  end;
  {$else}
  Image.Canvas.Pen.Color := c;
  Image.Canvas.Pen.Width := w;
  Image.Canvas.Pen.Style := penStyle;
  Image.Canvas.MoveTo(startX, startY);
  Image.Canvas.LineTo(endX, endY);
  {$endif}
end;

procedure TGraph.AddStar;
var
  centerX, centerY: integer;
  i: integer;
begin
  if CoordSystem = csDecart then begin
    centerX := CalculateX(x,ScaleX);
    centerY := CalculateY(y,ScaleY);
  end else if CoordSystem = csPolar then begin
    CalculatePolar(x,y,centerX,centerY);
  end;
  {$ifdef android}
  if Image.Bitmap.Canvas.BeginScene then begin
    Image.Bitmap.Canvas.stroke.Color := c;
    Image.Bitmap.Canvas.stroke.Thickness := w;
    Image.Bitmap.Canvas.stroke.Kind := TBrushKind.Solid;

    Image.Bitmap.Canvas.stroke.Dash := penStyle;
    Image.Bitmap.Canvas.DrawLine(TPointF.Create(centerX - radius, centerY - radius div 2),TPointF.Create(centerX + radius, centerY + radius div 2),1);
    Image.Bitmap.Canvas.DrawLine(TPointF.Create(centerX - radius, centerY + radius div 2),TPointF.Create(centerX + radius, centerY - radius div 2),1);
    Image.Bitmap.Canvas.DrawLine(TPointF.Create(centerX, centerY - radius),TPointF.Create(centerX, centerY + radius),1);
    Image.Bitmap.Canvas.EndScene;
  end;
  {$else}
  Image.Canvas.Pen.Color := c;
  Image.Canvas.Pen.Width := w;
  Image.Canvas.Pen.Style := penStyle;
  Image.Canvas.MoveTo(centerX - radius, centerY - radius div 2);
  Image.Canvas.LineTo(centerX + radius, centerY + radius div 2);
  Image.Canvas.MoveTo(centerX - radius, centerY + radius div 2);
  Image.Canvas.LineTo(centerX + radius, centerY - radius div 2);
  Image.Canvas.MoveTo(centerX, centerY - radius);
  Image.Canvas.LineTo(centerX, centerY + radius);
  {$endif}
end;

procedure TGraph.AddCircle;
var
  centerX, centerY: integer;
  i: integer;
  {$ifdef android}
  rect:TRectF;
  {$endif}
begin
  if CoordSystem = csDecart then begin
    centerX := CalculateX(x,ScaleX);
    centerY := CalculateY(y,ScaleY);
  end else if CoordSystem = csPolar then begin
    CalculatePolar(x,y,centerX,centerY);
  end;
  {$ifdef android}
  Image.Bitmap.Canvas.BeginScene;
  Image.Bitmap.Canvas.fill.Color := cFill;
  Image.Bitmap.Canvas.fill.Kind := brushStyle;
  Image.Bitmap.Canvas.stroke.Color := c;
  Image.Bitmap.Canvas.stroke.Thickness := w;
  Image.Bitmap.Canvas.stroke.Dash := penStyle;
  Image.Bitmap.Canvas.stroke.Kind := TBrushKind.Solid;
  rect := TRectF.Create(TPointF.Create(centerX, centerY),radius*2,radius*2);
  Image.Bitmap.Canvas.DrawEllipse(rect,1);
  Image.Bitmap.Canvas.FillEllipse(rect,1);
  Image.Bitmap.Canvas.EndScene;
  {$else}
  Image.Canvas.Pen.Color := c;
  Image.Canvas.Pen.Width := w;
  Image.Canvas.Pen.Style := penStyle;
  Image.Canvas.Brush.color := cFill;
  Image.Canvas.Brush.Style := brushStyle;
  Image.Canvas.Ellipse(centerX - radius + 1, centerY - radius + 1,centerX + radius, centerY + radius);
  {$endif}
end;

procedure TGraph.AddPoint;
var
  pointX,pointY:integer;
  i: integer;
  {$ifdef android}
  rect:TRectF;
  {$endif}
begin
  if pointType = ptCircle then AddCircle(x,y,PointSize,c,cFill,1,{$ifdef android}TStrokeDash.sdSolid{$else}psSolid{$endif},PointStyle)
  else if pointType = ptStar then AddStar(x,y,PointSize,c,2);
  (*if CoordSystem = csDecart then begin
    pointX := CalculateX(x,ScaleX);
    pointY := CalculateY(y,ScaleY);
  end else if CoordSystem = csPolar then begin
    CalculatePolar(x,y,pointX,pointY);
  end;
  {$ifdef android}
  Image.Bitmap.Canvas.BeginScene;
  Image.Bitmap.Canvas.fill.Color := cFill;
  Image.Bitmap.Canvas.fill.Kind := PointStyle;
  Image.Bitmap.Canvas.stroke.Color := c;
  Image.Bitmap.Canvas.stroke.Dash := TStrokeDash.Solid;
  Image.Bitmap.Canvas.stroke.Kind := TBrushKind.Solid;
  rect := TRectF.Create(TPointF.Create(pointX, pointY),PointSize*2,PointSize*2);
  Image.Bitmap.Canvas.DrawEllipse(rect,1);
  Image.Bitmap.Canvas.FillEllipse(rect,1);
  Image.Bitmap.Canvas.EndScene;
  {$else}

  Image.Canvas.Pen.color := c;
  Image.Canvas.Pen.Style := psSolid;
  Image.Canvas.Brush.color := cFill;
  Image.Canvas.Brush.Style := PointStyle;
  Image.Canvas.Ellipse(pointX - PointSize + 1, pointY - PointSize + 1,
    pointX + PointSize, pointY + PointSize);
  {$endif}  *)
end;

procedure TGraph.AddText;
var
  textX,textY:integer;
  i: integer;
begin
  if CoordSystem = csDecart then begin
    textX := CalculateX(x,ScaleX);
    textY := CalculateY(y,ScaleY);
  end else if CoordSystem = csPolar then begin
    CalculatePolar(x,y,textX,textY);
  end;

  AddTextAbs(textX, textY, Value, c, alignHorisontal, alignVertical);
end;

procedure TGraph.AddTextAbs;
var
  i: integer;
begin
  case alignVertical of
    taAlignBottom: Y := Y - round(Image.Canvas.TextHeight(Value));
    taVerticalCenter: Y := Y - round(Image.Canvas.TextHeight(Value)) div 2;
  end;

  case alignHorisontal of
    taRightJustify: X := X - round(Image.Canvas.TextWidth(Value));
    taCenter: X := X - (round(Image.Canvas.TextWidth(Value)) div 2);
  end;
  {$ifdef android}
  Image.Bitmap.Canvas.BeginScene;
  Image.Bitmap.Canvas.fill.Color := c;
  Image.Bitmap.Canvas.Font.Size:=8;
  Image.Bitmap.Canvas.Font.Family:='Arial';
  Image.Bitmap.Canvas.fill.Kind := TBrushKind.None;
  Image.Bitmap.Canvas.stroke.Color := c;
  Image.Bitmap.Canvas.stroke.Dash := TStrokeDash.Solid;
  Image.Bitmap.Canvas.stroke.Kind := TBrushKind.Solid;
  Image.Bitmap.Canvas.FillText(
      RectF(textX, textY, textX + Image.Canvas.TextWidth(Value), textY + round(Image.Canvas.TextHeight(Value))),
      Value, false, 1, [], TTextAlign.Center, TTextAlign.Center);
  Image.Bitmap.Canvas.EndScene;
  {$else}

  Image.Canvas.Brush.Style := bsClear;
  Image.Canvas.Pen.color := c;
  Image.Canvas.TextOut(X, Y, Value);
  {$endif}
end;

procedure TGraph.DrawAxis;
const
  PointSize = 5;
var
  i: integer;

  markStep, markValue: double;
  lineStyle: {$ifdef android}TStrokeDash{$else}TPenStyle{$endif};

begin

  if ScaleTypeX = stStandard then DrawAxisStdX
  else if ScaleTypeX = stLogarifmic then DrawAxisLogX10;

  if ScaleTypeY = stStandard then DrawAxisStdY
  else if ScaleTypeY = stLogarifmic then DrawAxisLogY10;
end;

procedure TGraph.DrawAxisStdX;
const
  PointSize = 5;
var
  i,j: integer;

  markStep, markValue, coef: double;
  lineStyle: {$ifdef android}TStrokeDash{$else}TPenStyle{$endif};
  temp:double;
  x,y:integer;

begin
  temp := round(Image.Width - LEFT_BORDER - RIGHT_BORDER - MarkTextSizeWidth)
    div MIN_SIZE_BETWEEN_HORISONTAL_MARKS - 1;
  if temp <= 0 then temp := 1;

  markStep := RoundStepValue((RightBorder - LeftBorder) / temp );
  if abs(markStep)>ZERO_VALUE then markValue := markStep * Floor(LeftBorder / markStep)
  else begin
    markValue := LeftBorder;
    markStep := 1;
  end;
  coef := 0;
  if AxisXCaption <> '' then coef := (Image.Canvas.TextWidth(AxisXCaption) - RIGHT_BORDER + 3) / ScaleX;
  if coef < 0 then coef := 0;

  i := 1;
  while markValue < RightBorder - coef do
  begin
    if i mod 5 = 0 then
      lineStyle := {$ifdef android}TStrokeDash.Solid{$else}psSolid{$endif}
    else
      lineStyle := {$ifdef android}TStrokeDash.Dot{$else}psDot{$endif};
    AddHorisontalMark(0, markValue, lineStyle);
    markValue := markValue + markStep;
    i := i + 1;
  end;


  if ShowAxis and (AxisXCaption <> '') then begin
    if CoordSystem = csDecart then begin
      x := Image.Width - 5;
      y := Image.Height - DOWN_BORDER;
      if UseFixedMarkTextSizeHeight then y := y - FixedMarkTextSizeHeight
      else y := y - MarkTextSizeHeight;
      AddTextAbs(x, y, AxisXCaption, AxisColor, taRightJustify, taAlignTop);
    end else if CoordSystem = csPolar then begin
      //AddText(FLeftBorder, Value, t, AxisColor, taCenter,taAlignTop);
    end;
  end;
end;

procedure TGraph.DrawAxisStdY;
const
  PointSize = 5;
var
  i: integer;
  x,y:integer;
  markStep, markValue, coef: double;
  lineStyle: {$ifdef android}TStrokeDash{$else}TPenStyle{$endif};
  temp:double;
begin
  if CoordSystem = csDecart then begin
    temp := (round(Image.Height  -
        UP_BORDER - DOWN_BORDER - MarkTextSizeHeight)
      div MIN_SIZE_BETWEEN_VERTICAL_MARKS - 1);
    if temp <= 0 then temp := 1;

    markStep := RoundStepValue((TopBorder - BottomBorder) / temp );
    if markStep * 3 > (TopBorder - BottomBorder) then markStep := RoundStepValue((TopBorder - BottomBorder) / 3);
  end else if CoordSystem = csPolar then begin
    temp := round(Image.Height - UP_BORDER - DOWN_BORDER - MarkTextSizeWidth)
      div MIN_SIZE_BETWEEN_HORISONTAL_MARKS - 1;
    if temp <= 0 then temp := 1;
    markStep := RoundStepValue((TopBorder - BottomBorder) / temp);
    if markStep * 3 > (TopBorder - BottomBorder) then markStep := RoundStepValue((TopBorder - BottomBorder) / 3);
  end;

  if abs(markStep)<ZERO_VALUE then markStep := 1;

  AddVerticalMark(PointSize, 0, {$ifdef android}TStrokeDash.Solid{$else}psSolid{$endif});
  markValue := markStep;
  i := 1;
  coef := 0;
  if AxisYCaption <> '' then coef := (MarkTextSizeHeight - UP_BORDER + 3)/ ScaleY;
  if coef < 0 then coef := 0;
  while markValue < TopBorder - coef do
  begin
    if i mod 5 = 0 then
      lineStyle := {$ifdef android}TStrokeDash.Solid{$else}psSolid{$endif}
    else
      lineStyle := {$ifdef android}TStrokeDash.Dot{$else}psDot{$endif};
    AddVerticalMark(PointSize, markValue, lineStyle);
    markValue := markValue + markStep;
    i := i + 1;
  end;

  markValue := -markStep;
  i := 1;
  while markValue > BottomBorder do
  begin
    if i mod 5 = 0 then
      lineStyle := {$ifdef android}TStrokeDash.Solid{$else}psSolid{$endif}
    else
      lineStyle := {$ifdef android}TStrokeDash.Dot{$else}psDot{$endif};
    AddVerticalMark(PointSize, markValue, lineStyle);
    markValue := markValue - markStep;
    i := i + 1;
  end;

  if ShowAxis and (AxisYCaption <> '') then begin
    if CoordSystem = csDecart then begin
      x := LEFT_BORDER - PointSize;
      if UseFixedMarkTextSizeWidth then x := x + FixedMarkTextSizeWidth
      else x := x + MarkTextSizeWidth;
      y := 2;
      AddTextAbs(x, y, AxisYCaption, AxisColor, taRightJustify, taAlignTop);
    end else if CoordSystem = csPolar then begin
      //AddText(FLeftBorder, Value, t, AxisColor, taCenter,taAlignTop);
    end;
  end;
end;

procedure TGraph.DrawAxisLogX;
const
  PointSize = 5;
var
  i: integer;

  step, markValue, coef: double;
  lineStyle: {$ifdef android}TStrokeDash{$else}TPenStyle{$endif};
  temp:double;
begin
  step := (Image.Width  -
    LEFT_BORDER - RIGHT_BORDER - MarkTextSizeWidth) / MIN_SIZE_BETWEEN_HORISONTAL_MARKS;
  if step < 3 then step := 3;
  step := (ConvertLogarifm(RightBorder,0) - ConvertLogarifm(LeftBorder, 0))/step;

  coef := step;

  markValue := RevertLogarifm(coef,0);
  temp := 0;
  i:=0;
  while markValue < RightBorder do
  begin
    if i mod 5 = 0 then
      lineStyle := {$ifdef android}TStrokeDash.Solid{$else}psSolid{$endif}
    else
      lineStyle := {$ifdef android}TStrokeDash.Dot{$else}psDot{$endif};
    markValue := RoundValue(markValue, abs(markValue - temp)/2);
    AddHorisontalMark(PointSize, markValue, lineStyle);
    temp := markValue;
    coef := coef + step;
    markValue := RevertLogarifm(coef,0);
    i := i + 1;
  end;
end;
procedure TGraph.DrawAxisLogY;
const
  PointSize = 5;
var
  i: integer;

  markValue,coef,temp,step: double;
  lineStyle: {$ifdef android}TStrokeDash{$else}TPenStyle{$endif};

begin
  step := (Image.Height  -
    UP_BORDER - DOWN_BORDER - MarkTextSizeHeight) / MIN_SIZE_BETWEEN_VERTICAL_MARKS;
  if step < 3 then step := 3;
  step := (ConvertLogarifm(TopBorder,1) - ConvertLogarifm(BottomBorder, 1))/step;

  coef := step;

  markValue := RevertLogarifm(coef,1);
  temp := 0;
  i:=0;
  while markValue < TopBorder do
  begin
    if i mod 5 = 0 then
      lineStyle := {$ifdef android}TStrokeDash.Solid{$else}psSolid{$endif}
    else
      lineStyle := {$ifdef android}TStrokeDash.Dot{$else}psDot{$endif};
    markValue := RoundValue(markValue, abs(markValue - temp)/2);
    AddVerticalMark(PointSize, markValue, lineStyle);
    temp := markValue;
    coef := coef + step;
    markValue := RevertLogarifm(coef,1);
    i := i + 1;
  end;
end;
procedure TGraph.DrawAxisLogX10;
const
  PointSize = 5;
var
  i,j: integer;

  step, markValue: double;
  lineStyle: {$ifdef android}TStrokeDash{$else}TPenStyle{$endif};
  temp:double;

  x,y:integer;
begin
  step := 1;
  while step > RightBorder do step := step / 10;
  while step < RightBorder do step := step * 10;
  if step > RightBorder * 2 then step := step / 10000
  else step := step / 1000;
  i:=0;
  markValue := 0;
  while markValue < RightBorder do
  begin
    markValue := 0;
    for j := 0 to 9 do begin
      markValue := markValue + step;
      if i mod 5 = 0 then
        lineStyle := {$ifdef android}TStrokeDash.Solid{$else}psSolid{$endif}
      else
        lineStyle := {$ifdef android}TStrokeDash.Dot{$else}psDot{$endif};
      AddHorisontalMark(0, markValue, lineStyle);
      i := i + 1;
    end;
    step := step * 10;
  end;

  if ShowAxis and (AxisXCaption <> '') then begin
    if CoordSystem = csDecart then begin
      x := Image.Width - 5;
      y := Image.Height - DOWN_BORDER;
      if UseFixedMarkTextSizeHeight then y := y - FixedMarkTextSizeHeight
      else y := y - MarkTextSizeHeight;
      AddTextAbs(x, y, AxisXCaption, AxisColor, taRightJustify, taAlignTop);
    end else if CoordSystem = csPolar then begin
      //AddText(FLeftBorder, Value, t, AxisColor, taCenter,taAlignTop);
    end;
  end;
end;
procedure TGraph.DrawAxisLogY10;
const
  PointSize = 5;
var
  i,j: integer;

  markValue,step: double;
  lineStyle: {$ifdef android}TStrokeDash{$else}TPenStyle{$endif};
  x,y:integer;
begin
  step := 1;
  while step > TopBorder do step := step / 10;
  while step < TopBorder do step := step * 10;
  if step > TopBorder * 2 then step := step / 10000
  else step := step / 1000;
  i:=0;
  markValue := 0;
  while markValue < TopBorder do
  begin
    markValue := 0;
    for j := 0 to 9 do begin
      markValue := markValue + step;
      if i mod 5 = 0 then
        lineStyle := {$ifdef android}TStrokeDash.Solid{$else}psSolid{$endif}
      else
        lineStyle := {$ifdef android}TStrokeDash.Dot{$else}psDot{$endif};
      AddVerticalMark(PointSize, markValue, lineStyle);
      i := i + 1;
    end;
    step := step * 10;
  end;
  if ShowAxis and (AxisYCaption <> '') then begin
    if CoordSystem = csDecart then begin
      x := LEFT_BORDER - PointSize;
      y := 2;
      if UseFixedMarkTextSizeWidth then x := x + FixedMarkTextSizeWidth
      else x := x + MarkTextSizeWidth;
      AddTextAbs(x, y, AxisYCaption, AxisColor, taRightJustify, taAlignTop);
    end else if CoordSystem = csPolar then begin
      //AddText(FLeftBorder, Value, t, AxisColor, taCenter,taAlignTop);
    end;
  end;
end;

function TGraph.RoundStepValue(Value: double): double;
var
  coef: integer;
begin
  if Value = 0 then
    Result := 0
  else
  begin
    if Value > 0 then
      coef := 1
    else
      coef := -1;
    Result := 1;
    while Result > Value * coef do
      Result := Result / 10;
    while Result * 10 < Value * coef do
      Result := Result * 10;
    if Result * 2 >= Value * coef then
      Result := Result * 2
    else if Result * 5 >= Value * coef then
      Result := Result * 5
    else
      Result := Result * 10;
    Result := Result * coef;
  end;
end;

function TGraph.RoundValue(Value, step: double): double;
var
  d: double;
begin
  if step <= 0 then
    Result := Value
  else
  begin
    d := 1;
    while d < 1 / step do
      d := d * 10;
    while d / 10 > 1 / step do
      d := d / 10;

    Result := Round(Value * d) / d;
  end;

end;

procedure TGraph.AddVerticalField(data: TList);
begin
  VerticalFieldsList.Add(data);
end;

procedure TGraph.AddVerticalLine(data: TList<double>);
begin
  VerticalLinesList.Add(data);
end;

procedure TGraph.AddVerticalMark;
var
  t: string;
begin
  if (Value <= BottomBorder) or (Value >= TopBorder) then
    exit;
  if abs(Value) <= (TopBorder - BottomBorder) / 1000000 then
    Value := 0;
  if ShowAxis then begin
    if ScaleTypeY = stStandard then t := DoubleToStr(Value, TopBorder - BottomBorder)
    else if ScaleTypeY = stLogarifmic then t:= FloatToStr(Value);
    if CoordSystem = csDecart then begin
      AddLine(LeftBorder, Value, LeftBorder - markSize / ScaleX, Value,
        AxisColor, 1);
      AddText(LeftBorder - markSize / ScaleX,
        Value, t, AxisColor, taRightJustify, taVerticalCenter);
    end else if CoordSystem = csPolar then begin
      AddText(LeftBorder, Value, t, AxisColor, taCenter,taAlignTop);
    end;
  end;

  if ShowGrid then
    if CoordSystem = csDecart then
      AddLine(LeftBorder, Value, RightBorder, Value, GridColor, 1, lineStyle)
    else if CoordSystem = csPolar then
      AddCircle(0,BottomBorder, round((Value - BottomBorder) * ScaleY / 2), GridColor, GridColor, 1, lineStyle);

end;

procedure TGraph.AddHorisontalField(data: TList);
begin
  HorisontalFieldsList.Add(data);
end;

procedure TGraph.AddHorisontalLine(data: TList<double>);
begin
  HorisontalLinesList.Add(data);
end;

procedure TGraph.AddHorisontalMark;
var
  t: string;
begin
  if (Value < LeftBorder) or (Value >= RightBorder) then
    exit;
  if (Value = LeftBorder) and (CoordSystem = csDecart) then
    exit;
  if abs(Value) <= (RightBorder - LeftBorder) / 1000000 then
    Value := 0;
  if ShowAxis then begin
    if ScaleTypeX = stStandard then t := DoubleToStr(Value, RightBorder - LeftBorder)
    else if ScaleTypeX = stLogarifmic then t:= FloatToStr(Value);
    if CoordSystem = csDecart then begin
      AddLine(Value, BottomBorder, Value, BottomBorder - markSize / ScaleY,
        AxisColor, 1);
      AddText(Value, BottomBorder - markSize / ScaleY, t, AxisColor, taCenter,taAlignTop);
    end else if CoordSystem = csPolar then begin
      AddText(Value, TopBorder + MarkTextSizeHeight / ScaleY, t, AxisColor, taCenter, taVerticalCenter);
    end;
  end;

  if ShowGrid then
    AddLine(Value, BottomBorder, Value, TopBorder, GridColor, 1, lineStyle);


end;

procedure TGraph.DrawGraph(data: TList; Index: integer);
var
  i: integer;
begin

  for i := 1 to data.Count - 1 do
  begin
    AddLine(PMyPoint(data.Items[i - 1])^.x, PMyPoint(data.Items[i - 1])^.y +
      VerticalShift[index], PMyPoint(data.Items[i])^.x, PMyPoint(data.Items[i])
      ^.y + VerticalShift[index], GraphicsColor[index], GraphLineWidth);
  end;
end;

procedure TGraph.DrawTrust(data: TList; Index: integer);
var
  i: integer;
  MaxY: double;
  y1low,y2low,y1high,y2high: double;
  point1,point2:PMyPoint;
begin
  MaxY := 0;
  if TrustMethod = 1 then begin

    for i := 0 to data.Count - 1 do begin
      if abs(PMyPoint(data.Items[i])^.y)>MaxY then MaxY:=abs(PMyPoint(data.Items[i])^.y);
    end;

  end else if TrustMethod = 2 then begin
    for i := 0 to data.Count - 1 do begin
      MaxY:=MaxY+abs(PMyPoint(data.Items[i])^.y);
    end;
    if data.Count>0 then MaxY:=MaxY/data.Count else MaxY:=0;
  end;

  MaxY := MaxY * TrustMinPercentage / 200;

  for i := 1 to data.Count-1 do begin
    point1 := PMyPoint(data.Items[i - 1]);
    point2 := PMyPoint(data.Items[i]);

    y1high := point1^.y + Max(abs(point1^.y * TrustPercentage / 100),MaxY) + VerticalShift[index];
    y1low := point1^.y - Max(abs(point1^.y * TrustPercentage / 100),MaxY) + VerticalShift[index];

    y2high := point2^.y + Max(abs(point2^.y * TrustPercentage / 100),MaxY) + VerticalShift[index];
    y2low := point2^.y - Max(abs(point2^.y * TrustPercentage / 100),MaxY) + VerticalShift[index];
    AddQuadrangle(point1^.X,y1high,
                  point2^.X,y2high,
                  point2^.X,y2low,
                  point1^.X,y1low,
                  TrustColor);
    AddLine(point1^.X,y1high,point1^.X,y1low,GraphicsColor[index],GraphLineWidth);
    AddLine(point1^.X,y1high,point2^.X,y2high,GraphicsColor[index],GraphLineWidth);
    AddLine(point1^.X,y1low,point2^.X,y2low,GraphicsColor[index],GraphLineWidth);
  end;
end;

procedure TGraph.DrawHorizontalDiagram(data: TList; Index: integer);
var
  i: integer;
begin
  for i := 0 to data.Count - 1 do
  begin
    AddLine(LeftBorder, PMyPoint(data.Items[i])^.y + VerticalShift[index], PMyPoint(data.Items[i])^.x, PMyPoint(data.Items[i])
      ^.y + VerticalShift[index], GraphicsColor[index], DiagramHorizontalLineWidth);
  end;

end;

procedure TGraph.DrawHorisontalFields(data: TList; Index: integer);
var
  i: integer;
begin
  for i := 0 to data.Count - 1 do
  begin
    AddQuadrangle(LeftBorder, PMyPoint(data.Items[i])^.X,
                  LeftBorder, PMyPoint(data.Items[i])^.Y,
                  RightBorder, PMyPoint(data.Items[i])^.Y,
                  RightBorder, PMyPoint(data.Items[i])^.X,
                  HorisontalFieldsColor[index]);
  end;
end;

procedure TGraph.DrawHorisontalLines(data: TList<double>; Index: integer);
var
  i: integer;
begin
  for i := 0 to data.Count - 1 do
  begin
    AddLine(LeftBorder, data.Items[i], RightBorder, data.Items[i],
    HorisontalLinesColor[index], DiagramHorizontalLineWidth);
  end;

end;

procedure TGraph.DrawPoints(data: TList; Index: integer);
var
  i: integer;
  c,cfill:{$ifdef android}TAlphaColor{$else}TColor{$endif};
  x,y:double;
begin
  for i := 0 to data.Count - 1 do
  begin
    if ColoredPoints then begin
      c := PColoredPoint(data.Items[i])^.color;
      cfill := PColoredPoint(data.Items[i])^.fillColor;
      x := PColoredPoint(data.Items[i])^.x;
      y := PColoredPoint(data.Items[i])^.y;
    end else begin
      c := GraphicsColor[index];
      cFill := GraphicsColor[index];
      x := PMyPoint(data.Items[i])^.x;
      y := PMyPoint(data.Items[i])^.y;
    end;
    AddPoint(x, y + VerticalShift[index], c, cFill,PointType[index]);
  end;

end;

procedure TGraph.DrawVerticalDiagram(data: TList; Index: integer);
var
  i: integer;
begin
  for i := 0 to data.Count - 1 do
  begin
    AddLine(PMyPoint(data.Items[i])^.x, BottomBorder, PMyPoint(data.Items[i])^.x, PMyPoint(data.Items[i])
      ^.y + VerticalShift[index], GraphicsColor[index], DiagramVerticalLineWidth);
  end;
end;

procedure TGraph.DrawVerticalFields(data: TList; Index: integer);
var
  i: integer;
begin
  for i := 0 to data.Count - 1 do
  begin
    AddQuadrangle(PMyPoint(data.Items[i])^.X, BottomBorder,
                  PMyPoint(data.Items[i])^.X, TopBorder,
                  PMyPoint(data.Items[i])^.Y, TopBorder,
                  PMyPoint(data.Items[i])^.Y, BottomBorder,
                  VerticalFieldsColor[index]);
  end;
end;

procedure TGraph.DrawVerticalLines(data: TList<double>; Index: integer);
var
  i: integer;
begin
  for i := 0 to data.Count - 1 do
  begin
    AddLine(data.Items[i], BottomBorder, data.Items[i], TopBorder, VerticalLinesColor[index], DiagramVerticalLineWidth);
  end;
end;

function TGraph.ConvertComplexArrayToPointArray(data: TComplexArray;
  deltaT: double; startTime: double = 0; maxPointCount: integer = 1000): TList;
var
  i, decVal, outSize: integer;
  coord: PMyPoint;
begin
  Result := TList.Create;
  if maxPointCount > 0 then
    decVal := High(data) div maxPointCount
  else
    decVal := 1;

  if decVal <= 0 then
    decVal := 1;

  outSize := 0;
  i := 1;
  while i <= High(data) do
  begin
    GetMem(coord, SizeOf(TMyPoint));
    try
      coord^.x := (i - 1) * deltaT + startTime;
      coord^.y := data[i].Re;
      Result.Add(coord);
    except
      FreeMem(coord);
      raise;
    end;
    i := i + decVal;
  end;
end;

function TGraph.ConvertDoubleArrayToPointArray(data: array of double;
  deltaT: double; startTime: double = 0; maxPointCount: integer = 1000): TList;
var
  i, decVal, outSize: integer;
  coord: PMyPoint;
begin
  Result := TList.Create;
  if maxPointCount > 0 then
    decVal := High(data) div maxPointCount
  else
    decVal := 1;

  if decVal = 0 then
    decVal := 1;

  outSize := 0;
  i := 1;
  while i <= High(data) do
  begin
    GetMem(coord, SizeOf(TMyPoint));
    try
      coord^.x := (i - 1) * deltaT + startTime;
      coord^.y := data[i];
      Result.Add(coord);
    except
      FreeMem(coord);
      raise;
    end;
    i := i + decVal;
  end;
end;

end.
