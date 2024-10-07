------bir tablo olu�turmak-----
--create table TBLDERSLER(
--	DERSID tinyint,
--	DERSAD varchar(20))

-----bir tabloya sonradan bir veri eklemek-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--alter Table TBLDERSLER
--add KONTENJAN smallint

-----tablodan bir s�tun d���rmek-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--alter table TBLDERSLER
--drop column KONTENJAN

----- !! tablo temizlenir !! -----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--truncate table TBLDERSLER

----- tabloyu g�ncelle�tirmek-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--update TBLOGRENCI set OGRC�NS�YET='erkek'
--update	TBLOGRENCI set OGRKLUP='kitapl�k' where OGRAD='emel'

----- notlar�n ortalamalar� al�narak ortalama s�tununa yazd�r�l�r-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--insert into TBLNOTLAR (OGRENC�, DERS, SINAV1, SINAV2) values (5,2,78,66)
--update TBLNOTLAR set ORT=(SINAV1+SINAV2+SINAV3)/3
--update TBLNOTLAR set DURUM=1 where ORT>=50
--update TBLNOTLAR set DURUM=0 where ORT<=50


---baz� haz�r fonksiyonlar sayma, toplama, ortalama--- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select count (*) from TBLOGRENCI --- TBLOGRENC� tablosundaki verileri sayar.
--select count(*) as 'toplam kay�t' from TBLOGRENCI
--select count(*) as 'toplam ki�i' from TBLOGRENCI where OGRSEH�R='ADANA' --�ARTLI KULLANIM
--select sum(SINAV1) as 's�nav1', sum(SINAV2)as 's�nav2', sum(SINAV3)as 's�nav3' from TBLNOTLAR
--select avg(SINAV1) as 's�nav1 ort',avg(SINAV2) as 's�nav2 ort', avg(SINAV3) as 's�nav3 ort' from TBLNOTLAR

-----Grupland�rmalar: �zellikle istatistiksel verilerde s�k�a kullan�l�r. gruptand�r�larak say�lar� bize verilir.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select OGRSEH�R, count(*) as 'toplam' from TBLOGRENCI group by OGRSEH�R
--select OGRC�NS�YET, count(*) as 'toplam' from TBLOGRENCI group by OGRC�NS�YET

--select DURUM, count(*) as'toplam' from TBLNOTLAR group by DURUM
--select OGRKUL�P, count(*) from TBLOGRENCI group by OGRKUL�P

-------HAV�NG KOMUTU: GRUPLANDIRMADA �ARTI WHERE �LE YAZAMAYIZ.-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select OGRSEH�R, count(*) as'say�' from TBLOGRENCI group by OGRSEH�R having count(*)=2 --sadece 2�er tane olanlar getirilir
--select OGRKUL�P, count(*) from TBLOGRENCI group by OGRKUL�P having OGRKUL�P='kitapl�k'

-----Like komutu-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLOGRENCI where OGRAD like '%a%' or OGRSOYAD like '%a%'
--select * from TBLOGRENCI where OGRAD like 'a%' and OGRC�NS�YET='k�z' -- ad� k�z olan ve ba� harfi a  ile ba�layanlar� getir.
--select * from TBLOGRENCI where OGRSEH�R like '%ed%'
--select * from TBLOGRENCI where OGRKUL�P not like '%a%'

-----Distinct komutu: tekrars�z olarak de�er getirir-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select distinct OGRSEH�R from TBLOGRENCI
--select count(distinct(OGRSEH�R)) as'say�'from TBLOGRENCI

--select distinct OGRKUL�P from TBLOGRENCI
--select count (distinct(OGRKUL�P)) as'kul�p say�s�' from TBLOGRENCI

-----Order By Komutu-----
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLOGRENCI order by OGRAD -- ��renci ad�na g�re alfabetik s�ralayarak getirir. desc: z den ba�layarak tersten s�ralar.
--select * from TBLOGRENCI order by OGRC�NS�YET
--select distinct OGRKUL�P from TBLOGRENCI order by OGRKUL�P desc

-----Like i�aretleri-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLOGRENCI where OGRSEH�R like'%ka_%' -- ir den sonra ba�ka bir harf daha gelmeli.
--select * from TBLOGRENCI where OGRAD like '[A,B]%' -- ad� a yada b ile ba�layan
--select * from TBLOGRENCI where OGRAD like '%[A,B]%' -- i�inde a yada b ge�en
--select * from TBLOGRENCI where OGRKUL�P like '[a-m]%' -- ad� a dan ba�lay�p m ye kadar olan harflerden herhangi biriyle ba�layanlar� getir

