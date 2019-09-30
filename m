From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/6] drm/amdkfd: Use array to probe kfd2kgd_calls
Date: Mon, 30 Sep 2019 18:04:36 +0000
Message-ID: <DM6PR12MB2778A4D093E06270A918BF09F0820@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20190928034132.28340-1-Yong.Zhao@amd.com>
 <20190928034132.28340-4-Yong.Zhao@amd.com>,
 <39dcbd3e-1bb9-8729-6368-0e87fdfcdbd3@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1145087799=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <39dcbd3e-1bb9-8729-6368-0e87fdfcdbd3-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1145087799==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2778A4D093E06270A918BF09F0820DM6PR12MB2778namp_"

--_000_DM6PR12MB2778A4D093E06270A918BF09F0820DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks. Will check that and fix the missing const.

Yong
________________________________
From: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 30, 2019 11:42 AM
To: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH 4/6] drm/amdkfd: Use array to probe kfd2kgd_calls

On 2019-09-27 11:41 p.m., Zhao, Yong wrote:
> This is the same idea as the kfd device info probe and move all the
> probe control together for easy maintenance.
>
> Change-Id: I85c98bb08eb2a4a1a80c3b913c32691cc74602d1
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>

Nice clean-up. See one comment inline.

Also, please check that this doesn't break the build if CONFIG_HSA_AMD
is undefined.

With that fixed and checked, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 65 +------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  7 --
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  8 +--
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  7 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  7 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  7 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  7 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 39 +++++++++--
>   8 files changed, 41 insertions(+), 106 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 92666b197f6c..8c531793fe17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -63,47 +63,10 @@ void amdgpu_amdkfd_fini(void)
>
>   void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
>   {
> -     const struct kfd2kgd_calls *kfd2kgd;
>        bool vf =3D amdgpu_sriov_vf(adev);
>
> -     switch (adev->asic_type) {
> -#ifdef CONFIG_DRM_AMDGPU_CIK
> -     case CHIP_KAVERI:
> -     case CHIP_HAWAII:
> -             kfd2kgd =3D amdgpu_amdkfd_gfx_7_get_functions();
> -             break;
> -#endif
> -     case CHIP_CARRIZO:
> -     case CHIP_TONGA:
> -     case CHIP_FIJI:
> -     case CHIP_POLARIS10:
> -     case CHIP_POLARIS11:
> -     case CHIP_POLARIS12:
> -     case CHIP_VEGAM:
> -             kfd2kgd =3D amdgpu_amdkfd_gfx_8_0_get_functions();
> -             break;
> -     case CHIP_VEGA10:
> -     case CHIP_VEGA12:
> -     case CHIP_VEGA20:
> -     case CHIP_RAVEN:
> -     case CHIP_RENOIR:
> -             kfd2kgd =3D amdgpu_amdkfd_gfx_9_0_get_functions();
> -             break;
> -     case CHIP_ARCTURUS:
> -             kfd2kgd =3D amdgpu_amdkfd_arcturus_get_functions();
> -             break;
> -     case CHIP_NAVI10:
> -     case CHIP_NAVI14:
> -     case CHIP_NAVI12:
> -             kfd2kgd =3D amdgpu_amdkfd_gfx_10_0_get_functions();
> -             break;
> -     default:
> -             dev_info(adev->dev, "kfd not supported on this ASIC\n");
> -             return;
> -     }
> -
>        adev->kfd.dev =3D kgd2kfd_probe((struct kgd_dev *)adev,
> -                                   adev->pdev, kfd2kgd, adev->asic_type,=
 vf);
> +                                   adev->pdev, adev->asic_type, vf);
>
>        if (adev->kfd.dev)
>                amdgpu_amdkfd_total_mem_size +=3D adev->gmc.real_vram_size=
;
> @@ -711,33 +674,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,=
 struct mm_struct *mm)
