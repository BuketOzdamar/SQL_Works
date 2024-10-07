------bir tablo oluþturmak-----
--create table TBLDERSLER(
--	DERSID tinyint,
--	DERSAD varchar(20))

-----bir tabloya sonradan bir veri eklemek-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--alter Table TBLDERSLER
--add KONTENJAN smallint

-----tablodan bir sütun düþürmek-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--alter table TBLDERSLER
--drop column KONTENJAN

----- !! tablo temizlenir !! -----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--truncate table TBLDERSLER

----- tabloyu güncelleþtirmek-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--update TBLOGRENCI set OGRCÝNSÝYET='erkek'
--update	TBLOGRENCI set OGRKLUP='kitaplýk' where OGRAD='emel'

----- notlarýn ortalamalarý alýnarak ortalama sütununa yazdýrýlýr-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--insert into TBLNOTLAR (OGRENCÝ, DERS, SINAV1, SINAV2) values (5,2,78,66)
--update TBLNOTLAR set ORT=(SINAV1+SINAV2+SINAV3)/3
--update TBLNOTLAR set DURUM=1 where ORT>=50
--update TBLNOTLAR set DURUM=0 where ORT<=50


---bazý hazýr fonksiyonlar sayma, toplama, ortalama--- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select count (*) from TBLOGRENCI --- TBLOGRENCÝ tablosundaki verileri sayar.
--select count(*) as 'toplam kayýt' from TBLOGRENCI
--select count(*) as 'toplam kiþi' from TBLOGRENCI where OGRSEHÝR='ADANA' --ÞARTLI KULLANIM
--select sum(SINAV1) as 'sýnav1', sum(SINAV2)as 'sýnav2', sum(SINAV3)as 'sýnav3' from TBLNOTLAR
--select avg(SINAV1) as 'sýnav1 ort',avg(SINAV2) as 'sýnav2 ort', avg(SINAV3) as 'sýnav3 ort' from TBLNOTLAR

-----Gruplandýrmalar: özellikle istatistiksel verilerde sýkça kullanýlýr. gruptandýrýlarak sayýlarý bize verilir.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select OGRSEHÝR, count(*) as 'toplam' from TBLOGRENCI group by OGRSEHÝR
--select OGRCÝNSÝYET, count(*) as 'toplam' from TBLOGRENCI group by OGRCÝNSÝYET

--select DURUM, count(*) as'toplam' from TBLNOTLAR group by DURUM
--select OGRKULÜP, count(*) from TBLOGRENCI group by OGRKULÜP

-------HAVÝNG KOMUTU: GRUPLANDIRMADA ÞARTI WHERE ÝLE YAZAMAYIZ.-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select OGRSEHÝR, count(*) as'sayý' from TBLOGRENCI group by OGRSEHÝR having count(*)=2 --sadece 2þer tane olanlar getirilir
--select OGRKULÜP, count(*) from TBLOGRENCI group by OGRKULÜP having OGRKULÜP='kitaplýk'

-----Like komutu-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLOGRENCI where OGRAD like '%a%' or OGRSOYAD like '%a%'
--select * from TBLOGRENCI where OGRAD like 'a%' and OGRCÝNSÝYET='kýz' -- adý kýz olan ve baþ harfi a  ile baþlayanlarý getir.
--select * from TBLOGRENCI where OGRSEHÝR like '%ed%'
--select * from TBLOGRENCI where OGRKULÜP not like '%a%'

-----Distinct komutu: tekrarsýz olarak deðer getirir-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select distinct OGRSEHÝR from TBLOGRENCI
--select count(distinct(OGRSEHÝR)) as'sayý'from TBLOGRENCI

--select distinct OGRKULÜP from TBLOGRENCI
--select count (distinct(OGRKULÜP)) as'kulüp sayýsý' from TBLOGRENCI

-----Order By Komutu-----
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLOGRENCI order by OGRAD -- öðrenci adýna göre alfabetik sýralayarak getirir. desc: z den baþlayarak tersten sýralar.
--select * from TBLOGRENCI order by OGRCÝNSÝYET
--select distinct OGRKULÜP from TBLOGRENCI order by OGRKULÜP desc

-----Like iþaretleri-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLOGRENCI where OGRSEHÝR like'%ka_%' -- ir den sonra baþka bir harf daha gelmeli.
--select * from TBLOGRENCI where OGRAD like '[A,B]%' -- adý a yada b ile baþlayan
--select * from TBLOGRENCI where OGRAD like '%[A,B]%' -- içinde a yada b geçen
--select * from TBLOGRENCI where OGRKULÜP like '[a-m]%' -- adý a dan baþlayýp m ye kadar olan harflerden herhangi biriyle baþlayanlarý getir

