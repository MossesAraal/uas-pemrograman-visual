unit Unit6;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ZConnection, ZDataset, Unit7, Unit12, Unit13, Unit8, Unit14;

type

  { TFormMonitoringAbsensi }

  TFormMonitoringAbsensi = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ButtonReportBulanan: TButton;
    ButtonIReportAbsensiHarian: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
uses
  Unit1;
{$R *.lfm}

{ TFormMonitoringAbsensi }

procedure TFormMonitoringAbsensi.ButtonIReportAbsensiHarianClick(Sender: TObject);
begin
  FormMonitoringAbsensi.Close;
  FormReportAbsensiHarian.Show;
end;

procedure TFormMonitoringAbsensi.ButtonReportBulananClick(Sender: TObject);
begin
  FormMonitoringAbsensi.Close;
  FormReportAbsensi.Show;
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

procedure TFormMonitoringAbsensi.Button1Click(Sender: TObject);
begin
  FormMonitoringAbsensi.Close;
  FormReportAbsensi.Show;
end;

procedure TFormMonitoringAbsensi.Button2Click(Sender: TObject);
begin
  FormMonitoringAbsensi.Close;
  FormAbsensiBulanan.Show;
end;

procedure TFormMonitoringAbsensi.Button3Click(Sender: TObject);
begin
  FormAbsensi.Close;
  FormLogin.EditUsername.Text := '';
  FormLogin.EditPassword.Text := '';
  FormLogin.Show;
end;

end.

