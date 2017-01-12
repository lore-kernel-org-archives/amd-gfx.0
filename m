From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[V3_04/11]_drm/amdgpu/virt:_use_k?=
 =?UTF-8?Q?iq_to_access_registers?=
Date: Thu, 12 Jan 2017 12:13:36 +0100
Message-ID: <ce44050c-b8fc-c9b4-8f74-b6c0dea3405b@vodafone.de>
References: <1484140698-10548-1-git-send-email-Xiangliang.Yu@amd.com>
 <1484140698-10548-5-git-send-email-Xiangliang.Yu@amd.com>
 <c6c7dbf9-03db-2528-78cd-b1390dcab10d@vodafone.de>
 <BY2PR1201MB11104C83B83FB2CEA6B26A2884660@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <d4e006ef-a0a2-bbc3-3582-d259d1e6a75b@vodafone.de>
 <BY2PR1201MB11107C560860494991E6D6F884660@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <f79c252c-369b-235e-2160-231b4ac32235@vodafone.de>
 <BY2PR1201MB11106D68693C869D3E7D431884660@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <BY2PR1201MB11108F4CBFB28D71407DE56184790@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <BY2PR1201MB11102241041CA3C7C37D25D984790@BY2PR1201MB1110.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0542983964=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB11102241041CA3C7C37D25D984790-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0542983964==
Content-Type: multipart/alternative;
 boundary="------------F933A9D5891E0D8F251296FC"

This is a multi-part message in MIME format.
--------------F933A9D5891E0D8F251296FC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I would go a step further and put the BUG_ON(in_interrupt()) into 
amdgpu_virt_kiq_rreg().

And BTW the problem is even worse, you also can't lock a mutex inside an 
atomic section and we could have plenty of that as well in the driver code.

Regards,
Christian.

