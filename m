From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add more PKT3 decoders ...
Date: Tue, 21 Mar 2017 19:28:45 +1100
Message-ID: <de64a8cc-c3b5-3ad6-3062-b8702a7d8ceb@folklore1984.net>
References: <20170320165016.22290-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2123840322=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170320165016.22290-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2123840322==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cEWiqTHuWlbfMuqRujsqrbqi6mUwNlAeR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cEWiqTHuWlbfMuqRujsqrbqi6mUwNlAeR
Content-Type: multipart/mixed; boundary="vvn4FEQVcnUM87S5TIHmRKol8mJqQQ2wX";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <de64a8cc-c3b5-3ad6-3062-b8702a7d8ceb-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add more PKT3 decoders ...
References: <20170320165016.22290-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170320165016.22290-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--vvn4FEQVcnUM87S5TIHmRKol8mJqQQ2wX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 03/21/2017 03:50 AM, Tom St Denis wrote:
> Various SI related PKT3 decoders.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/lib/ring_decode.c | 52 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
> index a991f5ffa237..ab1cb9d46411 100644
> --- a/src/lib/ring_decode.c
> +++ b/src/lib/ring_decode.c
> @@ -322,8 +322,20 @@ static void print_decode_pm4_pkt3(struct umr_asic =
*asic, struct umr_ring_decoder
>  	static const char *op_3c_functions[] =3D { "true", "<", "<=3D", "=3D=3D=
", "!=3D", ">=3D", ">", "reserved" };
>  	static const char *op_37_engines[] =3D { "ME", "PFP", "CE", "DE" };
>  	static const char *op_37_dst_sel[] =3D { "mem-mapped reg", "memory sy=
nc", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved" }=
;
> +	struct umr_reg *reg;
>  	printf("   PKT3 OPCODE 0x%02x, word %u: ", (unsigned)decoder->pm4.cur=
_opcode, (unsigned)decoder->pm4.cur_word);
>  	switch (decoder->pm4.cur_opcode) {
> +		case 0x28: // CONTEXT_CONTROL
> +			switch (decoder->pm4.cur_word) {
> +				case 0: printf("LOAD_EN: %lu, LOAD_CS: %lu, LOAD_GFX: %lu, LOAD_MU=
LTI: %lu, LOAD_SINGLE: %lu",
> +						BITS(ib, 31, 32), BITS(ib, 24, 25), BITS(ib, 16,17), BITS(ib, 1,=
2), BITS(ib, 0, 1));
> +					break;
> +				case 1: printf("SHADOW_EN: %lu, SHADOW_CS: %lu, SHADOW_GFX: %lu, S=
HADOW_MULTI: %lu, SHADOW_SINGLE: %lu",
> +						BITS(ib, 31, 32), BITS(ib, 24, 25), BITS(ib, 16,17), BITS(ib, 1,=
2), BITS(ib, 0, 1));
> +					break;
> +				default: printf("Invalid word for opcode 0x%02lx", (unsigned long)=
decoder->pm4.cur_opcode);
> +			}
> +			break;
>  		case 0x3f: // INDIRECT_BUFFER_CIK
>  		case 0x33: // INDIRECT_BUFFER_CONST
>  			switch (decoder->pm4.cur_word) {
> @@ -388,6 +400,37 @@ static void print_decode_pm4_pkt3(struct umr_asic =
*asic, struct umr_ring_decoder
>  				default: printf("Invalid word for opcode 0x%02lx", (unsigned long)=
decoder->pm4.cur_opcode);
>  			}
>  			break;
> +		case 0x43: // SURFACE_SYNC
> +			switch (decoder->pm4.cur_word) {
> +				case 0: printf("ENGINE: %s, COHER_CNTL: 0x%08lx",
> +						BITS(ib, 31, 32) ? "ME" : "PFP",
> +						BITS(ib, 0, 29));
> +					reg =3D umr_find_reg_data(asic, "mmCP_COHER_CNTL");
> +					if (reg && reg->bits) {
> +						int i, k;
> +						k =3D 0;
> +						printf(" (");
> +						for (i =3D 0; i < reg->no_bits; i++) {
> +							if (ib & (1UL << reg->bits[i].start)) {
> +								printf("%s%s", k ? ", " : "", reg->bits[i].regname);
> +								++k;
> +							}
> +						}
> +						printf(")");
> +					}
> +					break;
> +				case 1:
> +					printf("COHER_SIZE: 0x%08lx", (unsigned long)ib);
> +					break;
> +				case 2:
> +					printf("COHER_BASE: 0x%08lx", (unsigned long)ib);
> +					break;
> +				case 3:
> +					printf("POLL_INTERVAL: %lu", BITS(ib, 0, 16));
> +					break;
> +				default: printf("Invalid word for opcode 0x%02lx", (unsigned long)=
decoder->pm4.cur_opcode);
> +			}
> +			break;
>  		case 0x47: // EVENT_WRITE_EOP
>  			switch(decoder->pm4.cur_word) {
>  				case 0: printf("INV_L2:%lu, EVENT_INDEX:%lu, EVENT_TYPE:%lu",
> @@ -429,6 +472,15 @@ static void print_decode_pm4_pkt3(struct umr_asic =
*asic, struct umr_ring_decoder
>  				default: printf("Invalid word for opcode 0x%02lx", (unsigned long)=
decoder->pm4.cur_opcode);
>  			}
>  			break;
> +		case 0x68: // SET_CONFIG_REG
> +			switch(decoder->pm4.cur_word) {
> +				case 0: decoder->pm4.next_write_mem.addr_lo =3D BITS(ib, 0, 16) + =
0x2000;
> +					printf("starting reg: %s", umr_reg_name(asic, decoder->pm4.next_w=
rite_mem.addr_lo));
> +					break;
> +				default: printf("%s <=3D 0x%08lx", umr_reg_name(asic, decoder->pm4=
=2Enext_write_mem.addr_lo++), (unsigned long)ib);
> +					break;
> +			}
> +			break;
>  		default:
>  			printf("PKT3 DATA");
>  			break;
>=20


--vvn4FEQVcnUM87S5TIHmRKol8mJqQQ2wX--

--cEWiqTHuWlbfMuqRujsqrbqi6mUwNlAeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY0OQ9AAoJEP4bvbfZuWjbL+wP/jQ547id+i6AtwPCwCOw8/Bs
w/yqqBGXQ+CgxKQswmAEC49phSIdF+1eIq5fCm8ftucLIIZwbocJlqqCPx0Y4c9C
GDn2SBO8+Cksqi1ayt7Oic1TqNVi32Ls5XjK+rQv43E1s86azte5Mz6pcQQ6yZB/
JIqeVniplH8ug8+wl/X7i0f1xOT/ZeiIydMB2Mi2zbAeS9nsYQ/Q8Jq0JNjkzYLo
AtALVsCESoZtCNK/tRu12d3Zv/sL+hNyBa4+rRKV+FbFUq+C4Hpbp6KL7dvQUwBH
dtuyJtvtecICvkZEpC1v3MwnClUz5L9UakkrQgB8kqPd24HRUKLU5pHZkSGI5QSV
VFLPLKQtcJfcYWyzVtRumtaA7+LT/977xYGuOU7ptwvgL/gDoBVnyMzf8AfOHH+b
XQX/XhxOZw6oUt7yplbfn5nQO4V2YqAxos4uXLyjnLdHbHaa+2LzDPUjRjEWCzhu
HlcuhnTTpYc7JZTWNi4SUHTz2MkSulg/zYWE7sgNCPfoUrGyTnYUj56HPpKMEV4n
IYwb96DLA2XJqwtTeD1QnXYyT4gkOrpEYFv1+n7Ts94rUGkNn/1W5UJq6NIKaJJd
dvwvxoyotwBd0iP/L3vkmpkkbkiVCx3XqxgQmMgOWYpsafP8fA8hDoZ/v5Wceri1
arZaIIzhelaBOO5lt7UM
=yXih
-----END PGP SIGNATURE-----

--cEWiqTHuWlbfMuqRujsqrbqi6mUwNlAeR--

--===============2123840322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2123840322==--
