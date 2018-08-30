From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/2] Provide init/release functions for struct
 ttm_bo_global
Date: Thu, 30 Aug 2018 12:35:45 +0200
Message-ID: <ed56db4b-d0a0-ef32-2efb-e841a8ec7dfd@suse.de>
References: <20180813102443.12662-1-tzimmermann@suse.de>
 <b77c649e-4c5d-a19d-8c46-d91c69859293@amd.com>
 <5e815e50-d0be-5069-cf1d-aa881a18f094@suse.de>
 <73eea61d-e913-4f62-69b5-c4f482724236@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0127865312=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <73eea61d-e913-4f62-69b5-c4f482724236@amd.com>
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
Cc: thellstrom@vmware.com, gregkh@linuxfoundation.org, airlied@linux.ie, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com, alexander.deucher@amd.com, kong.kongxinwei@hisilicon.com, linux-graphics-maintainer@vmware.com, kraxel@redhat.com, puck.chen@hisilicon.com, zourongrong@gmail.com, bskeggs@redhat.com
List-Id: amd-gfx.lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0127865312==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="54zgTMGVVCsZUJx45gckUAG6QB3wtBXKT"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--54zgTMGVVCsZUJx45gckUAG6QB3wtBXKT
Content-Type: multipart/mixed; boundary="7CfbXlJLDfOo5PSMW3lwexHa2okybB6Ck";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 ray.huang@amd.com, Jerry.Zhang@amd.com, dri-devel@lists.freedesktop.org
Cc: thellstrom@vmware.com, nouveau@lists.freedesktop.org, airlied@linux.ie,
 puck.chen@hisilicon.com, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, kong.kongxinwei@hisilicon.com,
 linux-graphics-maintainer@vmware.com, kraxel@redhat.com,
 gregkh@linuxfoundation.org, alexander.deucher@amd.com, bskeggs@redhat.com
Message-ID: <ed56db4b-d0a0-ef32-2efb-e841a8ec7dfd@suse.de>
Subject: Re: [PATCH 0/2] Provide init/release functions for struct
 ttm_bo_global
References: <20180813102443.12662-1-tzimmermann@suse.de>
 <b77c649e-4c5d-a19d-8c46-d91c69859293@amd.com>
 <5e815e50-d0be-5069-cf1d-aa881a18f094@suse.de>
 <73eea61d-e913-4f62-69b5-c4f482724236@amd.com>
In-Reply-To: <73eea61d-e913-4f62-69b5-c4f482724236@amd.com>

--7CfbXlJLDfOo5PSMW3lwexHa2okybB6Ck
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 30.08.2018 um 08:45 schrieb Christian K=C3=B6nig:
[...]
>> or create their private instance.
>=20
> That doesn't sounds good. Drivers should not be allowed to create their=

> own private instance of that.

OK, will be changed in the patchset.

Best regards
Thomas

>=20
> Thanks for doing this,
> Christian.
>=20
>> =C2=A0 It's also a step towards drm device
>> hotplug, which someone just asked.
>>
>> Best regards
>> Thomas
>>
>>
>> Am 13.08.2018 um 12:33 schrieb Christian K=C3=B6nig:
>>> Yes, please! I had it on my TODO list to clean that up for an eternit=
y.
>>>
>>> Actually I never understood why that should be driver work to setup T=
TM?
>>>
>>> I mean can't we just have a module_init/module_exit for TTM?
>>>
>>> Thanks,
>>> Christian.
>>>
>>> Am 13.08.2018 um 12:24 schrieb Thomas Zimmermann:
>>>> TTM uses global memory and BO for backing graphics buffers. These ar=
e
>>>> represented by struct ttm_mem_global and struct ttm_bo_global.
>>>>
>>>> Currently, struct ttm_bo_global can only be initialized and released=

>>>> through
>>>> struct ttm_bo_global_ref. This is a workaround for passing an
>>>> instance of
>>>> ttm_mem_global to the BO global initialization code.
>>>>
>>>> The use of struct ttm_bo_global_ref makes driver code unnecessary
>>>> hard to
>>>> understand. At the same time drivers can use any combination of memo=
ry
>>>> and
>>>> BO for initializing the global instances. This can result in subtle
>>>> bugs
>>>> when the order of initializing and releasing drivers changes.
>>>>
>>>> As a first step for resolving these problems, the provided patch set=

>>>> separates initialization and release of struct ttm_bo_global from
>>>> struct ttm_bo_global_ref.
>>>>
>>>> The first patch only renames ttm_bo_global_{init/release}. Hopefully=

>>>> this
>>>> change can be applied at once for all drivers.
>>>>
>>>> Future directions: All TTM-based drivers follow the same pattern for=

>>>> setting
>>>> up the TTM. In a follow-up patch, this code can be moved into a sing=
le
>>>> place
>>>> and shared among drivers.
>>>>
>>>> Thomas Zimmermann (2):
>>>> =C2=A0=C2=A0=C2=A0 drm/ttm: Rename ttm_bo_global_{init,release}() to=

>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo_global_ref_*()
>>>> =C2=A0=C2=A0=C2=A0 drm/ttm: Provide ttm_bo_global_{init/release}() f=
or struct
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo_global
>>>>
>>>> =C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/ast/ast_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/bochs/bochs_mm.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/cirrus/cirrus_ttm.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c |=C2=A0 4 +=
-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/mgag200/mgag200_ttm.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/nouveau/nouveau_ttm.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/qxl/qxl_ttm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/radeon/radeon_ttm.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/ttm/ttm_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++--=
-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/virtio/virtgpu_ttm.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 drivers/staging/vboxvideo/vbox_ttm.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>>>> =C2=A0=C2=A0 include/drm/ttm/ttm_bo_driver.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 53
>>>> ++++++++++++++++-----
>>>> =C2=A0=C2=A0 14 files changed, 70 insertions(+), 43 deletions(-)
>>>>
>>>> --=C2=A0
>>>> 2.18.0
>>>>
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--7CfbXlJLDfOo5PSMW3lwexHa2okybB6Ck--

--54zgTMGVVCsZUJx45gckUAG6QB3wtBXKT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAluHyIEACgkQaA3BHVML
eiPcfwf+OF6M2ELHqbW3HCPM/dx+tA3QB8V4DRq4C8JQyj45+uDGTFFWVJCW9PC4
5k0yps5xmBNr53/56tv3gaefBALWvv5+zbOsdFc5sj2i7RjOGarNfYAK6nd/Aa80
lZs8isv1uKGMSHjAlYoRU5QyK+BRiE3qnEedvzleOjZEQbzuEpXbwmRI+LWcQDt9
lS0Yd+fcPCATls2Wq6g+7RsI/yMslw4tGqx49lSl8eGtnBuAqLXWRpaTZXxHcNeP
Z76WIqh+Nqq3X3ZVoJ/Zi/NYlVW8ww86agdfx/IVAY+ccmF2Ruin3TbR/BTCOSSz
i+QtF6ax2//aOIamkpNRfTzTg/ILxg==
=hajC
-----END PGP SIGNATURE-----

--54zgTMGVVCsZUJx45gckUAG6QB3wtBXKT--

--===============0127865312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0127865312==--
