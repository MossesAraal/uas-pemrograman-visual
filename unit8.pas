unit Unit8;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Unit9, Unit10, Unit7, Unit12, Unit13, Unit14, Unit16, Unit17, Unit18;

type

  { TFormAbsensi }

  TFormAbsensi = class(TForm)
    ButtonSignOut: TButton;
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
    procedure ButtonSignOutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormAbsensi: TFormAbsensi;

implementation
uses
  Unit1;

{$R *.lfm}

{ TFormAbsensi }

procedure TFormAbsensi.FormCreate(Sender: TObject);
begin

end;

procedure TFormAbsensi.ButtonClockInClick(Sender: TObject);
begin
  FormAbsenIn.Show;
  FormAbsensi.Close;
end;

procedure TFormAbsensi.ButtonClockOutClick(Sender: TObject);
begin
  FormAbsenOut.Show;
  FormAbsensi.Close;
end;

procedure TFormAbsensi.ButtonSignOutClick(Sender: TObject);
begin
  FormAbsensi.Close;
  FormLogin.EditUsername.Text := '';
  FormLogin.EditPassword.Text := '';
  FormLogin.Show;
end;

procedure TFormAbsensi.ButtonReportHarianClick(Sender: TObject);
begin
  FormReportAbsensiHarianUser.Show;
  FormAbsensi.Close;
end;

procedure TFormAbsensi.ButtonAbsensiBulananClick(Sender: TObject);
begin
  FormAbsensiBulananUser.Show;
  FormAbsensi.Close;
end;

procedure TFormAbsensi.ButtonReportBulananClick(Sender: TObject);
begin
  FormReportAbsensiUser.Show;
  FormAbsensi.Close;
end;

end.

