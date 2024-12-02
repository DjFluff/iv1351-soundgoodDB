-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE public.booking_id_seq;

CREATE SEQUENCE public.booking_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.genre_id_seq;

CREATE SEQUENCE public.genre_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.instrument_type_id_seq;

CREATE SEQUENCE public.instrument_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.lease_id_seq;

CREATE SEQUENCE public.lease_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.location_id_seq;

CREATE SEQUENCE public.location_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.person_id_seq;

CREATE SEQUENCE public.person_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.pricing_scheme_id_seq;

CREATE SEQUENCE public.pricing_scheme_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.rentable_instrument_id_seq;

CREATE SEQUENCE public.rentable_instrument_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.skill_level_id_seq;

CREATE SEQUENCE public.skill_level_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.genre definition

-- Drop table

-- DROP TABLE public.genre;

CREATE TABLE public.genre (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	genre varchar(100) NOT NULL,
	CONSTRAINT pk_genre PRIMARY KEY (id)
);


-- public.instrument_type definition

-- Drop table

-- DROP TABLE public.instrument_type;

CREATE TABLE public.instrument_type (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	"type" varchar(100) NOT NULL,
	CONSTRAINT pk_instrument_type PRIMARY KEY (id)
);


-- public."location" definition

-- Drop table

-- DROP TABLE public."location";

CREATE TABLE public."location" (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	location_place varchar(100) NULL,
	CONSTRAINT pk_location PRIMARY KEY (id)
);


-- public.pricing_scheme definition

-- Drop table

-- DROP TABLE public.pricing_scheme;

CREATE TABLE public.pricing_scheme (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	price int4 NOT NULL,
	wage int4 NOT NULL,
	sibling_discount int4 NOT NULL,
	CONSTRAINT pk_pricing_scheme PRIMARY KEY (id)
);


-- public.skill_level definition

-- Drop table

-- DROP TABLE public.skill_level;

CREATE TABLE public.skill_level (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	skill_level varchar(100) NULL,
	CONSTRAINT pk_skill_level PRIMARY KEY (id)
);


-- public.booking definition

-- Drop table

-- DROP TABLE public.booking;

CREATE TABLE public.booking (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	start_date_time timestamptz NOT NULL,
	end_date_time timestamptz NOT NULL,
	location_id int4 NULL,
	CONSTRAINT pk_booking PRIMARY KEY (id),
	CONSTRAINT fk_booking_1 FOREIGN KEY (location_id) REFERENCES public."location"(id)
);


-- public.person definition

-- Drop table

-- DROP TABLE public.person;

CREATE TABLE public.person (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	person_number varchar(12) NOT NULL,
	"name" varchar(100) NOT NULL,
	address varchar(100) NULL,
	phone_number varchar(20) NULL,
	email varchar(100) NULL,
	sibling_group_id int4 NULL,
	CONSTRAINT pk_person PRIMARY KEY (id),
	CONSTRAINT fk_person_0 FOREIGN KEY (sibling_group_id) REFERENCES public.person(id)
);


-- public.rentable_instrument definition

-- Drop table

-- DROP TABLE public.rentable_instrument;

CREATE TABLE public.rentable_instrument (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	brand varchar(100) NULL,
	model varchar(100) NULL,
	price int4 NOT NULL,
	instrument_type_id int4 NOT NULL,
	CONSTRAINT pk_rentable_instrument PRIMARY KEY (id),
	CONSTRAINT fk_rentable_instrument_0 FOREIGN KEY (instrument_type_id) REFERENCES public.instrument_type(id)
);


-- public.student definition

-- Drop table

-- DROP TABLE public.student;

CREATE TABLE public.student (
	person_id int4 NOT NULL,
	skill_level_id int4 NOT NULL,
	CONSTRAINT pk_student PRIMARY KEY (person_id),
	CONSTRAINT fk_student_0 FOREIGN KEY (person_id) REFERENCES public.person(id),
	CONSTRAINT fk_student_1 FOREIGN KEY (skill_level_id) REFERENCES public.skill_level(id)
);


-- public.student_instruments definition

-- Drop table

-- DROP TABLE public.student_instruments;

CREATE TABLE public.student_instruments (
	instrument_type_id int4 NOT NULL,
	person_id int4 NOT NULL,
	CONSTRAINT pk_student_instruments PRIMARY KEY (instrument_type_id, person_id),
	CONSTRAINT fk_student_instruments_0 FOREIGN KEY (instrument_type_id) REFERENCES public.instrument_type(id),
	CONSTRAINT fk_student_instruments_1 FOREIGN KEY (person_id) REFERENCES public.student(person_id)
);


-- public.contact_person definition

-- Drop table

-- DROP TABLE public.contact_person;

CREATE TABLE public.contact_person (
	person_id int4 NOT NULL,
	contact_id int4 NOT NULL,
	CONSTRAINT pk_contact_persons PRIMARY KEY (person_id, contact_id),
	CONSTRAINT fk_contact_persons_0 FOREIGN KEY (person_id) REFERENCES public.person(id),
	CONSTRAINT fk_contact_persons_1 FOREIGN KEY (contact_id) REFERENCES public.person(id)
);


-- public.instructor definition

-- Drop table

-- DROP TABLE public.instructor;

CREATE TABLE public.instructor (
	person_id int4 NOT NULL,
	CONSTRAINT pk_instructor PRIMARY KEY (person_id),
	CONSTRAINT fk_instructor_0 FOREIGN KEY (person_id) REFERENCES public.person(id)
);


-- public.instructor_available_times definition

-- Drop table

-- DROP TABLE public.instructor_available_times;

CREATE TABLE public.instructor_available_times (
	person_id int4 NOT NULL,
	start_date_time timestamptz NOT NULL,
	end_date_time timestamptz NOT NULL,
	instrument_type_id int4 NULL,
	skill_level_id int4 NULL,
	id int4 GENERATED ALWAYS AS IDENTITY NOT NULL,
	CONSTRAINT instructor_available_times_pk PRIMARY KEY (id),
	CONSTRAINT fk_instructor_available_times_0 FOREIGN KEY (person_id) REFERENCES public.instructor(person_id),
	CONSTRAINT fk_instructor_available_times_1 FOREIGN KEY (instrument_type_id) REFERENCES public.instrument_type(id),
	CONSTRAINT fk_instructor_available_times_2 FOREIGN KEY (skill_level_id) REFERENCES public.skill_level(id)
);


-- public.lease definition

-- Drop table

-- DROP TABLE public.lease;

CREATE TABLE public.lease (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	start_time timestamptz NOT NULL,
	end_time timestamptz NULL,
	rentable_instrument_id int4 NOT NULL,
	person_id int4 NOT NULL,
	CONSTRAINT pk_lease PRIMARY KEY (id),
	CONSTRAINT fk_lease_0 FOREIGN KEY (rentable_instrument_id) REFERENCES public.rentable_instrument(id),
	CONSTRAINT fk_lease_1 FOREIGN KEY (person_id) REFERENCES public.student(person_id)
);


-- public.lesson definition

-- Drop table

-- DROP TABLE public.lesson;

CREATE TABLE public.lesson (
	min int4 NULL,
	max int4 NULL,
	pricing_scheme_id int4 NOT NULL,
	person_id int4 NULL,
	booking_id int4 NOT NULL,
	CONSTRAINT lesson_pk PRIMARY KEY (booking_id),
	CONSTRAINT fk_lesson_0 FOREIGN KEY (pricing_scheme_id) REFERENCES public.pricing_scheme(id),
	CONSTRAINT fk_lesson_1 FOREIGN KEY (person_id) REFERENCES public.instructor(person_id),
	CONSTRAINT lesson_booking_fk FOREIGN KEY (booking_id) REFERENCES public.booking(id)
);


-- public.enrollment definition

-- Drop table

-- DROP TABLE public.enrollment;

CREATE TABLE public.enrollment (
	lesson_id int4 NOT NULL,
	person_id int4 NOT NULL,
	CONSTRAINT pk_enrollment PRIMARY KEY (lesson_id, person_id),
	CONSTRAINT fk_enrollment_0 FOREIGN KEY (lesson_id) REFERENCES public.lesson(booking_id),
	CONSTRAINT fk_enrollment_1 FOREIGN KEY (person_id) REFERENCES public.student(person_id)
);


-- public.ensemble definition

-- Drop table

