From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Replace TTM initialization/release with
 ttm_global
Date: Fri, 19 Oct 2018 09:35:42 +0200
Message-ID: <1915b5da-531a-168c-d14f-33d02d5adc6b@suse.de>
References: <20181018162752.2241-1-tzimmermann@suse.de>
 <20181018162752.2241-3-tzimmermann@suse.de>
 <7f85a647-0955-502b-cf71-569842dd8282@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1692209591=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7f85a647-0955-502b-cf71-569842dd8282-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry(Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, ray.huang-5C7GfCeVMHo@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1692209591==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5WkSoyZlXBZC9xJEQtveBMILW1tiog27Z"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5WkSoyZlXBZC9xJEQtveBMILW1tiog27Z
Content-Type: multipart/mixed; boundary="nD1rVYmFMKxWrtr1Jhwgkz48NrDKPs4KQ";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: "Zhang, Jerry(Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org,
 ray.huang-5C7GfCeVMHo@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org,
 airlied-cv59FeDIM0c@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <1915b5da-531a-168c-d14f-33d02d5adc6b-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: Replace TTM initialization/release with
 ttm_global
References: <20181018162752.2241-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
 <20181018162752.2241-3-tzimmermann-l3A5Bk7waGM@public.gmane.org>
 <7f85a647-0955-502b-cf71-569842dd8282-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <7f85a647-0955-502b-cf71-569842dd8282-5C7GfCeVMHo@public.gmane.org>

--nD1rVYmFMKxWrtr1Jhwgkz48NrDKPs4KQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for reviewing the patch.

Am 19.10.18 um 08:18 schrieb Zhang, Jerry(Junwei):
> On 10/19/2018 12:27 AM, Thomas Zimmermann wrote:
>> =C2=A0 /**
>> =C2=A0=C2=A0 * amdgpu_ttm_global_init - Initialize global TTM memory r=
eference
>> structures.
>> =C2=A0=C2=A0 *
>> @@ -102,35 +75,15 @@ static void amdgpu_ttm_mem_global_release(struct
>> drm_global_reference *ref)
>> =C2=A0=C2=A0 */
>> =C2=A0 static int amdgpu_ttm_global_init(struct amdgpu_device *adev)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 struct drm_global_reference *global_ref;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ensure reference is false in =
case init fails */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->mman.mem_global_referenced =3D fa=
lse;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 global_ref =3D &adev->mman.mem_global_ref;
>> -=C2=A0=C2=A0=C2=A0 global_ref->global_type =3D DRM_GLOBAL_TTM_MEM;
>> -=C2=A0=C2=A0=C2=A0 global_ref->size =3D sizeof(struct ttm_mem_global)=
;
>> -=C2=A0=C2=A0=C2=A0 global_ref->init =3D &amdgpu_ttm_mem_global_init;
>> -=C2=A0=C2=A0=C2=A0 global_ref->release =3D &amdgpu_ttm_mem_global_rel=
ease;
>> -=C2=A0=C2=A0=C2=A0 r =3D drm_global_item_ref(global_ref);
>> +=C2=A0=C2=A0=C2=A0 r =3D ttm_global_init(&adev->mman.glob);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_ERROR("Failed setting =
up TTM memory accounting "
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "subsystem.\n");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error_mem;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 adev->mman.bo_global_ref.mem_glob =3D
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->mman.mem_global_ref.=
object;
>=20
> Seems to miss this action.

Should be fine. This was a workaround for setting up the global BO's
memory. It received the value that is here stored in
adev->mman.bo_global_ref.mem_glob.

Earlier this week, a patch set was merged into the TTM tree that cleans
up the init interfaces of ttm_bo_global. [1] There's now

  int ttm_bo_global_init(struct ttm_bo_global *glob,
			 struct ttm_mem_global *mem_glob)

which takes the the global memory as second argument. In patch [1/3] we
call ttm_bo_global_init() from ttm_global_init_bo() with the correct
global memory.

So this workaround is not needed any longer.

> Or are you going to replace
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_bo_global_ref bo_global_ref
> with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_global glob ->=C2=A0 struct d=
rm_global_reference bo_ref
>=20
> if so, may need to remove ttm_bo_global_ref_init() and struct
> ttm_bo_global_ref at the same time.
>=20
>=20

I have a patch set for removing ttm_bo_global_ref and its interfaces,
but it has to wait until all drivers have been converted to struct
ttm_global. struct drm_global_reference will then become an
implementation detail of struct ttm_global and can be removed from DRM's
public interfaces.

Best regards
Thomas

[1]
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.21-wip&i=
d=3D1fbb364ae523177bd0fac81d32befb3c9eb1b37e

> Regards,
> Jerry
>=20
>> -=C2=A0=C2=A0=C2=A0 global_ref =3D &adev->mman.bo_global_ref.ref;
>> -=C2=A0=C2=A0=C2=A0 global_ref->global_type =3D DRM_GLOBAL_TTM_BO;
>> -=C2=A0=C2=A0=C2=A0 global_ref->size =3D sizeof(struct ttm_bo_global);=

>> -=C2=A0=C2=A0=C2=A0 global_ref->init =3D &ttm_bo_global_ref_init;
>> -=C2=A0=C2=A0=C2=A0 global_ref->release =3D &ttm_bo_global_ref_release=
;
>> -=C2=A0=C2=A0=C2=A0 r =3D drm_global_item_ref(global_ref);
>> -=C2=A0=C2=A0=C2=A0 if (r) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_ERROR("Failed setting =
up TTM BO subsystem.\n");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error_bo;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_ERROR("Failed setting =
up TTM subsystem.\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&adev->mman.gtt_windo=
w_lock);
>> @@ -138,19 +91,13 @@ static int amdgpu_ttm_global_init(struct
>> amdgpu_device *adev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->mman.mem_global_referenced =3D tr=
ue;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> -
>> -error_bo:
>> -=C2=A0=C2=A0=C2=A0 drm_global_item_unref(&adev->mman.mem_global_ref);=

>> -error_mem:
>> -=C2=A0=C2=A0=C2=A0 return r;
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void amdgpu_ttm_global_fini(struct amdgpu_device =
*adev)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->mman.mem_global_referenced) {=

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_destroy(&=
adev->mman.gtt_window_lock);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_global_item_unref(&ade=
v->mman.bo_global_ref.ref);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_global_item_unref(&ade=
v->mman.mem_global_ref);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttm_global_release(&adev->=
mman.glob);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->mman.mem_=
global_referenced =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> @@ -1765,7 +1712,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No others user of address space so s=
et it to 0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D ttm_bo_device_init(&adev->mman.bd=
ev,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->mman.bo_global_ref.ref.obje=
ct,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttm_global_get_bo_global(&adev->m=
man.glob),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &amdgpu_bo_driver,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->ddev->anon_inode->=
i_mapping,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_FILE_PAGE_OFFSET,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index fe8f276e9811..c3a7fe3ead3a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -26,6 +26,7 @@
>> =C2=A0 =C2=A0 #include "amdgpu.h"
>> =C2=A0 #include <drm/gpu_scheduler.h>
>> +#include <drm/ttm/ttm_global.h>
>> =C2=A0 =C2=A0 #define AMDGPU_PL_GDS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (TTM_PL_PRIV + 0)
>> =C2=A0 #define AMDGPU_PL_GWS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (TTM_PL_PRIV + 1)
>> @@ -39,8 +40,7 @@
>> =C2=A0 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS=C2=A0=C2=A0=C2=A0 2
>> =C2=A0 =C2=A0 struct amdgpu_mman {
>> -=C2=A0=C2=A0=C2=A0 struct ttm_bo_global_ref=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bo_global_ref;
>> -=C2=A0=C2=A0=C2=A0 struct drm_global_reference=C2=A0=C2=A0=C2=A0 mem_=
global_ref;
>> +=C2=A0=C2=A0=C2=A0 struct ttm_global=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 glob;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_bo_device=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bdev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mem_global_referen=
ced;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initialized;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--nD1rVYmFMKxWrtr1Jhwgkz48NrDKPs4KQ--

--5WkSoyZlXBZC9xJEQtveBMILW1tiog27Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlvJiVYACgkQaA3BHVML
eiO3Zgf/VnNpg2zS4j2wbB1TMdfQQroMavZJBm0TfXAoEToD2pMkbsYwgFTj2gHO
dz//Q1wQYDC407ewaIXAGLMFPlspwMHfzOJjdlxkIE/w+k93JpwWUHymriWK8A16
VbIc+JEU6aYF5WdYunIkODaAxF0WcC8HyktVAryZBv75zSh9TSA0asRClWzXqf4o
ADjrwaq/L34qzq5GAj238CDtw7DL2UhfkYs5XwCss/uszrOrzPnzTERlrBt4DCsw
jaxo4je2ssNaEo9C+09P019UQZvUquVHrqwIG9+PGOa/KXvrLAcUBz8iOHWx+r0D
9GN0nQLctfVrAlqLV86HRWz6oVLX+g==
=njmp
-----END PGP SIGNATURE-----

--5WkSoyZlXBZC9xJEQtveBMILW1tiog27Z--

--===============1692209591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1692209591==--
