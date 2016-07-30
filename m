From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: change pptable output format from ASCII
 to binary
Date: Sat, 30 Jul 2016 13:19:32 +1000
Message-ID: <26c00442-1635-acd4-b89b-7664a2502b6a@folklore1984.net>
References: <1469817418-31500-1-git-send-email-JinHuiEric.Huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0028946048=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469817418-31500-1-git-send-email-JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
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
To: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0028946048==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IIVwrkliEocxUHJg5bKglXfqAkrmFpAgc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IIVwrkliEocxUHJg5bKglXfqAkrmFpAgc
Content-Type: multipart/mixed; boundary="E0Cp5PEfLbmAXw0Ubu1WoIltplMwjK0sF"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <26c00442-1635-acd4-b89b-7664a2502b6a-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: change pptable output format from ASCII
 to binary
References: <1469817418-31500-1-git-send-email-JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1469817418-31500-1-git-send-email-JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>

--E0Cp5PEfLbmAXw0Ubu1WoIltplMwjK0sF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 07/30/2016 04:36 AM, Eric Huang wrote:
> Signed-off-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_pm.c
> index c4bb4ef..cded082 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -305,7 +305,7 @@ static ssize_t amdgpu_get_pp_table(struct device *d=
ev,
>  	struct drm_device *ddev =3D dev_get_drvdata(dev);
>  	struct amdgpu_device *adev =3D ddev->dev_private;
>  	char *table =3D NULL;
> -	int size, i;
> +	int size;
> =20
>  	if (adev->pp_enabled)
>  		size =3D amdgpu_dpm_get_pp_table(adev, &table);
> @@ -315,10 +315,7 @@ static ssize_t amdgpu_get_pp_table(struct device *=
dev,
>  	if (size >=3D PAGE_SIZE)
>  		size =3D PAGE_SIZE - 1;
> =20
> -	for (i =3D 0; i < size; i++) {
> -		sprintf(buf + i, "%02x", table[i]);
> -	}
> -	sprintf(buf + i, "\n");
> +	memcpy(buf, table, size);
> =20
>  	return size;
>  }
>=20


--E0Cp5PEfLbmAXw0Ubu1WoIltplMwjK0sF--

--IIVwrkliEocxUHJg5bKglXfqAkrmFpAgc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXnBzEAAoJEP4bvbfZuWjbpJ0P/RHndOwiiOO+GB/mjjp/QCkX
wmWXfhnP4klhe+zaXRQf0hnRisG+SUwsdITdqq0u/x5aWPq3cfQ0lBrSTanMKvjv
CI3mWYVMMX0xMJLOtvT1MB+9nmHjIq5HnH9qPfMFP/X/6rKS7/LF5Q6S1O2fitRm
B0Kbp8nRPwm4QhXqd1kzTZHVZiKWWYj6um/cWmIpqoj+0OsTwjWJVRIIqXOHA+zB
t31yhYCuD1inRxdywCf1VeOv1prteL5IevzxctEa27yLFU9gsXFH4JnZBiKAuBwm
lDf4wH9kaeGtXLLEZOWYH5cANp58sptqgOvEMTet7+RJQAz8cKOj8mJ1wAM8V5fR
k93Zw+RV9VBgwe7AoOXkXWWgnsGL68tQFX7K4AWu/IvIJCqb7/mQHTE4otFtBsMz
3zAuK8hjfifbn1NImOet//JAhytsGmEzsghGmaZUeiYTLzIIbfn3eOrSzyl6zg0J
HzZq55K1IYsx1zvderN5ZN0P0eW+Z66ZhYoLFD4FKPoxwFMZdKUFqT80WqWtfngA
NeF7we+R9rpJUuC5Gn9E85QvuqNc3DGBgXjfvp+uQhF7E0H7/C/zL6/ZHMU/1uYr
h5LaRxbHkv1c0XmjBn7Qohtjq3wo092v8dE45mttYiiBNJCtKRvOWLGap2eedYbh
xi9irRZUy+Oc8zz0oN3r
=KN65
-----END PGP SIGNATURE-----

--IIVwrkliEocxUHJg5bKglXfqAkrmFpAgc--

--===============0028946048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0028946048==--