-- DROP TABLE public.ensemble;

CREATE TABLE public.ensemble (
	lesson_id int4 NOT NULL,
	genre_id int4 NULL,
	CONSTRAINT pk_ensamble PRIMARY KEY (lesson_id),
	CONSTRAINT fk_ensamble_0 FOREIGN KEY (lesson_id) REFERENCES public.lesson(booking_id),
	CONSTRAINT fk_ensamble_1 FOREIGN KEY (genre_id) REFERENCES public.genre(id)
);


-- public.instrument_lesson definition

-- Drop table

-- DROP TABLE public.instrument_lesson;

CREATE TABLE public.instrument_lesson (
	lesson_id int4 NOT NULL,
	skill_level_id int4 NOT NULL,
	instrument_type_id int4 NOT NULL,
	CONSTRAINT pk_instrument_lesson PRIMARY KEY (lesson_id),
	CONSTRAINT fk_instrument_lesson_0 FOREIGN KEY (lesson_id) REFERENCES public.lesson(booking_id),
	CONSTRAINT fk_instrument_lesson_1 FOREIGN KEY (skill_level_id) REFERENCES public.skill_level(id),
	CONSTRAINT fk_instrument_lesson_2 FOREIGN KEY (instrument_type_id) REFERENCES public.instrument_type(id)
);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('356164407167','Dieter Hewitt','Ap #949-5346 Tempus, Av.','+4675911268','torquent.per.conubia@yahoo.org',1);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('529614662717','Gareth Rosales','P.O. Box 717, 7223 Donec Rd.','+4647132364','sed.turpis@aol.com',2);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('642073693544','Wylie George','P.O. Box 903, 6933 Sed Av.','+4639940822','scelerisque.scelerisque@yahoo.couk',3);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('855126562986','Lacy Fernandez','Ap #402-8950 Morbi Av.','+4692274301','arcu@yahoo.com',4);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('383351445154','Blake Howell','411-8185 Sed St.','+4684408618','tellus.justo@protonmail.net',5);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('422852753643','Nicholas Gilmore','938-5526 Erat Avenue','+4645773335','donec.tempor.est@protonmail.org',6);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('662922865678','Gareth Jenkins','273-5707 Donec Rd.','+4657032130','congue@yahoo.com',7);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('054683446563','Amery Jordan','Ap #976-4624 Vel, St.','+4696506451','class.aptent.taciti@protonmail.couk',8);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('363855319432','Chadwick Austin','Ap #106-4277 Aenean Av.','+4664022011','ante.nunc.mauris@outlook.net',9);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('742863648657','Warren Le','8460 Eget, Rd.','+4648141767','metus.sit@hotmail.ca',10);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('260796446163','Nichole Juarez','P.O. Box 465, 5763 Ultrices Rd.','+4689701073','aliquam.iaculis@icloud.edu',11);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('474867702376','Rina Perry','3272 Donec Street','+4682203772','neque.sed.sem@hotmail.org',12);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('441656534813','Lacey Adkins','Ap #164-5462 Dapibus Av.','+4674567948','semper.pretium@protonmail.edu',13);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('345882632944','Armando Decker','315-6499 Sociis Avenue','+4661165677','blandit.congue@yahoo.ca',14);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('858608248786','Yoshi Burt','Ap #968-1713 Etiam Av.','+4687615476','adipiscing.lobortis@aol.com',15);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('781567165265','Latifah Schmidt','5033 Fusce Rd.','+4646068518','volutpat@hotmail.ca',16);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('013868566185','Yasir Waters','407-1384 Urna, Rd.','+4673355315','tellus.nunc.lectus@hotmail.org',17);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('728062702756','Xena Abbott','Ap #238-1362 Tincidunt Ave','+4622680737','massa@yahoo.couk',18);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('614757216252','Lawrence Bauer','P.O. Box 915, 1050 Dignissim St.','+4623951616','eu.dui@aol.couk',19);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('212083485936','Anthony Moss','Ap #575-5716 Dolor Rd.','+4606802124','nec.euismod.in@protonmail.ca',3);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('954782244715','Elton Watkins','7843 Amet Av.','+4683228426','ipsum.dolor@hotmail.org',21);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('259307521324','Alma Hunt','P.O. Box 394, 2217 Lorem Road','+4633268536','accumsan.sed@icloud.edu',22);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('310871987167','Susan Short','P.O. Box 206, 5227 Ligula. Street','+4658716335','odio.semper.cursus@yahoo.org',23);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('241116975081','Damian Robbins','4601 Quisque Street','+4648632139','nullam.ut.nisi@hotmail.org',24);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('744484267312','Henry Horne','355-8766 Magnis Road','+4612844982','ligula@google.ca',25);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('575351761532','Winifred Huff','P.O. Box 587, 8213 Pede. Avenue','+4699726730','pede.blandit@yahoo.com',26);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('272738731016','Audra Ballard','954-9266 Molestie Street','+4650195288','eros.non@protonmail.couk',27);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('912623853694','Astra Kane','P.O. Box 543, 4796 Id, Road','+4631108183','lectus@outlook.edu',28);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('520120516567','Deirdre Mcknight','893-7676 Et Avenue','+4615647827','vestibulum.mauris@protonmail.com',29);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('121836572443','Steel Emerson','8145 Etiam Road','+4661853924','aliquam.vulputate@icloud.ca',30);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('143584426438','Rajah Estrada','565-815 Ligula. Street','+4623185819','dictum.proin@outlook.com',31);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('788446126663','Nash Porter','Ap #755-6825 Massa. Ave','+4645080051','ut.sem@icloud.com',32);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('187227784223','Gavin Moody','652-5325 Tortor St.','+4663534741','ligula.aenean@aol.edu',33);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('371796868535','Adena Burns','P.O. Box 503, 4624 Est, St.','+4668483559','erat@protonmail.net',34);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('108706487819','Ignacia Glover','Ap #433-3552 Aliquam Rd.','+4665225978','libero.dui@outlook.net',35);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('337343219868','Vladimir Cote','Ap #978-3336 Sed Ave','+4695369474','euismod.mauris@protonmail.couk',36);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('668540857895','Roanna Weeks','Ap #165-2251 Vestibulum St.','+4676596659','massa.non@outlook.edu',37);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('228971552581','Dacey Buck','3144 Non St.','+4683428853','eget.nisi@yahoo.org',38);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('575467149574','Lionel Brock','839 Leo. Rd.','+4616172348','ac.mattis@outlook.edu',39);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('477546603365','Laura Rojas','Ap #740-1344 Vitae, Road','+4668543460','eu.enim@outlook.com',40);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('326437474868','Aimee William','267-8624 Eros Ave','+4671128555','lectus.justo@hotmail.net',41);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('808549148144','Inez Bond','1961 Erat Ave','+4608481653','vel.pede@google.net',42);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('923416336907','Hayfa Randolph','5715 In Rd.','+4612575196','quam.curabitur@aol.net',43);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('436703593638','Erica Stevenson','503-7195 Habitant Rd.','+4648352369','ac.arcu@google.com',44);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('928755655864','Willa Sanchez','183-8311 Felis Rd.','+4672813310','a.enim@yahoo.couk',45);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('692474443916','Neil Conner','548-7039 Est, Avenue','+4627824855','mi.duis@hotmail.org',46);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('223224647328','Ryder Flowers','3995 Dictum. Rd.','+4636875315','tincidunt.adipiscing.mauris@yahoo.com',47);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('024665526725','Keefe Riley','Ap #300-1509 Donec St.','+4627888638','ipsum.ac@protonmail.couk',48);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('518564148798','Kiayada Chaney','813-2342 Elit, Street','+4616416434','velit.eu@aol.net',49);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('867852548534','Hop Bray','730 Aliquam Avenue','+4644756207','mauris@google.org',50);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('540468415145','Holmes Guzman','6445 Ante. Rd.','+4676777714','suspendisse.aliquet@hotmail.edu',51);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('766223839238','Benjamin Mcdowell','Ap #228-5194 Sit St.','+4637470600','urna.vivamus@aol.edu',52);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('383463127446','Charissa Marsh','8964 Donec Avenue','+4663819373','quis.tristique@google.org',50);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('873202034116','Hall Anthony','2606 Orci Avenue','+4627836736','blandit@protonmail.edu',54);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('897456884125','Cora Blackwell','318-8387 Molestie Avenue','+4602536265','non@protonmail.edu',55);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('258860456260','Louis Hutchinson','P.O. Box 335, 3665 Ultricies Rd.','+4655531131','id.enim.curabitur@protonmail.edu',56);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('868562368512','Lois Richardson','5127 Nascetur Avenue','+4610951732','urna@aol.edu',57);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('551630102933','Rana Rice','2774 Enim Avenue','+4628824759','bibendum.fermentum.metus@hotmail.com',58);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('839642546765','Eleanor Morris','316-249 Pellentesque Street','+4634378263','integer.aliquam@icloud.edu',59);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('836897811695','Mikayla Sanders','Ap #248-4761 Proin Rd.','+4642747213','tortor@icloud.org',60);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('435762833691','Alea Richardson','Ap #805-534 Integer Avenue','+4613632264','mauris@hotmail.org',61);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('765188291336','Garrison Hammond','137-9283 Neque Ave','+4667342146','proin.vel@protonmail.edu',62);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('641478861184','Odysseus Hughes','P.O. Box 699, 6850 Tincidunt Street','+4672714218','dolor@yahoo.com',63);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('824767513527','Melinda Riddle','P.O. Box 757, 1897 Mollis Avenue','+4647218384','ut@outlook.org',64);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('139534393626','Emma Charles','7837 Maecenas Road','+4647571867','sed.facilisis@protonmail.ca',65);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('506613436820','Rhona Mathews','Ap #421-5480 Aptent St.','+4626047388','lectus.a.sollicitudin@hotmail.org',66);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('254512631474','Brooke Duncan','724-8401 Rutrum Rd.','+4645473477','orci.in@hotmail.net',67);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('553748892893','Channing Larson','P.O. Box 456, 3286 Dui, Rd.','+4648277817','quis.diam.luctus@hotmail.com',68);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('973394417844','Eric Vang','Ap #858-8719 Vehicula. Ave','+4621698171','risus.donec.egestas@outlook.edu',69);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('455118721887','Noah Frost','295-1596 Lectus. St.','+4645183864','mus.aenean@outlook.couk',70);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('680188626483','Dacey Hansen','7002 Sit St.','+4628264782','parturient.montes.nascetur@hotmail.ca',71);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('865243286027','Buckminster Rowland','Ap #360-7215 Ridiculus St.','+4676844687','sit.amet.metus@aol.org',72);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('786228466905','Burton Sims','281-1997 Diam. St.','+4673347888','tincidunt.pede@google.ca',73);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('537675258675','Shelley Travis','Ap #140-4987 Pede St.','+4663640742','dolor.nonummy.ac@yahoo.net',74);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('910455736641','Hunter Gould','968-3752 Justo Av.','+4675361457','facilisis.vitae.orci@google.edu',75);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('052670849889','Xena Sloan','P.O. Box 490, 6670 Risus. Rd.','+4688932346','nulla.facilisis.suspendisse@icloud.ca',76);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('226902165736','Xenos Wagner','Ap #886-5300 Orci, Avenue','+4611084455','etiam.imperdiet@hotmail.net',77);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('525628084753','Joel Trujillo','Ap #312-3683 Sodales Avenue','+4644007395','auctor.quis.tristique@protonmail.org',78);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('252429728483','Craig Henry','Ap #745-2642 Et, Av.','+4606159101','nisi.nibh@protonmail.ca',37);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('313592601548','Alexander Mann','Ap #302-6201 Nibh. Avenue','+4637452999','viverra.maecenas@protonmail.edu',80);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('758562261892','Ali Suarez','765-7626 Aenean Rd.','+4668624470','sem.vitae@icloud.org',81);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('343688011907','Tamara Barrett','P.O. Box 672, 8786 Rutrum Street','+4644795866','volutpat@google.edu',82);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('652939568375','Fredericka Becker','479-7265 Semper St.','+4686824834','elementum.at@hotmail.net',83);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('415812663433','Orla Hughes','Ap #524-299 Ipsum Av.','+4621578683','ultrices@hotmail.com',84);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('843469727563','Sybill Lee','P.O. Box 270, 4540 Lacus, St.','+4680507495','vitae.posuere@aol.ca',85);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('767384885604','Garth Pope','Ap #534-5746 Donec St.','+4648381395','lobortis.risus.in@protonmail.com',86);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('174583738728','George Case','5194 Libero St.','+4681241392','arcu@yahoo.ca',87);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('763734893931','Deacon Olsen','4520 Aliquam Rd.','+4616556545','vulputate.eu@google.com',88);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('285474779249','Chloe Montgomery','268-869 Luctus, Street','+4622494038','sapien.cras@outlook.org',89);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('459690781190','Ariana Stanton','517-6658 Risus. Road','+4692188187','iaculis.enim@aol.ca',90);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('406742602747','Price Summers','830-8037 Interdum St.','+4687671601','faucibus.orci@protonmail.couk',91);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('538352389544','Unity Perkins','363-9170 At, Av.','+4635362452','venenatis.lacus@hotmail.com',92);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('487778147276','Quinn Clay','Ap #593-2508 Ante Rd.','+4685653666','sociis.natoque.penatibus@outlook.net',93);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('737924644245','Xavier Henry','Ap #625-2823 Vel St.','+4643186771','pharetra.ut@google.com',94);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('054342632847','Branden Blankenship','476-4122 Sollicitudin Avenue','+4685353381','euismod@outlook.edu',95);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('217442025787','Neve Montgomery','Ap #857-8283 Quam Avenue','+4638582588','enim.nec.tempus@icloud.edu',96);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('115135832022','Dieter Branch','P.O. Box 790, 6939 Imperdiet Ave','+4626441171','laoreet.lectus@hotmail.net',97);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('748225568872','Hiram Willis','Ap #287-3757 Amet Av.','+4677068714','nascetur.ridiculus@icloud.net',98);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('628566151714','Madaline Barlow','604-6203 Magnis Street','+4653263947','euismod.in.dolor@google.net',99);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('915722323318','Beatrice Guerra','Ap #728-6419 Sed Rd.','+4600836914','ultrices.mauris.ipsum@outlook.edu',100);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('646608473623','Kelly Mccarty','P.O. Box 609, 2100 Facilisis St.','+4627247156','facilisis.vitae@outlook.org',101);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('684746283777','Porter Newton','8203 Vestibulum. Road','+4688543333','molestie.in.tempus@yahoo.edu',102);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('796269870630','Roanna Garrison','849-9100 Massa St.','+4687204679','ut@google.org',103);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('143158539153','Ashely Goodwin','Ap #758-5797 Consequat, Ave','+4684812604','egestas.fusce@icloud.com',104);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('643135793154','Forrest Conner','225-8240 Aliquam St.','+4630847242','sem.eget.massa@google.ca',105);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('161186877534','Courtney Olson','3698 Integer St.','+4686600257','lacus.quisque@outlook.com',106);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('105894418274','Damon Rivera','Ap #181-7658 Faucibus Av.','+4656815638','amet.ultricies@yahoo.com',107);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('217266597969','Samantha Beck','426-9689 Auctor, Ave','+4614921643','iaculis.enim.sit@yahoo.ca',108);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('525763245605','Lawrence Davenport','Ap #293-8661 Vestibulum, St.','+4604536700','duis.sit.amet@icloud.org',109);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('759747639166','Thane Clay','319-6517 Praesent Avenue','+4616331647','felis.eget@hotmail.org',110);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('150828215457','Fiona Warner','Ap #260-6318 Dictum Ave','+4634443133','curae.phasellus@hotmail.edu',111);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('566143827858','Isadora Deleon','766-6573 Convallis St.','+4654354187','accumsan.neque@icloud.couk',112);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('288856623274','Forrest Ray','Ap #205-381 Magna Avenue','+4654153044','mauris.integer@icloud.org',113);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('136546125134','David Atkinson','718-2100 Phasellus Av.','+4632309321','conubia.nostra@icloud.ca',114);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('231502312940','Nora Giles','183-6843 Semper Road','+4642513472','ipsum.leo@outlook.ca',115);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('587218183746','Lane Duke','Ap #185-3128 Nec St.','+4695712315','erat@icloud.com',116);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('316254755734','MacKensie Calhoun','336-2265 Nullam Road','+4643724346','sed@google.org',117);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('346841829597','Isaiah Finley','Ap #280-8963 Placerat Rd.','+4645044843','fermentum.vel@aol.com',118);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('188807447433','Indira Lester','P.O. Box 934, 9001 Purus. Av.','+4624797494','id@yahoo.edu',119);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('051143705326','Leslie Fisher','P.O. Box 909, 7234 Ipsum St.','+4647862454','eget.odio@yahoo.com',120);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('548833121531','Linda Logan','8136 Semper. Ave','+4605227469','porttitor@aol.com',121);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('453496887185','Ria Soto','Ap #715-7780 Mauris St.','+4655978429','mi@yahoo.couk',122);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('567181972733','Colleen Wagner','Ap #116-2125 Mauris Ave','+4614913665','morbi@outlook.net',123);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('722626366433','Demetria Ware','835-710 Luctus Road','+4667156242','metus.urna@protonmail.com',124);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('947582478544','Hedwig Montoya','Ap #516-9526 Varius Street','+4622778622','libero.proin@protonmail.com',125);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('917223366582','Allegra Travis','387-4785 Odio Rd.','+4666264417','ullamcorper.nisl.arcu@hotmail.edu',126);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('767852791344','Brynne Mcclure','6868 Arcu St.','+4698963817','ornare.lectus.justo@outlook.ca',127);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('160906252056','Cedric Norton','P.O. Box 146, 3192 Adipiscing, St.','+4665476664','placerat.cras@google.com',128);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('233378440434','Tad Stewart','826-8841 Nisi. Avenue','+4637347851','tempor.lorem@google.com',129);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('114153839241','Unity Bender','Ap #871-7440 Risus. Rd.','+4675457034','sed.dui.fusce@aol.com',130);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('226175562131','Mira Rowland','826-6523 Aliquet St.','+4698384037','at@hotmail.couk',131);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('596627704246','Otto Shepard','Ap #593-8020 Urna. Rd.','+4670788131','etiam.ligula.tortor@aol.com',132);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('226281366717','Holmes Ward','568 Integer Avenue','+4641494217','ultricies.ligula@hotmail.edu',133);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('643524480366','Trevor Mcdowell','P.O. Box 866, 3086 Quam Street','+4642688808','vitae@protonmail.edu',134);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('763682501812','Leila Craig','105-9531 Ridiculus Rd.','+4630758616','velit.dui.semper@google.net',135);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('952326711091','Zeph Faulkner','Ap #570-5393 Adipiscing, Road','+4685435565','mollis@icloud.edu',136);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('124031733980','Basia Buckner','210-3451 Eget, Street','+4637557313','aliquam.erat@icloud.org',137);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('155012107168','Rowan Flowers','998 Dolor Ave','+4636177763','mauris.sit.amet@icloud.edu',65);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('313935928732','Riley Peters','198-688 Eu, Rd.','+4601461131','nec.imperdiet.nec@outlook.com',65);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('815136957065','Susan Wynn','P.O. Box 930, 8048 Sit Avenue','+4605615861','mollis.non@yahoo.ca',140);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('165458656058','Cameron Graves','4940 Neque Ave','+4620176832','pellentesque.tellus@aol.net',141);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('180147714750','Jack Gonzalez','Ap #776-6133 Aliquam Ave','+4626852598','lacus.varius@aol.com',142);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('224562333519','Nissim Griffin','Ap #228-9401 Nec, Road','+4624297764','amet.metus.aliquam@outlook.org',143);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('435881383183','Aaron Mcguire','898 Nisi. St.','+4604933085','cras.eu@yahoo.net',144);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('864249268186','Elmo Hall','292-8591 Sed Avenue','+4651381758','nulla.dignissim@icloud.edu',145);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('243283884319','Shana Fowler','468-6968 Vulputate St.','+4618368234','vitae.odio@protonmail.org',146);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('715579092896','Emery Stokes','Ap #451-2392 Tempus Rd.','+4615347272','fusce.mi@aol.org',147);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('850606246784','Stephanie Salazar','254-1235 Semper Avenue','+4618025779','molestie.dapibus@yahoo.couk',148);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('432576787492','Kaye Welch','Ap #306-2582 Tincidunt St.','+4662371555','aliquam.eu@outlook.edu',149);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('515861566482','Tanek Vang','231-3142 Proin Ave','+4622232887','ante.lectus.convallis@hotmail.couk',150);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('170812305534','Chanda Hamilton','700-699 Gravida St.','+4668410475','odio@icloud.edu',151);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('227433646926','Jeremy Mcintosh','Ap #133-4926 Vivamus Street','+4657438142','sed.pharetra@protonmail.couk',152);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('613292566506','Eric Marquez','P.O. Box 479, 6661 Magna. Rd.','+4666351252','lacus.pede@outlook.edu',153);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('722874304878','Catherine Parsons','Ap #547-7626 At, Rd.','+4607377190','vel.nisl@outlook.couk',154);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('703253188584','Colin Adams','186-7546 Non, St.','+4691473126','senectus.et@protonmail.org',155);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('821406371891','Driscoll Levine','Ap #952-4072 Natoque Street','+4681986465','aliquet@google.com',156);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('748059074774','Sara Dotson','Ap #529-6091 Est, Avenue','+4614826967','velit.in@icloud.com',157);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('571338436779','Savannah Vinson','P.O. Box 814, 9771 At, Avenue','+4606247713','non@yahoo.ca',158);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('594548289857','Quemby Robertson','P.O. Box 752, 8164 Etiam Av.','+4652228682','sit.amet@google.com',159);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('523172432471','Kai Mayo','343-4984 Amet Rd.','+4674968744','vel.nisl@protonmail.net',160);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('622576722070','Barry Camacho','484-4004 Odio Rd.','+4654511877','quis@protonmail.edu',161);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('131375304482','Stacy Finch','818 Cursus Avenue','+4645288172','nec@google.ca',162);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('122819313426','Solomon Deleon','Ap #991-6205 Eget St.','+4638300241','convallis.est@outlook.edu',163);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('678848394427','Ronan Goff','Ap #977-8750 Vulputate St.','+4621609512','feugiat@protonmail.org',164);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('250984326853','Yeo Bailey','Ap #695-8355 Massa. St.','+4689811135','rutrum@yahoo.net',165);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('082381264782','Hyatt Owen','Ap #201-4003 Pede, Av.','+4653588790','aliquet.metus@yahoo.net',166);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('286617735914','Tanner Burgess','Ap #694-6739 Gravida Av.','+4686641344','erat@yahoo.net',167);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('695174473729','Dana Barrett','651-4066 Eros St.','+4657058439','amet.ante@protonmail.ca',168);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('578736914483','Aspen Frye','Ap #417-8014 Amet Av.','+4670521534','enim.gravida.sit@hotmail.ca',169);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('176418345711','Joel Combs','Ap #854-2369 Dolor, Rd.','+4650102834','congue.turpis.in@icloud.couk',170);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('112034317164','Flynn Simmons','761-170 Est. St.','+4661144042','pede.et@hotmail.edu',171);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('779622131210','Tasha Sherman','277-3067 Libero Av.','+4684834136','odio.nam@protonmail.com',172);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('648660319492','Brett Avery','7649 Leo St.','+4673475543','cursus.in.hendrerit@protonmail.edu',173);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('214735892163','Clio Burton','330-2492 Lorem Rd.','+4674513160','sed.libero.proin@hotmail.com',174);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('520143418696','Barclay Rowland','616-7788 Lacus, St.','+4662711478','ac.libero@google.net',175);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('832559763181','Nash Mitchell','P.O. Box 141, 1970 A Ave','+4676427121','tellus.faucibus@google.ca',176);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('976625417731','Summer Ruiz','1010 Augue Rd.','+4653033647','ac.nulla@icloud.com',177);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('194530157253','Diana Fuentes','890-3977 Dis Street','+4647353315','semper.cursus@hotmail.couk',178);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('676175835574','Hashim Roy','5484 Nec Rd.','+4694616948','elementum.lorem@protonmail.com',179);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('280035231597','Henry Merritt','166 Elit Road','+4698343483','duis@google.org',173);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('413985473562','Valentine Mccullough','Ap #577-652 Ipsum Rd.','+4653523565','donec@protonmail.edu',181);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('422469482261','Ryan Valenzuela','Ap #467-4911 Est, Ave','+4675284031','hendrerit@hotmail.org',182);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('132835771240','Garth Melendez','375-1328 Dolor Av.','+4663853843','diam@google.org',183);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('627731479202','Reagan Parsons','Ap #302-8055 Nunc, Road','+4657718464','donec.nibh@icloud.couk',184);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('475225210146','Autumn Diaz','255-5950 Quisque St.','+4667584552','vulputate.eu@outlook.com',185);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('155898225650','Patience Tyson','838-2316 Morbi Rd.','+4651072731','enim@aol.org',186);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('460648315742','Driscoll Rasmussen','2974 Eu, St.','+4688236392','dapibus.rutrum.justo@yahoo.com',187);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('581565376473','Maggy Cash','774 Mus. St.','+4681256920','per.inceptos@outlook.couk',3);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('267950346872','Cullen Moore','Ap #910-4848 Quis Rd.','+4684752267','sed@icloud.edu',189);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('703355426695','Brianna Summers','Ap #150-2311 Urna Rd.','+4668543486','a.magna@outlook.com',190);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('681544415138','Zephania Carlson','Ap #602-3814 Vulputate Avenue','+4648907594','consectetuer.cursus.et@hotmail.edu',191);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('568828124858','Fulton Nguyen','704-6728 Eleifend Rd.','+4600787400','vestibulum.neque@google.couk',192);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('971580802868','Barclay Higgins','P.O. Box 691, 8861 Pretium Ave','+4688444521','montes@protonmail.org',193);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('420211865530','Noelle Cox','P.O. Box 211, 813 Taciti Rd.','+4686782356','aliquam.arcu@yahoo.net',194);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('346215428724','Bo Warner','568-8003 Neque Rd.','+4637979526','parturient@icloud.edu',195);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('752364308486','Larissa Herring','987-3431 Orci. Rd.','+4621787632','consequat.auctor@protonmail.net',196);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('796224865865','Indigo Phelps','P.O. Box 967, 6806 Lorem, Street','+4614165898','erat.etiam.vestibulum@aol.net',197);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('060327328285','Kylie Morse','Ap #657-6529 In Street','+4635764224','primis.in@google.couk',198);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('680618643278','Stephanie Floyd','Ap #706-6117 Odio. Rd.','+4612231824','sed.pede@hotmail.edu',199);
INSERT INTO public.person (person_number,"name",address,phone_number,email,sibling_group_id) VALUES
	('460451929748','Elvis Carrillo','6597 Sollicitudin Rd.','+4635775086','mauris.molestie@hotmail.org',200);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (140,187),
	 (170,115),
	 (34,191),
	 (31,20),
	 (186,46),
	 (81,98),
	 (86,95),
	 (116,128),
	 (114,121),
	 (109,85);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (130,189),
	 (6,115),
	 (84,23),
	 (127,156),
	 (33,70),
	 (56,125),
	 (138,65),
	 (15,36),
	 (117,86),
	 (3,143);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (30,53),
	 (102,91),
	 (165,8),
	 (7,81),
	 (90,59),
	 (111,188),
	 (80,64),
	 (90,184),
	 (182,84),
	 (9,159);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (110,150),
	 (164,163),
	 (55,46),
	 (123,115),
	 (105,19),
	 (123,77),
	 (129,107),
	 (174,169),
	 (85,29),
	 (39,136);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (151,76),
	 (187,187),
	 (165,29),
	 (77,159),
	 (109,63),
	 (197,42),
	 (190,19),
	 (73,145),
	 (27,140),
	 (142,199);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (84,15),
	 (3,3),
	 (126,76),
	 (38,28),
	 (86,34),
	 (91,31),
	 (139,161),
	 (110,40),
	 (141,182),
	 (30,185);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (141,146),
	 (159,23),
	 (195,78),
	 (129,85),
	 (158,147),
	 (177,153),
	 (26,107),
	 (155,135),
	 (71,200),
	 (5,59);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (7,105),
	 (25,82),
	 (57,107),
	 (3,125),
	 (122,185),
	 (74,61),
	 (118,55),
	 (191,122),
	 (45,49),
	 (97,60);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (68,154),
	 (146,3),
	 (109,185),
	 (10,134),
	 (76,64),
	 (4,12),
	 (41,18),
	 (54,178),
	 (100,41),
	 (49,97);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (176,83),
	 (151,14),
	 (22,179),
	 (17,9),
	 (171,91),
	 (5,23),
	 (107,88),
	 (161,168),
	 (183,107),
	 (90,85);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (137,32),
	 (51,3),
	 (60,112),
	 (172,30),
	 (187,15),
	 (46,2),
	 (127,6),
	 (167,41),
	 (153,4),
	 (83,69);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (92,160),
	 (145,36),
	 (130,57),
	 (17,64),
	 (92,65),
	 (133,156),
	 (167,35),
	 (48,50),
	 (97,151),
	 (172,42);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (50,86),
	 (157,183),
	 (142,121),
	 (6,116),
	 (21,185),
	 (33,135),
	 (120,84),
	 (15,118),
	 (59,90),
	 (20,22);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (118,23),
	 (85,89),
	 (105,18),
	 (45,164),
	 (22,103),
	 (87,60),
	 (159,190),
	 (88,45),
	 (81,174),
	 (91,84);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (52,104),
	 (85,42),
	 (125,146),
	 (95,59),
	 (27,39),
	 (113,111),
	 (102,13),
	 (171,60),
	 (189,194),
	 (11,98);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (173,57),
	 (55,12),
	 (30,61),
	 (53,148),
	 (108,158),
	 (161,44),
	 (187,80),
	 (118,173),
	 (61,198),
	 (199,44);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (195,54),
	 (182,70),
	 (166,36),
	 (123,118),
	 (96,7),
	 (134,112),
	 (127,104),
	 (44,131),
	 (11,172),
	 (99,197);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (153,34),
	 (19,110),
	 (72,47),
	 (3,9),
	 (76,165),
	 (124,4),
	 (140,35),
	 (68,62),
	 (156,95),
	 (159,101);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (57,30),
	 (78,29),
	 (167,2),
	 (2,110),
	 (152,96),
	 (16,70),
	 (167,128),
	 (54,23),
	 (50,137),
	 (75,117);
