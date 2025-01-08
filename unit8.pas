unit Unit8;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Unit9, Unit10, Unit7, Unit12, Unit13, Unit14;

type

  { TFormAbsensi }

  TFormAbsensi = class(TForm)
    ButtonAbsensiBulanan: TButton;
    ButtonReportHarian: TButton;
    ButtonReportBulanan: TButton;
    ButtonClockIn: TButton;
    ButtonClockOut: TButton;
    Label1: TLabel;
    procedure ButtonAbsensiBulananClick(Sender: TObject);
    procedure ButtonClockInClick(Sender: TObject);
    procedure ButtonClockOutClick(Sender: TObject);
    procedure ButtonReportBulananClick(Sender: TObject);
    procedure ButtonReportHarianClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormAbsensi: TFormAbsensi;

implementation

{$R *.lfm}

{ TFormAbsensi }

procedure TFormAbsensi.FormCreate(Sender: TObject);
begin

end;

procedure TFormAbsensi.ButtonClockInClick(Sender: TObject);
begin
  FormAbsenIn.Show;
end;

procedure TFormAbsensi.ButtonAbsensiBulananClick(Sender: TObject);
begin
  FormAbsensiBulanan.Show;
end;

procedure TFormAbsensi.ButtonClockOutClick(Sender: TObject);
begin
  FormAbsenOut.Show;
end;

procedure TFormAbsensi.ButtonReportBulananClick(Sender: TObject);
begin
  FormReportAbsensi.Show;
end;

procedure TFormAbsensi.ButtonReportHarianClick(Sender: TObject);
begin
  FormReportAbsensiHarian.Show;
end;

end.

