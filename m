From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/amdgpu: make sriov bios detection generic (v2)
Date: Tue, 20 Sep 2016 09:32:24 +1000
Message-ID: <5c739d6f-35d1-4d05-77b6-9192848445a9@folklore1984.net>
References: <1474310655-3094-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1073982541=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474310655-3094-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============1073982541==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r4BSjhGDMl3UVdBn3qLdfWd4ultm3dujN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r4BSjhGDMl3UVdBn3qLdfWd4ultm3dujN
Content-Type: multipart/mixed; boundary="1bMNCF7jVPS00vbVaOoRM5mX5lrgLQf2j";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <5c739d6f-35d1-4d05-77b6-9192848445a9-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/amdgpu: make sriov bios detection generic (v2)
References: <1474310655-3094-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1474310655-3094-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--1bMNCF7jVPS00vbVaOoRM5mX5lrgLQf2j
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

as with the rest of the respective series.

On 09/20/2016 04:44 AM, Alex Deucher wrote:
> It's not asic specific.
>=20
> v2: drop asic macro
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/vi.c            | 7 -------
>  3 files changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index ff6e683..fb8d603 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1828,7 +1828,6 @@ struct amdgpu_asic_funcs {
>  	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
>  				   u8 *bios, u32 length_bytes);
>  	void (*detect_hw_virtualization) (struct amdgpu_device *adev);
> -	void (*detect_sriov_bios)(struct amdgpu_device *adev);
>  	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
>  			     u32 sh_num, u32 reg_offset, u32 *value);
>  	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
> @@ -2287,7 +2286,6 @@ amdgpu_get_sdma_instance(struct amdgpu_ring *ring=
)
>  #define amdgpu_asic_read_disabled_bios(adev) (adev)->asic_funcs->read_=
disabled_bios((adev))
>  #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs-=
>read_bios_from_rom((adev), (b), (l))
>  #define amdgpu_asic_detect_hw_virtualization(adev) (adev)->asic_funcs-=
>detect_hw_virtualization((adev))
> -#define amdgpu_asic_detect_sriov_bios(adev) (adev)->asic_funcs->detect=
_sriov_bios((adev))
>  #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asi=
c_funcs->read_register((adev), (se), (sh), (offset), (v)))
>  #define amdgpu_gart_flush_gpu_tlb(adev, vmid) (adev)->gart.gart_funcs-=
>flush_gpu_tlb((adev), (vmid))
>  #define amdgpu_gart_set_pte_pde(adev, pt, idx, addr, flags) (adev)->ga=
rt.gart_funcs->set_pte_pde((adev), (pt), (idx), (addr), (flags))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index ca161e9..76f8298 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1535,6 +1535,12 @@ static bool amdgpu_device_is_virtual(void)
>  #endif
>  }
> =20
> +static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev=
)
> +{
> +	if (amdgpu_atombios_has_gpu_virtualization_table(adev))
> +		adev->virtualization.virtual_caps |=3D AMDGPU_SRIOV_CAPS_SRIOV_VBIOS=
;
> +}
> +
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -1690,8 +1696,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
>  	}
> =20
>  	/* detect if we are with an SRIOV vbios */
> -	if (adev->asic_funcs->detect_sriov_bios)
> -		amdgpu_asic_detect_sriov_bios(adev);
> +	amdgpu_device_detect_sriov_bios(adev);
> =20
>  	/* Post card if necessary */
>  	if (amdgpu_vpost_needed(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> index 81780f1..a8154d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -462,12 +462,6 @@ static void vi_detect_hw_virtualization(struct amd=
gpu_device *adev)
>  	}
>  }
> =20
> -static void vi_detect_sriov_bios(struct amdgpu_device *adev)
> -{
> -	if (amdgpu_atombios_has_gpu_virtualization_table(adev))
> -		adev->virtualization.virtual_caps |=3D AMDGPU_SRIOV_CAPS_SRIOV_VBIOS=
;
> -}
> -
>  static const struct amdgpu_allowed_register_entry tonga_allowed_read_r=
egisters[] =3D {
>  	{mmGB_MACROTILE_MODE7, true},
>  };
> @@ -1531,7 +1525,6 @@ static const struct amdgpu_asic_funcs vi_asic_fun=
cs =3D
>  	.read_disabled_bios =3D &vi_read_disabled_bios,
>  	.read_bios_from_rom =3D &vi_read_bios_from_rom,
>  	.detect_hw_virtualization =3D vi_detect_hw_virtualization,
> -	.detect_sriov_bios =3D vi_detect_sriov_bios,
>  	.read_register =3D &vi_read_register,
>  	.reset =3D &vi_asic_reset,
>  	.set_vga_state =3D &vi_vga_set_state,
>=20


--1bMNCF7jVPS00vbVaOoRM5mX5lrgLQf2j--

--r4BSjhGDMl3UVdBn3qLdfWd4ultm3dujN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX4HWIAAoJEP4bvbfZuWjbpj0QAKDV8Mvq9uWNRNM1mG39+tos
afodvpSrrOBicL+M6A7Bo6U0H08TJYIvbzKHeSLVNYrxtwptGL7mscFr/YX50n2d
Qf/VWmmCXDAevg+NZsVemiJT/kYZf/Iv9FiYuZEemkJMveLk3hW430gxIulpUNN6
j6l7mxEdhh86J64CGnR87l0HU7naqOsRk7RWQ9LiUJqBTyAXByWTTLm42BZCMd2C
a6yjNAKw8MRzQpQleEN9tlFYQ77qa+Q+gq4Kv4YnfQNuOJPCWJ3185c5MX3KiaQa
8DcCHaQ/3yVkPZj0nnsK9P+xOMbqLtfVAtgCS8pwOgy9j1gqy1U+iu/oDyFbKq62
BBzt3G0EF3V4iD0uyUPSBeXls6EIWIRv1cG9llTJ7YbNt1cqu4yn7ZR8Z3iTKeRD
c67jtlfR8AffwFjC+mMHayBOgiDFlYVDs9H23NzxAgZvsIYDmmcpLuudB4rL/ZEl
qRPGRotjWHq0wEzQxWuuZN2Cexi2rmxMWnf8rSa9TGxOOXbwEAzlhWfLuS9UO5l6
bSrScA0gRA7Bj571yuozmChIyKwvhiCINyhgYLf8/JGZcr2x2KrrfwE1dtKutrYo
RWOO6GOOlR2kfnkKL1VjkD5yqHpW0kZ2nk2MVVPqQZDjMTVVX2F/mm4W41JWAdPh
GuBGCD72bPwqGXXbXSRf
=rhg1
-----END PGP SIGNATURE-----

--r4BSjhGDMl3UVdBn3qLdfWd4ultm3dujN--

--===============1073982541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1073982541==--
