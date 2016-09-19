From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu:changes of virtualization cases probe (v2)
Date: Tue, 20 Sep 2016 09:38:09 +1000
Message-ID: <4f22a78d-7205-0dbf-c00d-65916e307ecd@folklore1984.net>
References: <1474305161-11435-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2129666458=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474305161-11435-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2129666458==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UBFdEd2vglBm5BxbTiuaptaJ9aoDMLXGQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UBFdEd2vglBm5BxbTiuaptaJ9aoDMLXGQ
Content-Type: multipart/mixed; boundary="lVNkXrspfWJ63CFQV0OUmJuBtNaLCsOTi";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Message-ID: <4f22a78d-7205-0dbf-c00d-65916e307ecd-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amdgpu:changes of virtualization cases probe (v2)
References: <1474305161-11435-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1474305161-11435-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--lVNkXrspfWJ63CFQV0OUmJuBtNaLCsOTi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/20/2016 03:12 AM, Alex Deucher wrote:
> From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>=20
> 1,Changes on virtualization detections
> 2,Don't load smu & mc firmware if using sr-iov bios
> 3,skip vPost for sriov & force vPost if dev pass-through
>=20
> v2: agd: fix missed SI case
>=20
> Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 38 ++++++++++++++++++++++=
+-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/cik.c           |  7 ------
>  drivers/gpu/drm/amd/amdgpu/fiji_smc.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/iceland_smc.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/si.c            |  7 ------
>  drivers/gpu/drm/amd/amdgpu/tonga_smc.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vi.c            | 36 ++++++++++++++++++----=
------
>  10 files changed, 74 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index ee45d9f..ff6e683 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1827,6 +1827,8 @@ struct amdgpu_asic_funcs {
>  	bool (*read_disabled_bios)(struct amdgpu_device *adev);
>  	bool (*read_bios_from_rom)(struct amdgpu_device *adev,
>  				   u8 *bios, u32 length_bytes);
> +	void (*detect_hw_virtualization) (struct amdgpu_device *adev);
> +	void (*detect_sriov_bios)(struct amdgpu_device *adev);
>  	int (*read_register)(struct amdgpu_device *adev, u32 se_num,
>  			     u32 sh_num, u32 reg_offset, u32 *value);
>  	void (*set_vga_state)(struct amdgpu_device *adev, bool state);
> @@ -1836,8 +1838,6 @@ struct amdgpu_asic_funcs {
>  	/* MM block clocks */
>  	int (*set_uvd_clocks)(struct amdgpu_device *adev, u32 vclk, u32 dclk)=
;
>  	int (*set_vce_clocks)(struct amdgpu_device *adev, u32 evclk, u32 eccl=
k);
> -	/* query virtual capabilities */
> -	u32 (*get_virtual_caps)(struct amdgpu_device *adev);
>  	/* static power management */
>  	int (*get_pcie_lanes)(struct amdgpu_device *adev);
>  	void (*set_pcie_lanes)(struct amdgpu_device *adev, int lanes);
> @@ -1934,15 +1934,36 @@ struct cgs_device *amdgpu_cgs_create_device(str=
uct amdgpu_device *adev);
>  void amdgpu_cgs_destroy_device(struct cgs_device *cgs_device);
> =20
> =20
> +#define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is sr-iov rea=
dy */
> +#define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is enabled o=
n this GPU */
> +#define AMDGPU_SRIOV_CAPS_IS_VF        (1 << 2) /* this GPU is a virtu=
al function */
> +#define AMDGPU_PASSTHROUGH_MODE        (1 << 3) /* thw whole GPU is pa=
ss through for VM */
>  /* GPU virtualization */
> -#define AMDGPU_VIRT_CAPS_SRIOV_EN       (1 << 0)
> -#define AMDGPU_VIRT_CAPS_IS_VF          (1 << 1)
>  struct amdgpu_virtualization {
> -	bool supports_sr_iov;
> -	bool is_virtual;
> -	u32 caps;
> +	uint32_t virtual_caps;
>  };
> =20
> +#define amdgpu_sriov_enabled(adev) \
> +((adev)->virtualization.virtual_caps & AMDGPU_SRIOV_CAPS_ENABLE_IOV)
> +
> +#define amdgpu_sriov_vf(adev) \
> +((adev)->virtualization.virtual_caps & AMDGPU_SRIOV_CAPS_IS_VF)
> +
> +#define amdgpu_sriov_bios(adev) \
> +((adev)->virtualization.virtual_caps & AMDGPU_SRIOV_CAPS_SRIOV_VBIOS)
> +
> +#define amdgpu_passthrough(adev) \
> +((adev)->virtualization.virtual_caps & AMDGPU_PASSTHROUGH_MODE)
> +
> +static inline bool is_virtual_machine(void)
> +{
> +#ifdef CONFIG_X86
> +	return boot_cpu_has(X86_FEATURE_HYPERVISOR);
> +#else
> +	return false;
> +#endif
> +}
> +
>  /*
>   * Core structure, functions and helpers.
>   */
> @@ -2260,12 +2281,13 @@ amdgpu_get_sdma_instance(struct amdgpu_ring *ri=
ng)
>  #define amdgpu_asic_get_xclk(adev) (adev)->asic_funcs->get_xclk((adev)=
)
>  #define amdgpu_asic_set_uvd_clocks(adev, v, d) (adev)->asic_funcs->set=
_uvd_clocks((adev), (v), (d))
>  #define amdgpu_asic_set_vce_clocks(adev, ev, ec) (adev)->asic_funcs->s=
et_vce_clocks((adev), (ev), (ec))
> -#define amdgpu_asic_get_virtual_caps(adev) ((adev)->asic_funcs->get_vi=
rtual_caps((adev)))
>  #define amdgpu_get_pcie_lanes(adev) (adev)->asic_funcs->get_pcie_lanes=
((adev))
>  #define amdgpu_set_pcie_lanes(adev, l) (adev)->asic_funcs->set_pcie_la=
nes((adev), (l))
>  #define amdgpu_asic_get_gpu_clock_counter(adev) (adev)->asic_funcs->ge=
t_gpu_clock_counter((adev))
>  #define amdgpu_asic_read_disabled_bios(adev) (adev)->asic_funcs->read_=
disabled_bios((adev))
>  #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs-=
>read_bios_from_rom((adev), (b), (l))
> +#define amdgpu_asic_detect_hw_virtualization(adev) (adev)->asic_funcs-=
>detect_hw_virtualization((adev))
> +#define amdgpu_asic_detect_sriov_bios(adev) (adev)->asic_funcs->detect=
_sriov_bios((adev))
>  #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asi=
c_funcs->read_register((adev), (se), (sh), (offset), (v)))
>  #define amdgpu_gart_flush_gpu_tlb(adev, vmid) (adev)->gart.gart_funcs-=
>flush_gpu_tlb((adev), (vmid))
>  #define amdgpu_gart_set_pte_pde(adev, pt, idx, addr, flags) (adev)->ga=
rt.gart_funcs->set_pte_pde((adev), (pt), (idx), (addr), (flags))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index 377d818..2df5f00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -110,7 +110,7 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uin=
t32_t reg, uint32_t v,
>  		    bool always_indirect)
>  {
>  	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
> -=09
> +
>  	if ((reg * 4) < adev->rmmio_size && !always_indirect)
>  		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>  	else {
> @@ -1648,25 +1648,26 @@ int amdgpu_device_init(struct amdgpu_device *ad=
ev,
>  		goto failed;
>  	}
> =20
> -	/* See if the asic supports SR-IOV */
> -	adev->virtualization.supports_sr_iov =3D
> -		amdgpu_atombios_has_gpu_virtualization_table(adev);
> -
> -	/* Check if we are executing in a virtualized environment */
> -	adev->virtualization.is_virtual =3D amdgpu_device_is_virtual();
> -	adev->virtualization.caps =3D amdgpu_asic_get_virtual_caps(adev);
> +	/* detect if we are with an SRIOV vbios */
> +	if (adev->asic_funcs->detect_sriov_bios)
> +		amdgpu_asic_detect_sriov_bios(adev);
> =20
>  	/* Post card if necessary */
> -	if (!amdgpu_card_posted(adev) ||
> -	    (adev->virtualization.is_virtual &&
> -	     !(adev->virtualization.caps & AMDGPU_VIRT_CAPS_SRIOV_EN))) {
> +	if (!amdgpu_sriov_vf(adev) &&
> +		(!amdgpu_card_posted(adev) || amdgpu_passthrough(adev))) {
>  		if (!adev->bios) {
>  			dev_err(adev->dev, "Card not posted and no BIOS - ignoring\n");
>  			r =3D -EINVAL;
>  			goto failed;
>  		}
>  		DRM_INFO("GPU not posted. posting now...\n");
> -		amdgpu_atom_asic_init(adev->mode_info.atom_context);
> +		r =3D amdgpu_atom_asic_init(adev->mode_info.atom_context);
> +		if (r) {
> +			dev_err(adev->dev, "gpu post error!\n");
> +			goto failed;
> +		}
> +	} else {
> +		DRM_INFO("GPU post is not needed\n");
>  	}
> =20
>  	/* Initialize clocks */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> index c96ae10..0c5f36d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -485,7 +485,7 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>  	/* if we are running in a VM, make sure the device
>  	 * torn down properly on reboot/shutdown
>  	 */
> -	if (adev->virtualization.is_virtual)
> +	if (amdgpu_passthrough(adev))
>  		amdgpu_pci_remove(pdev);
>  }
> =20
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amd=
gpu/cik.c
> index 825de80..e61fdee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -963,12 +963,6 @@ static bool cik_read_bios_from_rom(struct amdgpu_d=
evice *adev,
>  	return true;
>  }
> =20
> -static u32 cik_get_virtual_caps(struct amdgpu_device *adev)
> -{
> -	/* CIK does not support SR-IOV */
> -	return 0;
> -}
> -
>  static const struct amdgpu_allowed_register_entry cik_allowed_read_reg=
isters[] =3D {
>  	{mmGRBM_STATUS, false},
>  	{mmGB_ADDR_CONFIG, false},
> @@ -2390,7 +2384,6 @@ static const struct amdgpu_asic_funcs cik_asic_fu=
ncs =3D
>  	.get_xclk =3D &cik_get_xclk,
>  	.set_uvd_clocks =3D &cik_set_uvd_clocks,
>  	.set_vce_clocks =3D &cik_set_vce_clocks,
> -	.get_virtual_caps =3D &cik_get_virtual_caps,
>  };
> =20
>  static int cik_common_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/fiji_smc.c b/drivers/gpu/drm/am=
d/amdgpu/fiji_smc.c
> index b3e19ba..8cfb0a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/fiji_smc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/fiji_smc.c
> @@ -275,7 +275,7 @@ static int fiji_smu_upload_firmware_image(struct am=
dgpu_device *adev)
>  	/* Skip SMC ucode loading on SR-IOV capable boards.
>  	 * vbios does this for us in asic_init in that case.
>  	 */
> -	if (adev->virtualization.supports_sr_iov)
> +	if (amdgpu_sriov_bios(adev))
>  		return 0;
> =20
>  	hdr =3D (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v8_0.c
> index 8e7127f..6ec8e01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -261,8 +261,10 @@ static int gmc_v8_0_mc_load_microcode(struct amdgp=
u_device *adev)
> =20
>  	/* Skip MC ucode loading on SR-IOV capable boards.
>  	 * vbios does this for us in asic_init in that case.
> +	 * Skip MC ucode loading on VF, because hypervisor will do that
> +	 * for this adaptor.
>  	 */
> -	if (adev->virtualization.supports_sr_iov)
> +	if (amdgpu_sriov_bios(adev))
>  		return 0;
> =20
>  	hdr =3D (const struct mc_firmware_header_v1_0 *)adev->mc.fw->data;
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_smc.c b/drivers/gpu/drm=
/amd/amdgpu/iceland_smc.c
> index ef7c27d..c6e004a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_smc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_smc.c
> @@ -282,7 +282,7 @@ static int iceland_smu_upload_firmware_image(struct=
 amdgpu_device *adev)
>  	/* Skip SMC ucode loading on SR-IOV capable boards.
>  	 * vbios does this for us in asic_init in that case.
>  	 */
> -	if (adev->virtualization.supports_sr_iov)
> +	if (amdgpu_sriov_bios(adev))
>  		return 0;
> =20
>  	hdr =3D (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdg=
pu/si.c
> index fee76b8..a0b6b7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -952,12 +952,6 @@ static void si_smc_wreg(struct amdgpu_device *adev=
, u32 reg, u32 v)
>  	spin_unlock_irqrestore(&adev->smc_idx_lock, flags);
>  }
> =20
> -static u32 si_get_virtual_caps(struct amdgpu_device *adev)
> -{
> -	/* SI does not support SR-IOV */
> -	return 0;
> -}
> -
>  static struct amdgpu_allowed_register_entry si_allowed_read_registers[=
] =3D {
>  	{GRBM_STATUS, false},
>  	{GB_ADDR_CONFIG, false},
> @@ -1133,7 +1127,6 @@ static const struct amdgpu_asic_funcs si_asic_fun=
cs =3D
>  	.get_xclk =3D &si_get_xclk,
>  	.set_uvd_clocks =3D &si_set_uvd_clocks,
>  	.set_vce_clocks =3D NULL,
> -	.get_virtual_caps =3D &si_get_virtual_caps,
>  };
> =20
>  static uint32_t si_get_rev_id(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_smc.c b/drivers/gpu/drm/a=
md/amdgpu/tonga_smc.c
> index 940de18..1e71e81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_smc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_smc.c
> @@ -275,7 +275,7 @@ static int tonga_smu_upload_firmware_image(struct a=
mdgpu_device *adev)
>  	/* Skip SMC ucode loading on SR-IOV capable boards.
>  	 * vbios does this for us in asic_init in that case.
>  	 */
> -	if (adev->virtualization.supports_sr_iov)
> +	if (amdgpu_sriov_bios(adev))
>  		return 0;
> =20
>  	hdr =3D (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> index b688e2f..5141393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -445,18 +445,25 @@ static bool vi_read_bios_from_rom(struct amdgpu_d=
evice *adev,
>  	return true;
>  }
> =20
> -static u32 vi_get_virtual_caps(struct amdgpu_device *adev)
> -{
> -	u32 caps =3D 0;
> -	u32 reg =3D RREG32(mmBIF_IOV_FUNC_IDENTIFIER);
> -
> -	if (REG_GET_FIELD(reg, BIF_IOV_FUNC_IDENTIFIER, IOV_ENABLE))
> -		caps |=3D AMDGPU_VIRT_CAPS_SRIOV_EN;
> -
> -	if (REG_GET_FIELD(reg, BIF_IOV_FUNC_IDENTIFIER, FUNC_IDENTIFIER))
> -		caps |=3D AMDGPU_VIRT_CAPS_IS_VF;
> +static void vi_detect_hw_virtualization(struct amdgpu_device *adev) {
> +	uint32_t reg =3D RREG32(mmBIF_IOV_FUNC_IDENTIFIER);
> +	/* bit0: 0 means pf and 1 means vf */
> +	/* bit31: 0 means disable IOV and 1 means enable */
> +	if (reg & 1)
> +		adev->virtualization.virtual_caps |=3D AMDGPU_SRIOV_CAPS_IS_VF;
> +
> +	if (reg & 0x80000000)
> +		adev->virtualization.virtual_caps |=3D AMDGPU_SRIOV_CAPS_ENABLE_IOV;=

> +
> +	if (reg =3D=3D 0) {
> +		if (is_virtual_machine()) /* passthrough mode exclus sr-iov mode */
> +			adev->virtualization.virtual_caps |=3D AMDGPU_PASSTHROUGH_MODE;
> +	}
> +}
> =20
> -	return caps;
> +static void vi_detect_sriov_bios(struct amdgpu_device *adev) {
> +	if (amdgpu_atombios_has_gpu_virtualization_table(adev))
> +		adev->virtualization.virtual_caps |=3D AMDGPU_SRIOV_CAPS_SRIOV_VBIOS=
;
>  }
> =20
>  static const struct amdgpu_allowed_register_entry tonga_allowed_read_r=
egisters[] =3D {
> @@ -1521,13 +1528,14 @@ static const struct amdgpu_asic_funcs vi_asic_f=
uncs =3D
>  {
>  	.read_disabled_bios =3D &vi_read_disabled_bios,
>  	.read_bios_from_rom =3D &vi_read_bios_from_rom,
> +	.detect_hw_virtualization =3D vi_detect_hw_virtualization,
> +	.detect_sriov_bios =3D vi_detect_sriov_bios,

Why add it here and remove it later? Can these two sets be squashed
together?

>  	.read_register =3D &vi_read_register,
>  	.reset =3D &vi_asic_reset,
>  	.set_vga_state =3D &vi_vga_set_state,
>  	.get_xclk =3D &vi_get_xclk,
>  	.set_uvd_clocks =3D &vi_set_uvd_clocks,
>  	.set_vce_clocks =3D &vi_set_vce_clocks,
> -	.get_virtual_caps =3D &vi_get_virtual_caps,
>  };
> =20
>  static int vi_common_early_init(void *handle)
> @@ -1657,6 +1665,10 @@ static int vi_common_early_init(void *handle)
>  		return -EINVAL;
>  	}
> =20
> +	/* in early init stage, vbios code won't work */
> +	if (adev->asic_funcs->detect_hw_virtualization)
> +		amdgpu_asic_detect_hw_virtualization(adev);
> +
>  	if (amdgpu_smc_load_fw && smc_enabled)
>  		adev->firmware.smu_load =3D true;
> =20
>=20


--lVNkXrspfWJ63CFQV0OUmJuBtNaLCsOTi--

--UBFdEd2vglBm5BxbTiuaptaJ9aoDMLXGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX4HbhAAoJEP4bvbfZuWjbgwcP+wVCx+EUrXjIsAjAAoR9kiHo
3vqJHHzdkcb4R6kTE9E28XHkTnwYUbd1clxLA05xjv79V5Mp+3ugujh0ZndcDkKJ
5jHKcGaOEb7KY2wzxUWBr4HECORaEgoMxRnNbOhvB0Fd+tB141nti3rfJrYsgVit
1rszNccbZ44PuRSHHFRPIWGOlmA1tTymFvKx7VcKhafUehswhL9abhR858+/CXhR
l/72q/kRt6Lg9otIXgDssh7cNBUKbZws9F1zGbAeFLTw2Y6WCBToAZXCyoxdFBpL
jhkE/2DZflT+zGneN1YbrO0wxub5sKq0EvopKAPpqyiJ/CVOYmcQ5XEX95OYl/Vz
Our3volUZ/Hmj+nAO67NXuAobtf5lLhmRqMAP/FMyv7oqc/VpIoTeNI0JTYFpxRY
RWdJuHNfJFHg1wYKuUeG4IOK+nStxKVByhUehD4i0IHSodRAaIm6SGr9Oe4IYAiP
6i+jhtr9Q0U/fIDi2lWhZGzji2kz1JySNjvid08DIjZsVCQFJKK3QRyEv8IgBSU4
BcYR+aOvv2kC7E8VLnOYtKP84+cjadVTVayH9paP9NNJYtlouC9WjebxXJ1Lq1yV
jYaQLr5tmFflQ4Ai35yg9jCKn3kDjQA36bbFq69Tx0xqTto8CxMEvkv8eB6udrno
VNo94WQXorWu8UXS1kKF
=tF3W
-----END PGP SIGNATURE-----

--UBFdEd2vglBm5BxbTiuaptaJ9aoDMLXGQ--

--===============2129666458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2129666458==--
