unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uGraphic, uDataTypes, math,
  Vcl.ComCtrls;

type
  TfMain = class(TForm)
    mainGraph: TImage;
    bOpen: TButton;
    StatusBar: TStatusBar;
    cbShowGrid: TCheckBox;
    cbShowAxis: TCheckBox;
    cbShowPoints: TCheckBox;
    cbShowGraphs: TCheckBox;
    cbVerticalDiagram: TCheckBox;
    cbTrustDiagram: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure bOpenClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mainGraphMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cbPropertyClick(Sender: TObject);
  private
    MouseX,MouseY:double;
    graph:TGraph;
    TimeInterval:double;
    function OpenFile(FileName: string):TComplexArray;
    procedure PrepareData(InputArray: TComplexArray);
    procedure RepaintStatus;
    procedure UpdateGraphView;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.bOpenClick(Sender: TObject);
begin
  with TOpenDialog.Create(self) do begin
    if execute then
      PrepareData(OpenFile(FileName));
    Free;
  end;
end;

procedure TfMain.cbPropertyClick(Sender: TObject);
begin
  UpdateGraphView;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  graph := TGraph.Create(mainGraph);

  graph.LeftBorder := 0;
  graph.RightBorder := 100;
  graph.TopBorder := 10;
  graph.BottomBorder := -10;

  graph.AxisXCaption := 't';
  graph.AxisYCaption := 'A';
  MouseX := 0;
  MouseY := 0;
  RepaintStatus;
  UpdateGraphView;
end;

procedure TfMain.FormResize(Sender: TObject);
begin
  graph.Repaint;
end;

procedure TfMain.mainGraphMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  MouseX := graph.CalculateGraphXByMouseX(X);
  MouseY := graph.CalculateGraphYByMouseY(Y);
  RepaintStatus;
end;

function TfMain.OpenFile(FileName:string):TComplexArray;
var
  f: TextFile;
  i: Integer;
  s: string;
  code,tmp,cnt:integer;
begin
  if FileName = '' then exit;

  if fileexists(FileName) then begin
    AssignFile(f, FileName);
    Reset(f);
    Readln(f, s);
    s := Trim(s);
    s:=StringReplace(s,',','.',[rfReplaceAll]);
    val(s,TimeInterval,code);
    if code<>0 then begin
      CloseFile(f);
      exit;
    end;
    cnt:=1;
    tmp:=1000;
    SetLength(Result,tmp+1);
    while not EOF(f) do begin
      Readln(f, s);
      if s<>'' then begin
        s:=StringReplace(s,',','.',[rfReplaceAll]);
        if pos(' ', s) > 0 then  s := copy(s, 1, pos(' ', s) - 1)
        else if pos(#9, s) > 0 then  s := copy(s, 1, pos(#9, s) - 1)
        else if pos(';', s) > 0 then  s := copy(s, 1, pos(';', s) - 1);
        s := Trim(s);
        val(s,Result[cnt].Re,code);
        if code<>0 then begin
          CloseFile(f);
          SetLength(Result, 0);
          exit;
        end;
        cnt:=cnt+1;
        if cnt>tmp then begin
          tmp:=tmp+1000;
          SetLength(Result,tmp+1);
        end;
      end;
    end;
    SetLength(Result,cnt);
    CloseFile(f);
  end;
end;

procedure TfMain.PrepareData(InputArray:TComplexArray);
var
  minValue,maxValue:double;
  i:integer;
begin
  maxValue := -MaxDouble;
  minValue := MaxDouble;
  for i := 1 to high(InputArray) do begin
    if InputArray[i].Re > maxValue then maxValue:=InputArray[i].Re;
    if InputArray[i].Re < minValue then minValue:=InputArray[i].Re;
  end;

  graph.ClearGraphList;
  graph.VerticalShift[0] := 0;
  graph.LeftBorder := 0;
  graph.RightBorder := (High(InputArray)-1) * TimeInterval;
  graph.TopBorder := maxValue;
  graph.BottomBorder := minValue;
  graph.AddGraph(graph.ConvertComplexArrayToPointArray(InputArray,TimeInterval,0,5000));
  graph.Repaint;
end;

procedure TfMain.RepaintStatus;
begin
  StatusBar.Panels[0].Text := Format('Coords: (%f x %f)',[MouseX, MouseY]);
end;


procedure TfMain.UpdateGraphView();
begin
  graph.ShowAxis := cbShowAxis.Checked;
  graph.ShowGrid := cbShowGrid.Checked;
  graph.ShowPoints := cbShowPoints.Checked;
  graph.ShowGraphs := cbShowGraphs.Checked;
  graph.isVerticalDiagram := cbVerticalDiagram.Checked;
  graph.isTrustDiagram := cbTrustDiagram.Checked;
  graph.Repaint;
end;

end.