INSERT INTO public.contact_person (person_id,contact_id) VALUES
	 (127,133),
	 (88,70),
	 (44,110),
	 (27,95),
	 (62,9),
	 (133,69),
	 (94,18),
	 (110,199),
	 (12,24),
	 (123,123);
INSERT INTO public.genre (genre) VALUES
	 ('Classical'),
	 ('Jazz'),
	 ('Funk'),
	 ('Rock');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Afoxé'),
	 ('Agogô'),
	 ('Agung'),
	 ('Angklung'),
	 ('Babendil'),
	 ('Bak'),
	 ('Balafon'),
	 ('Batá drum'),
	 ('Cabasa'),
	 ('Cajón');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Carillon'),
	 ('Castanets (Palillos)'),
	 ('Caxirola'),
	 ('Caxixi'),
	 ('Chácaras'),
	 ('Clapstick'),
	 ('Claves'),
	 ('Cowbell'),
	 ('Crotales'),
	 ('Cymbal');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Ferrinho'),
	 ('Flexatone'),
	 ('Octa-Vibraphone'),
	 ('Gandingan'),
	 ('Ghatam'),
	 ('Glockenspiel'),
	 ('Gong'),
	 ('Güiro'),
	 ('Handbells'),
	 ('Handpan');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Hang'),
	 ('Kalimba'),
	 ('Kayamb (Kayamba)'),
	 ('Kemanak'),
	 ('Khartal'),
	 ('Kouxian'),
	 ('Kulintang'),
	 ('Maraca'),
	 ('Marimba'),
	 ('Mbira');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Pate'),
	 ('Qairaq (Kairak)'),
	 ('Shekere'),
	 ('Slit drum'),
	 ('Spoon'),
	 ('Steelpan'),
	 ('Tambourine'),
	 ('Teponaztli'),
	 ('Triangle'),
	 ('Trash Tube');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Txalaparta'),
	 ('Vibraphone'),
	 ('Vibraslap'),
	 ('Washboard'),
	 ('Wood block'),
	 ('Wooden fish'),
	 ('Xylophone'),
	 ('Zill'),
	 ('Sandpaper blocks'),
	 ('Ekwe');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Agida'),
	 ('Alfaia'),
	 ('Apinti'),
	 ('Arobapá'),
	 ('Ashiko'),
	 ('Atabaque'),
	 ('Baboula'),
	 ('Balaban (drum)'),
	 ('Balsié'),
	 ('Bamboula');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Bara'),
	 ('Barrel drum'),
	 ('"Barriles'),
	 ('buleador'),
	 ('primo'),
	 ('repicador'),
	 ('subidor"'),
	 ('Bass drum'),
	 ('Bedug'),
	 ('Bodhrán');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Bongo drums'),
	 ('Boobam'),
	 ('"Candombe'),
	 ('chico'),
	 ('repique'),
	 ('piano"'),
	 ('"Chenda (Chande)'),
	 ('Uruttu chenda'),
	 ('Veekku chenda'),
	 ('Acchan chenda"');
