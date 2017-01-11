From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[V2_04/11]_drm/amdgpu/virt:_use_k?=
 =?UTF-8?Q?iq_to_access_registers?=
Date: Wed, 11 Jan 2017 12:48:48 +0100
Message-ID: <7e00784c-bd61-f8e0-679a-93088ef1f598@vodafone.de>
References: <1484042450-22987-1-git-send-email-Xiangliang.Yu@amd.com>
 <1484042450-22987-5-git-send-email-Xiangliang.Yu@amd.com>
 <35600919-5cd3-4920-f2dd-db0e0620e3fa@vodafone.de>
 <BY2PR1201MB111068093D612E37CCD64DF284660@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <BY2PR1201MB11107ADADF57EBE79AB97D7F84660@BY2PR1201MB1110.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0133177040=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB11107ADADF57EBE79AB97D7F84660-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
--===============0133177040==
Content-Type: multipart/alternative;
 boundary="------------7EC5290A333DF7D71F753FB5"

This is a multi-part message in MIME format.
--------------7EC5290A333DF7D71F753FB5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Ah, that issue again. Yeah that was fixed in the meantime. Please remove 
the extra fance_get()/fence_put() for upstreaming.

If an old branch still has that issue we should backport the proper 
fixes and not work around them like this.

Thanks for looking into it,
Christian.

