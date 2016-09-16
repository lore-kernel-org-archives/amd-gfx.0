From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx6: drop duplicate code
Date: Fri, 16 Sep 2016 18:26:56 +1000
Message-ID: <957941f6-a36b-4ce0-87db-51417b1f8472@folklore1984.net>
References: <1473969314-14962-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1579883985=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473969314-14962-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============1579883985==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CHXRsgW2HOEautmB62iteQPD3EWUWPt7W"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CHXRsgW2HOEautmB62iteQPD3EWUWPt7W
Content-Type: multipart/mixed; boundary="X6QQFpfUP1HClOBqdPEWxFJEqh0LUE296";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <957941f6-a36b-4ce0-87db-51417b1f8472-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx6: drop duplicate code
References: <1473969314-14962-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1473969314-14962-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--X6QQFpfUP1HClOBqdPEWxFJEqh0LUE296
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

P.S., keep these hedge cuttings coming!

On 09/16/2016 05:55 AM, Alex Deucher wrote:
> The compute functions just called the gfx functions, drop
> the wrapper.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 33 +++++++++------------------=
------
>  1 file changed, 9 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c
> index 9697994..3cf4e9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1324,8 +1324,8 @@ static void gfx_v6_0_ring_emit_hdp_invalidate(str=
uct amdgpu_ring *ring)
>  	amdgpu_ring_write(ring, 0x1);
>  }
> =20
> -static void gfx_v6_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64=
 addr,
> -					 u64 seq, unsigned flags)
> +static void gfx_v6_0_ring_emit_fence(struct amdgpu_ring *ring, u64 add=
r,
> +				     u64 seq, unsigned flags)
>  {
>  	bool write64bit =3D flags & AMDGPU_FENCE_FLAG_64BIT;
>  	bool int_sel =3D flags & AMDGPU_FENCE_FLAG_INT;
> @@ -1351,17 +1351,9 @@ static void gfx_v6_0_ring_emit_fence_gfx(struct =
amdgpu_ring *ring, u64 addr,
>  	amdgpu_ring_write(ring, upper_32_bits(seq));
>  }
> =20
> -static void gfx_v6_0_ring_emit_fence_compute(struct amdgpu_ring *ring,=

> -					     u64 addr, u64 seq,
> -					     unsigned flags)
> -{
> -	gfx_v6_0_ring_emit_fence_gfx(ring, addr, seq, flags);
> -}
> -
> -
> -static void gfx_v6_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
> -				      struct amdgpu_ib *ib,
> -				      unsigned vm_id, bool ctx_switch)
> +static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
> +				  struct amdgpu_ib *ib,
> +				  unsigned vm_id, bool ctx_switch)
>  {
>  	u32 header, control =3D 0;
> =20
> @@ -1388,13 +1380,6 @@ static void gfx_v6_0_ring_emit_ib_gfx(struct amd=
gpu_ring *ring,
>  	amdgpu_ring_write(ring, control);
>  }
> =20
> -static void gfx_v6_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
> -					  struct amdgpu_ib *ib,
> -					  unsigned vm_id, bool ctx_switch)
> -{
> -	gfx_v6_0_ring_emit_ib_gfx(ring, ib, vm_id, ctx_switch);
> -}
> -
>  /**
>   * gfx_v6_0_ring_test_ib - basic ring IB test
>   *
> @@ -3119,8 +3104,8 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ri=
ng_funcs_gfx =3D {
>  	.get_wptr =3D gfx_v6_0_ring_get_wptr,
>  	.set_wptr =3D gfx_v6_0_ring_set_wptr_gfx,
>  	.parse_cs =3D NULL,
> -	.emit_ib =3D gfx_v6_0_ring_emit_ib_gfx,
> -	.emit_fence =3D gfx_v6_0_ring_emit_fence_gfx,
> +	.emit_ib =3D gfx_v6_0_ring_emit_ib,
> +	.emit_fence =3D gfx_v6_0_ring_emit_fence,
>  	.emit_pipeline_sync =3D gfx_v6_0_ring_emit_pipeline_sync,
>  	.emit_vm_flush =3D gfx_v6_0_ring_emit_vm_flush,
>  	.emit_gds_switch =3D gfx_v6_0_ring_emit_gds_switch,
> @@ -3136,8 +3121,8 @@ static const struct amdgpu_ring_funcs gfx_v6_0_ri=
ng_funcs_compute =3D {
>  	.get_wptr =3D gfx_v6_0_ring_get_wptr,
>  	.set_wptr =3D gfx_v6_0_ring_set_wptr_compute,
>  	.parse_cs =3D NULL,
> -	.emit_ib =3D gfx_v6_0_ring_emit_ib_compute,
> -	.emit_fence =3D gfx_v6_0_ring_emit_fence_compute,
> +	.emit_ib =3D gfx_v6_0_ring_emit_ib,
> +	.emit_fence =3D gfx_v6_0_ring_emit_fence,
>  	.emit_pipeline_sync =3D gfx_v6_0_ring_emit_pipeline_sync,
>  	.emit_vm_flush =3D gfx_v6_0_ring_emit_vm_flush,
>  	.emit_gds_switch =3D gfx_v6_0_ring_emit_gds_switch,
>=20


--X6QQFpfUP1HClOBqdPEWxFJEqh0LUE296--

--CHXRsgW2HOEautmB62iteQPD3EWUWPt7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX26zQAAoJEP4bvbfZuWjbmioQAJCEVN0G6fDkXVtjTDoy7Ttx
V8H8WGG4u45riEY9aCknNQ0kJ1ttNRBDSo1Ik3ATlDRpRAQur6ccX9wLeGZZzGkj
stFOMH5sRuKtpuMl2SQPDy+EYpDQ/Hs4EU2BCh9ajgEjrwPJzUFLvoI7RRNItto7
Ey9Z7OnoD2y9wsPKZyhnoUzoQjcGynmnUsLPE2pu5jggRZZySDLnniHPc7NASeal
qQpyiYtk2Kir7c+iJnB4fAHJvkdnA/m7JhcqJq9IaQsQheNbdRd3u9dxvFtr/tE7
GbmXYoY/P5o+n2vrWYvZJp0FfNUZjfJoXKMDj0wEnckoQdeWxgx1S6U60DZQYdyh
VjwKd4LKmH8t9cB7VBZIG/5ntabb0DHguehAAO+iLyF5ZM7y+FqhmZR7J/rSnePh
aRkSlGqcFrIM/Wrm4/fKD4XYJE40TGRK9ZLHWt/eDEiZte8gaoVvQTJKGn3ITlT+
k++SN9KCWd8zRyU5pTZKgK7NXpbrJwtC19dkH1FInxCOCSF17Bap2m3FrAaFmWzq
k+ohqYM9mdhL0ZyqihAwzIr3EGL+bYat/fS4cMGI9rwpROYeMD9XNCbOz7TzXhh2
ACYfAlvLeUHrO7jKz3XkphxMLYHJzu/oYSGuOqDpNhYvld3MSKyOwxIE0SdGuwzH
6R/SJtXecdjMS0rbpBbs
=rjh7
-----END PGP SIGNATURE-----

--CHXRsgW2HOEautmB62iteQPD3EWUWPt7W--

--===============1579883985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1579883985==--