INSERT INTO public.instrument_type ("type") VALUES
	 ('"Conga  (Tumbadora)'),
	 ('ricardo  (smallest)'),
	 ('requinto'),
	 ('quinto'),
	 ('conga'),
	 ('tumba'),
	 ('supertumba (largest)"'),
	 ('Cuíca'),
	 ('Culo''e puya'),
	 ('Cultrun');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Dabakan'),
	 ('Daf (Dap'),
	 ('Damaru'),
	 ('Davul (dhol'),
	 ('Dayereh'),
	 ('Den-den daiko'),
	 ('Dhak'),
	 ('Dhimay (Dhimaya)'),
	 ('Dhol'),
	 ('Dholak (Dholaki)');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Dimdi'),
	 ('Djembe'),
	 ('Dollu'),
	 ('Drum kit'),
	 ('Dunun  (Dundun)'),
	 ('Gran Cassa'),
	 ('Goblet drum'),
	 ('Gong bass drum'),
	 ('Hira-daiko'),
	 ('Idakka');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Ilimba drum'),
	 ('Ingoma'),
	 ('Shakwe'),
	 ('Inyahura'),
	 ('Igihumurizo"'),
	 ('Janggu (Janggo)'),
	 ('Junjung'),
	 ('Kakko'),
	 ('Kanjira'),
	 ('Kebero');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Kendang (Gendang)'),
	 ('Khol (Mrdanga)'),
	 ('Krakebs'),
	 ('Lambeg drum'),
	 ('Madhalam'),
	 ('Madal'),
	 ('Maddale'),
	 ('"Maktoum (maktoom)'),
	 ('Maram'),
	 ('Mirwas');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Mridangam'),
	 ('Nagara (drum)'),
	 ('Naqareh'),
	 ('Ney (flute)'),
	 ('O-daiko'),
	 ('Okedo-daiko'),
	 ('Octaban'),
	 ('Padayani thappu'),
	 ('Pakhavaj'),
	 ('Pandeiro');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Pandero'),
	 ('Parai'),
	 ('Qilaut'),
	 ('Rebana'),
	 ('Sabar'),
	 ('Sambal'),
	 ('Samphor'),
	 ('Shime-daiko'),
	 ('Snare drum'),
	 ('Surdo');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Tabla'),
	 ('Taiko'),
	 ('Talking drum'),
	 ('Tsukeshime-daiko'),
	 ('Tambor huacana'),
	 ('Tambori'),
	 ('Tamborim'),
	 ('Tamborita calentana (Mexico)'),
	 ('Tambou bas a dé fas'),
	 ('Tambou bas a yon fas');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Tan-tan'),
	 ('Taphon'),
	 ('Tar'),
	 ('Tbilat'),
	 ('Thavil'),
	 ('Timbales (Pailas)'),
	 ('Timpani (kettledrum)'),
	 ('Tom-tom drum'),
	 ('Tombak'),
	 ('Tsuzumi');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Tsuri-daiko'),
	 ('unpitched repique'),
	 ('Uchiwa-daiko'),
	 ('Celesta'),
	 ('Crystallophone'),
	 ('Glasschord'),
	 ('Glass harmonica'),
	 ('Hydraulophone'),
	 ('Plasmaphone'),
	 ('Pyrophone');
