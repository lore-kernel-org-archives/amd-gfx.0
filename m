From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Simplify bitfield operations in gfx v8
Date: Tue, 9 Aug 2016 15:28:07 +0000
Message-ID: <DM5PR12MB113283968678F567DACB84A6F71C0@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160809142739.1401-1-tom.stdenis@amd.com>
 <20160809142739.1401-4-tom.stdenis@amd.com>,
 <dc95cc72-5e8e-6c5e-7c87-979d838652e7@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1986214651=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dc95cc72-5e8e-6c5e-7c87-979d838652e7-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1986214651==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB113283968678F567DACB84A6F71C0DM5PR12MB1132namp_"

--_000_DM5PR12MB113283968678F567DACB84A6F71C0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Probably could but I felt that implementation was cleaner.


Tom


________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Tuesday, August 9, 2016 10:56
To: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Simplify bitfield operations in gf=
x v8

Am 09.08.2016 um 16:27 schrieb Tom St Denis:
> This patch introduces a new macro WREG32_FIELD which is used
> to write to a register with a new value in a field.  It's designed
> to replace the pattern:
>
> tmp =3D RREG32(mmFoo);
> tmp &=3D ~REG__FIELD_MASK;
> tmp |=3D new_value << REG__FIELD__SHIFT;
> WREG32(mmFoo, tmp)
>
> with:
>
> WREG32_FIELD(Foo, FIELD, new_value);
>
> Unlike WREG32_P() it understands offsets/masks and doesn't
> require the caller to shift the value (or mask properly).
>
> It's applied where suitable in the gfx_v8_0.c driver to start
> with.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |   3 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 275 ++++++---------------------=
-------
>   2 files changed, 48 insertions(+), 230 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index c309eaf468e9..f23eb38eb3aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -2218,6 +2218,9 @@ bool amdgpu_device_has_dal_support(struct amdgpu_de=
vice *adev);
>   #define REG_GET_FIELD(value, reg, field)                            \
>        (((value) & REG_FIELD_MASK(reg, field)) >> REG_FIELD_SHIFT(reg, fi=
eld))
>
> +#define WREG32_FIELD(reg, field, val)        \
> +     WREG32(mm##reg, (RREG32(mm##reg) & ~REG_FIELD_MASK(reg, field)) | (=
val) << REG_FIELD_SHIFT(reg, field))

Couldn't you use WREG32_P here to implement the new macro?

Christian.

