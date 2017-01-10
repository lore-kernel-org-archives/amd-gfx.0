From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: drop min/max wrappers
Date: Tue, 10 Jan 2017 12:36:49 +1100
Message-ID: <5dd6c190-a2e5-8acc-125b-5102f92167ef@folklore1984.net>
References: <20170109223547.24601-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0413827021=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170109223547.24601-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0413827021==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lEiV0KxBQOO4vM29AK0g30UuX9c0PenH5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lEiV0KxBQOO4vM29AK0g30UuX9c0PenH5
Content-Type: multipart/mixed; boundary="1dlhCFl9qsTmFQgO1QWaXTrxOC7xoAcFi";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <5dd6c190-a2e5-8acc-125b-5102f92167ef-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: drop min/max wrappers
References: <20170109223547.24601-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20170109223547.24601-1-airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--1dlhCFl9qsTmFQgO1QWaXTrxOC7xoAcFi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 01/10/2017 09:35 AM, Dave Airlie wrote:
> From: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>=20
> These aren't needed, and aren't really used in too many places.
>=20
> Signed-off-by: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c        | 2 +-
>  drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c | 4 ++--
>  drivers/gpu/drm/amd/display/dc/os_types.h       | 2 --
>  3 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm=
/amd/display/dc/core/dc.c
> index 69819d8..763d1e3 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -628,7 +628,7 @@ struct dc *dc_create(const struct dc_init_data *ini=
t_params)
>  	full_pipe_count =3D core_dc->res_pool->pipe_count;
>  	if (core_dc->res_pool->underlay_pipe_index >=3D 0)
>  		full_pipe_count--;
> -	core_dc->public.caps.max_targets =3D dm_min(
> +	core_dc->public.caps.max_targets =3D min(
>  			full_pipe_count,
>  			core_dc->res_pool->stream_enc_count);
> =20
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c b/drivers/=
gpu/drm/amd/display/dc/dce/dce_clocks.c
> index 2626120..dd922bd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> @@ -289,7 +289,7 @@ static void dce_set_clock(
> =20
>  	/* Make sure requested clock isn't lower than minimum threshold*/
>  	if (requested_clk_khz > 0)
> -		requested_clk_khz =3D dm_max(requested_clk_khz,
> +		requested_clk_khz =3D max(requested_clk_khz,
>  				clk_dce->dentist_vco_freq_khz / 64);
> =20
>  	/* Prepare to program display clock*/
> @@ -364,7 +364,7 @@ static void dce112_set_clock(
> =20
>  	/* Make sure requested clock isn't lower than minimum threshold*/
>  	if (requested_clk_khz > 0)
> -		requested_clk_khz =3D dm_max(requested_clk_khz,
> +		requested_clk_khz =3D max(requested_clk_khz,
>  				clk_dce->dentist_vco_freq_khz / 62);
> =20
>  	dce_clk_params.target_clock_frequency =3D requested_clk_khz;
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/dr=
m/amd/display/dc/os_types.h
> index 7f0c282..27ed2a6 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -52,8 +52,6 @@
> =20
>  #define dm_vlog(fmt, args) vprintk(fmt, args)
> =20
> -#define dm_min(x, y) min(x, y)
> -#define dm_max(x, y) max(x, y)
>  #endif
> =20
> =20
>=20


--1dlhCFl9qsTmFQgO1QWaXTrxOC7xoAcFi--

--lEiV0KxBQOO4vM29AK0g30UuX9c0PenH5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdDqxAAoJEP4bvbfZuWjb9OEQANWBf1/+jT97G1OW2XIMtt39
2cCWo4ukBESOjkOV2TbrDFWCx3Hv/A+rY5s/CSDbGxkDmpFz0rogaBozXfhWhafQ
u0Jnf4bNYi1Pz2tCNdC8ITpYxdLsTCD6X3nqoaqhVlyfW3/PSblA6SBxUZYJJDf1
IpTVnIPJyiZG0cUwQTVMz3Q5eLqBlxl6YGW9wPiNmaNMJy9DBvuFLs3U4tkXP7bP
cgwAUO3OnY2quMebKwYBWAGY+pMzPu83UangTmIW+SmkoXAncJ+oNVMYcSJabNwa
/n00d5W1CpI2KZ8KFaKy8EkIjnT5nCgRqAiQKGVB+9DVmDkTImTyr9f8SpeVZAum
vYZ6PHSw8e8GaToduZ6Q96n3mIBZnoDxQZALCusgYEoNNRm6BtCht2ubqLq3iHZl
4m7349QOkWFR6eBssScRXm2nnMyce1iHnSQUHDeqvHHGkbySjikM/UMDSoror2Na
FMMubl3wxwi6CcXCfnUr7OpuGD8n7/s120Uk+z3rB4LLLIXfE17yKI/yThGfNLOx
Fgh1pQ0/n++HodW+0BDJYjBNrlI9ZCaKfXAyrgFrYLnSnVjMJAVtp2pTtXY4DBSk
95Sauuj8oYX8Afuzv8IFhgg4PzYJOK7taOknTNvwctaQzpaDX5Nu8RbKmoFgSOAe
YVD4i66jo/oguBt1ui6n
=Koqd
-----END PGP SIGNATURE-----

--lEiV0KxBQOO4vM29AK0g30UuX9c0PenH5--

--===============0413827021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0413827021==--
