unit Unit16;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset, DateTimePicker;

type

  { TFormReportAbsensiHarianUser }

  TFormReportAbsensiHarianUser = class(TForm)
    Button1: TButton;
    ButtonDisplay: TButton;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelDepartment: TLabel;
    LabelID: TLabel;
    LabelJabatan: TLabel;
    LabelJamKeluar: TLabel;
    LabelJamMasuk: TLabel;
    LabelNama: TLabel;
    LabelStatusKehadiran: TLabel;
    TimePickerTanggal: TDateTimePicker;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure ButtonDisplayClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormReportAbsensiHarianUser: TFormReportAbsensiHarianUser;

implementation
uses
  Unit1, Unit8;
{$R *.lfm}

{ TFormReportAbsensiHarianUser }

procedure TFormReportAbsensiHarianUser.ButtonDisplayClick(Sender: TObject);
var
  idKaryawan:Integer;
begin
  ZQuery1.SQL.Text := 'SELECT id FROM karyawan WHERE username = :username AND password = :password';
  ZQuery1.ParamByName('username').AsString := FormLogin.EditUsername.Text;
  ZQuery1.ParamByName('password').AsString := FormLogin.EditPassword.Text;
  ZQuery1.Open;
  idKaryawan := ZQuery1.FieldByName('id').AsInteger;
  ZQuery1.Close;

  ZQuery1.SQL.Text := 'SELECT k.nama, k.id, k.department, k.jabatan, a.jam_masuk, a.jam_keluar, a.status_kehadiran, a.tanggal FROM absensi AS a INNER JOIN karyawan AS k ON a.id = k.id WHERE a.id = :id AND a.tanggal = :tanggal';
  ZQuery1.ParamByName('id').AsInteger := idKaryawan;
  ZQuery1.ParamByName('tanggal').AsString := FormatDateTime('mm/dd/yyyy', TimePickerTanggal.Date);
  ZQuery1.Open;
  LabelID.Caption := IntToStr(ZQuery1.FieldByName('id').AsInteger);
  LabelNama.Caption := ZQuery1.FieldByName('nama').AsString;
  LabelDepartment.Caption := ZQuery1.FieldByName('department').AsString;
  LabelJabatan.Caption := ZQuery1.FieldByName('jabatan').AsString;
  LabelJamMasuk.Caption := ZQuery1.FieldByName('jam_masuk').AsString;
  LabelJamKeluar.Caption := ZQuery1.FieldByName('jam_keluar').AsString;
  LabelStatusKehadiran.Caption := ZQuery1.FieldByName('status_kehadiran').AsString;
  if ZQuery1.RecordCount = 0 then
    begin
      LabelID.Caption := '-';
      LabelNama.Caption := '-';
      LabelDepartment.Caption := '-';
      LabelJabatan.Caption := '-';
      LabelJamMasuk.Caption := '-';
      LabelJamKeluar.Caption := '-';
      LabelStatusKehadiran.Caption := '-';
      showMessage('data tidak ada');
    end;
    ZQuery1.Close;
end;

procedure TFormReportAbsensiHarianUser.FormCreate(Sender: TObject);
begin
  TimePickerTanggal.Date := Now;
end;

procedure TFormReportAbsensiHarianUser.Button1Click(Sender: TObject);
begin
  FormReportAbsensiHarianUser.Close;
  FormAbsensi.Show;
end;

end.

