From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Read vram width from integrated system
 info table
Date: Mon, 3 Apr 2017 17:20:23 +0200
Message-ID: <8623a5d4-1e10-fc46-aaa2-0777b500c3a2@dev.carbon-project.org>
References: <20170403150107.13253-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0973836569=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170403150107.13253-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0973836569==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4Jh0w8xo4VD56woRqUIesBHsmujIH1Bab"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Jh0w8xo4VD56woRqUIesBHsmujIH1Bab
Content-Type: multipart/mixed; boundary="gaQPS6WfFJ8rwilucrRkXCjMsGDI8SXUV";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>,
 amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <8623a5d4-1e10-fc46-aaa2-0777b500c3a2-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Read vram width from integrated system
 info table
References: <20170403150107.13253-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170403150107.13253-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>

--gaQPS6WfFJ8rwilucrRkXCjMsGDI8SXUV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Harry,
Harry Wentland wrote on 03.04.2017 17:01:
> On KB, KV, CZ we should read the vram width from integrated system
> table, if we can. The NOOFCHAN in MC_SHARED_CHMAP is not accurate.
>=20
> With this change we can enable two 4k displays on CZ again. This use
> case was broken sometime in January when we started looking at
> vram_width for bandwidth calculations instead of hardcoding this value.=

>=20
> v2:
>   Return 0 if integrated system info table is not available.
>=20
> Tested-by: Roman Li <roman.li-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 29 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c        | 87 +++++++++++++++-----=
--------
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c        | 87 +++++++++++++++-----=
--------
>  4 files changed, 123 insertions(+), 82 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atombios.c
> index f52b1bf3d3d9..ad4329922f79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -754,6 +754,35 @@ union igp_info {
>  	struct _ATOM_INTEGRATED_SYSTEM_INFO_V1_9 info_9;
>  };
> =20
> +/*
> + * Return vram width from integrated system info table, if available,
> + * or 0 if not.
> + */
> +int amdgpu_atombios_get_vram_width(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_mode_info *mode_info =3D &adev->mode_info;
> +	int index =3D GetIndexIntoMasterTable(DATA, IntegratedSystemInfo);
> +	u16 data_offset, size;
> +	union igp_info *igp_info;
> +	u8 frev, crev;
> +
> +	/* get any igp specific overrides */
> +	if (amdgpu_atom_parse_data_header(mode_info->atom_context, index, &si=
ze,
> +				   &frev, &crev, &data_offset)) {
> +		igp_info =3D (union igp_info *)
> +			(mode_info->atom_context->bios + data_offset);
> +		switch (crev) {
> +		case 8:
> +		case 9:
> +			return igp_info->info_8.ucUMAChannelNumber * 64;
> +		default:
> +			return 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void amdgpu_atombios_get_igp_ss_overrides(struct amdgpu_device =
*adev,
>  						 struct amdgpu_atom_ss *ss,
>  						 int id)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atombios.h
> index 4e0f488487f3..38d0fe32e5cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> @@ -148,6 +148,8 @@ int amdgpu_atombios_get_clock_info(struct amdgpu_de=
vice *adev);
> =20
>  int amdgpu_atombios_get_gfx_info(struct amdgpu_device *adev);
> =20
> +int amdgpu_atombios_get_vram_width(struct amdgpu_device *adev);
> +
>  bool amdgpu_atombios_get_asic_ss_info(struct amdgpu_device *adev,
>  				      struct amdgpu_atom_ss *ss,
>  				      int id, u32 clock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v7_0.c
> index 0c0a6015cca5..78643a1baa5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -37,6 +37,8 @@
>  #include "oss/oss_2_0_d.h"
>  #include "oss/oss_2_0_sh_mask.h"
> =20
> +#include "amdgpu_atombios.h"
> +
>  static void gmc_v7_0_set_gart_funcs(struct amdgpu_device *adev);
>  static void gmc_v7_0_set_irq_funcs(struct amdgpu_device *adev);
>  static int gmc_v7_0_wait_for_idle(void *handle);
> @@ -325,48 +327,51 @@ static void gmc_v7_0_mc_program(struct amdgpu_dev=
ice *adev)
>   */
>  static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
>  {
> -	u32 tmp;
> -	int chansize, numchan;
> -
> -	/* Get VRAM informations */
> -	tmp =3D RREG32(mmMC_ARB_RAMCFG);
> -	if (REG_GET_FIELD(tmp, MC_ARB_RAMCFG, CHANSIZE)) {
> -		chansize =3D 64;
> -	} else {
> -		chansize =3D 32;
> -	}
> -	tmp =3D RREG32(mmMC_SHARED_CHMAP);
> -	switch (REG_GET_FIELD(tmp, MC_SHARED_CHMAP, NOOFCHAN)) {
> -	case 0:
> -	default:
> -		numchan =3D 1;
> -		break;
> -	case 1:
> -		numchan =3D 2;
> -		break;
> -	case 2:
> -		numchan =3D 4;
> -		break;
> -	case 3:
> -		numchan =3D 8;
> -		break;
> -	case 4:
> -		numchan =3D 3;
> -		break;
> -	case 5:
> -		numchan =3D 6;
> -		break;
> -	case 6:
> -		numchan =3D 10;
> -		break;
> -	case 7:
> -		numchan =3D 12;
> -		break;
> -	case 8:
> -		numchan =3D 16;
> -		break;
> +	adev->mc.vram_width =3D amdgpu_atombios_get_vram_width(adev);
> +	if (!adev->mc.vram_width) {
> +		u32 tmp;
> +		int chansize, numchan;
> +
> +		/* Get VRAM informations */
> +		tmp =3D RREG32(mmMC_ARB_RAMCFG);
> +		if (REG_GET_FIELD(tmp, MC_ARB_RAMCFG, CHANSIZE)) {
> +			chansize =3D 64;
> +		} else {
> +			chansize =3D 32;
> +		}
> +		tmp =3D RREG32(mmMC_SHARED_CHMAP);
> +		switch (REG_GET_FIELD(tmp, MC_SHARED_CHMAP, NOOFCHAN)) {
> +		case 0:
> +		default:
> +			numchan =3D 1;
> +			break;
> +		case 1:
> +			numchan =3D 2;
> +			break;
> +		case 2:
> +			numchan =3D 4;
> +			break;
> +		case 3:
> +			numchan =3D 8;
> +			break;
> +		case 4:
> +			numchan =3D 3;
> +			break;
> +		case 5:
> +			numchan =3D 6;
> +			break;
> +		case 6:
> +			numchan =3D 10;
> +			break;
> +		case 7:
> +			numchan =3D 12;
> +			break;
> +		case 8:
> +			numchan =3D 16;
> +			break;
> +		}
> +		adev->mc.vram_width =3D numchan * chansize;
>  	}
> -	adev->mc.vram_width =3D numchan * chansize;
>  	/* Could aper size report 0 ? */
>  	adev->mc.aper_base =3D pci_resource_start(adev->pdev, 0);
>  	adev->mc.aper_size =3D pci_resource_len(adev->pdev, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v8_0.c
> index d19d1c5e2847..42b2f357a799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -38,6 +38,8 @@
>  #include "vid.h"
>  #include "vi.h"
> =20
> +#include "amdgpu_atombios.h"
> +
> =20
>  static void gmc_v8_0_set_gart_funcs(struct amdgpu_device *adev);
>  static void gmc_v8_0_set_irq_funcs(struct amdgpu_device *adev);
> @@ -487,48 +489,51 @@ static void gmc_v8_0_mc_program(struct amdgpu_dev=
ice *adev)
>   */
>  static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>  {
> -	u32 tmp;
> -	int chansize, numchan;
> -
> -	/* Get VRAM informations */
> -	tmp =3D RREG32(mmMC_ARB_RAMCFG);
> -	if (REG_GET_FIELD(tmp, MC_ARB_RAMCFG, CHANSIZE)) {
> -		chansize =3D 64;
> -	} else {
> -		chansize =3D 32;
> -	}
> -	tmp =3D RREG32(mmMC_SHARED_CHMAP);
> -	switch (REG_GET_FIELD(tmp, MC_SHARED_CHMAP, NOOFCHAN)) {
> -	case 0:
> -	default:
> -		numchan =3D 1;
> -		break;
> -	case 1:
> -		numchan =3D 2;
> -		break;
> -	case 2:
> -		numchan =3D 4;
> -		break;
> -	case 3:
> -		numchan =3D 8;
> -		break;
> -	case 4:
> -		numchan =3D 3;
> -		break;
> -	case 5:
> -		numchan =3D 6;
> -		break;
> -	case 6:
> -		numchan =3D 10;
> -		break;
> -	case 7:
> -		numchan =3D 12;
> -		break;
> -	case 8:
> -		numchan =3D 16;
> -		break;
> +	adev->mc.vram_width =3D amdgpu_atombios_get_vram_width(adev);
> +	if (!adev->mc.vram_width) {
> +		u32 tmp;
> +		int chansize, numchan;
> +
> +		/* Get VRAM informations */
> +		tmp =3D RREG32(mmMC_ARB_RAMCFG);
> +		if (REG_GET_FIELD(tmp, MC_ARB_RAMCFG, CHANSIZE)) {
> +			chansize =3D 64;
> +		} else {
> +			chansize =3D 32;
> +		}
> +		tmp =3D RREG32(mmMC_SHARED_CHMAP);
> +		switch (REG_GET_FIELD(tmp, MC_SHARED_CHMAP, NOOFCHAN)) {
> +		case 0:
> +		default:
> +			numchan =3D 1;
> +			break;
> +		case 1:
> +			numchan =3D 2;
> +			break;
> +		case 2:
> +			numchan =3D 4;
> +			break;
> +		case 3:
> +			numchan =3D 8;
> +			break;
> +		case 4:
> +			numchan =3D 3;
> +			break;
> +		case 5:
> +			numchan =3D 6;
> +			break;
> +		case 6:
> +			numchan =3D 10;
> +			break;
> +		case 7:
> +			numchan =3D 12;
> +			break;
> +		case 8:
> +			numchan =3D 16;
> +			break;
> +		}
> +		adev->mc.vram_width =3D numchan * chansize;

I might miss something subtle here, but after reading this a couple of ti=
mes,
I've convinced myself this is exactly the same switch statement as in
gmc_v7_0_mc_init() above, right? If so: why not move that part to common =
code as
well?

Cheers,
Kai


>  	}
> -	adev->mc.vram_width =3D numchan * chansize;
>  	/* Could aper size report 0 ? */
>  	adev->mc.aper_base =3D pci_resource_start(adev->pdev, 0);
>  	adev->mc.aper_size =3D pci_resource_len(adev->pdev, 0);



--gaQPS6WfFJ8rwilucrRkXCjMsGDI8SXUV--

--4Jh0w8xo4VD56woRqUIesBHsmujIH1Bab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAljiaEAACgkQownXbOHe
WdLceQv/ftXrxJohtenOa0IIktXhW3RAqUHYAv7oVpEht2pmm39EjDqOF0Yuy1mY
FHlK9AHZoJdbBuYENat5KhSx7+hXgLbgfWQAjVJbMy29JA/kCygABgp6a7LYl/An
pgDbf2LQAMNlWj7Jc7yAgmDJlJwn1l+HO81DWOVxNV6ON0r0qxLU/+AiOmIhkalg
RdDKruOPqC8tQsepCpw4JmQqAok+NpH8rtUVLcwwBFYAOT0jAfQ1K/8dxKX6qWNr
bdTqLSdoLcEz54dOhS5eAvglmkEW+8d/tGCdXJqCNuziKv8N1sZVa/tSS2opC/K0
QqLpL1fNgv/OEOS+V3UWv1b1oENYADuNFxy3tDbZV9yhcnY27e3oDD5mx0/PGBmi
qXBiUJ34dipBo7jO23rwuZwKUKaR7clCblG3iouATYtBku1OISv4LZNgyVWiobR0
WR3NHksHOApo2u4o4p7zVF9/OR306GovLxOFkLc2Soj3uDYj17YK5/H/pz059rrY
1zj5aa/6
=kYUh
-----END PGP SIGNATURE-----

--4Jh0w8xo4VD56woRqUIesBHsmujIH1Bab--

--===============0973836569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0973836569==--
