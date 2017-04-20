From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add error message to remind user
 updating firmware
Date: Thu, 20 Apr 2017 20:09:27 +1000
Message-ID: <7d3eee1c-7362-2af0-d5bf-764c6e765ee1@folklore1984.net>
References: <1492673633-21017-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1018224836=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492673633-21017-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1018224836==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fjVgGiwSxKSJ4xw9BSaadSscjvmBFcXlD"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fjVgGiwSxKSJ4xw9BSaadSscjvmBFcXlD
Content-Type: multipart/mixed; boundary="xaApJpAqK6JTCSGB58OgkBnvDuCpGGWIn";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Message-ID: <7d3eee1c-7362-2af0-d5bf-764c6e765ee1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add error message to remind user
 updating firmware
References: <1492673633-21017-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1492673633-21017-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>

--xaApJpAqK6JTCSGB58OgkBnvDuCpGGWIn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 04/20/2017 05:33 PM, Huang Rui wrote:
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/dri=
vers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> index 2685f02..b3f3af2 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> @@ -378,8 +378,11 @@ static int vega10_verify_smc_interface(struct pp_s=
mumgr *smumgr)
>  			"Attempt to read SMC IF Version Number Failed!",
>  			return -1);
> =20
> -	if (smc_driver_if_version !=3D SMU9_DRIVER_IF_VERSION)
> -		return -1;
> +	if (smc_driver_if_version !=3D SMU9_DRIVER_IF_VERSION) {
> +		pr_err("Your firmware(0x%x) doesn't match SMU9_DRIVER_IF_VERSION(0x%=
x). Please update your firmware!\n",
> +		       smc_driver_if_version, SMU9_DRIVER_IF_VERSION);
> +		return -EINVAL;
> +	}
> =20
>  	return 0;
>  }
>=20


--xaApJpAqK6JTCSGB58OgkBnvDuCpGGWIn--

--fjVgGiwSxKSJ4xw9BSaadSscjvmBFcXlD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+IjaAAoJEP4bvbfZuWjbdiAP/Ah84VdJHMkuvvHgMS/tqf5k
TJ+ooFwKgo688YIngG10w7t1DcyH+HT3IC4cS3RA+8mizh6AHeqCC8cB4M4eJPCm
imnXOtuAB8spFecD8uq9gRJptwKTaxAExbENxI3ZjmYLkHMiL3Vu9zU0oHNQ5O1t
kLXbMpFHwHBLxqzXFDSLHixllsnRYnX7cltNUtPKTLKGhyqw146+mIzbjMmNxOKZ
yusS9iZ2X4yYupiAPgvflZEI8uUp8be1kHbEtb4sQmkBJq+qyo3hZ86wBz4hdOC3
9CXkW8SAezscqhWoYj5XhWoLHwglsg32zA87eGw+MbCG1e968pUaoZx2rBVrLT14
sl70I3PIxgJtR0CcjSLPKLUVKMmXpzsgJ6vc/pimjglI4pGx7gg8spy1Q/Udx/++
ti4HEYoz0pykJv0wry2zMwB0drH/opcvRAuf2Xoh12BR0+I94wn6fzTYbh8piWGb
7hHDL8YaVNE0pxqYC4MDX15RtIVmlWSUs6TKdWnf/DGam09iRaBuXzCx6J5HO978
vjHpdBP/M1F2IEns2PFcDRE6oqGv/uqhF117iW+IwG4wWUUwSQCrS7uk1HoMZb3Q
7Dcl6i0mHuFZtQs/PB51PNn2+YuKxxSMWcr14rR/tcjrKZu1ja+wXSn7pB3VVo0m
iQB4ZH5/yoXY0eLjthGX
=RnHF
-----END PGP SIGNATURE-----

--fjVgGiwSxKSJ4xw9BSaadSscjvmBFcXlD--

--===============1018224836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1018224836==--
