program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, unit1, zcomponent, datetimectrls, unit2, unit3, unit4, unit5, unit6,
  unit7, unit8, unit9, unit10, unit11, unit12, unit13, unit14, unit15, unit16,
  unit17, unit18
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMonitoringKaryawan, FormMonitoringKaryawan);
  Application.CreateForm(TFormRegister, FormRegister);
  Application.CreateForm(TFormTambahKaryawan, FormTambahKaryawan);
  Application.CreateForm(TFormUpdateKaryawan, FormUpdateKaryawan);
  Application.CreateForm(TFormMonitoringAbsensi, FormMonitoringAbsensi);
  Application.CreateForm(TFormReportAbsensiHarian, FormReportAbsensiHarian);
  Application.CreateForm(TFormAbsensi, FormAbsensi);
  Application.CreateForm(TFormAbsenIn, FormAbsenIn);
  Application.CreateForm(TFormAbsenOut, FormAbsenOut);
  Application.CreateForm(TFormDetailKaryawan, FormDetailKaryawan);
  Application.CreateForm(TFormReportAbsensiBulanan, FormReportAbsensiBulanan);
  Application.CreateForm(TFormReportAbsensi, FormReportAbsensi);
  Application.CreateForm(TFormAbsensiBulanan, FormAbsensiBulanan);
  Application.CreateForm(TFormDeleteKaryawan, FormDeleteKaryawan);
  Application.CreateForm(TFormReportAbsensiHarianUser,
    FormReportAbsensiHarianUser);
  Application.CreateForm(TFormAbsensiBulananUser, FormAbsensiBulananUser);
  Application.CreateForm(TFormReportAbsensiUser, FormReportAbsensiUser);
  Application.Run;
end.

