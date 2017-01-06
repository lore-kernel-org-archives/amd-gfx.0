From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 01/10] drm/radeon/si: load special ucode for certain MC
 configs
Date: Sat, 7 Jan 2017 01:20:52 +1100
Message-ID: <5f0ad2a1-5452-7422-c898-b1490e697c71@folklore1984.net>
References: <1483639864-16171-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0378020507=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1483639864-16171-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============0378020507==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fTPALfW283hSIlcrFK9pg9t3ouGVd3IaH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fTPALfW283hSIlcrFK9pg9t3ouGVd3IaH
Content-Type: multipart/mixed; boundary="qn5dK9HLcA8eHxm5iiPU2bkBI9OABbggN";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <5f0ad2a1-5452-7422-c898-b1490e697c71-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 01/10] drm/radeon/si: load special ucode for certain MC
 configs
References: <1483639864-16171-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1483639864-16171-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--qn5dK9HLcA8eHxm5iiPU2bkBI9OABbggN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/06/2017 05:10 AM, Alex Deucher wrote:
> Required for certain MC configs.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/radeon/si.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index ad4d7b8..bbc239e 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -116,6 +116,8 @@ MODULE_FIRMWARE("radeon/hainan_rlc.bin");
>  MODULE_FIRMWARE("radeon/hainan_smc.bin");
>  MODULE_FIRMWARE("radeon/hainan_k_smc.bin");
> =20
> +MODULE_FIRMWARE("radeon/si58_mc.bin");
> +
>  static u32 si_get_cu_active_bitmap(struct radeon_device *rdev, u32 se,=
 u32 sh);
>  static void si_pcie_gen3_enable(struct radeon_device *rdev);
>  static void si_program_aspm(struct radeon_device *rdev);
> @@ -1651,6 +1653,7 @@ static int si_init_microcode(struct radeon_device=
 *rdev)
>  	int err;
>  	int new_fw =3D 0;
>  	bool new_smc =3D false;
> +	bool si58_fw =3D false;
> =20
>  	DRM_DEBUG("\n");
> =20
> @@ -1746,6 +1749,9 @@ static int si_init_microcode(struct radeon_device=
 *rdev)
>  	default: BUG();
>  	}
> =20

Hi Alex,

I suggest just a short one line comment above here and also in the
amdgpu patch too explaining what a 'si58_fw' actually means for a
non-AMD eng.

With that this series is,
Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> +	if (((RREG32(MC_SEQ_MISC0) & 0xff000000) >> 24) =3D=3D 0x58)
> +		si58_fw =3D true;
> +
>  	DRM_INFO("Loading %s Microcode\n", new_chip_name);
> =20
>  	snprintf(fw_name, sizeof(fw_name), "radeon/%s_pfp.bin", new_chip_name=
);
> @@ -1849,7 +1855,10 @@ static int si_init_microcode(struct radeon_devic=
e *rdev)
>  		}
>  	}
> =20
> -	snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", new_chip_name)=
;
> +	if (si58_fw)
> +		snprintf(fw_name, sizeof(fw_name), "radeon/si58_mc.bin");
> +	else
> +		snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", new_chip_name=
);
>  	err =3D request_firmware(&rdev->mc_fw, fw_name, rdev->dev);
>  	if (err) {
>  		snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc2.bin", chip_name);
>=20


--qn5dK9HLcA8eHxm5iiPU2bkBI9OABbggN--

--fTPALfW283hSIlcrFK9pg9t3ouGVd3IaH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYb6fEAAoJEP4bvbfZuWjbgiEQAIMLRd9AbO9gM2xwLeqvOy4P
6Cv7p0WpI24HCvJMItjE5zcZ3W1uGBygULFWJAoj68UlrI8CcU4eVaXVwWlJ7oZM
MyaibqHaMi6HGEhKHS5F+oIUKB/uhs/IRxRExR8vUgJmkP+qZwjuXe4vDAZC3+fB
9zDKnEME97rt99AJBt2aQSrC3hrsA0hCXxIYqounGVFkqvcrBWnWBbXPHfEaVV8a
ycLZ1bEIsXd9p24VgyL3a2N7rF8CVLYnqzQ92LqHcsyvm7O1NaOkVKAf9bDdMK9J
FMU7gU4dRGMMMSETGcdp4a6b1O0tFH2uVZVj3V0muM94tn8Z9vc3ckhmdZmt6QRo
7VkAcTIVA5ulU0pts5yHe1DQoHw+KO2RJjNappcR+H7lFkrPCBk7L7wOx+UKDdEH
cUdMrxCVXA0uHosrs+eNAdCDK21HzgGGXEM7N7CzJR+3M/CgCavktGcvJZGt4/yV
/mDI+3Q7kIh/vX/UK0/vQqSjbxB8gnQC6n6BquOK02t5vsObESLbEGPt9T/A6hMn
CNuX4rvAp3UJ1WBA83tQxPGZ6jjoHZ8hkJe8QvOP0ADYtPIOWS//yvDpfAYw6Q7T
uSinRh0X9Ep2JcjKt57NSThxPg+pnRI3uGRUbt4qhUVfRGigx9JjcPyAjHR8WG5n
ZzC3yBjTdttIYnHy5/HZ
=tYdg
-----END PGP SIGNATURE-----

--fTPALfW283hSIlcrFK9pg9t3ouGVd3IaH--

--===============0378020507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0378020507==--
