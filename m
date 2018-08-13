From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/2] Provide init/release functions for struct
 ttm_bo_global
Date: Mon, 13 Aug 2018 14:28:24 +0200
Message-ID: <87d57d1e-4ce3-cde7-5e05-798b6738ae6c@suse.de>
References: <20180813102443.12662-1-tzimmermann@suse.de>
 <b77c649e-4c5d-a19d-8c46-d91c69859293@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1510107852=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <b77c649e-4c5d-a19d-8c46-d91c69859293@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, ray.huang@amd.com, Jerry.Zhang@amd.com, dri-devel@lists.freedesktop.org
Cc: thellstrom@vmware.com, nouveau@lists.freedesktop.org, airlied@linux.ie, puck.chen@hisilicon.com, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, linux-graphics-maintainer@vmware.com, kraxel@redhat.com, gregkh@linuxfoundation.org, alexander.deucher@amd.com, bskeggs@redhat.com
List-Id: amd-gfx.lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1510107852==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ATglUGlGBTgwKmQaKSsH5G5OHbDDnDA2h"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ATglUGlGBTgwKmQaKSsH5G5OHbDDnDA2h
Content-Type: multipart/mixed; boundary="4JVgFr7ultsuCY2ZYmzOVoi8xy4bvsqiH";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 ray.huang@amd.com, Jerry.Zhang@amd.com, dri-devel@lists.freedesktop.org
Cc: alexander.deucher@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
 kraxel@redhat.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com,
 kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, bskeggs@redhat.com,
 linux-graphics-maintainer@vmware.com, syeh@vmware.com,
 thellstrom@vmware.com, gregkh@linuxfoundation.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 nouveau@lists.freedesktop.org
Message-ID: <87d57d1e-4ce3-cde7-5e05-798b6738ae6c@suse.de>
Subject: Re: [PATCH 0/2] Provide init/release functions for struct
 ttm_bo_global
References: <20180813102443.12662-1-tzimmermann@suse.de>
 <b77c649e-4c5d-a19d-8c46-d91c69859293@amd.com>
In-Reply-To: <b77c649e-4c5d-a19d-8c46-d91c69859293@amd.com>

--4JVgFr7ultsuCY2ZYmzOVoi8xy4bvsqiH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 13.08.2018 um 12:33 schrieb Christian K=C3=B6nig:
> Yes, please! I had it on my TODO list to clean that up for an eternity.=


On top of these patches, I have a patch set that provides a single
init/release interface for TTM global data. I'll post it when the
current patches got some feed back.

I'd really like to move the code from drm_global.c back into TTM. It's
TTM-specific and not useful elsewhere. However, the first commit message
from 2010 [1] says that some unnamed, external driver uses this code for
something. Do you know if this still applies?

Best regards
Thomas

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dba4420c224c2808f2661cf8428f43ceef7a73a4a

>=20
> Actually I never understood why that should be driver work to setup TTM=
?
>=20
> I mean can't we just have a module_init/module_exit for TTM?
>=20
> Thanks,
> Christian.
>=20
> Am 13.08.2018 um 12:24 schrieb Thomas Zimmermann:
>> TTM uses global memory and BO for backing graphics buffers. These are
>> represented by struct ttm_mem_global and struct ttm_bo_global.
>>
>> Currently, struct ttm_bo_global can only be initialized and released
>> through
>> struct ttm_bo_global_ref. This is a workaround for passing an instance=
 of
>> ttm_mem_global to the BO global initialization code.
>>
>> The use of struct ttm_bo_global_ref makes driver code unnecessary hard=
 to
>> understand. At the same time drivers can use any combination of memory=

>> and
>> BO for initializing the global instances. This can result in subtle bu=
gs
>> when the order of initializing and releasing drivers changes.
>>
>> As a first step for resolving these problems, the provided patch set
>> separates initialization and release of struct ttm_bo_global from
>> struct ttm_bo_global_ref.
>>
>> The first patch only renames ttm_bo_global_{init/release}. Hopefully t=
his
>> change can be applied at once for all drivers.
>>
>> Future directions: All TTM-based drivers follow the same pattern for
>> setting
>> up the TTM. In a follow-up patch, this code can be moved into a single=

>> place
>> and shared among drivers.
>>
>> Thomas Zimmermann (2):
>> =C2=A0=C2=A0 drm/ttm: Rename ttm_bo_global_{init,release}() to
>> =C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo_global_ref_*()
>> =C2=A0=C2=A0 drm/ttm: Provide ttm_bo_global_{init/release}() for struc=
t
>> =C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo_global
>>
>> =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/ast/ast_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/bochs/bochs_mm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/cirrus/cirrus_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/mgag200/mgag200_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/nouveau/nouveau_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/qxl/qxl_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/radeon/radeon_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/ttm/ttm_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++---
>> =C2=A0 drivers/gpu/drm/virtio/virtgpu_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 +-
>> =C2=A0 drivers/staging/vboxvideo/vbox_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0 include/drm/ttm/ttm_bo_driver.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 53 ++++++++++++++++-----
>> =C2=A0 14 files changed, 70 insertions(+), 43 deletions(-)
>>
>> --=20
>> 2.18.0
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--4JVgFr7ultsuCY2ZYmzOVoi8xy4bvsqiH--

--ATglUGlGBTgwKmQaKSsH5G5OHbDDnDA2h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAltxeWgACgkQaA3BHVML
eiNXJQf/ffGzu1VRVvsj02ybvGfwcIvnlHohPJFXONDs3wmhL0KhQNl90zNYZ8yP
Tz2WjqKPDSpv+ihB/RFvO4DQ8AWjFycUhI+5LLffk+g9X6UyM29q32Vv4pK0ZkJB
R5qqgJ1BTk7nXH8MSReeV7AwBer8vodjsgonZHWNDZP+mLDyiE9pMG+8+A+XhYXN
77lKccImMuI3ATzNACZK1Hnarh1SHHvBZb0EjJRnhibSnNyWhGa+10iSkl9KVwN7
mPvRqiIyV27ABbtyUYRkONqm0X8oQImc/9OO+3rxR2fWKGtvzZ6YtdhbwgUNeb1m
Bw7+Jx7mrklUe0qhvpohkgrvtnBA2A==
=6ncs
-----END PGP SIGNATURE-----

--ATglUGlGBTgwKmQaKSsH5G5OHbDDnDA2h--

--===============1510107852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1510107852==--
