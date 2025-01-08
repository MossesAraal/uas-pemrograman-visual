unit Unit10;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DateTimePicker, ZConnection, ZDataset;

type

  { TFormAbsenOut }

  TFormAbsenOut = class(TForm)
    ButtonPulang: TButton;
    DataSource1: TDataSource;
    EditIDKaryawan: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure ButtonPulangClick(Sender: TObject);
  private

  public

  end;

var
  FormAbsenOut: TFormAbsenOut;

implementation

{$R *.lfm}

{ TFormAbsenOut }

procedure TFormAbsenOut.ButtonPulangClick(Sender: TObject);
var
  idKaryawan, lastID, total_hadir, total_absen, total_izin, laporan_absen_id: Integer;
begin
  try
    // Ambil nilai ID Karyawan dari form
    if Trim(EditIDKaryawan.Text) = '' then
      raise Exception.Create('ID Karyawan tidak boleh kosong.');

    idKaryawan := StrToInt(EditIDKaryawan.Text); // Konversi teks menjadi integer

    // Update jam_keluar pada absensi terakhir yang ditemukan berdasarkan absen_id dan id_karyawan
    ZQuery1.SQL.Text :=
        'UPDATE absensi ' +
        'SET jam_keluar = :jam_keluar ' +
        'WHERE tanggal = :tanggal AND id = :id';
    ZQuery1.ParamByName('tanggal').AsString := FormatDateTime('mm/dd/yyyy', Now);
    ZQuery1.ParamByName('id').AsInteger := idKaryawan;  // Pastikan ID Karyawan sesuai
    ZQuery1.ParamByName('jam_keluar').AsDateTime := Now; // Waktu sekarang

    ZQuery1.ExecSQL; // Eksekusi query update
    ShowMessage('Jam Keluar berhasil diperbarui!');

    ZQuery1.SQL.Text := 'select * from absensi order by jam_keluar desc limit 1';
    ZQuery1.Open;
    lastID := ZQuery1.FieldByName('absen_id').AsInteger;
    ZQuery1.Close;

    ZQuery1.SQL.Text := 'select count(status_kehadiran) from absensi where status_kehadiran = :status_kehadiran AND id = :id;';
    ZQuery1.ParamByName('status_kehadiran').AsString := 'Hadir';
    ZQuery1.ParamByName('id').AsInteger := idKaryawan;
    ZQuery1.ParamByName('periode_bulan').AsString := FormatDateTime('mm', Now);
    ZQuery1.Open;
    total_hadir := ZQuery1.FieldByName('count').AsInteger;
    ZQuery1.Close;

    ZQuery1.SQL.Text := 'select count(status_kehadiran) from absensi where status_kehadiran = :status_kehadiran AND id = :id;';
    ZQuery1.ParamByName('status_kehadiran').AsString := 'Absen';
    ZQuery1.ParamByName('id').AsInteger := idKaryawan;
    ZQuery1.Open;
    total_absen := ZQuery1.FieldByName('count').AsInteger;
    ZQuery1.Close;

    ZQuery1.SQL.Text := 'select count(status_kehadiran) from absensi where status_kehadiran = :status_kehadiran AND id = :id;';
    ZQuery1.ParamByName('status_kehadiran').AsString := 'Izin';
    ZQuery1.ParamByName('id').AsInteger := idKaryawan;
    ZQuery1.Open;
    total_izin := ZQuery1.FieldByName('count').AsInteger;
    ZQuery1.Close;

    ZQuery1.SQL.Text := 'INSERT INTO laporan_absensi_karyawan(absen_id, periode_bulan, total_hadir, total_absen, total_izin, tanggal) ' +
    'VALUES(:absen_id, :periode_bulan, :total_hadir, :total_absen, :total_izin, :tanggal)';
    ZQuery1.ParamByName('absen_id').AsInteger := lastID;
    ZQuery1.ParamByName('periode_bulan').AsString := FormatDateTime('mmmm', Now);
    ZQuery1.ParamByName('total_hadir').AsInteger := total_hadir;
    ZQuery1.ParamByName('total_absen').AsInteger := total_absen;
    ZQuery1.ParamByName('total_izin').AsInteger := total_izin;
    ZQuery1.ParamByName('tanggal').AsString := FormatDateTime('mm/dd/yyyy', Now);
    ZQuery1.ExecSQL;

    ZQuery1.SQL.Text := 'select * from laporan_absensi_karyawan order by laporan_absen_id desc limit 1';
    ZQuery1.Open;
    laporan_absen_id := ZQuery1.FieldByName('laporan_absen_id').AsInteger;
    ZQuery1.Close;

    ZQuery1.SQL.Text := 'delete from laporan_absensi_karyawan where absen_id = :absen_id and laporan_absen_id < :laporan_absen_id and tanggal = :tanggal';
    ZQuery1.ParamByName('absen_id').AsInteger := lastID;
    ZQuery1.ParamByName('laporan_absen_id').AsInteger := laporan_absen_id;
    ZQuery1.ParamByName('tanggal').AsString := FormatDateTime('mm/dd/yyyy', Now);
    ZQuery1.ExecSQL;

  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

end.