INSERT INTO public.instrument_type ("type") VALUES
	 ('Quintephone'),
	 ('"Asadullah (Meerut'),
	 ('Shishi odoshi (Japan)'),
	 ('Suikinkutsu (Japanese water zither)'),
	 ('Wobble board (Australia)');
INSERT INTO public."location" (location_place) VALUES
	 ('Ka-388'),
	 ('Ka-385'),
	 ('Ka-348'),
	 ('Ka-384'),
	 ('Ka-328'),
	 ('Ka-359'),
	 ('Ka-349'),
	 ('Ka-373'),
	 ('Ka-353'),
	 ('Ka-364');
INSERT INTO public."location" (location_place) VALUES
	 ('Ka-388'),
	 ('Ka-385'),
	 ('Ka-348'),
	 ('Ka-384'),
	 ('Ka-328'),
	 ('Ka-359'),
	 ('Ka-349'),
	 ('Ka-373'),
	 ('Ka-353'),
	 ('Ka-364');
INSERT INTO public."location" (location_place) VALUES
	 ('Ka-388'),
	 ('Ka-385'),
	 ('Ka-348'),
	 ('Ka-384'),
	 ('Ka-328'),
	 ('Ka-359'),
	 ('Ka-349'),
	 ('Ka-373'),
	 ('Ka-353'),
	 ('Ka-364');
