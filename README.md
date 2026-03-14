<H1>Įvadas</H1>

Šis įrankis skirtas iš naujosios (nuo 2024-12) CVP IS parsisiųstų tiekėjų pasiūlymų failų pervardinimui.
Iš CVP IS parsisiuntus tiekėjo pasiūlymo archyvą (.zip failą) bei jį išarchyvavus, pasiūlymo failų pavadinimai yra „iškraipyti“, todėl neatsidarius jų nėra įmanoma suprasti koks jų turinys

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/problem.png)

Šis įrankis naudodamas faile tender.xml pateiktą informaciją atstato failų tikruosius pavadinimus – tokius, kokius jie turėjo tiekėjui juos įkeliant į sistemą

Įrankiui įdiegti ir naudoti administratoriaus teisių nereikia, todėl jis gali būti įdiegtas paties vartotojo. Vis dėlto, vartotojas yra pats atsakingas išsiaiškinti ar savarankiškai diegdamas programą darbo kompiuteryje nepažeis įstaigos vidaus politikos (tvarkos) dėl programų diegimo, naudojimo ir saugumo. Esant poreikiui rekomenduotina pasitarti su savo įstaigos informacinių technologijų specialistais. Be paruoštos naudoti įdiegimo programos taip pat yra pateikta pilnas programinis kodas, kad didesnio saugumo reikalavimų įstaigų IT specialistai galėtų patys įsitikinti programos saugumu arba organizuoti programos įdiegimą kitu būdu. 

<H1>Diegimo instrukcija</H1>

Atsisiuntus įdiegimo failą setup.exe, jį reikia aktyvuoti du kartus spustelėjus pelės kairiuoju klavišu

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/setup-file.png)

Atsižvelgiant į naudojamos Windows sistemos versiją bei saugumo nustatymus, sistema gali paprašyti patvirtinti programos aktyvavimą suvedant savo slaptažodį. Kaip jau minėta, įdiegimui nebūtinos administratoriaus teisės, todėl užtenka įvesti savo vartotojo slaptažodį. 

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/security.png)

Įsijungus įdiegimo programai reikia paspausti „Įdiegti“

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/setup-1.png)

Kitame lange paspausti – „Pabaiga“

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/setup-end.png)

<H1>Naudojimo instrukcija</H1>

Iš CVP IS sistemos parsisiuntus pasiūlymo failo archyvą (.ZIP) jį reikia išarchyvuoti („extract“). 
Tuomet, išarchyvuotuose failuose surasti failą "tender.xml" (arba tiesiog „tender“), ir jį pasižymėjus, nuspausti pelės dešinįjį klavišą.
Toliau veiksmai gali šiek tiek skirtis atsižvelgiant į naudojamą sistemos versiją bei sistemos nustatymus. 

Pavyzdžiui, Windows 10 aplinkoje iš karto matysis pasirinkimas „Pasiūlymo failų pervardinimas“

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/windows10-run.png)

O Windows 11 aplinkoje reikės pasirinkti „Show more options“:

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/run-more-options.png)

ir tik tada „Pasiūlymo failų pervardinimas“:

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/run-run.png)

Jeigu atsiranda toks langas 

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/warning.png)

spaudžiame „Open“.

Netrukus failai esantys kataloge „files“ bus pervardinti. Atsižvelgiant į failų kiekį, tai gali užtrukti iki kelių sekundžių.

<H1>Jeigu nesiseka</H1>

Jeigu, kaip aprašyta aukščiau, neatsiranda pasirinkimas „Pasiūlymo failų pervardinimas“, to priežastys gali būti kelios:

1. bandote veiksmą atlikti ne išarchyvuotame pasiūlymų archyve, tuomet vaizdas bus panašus į šį:

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/klaida.jpg)

2. dešinį pelės klavišą nuspaudėte ne ant failo "tender.xml" (tender), o kur nors šalia. Bandykite dar kartą – pelės žymeklis turi būti ant failo "tender.xml" tuo metu, kai spaudžiate pelės dešinį klavišą.

Taip pat, kartais pervardinimas gali būti nesėkmingas dėl to, kad failo kelias ir pavadinimas yra per ilgi. Tai susiję su Windows sistemos apribojimais, todėl pabandykite išarchyvuoto pasiūlymų katalogą padėti kur nors „sekliau“, pavyzdžiui ne „C:\Users\vartotojo-vardas\Documents\Mano pasiūlymų failai\Pirkimas elektroninės naujos sistemos 2026 metų, galutinė versija 2027-01-05 atnaujinta\visi pasiūlymai\UAB nebeprisikiškiakopusteliaudami\“, o pvz. C:\Dokumentai\Pasiūlymai1\

Jeigu bandant įdiegti įrankį sistema jį užblokuoja ir rodo tokį pranešimą:

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/blokavimas.png)

tuomet reikėtų atsiųstą failą „setup.exe“ atblokuoti. Tam reikia dešiniuoju pelės klavišu nuspausti ant failo „setup.exe“, pasirinkti „Properties“, tuomet lange pažymėti „Unblock“ ir paspausti „OK“

![image](https://github.com/ggolcevas/pasiulymu-pervardinimas/blob/main/docs/images/unblock.png)


<H1>LICENCIJOS IR KITOS SĄLYGOS</H1>

(c) 2026 Gediminas Golcevas

Leidžiama naudoti, kopijuoti, modifikuoti ir platinti šią programinę įrangą
bei jos modifikuotas versijas laikantis šių sąlygų:

1. Programinė įranga gali būti naudojama tik nekomerciniais tikslais.
2. Programinę įrangą ir jos modifikuotas versijas leidžiama platinti tik
   nemokamai (be jokio užmokesčio).
3. Bet kokio platinimo ar publikavimo atveju privaloma nurodyti originalų autorių.
4. Modifikuotos versijos turi aiškiai pažymėti, kad jos yra pakeistos,
   ir turi išsaugoti šį licencijos tekstą.

Atsakomybės apribojimas

Ši programinė įranga pateikiama „tokiu pavidalu, kokia yra“ (angl. as is),
be jokių garantijų, nei išreikštų, nei numanomų.

Autorius neatsako už jokius nuostolius, žalą ar pasekmes,
atsiradusias naudojant šią programinę įrangą. Prieš naudojant šį failą rekomenduojama pasidaryti atsargines pasiūlymo failų kopijas.
