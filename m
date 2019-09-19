From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v3 07/11] drm/ttm: rename ttm_fbdev_mmap
Date: Thu, 19 Sep 2019 13:25:39 +0200
Message-ID: <a93f8308-3e77-59c8-548e-c0553b33e205@suse.de>
References: <20190919100223.13309-1-kraxel@redhat.com>
 <20190919100223.13309-8-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0455519710=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190919100223.13309-8-kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0455519710==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1Vl4XQmXHd78qivdStEU98KPXVJ7s4NIH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Vl4XQmXHd78qivdStEU98KPXVJ7s4NIH
Content-Type: multipart/mixed; boundary="TzvBT24JB85x8wBrIXcljxPE6A7tpUr9f";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>,
 Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>,
 "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>,
 David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>,
 Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <a93f8308-3e77-59c8-548e-c0553b33e205-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v3 07/11] drm/ttm: rename ttm_fbdev_mmap
References: <20190919100223.13309-1-kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
 <20190919100223.13309-8-kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <20190919100223.13309-8-kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

--TzvBT24JB85x8wBrIXcljxPE6A7tpUr9f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 19.09.19 um 12:02 schrieb Gerd Hoffmann:
> Rename ttm_fbdev_mmap to ttm_bo_mmap_obj.  Move the vm_pgoff sanity
> check to amdgpu_bo_fbdev_mmap (only ttm_fbdev_mmap user in tree).
>=20
> The ttm_bo_mmap_obj function can now be used to map any buffer object.
> This allows to implement &drm_gem_object_funcs.mmap in gem ttm helpers.=

>=20
> Signed-off-by: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Thanks. I find this to be a much cleaner interface than before.

Acked-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>

Best regards
Thomas

> ---
>  include/drm/ttm/ttm_bo_api.h               | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  5 ++++-
>  drivers/gpu/drm/ttm/ttm_bo_vm.c            |  8 ++------
>  3 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.=
h
> index 43c4929a2171..d2277e06316d 100644
> --- a/include/drm/ttm/ttm_bo_api.h
> +++ b/include/drm/ttm/ttm_bo_api.h
> @@ -710,16 +710,14 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo, uns=
igned long start_page,
>  void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map);
> =20
>  /**
> - * ttm_fbdev_mmap - mmap fbdev memory backed by a ttm buffer object.
> + * ttm_bo_mmap_obj - mmap memory backed by a ttm buffer object.
>   *
>   * @vma:       vma as input from the fbdev mmap method.
> - * @bo:        The bo backing the address space. The address space wil=
l
> - * have the same size as the bo, and start at offset 0.
> + * @bo:        The bo backing the address space.
>   *
> - * This function is intended to be called by the fbdev mmap method
> - * if the fbdev address space is to be backed by a bo.
> + * Maps a buffer object.
>   */
> -int ttm_fbdev_mmap(struct vm_area_struct *vma, struct ttm_buffer_objec=
t *bo);
> +int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_obje=
ct *bo);
> =20
>  /**
>   * ttm_bo_mmap - mmap out of the ttm device address space.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> index 2f11ebd95528..e5447e0d8b88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1051,7 +1051,10 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
>  int amdgpu_bo_fbdev_mmap(struct amdgpu_bo *bo,
>  			     struct vm_area_struct *vma)
>  {
> -	return ttm_fbdev_mmap(vma, &bo->tbo);
> +	if (vma->vm_pgoff !=3D 0)
> +		return -EACCES;
> +
> +	return ttm_bo_mmap_obj(vma, &bo->tbo);
>  }
> =20
>  /**
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_=
bo_vm.c
> index b5314ef85a3d..6688d7893161 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -479,14 +479,10 @@ int ttm_bo_mmap(struct file *filp, struct vm_area=
_struct *vma,
>  }
>  EXPORT_SYMBOL(ttm_bo_mmap);
> =20
> -int ttm_fbdev_mmap(struct vm_area_struct *vma, struct ttm_buffer_objec=
t *bo)
> +int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_obje=
ct *bo)
>  {
> -	if (vma->vm_pgoff !=3D 0)
> -		return -EACCES;
> -
>  	ttm_bo_get(bo);
> -
>  	ttm_bo_mmap_vma_setup(bo, vma);
>  	return 0;
>  }
> -EXPORT_SYMBOL(ttm_fbdev_mmap);
> +EXPORT_SYMBOL(ttm_bo_mmap_obj);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--TzvBT24JB85x8wBrIXcljxPE6A7tpUr9f--

--1Vl4XQmXHd78qivdStEU98KPXVJ7s4NIH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl2DZbMACgkQaA3BHVML
eiNZ8QgAkTCp+uwT0g6oLhkmYEgwDPEmHEvdPKTjp6X+r7iztEI/zXi0i6XCQqB+
k7Bv5MZtSEe6Yg5V1JSPKxZ0fW8W7Hib5g1hfOUpHrTvXtn+2YNPaEnSsn2+eMBG
YrBHQRrHhvUtIDQxnOgoYA3vusPw4aNQoOmBjUllBn9aVjZ6RhNOkqLi+5zqv5L7
NQAi05BaLdaC7M4YovLHhrsi3xIlLmY9+kqlKI8vycgN/2d1bwCGXTjCNic1Y/ub
DhUZgK7Gh+t2pQ0HCWvF8zeVk00HnQ0o7WtePndP0jCBK45WCNAHOmAoL5elh34u
KCmlXwrGEGOoybyCaVPbq+u0kT4nSg==
=Zvov
-----END PGP SIGNATURE-----

--1Vl4XQmXHd78qivdStEU98KPXVJ7s4NIH--

--===============0455519710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0455519710==--
