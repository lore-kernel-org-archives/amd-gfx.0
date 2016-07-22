From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: partial revert "cleanup ttm_tt_(unbind|destroy)"
 v2
Date: Fri, 22 Jul 2016 23:12:16 +1000
Message-ID: <f1a612c0-03d6-a279-23b5-2ab36aa605f8@folklore1984.net>
References: <1469193013-11482-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1966349429=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469193013-11482-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Amber.Lin-5C7GfCeVMHo@public.gmane.org, felix.kuehling-5C7GfCeVMHo@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1966349429==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hNdeu0w7t5rtnow7FpAabLFJrHRCrdAoL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hNdeu0w7t5rtnow7FpAabLFJrHRCrdAoL
Content-Type: multipart/mixed; boundary="JIdR7fsB4arvAp3IxtEkGDJ5SVKoQxGsk"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Amber.Lin-5C7GfCeVMHo@public.gmane.org, felix.kuehling-5C7GfCeVMHo@public.gmane.org
Message-ID: <f1a612c0-03d6-a279-23b5-2ab36aa605f8-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: partial revert "cleanup ttm_tt_(unbind|destroy)"
 v2
References: <1469193013-11482-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1469193013-11482-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--JIdR7fsB4arvAp3IxtEkGDJ5SVKoQxGsk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 07/22/2016 11:10 PM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> We still need to unbind explicitely during a move.
>=20
> This partial reverts commit ff20caa0bcbfef9f7686f8d1868a3b990921afd6.
>=20
> v2: remove unnecessary check and unused variable
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/ttm/ttm_bo_util.c |  1 +
>  drivers/gpu/drm/ttm/ttm_tt.c      | 19 ++++++++++++-------
>  include/drm/ttm/ttm_bo_driver.h   |  9 +++++++++
>  3 files changed, 22 insertions(+), 7 deletions(-)
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
> index d28d4333..526e5a7 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -166,16 +166,10 @@ EXPORT_SYMBOL(ttm_tt_set_placement_caching);
> =20
>  void ttm_tt_destroy(struct ttm_tt *ttm)
>  {
> -	int ret;
> -
>  	if (ttm =3D=3D NULL)
>  		return;
> =20
> -	if (ttm->state =3D=3D tt_bound) {
> -		ret =3D ttm->func->unbind(ttm);
> -		BUG_ON(ret);
> -		ttm->state =3D tt_unbound;
> -	}
> +	ttm_tt_unbind(ttm);
> =20
>  	if (ttm->state =3D=3D tt_unbound)
>  		ttm_tt_unpopulate(ttm);
> @@ -255,6 +249,17 @@ void ttm_dma_tt_fini(struct ttm_dma_tt *ttm_dma)
>  }
>  EXPORT_SYMBOL(ttm_dma_tt_fini);
> =20
> +void ttm_tt_unbind(struct ttm_tt *ttm)
> +{
> +	int ret;
> +
> +	if (ttm->state =3D=3D tt_bound) {
> +		ret =3D ttm->func->unbind(ttm);
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


--JIdR7fsB4arvAp3IxtEkGDJ5SVKoQxGsk--

--hNdeu0w7t5rtnow7FpAabLFJrHRCrdAoL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXkhuwAAoJEP4bvbfZuWjbATQP/0K4K0PvtnsZfqHbxktoX8vE
ttrAvfh9YgRI+i0b4M/DSB/hv3EOcGyyZArtooIQTr35vfjZ++yhVRtaTuc4YV8L
CkU4x9IZtZsZjmUor17WGoOP5JCu27XMHEyUMFgUcKKJwqVw5egLol3exaJ2qlOV
+naZ2/LzR1OmymDf2xzsB+FI+lbN5mIVbeNQakhcMXXc9ap4sV01Z+UQFEgiiML9
DFTSdgERvKN1k0thJ5rJnl5EF/w/2WNA/bg+RTLcluQJ2jOKB9X+IyTlDWZT3gNz
soYF6hOljZ04cOyrYwkLd7vtPE6hDoBRLVGCyrihNP+G91Coabq5uPS0HZjYgBNc
2sM6hfFXCbWi3dUOxzYNgBGcrYY/hOJJxuPgCFnm+h++X2q4rNpguJEkTq3Xfn3m
S6Lyt1CLRvB0836wO59KAT3fETzx0WyVQUEphvfWvrYCjn3/TBMO8kAx5Ory2cyi
Kj8gYwF5SbbzPT0TqGVr8WKGNTEZ52SAErJEhhTkIzKQfyeeOUBX6ikU8WhSFPcs
43oATAr+Uc31nTvQTbQq7wU/OFhXzOhIfkDQa0xhF2fLlFWI6g4STVoKdEjRIu62
6NRrCSaz2ABaT9rQ546ORe7jf8lGgQ5dd8dKK+DnkqddI/DbCbP2vU/6iEprL9b7
NUj1Tyse1UjFq8zaxQnW
=gjH/
-----END PGP SIGNATURE-----

--hNdeu0w7t5rtnow7FpAabLFJrHRCrdAoL--

--===============1966349429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1966349429==--
