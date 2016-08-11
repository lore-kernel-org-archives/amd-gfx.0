From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amd/amdgpu: Cleanup register access in VCE v3
Date: Thu, 11 Aug 2016 15:43:55 +0000
Message-ID: <DM5PR12MB1132BAFCCA55629CE9C893A2F71E0@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160811143253.24718-1-tom.stdenis@amd.com>
 <20160811143253.24718-2-tom.stdenis@amd.com>,
 <MWHPR12MB169403F24E091D033BEE21F6F71E0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0775023811=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB169403F24E091D033BEE21F6F71E0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0775023811==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132BAFCCA55629CE9C893A2F71E0DM5PR12MB1132namp_"

--_000_DM5PR12MB1132BAFCCA55629CE9C893A2F71E0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorta.  The switch from gate/ungate for instance is kinda mutually exclusiv=
e.  The device won't be gated when calling gate or ungated when calling ung=
ate.  The other conditional writes are similar.


Tom


________________________________
From: Deucher, Alexander
Sent: Thursday, August 11, 2016 11:41
To: 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: RE: [PATCH 1/4] drm/amd/amdgpu: Cleanup register access in VCE v3

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Tom St Denis
> Sent: Thursday, August 11, 2016 10:33 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: StDenis, Tom
> Subject: [PATCH 1/4] drm/amd/amdgpu: Cleanup register access in VCE v3
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This potentially adds a bunch of unnecessary register writes which increase=
s latency on VCE power up.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 145 ++++++++++-----------------
> -------
>  1 file changed, 43 insertions(+), 102 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 7e6bb45658f6..073cf9ed0674 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -110,22 +110,13 @@ static void vce_v3_0_ring_set_wptr(struct
> amdgpu_ring *ring)
>
>  static void vce_v3_0_override_vce_clock_gating(struct amdgpu_device
> *adev, bool override)
>  {
> -     u32 tmp, data;
> -
> -     tmp =3D data =3D RREG32(mmVCE_RB_ARB_CTRL);
> -     if (override)
> -             data |=3D VCE_RB_ARB_CTRL__VCE_CGTT_OVERRIDE_MASK;
> -     else
> -             data &=3D
> ~VCE_RB_ARB_CTRL__VCE_CGTT_OVERRIDE_MASK;
> -
> -     if (tmp !=3D data)
> -             WREG32(mmVCE_RB_ARB_CTRL, data);
> +     WREG32_FIELD(VCE_RB_ARB_CTRL, VCE_CGTT_OVERRIDE, override
> ? 1 : 0);
>  }
>
>  static void vce_v3_0_set_vce_sw_clock_gating(struct amdgpu_device
> *adev,
>                                             bool gated)
>  {
> -     u32 tmp, data;
> +     u32 data;
>
>        /* Set Override to disable Clock Gating */
>        vce_v3_0_override_vce_clock_gating(adev, true);
> @@ -136,65 +127,55 @@ static void
> vce_v3_0_set_vce_sw_clock_gating(struct amdgpu_device *adev,
>           fly as necessary.
>        */
>        if (gated) {
> -             tmp =3D data =3D RREG32(mmVCE_CLOCK_GATING_B);
> +             data =3D RREG32(mmVCE_CLOCK_GATING_B);
>                data |=3D 0x1ff;
>                data &=3D ~0xef0000;
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_CLOCK_GATING_B, data);
> +             WREG32(mmVCE_CLOCK_GATING_B, data);
>
> -             tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING);
> +             data =3D RREG32(mmVCE_UENC_CLOCK_GATING);
>                data |=3D 0x3ff000;
>                data &=3D ~0xffc00000;
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_UENC_CLOCK_GATING, data);
> +             WREG32(mmVCE_UENC_CLOCK_GATING, data);
>
> -             tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);
> +             data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);
>                data |=3D 0x2;
>                data &=3D ~0x00010000;
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_UENC_CLOCK_GATING_2, data);
> +             WREG32(mmVCE_UENC_CLOCK_GATING_2, data);
>
> -             tmp =3D data =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> +             data =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);
>                data |=3D 0x37f;
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_UENC_REG_CLOCK_GATING,
> data);
> +             WREG32(mmVCE_UENC_REG_CLOCK_GATING, data);
>
> -             tmp =3D data =3D RREG32(mmVCE_UENC_DMA_DCLK_CTRL);
> +             data =3D RREG32(mmVCE_UENC_DMA_DCLK_CTRL);
>                data |=3D
> VCE_UENC_DMA_DCLK_CTRL__WRDMCLK_FORCEON_MASK |
>
>        VCE_UENC_DMA_DCLK_CTRL__RDDMCLK_FORCEON_MASK |
>
>        VCE_UENC_DMA_DCLK_CTRL__REGCLK_FORCEON_MASK  |
>                        0x8;
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_UENC_DMA_DCLK_CTRL, data);
> +             WREG32(mmVCE_UENC_DMA_DCLK_CTRL, data);
>        } else {
> -             tmp =3D data =3D RREG32(mmVCE_CLOCK_GATING_B);
> +             data =3D RREG32(mmVCE_CLOCK_GATING_B);
>                data &=3D ~0x80010;
>                data |=3D 0xe70008;
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_CLOCK_GATING_B, data);
> +             WREG32(mmVCE_CLOCK_GATING_B, data);
>
> -             tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING);
> +             data =3D RREG32(mmVCE_UENC_CLOCK_GATING);
>                data |=3D 0xffc00000;
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_UENC_CLOCK_GATING, data);
> +             WREG32(mmVCE_UENC_CLOCK_GATING, data);
>
> -             tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);
> +             data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);
>                data |=3D 0x10000;
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_UENC_CLOCK_GATING_2, data);
> +             WREG32(mmVCE_UENC_CLOCK_GATING_2, data);
>
> -             tmp =3D data =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> +             data =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);
>                data &=3D ~0xffc00000;
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_UENC_REG_CLOCK_GATING,
> data);
> +             WREG32(mmVCE_UENC_REG_CLOCK_GATING, data);
>
> -             tmp =3D data =3D RREG32(mmVCE_UENC_DMA_DCLK_CTRL);
> +             data =3D RREG32(mmVCE_UENC_DMA_DCLK_CTRL);
>                data &=3D
> ~(VCE_UENC_DMA_DCLK_CTRL__WRDMCLK_FORCEON_MASK |
>
> VCE_UENC_DMA_DCLK_CTRL__RDDMCLK_FORCEON_MASK |
>
> VCE_UENC_DMA_DCLK_CTRL__REGCLK_FORCEON_MASK  |
>                          0x8);
> -             if (tmp !=3D data)
> -                     WREG32(mmVCE_UENC_DMA_DCLK_CTRL, data);
> +             WREG32(mmVCE_UENC_DMA_DCLK_CTRL, data);
>        }
>        vce_v3_0_override_vce_clock_gating(adev, false);
>  }
> @@ -213,12 +194,9 @@ static int vce_v3_0_firmware_loaded(struct
> amdgpu_device *adev)
>                }
>
>                DRM_ERROR("VCE not responding, trying to reset the
> ECPU!!!\n");
> -             WREG32_P(mmVCE_SOFT_RESET,
> -                     VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> -                     ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
>                mdelay(10);
> -             WREG32_P(mmVCE_SOFT_RESET, 0,
> -                     ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);
>                mdelay(10);
>        }
>
> @@ -256,34 +234,22 @@ static int vce_v3_0_start(struct amdgpu_device
> *adev)
>                if (adev->vce.harvest_config & (1 << idx))
>                        continue;
>
> -             if (idx =3D=3D 0)
> -                     WREG32_P(mmGRBM_GFX_INDEX, 0,
> -
>        ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);
> -             else
> -                     WREG32_P(mmGRBM_GFX_INDEX,
> -                             GRBM_GFX_INDEX__VCE_INSTANCE_MASK,
> -
>        ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);
> -
> +             WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANCE, idx);
>                vce_v3_0_mc_resume(adev, idx);
> -
> -             WREG32_P(mmVCE_STATUS,
> VCE_STATUS__JOB_BUSY_MASK,
> -                      ~VCE_STATUS__JOB_BUSY_MASK);
> +             WREG32_FIELD(VCE_STATUS, JOB_BUSY, 1);
>
>                if (adev->asic_type >=3D CHIP_STONEY)
>                        WREG32_P(mmVCE_VCPU_CNTL, 1, ~0x200001);
>                else
> -                     WREG32_P(mmVCE_VCPU_CNTL,
> VCE_VCPU_CNTL__CLK_EN_MASK,
> -                             ~VCE_VCPU_CNTL__CLK_EN_MASK);
> -
> -             WREG32_P(mmVCE_SOFT_RESET, 0,
> -                     ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +                     WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 1);
>
> +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);
>                mdelay(100);
>
>                r =3D vce_v3_0_firmware_loaded(adev);
>
>                /* clear BUSY flag */
> -             WREG32_P(mmVCE_STATUS, 0,
> ~VCE_STATUS__JOB_BUSY_MASK);
> +             WREG32_FIELD(VCE_STATUS, JOB_BUSY, 0);
>
>                if (r) {
>                        DRM_ERROR("VCE not responding, giving up!!!\n");
> @@ -292,7 +258,7 @@ static int vce_v3_0_start(struct amdgpu_device
> *adev)
>                }
>        }
>
> -     WREG32_P(mmGRBM_GFX_INDEX, 0,
> ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);
> +     WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANCE, 0);
>        mutex_unlock(&adev->grbm_idx_mutex);
>
>        return 0;
> @@ -307,33 +273,25 @@ static int vce_v3_0_stop(struct amdgpu_device
> *adev)
>                if (adev->vce.harvest_config & (1 << idx))
>                        continue;
>
> -             if (idx =3D=3D 0)
> -                     WREG32_P(mmGRBM_GFX_INDEX, 0,
> -
>        ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);
> -             else
> -                     WREG32_P(mmGRBM_GFX_INDEX,
> -                             GRBM_GFX_INDEX__VCE_INSTANCE_MASK,
> -
>        ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);
> +             WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANCE, idx);
>
>                if (adev->asic_type >=3D CHIP_STONEY)
>                        WREG32_P(mmVCE_VCPU_CNTL, 0, ~0x200001);
>                else
> -                     WREG32_P(mmVCE_VCPU_CNTL, 0,
> -                             ~VCE_VCPU_CNTL__CLK_EN_MASK);
> +                     WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 0);
> +
>                /* hold on ECPU */
> -             WREG32_P(mmVCE_SOFT_RESET,
> -                      VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> -                      ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
>
>                /* clear BUSY flag */
> -             WREG32_P(mmVCE_STATUS, 0,
> ~VCE_STATUS__JOB_BUSY_MASK);
> +             WREG32_FIELD(VCE_STATUS, JOB_BUSY, 0);
>
>                /* Set Clock-Gating off */
>                if (adev->cg_flags & AMD_CG_SUPPORT_VCE_MGCG)
>                        vce_v3_0_set_vce_sw_clock_gating(adev, false);
>        }
>
> -     WREG32_P(mmGRBM_GFX_INDEX, 0,
> ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);
> +     WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANCE, 0);
>        mutex_unlock(&adev->grbm_idx_mutex);
>
>        return 0;
> @@ -561,9 +519,7 @@ static void vce_v3_0_mc_resume(struct
> amdgpu_device *adev, int idx)
>        }
>
>        WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> -
> -     WREG32_P(mmVCE_SYS_INT_EN,
> VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK,
> -
> ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
> +     WREG32_FIELD(VCE_SYS_INT_EN,
> VCE_SYS_INT_TRAP_INTERRUPT_EN, 1);
>  }
>
>  static bool vce_v3_0_is_idle(void *handle)
> @@ -599,7 +555,6 @@ static int vce_v3_0_check_soft_reset(void *handle)
>  {
>        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>        u32 srbm_soft_reset =3D 0;
> -     u32 tmp;
>
>        /* According to VCE team , we should use VCE_STATUS instead
>         * SRBM_STATUS.VCE_BUSY bit for busy status checking.
> @@ -614,23 +569,17 @@ static int vce_v3_0_check_soft_reset(void
> *handle)
>         *
>         * VCE team suggest use bit 3--bit 6 for busy status check
>         */
> -     tmp =3D RREG32(mmGRBM_GFX_INDEX);
> -     tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_INDEX, INSTANCE_INDEX,
> 0);
> -     WREG32(mmGRBM_GFX_INDEX, tmp);
> +     WREG32_FIELD(GRBM_GFX_INDEX, INSTANCE_INDEX, 0);
>        if (RREG32(mmVCE_STATUS) &
> AMDGPU_VCE_STATUS_BUSY_MASK) {
>                srbm_soft_reset =3D REG_SET_FIELD(srbm_soft_reset,
> SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);
>                srbm_soft_reset =3D REG_SET_FIELD(srbm_soft_reset,
> SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);
>        }
> -     tmp =3D RREG32(mmGRBM_GFX_INDEX);
> -     tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_INDEX, INSTANCE_INDEX,
> 0x10);
> -     WREG32(mmGRBM_GFX_INDEX, tmp);
> +     WREG32_FIELD(GRBM_GFX_INDEX, INSTANCE_INDEX, 0x10);
>        if (RREG32(mmVCE_STATUS) &
> AMDGPU_VCE_STATUS_BUSY_MASK) {
>                srbm_soft_reset =3D REG_SET_FIELD(srbm_soft_reset,
> SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);
>                srbm_soft_reset =3D REG_SET_FIELD(srbm_soft_reset,
> SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);
>        }
> -     tmp =3D RREG32(mmGRBM_GFX_INDEX);
> -     tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_INDEX, INSTANCE_INDEX,
> 0);
> -     WREG32(mmGRBM_GFX_INDEX, tmp);
> +     WREG32_FIELD(GRBM_GFX_INDEX, INSTANCE_INDEX, 0);
>
>        if (srbm_soft_reset) {
>                adev->ip_block_status[AMD_IP_BLOCK_TYPE_VCE].hang =3D
> true;
> @@ -718,9 +667,7 @@ static int vce_v3_0_process_interrupt(struct
> amdgpu_device *adev,
>  {
>        DRM_DEBUG("IH: VCE\n");
>
> -     WREG32_P(mmVCE_SYS_INT_STATUS,
> -
>        VCE_SYS_INT_STATUS__VCE_SYS_INT_TRAP_INTERRUPT_INT_MAS
> K,
> -
>        ~VCE_SYS_INT_STATUS__VCE_SYS_INT_TRAP_INTERRUPT_INT_MA
> SK);
> +     WREG32_FIELD(VCE_SYS_INT_STATUS,
> VCE_SYS_INT_TRAP_INTERRUPT_INT, 1);
>
>        switch (entry->src_data) {
>        case 0:
> @@ -767,13 +714,7 @@ static int vce_v3_0_set_clockgating_state(void
> *handle,
>                if (adev->vce.harvest_config & (1 << i))
>                        continue;
>
> -             if (i =3D=3D 0)
> -                     WREG32_P(mmGRBM_GFX_INDEX, 0,
> -
>        ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);
> -             else
> -                     WREG32_P(mmGRBM_GFX_INDEX,
> -
>        GRBM_GFX_INDEX__VCE_INSTANCE_MASK,
> -
>        ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);
> +             WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANCE, i);
>
>                if (enable) {
>                        /* initialize VCE_CLOCK_GATING_A: Clock ON/OFF
> delay */
> @@ -792,7 +733,7 @@ static int vce_v3_0_set_clockgating_state(void
> *handle,
>                vce_v3_0_set_vce_sw_clock_gating(adev, enable);
>        }
>
> -     WREG32_P(mmGRBM_GFX_INDEX, 0,
> ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);
> +     WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANCE, 0);
>        mutex_unlock(&adev->grbm_idx_mutex);
>
>        return 0;
> --
> 2.9.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1132BAFCCA55629CE9C893A2F71E0DM5PR12MB1132namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Sorta. &nbsp;The switch from gate/ungate for instance is kinda mutually =
exclusive. &nbsp;The device won't be gated when calling gate or ungated whe=
n calling ungate. &nbsp;The other conditional writes are similar.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<=
br>
<b>Sent:</b> Thursday, August 11, 2016 11:41<br>
<b>To:</b> 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> RE: [PATCH 1/4] drm/amd/amdgpu: Cleanup register access in =
VCE v3</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Tom St Denis<br>
&gt; Sent: Thursday, August 11, 2016 10:33 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: StDenis, Tom<br>
&gt; Subject: [PATCH 1/4] drm/amd/amdgpu: Cleanup register access in VCE v3=
<br>
&gt; <br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
This potentially adds a bunch of unnecessary register writes which increase=
s latency on VCE power up.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 145 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;-----------------<br>
&gt; -------<br>
&gt;&nbsp; 1 file changed, 43 insertions(&#43;), 102 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; index 7e6bb45658f6..073cf9ed0674 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; @@ -110,22 &#43;110,13 @@ static void vce_v3_0_ring_set_wptr(struct<br=
>
&gt; amdgpu_ring *ring)<br>
&gt; <br>
&gt;&nbsp; static void vce_v3_0_override_vce_clock_gating(struct amdgpu_dev=
ice<br>
&gt; *adev, bool override)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp, data;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D data =3D RREG32(mmVCE_RB_ARB_CTRL);<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (override)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D VCE_RB_ARB_CTRL__VCE_CGTT_OVERRIDE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D<br>
&gt; ~VCE_RB_ARB_CTRL__VCE_CGTT_OVERRIDE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmVCE_RB_ARB_CTRL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(VCE_RB_ARB_CTRL, VCE_CGTT_O=
VERRIDE, override<br>
&gt; ? 1 : 0);<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; static void vce_v3_0_set_vce_sw_clock_gating(struct amdgpu_devic=
e<br>
&gt; *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gated)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp, data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set Override to disable C=
lock Gating */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_override_vce_clock_=
gating(adev, true);<br>
&gt; @@ -136,65 &#43;127,55 @@ static void<br>
&gt; vce_v3_0_set_vce_sw_clock_gating(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fly as nec=
essary.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gated) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_CLOCK_GATING_B);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_CLOCK_GATING_B);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D 0x1ff;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data &amp;=3D ~0xef0000;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_CLOCK_GATI=
NG_B, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_CLOCK_GATING_B, data);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_UENC_CLOCK_GATING);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D 0x3ff000;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data &amp;=3D ~0xffc00000;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_CLOCK=
_GATING, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_UENC_CLOCK_GATING, data);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D 0x2;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data &amp;=3D ~0x00010000;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_CLOCK=
_GATING_2, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_UENC_CLOCK_GATING_2, data);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D 0x37f;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_REG_C=
LOCK_GATING,<br>
&gt; data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_UENC_REG_CLOCK_GATING, data);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_UENC_DMA_DCLK_CTRL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_UENC_DMA_DCLK_CTRL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D<br>
&gt; VCE_UENC_DMA_DCLK_CTRL__WRDMCLK_FORCEON_MASK |<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCE_UENC_DMA_DCLK_CTRL__RDDM=
CLK_FORCEON_MASK |<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCE_UENC_DMA_DCLK_CTRL__REGC=
LK_FORCEON_MASK&nbsp; |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8;<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_DMA_D=
CLK_CTRL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_UENC_DMA_DCLK_CTRL, data);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_CLOCK_GATING_B);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_CLOCK_GATING_B);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data &amp;=3D ~0x80010;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D 0xe70008;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_CLOCK_GATI=
NG_B, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_CLOCK_GATING_B, data);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_UENC_CLOCK_GATING);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D 0xffc00000;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_CLOCK=
_GATING, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_UENC_CLOCK_GATING, data);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_UENC_CLOCK_GATING_2);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data |=3D 0x10000;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_CLOCK=
_GATING_2, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_UENC_CLOCK_GATING_2, data);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_UENC_REG_CLOCK_GATING);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data &amp;=3D ~0xffc00000;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_REG_C=
LOCK_GATING,<br>
&gt; data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_UENC_REG_CLOCK_GATING, data);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; tmp =3D data =3D RREG32(mmVCE_UENC_DMA_DCLK_CTRL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D RREG32(mmVCE_UENC_DMA_DCLK_CTRL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data &amp;=3D<br>
&gt; ~(VCE_UENC_DMA_DCLK_CTRL__WRDMCLK_FORCEON_MASK |<br>
&gt; <br>
&gt; VCE_UENC_DMA_DCLK_CTRL__RDDMCLK_FORCEON_MASK |<br>
&gt; <br>
&gt; VCE_UENC_DMA_DCLK_CTRL__REGCLK_FORCEON_MASK&nbsp; |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x8);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (tmp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_UENC_DMA_D=
CLK_CTRL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmVCE_UENC_DMA_DCLK_CTRL, data);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_override_vce_clock_=
gating(adev, false);<br>
&gt;&nbsp; }<br>
&gt; @@ -213,12 &#43;194,9 @@ static int vce_v3_0_firmware_loaded(struct<br=
>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;VCE not responding, trying to reset the=
<br>
&gt; ECPU!!!\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCE_SOFT_RESET__ECPU_SO=
FT_RESET_MASK,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_SOFT_RESET__ECPU_S=
OFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mdelay(10);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_SOFT_RESET__ECPU_S=
OFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mdelay(10);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; @@ -256,34 &#43;234,22 @@ static int vce_v3_0_start(struct amdgpu_devi=
ce<br>
&gt; *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;vce.harvest_config &amp; (1 &lt;&lt; idx))=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (idx =3D=3D 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmGRBM_GFX_IND=
EX, 0,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~GRBM_GFX_INDEX__VCE_INSTANC=
E_MASK);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmGRBM_GFX_IND=
EX,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; GRBM_GFX_INDEX__VCE_INSTANCE_MASK,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~GRBM_GFX_INDEX__VCE_INSTANC=
E_MASK);<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANCE, idx);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vce_v3_0_mc_resume(adev, idx);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_STATUS,<br>
&gt; VCE_STATUS__JOB_BUSY_MASK,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_STATUS__JOB_=
BUSY_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_STATUS, JOB_BUSY, 1);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_STONEY)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_=
P(mmVCE_VCPU_CNTL, 1, ~0x200001);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_VCPU_CNT=
L,<br>
&gt; VCE_VCPU_CNTL__CLK_EN_MASK,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_VCPU_CNTL__CLK_EN_MASK);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_SOFT_RESET__ECPU_S=
OFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(VCE_VC=
PU_CNTL, CLK_EN, 1);<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mdelay(100);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D vce_v3_0_firmware_loaded(adev);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* clear BUSY flag */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_STATUS, 0,<br>
&gt; ~VCE_STATUS__JOB_BUSY_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_STATUS, JOB_BUSY, 0);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;VCE not responding, giving up!!!\n&quot;);<br>
&gt; @@ -292,7 &#43;258,7 @@ static int vce_v3_0_start(struct amdgpu_device=
<br>
&gt; *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmGRBM_GFX_INDEX, 0,<br>
&gt; ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANC=
E, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -307,33 &#43;273,25 @@ static int vce_v3_0_stop(struct amdgpu_devic=
e<br>
&gt; *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;vce.harvest_config &amp; (1 &lt;&lt; idx))=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (idx =3D=3D 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmGRBM_GFX_IND=
EX, 0,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~GRBM_GFX_INDEX__VCE_INSTANC=
E_MASK);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmGRBM_GFX_IND=
EX,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; GRBM_GFX_INDEX__VCE_INSTANCE_MASK,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~GRBM_GFX_INDEX__VCE_INSTANC=
E_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANCE, idx);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_STONEY)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_=
P(mmVCE_VCPU_CNTL, 0, ~0x200001);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_VCPU_CNT=
L, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_VCPU_CNTL__CLK_EN_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(VCE_VC=
PU_CNTL, CLK_EN, 0);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* hold on ECPU */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_SOFT_RESET,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCE_SOFT_RESET__E=
CPU_SOFT_RESET_MASK,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_SOFT_RESET__=
ECPU_SOFT_RESET_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* clear BUSY flag */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_P(mmVCE_STATUS, 0,<br>
&gt; ~VCE_STATUS__JOB_BUSY_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(VCE_STATUS, JOB_BUSY, 0);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Set Clock-Gating off */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCE_MGCG)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_=
0_set_vce_sw_clock_gating(adev, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmGRBM_GFX_INDEX, 0,<br>
&gt; ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANC=
E, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -561,9 &#43;519,7 @@ static void vce_v3_0_mc_resume(struct<br>
&gt; amdgpu_device *adev, int idx)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_LMI_CTRL2, 0x=
0, ~0x100);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_SYS_INT_EN,<br>
&gt; VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK,<br>
&gt; -<br>
&gt; ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(VCE_SYS_INT_EN,<br>
&gt; VCE_SYS_INT_TRAP_INTERRUPT_EN, 1);<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; static bool vce_v3_0_is_idle(void *handle)<br>
&gt; @@ -599,7 &#43;555,6 @@ static int vce_v3_0_check_soft_reset(void *han=
dle)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)handle;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 srbm_soft_reset =3D 0;<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* According to VCE team , w=
e should use VCE_STATUS instead<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SRBM_STATUS.VCE_BUSY=
 bit for busy status checking.<br>