>        return 0;
>   }
>
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_7_get_functions(void)
> -{
> -     return NULL;
> -}
> -
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_8_0_get_functions(void)
> -{
> -     return NULL;
> -}
> -
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_9_0_get_functions(void)
> -{
> -     return NULL;
> -}
> -
> -struct kfd2kgd_calls *amdgpu_amdkfd_arcturus_get_functions(void)
> -{
> -     return NULL;
> -}
> -
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_10_0_get_functions(void)
> -{
> -     return NULL;
> -}
> -
>   struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev=
,
> -                           const struct kfd2kgd_calls *f2g,
>                              unsigned int asic_type, bool vf)
>   {
>        return NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.h
> index 4eb2fb85de26..069d5d230810 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -137,12 +137,6 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enu=
m kgd_engine_type engine,
>   void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle);
>   bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd);
>
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_7_get_functions(void);
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_8_0_get_functions(void);
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_9_0_get_functions(void);
> -struct kfd2kgd_calls *amdgpu_amdkfd_arcturus_get_functions(void);
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_10_0_get_functions(void);
> -
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>
>   int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
> @@ -248,7 +242,6 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdg=
pu_bo *bo);
>   int kgd2kfd_init(void);
>   void kgd2kfd_exit(void);
>   struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev=
,
> -                           const struct kfd2kgd_calls *f2g,
>                              unsigned int asic_type, bool vf);
>   bool kgd2kfd_device_init(struct kfd_dev *kfd,
>                         struct drm_device *ddev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 4a49dbee26a1..e1fbbebce4fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -262,7 +262,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev *kgd, =
void *mqd,
>        return 0;
>   }
>
> -static const struct kfd2kgd_calls kfd2kgd =3D {
> +const struct kfd2kgd_calls arcturus_kfd2kgd =3D {
>        .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
>        .set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
>        .init_interrupts =3D kgd_gfx_v9_init_interrupts,
> @@ -286,9 +286,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D {
>        .invalidate_tlbs_vmid =3D kgd_gfx_v9_invalidate_tlbs_vmid,
>        .get_hive_id =3D amdgpu_amdkfd_get_hive_id,
>   };
> -
> -struct kfd2kgd_calls *amdgpu_amdkfd_arcturus_get_functions(void)
> -{
> -     return (struct kfd2kgd_calls *)&kfd2kgd;
> -}
> -
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index be9b873ec683..a01704bc91cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -815,7 +815,7 @@ static void set_vm_context_page_table_base(struct kgd=
_dev *kgd, uint32_t vmid,
>        gfxhub_v2_0_setup_vm_pt_regs(adev, vmid, page_table_base);
>   }
>
> -static const struct kfd2kgd_calls kfd2kgd =3D {
> +struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {

This should be const. Can you fix that too while you're here?


>        .program_sh_mem_settings =3D kgd_program_sh_mem_settings,
>        .set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping,
>        .init_interrupts =3D kgd_init_interrupts,
> @@ -839,8 +839,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D {
>        .invalidate_tlbs_vmid =3D invalidate_tlbs_vmid,
>        .get_hive_id =3D amdgpu_amdkfd_get_hive_id,
>   };
> -
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_10_0_get_functions()
> -{
> -     return (struct kfd2kgd_calls *)&kfd2kgd;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 9c4ebcadad62..0b9cc6515e64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -751,7 +751,7 @@ static uint32_t read_vmid_from_vmfault_reg(struct kgd=
_dev *kgd)
>        return REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS, =
VMID);
>   }
>
> -static const struct kfd2kgd_calls kfd2kgd =3D {
> +const struct kfd2kgd_calls gfx_v7_kfd2kgd =3D {
>        .program_sh_mem_settings =3D kgd_program_sh_mem_settings,
>        .set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping,
>        .init_interrupts =3D kgd_init_interrupts,
> @@ -775,8 +775,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D {
>        .invalidate_tlbs_vmid =3D invalidate_tlbs_vmid,
>        .read_vmid_from_vmfault_reg =3D read_vmid_from_vmfault_reg,
>   };
> -
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_7_get_functions(void)
> -{
> -     return (struct kfd2kgd_calls *)&kfd2kgd;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index f2e52b496044..3416a7f27dc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -696,7 +696,7 @@ static int invalidate_tlbs_vmid(struct kgd_dev *kgd, =
uint16_t vmid)
>        return 0;
>   }
>
> -static const struct kfd2kgd_calls kfd2kgd =3D {
> +const struct kfd2kgd_calls gfx_v8_kfd2kgd =3D {
>        .program_sh_mem_settings =3D kgd_program_sh_mem_settings,
>        .set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping,
>        .init_interrupts =3D kgd_init_interrupts,
> @@ -720,8 +720,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D {
>        .invalidate_tlbs =3D invalidate_tlbs,
>        .invalidate_tlbs_vmid =3D invalidate_tlbs_vmid,
>   };
> -
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_8_0_get_functions(void)
> -{
> -     return (struct kfd2kgd_calls *)&kfd2kgd;
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 12f30df2174c..82ed9316b096 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -786,7 +786,7 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct=
 kgd_dev *kgd, uint32_t vmi
>        gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
>   }
>
> -static const struct kfd2kgd_calls kfd2kgd =3D {
> +const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
>        .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
>        .set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
>        .init_interrupts =3D kgd_gfx_v9_init_interrupts,
> @@ -810,8 +810,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D {
>        .invalidate_tlbs_vmid =3D kgd_gfx_v9_invalidate_tlbs_vmid,
>        .get_hive_id =3D amdgpu_amdkfd_get_hive_id,
>   };
> -
> -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_9_0_get_functions(void)
> -{
> -     return (struct kfd2kgd_calls *)&kfd2kgd;
> -}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 96a9e0653db2..0db273587af4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -39,6 +39,35 @@
>    */
>   static atomic_t kfd_locked =3D ATOMIC_INIT(0);
>
> +extern const struct kfd2kgd_calls gfx_v7_kfd2kgd;
> +extern const struct kfd2kgd_calls gfx_v8_kfd2kgd;
> +extern const struct kfd2kgd_calls gfx_v9_kfd2kgd;
> +extern const struct kfd2kgd_calls arcturus_kfd2kgd;
> +extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
> +
> +static const struct kfd2kgd_calls *kfd2kgd_funcs[] =3D {
> +#ifdef KFD_SUPPORT_IOMMU_V2
> +     [CHIP_KAVERI] =3D &gfx_v7_kfd2kgd,
> +     [CHIP_CARRIZO] =3D &gfx_v8_kfd2kgd,
> +     [CHIP_RAVEN] =3D &gfx_v9_kfd2kgd,
> +#endif
> +     [CHIP_HAWAII] =3D &gfx_v7_kfd2kgd,
> +     [CHIP_TONGA] =3D &gfx_v8_kfd2kgd,
> +     [CHIP_FIJI] =3D &gfx_v8_kfd2kgd,
> +     [CHIP_POLARIS10] =3D &gfx_v8_kfd2kgd,
> +     [CHIP_POLARIS11] =3D &gfx_v8_kfd2kgd,
> +     [CHIP_POLARIS12] =3D &gfx_v8_kfd2kgd,
> +     [CHIP_VEGAM] =3D &gfx_v8_kfd2kgd,
> +     [CHIP_VEGA10] =3D &gfx_v9_kfd2kgd,
> +     [CHIP_VEGA12] =3D &gfx_v9_kfd2kgd,
> +     [CHIP_VEGA20] =3D &gfx_v9_kfd2kgd,
> +     [CHIP_RENOIR] =3D &gfx_v9_kfd2kgd,
> +     [CHIP_ARCTURUS] =3D &arcturus_kfd2kgd,
> +     [CHIP_NAVI10] =3D &gfx_v10_kfd2kgd,
> +     [CHIP_NAVI12] =3D &gfx_v10_kfd2kgd,
> +     [CHIP_NAVI14] =3D &gfx_v10_kfd2kgd,
> +};
> +
>   #ifdef KFD_SUPPORT_IOMMU_V2
>   static const struct kfd_device_info kaveri_device_info =3D {
>        .asic_family =3D CHIP_KAVERI,
> @@ -454,20 +483,22 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>   static int kfd_resume(struct kfd_dev *kfd);
>
>   struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
> -     struct pci_dev *pdev, const struct kfd2kgd_calls *f2g,
> -     unsigned int asic_type, bool vf)
> +     struct pci_dev *pdev, unsigned int asic_type, bool vf)
>   {
>        struct kfd_dev *kfd;
>        const struct kfd_device_info *device_info;
> +     const struct kfd2kgd_calls *f2g;
>
> -     if (asic_type >=3D sizeof(kfd_supported_devices) / (sizeof(void *) =
* 2)) {
> +     if (asic_type >=3D sizeof(kfd_supported_devices) / (sizeof(void *) =
* 2)
> +             || asic_type >=3D sizeof(kfd2kgd_funcs) / sizeof(void *)) {
>                dev_err(kfd_device, "asic_type %d out of range\n", asic_ty=
pe);
>                return NULL; /* asic_type out of range */
>        }
>
>        device_info =3D kfd_supported_devices[asic_type][vf];
> +     f2g =3D kfd2kgd_funcs[asic_type];
>
> -     if (!device_info) {
> +     if (!device_info && !f2g) {
>                dev_err(kfd_device, "%s %s not supported in kfd\n",
>                        amdgpu_asic_name[asic_type], vf ? "VF" : "");
>                return NULL;

--_000_DM6PR12MB2778A4D093E06270A918BF09F0820DM6PR12MB2778namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks. Will check that and fix the missing const.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, September 30, 2019 11:42 AM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 4/6] drm/amdkfd: Use array to probe kfd2kgd_call=
s</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-09-27 11:41 p.m., Zhao, Yong wrote:<br>
&gt; This is the same idea as the kfd device info probe and move all the<br=
>
&gt; probe control together for easy maintenance.<br>
&gt;<br>
&gt; Change-Id: I85c98bb08eb2a4a1a80c3b913c32691cc74602d1<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Nice clean-up. See one comment inline.<br>
<br>
Also, please check that this doesn't break the build if CONFIG_HSA_AMD <br>
is undefined.<br>
<br>
With that fixed and checked, this patch is<br>
<br>
Reviewed-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbs=
p; | 65 &#43;------------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbs=
p; |&nbsp; 7 --<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c&nbsp;&nbsp; |&=
nbsp; 8 &#43;--<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c&nbsp;&nbsp;&nbs=
p; |&nbsp; 7 &#43;-<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |&nbsp; 7 &#=
43;-<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |&nbsp; 7 &#=
43;-<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |&nbsp; 7 &#=
43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 39 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; 8 files changed, 41 insertions(&#43;), 106 deletions(-)<br=
>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; index 92666b197f6c..8c531793fe17 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; @@ -63,47 &#43;63,10 @@ void amdgpu_amdkfd_fini(void)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev=
)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd2kgd_calls *kfd2kgd;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vf =3D amdgpu_sriov_vf(=
adev);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&gt; -#ifdef CONFIG_DRM_AMDGPU_CIK<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_KAVERI:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_HAWAII:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd2kgd =3D amdgpu_amdkfd_gfx_7_get_functions();<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -#endif<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TONGA:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_FIJI:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS10:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS11:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS12:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGAM:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd2kgd =3D amdgpu_amdkfd_gfx_8_0_get_functions();<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA10:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA12:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd2kgd =3D amdgpu_amdkfd_gfx_9_0_get_functions();<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd2kgd =3D amdgpu_amdkfd_arcturus_get_functions();<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfd2kgd =3D amdgpu_amdkfd_gfx_10_0_get_functions();<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_info(adev-&gt;dev, &quot;kfd not supported on this ASIC\n&quot;);<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;kfd.dev =3D kgd2kfd=
_probe((struct kgd_dev *)adev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pdev,=
 kfd2kgd, adev-&gt;asic_type, vf);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;p=
dev, adev-&gt;asic_type, vf);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;kfd.dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_total_mem_size &#43;=3D adev-&gt;gmc.real=
_vram_size;<br>
&gt; @@ -711,33 &#43;674,7 @@ int amdgpu_amdkfd_evict_userptr(struct kgd_me=
m *mem, struct mm_struct *mm)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_7_get_functions(void)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; -}<br>
&gt; -<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_8_0_get_functions(void)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; -}<br>
&gt; -<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_9_0_get_functions(void)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; -}<br>
&gt; -<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_arcturus_get_functions(void)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; -}<br>
&gt; -<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_10_0_get_functions(void)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp;&nbsp; struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct =
pci_dev *pdev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; const struct kfd2kgd_calls *f2g,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int asic_type, bool vf)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; index 4eb2fb85de26..069d5d230810 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&gt; @@ -137,12 &#43;137,6 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *k=
gd, enum kgd_engine_type engine,<br>
&gt;&nbsp;&nbsp; void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, b=
ool idle);<br>
&gt;&nbsp;&nbsp; bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kg=
d);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_7_get_functions(void);<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_8_0_get_functions(void);<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_9_0_get_functions(void);<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_arcturus_get_functions(void);<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_10_0_get_functions(void);<br>
&gt; -<br>
&gt;&nbsp;&nbsp; bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev,=
 u32 vmid);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);<b=
