From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu/vi: whitespace fixes
Date: Tue, 20 Sep 2016 09:31:07 +1000
Message-ID: <04b4825e-fc31-2c79-9a78-13be900d19d5@folklore1984.net>
References: <1474310162-21802-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0607897465=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474310162-21802-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0607897465==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VIcwi9W8oOrKBIk48umRNWTfE5P3Raxpo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VIcwi9W8oOrKBIk48umRNWTfE5P3Raxpo
Content-Type: multipart/mixed; boundary="94aiX901wAlKepkL0J3TEWWQhHU2B96Ns";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <04b4825e-fc31-2c79-9a78-13be900d19d5-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu/vi: whitespace fixes
References: <1474310162-21802-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1474310162-21802-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--94aiX901wAlKepkL0J3TEWWQhHU2B96Ns
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Series is,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 09/20/2016 04:35 AM, Alex Deucher wrote:
> function declaration parens should be a new line.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> index 5141393..81780f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -445,7 +445,8 @@ static bool vi_read_bios_from_rom(struct amdgpu_dev=
ice *adev,
>  	return true;
>  }
> =20
> -static void vi_detect_hw_virtualization(struct amdgpu_device *adev) {
> +static void vi_detect_hw_virtualization(struct amdgpu_device *adev)
> +{
>  	uint32_t reg =3D RREG32(mmBIF_IOV_FUNC_IDENTIFIER);
>  	/* bit0: 0 means pf and 1 means vf */
>  	/* bit31: 0 means disable IOV and 1 means enable */
> @@ -461,7 +462,8 @@ static void vi_detect_hw_virtualization(struct amdg=
pu_device *adev) {
>  	}
>  }
> =20
> -static void vi_detect_sriov_bios(struct amdgpu_device *adev) {
> +static void vi_detect_sriov_bios(struct amdgpu_device *adev)
> +{
>  	if (amdgpu_atombios_has_gpu_virtualization_table(adev))
>  		adev->virtualization.virtual_caps |=3D AMDGPU_SRIOV_CAPS_SRIOV_VBIOS=
;
>  }
>=20


--94aiX901wAlKepkL0J3TEWWQhHU2B96Ns--

--VIcwi9W8oOrKBIk48umRNWTfE5P3Raxpo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX4HU8AAoJEP4bvbfZuWjbCD8QAMZbAoKotnFRMfbI7+vl9XPg
lnOW4sF9BXC2uzSqpCP510HA51F8CaYmmU82qFNYNexdtE6aLuYTgaVWbdSgfKXc
XL6Eerhn/HsVWNFyqNomHd7S4CYQy6cXcqzIzBgewcP2oDYI2JN4huEqUSQIy9yT
M2yv7bCoyVVIUFQMXcHuIzWasVfYX5vmd+QxMmNvwfzbECVt/Ro69ePZfYpEHz8k
TXO2fEo332pzhjQxeKMjJM65VDUfMmxs758UFW4ACMlgMAfGecIV/Pc/5U7KuBw5
XEvz9ZqA1xPMbn9SPwP6WBzOyIItEOSyxnR+VkoQPRr0oe4B1H94OqEZWM57rPUB
dLz9Y4mEAdLwzPH/MdeHVIP9c88GiozkuKxVXIdaNZ9yhATGnXgRz6pGSdi691T9
S78d22QwLu+2wyD1Q6gk5Bg/m03hpchQq8yCo/KuOnHv7sc9HtoOV7JlTz/JBw6X
YSPBd0C8qABu8kENQSfx4gD/iye7Uw6OdyL+Cik0rX/fY2YHwhV3NHDsa8EIoUFi
0SfxKaG0hAuCGzWlsb3niaZztBcIKl3bdbBpf5BVdQcElFZ91xKUeQNME+DuQvT/
AcQVqtPFTR5i6UV6Z4SkmadpvNVWjBxQjpM2AbVOw5DvToe6LLo9udtOM3EoazS0
8eizeZz6VavbyLTA2Cy4
=rZsU
-----END PGP SIGNATURE-----

--VIcwi9W8oOrKBIk48umRNWTfE5P3Raxpo--

--===============0607897465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0607897465==--
