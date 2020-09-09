unit bntunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, UTF8Process, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, ActnList, StdCtrls, Buttons;

type

  { Tboanoite }

  Tboanoite = class(TForm)
    BitBtn1: TBitBtn;
    addTempo: TComboBox;
    acao: TRadioGroup;
    myShell: TProcessUTF8;
    procedure BitBtn1Click(Sender: TObject);
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
  ordenar:= 'restart ' + showH + ':' + showM;
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

  if minutosNum < 10 then
  begin
  showM := '0' + IntToStr(minutosNum);
  end;

  if horasNum < 10 then
  begin
  showH := '0' + IntToStr(minutosNum);
  end;

  showmessage('Vai desligar em ' + showH + ':' + showM );

  comando;

end;

procedure Tboanoite.acaoClick(Sender: TObject);
begin

end;

procedure Tboanoite.FormCreate(Sender: TObject);
begin

end;

procedure Tboanoite.BitBtn1Click(Sender: TObject);
var
  programar: TstringList;
begin

  adicionarTempo;
 { programar := TStringList.create;
  myShell.CommandLine := ordenar;
  myShell.Execute;
  programar.Free;
  myShell.Free;
  }
  showmessage(ordenar);
end;

end.

