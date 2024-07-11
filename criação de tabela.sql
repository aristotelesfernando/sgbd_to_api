-- DROP TABLE IF EXISTS public.people;

CREATE TABLE IF NOT EXISTS public.people
(
    name character varying(250) COLLATE pg_catalog."default",
    email character varying(250) COLLATE pg_catalog."default",
    mobile character varying(25) COLLATE pg_catalog."default",
    country_name character varying(100) COLLATE pg_catalog."default",
    id integer NOT NULL DEFAULT nextval('people_id_seq'::regclass),
    CONSTRAINT people_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.people
    OWNER to postgres;