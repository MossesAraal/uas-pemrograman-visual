unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ZDataset,
  ZConnection, DateTimePicker;

type

  { TFormUpdateKaryawan }

  TFormUpdateKaryawan = class(TForm)
    ButtonDisplay: TButton;
    DataSource1: TDataSource;
    EditIDKaryawan: TEdit;
    EditAlamat: TEdit;
    EditEmail: TEdit;
    EditNama: TEdit;
    EditNoTelp: TEdit;
    EditPassword: TEdit;
    EditUsername: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
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
    procedure ButtonDisplayClick(Sender: TObject);
    procedure RegisterClick(Sender: TObject);
  private

  public

  end;

var
  FormUpdateKaryawan: TFormUpdateKaryawan;

implementation

{$R *.lfm}

{ TFormUpdateKaryawan }

procedure TFormUpdateKaryawan.ButtonDisplayClick(Sender: TObject);
var
  tanggal_lahir:String;
begin
  ZQuery1.SQL.Text := 'SELECT * FROM karyawan WHERE id = :id';
  ZQuery1.ParamByName('id').AsInteger := StrToInt(EditIDKaryawan.Text);
  ZQuery1.Open;

  if not ZQuery1.EOF then
    begin
      EditUsername.Text := ZQuery1.FieldByName('username').AsString;
      EditPassword.Text := ZQuery1.FieldByName('password').AsString;
      EditNama.Text := ZQuery1.FieldByName('nama').AsString;

      TimePickerTanggalLahir.Date := StrToDate(ZQuery1.FieldByName('tanggal_lahir').AsString);

      if ZQuery1.FieldByName('jenis_kelamin').AsString = 'Pria' then
        RadioButtonPria.Checked := true;
      if ZQuery1.FieldByName('jenis_kelamin').AsString = 'Wanita' then
        RadioButtonWanita.Checked := true;

      TimePickerTanggalMasuk.Date := StrToDate(ZQuery1.FieldByName('tanggal_masuk').AsString);

      EditEmail.Text := ZQuery1.FieldByName('email').AsString;
      EditNoTelp.Text := ZQuery1.FieldByName('no_telp').AsString;
      EditAlamat.Text := ZQuery1.FieldByName('alamat').AsString;
    end;
  ZQuery1.Close;
end;

procedure TFormUpdateKaryawan.RegisterClick(Sender: TObject);
begin
  ZQuery1.SQL.Text := 'UPDATE karyawan SET username=:username, password=:password, nama=:nama, tanggal_lahir=:tanggal_lahir, jenis_kelamin=:jenis_kelamin, tanggal_masuk=:tanggal_masuk, email=:email, no_telp=:no_telp, alamat=:alamat WHERE id=:id';
  ZQuery1.ParamByName('username').AsString := EditUsername.Text;
  ZQuery1.ParamByName('password').AsString := EditPassword.Text;
  ZQuery1.ParamByName('nama').AsString := EditNama.Text;
  ZQuery1.ParamByName('tanggal_lahir').AsString := FormatDateTime('mm/dd/yyyy', TimePickerTanggalLahir.Date);

  if RadioButtonPria.Checked = true then
    begin
      ZQuery1.ParamByName('jenis_kelamin').AsString := 'Pria';
    end;
  if RadioButtonWanita.Checked = true then
    begin
      ZQuery1.ParamByName('jenis_kelamin').AsString := 'Wanita';
    end;

  ZQuery1.ParamByName('tanggal_masuk').AsString := FormatDateTime('mm/dd/yyyy', TimePickerTanggalMasuk.Date);
  ZQuery1.ParamByName('email').AsString := EditEmail.Text;
  ZQuery1.ParamByName('no_telp').AsString := EditNoTelp.Text;
  ZQuery1.ParamByName('alamat').AsString := EditAlamat.Text;

  ZQuery1.Open;
  showMessage('data berhasil diupdate');
  ZQuery1.Close;
end;

end.

