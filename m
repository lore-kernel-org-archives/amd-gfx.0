From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/5] drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
Date: Fri, 8 Feb 2019 08:58:48 +0100
Message-ID: <64feef09-062f-27ea-b35f-39a23644b4b6@suse.de>
References: <20190207085931.29569-1-tzimmermann@suse.de>
 <20190207085931.29569-3-tzimmermann@suse.de>
 <67782273034c55fd14d7c5d20ba35309ade32afe.camel@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0882135937=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <67782273034c55fd14d7c5d20ba35309ade32afe.camel@vmware.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thomas Hellstrom <thellstrom@vmware.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "zourongrong@gmail.com" <zourongrong@gmail.com>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "alexander.deucher@amd.com" <alexander.deucher@amd.com>, "David1.Zhou@amd.com" <David1.Zhou@amd.com>, "ray.huang@amd.com" <ray.huang@amd.com>, "bskeggs@redhat.com" <bskeggs@redhat.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "airlied@redhat.com" <airlied@redhat.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Jerry.Zhang@amd.com" <Jerry.Zhang@amd.com>, Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: amd-gfx.lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0882135937==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="q37wT5bRzWa9BCN4MrlybHzwM77ugnl2V"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q37wT5bRzWa9BCN4MrlybHzwM77ugnl2V
Content-Type: multipart/mixed; boundary="PoeV4raQ1gdDlWikQSvAPAQ0X8udAfekc";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Thomas Hellstrom <thellstrom@vmware.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "zourongrong@gmail.com" <zourongrong@gmail.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "hdegoede@redhat.com" <hdegoede@redhat.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "David1.Zhou@amd.com" <David1.Zhou@amd.com>,
 "ray.huang@amd.com" <ray.huang@amd.com>,
 "bskeggs@redhat.com" <bskeggs@redhat.com>,
 "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>,
 "airlied@redhat.com" <airlied@redhat.com>, "daniel@ffwll.ch"
 <daniel@ffwll.ch>, "Jerry.Zhang@amd.com" <Jerry.Zhang@amd.com>,
 Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>,
 "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>,
 "arnd@arndb.de" <arnd@arndb.de>
Cc: "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Message-ID: <64feef09-062f-27ea-b35f-39a23644b4b6@suse.de>
Subject: Re: [PATCH 2/5] drm/ttm: Define a single DRM_FILE_PAGE_OFFSET
 constant
References: <20190207085931.29569-1-tzimmermann@suse.de>
 <20190207085931.29569-3-tzimmermann@suse.de>
 <67782273034c55fd14d7c5d20ba35309ade32afe.camel@vmware.com>
In-Reply-To: <67782273034c55fd14d7c5d20ba35309ade32afe.camel@vmware.com>

--PoeV4raQ1gdDlWikQSvAPAQ0X8udAfekc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.02.19 um 20:07 schrieb Thomas Hellstrom:
>=20
>> diff --git a/include/drm/ttm/ttm_bo_driver.h
>> b/include/drm/ttm/ttm_bo_driver.h
>> index cbf3180cb612..c0bed72492f3 100644
>> --- a/include/drm/ttm/ttm_bo_driver.h
>> +++ b/include/drm/ttm/ttm_bo_driver.h
>> @@ -49,6 +49,8 @@
>>  #define TTM_MEMTYPE_FLAG_MAPPABLE      (1 << 1)	/* Memory
>> mappable */
>>  #define TTM_MEMTYPE_FLAG_CMA           (1 << 3)	/* Can't map
>> aperture */
>> =20
>> +#define DRM_FILE_PAGE_OFFSET (0x100000000ULL >> PAGE_SHIFT)
>> +
>=20
> IMO strictly, the place in the drm file address space where a driver
> chooses to insert the TTM bo address space is to be determined by DRM,
> (as also the define indicates) rather than TTM. So I think the right
> place for this define is a drm header, not a ttm header.

I put this here temporarily for the cleanup. But it gets fixed by patch
[05], which moves the constants into drm_vma_manager.h

Best regards
Thomas

>=20
> Thanks,
> Thomas
>=20
>=20
>>  struct ttm_mem_type_manager;
>> =20
>>  struct ttm_mem_type_manager_func {
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstr. 5, D-90409 N=C3=BCrnberg
Tel: +49-911-74053-0; Fax: +49-911-7417755;  https://www.suse.com/
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard,
Graham Norton, HRB 21284 (AG N=C3=BCrnberg)


--PoeV4raQ1gdDlWikQSvAPAQ0X8udAfekc--

--q37wT5bRzWa9BCN4MrlybHzwM77ugnl2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlxdNrwACgkQaA3BHVML
eiOE4Qf+NdRTxA6wptm6DXWAixgevV2wczdvOuu3dRwj+RtbG1UMOOMBN03R7YRe
CCXPQLmNFReFa829dDHS/jYUtgl9SUJIgaYXF6pZsd3FAsgWakUTwxn8O4WHYZ/O
3yOr2BVSLHqLnQUxxblvo6ZtvjZAcsEPVtL2xa2gX6v4OUkBZvSEQldMCM5bOOEo
VdiMI/kdOkx0FZG3fRccNcLRZ85BYQHN+JlyScNtZ1zuxRRrfQtMLsQl9aZXrgAm
nrkVN8RpahQ87WsEBo3xhk+8UsU/3lOL7DxlunQXimFLDVQYvnQtdivk5cWcpcO4
e7kT5lnqdSA0v5QWwkBdaNS0qVKFEw==
=L64E
-----END PGP SIGNATURE-----

--q37wT5bRzWa9BCN4MrlybHzwM77ugnl2V--

--===============0882135937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0882135937==--
