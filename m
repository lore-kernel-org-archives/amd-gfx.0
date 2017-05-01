From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: CZ EDC param and support
Date: Mon, 1 May 2017 16:40:23 +0200
Message-ID: <502f7d5e-431c-b39a-1281-dbe3b710a75e@vodafone.de>
References: <BN6PR12MB1889CED9632BAE0144E8AE1795100@BN6PR12MB1889.namprd12.prod.outlook.com>
 <40321e5a-36c5-6e07-8176-bcd596e7e982@amd.com>
 <BN6PR12MB1889C8C94B10AA6E3DF6BD6495130@BN6PR12MB1889.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1594865264=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1889C8C94B10AA6E3DF6BD6495130-/b2+HYfkarQsUGYmqVGGPAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Panariti, David" <David.Panariti-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, gpudriverdevsupport <gpudriverdevsupport-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1594865264==
Content-Type: multipart/alternative;
 boundary="------------BAD694D9BAC5B4F07A0FE11C"

This is a multi-part message in MIME format.
--------------BAD694D9BAC5B4F07A0FE11C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> I’ve gotten a comment that inline patches are preferred.
>
Well, they are. But you should send them with "git send-email" and not 
squashed together all in one mail :)

Otherwise I can't see how we should be able to apply them.

Additional to that at least I'm perfectly fine with attached patches as 
well.

Christian.

