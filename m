From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] sync up registers/bits with staging tree
Date: Tue, 21 Mar 2017 19:28:04 +1100
Message-ID: <fa0c88ea-46b8-a23d-94aa-0929a55e6cb4@folklore1984.net>
References: <20170320153114.18177-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1830722745=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170320153114.18177-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
--===============1830722745==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E30trSX9fqB8dkgDFEOOE08voBIFnTw2R"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E30trSX9fqB8dkgDFEOOE08voBIFnTw2R
Content-Type: multipart/mixed; boundary="6V7Og9nvdAFte37WaaVBviJq0jHR4gptl";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <fa0c88ea-46b8-a23d-94aa-0929a55e6cb4-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] sync up registers/bits with staging tree
References: <20170320153114.18177-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170320153114.18177-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--6V7Og9nvdAFte37WaaVBviJq0jHR4gptl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/21/2017 02:31 AM, Tom St Denis wrote:
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  scripts/parse_bits.sh    | 4 +++-
>  src/lib/ip/dce60_bits.i  | 1 +
>  src/lib/ip/smu712_regs.i | 1 +
>  src/lib/ip/smu713_regs.i | 1 +
>  4 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/parse_bits.sh b/scripts/parse_bits.sh
> index ebaa6aefb1fa..14df5e831b01 100755
> --- a/scripts/parse_bits.sh
> +++ b/scripts/parse_bits.sh
> @@ -4,7 +4,9 @@
>  # ASICs
> =20
>  #this is the path to the tree (not necessarily the one running on your=
 host)
> -pk=3D/nas/work/repos/linux/drivers/gpu/drm/amd/include/asic_reg/
> +if [ "$pk" =3D=3D "" ]; then
> +	pk=3D/nas/work/repos/linux/drivers/gpu/drm/amd/include/asic_reg/
> +fi
> =20
Hmm, perhaps this hunk should not be conflated in with the rest.

The rest of this patch is,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

