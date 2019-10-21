From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: Fix DSC throughput mode 0 mask definition
Date: Mon, 21 Oct 2019 15:35:36 +0000
Message-ID: <584f5292-c177-34d8-8e2f-0e6661a87f23@amd.com>
References: <20191021150345.igdye4kv35nsk4ox@outlook.office365.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0721323171=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191021150345.igdye4kv35nsk4ox-1ViLX0X+lBJGNQ1M2rI3KwRV3xvJKrda@public.gmane.org>
Content-Language: en-US
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
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Cornij, Nikola" <Nikola.Cornij-5C7GfCeVMHo@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?Windows-1252?Q?Ville_Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rodrigo Siqueira <rodrigosiqueiramelo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0721323171==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5AEnsr0KGpggiNbzF6C8RpBBDmYFBFOo5"

--5AEnsr0KGpggiNbzF6C8RpBBDmYFBFOo5
Content-Type: multipart/mixed; boundary="nJMgTaE3fRVCldVSrzx3nOVyfe3neO6fn"

--nJMgTaE3fRVCldVSrzx3nOVyfe3neO6fn
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-10-21 11:03 a.m., Siqueira, Rodrigo wrote:
> Commit d7cd0e05 introduced a change at DP_DSC_THROUGHPUT_MODE_0_170
> which is not aligned with the spec. This commit replace 15 << 4 by
> 15 << 0 for DP_DSC_THROUGHPUT_MODE_0_170 in order to make it follow the=

> specification.
>=20
> Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Cc: Nikola Cornij <nikola.cornij-5C7GfCeVMHo@public.gmane.org>
> Cc: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Ville Syrj=E4l=E4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Fixes: d7cd0e053b1 (drm/amd/display: Add 170Mpix/sec DSC throughput sup=
port)
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

Harry

> ---
>  include/drm/drm_dp_helper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index cfadeeef8492..52024049c59e 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -306,7 +306,7 @@
>  # define DP_DSC_THROUGHPUT_MODE_0_900       (12 << 0)
>  # define DP_DSC_THROUGHPUT_MODE_0_950       (13 << 0)
>  # define DP_DSC_THROUGHPUT_MODE_0_1000      (14 << 0)
> -# define DP_DSC_THROUGHPUT_MODE_0_170       (15 << 4)
> +# define DP_DSC_THROUGHPUT_MODE_0_170       (15 << 0) /* 1.4a */
>  # define DP_DSC_THROUGHPUT_MODE_1_MASK      (0xf << 4)
>  # define DP_DSC_THROUGHPUT_MODE_1_SHIFT     4
>  # define DP_DSC_THROUGHPUT_MODE_1_UPSUPPORTED 0
>=20


--nJMgTaE3fRVCldVSrzx3nOVyfe3neO6fn--

--5AEnsr0KGpggiNbzF6C8RpBBDmYFBFOo5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkiEcMSFhcOGNLtE6LVgVyYwUtuMFAl2t0EUACgkQLVgVyYwU
tuON8gf+Mgje6g3E0+fTAj/6T//tK+k2y7tTD/Tast/oj4gw5ZKZzprYVwXqHfGe
AeJfwbwFtfGjFt21RU62DxwrgK9jDq8LapcNZLYE2ox3AjHGWL+mImXBCKS1gKmY
YlWSt29xA1RI7RD1y3Lo4xSMsstFbpNMP5063sRM5x7J4qUyZSuzTcPVGyYYit5G
VQ+Ofd8Vvb84ILbjD5s4eQik2w3C31TLBlMrDnVsr6Ui01pysx/ZsQgUSReIxI2C
jAIWDhlG8eKIpsP3Xx+BDpZwAST5n6nD8PLVDHfUcKG3xqkkMeYc7QVvbjEGnf+w
UkFpcP9KCK8hvRfh+XS+4AxVUJcCNg==
=BQvT
-----END PGP SIGNATURE-----

--5AEnsr0KGpggiNbzF6C8RpBBDmYFBFOo5--

--===============0721323171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0721323171==--
