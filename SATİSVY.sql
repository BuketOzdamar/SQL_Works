----- DDL KOMUTLARI ------

--create database dbSatisVT
--use dbSatisVT

--create table TBLKATEGOR�
--	(KATEGOR�ID tinyint identity(1,1) primary key,
--	 KATEGOR�AD varchar(50)
--	)

--create table TBLURUNLER
--	(
--	 URUNLERID tinyint identity(1,1) primary key,
--	 URUNLER�AD varchar(50),
--	 URUNMARKA varchar(50),
--	 URUNKATEGOR� tinyint,
--	 URUNALISF decimal(18,2),
--	 URUNSATISF decimal(18,2),
--	 URUNSTOK smallint check(URUNSTOK>0),
--	 URUNDURUM bit default '1'
--	)

--create table TBLPERSONEL
--(	
--	PERSONELID smallint identity(1,1) primary key,
--	PERSONELADSOYAD varchar(50)
--)

--create table TBLMUSTER�
--(	
--	MUSTER�ID int primary key identity(1,1),
--	MUSTER�AD varchar(50),
--	MUSTER�SOYAD varchar(50),
--	MUSTER�SEH�R varchar(13),
--	MUSTER�BAK�YE decimal(18,2)
--)

--create table TBLHAREKET
--(	
--	HAREKETID int primary key identity(1,1),
--	URUN int,
--	MUSTER� int,
--	PERSONEL smallint,
--	ADET int,
--	TUTAR decimal(18,2),
--	TAR�H smalldatetime
--)

--TRUNCATE table TBLURUNLER -- tablo s�f�rland�.

----- DML KOMUTLARI ------

--i
--insert into TBLURUNLER(URUNLER�AD, URUNMARKA,URUNKATEGOR�,URUNALISF, URUNSATISF,URUNSTOK) values ('buzdolab�','siemens',2,4356,4588,10)

--update TBLURUNLER set URUNAD='kettle' where URUNAD='su �s�t�c�s�'

-------------------------------------------------------------------
--select KATEGOR�AD, count(*) as 'toplam �r�n' from TBLURUNLER
--inner join 
--TBLKATEGOR�
--on
--TBLURUNLER.URUNKATEGOR�=TBLKATEGOR�.KATEGOR�ID
--group by KATEGOR�AD 
--order by count(*)
--------------------------------------------------------------------

-- kategori ad� bilgisayar olan �r�nlerin sat�� fiyat�na 500 tl zam
--update TBLURUNLER set URUNSATISF+=500 where URUNKATEGOR�=(select KATEGOR�ID from TBLKATEGOR� where KATEGOR�AD='bilgisayar')

-- tv kategorisindeki �r�nlere %10 indirim. --
--select URUNAD, URUNALISF, URUNSATISF, URUNDURUM from TBLURUNLER 
--update TBLURUNLER set URUNSATISF=(URUNSATISF*10)/100+URUNSATISF
--where URUNKATEGOR� = (select KATEGOR�ID from TBLKATEGOR� where KATEGOR�AD = 'TV')

--select count(*) as'ka� farkl� �r�n', sum(urunstok) as 'stok say�s�' from TBLURUNLER 

--stoktaki b�t�n �r�nleri satarsak ka� para kazan�r�z?
--select URUNID, URUNAD, URUNMARKA, KATEGOR�ID, URUNALISF, URUNSATISF,
--(URUNSATISF-URUNALISF)as'kar',
--(URUNSATISF-URUNALISF)*URUNSTOK as 'toplam kar' from TBLURUNLER
--inner join
--TBLKATEGOR�
--on TBLURUNLER.URUNKATEGOR�=TBLKATEGOR�.KATEGOR�ID

-- Toplam kar� 1000 tlnin alt�nda kalana 500 tl zam.
--select URUNID, URUNAD, URUNMARKA, URUNALISF, URUNSATISF, (URUNSATISF - URUNALISF) * URUNSTOK as 'toplam kar' 
--update TBLURUNLER set URUNSATISF+=500
--from TBLURUNLER
--inner join TBLKATEGOR�
--on TBLURUNLER.URUNKATEGOR� = TBLKATEGOR�.KATEGOR�ID
--where (URUNSATISF - URUNALISF) * URUNSTOK < 1000;

---------------------------------------------- PROSED�R KULLANIMI ------------------------------

--create procedure HAREKETLER 
--as
--select HAREKETID, URUNAD, MUSTER�AD + ' ' + MUSTER�SOYAD as 'AD SOYAD', PERSONELADSOYAD, ADET, TUTAR, TAR�H
--from TBLHAREKET 
--inner join TBLURUNLER
--on TBLHAREKET.URUN=TBLURUNLER.URUNID
--inner join TBLMUSTER�
--on TBLHAREKET.MUSTER�=TBLMUSTER�.MUSTER�ID
--inner join TBLPERSONEL
--on TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID

--execute HAREKETLER -- kaydetti�iiz prosed�r� kullan�yoruz. 

--------------------------------------------- prosed�r silme --------------------------------------
--create procedure DENEME
--as
--select * from TBLURUNLER where URUNSTOK>10
--exec DENEME

--drop procedure DENEME

------------------------------------------- PROSED�R G�NCELLEME ----------------------------------
--alter procedure HAREKETLER 
--as
--select HAREKETID, URUNAD, left(MUSTER�AD,1) + '.' + MUSTER�SOYAD as 'AD SOYAD', PERSONELADSOYAD, ADET, TUTAR, TAR�H
--from TBLHAREKET 
--inner join TBLURUNLER
--on TBLHAREKET.URUN=TBLURUNLER.URUNID
--inner join TBLMUSTER�
--on TBLHAREKET.MUSTER�=TBLMUSTER�.MUSTER�ID
--inner join TBLPERSONEL
--on TBLHAREKET.PERSONEL=TBLPERSONEL.PERSONELID

