From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix coding style and printing in
 amdgpu_doorbell_init
Date: Tue, 7 Mar 2017 01:28:25 +1100
Message-ID: <1d07e4d7-9e91-f574-8fa0-8c47045907e7@folklore1984.net>
References: <1488808441-25756-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0479500835=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1488808441-25756-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0479500835==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lV4f0L3wmhPkVAxDuiviVc6SLpQ7kmPW6"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lV4f0L3wmhPkVAxDuiviVc6SLpQ7kmPW6
Content-Type: multipart/mixed; boundary="icji8AMwrS6LhSFl3kO0B0RIKdwe0lDeI";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <1d07e4d7-9e91-f574-8fa0-8c47045907e7-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix coding style and printing in
 amdgpu_doorbell_init
References: <1488808441-25756-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <1488808441-25756-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--icji8AMwrS6LhSFl3kO0B0RIKdwe0lDeI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 03/07/2017 12:54 AM, Christian K=C3=B6nig wrote:
> From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>=20
> Based on commit "drm/radeon: remove useless and potentially wrong messa=
ge".
>=20
> The size of the info printing is incorrect and the PCI subsystems print=
s
> the same info on boot anyway.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index bf31aaf..fd03072 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -381,12 +381,11 @@ static int amdgpu_doorbell_init(struct amdgpu_dev=
ice *adev)
>  	if (adev->doorbell.num_doorbells =3D=3D 0)
>  		return -EINVAL;
> =20
> -	adev->doorbell.ptr =3D ioremap(adev->doorbell.base, adev->doorbell.nu=
m_doorbells * sizeof(u32));
> -	if (adev->doorbell.ptr =3D=3D NULL) {
> +	adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
> +				     adev->doorbell.num_doorbells *
> +				     sizeof(u32));
> +	if (adev->doorbell.ptr =3D=3D NULL)
>  		return -ENOMEM;
> -	}
> -	DRM_INFO("doorbell mmio base: 0x%08X\n", (uint32_t)adev->doorbell.bas=
e);
> -	DRM_INFO("doorbell mmio size: %u\n", (unsigned)adev->doorbell.size);
> =20
>  	return 0;
>  }
>=20


--icji8AMwrS6LhSFl3kO0B0RIKdwe0lDeI--

--lV4f0L3wmhPkVAxDuiviVc6SLpQ7kmPW6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvXINAAoJEP4bvbfZuWjbIJEP/16ypX34wG5QgQfBytB142q+
HzUpGEWHCQqkDoDrG13au9/DgaVt6BjlHiPWzyCZFVuSXWKV2M2pXt/bh1wcsrEL
cxCsAAAqJXAYU7R8jBWlL2ncz8rKrpKL2q2lMhAWlDaoqad47P+40LlvUCCRwaZt
RGevMpKJUvn1I1PSpUGDMEU2RVAWlHWmtZW0KG2e/i16Fnzon38xf/Per4XI2nWR
8Qlc59psB1433BJ8nvOpdby+uBNS85RL24giEpfaSL4kd1kvg5Ff89JXPHmsgwlo
2RE0gHFuP/wJnSa2T5a7bxZgz7uKx8aa3zOlVx2aH3mqHDW3i0dfrrRijJr3l78D
9Ekx9Aacb3c8BfqLp/H95hZ4/GEygF3XzmHsZenbunq2CWdp7KpWU+z2BZwI0Ec9
7VUA/dA1IBUHzxLB22juROYUqPwzi8nQGQrenmG4+KTZBIThAbPCot/19Wxv3RyT
1SyVS1qEmGpG4bO5KInBrByXXOtGiZ9AjSLABsDfhdG6MKhCtQ+EXGFvsyFiiM2u
9YgWXCPb1D3hwVc9ba9k+RpNs0DTo/9klelJTWO/N+SReyNcGT18grBcaXsvCKOh
ryUxuweTMoOr7oIVD91B3ztxMUFOLgaXQVql8yEBTthjBL4uSFskqsF/4PnprjsC
eL2eyIM0YXtA6FQVAyjq
=5eTA
-----END PGP SIGNATURE-----

--lV4f0L3wmhPkVAxDuiviVc6SLpQ7kmPW6--

--===============0479500835==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0479500835==--
