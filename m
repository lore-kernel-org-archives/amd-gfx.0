From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 01/18] drm/ttm: Provide struct ttm_global for referencing
 TTM global state
Date: Fri, 19 Oct 2018 11:41:59 +0200
Message-ID: <616760d1-6598-9769-f058-54777e55b392@suse.de>
References: <20181019085423.28159-1-tzimmermann@suse.de>
 <20181019085423.28159-2-tzimmermann@suse.de>
 <39122bc3-869b-8e7f-f5bc-98c2a79184fb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1875591765=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <39122bc3-869b-8e7f-f5bc-98c2a79184fb@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: christian.koenig@amd.com, ray.huang@amd.com, Jerry.Zhang@amd.com, alexander.deucher@amd.com, David1.Zhou@amd.com, airlied@linux.ie, kraxel@redhat.com, bskeggs@redhat.com, syeh@vmware.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1875591765==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MRbCgk6URw3cC2VorkTKzCbxHyAOuQSrZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MRbCgk6URw3cC2VorkTKzCbxHyAOuQSrZ
Content-Type: multipart/mixed; boundary="7c5lSohiTcUfDSCHubziOdUyWoXrq78ap";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: christian.koenig@amd.com, ray.huang@amd.com, Jerry.Zhang@amd.com,
 alexander.deucher@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
 kraxel@redhat.com, bskeggs@redhat.com, syeh@vmware.com,
 z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Message-ID: <616760d1-6598-9769-f058-54777e55b392@suse.de>
Subject: Re: [PATCH 01/18] drm/ttm: Provide struct ttm_global for referencing
 TTM global state
References: <20181019085423.28159-1-tzimmermann@suse.de>
 <20181019085423.28159-2-tzimmermann@suse.de>
 <39122bc3-869b-8e7f-f5bc-98c2a79184fb@gmail.com>
In-Reply-To: <39122bc3-869b-8e7f-f5bc-98c2a79184fb@gmail.com>

--7c5lSohiTcUfDSCHubziOdUyWoXrq78ap
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 19.10.18 um 11:30 schrieb Christian K=C3=B6nig:
> In general I'm really graceful that you look into this, but you are jus=
t
> moving the complexity around instead of cleaning it up.
>=20
> This whole global reference stuff is just going into the wrong directio=
n.
>=20
> Please let me clean that up instead,

Well, Ok.

One thing I noticed is that none of the drivers does anything with the
global TTM state. One thing that could be done is to remove the state
from the drivers and handle it entirely in ttm_bo_device.

Best regards
Thomas

> Christian.
>=20
> Am 19.10.18 um 10:54 schrieb Thomas Zimmermann:
>> The new struct ttm_global provides drivers with TTM's global memory an=
d
>> BO in a unified way. Initialization and release is handled internally.=

>>
>> The functionality provided by struct ttm_global is currently
>> re-implemented
>> by a dozen individual DRM drivers using struct drm_global. The
>> implementation
>> of struct ttm_global is also built on top of drm_global, so it can
>> co-exists
>> with the existing drivers. Once all TTM-based drivers have been
>> converted to
>> struct ttm_global, the implementation of struct drm_global can be made=