-----Top ve Percent Komutlar�------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select top 3* from TBLOGRENCI -- �stten 3 kayd� getir.
--select top 4* from TBLOGRENCI order by OGRID desc -- desc ile tersten s�ralar ve en ba�taki 4� al�rsay en alttaki 4� alm�� oluruz.
--select top 60 percent * from TBLOGRENCI -- %60 �n� getir

-----In ve Not In: veya yerine kullan�l�r
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLOGRENCI where OGRSEH�R='izmir' or OGRSEH�R='Ankara'
--select * from TBLOGRENCI where OGRSEH�R in('izmir','ankara','edirne') --buradaki iki sorgu da yan� i�levde. in kullanarak sorguyu biraz daha k�saltabiliriz
--select * from TBLOGRENCI where OGRSEH�R not in('izmir','ankara','edirne') --parantez i�indekileri i�ermeyenleri getir

-----Between komutu-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select * from TBLNOTLAR where ORT between 74 and 100 -- ortalamas� 74-100 aras�ndakileri geti
--select * from TBLOGRENCI where OGRAD between 'a' and 't' -- ba�harfi a-t aras�nda olanlar gelir.
--select * from TBLOGRENCI where OGRAD not between 'a' and 't' -- ba�harfi a-t aras�nda olmayanlar gelir.

-----�li�kili tablolara giri�-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Veri karma�asn� �nler, veri tekrar�n� �nler, bellek performans�n� sa�lar.
-- T�rler: bire bir,, bire �ok, �oka �ok

--update TBLOGRENCI set OGRKUL�P=1 where OGRKUL�P='bilgisayar'
--update TBLOGRENCI set OGRKUL�P=2 where OGRKUL�P='kitapl�k'
--update TBLOGRENCI set OGRKUL�P=3 where OGRKUL�P='izci'
--update TBLOGRENCI set OGRKUL�P=4 where OGRKUL�P='gezi'
--update TBLOGRENCI set OGRKUL�P=5 where OGRKUL�P='tiyatro'

--update TBLOGRENCI set OGRSEH�R=06 where OGRSEH�R='ankara'
--update TBLOGRENCI set OGRSEH�R=35 where OGRSEH�R='izmir'
--update TBLOGRENCI set OGRSEH�R=41 where OGRSEH�R='izmit'
--update TBLOGRENCI set OGRSEH�R=26 where OGRSEH�R='eski�ehir'
--update TBLOGRENCI set OGRSEH�R=16 where OGRSEH�R='bursa'

--update TBLOGRENCI set OGRC�NS�YET=0 where OGRC�NS�YET='erkek'
--update TBLOGRENCI set OGRC�NS�YET=1 where OGRC�NS�YET='k�z'

--insert into TBLOGRENCI (OGRAD, OGRKUL�P, OGRSEH�R) values ('veysel', 5, 'izmir')

-----�li�kili tablolar� birle�tirme i�lemi-----
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select NOTID,DERSAD, OGRAD+' '+ OGRSOYAD as 'AD SOYAD', ORT from TBLNOTLAR
--inner join TBLDERSLER		--ortak alanlar� birle�tirir
--on TBLNOTLAR.DERS=TBLDERSLER.DERSID
--inner join TBLOGRENCI
--on TBLNOTLAR.OGRENC�=TBLOGRENCI.OGRID

-----Alt Sorgular-----
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---** Dersler tablosunda ad� matematik olan derse ait s�navnot bilgisi**---
--select * from TBLNOTLAR where DERS=(select DERSID from TBLDERSLER where DERSAD='matematik') 

----- Inner Join----- Ortak alanda olanlar gelir. notlar tablosunda olmay�p ��renciler tablosunda olanlar gelmez.

--select * from TBLNOTLAR
--INNER JOIN TBLOGRENCI
--ON TBLOGRENCI.OGRID=TBLNOTLAR.OGRENC�

--select * from TBLNOTLAR
--full join TBLOGRENCI   ---**rightt: �rt��meyen veriyi de al�r. left join ise inner join gibi �al��t�. full join: b�t�n hepsini getirir. 
--on TBLOGRENCI.OGRID=TBLNOTLAR.OGRENC�

--select * from TBLKULUP
--union                   ---** iki tablonun aras�na yaz�ld��da iki tabloy birle�irir.
--select * from TBLDERSLER

------ AR�TMET�K ��LEMLER -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select 20+4 as 'toplam', 20-4 as 'fark', 20*4 as '�arp�m', 20/4 as 'b�l�m'

--** ikinci s�nav notu 45in alt�nda olanlara 10 puan ekleyelim**--
--update TBLNOTLAR set SINAV  2=SINAV2+10 from TBLNOTLAR where ders=1 and SINAV2<45