INSERT INTO public."location" (location_place) VALUES
	 ('Ka-372'),
	 ('Ka-353'),
	 ('Ka-318'),
	 ('Ka-318'),
	 ('Ka-315'),
	 ('Ka-361'),
	 ('Ka-335'),
	 ('Ka-356'),
	 ('Ka-357'),
	 ('Ka-347');
INSERT INTO public.pricing_scheme (price,wage,sibling_discount) VALUES
	 (200,180,20),
	 (400,380,10);
INSERT INTO public.skill_level (skill_level) VALUES
	 ('Chomp'),
	 ('Beginner'),
	 ('Intermediate'),
	 ('Advanced'),
	 ('LITERALLY GOD');
INSERT INTO public.instructor (person_id) VALUES
	 (11),
	 (12),
	 (19),
	 (81);
INSERT INTO public.instructor_available_times (person_id,start_date_time,end_date_time,instrument_type_id,skill_level_id) VALUES
	 (12,'2025-09-22 00:00:00+02','2025-09-22 01:00:00+02',191,3),
	 (12,'2025-10-15 00:00:00+02','2025-10-15 01:00:00+02',79,2),
	 (81,'2024-12-17 00:00:00+01','2024-12-17 01:00:00+01',184,5),
	 (12,'2025-08-13 00:00:00+02','2025-08-13 01:00:00+02',116,4),
	 (19,'2024-06-08 00:00:00+02','2024-06-08 01:00:00+02',16,5),
	 (11,'2025-03-01 00:00:00+01','2025-03-01 01:00:00+01',190,5),
	 (81,'2025-05-04 00:00:00+02','2025-05-04 01:00:00+02',109,5),
	 (11,'2024-06-08 00:00:00+02','2024-06-08 01:00:00+02',59,5),
	 (19,'2025-11-09 00:00:00+01','2025-11-09 01:00:00+01',130,1),
	 (19,'2024-11-14 00:00:00+01','2024-11-14 01:00:00+01',190,3);
INSERT INTO public.instructor_available_times (person_id,start_date_time,end_date_time,instrument_type_id,skill_level_id) VALUES
	 (11,'2023-12-02 00:00:00+01','2023-12-02 01:00:00+01',45,4),
	 (12,'2024-07-23 00:00:00+02','2024-07-23 01:00:00+02',118,5),
	 (81,'2025-10-22 00:00:00+02','2025-10-22 01:00:00+02',144,5),
	 (19,'2025-05-28 00:00:00+02','2025-05-28 01:00:00+02',139,2),
	 (12,'2025-06-07 00:00:00+02','2025-06-07 01:00:00+02',71,3),
	 (11,'2024-08-02 00:00:00+02','2024-08-02 01:00:00+02',166,2),
	 (81,'2024-11-10 00:00:00+01','2024-11-10 01:00:00+01',163,2),
	 (12,'2024-03-05 00:00:00+01','2024-03-05 01:00:00+01',52,5),
	 (19,'2025-08-08 00:00:00+02','2025-08-08 01:00:00+02',104,2),
	 (19,'2025-04-18 00:00:00+02','2025-04-18 01:00:00+02',17,5);
