--
-- PostgreSQL database dump
--

\restrict WFS0Pz4q7wu2mEpLvx68Nh7TbefgiXRo17DsVEWGxuwh5Lt6Sa19ZfyA52DMVJX

-- Dumped from database version 15.14
-- Dumped by pg_dump version 15.14

-- Started on 2025-11-27 10:38:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE kasir_cafe;
--
-- TOC entry 3393 (class 1262 OID 49911)
-- Name: kasir_cafe; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE kasir_cafe WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';


ALTER DATABASE kasir_cafe OWNER TO postgres;

\unrestrict WFS0Pz4q7wu2mEpLvx68Nh7TbefgiXRo17DsVEWGxuwh5Lt6Sa19ZfyA52DMVJX
\connect kasir_cafe
\restrict WFS0Pz4q7wu2mEpLvx68Nh7TbefgiXRo17DsVEWGxuwh5Lt6Sa19ZfyA52DMVJX

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 49923)
-- Name: kategori_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori_menu (
    id_kategori integer NOT NULL,
    nama_kategori character varying(50) NOT NULL
);


ALTER TABLE public.kategori_menu OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 49922)
-- Name: kategori_menu_id_kategori_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kategori_menu_id_kategori_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kategori_menu_id_kategori_seq OWNER TO postgres;

--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 214
-- Name: kategori_menu_id_kategori_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kategori_menu_id_kategori_seq OWNED BY public.kategori_menu.id_kategori;


--
-- TOC entry 219 (class 1259 OID 49945)
-- Name: member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.member (
    id_member integer NOT NULL,
    nama_member character varying(100) NOT NULL,
    no_telp character varying(20),
    email character varying(100),
    points integer DEFAULT 0,
    tanggal_join timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.member OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 49944)
-- Name: member_id_member_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.member_id_member_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.member_id_member_seq OWNER TO postgres;

--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 218
-- Name: member_id_member_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.member_id_member_seq OWNED BY public.member.id_member;


--
-- TOC entry 217 (class 1259 OID 49930)
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    id_menu integer NOT NULL,
    nama_menu character varying(100) NOT NULL,
    id_kategori integer,
    harga numeric(12,2) NOT NULL,
    status_menu character varying(20) DEFAULT 'Tersedia'::character varying,
    deskripsi text,
    gambar bytea
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 49929)
-- Name: menu_id_menu_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_id_menu_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_id_menu_seq OWNER TO postgres;

--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 216
-- Name: menu_id_menu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_id_menu_seq OWNED BY public.menu.id_menu;


--
-- TOC entry 221 (class 1259 OID 49954)
-- Name: pesanan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pesanan (
    id_pesanan integer NOT NULL,
    no_meja character varying(10),
    nama_pelanggan character varying(100),
    waktu_pesan timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.pesanan OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 49962)
-- Name: pesanan_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pesanan_detail (
    id_detail integer NOT NULL,
    id_pesanan integer NOT NULL,
    id_menu integer NOT NULL,
    qty integer NOT NULL,
    harga numeric(12,2) NOT NULL,
    subtotal numeric(12,2) GENERATED ALWAYS AS (((qty)::numeric * harga)) STORED
);


ALTER TABLE public.pesanan_detail OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 49961)
-- Name: pesanan_detail_id_detail_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pesanan_detail_id_detail_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pesanan_detail_id_detail_seq OWNER TO postgres;

--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 222
-- Name: pesanan_detail_id_detail_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pesanan_detail_id_detail_seq OWNED BY public.pesanan_detail.id_detail;


--
-- TOC entry 220 (class 1259 OID 49953)
-- Name: pesanan_id_pesanan_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pesanan_id_pesanan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pesanan_id_pesanan_seq OWNER TO postgres;

--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 220
-- Name: pesanan_id_pesanan_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pesanan_id_pesanan_seq OWNED BY public.pesanan.id_pesanan;


--
-- TOC entry 225 (class 1259 OID 49980)
-- Name: transaksi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaksi (
    id_transaksi integer NOT NULL,
    id_pesanan integer NOT NULL,
    id_member integer,
    waktu_transaksi timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_belanja numeric(12,2) NOT NULL,
    diskon numeric(12,2) DEFAULT 0,
    pajak numeric(12,2) DEFAULT 0,
    total_akhir numeric(12,2) NOT NULL,
    metode_pembayaran character varying(20) NOT NULL,
    nominal_bayar numeric(12,2),
    kembalian numeric(12,2)
);


ALTER TABLE public.transaksi OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 49979)
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaksi_id_transaksi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaksi_id_transaksi_seq OWNER TO postgres;

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 224
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaksi_id_transaksi_seq OWNED BY public.transaksi.id_transaksi;


--
-- TOC entry 226 (class 1259 OID 49999)
-- Name: v_laporan_harian; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_laporan_harian AS
 SELECT t.id_transaksi,
    (t.waktu_transaksi)::date AS tanggal,
    m.nama_menu,
    d.qty,
    d.subtotal,
    t.metode_pembayaran
   FROM (((public.transaksi t
     JOIN public.pesanan p ON ((t.id_pesanan = p.id_pesanan)))
     JOIN public.pesanan_detail d ON ((d.id_pesanan = p.id_pesanan)))
     JOIN public.menu m ON ((d.id_menu = m.id_menu)));


ALTER TABLE public.v_laporan_harian OWNER TO postgres;

--
-- TOC entry 3202 (class 2604 OID 49926)
-- Name: kategori_menu id_kategori; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori_menu ALTER COLUMN id_kategori SET DEFAULT nextval('public.kategori_menu_id_kategori_seq'::regclass);


--
-- TOC entry 3205 (class 2604 OID 49948)
-- Name: member id_member; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member ALTER COLUMN id_member SET DEFAULT nextval('public.member_id_member_seq'::regclass);