--select AVG(ort) as 'ortalama' from TBLNOTLAR where DERS=1

----- MATEMAT�KSEL ��LEMLER -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select ABS(-85) as 'mutlak'
--select POWER(2,4) as '�s alma'
--select SQRT(625) as 'karek�k'
--select FLOOR(4.86) as 'taban', CEILING(4.86) as'tavan'

--select sum (s�nav1) from TBLNOTLAR where OGRENC�=1
--select s�nav1, ders from TBLNOTLAR where OGRENC�=1
--select 
--	dersad, s�nav1 from TBLNOTLAR	
--	inner join TBLDERSLER on TBLNOTLAR.DERS=TBLDERSLER.DERSID 
--	where OGRENC�=1

--select 
--	dersad, s�nav1, s�nav2, s�nav3, ort, durum from TBLNOTLAR	
--	inner join TBLDERSLER on TBLNOTLAR.DERS=TBLDERSLER.DERSID 
--	where OGRENC�=(select OGRID from TBLOGRENCI where OGRAD='ay�e' and OGRSOYAD='do�an') --ad� ve soyad� belirtilen ki�inin bilgilerini getirir. 

----- UPPER-LOWER FONKS�YONLARI-----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--select upper ('merhaba') as 's�tun'

--select upper (ograd) as '��renci ad�', upper (ogrsoyad) as 'soyad', lower(ogrsehir) as '�ehirler'
--	from TBLOGRENCI --b�t�n ��renci adlar�n� b�y�k harfle getirir.

-- kocaeliden gezi kul�b�ndeki ki�inin ad�n� b�y�k harfle yazd�r.

--select upper(OGRAD) as '��renci ad�' from TBLOGRENCI where OGRSEH�R='41' and OGRKUL�P=(select KUL�PID from TBLKULUP where KUL�PAD='gezi')

----- SUBSTR�NG -----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select SUBSTRING(OGRAD, 1,1) +'. '+ OGRSOYAD as'ad soyad' from TBLOGRENCI -- !! ad�n ilk harfi nokta soyad

----- ismin ilk garfi ve soyisim yan�na kul�plerin ilk �� harflerini yazd�r-----
--SELECT 
--    SUBSTRING(OGRAD, 1, 1) + '. ' + OGRSOYAD AS 'Ad Soyad',
--    SUBSTRING(KUL�PAD, 1, 3) AS 'Kul�p Ad�'
--FROM 
--    TBLOGRENCI
--JOIN 
--    TBLKULUP ON OGRKUL�P = KUL�PID;

----- LEFT-R�GHT FONKS�YONLARI-----
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select
--	left('merhaba d�nya',9), --soldan ba�layarak ilk 9 harfi al�r. bo�luk dahil.
--	RIGHT('merhaba sql',3) --sa�dan al�r

--select
--	left(DERSAD,3), 
--	AVG(ort) 
--	from TBLNOTLAR
--	inner join 
--	TBLDERSLER
--	on TBLDERSLER.DERSID=TBLNOTLAR.DERS
--	group by DERSAD

------- LEN FONKS�YONU ------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select
--	OGRAD,
--	len(OGRAD),
--	OGRKUL�P
--	from TBLOGRENCI 
--	where OGRSEH�R='41' 
--	and
--	OGRKUL�P=(select KUL�PID from TBLKULUP where KUL�PAD='gezi')

--select * from TBLOGRENCI where len(OGRAD)=4 or len(OGRAD)=3 -- ��renci ad� 3 veya 4 uzunlu�undaki isimleri getir.

----- LTR�M/RTR�M REPLACE KOMUTLARI ------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--select ltrim('         Korkma s�nmez bu safa�larda y�zen al sancak') -- ltrim: sol taraftan bo�lu�u siler.
																	 -- rtrim: sa� taraftan bo�lu�u siler.

--select
--	REPLACE('Murat y�ceda�','y�ceda�','Y.da�') -- belirtilen soyismi de�i�tirir. en sondaki t�rnak i�aretinin i�indekini yazar.
											   -- 1.parametre: ama kelime/c�mle
											   -- 2.parametre bulunacak de�er.
											   -- 3. parametre yenide�er.
--select 
--	CHARINDEX ('a', 'SQL derslerine devam ediyoruz.') -- aradaki bo�luklar dahil a harfinin ka��nc� s�rada oldu�unu bulur. 

--select 
--	CHARINDEX ('e', 'SQL derslerine devam ediyoruz.', 5) -- ilk 5 harften sonra e harfinin ka��nc� s�rada oldu�unu bulur. 

--select
--	CHARINDEX('a', OGRAD) from TBLOGRENCI

