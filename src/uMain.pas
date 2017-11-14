unit uMain;

interface

uses
    Winapi.Windows
  , System.SysUtils
  , System.Classes
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Data.DB
  , Vcl.Grids
  , Vcl.DBGrids
  , Vcl.StdCtrls
  , Vcl.ExtCtrls
  , RO.DBConnectionIntf
  , RO.DBGenericImpl
  , RO.DBUniImpl
  , ConnectionInfo
  ;

type
  TfMain = class(TForm)
    pnlMenu: TPanel;
    lblTitle: TLabel;
    lblHostname: TLabel;
    edHostname: TEdit;
    lblDatabase: TLabel;
    edDatabase: TEdit;
    lblUsername: TLabel;
    edUsername: TEdit;
    lblPassword: TLabel;
    edPassword: TEdit;
    bConnect: TButton;
    bExit: TButton;
    gridPosts: TDBGrid;
    edPort: TEdit;
    lblPort: TLabel;
    dsPosts: TDataSource;
    lblHowTo: TLabel;
    lblHowToDetail: TLabel;
    procedure bExitClick(Sender: TObject);
    procedure bConnectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MemoHandler(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure gridPostsDblClick(Sender: TObject);
    procedure gridPostsKeyPress(Sender: TObject; var Key: Char);
  private
    dbSQL: IDatabase;
    qPosts: IDBQuery;
    ConnectionInfo: IConnectionInfo;
    procedure LoadConnectionInfo;
    procedure SaveConnectionInfo;
    procedure LoadPosts;
    procedure ChangePageViews(const PostID: Integer; const NewValue: LongWord);
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.bConnectClick(Sender: TObject);
begin
  if edHostname.Text = ''
    then begin
      edHostname.SetFocus;
      Exit;
    end;

  dbSQL := TDatabase.New(
    TServer.New(
      edHostname.Text,
      StrToInt(edPort.Text),
      edUsername.Text,
      edPassword.Text,
      TServerType.stMySQL
    ),
    edDatabase.Text
  ).Connect;

  if dbSQL.IsConnected
    then begin
      SaveConnectionInfo;
      LoadPosts;
      gridPosts.SetFocus;
    end
    else begin
      ShowMessage('Não foi possível conectar ao servidor. . .');
    end;
end;

procedure TfMain.bExitClick(Sender: TObject);
begin
  dbSQL.Disconnect;
  Application.Terminate;
end;

procedure TfMain.ChangePageViews(const PostID: Integer; const NewValue: LongWord);
begin
  if MessageDlg(
       Format('%d será gravado como o novo valor de visualizações.'#10'Confirma?', [NewValue]),
       mtConfirmation,
       [mbYes, mbNo],
       0,
       mbYes
     ) = mrYes
    then begin
      dbSQL.Run(
        TSQLStatement.New(
          'UPDATE wp_popularpostsdata ' +
          '   SET pageviews = ' + NewValue.ToString + ' ' +
          ' WHERE postid = ' + PostID.ToString,
          TSQLParams.New
        )
      );
      dsPosts.Dataset.Refresh;
    end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  lblHowToDetail.Caption :=
    '1. Insert your server access data'#10 +
    '2. Click ''Connect'''#10 +
    '3. Double Click the post you need to change'#10 +
    '4. Insert new value';
  ConnectionInfo := TConnectionInfo.New(
    ChangeFileExt(
      ParamStr(0),
      '.ini'
    )
  );
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  LoadConnectionInfo;
  if edHostname.Text <> ''
    then bConnect.SetFocus;
end;

procedure TfMain.gridPostsDblClick(Sender: TObject);
var
  NewValue: Integer;
begin
  try
    NewValue := StrToInt(
      InputBox(
        'Substituir número de visualizações',
        Format('Qual o novo valor para o post '#10'"%s"?', [dsPosts.DataSet.FieldByName('post_title').AsString]),
        dsPosts.DataSet.FieldByName('pageviews').AsString
      )
    );
  except
    on E: EConvertError do
      begin
        ShowMessage('O valor deve ser numérico.');
        NewValue := dsPosts.DataSet.FieldByName('pageviews').AsInteger;
      end;
  end;

  if NewValue <> dsPosts.DataSet.FieldByName('pageviews').AsInteger
    then begin
      ChangePageViews(
        dsPosts.DataSet.FieldByName('ID').AsInteger,
        NewValue
      );
    end;
end;

procedure TfMain.gridPostsKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and Assigned(dsPosts.DataSet) and (dsPosts.DataSet.RecordCount > 0)
    then begin
      gridPostsDblClick(Sender);
      Key := #0;
    end;
end;

procedure TfMain.LoadConnectionInfo;
begin
  edHostname.Text := ConnectionInfo.Hostname;
  edPort.Text     := ConnectionInfo.Port.ToString;
  edDatabase.Text := ConnectionInfo.Database;
  edUsername.Text := ConnectionInfo.Username;
  edPassword.Text := ConnectionInfo.Password;
end;

procedure TfMain.LoadPosts;
begin
  qPosts := dbSQL.NewQuery(
    TSQLStatement.New(
      'select wp_posts.ID, wp_posts.post_title, wp_popularpostsdata.pageviews '+
      '  from wp_posts '+
      ' inner join wp_popularpostsdata on wp_popularpostsdata.postid = wp_posts.ID '+
      ' where post_status = ''publish'' '+
      '   and post_title <> '''' '+
      ' order by post_title'
    )
  ).Run
   .Publish(dsPosts);
  dsPosts.DataSet.FieldByName('post_title').OnGetText := MemoHandler;
end;

procedure TfMain.MemoHandler(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := Copy(dsPosts.DataSet.FieldByName('post_title').AsString, 1, 400);
end;

procedure TfMain.SaveConnectionInfo;
begin
  ConnectionInfo.Hostname := edHostname.Text;
  ConnectionInfo.Port     := StrToInt(edPort.Text);
  ConnectionInfo.Database := edDatabase.Text;
  ConnectionInfo.Username := edUsername.Text;
  ConnectionInfo.Password := edPassword.Text;
end;

end.
