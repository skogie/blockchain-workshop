Coinit

Oppgaven går ut på å lage en smart kontrakt som har funksjonalitet som tilsvarer dagens utviklingskonto. Man skal blant annet kunne opprette nye brukere, og admin skal kunne lage penger som settes på konto til disse. Hver bruker har en saldo.

1.
Implementer 'createAccount' der det opprettes en bruker. En bruker skal ha følgende felt: 
'addr' - ethereum addressen til brukeren
'amount' - balansen i int
'validated' - boolean som beskriver om brukeren er validert av admin
'exist' - boolean som beskriver om brukeren eksisterer

Ved opprettelse skal brukeren ikke være markert som validert, ettersom admin må gjøre dette.


2.
Implementer 'validateEmployee'. Brukeren til addressen som sendes inn skal bli markert som validert. Funksjonen kan kun utføres av admin, det vil si han som opprettet kontrakten.

3.
Implementer 'createAndSendCoin'. Denne funksjonen "lager" penger og setter de inn på kontoen som er gitt som parameter. Funksjonen kan kun utføres av admin.

4.
Implementer 'sendCoin'. Denne funksjonen er ment for at de ansatte kan sende penger mellom seg. Det skal ikke gå ann å sende mer penger enn det man har i balanse.

5.
Implementer 'createAndGiveMoneyToAllEmployees'. Denne funksjonen skal sette inn penger på alle kontoer som er validerte. Hvordan kan du strukturere dataene for å få dette til?

6.
Implementer get-funksjonene.

7.
Implementer 'markForPayOutOnNextSalary'. og 'payOutOnNextSalary' Sistnevnte gir en ansatt mulighet til å markere en del av saldoen som han/hun ønsker at utbetales på neste lønning. Den første gir admin mulighet til å gjøre det samme for hvilken som helst ansatt.

8.
Implementer 'payout'. Her skal man loope over alle ansatte som har markert at noe skal utbetales, også fjerner man beløpet fra saldoen deres, ettersom dette nå kommer på lønning i NOK. Du skal slippe å bry deg om hvordan du faktisk skal få infoen inn i lønningssystemet.. :)

