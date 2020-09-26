unit bntCunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, lclintf,
  Buttons, ExtCtrls;

type

  { Tconfirmacao }

  Tconfirmacao = class(TForm)
    donate: TBitBtn;
    desfazer: TBitBtn;
    letreiro1: TLabel;
    letreiro2: TLabel;
    wallpaper: TImage;
    procedure desfazerClick(Sender: TObject);
    procedure donateClick(Sender: TObject);
    procedure doneClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  confirmacao: Tconfirmacao;

implementation
 uses bntunit;
{$R *.lfm}

{ Tconfirmacao }

procedure Tconfirmacao.FormCreate(Sender: TObject);
begin

end;

procedure Tconfirmacao.desfazerClick(Sender: TObject);
begin
  boanoite.Visible:= true;  
  confirmacao.Visible:= false;
  boanoite.cancelar.Click;

end;

procedure Tconfirmacao.donateClick(Sender: TObject);
begin
  OpenURL('https://www.informaticode.com.br/p/doacoes.html');
end;

procedure Tconfirmacao.doneClick(Sender: TObject);
begin

end;

end.