> +
>   /*
>    * BIOS helpers.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 5f91a834aed2..6e01392facef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -3566,10 +3566,7 @@ static void gfx_v8_0_gpu_init(struct amdgpu_device=
 *adev)
>        u32 tmp;
>        int i;
>
> -     tmp =3D RREG32(mmGRBM_CNTL);
> -     tmp =3D REG_SET_FIELD(tmp, GRBM_CNTL, READ_TIMEOUT, 0xff);
> -     WREG32(mmGRBM_CNTL, tmp);
> -
> +     WREG32_FIELD(GRBM_CNTL, READ_TIMEOUT, 0xFF);
>        WREG32(mmGB_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
>        WREG32(mmHDP_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
>        WREG32(mmDMIF_ADDR_CALC, adev->gfx.config.gb_addr_config);
> @@ -3758,9 +3755,7 @@ static int gfx_v8_0_init_save_restore_list(struct a=
mdgpu_device *adev)
>                                sizeof(indirect_start_offsets)/sizeof(int)=
);
>
>        /* save and restore list */
> -     temp =3D RREG32(mmRLC_SRM_CNTL);
> -     temp |=3D RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
> -     WREG32(mmRLC_SRM_CNTL, temp);
> +     WREG32_FIELD(RLC_SRM_CNTL, AUTO_INCR_ADDR, 1);
>
>        WREG32(mmRLC_SRM_ARAM_ADDR, 0);
>        for (i =3D 0; i < adev->gfx.rlc.reg_list_size_bytes >> 2; i++)
> @@ -3797,11 +3792,7 @@ static int gfx_v8_0_init_save_restore_list(struct =
amdgpu_device *adev)
>
>   static void gfx_v8_0_enable_save_restore_machine(struct amdgpu_device *=
adev)
>   {
> -     uint32_t data;
> -
> -     data =3D RREG32(mmRLC_SRM_CNTL);
> -     data |=3D RLC_SRM_CNTL__SRM_ENABLE_MASK;
> -     WREG32(mmRLC_SRM_CNTL, data);
> +     WREG32_FIELD(RLC_SRM_CNTL, SRM_ENABLE, 1);
>   }
>
>   static void gfx_v8_0_init_power_gating(struct amdgpu_device *adev)
> @@ -3811,75 +3802,34 @@ static void gfx_v8_0_init_power_gating(struct amd=
gpu_device *adev)
>        if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_PG |
>                              AMD_PG_SUPPORT_GFX_SMG |
>                              AMD_PG_SUPPORT_GFX_DMG)) {
> -             data =3D RREG32(mmCP_RB_WPTR_POLL_CNTL);
> -             data &=3D ~CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT_MASK;
> -             data |=3D (0x60 << CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__S=
HIFT);
> -             WREG32(mmCP_RB_WPTR_POLL_CNTL, data);
> -
> -             data =3D 0;
> -             data |=3D (0x10 << RLC_PG_DELAY__POWER_UP_DELAY__SHIFT);
> -             data |=3D (0x10 << RLC_PG_DELAY__POWER_DOWN_DELAY__SHIFT);
> -             data |=3D (0x10 << RLC_PG_DELAY__CMD_PROPAGATE_DELAY__SHIFT=
);
> -             data |=3D (0x10 << RLC_PG_DELAY__MEM_SLEEP_DELAY__SHIFT);
> -             WREG32(mmRLC_PG_DELAY, data);
> +             WREG32_FIELD(CP_RB_WPTR_POLL_CNTL, IDLE_POLL_COUNT, 0x60);
>
> -             data =3D RREG32(mmRLC_PG_DELAY_2);
> -             data &=3D ~RLC_PG_DELAY_2__SERDES_CMD_DELAY_MASK;
> -             data |=3D (0x3 << RLC_PG_DELAY_2__SERDES_CMD_DELAY__SHIFT);
> -             WREG32(mmRLC_PG_DELAY_2, data);
> +             data =3D REG_SET_FIELD(0, RLC_PG_DELAY, POWER_UP_DELAY, 0x1=
0);
> +             data =3D REG_SET_FIELD(data, RLC_PG_DELAY, POWER_DOWN_DELAY=
, 0x10);
> +             data =3D REG_SET_FIELD(data, RLC_PG_DELAY, CMD_PROPAGATE_DE=
LAY, 0x10);
> +             data =3D REG_SET_FIELD(data, RLC_PG_DELAY, MEM_SLEEP_DELAY,=
 0x10);
> +             WREG32(mmRLC_PG_DELAY, data);
>
> -             data =3D RREG32(mmRLC_AUTO_PG_CTRL);
> -             data &=3D ~RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHO=
LD_MASK;
> -             data |=3D (0x55f0 << RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_ID=
LE_THRESHOLD__SHIFT);
> -             WREG32(mmRLC_AUTO_PG_CTRL, data);
> +             WREG32_FIELD(RLC_PG_DELAY_2, SERDES_CMD_DELAY, 0x3);
> +             WREG32_FIELD(RLC_AUTO_PG_CTRL, GRBM_REG_SAVE_GFX_IDLE_THRES=
HOLD, 0x55f0);
>        }
>   }
>
>   static void cz_enable_sck_slow_down_on_power_up(struct amdgpu_device *a=
dev,
>                                                bool enable)
>   {
> -     u32 data, orig;
> -
> -     orig =3D data =3D RREG32(mmRLC_PG_CNTL);
> -
> -     if (enable)
> -             data |=3D RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PU_ENABLE_MASK;
> -     else
> -             data &=3D ~RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PU_ENABLE_MASK;
> -
> -     if (orig !=3D data)
> -             WREG32(mmRLC_PG_CNTL, data);
> +     WREG32_FIELD(RLC_PG_CNTL, SMU_CLK_SLOWDOWN_ON_PU_ENABLE, enable ? 1=
 : 0);
>   }
>
>   static void cz_enable_sck_slow_down_on_power_down(struct amdgpu_device =
*adev,
>                                                  bool enable)
>   {
> -     u32 data, orig;
> -
> -     orig =3D data =3D RREG32(mmRLC_PG_CNTL);
> -
> -     if (enable)
> -             data |=3D RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PD_ENABLE_MASK;
> -     else
> -             data &=3D ~RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PD_ENABLE_MASK;
> -
> -     if (orig !=3D data)
> -             WREG32(mmRLC_PG_CNTL, data);
> +     WREG32_FIELD(RLC_PG_CNTL, SMU_CLK_SLOWDOWN_ON_PD_ENABLE, enable ? 1=
 : 0);
>   }
>
>   static void cz_enable_cp_power_gating(struct amdgpu_device *adev, bool =
enable)
>   {
> -     u32 data, orig;
> -
> -     orig =3D data =3D RREG32(mmRLC_PG_CNTL);
> -
> -     if (enable)
> -             data &=3D ~RLC_PG_CNTL__CP_PG_DISABLE_MASK;
> -     else
> -             data |=3D RLC_PG_CNTL__CP_PG_DISABLE_MASK;
> -
> -     if (orig !=3D data)
> -             WREG32(mmRLC_PG_CNTL, data);
> +     WREG32_FIELD(RLC_PG_CNTL, CP_PG_DISABLE, enable ? 1 : 0);
>   }
>
>   static void gfx_v8_0_init_pg(struct amdgpu_device *adev)
> @@ -3918,34 +3868,24 @@ static void gfx_v8_0_init_pg(struct amdgpu_device=
 *adev)