Am 11.01.2017 um 09:30 schrieb Liu, Monk:
>
> Hi Christian
>
>
> latest updates on the fence grab/release
>
>
> I recall the impression of why I added those grab/release pare:
>
>
> I checked the history, the first time I added those pare is because 
> they are first introduced/implemented in amd-sriov-4.3, and that 
> branch's fence implement has big gap between current (4.3 fence 
> doesn't use RCU and kmem_cache)
>
>
> in amd-sriov-4.3 branch, without this grab/release around I found 
> there will be kernel page fault triggered if fence quickly signaled 
> before fence_wait(), because amdgpu_fence_process will put the fence 
> and lead to fence released prior to later's fence_wait().
>
>
> but for staging-4.7 code, I didn't found such page fault after remove 
> those grab/release, and I noticed that the reason maybe we increases 
> the kref of fence to 2 in amdgpu_fence_emit ( in 4.3 kernel we only 
> increase it to 1):
>
>
> Increasing to 1 is by fence_init, and to 2 is by 
> rcu_assign_pointer(*ptr,fence_get(&fence->base))
>
>
> and with this reason the fence is 1 after it signaled. Agree  with you 
> that we should remove those grab/release and only leave one 
> fence_put() in kiq reg access routines.
>
>
> I didn't check the code on detail previously, thanks !
>
>
> BR Monk
>
>
> ------------------------------------------------------------------------
> *发件人:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> 代表 Liu, Monk 
> <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> *发送时间:* 2017年1月11日 11:06:34
> *收件人:* Christian König; Yu, Xiangliang; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* 答复: [V2 04/11] drm/amdgpu/virt: use kiq to access registers
> > +     fence_get(f);
> > +     amdgpu_ring_commit(ring);
> > +     mutex_unlock(&adev->virt.lock);
> > +
> > +     r = fence_wait(f, false);
> > +     fence_put(f);
>
> Why do you grab and release an extra fence reference here?
>
> Christian.
>
> [ML] e.g.  without those grab/release pare, if fence is signaled right 
> after ring_commit(), then
> "amdgpu_fence_process" will be invoked by interrupt and it will call 
> fence_put() on this fence, so this
> Fence is never valid and all fence_wait on it in sequence will trigger 
> page fault ...
>
> BR Monk
>
>
>
> -----邮件原件-----
> 发件人: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] 代表 
> Christian König
> 发送时间: Tuesday, January 10, 2017 9:09 PM
> 收件人: Yu, Xiangliang; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> 主题: Re: [V2 04/11] drm/amdgpu/virt: use kiq to access registers
>
> Am 10.01.2017 um 11:00 schrieb Xiangliang Yu:
> > For virtualization, it is must for driver to use KIQ to access
> > registers when it is out of GPU full access mode.
> >
> > Signed-off-by: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 86 
> ++++++++++++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  5 ++
> >   drivers/gpu/drm/amd/amdgpu/vi.c            |  3 ++
> >   5 files changed, 101 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> > b/drivers/gpu/drm/amd/amdgpu/Makefile
> > index 4185b03..0b8e470 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -30,7 +30,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
> >        atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
> >        amdgpu_prime.o amdgpu_vm.o amdgpu_ib.o amdgpu_pll.o \
> >        amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
> > -     amdgpu_gtt_mgr.o amdgpu_vram_mgr.o
> > +     amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o
> >
> >   # add asic specific block
> >   amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index f82919d..9a2fd3e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -95,6 +95,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device 
> *adev, uint32_t reg,
> >   {
> >        uint32_t ret;
> >
> > +     if (amdgpu_sriov_runtime(adev) && !in_interrupt())
> > +             return amdgpu_virt_kiq_rreg(adev, reg);
> > +
> >        if ((reg * 4) < adev->rmmio_size && !always_indirect)
> >                ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> >        else {
> > @@ -114,6 +117,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, 
> uint32_t reg, uint32_t v,
> >   {
> >        trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
> >
> > +     if (amdgpu_sriov_runtime(adev))
> > +             return amdgpu_virt_kiq_wreg(adev, reg, v);
> > +
> >        if ((reg * 4) < adev->rmmio_size && !always_indirect)
> >                writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> >        else {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > new file mode 100644
> > index 0000000..6520a4e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -0,0 +1,86 @@
> > +/*
> > + * Copyright 2017 Advanced Micro Devices, Inc.
> > + *
> > + * Permission is hereby granted, free of charge, to any person
> > +obtaining a
> > + * copy of this software and associated documentation files (the
> > +"Software"),
> > + * to deal in the Software without restriction, including without
> > +limitation
> > + * the rights to use, copy, modify, merge, publish, distribute,
> > +sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom
> > +the
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be
> > +included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > +EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > +MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> > +SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> > +DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> > +OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > +OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +#include "amdgpu.h"
> > +#include "amdgpu_virt.h"
> > +
> > +void amdgpu_virt_init_setting(struct amdgpu_device *adev) {
> > +     mutex_init(&adev->virt.lock);
> > +}
> > +
> > +uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t
> > +reg) {
> > +     signed long r;
> > +     uint32_t val;
> > +     struct fence *f;
> > +     struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> > +     struct amdgpu_ring *ring = &kiq->ring;
> > +
> > +     BUG_ON(!ring->funcs->emit_rreg);
> > +
> > +     mutex_lock(&adev->virt.lock);
> > +     amdgpu_ring_alloc(ring, 32);
> > +     amdgpu_ring_emit_hdp_flush(ring);
> > +     amdgpu_ring_emit_rreg(ring, reg);
> > +     amdgpu_ring_emit_hdp_invalidate(ring);
> > +     amdgpu_fence_emit(ring, &f);
> > +     fence_get(f);
> > +     amdgpu_ring_commit(ring);
> > +     mutex_unlock(&adev->virt.lock);
> > +
> > +     r = fence_wait(f, false);
> > +     fence_put(f);
>
> Why do you grab and release an extra fence reference here?
>
> Christian.
>
> > +     if (r)
> > +             DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> > +     fence_put(f);
> > +
> > +     val = adev->wb.wb[adev->virt.val_offs];
> > +
> > +     return val;
> > +}
> > +
> > +void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
> > +uint32_t v) {
> > +     signed long r;
> > +     struct fence *f;
> > +     struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> > +     struct amdgpu_ring *ring = &kiq->ring;
> > +
> > +     BUG_ON(!ring->funcs->emit_wreg);
> > +
> > +     mutex_lock(&adev->virt.lock);
> > +     amdgpu_ring_alloc(ring, 32);
> > +     amdgpu_ring_emit_hdp_flush(ring);
> > +     amdgpu_ring_emit_wreg(ring, reg, v);
> > +     amdgpu_ring_emit_hdp_invalidate(ring);
> > +     amdgpu_fence_emit(ring, &f);
> > +     fence_get(f);
> > +     amdgpu_ring_commit(ring);
> > +     mutex_unlock(&adev->virt.lock);
> > +
> > +     r = fence_wait(f, false);
> > +     fence_put(f);
> > +     if (r)
> > +             DRM_ERROR("wait for kiq fence error: %ld.\n", r);
> > +     fence_put(f);
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > index 79619b6..24f0590 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> > @@ -33,6 +33,7 @@
> >   struct amdgpu_virt {
> >        uint32_t                caps;
> >        uint32_t                val_offs;
> > +     struct mutex            lock;
> >   };
> >
> >   #define amdgpu_sriov_enabled(adev) \ @@ -59,4 +60,8 @@ static inline
> > bool is_virtual_machine(void)
> >   #endif
> >   }
> >
> > +void amdgpu_virt_init_setting(struct amdgpu_device *adev); uint32_t
> > +amdgpu_virt_kiq_rreg(struct amdgpu_device *adev, uint32_t reg); void
> > +amdgpu_virt_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
> > +uint32_t v);
> > +
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> > b/drivers/gpu/drm/amd/amdgpu/vi.c index 7350a8f..dc0d4fa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -892,6 +892,9 @@ static int vi_common_early_init(void *handle)
> >                (amdgpu_ip_block_mask & (1 << AMD_IP_BLOCK_TYPE_SMC)))
> >                smc_enabled = true;
> >
> > +     if (amdgpu_sriov_vf(adev))
> > +             amdgpu_virt_init_setting(adev);
> > +
> >        adev->rev_id = vi_get_rev_id(adev);
> >        adev->external_rev_id = 0xFF;
> >        switch (adev->asic_type) {
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
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



--------------7EC5290A333DF7D71F753FB5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Ah, that issue again. Yeah that was
      fixed in the meantime. Please remove the extra
      fance_get()/fence_put() for upstreaming.<br>
      <br>
      If an old branch still has that issue we should backport the
      proper fixes and not work around them like this.<br>
      <br>
      Thanks for looking into it,<br>
      Christian.<br>
      <br>
      Am 11.01.2017 um 09:30 schrieb Liu, Monk:<br>
    </div>
    <blockquote
cite="mid:BY2PR1201MB11107ADADF57EBE79AB97D7F84660-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
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
          <p>Hi Christian</p>
          <p><br>
          </p>
          <p>latest updates on the fence grab/release</p>
          <p><br>
          </p>
          <p>I recall the impression of why I added those grab/release
            pare:</p>
          <p><br>
          </p>
          <p>I checked the history, the first time I added those pare is
            because they are first introduced/implemented in
            amd-sriov-4.3, and that branch's fence implement has big gap
            between current (4.3 fence doesn't use RCU and kmem_cache)</p>
          <p><br>
          </p>
          <p>in amd-sriov-4.3 branch, without this grab/release around I
            found there will be kernel page fault triggered if fence
            quickly signaled before fence_wait(), because
            amdgpu_fence_process will put the fence and lead to fence
            released prior to later's fence_wait().</p>
          <p><br>
          </p>
          <p>but for staging-4.7 code, I didn't found such page fault
            after remove those grab/release, and I noticed that the
            reason maybe we increases the kref of fence to 2 in
            amdgpu_fence_emit ( in 4.3 kernel we only increase it to 1):</p>
          <p><br>
          </p>
          <p>Increasing to 1 is by fence_init, and to 2 is by <span>rcu_assign_pointer(*ptr,fence_get(&amp;fence-&gt;base)</span>)</p>
          <p><br>
            and with this reason the fence is 1 after it signaled.
            Agree  with you that we should remove those grab/release and
            only leave one fence_put() in kiq reg access routines.</p>
          <p><br>
          </p>
          <p>I didn't check the code on detail previously, thanks !</p>
          <p><br>
          </p>
          <p>BR Monk<br>
          </p>
          <p><br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>发件人:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> 代表
            Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <b>发送时间:</b> 2017年1月11日 11:06:34<br>
            <b>收件人:</b> Christian König; Yu, Xiangliang;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>主题:</b> 答复: [V2 04/11] drm/amdgpu/virt: use kiq to access
            registers</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">&gt; +     fence_get(f);<br>
            &gt; +     amdgpu_ring_commit(ring);<br>
            &gt; +     mutex_unlock(&amp;adev-&gt;virt.lock);<br>
            &gt; +<br>
            &gt; +     r = fence_wait(f, false);<br>
            &gt; +     fence_put(f);<br>
            <br>
            Why do you grab and release an extra fence reference here?<br>
            <br>
            Christian.<br>
            <br>
            [ML] e.g.  without those grab/release pare, if fence is
            signaled right after ring_commit(), then<br>
            "amdgpu_fence_process" will be invoked by interrupt and it
            will call fence_put() on this fence, so this
            <br>
            Fence is never valid and all fence_wait on it in sequence
            will trigger page fault ...<br>
            <br>
            BR Monk<br>
            <br>
            <br>
            <br>
            -----邮件原件-----<br>
            发件人: amd-gfx [<a moz-do-not-send="true"
              href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
            代表 Christian König<br>
            发送时间: Tuesday, January 10, 2017 9:09 PM<br>
            收件人: Yu, Xiangliang; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            主题: Re: [V2 04/11] drm/amdgpu/virt: use kiq to access
            registers<br>
            <br>
            Am 10.01.2017 um 11:00 schrieb Xiangliang Yu:<br>
            &gt; For virtualization, it is must for driver to use KIQ to
            access <br>
            &gt; registers when it is out of GPU full access mode.<br>
            &gt;<br>
            &gt; Signed-off-by: Xiangliang Yu
            <a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; ---<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +-<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 86
            ++++++++++++++++++++++++++++++<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  5 ++<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/vi.c            |  3 ++<br>
            &gt;   5 files changed, 101 insertions(+), 1 deletion(-)<br>
            &gt;   create mode 100644
            drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
            &gt; index 4185b03..0b8e470 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
            &gt; @@ -30,7 +30,7 @@ amdgpu-y += amdgpu_device.o
            amdgpu_kms.o \<br>
            &gt;        atombios_encoders.o amdgpu_sa.o atombios_i2c.o \<br>
            &gt;        amdgpu_prime.o amdgpu_vm.o amdgpu_ib.o
            amdgpu_pll.o \<br>
            &gt;        amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o
            amdgpu_sync.o \<br>
            &gt; -     amdgpu_gtt_mgr.o amdgpu_vram_mgr.o<br>
            &gt; +     amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o<br>
            &gt;   <br>
            &gt;   # add asic specific block<br>
            &gt;   amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o
            kv_smc.o kv_dpm.o \ <br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; index f82919d..9a2fd3e 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; @@ -95,6 +95,9 @@ uint32_t amdgpu_mm_rreg(struct
            amdgpu_device *adev, uint32_t reg,<br>
            &gt;   {<br>
            &gt;        uint32_t ret;<br>
            &gt;   <br>
            &gt; +     if (amdgpu_sriov_runtime(adev) &amp;&amp;
            !in_interrupt())<br>
            &gt; +             return amdgpu_virt_kiq_rreg(adev, reg);<br>
            &gt; +<br>
            &gt;        if ((reg * 4) &lt; adev-&gt;rmmio_size
            &amp;&amp; !always_indirect)<br>
            &gt;                ret = readl(((void __iomem
            *)adev-&gt;rmmio) + (reg * 4));<br>
            &gt;        else {<br>
            &gt; @@ -114,6 +117,9 @@ void amdgpu_mm_wreg(struct
            amdgpu_device *adev, uint32_t reg, uint32_t v,<br>
            &gt;   {<br>
            &gt;        trace_amdgpu_mm_wreg(adev-&gt;pdev-&gt;device,
            reg, v);<br>
            &gt;   <br>
            &gt; +     if (amdgpu_sriov_runtime(adev))<br>
            &gt; +             return amdgpu_virt_kiq_wreg(adev, reg,
            v);<br>
            &gt; +<br>
            &gt;        if ((reg * 4) &lt; adev-&gt;rmmio_size
            &amp;&amp; !always_indirect)<br>
            &gt;                writel(v, ((void __iomem
            *)adev-&gt;rmmio) + (reg * 4));<br>
            &gt;        else {<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
            &gt; new file mode 100644<br>
            &gt; index 0000000..6520a4e<br>
            &gt; --- /dev/null<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
            &gt; @@ -0,0 +1,86 @@<br>
            &gt; +/*<br>
            &gt; + * Copyright 2017 Advanced Micro Devices, Inc.<br>
            &gt; + *<br>
            &gt; + * Permission is hereby granted, free of charge, to
            any person <br>
            &gt; +obtaining a<br>
            &gt; + * copy of this software and associated documentation
            files (the <br>
            &gt; +"Software"),<br>
            &gt; + * to deal in the Software without restriction,
            including without <br>
            &gt; +limitation<br>
            &gt; + * the rights to use, copy, modify, merge, publish,
            distribute, <br>
            &gt; +sublicense,<br>
            &gt; + * and/or sell copies of the Software, and to permit
            persons to whom <br>
            &gt; +the<br>
            &gt; + * Software is furnished to do so, subject to the
            following conditions:<br>
            &gt; + *<br>
            &gt; + * The above copyright notice and this permission
            notice shall be <br>
            &gt; +included in<br>
            &gt; + * all copies or substantial portions of the Software.<br>
            &gt; + *<br>
            &gt; + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY
            OF ANY KIND, <br>
            &gt; +EXPRESS OR<br>
            &gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE
            WARRANTIES OF <br>
            &gt; +MERCHANTABILITY,<br>
            &gt; + * FITNESS FOR A PARTICULAR PURPOSE AND
            NONINFRINGEMENT.  IN NO EVENT <br>
            &gt; +SHALL<br>
            &gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR
            ANY CLAIM, <br>
            &gt; +DAMAGES OR<br>
            &gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
            TORT OR <br>
            &gt; +OTHERWISE,<br>
            &gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE
            SOFTWARE OR THE USE <br>
            &gt; +OR<br>
            &gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
            &gt; + */<br>
            &gt; +<br>
            &gt; +#include "amdgpu.h"<br>
            &gt; +#include "amdgpu_virt.h"<br>
            &gt; +<br>
            &gt; +void amdgpu_virt_init_setting(struct amdgpu_device
            *adev) {<br>
            &gt; +     mutex_init(&amp;adev-&gt;virt.lock);<br>
            &gt; +}<br>
            &gt; +<br>
            &gt; +uint32_t amdgpu_virt_kiq_rreg(struct amdgpu_device
            *adev, uint32_t <br>
            &gt; +reg) {<br>
            &gt; +     signed long r;<br>
            &gt; +     uint32_t val;<br>
            &gt; +     struct fence *f;<br>
            &gt; +     struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;<br>
            &gt; +     struct amdgpu_ring *ring = &amp;kiq-&gt;ring;<br>
            &gt; +<br>
            &gt; +     BUG_ON(!ring-&gt;funcs-&gt;emit_rreg);<br>
            &gt; +<br>
            &gt; +     mutex_lock(&amp;adev-&gt;virt.lock);<br>
            &gt; +     amdgpu_ring_alloc(ring, 32);<br>
            &gt; +     amdgpu_ring_emit_hdp_flush(ring);<br>
            &gt; +     amdgpu_ring_emit_rreg(ring, reg);<br>
            &gt; +     amdgpu_ring_emit_hdp_invalidate(ring);<br>
            &gt; +     amdgpu_fence_emit(ring, &amp;f);<br>
            &gt; +     fence_get(f);<br>
            &gt; +     amdgpu_ring_commit(ring);<br>
            &gt; +     mutex_unlock(&amp;adev-&gt;virt.lock);<br>
            &gt; +<br>
            &gt; +     r = fence_wait(f, false);<br>
            &gt; +     fence_put(f);<br>
            <br>
            Why do you grab and release an extra fence reference here?<br>
            <br>
            Christian.<br>
            <br>
            &gt; +     if (r)<br>
            &gt; +             DRM_ERROR("wait for kiq fence error:
            %ld.\n", r);<br>
            &gt; +     fence_put(f);<br>
            &gt; +<br>
            &gt; +     val = adev-&gt;wb.wb[adev-&gt;virt.val_offs];<br>
            &gt; +<br>
            &gt; +     return val;<br>
            &gt; +}<br>
            &gt; +<br>
            &gt; +void amdgpu_virt_kiq_wreg(struct amdgpu_device *adev,
            uint32_t reg, <br>
            &gt; +uint32_t v) {<br>
            &gt; +     signed long r;<br>
            &gt; +     struct fence *f;<br>
            &gt; +     struct amdgpu_kiq *kiq = &amp;adev-&gt;gfx.kiq;<br>
            &gt; +     struct amdgpu_ring *ring = &amp;kiq-&gt;ring;<br>
            &gt; +<br>
            &gt; +     BUG_ON(!ring-&gt;funcs-&gt;emit_wreg);<br>
            &gt; +<br>
            &gt; +     mutex_lock(&amp;adev-&gt;virt.lock);<br>
            &gt; +     amdgpu_ring_alloc(ring, 32);<br>
            &gt; +     amdgpu_ring_emit_hdp_flush(ring);<br>
            &gt; +     amdgpu_ring_emit_wreg(ring, reg, v);<br>
            &gt; +     amdgpu_ring_emit_hdp_invalidate(ring);<br>
            &gt; +     amdgpu_fence_emit(ring, &amp;f);<br>
            &gt; +     fence_get(f);<br>
            &gt; +     amdgpu_ring_commit(ring);<br>
            &gt; +     mutex_unlock(&amp;adev-&gt;virt.lock);<br>
            &gt; +<br>
            &gt; +     r = fence_wait(f, false);<br>
            &gt; +     fence_put(f);<br>
            &gt; +     if (r)<br>
            &gt; +             DRM_ERROR("wait for kiq fence error:
            %ld.\n", r);<br>
            &gt; +     fence_put(f);<br>
            &gt; +}<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
            &gt; index 79619b6..24f0590 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h<br>
            &gt; @@ -33,6 +33,7 @@<br>
            &gt;   struct amdgpu_virt {<br>
            &gt;        uint32_t                caps;<br>
            &gt;        uint32_t                val_offs;<br>
            &gt; +     struct mutex            lock;<br>
            &gt;   };<br>
            &gt;   <br>
            &gt;   #define amdgpu_sriov_enabled(adev) \ @@ -59,4 +60,8
            @@ static inline <br>
            &gt; bool is_virtual_machine(void)<br>
            &gt;   #endif<br>
            &gt;   }<br>
            &gt;   <br>
            &gt; +void amdgpu_virt_init_setting(struct amdgpu_device
            *adev); uint32_t <br>
            &gt; +amdgpu_virt_kiq_rreg(struct amdgpu_device *adev,
            uint32_t reg); void <br>
            &gt; +amdgpu_virt_kiq_wreg(struct amdgpu_device *adev,
            uint32_t reg, <br>
            &gt; +uint32_t v);<br>
            &gt; +<br>
            &gt;   #endif<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/vi.c index
            7350a8f..dc0d4fa 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
            &gt; @@ -892,6 +892,9 @@ static int
            vi_common_early_init(void *handle)<br>
            &gt;                (amdgpu_ip_block_mask &amp; (1 &lt;&lt;
            AMD_IP_BLOCK_TYPE_SMC)))<br>
            &gt;                smc_enabled = true;<br>
            &gt;   <br>
            &gt; +     if (amdgpu_sriov_vf(adev))<br>
            &gt; +             amdgpu_virt_init_setting(adev);<br>
            &gt; +<br>
            &gt;        adev-&gt;rev_id = vi_get_rev_id(adev);<br>
            &gt;        adev-&gt;external_rev_id = 0xFF;<br>
            &gt;        switch (adev-&gt;asic_type) {<br>
            <br>
            <br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a moz-do-not-send="true"
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a moz-do-not-send="true"
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
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

--------------7EC5290A333DF7D71F753FB5--

--===============0133177040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0133177040==--
