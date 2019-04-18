From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] drm: increase drm mmap_range size to 1TB
Date: Thu, 18 Apr 2019 09:29:39 +0200
Message-ID: <ce68d6f5-317b-ae11-187c-4468dd6f2bc3@suse.de>
References: <20190417221507.933-1-Philip.Yang@amd.com>
 <c8d289ef-75dc-163e-bea5-cd0d429d8614@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0802664882=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c8d289ef-75dc-163e-bea5-cd0d429d8614-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0802664882==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fb4nurGV04Lyppk6DqBfEwfvUMZLJ7OWS"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fb4nurGV04Lyppk6DqBfEwfvUMZLJ7OWS
Content-Type: multipart/mixed; boundary="4uhE8gSHALYxEC8megKeVeguLCDBLCkaV";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>,
 "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>,
 Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <ce68d6f5-317b-ae11-187c-4468dd6f2bc3-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] drm: increase drm mmap_range size to 1TB
References: <20190417221507.933-1-Philip.Yang-5C7GfCeVMHo@public.gmane.org>
 <c8d289ef-75dc-163e-bea5-cd0d429d8614-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <c8d289ef-75dc-163e-bea5-cd0d429d8614-5C7GfCeVMHo@public.gmane.org>

--4uhE8gSHALYxEC8megKeVeguLCDBLCkaV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.04.19 um 00:16 schrieb Kuehling, Felix:
> Adding dri-devel
>=20
> On 2019-04-17 6:15 p.m., Yang, Philip wrote:
>> After patch "drm: Use the same mmap-range offset and size for GEM and
>> TTM", application failed to create bo of system memory because drm
>> mmap_range size decrease to 64GB from original 1TB. This is not big
>> enough for applications. Increase the drm mmap_range size to 1TB.

That change in size was accidental. Thanks for restoring the original
value. The fix will affect GEM as well. If that is not a problem then

Reviewed-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>

Best regards
Thomas

>> Change-Id: Id482af261f56f3289e8873f5985078da599a0998
>> Signed-off-by: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   include/drm/drm_vma_manager.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/drm/drm_vma_manager.h b/include/drm/drm_vma_manag=
er.h
>> index f4f8ff1cdeec..76ac5e97a559 100644
>> --- a/include/drm/drm_vma_manager.h
>> +++ b/include/drm/drm_vma_manager.h
>> @@ -35,7 +35,7 @@
>>    */
>>   #if BITS_PER_LONG =3D=3D 64
>>   #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFFUL >> PAGE_SHIFT) + 1=
)
>> -#define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFFUL >> PAGE_SHIFT) * 16)=

>> +#define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFFUL >> PAGE_SHIFT) * 256=
)
>>   #else
>>   #define DRM_FILE_PAGE_OFFSET_START ((0xFFFFFFFUL >> PAGE_SHIFT) + 1)=

>>   #define DRM_FILE_PAGE_OFFSET_SIZE ((0xFFFFFFFUL >> PAGE_SHIFT) * 16)=

> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--4uhE8gSHALYxEC8megKeVeguLCDBLCkaV--

--Fb4nurGV04Lyppk6DqBfEwfvUMZLJ7OWS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAly4J2gACgkQaA3BHVML
eiOgWQf+PGgckgFfaGAKdyj540tEVzpkRrljKN1LaSoTZYZPXIUg/Kj8AZriuYDo
VLtMM4rd5w8iAQ21yeb/u83Y0FTOV9yHX1gpfSTt5EceAftFGvh+sbsoC5XEAu8J
Fhg+NoRWqDrxPJHfY7WxBNluLfHpzYQjNt4sPub2cxZstTrUCwtMzzCFlpD8aKCX
rsShbF2GqPrNAJyjYu8PdYn8VC1alfdrfqbRHQPBrXh3F2i20YfdlvDC+GN58wFR
wDJt1v1ipLE1nLYO1p80sqVqAYjGZ59orxK+HBC/TW42atIuA9uAKvyv1LvcF1zl
UXWL2aXj0LbMdPTbCSsJVG6RS6ppYg==
=Y3aY
-----END PGP SIGNATURE-----

--Fb4nurGV04Lyppk6DqBfEwfvUMZLJ7OWS--

--===============0802664882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0802664882==--