r>
&gt; @@ -248,7 &#43;242,6 @@ void amdgpu_amdkfd_unreserve_memory_limit(stru=
ct amdgpu_bo *bo);<br>
&gt;&nbsp;&nbsp; int kgd2kfd_init(void);<br>
&gt;&nbsp;&nbsp; void kgd2kfd_exit(void);<br>
&gt;&nbsp;&nbsp; struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct =
pci_dev *pdev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; const struct kfd2kgd_calls *f2g,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int asic_type, bool vf);<br>
&gt;&nbsp;&nbsp; bool kgd2kfd_device_init(struct kfd_dev *kfd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct drm_device *ddev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; index 4a49dbee26a1..e1fbbebce4fd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<=
br>
&gt; @@ -262,7 &#43;262,7 @@ static int kgd_hqd_sdma_destroy(struct kgd_dev=
 *kgd, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static const struct kfd2kgd_calls kfd2kgd =3D {<br>
&gt; &#43;const struct kfd2kgd_calls arcturus_kfd2kgd =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_sh_mem_settings =3D=
 kgd_gfx_v9_program_sh_mem_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pasid_vmid_mapping =3D =
kgd_gfx_v9_set_pasid_vmid_mapping,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_interrupts =3D kgd_gfx=
_v9_init_interrupts,<br>
&gt; @@ -286,9 &#43;286,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .invalidate_tlbs_vmid =3D kg=
d_gfx_v9_invalidate_tlbs_vmid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hive_id =3D amdgpu_amdk=
fd_get_hive_id,<br>
&gt;&nbsp;&nbsp; };<br>
&gt; -<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_arcturus_get_functions(void)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return (struct kfd2kgd_calls *)&amp;kfd2kgd;=
<br>
&gt; -}<br>
&gt; -<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&gt; index be9b873ec683..a01704bc91cd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<b=
r>
&gt; @@ -815,7 &#43;815,7 @@ static void set_vm_context_page_table_base(str=
uct kgd_dev *kgd, uint32_t vmid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v2_0_setup_vm_pt_regs=
(adev, vmid, page_table_base);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static const struct kfd2kgd_calls kfd2kgd =3D {<br>
&gt; &#43;struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {<br>
<br>
This should be const. Can you fix that too while you're here?<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_sh_mem_settings =3D=
 kgd_program_sh_mem_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pasid_vmid_mapping =3D =
kgd_set_pasid_vmid_mapping,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_interrupts =3D kgd_ini=
t_interrupts,<br>
&gt; @@ -839,8 &#43;839,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .invalidate_tlbs_vmid =3D in=
validate_tlbs_vmid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hive_id =3D amdgpu_amdk=
fd_get_hive_id,<br>
&gt;&nbsp;&nbsp; };<br>
&gt; -<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_10_0_get_functions()<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return (struct kfd2kgd_calls *)&amp;kfd2kgd;=
<br>
&gt; -}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&gt; index 9c4ebcadad62..0b9cc6515e64 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br=
>
&gt; @@ -751,7 &#43;751,7 @@ static uint32_t read_vmid_from_vmfault_reg(str=
uct kgd_dev *kgd)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return REG_GET_FIELD(status,=
 VM_CONTEXT1_PROTECTION_FAULT_STATUS, VMID);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static const struct kfd2kgd_calls kfd2kgd =3D {<br>
&gt; &#43;const struct kfd2kgd_calls gfx_v7_kfd2kgd =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_sh_mem_settings =3D=
 kgd_program_sh_mem_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pasid_vmid_mapping =3D =
kgd_set_pasid_vmid_mapping,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_interrupts =3D kgd_ini=
t_interrupts,<br>
&gt; @@ -775,8 &#43;775,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .invalidate_tlbs_vmid =3D in=
validate_tlbs_vmid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_vmid_from_vmfault_reg =
=3D read_vmid_from_vmfault_reg,<br>
&gt;&nbsp;&nbsp; };<br>
&gt; -<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_7_get_functions(void)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return (struct kfd2kgd_calls *)&amp;kfd2kgd;=
<br>
&gt; -}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&gt; index f2e52b496044..3416a7f27dc7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br=
>
&gt; @@ -696,7 &#43;696,7 @@ static int invalidate_tlbs_vmid(struct kgd_dev=
 *kgd, uint16_t vmid)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static const struct kfd2kgd_calls kfd2kgd =3D {<br>
&gt; &#43;const struct kfd2kgd_calls gfx_v8_kfd2kgd =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_sh_mem_settings =3D=
 kgd_program_sh_mem_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pasid_vmid_mapping =3D =
kgd_set_pasid_vmid_mapping,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_interrupts =3D kgd_ini=
t_interrupts,<br>
&gt; @@ -720,8 &#43;720,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .invalidate_tlbs =3D invalid=
ate_tlbs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .invalidate_tlbs_vmid =3D in=
validate_tlbs_vmid,<br>
&gt;&nbsp;&nbsp; };<br>
&gt; -<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_8_0_get_functions(void)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return (struct kfd2kgd_calls *)&amp;kfd2kgd;=
<br>
&gt; -}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; index 12f30df2174c..82ed9316b096 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br=
>
&gt; @@ -786,7 &#43;786,7 @@ void kgd_gfx_v9_set_vm_context_page_table_base=
(struct kgd_dev *kgd, uint32_t vmi<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhub_v1_0_setup_vm_pt_regs=
(adev, vmid, page_table_base);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -static const struct kfd2kgd_calls kfd2kgd =3D {<br>
&gt; &#43;const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .program_sh_mem_settings =3D=
 kgd_gfx_v9_program_sh_mem_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pasid_vmid_mapping =3D =
kgd_gfx_v9_set_pasid_vmid_mapping,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_interrupts =3D kgd_gfx=
_v9_init_interrupts,<br>
&gt; @@ -810,8 &#43;810,3 @@ static const struct kfd2kgd_calls kfd2kgd =3D =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .invalidate_tlbs_vmid =3D kg=
d_gfx_v9_invalidate_tlbs_vmid,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hive_id =3D amdgpu_amdk=
fd_get_hive_id,<br>
&gt;&nbsp;&nbsp; };<br>
&gt; -<br>
&gt; -struct kfd2kgd_calls *amdgpu_amdkfd_gfx_9_0_get_functions(void)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return (struct kfd2kgd_calls *)&amp;kfd2kgd;=
<br>
&gt; -}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_device.c<br>
&gt; index 96a9e0653db2..0db273587af4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; @@ -39,6 &#43;39,35 @@<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; static atomic_t kfd_locked =3D ATOMIC_INIT(0);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;extern const struct kfd2kgd_calls gfx_v7_kfd2kgd;<br>
&gt; &#43;extern const struct kfd2kgd_calls gfx_v8_kfd2kgd;<br>
&gt; &#43;extern const struct kfd2kgd_calls gfx_v9_kfd2kgd;<br>
&gt; &#43;extern const struct kfd2kgd_calls arcturus_kfd2kgd;<br>
&gt; &#43;extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;<br>
&gt; &#43;<br>
&gt; &#43;static const struct kfd2kgd_calls *kfd2kgd_funcs[] =3D {<br>
&gt; &#43;#ifdef KFD_SUPPORT_IOMMU_V2<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_KAVERI] =3D &amp;gfx_v7_kfd2kgd,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_CARRIZO] =3D &amp;gfx_v8_kfd2kgd,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_RAVEN] =3D &amp;gfx_v9_kfd2kgd,<br=
>
&gt; &#43;#endif<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_HAWAII] =3D &amp;gfx_v7_kfd2kgd,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_TONGA] =3D &amp;gfx_v8_kfd2kgd,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_FIJI] =3D &amp;gfx_v8_kfd2kgd,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_POLARIS10] =3D &amp;gfx_v8_kfd2kgd=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_POLARIS11] =3D &amp;gfx_v8_kfd2kgd=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_POLARIS12] =3D &amp;gfx_v8_kfd2kgd=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_VEGAM] =3D &amp;gfx_v8_kfd2kgd,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_VEGA10] =3D &amp;gfx_v9_kfd2kgd,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_VEGA12] =3D &amp;gfx_v9_kfd2kgd,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_VEGA20] =3D &amp;gfx_v9_kfd2kgd,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_RENOIR] =3D &amp;gfx_v9_kfd2kgd,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_ARCTURUS] =3D &amp;arcturus_kfd2kg=
d,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_NAVI10] =3D &amp;gfx_v10_kfd2kgd,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_NAVI12] =3D &amp;gfx_v10_kfd2kgd,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; [CHIP_NAVI14] =3D &amp;gfx_v10_kfd2kgd,<=
br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; #ifdef KFD_SUPPORT_IOMMU_V2<br>
&gt;&nbsp;&nbsp; static const struct kfd_device_info kaveri_device_info =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asic_family =3D CHIP_KAVERI=
,<br>
&gt; @@ -454,20 &#43;483,22 @@ static void kfd_gtt_sa_fini(struct kfd_dev *=
kfd);<br>
&gt;&nbsp;&nbsp; static int kfd_resume(struct kfd_dev *kfd);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *pdev, const struct kfd2kgd_c=
alls *f2g,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned int asic_type, bool vf)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_dev *pdev, unsigned int asic_=
type, bool vf)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd_device_info=
 *device_info;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; const struct kfd2kgd_calls *f2g;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (asic_type &gt;=3D sizeof(kfd_supported_d=
evices) / (sizeof(void *) * 2)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_type &gt;=3D sizeof(kfd_support=
ed_devices) / (sizeof(void *) * 2)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; || asic_type &gt;=3D sizeof(kfd2kgd_funcs) / sizeof(void *)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_err(kfd_device, &quot;asic_type %d out of range\n&q=
uot;, asic_type);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL; /* asic_type out of range */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_info =3D kfd_supporte=
d_devices[asic_type][vf];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; f2g =3D kfd2kgd_funcs[asic_type];<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!device_info) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!device_info &amp;&amp; !f2g) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_err(kfd_device, &quot;%s %s not supported in kfd\n&=
quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
asic_name[asic_type], vf ? &quot;VF&quot; : &quot;&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB2778A4D093E06270A918BF09F0820DM6PR12MB2778namp_--

--===============1145087799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1145087799==--