--
-- TOC entry 3203 (class 2604 OID 49933)
-- Name: menu id_menu; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu ALTER COLUMN id_menu SET DEFAULT nextval('public.menu_id_menu_seq'::regclass);


--
-- TOC entry 3208 (class 2604 OID 49957)
-- Name: pesanan id_pesanan; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pesanan ALTER COLUMN id_pesanan SET DEFAULT nextval('public.pesanan_id_pesanan_seq'::regclass);


--
-- TOC entry 3210 (class 2604 OID 49965)
-- Name: pesanan_detail id_detail; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pesanan_detail ALTER COLUMN id_detail SET DEFAULT nextval('public.pesanan_detail_id_detail_seq'::regclass);


--
-- TOC entry 3212 (class 2604 OID 49983)
-- Name: transaksi id_transaksi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksi ALTER COLUMN id_transaksi SET DEFAULT nextval('public.transaksi_id_transaksi_seq'::regclass);


--
-- TOC entry 3377 (class 0 OID 49923)
-- Dependencies: 215
-- Data for Name: kategori_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kategori_menu (id_kategori, nama_kategori) FROM stdin;
\.


--
-- TOC entry 3381 (class 0 OID 49945)
-- Dependencies: 219
-- Data for Name: member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.member (id_member, nama_member, no_telp, email, points, tanggal_join) FROM stdin;
\.


--
-- TOC entry 3379 (class 0 OID 49930)
-- Dependencies: 217
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (id_menu, nama_menu, id_kategori, harga, status_menu, deskripsi, gambar) FROM stdin;
\.


--
-- TOC entry 3383 (class 0 OID 49954)
-- Dependencies: 221
-- Data for Name: pesanan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pesanan (id_pesanan, no_meja, nama_pelanggan, waktu_pesan) FROM stdin;
\.


--
-- TOC entry 3385 (class 0 OID 49962)
-- Dependencies: 223
-- Data for Name: pesanan_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pesanan_detail (id_detail, id_pesanan, id_menu, qty, harga) FROM stdin;
\.


--
-- TOC entry 3387 (class 0 OID 49980)
-- Dependencies: 225
-- Data for Name: transaksi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaksi (id_transaksi, id_pesanan, id_member, waktu_transaksi, total_belanja, diskon, pajak, total_akhir, metode_pembayaran, nominal_bayar, kembalian) FROM stdin;
\.


--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 214
-- Name: kategori_menu_id_kategori_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategori_menu_id_kategori_seq', 1, false);


--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 218
-- Name: member_id_member_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.member_id_member_seq', 1, false);


--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 216
-- Name: menu_id_menu_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_id_menu_seq', 1, false);


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 222
-- Name: pesanan_detail_id_detail_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pesanan_detail_id_detail_seq', 1, false);


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 220
-- Name: pesanan_id_pesanan_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pesanan_id_pesanan_seq', 1, false);


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 224
-- Name: transaksi_id_transaksi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaksi_id_transaksi_seq', 1, false);


--
-- TOC entry 3217 (class 2606 OID 49928)
-- Name: kategori_menu kategori_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori_menu
    ADD CONSTRAINT kategori_menu_pkey PRIMARY KEY (id_kategori);


--
-- TOC entry 3221 (class 2606 OID 49952)
-- Name: member member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id_member);


--
-- TOC entry 3219 (class 2606 OID 49938)
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id_menu);


--
-- TOC entry 3225 (class 2606 OID 49968)
-- Name: pesanan_detail pesanan_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pesanan_detail
    ADD CONSTRAINT pesanan_detail_pkey PRIMARY KEY (id_detail);


--
-- TOC entry 3223 (class 2606 OID 49960)
-- Name: pesanan pesanan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pesanan
    ADD CONSTRAINT pesanan_pkey PRIMARY KEY (id_pesanan);


--
-- TOC entry 3227 (class 2606 OID 49988)
-- Name: transaksi transaksi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksi
    ADD CONSTRAINT transaksi_pkey PRIMARY KEY (id_transaksi);


--
-- TOC entry 3228 (class 2606 OID 49939)
-- Name: menu menu_id_kategori_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_id_kategori_fkey FOREIGN KEY (id_kategori) REFERENCES public.kategori_menu(id_kategori) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3229 (class 2606 OID 49974)
-- Name: pesanan_detail pesanan_detail_id_menu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pesanan_detail
    ADD CONSTRAINT pesanan_detail_id_menu_fkey FOREIGN KEY (id_menu) REFERENCES public.menu(id_menu) ON DELETE RESTRICT;


--
-- TOC entry 3230 (class 2606 OID 49969)
-- Name: pesanan_detail pesanan_detail_id_pesanan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pesanan_detail
    ADD CONSTRAINT pesanan_detail_id_pesanan_fkey FOREIGN KEY (id_pesanan) REFERENCES public.pesanan(id_pesanan) ON DELETE CASCADE;


--
-- TOC entry 3231 (class 2606 OID 49994)
-- Name: transaksi transaksi_id_member_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksi
    ADD CONSTRAINT transaksi_id_member_fkey FOREIGN KEY (id_member) REFERENCES public.member(id_member) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3232 (class 2606 OID 49989)
-- Name: transaksi transaksi_id_pesanan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksi
    ADD CONSTRAINT transaksi_id_pesanan_fkey FOREIGN KEY (id_pesanan) REFERENCES public.pesanan(id_pesanan) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2025-11-27 10:38:41

--
-- PostgreSQL database dump complete
--

\unrestrict WFS0Pz4q7wu2mEpLvx68Nh7TbefgiXRo17DsVEWGxuwh5Lt6Sa19ZfyA52DMVJX

