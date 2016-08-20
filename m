From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu] Fix cursor size for SI
Date: Sat, 20 Aug 2016 20:50:14 +1000
Message-ID: <186f90ca-c698-fccb-46ce-f42143b765c2@folklore1984.net>
References: <1471603432-5378-1-git-send-email-maraeo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1254790786=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471603432-5378-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1254790786==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ntAq1SxrJ10Cn9F1WH7uJW6TENv3cv8BI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ntAq1SxrJ10Cn9F1WH7uJW6TENv3cv8BI
Content-Type: multipart/mixed; boundary="s8fL7qFJVV6R4ORoG7aFapBA5oIOIiXLq"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <186f90ca-c698-fccb-46ce-f42143b765c2-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu] Fix cursor size for SI
References: <1471603432-5378-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1471603432-5378-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--s8fL7qFJVV6R4ORoG7aFapBA5oIOIiXLq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

Perhaps a follow up that queries the kernel instead, however better this
than broken.

On 08/19/2016 08:43 PM, Marek Ol=C5=A1=C3=A1k wrote:
> From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>=20
> This doesn't fix the missing cursor, which seems to be a kernel issue,
> because it's missing with modesetting as well.
> ---
>  src/amdgpu_kms.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/amdgpu_kms.c b/src/amdgpu_kms.c
> index 9ee48df..d9f15a4 100644
> --- a/src/amdgpu_kms.c
> +++ b/src/amdgpu_kms.c
> @@ -922,22 +922,28 @@ Bool AMDGPUPreInit_KMS(ScrnInfoPtr pScrn, int fla=
gs)
>  		goto fail;
>  	}
> =20
>  	AMDGPUSetupCapabilities(pScrn);
> =20
>  	if (info->drmmode.count_crtcs =3D=3D 1)
>  		pAMDGPUEnt->HasCRTC2 =3D FALSE;
>  	else
>  		pAMDGPUEnt->HasCRTC2 =3D TRUE;
> =20
> -	info->cursor_w =3D CURSOR_WIDTH_CIK;
> -	info->cursor_h =3D CURSOR_HEIGHT_CIK;
> +	if (info->ChipFamily >=3D CHIP_FAMILY_TAHITI &&
> +	    info->ChipFamily <=3D CHIP_FAMILY_HAINAN) {
> +		info->cursor_w =3D CURSOR_WIDTH;
> +		info->cursor_h =3D CURSOR_HEIGHT;
> +	} else {
> +		info->cursor_w =3D CURSOR_WIDTH_CIK;
> +		info->cursor_h =3D CURSOR_HEIGHT_CIK;
> +	}
> =20
>  	amdgpu_query_heap_size(pAMDGPUEnt->pDev, AMDGPU_GEM_DOMAIN_GTT,
>  				&heap_size, &max_allocation);
>  	info->gart_size =3D heap_size;
>  	amdgpu_query_heap_size(pAMDGPUEnt->pDev, AMDGPU_GEM_DOMAIN_VRAM,
>  				&heap_size, &max_allocation);
>  	info->vram_size =3D max_allocation;
> =20
>  	xf86DrvMsg(pScrn->scrnIndex, X_INFO,
>  		   "mem size init: gart size :%llx vram size: s:%llx visible:%llx\n"=
,
>=20


--s8fL7qFJVV6R4ORoG7aFapBA5oIOIiXLq--

--ntAq1SxrJ10Cn9F1WH7uJW6TENv3cv8BI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXuDXmAAoJEP4bvbfZuWjbpE0P/AmvJ5Qolvxv2/gQWozkRu8g
9OKCVrFR4HHYiomsg7i3K47IpiLEyxeVoHRppEBW4S9uw7+/mFsOzat9MUu+DT4r
tyqBm/kFblrcbwi2cKoU2km2eAwLDzIzPIWGONFsr0G9aM6QegnetMYVgZGQX59M
nBr8qJ2xI2hddDsenKNdnd1A3+Ams9zITqKgh3sqocxt3maxeAuel0Bt33JTxTLL
A0nwNsILNU/rmteJKK+DDUnUZK4Aficx51iw8lUW95w9kzgQ2fqcgCF2N9Zemff5
L1p3oxG0p7+6YQLlNHTFraO4HdT22Qb4Q2o4dOm3wq7OBK0c0kzKFcnnMa1akWkb
kGYzGOEl3kb/K/34wMA90Bvc7fKuqp+pekCBxWcYILQQMKWGmhepSZ4BCJoQUrGt
IQgpprdMRhzqMwD3L/Gd57vnSFfelEJXlmpqa2lu3P0vM6/TgKAUVjVJzQ+sqKzh
hw9fohI7GM5yeObgCppGP4czaUY9uS73S1VRsaglsNr4dYNifACSoCw7sO9FMv6B
gSacCHRjasWLOmio3543ka/Me5xD2HwWHOvh50S8I6PeeiU+w1090qEBy+ZRXjB6
HKmy4eD7VODE2BK4wr0HOZcz2ybZUQ9/S1uMneU2shNCaCNnR9Y5CmA7SUDQm5R+
u4noK17/CvWtoTNLV1mC
=KWGV
-----END PGP SIGNATURE-----

--ntAq1SxrJ10Cn9F1WH7uJW6TENv3cv8BI--

--===============1254790786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1254790786==--
