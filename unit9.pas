unit Unit9;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset;

type

  { TFormAbsenIn }

  TFormAbsenIn = class(TForm)
    ButtonKembali: TButton;
    ButtonAbsenIn: TButton;
    ComboBoxStatusKehadiran: TComboBox;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label5: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure ButtonAbsenInClick(Sender: TObject);
    procedure ButtonKembaliClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  FormAbsenIn: TFormAbsenIn;

implementation
uses
  Unit1, Unit8;
{$R *.lfm}

{ TFormAbsenIn }

procedure TFormAbsenIn.ZConnection1AfterConnect(Sender: TObject);
begin

end;

procedure TFormAbsenIn.ButtonAbsenInClick(Sender: TObject);
var
  idKaryawan: Integer;
  statusKehadiran: string;
begin
  try
    if ComboBoxStatusKehadiran.Text = '' then
      begin
        ShowMessage('status kehadiran belum dipilih');
      end
    else
    begin
      ZQuery1.SQL.Text := 'SELECT id FROM karyawan WHERE username = :username AND password = :password';
      ZQuery1.ParamByName('username').AsString := FormLogin.EditUsername.Text;
      ZQuery1.ParamByName('password').AsString := FormLogin.EditPassword.Text;
      ZQuery1.Open;
      idKaryawan := ZQuery1.FieldByName('id').AsInteger;
      ZQuery1.Close;

      ZQuery1.SQL.Text := 'SELECT * FROM absensi WHERE id = :id AND tanggal = :tanggal';
      ZQuery1.ParamByName('id').AsInteger := idKaryawan;
      ZQuery1.ParamByName('tanggal').AsString := FormatDateTime('mm/dd/yyyy', Now);
      ZQuery1.Open;
      if ZQuery1.RecordCount > 0 then
        begin
          showMessage('absensi sudah dilakukan');
        end
      else
        begin
          ZQuery1.SQL.Text := 'INSERT INTO absensi (id, jam_masuk, status_kehadiran, tanggal) ' +
          'VALUES (:id, :jam_masuk, :status_kehadiran, :tanggal)';
          ZQuery1.ParamByName('id').AsInteger := idKaryawan;
          ZQuery1.ParamByName('jam_masuk').AsDateTime := Now; // Menggunakan waktu saat ini
          ZQuery1.ParamByName('status_kehadiran').AsString := ComboBoxStatusKehadiran.Text;
          ZQuery1.ParamByName('tanggal').AsString := FormatDateTime('mm/dd/yyyy', Now);

          ZQuery1.ExecSQL; // Jalankan query

          ShowMessage('absen in berhasil pada pukul ' + FormatDateTime('hh:nn:ss', Now));

        end;
    end;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TFormAbsenIn.ButtonKembaliClick(Sender: TObject);
begin
  FormAbsenIn.Close;
  FormAbsensi.show;
end;

procedure TFormAbsenIn.FormCreate(Sender: TObject);
begin

end;

procedure TFormAbsenIn.FormShow(Sender: TObject);
begin

end;

end.

