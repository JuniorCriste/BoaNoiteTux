unit bntCunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls;

type

  { Tconfirmacao }

  Tconfirmacao = class(TForm)
    desfazer: TBitBtn;
    letreiro1: TLabel;
    letreiro2: TLabel;
    wallpaper: TImage;
    procedure desfazerClick(Sender: TObject);
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

end.

