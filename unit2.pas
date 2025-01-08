unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  Menus, ZConnection, ZDataset, Unit4, Unit5, Unit6, Unit11;

type

  { TFormMonitoringKaryawan }

  TFormMonitoringKaryawan = class(TForm)
    ButtonDetailKaryawan: TButton;
    ButtonMonitoringAbsensi: TButton;
    ButtonDelete: TButton;
    ButtonTambah: TButton;
    ButtonRefresh: TButton;
    ButtonUpdate: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    EditDelete: TEdit;
    Label1: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure ButtonDetailKaryawanClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonMonitoringAbsensiClick(Sender: TObject);
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

{$R *.lfm}

{ TFormMonitoringKaryawan }

procedure TFormMonitoringKaryawan.Label1Click(Sender: TObject);
begin

end;

procedure TFormMonitoringKaryawan.ButtonTambahClick(Sender: TObject);
begin
  FormTambahKaryawan.Show;
end;

procedure TFormMonitoringKaryawan.ButtonDeleteClick(Sender: TObject);
begin
  if EditDelete.Text = '' then
    begin
      showMessage('id karyawan kosong');
    end
  else
    begin
      ZQuery1.SQL.Text := 'DELETE FROM karyawan WHERE id = :id';
      ZQuery1.ParamByName('id').AsInteger := StrToInt(EditDelete.Text);
      ZQuery1.ExecSQL;
      ZQuery1.Close;
      showMessage('data berhasil dihapus');
    end;
end;

procedure TFormMonitoringKaryawan.ButtonDetailKaryawanClick(Sender: TObject);
begin
  FormDetailKaryawan.Show;
end;

procedure TFormMonitoringKaryawan.ButtonMonitoringAbsensiClick(Sender: TObject);
begin
  FormMonitoringAbsensi.Show;
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
  FormUpdateKaryawan.show;
end;

procedure TFormMonitoringKaryawan.EditDeleteChange(Sender: TObject);
begin

end;

procedure TFormMonitoringKaryawan.FormCreate(Sender: TObject);
begin
  ZQuery1.SQL.Text := 'SELECT * FROM karyawan';
  ZQuery1.Active := true;
end;

end.

