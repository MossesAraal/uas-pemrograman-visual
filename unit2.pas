unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  Menus, ZConnection, ZDataset, Unit4, Unit5, Unit6, Unit11, Unit15;

type

  { TFormMonitoringKaryawan }

  TFormMonitoringKaryawan = class(TForm)
    ButtonSignOut: TButton;
    ButtonDetailKaryawan: TButton;
    ButtonMonitoringAbsensi: TButton;
    ButtonDelete: TButton;
    ButtonTambah: TButton;
    ButtonUpdate: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure ButtonDetailKaryawanClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonMonitoringAbsensiClick(Sender: TObject);
    procedure ButtonSignOutClick(Sender: TObject);
    procedure ButtonTambahClick(Sender: TObject);
    procedure ButtonRefreshClick(Sender: TObject);
    procedure ButtonUpdateClick(Sender: TObject);
    procedure EditDeleteChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  FormMonitoringKaryawan: TFormMonitoringKaryawan;

implementation
uses
  Unit1;
{$R *.lfm}

{ TFormMonitoringKaryawan }

procedure TFormMonitoringKaryawan.Label1Click(Sender: TObject);
begin

end;

procedure TFormMonitoringKaryawan.ButtonTambahClick(Sender: TObject);
begin
  FormMonitoringKaryawan.Close;
  FormTambahKaryawan.Show;
end;

procedure TFormMonitoringKaryawan.ButtonDeleteClick(Sender: TObject);
begin
  FormMonitoringKaryawan.Close;
  FormDeleteKaryawan.Show;
end;

procedure TFormMonitoringKaryawan.ButtonDetailKaryawanClick(Sender: TObject);
begin
  FormMonitoringKaryawan.Close;
  FormDetailKaryawan.Show;
end;

procedure TFormMonitoringKaryawan.ButtonMonitoringAbsensiClick(Sender: TObject);
begin
  FormMonitoringKaryawan.Close;
  FormMonitoringAbsensi.Show;
end;

procedure TFormMonitoringKaryawan.ButtonSignOutClick(Sender: TObject);
begin
  FormMonitoringKaryawan.Close;
  FormLogin.EditUsername.Text := '';
  FormLogin.EditPassword.Text := '';
  FormLogin.Show;
end;

procedure TFormMonitoringKaryawan.ButtonRefreshClick(Sender: TObject);
begin
  if ZQuery1.Active then
    ZQuery1.Close;

  ZQuery1.SQL.Text := 'SELECT * FROM karyawan';
  ZQuery1.Active := true;
end;

procedure TFormMonitoringKaryawan.ButtonUpdateClick(Sender: TObject);
begin
  FormMonitoringKaryawan.Close;
  FormUpdateKaryawan.show;
end;

procedure TFormMonitoringKaryawan.EditDeleteChange(Sender: TObject);
begin

end;

procedure TFormMonitoringKaryawan.FormCreate(Sender: TObject);
begin

end;

end.

