--vycistime tabulku sluzeb
truncate table service;


--Pridame 5 pouziti sluzby do tabulky
begin
        pridej_sluzbu.add_service(1, 1, date '2020-01-01', date '2020-01-01', 1);
        pridej_sluzbu.add_service(1, 1, date '2020-01-01', date '2020-01-01', 1);
        pridej_sluzbu.add_service(1, 1, date '2020-01-01', date '2020-01-01', 1);
        pridej_sluzbu.add_service(1, 1, date '2020-01-01', date '2020-01-01', 1);
        pridej_sluzbu.add_service(1, 1, date '2020-01-01', date '2020-01-01', 1);
end;
/

--Po sestem volani procedura musi vyhodit vyjimku, protoze jeden typ sluzby muze byt pouzit nejvyse petkrat
begin
        pridej_sluzbu.add_service(1, 1, date '2020-01-01', date '2020-01-01', 1);
end;
/

--Ted zmenime identifikator typu sluzby, abychom vyvolali druhou vyjimku, jelikoz jeden student muze vyuzit sluzeb maximalne petkrat
begin
        pridej_sluzbu.add_service(1, 1, date '2020-01-01', date '2020-01-01', 2);
end;
/