>  # parse_bits /path/to/asic_reg/foo/block /path/to/umr/file
>  parse_bits() {
> diff --git a/src/lib/ip/dce60_bits.i b/src/lib/ip/dce60_bits.i
> index 50ae01e400d5..7ced97afed5d 100644
> --- a/src/lib/ip/dce60_bits.i
> +++ b/src/lib/ip/dce60_bits.i
> @@ -2488,6 +2488,7 @@ static struct umr_bitfield mmCC_DC_PIPE_DIS[] =3D=
 {
>  };
>  static struct umr_bitfield mmAZALIA_F0_CODEC_ENDPOINT_INDEX[] =3D {
>  	 { "AZALIA_ENDPOINT_REG_INDEX", 0, 7, &umr_bitfield_default },
> +	 { "AZALIA_ENDPOINT_REG_WRITE_EN", 8, 8, &umr_bitfield_default },
>  };
>  static struct umr_bitfield mmAZALIA_F0_CODEC_ENDPOINT_DATA[] =3D {
>  	 { "AZALIA_ENDPOINT_REG_DATA", 0, 31, &umr_bitfield_default },
> diff --git a/src/lib/ip/smu712_regs.i b/src/lib/ip/smu712_regs.i
> index eb030979eaec..f718b000b84b 100644
> --- a/src/lib/ip/smu712_regs.i
> +++ b/src/lib/ip/smu712_regs.i
> @@ -1222,6 +1222,7 @@
>  	{ "ixCG_THERMAL_INT_ENA", REG_SMC, 0xc2100024, &ixCG_THERMAL_INT_ENA[=
0], sizeof(ixCG_THERMAL_INT_ENA)/sizeof(ixCG_THERMAL_INT_ENA[0]), 0, 0 },=

>  	{ "ixCG_THERMAL_INT_CTRL", REG_SMC, 0xc2100028, &ixCG_THERMAL_INT_CTR=
L[0], sizeof(ixCG_THERMAL_INT_CTRL)/sizeof(ixCG_THERMAL_INT_CTRL[0]), 0, =
0 },
>  	{ "ixCG_THERMAL_INT_STATUS", REG_SMC, 0xc210002c, &ixCG_THERMAL_INT_S=
TATUS[0], sizeof(ixCG_THERMAL_INT_STATUS)/sizeof(ixCG_THERMAL_INT_STATUS[=
0]), 0, 0 },
> +	{ "ixCURRENT_PG_STATUS_APU", REG_SMC, 0xd020029c, NULL, 0, 0, 0 },
>  	{ "ixSMU_MAIN_PLL_OP_FREQ", REG_SMC, 0xe0003020, &ixSMU_MAIN_PLL_OP_F=
REQ[0], sizeof(ixSMU_MAIN_PLL_OP_FREQ)/sizeof(ixSMU_MAIN_PLL_OP_FREQ[0]),=
 0, 0 },
>  	{ "ixSMU_STATUS", REG_SMC, 0xe0003088, &ixSMU_STATUS[0], sizeof(ixSMU=
_STATUS)/sizeof(ixSMU_STATUS[0]), 0, 0 },
>  	{ "ixSMU_FIRMWARE", REG_SMC, 0xe00030a4, &ixSMU_FIRMWARE[0], sizeof(i=
xSMU_FIRMWARE)/sizeof(ixSMU_FIRMWARE[0]), 0, 0 },
> diff --git a/src/lib/ip/smu713_regs.i b/src/lib/ip/smu713_regs.i
> index 0f1d79aa2b9f..8a632b41624e 100644
> --- a/src/lib/ip/smu713_regs.i
> +++ b/src/lib/ip/smu713_regs.i
> @@ -1192,6 +1192,7 @@
>  	{ "ixGC_CAC_ACC_CU13", REG_SMC, 0xc7, &ixGC_CAC_ACC_CU13[0], sizeof(i=
xGC_CAC_ACC_CU13)/sizeof(ixGC_CAC_ACC_CU13[0]), 0, 0 },
>  	{ "ixGC_CAC_ACC_CU14", REG_SMC, 0xc8, &ixGC_CAC_ACC_CU14[0], sizeof(i=
xGC_CAC_ACC_CU14)/sizeof(ixGC_CAC_ACC_CU14[0]), 0, 0 },
>  	{ "ixGC_CAC_ACC_CU15", REG_SMC, 0xc9, &ixGC_CAC_ACC_CU15[0], sizeof(i=
xGC_CAC_ACC_CU15)/sizeof(ixGC_CAC_ACC_CU15[0]), 0, 0 },
> +	{ "ixCURRENT_PG_STATUS_APU", REG_SMC, 0xd020029c, NULL, 0, 0, 0 },
>  	{ "ixSMU_MAIN_PLL_OP_FREQ", REG_SMC, 0xe0003020, &ixSMU_MAIN_PLL_OP_F=
REQ[0], sizeof(ixSMU_MAIN_PLL_OP_FREQ)/sizeof(ixSMU_MAIN_PLL_OP_FREQ[0]),=
 0, 0 },
>  	{ "ixSMU_STATUS", REG_SMC, 0xe0003088, &ixSMU_STATUS[0], sizeof(ixSMU=
_STATUS)/sizeof(ixSMU_STATUS[0]), 0, 0 },
>  	{ "ixSMU_FIRMWARE", REG_SMC, 0xe00030a4, &ixSMU_FIRMWARE[0], sizeof(i=
xSMU_FIRMWARE)/sizeof(ixSMU_FIRMWARE[0]), 0, 0 },
>=20


--6V7Og9nvdAFte37WaaVBviJq0jHR4gptl--

--E30trSX9fqB8dkgDFEOOE08voBIFnTw2R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY0OQYAAoJEP4bvbfZuWjbrckP/j0gEK/m6QbOAe4B/+wWKWWc
HIO3d7/64zdK6bTklTX/mLvOXCKNm+vNi3gZH0CM3LZUrz/WCmISdpFTgvhSEONI
zJHrNlnltcy/J94HvsV8Rtl4aDqdmQjw7WX+u2W+4m2FVemNLKg/TqbVC9MogTA3
z/xpn1DSfLrRNwBro04Fc6/N2kq0sUndvsPmm7nR1lnGnfOCIzZo2HUPWTL5s2Sm
/d3yol8pVeXijh8vsI895Qyr5VqlKfI945m0Wr4vVLGQMLKAOw3ej6/JvGWA2g+f
+nps+vAkzt5ikgKQxPTEvzSR3ExM6xfJ+CaD4d2sIoxn2SZQ9+Nc7NuoaslPAZ4D
enSYNiGcG66/X4o5w+Ieqpf6mVs8qSy/SxshN+PZb4E9MaW7jcmeJs2oXiqhjedF
RBQUb+E8RyixMs1NY0IJDHXRknYp+4kXxioZXYCzUEEBy9aoYDfain5/0rk3g0k/
cBzQIrze6b9bP3OmmvPxtlEsFmmgDiBSF9SjQdNVQHCILod/3Qp7rgM+CV/YyAyJ
SWT0v04NIUlGqxnzP0MxwCdnjph3U6pGYXnDglybi44vaR9HVtfkThcA+qrCaMR7
wxWyenDJgSWHlfhpScTWhcWsi3D3pK+wbjx/BDmr4AnlfMJBiOywUfFyzlR7EQbU
csy43eeaFIQlrP+Xs19S
=Qh8k
-----END PGP SIGNATURE-----

--E30trSX9fqB8dkgDFEOOE08voBIFnTw2R--

--===============1830722745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1830722745==--
