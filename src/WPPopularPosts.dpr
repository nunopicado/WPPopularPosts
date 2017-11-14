program WPPopularPosts;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fMain},
  ConnectionInfo in 'ConnectionInfo.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  ReportMemoryLeaksOnShutDown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'WP Popular Posts';
  TStyleManager.TrySetStyle('Auric');
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
