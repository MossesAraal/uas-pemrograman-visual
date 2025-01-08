unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset, DateTimePicker;

type

  { TFormTambahKaryawan }

  TFormTambahKaryawan = class(TForm)
    Bagian: TComboBox;
    DataSource1: TDataSource;
    EditAlamat: TEdit;
    EditEmail: TEdit;
    EditNama: TEdit;
    EditNoTelp: TEdit;
    EditPassword: TEdit;
    EditUsername: TEdit;
    Jabatan: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RadioButtonPria: TRadioButton;
    RadioButtonWanita: TRadioButton;
    Register: TButton;
    TimePickerTanggalLahir: TDateTimePicker;
    TimePickerTanggalMasuk: TDateTimePicker;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure FormCreate(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure RegisterClick(Sender: TObject);
  private

  public

  end;

var
  FormTambahKaryawan: TFormTambahKaryawan;

implementation

{$R *.lfm}

{ TFormTambahKaryawan }

procedure TFormTambahKaryawan.Label14Click(Sender: TObject);
begin

end;

procedure TFormTambahKaryawan.FormCreate(Sender: TObject);
begin
  TimePickerTanggalLahir.Date := StrToDate(FormatDateTime('mm/dd/yyyy', Now));
  TimePickerTanggalMasuk.Date := StrToDate(FormatDateTime('mm/dd/yyyy', Now));
end;

procedure TFormTambahKaryawan.Label6Click(Sender: TObject);
begin

end;

procedure TFormTambahKaryawan.RegisterClick(Sender: TObject);
var
  username, password, nama, tanggal_lahir, jenis_kelamin, tanggal_masuk, email, no_telp, alamat, department, title:String;
begin
  username := EditUsername.Text;
  password := EditPassword.Text;
  nama := EditNama.Text;
  tanggal_lahir := FormatDateTime('mm/dd/yyyy', TimePickerTanggalLahir.Date);

  if RadioButtonPria.Checked = true then
    begin
      jenis_kelamin := 'Pria';
    end;
  if RadioButtonWanita.Checked = true then
    begin
      jenis_kelamin := 'Wanita';
    end;

  tanggal_masuk := FormatDateTime('mm/dd/yyyy', TimePickerTanggalMasuk.Date);
  email := EditEmail.Text;
  no_telp := EditNoTelp.Text;
  alamat := EditAlamat.Text;
  department := Bagian.Text;
  title := Jabatan.Text;

  if ZConnection1.Connected = true then
    begin
      ZQuery1.SQL.Text := 'INSERT INTO karyawan(username, password, nama, tanggal_lahir, jenis_kelamin, tanggal_masuk, email, no_telp, alamat, department, jabatan) VALUES(:username, :password, :nama, :tanggal_lahir, :jenis_kelamin, :tanggal_masuk, :email, :no_telp, :alamat, :department, :jabatan)';
      ZQuery1.ParamByName('username').AsString := username;
      ZQuery1.ParamByName('password').AsString := password;
      ZQuery1.ParamByName('nama').AsString := nama;
      ZQuery1.ParamByName('tanggal_lahir').AsString := tanggal_lahir;
      ZQuery1.ParamByName('jenis_kelamin').AsString := jenis_kelamin;
      ZQuery1.ParamByName('tanggal_masuk').AsString := tanggal_masuk;
      ZQuery1.ParamByName('email').AsString := email;
      ZQuery1.ParamByName('no_telp').AsString := no_telp;
      ZQuery1.ParamByName('alamat').AsString := alamat;
      ZQuery1.ParamByName('department').AsString := department;
      ZQuery1.ParamByName('jabatan').AsString := title;

      ZQuery1.ExecSQL;

      ZQuery1.SQL.Text := 'SELECT k.id, k.username, k.nama, k.department, k.jabatan, a.jam_masuk, a.jam_keluar, a.status_kehadiran FROM karyawan AS k INNER JOIN absensi AS a ON k.id = a.id';
      ZQuery1.Open;
      ZQuery1.Active := true;
      ZQuery1.Close;

      showMessage('karyawan berhasil ditambahkan');
    end;
end;

end.

