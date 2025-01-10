unit Unit13;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset;

type

  { TFormReportAbsensi }

  TFormReportAbsensi = class(TForm)
    Button1: TButton;
    ButtonDisplay: TButton;
    DataSource1: TDataSource;
    EditIDKaryawan: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormReportAbsensi: TFormReportAbsensi;

implementation
uses
  Unit8, Unit1;

{$R *.lfm}

{ TFormReportAbsensi }

procedure TFormReportAbsensi.FormCreate(Sender: TObject);
begin

end;

procedure TFormReportAbsensi.ButtonDisplayClick(Sender: TObject);
begin
  if EditIDKaryawan.Text = '' then
    begin
      showMessage('id karyawan kosong');
    end
  else
    begin
      ZQuery1.SQL.Text := 'SELECT * FROM absensi AS a INNER JOIN karyawan AS k ON a.id = k.id ' +
      'INNER JOIN laporan_absensi_karyawan AS lak ON a.absen_id = lak.absen_id WHERE a.id = :id ORDER BY lak.total_hadir DESC LIMIT 1';
      ZQuery1.ParamByName('id').AsInteger := StrToInt(EditIDKaryawan.Text);
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
end;

procedure TFormReportAbsensi.Button1Click(Sender: TObject);
begin
  FormReportAbsensi.Close;
  FormMonitoringAbsensi.show;
end;

end.

