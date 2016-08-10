From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Simplify bitfield operations in gfx v8
Date: Wed, 10 Aug 2016 14:29:16 +0200
Message-ID: <6472fd04-dc03-1770-38c2-efdbb7f589c1@vodafone.de>
References: <20160809142739.1401-1-tom.stdenis@amd.com>
 <20160809142739.1401-4-tom.stdenis@amd.com>
 <dc95cc72-5e8e-6c5e-7c87-979d838652e7@vodafone.de>
 <DM5PR12MB113283968678F567DACB84A6F71C0@DM5PR12MB1132.namprd12.prod.outlook.com>
 <DM5PR12MB113243454107BC54C623786EF71D0@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0369700958=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB113243454107BC54C623786EF71D0-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0369700958==
Content-Type: multipart/alternative;
 boundary="------------434CD24A89AB957B29AADAA0"

This is a multi-part message in MIME format.
--------------434CD24A89AB957B29AADAA0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

No, not really. Just thought you could simplify this even more.

The whole set is Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Regards,
Christian.

Am 10.08.2016 um 14:25 schrieb StDenis, Tom:
>
> So is that a NAK to the series or are we good to go?
>
>
> Cheers,
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* StDenis, Tom
> *Sent:* Tuesday, August 9, 2016 11:28
> *To:* Christian König; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 3/3] drm/amd/amdgpu: Simplify bitfield 
> operations in gfx v8
>
> Probably could but I felt that implementation was cleaner.
>
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Tuesday, August 9, 2016 10:56
> *To:* Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* StDenis, Tom
> *Subject:* Re: [PATCH 3/3] drm/amd/amdgpu: Simplify bitfield 
> operations in gfx v8
> Am 09.08.2016 um 16:27 schrieb Tom St Denis:
> > This patch introduces a new macro WREG32_FIELD which is used
> > to write to a register with a new value in a field.  It's designed
> > to replace the pattern:
> >
> > tmp = RREG32(mmFoo);
> > tmp &= ~REG__FIELD_MASK;
> > tmp |= new_value << REG__FIELD__SHIFT;
> > WREG32(mmFoo, tmp)
> >
> > with:
> >
> > WREG32_FIELD(Foo, FIELD, new_value);
> >
> > Unlike WREG32_P() it understands offsets/masks and doesn't
> > require the caller to shift the value (or mask properly).
> >
> > It's applied where suitable in the gfx_v8_0.c driver to start
> > with.
> >
> > Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |   3 +
> >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 275 
> ++++++----------------------------
> >   2 files changed, 48 insertions(+), 230 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index c309eaf468e9..f23eb38eb3aa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -2218,6 +2218,9 @@ bool amdgpu_device_has_dal_support(struct 
> amdgpu_device *adev);
> >   #define REG_GET_FIELD(value, reg, field)                            \
> >        (((value) & REG_FIELD_MASK(reg, field)) >> 
> REG_FIELD_SHIFT(reg, field))
> >
> > +#define WREG32_FIELD(reg, field, val) \
> > +     WREG32(mm##reg, (RREG32(mm##reg) & ~REG_FIELD_MASK(reg, 
> field)) | (val) << REG_FIELD_SHIFT(reg, field))
>
> Couldn't you use WREG32_P here to implement the new macro?
>
> Christian.
>
> > +
> >   /*
> >    * BIOS helpers.
> >    */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > index 5f91a834aed2..6e01392facef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -3566,10 +3566,7 @@ static void gfx_v8_0_gpu_init(struct 
> amdgpu_device *adev)
> >        u32 tmp;
> >        int i;
> >
> > -     tmp = RREG32(mmGRBM_CNTL);
> > -     tmp = REG_SET_FIELD(tmp, GRBM_CNTL, READ_TIMEOUT, 0xff);
> > -     WREG32(mmGRBM_CNTL, tmp);
> > -
> > +     WREG32_FIELD(GRBM_CNTL, READ_TIMEOUT, 0xFF);
> >        WREG32(mmGB_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
> >        WREG32(mmHDP_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
> >        WREG32(mmDMIF_ADDR_CALC, adev->gfx.config.gb_addr_config);
> > @@ -3758,9 +3755,7 @@ static int 
> gfx_v8_0_init_save_restore_list(struct amdgpu_device *adev)
> > sizeof(indirect_start_offsets)/sizeof(int));
> >
> >        /* save and restore list */
> > -     temp = RREG32(mmRLC_SRM_CNTL);
> > -     temp |= RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
> > -     WREG32(mmRLC_SRM_CNTL, temp);
> > +     WREG32_FIELD(RLC_SRM_CNTL, AUTO_INCR_ADDR, 1);
> >
> >        WREG32(mmRLC_SRM_ARAM_ADDR, 0);
> >        for (i = 0; i < adev->gfx.rlc.reg_list_size_bytes >> 2; i++)
> > @@ -3797,11 +3792,7 @@ static int 
> gfx_v8_0_init_save_restore_list(struct amdgpu_device *adev)
> >
> >   static void gfx_v8_0_enable_save_restore_machine(struct 
> amdgpu_device *adev)
> >   {
> > -     uint32_t data;
> > -
> > -     data = RREG32(mmRLC_SRM_CNTL);
> > -     data |= RLC_SRM_CNTL__SRM_ENABLE_MASK;
> > -     WREG32(mmRLC_SRM_CNTL, data);
> > +     WREG32_FIELD(RLC_SRM_CNTL, SRM_ENABLE, 1);
> >   }
> >
> >   static void gfx_v8_0_init_power_gating(struct amdgpu_device *adev)
> > @@ -3811,75 +3802,34 @@ static void 
> gfx_v8_0_init_power_gating(struct amdgpu_device *adev)
> >        if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_PG |
> > AMD_PG_SUPPORT_GFX_SMG |
> > AMD_PG_SUPPORT_GFX_DMG)) {
> > -             data = RREG32(mmCP_RB_WPTR_POLL_CNTL);
> > -             data &= ~CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT_MASK;
> > -             data |= (0x60 << 
> CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);
> > -             WREG32(mmCP_RB_WPTR_POLL_CNTL, data);
> > -
> > -             data = 0;
> > -             data |= (0x10 << RLC_PG_DELAY__POWER_UP_DELAY__SHIFT);
> > -             data |= (0x10 << RLC_PG_DELAY__POWER_DOWN_DELAY__SHIFT);
> > -             data |= (0x10 << 
> RLC_PG_DELAY__CMD_PROPAGATE_DELAY__SHIFT);
> > -             data |= (0x10 << RLC_PG_DELAY__MEM_SLEEP_DELAY__SHIFT);
> > -             WREG32(mmRLC_PG_DELAY, data);
> > + WREG32_FIELD(CP_RB_WPTR_POLL_CNTL, IDLE_POLL_COUNT, 0x60);
> >
> > -             data = RREG32(mmRLC_PG_DELAY_2);
> > -             data &= ~RLC_PG_DELAY_2__SERDES_CMD_DELAY_MASK;
> > -             data |= (0x3 << RLC_PG_DELAY_2__SERDES_CMD_DELAY__SHIFT);
> > -             WREG32(mmRLC_PG_DELAY_2, data);
> > +             data = REG_SET_FIELD(0, RLC_PG_DELAY, POWER_UP_DELAY, 
> 0x10);
> > +             data = REG_SET_FIELD(data, RLC_PG_DELAY, 
> POWER_DOWN_DELAY, 0x10);
> > +             data = REG_SET_FIELD(data, RLC_PG_DELAY, 
> CMD_PROPAGATE_DELAY, 0x10);
> > +             data = REG_SET_FIELD(data, RLC_PG_DELAY, 
> MEM_SLEEP_DELAY, 0x10);
> > +             WREG32(mmRLC_PG_DELAY, data);
> >
> > -             data = RREG32(mmRLC_AUTO_PG_CTRL);
> > -             data &= 
> ~RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHOLD_MASK;
> > -             data |= (0x55f0 << 
> RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHOLD__SHIFT);
> > -             WREG32(mmRLC_AUTO_PG_CTRL, data);
> > +             WREG32_FIELD(RLC_PG_DELAY_2, SERDES_CMD_DELAY, 0x3);
> > +             WREG32_FIELD(RLC_AUTO_PG_CTRL, 
> GRBM_REG_SAVE_GFX_IDLE_THRESHOLD, 0x55f0);
> >        }
> >   }
> >
> >   static void cz_enable_sck_slow_down_on_power_up(struct 
> amdgpu_device *adev,
> >                                                bool enable)
> >   {
> > -     u32 data, orig;
> > -
> > -     orig = data = RREG32(mmRLC_PG_CNTL);
> > -
> > -     if (enable)
> > -             data |= RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PU_ENABLE_MASK;
> > -     else
> > -             data &= ~RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PU_ENABLE_MASK;
> > -
> > -     if (orig != data)
> > -             WREG32(mmRLC_PG_CNTL, data);
> > +     WREG32_FIELD(RLC_PG_CNTL, SMU_CLK_SLOWDOWN_ON_PU_ENABLE, 
> enable ? 1 : 0);
> >   }
> >
> >   static void cz_enable_sck_slow_down_on_power_down(struct 
> amdgpu_device *adev,
> >                                                  bool enable)
> >   {
> > -     u32 data, orig;
> > -
> > -     orig = data = RREG32(mmRLC_PG_CNTL);
> > -
> > -     if (enable)
> > -             data |= RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PD_ENABLE_MASK;
> > -     else
> > -             data &= ~RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PD_ENABLE_MASK;
> > -
> > -     if (orig != data)
> > -             WREG32(mmRLC_PG_CNTL, data);
> > +     WREG32_FIELD(RLC_PG_CNTL, SMU_CLK_SLOWDOWN_ON_PD_ENABLE, 
> enable ? 1 : 0);
> >   }
> >
> >   static void cz_enable_cp_power_gating(struct amdgpu_device *adev, 
> bool enable)
> >   {
> > -     u32 data, orig;
> > -
> > -     orig = data = RREG32(mmRLC_PG_CNTL);
> > -
> > -     if (enable)
> > -             data &= ~RLC_PG_CNTL__CP_PG_DISABLE_MASK;
> > -     else
> > -             data |= RLC_PG_CNTL__CP_PG_DISABLE_MASK;
> > -
> > -     if (orig != data)
> > -             WREG32(mmRLC_PG_CNTL, data);
> > +     WREG32_FIELD(RLC_PG_CNTL, CP_PG_DISABLE, enable ? 1 : 0);
> >   }
> >
> >   static void gfx_v8_0_init_pg(struct amdgpu_device *adev)
> > @@ -3918,34 +3868,24 @@ static void gfx_v8_0_init_pg(struct 
> amdgpu_device *adev)
> >
> >   void gfx_v8_0_rlc_stop(struct amdgpu_device *adev)
> >   {
> > -     u32 tmp = RREG32(mmRLC_CNTL);
> > -
> > -     tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
> > -     WREG32(mmRLC_CNTL, tmp);
> > +     WREG32_FIELD(RLC_CNTL, RLC_ENABLE_F32, 0);
> >
> > gfx_v8_0_enable_gui_idle_interrupt(adev, false);
> > -
> >        gfx_v8_0_wait_for_rlc_serdes(adev);
> >   }
> >
> >   static void gfx_v8_0_rlc_reset(struct amdgpu_device *adev)
> >   {
> > -     u32 tmp = RREG32(mmGRBM_SOFT_RESET);
> > -
> > -     tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
> > -     WREG32(mmGRBM_SOFT_RESET, tmp);
> > +     WREG32_FIELD(GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
> >        udelay(50);
> > -     tmp = REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
> > -     WREG32(mmGRBM_SOFT_RESET, tmp);
> > +
> > +     WREG32_FIELD(GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
> >        udelay(50);
> >   }
> >
> >   static void gfx_v8_0_rlc_start(struct amdgpu_device *adev)
> >   {
> > -     u32 tmp = RREG32(mmRLC_CNTL);
> > -
> > -     tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 1);
> > -     WREG32(mmRLC_CNTL, tmp);
> > +     WREG32_FIELD(RLC_CNTL, RLC_ENABLE_F32, 1);
> >
> >        /* carrizo do enable cp interrupt after cp inited */
> >        if (!(adev->flags & AMD_IS_APU))
> > @@ -5371,8 +5311,6 @@ static int gfx_v8_0_late_init(void *handle)
> >   static void gfx_v8_0_enable_gfx_static_mg_power_gating(struct 
> amdgpu_device *adev,
> >                                                       bool enable)
> >   {
> > -     uint32_t data, temp;
> > -
> >        if (adev->asic_type == CHIP_POLARIS11)
> >                /* Send msg to SMU via Powerplay */
> > amdgpu_set_powergating_state(adev,
> > @@ -5380,83 +5318,35 @@ static void 
> gfx_v8_0_enable_gfx_static_mg_power_gating(struct amdgpu_device *ade
> > enable ?
> > AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE);
> >
> > -     temp = data = RREG32(mmRLC_PG_CNTL);
> > -     /* Enable static MGPG */
> > -     if (enable)
> > -             data |= RLC_PG_CNTL__STATIC_PER_CU_PG_ENABLE_MASK;
> > -     else
> > -             data &= ~RLC_PG_CNTL__STATIC_PER_CU_PG_ENABLE_MASK;
> > -
> > -     if (temp != data)
> > -             WREG32(mmRLC_PG_CNTL, data);
> > +     WREG32_FIELD(RLC_PG_CNTL, STATIC_PER_CU_PG_ENABLE, enable ? 1 
> : 0);
> >   }
> >
> >   static void gfx_v8_0_enable_gfx_dynamic_mg_power_gating(struct 
> amdgpu_device *adev,
> >                                                        bool enable)
> >   {
> > -     uint32_t data, temp;
> > -
> > -     temp = data = RREG32(mmRLC_PG_CNTL);
> > -     /* Enable dynamic MGPG */
> > -     if (enable)
> > -             data |= RLC_PG_CNTL__DYN_PER_CU_PG_ENABLE_MASK;
> > -     else
> > -             data &= ~RLC_PG_CNTL__DYN_PER_CU_PG_ENABLE_MASK;
> > -
> > -     if (temp != data)
> > -             WREG32(mmRLC_PG_CNTL, data);
> > +     WREG32_FIELD(RLC_PG_CNTL, DYN_PER_CU_PG_ENABLE, enable ? 1 : 0);
> >   }
> >
> >   static void polaris11_enable_gfx_quick_mg_power_gating(struct 
> amdgpu_device *adev,
> >                bool enable)
> >   {
> > -     uint32_t data, temp;
> > -
> > -     temp = data = RREG32(mmRLC_PG_CNTL);
> > -     /* Enable quick PG */
> > -     if (enable)
> > -             data |= RLC_PG_CNTL__QUICK_PG_ENABLE_MASK;
> > -     else
> > -             data &= ~RLC_PG_CNTL__QUICK_PG_ENABLE_MASK;
> > -
> > -     if (temp != data)
> > -             WREG32(mmRLC_PG_CNTL, data);
> > +     WREG32_FIELD(RLC_PG_CNTL, QUICK_PG_ENABLE, enable ? 1 : 0);
> >   }
> >
> >   static void cz_enable_gfx_cg_power_gating(struct amdgpu_device *adev,
> >                                          bool enable)
> >   {
> > -     u32 data, orig;
> > -
> > -     orig = data = RREG32(mmRLC_PG_CNTL);
> > -
> > -     if (enable)
> > -             data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> > -     else
> > -             data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> > -
> > -     if (orig != data)
> > -             WREG32(mmRLC_PG_CNTL, data);
> > +     WREG32_FIELD(RLC_PG_CNTL, GFX_POWER_GATING_ENABLE, enable ? 1 
> : 0);
> >   }
> >
> >   static void cz_enable_gfx_pipeline_power_gating(struct 
> amdgpu_device *adev,
> >                                                bool enable)
> >   {
> > -     u32 data, orig;
> > -
> > -     orig = data = RREG32(mmRLC_PG_CNTL);
> > -
> > -     if (enable)
> > -             data |= RLC_PG_CNTL__GFX_PIPELINE_PG_ENABLE_MASK;
> > -     else
> > -             data &= ~RLC_PG_CNTL__GFX_PIPELINE_PG_ENABLE_MASK;
> > -
> > -     if (orig != data)
> > -             WREG32(mmRLC_PG_CNTL, data);
> > +     WREG32_FIELD(RLC_PG_CNTL, GFX_PIPELINE_PG_ENABLE, enable ? 1 : 0);
> >
> >        /* Read any GFX register to wake up GFX. */
> >        if (!enable)
> > -             data = RREG32(mmDB_RENDER_CONTROL);
> > +             RREG32(mmDB_RENDER_CONTROL);
> >   }
> >
> >   static void cz_update_gfx_cg_power_gating(struct amdgpu_device *adev,
> > @@ -5563,10 +5453,10 @@ static void gfx_v8_0_send_serdes_cmd(struct 
> amdgpu_device *adev,
> >
> >   #define MSG_ENTER_RLC_SAFE_MODE     1
> >   #define MSG_EXIT_RLC_SAFE_MODE      0
> > -
> > -#define RLC_GPR_REG2__REQ_MASK 0x00000001
> > -#define RLC_GPR_REG2__MESSAGE__SHIFT 0x00000001
> > -#define RLC_GPR_REG2__MESSAGE_MASK 0x0000001e
> > +#define RLC_GPR_REG2__REQ_MASK 0x00000001
> > +#define RLC_GPR_REG2__REQ__SHIFT 0
> > +#define RLC_GPR_REG2__MESSAGE__SHIFT 0x00000001
> > +#define RLC_GPR_REG2__MESSAGE_MASK 0x0000001e
> >
> >   static void cz_enter_rlc_safe_mode(struct amdgpu_device *adev)
> >   {
> > @@ -5596,7 +5486,7 @@ static void cz_enter_rlc_safe_mode(struct 
> amdgpu_device *adev)
> >                }
> >
> >                for (i = 0; i < adev->usec_timeout; i++) {
> > -                     if ((RREG32(mmRLC_GPR_REG2) & 
> RLC_GPR_REG2__REQ_MASK) == 0)
> > +                     if (!REG_GET_FIELD(RREG32(mmRLC_GPR_REG2), 
> RLC_GPR_REG2, REQ))
> >                                break;
> >                        udelay(1);
> >                }
> > @@ -5624,7 +5514,7 @@ static void cz_exit_rlc_safe_mode(struct 
> amdgpu_device *adev)
> >        }
> >
> >        for (i = 0; i < adev->usec_timeout; i++) {
> > -             if ((RREG32(mmRLC_GPR_REG2) & RLC_GPR_REG2__REQ_MASK) 
> == 0)
> > +             if (!REG_GET_FIELD(RREG32(mmRLC_GPR_REG2), 
> RLC_GPR_REG2, REQ))
> >                        break;
> >                udelay(1);
> >        }
> > @@ -5656,7 +5546,7 @@ static void iceland_enter_rlc_safe_mode(struct 
> amdgpu_device *adev)
> >                }
> >
> >                for (i = 0; i < adev->usec_timeout; i++) {
> > -                     if ((RREG32(mmRLC_SAFE_MODE) & 
> RLC_SAFE_MODE__CMD_MASK) == 0)
> > +                     if (!REG_GET_FIELD(RREG32(mmRLC_SAFE_MODE), 
> RLC_SAFE_MODE, CMD))
> >                                break;
> >                        udelay(1);
> >                }
> > @@ -5683,7 +5573,7 @@ static void iceland_exit_rlc_safe_mode(struct 
> amdgpu_device *adev)
> >        }
> >
> >        for (i = 0; i < adev->usec_timeout; i++) {
> > -             if ((RREG32(mmRLC_SAFE_MODE) & 
> RLC_SAFE_MODE__CMD_MASK) == 0)
> > +             if (!REG_GET_FIELD(RREG32(mmRLC_SAFE_MODE), 
> RLC_SAFE_MODE, CMD))
> >                        break;
> >                udelay(1);
> >        }
> > @@ -5724,21 +5614,12 @@ static void 
> gfx_v8_0_update_medium_grain_clock_gating(struct amdgpu_device *adev
> >        /* It is disabled by HW by default */
> >        if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG)) {
> >                if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
> > -                     if (adev->cg_flags & AMD_CG_SUPPORT_GFX_RLC_LS) {
> > +                     if (adev->cg_flags & AMD_CG_SUPPORT_GFX_RLC_LS)
> >                                /* 1 - RLC memory Light sleep */
> > -                             temp = data = RREG32(mmRLC_MEM_SLP_CNTL);
> > -                             data |= 
> RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK;
> > -                             if (temp != data)
> > - WREG32(mmRLC_MEM_SLP_CNTL, data);
> > -                     }
> > + WREG32_FIELD(RLC_MEM_SLP_CNTL, RLC_MEM_LS_EN, 1);
> >
> > -                     if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CP_LS) {
> > -                             /* 2 - CP memory Light sleep */
> > -                             temp = data = RREG32(mmCP_MEM_SLP_CNTL);
> > -                             data |= 
> CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK;
> > -                             if (temp != data)
> > - WREG32(mmCP_MEM_SLP_CNTL, data);
> > -                     }
> > +                     if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CP_LS)
> > + WREG32_FIELD(CP_MEM_SLP_CNTL, CP_MEM_LS_EN, 1);
> >                }
> >
> >                /* 3 - RLC_CGTT_MGCG_OVERRIDE */
> > @@ -6213,33 +6094,14 @@ static void 
> gfx_v8_0_ring_emit_fence_compute(struct amdgpu_ring *ring,
> >   static void gfx_v8_0_set_gfx_eop_interrupt_state(struct 
> amdgpu_device *adev,
> >                                                 enum amdgpu_interrupt_state state)
> >   {
> > -     u32 cp_int_cntl;
> > -
> > -     switch (state) {
> > -     case AMDGPU_IRQ_STATE_DISABLE:
> > -             cp_int_cntl = RREG32(mmCP_INT_CNTL_RING0);
> > -             cp_int_cntl = REG_SET_FIELD(cp_int_cntl, 
> CP_INT_CNTL_RING0,
> > - TIME_STAMP_INT_ENABLE, 0);
> > -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> > -             break;
> > -     case AMDGPU_IRQ_STATE_ENABLE:
> > -             cp_int_cntl = RREG32(mmCP_INT_CNTL_RING0);
> > -             cp_int_cntl =
> > - REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
> > - TIME_STAMP_INT_ENABLE, 1);
> > -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > +     WREG32_FIELD(CP_INT_CNTL_RING0, TIME_STAMP_INT_ENABLE,
> > +                  state == AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);
> >   }
> >
> >   static void gfx_v8_0_set_compute_eop_interrupt_state(struct 
> amdgpu_device *adev,
> >                                                     int me, int pipe,
> >                                                     enum amdgpu_interrupt_state state)
> >   {
> > -     u32 mec_int_cntl, mec_int_cntl_reg;
> > -
> >        /*
> >         * amdgpu controls only pipe 0 of MEC1. That's why this 
> function only
> >         * handles the setting of interrupts for this specific pipe. 
> All other
> > @@ -6249,7 +6111,6 @@ static void 
> gfx_v8_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
> >        if (me == 1) {
> >                switch (pipe) {
> >                case 0:
> > -                     mec_int_cntl_reg = mmCP_ME1_PIPE0_INT_CNTL;
> >                        break;
> >                default:
> >                        DRM_DEBUG("invalid pipe %d\n", pipe);
> > @@ -6260,22 +6121,8 @@ static void 
> gfx_v8_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
> >                return;
> >        }
> >
> > -     switch (state) {
> > -     case AMDGPU_IRQ_STATE_DISABLE:
> > -             mec_int_cntl = RREG32(mec_int_cntl_reg);
> > -             mec_int_cntl = REG_SET_FIELD(mec_int_cntl, 
> CP_ME1_PIPE0_INT_CNTL,
> > - TIME_STAMP_INT_ENABLE, 0);
> > -             WREG32(mec_int_cntl_reg, mec_int_cntl);
> > -             break;
> > -     case AMDGPU_IRQ_STATE_ENABLE:
> > -             mec_int_cntl = RREG32(mec_int_cntl_reg);
> > -             mec_int_cntl = REG_SET_FIELD(mec_int_cntl, 
> CP_ME1_PIPE0_INT_CNTL,
> > - TIME_STAMP_INT_ENABLE, 1);
> > -             WREG32(mec_int_cntl_reg, mec_int_cntl);
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > +     WREG32_FIELD(CP_ME1_PIPE0_INT_CNTL, TIME_STAMP_INT_ENABLE,
> > +                  state == AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);
> >   }
> >
> >   static int gfx_v8_0_set_priv_reg_fault_state(struct amdgpu_device 
> *adev,
> > @@ -6283,24 +6130,8 @@ static int 
> gfx_v8_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
> > unsigned type,
> > enum amdgpu_interrupt_state state)
> >   {
> > -     u32 cp_int_cntl;
> > -
> > -     switch (state) {
> > -     case AMDGPU_IRQ_STATE_DISABLE:
> > -             cp_int_cntl = RREG32(mmCP_INT_CNTL_RING0);
> > -             cp_int_cntl = REG_SET_FIELD(cp_int_cntl, 
> CP_INT_CNTL_RING0,
> > - PRIV_REG_INT_ENABLE, 0);
> > -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> > -             break;
> > -     case AMDGPU_IRQ_STATE_ENABLE:
> > -             cp_int_cntl = RREG32(mmCP_INT_CNTL_RING0);
> > -             cp_int_cntl = REG_SET_FIELD(cp_int_cntl, 
> CP_INT_CNTL_RING0,
> > - PRIV_REG_INT_ENABLE, 1);
> > -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > +     WREG32_FIELD(CP_INT_CNTL_RING0, PRIV_REG_INT_ENABLE,
> > +                  state == AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);
> >
> >        return 0;
> >   }
> > @@ -6310,24 +6141,8 @@ static int 
> gfx_v8_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
> > unsigned type,
> > enum amdgpu_interrupt_state state)
> >   {
> > -     u32 cp_int_cntl;
> > -
> > -     switch (state) {
> > -     case AMDGPU_IRQ_STATE_DISABLE:
> > -             cp_int_cntl = RREG32(mmCP_INT_CNTL_RING0);
> > -             cp_int_cntl = REG_SET_FIELD(cp_int_cntl, 
> CP_INT_CNTL_RING0,
> > - PRIV_INSTR_INT_ENABLE, 0);
> > -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> > -             break;
> > -     case AMDGPU_IRQ_STATE_ENABLE:
> > -             cp_int_cntl = RREG32(mmCP_INT_CNTL_RING0);
> > -             cp_int_cntl = REG_SET_FIELD(cp_int_cntl, 
> CP_INT_CNTL_RING0,
> > - PRIV_INSTR_INT_ENABLE, 1);
> > -             WREG32(mmCP_INT_CNTL_RING0, cp_int_cntl);
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > +     WREG32_FIELD(CP_INT_CNTL_RING0, PRIV_INSTR_INT_ENABLE,
> > +                  state == AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);
> >
> >        return 0;
> >   }
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------434CD24A89AB957B29AADAA0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">No, not really. Just thought you could
      simplify this even more.<br>
      <br>
      The whole set is Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 10.08.2016 um 14:25 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB113243454107BC54C623786EF71D0-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>So is that a NAK to the series or are we good to go?</p>
        <p><br>
        </p>
        <p>Cheers,</p>
        <p>Tom</p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              StDenis, Tom<br>
              <b>Sent:</b> Tuesday, August 9, 2016 11:28<br>
              <b>To:</b> Christian König; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Subject:</b> Re: [PATCH 3/3] drm/amd/amdgpu: Simplify
              bitfield operations in gfx v8</font>
            <div> </div>
          </div>
          <div>
            <div id="divtagdefaultwrapper" style="font-size:12pt;
              color:#000000; background-color:#FFFFFF;
              font-family:Calibri,Arial,Helvetica,sans-serif">
              <p>Probably could but I felt that implementation was
                cleaner.</p>
              <p><br>
              </p>
              <p>Tom</p>
              <br>
              <br>
              <div style="color:rgb(0,0,0)">
                <div>
                  <hr tabindex="-1" style="display:inline-block;
                    width:98%">
                  <div id="x_divRplyFwdMsg" dir="ltr"><font
                      style="font-size:11pt" color="#000000"
                      face="Calibri, sans-serif"><b>From:</b> Christian
                      König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                      <b>Sent:</b> Tuesday, August 9, 2016 10:56<br>
                      <b>To:</b> Tom St Denis;
                      <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                      <b>Cc:</b> StDenis, Tom<br>
                      <b>Subject:</b> Re: [PATCH 3/3] drm/amd/amdgpu:
                      Simplify bitfield operations in gfx v8</font>
                    <div> </div>
                  </div>
                </div>
                <font size="2"><span style="font-size:10pt">
                    <div class="PlainText">Am 09.08.2016 um 16:27
                      schrieb Tom St Denis:<br>
                      &gt; This patch introduces a new macro
                      WREG32_FIELD which is used<br>
                      &gt; to write to a register with a new value in a
                      field.  It's designed<br>
                      &gt; to replace the pattern:<br>
                      &gt;<br>
                      &gt; tmp = RREG32(mmFoo);<br>
                      &gt; tmp &amp;= ~REG__FIELD_MASK;<br>
                      &gt; tmp |= new_value &lt;&lt; REG__FIELD__SHIFT;<br>
                      &gt; WREG32(mmFoo, tmp)<br>
                      &gt;<br>
                      &gt; with:<br>
                      &gt;<br>
                      &gt; WREG32_FIELD(Foo, FIELD, new_value);<br>
                      &gt;<br>
                      &gt; Unlike WREG32_P() it understands
                      offsets/masks and doesn't<br>
                      &gt; require the caller to shift the value (or
                      mask properly).<br>
                      &gt;<br>
                      &gt; It's applied where suitable in the gfx_v8_0.c
                      driver to start<br>
                      &gt; with.<br>
                      &gt;<br>
                      &gt; Signed-off-by: Tom St Denis
                      <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org">&lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                      &gt; ---<br>
                      &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |   3
                      +<br>
                      &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 275
                      ++++++----------------------------<br>
                      &gt;   2 files changed, 48 insertions(+), 230
                      deletions(-)<br>
                      &gt;<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                      &gt; index c309eaf468e9..f23eb38eb3aa 100644<br>
                      &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                      &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                      &gt; @@ -2218,6 +2218,9 @@ bool
                      amdgpu_device_has_dal_support(struct amdgpu_device
                      *adev);<br>
                      &gt;   #define REG_GET_FIELD(value, reg,
                      field)                            \<br>
                      &gt;        (((value) &amp; REG_FIELD_MASK(reg,
                      field)) &gt;&gt; REG_FIELD_SHIFT(reg, field))<br>
                      &gt;   <br>
                      &gt; +#define WREG32_FIELD(reg, field, val)       
                      \<br>
                      &gt; +     WREG32(mm##reg, (RREG32(mm##reg) &amp;
                      ~REG_FIELD_MASK(reg, field)) | (val) &lt;&lt;
                      REG_FIELD_SHIFT(reg, field))<br>
                      <br>
                      Couldn't you use WREG32_P here to implement the
                      new macro?<br>
                      <br>
                      Christian.<br>
                      <br>
                      &gt; +<br>
                      &gt;   /*<br>
                      &gt;    * BIOS helpers.<br>
                      &gt;    */<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
                      b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                      &gt; index 5f91a834aed2..6e01392facef 100644<br>
                      &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                      &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                      &gt; @@ -3566,10 +3566,7 @@ static void
                      gfx_v8_0_gpu_init(struct amdgpu_device *adev)<br>
                      &gt;        u32 tmp;<br>
                      &gt;        int i;<br>
                      &gt;   <br>
                      &gt; -     tmp = RREG32(mmGRBM_CNTL);<br>
                      &gt; -     tmp = REG_SET_FIELD(tmp, GRBM_CNTL,
                      READ_TIMEOUT, 0xff);<br>
                      &gt; -     WREG32(mmGRBM_CNTL, tmp);<br>
                      &gt; -<br>
                      &gt; +     WREG32_FIELD(GRBM_CNTL, READ_TIMEOUT,
                      0xFF);<br>
                      &gt;        WREG32(mmGB_ADDR_CONFIG,
                      adev-&gt;gfx.config.gb_addr_config);<br>
                      &gt;        WREG32(mmHDP_ADDR_CONFIG,
                      adev-&gt;gfx.config.gb_addr_config);<br>
                      &gt;        WREG32(mmDMIF_ADDR_CALC,
                      adev-&gt;gfx.config.gb_addr_config);<br>
                      &gt; @@ -3758,9 +3755,7 @@ static int
                      gfx_v8_0_init_save_restore_list(struct
                      amdgpu_device *adev)<br>
                      &gt;                               
                      sizeof(indirect_start_offsets)/sizeof(int));<br>
                      &gt;   <br>
                      &gt;        /* save and restore list */<br>
                      &gt; -     temp = RREG32(mmRLC_SRM_CNTL);<br>
                      &gt; -     temp |=
                      RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;<br>
                      &gt; -     WREG32(mmRLC_SRM_CNTL, temp);<br>
                      &gt; +     WREG32_FIELD(RLC_SRM_CNTL,
                      AUTO_INCR_ADDR, 1);<br>
                      &gt;   <br>
                      &gt;        WREG32(mmRLC_SRM_ARAM_ADDR, 0);<br>
                      &gt;        for (i = 0; i &lt;
                      adev-&gt;gfx.rlc.reg_list_size_bytes &gt;&gt; 2;
                      i++)<br>
                      &gt; @@ -3797,11 +3792,7 @@ static int
                      gfx_v8_0_init_save_restore_list(struct
                      amdgpu_device *adev)<br>
                      &gt;   <br>
                      &gt;   static void
                      gfx_v8_0_enable_save_restore_machine(struct
                      amdgpu_device *adev)<br>
                      &gt;   {<br>
                      &gt; -     uint32_t data;<br>
                      &gt; -<br>
                      &gt; -     data = RREG32(mmRLC_SRM_CNTL);<br>
                      &gt; -     data |= RLC_SRM_CNTL__SRM_ENABLE_MASK;<br>
                      &gt; -     WREG32(mmRLC_SRM_CNTL, data);<br>
                      &gt; +     WREG32_FIELD(RLC_SRM_CNTL, SRM_ENABLE,
                      1);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      gfx_v8_0_init_power_gating(struct amdgpu_device
                      *adev)<br>
                      &gt; @@ -3811,75 +3802,34 @@ static void
                      gfx_v8_0_init_power_gating(struct amdgpu_device
                      *adev)<br>
                      &gt;        if (adev-&gt;pg_flags &amp;
                      (AMD_PG_SUPPORT_GFX_PG |<br>
                      &gt;                             
                      AMD_PG_SUPPORT_GFX_SMG |<br>
                      &gt;                             
                      AMD_PG_SUPPORT_GFX_DMG)) {<br>
                      &gt; -             data =
                      RREG32(mmCP_RB_WPTR_POLL_CNTL);<br>
                      &gt; -             data &amp;=
                      ~CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT_MASK;<br>
                      &gt; -             data |= (0x60 &lt;&lt;
                      CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);<br>
                      &gt; -             WREG32(mmCP_RB_WPTR_POLL_CNTL,
                      data);<br>
                      &gt; -<br>
                      &gt; -             data = 0;<br>
                      &gt; -             data |= (0x10 &lt;&lt;
                      RLC_PG_DELAY__POWER_UP_DELAY__SHIFT);<br>
                      &gt; -             data |= (0x10 &lt;&lt;
                      RLC_PG_DELAY__POWER_DOWN_DELAY__SHIFT);<br>
                      &gt; -             data |= (0x10 &lt;&lt;
                      RLC_PG_DELAY__CMD_PROPAGATE_DELAY__SHIFT);<br>
                      &gt; -             data |= (0x10 &lt;&lt;
                      RLC_PG_DELAY__MEM_SLEEP_DELAY__SHIFT);<br>
                      &gt; -             WREG32(mmRLC_PG_DELAY, data);<br>
                      &gt; +            
                      WREG32_FIELD(CP_RB_WPTR_POLL_CNTL,
                      IDLE_POLL_COUNT, 0x60);<br>
                      &gt;   <br>
                      &gt; -             data =
                      RREG32(mmRLC_PG_DELAY_2);<br>
                      &gt; -             data &amp;=
                      ~RLC_PG_DELAY_2__SERDES_CMD_DELAY_MASK;<br>
                      &gt; -             data |= (0x3 &lt;&lt;
                      RLC_PG_DELAY_2__SERDES_CMD_DELAY__SHIFT);<br>
                      &gt; -             WREG32(mmRLC_PG_DELAY_2, data);<br>
                      &gt; +             data = REG_SET_FIELD(0,
                      RLC_PG_DELAY, POWER_UP_DELAY, 0x10);<br>
                      &gt; +             data = REG_SET_FIELD(data,
                      RLC_PG_DELAY, POWER_DOWN_DELAY, 0x10);<br>
                      &gt; +             data = REG_SET_FIELD(data,
                      RLC_PG_DELAY, CMD_PROPAGATE_DELAY, 0x10);<br>
                      &gt; +             data = REG_SET_FIELD(data,
                      RLC_PG_DELAY, MEM_SLEEP_DELAY, 0x10);<br>
                      &gt; +             WREG32(mmRLC_PG_DELAY, data);<br>
                      &gt;   <br>
                      &gt; -             data =
                      RREG32(mmRLC_AUTO_PG_CTRL);<br>
                      &gt; -             data &amp;=
                      ~RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHOLD_MASK;<br>
                      &gt; -             data |= (0x55f0 &lt;&lt;
                      RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHOLD__SHIFT);<br>
                      &gt; -             WREG32(mmRLC_AUTO_PG_CTRL,
                      data);<br>
                      &gt; +             WREG32_FIELD(RLC_PG_DELAY_2,
                      SERDES_CMD_DELAY, 0x3);<br>
                      &gt; +             WREG32_FIELD(RLC_AUTO_PG_CTRL,
                      GRBM_REG_SAVE_GFX_IDLE_THRESHOLD, 0x55f0);<br>
                      &gt;        }<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      cz_enable_sck_slow_down_on_power_up(struct
                      amdgpu_device *adev,<br>
&gt;                                                bool enable)<br>
                      &gt;   {<br>
                      &gt; -     u32 data, orig;<br>
                      &gt; -<br>
                      &gt; -     orig = data = RREG32(mmRLC_PG_CNTL);<br>
                      &gt; -<br>
                      &gt; -     if (enable)<br>
                      &gt; -             data |=
                      RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PU_ENABLE_MASK;<br>
                      &gt; -     else<br>
                      &gt; -             data &amp;=
                      ~RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PU_ENABLE_MASK;<br>
                      &gt; -<br>
                      &gt; -     if (orig != data)<br>
                      &gt; -             WREG32(mmRLC_PG_CNTL, data);<br>
                      &gt; +     WREG32_FIELD(RLC_PG_CNTL,
                      SMU_CLK_SLOWDOWN_ON_PU_ENABLE, enable ? 1 : 0);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      cz_enable_sck_slow_down_on_power_down(struct
                      amdgpu_device *adev,<br>
&gt;                                                  bool enable)<br>
                      &gt;   {<br>
                      &gt; -     u32 data, orig;<br>
                      &gt; -<br>
                      &gt; -     orig = data = RREG32(mmRLC_PG_CNTL);<br>
                      &gt; -<br>
                      &gt; -     if (enable)<br>
                      &gt; -             data |=
                      RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PD_ENABLE_MASK;<br>
                      &gt; -     else<br>
                      &gt; -             data &amp;=
                      ~RLC_PG_CNTL__SMU_CLK_SLOWDOWN_ON_PD_ENABLE_MASK;<br>
                      &gt; -<br>
                      &gt; -     if (orig != data)<br>
                      &gt; -             WREG32(mmRLC_PG_CNTL, data);<br>
                      &gt; +     WREG32_FIELD(RLC_PG_CNTL,
                      SMU_CLK_SLOWDOWN_ON_PD_ENABLE, enable ? 1 : 0);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      cz_enable_cp_power_gating(struct amdgpu_device
                      *adev, bool enable)<br>
                      &gt;   {<br>
                      &gt; -     u32 data, orig;<br>
                      &gt; -<br>
                      &gt; -     orig = data = RREG32(mmRLC_PG_CNTL);<br>
                      &gt; -<br>
                      &gt; -     if (enable)<br>
                      &gt; -             data &amp;=
                      ~RLC_PG_CNTL__CP_PG_DISABLE_MASK;<br>
                      &gt; -     else<br>
                      &gt; -             data |=
                      RLC_PG_CNTL__CP_PG_DISABLE_MASK;<br>
                      &gt; -<br>
                      &gt; -     if (orig != data)<br>
                      &gt; -             WREG32(mmRLC_PG_CNTL, data);<br>
                      &gt; +     WREG32_FIELD(RLC_PG_CNTL,
                      CP_PG_DISABLE, enable ? 1 : 0);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void gfx_v8_0_init_pg(struct
                      amdgpu_device *adev)<br>
                      &gt; @@ -3918,34 +3868,24 @@ static void
                      gfx_v8_0_init_pg(struct amdgpu_device *adev)<br>
                      &gt;   <br>
                      &gt;   void gfx_v8_0_rlc_stop(struct amdgpu_device
                      *adev)<br>
                      &gt;   {<br>
                      &gt; -     u32 tmp = RREG32(mmRLC_CNTL);<br>
                      &gt; -<br>
                      &gt; -     tmp = REG_SET_FIELD(tmp, RLC_CNTL,
                      RLC_ENABLE_F32, 0);<br>
                      &gt; -     WREG32(mmRLC_CNTL, tmp);<br>
                      &gt; +     WREG32_FIELD(RLC_CNTL, RLC_ENABLE_F32,
                      0);<br>
                      &gt;   <br>
                      &gt;       
                      gfx_v8_0_enable_gui_idle_interrupt(adev, false);<br>
                      &gt; -<br>
                      &gt;        gfx_v8_0_wait_for_rlc_serdes(adev);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void gfx_v8_0_rlc_reset(struct
                      amdgpu_device *adev)<br>
                      &gt;   {<br>
                      &gt; -     u32 tmp = RREG32(mmGRBM_SOFT_RESET);<br>
                      &gt; -<br>
                      &gt; -     tmp = REG_SET_FIELD(tmp,
                      GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);<br>
                      &gt; -     WREG32(mmGRBM_SOFT_RESET, tmp);<br>
                      &gt; +     WREG32_FIELD(GRBM_SOFT_RESET,
                      SOFT_RESET_RLC, 1);<br>
                      &gt;        udelay(50);<br>
                      &gt; -     tmp = REG_SET_FIELD(tmp,
                      GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);<br>
                      &gt; -     WREG32(mmGRBM_SOFT_RESET, tmp);<br>
                      &gt; +<br>
                      &gt; +     WREG32_FIELD(GRBM_SOFT_RESET,
                      SOFT_RESET_RLC, 0);<br>
                      &gt;        udelay(50);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void gfx_v8_0_rlc_start(struct
                      amdgpu_device *adev)<br>
                      &gt;   {<br>
                      &gt; -     u32 tmp = RREG32(mmRLC_CNTL);<br>
                      &gt; -<br>
                      &gt; -     tmp = REG_SET_FIELD(tmp, RLC_CNTL,
                      RLC_ENABLE_F32, 1);<br>
                      &gt; -     WREG32(mmRLC_CNTL, tmp);<br>
                      &gt; +     WREG32_FIELD(RLC_CNTL, RLC_ENABLE_F32,
                      1);<br>
                      &gt;   <br>
                      &gt;        /* carrizo do enable cp interrupt
                      after cp inited */<br>
                      &gt;        if (!(adev-&gt;flags &amp;
                      AMD_IS_APU))<br>
                      &gt; @@ -5371,8 +5311,6 @@ static int
                      gfx_v8_0_late_init(void *handle)<br>
                      &gt;   static void
                      gfx_v8_0_enable_gfx_static_mg_power_gating(struct
                      amdgpu_device *adev,<br>
&gt;                                                       bool enable)<br>
                      &gt;   {<br>
                      &gt; -     uint32_t data, temp;<br>
                      &gt; -<br>
                      &gt;        if (adev-&gt;asic_type ==
                      CHIP_POLARIS11)<br>
                      &gt;                /* Send msg to SMU via
                      Powerplay */<br>
                      &gt;               
                      amdgpu_set_powergating_state(adev,<br>
                      &gt; @@ -5380,83 +5318,35 @@ static void
                      gfx_v8_0_enable_gfx_static_mg_power_gating(struct
                      amdgpu_device *ade<br>
                      &gt;                                            
                      enable ?<br>
                      &gt;                                            
                      AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE);<br>
                      &gt;   <br>
                      &gt; -     temp = data = RREG32(mmRLC_PG_CNTL);<br>
                      &gt; -     /* Enable static MGPG */<br>
                      &gt; -     if (enable)<br>
                      &gt; -             data |=
                      RLC_PG_CNTL__STATIC_PER_CU_PG_ENABLE_MASK;<br>
                      &gt; -     else<br>
                      &gt; -             data &amp;=
                      ~RLC_PG_CNTL__STATIC_PER_CU_PG_ENABLE_MASK;<br>
                      &gt; -<br>
                      &gt; -     if (temp != data)<br>
                      &gt; -             WREG32(mmRLC_PG_CNTL, data);<br>
                      &gt; +     WREG32_FIELD(RLC_PG_CNTL,
                      STATIC_PER_CU_PG_ENABLE, enable ? 1 : 0);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      gfx_v8_0_enable_gfx_dynamic_mg_power_gating(struct
                      amdgpu_device *adev,<br>
&gt;                                                        bool enable)<br>
                      &gt;   {<br>
                      &gt; -     uint32_t data, temp;<br>
                      &gt; -<br>
                      &gt; -     temp = data = RREG32(mmRLC_PG_CNTL);<br>
                      &gt; -     /* Enable dynamic MGPG */<br>
                      &gt; -     if (enable)<br>
                      &gt; -             data |=
                      RLC_PG_CNTL__DYN_PER_CU_PG_ENABLE_MASK;<br>
                      &gt; -     else<br>
                      &gt; -             data &amp;=
                      ~RLC_PG_CNTL__DYN_PER_CU_PG_ENABLE_MASK;<br>
                      &gt; -<br>
                      &gt; -     if (temp != data)<br>
                      &gt; -             WREG32(mmRLC_PG_CNTL, data);<br>
                      &gt; +     WREG32_FIELD(RLC_PG_CNTL,
                      DYN_PER_CU_PG_ENABLE, enable ? 1 : 0);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      polaris11_enable_gfx_quick_mg_power_gating(struct
                      amdgpu_device *adev,<br>
                      &gt;                bool enable)<br>
                      &gt;   {<br>
                      &gt; -     uint32_t data, temp;<br>
                      &gt; -<br>
                      &gt; -     temp = data = RREG32(mmRLC_PG_CNTL);<br>
                      &gt; -     /* Enable quick PG */<br>
                      &gt; -     if (enable)<br>
                      &gt; -             data |=
                      RLC_PG_CNTL__QUICK_PG_ENABLE_MASK;<br>
                      &gt; -     else<br>
                      &gt; -             data &amp;=
                      ~RLC_PG_CNTL__QUICK_PG_ENABLE_MASK;<br>
                      &gt; -<br>
                      &gt; -     if (temp != data)<br>
                      &gt; -             WREG32(mmRLC_PG_CNTL, data);<br>
                      &gt; +     WREG32_FIELD(RLC_PG_CNTL,
                      QUICK_PG_ENABLE, enable ? 1 : 0);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      cz_enable_gfx_cg_power_gating(struct amdgpu_device
                      *adev,<br>
                      &gt;                                          bool
                      enable)<br>
                      &gt;   {<br>
                      &gt; -     u32 data, orig;<br>
                      &gt; -<br>
                      &gt; -     orig = data = RREG32(mmRLC_PG_CNTL);<br>
                      &gt; -<br>
                      &gt; -     if (enable)<br>
                      &gt; -             data |=
                      RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;<br>
                      &gt; -     else<br>
                      &gt; -             data &amp;=
                      ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;<br>
                      &gt; -<br>
                      &gt; -     if (orig != data)<br>
                      &gt; -             WREG32(mmRLC_PG_CNTL, data);<br>
                      &gt; +     WREG32_FIELD(RLC_PG_CNTL,
                      GFX_POWER_GATING_ENABLE, enable ? 1 : 0);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      cz_enable_gfx_pipeline_power_gating(struct
                      amdgpu_device *adev,<br>
&gt;                                                bool enable)<br>
                      &gt;   {<br>
                      &gt; -     u32 data, orig;<br>
                      &gt; -<br>
                      &gt; -     orig = data = RREG32(mmRLC_PG_CNTL);<br>
                      &gt; -<br>
                      &gt; -     if (enable)<br>
                      &gt; -             data |=
                      RLC_PG_CNTL__GFX_PIPELINE_PG_ENABLE_MASK;<br>
                      &gt; -     else<br>
                      &gt; -             data &amp;=
                      ~RLC_PG_CNTL__GFX_PIPELINE_PG_ENABLE_MASK;<br>
                      &gt; -<br>
                      &gt; -     if (orig != data)<br>
                      &gt; -             WREG32(mmRLC_PG_CNTL, data);<br>
                      &gt; +     WREG32_FIELD(RLC_PG_CNTL,
                      GFX_PIPELINE_PG_ENABLE, enable ? 1 : 0);<br>
                      &gt;   <br>
                      &gt;        /* Read any GFX register to wake up
                      GFX. */<br>
                      &gt;        if (!enable)<br>
                      &gt; -             data =
                      RREG32(mmDB_RENDER_CONTROL);<br>
                      &gt; +             RREG32(mmDB_RENDER_CONTROL);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      cz_update_gfx_cg_power_gating(struct amdgpu_device
                      *adev,<br>
                      &gt; @@ -5563,10 +5453,10 @@ static void
                      gfx_v8_0_send_serdes_cmd(struct amdgpu_device
                      *adev,<br>
                      &gt;   <br>
                      &gt;   #define MSG_ENTER_RLC_SAFE_MODE     1<br>
                      &gt;   #define MSG_EXIT_RLC_SAFE_MODE      0<br>
                      &gt; -<br>
                      &gt; -#define RLC_GPR_REG2__REQ_MASK          
                      0x00000001<br>
                      &gt; -#define RLC_GPR_REG2__MESSAGE__SHIFT    
                      0x00000001<br>
                      &gt; -#define RLC_GPR_REG2__MESSAGE_MASK      
                      0x0000001e<br>
                      &gt; +#define RLC_GPR_REG2__REQ_MASK 0x00000001<br>
                      &gt; +#define RLC_GPR_REG2__REQ__SHIFT 0<br>
                      &gt; +#define RLC_GPR_REG2__MESSAGE__SHIFT
                      0x00000001<br>
                      &gt; +#define RLC_GPR_REG2__MESSAGE_MASK
                      0x0000001e<br>
                      &gt;   <br>
                      &gt;   static void cz_enter_rlc_safe_mode(struct
                      amdgpu_device *adev)<br>
                      &gt;   {<br>
                      &gt; @@ -5596,7 +5486,7 @@ static void
                      cz_enter_rlc_safe_mode(struct amdgpu_device *adev)<br>
                      &gt;                }<br>
                      &gt;   <br>
                      &gt;                for (i = 0; i &lt;
                      adev-&gt;usec_timeout; i++) {<br>
                      &gt; -                     if
                      ((RREG32(mmRLC_GPR_REG2) &amp;
                      RLC_GPR_REG2__REQ_MASK) == 0)<br>
                      &gt; +                     if
                      (!REG_GET_FIELD(RREG32(mmRLC_GPR_REG2),
                      RLC_GPR_REG2, REQ))<br>
                      &gt;                                break;<br>
                      &gt;                        udelay(1);<br>
                      &gt;                }<br>
                      &gt; @@ -5624,7 +5514,7 @@ static void
                      cz_exit_rlc_safe_mode(struct amdgpu_device *adev)<br>
                      &gt;        }<br>
                      &gt;   <br>
                      &gt;        for (i = 0; i &lt;
                      adev-&gt;usec_timeout; i++) {<br>
                      &gt; -             if ((RREG32(mmRLC_GPR_REG2)
                      &amp; RLC_GPR_REG2__REQ_MASK) == 0)<br>
                      &gt; +             if
                      (!REG_GET_FIELD(RREG32(mmRLC_GPR_REG2),
                      RLC_GPR_REG2, REQ))<br>
                      &gt;                        break;<br>
                      &gt;                udelay(1);<br>
                      &gt;        }<br>
                      &gt; @@ -5656,7 +5546,7 @@ static void
                      iceland_enter_rlc_safe_mode(struct amdgpu_device
                      *adev)<br>
                      &gt;                }<br>
                      &gt;   <br>
                      &gt;                for (i = 0; i &lt;
                      adev-&gt;usec_timeout; i++) {<br>
                      &gt; -                     if
                      ((RREG32(mmRLC_SAFE_MODE) &amp;
                      RLC_SAFE_MODE__CMD_MASK) == 0)<br>
                      &gt; +                     if
                      (!REG_GET_FIELD(RREG32(mmRLC_SAFE_MODE),
                      RLC_SAFE_MODE, CMD))<br>
                      &gt;                                break;<br>
                      &gt;                        udelay(1);<br>
                      &gt;                }<br>
                      &gt; @@ -5683,7 +5573,7 @@ static void
                      iceland_exit_rlc_safe_mode(struct amdgpu_device
                      *adev)<br>
                      &gt;        }<br>
                      &gt;   <br>
                      &gt;        for (i = 0; i &lt;
                      adev-&gt;usec_timeout; i++) {<br>
                      &gt; -             if ((RREG32(mmRLC_SAFE_MODE)
                      &amp; RLC_SAFE_MODE__CMD_MASK) == 0)<br>
                      &gt; +             if
                      (!REG_GET_FIELD(RREG32(mmRLC_SAFE_MODE),
                      RLC_SAFE_MODE, CMD))<br>
                      &gt;                        break;<br>
                      &gt;                udelay(1);<br>
                      &gt;        }<br>
                      &gt; @@ -5724,21 +5614,12 @@ static void
                      gfx_v8_0_update_medium_grain_clock_gating(struct
                      amdgpu_device *adev<br>
                      &gt;        /* It is disabled by HW by default */<br>
                      &gt;        if (enable &amp;&amp;
                      (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_MGCG))
                      {<br>
                      &gt;                if (adev-&gt;cg_flags &amp;
                      AMD_CG_SUPPORT_GFX_MGLS) {<br>
                      &gt; -                     if (adev-&gt;cg_flags
                      &amp; AMD_CG_SUPPORT_GFX_RLC_LS) {<br>
                      &gt; +                     if (adev-&gt;cg_flags
                      &amp; AMD_CG_SUPPORT_GFX_RLC_LS)<br>
                      &gt;                                /* 1 - RLC
                      memory Light sleep */<br>
                      &gt; -                             temp = data =
                      RREG32(mmRLC_MEM_SLP_CNTL);<br>
                      &gt; -                             data |=
                      RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK;<br>
                      &gt; -                             if (temp !=
                      data)<br>
                      &gt; -                                    
                      WREG32(mmRLC_MEM_SLP_CNTL, data);<br>
                      &gt; -                     }<br>
                      &gt; +                            
                      WREG32_FIELD(RLC_MEM_SLP_CNTL, RLC_MEM_LS_EN, 1);<br>
                      &gt;   <br>
                      &gt; -                     if (adev-&gt;cg_flags
                      &amp; AMD_CG_SUPPORT_GFX_CP_LS) {<br>
                      &gt; -                             /* 2 - CP
                      memory Light sleep */<br>
                      &gt; -                             temp = data =
                      RREG32(mmCP_MEM_SLP_CNTL);<br>
                      &gt; -                             data |=
                      CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK;<br>
                      &gt; -                             if (temp !=
                      data)<br>
                      &gt; -                                    
                      WREG32(mmCP_MEM_SLP_CNTL, data);<br>
                      &gt; -                     }<br>
                      &gt; +                     if (adev-&gt;cg_flags
                      &amp; AMD_CG_SUPPORT_GFX_CP_LS)<br>
                      &gt; +                            
                      WREG32_FIELD(CP_MEM_SLP_CNTL, CP_MEM_LS_EN, 1);<br>
                      &gt;                }<br>
                      &gt;   <br>
                      &gt;                /* 3 - RLC_CGTT_MGCG_OVERRIDE
                      */<br>
                      &gt; @@ -6213,33 +6094,14 @@ static void
                      gfx_v8_0_ring_emit_fence_compute(struct
                      amdgpu_ring *ring,<br>
                      &gt;   static void
                      gfx_v8_0_set_gfx_eop_interrupt_state(struct
                      amdgpu_device *adev,<br>
&gt;                                                 enum
                      amdgpu_interrupt_state state)<br>
                      &gt;   {<br>
                      &gt; -     u32 cp_int_cntl;<br>
                      &gt; -<br>
                      &gt; -     switch (state) {<br>
                      &gt; -     case AMDGPU_IRQ_STATE_DISABLE:<br>
                      &gt; -             cp_int_cntl =
                      RREG32(mmCP_INT_CNTL_RING0);<br>
                      &gt; -             cp_int_cntl =
                      REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
                      &gt; -                                        
                      TIME_STAMP_INT_ENABLE, 0);<br>
                      &gt; -             WREG32(mmCP_INT_CNTL_RING0,
                      cp_int_cntl);<br>
                      &gt; -             break;<br>
                      &gt; -     case AMDGPU_IRQ_STATE_ENABLE:<br>
                      &gt; -             cp_int_cntl =
                      RREG32(mmCP_INT_CNTL_RING0);<br>
                      &gt; -             cp_int_cntl =<br>
                      &gt; -                    
                      REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
                      &gt; -                                  
                      TIME_STAMP_INT_ENABLE, 1);<br>
                      &gt; -             WREG32(mmCP_INT_CNTL_RING0,
                      cp_int_cntl);<br>
                      &gt; -             break;<br>
                      &gt; -     default:<br>
                      &gt; -             break;<br>
                      &gt; -     }<br>
                      &gt; +     WREG32_FIELD(CP_INT_CNTL_RING0,
                      TIME_STAMP_INT_ENABLE,<br>
                      &gt; +                  state ==
                      AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static void
                      gfx_v8_0_set_compute_eop_interrupt_state(struct
                      amdgpu_device *adev,<br>
&gt;                                                     int me, int
                      pipe,<br>
&gt;                                                     enum
                      amdgpu_interrupt_state state)<br>
                      &gt;   {<br>
                      &gt; -     u32 mec_int_cntl, mec_int_cntl_reg;<br>
                      &gt; -<br>
                      &gt;        /*<br>
                      &gt;         * amdgpu controls only pipe 0 of
                      MEC1. That's why this function only<br>
                      &gt;         * handles the setting of interrupts
                      for this specific pipe. All other<br>
                      &gt; @@ -6249,7 +6111,6 @@ static void
                      gfx_v8_0_set_compute_eop_interrupt_state(struct
                      amdgpu_device *adev,<br>
                      &gt;        if (me == 1) {<br>
                      &gt;                switch (pipe) {<br>
                      &gt;                case 0:<br>
                      &gt; -                     mec_int_cntl_reg =
                      mmCP_ME1_PIPE0_INT_CNTL;<br>
                      &gt;                        break;<br>
                      &gt;                default:<br>
                      &gt;                        DRM_DEBUG("invalid
                      pipe %d\n", pipe);<br>
                      &gt; @@ -6260,22 +6121,8 @@ static void
                      gfx_v8_0_set_compute_eop_interrupt_state(struct
                      amdgpu_device *adev,<br>
                      &gt;                return;<br>
                      &gt;        }<br>
                      &gt;   <br>
                      &gt; -     switch (state) {<br>
                      &gt; -     case AMDGPU_IRQ_STATE_DISABLE:<br>
                      &gt; -             mec_int_cntl =
                      RREG32(mec_int_cntl_reg);<br>
                      &gt; -             mec_int_cntl =
                      REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
                      &gt; -                                         
                      TIME_STAMP_INT_ENABLE, 0);<br>
                      &gt; -             WREG32(mec_int_cntl_reg,
                      mec_int_cntl);<br>
                      &gt; -             break;<br>
                      &gt; -     case AMDGPU_IRQ_STATE_ENABLE:<br>
                      &gt; -             mec_int_cntl =
                      RREG32(mec_int_cntl_reg);<br>
                      &gt; -             mec_int_cntl =
                      REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,<br>
                      &gt; -                                         
                      TIME_STAMP_INT_ENABLE, 1);<br>
                      &gt; -             WREG32(mec_int_cntl_reg,
                      mec_int_cntl);<br>
                      &gt; -             break;<br>
                      &gt; -     default:<br>
                      &gt; -             break;<br>
                      &gt; -     }<br>
                      &gt; +     WREG32_FIELD(CP_ME1_PIPE0_INT_CNTL,
                      TIME_STAMP_INT_ENABLE,<br>
                      &gt; +                  state ==
                      AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);<br>
                      &gt;   }<br>
                      &gt;   <br>
                      &gt;   static int
                      gfx_v8_0_set_priv_reg_fault_state(struct
                      amdgpu_device *adev,<br>
                      &gt; @@ -6283,24 +6130,8 @@ static int
                      gfx_v8_0_set_priv_reg_fault_state(struct
                      amdgpu_device *adev,<br>
                      &gt;                                            
                      unsigned type,<br>
                      &gt;                                            
                      enum amdgpu_interrupt_state state)<br>
                      &gt;   {<br>
                      &gt; -     u32 cp_int_cntl;<br>
                      &gt; -<br>
                      &gt; -     switch (state) {<br>
                      &gt; -     case AMDGPU_IRQ_STATE_DISABLE:<br>
                      &gt; -             cp_int_cntl =
                      RREG32(mmCP_INT_CNTL_RING0);<br>
                      &gt; -             cp_int_cntl =
                      REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
                      &gt; -                                        
                      PRIV_REG_INT_ENABLE, 0);<br>
                      &gt; -             WREG32(mmCP_INT_CNTL_RING0,
                      cp_int_cntl);<br>
                      &gt; -             break;<br>
                      &gt; -     case AMDGPU_IRQ_STATE_ENABLE:<br>
                      &gt; -             cp_int_cntl =
                      RREG32(mmCP_INT_CNTL_RING0);<br>
                      &gt; -             cp_int_cntl =
                      REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
                      &gt; -                                        
                      PRIV_REG_INT_ENABLE, 1);<br>
                      &gt; -             WREG32(mmCP_INT_CNTL_RING0,
                      cp_int_cntl);<br>
                      &gt; -             break;<br>
                      &gt; -     default:<br>
                      &gt; -             break;<br>
                      &gt; -     }<br>
                      &gt; +     WREG32_FIELD(CP_INT_CNTL_RING0,
                      PRIV_REG_INT_ENABLE,<br>
                      &gt; +                  state ==
                      AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);<br>
                      &gt;   <br>
                      &gt;        return 0;<br>
                      &gt;   }<br>
                      &gt; @@ -6310,24 +6141,8 @@ static int
                      gfx_v8_0_set_priv_inst_fault_state(struct
                      amdgpu_device *adev,<br>
                      &gt;                                             
                      unsigned type,<br>
                      &gt;                                             
                      enum amdgpu_interrupt_state state)<br>
                      &gt;   {<br>
                      &gt; -     u32 cp_int_cntl;<br>
                      &gt; -<br>
                      &gt; -     switch (state) {<br>
                      &gt; -     case AMDGPU_IRQ_STATE_DISABLE:<br>
                      &gt; -             cp_int_cntl =
                      RREG32(mmCP_INT_CNTL_RING0);<br>
                      &gt; -             cp_int_cntl =
                      REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
                      &gt; -                                        
                      PRIV_INSTR_INT_ENABLE, 0);<br>
                      &gt; -             WREG32(mmCP_INT_CNTL_RING0,
                      cp_int_cntl);<br>
                      &gt; -             break;<br>
                      &gt; -     case AMDGPU_IRQ_STATE_ENABLE:<br>
                      &gt; -             cp_int_cntl =
                      RREG32(mmCP_INT_CNTL_RING0);<br>
                      &gt; -             cp_int_cntl =
                      REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,<br>
                      &gt; -                                        
                      PRIV_INSTR_INT_ENABLE, 1);<br>
                      &gt; -             WREG32(mmCP_INT_CNTL_RING0,
                      cp_int_cntl);<br>
                      &gt; -             break;<br>
                      &gt; -     default:<br>
                      &gt; -             break;<br>
                      &gt; -     }<br>
                      &gt; +     WREG32_FIELD(CP_INT_CNTL_RING0,
                      PRIV_INSTR_INT_ENABLE,<br>
                      &gt; +                  state ==
                      AMDGPU_IRQ_STATE_DISABLE ? 0 : 1);<br>
                      &gt;   <br>
                      &gt;        return 0;<br>
                      &gt;   }<br>
                      <br>
                      <br>
                    </div>
                  </span></font></div>
            </div>
          </div>
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

--------------434CD24A89AB957B29AADAA0--

--===============0369700958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0369700958==--
