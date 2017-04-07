From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add AI sensors to --top
Date: Sat, 8 Apr 2017 00:17:06 +1000
Message-ID: <9eaa3cf7-0c1d-98be-8e33-3e66df5ed969@folklore1984.net>
References: <20170407104745.17519-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0510377769=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170407104745.17519-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
--===============0510377769==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="h1Tp78wJnJ4h4O9gJ3LgkkATA8KiFTo0K"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h1Tp78wJnJ4h4O9gJ3LgkkATA8KiFTo0K
Content-Type: multipart/mixed; boundary="KsI8bdT0b5otcTo6WN8Wu0r8NVM5DlNmC";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <9eaa3cf7-0c1d-98be-8e33-3e66df5ed969-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Add AI sensors to --top
References: <20170407104745.17519-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170407104745.17519-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--KsI8bdT0b5otcTo6WN8Wu0r8NVM5DlNmC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 04/07/2017 08:47 PM, Tom St Denis wrote:
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/app/top.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/app/top.c b/src/app/top.c
> index b8a91e317ba5..96e33ff2e1da 100644
> --- a/src/app/top.c
> +++ b/src/app/top.c
> @@ -252,6 +252,15 @@ static struct umr_bitfield stat_si_sensor_bits[] =3D=
 {
>  	{ NULL, 0, 0, NULL },
>  };
> =20
> +static struct umr_bitfield stat_ai_sensor_bits[] =3D {
> +	{ "GFX_SCLK", AMDGPU_PP_SENSOR_GFX_SCLK, SENSOR_D100|(SENSOR_MHZ<<4),=
 &umr_bitfield_default },
> +	{ "GFX_MCLK", AMDGPU_PP_SENSOR_GFX_MCLK, SENSOR_D100|(SENSOR_MHZ<<4),=
 &umr_bitfield_default },
> +	{ "GPU_LOAD", AMDGPU_PP_SENSOR_GPU_LOAD, SENSOR_PERCENT<<4, &umr_bitf=
ield_default },
> +	{ "GPU_TEMP", AMDGPU_PP_SENSOR_GPU_TEMP, SENSOR_D1000|(SENSOR_TEMP<<4=
), &umr_bitfield_default },
> +	{ NULL, 0, 0, NULL },
> +};
> +
> +
>  #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
>  #define AMDGPU_INFO_VRAM_USAGE			0x10
>  #define AMDGPU_INFO_GTT_USAGE			0x11
> @@ -794,7 +803,10 @@ static void top_build_vi_program(struct umr_asic *=
asic)
>  		ENTRY(i++, "mmRLC_GPM_STAT", &stat_rlc_gpm_bits[0], &top_options.vi.=
gfxpwr, "GFX PWR");
> =20
>  	// sensors
> -	if (asic->config.gfx.family =3D=3D 135) {
> +	if (asic->config.gfx.family =3D=3D 141) {
> +		// Arctic Island Family
> +		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_ai_sensor_bits[0], &top_options.=
vi.sensors, "Sensors");
> +	} else if (asic->config.gfx.family =3D=3D 135) {
>  		// Carrizo/Stoney family
>  		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_carrizo_sensor_bits[0], &top_opt=
ions.vi.sensors, "Sensors");
>  	} else if (asic->config.gfx.family =3D=3D 130) {
>=20


--KsI8bdT0b5otcTo6WN8Wu0r8NVM5DlNmC--

--h1Tp78wJnJ4h4O9gJ3LgkkATA8KiFTo0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY559mAAoJEP4bvbfZuWjbJ2sP/2GVqScWB7g0IA+Gl2SzZZ6s
9frva21q2biMwiIMt70sGOKU6+/iTapV95PZ7grhxkzPiEHx34lqttuy+FATHzNJ
DnH8VsKXw4e4Q7ORNVptMtlQ5NGlFqXbL7BgLA2tGMTdSnpZb9+P2Ypv8DOMfdLZ
iGPA08VJeiYEinLiNQUM31w6Q6KuaYsZ4IHqhzQ2PJ18NalwGdJ6rKWU6wnaplHt
iphw8MpkulpGBg47plsl5q21IDQKq+o8gPFrUsd1q6mrNUNO4Des2zCxGqavJjkq
FnSkoxI6wLMll7Xh5hNW2zzqedxC2yTrvGbNr00DuSUwHk5+rJbGG6PO7dpeNZ/m
4wt4zK/5hhcjPFr6bFwWC8zXvCWMj2YyTm396KH1R8nsm3yzgITHthv+c8iVkID5
bvRJlF26fAno50nnkqjaXLYnBaU29aqt2gLy7QU/qHV83x3n7+wmOmf8QsO9ca4Y
U5+PppmBoRv+11kh7IjrNvCy/ovwCifmgZ6EZGPr9xRd1MOG9CEQDEcP2EAPMbh/
QCuVlne2nwNkE/UXEfjwoRb1WGWb85HkArExTHWD/ot0WV9sA45UMTQtPimQY50z
Z/3xRdlnWCOn6uQXvg0Uwiq/6Dg2dASEUT/9oqEPbEzNZXAaj8cubC4nPSIyAVpW
lFoYUBaLv0O4LhCAVWZA
=dWT7
-----END PGP SIGNATURE-----

--h1Tp78wJnJ4h4O9gJ3LgkkATA8KiFTo0K--

--===============0510377769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0510377769==--
