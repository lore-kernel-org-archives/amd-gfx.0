From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/ttm: Provide struct ttm_global for referencing
 TTM global state
Date: Fri, 19 Oct 2018 09:38:15 +0200
Message-ID: <be33a33a-ffcc-3c38-4d26-4e0e7100fc0c@suse.de>
References: <20181018162752.2241-1-tzimmermann@suse.de>
 <20181018162752.2241-2-tzimmermann@suse.de> <20181019033025.GA8072@hr-amur2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0892490067=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181019033025.GA8072@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0892490067==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oehW6VUXucu8TnXCUhMW7vJy2dvKthsWW"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oehW6VUXucu8TnXCUhMW7vJy2dvKthsWW
Content-Type: multipart/mixed; boundary="7nAQOHoFsyQHBdqt0SamcasooVq9s41DO";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>,
 "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>,
 "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Message-ID: <be33a33a-ffcc-3c38-4d26-4e0e7100fc0c-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/ttm: Provide struct ttm_global for referencing
 TTM global state
References: <20181018162752.2241-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
 <20181018162752.2241-2-tzimmermann-l3A5Bk7waGM@public.gmane.org> <20181019033025.GA8072@hr-amur2>
In-Reply-To: <20181019033025.GA8072@hr-amur2>

--7nAQOHoFsyQHBdqt0SamcasooVq9s41DO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for the review.

Am 19.10.18 um 05:30 schrieb Huang Rui:
> On Fri, Oct 19, 2018 at 12:27:50AM +0800, Thomas Zimmermann wrote:
>> +int ttm_global_init(struct ttm_global *glob)
>> +{
>> +	int ret;
>> +
>=20
> We would better add a protection here to make sure the glob is not NULL=
=2E
>=20
> if (!glob)
>         return -EINVAL;

Passing a NULL pointer is a programming error, not a runtime error. I'd
rather use BUG_ON() for this test. Ok?

Best regards
Thomas

>=20
> Others, look good for me.
>=20
> Thanks,
> Ray
>=20
>> +	glob->mem_ref.global_type =3D DRM_GLOBAL_TTM_MEM;
>> +	glob->mem_ref.size =3D sizeof(struct ttm_mem_global);
>> +	glob->bo_ref.object =3D NULL;
>> +	glob->mem_ref.init =3D &ttm_global_init_mem;
>> +	glob->mem_ref.release =3D &ttm_global_release_mem;
>> +	ret =3D drm_global_item_ref(&glob->mem_ref);
>> +	if (ret)
>> +		return ret;
>> +
>> +	glob->bo_ref.global_type =3D DRM_GLOBAL_TTM_BO;
>> +	glob->bo_ref.size =3D sizeof(struct ttm_bo_global);
>> +	glob->bo_ref.object =3D NULL;
>> +	glob->bo_ref.init =3D &ttm_global_init_bo;
>> +	glob->bo_ref.release =3D &ttm_global_release_bo;
>> +	ret =3D drm_global_item_ref(&glob->bo_ref);
>> +	if (ret)
>> +		goto err_drm_global_item_unref_mem;
>> +
>> +	return 0;
>> +
>> +err_drm_global_item_unref_mem:
>> +	drm_global_item_unref(&glob->mem_ref);
>> +	return ret;
>> +}
>> +
>> +EXPORT_SYMBOL(ttm_global_init);
>> +
>> +void ttm_global_release(struct ttm_global *glob)
>> +{
>> +	drm_global_item_unref(&glob->bo_ref);
>> +	drm_global_item_unref(&glob->mem_ref);
>> +}
>> +
>> +EXPORT_SYMBOL(ttm_global_release);
>> diff --git a/include/drm/drm_global.h b/include/drm/drm_global.h
>> index 3a830602a2e4..4482a9bbd6e9 100644
>> --- a/include/drm/drm_global.h
>> +++ b/include/drm/drm_global.h
>> @@ -28,8 +28,16 @@
>>   * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
>>   */
>> =20
>> +/*
>> + *  The interfaces in this file are deprecated. Please use ttm_global=

>> + *  from <drm/ttm/ttm_global.h> instead.
>> + */
>> +
>>  #ifndef _DRM_GLOBAL_H_
>>  #define _DRM_GLOBAL_H_
>> +
>> +#include <linux/types.h>
>> +
>>  enum drm_global_types {
>>  	DRM_GLOBAL_TTM_MEM =3D 0,
>>  	DRM_GLOBAL_TTM_BO,
>> diff --git a/include/drm/ttm/ttm_global.h b/include/drm/ttm/ttm_global=
=2Eh
>> new file mode 100644
>> index 000000000000..06e791499f87
>> --- /dev/null
>> +++ b/include/drm/ttm/ttm_global.h
>> @@ -0,0 +1,79 @@
>> +/********************************************************************=
******
>> + *
>> + * Copyright 2008-2009 VMware, Inc., Palo Alto, CA., USA
>> + * All Rights Reserved.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtain=
ing a
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
>> + * next paragraph) shall be included in all copies or substantial por=
tions
>> + * of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT=
 SHALL
>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR =
ANY CLAIM,
>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT=
 OR
>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE=
 OR THE
>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + ********************************************************************=
******/
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
>> +	struct drm_global_reference mem_ref;
>> +	struct drm_global_reference bo_ref;
>> +};
>> +
>> +/**
>> + * ttm_global_init
>> + *
>> + * @glob: A pointer to a struct ttm_global that is about to be initia=
lized
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
>> + * Releases an initialized instance of struct ttm_global. If the inst=
ance
>> + * constains the final references to the global memory and BO, the gl=
obal
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
>> + * Returns the global BO. The BO should be forwarded to the initializ=
ation
>> + * of a driver's TTM BO device.
>> + */
>> +static inline struct ttm_bo_global*
>> +ttm_global_get_bo_global(struct ttm_global *glob)
>> +{
>> +	return glob->bo_ref.object;
>> +}
>> +
>> +#endif /* _TTM_GLOBAL_H_ */
>> --=20
>> 2.19.1
>>
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


--7nAQOHoFsyQHBdqt0SamcasooVq9s41DO--

--oehW6VUXucu8TnXCUhMW7vJy2dvKthsWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlvJiecACgkQaA3BHVML
eiM1FQf+P1VzkmrdLjGzokGbJXHtwo+mHEAXqwCOCBhHrX0zyIj3R8w/gYkCrShx
MnnTMvQG3SLBbxMTqRyhNovJ1Tpqr4bGaJkXrQk6uLNBZWpAq6xnyDSZiFQD/6yg
2gVDe3Sl+FCZRzYiD8JdRRyf98/ffDlUBVtAvTk7k7sG6WaAenHWqqxCnJ4DsqKJ
/kkbbxrtDV6n2Co+WeOtTO89X+dJqcxcdg4cEJ89sOPD5RURFMWoCZT7Ayb2XNPc
IhYgCOYizFuwANC2Ek8GuP1PDdZ55pCNAtMmC00L2NxQr5Q4mugofj4Kj7GsHUIk
FSENRtzmuy9g+lC3OifFFHKaRaCh/A==
=gqA1
-----END PGP SIGNATURE-----

--oehW6VUXucu8TnXCUhMW7vJy2dvKthsWW--

--===============0892490067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0892490067==--
