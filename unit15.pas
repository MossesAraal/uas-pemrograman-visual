unit Unit15;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, ZDataset;

type

  { TFormDeleteKaryawan }

  TFormDeleteKaryawan = class(TForm)
    Button1: TButton;
    ButtonBatal: TButton;
    DataSource1: TDataSource;
    EditDelete: TEdit;
    Label3: TLabel;
    ZQuery1: TZQuery;
    procedure Button1Click(Sender: TObject);
    procedure ButtonBatalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormDeleteKaryawan: TFormDeleteKaryawan;

implementation
uses
  Unit2;
{$R *.lfm}

{ TFormDeleteKaryawan }

procedure TFormDeleteKaryawan.Button1Click(Sender: TObject);
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
      FormDeleteKaryawan.Close;
      FormMonitoringKaryawan.ZQuery1.Refresh;
      FormMonitoringKaryawan.Show;
    end;
end;

procedure TFormDeleteKaryawan.ButtonBatalClick(Sender: TObject);
begin
  FormDeleteKaryawan.Close;
  FormMonitoringKaryawan.Show;
end;

procedure TFormDeleteKaryawan.FormCreate(Sender: TObject);
begin

end;

end.

