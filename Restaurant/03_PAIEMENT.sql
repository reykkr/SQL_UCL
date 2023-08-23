/*

  _____        _____ ______ __  __ ______ _   _ _______ 
 |  __ \ /\   |_   _|  ____|  \/  |  ____| \ | |__   __|
 | |__) /  \    | | | |__  | \  / | |__  |  \| |  | |   
 |  ___/ /\ \   | | |  __| | |\/| |  __| | . ` |  | |   
 | |  / ____ \ _| |_| |____| |  | | |____| |\  |  | |   
 |_| /_/    \_\_____|______|_|  |_|______|_| \_|  |_|   
                                                        
                                                       
*/



----
--  ADDITION
----

-- Sequence --
DROP SEQUENCE IF EXISTS public.addition_addition_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.addition_addition_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY addition.addition_id;

ALTER SEQUENCE public.addition_addition_id_seq
    OWNER TO postgres;


-- Table --
DROP TABLE IF EXISTS public.addition;

CREATE TABLE IF NOT EXISTS public.addition
(
    addition_id integer NOT NULL DEFAULT nextval('addition_addition_id_seq'::regclass),
    cmd_id integer NOT NULL,
    addition_dh timestamp with time zone,
    CONSTRAINT addition_pkey PRIMARY KEY (addition_id),
    CONSTRAINT fk_cmd_id FOREIGN KEY (cmd_id)
        REFERENCES public.commande (commande_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.addition
    OWNER to postgres;



----
--  LIGNE ADDITION
----


-- Sequence --
DROP SEQUENCE IF EXISTS public.addition_ligne_ligne_addition_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.addition_ligne_ligne_addition_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY addition_ligne.ligne_addition_id;

ALTER SEQUENCE public.addition_ligne_ligne_addition_id_seq
    OWNER TO postgres;



-- Table --
DROP TABLE IF EXISTS public.addition_ligne;

CREATE TABLE IF NOT EXISTS public.addition_ligne
(
    ligne_addition_id integer NOT NULL DEFAULT nextval('addition_ligne_ligne_addition_id_seq'::regclass),
    addition_id integer NOT NULL,
    item_id integer,
    item_desc character varying COLLATE pg_catalog."default",
    item_pv numeric,
    CONSTRAINT addition_ligne_pkey PRIMARY KEY (ligne_addition_id),
    CONSTRAINT fk_addition FOREIGN KEY (addition_id)
        REFERENCES public.addition (addition_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.addition_ligne
    OWNER to postgres;


----
--  TYPES DE PAIEMENT
----

-- Sequence --
DROP SEQUENCE IF EXISTS public.paiement_type_paiement_type_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.paiement_type_paiement_type_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY paiement_type.paiement_type_id;

ALTER SEQUENCE public.paiement_type_paiement_type_id_seq
    OWNER TO postgres;



-- Type de paiement --
DROP TABLE IF EXISTS public.paiement_type;

CREATE TABLE IF NOT EXISTS public.paiement_type
(
    paiement_type_id integer NOT NULL DEFAULT nextval('paiement_type_paiement_type_id_seq'::regclass),
    paiement_type_nom character varying COLLATE pg_catalog."default",
    paiement_type_limite numeric,
    CONSTRAINT paiement_type_pkey PRIMARY KEY (paiement_type_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.paiement_type
    OWNER to postgres;
	
	


INSERT INTO paiement_type (paiement_type_nom) VALUES ('CB');
INSERT INTO paiement_type (paiement_type_nom,paiement_type_limite) VALUES ('ESPECES',3000);
INSERT INTO paiement_type (paiement_type_nom,paiement_type_limite) VALUES ('TICKET REST.',25);




----
--  PAIEMENT
----


-- Sequence --
DROP SEQUENCE IF EXISTS public.paiement_paiement_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.paiement_paiement_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY paiement.paiement_id;

ALTER SEQUENCE public.paiement_paiement_id_seq
    OWNER TO postgres;
	
	
	
-- Table --
DROP TABLE IF EXISTS public.paiement;

CREATE TABLE IF NOT EXISTS public.paiement
(
    paiement_id integer NOT NULL DEFAULT nextval('paiement_paiement_id_seq'::regclass),
    addition_id integer NOT NULL,
    paiement_type integer NOT NULL,
    paiement_montant numeric NOT NULL,
    CONSTRAINT paiement_pkey PRIMARY KEY (paiement_id),
    CONSTRAINT fk_addition FOREIGN KEY (addition_id)
        REFERENCES public.addition (addition_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_type_paiement FOREIGN KEY (paiement_type)
        REFERENCES public.paiement_type (paiement_type_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.paiement
    OWNER to postgres;