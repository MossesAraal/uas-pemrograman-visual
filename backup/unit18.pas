unit Unit18;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset;

type

  { TFormReportAbsensiUser }

  TFormReportAbsensiUser = class(TForm)
    Button1: TButton;
    ButtonDisplay: TButton;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelDepartment: TLabel;
    LabelID: TLabel;
    LabelJabatan: TLabel;
    LabelNama: TLabel;
    LabelTotalAbsen: TLabel;
    LabelTotalHadir: TLabel;
    LabelTotalIzin: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure ButtonDisplayClick(Sender: TObject);
  private

  public

  end;

var
  FormReportAbsensiUser: TFormReportAbsensiUser;

implementation
uses
  Unit1, Unit8;

{$R *.lfm}

{ TFormReportAbsensiUser }

procedure TFormReportAbsensiUser.ButtonDisplayClick(Sender: TObject);
var
  idKaryawan:Integer;
begin
  ZQuery1.SQL.Text := 'SELECT id FROM karyawan WHERE username = :username AND password = :password';
  ZQuery1.ParamByName('username').AsString := FormLogin.EditUsername.Text;
  ZQuery1.ParamByName('password').AsString := FormLogin.EditPassword.Text;
  ZQuery1.Open;
  idKaryawan := ZQuery1.FieldByName('id').AsInteger;
  ZQuery1.Close;

  ZQuery1.SQL.Text := 'SELECT * FROM absensi AS a INNER JOIN karyawan AS k ON a.id = k.id ' +
  'INNER JOIN laporan_absensi_karyawan AS lak ON a.absen_id = lak.absen_id WHERE a.id = :id ORDER BY lak.total_hadir DESC LIMIT 1';
  ZQuery1.ParamByName('id').AsInteger := idKaryawan;
  ZQuery1.Open;
  LabelID.Caption := IntToStr(ZQuery1.FieldByName('id').AsInteger);
  LabelNama.Caption := ZQuery1.FieldByName('nama').AsString;
  LabelDepartment.Caption := ZQuery1.FieldByName('department').AsString;
  LabelJabatan.Caption := ZQuery1.FieldByName('jabatan').AsString;
  LabelTotalHadir.Caption := IntToStr(ZQuery1.FieldByName('total_hadir').AsInteger);
  LabelTotalAbsen.Caption := IntToStr(ZQuery1.FieldByName('total_absen').AsInteger);
  LabelTotalIzin.Caption := IntToStr(ZQuery1.FieldByName('total_izin').AsInteger);

  if ZQuery1.RecordCount = 0 then
    begin
      LabelID.Caption := '-';
      LabelNama.Caption := '-';
      LabelDepartment.Caption := '-';
      LabelJabatan.Caption := '-';
      LabelTotalHadir.Caption := '-';
      LabelTotalAbsen.Caption := '-';
      LabelTotalIzin.Caption := '-';
      showMessage('data tidak ada');
    end;
    ZQuery1.Close;
end;

procedure TFormReportAbsensiUser.Button1Click(Sender: TObject);
begin
  FormReportAbsensiUser.Close;
  FormAbsensi.Show;
end;

end.

