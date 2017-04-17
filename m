From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add new AI+ field to RELEASE_MEM decoding
Date: Mon, 17 Apr 2017 23:37:17 +1000
Message-ID: <7b51a920-4b45-77a1-7103-24b8ae15f679@folklore1984.net>
References: <20170417124352.19956-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1015860585=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170417124352.19956-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1015860585==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qmQ3OpqdiLpojduBFfxrot5bmon9dkuV0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qmQ3OpqdiLpojduBFfxrot5bmon9dkuV0
Content-Type: multipart/mixed; boundary="wFmBVtxDTMpPvEQr5QxV4fgK2WvPP5KUI";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <7b51a920-4b45-77a1-7103-24b8ae15f679-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add new AI+ field to RELEASE_MEM decoding
References: <20170417124352.19956-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170417124352.19956-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--wFmBVtxDTMpPvEQr5QxV4fgK2WvPP5KUI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 04/17/2017 10:43 PM, Tom St Denis wrote:
> As well as add EVENT type decoding to human readable
> string.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/lib/ring_decode.c | 66 +++++++++++++++++++++++++++++++++++++++++++=
+++++---
>  1 file changed, 63 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
> index ab1cb9d46411..372bb43595b8 100644
> --- a/src/lib/ring_decode.c
> +++ b/src/lib/ring_decode.c
> @@ -284,6 +284,60 @@ static const char *pm4_pkt3_opcode_names[] =3D {
>  	"UNK", // ff
>  };
> =20
> +static const struct {
> +	char *name;
> +	unsigned event_no;
> +} vgt_event_tags[] =3D {
> +	{ "SAMPLE_STREAMOUTSTATS1", 1 },
> +	{ "SAMPLE_STREAMOUTSTATS2", 2 },
> +	{ "SAMPLE_STREAMOUTSTATS3", 3 },
> +	{ "CACHE_FLUSH_TS", 4 },
> +	{ "CACHE_FLUSH", 6 },
> +	{ "CS_PARTIAL_FLUSH", 7 },
> +	{ "VGT_STREAMOUT_RESET", 10 },
> +	{ "END_OF_PIPE_INCR_DE", 11 },
> +	{ "END_OF_PIPE_IB_END", 12 },
> +	{ "RST_PIX_CNT", 13 },
> +	{ "VS_PARTIAL_FLUSH", 15 },
> +	{ "PS_PARTIAL_FLUSH", 16 },
> +	{ "CACHE_FLUSH_AND_INV_TS_EVENT", 20 },
> +	{ "ZPASS_DONE", 21 },
> +	{ "CACHE_FLUSH_AND_INV_EVENT", 22 },
> +	{ "PERFCOUNTER_START", 23 },
> +	{ "PERFCOUNTER_STOP", 24 },
> +	{ "PIPELINESTAT_START", 25 },
> +	{ "PIPELINESTAT_STOP", 26 },
> +	{ "PERFCOUNTER_SAMPLE", 27 },
> +	{ "SAMPLE_PIPELINESTAT", 30 },
> +	{ "SAMPLE_STREAMOUTSTATS", 32 },
> +	{ "RESET_VTX_CNT", 33 },
> +	{ "VGT_FLUSH", 36 },
> +	{ "BOTTOM_OF_PIPE_TS", 40 },
> +	{ "DB_CACHE_FLUSH_AND_INV", 42 },
> +	{ "FLUSH_AND_INV_DB_DATA_TS", 43 },
> +	{ "FLUSH_AND_INV_DB_META", 44 },
> +	{ "FLUSH_AND_INV_CB_DATA_TS", 45 },
> +	{ "FLUSH_AND_INV_CB_META", 46 },
> +	{ "CS_DONE", 47 },
> +	{ "PS_DONE", 48 },
> +	{ "FLUSH_AND_INV_CB_PIXEL_DATA", 49 },
> +	{ "THREAD_TRACE_START", 51 },
> +	{ "THREAD_TRACE_STOP", 52 },
> +	{ "THREAD_TRACE_FLUSH", 54 },
> +	{ "THREAD_TRACE_FINISH", 55 },
> +	{ NULL, 0 },
> +};
> +
> +static char *vgt_event_decode(unsigned tag)
> +{
> +	unsigned x;
> +	for (x =3D 0; vgt_event_tags[x].name; x++) {
> +		if (vgt_event_tags[x].event_no =3D=3D tag)
> +			return vgt_event_tags[x].name;
> +	}
> +	return "<unknown event>";
> +}
> +
>  #define BITS(x, a, b) (unsigned long)((x >> a) & ((1ULL << (b-a))-1))
> =20
>  void add_ib(struct umr_ring_decoder *decoder)
> @@ -454,12 +508,11 @@ static void print_decode_pm4_pkt3(struct umr_asic=
 *asic, struct umr_ring_decoder
>  			break;
>  		case 0x49: // RELEASE_MEM
>  			switch(decoder->pm4.cur_word) {
> -				case 0: printf("EOP_TCL1_ACTION: %lu, EOP_TC_ACTION: %lu, EOP_TC_W=
B_ACTION: %lu, EVENT_TYPE: %lu, EVENT_INDEX: %lu",
> -				BITS(ib, 16, 17), BITS(ib, 17, 18), BITS(ib, 15, 16), BITS(ib, 0, =
7), BITS(ib, 8, 15));
> +				case 0: printf("EOP_TCL1_ACTION: %lu, EOP_TC_ACTION: %lu, EOP_TC_W=
B_ACTION: %lu, EVENT_TYPE: %lu[%s], EVENT_INDEX: %lu",
> +				BITS(ib, 16, 17), BITS(ib, 17, 18), BITS(ib, 15, 16), BITS(ib, 0, =
7), vgt_event_decode(BITS(ib, 0, 7)), BITS(ib, 8, 15));
>  					break;
>  				case 1:
>  					printf("DATA_SEL+INT_SEL: 0x%08lx", (unsigned long)ib);
> -//DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0)
>  					break;
>  				case 2: printf("ADDR_LO: 0x%08lx", (unsigned long)ib);
>  					break;
> @@ -469,6 +522,13 @@ static void print_decode_pm4_pkt3(struct umr_asic =
*asic, struct umr_ring_decoder
>  					break;
>  				case 5: printf("SEQ_HI: 0x%08lx", (unsigned long)ib);
>  					break;
> +				case 6:
> +					if (asic->family >=3D FAMILY_AI) {
> +						// decode additional words
> +						printf("DATA: 0x%08lx", (unsigned long)ib);
> +						break;
> +					}
> +					// fall through to invalid
>  				default: printf("Invalid word for opcode 0x%02lx", (unsigned long)=
decoder->pm4.cur_opcode);
>  			}
>  			break;
>=20


--wFmBVtxDTMpPvEQr5QxV4fgK2WvPP5KUI--

--qmQ3OpqdiLpojduBFfxrot5bmon9dkuV0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9MUNAAoJEP4bvbfZuWjbVOUP/R4d1isPoHbql33oC1mwhBnR
eIeGrWZzg/WcpEfLu+ubvv9M0qbcH3t5cjrPJkhY/Z3Fo9jxgai6NWudDSYD9qfD
N9pJVSw4sk4UpQGr4MYyTXcAfpB5zQCn5Z/WL0FKxZAQvv0rMWZkoRBwHo8F4CAs
+B/4Zoj2iwMFVhqMumw3CJjfjkzOiFCvYCWb0MOSPH8HnGKuTwOChT5E9CwRXBse
fgFBGqAotxA8IjBg9+Mv/s5h5l3+KQZSw31WOuvFXWFgnQfHblRAgp0coPBlx9Ng
67ZLbtXN/iqAGE/KeVzOwncFrMkKlFYZ6lc8fJtpNAsw2bu2HZ6Ttc/bgv6Pb2NR
LLU7qr13FLtsDn0mr5YtkArD6DbLlLZM1WMsNE3vjCsbXx/1bq5oeFTlkMPD+CQ4
bIo/bh02Lb/NS1WQLmRhCh5xZvWi0luw0ydCvLzcs1wicJiqG8q8RjedyIPKVMza
rJtu5qVSdWDXpo2bPnJzMt4eg0B9DWts1PTfWosQl6FMxCF3WkVZhthxlmtKmPiV
3Kh9xI5AftstO6AT462IzTLUGOI48EfwQrQaKMg9/5U8VWvS6D3ReR92MoLE2Q1J
27WqBivt60wH6nuXUwqRW5/p0VMnkoUky0Zx+UvZtizMGFPHRnw+eTKjTdGv4C+f
srhln8eajoZVW+AnXFWa
=VhK4
-----END PGP SIGNATURE-----

--qmQ3OpqdiLpojduBFfxrot5bmon9dkuV0--

--===============1015860585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1015860585==--
