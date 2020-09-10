program bnt;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, bntunit, bntCunit
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='Boa Noite Tux';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tboanoite, boanoite);
  Application.CreateForm(Tconfirmacao, confirmacao);
  Application.Run;
end.

