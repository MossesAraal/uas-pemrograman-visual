unit Unit9;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset;

type

  { TFormAbsenIn }

  TFormAbsenIn = class(TForm)
    ButtonAbsenIn: TButton;
    ComboBoxStatusKehadiran: TComboBox;
    DataSource1: TDataSource;
    EditIDKaryawan: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure ButtonAbsenInClick(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender: TObject);
  private

  public

  end;

var
  FormAbsenIn: TFormAbsenIn;

implementation

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
        ZQuery1.ParamByName('status_kehadiran').AsString := statusKehadiran;
        ZQuery1.ParamByName('tanggal').AsString := FormatDateTime('mm/dd/yyyy', Now);

        ZQuery1.ExecSQL; // Jalankan query

        ShowMessage('Absen berhasil pada pukul ' + FormatDateTime('hh:nn:ss', Now));
      end;

  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

end.

