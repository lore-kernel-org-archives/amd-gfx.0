From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/2] Provide init/release functions for struct
 ttm_bo_global
Date: Thu, 30 Aug 2018 08:34:57 +0200
Message-ID: <5e815e50-d0be-5069-cf1d-aa881a18f094@suse.de>
References: <20180813102443.12662-1-tzimmermann@suse.de>
 <b77c649e-4c5d-a19d-8c46-d91c69859293@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0177679977=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b77c649e-4c5d-a19d-8c46-d91c69859293-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, ray.huang-5C7GfCeVMHo@public.gmane.org, Jerry.Zhang-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David1.Zhou-5C7GfCeVMHo@public.gmane.org, thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, syeh-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0177679977==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="94YPPfpkXJ5UewInxJbC6xO7okH09vx6w"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--94YPPfpkXJ5UewInxJbC6xO7okH09vx6w
Content-Type: multipart/mixed; boundary="JQzy3oOasLP7x0qaayQXM6bVeUJB9HA9Z";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>,
 ray.huang-5C7GfCeVMHo@public.gmane.org, Jerry.Zhang-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org,
 kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org,
 linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, syeh-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org,
 thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org,
 nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <5e815e50-d0be-5069-cf1d-aa881a18f094-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/2] Provide init/release functions for struct
 ttm_bo_global
References: <20180813102443.12662-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
 <b77c649e-4c5d-a19d-8c46-d91c69859293-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <b77c649e-4c5d-a19d-8c46-d91c69859293-5C7GfCeVMHo@public.gmane.org>

--JQzy3oOasLP7x0qaayQXM6bVeUJB9HA9Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Christian,

I just wanted to ask if there's something else required to get this
patch set reviewed and landed.

On top of these two patches, I have a patch set that replaces the
driver-specific global-bo-and-mem combos with a single struct ttm_global
structure. It further merges struct drm_global into struct ttm_global
and implements it such that drivers can either share the global memory
or create their private instance. It's also a step towards drm device
hotplug, which someone just asked.

Best regards
Thomas


Am 13.08.2018 um 12:33 schrieb Christian K=C3=B6nig:
> Yes, please! I had it on my TODO list to clean that up for an eternity.=

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


--JQzy3oOasLP7x0qaayQXM6bVeUJB9HA9Z--

--94YPPfpkXJ5UewInxJbC6xO7okH09vx6w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAluHkBEACgkQaA3BHVML
eiOOugf/ahb9OWLyvgBBVPACsOzdOaifWA0vbyT7JEJDcTITOx6Ya4lZvX0CaNPE
apQUyU+hYkAbb4L2vqjeWsJNrhTzVd7uBco4iEdqVA2Q4KBADeqLhdK+t3h+9dN0
1vBSfxpkoF6IVMcsImuYZlsYiYKEW90eSZwCoWQg4xbpu1pDR1/ZEChs4oj8q9vu
jBgq64FAxcV9RNodS809GKbTzZj8DDPuRkXdpflVTom9ErSIfhV8fBVCt5a0yRTP
p0zASsBQ7DObKwPX0I43GqK9p9ZdLo409faBX26jPRf5oRp8je/Sgh2fqDF7nD5Y
ejAH6dKiqq48952rNshoeFDF03CrMQ==
=BQPl
-----END PGP SIGNATURE-----

--94YPPfpkXJ5UewInxJbC6xO7okH09vx6w--

--===============0177679977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0177679977==--
