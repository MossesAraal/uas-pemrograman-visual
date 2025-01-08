unit Unit12;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ZConnection, ZDataset;

type

  { TFormReportAbsensiBulanan }

  TFormReportAbsensiBulanan = class(TForm)
    ButtonDisplay: TButton;
    DataSource1: TDataSource;
    EditIDKaryawan: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelDepartment: TLabel;
    LabelID: TLabel;
    LabelJabatan: TLabel;
    LabelTotalIzin: TLabel;
    LabelTotalHadir: TLabel;
    LabelNama: TLabel;
    LabelTotalAbsen: TLabel;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure ButtonDisplayClick(Sender: TObject);
  private

  public

  end;

var
  FormReportAbsensiBulanan: TFormReportAbsensiBulanan;

implementation

{$R *.lfm}

{ TFormReportAbsensiBulanan }

procedure TFormReportAbsensiBulanan.ButtonDisplayClick(Sender: TObject);
begin

end;

end.

