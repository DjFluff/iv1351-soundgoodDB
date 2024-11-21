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
