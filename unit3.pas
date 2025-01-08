unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DBDateTimePicker, DateTimePicker, ZDataset, ZConnection, Unit2, Unit8;

type

  { TFormRegister }

  TFormRegister = class(TForm)
    Bagian: TComboBox;
    Jabatan: TComboBox;
    DataSource1: TDataSource;
    EditEmail: TEdit;
    EditNoTelp: TEdit;
    EditAlamat: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RadioButtonPria: TRadioButton;
    RadioButtonWanita: TRadioButton;
    TimePickerTanggalLahir: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Register: TButton;
    EditNama: TEdit;
    EditUsername: TEdit;
    EditPassword: TEdit;
    TimePickerTanggalMasuk: TDateTimePicker;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure RegisterClick(Sender: TObject);
  private

  public

  end;

var
  FormRegister: TFormRegister;

implementation

{$R *.lfm}

{ TFormRegister }

procedure TFormRegister.RegisterClick(Sender: TObject);
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
      ZQuery1.Close;

      showMessage('karyawan berhasil ditambahkan');
      if department = 'HRD' then
        begin
          FormMonitoringKaryawan.Show;
        end
      else
        FormAbsensi.Show;
    end;
end;

procedure TFormRegister.DataSource1DataChange(Sender: TObject; Field: TField);
begin

end;

procedure TFormRegister.FormCreate(Sender: TObject);
begin
  TimePickerTanggalLahir.Date := StrToDate(FormatDateTime('mm/dd/yyyy', Now));
  TimePickerTanggalMasuk.Date := StrToDate(FormatDateTime('mm/dd/yyyy', Now));
end;

procedure TFormRegister.Label12Click(Sender: TObject);
begin

end;

end.

