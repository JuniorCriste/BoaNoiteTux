unit bntunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, UTF8Process, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, ActnList, StdCtrls, Buttons, bntcunit;

type

  { Tboanoite }

  Tboanoite = class(TForm)
    cancelar: TButton;
    programar: TBitBtn;
    addTempo: TComboBox;
    acao: TRadioGroup;
    separador: TLabel;
    num1: TEdit;
    myShell: TProcessUTF8;
    num2: TEdit;
    procedure addTempoChange(Sender: TObject);
    procedure cancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure num1KeyPress(Sender: TObject; var Key: char);
    procedure num2KeyPress(Sender: TObject; var Key: char);
    procedure programarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acaoClick(Sender: TObject);
  private

  public

  end;

var
  boanoite: Tboanoite;
  horas: string;
  horasNum: integer;
  minutosNum: integer;
  addMin: integer;
  showH, showM: string;
  ordenar: string;

implementation

{$R *.lfm}

{ Tboanoite }

procedure pegarTempo;
begin
  horas:= TimeToStr(Time);
  Showmessage('Horas: ' + horas.Chars[0] + horas.Chars[1]);
  Showmessage('Minutos: ' + horas.Chars[3] + horas.Chars[4]);
end;


procedure contarTempo;
begin
  horas:= TimeToStr(Time);
  horasNum:= StrToInt(horas.Chars[0] + horas.Chars[1]);
  minutosNum:= StrToInt(horas.Chars[3] + horas.Chars[4]);
end;


procedure addUmaHora;
begin
   if horasNum < 24 then
    begin
    horasNum:= horasNum + 1
    end else
    begin
    horasNum:= 00;
    end;
end;



procedure comando;
begin
  if boanoite.acao.ItemIndex = 0 then
  begin
  ordenar:= 'shutdown ' + showH + ':' + showM;
  end else
  begin
  ordenar:= 'shutdown -r ' + showH + ':' + showM;
  end;
end;


procedure adicionarTempo;
begin
  contarTempo;
  {showmessage(inttostr(horasNum) + inttostr(minutosNum));}
  {1 Minuto}
  if  boanoite.addTempo.ItemIndex = 0 then
  begin
    addMin := 1;

    if minutosNum + 1 < 60 then
    begin
    minutosNum:= minutosNum + 1
    end else
    begin
    minutosNum:= 1 - (60- minutosNum);
    addUmaHora;
    end;

  end;

  {15 Minutos}
  if  boanoite.addTempo.ItemIndex = 1 then
  begin                              
    addMin := 15;

    if minutosNum + 15 < 60 then
    begin
    minutosNum:= minutosNum + 15
    end else
    begin
    minutosNum:= 15 - (60- minutosNum);
    addUmaHora;
    end;

  end;

  {30 Minutos}
  if  boanoite.addTempo.ItemIndex = 2 then
  begin                         
    addMin := 30;

    if minutosNum + 30 < 60 then
    begin
    minutosNum:= minutosNum + 30
    end else
    begin
    minutosNum:= 30 - (60- minutosNum);
    addUmaHora;
    end;


  end;

  {45 Minutos}
  if  boanoite.addTempo.ItemIndex = 3 then
  begin                                 
    addMin := 45;

    if minutosNum + 45 < 60 then
    begin
    minutosNum:= minutosNum + 15
    end else
    begin
    minutosNum:= 45 - (60- minutosNum);
    addUmaHora;
    end;

  end;

  {1 Hora}
  if  boanoite.addTempo.ItemIndex = 4 then
  begin
    if horasNum < 24 then
    begin
    horasNum:= horasNum + 1
    end else
    begin
    horasNum:= 00;
    end;

  end;


  showM := inttostr(minutosnum);
  showH:= intToStr(horasnum);



  {Outro Horário}
  if  boanoite.addTempo.ItemIndex = 5 then
  begin
    showH:= boanoite.num1.Text;
    showM:= boanoite.num2.Text;

  end;


  if minutosNum < 10 then
  begin
  showM := '0' + IntToStr(minutosNum);
  end;

  if horasNum < 10 then
  begin
  showH := '0' + IntToStr(minutosNum);
  end;

  comando;

end;

procedure Tboanoite.acaoClick(Sender: TObject);
begin

end;

procedure Tboanoite.FormCreate(Sender: TObject);
begin

end;

procedure ShellScript;
var
  programarShell: TstringList;
begin
  programarShell := TStringList.create;
  boanoite.myShell.CommandLine := ordenar;
  boanoite.myShell.Execute;
{  programarShell.Free;
  boanoite.myShell.Free;
 }
  {showmessage(ordenar);}

end;

procedure Tboanoite.programarClick(Sender: TObject);
begin
  if (StrToInt(num1.Text) > 23) or (StrToInt(num2.Text) >59) then
  begin
  showmessage('ERRO: O horário indicado não existe!');
  end else
  begin
  adicionarTempo;
  ShellScript;

  confirmacao.letreiro2.Caption:= showH + ':' + showM;
  if acao.ItemIndex =0 then
  begin
  confirmacao.letreiro1.Caption:= 'PROGRAMADO PARA DESLIGAR ÁS';
  end else
  begin
  confirmacao.letreiro1.Caption:= 'PROGRAMADO PARA REINICIAR ÁS';
  end;

  confirmacao.Visible:= true;
  boanoite.Visible:= false;
  end;

end;

procedure Tboanoite.addTempoChange(Sender: TObject);
begin
  if addTempo.ItemIndex = 5 then
  begin
  boanoite.Height:= 240;
  programar.Top:= 190;

  num1.Top:= 140;
  num2.Top:= 140;
  separador.Top:= 140;
  end else
  begin             
  boanoite.Height:= 190;
  programar.Top:= 140;

  num1.Top:= 190;
  num2.Top:= 190;
  separador.Top:= 190;
  end;
end;

procedure Tboanoite.cancelarClick(Sender: TObject);
begin
  ordenar:= 'shutdown -c';
  ShellScript;
  showmessage('Programação desfeita com sucesso!');

end;

procedure Tboanoite.FormShow(Sender: TObject);
begin
  acao.Visible:=true;
end;

procedure Tboanoite.num1KeyPress(Sender: TObject; var Key: char);
begin
  if  not ( Key in ['0'..'9', Chr(8)] ) then
  begin
  Key := #0
  end;
end;

procedure Tboanoite.num2KeyPress(Sender: TObject; var Key: char);
begin
  if  not ( Key in ['0'..'9', Chr(8)] ) then
  begin
  Key := #0
  end;
end;

end.