-----Top ve Percent Komutlarý------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select top 3* from TBLOGRENCI -- üstten 3 kaydý getir.
--select top 4* from TBLOGRENCI order by OGRID desc -- desc ile tersten sýralar ve en baþtaki 4ü alýrsay en alttaki 4ü almýþ oluruz.
--select top 60 percent * from TBLOGRENCI -- %60 ýný getir

-----In ve Not In: veya yerine kullanýlýr
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLOGRENCI where OGRSEHÝR='izmir' or OGRSEHÝR='Ankara'
--select * from TBLOGRENCI where OGRSEHÝR in('izmir','ankara','edirne') --buradaki iki sorgu da yaný iþlevde. in kullanarak sorguyu biraz daha kýsaltabiliriz
--select * from TBLOGRENCI where OGRSEHÝR not in('izmir','ankara','edirne') --parantez içindekileri içermeyenleri getir

-----Between komutu-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLNOTLAR where ORT between 74 and 100 -- ortalamasý 74-100 arasýndakileri geti
--select * from TBLOGRENCI where OGRAD between 'a' and 't' -- baþharfi a-t arasýnda olanlar gelir.
--select * from TBLOGRENCI where OGRAD not between 'a' and 't' -- baþharfi a-t arasýnda olmayanlar gelir.

-----Ýliþkili tablolara giriþ-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Veri karmaþasný önler, veri tekrarýný önler, bellek performansýný saðlar.
-- Türler: bire bir,, bire çok, çoka çok

--update TBLOGRENCI set OGRKULÜP=1 where OGRKULÜP='bilgisayar'
--update TBLOGRENCI set OGRKULÜP=2 where OGRKULÜP='kitaplýk'
--update TBLOGRENCI set OGRKULÜP=3 where OGRKULÜP='izci'
--update TBLOGRENCI set OGRKULÜP=4 where OGRKULÜP='gezi'
--update TBLOGRENCI set OGRKULÜP=5 where OGRKULÜP='tiyatro'

--update TBLOGRENCI set OGRSEHÝR=06 where OGRSEHÝR='ankara'
--update TBLOGRENCI set OGRSEHÝR=35 where OGRSEHÝR='izmir'
--update TBLOGRENCI set OGRSEHÝR=41 where OGRSEHÝR='izmit'
--update TBLOGRENCI set OGRSEHÝR=26 where OGRSEHÝR='eskiþehir'
--update TBLOGRENCI set OGRSEHÝR=16 where OGRSEHÝR='bursa'

--update TBLOGRENCI set OGRCÝNSÝYET=0 where OGRCÝNSÝYET='erkek'
--update TBLOGRENCI set OGRCÝNSÝYET=1 where OGRCÝNSÝYET='kýz'

--insert into TBLOGRENCI (OGRAD, OGRKULÜP, OGRSEHÝR) values ('veysel', 5, 'izmir')

-----Ýliþkili tablolarý birleþtirme iþlemi-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select NOTID,DERSAD, OGRAD+' '+ OGRSOYAD as 'AD SOYAD', ORT from TBLNOTLAR
--inner join TBLDERSLER		--ortak alanlarý birleþtirir
--on TBLNOTLAR.DERS=TBLDERSLER.DERSID
--inner join TBLOGRENCI
--on TBLNOTLAR.OGRENCÝ=TBLOGRENCI.OGRID

-----Alt Sorgular-----
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---** Dersler tablosunda adý matematik olan derse ait sýnavnot bilgisi**---
--select * from TBLNOTLAR where DERS=(select DERSID from TBLDERSLER where DERSAD='matematik') 

----- Inner Join----- Ortak alanda olanlar gelir. notlar tablosunda olmayýp öðrenciler tablosunda olanlar gelmez.

--select * from TBLNOTLAR
--INNER JOIN TBLOGRENCI
--ON TBLOGRENCI.OGRID=TBLNOTLAR.OGRENCÝ

--select * from TBLNOTLAR
--full join TBLOGRENCI   ---**rightt: örtüþmeyen veriyi de alýr. left join ise inner join gibi çalýþtý. full join: bütün hepsini getirir. 
--on TBLOGRENCI.OGRID=TBLNOTLAR.OGRENCÝ

--select * from TBLKULUP
--union                   ---** iki tablonun arasýna yazýldðýda iki tabloy birleþirir.
--select * from TBLDERSLER

------ ARÝTMETÝK ÝÞLEMLER -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select 20+4 as 'toplam', 20-4 as 'fark', 20*4 as 'çarpým', 20/4 as 'bölüm'

--** ikinci sýnav notu 45in altýnda olanlara 10 puan ekleyelim**--
--update TBLNOTLAR set SINAV  2=SINAV2+10 from TBLNOTLAR where ders=1 and SINAV2<45

