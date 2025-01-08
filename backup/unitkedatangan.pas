unit UnitAbsenMasuk;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  ZConnection, ZDataset;

type

  { TFormAbsenDatang }

  TFormAbsenDatang = class(TForm)
    ButtonAbsenDatang: TButton;
    ComboBoxStatusKehadiran: TComboBox;
    DataSource1: TDataSource;
    EditIDKaryawan: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure ButtonAbsenDatangClick(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  FormAbsenDatang: TFormAbsenDatang;

implementation

{$R *.lfm}

{ TFormAbsenDatang }

procedure TFormAbsenDatang.ButtonAbsenDatangClick(Sender: TObject);
var
  idKaryawan: Integer;
  statusKehadiran: string;
begin
  try
    // Ambil nilai ID Karyawan dan Status Kehadiran dari form
    if Trim(EditIDKaryawan.Text) = '' then
      raise Exception.Create('ID Karyawan tidak boleh kosong.');
    if ComboBoxStatusKehadiran.Text = '' then
      raise Exception.Create('Status Kehadiran harus dipilih.');

    idKaryawan := StrToInt(EditIDKaryawan.Text); // Konversi teks menjadi integer
    statusKehadiran := ComboBoxStatusKehadiran.Text;      // Ambil status kehadiran

    // Cek koneksi database
    if not ZConnection1.Connected then
      raise Exception.Create('Koneksi ke database gagal.');

    // Masukkan data absen ke tabel
    ZQuery1.SQL.Text :=
      'INSERT INTO absensi (id, jam_masuk, status_kehadiran) ' +
      'VALUES (:id, :jam_masuk, :status_kehadiran)';
    ZQuery1.ParamByName('id').AsInteger := idKaryawan;
    ZQuery1.ParamByName('jam_masuk').AsDateTime := Now; // Menggunakan waktu saat ini
    ZQuery1.ParamByName('status_kehadiran').AsString := statusKehadiran;

    ZQuery1.ExecSQL; // Jalankan query

    ShowMessage('Absen berhasil!');

    // Refresh DBGrid
    ZQuery1.SQL.Text := 'SELECT  jam_masuk, status_kehadiran FROM absen WHERE id_karyawan = :id_karyawan ORDER BY absen_id DESC;';
    ZQuery1.Open;

  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TFormAbsenDatang.ZConnection1AfterConnect(Sender: TObject);
begin

end;

end.