INSERT INTO public.instructor_available_times (person_id,start_date_time,end_date_time,instrument_type_id,skill_level_id) VALUES
	 (19,'2024-08-18 00:00:00+02','2024-08-18 01:00:00+02',NULL,NULL),
	 (81,'2025-10-13 00:00:00+02','2025-10-13 01:00:00+02',NULL,NULL),
	 (11,'2024-08-10 00:00:00+02','2024-08-10 01:00:00+02',NULL,NULL),
	 (81,'2025-08-03 00:00:00+02','2025-08-03 01:00:00+02',NULL,NULL),
	 (12,'2024-02-17 00:00:00+01','2024-02-17 01:00:00+01',NULL,NULL),
	 (81,'2024-06-28 00:00:00+02','2024-06-28 01:00:00+02',NULL,NULL),
	 (19,'2025-11-15 00:00:00+01','2025-11-15 01:00:00+01',NULL,NULL),
	 (81,'2024-09-26 00:00:00+02','2024-09-26 01:00:00+02',NULL,NULL),
	 (19,'2024-12-16 00:00:00+01','2024-12-16 01:00:00+01',NULL,NULL),
	 (11,'2024-03-03 00:00:00+01','2024-03-03 01:00:00+01',NULL,NULL);
INSERT INTO public.student (person_id,skill_level_id) VALUES
	 (56,3),
	 (180,1),
	 (138,4),
	 (37,3),
	 (108,2),
	 (53,1),
	 (6,5),
	 (14,2),
	 (188,2),
	 (161,4);
INSERT INTO public.student (person_id,skill_level_id) VALUES
	 (65,2),
	 (192,4),
	 (47,3),
	 (173,3),
	 (88,4),
	 (20,3),
	 (26,3),
	 (49,4),
	 (186,4),
	 (79,5);
INSERT INTO public.student (person_id,skill_level_id) VALUES
	 (162,5),
	 (50,1),
	 (75,5),
	 (54,5),
	 (139,4),
	 (163,2),
	 (93,5),
	 (119,2),
	 (3,5),
	 (76,2);
INSERT INTO public.student_instruments (instrument_type_id,person_id) VALUES
	 (166,53),
	 (184,3),
	 (35,6),
	 (137,14),
	 (29,20),
	 (44,26),
	 (111,37),
	 (5,47),
	 (189,49),
	 (148,50);
INSERT INTO public.student_instruments (instrument_type_id,person_id) VALUES
	 (160,54),
	 (80,56),
	 (193,65),
	 (174,75),
	 (166,76),
	 (175,79),
	 (127,88),
	 (110,93),
	 (74,108),
	 (7,119);
INSERT INTO public.student_instruments (instrument_type_id,person_id) VALUES
	 (2,138),
	 (77,139),
	 (148,161),
	 (26,162),
	 (193,163),
	 (161,173),
	 (67,180),
	 (30,186),
	 (100,188),
	 (5,192);
INSERT INTO public.rentable_instrument (brand,model,price,instrument_type_id) VALUES
	 ('Ullamcorper Duis PC','est mauris,',263,144),
	 ('Amet Ante LLC','convallis erat,',323,30),
	 ('Arcu Sed Foundation','vitae, posuere',256,87),
	 ('Vivamus Nisi Inc.','Nunc lectus',387,113),
	 ('Sodales Associates','egestas. Aliquam',484,8),
	 ('Eu Augue Institute','luctus ut,',394,67),
	 ('Nonummy Ultricies Associates','tincidunt nibh.',404,181),
	 ('Sed Auctor LLP','consectetuer adipiscing',325,112),
	 ('Velit Corporation','Fusce mi',219,60),
	 ('Non Corporation','odio a',399,39);
INSERT INTO public.rentable_instrument (brand,model,price,instrument_type_id) VALUES
	 ('Ac LLP','ac turpis',161,107),
	 ('Nisl Nulla Corp.','iaculis nec,',253,60),
	 ('Et Magnis Dis Corp.','at risus.',418,22),
	 ('Diam At Corporation','Donec tempor,',438,117),
	 ('Egestas Sed LLC','sed sem',385,11),
	 ('Mollis Integer LLC','vitae purus',324,186),
	 ('Ipsum Porta Company','lectus, a',354,104),
	 ('Nascetur Ridiculus Mus Inc.','Donec tincidunt.',465,98),
	 ('Pede LLP','amet luctus',261,47),
	 ('Vestibulum Nec LLP','fringilla euismod',173,110);
INSERT INTO public.rentable_instrument (brand,model,price,instrument_type_id) VALUES
	 ('Aliquet Vel Corp.','felis, adipiscing',318,90),
	 ('Nascetur Ridiculus LLC','non enim',322,125),
	 ('Dapibus Rutrum Justo Inc.','amet risus.',456,138),
	 ('Leo Vivamus Nibh LLP','lectus. Nullam',222,92),
	 ('Libero Proin Foundation','orci. Ut',285,132),
	 ('Consectetuer Adipiscing PC','augue ut',441,164),
	 ('Eu Tellus Phasellus Ltd','in consequat',267,90),
	 ('Ullamcorper Velit Company','pede. Suspendisse',412,82),
	 ('Et Magnis Corporation','Proin nisl',374,165),
	 ('Cras PC','et malesuada',461,178);
INSERT INTO public.rentable_instrument (brand,model,price,instrument_type_id) VALUES
	 ('Diam Corporation','ligula tortor,',497,49),
	 ('Per Inceptos Hymenaeos PC','lectus convallis',236,76),
	 ('Non Foundation','Aenean eget',319,64),
	 ('Nibh Aliquam Consulting','erat. Vivamus',371,24),
	 ('Tristique Pharetra Corp.','leo. Vivamus',228,191),
	 ('Magna Et Consulting','malesuada ut,',198,26),
	 ('Sapien Nunc Ltd','luctus et',497,187),
	 ('Sem Vitae Aliquam Corporation','fermentum arcu.',368,162),
	 ('Enim Mi Tempor Inc.','primis in',325,95),
	 ('Mauris Non LLC','auctor non,',286,71);
INSERT INTO public.rentable_instrument (brand,model,price,instrument_type_id) VALUES
	 ('Imperdiet Nec Company','fringilla mi',225,53),
	 ('Eget Massa Suspendisse Associates','sit amet',411,189),
	 ('Consectetuer Inc.','eget, volutpat',427,67),
	 ('Ipsum Cursus Institute','erat. Etiam',476,37),
	 ('Adipiscing Lacus Ut PC','ipsum primis',254,92),
	 ('A Neque Inc.','augue ac',252,177),
	 ('Urna Company','tortor. Integer',432,122),
	 ('Malesuada Institute','facilisi. Sed',392,145),
	 ('Quis Massa Consulting','commodo ipsum.',315,66),
	 ('Nibh Dolor Limited','In ornare',326,180);
INSERT INTO public.lease (start_time,end_time,rentable_instrument_id,person_id) VALUES
	 ('2023-12-12 00:00:00+01','2023-12-12 01:00:00+01',39,37),
	 ('2024-06-06 00:00:00+02','2024-06-06 01:00:00+02',22,173),
	 ('2023-12-05 00:00:00+01','2023-12-05 01:00:00+01',9,138),
	 ('2025-06-17 00:00:00+02','2025-06-17 01:00:00+02',11,119),
	 ('2024-01-17 00:00:00+01','2024-01-17 01:00:00+01',23,65),
	 ('2025-10-15 00:00:00+02','2025-10-15 01:00:00+02',42,88),
	 ('2023-12-14 00:00:00+01','2023-12-14 01:00:00+01',12,53),
	 ('2023-12-26 00:00:00+01','2023-12-26 01:00:00+01',26,93),
	 ('2024-04-21 00:00:00+02','2024-04-21 01:00:00+02',20,49),
	 ('2025-07-15 00:00:00+02','2025-07-15 01:00:00+02',5,54);
