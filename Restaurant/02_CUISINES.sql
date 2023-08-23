/*
   _____ _    _ _____  _____ _____ _   _ ______  _____ 
  / ____| |  | |_   _|/ ____|_   _| \ | |  ____|/ ____|
 | |    | |  | | | | | (___   | | |  \| | |__  | (___  
 | |    | |  | | | |  \___ \  | | | . ` |  __|  \___ \ 
 | |____| |__| |_| |_ ____) |_| |_| |\  | |____ ____) |
  \_____|\____/|_____|_____/|_____|_| \_|______|_____/ 
  
 */
 
 
----
--  TABLES DU RESTAURANT
----

-- Sequence --
DROP SEQUENCE IF EXISTS public.table_table_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.table_table_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY "table".table_id;

ALTER SEQUENCE public.table_table_id_seq
    OWNER TO postgres;
	

-- Table --
-- Attention le mot table est un mot réservé au langage SQL --
DROP TABLE IF EXISTS public."table_rest";

CREATE TABLE IF NOT EXISTS public."table_rest"
(
    table_id integer NOT NULL DEFAULT nextval('table_table_id_seq'::regclass),
    table_num character varying COLLATE pg_catalog."default" NOT NULL,
    table_nbpers integer,
    CONSTRAINT table_pkey PRIMARY KEY (table_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."table"
    OWNER to postgres;
	

INSERT INTO table_rest(table_num,table_nbpers) VALUES ('T1',2);
INSERT INTO table_rest(table_num,table_nbpers) VALUES ('T2',4);
INSERT INTO table_rest(table_num,table_nbpers) VALUES ('T3',6);



----
--  COMMANDES
----

-- sequence --
DROP SEQUENCE IF EXISTS public.commande_commande_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.commande_commande_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY commande.commande_id;

ALTER SEQUENCE public.commande_commande_id_seq
    OWNER TO postgres;

-- table --
DROP TABLE IF EXISTS public.commande;

CREATE TABLE IF NOT EXISTS public.commande
(
    commande_id integer NOT NULL DEFAULT nextval('commande_commande_id_seq'::regclass),
    table_id integer NOT NULL,
    commande_dh timestamp with time zone,
    CONSTRAINT commande_pkey PRIMARY KEY (commande_id),
    CONSTRAINT fk_table_id FOREIGN KEY (table_id)
        REFERENCES public.table_rest (table_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.commande
    OWNER to postgres;
	
	
----
--  ITEMS DE LA COMMANDE (TABLE DE RELATION)
----


-- table --

DROP TABLE IF EXISTS public.item_cmd;

CREATE TABLE IF NOT EXISTS public.item_cmd
(
    item_id integer NOT NULL,
    item_cmd_dh timestamp with time zone NOT NULL,
    cmd_id integer NOT NULL,
    item_serv_dh timestamp with time zone,
    item_servi integer,
    CONSTRAINT fk_commande FOREIGN KEY (cmd_id)
        REFERENCES public.commande (commande_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT fk_item FOREIGN KEY (item_id)
        REFERENCES public.item (item_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.item_cmd
    OWNER to postgres;



----
--  SERVEUR
----

-- Sequence --
DROP SEQUENCE IF EXISTS public.serveur_serveur_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.serveur_serveur_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY serveur.serveur_id;

ALTER SEQUENCE public.serveur_serveur_id_seq
    OWNER TO postgres;



-- Table --
DROP TABLE IF EXISTS public.serveur;

CREATE TABLE IF NOT EXISTS public.serveur
(
    serveur_id integer NOT NULL DEFAULT nextval('serveur_serveur_id_seq'::regclass),
    serveur_nom character varying COLLATE pg_catalog."default",
    serveur_prenom character varying COLLATE pg_catalog."default",
    CONSTRAINT serveur_pkey PRIMARY KEY (serveur_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.serveur
    OWNER to postgres;
	
	
INSERT INTO serveur (serveur_prenom,serveur_nom) VALUES ('Jean','Dujardin');
INSERT INTO serveur (serveur_prenom,serveur_nom) VALUES ('Alexandra','Lamy');