unit Unit7;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset, DateTimePicker;

type

  { TFormReportAbsensiHarian }

  TFormReportAbsensiHarian = class(TForm)
    ButtonDisplay: TButton;
    DataSource1: TDataSource;
    EditIDKaryawan: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    LabelID: TLabel;
    LabelNama: TLabel;
    LabelDepartment: TLabel;
    LabelJabatan: TLabel;
    LabelJamMasuk: TLabel;
    LabelJamKeluar: TLabel;
    LabelStatusKehadiran: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    TimePickerTanggal: TDateTimePicker;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure ButtonDisplayClick(Sender: TObject);
    procedure ButtonInputClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabelNamaClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  FormReportAbsensiHarian: TFormReportAbsensiHarian;

implementation

{$R *.lfm}

{ TFormReportAbsensiHarian }

procedure TFormReportAbsensiHarian.Button1Click(Sender: TObject);
begin

end;

procedure TFormReportAbsensiHarian.ButtonDisplayClick(Sender: TObject);
begin
  if EditIDKaryawan.Text = '' then
    begin
      showMessage('id karyawan kosong');
    end
  else
    begin
      ZQuery1.SQL.Text := 'SELECT k.nama, k.id, k.department, k.jabatan, a.jam_masuk, a.jam_keluar, a.status_kehadiran, a.tanggal FROM absensi AS a INNER JOIN karyawan AS k ON a.id = k.id WHERE a.id = :id AND a.tanggal = :tanggal';
      ZQuery1.ParamByName('id').AsInteger := StrToInt(EditIDKaryawan.Text);
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
        end;
      ZQuery1.Close;
    end;
end;

procedure TFormReportAbsensiHarian.ButtonInputClick(Sender: TObject);
begin

end;

procedure TFormReportAbsensiHarian.FormCreate(Sender: TObject);
begin
  TimePickerTanggal.Date := Now;
end;

procedure TFormReportAbsensiHarian.LabelNamaClick(Sender: TObject);
begin

end;

procedure TFormReportAbsensiHarian.Label3Click(Sender: TObject);
begin

end;

procedure TFormReportAbsensiHarian.ZConnection1AfterConnect(Sender: TObject);
begin

end;

end.

