unit Unit11;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset, DateTimePicker;

type

  { TFormDetailKaryawan }

  TFormDetailKaryawan = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditIDKaryawan: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelID: TLabel;
    LabelNama: TLabel;
    LabelEmail: TLabel;
    LabelTanggalLahir: TLabel;
    LabelJenisKelamin: TLabel;
    LabelTanggalMasuk: TLabel;
    LabelNoTelp: TLabel;
    LabelAlamat: TLabel;
    LabelDepartment: TLabel;
    LabelJabatan: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private

  public

  end;

var
  FormDetailKaryawan: TFormDetailKaryawan;

implementation
uses
  Unit2;
{$R *.lfm}

{ TFormDetailKaryawan }

procedure TFormDetailKaryawan.FormCreate(Sender: TObject);
begin

end;

procedure TFormDetailKaryawan.Label2Click(Sender: TObject);
begin

end;

procedure TFormDetailKaryawan.Button1Click(Sender: TObject);
begin
  if EditIDKaryawan.Text = '' then
    begin
      showMessage('id karyawan kosong');
    end
  else
    begin
      ZQuery1.SQL.Text := 'SELECT * FROM karyawan WHERE id = :id';
      ZQuery1.ParamByName('id').AsInteger := StrToInt(EditIDKaryawan.Text);
      ZQuery1.Open;
      LabelID.Caption := IntToStr(ZQuery1.FieldByName('id').AsInteger);
      LabelNama.Caption := ZQuery1.FieldByName('nama').AsString;
      LabelTanggalLahir.Caption := ZQuery1.FieldByName('tanggal_lahir').AsString;
      LabelJenisKelamin.Caption := ZQuery1.FieldByName('jenis_kelamin').AsString;
      LabelTanggalMasuk.Caption := ZQuery1.FieldByName('tanggal_masuk').AsString;
      LabelEmail.Caption := ZQuery1.FieldByName('email').AsString;
      LabelNoTelp.Caption := ZQuery1.FieldByName('no_telp').AsString;
      LabelAlamat.Caption := ZQuery1.FieldByName('alamat').AsString;
      LabelDepartment.Caption := ZQuery1.FieldByName('department').AsString;
      LabelJabatan.Caption := ZQuery1.FieldByName('jabatan').AsString;

      if ZQuery1.RecordCount = 0 then
        begin
          LabelID.Caption := '-';
          LabelNama.Caption := '-';
          LabelTanggalLahir.Caption := '-';
          LabelJenisKelamin.Caption := '-';
          LabelTanggalMasuk.Caption := '-';
          LabelEmail.Caption := '-';
          LabelNoTelp.Caption := '-';
          LabelAlamat.Caption := '-';
          LabelDepartment.Caption := '-';
          LabelJabatan.Caption := '-';
          showMessage('data tidak ada');
        end;
      ZQuery1.Close;
    end;
end;

procedure TFormDetailKaryawan.Button2Click(Sender: TObject);
begin
  FormDetailKaryawan.Close;
  FormMonitoringKaryawan.Show;
end;

end.