>> private to TTM.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>> =C2=A0 drivers/gpu/drm/ttm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
>> =C2=A0 drivers/gpu/drm/ttm/ttm_global.c | 98 +++++++++++++++++++++++++=
+++++++
>> =C2=A0 include/drm/drm_global.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 8 +++
>> =C2=A0 include/drm/ttm/ttm_global.h=C2=A0=C2=A0=C2=A0=C2=A0 | 79 +++++=
++++++++++++++++++++
>> =C2=A0 4 files changed, 186 insertions(+), 1 deletion(-)
>> =C2=A0 create mode 100644 drivers/gpu/drm/ttm/ttm_global.c
>> =C2=A0 create mode 100644 include/drm/ttm/ttm_global.h
>>
>> diff --git a/drivers/gpu/drm/ttm/Makefile b/drivers/gpu/drm/ttm/Makefi=
le
>> index 01fc670ce7a2..b7272b26e9f3 100644
>> --- a/drivers/gpu/drm/ttm/Makefile
>> +++ b/drivers/gpu/drm/ttm/Makefile
>> @@ -5,7 +5,7 @@
>> =C2=A0 ttm-y :=3D ttm_memory.o ttm_tt.o ttm_bo.o \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo_util.o ttm_bo_vm.o ttm_module.o =
\
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttm_execbuf_util.o ttm_page_alloc.o ttm=
_bo_manager.o \
>> -=C2=A0=C2=A0=C2=A0 ttm_page_alloc_dma.o
>> +=C2=A0=C2=A0=C2=A0 ttm_page_alloc_dma.o ttm_global.o
>> =C2=A0 ttm-$(CONFIG_AGP) +=3D ttm_agp_backend.o
>> =C2=A0 =C2=A0 obj-$(CONFIG_DRM_TTM) +=3D ttm.o
>> diff --git a/drivers/gpu/drm/ttm/ttm_global.c
>> b/drivers/gpu/drm/ttm/ttm_global.c
>> new file mode 100644
>> index 000000000000..ca9da0a46147
>> --- /dev/null
>> +++ b/drivers/gpu/drm/ttm/ttm_global.c
>> @@ -0,0 +1,98 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>> +/********************************************************************=
******
>>
>> + *
>> + * Copyright 2008-2009 VMware, Inc., Palo Alto, CA., USA
>> + * All Rights Reserved.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> obtaining a
>> + * copy of this software and associated documentation files (the
>> + * "Software"), to deal in the Software without restriction, includin=
g
>> + * without limitation the rights to use, copy, modify, merge, publish=
,
>> + * distribute, sub license, and/or sell copies of the Software, and t=
o
>> + * permit persons to whom the Software is furnished to do so, subject=
 to
>> + * the following conditions:
>> + *
>> + * The above copyright notice and this permission notice (including t=
he
>> + * next paragraph) shall be included in all copies or substantial
>> portions
>> + * of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT=

>> SHALL
>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR
>> ANY CLAIM,
>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT=
 OR
>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE=

>> OR THE
>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> +
>> **********************************************************************=
****/
>>
>> +
>> +#include <drm/ttm/ttm_global.h>
>> +#include <drm/ttm/ttm_bo_driver.h>
>> +#include <drm/ttm/ttm_memory.h>
>> +#include <linux/kernel.h>
>> +
>> +static int ttm_global_init_mem(struct drm_global_reference *ref)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BUG_ON(!ref->object);
>> +=C2=A0=C2=A0=C2=A0 return ttm_mem_global_init(ref->object);
>> +}
>> +
>> +static void ttm_global_release_mem(struct drm_global_reference *ref)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BUG_ON(!ref->object);
>> +=C2=A0=C2=A0=C2=A0 ttm_mem_global_release(ref->object);
>> +}
>> +
>> +static int ttm_global_init_bo(struct drm_global_reference *ref)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ttm_global *glob =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 container_of(ref, struct t=
tm_global, bo_ref);
>> +=C2=A0=C2=A0=C2=A0 BUG_ON(!ref->object);
>> +=C2=A0=C2=A0=C2=A0 BUG_ON(!glob->mem_ref.object);
>> +=C2=A0=C2=A0=C2=A0 return ttm_bo_global_init(ref->object, glob->mem_r=
ef.object);
>> +}
>> +
>> +static void ttm_global_release_bo(struct drm_global_reference *ref)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BUG_ON(!ref->object);
>> +=C2=A0=C2=A0=C2=A0 ttm_bo_global_release(ref->object);
>> +}
>> +
>> +int ttm_global_init(struct ttm_global *glob)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 glob->mem_ref.global_type =3D DRM_GLOBAL_TTM_MEM;
>> +=C2=A0=C2=A0=C2=A0 glob->mem_ref.size =3D sizeof(struct ttm_mem_globa=
l);
>> +=C2=A0=C2=A0=C2=A0 glob->bo_ref.object =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 glob->mem_ref.init =3D &ttm_global_init_mem;
>> +=C2=A0=C2=A0=C2=A0 glob->mem_ref.release =3D &ttm_global_release_mem;=