--select AVG(ort) as 'ortalama' from TBLNOTLAR where DERS=1

----- MATEMATÝKSEL ÝÞLEMLER -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select ABS(-85) as 'mutlak'
--select POWER(2,4) as 'üs alma'
--select SQRT(625) as 'karekök'
--select FLOOR(4.86) as 'taban', CEILING(4.86) as'tavan'

--select sum (sýnav1) from TBLNOTLAR where OGRENCÝ=1
--select sýnav1, ders from TBLNOTLAR where OGRENCÝ=1
--select 
--	dersad, sýnav1 from TBLNOTLAR	
--	inner join TBLDERSLER on TBLNOTLAR.DERS=TBLDERSLER.DERSID 
--	where OGRENCÝ=1

--select 
--	dersad, sýnav1, sýnav2, sýnav3, ort, durum from TBLNOTLAR	
--	inner join TBLDERSLER on TBLNOTLAR.DERS=TBLDERSLER.DERSID 
--	where OGRENCÝ=(select OGRID from TBLOGRENCI where OGRAD='ayþe' and OGRSOYAD='doðan') --adý ve soyadý belirtilen kiþinin bilgilerini getirir. 

----- UPPER-LOWER FONKSÝYONLARI-----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select upper ('merhaba') as 'sütun'

--select upper (ograd) as 'öðrenci adý', upper (ogrsoyad) as 'soyad', lower(ogrsehir) as 'þehirler'
--	from TBLOGRENCI --bütün öðrenci adlarýný büyük harfle getirir.

-- kocaeliden gezi kulübündeki kiþinin adýný büyük harfle yazdýr.

--select upper(OGRAD) as 'öðrenci adý' from TBLOGRENCI where OGRSEHÝR='41' and OGRKULÜP=(select KULÜPID from TBLKULUP where KULÜPAD='gezi')

----- SUBSTRÝNG -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select SUBSTRING(OGRAD, 1,1) +'. '+ OGRSOYAD as'ad soyad' from TBLOGRENCI -- !! adýn ilk harfi nokta soyad

----- ismin ilk garfi ve soyisim yanýna kulüplerin ilk üç harflerini yazdýr-----
--SELECT 
--    SUBSTRING(OGRAD, 1, 1) + '. ' + OGRSOYAD AS 'Ad Soyad',
--    SUBSTRING(KULÜPAD, 1, 3) AS 'Kulüp Adý'
--FROM 
--    TBLOGRENCI
--JOIN 
--    TBLKULUP ON OGRKULÜP = KULÜPID;

----- LEFT-RÝGHT FONKSÝYONLARI-----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select
--	left('merhaba dünya',9), --soldan baþlayarak ilk 9 harfi alýr. boþluk dahil.
--	RIGHT('merhaba sql',3) --saðdan alýr

--select
--	left(DERSAD,3), 
--	AVG(ort) 
--	from TBLNOTLAR
--	inner join 
--	TBLDERSLER
--	on TBLDERSLER.DERSID=TBLNOTLAR.DERS
--	group by DERSAD

------- LEN FONKSÝYONU ------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select
--	OGRAD,
--	len(OGRAD),
--	OGRKULÜP
--	from TBLOGRENCI 
--	where OGRSEHÝR='41' 
--	and
--	OGRKULÜP=(select KULÜPID from TBLKULUP where KULÜPAD='gezi')

--select * from TBLOGRENCI where len(OGRAD)=4 or len(OGRAD)=3 -- öðrenci adý 3 veya 4 uzunluðundaki isimleri getir.

----- LTRÝM/RTRÝM REPLACE KOMUTLARI ------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select ltrim('         Korkma sönmez bu safaþlarda yüzen al sancak') -- ltrim: sol taraftan boþluðu siler.
																	 -- rtrim: sað taraftan boþluðu siler.

--select
--	REPLACE('Murat yücedað','yücedað','Y.dað') -- belirtilen soyismi deðiþtirir. en sondaki týrnak iþaretinin içindekini yazar.
											   -- 1.parametre: ama kelime/cümle
											   -- 2.parametre bulunacak deðer.
											   -- 3. parametre yenideðer.
--select 
--	CHARINDEX ('a', 'SQL derslerine devam ediyoruz.') -- aradaki boþluklar dahil a harfinin kaçýncý sýrada olduðunu bulur. 

--select 
--	CHARINDEX ('e', 'SQL derslerine devam ediyoruz.', 5) -- ilk 5 harften sonra e harfinin kaçýncý sýrada olduðunu bulur. 

--select
--	CHARINDEX('a', OGRAD) from TBLOGRENCI

