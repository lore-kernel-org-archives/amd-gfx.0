From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use pin rather than pin_restricted in a few
 cases
Date: Thu, 8 Dec 2016 11:35:55 +1100
Message-ID: <903d5cee-23aa-2626-83f4-92ff77306765@folklore1984.net>
References: <1481145457-23105-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0381373041=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481145457-23105-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============0381373041==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4Up6gjnoLgKjjE0w1VXBtPe8Ja9VoLtIK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Up6gjnoLgKjjE0w1VXBtPe8Ja9VoLtIK
Content-Type: multipart/mixed; boundary="JHxebIgnbd9NCk4WgIcOqQOephd4AOaBK";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <903d5cee-23aa-2626-83f4-92ff77306765-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use pin rather than pin_restricted in a few
 cases
References: <1481145457-23105-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1481145457-23105-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--JHxebIgnbd9NCk4WgIcOqQOephd4AOaBK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 12/08/2016 08:17 AM, Alex Deucher wrote:
> We don't require a resticted pinning in these cases, so just
> use plain pin.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_display.c
> index 741144f..581601c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -187,7 +187,7 @@ int amdgpu_crtc_page_flip_target(struct drm_crtc *c=
rtc,
>  		goto cleanup;
>  	}
> =20
> -	r =3D amdgpu_bo_pin_restricted(new_abo, AMDGPU_GEM_DOMAIN_VRAM, 0, 0,=
 &base);
> +	r =3D amdgpu_bo_pin(new_abo, AMDGPU_GEM_DOMAIN_VRAM, &base);
>  	if (unlikely(r !=3D 0)) {
>  		r =3D -EINVAL;
>  		DRM_ERROR("failed to pin new abo buffer before flip\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_fb.c
> index f1c9e59..24629be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -171,7 +171,7 @@ static int amdgpufb_create_pinned_object(struct amd=
gpu_fbdev *rfbdev,
>  	}
> =20
> =20
> -	ret =3D amdgpu_bo_pin_restricted(abo, AMDGPU_GEM_DOMAIN_VRAM, 0, 0, N=
ULL);
> +	ret =3D amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM, NULL);
>  	if (ret) {
>  		amdgpu_bo_unreserve(abo);
>  		goto out_unref;
>=20


--JHxebIgnbd9NCk4WgIcOqQOephd4AOaBK--

--4Up6gjnoLgKjjE0w1VXBtPe8Ja9VoLtIK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSKrrAAoJEP4bvbfZuWjbmVwQALOjsEGoInltkEop7wgWiuBv
xeJes3OaX1E2si4QTlFwGWIT5pMpu4J1Ibk9JIe4rvp4tP1ieX5wAuPiEY2Z2enY
NdD/6Lsh6PRUJrUwbYZIr2X20XOwP9RntNhMM7D3fEPNbSsUvm3MV6biieduroK4
yFDDPsk6/wRfunU0U1aq+10d8eEFDNU7/yjx86Vqp4Tf4d6UgqI8+6SRtLITW3vw
/v81z1gE8hbMyfDGkbHytsduhkJQnq1Se1L9MNInW+hNT4oo58msssKhrqnZBC0J
TAf4KFRrck0J5/fRDauxmVH5KcLkzFXIeUkydnocVQI9vMHgS+F6pfaNAEU070gd
PkNXuB/AE5Z6zKPF+Esd4O0Fo1ICiWzwrn4qMVOC7trNuNWTZnsuomwkBFQI4pT+
p57nUSe2UHcgW9kVi4fq5LgD9MskhOc30J4z2goyfMZeber7jejo3TGmzj5pJzzj
sukexUqlJ+a8E9ft3cuDOs5kJFih+X357bsxUQh2EOH87RLS2mlkkK4RojVc/+mn
mMzfAToj8IPMkVUI1USsbCC2gAZjav7QPoIWUCVu479ig+VMlLnoM/MK/aRrwrdN
HHZDzv5aJsuF0ULvvwPUiL9U/MESqyvjLaPoKBO9bC++usj2JLGJUFXLybB9tldn
9p5Ox7+Ct807WLQisgZv
=h/IY
-----END PGP SIGNATURE-----

--4Up6gjnoLgKjjE0w1VXBtPe8Ja9VoLtIK--

--===============0381373041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0381373041==--