INSERT INTO public.lease (start_time,end_time,rentable_instrument_id,person_id) VALUES
	 ('2024-06-08 00:00:00+02','2024-06-08 01:00:00+02',48,162),
	 ('2025-06-21 00:00:00+02','2025-06-21 01:00:00+02',14,54),
	 ('2025-01-29 00:00:00+01','2025-01-29 01:00:00+01',17,163),
	 ('2024-10-05 00:00:00+02','2024-10-05 01:00:00+02',46,53),
	 ('2024-11-07 00:00:00+01','2024-11-07 01:00:00+01',33,65),
	 ('2024-01-25 00:00:00+01','2024-01-25 01:00:00+01',21,75),
	 ('2025-08-02 00:00:00+02','2025-08-02 01:00:00+02',44,162),
	 ('2024-06-23 00:00:00+02','2024-06-23 01:00:00+02',27,188),
	 ('2025-10-09 00:00:00+02','2025-10-09 01:00:00+02',13,192),
	 ('2025-11-09 00:00:00+01','2025-11-09 01:00:00+01',18,26);
INSERT INTO public.lease (start_time,end_time,rentable_instrument_id,person_id) VALUES
	 ('2025-06-30 00:00:00+02','2025-06-30 01:00:00+02',24,119),
	 ('2024-03-10 00:00:00+01','2024-03-10 01:00:00+01',4,161),
	 ('2025-03-12 00:00:00+01','2025-03-12 01:00:00+01',49,161),
	 ('2025-04-19 00:00:00+02','2025-04-19 01:00:00+02',7,93),
	 ('2025-06-13 00:00:00+02','2025-06-13 01:00:00+02',30,173);
INSERT INTO public.booking (start_date_time,end_date_time,location_id) VALUES
	 ('2025-09-22 00:00:00+02','2025-09-22 01:00:00+02',1),
	 ('2025-10-15 00:00:00+02','2025-10-15 01:00:00+02',2),
	 ('2024-12-17 00:00:00+01','2024-12-17 01:00:00+01',3),
	 ('2025-08-13 00:00:00+02','2025-08-13 01:00:00+02',4),
	 ('2024-06-08 00:00:00+02','2024-06-08 01:00:00+02',5),
	 ('2025-03-01 00:00:00+01','2025-03-01 01:00:00+01',6),
	 ('2025-05-04 00:00:00+02','2025-05-04 01:00:00+02',7),
	 ('2024-06-08 00:00:00+02','2024-06-08 01:00:00+02',8),
	 ('2025-11-09 00:00:00+01','2025-11-09 01:00:00+01',9),
	 ('2024-11-14 00:00:00+01','2024-11-14 01:00:00+01',10);
INSERT INTO public.booking (start_date_time,end_date_time,location_id) VALUES
	 ('2023-12-02 00:00:00+01','2023-12-02 01:00:00+01',11),
	 ('2024-07-23 00:00:00+02','2024-07-23 01:00:00+02',12),
	 ('2025-10-22 00:00:00+02','2025-10-22 01:00:00+02',13),
	 ('2025-05-28 00:00:00+02','2025-05-28 01:00:00+02',14),
	 ('2025-06-07 00:00:00+02','2025-06-07 01:00:00+02',15),
	 ('2024-08-02 00:00:00+02','2024-08-02 01:00:00+02',16),
	 ('2024-11-10 00:00:00+01','2024-11-10 01:00:00+01',17),
	 ('2024-03-05 00:00:00+01','2024-03-05 01:00:00+01',18),
	 ('2025-08-08 00:00:00+02','2025-08-08 01:00:00+02',19),
	 ('2025-04-18 00:00:00+02','2025-04-18 01:00:00+02',20);
INSERT INTO public.booking (start_date_time,end_date_time,location_id) VALUES
	 ('2024-08-18 00:00:00+02','2024-08-18 01:00:00+02',21),
	 ('2025-10-13 00:00:00+02','2025-10-13 01:00:00+02',22),
	 ('2025-08-03 00:00:00+02','2025-08-03 01:00:00+02',24),
	 ('2024-06-28 00:00:00+02','2024-06-28 01:00:00+02',26),
	 ('2025-11-15 00:00:00+01','2025-11-15 01:00:00+01',27),
	 ('2024-09-26 00:00:00+02','2024-09-26 01:00:00+02',28),
	 ('2024-04-13 00:00:00+02','2024-04-13 01:00:00+02',31),
	 ('2025-11-02 00:00:00+01','2025-11-02 01:00:00+01',32),
	 ('2025-03-28 00:00:00+01','2025-03-28 01:00:00+01',33),
	 ('2024-03-10 00:00:00+01','2024-03-10 01:00:00+01',34);
INSERT INTO public.booking (start_date_time,end_date_time,location_id) VALUES
	 ('2024-02-02 00:00:00+01','2024-02-02 01:00:00+01',35),
	 ('2024-02-22 00:00:00+01','2024-02-22 01:00:00+01',36),
	 ('2024-01-10 00:00:00+01','2024-01-10 01:00:00+01',37),
	 ('2025-09-18 00:00:00+02','2025-09-18 01:00:00+02',38),
	 ('2025-07-12 00:00:00+02','2025-07-12 01:00:00+02',39),
	 ('2024-09-27 00:00:00+02','2024-09-27 01:00:00+02',40),
	 ('2024-12-08 00:00:00+01','2024-12-16 01:00:00+01',29),
	 ('2024-12-03 00:00:00+01','2024-03-03 01:00:00+01',30),
	 ('2024-12-09 23:00:00+01','2024-08-10 01:00:00+02',23),
	 ('2024-12-05 00:00:00+01','2024-02-17 01:00:00+01',25);
INSERT INTO public.lesson (min,max,pricing_scheme_id,person_id,booking_id) VALUES
	 (1,1,1,12,1),
	 (1,1,1,12,2),
	 (1,1,1,81,3),
	 (1,1,1,12,4),
	 (1,1,1,19,5),
	 (1,1,1,11,6),
	 (1,1,1,81,7),
	 (1,1,1,19,9),
	 (1,1,1,19,10),
	 (3,6,1,11,11);
INSERT INTO public.lesson (min,max,pricing_scheme_id,person_id,booking_id) VALUES
	 (3,6,1,12,12),
	 (3,6,1,81,13),
	 (3,6,1,19,14),
	 (3,6,1,12,15),
	 (3,6,1,11,16),
	 (3,6,1,12,18),
	 (3,6,1,19,19),
	 (3,6,1,19,20),
	 (4,8,1,19,21),
	 (4,8,1,81,22);
INSERT INTO public.lesson (min,max,pricing_scheme_id,person_id,booking_id) VALUES
	 (4,8,1,11,23),
	 (4,8,1,81,24),
	 (4,8,1,12,25),
	 (4,8,1,81,26),
	 (1,1,2,11,8),
	 (3,6,2,81,17),
	 (4,8,2,81,28),
	 (4,8,1,NULL,27),
	 (4,8,1,NULL,29),
	 (4,8,1,NULL,30);
INSERT INTO public.ensemble (lesson_id,genre_id) VALUES
	 (21,1),
	 (22,2),
	 (23,3),
	 (24,3),
	 (25,3),
	 (26,3),
	 (27,4),
	 (28,2),
	 (29,4),
	 (30,4);
INSERT INTO public.instrument_lesson (lesson_id,skill_level_id,instrument_type_id) VALUES
	 (1,3,191),
	 (2,2,79),
	 (3,5,184),
	 (4,4,116),
	 (5,5,16),
	 (6,5,190),
	 (7,5,109),
	 (8,5,59),
	 (9,1,130),
	 (10,3,190);
INSERT INTO public.instrument_lesson (lesson_id,skill_level_id,instrument_type_id) VALUES
	 (11,4,45),
	 (12,5,118),
	 (13,5,144),
	 (14,2,139),
	 (15,3,71),
	 (16,2,166),
	 (17,2,163),
	 (18,5,52),
	 (19,2,104),
	 (20,5,17);
INSERT INTO public.enrollment (lesson_id,person_id) VALUES
	 (3,3),
	 (16,76),
	 (16,53),
	 (26,49),
	 (26,75),
	 (26,20),
	 (26,161),
	 (26,26),
	 (26,139),
	 (25,26);
INSERT INTO public.enrollment (lesson_id,person_id) VALUES
	 (30,26),
	 (30,49),
	 (30,75),
	 (30,20),
	 (30,161),
	 (30,139),
	 (25,49),
	 (25,75),
	 (25,20),
	 (25,161);
INSERT INTO public.enrollment (lesson_id,person_id) VALUES
	 (25,139),
	 (25,76),
	 (25,3);
