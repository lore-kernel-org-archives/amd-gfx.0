From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: partial revert "cleanup ttm_tt_(unbind|destroy)"
Date: Fri, 22 Jul 2016 10:54:48 +1000
Message-ID: <24a16555-dafa-771c-2f64-4dedf9d56e92@folklore1984.net>
References: <1469097271-3378-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1938808796=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469097271-3378-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
--===============1938808796==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DgcO1USIVUwO2vf1mGHt6TJtQEUtPfRMO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DgcO1USIVUwO2vf1mGHt6TJtQEUtPfRMO
Content-Type: multipart/mixed; boundary="F39wiQF7NDuiImoQuhrgM3o2lt7DkF5Tt"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <24a16555-dafa-771c-2f64-4dedf9d56e92-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: partial revert "cleanup ttm_tt_(unbind|destroy)"
References: <1469097271-3378-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1469097271-3378-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--F39wiQF7NDuiImoQuhrgM3o2lt7DkF5Tt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/21/2016 08:34 PM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> We still need to unbind explicitely during a move.
>=20
> This partial reverts commit ff20caa0bcbfef9f7686f8d1868a3b990921afd6.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_util.c |  1 +
>  drivers/gpu/drm/ttm/ttm_tt.c      | 15 ++++++++++++---
>  include/drm/ttm/ttm_bo_driver.h   |  9 +++++++++
>  3 files changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/tt=
m_bo_util.c
> index 0c389a5..6c412c3 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -53,6 +53,7 @@ int ttm_bo_move_ttm(struct ttm_buffer_object *bo,
>  	int ret;
> =20
>  	if (old_mem->mem_type !=3D TTM_PL_SYSTEM) {
> +		ttm_tt_unbind(ttm);
>  		ttm_bo_free_old_node(bo);
>  		ttm_flag_masked(&old_mem->placement, TTM_PL_FLAG_SYSTEM,
>  				TTM_PL_MASK_MEM);
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.=
c
> index d28d4333..fa42dc3 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -172,9 +172,7 @@ void ttm_tt_destroy(struct ttm_tt *ttm)
>  		return;
> =20
>  	if (ttm->state =3D=3D tt_bound) {
> -		ret =3D ttm->func->unbind(ttm);
> -		BUG_ON(ret);
> -		ttm->state =3D tt_unbound;
> +		ttm_tt_unbind(ttm);
>  	}

Why keep the branch here given that the branch is also within
'ttm_tt_unbind()'?

> =20
>  	if (ttm->state =3D=3D tt_unbound)
> @@ -255,6 +253,17 @@ void ttm_dma_tt_fini(struct ttm_dma_tt *ttm_dma)
>  }
>  EXPORT_SYMBOL(ttm_dma_tt_fini);
> =20
> +void ttm_tt_unbind(struct ttm_tt *ttm)
> +{
> +	int ret;
> +
> +	if (ttm->state =3D=3D tt_bound) {
> +		ret =3D ttm->func->unbind(ttm);

int ret; here

Kind Regards,
Edward.

> +		BUG_ON(ret);
> +		ttm->state =3D tt_unbound;
> +	}
> +}
> +
>  int ttm_tt_bind(struct ttm_tt *ttm, struct ttm_mem_reg *bo_mem)
>  {
>  	int ret =3D 0;
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_d=
river.h
> index 141cefb..e7d81a8 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -628,6 +628,15 @@ extern int ttm_tt_bind(struct ttm_tt *ttm, struct =
ttm_mem_reg *bo_mem);
>  extern void ttm_tt_destroy(struct ttm_tt *ttm);
> =20
>  /**
> + * ttm_ttm_unbind:
> + *
> + * @ttm: The struct ttm_tt.
> + *
> + * Unbind a struct ttm_tt.
> + */
> +extern void ttm_tt_unbind(struct ttm_tt *ttm);
> +
> +/**
>   * ttm_tt_swapin:
>   *
>   * @ttm: The struct ttm_tt.
>=20


--F39wiQF7NDuiImoQuhrgM3o2lt7DkF5Tt--

--DgcO1USIVUwO2vf1mGHt6TJtQEUtPfRMO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXkW7YAAoJEP4bvbfZuWjbbzUP/iALYaj40f8RGxiwCDghOh4a
lnZ2F3ni5MQIjOe9+hYR5eb3NLML1/1R1YCAiP5zzYcsAWy9X0/XJ5CJevXFzRgU
YazxzVl7NEwAA6S/zc517bpFBJ4YXgV+UR0iryZOSoG8D98kSQJz6MbT94L3k1cP
8IfW5jD7v0UxgXKJgrDHhFFhMHFDLTWoflw5uCTK9ShgGSJfQKHp9uAZUAsT/H6M
yAufZxi20zCwVFX/TtzPASMhkY3wtvSFAzXsGZ/i2+khBA7oS6oaaMLgUkkMinjQ
HeBzrWvuRPJmwYRUzX3nZEdhcIvdCVf65X/7/yYmLkwSsvBEb9UpuytquLu7WV3p
SOzvjqJXmlzE/Z3pXMlj1J7Bhen25jsoSP/oQuuvm7RhSpET9dJmd5h0OUHc8m17
5gCELyBYEdWoGN/5D1gdnGNvwcHWDPFClsbRsPuIF36HpbyNFJ+4BIgAfXAUa3LU
I9+6nURG7+YT0z+IzhJtmu0QAiJ5wNnmmlyFEo0MvqrhACNFcO5xmHwY9i1sw27p
8ZOLCig4AWZ5DDiC+bfopM0IiRIMCTT2Z5Vt8vRSvjBqUwxuNpVcNEm8OMLBRJzD
0s3tG+saS2mu+8ZWQ+N4zeeNcxubkggcO9xSfSDVBv0VU7sjzBKmCvtQhIlT21dh
nBMv6e2zvB4MK5QXhPlz
=lrLy
-----END PGP SIGNATURE-----

--DgcO1USIVUwO2vf1mGHt6TJtQEUtPfRMO--

--===============1938808796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1938808796==--
