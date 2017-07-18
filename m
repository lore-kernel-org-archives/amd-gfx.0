From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: read reg in each iterate of psp_wait_for loop
Date: Tue, 18 Jul 2017 03:25:45 +0000
Message-ID: <BN6PR12MB16520B2CDC16A66FA2592028F7A10@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1500346464-8132-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1500346464-8132-1-git-send-email-Jerry.Zhang@amd.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Zhang, Jerry" <Jerry.Zhang@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

> -----Original Message-----
> From: Junwei Zhang [mailto:Jerry.Zhang@amd.com]
> Sent: Monday, July 17, 2017 10:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander; Huang, Ray; gregkh@linuxfoundation.org; Zhang,
> Jerry; stable@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: read reg in each iterate of psp_wait_for loo=
p
>=20
> From: "Zhang, Jerry" <Jerry.Zhang@amd.com>
>=20
> v2: fixes the SOS loading failure for PSP v3.1
>=20
> Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com>
> Cc: stable@vger.kernel.org
> Acked-by: Alex Deucher <alexander.deucher@amd.com> (v1)
> Acked-by: Huang Rui <ray.huang@amd.com> (v1)

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
>  drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 2 --
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c919579..644941d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -98,9 +98,8 @@ int psp_wait_for(struct psp_context *psp, uint32_t
> reg_index,
>  	int i;
>  	struct amdgpu_device *adev =3D psp->adev;
>=20
> -	val =3D RREG32(reg_index);
> -
>  	for (i =3D 0; i < adev->usec_timeout; i++) {
> +		val =3D RREG32(reg_index);
>  		if (check_changed) {
>  			if (val !=3D reg_val)
>  				return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> index 2718e86..23106e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> @@ -237,11 +237,9 @@ int psp_v3_1_bootloader_load_sos(struct
> psp_context *psp)
>=20
>  	/* there might be handshake issue with hardware which needs delay
> */
>  	mdelay(20);
> -#if 0
>  	ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_81),
>  			   RREG32_SOC15(MP0, 0,
> mmMP0_SMN_C2PMSG_81),
>  			   0, true);
> -#endif
>=20
>  	return ret;
>  }
> --
> 1.9.1
