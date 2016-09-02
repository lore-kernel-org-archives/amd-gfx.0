From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx6: drop some dead code
Date: Fri, 2 Sep 2016 13:17:26 +1000
Message-ID: <cff37221-8b5f-e2d2-f0f2-ef76d1a14fea@folklore1984.net>
References: <1472753496-8114-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1785050999=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472753496-8114-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1785050999==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PskcNT7f7ej42FhNH1kLl91oUXgFBnb64"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PskcNT7f7ej42FhNH1kLl91oUXgFBnb64
Content-Type: multipart/mixed; boundary="aqXjsggwwvTSjTF2tJsagkG8GofKEBQoa";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <cff37221-8b5f-e2d2-f0f2-ef76d1a14fea-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx6: drop some dead code
References: <1472753496-8114-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1472753496-8114-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--aqXjsggwwvTSjTF2tJsagkG8GofKEBQoa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 09/02/2016 04:11 AM, Alex Deucher wrote:
> The mqd is only used on CI and newer.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c
> index 17a560c..040bc7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1725,28 +1725,6 @@ static void gfx_v6_0_ring_set_wptr_compute(struc=
t amdgpu_ring *ring)
> =20
>  }
> =20
> -
> -static void gfx_v6_0_cp_compute_fini(struct amdgpu_device *adev)
> -{
> -	int i, r;
> -
> -	for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> -		struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
> -
> -		if (ring->mqd_obj) {
> -			r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> -			if (unlikely(r !=3D 0))
> -				dev_warn(adev->dev, "(%d) reserve MQD bo failed\n", r);
> -
> -			amdgpu_bo_unpin(ring->mqd_obj);
> -			amdgpu_bo_unreserve(ring->mqd_obj);
> -
> -			amdgpu_bo_unref(&ring->mqd_obj);
> -			ring->mqd_obj =3D NULL;
> -		}
> -	}
> -}
> -
>  static int gfx_v6_0_cp_compute_resume(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ring *ring;
> @@ -2865,7 +2843,6 @@ static int gfx_v6_0_sw_fini(void *handle)
>  	for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>  		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> =20
> -	gfx_v6_0_cp_compute_fini(adev);
>  	gfx_v6_0_rlc_fini(adev);
> =20
>  	return 0;
>=20


--aqXjsggwwvTSjTF2tJsagkG8GofKEBQoa--

--PskcNT7f7ej42FhNH1kLl91oUXgFBnb64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyO9KAAoJEP4bvbfZuWjbkowP/jcTawzJWm+9EWxSmGiHu6Rv
NIagsZ5eqh/GIvSme2ZHAyG/X/6KqGO3VQNWUF+RXKYF/HNOXCc/zForm6TYmJzI
O0hSf6/islBcelvJ2OitMC+5XITL4QwGH74t0KE8i96u6mL7JP093HWqXcSrrW/C
c6JAPaOYeEkApJptBQoKfzigvpZ8sW9tFFWOIjz1i6l59tOU6ixjCFydxadPC6ml
kktHA3EhuSchUDnQawX8QdKaVVa65ZjRkJtVgYIWUmq011zQryGCzY/hBqTdpeSW
VbJnV6kz0yb7OxlA38VHQUTnEgmXnO+zPo+YbqEMaRApWkUMnCsnDQ/VrB8RCceL
NvVIBmYa/otsbeS+4TvFTC7DRBq/IxUTq2/Ww4T1+CAocurHs+n1rPe9+MURby6A
XbgUwnP9OyLI9eqY3M04F29LtKFezuDum//szLdiByBPWuJ6p5GYelmY2TD4DOPs
mTilgJ9tWKmTAJtXX5NQUOf+Q3x9NX8ky53sj9bjSdueVZteR2ACiUmXv9n1IFsq
CcQu0qSuuYohmDVNmaGZWCksViifpcgIfOqo1VYUZiyL+a661PrZvGVOUTJwHM4f
JvD0FowZEuGJSixnjaXFStvnZ5PqTfybIn+eiO/CDRjh352Wn4mo83NSu2sWP1Z/
ZHDHdyox8oYP4Cp+xoUB
=lbVw
-----END PGP SIGNATURE-----

--PskcNT7f7ej42FhNH1kLl91oUXgFBnb64--

--===============1785050999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1785050999==--
