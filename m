From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix warning in dce_virtual.c
Date: Sat, 15 Oct 2016 21:35:11 +1100
Message-ID: <2c0ac9ff-75f6-dcd3-4583-ec3ef66ea921@folklore1984.net>
References: <1476468027-10305-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1207094735=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1476468027-10305-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============1207094735==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xlraca1P0TVQjXg1PPLeaqosJN67ep0pU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xlraca1P0TVQjXg1PPLeaqosJN67ep0pU
Content-Type: multipart/mixed; boundary="FaHjGj33mvPLPqEhn75NjmFDFTf2dbCHB";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <2c0ac9ff-75f6-dcd3-4583-ec3ef66ea921-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix warning in dce_virtual.c
References: <1476468027-10305-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1476468027-10305-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--FaHjGj33mvPLPqEhn75NjmFDFTf2dbCHB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

if possible can you squash it into the original bad commit?

On 10/15/2016 05:00 AM, Alex Deucher wrote:
> copy paste typo when I re-arranged the code.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm=
/amd/amdgpu/dce_virtual.c
> index 2eefa5d..48973b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -657,18 +657,18 @@ static int dce_virtual_connector_encoder_init(str=
uct amdgpu_device *adev,
> =20
>  	/* add a new encoder */
>  	encoder =3D kzalloc(sizeof(struct drm_encoder), GFP_KERNEL);
> -	if (!encoder) {
> -		kfree(connector);
> +	if (!encoder)
>  		return -ENOMEM;
> -	}
>  	encoder->possible_crtcs =3D 1 << index;
>  	drm_encoder_init(adev->ddev, encoder, &dce_virtual_encoder_funcs,
>  			 DRM_MODE_ENCODER_VIRTUAL, NULL);
>  	drm_encoder_helper_add(encoder, &dce_virtual_encoder_helper_funcs);
> =20
>  	connector =3D kzalloc(sizeof(struct drm_connector), GFP_KERNEL);
> -	if (!connector)
> +	if (!connector) {
> +		kfree(encoder);
>  		return -ENOMEM;
> +	}
> =20
>  	/* add a new connector */
>  	drm_connector_init(adev->ddev, connector, &dce_virtual_connector_func=
s,
>=20


--FaHjGj33mvPLPqEhn75NjmFDFTf2dbCHB--

--xlraca1P0TVQjXg1PPLeaqosJN67ep0pU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYAgZfAAoJEP4bvbfZuWjbp4MP/0q6HnT31UpmOX0FZdrB1mvI
3X1Msn3ak9E4wFeIoif2DhLxlAz6o54ABnbX4Xi1Y3xpSf07WllQDuVnR7593YFd
9xQBEqgUF92cJGyf5nGrddt6LWZGYBtRkA4+2FtQB0XO8dxn7mlVe+udaJK584lQ
IaaIigqgIiQDjaQ7PcqC14SdD59HiFrYh+v2QCrWv9edNwdrOIkdgXmO/wiudICq
S4q1mWzMmkfh/GQW/P3N/cpkeCM8isdeZQXSLdI3Rj1MJyHZyI9dmfyDSoTukRZb
mkXptDx5o+OAaICgMJ/G8yZJljmrGotMeDuX2HssSZXg5/yYd3yVmUdPg12ZgrMM
gX87MbotsWTlIOExL97HuGBfEUwORp2Oo+HSDsA+k25vvEs9oSrhWinc176UUWYQ
kF9pHhGmy6TkzZzh8QyYU+CyAAGmd8/Ma5L/PHL5YFB0bEXXBFkpkX1KSYb38ZBq
CFRvHkP9aqIeTvEvrDdE255aJJsRlgLh/F8pJDGhmtBP+TTCbpiZRFF9/wgapVbT
/x1IpCrDCckEHnm3nYYsrAngXvzS4puiIBq4+Vi6Uhq6xYoLCKIWHKKqH9KJ6rRD
4CaEMmzwlm9AU/W8W87pMJZAJfT59EwVIRiNHt4qZ/4vtTFwEiBqmOxi255MDHMc
65wxuYxsDrpUfuOef847
=D8Bk
-----END PGP SIGNATURE-----

--xlraca1P0TVQjXg1PPLeaqosJN67ep0pU--

--===============1207094735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1207094735==--