>> +=C2=A0=C2=A0=C2=A0 ret =3D drm_global_item_ref(&glob->mem_ref);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 glob->bo_ref.global_type =3D DRM_GLOBAL_TTM_BO;
>> +=C2=A0=C2=A0=C2=A0 glob->bo_ref.size =3D sizeof(struct ttm_bo_global)=
;
>> +=C2=A0=C2=A0=C2=A0 glob->bo_ref.object =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 glob->bo_ref.init =3D &ttm_global_init_bo;
>> +=C2=A0=C2=A0=C2=A0 glob->bo_ref.release =3D &ttm_global_release_bo;
>> +=C2=A0=C2=A0=C2=A0 ret =3D drm_global_item_ref(&glob->bo_ref);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_drm_global_item_u=
nref_mem;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +err_drm_global_item_unref_mem:
>> +=C2=A0=C2=A0=C2=A0 drm_global_item_unref(&glob->mem_ref);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +EXPORT_SYMBOL(ttm_global_init);
>> +
>> +void ttm_global_release(struct ttm_global *glob)
>> +{
>> +=C2=A0=C2=A0=C2=A0 drm_global_item_unref(&glob->bo_ref);
>> +=C2=A0=C2=A0=C2=A0 drm_global_item_unref(&glob->mem_ref);
>> +}
>> +
>> +EXPORT_SYMBOL(ttm_global_release);
>> diff --git a/include/drm/drm_global.h b/include/drm/drm_global.h
>> index 3a830602a2e4..4482a9bbd6e9 100644
>> --- a/include/drm/drm_global.h
>> +++ b/include/drm/drm_global.h
>> @@ -28,8 +28,16 @@
>> =C2=A0=C2=A0 * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com=
>
>> =C2=A0=C2=A0 */
>> =C2=A0 +/*
>> + *=C2=A0 The interfaces in this file are deprecated. Please use ttm_g=
lobal
>> + *=C2=A0 from <drm/ttm/ttm_global.h> instead.
>> + */
>> +
>> =C2=A0 #ifndef _DRM_GLOBAL_H_
>> =C2=A0 #define _DRM_GLOBAL_H_
>> +
>> +#include <linux/types.h>
>> +
>> =C2=A0 enum drm_global_types {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_GLOBAL_TTM_MEM =3D 0,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_GLOBAL_TTM_BO,
>> diff --git a/include/drm/ttm/ttm_global.h b/include/drm/ttm/ttm_global=
=2Eh
>> new file mode 100644
>> index 000000000000..06e791499f87
>> --- /dev/null
>> +++ b/include/drm/ttm/ttm_global.h
>> @@ -0,0 +1,79 @@
>> +/********************************************************************=
******
>>
>> + *
>> + * Copyright 2008-2009 VMware, Inc., Palo Alto, CA., USA
>> + * All Rights Reserved.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> obtaining a
>> + * copy of this software and associated documentation files (the
>> + * "Software"), to deal in the Software without restriction, includin=
g
>> + * without limitation the rights to use, copy, modify, merge, publish=
,
>> + * distribute, sub license, and/or sell copies of the Software, and t=
o
>> + * permit persons to whom the Software is furnished to do so, subject=
 to
>> + * the following conditions:
>> + *
>> + * The above copyright notice and this permission notice (including t=
he
>> + * next paragraph) shall be included in all copies or substantial
>> portions
>> + * of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT=

>> SHALL
>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR
>> ANY CLAIM,
>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT=
 OR
>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE=

>> OR THE
>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> +
>> **********************************************************************=
****/
>>
>> +
>> +#ifndef _TTM_GLOBAL_H_
>> +#define _TTM_GLOBAL_H_
>> +
>> +#include <drm/drm_global.h>
>> +
>> +struct ttm_bo_global;
>> +
>> +/**
>> + * struct ttm_global - Stores references to global TTM state
>> + */
>> +struct ttm_global {
>> +=C2=A0=C2=A0=C2=A0 struct drm_global_reference mem_ref;
>> +=C2=A0=C2=A0=C2=A0 struct drm_global_reference bo_ref;
>> +};
>> +
>> +/**
>> + * ttm_global_init
>> + *
>> + * @glob: A pointer to a struct ttm_global that is about to be
>> initialized
>> + * @return Zero on success, or a negative error code otherwise.
>> + *
>> + * Initializes an instance of struct ttm_global with TTM's global sta=
te
>> + */
>> +int ttm_global_init(struct ttm_global *glob);
>> +
>> +/**
>> + * ttm_global_release
>> + *
>> + * @glob: A pointer to an instance of struct ttm_global
>> + *
>> + * Releases an initialized instance of struct ttm_global. If the
>> instance
>> + * constains the final references to the global memory and BO, the
>> global
>> + * structures are released as well.
>> + */
>> +void ttm_global_release(struct ttm_global *glob);
>> +
>> +/**
>> + * ttm_global_get_bo_global
>> + *
>> + * @glob A pointer to an instance of struct ttm_global
>> + * @return A refernce to the global BO.
>> + *
>> + * Returns the global BO. The BO should be forwarded to the
>> initialization
>> + * of a driver's TTM BO device.
>> + */
>> +static inline struct ttm_bo_global*
>> +ttm_global_get_bo_global(struct ttm_global *glob)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return glob->bo_ref.object;
>> +}
>> +
>> +#endif /* _TTM_GLOBAL_H_ */
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--7c5lSohiTcUfDSCHubziOdUyWoXrq78ap--

--MRbCgk6URw3cC2VorkTKzCbxHyAOuQSrZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlvJpucACgkQaA3BHVML
eiODMQf+Ltd1CQb0b2wNaO9i0te2qfuKNtvWXO6JR0j9sdsZUCBVN3W+2HeQ8VnJ
GQAcBZCZFiJS8dtmjlCvOm2evp+4egX/2B3FqwLdFtNAJ78KAYgBA6n6fV6tm2pc
n8rFUzkekT/AF+NjbY+5jAHUwrhtW8+iVn9j3lIkBaKGM6nzJwSoON2hByvf0IDJ
bKn8QXuLP5aOyvu8YCCXgRC4nPVZ31IlV6zODdHgI+vMXY12ITe2guC1wTAJuBS2
SZL7UZneDORSNMHrxWkH9eO/ivAx5rZs4IsjOVI6uLG0hKp50mWfJpW8c6aXpU5C
rHF4Hrj6XkjyTopGq00QIqd0Qf4g3g==
=96tx
-----END PGP SIGNATURE-----

--MRbCgk6URw3cC2VorkTKzCbxHyAOuQSrZ--

--===============1875591765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1875591765==--