--exec HAREKETLER

--alter procedure URUNGET�R
--@DEGER varchar(50)='buzdolab�' --�artl� prosed�r. 
--as
--select URUNAD, URUNSTOK, URUNMARKA from TBLURUNLER
--where URUNAD=@DEGER

--execute URUNGET�R @DEGER='�ama��r makinesi' 

--------------------------------------------- DATEPART KULLANMI -------------------------------
--select * from TBLHAREKET where DATEPART (day,TAR�H) between 3 and 5 and MUSTER�=1

--select * from TBLHAREKET where DATEPART(day, TAR�H) between 1 and 3 and
--MUSTER�=(select MUSTER�ID FROM TBLMUSTER� where MUSTER�SEH�R='ankara'

--select DATENAME (month, getdate()), datename(month, '2019.01.15')
--select DATENAME(WEEKDAY, getdate())

---------------------------------------------- DateDiff ---------------------------------------
--select DATEDIFF(year, '2010.10.25',getdate()) -- verilen tarihle bulundu�umuz tarih aras�nda ge�en y�l� bize verir.
--select DATEDIFF(month,'2010.06.01', getdate()) -- verilen tarihle g�n�m�z tarihinin ay olarak fark�n� verir
--select DATEDIFF(day, TAR�H, getdate()) from TBLHAREKET where HAREKETID=1

---------------------------------------------- DATEADD ---------------------------------------

--select DATEADD(year,3,'2009.10.25') --verilen tarihin �stine istenen y�l� ekler.
--select DATEADD(day,3,'2009.10.25') --verilen tarihin �stine istenen g�n� ekler.
--select DATEADD(month,3,'2009.10.25') --verilen tarihin �stine istenen ay� ekler.

----------------------------------------------- ALT SORGU �ALI�MASI ----------------------------------
--select URUNAD, count(*) as '�r�n ad' from TBLHAREKET
--inner join TBLURUNLER on TBLHAREKET.URUN=TBLURUNLER.URUNID
--group by URUNAD 

----- �r�nler tablosunda sadece bilgisayar sat�lan �r�nleri hareket tablosundan getir.
--select * from TBLHAREKET where URUN in(select URUNID from TBLURUNLER where URUNKATEGOR�=1)

--select * from TBLHAREKET where MUSTER� in(select MUSTER�ID from TBLMUSTER� where MUSTER�SEH�R='adana')

--select * from TBLHAREKET where URUN in(select URUNID from TBLURUNLER 
--where URUNKATEGOR�=(select KATEGOR�ID from TBLKATEGOR� where KATEGOR�AD='beyaz e�ya'))

--select SUM(TUTAR) from TBLHAREKET 
--where MUSTER� in(select musteri�d from TBLMUSTER� where MUSTER�SEH�R='adana'or MUSTER�SEH�R='ankara')

----- sat�lan bir �r�n�n sto�u nas�l azalt�l�r?
--select * from TBLHAREKET where URUN=1
--update TBLURUNLER set URUNSTOK=URUNSTOK-(select SUM(ADET) from TBLHAREKET where URUN=10) where URUNID=10

------------------------------------------------- kasa tablosu ------------------------------------------------------
--create table TBLKASA(
--	toplam decimal(18,2))

--insert into TBLKASA values (0)
--select * from TBLKASA

--update TBLKASA set TOPLAM=(select SUM(TUTAR) from TBLHAREKET) -- hareket tablosunda harcanan para kasa tablosunda kullan�l�r.
--select * from TBLKASA

-------------------------------------------------- TRIGGER OLU�TURMA ---------------------------------------------
-- �rne�in hareket tablosunda bir �r�n sat�ld��� anda urunler tablosundan otomatik olarak stoktan d���lmesini sa�lar.

--create table TBLSAYAC(
--	ISLEM int)

--insert into TBLSAYAC values(0)

--update TBLSAYAC set ISLEM=(select COUNT(*) from TBLHAREKET)

----- hareket tablosuna veri giri�i yapt���m�z anda saya� tablsounda art�� olmal�. bunun i�in tetikleyici olu�turaca��z.
--create trigger ISLEMARTIS
--on TBLHAREKET -- hareket tablsounda
--after insert -- insert yap�ld�ktan sonra yani veri girildikten sonra
--as 
--update TBLSAYAC set ISLEM=ISLEM+1 -- ne yap�lacak? i�lem 1 artt�r�lacak.

--create table TBLTOPLAMKATEGORI(
--	ADET tinyint)
	 
--update TBLTOPLAMKATEGORI set adet=(select count(*) from TBLKATEGOR�)

--create trigger KATEGORIARTIS1
--on TBLKATEGOR�
--after insert
--as 
--update TBLTOPLAMKATEGORI set ADET+=1

--create trigger KATEGORIAZALIS1
--on TBLKATEGOR�
--after delete
--as
--update TBLTOPLAMKATEGORI set ADET-=1

---------------------------------------------------------- V�EV OLU�TURMA ----------------------------------------------------------
--create view TEST1
--as
--select * from TBLKATEGOR�

--select * from TEST1

--alter view TEST1
--as 
--select * from TBLKATEGOR� where KATEGOR�ID<4

--select * from TEST1

---------------------------------------------------------- VIEW S�H�RBAZ ----------------------------------------------------------
--select * from TEST1

--select * from TEST3











