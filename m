From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: bump version for PRT support
Date: Fri, 17 Mar 2017 12:00:58 +1100
Message-ID: <6bbea970-8810-7565-46e3-3fc5d79bebb3@folklore1984.net>
References: <1489675595-8287-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0205313578=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489675595-8287-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0205313578==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SrQmlq2Bts8MtEJsgU8BXgrP17TXbXhMx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SrQmlq2Bts8MtEJsgU8BXgrP17TXbXhMx
Content-Type: multipart/mixed; boundary="OskNFCLQlLnmRAMW3iqTOcjiX48RKtt1i";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <6bbea970-8810-7565-46e3-3fc5d79bebb3-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: bump version for PRT support
References: <1489675595-8287-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1489675595-8287-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--OskNFCLQlLnmRAMW3iqTOcjiX48RKtt1i
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

Alex, as a matter of procedure could you perhaps have the actual version
bump as part of the final patch in a given series? This would mitigate
the issue of forgetting to bump the version for a given relevant changese=
t.

Kindly,
Edward.

On 03/17/2017 01:46 AM, Alex Deucher wrote:
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> index c4dacd5..c75f48e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -62,9 +62,10 @@
>   * - 3.10.0 - Add support for new fences ioctl, new gem ioctl flags
>   * - 3.11.0 - Add support for sensor query info (clocks, temp, etc).
>   * - 3.12.0 - Add query for double offchip LDS buffers
> + * - 3.13.0 - Add PRT support
>   */
>  #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	12
> +#define KMS_DRIVER_MINOR	13
>  #define KMS_DRIVER_PATCHLEVEL	0
> =20
>  int amdgpu_vram_limit =3D 0;
>=20


--OskNFCLQlLnmRAMW3iqTOcjiX48RKtt1i--

--SrQmlq2Bts8MtEJsgU8BXgrP17TXbXhMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYyzVOAAoJEP4bvbfZuWjbKsgP/iJSZVaklDz4tHwHXHbbVAnp
IGnYRlu4CYffwDIdmhFrhTK5qAm011iYPQQxsSD2EERAP4lkxeIDfQLnoV9ABbNd
ARnnSFGDo+ck+mvJZTthSLo2TwDqYfK9FHUUEb37ixLJe44dHqopf1SvsdACbJKu
aWZcIz/7gfPOoclbQWVEPRICUIsP+mEbafpPAq15TqrU4RqIGNQmBYS+YDc6ICDz
/Qvh0nYQhniJFxUF7F+bZzrkErvzDNDXCu3K5rMhiX6W+OqM07ZcqAup1p5z8gPf
PXV9Q2JTkiHEEA1HBlWazvX+hq2DfzItHnaL64qZKoixYEzKlkJWcv+la70ou6BA
41yfmhgzXY9j1RZYC/73cm9MEfXAP4UTxXTXBtXWIqfnO6Xie9uX15DnEdq3Fi2S
2ZUeSNFzXnPxsIoDwQbrpJa3LUOo+ShAClXr5VoxHQnxImmCvDRqmnpe787yH+Pp
WmYjBPCmco23biwtBWPYoQdCdwMMdBf2Wm5mLQGFeyfJ2DSHi8Ol1yaAv0bIzWuD
4Vc9sxOlT4y7HKPVCoOtCDNXFBlCfXYFNwkcGqPhR6pBEHLmxa/TNLc4Go5WkRSA
hYWmCCpVP1df+gXLbpdYB5KnPz4lusBMHBnfsBqZZROOVcf/s42UBu8/ohdRmumX
KbjeZigWwy+9hvizB9x8
=Olek
-----END PGP SIGNATURE-----

--SrQmlq2Bts8MtEJsgU8BXgrP17TXbXhMx--

--===============0205313578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0205313578==--
