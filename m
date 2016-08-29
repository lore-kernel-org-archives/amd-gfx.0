From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/amdgpu: use explicit limit for VRAM_LINEAR
 handling
Date: Mon, 29 Aug 2016 20:59:08 +1000
Message-ID: <9659ebbd-f022-2c3e-0497-ecbe7180d408@folklore1984.net>
References: <1472462424-3052-1-git-send-email-deathsimple@vodafone.de>
 <1472462424-3052-3-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1057454061=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472462424-3052-3-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
--===============1057454061==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tjB7XqM1kVg7Vw9E2Jdccqs6IPOX9wbvG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tjB7XqM1kVg7Vw9E2Jdccqs6IPOX9wbvG
Content-Type: multipart/mixed; boundary="6dxo7jxTdOKGgDwfF7QeAal55ScChtIdV"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <9659ebbd-f022-2c3e-0497-ecbe7180d408-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/amdgpu: use explicit limit for VRAM_LINEAR
 handling
References: <1472462424-3052-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
 <1472462424-3052-3-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1472462424-3052-3-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--6dxo7jxTdOKGgDwfF7QeAal55ScChtIdV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/29/2016 07:20 PM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> Split VRAM won't have a valid offset, so just set an explicit limit
> when the flag is given to trigger reallocation if necessary.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> index 6f83909..79f6413 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -123,12 +123,17 @@ static void amdgpu_ttm_placement_init(struct amdg=
pu_device *adev,
> =20
>  	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>  		unsigned visible_pfn =3D adev->mc.visible_vram_size >> PAGE_SHIFT;
> +		unsigned lpfn =3D 0;
> +
> +		/* This forces a reallocation if the flag wasn't set before */
> +		if (flags & AMDGPU_GEM_CREATE_VRAM_LINEAR)
> +			lpfn =3D adev->mc.real_vram_size >> PAGE_SHIFT;
> =20
>  		if (flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS &&
>  		    !(flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) &&
>  		    adev->mc.visible_vram_size < adev->mc.real_vram_size) {
>  			places[c].fpfn =3D visible_pfn;
> -			places[c].lpfn =3D 0;
> +			places[c].lpfn =3D lpfn;
>  			places[c].flags =3D TTM_PL_FLAG_WC |
>  				TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_VRAM |
>  				TTM_PL_FLAG_TOPDOWN;
> @@ -136,7 +141,7 @@ static void amdgpu_ttm_placement_init(struct amdgpu=
_device *adev,
>  		}
> =20
>  		places[c].fpfn =3D 0;
> -		places[c].lpfn =3D 0;
> +		places[c].lpfn =3D lpfn;
>  		places[c].flags =3D TTM_PL_FLAG_WC | TTM_PL_FLAG_UNCACHED |
>  			TTM_PL_FLAG_VRAM;
>  		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
>=20


--6dxo7jxTdOKGgDwfF7QeAal55ScChtIdV--

--tjB7XqM1kVg7Vw9E2Jdccqs6IPOX9wbvG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxBV9AAoJEP4bvbfZuWjbMKMP/jWz4HGjU7nTHmGaSONwmsWG
HJRRqXqbocBPRK5+ONrHatrlAmM62lT0FRoWsVvfAxv/x35fni/FB5nL5y0fkkpa
STRXLnryYrudwsuV7SCa0pRxQ/WjbcYhYp+pBYvRWp0cdmMGB3EaDAuFh7REihiF
6ldzsf315ZTkMS/+0LM47xoGe2LaXj3eTpejVzvAJU7cRDChhAOlIYiytMmcarw2
Qi93Waqg4kr33ppfxotYKRatWN/1FpRXwQmqF6Qs+/wWAI46qsrJBL+Sgr4fi2TV
Br5YyCQYM5nJS5WLAlW6VVcrHMOIt7pQtKZvaSTVrloTHYe3KSJexFGo0tOjFhCK
191cdVaT1nAILYCS9ZEJz6l+cVtM9DoioWOhGMZqWrF+R/Z39nU6MLeDQaVMF1Di
Ybv4EktD/gNaZrdTAPz5GvamRO1wHrE56zLitN5UDeJEDh4vYC/n5aIS+FgMoxGQ
+Q5Pqg/TtNKdv6gGRG6vCkLu6hm62m7lrZX7vROw2R3Z97LKExIyIK62cnTZw9C9
ZNCJmOGkCr0O8HfFNCAPU3D+7qjjd5Fsg5jc+SXufx9IFGpHUzZYNE04+BTE4Txg
++q6FpIS+V671A/sEPKIdfSLuKKiFaDcKB4uF68knQIs9dTjeZYeknH+qM0D5g7I
BS2oEgGqkO1WScbfUNhe
=XoFs
-----END PGP SIGNATURE-----

--tjB7XqM1kVg7Vw9E2Jdccqs6IPOX9wbvG--

--===============1057454061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1057454061==--
