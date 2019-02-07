From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/5] Clean up TTM mmap offsets
Date: Thu, 7 Feb 2019 10:45:26 +0100
Message-ID: <552aa321-98d4-344d-eda2-8441940b5811@suse.de>
References: <20190207085931.29569-1-tzimmermann@suse.de>
 <e03e4cff-557b-9d50-dba8-94835e768743@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1334058901=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e03e4cff-557b-9d50-dba8-94835e768743-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org" <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org" <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1334058901==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ph3dCPhyLO8rNzKBNrKknkwmOzQcKOxRr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ph3dCPhyLO8rNzKBNrKknkwmOzQcKOxRr
Content-Type: multipart/mixed; boundary="hWl33hLGCoKgv2YV1Ka4BxzdlBFSIita6";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>,
 "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>,
 "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>,
 "airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
 "kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
 "z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>,
 "zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 "kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>,
 "puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>,
 "bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
 "thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org" <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>,
 "linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org"
 <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>,
 "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org"
 <arnd-r2nGTMty4D4@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
 "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org"
 <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Message-ID: <552aa321-98d4-344d-eda2-8441940b5811-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/5] Clean up TTM mmap offsets
References: <20190207085931.29569-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
 <e03e4cff-557b-9d50-dba8-94835e768743-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <e03e4cff-557b-9d50-dba8-94835e768743-5C7GfCeVMHo@public.gmane.org>

--hWl33hLGCoKgv2YV1Ka4BxzdlBFSIita6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 07.02.19 um 10:36 schrieb Koenig, Christian:
> Am 07.02.19 um 09:59 schrieb Thomas Zimmermann:
>> Almost all TTM-based drivers use the same values for the mmap-able
>> range of BO addresses. Each driver therefore duplicates the
>> DRM_FILE_PAGE_OFFSET constant. OTOH, the mmap range's size is not
>> configurable by drivers.
>>
>> This patch set replaces driver-specific configuration with a single
>> setup. All code is located within TTM. TTM and GEM share the same
>> range for mmap-able BOs.
>>
>> Thomas Zimmermann (5):
>>    staging/vboxvideo: Use same BO mmap offset as other drivers
>>    drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
>>    drm/ttm: Remove file_page_offset parameter from ttm_bo_device_init(=
)
>>    drm/ttm: Quick-test mmap offset in ttm_bo_mmap()
>>    drm: Use the same mmap-range offset and size for GEM and TTM
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org> for the wh=
ole=20
> series.

That was quick! Thank you.

>=20
> Nice cleanup! Thanks,
> Christian.
>=20
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 12 ++----------
>>   drivers/gpu/drm/ast/ast_drv.h               |  2 --
>>   drivers/gpu/drm/ast/ast_ttm.c               | 10 ++--------
>>   drivers/gpu/drm/bochs/bochs.h               |  2 --
>>   drivers/gpu/drm/bochs/bochs_mm.c            | 10 ++--------
>>   drivers/gpu/drm/cirrus/cirrus_drv.h         |  1 -
>>   drivers/gpu/drm/cirrus/cirrus_ttm.c         | 10 ++--------
>>   drivers/gpu/drm/drm_gem.c                   | 17 -----------------
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c | 12 ++----------
>>   drivers/gpu/drm/mgag200/mgag200_drv.h       |  1 -
>>   drivers/gpu/drm/mgag200/mgag200_ttm.c       | 10 ++--------
>>   drivers/gpu/drm/nouveau/nouveau_drv.h       |  2 --
>>   drivers/gpu/drm/nouveau/nouveau_ttm.c       |  4 ----
>>   drivers/gpu/drm/qxl/qxl_drv.h               |  3 ---
>>   drivers/gpu/drm/qxl/qxl_ttm.c               | 11 +++--------
>>   drivers/gpu/drm/radeon/radeon_ttm.c         | 13 ++-----------
>>   drivers/gpu/drm/ttm/ttm_bo.c                |  6 +++---
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c             |  3 +++
>>   drivers/gpu/drm/virtio/virtgpu_ttm.c        |  4 +---
>>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.c         |  1 -
>>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.h         |  1 -
>>   drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c    | 11 ++---------
>>   drivers/staging/vboxvideo/vbox_drv.h        |  2 --
>>   drivers/staging/vboxvideo/vbox_ttm.c        | 12 +++---------
>>   include/drm/drm_vma_manager.h               | 12 ++++++++++++
>>   include/drm/ttm/ttm_bo_driver.h             |  2 +-
>>   26 files changed, 42 insertions(+), 132 deletions(-)
>>
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--hWl33hLGCoKgv2YV1Ka4BxzdlBFSIita6--

--Ph3dCPhyLO8rNzKBNrKknkwmOzQcKOxRr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlxb/jwACgkQaA3BHVML
eiNFLwf/QGo9uOHxyfmRV+qktm3mje3M67fwMzxRlLyKBNrUYCTamu3kc1t1y7z6
SNXP090LYPIA2q6Exs7Fo4spEef1kjzD9K7o8QMLxZjzGedxl8Akwp67Iq5VB588
sb5ctBevfrATTNGzVF5GAXvgrK6Y59PDC3iozwLc+LjyVY0I3xXbNw7L0FUDxy4X
6C0CXaODz5V4D012rokwqn5SaA3eTx49X1BevRb1f38F5ezYpcz0ltDOBEB3N79L
KDSZP4oGpMMK6eLrU9Ac9gppLLM2U6Fcn6YJPjGg5b3Cf2sBUuHOPgoJMhsg2nfb
GO4X5q4cBNBCzvw78yvGWfCqg3gtIQ==
=smDB
-----END PGP SIGNATURE-----

--Ph3dCPhyLO8rNzKBNrKknkwmOzQcKOxRr--

--===============1334058901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1334058901==--