Am 12.01.2017 um 04:21 schrieb Liu, Monk:
>
> Xiangliang
>
> please BUG() when register access occured in RUNTIME and IRQ context, 
> e.g.:
>
> for register read:
> if (amdgpu_sriov_runtime(adev)) {
>    if (in_interrupt())
>         BUG();
>    else
> return amdgpu_virt_kiq_rreg(adev, reg, v);
> }
>
> and also for register write, with above addressed, Reviewed-by: Monk 
> Liu <monk.liu-5C7GfCeVMHo@public.gmane.org>
>
> ------------------------------------------------------------------------
> *发件人:* Liu, Monk
> *发送时间:* 2017年1月12日 11:19:40
> *收件人:* Christian König; Yu, Xiangliang; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* 答复: [V3 04/11] drm/amdgpu/virt: use kiq to access registers
>
> Xiangliang
>
>
> please BUG() when register access occured in RUNTIME and IRQ context, 
> e.g.:
>
>
> if (amdgpu_sriov_runtime(adev)) {
>
>
> }
>   return amdgpu_virt_kiq_wreg(adev, reg, v);
>
>
> with above addressed, Reviewed-by: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org>
>
> ------------------------------------------------------------------------
> *发件人:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> 代表 Liu, Monk 
> <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> *发送时间:* 2017年1月11日 22:54:52
> *收件人:* Christian König; Yu, Xiangliang; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* RE: [V3 04/11] drm/amdgpu/virt: use kiq to access registers
> We should BUG and not access register at all if found during RUNTIME 
> && IRQ_context
> By far.
>
> BR Monk
> -----Original Message-----
> From: Christian König [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
> Sent: Wednesday, January 11, 2017 10:44 PM
> To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Yu, Xiangliang 
> <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: Re: [V3 04/11] drm/amdgpu/virt: use kiq to access registers
>
> > do you think that's okay ?
> Fine with me, but I'm not sure if the hypervisor doesn't gets a hickup 
> when a client writes to some registers from interrupt context.
>
> Christian.
>
> Am 11.01.2017 um 15:38 schrieb Liu, Monk:
> > Yeah, make sense
> >
> > I think before we have a full version of KIQ reg accessing without 
> context switch, we should totally disable KIQ reg read/write in IRQ 
> context, do you think that's okay ?
> >
> > BR Monk
> >
> > -----Original Message-----
> > From: Christian König [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
> > Sent: Wednesday, January 11, 2017 10:16 PM
> > To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Yu, Xiangliang
> > <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Subject: Re: [V3 04/11] drm/amdgpu/virt: use kiq to access registers
> >
> >> Because if we are in interrupt , we are forbid to do schedule, and 
> use kiq to read register will invoke fence_wait() ...
> > That won't work. Locking a mutext like it is done in the write path 
> can cause scheduling as well.
> >
> > If we need to push writes through the KIQ in interrupt context we 
> need to change the code to use a spinlock with disabled interrupts 
> instead of a mutex.
> >
> > Otherwise the whole thing can easily deadlock when an interrupt 
> happens to come while the lock is taken.
> >
> > Please also test the patchset with lockdep enabled, that should 
> yield a bunch of error messages when you try to do something like this.
> >
> > Regards,
> > Christian.
> >
> > Am 11.01.2017 um 14:51 schrieb Liu, Monk:
> >> Because if we are in interrupt , we are forbid to do schedule, and 
> use kiq to read register will invoke fence_wait() ...
> >>
> >> If you think that's odds, we can use BUG_ON() to stop driver 
> running if we need read registers in SRIOV case.
> >>
> >> And to fully support register reading, we need to implement a new
> >> method to use KIQ access register without any schedule() chance, but
> >> that's overhead for current stage, and we don't observe registers
> >> reading in IRQ context now on 3D apps. (kfd observed such case, and
> >> @Shaoyun dispatches a kernel thread/tasklet in IRQ to do the register
> >> dumping, instead of directly reading them via KIQ )
> >>
> >> BR Monk
> >>
> >> -----Original Message-----
> >> From: Christian König [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
> >> Sent: Wednesday, January 11, 2017 9:38 PM
> >> To: Yu, Xiangliang <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>;
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> Cc: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> >> Subject: Re: [V3 04/11] drm/amdgpu/virt: use kiq to access registers
> >>
> >> Am 11.01.2017 um 14:18 schrieb Xiangliang Yu:
> >>> For virtualization, it is must for driver to use KIQ to access
> >>> registers when it is out of GPU full access mode.
> >>>
> >>> Signed-off-by: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
> >>> Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> >>> ---
> >>> drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +-
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 82 
> ++++++++++++++++++++++++++++++
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  5 ++
> >>> drivers/gpu/drm/amd/amdgpu/vi.c            |  3 ++
> >>>     5 files changed, 97 insertions(+), 1 deletion(-)
> >>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> >>> b/drivers/gpu/drm/amd/amdgpu/Makefile
> >>> index 4185b03..0b8e470 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> >>> @@ -30,7 +30,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
> >>>      atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
> >>>      amdgpu_prime.o amdgpu_vm.o amdgpu_ib.o amdgpu_pll.o \
> >>>      amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
> >>> -   amdgpu_gtt_mgr.o amdgpu_vram_mgr.o
> >>> +   amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o
> >>>
> >>>     # add asic specific block
> >>>     amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o
> >>> kv_dpm.o \ diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> index f82919d..9a2fd3e 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -95,6 +95,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device 
> *adev, uint32_t reg,
> >>>     {
> >>>      uint32_t ret;
> >>>
> >>> +   if (amdgpu_sriov_runtime(adev) && !in_interrupt())
> >>> +           return amdgpu_virt_kiq_rreg(adev, reg);
> >>> +
> >> Mhm, why is the in_interrupt() necessary here?
> >>
> >>>      if ((reg * 4) < adev->rmmio_size && !always_indirect)
> >>>              ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> >>>      else {
> >>> @@ -114,6 +117,9 @@ void amdgpu_mm_wreg(struct amdgpu_device 
> *adev, uint32_t reg, uint32_t v,
> >>>     {
> >>> trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
> >>>
> >>> +   if (amdgpu_sriov_runtime(adev))
> >>> +           return amdgpu_virt_kiq_wreg(adev, reg, v);
> >>> +
> >> And why it isn't necessary here? What happens when we write a 
> register from an interrupt routine?
> >>
> >> Christian.
> >>
> >>>      if ((reg * 4) < adev->rmmio_size && !always_indirect)
> >>>              writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> >>>      else {
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >>> new file mode 100644
> >>> index 0000000..7861b6b
> >>> --- /dev/null
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >>> @@ -0,0 +1,82 @@
> >>> +/*
> >>> + * Copyright 2017 Advanced Micro Devices, Inc.
> >>> + *
> >>> + * Permission is hereby granted, free of charge, to any person
> >>> +obtaining a
> >>> + * copy of this software and associated documentation files (the
> >>> +"Software"),
> >>> + * to deal in the Software without restriction, including without
> >>> +limitation
> >>> + * the rights to use, copy, modify, merge, publish, distribute,
> >>> +sublicense,
> >>> + * and/or sell copies of the Software, and to permit persons to
> >>> +whom the
> >>> + * Software is furnished to do so, subject to the following 
> conditions:
> >>> + *
> >>> + * The above copyright notice and this permission notice shall be
> >>> +included in
> >>> + * all copies or substantial portions of the Software.
> >>> + *
> >>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> >>> +EXPRESS OR
> >>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> >>> +MERCHANTABILITY,
> >>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> >>> +EVENT SHALL
> >>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> >>> +DAMAGES OR
> >>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> >>> +OTHERWISE,
> >>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> >>> +USE OR
> >>> + * OTHER DEALINGS IN THE SOFTWARE.
> >>> + */
> >>> +
> >>> +#include "amdgpu.h"
> >>> +#include "amdgpu_virt.h"
> >>> +
> >>> +void amdgpu_virt_init_setting(struct amdgpu_device *adev) {
> >>> +   mutex_init(&adev->virt.lock);
> >>> +}
> >>> +
> >>> +uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t
> >>> +reg) {
> >>> +   signed long r;
> >>> +   uint32_t val;
> >>> +   struct fence *f;
> >>> +   struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> >>> +   struct amdgpu_ring *ring = &kiq->ring;
> >>> +
> >>> +   BUG_ON(!ring->funcs->emit_rreg);
> >>> +
> >>> +   mutex_lock(&adev->virt.lock);
> >>> +   amdgpu_ring_alloc(ring, 32);
> >>> +   amdgpu_ring_emit_hdp_flush(ring);
> >>> +   amdgpu_ring_emit_rreg(ring, reg);
> >>> +   amdgpu_ring_emit_hdp_invalidate(ring);
> >>> +   amdgpu_fence_emit(ring, &f);
> >>> +   amdgpu_ring_commit(ring);
> >>> +   mutex_unlock(&adev->virt.lock);
> >>> +
> >>> +   r = fence_wait(f, false);
> >>> +   if (r)
> >>> +           DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> >>> +   fence_put(f);
> >>> +
> >>> +   val = adev->wb.wb[adev->virt.reg_val_offs];
> >>> +
> >>> +   return val;
> >>> +}
> >>> +
> >>> +void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
> >>> +uint32_t v) {
> >>> +   signed long r;
> >>> +   struct fence *f;
> >>> +   struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> >>> +   struct amdgpu_ring *ring = &kiq->ring;
> >>> +
> >>> +   BUG_ON(!ring->funcs->emit_wreg);
> >>> +
> >>> +   mutex_lock(&adev->virt.lock);
> >>> +   amdgpu_ring_alloc(ring, 32);
> >>> +   amdgpu_ring_emit_hdp_flush(ring);
> >>> +   amdgpu_ring_emit_wreg(ring, reg, v);
> >>> +   amdgpu_ring_emit_hdp_invalidate(ring);
> >>> +   amdgpu_fence_emit(ring, &f);
> >>> +   amdgpu_ring_commit(ring);
> >>> +   mutex_unlock(&adev->virt.lock);
> >>> +
> >>> +   r = fence_wait(f, false);
> >>> +   if (r)
> >>> +           DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> >>> +   fence_put(f);
> >>> +}
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> >>> index 3d38a9f..2869980 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> >>> @@ -33,6 +33,7 @@
> >>>     struct amdgpu_virt {
> >>>      uint32_t                caps;
> >>>      uint32_t                reg_val_offs;
> >>> +   struct mutex            lock;
> >>>     };
> >>>
> >>>     #define amdgpu_sriov_enabled(adev) \ @@ -59,4 +60,8 @@ static
> >>> inline bool is_virtual_machine(void)
> >>>     #endif
> >>>     }
> >>>
> >>> +void amdgpu_virt_init_setting(struct amdgpu_device *adev); uint32_t
> >>> +amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
> >>> +void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
> >>> +uint32_t v);
> >>> +
> >>>     #endif
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>> b/drivers/gpu/drm/amd/amdgpu/vi.c index 7350a8f..dc0d4fa 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> >>> @@ -892,6 +892,9 @@ static int vi_common_early_init(void *handle)
> >>>              (amdgpu_ip_block_mask & (1 << AMD_IP_BLOCK_TYPE_SMC)))
> >>>              smc_enabled = true;
> >>>
> >>> +   if (amdgpu_sriov_vf(adev))
> >>> +           amdgpu_virt_init_setting(adev);
> >>> +
> >>>      adev->rev_id = vi_get_rev_id(adev);
> >>>      adev->external_rev_id = 0xFF;
> >>>      switch (adev->asic_type) {
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------F933A9D5891E0D8F251296FC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">I would go a step further and put the
      BUG_ON(in_interrupt()) into amdgpu_virt_kiq_rreg().<br>
      <br>
      And BTW the problem is even worse, you also can't lock a mutex
      inside an atomic section and we could have plenty of that as well
      in the driver code.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 12.01.2017 um 04:21 schrieb Liu, Monk:<br>
    </div>
    <blockquote
cite="mid:BY2PR1201MB11102241041CA3C7C37D25D984790-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p><span style="font-size:12pt;" id="x_divtagdefaultwrapper"></span></p>
        <div style="margin-top:0;margin-bottom:0;">Xiangliang</div>
        <div style="margin-top:0;margin-bottom:0;"><br>
        </div>
        <div style="margin-top:0;margin-bottom:0;">please BUG() when
          register access occured in RUNTIME and IRQ context, e.g.:</div>
        <div style="margin-top:0;margin-bottom:0;"><br>
          for register read:<br>
        </div>
        <div style="margin-top:0;margin-bottom:0;"><font size="2"><span
              style="font-size:10pt;">if (amdgpu_sriov_runtime(adev)) {</span></font></div>
        <div style="margin-top:0;margin-bottom:0;"><font size="2"><span
              style="font-size:10pt;">   if (<font size="2"><span
                  style="font-size:10pt;">in_interrupt()</span></font>)<br>
                      BUG();<br>
                 else<br>
                     <span style="font-size:12pt;"
                id="x_divtagdefaultwrapper"><font size="2"><span
                    style="font-size:10pt;">return
                    amdgpu_virt_kiq_rreg(adev, reg, v);</span></font></span> 
              <br>
            </span></font></div>
        <div style="margin-top:0;margin-bottom:0;"><font size="2"><span
              style="font-size:10pt;">}</span></font><font size="2"><span
              style="font-size:10pt;"><br>
              <br>
              <span style="font-size: 12pt;">and also </span><span
                style="font-size: 12pt;">for register write</span></span></font>,
          with above addressed, Reviewed-by: Monk Liu
          <a class="moz-txt-link-rfc2396E" href="mailto:monk.liu-5C7GfCeVMHo@public.gmane.org">&lt;monk.liu-5C7GfCeVMHo@public.gmane.org&gt;</a>
        </div>
        <br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          color="#000000" face="Calibri, sans-serif"><b>发件人:</b> Liu,
          Monk<br>
          <b>发送时间:</b> 2017年1月12日 11:19:40<br>
          <b>收件人:</b> Christian König; Yu, Xiangliang;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>主题:</b> 答复: [V3 04/11] drm/amdgpu/virt: use kiq to access
          registers</font>
        <div> </div>
      </div>
      <div>
        <meta content="text/html; charset=UTF-8">
        <style type="text/css" style="">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
        <div dir="ltr">
          <div id="x_divtagdefaultwrapper" dir="ltr"
            style="font-size:12pt; color:#000000;
            font-family:Calibri,Arial,Helvetica,sans-serif">
            <p>Xiangliang</p>
            <p><br>
            </p>
            <p>please BUG() when register access occured in RUNTIME and
              IRQ context, e.g.:</p>
            <p><br>
            </p>
            <p><font size="2"><span style="font-size:10pt">if
                  (amdgpu_sriov_runtime(adev)) {</span></font></p>
            <p><font size="2"><span style="font-size:10pt"><br>
                </span></font></p>
            <p><font size="2"><span style="font-size:10pt">}<br>
                    return amdgpu_virt_kiq_wreg(adev, reg, v);</span></font><br>
            </p>
            <p><br>
            </p>
            <p>with above addressed, Reviewed-by: Monk Liu
              <a class="moz-txt-link-rfc2396E" href="mailto:monk.liu-5C7GfCeVMHo@public.gmane.org">&lt;monk.liu-5C7GfCeVMHo@public.gmane.org&gt;</a> <br>
            </p>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="x_divRplyFwdMsg" dir="ltr"><font
              style="font-size:11pt" color="#000000" face="Calibri,
              sans-serif"><b>发件人:</b> amd-gfx
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> 代表 Liu, Monk
              <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>发送时间:</b> 2017年1月11日 22:54:52<br>
              <b>收件人:</b> Christian König; Yu, Xiangliang;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>主题:</b> RE: [V3 04/11] drm/amdgpu/virt: use kiq to
              access registers</font>
            <div> </div>
          </div>
        </div>
        <font size="2"><span style="font-size:10pt;">
            <div class="PlainText">We should BUG and not access register
              at all if found during RUNTIME &amp;&amp; IRQ_context<br>
              By far.<br>
              <br>
              BR Monk<br>
              -----Original Message-----<br>
              From: Christian König [<a moz-do-not-send="true"
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]
              <br>
              Sent: Wednesday, January 11, 2017 10:44 PM<br>
              To: Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>; Yu, Xiangliang
              <a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              Subject: Re: [V3 04/11] drm/amdgpu/virt: use kiq to access
              registers<br>
              <br>
              &gt; do you think that's okay ?<br>
              Fine with me, but I'm not sure if the hypervisor doesn't
              gets a hickup when a client writes to some registers from
              interrupt context.<br>
              <br>
              Christian.<br>
              <br>
              Am 11.01.2017 um 15:38 schrieb Liu, Monk:<br>
              &gt; Yeah, make sense<br>
              &gt;<br>
              &gt; I think before we have a full version of KIQ reg
              accessing without context switch, we should totally
              disable KIQ reg read/write in IRQ context, do you think
              that's okay ?<br>
              &gt;<br>
              &gt; BR Monk<br>
              &gt;<br>
              &gt; -----Original Message-----<br>
              &gt; From: Christian König [<a moz-do-not-send="true"
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]<br>
              &gt; Sent: Wednesday, January 11, 2017 10:16 PM<br>
              &gt; To: Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>; Yu,
              Xiangliang <br>
              &gt; <a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              &gt; Subject: Re: [V3 04/11] drm/amdgpu/virt: use kiq to
              access registers<br>
              &gt;<br>
              &gt;&gt; Because if we are in interrupt , we are forbid to
              do schedule, and use kiq to read register will invoke
              fence_wait() ...<br>
              &gt; That won't work. Locking a mutext like it is done in
              the write path can cause scheduling as well.<br>
              &gt;<br>
              &gt; If we need to push writes through the KIQ in
              interrupt context we need to change the code to use a
              spinlock with disabled interrupts instead of a mutex.<br>
              &gt;<br>
              &gt; Otherwise the whole thing can easily deadlock when an
              interrupt happens to come while the lock is taken.<br>
              &gt;<br>
              &gt; Please also test the patchset with lockdep enabled,
              that should yield a bunch of error messages when you try
              to do something like this.<br>
              &gt;<br>
              &gt; Regards,<br>
              &gt; Christian.<br>
              &gt;<br>
              &gt; Am 11.01.2017 um 14:51 schrieb Liu, Monk:<br>
              &gt;&gt; Because if we are in interrupt , we are forbid to
              do schedule, and use kiq to read register will invoke
              fence_wait() ...<br>
              &gt;&gt;<br>
              &gt;&gt; If you think that's odds, we can use BUG_ON() to
              stop driver running if we need read registers in SRIOV
              case.<br>
              &gt;&gt;<br>
              &gt;&gt; And to fully support register reading, we need to
              implement a new <br>
              &gt;&gt; method to use KIQ access register without any
              schedule() chance, but <br>
              &gt;&gt; that's overhead for current stage, and we don't
              observe registers <br>
              &gt;&gt; reading in IRQ context now on 3D apps. (kfd
              observed such case, and <br>
              &gt;&gt; @Shaoyun dispatches a kernel thread/tasklet in
              IRQ to do the register <br>
              &gt;&gt; dumping, instead of directly reading them via KIQ
              )<br>
              &gt;&gt;    <br>
              &gt;&gt; BR Monk<br>
              &gt;&gt;<br>
              &gt;&gt; -----Original Message-----<br>
              &gt;&gt; From: Christian König [<a moz-do-not-send="true"
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]<br>
              &gt;&gt; Sent: Wednesday, January 11, 2017 9:38 PM<br>
              &gt;&gt; To: Yu, Xiangliang <a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
              <br>
              &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              &gt;&gt; Cc: Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt;&gt; Subject: Re: [V3 04/11] drm/amdgpu/virt: use kiq
              to access registers<br>
              &gt;&gt;<br>
              &gt;&gt; Am 11.01.2017 um 14:18 schrieb Xiangliang Yu:<br>
              &gt;&gt;&gt; For virtualization, it is must for driver to
              use KIQ to access <br>
              &gt;&gt;&gt; registers when it is out of GPU full access
              mode.<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; Signed-off-by: Xiangliang Yu
              <a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt;&gt;&gt; Signed-off-by: Monk Liu
              <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt;&gt;&gt; ---<br>
              &gt;&gt;&gt;    
              drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +-<br>
              &gt;&gt;&gt;    
              drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++<br>
              &gt;&gt;&gt;    
              drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 82
              ++++++++++++++++++++++++++++++<br>
              &gt;&gt;&gt;    
              drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  5 ++<br>
              &gt;&gt;&gt;    
              drivers/gpu/drm/amd/amdgpu/vi.c            |  3 ++<br>
              &gt;&gt;&gt;     5 files changed, 97 insertions(+), 1
              deletion(-)<br>
              &gt;&gt;&gt;     create mode 100644
              drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
              &gt;&gt;&gt;<br>
              &gt;&gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
              &gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
              &gt;&gt;&gt; index 4185b03..0b8e470 100644<br>
              &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
              &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
              &gt;&gt;&gt; @@ -30,7 +30,7 @@ amdgpu-y += amdgpu_device.o
              amdgpu_kms.o \<br>
              &gt;&gt;&gt;      atombios_encoders.o amdgpu_sa.o
              atombios_i2c.o \<br>
              &gt;&gt;&gt;      amdgpu_prime.o amdgpu_vm.o amdgpu_ib.o
              amdgpu_pll.o \<br>
              &gt;&gt;&gt;      amdgpu_ucode.o amdgpu_bo_list.o
              amdgpu_ctx.o amdgpu_sync.o \<br>
              &gt;&gt;&gt; -   amdgpu_gtt_mgr.o amdgpu_vram_mgr.o<br>
              &gt;&gt;&gt; +   amdgpu_gtt_mgr.o amdgpu_vram_mgr.o
              amdgpu_virt.o<br>
              &gt;&gt;&gt;     <br>
              &gt;&gt;&gt;     # add asic specific block<br>
              &gt;&gt;&gt;     amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o
              cik_ih.o kv_smc.o <br>
              &gt;&gt;&gt; kv_dpm.o \ diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt;&gt; index f82919d..9a2fd3e 100644<br>
              &gt;&gt;&gt; ---
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt;&gt; +++
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
              &gt;&gt;&gt; @@ -95,6 +95,9 @@ uint32_t
              amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,<br>
              &gt;&gt;&gt;     {<br>
              &gt;&gt;&gt;      uint32_t ret;<br>
              &gt;&gt;&gt;     <br>
              &gt;&gt;&gt; +   if (amdgpu_sriov_runtime(adev) &amp;&amp;
              !in_interrupt())<br>
              &gt;&gt;&gt; +           return amdgpu_virt_kiq_rreg(adev,
              reg);<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt; Mhm, why is the in_interrupt() necessary here?<br>
              &gt;&gt;<br>
              &gt;&gt;&gt;      if ((reg * 4) &lt; adev-&gt;rmmio_size
              &amp;&amp; !always_indirect)<br>
              &gt;&gt;&gt;              ret = readl(((void __iomem
              *)adev-&gt;rmmio) + (reg * 4));<br>
              &gt;&gt;&gt;      else {<br>
              &gt;&gt;&gt; @@ -114,6 +117,9 @@ void
              amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg,
              uint32_t v,<br>
              &gt;&gt;&gt;     {<br>
              &gt;&gt;&gt;     
              trace_amdgpu_mm_wreg(adev-&gt;pdev-&gt;device, reg, v);<br>
              &gt;&gt;&gt;     <br>
              &gt;&gt;&gt; +   if (amdgpu_sriov_runtime(adev))<br>
              &gt;&gt;&gt; +           return amdgpu_virt_kiq_wreg(adev,
              reg, v);<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt; And why it isn't necessary here? What happens
              when we write a register from an interrupt routine?<br>
              &gt;&gt;<br>
              &gt;&gt; Christian.<br>
              &gt;&gt;<br>
              &gt;&gt;&gt;      if ((reg * 4) &lt; adev-&gt;rmmio_size
              &amp;&amp; !always_indirect)<br>
              &gt;&gt;&gt;              writel(v, ((void __iomem
              *)adev-&gt;rmmio) + (reg * 4));<br>
              &gt;&gt;&gt;      else {<br>
              &gt;&gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
              &gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
              &gt;&gt;&gt; new file mode 100644<br>
              &gt;&gt;&gt; index 0000000..7861b6b<br>
              &gt;&gt;&gt; --- /dev/null<br>
              &gt;&gt;&gt; +++
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
              &gt;&gt;&gt; @@ -0,0 +1,82 @@<br>
              &gt;&gt;&gt; +/*<br>
              &gt;&gt;&gt; + * Copyright 2017 Advanced Micro Devices,
              Inc.<br>
              &gt;&gt;&gt; + *<br>
              &gt;&gt;&gt; + * Permission is hereby granted, free of
              charge, to any person <br>
              &gt;&gt;&gt; +obtaining a<br>
              &gt;&gt;&gt; + * copy of this software and associated
              documentation files (the <br>
              &gt;&gt;&gt; +"Software"),<br>
              &gt;&gt;&gt; + * to deal in the Software without
              restriction, including without <br>
              &gt;&gt;&gt; +limitation<br>
              &gt;&gt;&gt; + * the rights to use, copy, modify, merge,
              publish, distribute, <br>
              &gt;&gt;&gt; +sublicense,<br>
              &gt;&gt;&gt; + * and/or sell copies of the Software, and
              to permit persons to <br>
              &gt;&gt;&gt; +whom the<br>
              &gt;&gt;&gt; + * Software is furnished to do so, subject
              to the following conditions:<br>
              &gt;&gt;&gt; + *<br>
              &gt;&gt;&gt; + * The above copyright notice and this
              permission notice shall be <br>
              &gt;&gt;&gt; +included in<br>
              &gt;&gt;&gt; + * all copies or substantial portions of the
              Software.<br>
              &gt;&gt;&gt; + *<br>
              &gt;&gt;&gt; + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
              WARRANTY OF ANY KIND, <br>
              &gt;&gt;&gt; +EXPRESS OR<br>
              &gt;&gt;&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE
              WARRANTIES OF <br>
              &gt;&gt;&gt; +MERCHANTABILITY,<br>
              &gt;&gt;&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND
              NONINFRINGEMENT.  IN NO <br>
              &gt;&gt;&gt; +EVENT SHALL<br>
              &gt;&gt;&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE
              LIABLE FOR ANY CLAIM, <br>
              &gt;&gt;&gt; +DAMAGES OR<br>
              &gt;&gt;&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF
              CONTRACT, TORT OR <br>
              &gt;&gt;&gt; +OTHERWISE,<br>
              &gt;&gt;&gt; + * ARISING FROM, OUT OF OR IN CONNECTION
              WITH THE SOFTWARE OR THE <br>
              &gt;&gt;&gt; +USE OR<br>
              &gt;&gt;&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
              &gt;&gt;&gt; + */<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +#include "amdgpu.h"<br>
              &gt;&gt;&gt; +#include "amdgpu_virt.h"<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +void amdgpu_virt_init_setting(struct
              amdgpu_device *adev) {<br>
              &gt;&gt;&gt; +   mutex_init(&amp;adev-&gt;virt.lock);<br>
              &gt;&gt;&gt; +}<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +uint32_t amdgpu_virt_kiq_rreg(struct
              amdgpu_device *adev, uint32_t<br>
              &gt;&gt;&gt; +reg) {<br>
              &gt;&gt;&gt; +   signed long r;<br>
              &gt;&gt;&gt; +   uint32_t val;<br>
              &gt;&gt;&gt; +   struct fence *f;<br>
              &gt;&gt;&gt; +   struct amdgpu_kiq *kiq =
              &amp;adev-&gt;gfx.kiq;<br>
              &gt;&gt;&gt; +   struct amdgpu_ring *ring =
              &amp;kiq-&gt;ring;<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +   BUG_ON(!ring-&gt;funcs-&gt;emit_rreg);<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +   mutex_lock(&amp;adev-&gt;virt.lock);<br>
              &gt;&gt;&gt; +   amdgpu_ring_alloc(ring, 32);<br>
              &gt;&gt;&gt; +   amdgpu_ring_emit_hdp_flush(ring);<br>
              &gt;&gt;&gt; +   amdgpu_ring_emit_rreg(ring, reg);<br>
              &gt;&gt;&gt; +   amdgpu_ring_emit_hdp_invalidate(ring);<br>
              &gt;&gt;&gt; +   amdgpu_fence_emit(ring, &amp;f);<br>
              &gt;&gt;&gt; +   amdgpu_ring_commit(ring);<br>
              &gt;&gt;&gt; +   mutex_unlock(&amp;adev-&gt;virt.lock);<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +   r = fence_wait(f, false);<br>
              &gt;&gt;&gt; +   if (r)<br>
              &gt;&gt;&gt; +           DRM_ERROR("wait for kiq fence
              error: %ld.\n", r);<br>
              &gt;&gt;&gt; +   fence_put(f);<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +   val =
              adev-&gt;wb.wb[adev-&gt;virt.reg_val_offs];<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +   return val;<br>
              &gt;&gt;&gt; +}<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +void amdgpu_virt_kiq_wreg(struct
              amdgpu_device *adev, uint32_t reg, <br>
              &gt;&gt;&gt; +uint32_t v) {<br>
              &gt;&gt;&gt; +   signed long r;<br>
              &gt;&gt;&gt; +   struct fence *f;<br>
              &gt;&gt;&gt; +   struct amdgpu_kiq *kiq =
              &amp;adev-&gt;gfx.kiq;<br>
              &gt;&gt;&gt; +   struct amdgpu_ring *ring =
              &amp;kiq-&gt;ring;<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +   BUG_ON(!ring-&gt;funcs-&gt;emit_wreg);<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +   mutex_lock(&amp;adev-&gt;virt.lock);<br>
              &gt;&gt;&gt; +   amdgpu_ring_alloc(ring, 32);<br>
              &gt;&gt;&gt; +   amdgpu_ring_emit_hdp_flush(ring);<br>
              &gt;&gt;&gt; +   amdgpu_ring_emit_wreg(ring, reg, v);<br>
              &gt;&gt;&gt; +   amdgpu_ring_emit_hdp_invalidate(ring);<br>
              &gt;&gt;&gt; +   amdgpu_fence_emit(ring, &amp;f);<br>
              &gt;&gt;&gt; +   amdgpu_ring_commit(ring);<br>
              &gt;&gt;&gt; +   mutex_unlock(&amp;adev-&gt;virt.lock);<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt; +   r = fence_wait(f, false);<br>
              &gt;&gt;&gt; +   if (r)<br>
              &gt;&gt;&gt; +           DRM_ERROR("wait for kiq fence
              error: %ld.\n", r);<br>
              &gt;&gt;&gt; +   fence_put(f);<br>
              &gt;&gt;&gt; +}<br>
              &gt;&gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
              &gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
              &gt;&gt;&gt; index 3d38a9f..2869980 100644<br>
              &gt;&gt;&gt; ---
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
              &gt;&gt;&gt; +++
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
              &gt;&gt;&gt; @@ -33,6 +33,7 @@<br>
              &gt;&gt;&gt;     struct amdgpu_virt {<br>
              &gt;&gt;&gt;      uint32_t                caps;<br>
              &gt;&gt;&gt;      uint32_t                reg_val_offs;<br>
              &gt;&gt;&gt; +   struct mutex            lock;<br>
              &gt;&gt;&gt;     };<br>
              &gt;&gt;&gt;     <br>
              &gt;&gt;&gt;     #define amdgpu_sriov_enabled(adev) \ @@
              -59,4 +60,8 @@ static <br>
              &gt;&gt;&gt; inline bool is_virtual_machine(void)<br>
              &gt;&gt;&gt;     #endif<br>
              &gt;&gt;&gt;     }<br>
              &gt;&gt;&gt;     <br>
              &gt;&gt;&gt; +void amdgpu_virt_init_setting(struct
              amdgpu_device *adev); uint32_t <br>
              &gt;&gt;&gt; +amdgpu_virt_kiq_rreg(struct amdgpu_device
              *adev, uint32_t reg); <br>
              &gt;&gt;&gt; +void amdgpu_virt_kiq_wreg(struct
              amdgpu_device *adev, uint32_t reg, <br>
              &gt;&gt;&gt; +uint32_t v);<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt;     #endif<br>
              &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
              <br>
              &gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/vi.c index
              7350a8f..dc0d4fa 100644<br>
              &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
              &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
              &gt;&gt;&gt; @@ -892,6 +892,9 @@ static int
              vi_common_early_init(void *handle)<br>
              &gt;&gt;&gt;              (amdgpu_ip_block_mask &amp; (1
              &lt;&lt; AMD_IP_BLOCK_TYPE_SMC)))<br>
              &gt;&gt;&gt;              smc_enabled = true;<br>
              &gt;&gt;&gt;     <br>
              &gt;&gt;&gt; +   if (amdgpu_sriov_vf(adev))<br>
              &gt;&gt;&gt; +           amdgpu_virt_init_setting(adev);<br>
              &gt;&gt;&gt; +<br>
              &gt;&gt;&gt;      adev-&gt;rev_id = vi_get_rev_id(adev);<br>
              &gt;&gt;&gt;      adev-&gt;external_rev_id = 0xFF;<br>
              &gt;&gt;&gt;      switch (adev-&gt;asic_type) {<br>
              &gt;&gt; _______________________________________________<br>
              &gt;&gt; amd-gfx mailing list<br>
              &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              &gt;&gt; <a moz-do-not-send="true"
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
              &gt;<br>
              &gt; _______________________________________________<br>
              &gt; amd-gfx mailing list<br>
              &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              &gt; <a moz-do-not-send="true"
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
              <br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a moz-do-not-send="true"
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </div>
          </span></font></div>
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

--------------F933A9D5891E0D8F251296FC--

--===============0542983964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0542983964==--
