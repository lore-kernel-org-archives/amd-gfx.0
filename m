From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/3] Provide struct ttm_global for TTM global state
Date: Fri, 19 Oct 2018 09:44:28 +0200
Message-ID: <ab903eba-fbcb-817e-4884-dc14c2f1a4b8@suse.de>
References: <20181018162752.2241-1-tzimmermann@suse.de>
 <d30cd353-2f1b-4442-d482-1accaf26feee@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1101547817=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d30cd353-2f1b-4442-d482-1accaf26feee-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1101547817==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ul8BIiJiXRsBquLsSLxDGly0nmBIqpl0j"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ul8BIiJiXRsBquLsSLxDGly0nmBIqpl0j
Content-Type: multipart/mixed; boundary="Hci3U2Q5IF6MOOBEab8fUYu0YoJjpWA2y";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>,
 "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>,
 "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>,
 "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>,
 "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <ab903eba-fbcb-817e-4884-dc14c2f1a4b8-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/3] Provide struct ttm_global for TTM global state
References: <20181018162752.2241-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
 <d30cd353-2f1b-4442-d482-1accaf26feee-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <d30cd353-2f1b-4442-d482-1accaf26feee-5C7GfCeVMHo@public.gmane.org>

--Hci3U2Q5IF6MOOBEab8fUYu0YoJjpWA2y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 19.10.18 um 09:24 schrieb Koenig, Christian:
> Hi Thomas,
>=20
> I honestly still find that way to complicated compared to what it=20
> actually does.
>=20
> Both ttm_mem_global and ttm_bo_global can just be some static variables=
=2E=20
> E.g. the whole handling with drm_global_reference is just superfluous.
>=20
> Can I just write a patch to clean up the mess we created?

'Can I?' I don't know :)

Sure, it's a mess. For example, if a driver inits drm_global_reference()
and is later unloaded, there are dangling function pointers to the
driver's code.

I do a slow clean-up of the code because TTM-based drivers depend on the
current way of doing things.

Maybe let me post my full patch set for RFC and discuss this instead.

Best regards
Thomas


> Regards,
> Christian.
>=20
> Am 18.10.18 um 18:27 schrieb Thomas Zimmermann:
>> TTM provides global memory and a global BO that is shared by all
>> TTM-based drivers. The data structures are provided by struct drm_glob=
al
>> and its helpers. All TTM-based DRM drivers copy the initialization and=

>> clean-up code for the global TTM state from each other; leading to cod=
e
>> duplication.
>>
>> The new structure struct ttm_global and its helpers provide a unified
>> implementation. Drivers only have to initialize it and forward the
>> contained BO global object to ttm_bo_device_init().
>>
>> The amdgpu and radeon drivers are converted to struct ttm_global as
>> part of this patch set. All other TTM-based drivers share exactly the
>> same code patterns and can be converted in the same way.
>>
>> Future directions: I already have patches for converting the remaining=

>> TTM drivers to struct ttm_global. These patches can be merged after
>> the structure has become available in upstream. struct ttm_global is
>> implemented on top of struct drm_global. The latter actually maintains=

>> TTM state instead of DRM state. Once all drivers have been converted,
>>      the code for struct drm_global can be merged into struct ttm_glob=
al.
>>
>> (Resending this patch set, as I forgot to CC the mailing lists as firs=
t.)
>>
>> Thomas Zimmermann (3):
>>    drm/ttm: Provide struct ttm_global for referencing TTM global state=

>>    drm/amdgpu: Replace TTM initialization/release with ttm_global
>>    drm/radeon: Replace TTM initialization/release with ttm_global
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 63 ++--------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  4 +-
>>   drivers/gpu/drm/radeon/radeon.h         |  4 +-
>>   drivers/gpu/drm/radeon/radeon_ttm.c     | 40 ++--------
>>   drivers/gpu/drm/ttm/Makefile            |  2 +-
>>   drivers/gpu/drm/ttm/ttm_global.c        | 98 +++++++++++++++++++++++=
++
>>   include/drm/drm_global.h                |  8 ++
>>   include/drm/ttm/ttm_global.h            | 79 ++++++++++++++++++++
>>   8 files changed, 200 insertions(+), 98 deletions(-)
>>   create mode 100644 drivers/gpu/drm/ttm/ttm_global.c
>>   create mode 100644 include/drm/ttm/ttm_global.h
>>
>> --
>> 2.19.1
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--Hci3U2Q5IF6MOOBEab8fUYu0YoJjpWA2y--

--ul8BIiJiXRsBquLsSLxDGly0nmBIqpl0j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlvJi1wACgkQaA3BHVML
eiOPjgf/atW3Vz0ZChpIkW1k8rryRyxFW1za+Q59+e/0yaKN5i3lQAGtbYELjfJU
dGNtD5hSPdEngPsJIUGHCWzNc2vry5b6nTgxMC+E3vuAxybdNJx0nh5OG7YkCyEo
H9d71eCIlO2Aef4MgfNzJp/lRywefkQ85pgH7URIMBPKHl/o2Wdw7BRUir39IAK/
GsBZYnnesQ2iGtPXdxvznAfJ8qfo1xDVVV2r1hW1qVsCx1zJ27xCrRLAeOwsbSi2
44Ia8WDWibFbRJIVz8mQioIMimTEYGLZMsOQy4TOM/ufhBld8WbY0sCWm2xGs130
Z9U9GB+Lq8+vPCercdDmMuyH4Ol9cA==
=x0AZ
-----END PGP SIGNATURE-----

--ul8BIiJiXRsBquLsSLxDGly0nmBIqpl0j--

--===============1101547817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1101547817==--