Am 28.04.2017 um 16:18 schrieb Panariti, David:
>
> Actually, the attachment was an oversight.
>
> It’s easier for me to attach, open the attachment and then delete the 
> attachment.
>
> I got only 2/3 this time.
>
> I’ve gotten a comment that inline patches are preferred.
>
> Sorry for the inconvenience.
>
> davep
>
> *From:*Koenig, Christian
> *Sent:* Friday, April 28, 2017 4:06 AM
> *To:* Panariti, David <David.Panariti-5C7GfCeVMHo@public.gmane.org>; gpudriverdevsupport 
> <gpudriverdevsupport-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: CZ EDC param and support
>
> You somehow messed up the attachment.
>
> Instead of individual files everything is squashed together as 
> all-edc.patch.
>
> Please fix that otherwise proper review won't be possible.
>
> Christian.
>
> Am 28.04.2017 um 00:13 schrieb Panariti, David:
>
>     The changes in the workarounds function use DRM_INFO rather than
>     DRM_DEBUG because CZs with EDC are often used in embedded
>     environments and any info can be useful especially in the case of
>     an intermittent problem.
>
>     From e1ce383592c275b58ad95bd80b5479af8c1f9dae Mon Sep 17 00:00:00 2001
>
>     From: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
>     <mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org>
>
>     Date: Fri, 14 Apr 2017 13:41:52 -0400
>
>     Subject: [PATCH 1/3] drm/amdgpu: Moved gfx_v8_0_select_se_sh() in
>     lieu of
>
>     re-redundant prototype.
>
>     Will be needed for the rest of the EDC workarounds patch.
>
>     Change-Id: Ie586ab38a69e98a91c6cb5747e285ce8bfdd1c86
>
>     Signed-off-by: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
>     <mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org>
>
>     ---
>
>     drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 46
>     +++++++++++++++++------------------
>
>     1 file changed, 23 insertions(+), 23 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>
>     index 2ff5f19..27b57cb 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>
>     @@ -1500,6 +1500,29 @@ static int gfx_v8_0_kiq_init(struct
>     amdgpu_device *adev)
>
>                    return 0;
>
>     }
>
>     +static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
>
>     +   u32 se_num, u32 sh_num, u32 instance)
>
>     +{
>
>     +             u32 data;
>
>     +
>
>     +             if (instance == 0xffffffff)
>
>     +                             data = REG_SET_FIELD(0,
>     GRBM_GFX_INDEX, INSTANCE_BROADCAST_WRITES, 1);
>
>     +             else
>
>     +                             data = REG_SET_FIELD(0,
>     GRBM_GFX_INDEX, INSTANCE_INDEX, instance);
>
>     +
>
>     +             if (se_num == 0xffffffff)
>
>     +                             data = REG_SET_FIELD(data,
>     GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
>
>     +             else
>
>     +                             data = REG_SET_FIELD(data,
>     GRBM_GFX_INDEX, SE_INDEX, se_num);
>
>     +
>
>     +             if (sh_num == 0xffffffff)
>
>     +                             data = REG_SET_FIELD(data,
>     GRBM_GFX_INDEX, SH_BROADCAST_WRITES, 1);
>
>     +             else
>
>     +                             data = REG_SET_FIELD(data,
>     GRBM_GFX_INDEX, SH_INDEX, sh_num);
>
>     +
>
>     +             WREG32(mmGRBM_GFX_INDEX, data);
>
>     +}
>
>     +
>
>     static const u32 vgpr_init_compute_shader[] =
>
>     {
>
>                    0x7e000209, 0x7e020208,
>
>     @@ -3556,29 +3579,6 @@ static void
>     gfx_v8_0_tiling_mode_table_init(struct amdgpu_device *adev)
>
>                    }
>
>     }
>
>     -static void gfx_v8_0_select_se_sh(struct amdgpu_device *adev,
>
>     -   u32 se_num, u32 sh_num, u32 instance)
>
>     -{
>
>     -              u32 data;
>
>     -
>
>     -              if (instance == 0xffffffff)
>
>     -                              data = REG_SET_FIELD(0,
>     GRBM_GFX_INDEX, INSTANCE_BROADCAST_WRITES, 1);
>
>     -              else
>
>     -                              data = REG_SET_FIELD(0,
>     GRBM_GFX_INDEX, INSTANCE_INDEX, instance);
>
>     -
>
>     -              if (se_num == 0xffffffff)
>
>     -                              data = REG_SET_FIELD(data,
>     GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1);
>
>     -              else
>
>     -                              data = REG_SET_FIELD(data,
>     GRBM_GFX_INDEX, SE_INDEX, se_num);
>
>     -
>
>     -              if (sh_num == 0xffffffff)
>
>     -                              data = REG_SET_FIELD(data,
>     GRBM_GFX_INDEX, SH_BROADCAST_WRITES, 1);
>
>     -              else
>
>     -                              data = REG_SET_FIELD(data,
>     GRBM_GFX_INDEX, SH_INDEX, sh_num);
>
>     -
>
>     -              WREG32(mmGRBM_GFX_INDEX, data);
>
>     -}
>
>     -
>
>     static u32 gfx_v8_0_create_bitmask(u32 bit_width)
>
>     {
>
>                    return (u32)((1ULL << bit_width) - 1);
>
>     -- 
>
>     2.7.4
>
>     From 38fac8cab73dbc07e0ee7599b52106bc09dd32ea Mon Sep 17 00:00:00 2001
>
>     From: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
>     <mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org>
>
>     Date: Mon, 24 Apr 2017 11:05:45 -0400
>
>     Subject: [PATCH 2/3] drm/amdgpu: Complete Carrizo EDC (Error
>     Detection and
>
>     Correction) workarounds.
>
>     The workarounds are unconditionally performed on CZs with EDC enabled.
>
>     EDC detects uncorrected ECC errors and uses data poisoning to prevent
>
>     corrupted compute results from being used (read).
>
>     EDC enabled CZs are often used in embedded environments.
>
>     Change-Id: I84c261785329beeb797f11efbe0ec35790f2996c
>
>     Signed-off-by: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
>     <mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org>
>
>     ---
>
>     drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 148
>     ++++++++++++++++++++++++----------
>
>     1 file changed, 106 insertions(+), 42 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>
>     index 27b57cb..2f5bf5f 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>
>     @@ -1645,35 +1645,92 @@ static const u32 sgpr2_init_regs[] =
>
>                    mmCOMPUTE_USER_DATA_9, 0xedcedc09,
>
>     };
>
>     -static const u32 sec_ded_counter_registers[] =
>
>     -{
>
>     -              mmCPC_EDC_ATC_CNT,
>
>     -              mmCPC_EDC_SCRATCH_CNT,
>
>     -              mmCPC_EDC_UCODE_CNT,
>
>     -              mmCPF_EDC_ATC_CNT,
>
>     -              mmCPF_EDC_ROQ_CNT,
>
>     -              mmCPF_EDC_TAG_CNT,
>
>     -              mmCPG_EDC_ATC_CNT,
>
>     -              mmCPG_EDC_DMA_CNT,
>
>     -              mmCPG_EDC_TAG_CNT,
>
>     -              mmDC_EDC_CSINVOC_CNT,
>
>     -              mmDC_EDC_RESTORE_CNT,
>
>     -              mmDC_EDC_STATE_CNT,
>
>     -              mmGDS_EDC_CNT,
>
>     -              mmGDS_EDC_GRBM_CNT,
>
>     -              mmGDS_EDC_OA_DED,
>
>     -              mmSPI_EDC_CNT,
>
>     - mmSQC_ATC_EDC_GATCL1_CNT,
>
>     -              mmSQC_EDC_CNT,
>
>     -              mmSQ_EDC_DED_CNT,
>
>     -              mmSQ_EDC_INFO,
>
>     -              mmSQ_EDC_SEC_CNT,
>
>     -              mmTCC_EDC_CNT,
>
>     - mmTCP_ATC_EDC_GATCL1_CNT,
>
>     -              mmTCP_EDC_CNT,
>
>     -              mmTD_EDC_CNT
>
>     +struct reg32_counter_name_map {
>
>     +             uint32_t rnmap_addr;   /* Counter register address */
>
>     +             const char *rnmap_name;           /* Name of the
>     counter */
>
>     +             size_t rnmap_num_instances;  /* Number of block
>     instances */
>
>     };
>
>     +#define DEF_mmREG32_NAME_MAP_ELEMENT(reg, num_instances)
>     {             \
>
>     +             .rnmap_addr = mm##reg, \
>
>     +             .rnmap_name = #reg, \
>
>     +             .rnmap_num_instances =
>     num_instances                                            \
>
>     +}
>
>     +
>
>     +/* See GRBM_GFX_INDEX, et. al. registers. */
>
>     +static const struct reg32_counter_name_map
>     sec_ded_counter_registers[] = {
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(SQC_EDC_CNT, 2),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(SQC_ATC_EDC_GATCL1_CNT, 2),
>
>     +
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(SQ_EDC_SEC_CNT, 8),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(SQ_EDC_DED_CNT, 8),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(TCP_EDC_CNT, 8),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(TCP_ATC_EDC_GATCL1_CNT, 8),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(TD_EDC_CNT, 8),
>
>     +
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(TCC_EDC_CNT, 4),
>
>     +
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_ATC_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_SCRATCH_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_UCODE_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_ATC_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_ROQ_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_TAG_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_ATC_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_DMA_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_TAG_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_CSINVOC_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_STATE_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_RESTORE_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(GDS_EDC_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(GDS_EDC_GRBM_CNT, 1),
>
>     + DEF_mmREG32_NAME_MAP_ELEMENT(SPI_EDC_CNT, 1),
>
>     +};
>
>     +
>
>     +static int gfx_v8_0_edc_clear_counters(struct amdgpu_device *adev)
>
>     +{
>
>     +             int ci, se, sh, i;
>
>     +             uint32_t count;
>
>     +             int r = 0;
>
>     +
>
>     + mutex_lock(&adev->grbm_idx_mutex);
>
>     +
>
>     +             for (ci = 0; ci <
>     ARRAY_SIZE(sec_ded_counter_registers); ++ci) {
>
>     +                             const struct reg32_counter_name_map
>     *cp =
>
>     + sec_ded_counter_registers + ci;
>
>     +                             const char *name = cp->rnmap_name;
>
>     +
>
>     +                             for (se = 0; se <
>     adev->gfx.config.max_shader_engines; ++se) {
>
>     + for (sh = 0; sh < adev->gfx.config.max_sh_per_se; ++sh) {
>
>     + for (i = 0; i < cp->rnmap_num_instances; ++i) {
>
>     + gfx_v8_0_select_se_sh(adev, se, sh, i);
>
>     + count = RREG32(cp->rnmap_addr);
>
>     + count = RREG32(cp->rnmap_addr);
>
>     + if (count != 0) {
>
>     + /*
>
>     + * Workaround failed.
>
>     + * If people are interested
>
>     + * in EDC at all, they will
>
>     + * want to know which
>
>     + * counters had problems.
>
>     + */
>
>     + DRM_WARN("EDC counter %s is 0x%08x, but should be 0\n.",
>
>     + name, count);
>
>     + r = -EINVAL;
>
>     + goto ret;
>
>     + }
>
>     + }
>
>     + }
>
>     +                             }
>
>     +             }
>
>     +
>
>     +ret:
>
>     + gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>
>     + mutex_unlock(&adev->grbm_idx_mutex);
>
>     +
>
>     +             return r;
>
>     +}
>
>     +
>
>     static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>
>     {
>
>                    struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
>
>     @@ -1681,18 +1738,36 @@ static int
>     gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>
>                    struct fence *f = NULL;
>
>                    int r, i;
>
>                    u32 tmp;
>
>     +             u32 dis_bit;
>
>                    unsigned total_size, vgpr_offset, sgpr_offset;
>
>                    u64 gpu_addr;
>
>     -              /* only supported on CZ */
>
>     -              if (adev->asic_type != CHIP_CARRIZO)
>
>     +             if (adev->asic_type != CHIP_CARRIZO) {
>
>     +                             /* EDC is only supported on CZ */
>
>     +                             return 0;
>
>     +             }
>
>     +
>
>     +        DRM_INFO("Detected Carrizo.\n");
>
>     +
>
>     +             tmp = RREG32(mmCC_GC_EDC_CONFIG);
>
>     +             dis_bit = REG_GET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_EDC);
>
>     +             if (dis_bit) {
>
>     +                             /* On Carrizo, EDC may be disabled
>     by a fuse. */
>
>     + DRM_INFO("EDC hardware is disabled, GC_EDC_CONFIG: 0x%08x.\n",
>
>     + tmp);
>
>                                    return 0;
>
>     +             }
>
>                     /* bail if the compute ring is not ready */
>
>                    if (!ring->ready)
>
>                                    return 0;
>
>     -              tmp = RREG32(mmGB_EDC_MODE);
>
>     +             DRM_INFO("Applying EDC workarounds.\n");
>
>     +
>
>     +             /*
>
>     +             * Interested parties can enable EDC using debugfs
>     register reads and
>
>     +             * writes.
>
>     +             */
>
>                    WREG32(mmGB_EDC_MODE, 0);
>
>                     total_size =
>
>     @@ -1817,18 +1892,7 @@ static int
>     gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>
>                                    goto fail;
>
>                    }
>
>     -              tmp = REG_SET_FIELD(tmp, GB_EDC_MODE, DED_MODE, 2);
>
>     -              tmp = REG_SET_FIELD(tmp, GB_EDC_MODE, PROP_FED, 1);
>
>     -              WREG32(mmGB_EDC_MODE, tmp);
>
>     -
>
>     -              tmp = RREG32(mmCC_GC_EDC_CONFIG);
>
>     -              tmp = REG_SET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_EDC,
>     0) | 1;
>
>     - WREG32(mmCC_GC_EDC_CONFIG, tmp);
>
>     -
>
>     -
>
>     -              /* read back registers to clear the counters */
>
>     -              for (i = 0; i <
>     ARRAY_SIZE(sec_ded_counter_registers); i++)
>
>     - RREG32(sec_ded_counter_registers[i]);
>
>     + gfx_v8_0_edc_clear_counters(adev);
>
>      fail:
>
>                    amdgpu_ib_free(adev, &ib, NULL);
>
>     -- 
>
>     2.7.4
>
>     From ec4803205582c1011f5ced1ead70ee244268b4b8 Mon Sep 17 00:00:00 2001
>
>     From: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
>     <mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org>
>
>     Date: Wed, 26 Apr 2017 10:13:06 -0400
>
>     Subject: [PATCH 3/3] drm/amdgpu: Add kernel parameter to control
>     use of
>
>     ECC/EDC.
>
>     Allow various kinds of memory integrity methods (e.g. ECC/EDC) to
>     be enabled
>
>     or disabled.  By default, all features are disabled.
>
>     EDC is Error Detection and Correction. It can detect ECC errors
>     and do 0 or
>
>     more of: count SEC (single error corrected) and DED (double error
>     detected,
>
>     i.e. uncorrected ECC error), halt the affected block, interrupt
>     the CPU.
>
>     Currently, only counting errors is supported.
>
>     Signed-off-by: David Panariti <David.Panariti-5C7GfCeVMHo@public.gmane.org>
>     <mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org>
>
>     ---
>
>     drivers/gpu/drm/amd/amdgpu/amdgpu.h |  1 +
>
>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 ++++
>
>     drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 34
>     +++++++++++++++++++++++++++-----
>
>     drivers/gpu/drm/amd/include/amd_shared.h | 14 +++++++++++++
>
>     4 files changed, 48 insertions(+), 5 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>     index 4a16e3c..0322392 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>
>     @@ -111,6 +111,7 @@ extern int amdgpu_prim_buf_per_se;
>
>     extern int amdgpu_pos_buf_per_se;
>
>     extern int amdgpu_cntl_sb_buf_per_se;
>
>     extern int amdgpu_param_buf_per_se;
>
>     +extern unsigned amdgpu_ecc_flags;
>
>      #define AMDGPU_DEFAULT_GTT_SIZE_MB                      3072ULL
>     /* 3GB by default */
>
>     #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS                   3000
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>
>     index ead00d7..00e16ac 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>
>     @@ -110,6 +110,7 @@ int amdgpu_prim_buf_per_se = 0;
>
>     int amdgpu_pos_buf_per_se = 0;
>
>     int amdgpu_cntl_sb_buf_per_se = 0;
>
>     int amdgpu_param_buf_per_se = 0;
>
>     +unsigned amdgpu_ecc_flags = 0;
>
>      MODULE_PARM_DESC(vramlimit, "Restrict VRAM for testing, in
>     megabytes");
>
>     module_param_named(vramlimit, amdgpu_vram_limit, int, 0600);
>
>     @@ -235,6 +236,9 @@ module_param_named(cntl_sb_buf_per_se,
>     amdgpu_cntl_sb_buf_per_se, int, 0444);
>
>     MODULE_PARM_DESC(param_buf_per_se, "the size of Off-Chip Pramater
>     Cache per Shader Engine (default depending on gfx)");
>
>     module_param_named(param_buf_per_se, amdgpu_param_buf_per_se, int,
>     0444);
>
>     +MODULE_PARM_DESC(ecc_flags, "ECC/EDC enable flags (0 = disable
>     ECC/EDC (default))");
>
>     +module_param_named(ecc_flags, amdgpu_ecc_flags, uint, 0444);
>
>     +
>
>      static const struct pci_device_id pciidlist[] = {
>
>     #ifdef  CONFIG_DRM_AMDGPU_SI
>
>     diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>     b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>
>     index 2f5bf5f..05cab7e 100644
>
>     --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>
>     +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>
>     @@ -1708,7 +1708,7 @@ static int
>     gfx_v8_0_edc_clear_counters(struct amdgpu_device *adev)
>
>     count = RREG32(cp->rnmap_addr);
>
>     if (count != 0) {
>
>     /*
>
>     - * Workaround failed.
>
>     + * EDC workaround failed.
>
>      * If people are interested
>
>      * in EDC at all, they will
>
>      * want to know which
>
>     @@ -1747,14 +1747,24 @@ static int
>     gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>
>                                    return 0;
>
>                    }
>
>     -        DRM_INFO("Detected Carrizo.\n");
>
>     +             DRM_INFO("Detected Carrizo.\n");
>
>                     tmp = RREG32(mmCC_GC_EDC_CONFIG);
>
>                    dis_bit = REG_GET_FIELD(tmp, CC_GC_EDC_CONFIG,
>     DIS_EDC);
>
>                    if (dis_bit) {
>
>     -                              /* On Carrizo, EDC may be disabled
>     by a fuse. */
>
>     - DRM_INFO("EDC hardware is disabled, GC_EDC_CONFIG: 0x%08x.\n",
>
>     - tmp);
>
>     +                             /* On Carrizo, EDC may be disabled
>     permanently by a fuse. */
>
>     + DRM_INFO("Carrizo EDC hardware is disabled, GC_EDC_CONFIG:
>     0x%08x.\n",
>
>     + tmp);
>
>     +                             return 0;
>
>     +             }
>
>     +
>
>     +             /*
>
>     +             * Check if EDC has been requested by a kernel parameter.
>
>     +             * For Carrizo, EDC is the best/safest mode WRT error
>     handling.
>
>     +             */
>
>     +             if (!(amdgpu_ecc_flags
>
>     +                   & (AMD_ECC_SUPPORT_BEST | AMD_ECC_SUPPORT_EDC))) {
>
>     + DRM_INFO("EDC support has not been requested.\n");
>
>                                    return 0;
>
>                    }
>
>     @@ -1892,6 +1902,20 @@ static int
>     gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
>
>                                    goto fail;
>
>                    }
>
>     +             /* 00 - GB_EDC_DED_MODE_LOG: Count DED errors but do
>     not halt */
>
>     +             tmp = REG_SET_FIELD(tmp, GB_EDC_MODE, DED_MODE, 0);
>
>     +             /* Do not propagate the errors to the next block. */
>
>     +             tmp = REG_SET_FIELD(tmp, GB_EDC_MODE, PROP_FED, 0);
>
>     +             WREG32(mmGB_EDC_MODE, tmp);
>
>     +
>
>     +             tmp = RREG32(mmCC_GC_EDC_CONFIG);
>
>     +
>
>     +             /*
>
>     +             * Clear EDC_DISABLE bit so the counters are available.
>
>     +             */
>
>     +             tmp = REG_SET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_EDC, 0);
>
>     + WREG32(mmCC_GC_EDC_CONFIG, tmp);
>
>     +
>
>     gfx_v8_0_edc_clear_counters(adev);
>
>      fail:
>
>     diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>     b/drivers/gpu/drm/amd/include/amd_shared.h
>
>     index 2ccf44e..c4fd013 100644
>
>     --- a/drivers/gpu/drm/amd/include/amd_shared.h
>
>     +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>
>     @@ -179,6 +179,20 @@ struct amd_pp_profile {
>
>     #define AMD_PG_SUPPORT_GFX_QUICK_MG (1 << 11)
>
>     #define AMD_PG_SUPPORT_GFX_PIPELINE                     (1 << 12)
>
>     +/*
>
>     + * ECC flags
>
>     + * Allows the user to choose what kind of error
>     detection/correction is used.
>
>     + * Currently, EDC is supported on Carrizo.
>
>     + *
>
>     + * The AMD_ECC_SUPPORT_BEST bit is used to allow a user to have
>     the driver
>
>     + * set what it thinks is best/safest mode.  This may not be the
>     same as the
>
>     + * default, depending on the GPU and the application.
>
>     + * Using a single bit makes it easy to request the best support
>     without
>
>     + * needing to know all currently supported modes.
>
>     + */
>
>     +#define AMD_ECC_SUPPORT_BEST (1 << 0)
>
>     +#define AMD_ECC_SUPPORT_EDC (1 << 1)
>
>     +
>
>     enum amd_pm_state_type {
>
>                    /* not used for dpm */
>
>     POWER_STATE_TYPE_DEFAULT,
>
>     -- 
>
>     2.7.4
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------BAD694D9BAC5B4F07A0FE11C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <p class="MsoNormal"><span style="color:#1F497D">I’ve gotten a
            comment that inline patches are preferred.<o:p></o:p></span></p>
        <span style="color:#1F497D"><o:p></o:p></span></blockquote>
      Well, they are. But you should send them with "git send-email" and
      not squashed together all in one mail :)<br>
      <br>
      Otherwise I can't see how we should be able to apply them.<br>
      <br>
      Additional to that at least I'm perfectly fine with attached
      patches as well.<br>
      <br>
      Christian.<br>
      <br>
      Am 28.04.2017 um 16:18 schrieb Panariti, David:<br>
    </div>
    <blockquote
cite="mid:BN6PR12MB1889C8C94B10AA6E3DF6BD6495130-/b2+HYfkarQsUGYmqVGGPAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="color:#1F497D">Actually, the
            attachment was an oversight.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D">It’s easier for
            me to attach, open the attachment and then delete the
            attachment.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D">I got only 2/3
            this time.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D">I’ve gotten a
            comment that inline patches are preferred.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D">Sorry for the
            inconvenience.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D">davep<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D"><o:p> </o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                  style="color:windowtext"> Koenig, Christian
                  <br>
                  <b>Sent:</b> Friday, April 28, 2017 4:06 AM<br>
                  <b>To:</b> Panariti, David
                  <a class="moz-txt-link-rfc2396E" href="mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org">&lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;</a>; gpudriverdevsupport
                  <a class="moz-txt-link-rfc2396E" href="mailto:gpudriverdevsupport-5C7GfCeVMHo@public.gmane.org">&lt;gpudriverdevsupport-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Re: CZ EDC param and support<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div>
            <p class="MsoNormal">You somehow messed up the attachment.<br>
              <br>
              Instead of individual files everything is squashed
              together as all-edc.patch.<br>
              <br>
              Please fix that otherwise proper review won't be possible.<br>
              <br>
              Christian.<br>
              <br>
              Am 28.04.2017 um 00:13 schrieb Panariti, David:<span
                style="font-size:12.0pt"><o:p></o:p></span></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal">The changes in the workarounds function
              use DRM_INFO rather than DRM_DEBUG because CZs with EDC
              are often used in embedded environments and any info can
              be useful especially in the case of an intermittent
              problem.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">From
              e1ce383592c275b58ad95bd80b5479af8c1f9dae Mon Sep 17
              00:00:00 2001<o:p></o:p></p>
            <p class="MsoNormal">From: David Panariti <a
                moz-do-not-send="true"
                href="mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org">
                &lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></p>
            <p class="MsoNormal">Date: Fri, 14 Apr 2017 13:41:52 -0400<o:p></o:p></p>
            <p class="MsoNormal">Subject: [PATCH 1/3] drm/amdgpu: Moved
              gfx_v8_0_select_se_sh() in lieu of<o:p></o:p></p>
            <p class="MsoNormal">re-redundant prototype.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">Will be needed for the rest of the EDC
              workarounds patch.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">Change-Id:
              Ie586ab38a69e98a91c6cb5747e285ce8bfdd1c86<o:p></o:p></p>
            <p class="MsoNormal">Signed-off-by: David Panariti <a
                moz-do-not-send="true"
                href="mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org">
                &lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></p>
            <p class="MsoNormal">---<o:p></o:p></p>
            <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c |
              46 +++++++++++++++++------------------<o:p></o:p></p>
            <p class="MsoNormal">1 file changed, 23 insertions(+), 23
              deletions(-)<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">diff --git
              a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
              b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
            <p class="MsoNormal">index 2ff5f19..27b57cb 100644<o:p></o:p></p>
            <p class="MsoNormal">---
              a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
            <p class="MsoNormal">+++
              b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
            <p class="MsoNormal">@@ -1500,6 +1500,29 @@ static int
              gfx_v8_0_kiq_init(struct amdgpu_device *adev)<o:p></o:p></p>
            <p class="MsoNormal">               return 0;<o:p></o:p></p>
            <p class="MsoNormal">}<o:p></o:p></p>
            <p class="MsoNormal">+static void
              gfx_v8_0_select_se_sh(struct amdgpu_device *adev,<o:p></o:p></p>
            <p class="MsoNormal">+                                                            
                u32 se_num, u32 sh_num, u32 instance)<o:p></o:p></p>
            <p class="MsoNormal">+{<o:p></o:p></p>
            <p class="MsoNormal">+             u32 data;<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             if (instance ==
              0xffffffff)<o:p></o:p></p>
            <p class="MsoNormal">+                             data =
              REG_SET_FIELD(0, GRBM_GFX_INDEX,
              INSTANCE_BROADCAST_WRITES, 1);<o:p></o:p></p>
            <p class="MsoNormal">+             else<o:p></o:p></p>
            <p class="MsoNormal">+                             data =
              REG_SET_FIELD(0, GRBM_GFX_INDEX, INSTANCE_INDEX,
              instance);<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             if (se_num == 0xffffffff)<o:p></o:p></p>
            <p class="MsoNormal">+                             data =
              REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES,
              1);<o:p></o:p></p>
            <p class="MsoNormal">+             else<o:p></o:p></p>
            <p class="MsoNormal">+                             data =
              REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se_num);<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             if (sh_num == 0xffffffff)<o:p></o:p></p>
            <p class="MsoNormal">+                             data =
              REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_BROADCAST_WRITES,
              1);<o:p></o:p></p>
            <p class="MsoNormal">+             else<o:p></o:p></p>
            <p class="MsoNormal">+                             data =
              REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             WREG32(mmGRBM_GFX_INDEX,
              data);<o:p></o:p></p>
            <p class="MsoNormal">+}<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">static const u32
              vgpr_init_compute_shader[] =<o:p></o:p></p>
            <p class="MsoNormal">{<o:p></o:p></p>
            <p class="MsoNormal">               0x7e000209, 0x7e020208,<o:p></o:p></p>
            <p class="MsoNormal">@@ -3556,29 +3579,6 @@ static void
              gfx_v8_0_tiling_mode_table_init(struct amdgpu_device
              *adev)<o:p></o:p></p>
            <p class="MsoNormal">               }<o:p></o:p></p>
            <p class="MsoNormal">}<o:p></o:p></p>
            <p class="MsoNormal">-static void
              gfx_v8_0_select_se_sh(struct amdgpu_device *adev,<o:p></o:p></p>
            <p class="MsoNormal">-                                                             
                u32 se_num, u32 sh_num, u32 instance)<o:p></o:p></p>
            <p class="MsoNormal">-{<o:p></o:p></p>
            <p class="MsoNormal">-              u32 data;<o:p></o:p></p>
            <p class="MsoNormal">-<o:p></o:p></p>
            <p class="MsoNormal">-              if (instance ==
              0xffffffff)<o:p></o:p></p>
            <p class="MsoNormal">-                              data =
              REG_SET_FIELD(0, GRBM_GFX_INDEX,
              INSTANCE_BROADCAST_WRITES, 1);<o:p></o:p></p>
            <p class="MsoNormal">-              else<o:p></o:p></p>
            <p class="MsoNormal">-                              data =
              REG_SET_FIELD(0, GRBM_GFX_INDEX, INSTANCE_INDEX,
              instance);<o:p></o:p></p>
            <p class="MsoNormal">-<o:p></o:p></p>
            <p class="MsoNormal">-              if (se_num ==
              0xffffffff)<o:p></o:p></p>
            <p class="MsoNormal">-                              data =
              REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES,
              1);<o:p></o:p></p>
            <p class="MsoNormal">-              else<o:p></o:p></p>
            <p class="MsoNormal">-                              data =
              REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se_num);<o:p></o:p></p>
            <p class="MsoNormal">-<o:p></o:p></p>
            <p class="MsoNormal">-              if (sh_num ==
              0xffffffff)<o:p></o:p></p>
            <p class="MsoNormal">-                              data =
              REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_BROADCAST_WRITES,
              1);<o:p></o:p></p>
            <p class="MsoNormal">-              else<o:p></o:p></p>
            <p class="MsoNormal">-                              data =
              REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);<o:p></o:p></p>
            <p class="MsoNormal">-<o:p></o:p></p>
            <p class="MsoNormal">-              WREG32(mmGRBM_GFX_INDEX,
              data);<o:p></o:p></p>
            <p class="MsoNormal">-}<o:p></o:p></p>
            <p class="MsoNormal">-<o:p></o:p></p>
            <p class="MsoNormal">static u32 gfx_v8_0_create_bitmask(u32
              bit_width)<o:p></o:p></p>
            <p class="MsoNormal">{<o:p></o:p></p>
            <p class="MsoNormal">               return (u32)((1ULL
              &lt;&lt; bit_width) - 1);<o:p></o:p></p>
            <p class="MsoNormal">-- <o:p></o:p></p>
            <p class="MsoNormal">2.7.4<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">From
              38fac8cab73dbc07e0ee7599b52106bc09dd32ea Mon Sep 17
              00:00:00 2001<o:p></o:p></p>
            <p class="MsoNormal">From: David Panariti <a
                moz-do-not-send="true"
                href="mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org">
                &lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></p>
            <p class="MsoNormal">Date: Mon, 24 Apr 2017 11:05:45 -0400<o:p></o:p></p>
            <p class="MsoNormal">Subject: [PATCH 2/3] drm/amdgpu:
              Complete Carrizo EDC (Error Detection and<o:p></o:p></p>
            <p class="MsoNormal">Correction) workarounds.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">The workarounds are unconditionally
              performed on CZs with EDC enabled.<o:p></o:p></p>
            <p class="MsoNormal">EDC detects uncorrected ECC errors and
              uses data poisoning to prevent<o:p></o:p></p>
            <p class="MsoNormal">corrupted compute results from being
              used (read).<o:p></o:p></p>
            <p class="MsoNormal">EDC enabled CZs are often used in
              embedded environments.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">Change-Id:
              I84c261785329beeb797f11efbe0ec35790f2996c<o:p></o:p></p>
            <p class="MsoNormal">Signed-off-by: David Panariti <a
                moz-do-not-send="true"
                href="mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org">
                &lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></p>
            <p class="MsoNormal">---<o:p></o:p></p>
            <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c |
              148 ++++++++++++++++++++++++----------<o:p></o:p></p>
            <p class="MsoNormal">1 file changed, 106 insertions(+), 42
              deletions(-)<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">diff --git
              a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
              b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
            <p class="MsoNormal">index 27b57cb..2f5bf5f 100644<o:p></o:p></p>
            <p class="MsoNormal">---
              a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
            <p class="MsoNormal">+++
              b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
            <p class="MsoNormal">@@ -1645,35 +1645,92 @@ static const
              u32 sgpr2_init_regs[] =<o:p></o:p></p>
            <p class="MsoNormal">               mmCOMPUTE_USER_DATA_9,
              0xedcedc09,<o:p></o:p></p>
            <p class="MsoNormal">};<o:p></o:p></p>
            <p class="MsoNormal">-static const u32
              sec_ded_counter_registers[] =<o:p></o:p></p>
            <p class="MsoNormal">-{<o:p></o:p></p>
            <p class="MsoNormal">-              mmCPC_EDC_ATC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmCPC_EDC_SCRATCH_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmCPC_EDC_UCODE_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmCPF_EDC_ATC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmCPF_EDC_ROQ_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmCPF_EDC_TAG_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmCPG_EDC_ATC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmCPG_EDC_DMA_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmCPG_EDC_TAG_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmDC_EDC_CSINVOC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmDC_EDC_RESTORE_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmDC_EDC_STATE_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmGDS_EDC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmGDS_EDC_GRBM_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmGDS_EDC_OA_DED,<o:p></o:p></p>
            <p class="MsoNormal">-              mmSPI_EDC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-             
              mmSQC_ATC_EDC_GATCL1_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmSQC_EDC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmSQ_EDC_DED_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmSQ_EDC_INFO,<o:p></o:p></p>
            <p class="MsoNormal">-              mmSQ_EDC_SEC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmTCC_EDC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-             
              mmTCP_ATC_EDC_GATCL1_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmTCP_EDC_CNT,<o:p></o:p></p>
            <p class="MsoNormal">-              mmTD_EDC_CNT<o:p></o:p></p>
            <p class="MsoNormal">+struct reg32_counter_name_map {<o:p></o:p></p>
            <p class="MsoNormal">+             uint32_t rnmap_addr;   /*
              Counter register address */<o:p></o:p></p>
            <p class="MsoNormal">+             const char
              *rnmap_name;           /* Name of the counter */<o:p></o:p></p>
            <p class="MsoNormal">+             size_t
              rnmap_num_instances;  /* Number of block instances */<o:p></o:p></p>
            <p class="MsoNormal">};<o:p></o:p></p>
            <p class="MsoNormal">+#define
              DEF_mmREG32_NAME_MAP_ELEMENT(reg, num_instances)
              {             \<o:p></o:p></p>
            <p class="MsoNormal">+             .rnmap_addr =
mm##reg,                                                                          
              \<o:p></o:p></p>
            <p class="MsoNormal">+             .rnmap_name =
              #reg,                                                                   
              \<o:p></o:p></p>
            <p class="MsoNormal">+             .rnmap_num_instances =
              num_instances                                            \<o:p></o:p></p>
            <p class="MsoNormal">+}<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+/* See GRBM_GFX_INDEX, et. al.
              registers. */<o:p></o:p></p>
            <p class="MsoNormal">+static const struct
              reg32_counter_name_map sec_ded_counter_registers[] = {<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(SQC_EDC_CNT, 2),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(SQC_ATC_EDC_GATCL1_CNT, 2),<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(SQ_EDC_SEC_CNT, 8),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(SQ_EDC_DED_CNT, 8),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(TCP_EDC_CNT, 8),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(TCP_ATC_EDC_GATCL1_CNT, 8),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(TD_EDC_CNT, 8),<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(TCC_EDC_CNT, 4),<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_ATC_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_SCRATCH_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(CPC_EDC_UCODE_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_ATC_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_ROQ_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(CPF_EDC_TAG_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_ATC_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_DMA_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(CPG_EDC_TAG_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_CSINVOC_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_STATE_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(DC_EDC_RESTORE_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(GDS_EDC_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(GDS_EDC_GRBM_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+            
              DEF_mmREG32_NAME_MAP_ELEMENT(SPI_EDC_CNT, 1),<o:p></o:p></p>
            <p class="MsoNormal">+};<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+static int
              gfx_v8_0_edc_clear_counters(struct amdgpu_device *adev)<o:p></o:p></p>
            <p class="MsoNormal">+{<o:p></o:p></p>
            <p class="MsoNormal">+             int ci, se, sh, i;<o:p></o:p></p>
            <p class="MsoNormal">+             uint32_t count;<o:p></o:p></p>
            <p class="MsoNormal">+             int r = 0;<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+            
              mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             for (ci = 0; ci &lt;
              ARRAY_SIZE(sec_ded_counter_registers); ++ci) {<o:p></o:p></p>
            <p class="MsoNormal">+                             const
              struct reg32_counter_name_map *cp =<o:p></o:p></p>
            <p class="MsoNormal">+                                            
              sec_ded_counter_registers + ci;<o:p></o:p></p>
            <p class="MsoNormal">+                             const
              char *name = cp-&gt;rnmap_name;<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+                             for (se =
              0; se &lt; adev-&gt;gfx.config.max_shader_engines; ++se) {<o:p></o:p></p>
            <p class="MsoNormal">+                                            
              for (sh = 0; sh &lt; adev-&gt;gfx.config.max_sh_per_se;
              ++sh) {<o:p></o:p></p>
            <p class="MsoNormal">+                                                            
              for (i = 0; i &lt; cp-&gt;rnmap_num_instances; ++i) {<o:p></o:p></p>
            <p class="MsoNormal">+                                                                            
              gfx_v8_0_select_se_sh(adev, se, sh, i);<o:p></o:p></p>
            <p class="MsoNormal">+                                                                            
              count = RREG32(cp-&gt;rnmap_addr);<o:p></o:p></p>
            <p class="MsoNormal">+                                                                            
              count = RREG32(cp-&gt;rnmap_addr);<o:p></o:p></p>
            <p class="MsoNormal">+                                                                            
              if (count != 0) {<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              /*<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              * Workaround failed.<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              * If people are interested<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              * in EDC at all, they will<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              * want to know which<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              * counters had problems.<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              */<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              DRM_WARN("EDC counter %s is 0x%08x, but should be 0\n.",<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                                            
              name, count);<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              r = -EINVAL;<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              goto ret;<o:p></o:p></p>
            <p class="MsoNormal">+                                                                            
              }<o:p></o:p></p>
            <p class="MsoNormal">+                                                            
              }<o:p></o:p></p>
            <p class="MsoNormal">+                                            
              }<o:p></o:p></p>
            <p class="MsoNormal">+                             }<o:p></o:p></p>
            <p class="MsoNormal">+             }<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+ret:<o:p></o:p></p>
            <p class="MsoNormal">+            
              gfx_v8_0_select_se_sh(adev, 0xffffffff, 0xffffffff,
              0xffffffff);<o:p></o:p></p>
            <p class="MsoNormal">+            
              mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             return r;<o:p></o:p></p>
            <p class="MsoNormal">+}<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">static int
              gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device
              *adev)<o:p></o:p></p>
            <p class="MsoNormal">{<o:p></o:p></p>
            <p class="MsoNormal">               struct amdgpu_ring *ring
              = &amp;adev-&gt;gfx.compute_ring[0];<o:p></o:p></p>
            <p class="MsoNormal">@@ -1681,18 +1738,36 @@ static int
              gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device
              *adev)<o:p></o:p></p>
            <p class="MsoNormal">               struct fence *f = NULL;<o:p></o:p></p>
            <p class="MsoNormal">               int r, i;<o:p></o:p></p>
            <p class="MsoNormal">               u32 tmp;<o:p></o:p></p>
            <p class="MsoNormal">+             u32 dis_bit;<o:p></o:p></p>
            <p class="MsoNormal">               unsigned total_size,
              vgpr_offset, sgpr_offset;<o:p></o:p></p>
            <p class="MsoNormal">               u64 gpu_addr;<o:p></o:p></p>
            <p class="MsoNormal">-              /* only supported on CZ
              */<o:p></o:p></p>
            <p class="MsoNormal">-              if (adev-&gt;asic_type
              != CHIP_CARRIZO)<o:p></o:p></p>
            <p class="MsoNormal">+             if (adev-&gt;asic_type !=
              CHIP_CARRIZO) {<o:p></o:p></p>
            <p class="MsoNormal">+                             /* EDC is
              only supported on CZ */<o:p></o:p></p>
            <p class="MsoNormal">+                             return 0;<o:p></o:p></p>
            <p class="MsoNormal">+             }<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+        DRM_INFO("Detected
              Carrizo.\n");<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             tmp =
              RREG32(mmCC_GC_EDC_CONFIG);<o:p></o:p></p>
            <p class="MsoNormal">+             dis_bit =
              REG_GET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_EDC);<o:p></o:p></p>
            <p class="MsoNormal">+             if (dis_bit) {<o:p></o:p></p>
            <p class="MsoNormal">+                             /* On
              Carrizo, EDC may be disabled by a fuse. */<o:p></o:p></p>
            <p class="MsoNormal">+                            
              DRM_INFO("EDC hardware is disabled, GC_EDC_CONFIG:
              0x%08x.\n",<o:p></o:p></p>
            <p class="MsoNormal">+                                            
              tmp);<o:p></o:p></p>
            <p class="MsoNormal">                               return
              0;<o:p></o:p></p>
            <p class="MsoNormal">+             }<o:p></o:p></p>
            <p class="MsoNormal">                /* bail if the compute
              ring is not ready */<o:p></o:p></p>
            <p class="MsoNormal">               if (!ring-&gt;ready)<o:p></o:p></p>
            <p class="MsoNormal">                               return
              0;<o:p></o:p></p>
            <p class="MsoNormal">-              tmp =
              RREG32(mmGB_EDC_MODE);<o:p></o:p></p>
            <p class="MsoNormal">+             DRM_INFO("Applying EDC
              workarounds.\n");<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             /*<o:p></o:p></p>
            <p class="MsoNormal">+             * Interested parties can
              enable EDC using debugfs register reads and<o:p></o:p></p>
            <p class="MsoNormal">+             * writes.<o:p></o:p></p>
            <p class="MsoNormal">+             */<o:p></o:p></p>
            <p class="MsoNormal">               WREG32(mmGB_EDC_MODE,
              0);<o:p></o:p></p>
            <p class="MsoNormal">                total_size =<o:p></o:p></p>
            <p class="MsoNormal">@@ -1817,18 +1892,7 @@ static int
              gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device
              *adev)<o:p></o:p></p>
            <p class="MsoNormal">                               goto
              fail;<o:p></o:p></p>
            <p class="MsoNormal">               }<o:p></o:p></p>
            <p class="MsoNormal">-              tmp = REG_SET_FIELD(tmp,
              GB_EDC_MODE, DED_MODE, 2);<o:p></o:p></p>
            <p class="MsoNormal">-              tmp = REG_SET_FIELD(tmp,
              GB_EDC_MODE, PROP_FED, 1);<o:p></o:p></p>
            <p class="MsoNormal">-              WREG32(mmGB_EDC_MODE,
              tmp);<o:p></o:p></p>
            <p class="MsoNormal">-<o:p></o:p></p>
            <p class="MsoNormal">-              tmp =
              RREG32(mmCC_GC_EDC_CONFIG);<o:p></o:p></p>
            <p class="MsoNormal">-              tmp = REG_SET_FIELD(tmp,
              CC_GC_EDC_CONFIG, DIS_EDC, 0) | 1;<o:p></o:p></p>
            <p class="MsoNormal">-             
              WREG32(mmCC_GC_EDC_CONFIG, tmp);<o:p></o:p></p>
            <p class="MsoNormal">-<o:p></o:p></p>
            <p class="MsoNormal">-<o:p></o:p></p>
            <p class="MsoNormal">-              /* read back registers
              to clear the counters */<o:p></o:p></p>
            <p class="MsoNormal">-              for (i = 0; i &lt;
              ARRAY_SIZE(sec_ded_counter_registers); i++)<o:p></o:p></p>
            <p class="MsoNormal">-                             
              RREG32(sec_ded_counter_registers[i]);<o:p></o:p></p>
            <p class="MsoNormal">+            
              gfx_v8_0_edc_clear_counters(adev);<o:p></o:p></p>
            <p class="MsoNormal"> fail:<o:p></o:p></p>
            <p class="MsoNormal">               amdgpu_ib_free(adev,
              &amp;ib, NULL);<o:p></o:p></p>
            <p class="MsoNormal">-- <o:p></o:p></p>
            <p class="MsoNormal">2.7.4<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">From
              ec4803205582c1011f5ced1ead70ee244268b4b8 Mon Sep 17
              00:00:00 2001<o:p></o:p></p>
            <p class="MsoNormal">From: David Panariti <a
                moz-do-not-send="true"
                href="mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org">
                &lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></p>
            <p class="MsoNormal">Date: Wed, 26 Apr 2017 10:13:06 -0400<o:p></o:p></p>
            <p class="MsoNormal">Subject: [PATCH 3/3] drm/amdgpu: Add
              kernel parameter to control use of<o:p></o:p></p>
            <p class="MsoNormal">ECC/EDC.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">Allow various kinds of memory integrity
              methods (e.g. ECC/EDC) to be enabled<o:p></o:p></p>
            <p class="MsoNormal">or disabled.  By default, all features
              are disabled.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">EDC is Error Detection and Correction. 
              It can detect ECC errors and do 0 or<o:p></o:p></p>
            <p class="MsoNormal">more of: count SEC (single error
              corrected) and DED (double error detected,<o:p></o:p></p>
            <p class="MsoNormal">i.e. uncorrected ECC error), halt the
              affected block, interrupt the CPU.<o:p></o:p></p>
            <p class="MsoNormal">Currently, only counting errors is
              supported.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">Signed-off-by: David Panariti <a
                moz-do-not-send="true"
                href="mailto:David.Panariti-5C7GfCeVMHo@public.gmane.org">
                &lt;David.Panariti-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></p>
            <p class="MsoNormal">---<o:p></o:p></p>
            <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu.h     
              |  1 +<o:p></o:p></p>
            <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
              |  4 ++++<o:p></o:p></p>
            <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   
              | 34 +++++++++++++++++++++++++++-----<o:p></o:p></p>
            <p class="MsoNormal">drivers/gpu/drm/amd/include/amd_shared.h
              | 14 +++++++++++++<o:p></o:p></p>
            <p class="MsoNormal">4 files changed, 48 insertions(+), 5
              deletions(-)<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
            <p class="MsoNormal">index 4a16e3c..0322392 100644<o:p></o:p></p>
            <p class="MsoNormal">---
              a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
            <p class="MsoNormal">+++
              b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
            <p class="MsoNormal">@@ -111,6 +111,7 @@ extern int
              amdgpu_prim_buf_per_se;<o:p></o:p></p>
            <p class="MsoNormal">extern int amdgpu_pos_buf_per_se;<o:p></o:p></p>
            <p class="MsoNormal">extern int amdgpu_cntl_sb_buf_per_se;<o:p></o:p></p>
            <p class="MsoNormal">extern int amdgpu_param_buf_per_se;<o:p></o:p></p>
            <p class="MsoNormal">+extern unsigned amdgpu_ecc_flags;<o:p></o:p></p>
            <p class="MsoNormal"> #define
              AMDGPU_DEFAULT_GTT_SIZE_MB                      3072ULL /*
              3GB by default */<o:p></o:p></p>
            <p class="MsoNormal">#define
              AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS                   3000<o:p></o:p></p>
            <p class="MsoNormal">diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<o:p></o:p></p>
            <p class="MsoNormal">index ead00d7..00e16ac 100644<o:p></o:p></p>
            <p class="MsoNormal">---
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<o:p></o:p></p>
            <p class="MsoNormal">+++
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<o:p></o:p></p>
            <p class="MsoNormal">@@ -110,6 +110,7 @@ int
              amdgpu_prim_buf_per_se = 0;<o:p></o:p></p>
            <p class="MsoNormal">int amdgpu_pos_buf_per_se = 0;<o:p></o:p></p>
            <p class="MsoNormal">int amdgpu_cntl_sb_buf_per_se = 0;<o:p></o:p></p>
            <p class="MsoNormal">int amdgpu_param_buf_per_se = 0;<o:p></o:p></p>
            <p class="MsoNormal">+unsigned amdgpu_ecc_flags = 0;<o:p></o:p></p>
            <p class="MsoNormal"> MODULE_PARM_DESC(vramlimit, "Restrict
              VRAM for testing, in megabytes");<o:p></o:p></p>
            <p class="MsoNormal">module_param_named(vramlimit,
              amdgpu_vram_limit, int, 0600);<o:p></o:p></p>
            <p class="MsoNormal">@@ -235,6 +236,9 @@
              module_param_named(cntl_sb_buf_per_se,
              amdgpu_cntl_sb_buf_per_se, int, 0444);<o:p></o:p></p>
            <p class="MsoNormal">MODULE_PARM_DESC(param_buf_per_se, "the
              size of Off-Chip Pramater Cache per Shader Engine (default
              depending on gfx)");<o:p></o:p></p>
            <p class="MsoNormal">module_param_named(param_buf_per_se,
              amdgpu_param_buf_per_se, int, 0444);<o:p></o:p></p>
            <p class="MsoNormal">+MODULE_PARM_DESC(ecc_flags, "ECC/EDC
              enable flags (0 = disable ECC/EDC (default))");<o:p></o:p></p>
            <p class="MsoNormal">+module_param_named(ecc_flags,
              amdgpu_ecc_flags, uint, 0444);<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal"> static const struct pci_device_id
              pciidlist[] = {<o:p></o:p></p>
            <p class="MsoNormal">#ifdef  CONFIG_DRM_AMDGPU_SI<o:p></o:p></p>
            <p class="MsoNormal">diff --git
              a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
              b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
            <p class="MsoNormal">index 2f5bf5f..05cab7e 100644<o:p></o:p></p>
            <p class="MsoNormal">---
              a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
            <p class="MsoNormal">+++
              b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<o:p></o:p></p>
            <p class="MsoNormal">@@ -1708,7 +1708,7 @@ static int
              gfx_v8_0_edc_clear_counters(struct amdgpu_device *adev)<o:p></o:p></p>
            <p class="MsoNormal">                                                                              
              count = RREG32(cp-&gt;rnmap_addr);<o:p></o:p></p>
            <p class="MsoNormal">                                                                              
              if (count != 0) {<o:p></o:p></p>
            <p class="MsoNormal">                                                                                              
              /*<o:p></o:p></p>
            <p class="MsoNormal">-                                                                                             
              * Workaround failed.<o:p></o:p></p>
            <p class="MsoNormal">+                                                                                            
              * EDC workaround failed.<o:p></o:p></p>
            <p class="MsoNormal">                                                                                              
               * If people are interested<o:p></o:p></p>
            <p class="MsoNormal">                                                                                              
               * in EDC at all, they will<o:p></o:p></p>
            <p class="MsoNormal">                                                                                              
               * want to know which<o:p></o:p></p>
            <p class="MsoNormal">@@ -1747,14 +1747,24 @@ static int
              gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device
              *adev)<o:p></o:p></p>
            <p class="MsoNormal">                               return
              0;<o:p></o:p></p>
            <p class="MsoNormal">               }<o:p></o:p></p>
            <p class="MsoNormal">-        DRM_INFO("Detected
              Carrizo.\n");<o:p></o:p></p>
            <p class="MsoNormal">+             DRM_INFO("Detected
              Carrizo.\n");<o:p></o:p></p>
            <p class="MsoNormal">                tmp =
              RREG32(mmCC_GC_EDC_CONFIG);<o:p></o:p></p>
            <p class="MsoNormal">               dis_bit =
              REG_GET_FIELD(tmp, CC_GC_EDC_CONFIG, DIS_EDC);<o:p></o:p></p>
            <p class="MsoNormal">               if (dis_bit) {<o:p></o:p></p>
            <p class="MsoNormal">-                              /* On
              Carrizo, EDC may be disabled by a fuse. */<o:p></o:p></p>
            <p class="MsoNormal">-                             
              DRM_INFO("EDC hardware is disabled, GC_EDC_CONFIG:
              0x%08x.\n",<o:p></o:p></p>
            <p class="MsoNormal">-                                             
              tmp);<o:p></o:p></p>
            <p class="MsoNormal">+                             /* On
              Carrizo, EDC may be disabled permanently by a fuse. */<o:p></o:p></p>
            <p class="MsoNormal">+                            
              DRM_INFO("Carrizo EDC hardware is disabled, GC_EDC_CONFIG:
              0x%08x.\n",<o:p></o:p></p>
            <p class="MsoNormal">+                                            
              tmp);<o:p></o:p></p>
            <p class="MsoNormal">+                             return 0;<o:p></o:p></p>
            <p class="MsoNormal">+             }<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             /*<o:p></o:p></p>
            <p class="MsoNormal">+             * Check if EDC has been
              requested by a kernel parameter.<o:p></o:p></p>
            <p class="MsoNormal">+             * For Carrizo, EDC is the
              best/safest mode WRT error handling.<o:p></o:p></p>
            <p class="MsoNormal">+             */<o:p></o:p></p>
            <p class="MsoNormal">+             if (!(amdgpu_ecc_flags<o:p></o:p></p>
            <p class="MsoNormal">+                   &amp;
              (AMD_ECC_SUPPORT_BEST | AMD_ECC_SUPPORT_EDC))) {<o:p></o:p></p>
            <p class="MsoNormal">+                            
              DRM_INFO("EDC support has not been requested.\n");<o:p></o:p></p>
            <p class="MsoNormal">                               return
              0;<o:p></o:p></p>
            <p class="MsoNormal">               }<o:p></o:p></p>
            <p class="MsoNormal">@@ -1892,6 +1902,20 @@ static int
              gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device
              *adev)<o:p></o:p></p>
            <p class="MsoNormal">                               goto
              fail;<o:p></o:p></p>
            <p class="MsoNormal">               }<o:p></o:p></p>
            <p class="MsoNormal">+             /* 00 -
              GB_EDC_DED_MODE_LOG: Count DED errors but do not halt */<o:p></o:p></p>
            <p class="MsoNormal">+             tmp = REG_SET_FIELD(tmp,
              GB_EDC_MODE, DED_MODE, 0);<o:p></o:p></p>
            <p class="MsoNormal">+             /* Do not propagate the
              errors to the next block. */<o:p></o:p></p>
            <p class="MsoNormal">+             tmp = REG_SET_FIELD(tmp,
              GB_EDC_MODE, PROP_FED, 0);<o:p></o:p></p>
            <p class="MsoNormal">+             WREG32(mmGB_EDC_MODE,
              tmp);<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             tmp =
              RREG32(mmCC_GC_EDC_CONFIG);<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">+             /*<o:p></o:p></p>
            <p class="MsoNormal">+             * Clear EDC_DISABLE bit
              so the counters are available.<o:p></o:p></p>
            <p class="MsoNormal">+             */<o:p></o:p></p>
            <p class="MsoNormal">+             tmp = REG_SET_FIELD(tmp,
              CC_GC_EDC_CONFIG, DIS_EDC, 0);<o:p></o:p></p>
            <p class="MsoNormal">+            
              WREG32(mmCC_GC_EDC_CONFIG, tmp);<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">              
              gfx_v8_0_edc_clear_counters(adev);<o:p></o:p></p>
            <p class="MsoNormal"> fail:<o:p></o:p></p>
            <p class="MsoNormal">diff --git
              a/drivers/gpu/drm/amd/include/amd_shared.h
              b/drivers/gpu/drm/amd/include/amd_shared.h<o:p></o:p></p>
            <p class="MsoNormal">index 2ccf44e..c4fd013 100644<o:p></o:p></p>
            <p class="MsoNormal">---
              a/drivers/gpu/drm/amd/include/amd_shared.h<o:p></o:p></p>
            <p class="MsoNormal">+++
              b/drivers/gpu/drm/amd/include/amd_shared.h<o:p></o:p></p>
            <p class="MsoNormal">@@ -179,6 +179,20 @@ struct
              amd_pp_profile {<o:p></o:p></p>
            <p class="MsoNormal">#define
              AMD_PG_SUPPORT_GFX_QUICK_MG                               
              (1 &lt;&lt; 11)<o:p></o:p></p>
            <p class="MsoNormal">#define
              AMD_PG_SUPPORT_GFX_PIPELINE                     (1
              &lt;&lt; 12)<o:p></o:p></p>
            <p class="MsoNormal">+/*<o:p></o:p></p>
            <p class="MsoNormal">+ * ECC flags<o:p></o:p></p>
            <p class="MsoNormal">+ * Allows the user to choose what kind
              of error detection/correction is used.<o:p></o:p></p>
            <p class="MsoNormal">+ * Currently, EDC is supported on
              Carrizo.<o:p></o:p></p>
            <p class="MsoNormal">+ *<o:p></o:p></p>
            <p class="MsoNormal">+ * The AMD_ECC_SUPPORT_BEST bit is
              used to allow a user to have the driver<o:p></o:p></p>
            <p class="MsoNormal">+ * set what it thinks is best/safest
              mode.  This may not be the same as the<o:p></o:p></p>
            <p class="MsoNormal">+ * default, depending on the GPU and
              the application.<o:p></o:p></p>
            <p class="MsoNormal">+ * Using a single bit makes it easy to
              request the best support without<o:p></o:p></p>
            <p class="MsoNormal">+ * needing to know all currently
              supported modes.<o:p></o:p></p>
            <p class="MsoNormal">+ */<o:p></o:p></p>
            <p class="MsoNormal">+#define
              AMD_ECC_SUPPORT_BEST                                    
              (1 &lt;&lt; 0)<o:p></o:p></p>
            <p class="MsoNormal">+#define
              AMD_ECC_SUPPORT_EDC                                      
              (1 &lt;&lt; 1)<o:p></o:p></p>
            <p class="MsoNormal">+<o:p></o:p></p>
            <p class="MsoNormal">enum amd_pm_state_type {<o:p></o:p></p>
            <p class="MsoNormal">               /* not used for dpm */<o:p></o:p></p>
            <p class="MsoNormal">              
              POWER_STATE_TYPE_DEFAULT,<o:p></o:p></p>
            <p class="MsoNormal">-- <o:p></o:p></p>
            <p class="MsoNormal">2.7.4<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
          </blockquote>
          <p><o:p> </o:p></p>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------BAD694D9BAC5B4F07A0FE11C--

--===============1594865264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1594865264==--
