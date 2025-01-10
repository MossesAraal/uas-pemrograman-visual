unit Unit17;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset;

type

  { TFormAbsensiBulananUser }

  TFormAbsensiBulananUser = class(TForm)
    ButtonDisplay: TButton;
    ButtonKembali: TButton;
    ComboBoxBulan: TComboBox;
    ComboBoxTahun: TComboBox;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelDepartment: TLabel;
    LabelID: TLabel;
    LabelJabatan: TLabel;
    LabelNama: TLabel;
    LabelTotalAbsen: TLabel;
    LabelTotalHadir: TLabel;
    LabelTotalIzin: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure ButtonDisplayClick(Sender: TObject);
    procedure ButtonKembaliClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormAbsensiBulananUser: TFormAbsensiBulananUser;

implementation
Uses
  Unit1, Unit8;

{$R *.lfm}

{ TFormAbsensiBulananUser }

procedure TFormAbsensiBulananUser.FormCreate(Sender: TObject);
begin

end;

procedure TFormAbsensiBulananUser.ButtonDisplayClick(Sender: TObject);
var
  bulan:String;
  total_hadir, total_absen, total_izin, idKaryawan:Integer;
begin
  ZQuery1.SQL.Text := 'SELECT id FROM karyawan WHERE username = :username AND password = :password';
  ZQuery1.ParamByName('username').AsString := FormLogin.EditUsername.Text;
  ZQuery1.ParamByName('password').AsString := FormLogin.EditPassword.Text;
  ZQuery1.Open;
  idKaryawan := ZQuery1.FieldByName('id').AsInteger;
  ZQuery1.Close;

  if ComboBoxBulan.Text = 'January' then
   begin
     bulan := '01';
   end
  else if ComboBoxBulan.Text = 'February' then
   begin
     bulan := '02';
   end
  else if ComboBoxBulan.Text = 'March' then
   begin
     bulan := '03';
   end
  else if ComboBoxBulan.Text = 'April' then
   begin
     bulan := '04';
   end
  else if ComboBoxBulan.Text = 'May' then
   begin
     bulan := '05';
   end
  else if ComboBoxBulan.Text = 'June' then
   begin
     bulan := '06';
   end
  else if ComboBoxBulan.Text = 'July' then
   begin
     bulan := '07';
   end
  else if ComboBoxBulan.Text = 'August' then
   begin
     bulan := '08';
   end
  else if ComboBoxBulan.Text = 'September' then
   begin
     bulan := '09';
   end
  else if ComboBoxBulan.Text = 'October' then
   begin
     bulan := '10';
   end
  else if ComboBoxBulan.Text = 'November' then
   begin
     bulan := '11';
   end
  else if ComboBoxBulan.Text = 'December' then
   begin
     bulan := '12';
   end;

  if ComboBoxBulan.Text = '' then
    begin
      showMessage('bulan belum dipilih');
    end
  else if ComboBoxTahun.Text = '' then
    begin
      showMessage('tahun belum dipilih');
    end
  else
   begin
     ZQuery1.SQL.Text := 'select count(id) from absensi where tanggal like :tanggal and tanggal like :tahun and status_kehadiran = :status_kehadiran and id = :id';
     ZQuery1.ParamByName('tanggal').AsString := bulan + '%';
     ZQuery1.ParamByName('status_kehadiran').AsString := 'Hadir';
     ZQuery1.ParamByName('id').AsInteger := idKaryawan;
     ZQuery1.ParamByName('tahun').AsString := '%/' + ComboBoxTahun.Text + '%';
     ZQuery1.Open;
     total_hadir := ZQuery1.FieldByName('count').AsInteger;
     ZQuery1.Close;

     ZQuery1.SQL.Text := 'select count(id) from absensi where tanggal like :tanggal and tanggal like :tahun and status_kehadiran = :status_kehadiran and id = :id';
     ZQuery1.ParamByName('tanggal').AsString := bulan + '%';
     ZQuery1.ParamByName('status_kehadiran').AsString := 'Absen';
     ZQuery1.ParamByName('id').AsInteger := idKaryawan;
     ZQuery1.ParamByName('tahun').AsString := '%/' + ComboBoxTahun.Text + '%';
     ZQuery1.Open;
     total_absen := ZQuery1.FieldByName('count').AsInteger;
     ZQuery1.Close;

     ZQuery1.SQL.Text := 'select count(id) from absensi where tanggal like :tanggal and tanggal like :tahun and status_kehadiran = :status_kehadiran and id = :id';
     ZQuery1.ParamByName('tanggal').AsString := bulan + '%';
     ZQuery1.ParamByName('status_kehadiran').AsString := 'Izin';
     ZQuery1.ParamByName('id').AsInteger := idKaryawan;
     ZQuery1.ParamByName('tahun').AsString := '%/' + ComboBoxTahun.Text + '%';
     ZQuery1.Open;
     total_izin := ZQuery1.FieldByName('count').AsInteger;
     ZQuery1.Close;

     ZQuery1.SQL.Text := 'select * from karyawan where id = :id';
     ZQuery1.ParamByName('id').AsInteger := idKaryawan;
     ZQuery1.Open;
     LabelID.Caption := IntToStr(ZQuery1.FieldByName('id').AsInteger);
     LabelNama.Caption := ZQuery1.FieldByName('nama').AsString;
     LabelDepartment.Caption := ZQuery1.FieldByName('department').AsString;
     LabelJabatan.Caption := ZQuery1.FieldByName('jabatan').AsString;
     LabelTotalHadir.Caption := IntToStr(total_hadir);
     LabelTotalAbsen.Caption := IntToStr(total_absen);
     LabelTotalIzin.Caption := IntToStr(total_izin);

     if ZQuery1.RecordCount = 0 then
       begin
         LabelID.Caption := '-';
         LabelNama.Caption := '-';
         LabelDepartment.Caption := '-';
         LabelJabatan.Caption := '-';
         LabelTotalHadir.Caption := '-';
         LabelTotalAbsen.Caption := '-';
         LabelTotalIzin.Caption := '-';
         showMessage('data tidak ada');
       end;
      ZQuery1.Close;
   end;
end;

procedure TFormAbsensiBulananUser.ButtonKembaliClick(Sender: TObject);
begin
  FormAbsensiBulananUser.Close;
  FormAbsensi.Show;
end;

end.