&gt; @@ -614,23 &#43;569,17 @@ static int vce_v3_0_check_soft_reset(void<br=
>
&gt; *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VCE team suggest use=
 bit 3--bit 6 for busy status check<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmGRBM_GFX_INDEX);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_INDEX, I=
NSTANCE_INDEX,<br>
&gt; 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRBM_GFX_INDEX, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(GRBM_GFX_INDEX, INSTANCE_IN=
DEX, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32(mmVCE_STATUS) &am=
p;<br>
&gt; AMDGPU_VCE_STATUS_BUSY_MASK) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; srbm_soft_reset =3D REG_SET_FIELD(srbm_soft_reset,<br>
&gt; SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; srbm_soft_reset =3D REG_SET_FIELD(srbm_soft_reset,<br>
&gt; SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmGRBM_GFX_INDEX);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_INDEX, I=
NSTANCE_INDEX,<br>
&gt; 0x10);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRBM_GFX_INDEX, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(GRBM_GFX_INDEX, INSTANCE_IN=
DEX, 0x10);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (RREG32(mmVCE_STATUS) &am=
p;<br>
&gt; AMDGPU_VCE_STATUS_BUSY_MASK) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; srbm_soft_reset =3D REG_SET_FIELD(srbm_soft_reset,<br>
&gt; SRBM_SOFT_RESET, SOFT_RESET_VCE0, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; srbm_soft_reset =3D REG_SET_FIELD(srbm_soft_reset,<br>
&gt; SRBM_SOFT_RESET, SOFT_RESET_VCE1, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmGRBM_GFX_INDEX);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GRBM_GFX_INDEX, I=
NSTANCE_INDEX,<br>
&gt; 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRBM_GFX_INDEX, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(GRBM_GFX_INDEX, INSTANCE_IN=
DEX, 0);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (srbm_soft_reset) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;ip_block_status[AMD_IP_BLOCK_TYPE_VCE].hang =
=3D<br>
&gt; true;<br>
&gt; @@ -718,9 &#43;667,7 @@ static int vce_v3_0_process_interrupt(struct<b=
r>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;IH: VCE\n&qu=
ot;);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmVCE_SYS_INT_STATUS,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VCE_SYS_INT_STATUS__VCE_SYS_=
INT_TRAP_INTERRUPT_INT_MAS<br>
&gt; K,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~VCE_SYS_INT_STATUS__VCE_SYS=
_INT_TRAP_INTERRUPT_INT_MA<br>
&gt; SK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(VCE_SYS_INT_STATUS,<br>
&gt; VCE_SYS_INT_TRAP_INTERRUPT_INT, 1);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (entry-&gt;src_data) =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
&gt; @@ -767,13 &#43;714,7 @@ static int vce_v3_0_set_clockgating_state(voi=
d<br>
&gt; *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;vce.harvest_config &amp; (1 &lt;&lt; i))<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (i =3D=3D 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmGRBM_GFX_IND=
EX, 0,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~GRBM_GFX_INDEX__VCE_INSTANC=
E_MASK);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmGRBM_GFX_IND=
EX,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GRBM_GFX_INDEX__VCE_INSTANCE=
_MASK,<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~GRBM_GFX_INDEX__VCE_INSTANC=
E_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANCE, i);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init=
ialize VCE_CLOCK_GATING_A: Clock ON/OFF<br>
&gt; delay */<br>
&gt; @@ -792,7 &#43;733,7 @@ static int vce_v3_0_set_clockgating_state(void=
<br>
&gt; *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vce_v3_0_set_vce_sw_clock_gating(adev, enable);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(mmGRBM_GFX_INDEX, 0,<br>
&gt; ~GRBM_GFX_INDEX__VCE_INSTANCE_MASK);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(GRBM_GFX_INDEX, VCE_INSTANC=
E, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; --<br>
&gt; 2.9.2<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1132BAFCCA55629CE9C893A2F71E0DM5PR12MB1132namp_--

--===============0775023811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0775023811==--
