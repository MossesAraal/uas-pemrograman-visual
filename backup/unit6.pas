unit Unit6;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ZConnection, ZDataset, Unit7, Unit12;

type

  { TFormMonitoringAbsensi }

  TFormMonitoringAbsensi = class(TForm)
    ButtonReportBulanan: TButton;
    ButtonIReportAbsensiHarian: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure ButtonRefreshClick(Sender: TObject);
    procedure ButtonIReportAbsensiHarianClick(Sender: TObject);
    procedure ButtonReportBulananClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  FormMonitoringAbsensi: TFormMonitoringAbsensi;

implementation

{$R *.lfm}

{ TFormMonitoringAbsensi }

procedure TFormMonitoringAbsensi.ButtonIReportAbsensiHarianClick(Sender: TObject);
begin
  FormReportAbsensiHarian.Show;
end;

procedure TFormMonitoringAbsensi.ButtonReportBulananClick(Sender: TObject);
begin
  FormReportAbsensiBulanan.Show;
end;

procedure TFormMonitoringAbsensi.FormCreate(Sender: TObject);
begin
  if ZConnection1.Connected = true then
    begin
      ZQuery1.SQL.Text := 'SELECT k.nama, k.id, k.department, k.jabatan, a.jam_masuk, a.jam_keluar, a.status_kehadiran, a.tanggal FROM absensi AS a INNER JOIN karyawan AS k ON a.id = k.id;';
      ZQuery1.Open;
    end;
end;

procedure TFormMonitoringAbsensi.FormShow(Sender: TObject);
begin

end;

procedure TFormMonitoringAbsensi.ButtonRefreshClick(Sender: TObject);
begin

end;

end.

