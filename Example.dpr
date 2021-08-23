program Example;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fMain},
  uGraphic in 'uGraphic.pas',
  uDataTypes in 'uDataTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
