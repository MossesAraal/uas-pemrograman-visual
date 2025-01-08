unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ExtDlgs, DateTimePicker, ZConnection, ZDataset, Unit2, Unit3, Unit8;

type

  { TFormLogin }

  TFormLogin = class(TForm)
    Button1: TButton;
    ButtonLogin: TButton;
    DataSource1: TDataSource;
    EditUsername: TEdit;
    EditPassword: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure ButtonLoginClick(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.lfm}

{ TFormLogin }

procedure TFormLogin.ButtonLoginClick(Sender: TObject);
var
  username, password:String;
  GlobalUsername:String;
begin
  username := EditUsername.Text;
  password := EditPassword.Text;

  GlobalUsername := EditUsername.Text;

  if ZConnection1.Connected = true then
     begin
       ZQuery1.SQL.Text := 'SELECT * FROM karyawan WHERE username = :username AND password = :password';
       ZQuery1.ParamByName('username').AsString := username;
       ZQuery1.ParamByName('password').AsString := password;
       ZQuery1.Active := true;
       if ZQuery1.RecordCount > 0 then
          if ZQuery1.FieldByName('department').AsString = 'HRD' then
            begin
              showMessage('login berhasil');
              FormMonitoringKaryawan.Show;
              Zquery1.Close;
            end
         else
           begin
             FormAbsensi.Show;
             ZQuery1.Close;
           end
     else
         begin
           showMessage('login gagal');
           ZQuery1.Close;
         end;
     end;
end;

procedure TFormLogin.Button1Click(Sender: TObject);
begin
  FormRegister.show;
end;

procedure TFormLogin.ZConnection1AfterConnect(Sender: TObject);
begin

end;

end.