>
>   void gfx_v8_0_rlc_stop(struct amdgpu_device *adev)
>   {
> -     u32 tmp =3D RREG32(mmRLC_CNTL);
> -
> -     tmp =3D REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
> -     WREG32(mmRLC_CNTL, tmp);
> +     WREG32_FIELD(RLC_CNTL, RLC_ENABLE_F32, 0);
>
>        gfx_v8_0_enable_gui_idle_interrupt(adev, false);
> -
>        gfx_v8_0_wait_for_rlc_serdes(adev);
>   }
>
>   static void gfx_v8_0_rlc_reset(struct amdgpu_device *adev)
>   {
> -     u32 tmp =3D RREG32(mmGRBM_SOFT_RESET);
> -
> -     tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
> -     WREG32(mmGRBM_SOFT_RESET, tmp);
> +     WREG32_FIELD(GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
>        udelay(50);
> -     tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
> -     WREG32(mmGRBM_SOFT_RESET, tmp);
> +
> +     WREG32_FIELD(GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
>        udelay(50);
>   }
>
>   static void gfx_v8_0_rlc_start(struct amdgpu_device *adev)
>   {
> -     u32 tmp =3D RREG32(mmRLC_CNTL);
> -
> -     tmp =3D REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 1);
> -     WREG32(mmRLC_CNTL, tmp);
> +     WREG32_FIELD(RLC_CNTL, RLC_ENABLE_F32, 1);
>
>        /* carrizo do enable cp interrupt after cp inited */
>        if (!(adev->flags & AMD_IS_APU))
> @@ -5371,8 +5311,6 @@ static int gfx_v8_0_late_init(void *handle)
>   static void gfx_v8_0_enable_gfx_static_mg_power_gating(struct amdgpu_de=
vice *adev,
>                                                       bool enable)
>   {
> -     uint32_t data, temp;
> -
>        if (adev->asic_type =3D=3D CHIP_POLARIS11)
>                /* Send msg to SMU via Powerplay */
>                amdgpu_set_powergating_state(adev,
> @@ -5380,83 +5318,35 @@ static void gfx_v8_0_enable_gfx_static_mg_power_g=
ating(struct amdgpu_device *ade
>                                             enable ?
>                                             AMD_PG_STATE_GATE : AMD_PG_ST=
ATE_UNGATE);
>
> -     temp =3D data =3D RREG32(mmRLC_PG_CNTL);
> -     /* Enable static MGPG */
> -     if (enable)
> -             data |=3D RLC_PG_CNTL__STATIC_PER_CU_PG_ENABLE_MASK;
> -     else
> -             data &=3D ~RLC_PG_CNTL__STATIC_PER_CU_PG_ENABLE_MASK;
> -
> -     if (temp !=3D data)
> -             WREG32(mmRLC_PG_CNTL, data);
> +     WREG32_FIELD(RLC_PG_CNTL, STATIC_PER_CU_PG_ENABLE, enable ? 1 : 0);
>   }
>
>   static void gfx_v8_0_enable_gfx_dynamic_mg_power_gating(struct amdgpu_d=
evice *adev,
>                                                        bool enable)
>   {
> -     uint32_t data, temp;
> -
> -     temp =3D data =3D RREG32(mmRLC_PG_CNTL);
> -     /* Enable dynamic MGPG */
> -     if (enable)
> -             data |=3D RLC_PG_CNTL__DYN_PER_CU_PG_ENABLE_MASK;
> -     else
> -             data &=3D ~RLC_PG_CNTL__DYN_PER_CU_PG_ENABLE_MASK;
> -
> -     if (temp !=3D data)
> -             WREG32(mmRLC_PG_CNTL, data);
> +     WREG32_FIELD(RLC_PG_CNTL, DYN_PER_CU_PG_ENABLE, enable ? 1 : 0);
>   }
>
>   static void polaris11_enable_gfx_quick_mg_power_gating(struct amdgpu_de=
vice *adev,
>                bool enable)
>   {
> -     uint32_t data, temp;
> -
> -     temp =3D data =3D RREG32(mmRLC_PG_CNTL);
> -     /* Enable quick PG */
> -     if (enable)
> -             data |=3D RLC_PG_CNTL__QUICK_PG_ENABLE_MASK;
> -     else
> -             data &=3D ~RLC_PG_CNTL__QUICK_PG_ENABLE_MASK;
> -
> -     if (temp !=3D data)
> -             WREG32(mmRLC_PG_CNTL, data);
> +     WREG32_FIELD(RLC_PG_CNTL, QUICK_PG_ENABLE, enable ? 1 : 0);
>   }
>
>   static void cz_enable_gfx_cg_power_gating(struct amdgpu_device *adev,
>                                          bool enable)
>   {
> -     u32 data, orig;
> -
> -     orig =3D data =3D RREG32(mmRLC_PG_CNTL);
> -
> -     if (enable)
> -             data |=3D RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> -     else
> -             data &=3D ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> -
> -     if (orig !=3D data)
> -             WREG32(mmRLC_PG_CNTL, data);
> +     WREG32_FIELD(RLC_PG_CNTL, GFX_POWER_GATING_ENABLE, enable ? 1 : 0);
>   }
>
>   static void cz_enable_gfx_pipeline_power_gating(struct amdgpu_device *a=
dev,
>                                                bool enable)
>   {
> -     u32 data, orig;
> -
> -     orig =3D data =3D RREG32(mmRLC_PG_CNTL);
> -
> -     if (enable)
> -             data |=3D RLC_PG_CNTL__GFX_PIPELINE_PG_ENABLE_MASK;
> -     else
> -             data &=3D ~RLC_PG_CNTL__GFX_PIPELINE_PG_ENABLE_MASK;
> -
> -     if (orig !=3D data)
> -             WREG32(mmRLC_PG_CNTL, data);
> +     WREG32_FIELD(RLC_PG_CNTL, GFX_PIPELINE_PG_ENABLE, enable ? 1 : 0);
>
>        /* Read any GFX register to wake up GFX. */
>        if (!enable)
> -             data =3D RREG32(mmDB_RENDER_CONTROL);
> +             RREG32(mmDB_RENDER_CONTROL);
>   }
>
>   static void cz_update_gfx_cg_power_gating(struct amdgpu_device *adev,
> @@ -5563,10 +5453,10 @@ static void gfx_v8_0_send_serdes_cmd(struct amdgp=
u_device *adev,
>
>   #define MSG_ENTER_RLC_SAFE_MODE     1
>   #define MSG_EXIT_RLC_SAFE_MODE      0
> -
> -#define RLC_GPR_REG2__REQ_MASK           0x00000001
> -#define RLC_GPR_REG2__MESSAGE__SHIFT     0x00000001
> -#define RLC_GPR_REG2__MESSAGE_MASK       0x0000001e
> +#define RLC_GPR_REG2__REQ_MASK 0x00000001
> +#define RLC_GPR_REG2__REQ__SHIFT 0
> +#define RLC_GPR_REG2__MESSAGE__SHIFT 0x00000001
> +#define RLC_GPR_REG2__MESSAGE_MASK 0x0000001e
>
>   static void cz_enter_rlc_safe_mode(struct amdgpu_device *adev)
>   {
> @@ -5596,7 +5486,7 @@ static void cz_enter_rlc_safe_mode(struct amdgpu_de=
vice *adev)
>                }
>
>                for (i =3D 0; i < adev->usec_timeout; i++) {
> -                     if ((RREG32(mmRLC_GPR_REG2) & RLC_GPR_REG2__REQ_MAS=
K) =3D=3D 0)
> +                     if (!REG_GET_FIELD(RREG32(mmRLC_GPR_REG2), RLC_GPR_=
REG2, REQ))
>                                break;
>                        udelay(1);
>                }
> @@ -5624,7 +5514,7 @@ static void cz_exit_rlc_safe_mode(struct amdgpu_dev=
ice *adev)
>        }
>
>        for (i =3D 0; i < adev->usec_timeout; i++) {
> -             if ((RREG32(mmRLC_GPR_REG2) & RLC_GPR_REG2__REQ_MASK) =3D=
=3D 0)
> +             if (!REG_GET_FIELD(RREG32(mmRLC_GPR_REG2), RLC_GPR_REG2, RE=
Q))
>                        break;
>                udelay(1);
>        }
> @@ -5656,7 +5546,7 @@ static void iceland_enter_rlc_safe_mode(struct amdg=
pu_device *adev)
>                }
>
>                for (i =3D 0; i < adev->usec_timeout; i++) {
> -                     if ((RREG32(mmRLC_SAFE_MODE) & RLC_SAFE_MODE__CMD_M=
ASK) =3D=3D 0)
> +                     if (!REG_GET_FIELD(RREG32(mmRLC_SAFE_MODE), RLC_SAF=
E_MODE, CMD))
>                                break;
>                        udelay(1);
>                }
> @@ -5683,7 +5573,7 @@ static void iceland_exit_rlc_safe_mode(struct amdgp=
u_device *adev)
>        }
>
>        for (i =3D 0; i < adev->usec_timeout; i++) {
> -             if ((RREG32(mmRLC_SAFE_MODE) & RLC_SAFE_MODE__CMD_MASK) =3D=
=3D 0)
> +             if (!REG_GET_FIELD(RREG32(mmRLC_SAFE_MODE), RLC_SAFE_MODE, =
CMD))
>                        break;
>                udelay(1);
>        }
> @@ -5724,21 +5614,12 @@ static void gfx_v8_0_update_medium_grain_clock_ga=
ting(struct amdgpu_device *adev
>        /* It is disabled by HW by default */
>        if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
>                if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
> -                     if (adev->cg_flags & AMD_CG_SUPPORT_GFX_RLC_LS) {
> +                     if (adev->cg_flags & AMD_CG_SUPPORT_GFX_RLC_LS)
>                                /* 1 - RLC memory Light sleep */
> -                             temp =3D data =3D RREG32(mmRLC_MEM_SLP_CNTL=
);
> -                             data |=3D RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_M=
ASK;
> -                             if (temp !=3D data)
> -                                     WREG32(mmRLC_MEM_SLP_CNTL, data);
> -                     }
> +                             WREG32_FIELD(RLC_MEM_SLP_CNTL, RLC_MEM_LS_E=
N, 1);
>
> -                     if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CP_LS) {
> -                             /* 2 - CP memory Light sleep */
> -                             temp =3D data =3D RREG32(mmCP_MEM_SLP_CNTL)=
;
> -                             data |=3D CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MAS=
K;
> -                             if (temp !=3D data)
> -                                     WREG32(mmCP_MEM_SLP_CNTL, data);
> -                     }
> +                     if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CP_LS)
> +                             WREG32_FIELD(CP_MEM_SLP_CNTL, CP_MEM_LS_EN,=
 1);
>                }
>
>                /* 3 - RLC_CGTT_MGCG_OVERRIDE */
> @@ -6213,33 +6094,14 @@ static void gfx_v8_0_ring_emit_fence_compute(stru=
ct amdgpu_ring *ring,
>   static void gfx_v8_0_set_gfx_eop_interrupt_state(struct amdgpu_device *=
adev,
>                                                 enum amdgpu_interrupt_sta=
te state)
>   {
> -     u32 cp_int_cntl;
> -
> -     switch (state) {
> -     case AMDGPU_IRQ_STATE_DISABLE:
> -             cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);
> -             cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING=
0,
> -                                         TIME_STAMP_INT_ENABLE, 0);
> -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> -             break;
> -     case AMDGPU_IRQ_STATE_ENABLE:
> -             cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);
> -             cp_int_cntl =3D
> -                     REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
> -                                   TIME_STAMP_INT_ENABLE, 1);
> -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> -             break;
> -     default:
> -             break;
> -     }
> +     WREG32_FIELD(CP_INT_CNTL_RING0, TIME_STAMP_INT_ENABLE,
> +                  state =3D=3D AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);
>   }
>
>   static void gfx_v8_0_set_compute_eop_interrupt_state(struct amdgpu_devi=
ce *adev,
>                                                     int me, int pipe,
>                                                     enum amdgpu_interrupt=
_state state)
>   {
> -     u32 mec_int_cntl, mec_int_cntl_reg;
> -
>        /*
>         * amdgpu controls only pipe 0 of MEC1. That's why this function o=
nly
>         * handles the setting of interrupts for this specific pipe. All o=
ther
> @@ -6249,7 +6111,6 @@ static void gfx_v8_0_set_compute_eop_interrupt_stat=
e(struct amdgpu_device *adev,
>        if (me =3D=3D 1) {
>                switch (pipe) {
>                case 0:
> -                     mec_int_cntl_reg =3D mmCP_ME1_PIPE0_INT_CNTL;
>                        break;
>                default:
>                        DRM_DEBUG("invalid pipe %d\n", pipe);
> @@ -6260,22 +6121,8 @@ static void gfx_v8_0_set_compute_eop_interrupt_sta=
te(struct amdgpu_device *adev,
>                return;
>        }
>
> -     switch (state) {
> -     case AMDGPU_IRQ_STATE_DISABLE:
> -             mec_int_cntl =3D RREG32(mec_int_cntl_reg);
> -             mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_I=
NT_CNTL,
> -                                          TIME_STAMP_INT_ENABLE, 0);
> -             WREG32(mec_int_cntl_reg, mec_int_cntl);
> -             break;
> -     case AMDGPU_IRQ_STATE_ENABLE:
> -             mec_int_cntl =3D RREG32(mec_int_cntl_reg);
> -             mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_I=
NT_CNTL,
> -                                          TIME_STAMP_INT_ENABLE, 1);
> -             WREG32(mec_int_cntl_reg, mec_int_cntl);
> -             break;
> -     default:
> -             break;
> -     }
> +     WREG32_FIELD(CP_ME1_PIPE0_INT_CNTL, TIME_STAMP_INT_ENABLE,
> +                  state =3D=3D AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);
>   }
>
>   static int gfx_v8_0_set_priv_reg_fault_state(struct amdgpu_device *adev=
,
> @@ -6283,24 +6130,8 @@ static int gfx_v8_0_set_priv_reg_fault_state(struc=
t amdgpu_device *adev,
>                                             unsigned type,
>                                             enum amdgpu_interrupt_state s=
tate)
>   {
> -     u32 cp_int_cntl;
> -
> -     switch (state) {
> -     case AMDGPU_IRQ_STATE_DISABLE:
> -             cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);
> -             cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING=
0,
> -                                         PRIV_REG_INT_ENABLE, 0);
> -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> -             break;
> -     case AMDGPU_IRQ_STATE_ENABLE:
> -             cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);
> -             cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING=
0,
> -                                         PRIV_REG_INT_ENABLE, 1);
> -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> -             break;
> -     default:
> -             break;
> -     }
> +     WREG32_FIELD(CP_INT_CNTL_RING0, PRIV_REG_INT_ENABLE,
> +                  state =3D=3D AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);
>
>        return 0;
>   }
> @@ -6310,24 +6141,8 @@ static int gfx_v8_0_set_priv_inst_fault_state(stru=
ct amdgpu_device *adev,
>                                              unsigned type,
>                                              enum amdgpu_interrupt_state =
state)
>   {
> -     u32 cp_int_cntl;
> -
> -     switch (state) {
> -     case AMDGPU_IRQ_STATE_DISABLE:
> -             cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);
> -             cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING=
0,
> -                                         PRIV_INSTR_INT_ENABLE, 0);
> -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> -             break;
> -     case AMDGPU_IRQ_STATE_ENABLE:
> -             cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);
> -             cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING=
0,
> -                                         PRIV_INSTR_INT_ENABLE, 1);
> -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> -             break;
> -     default:
> -             break;
> -     }
> +     WREG32_FIELD(CP_INT_CNTL_RING0, PRIV_INSTR_INT_ENABLE,
> +                  state =3D=3D AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);
>
>        return 0;
>   }



--_000_DM5PR12MB113283968678F567DACB84A6F71C0DM5PR12MB1132namp_
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
<p>Probably could but I felt that implementation was cleaner.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &=
lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, August 9, 2016 10:56<br>
<b>To:</b> Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/amdgpu: Simplify bitfield operation=
s in gfx v8</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Am 09.08.2016 um 16:27 schrieb Tom St Denis:<br>
&gt; This patch introduces a new macro WREG32_FIELD which is used<br>
&gt; to write to a register with a new value in a field.&nbsp; It's designe=
d<br>
&gt; to replace the pattern:<br>
&gt;<br>
&gt; tmp =3D RREG32(mmFoo);<br>
&gt; tmp &amp;=3D ~REG__FIELD_MASK;<br>
&gt; tmp |=3D new_value &lt;&lt; REG__FIELD__SHIFT;<br>
&gt; WREG32(mmFoo, tmp)<br>
&gt;<br>
&gt; with:<br>
&gt;<br>
&gt; WREG32_FIELD(Foo, FIELD, new_value);<br>
&gt;<br>
&gt; Unlike WREG32_P() it understands offsets/masks and doesn't<br>
&gt; require the caller to shift the value (or mask properly).<br>
&gt;<br>
&gt; It's applied where suitable in the gfx_v8_0.c driver to start<br>
&gt; with.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp; |&nbsp;&nb=
sp; 3 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 275 &#43;&#43;&#43=
;&#43;&#43;&#43;----------------------------<br>
&gt;&nbsp;&nbsp; 2 files changed, 48 insertions(&#43;), 230 deletions(-)<br=
>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index c309eaf468e9..f23eb38eb3aa 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -2218,6 &#43;2218,9 @@ bool amdgpu_device_has_dal_support(struct am=
dgpu_device *adev);<br>
&gt;&nbsp;&nbsp; #define REG_GET_FIELD(value, reg, field)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((value) &amp; REG_FIELD_MA=
SK(reg, field)) &gt;&gt; REG_FIELD_SHIFT(reg, field))<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;#define WREG32_FIELD(reg, field, val)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mm##reg, (RREG32(mm##reg) &amp; ~=
REG_FIELD_MASK(reg, field)) | (val) &lt;&lt; REG_FIELD_SHIFT(reg, field))<b=
r>
<br>
Couldn't you use WREG32_P here to implement the new macro?<br>
<br>
Christian.<br>
<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * BIOS helpers.<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v8_0.c<br>
&gt; index 5f91a834aed2..6e01392facef 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -3566,10 &#43;3566,7 @@ static void gfx_v8_0_gpu_init(struct amdgpu=
_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmGRBM_CNTL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GRBM_CNTL, READ_T=
IMEOUT, 0xff);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRBM_CNTL, tmp);<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(GRBM_CNTL, READ_TIMEOUT, 0x=
FF);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGB_ADDR_CONFIG, ade=
v-&gt;gfx.config.gb_addr_config);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmHDP_ADDR_CONFIG, ad=
ev-&gt;gfx.config.gb_addr_config);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmDMIF_ADDR_CALC, ade=
v-&gt;gfx.config.gb_addr_config);<br>
&gt; @@ -3758,9 &#43;3755,7 @@ static int gfx_v8_0_init_save_restore_list(s=
truct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(indirect_start_offsets)/siz=
eof(int));<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save and restore list */<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(mmRLC_SRM_CNTL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; temp |=3D RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_SRM_CNTL, temp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_SRM_CNTL, AUTO_INCR_ADD=
R, 1);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_SRM_ARAM_ADDR, =
0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;gfx.rlc.reg_list_size_bytes &gt;&gt; 2; i&#43;&#43;)<br>
&gt; @@ -3797,11 &#43;3792,7 @@ static int gfx_v8_0_init_save_restore_list(=
struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_enable_save_restore_machine(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32(mmRLC_SRM_CNTL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; data |=3D RLC_SRM_CNTL__SRM_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_SRM_CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_SRM_CNTL, SRM_ENABLE, 1=
);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_init_power_gating(struct amdgpu_devic=
e *adev)<br>
&gt; @@ -3811,75 &#43;3802,34 @@ static void gfx_v8_0_init_power_gating(str=
uct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp; =
(AMD_PG_SUPPORT_GFX_PG |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GFX_SMG |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GFX_DMG)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D RREG32(mmCP_RB_WPTR_POLL_CNTL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D (0x60 &lt;&lt; CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmCP_RB_WPTR_POLL_CNTL, data);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D (0x10 &lt;&lt; RLC_PG_DELAY__POWER_UP_DELAY__SHIFT);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D (0x10 &lt;&lt; RLC_PG_DELAY__POWER_DOWN_DELAY__SHIFT);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D (0x10 &lt;&lt; RLC_PG_DELAY__CMD_PROPAGATE_DELAY__SHIFT);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D (0x10 &lt;&lt; RLC_PG_DELAY__MEM_SLEEP_DELAY__SHIFT);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_DELAY, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(CP_RB_WPTR_POLL_CNTL, IDLE_POLL_COUNT, 0x60);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D RREG32(mmRLC_PG_DELAY_2);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_PG_DELAY_2__SERDES_CMD_DELAY_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D (0x3 &lt;&lt; RLC_PG_DELAY_2__SERDES_CMD_DELAY__SHIFT);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_DELAY_2, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D REG_SET_FIELD(0, RLC_PG_DELAY, POWER_UP_DELAY, 0x10);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D REG_SET_FIELD(data, RLC_PG_DELAY, POWER_DOWN_DELAY, 0x10);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D REG_SET_FIELD(data, RLC_PG_DELAY, CMD_PROPAGATE_DELAY, 0x1=
0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D REG_SET_FIELD(data, RLC_PG_DELAY, MEM_SLEEP_DELAY, 0x10);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32(mmRLC_PG_DELAY, data);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D RREG32(mmRLC_AUTO_PG_CTRL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHOLD_MASK;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D (0x55f0 &lt;&lt; RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THR=
ESHOLD__SHIFT);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_AUTO_PG_CTRL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(RLC_PG_DELAY_2, SERDES_CMD_DELAY, 0x3);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_FIELD(RLC_AUTO_PG_CTRL, GRBM_REG_SAVE_GFX_IDLE_THRESHOLD, 0x=
55f0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void cz_enable_sck_slow_down_on_power_up(struct amd=
gpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<=
br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 data, orig;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; orig =3D data =3D RREG32(mmRLC_PG_CNTL);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PU_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PU_ENABLE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (orig !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, SMU_CLK_SLOWDO=
WN_ON_PU_ENABLE, enable ? 1 : 0);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void cz_enable_sck_slow_down_on_power_down(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
ool enable)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 data, orig;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; orig =3D data =3D RREG32(mmRLC_PG_CNTL);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PD_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PD_ENABLE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (orig !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, SMU_CLK_SLOWDO=
WN_ON_PD_ENABLE, enable ? 1 : 0);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void cz_enable_cp_power_gating(struct amdgpu_device=
 *adev, bool enable)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 data, orig;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; orig =3D data =3D RREG32(mmRLC_PG_CNTL);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_PG_CNTL__CP_PG_DISABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D RLC_PG_CNTL__CP_PG_DISABLE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (orig !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, CP_PG_DISABLE,=
 enable ? 1 : 0);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_init_pg(struct amdgpu_device *adev)<b=
r>
&gt; @@ -3918,34 &#43;3868,24 @@ static void gfx_v8_0_init_pg(struct amdgpu=
_device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void gfx_v8_0_rlc_stop(struct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32(mmRLC_CNTL);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENA=
BLE_F32, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_CNTL, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_CNTL, RLC_ENABLE_F32, 0=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_enable_gui_idle_int=
errupt(adev, false);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_wait_for_rlc_serdes=
(adev);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_rlc_reset(struct amdgpu_device *adev)=
<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32(mmGRBM_SOFT_RESET);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, =
SOFT_RESET_RLC, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRBM_SOFT_RESET, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(GRBM_SOFT_RESET, SOFT_RESET=
_RLC, 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, =
SOFT_RESET_RLC, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmGRBM_SOFT_RESET, tmp);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(GRBM_SOFT_RESET, SOFT_RESET=
_RLC, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(50);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_rlc_start(struct amdgpu_device *adev)=
<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32(mmRLC_CNTL);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENA=
BLE_F32, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmRLC_CNTL, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_CNTL, RLC_ENABLE_F32, 1=
);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* carrizo do enable cp inte=
rrupt after cp inited */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; A=
MD_IS_APU))<br>
&gt; @@ -5371,8 &#43;5311,6 @@ static int gfx_v8_0_late_init(void *handle)<=
br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_enable_gfx_static_mg_power_gating(str=
uct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data, temp;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_POLARIS11)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Send msg to SMU via Powerplay */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_set_powergating_state(adev,<br>
&gt; @@ -5380,83 &#43;5318,35 @@ static void gfx_v8_0_enable_gfx_static_mg_=
power_gating(struct amdgpu_device *ade<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable ?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE : AMD_PG_STAT=
E_UNGATE);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; temp =3D data =3D RREG32(mmRLC_PG_CNTL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Enable static MGPG */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D RLC_PG_CNTL__STATIC_PER_CU_PG_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_PG_CNTL__STATIC_PER_CU_PG_ENABLE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (temp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, STATIC_PER_CU_=
PG_ENABLE, enable ? 1 : 0);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_enable_gfx_dynamic_mg_power_gating(st=
ruct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data, temp;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; temp =3D data =3D RREG32(mmRLC_PG_CNTL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Enable dynamic MGPG */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D RLC_PG_CNTL__DYN_PER_CU_PG_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_PG_CNTL__DYN_PER_CU_PG_ENABLE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (temp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, DYN_PER_CU_PG_=
ENABLE, enable ? 1 : 0);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void polaris11_enable_gfx_quick_mg_power_gating(str=
uct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bool enable)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data, temp;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; temp =3D data =3D RREG32(mmRLC_PG_CNTL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Enable quick PG */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D RLC_PG_CNTL__QUICK_PG_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_PG_CNTL__QUICK_PG_ENABLE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (temp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, QUICK_PG_ENABL=
E, enable ? 1 : 0);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void cz_enable_gfx_cg_power_gating(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 data, orig;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; orig =3D data =3D RREG32(mmRLC_PG_CNTL);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (orig !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, GFX_POWER_GATI=
NG_ENABLE, enable ? 1 : 0);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void cz_enable_gfx_pipeline_power_gating(struct amd=
gpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<=
br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 data, orig;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; orig =3D data =3D RREG32(mmRLC_PG_CNTL);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data |=3D RLC_PG_CNTL__GFX_PIPELINE_PG_ENABLE_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data &amp;=3D ~RLC_PG_CNTL__GFX_PIPELINE_PG_ENABLE_MASK;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (orig !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmRLC_PG_CNTL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_PG_CNTL, GFX_PIPELINE_P=
G_ENABLE, enable ? 1 : 0);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Read any GFX register to =
wake up GFX. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!enable)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; data =3D RREG32(mmDB_RENDER_CONTROL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; RREG32(mmDB_RENDER_CONTROL);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void cz_update_gfx_cg_power_gating(struct amdgpu_de=
vice *adev,<br>
&gt; @@ -5563,10 &#43;5453,10 @@ static void gfx_v8_0_send_serdes_cmd(struc=
t amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define MSG_ENTER_RLC_SAFE_MODE&nbsp;&nbsp;&nbsp;&nbsp; 1<=
br>
&gt;&nbsp;&nbsp; #define MSG_EXIT_RLC_SAFE_MODE&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0<br>
&gt; -<br>
&gt; -#define RLC_GPR_REG2__REQ_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x00000001<br>
&gt; -#define RLC_GPR_REG2__MESSAGE__SHIFT&nbsp;&nbsp;&nbsp;&nbsp; 0x000000=
01<br>
&gt; -#define RLC_GPR_REG2__MESSAGE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0x0000001e<br>
&gt; &#43;#define RLC_GPR_REG2__REQ_MASK 0x00000001<br>
&gt; &#43;#define RLC_GPR_REG2__REQ__SHIFT 0<br>
&gt; &#43;#define RLC_GPR_REG2__MESSAGE__SHIFT 0x00000001<br>
&gt; &#43;#define RLC_GPR_REG2__MESSAGE_MASK 0x0000001e<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void cz_enter_rlc_safe_mode(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -5596,7 &#43;5486,7 @@ static void cz_enter_rlc_safe_mode(struct am=
dgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;usec_timeout; i&#43;&#43;=
) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((RREG32(mmRLC_GPR_R=
EG2) &amp; RLC_GPR_REG2__REQ_MASK) =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!REG_GET_FIELD(=
RREG32(mmRLC_GPR_REG2), RLC_GPR_REG2, REQ))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(=
1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -5624,7 &#43;5514,7 @@ static void cz_exit_rlc_safe_mode(struct amd=
gpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;usec_timeout; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((RREG32(mmRLC_GPR_REG2) &amp; RLC_GPR_REG2__REQ_MASK) =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!REG_GET_FIELD(RREG32(mmRLC_GPR_REG2), RLC_GPR_REG2, REQ))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; udelay(1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -5656,7 &#43;5546,7 @@ static void iceland_enter_rlc_safe_mode(stru=
ct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;usec_timeout; i&#43;&#43;=
) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((RREG32(mmRLC_SAFE_=
MODE) &amp; RLC_SAFE_MODE__CMD_MASK) =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!REG_GET_FIELD(=
RREG32(mmRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(=
1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -5683,7 &#43;5573,7 @@ static void iceland_exit_rlc_safe_mode(struc=
t amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&g=
t;usec_timeout; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((RREG32(mmRLC_SAFE_MODE) &amp; RLC_SAFE_MODE__CMD_MASK) =3D=3D 0)<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!REG_GET_FIELD(RREG32(mmRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; udelay(1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -5724,21 &#43;5614,12 @@ static void gfx_v8_0_update_medium_grain_c=
lock_gating(struct amdgpu_device *adev<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* It is disabled by HW by d=
efault */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; (adev-=
&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_MGCG)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_MGLS) {<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &=
amp; AMD_CG_SUPPORT_GFX_RLC_LS) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_fla=
gs &amp; AMD_CG_SUPPORT_GFX_RLC_LS)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 1 - RLC memory Light sleep */<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; temp =3D data =3D RREG32(mmRLC_MEM_SLP_CNTL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; data |=3D RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK;<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (temp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32(mmRLC_MEM_SLP_CNTL, data);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(RLC_MEM_SLP_CNTL, RLC_MEM_LS_EN, =
1);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &=
amp; AMD_CG_SUPPORT_GFX_CP_LS) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* 2 - CP memory Light sleep */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; temp =3D data =3D RREG32(mmCP_MEM_SLP_CNTL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; data |=3D CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (temp !=3D data)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WR=
EG32(mmCP_MEM_SLP_CNTL, data);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_fla=
gs &amp; AMD_CG_SUPPORT_GFX_CP_LS)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(CP_MEM_SLP_CNTL, CP_MEM_LS_EN, 1)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* 3 - RLC_CGTT_MGCG_OVERRIDE */<br>
&gt; @@ -6213,33 &#43;6094,14 @@ static void gfx_v8_0_ring_emit_fence_compu=
te(struct amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_set_gfx_eop_interrupt_state(struct am=
dgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum am=
dgpu_interrupt_state state)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 cp_int_cntl;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIELD(cp_int_cn=
tl, CP_INT_CNTL_RING0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT=
_ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(CP_INT_CNTL_RING0, TIME_STA=
MP_INT_ENABLE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_DISABLE=
 ? 0 : 1);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_set_compute_eop_interrupt_state(struc=
t amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; int me, int pipe,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 mec_int_cntl, mec_int_cntl_reg;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu controls only=
 pipe 0 of MEC1. That's why this function only<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * handles the setting =
of interrupts for this specific pipe. All other<br>
&gt; @@ -6249,7 &#43;6111,6 @@ static void gfx_v8_0_set_compute_eop_interru=
pt_state(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (me =3D=3D 1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (pipe) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case 0:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mec_int_cntl_reg =3D mm=
CP_ME1_PIPE0_INT_CNTL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEB=
UG(&quot;invalid pipe %d\n&quot;, pipe);<br>
&gt; @@ -6260,22 &#43;6121,8 @@ static void gfx_v8_0_set_compute_eop_interr=
upt_state(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mec_int_cntl =3D RREG32(mec_int_cntl_reg);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mec_int_cntl_reg, mec_int_cntl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mec_int_cntl =3D RREG32(mec_int_cntl_reg);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mec_int_cntl_reg, mec_int_cntl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(CP_ME1_PIPE0_INT_CNTL, TIME=
_STAMP_INT_ENABLE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_DISABLE=
 ? 0 : 1);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v8_0_set_priv_reg_fault_state(struct amdgpu=
_device *adev,<br>
&gt; @@ -6283,24 &#43;6130,8 @@ static int gfx_v8_0_set_priv_reg_fault_stat=
e(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state sta=
te)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 cp_int_cntl;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PRIV_REG_INT_ENABLE, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PRIV_REG_INT_ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(CP_INT_CNTL_RING0, PRIV_REG=
_INT_ENABLE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_DISABLE=
 ? 0 : 1);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -6310,24 &#43;6141,8 @@ static int gfx_v8_0_set_priv_inst_fault_sta=
te(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_sta=
te state)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 cp_int_cntl;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PRIV_INSTR_INT_ENABLE, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D RREG32(mmCP_INT_CNTL_RING0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PRIV_INSTR_INT_ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD(CP_INT_CNTL_RING0, PRIV_INS=
TR_INT_ENABLE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_DISABLE=
 ? 0 : 1);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB113283968678F567DACB84A6F71C0DM5PR12MB1132namp_--

--===============1986214651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1986214651==--
