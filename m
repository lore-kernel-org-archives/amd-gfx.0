From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: export a function to read fan rpm
Date: Sun, 30 Oct 2016 16:10:28 +1100
Message-ID: <85ab550e-ccff-6f0c-9a1e-4a9aa2feaf34@folklore1984.net>
References: <1477772939-23619-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1812874039=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477772939-23619-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1812874039==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ebDQQB1qeKstO91i1ARgWxe6L1tPL8AWA"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ebDQQB1qeKstO91i1ARgWxe6L1tPL8AWA
Content-Type: multipart/mixed; boundary="jiiPrJvOUwJkLR242cB1PbubqDULxic8c";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <85ab550e-ccff-6f0c-9a1e-4a9aa2feaf34-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: export a function to read fan rpm
References: <1477772939-23619-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1477772939-23619-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--jiiPrJvOUwJkLR242cB1PbubqDULxic8c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Howdy,

On 10/30/2016 07:28 AM, Grazvydas Ignotas wrote:
> Powerplay hwmgr already has an implementation, all we need to do is to =
call it.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c     | 18 +++++++++++++++=
+++
>  drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h |  1 +
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gp=
u/drm/amd/powerplay/amd_powerplay.c
> index 0b1f220..1f49764 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -582,6 +582,23 @@ static int pp_dpm_get_fan_speed_percent(void *hand=
le, uint32_t *speed)
>  	return hwmgr->hwmgr_func->get_fan_speed_percent(hwmgr, speed);
>  }
> =20
> +static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)

why not type the handle rather than have 'void *' and a coercion (I
didn't check the call site yet..)

> +{
> +	struct pp_hwmgr *hwmgr;
> +
> +	if (handle =3D=3D NULL)

if (!handle)

> +		return -EINVAL;
> +
> +	hwmgr =3D ((struct pp_instance *)handle)->hwmgr;
> +
> +	PP_CHECK_HW(hwmgr);
> +
> +	if (hwmgr->hwmgr_func->get_fan_speed_rpm =3D=3D NULL)

if (!hwmgr->hwmgr_func->get_fan_speed_rpm)

> +		return -EINVAL;
> +
> +	return hwmgr->hwmgr_func->get_fan_speed_rpm(hwmgr, rpm);
> +}
> +
>  static int pp_dpm_get_temperature(void *handle)
>  {
>  	struct pp_hwmgr  *hwmgr;
> @@ -852,6 +869,7 @@ const struct amd_powerplay_funcs pp_dpm_funcs =3D {=

>  	.get_fan_control_mode =3D pp_dpm_get_fan_control_mode,
>  	.set_fan_speed_percent =3D pp_dpm_set_fan_speed_percent,
>  	.get_fan_speed_percent =3D pp_dpm_get_fan_speed_percent,
> +	.get_fan_speed_rpm =3D pp_dpm_get_fan_speed_rpm,
>  	.get_pp_num_states =3D pp_dpm_get_pp_num_states,
>  	.get_pp_table =3D pp_dpm_get_pp_table,
>  	.set_pp_table =3D pp_dpm_set_pp_table,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h b/driver=
s/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> index eb3e83d..2892b4e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amd_powerplay.h
> @@ -349,6 +349,7 @@ struct amd_powerplay_funcs {
>  	int (*get_fan_control_mode)(void *handle);
>  	int (*set_fan_speed_percent)(void *handle, uint32_t percent);
>  	int (*get_fan_speed_percent)(void *handle, uint32_t *speed);
> +	int (*get_fan_speed_rpm)(void *handle, uint32_t *rpm);
>  	int (*get_pp_num_states)(void *handle, struct pp_states_info *data);
>  	int (*get_pp_table)(void *handle, char **table);
>  	int (*set_pp_table)(void *handle, const char *buf, size_t size);
>=20


--jiiPrJvOUwJkLR242cB1PbubqDULxic8c--

--ebDQQB1qeKstO91i1ARgWxe6L1tPL8AWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYFYDFAAoJEP4bvbfZuWjblH0P/2WLMq+KJswDmm2N3IrVVAmL
/93Aj+tm3Q3hAcorEXqvgKoO37lWURh7dndz2b7D535jKP0pOmen9oiZugs9I6+N
QccGhOo9irr0CCQ95nvrXNEUTjabmeDgvCTzlDQdqB/2o8Bz5BmtMeEhA2RVqEO9
ZebXxEDvvntmXn2xgnOa0Kmv1w4Jy7w7Zngonkn5o4zgh8Gz1Bjr5dDWT01ouW70
NPkQqyLsZo6JO0qiQ3mNKi6QAzFF/Fr33PEw0u77fIRO7dxiFWGYhBb5vtAQxni1
pavlV45QT76jErPJSb6NeEy01uQYx+Z29+fu97ZU/1rRevWqAAZP0e4iHWP06Fda
YILrM8jyaJtYnzt5DOZc1r9Wskge6I0HLnR4MWVTiK7I+UBfQGGwKE9uO8hb4blT
9CjSNbKQtyCmrKCBZ8r269+CEc/z78+Iv2wE7w+GovdLpplSqIXDxnhtLyTHiUEc
D6AGrQjlvXvL1GrGyDB4eOB8GkqX6+OmIB+DX6fCkgwnuvAwTRR8l2iiJ7ES5AbJ
qvCwVnKhZRMWFjTbBPmxgUOf94PeQL5LipQ3jrYia7cKH8RqqifKqDpXMFnykEF9
X84Bv4Siko4Vb5sAFd6TxClt5mtHTmFbeJHZlI3y1qnC990Wj8UbTlXcsGRNSTy5
q4gUUu+06DtxYQ7NUn0s
=1rKU
-----END PGP SIGNATURE-----

--ebDQQB1qeKstO91i1ARgWxe6L1tPL8AWA--

--===============1812874039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1812874039==--
