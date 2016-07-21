From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/7] drm/amdgpu: fix indentation in struct amdgpu_ring
Date: Thu, 21 Jul 2016 20:24:51 +1000
Message-ID: <4a6f9600-1ce3-2f6d-7526-a2613c82a288@folklore1984.net>
References: <1469095284-2024-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0613696259=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469095284-2024-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0613696259==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uifvbmPEO5CgJwQVkmjlX2lcbmIECHnDX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uifvbmPEO5CgJwQVkmjlX2lcbmIECHnDX
Content-Type: multipart/mixed; boundary="aUUE6xWQgXk6RIHJfK2K6LDP5L28DkIt9"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <4a6f9600-1ce3-2f6d-7526-a2613c82a288-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/7] drm/amdgpu: fix indentation in struct amdgpu_ring
References: <1469095284-2024-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1469095284-2024-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--aUUE6xWQgXk6RIHJfK2K6LDP5L28DkIt9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

A nice revision of the previous solution btw..

On 07/21/2016 08:01 PM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 459e136..d939038 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -802,8 +802,8 @@ struct amdgpu_ring {
>  	enum amdgpu_ring_type	type;
>  	char			name[16];
>  	unsigned		cond_exe_offs;
> -	u64				cond_exe_gpu_addr;
> -	volatile u32	*cond_exe_cpu_addr;
> +	u64			cond_exe_gpu_addr;
> +	volatile u32		*cond_exe_cpu_addr;
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry *ent;
>  #endif
>=20


--aUUE6xWQgXk6RIHJfK2K6LDP5L28DkIt9--

--uifvbmPEO5CgJwQVkmjlX2lcbmIECHnDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXkKL4AAoJEP4bvbfZuWjbRkAP/2/cRkYol95dLB6xucuQsezm
vPSDeMbCWi9ii/aJopXcgfASbUBFopo5b120v3lRc4Ntz50srShfIutPG0LgzuyD
iWhIoIX5Ohxj2UxuHz3Efr1CZ+bAgzkYnD3wv2hXG26arExp8acbnMGw2XxUHfte
AXzamfn28ct5APsMQu41gO1Awtf9tqoM2/wrPhesYLd+OhtevoP5dcAFEthzKQk6
YHcXKwnw5b5Uy3d6fKpAckHcuz2NcOSy+vtm5Og7QXV29b1jE+lAMfQEGQpP8bfx
DkyjlIUd0uQOaYtTirJ1XjWgCeSm2BgDx9zpsKLi2DX+GLmz5Z/1DqgZjowhrYDg
hohAYaMdbs/D9RHaFeshHWdwj9nZPmQ9SPjR/T8qA3mBKoX3yYj0cliPvwqh+3A0
XBr/VMepbx7tGNYqT3YTaTdTO1Y1Suzfke8GzaL4w7Z3gDOd//Qti0ux/YKMNSns
QiS/iX5aOucCNDKPZWLK6HQpm0Tl4qNa8y6Xxlq7oJw0EePrslU/HaV6rm0tsiDr
Os7OdYNnSSZwR6xFjyKVwl34KTg/0jW+gfE092Y8zkhDc7jkVKdEZx4E59tptEg/
OikF292gCcy1CJOAaxSw/zspSbHdhkewNh8nu4ywEEOW1tAN5K5liOsJQ5a1z4ut
gwbddSQXYMVfWMTrQ0t1
=ZZKs
-----END PGP SIGNATURE-----

--uifvbmPEO5CgJwQVkmjlX2lcbmIECHnDX--

--===============0613696259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0613696259==--
