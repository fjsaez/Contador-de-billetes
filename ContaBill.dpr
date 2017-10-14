{
    Contador de billetes
         v1.5

    Autor: Francisco J. Sáez S.

    Contador de billetes que arroja la suma total del dinero contado.
    Se emplearon los componentes JEDI.

    Calabozo, Guárico. Venezuela. Julio 2017

}

program ContaBill;

uses
  Forms,
  Princ in 'Princ.pas' {FPrinc};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Contador de billetes';
  Application.CreateForm(TFPrinc, FPrinc);
  Application.Run;
end.
