From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0hdIGRybS9hbWRncHU6Z3Vh?=
 =?UTF-8?Q?rantee_128dws_between_vm_flush_and_IB?=
Date: Thu, 19 Jan 2017 10:10:36 +0100
Message-ID: <3a5930fb-1d11-c224-ece7-4d57781db361@vodafone.de>
References: <1484718926-10539-1-git-send-email-Monk.Liu@amd.com>
 <5999cfbf-d089-a05f-734c-dabe388cd303@vodafone.de>
 <BY2PR1201MB1110C8A3D5B66799F3BCC1B1847F0@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <9e325cfb-ec04-0317-b871-2d54ad21b724@vodafone.de>
 <BY2PR1201MB11109CD4EC58A7C8F9C180CA847E0@BY2PR1201MB1110.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1409244298=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB11109CD4EC58A7C8F9C180CA847E0-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1409244298==
Content-Type: multipart/alternative;
 boundary="------------750AF50DE9186E023497AE48"

This is a multi-part message in MIME format.
--------------750AF50DE9186E023497AE48
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> so the conclusion is if we have vm-flush, we make sure 128dw between 
> vm flush and CE ib, if we don't insert vm flush we stil make sure 128 
> DW between SWITCH_BUFFER and CE ib.
>
Good point.

> if you reject this patch, please give me a solution to fix above VM fault
>
Well, we could follow the windows approach, e.g. increase padding to 
256dw and separate the VM flush in it's own submission.

But that's more a long term fix, for now I'm ok with that patch and just 
reviewed your v4 of it.

Regards,
Christian.

Am 19.01.2017 um 04:19 schrieb Liu, Monk:
>
> current code missed the 128 DW after SWITCH_BUFFER, even without vm 
> flush, we still need those 128 DW betwen previous frame's 
> SWITCH_BUFFER and current frame's CE ib,
>
> and this patch fixed this issue as well otherwise in SRIOV case 
> (Unigeen HEAVEN) CE will meet vm fault, and in  steam OS case (DOTA2) 
> will meet VM fault as well.
>
>
> so the conclusion is if we have vm-flush, we make sure 128dw between 
> vm flush and CE ib, if we don't insert vm flush we stil make sure 128 
> DW between SWITCH_BUFFER and CE ib.
>
>
> if you reject this patch, please give me a solution to fix above VM fault
>
>
> BR Monk
>
> ------------------------------------------------------------------------
> *发件人:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> 代表 Christian 
> König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *发送时间:* 2017年1月18日 20:52:14
> *收件人:* Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* Re: 答复: [PATCH] drm/amdgpu:guarantee 128dws between vm flush and 
> IB
> > suppose hw_submit_count in gpu_scheduler is 2 (by default), and
> > without suppress frame size under 256, we may sometime submit 256dw,
> > and sometime submit 512 dw, and that could lead to CPU override ring
> > buffer content which is under processing by GPU, e.g. :
> >
> The max_dw parameter for amdgpu_ring_init() is multiplied by
> amdgpu_sched_hw_submission. See amdgpu_ring_init():
>
>          ring->ring_size = roundup_pow_of_two(max_dw * 4 *
> amdgpu_sched_hw_submission);
>
> Since we use 1024 for max_dw for the GFX, Compute and SDMA rings using
> 512 dw is perfectly ok.
>
> Even if we ever try to submit more than 1024 including padding we will
> get a nice warning in the logs. See amdgpu_ring_alloc():
>
>          if (WARN_ON_ONCE(ndw > ring->max_dw))
>                  return -ENOMEM;
>
> > another reason is we keep each DMAframe to 256dw is for better
> > performance.
> >
> Well considering what else we have in those command buffers I would
> strongly say that this is negligible.
>
> So NAK on that patch as long as we don't have a good reason for it.
>
> Regards,
> Christian.
>
> Am 18.01.2017 um 11:11 schrieb Liu, Monk:
> >
> > >First question why do we want to limit the dw per submit to 256? Some
> > >limitation for SRIOV?
> >
> >
> > [ML]
> >
> > suppose hw_submit_count in gpu_scheduler is 2 (by default), and
> > without suppress frame size under 256, we may sometime submit 256dw,
> > and sometime submit 512 dw, and that could lead to CPU override ring
> > buffer content which is under processing by GPU, e.g. :
> >
> >
> > we assume ring buffer size = 512 dw (so ring buffer can hold 2 hw
> > submit) for easy understanding.
> >
> >
> > hw_count =2;
> >
> > submit job-1 (take 256 dw)
> >
> > hw_count = 1;
> >
> > submit job-2 (take 256 dw) //now ring buffer is full
> >
> > hw_count =0;
> >
> > gpu_scheduler waiting
> >
> > ...
> >
> > job-1 signaled, then hw_count => 1
> >
> > submit job3, and the job3 is filled in the head of RB (wrapped)
> >
> > but job3 take 512 dw (e.g. it takes 259 dw, but we aligned it to 512)
> >
> >
> > job-2 still under processing, but the package belongs to job-2 is
> > override by job3, disaster ...
> >
> >
> > another reason is we keep each DMAframe to 256dw is for better
> > performance.
> >
> >
> > BR Monk
> >
> > ------------------------------------------------------------------------
> > *发件人:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> > *发送时间:* 2017年1月18日 17:28:15
> > *收件人:* Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > *主题:* Re: [PATCH] drm/amdgpu:guarantee 128dws between vm flush and IB
> > Am 18.01.2017 um 06:55 schrieb Monk Liu:
> > > previously we always insert 128nops behind vm_flush, which
> > > may lead to DAMframe size above 256 dw and automatially aligned
> > > to 512 dw.
> > >
> > > now we calculate how many DWs already inserted after vm_flush
> > > and make up for the reset to pad up to 128dws before emit_ib.
> > >
> > > that way we only take 256 dw per submit.
> >
> > First question why do we want to limit the dw per submit to 256? Some
> > limitation for SRIOV?
> >
> > Then for the implementation, please don't add all that counting to the
> > different functions. Instead save the current position in the ring in
> > emit_vm_flush and then calculate in emit_cntxcntl() how many dw we still
> > need to add to have at least 128. E.g. call the variable something like
> > last_vm_flush_pos.
> >
> > That makes the code way more robust towards any changes.
> >
> > Regards,
> > Christian.
> >
> > >
> > > Change-Id: Iac198e16f35b071476ba7bd48ab338223f6fe650
> > > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 24 
> ++++++++++++++++++++++--
> > >   2 files changed, 23 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > index c813cbe..1dbe600 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > > @@ -173,6 +173,7 @@ struct amdgpu_ring {
> > >   #if defined(CONFIG_DEBUG_FS)
> > >        struct dentry *ent;
> > >   #endif
> > > +     u32 dws_between_vm_ib;
> > >   };
> > >
> > >   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > index 5f37313..76b1315 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > > @@ -5670,6 +5670,8 @@ static void
> > gfx_v8_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
> > >        amdgpu_ring_write(ring, amdgpu_gds_reg_offset[vmid].oa);
> > >        amdgpu_ring_write(ring, 0);
> > >        amdgpu_ring_write(ring, (1 << (oa_size + oa_base)) - (1 <<
> > oa_base));
> > > +
> > > +     ring->dws_between_vm_ib += 20;
> > >   }
> > >
> > >   static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t
> > simd, uint32_t wave, uint32_t address)
> > > @@ -6489,6 +6491,8 @@ static void
> > gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> > >        amdgpu_ring_write(ring, ref_and_mask);
> > >        amdgpu_ring_write(ring, ref_and_mask);
> > >        amdgpu_ring_write(ring, 0x20); /* poll interval */
> > > +
> > > +     ring->dws_between_vm_ib += 7;
> > >   }
> > >
> > >   static void gfx_v8_0_ring_emit_vgt_flush(struct amdgpu_ring *ring)
> > > @@ -6500,6 +6504,8 @@ static void
> > gfx_v8_0_ring_emit_vgt_flush(struct amdgpu_ring *ring)
> > >        amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> > >        amdgpu_ring_write(ring, EVENT_TYPE(VGT_FLUSH) |
> > >                EVENT_INDEX(0));
> > > +
> > > +     ring->dws_between_vm_ib += 4;
> > >   }
> > >
> > >
> > > @@ -6573,6 +6579,7 @@ static void
> > gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
> > >        amdgpu_ring_write(ring, lower_32_bits(seq));
> > >        amdgpu_ring_write(ring, upper_32_bits(seq));
> > >
> > > +     ring->dws_between_vm_ib += 6;
> > >   }
> > >
> > >   static void gfx_v8_0_ring_emit_pipeline_sync(struct amdgpu_ring 
> *ring)
> > > @@ -6639,6 +6646,8 @@ static void gfx_v8_0_ring_emit_vm_flush(struct
> > amdgpu_ring *ring,
> > >                /* GFX8 emits 128 dw nop to prevent CE access VM
> > before vm_flush finish */
> > >                amdgpu_ring_insert_nop(ring, 128);
> > >        }
> > > +
> > > +     ring->dws_between_vm_ib = 0; /* clear before recalculate */
> > >   }
> > >
> > >   static u32 gfx_v8_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> > > @@ -6711,9 +6720,11 @@ static void gfx_v8_ring_emit_cntxcntl(struct
> > amdgpu_ring *ring, uint32_t flags)
> > >   {
> > >        uint32_t dw2 = 0;
> > >
> > > -     if (amdgpu_sriov_vf(ring->adev))
> > > +     if (amdgpu_sriov_vf(ring->adev)) {
> > > gfx_v8_0_ring_emit_ce_meta_init(ring,
> > >                        (flags & AMDGPU_VM_DOMAIN) ? AMDGPU_CSA_VADDR
> > : ring->adev->virt.csa_vmid0_addr);
> > > +             ring->dws_between_vm_ib += 8;
> > > +     }
> > >
> > >        dw2 |= 0x80000000; /* set load_enable otherwise this package
> > is just NOPs */
> > >        if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> > > @@ -6739,10 +6750,19 @@ static void gfx_v8_ring_emit_cntxcntl(struct
> > amdgpu_ring *ring, uint32_t flags)
> > >        amdgpu_ring_write(ring, PACKET3(PACKET3_CONTEXT_CONTROL, 1));
> > >        amdgpu_ring_write(ring, dw2);
> > >        amdgpu_ring_write(ring, 0);
> > > +     ring->dws_between_vm_ib += 3;
> > >
> > > -     if (amdgpu_sriov_vf(ring->adev))
> > > +     if (amdgpu_sriov_vf(ring->adev)) {
> > > gfx_v8_0_ring_emit_de_meta_init(ring,
> > >                        (flags & AMDGPU_VM_DOMAIN) ? AMDGPU_CSA_VADDR
> > : ring->adev->virt.csa_vmid0_addr);
> > > +             ring->dws_between_vm_ib += 21;
> > > +     }
> > > +
> > > +     /* emit_de_meta_init should be the last package right before
> > emi_ib,
> > > +      * and we need to pad some NOPs before emit_ib to prevent CE
> > run ahead of
> > > +      * vm_flush, which may trigger VM fault.
> > > +      */
> > > +     amdgpu_ring_insert_nop(ring, 128 - ring->dws_between_vm_ib);
> > >   }
> > >
> > >   static void gfx_v8_0_ring_emit_rreg(struct amdgpu_ring *ring,
> > uint32_t reg)
> >
> >
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



--------------750AF50DE9186E023497AE48
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <p>so the conclusion is if we have vm-flush, we make sure 128dw
          between vm flush and CE ib, if we don't insert vm flush we
          stil make sure 128 DW between SWITCH_BUFFER and CE ib.</p>
      </blockquote>
      Good point.<br>
      <br>
      <blockquote type="cite">
        <p>if you reject this patch, please give me a solution to fix
          above VM fault <br>
        </p>
      </blockquote>
      Well, we could follow the windows approach, e.g. increase padding
      to 256dw and separate the VM flush in it's own submission.<br>
      <br>
      But that's more a long term fix, for now I'm ok with that patch
      and just reviewed your v4 of it.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 19.01.2017 um 04:19 schrieb Liu, Monk:<br>
    </div>
    <blockquote
cite="mid:BY2PR1201MB11109CD4EC58A7C8F9C180CA847E0-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
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
          <p>current code missed the 128 DW after SWITCH_BUFFER, even
            without vm flush, we still need those 128 DW betwen previous
            frame's SWITCH_BUFFER and current frame's CE ib,
          </p>
          <p>and this patch fixed this issue as well otherwise in SRIOV
            case (Unigeen HEAVEN) CE will meet vm fault, and in  steam
            OS case (DOTA2) will meet VM fault as well.</p>
          <p><br>
          </p>
          <p>so the conclusion is if we have vm-flush, we make sure
            128dw between vm flush and CE ib, if we don't insert vm
            flush we stil make sure 128 DW between SWITCH_BUFFER and CE
            ib.</p>
          <p><br>
          </p>
          <p>if you reject this patch, please give me a solution to fix
            above VM fault <br>
          </p>
          <p><br>
          </p>
          <p>BR Monk<br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>发件人:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> 代表
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            <b>发送时间:</b> 2017年1月18日 20:52:14<br>
            <b>收件人:</b> Liu, Monk; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>主题:</b> Re: 答复: [PATCH] drm/amdgpu:guarantee 128dws
            between vm flush and IB</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">&gt; suppose hw_submit_count in
            gpu_scheduler is 2 (by default), and
            <br>
            &gt; without suppress frame size under 256, we may sometime
            submit 256dw, <br>
            &gt; and sometime submit 512 dw, and that could lead to CPU
            override ring <br>
            &gt; buffer content which is under processing by GPU, e.g. :<br>
            &gt;<br>
            The max_dw parameter for amdgpu_ring_init() is multiplied by
            <br>
            amdgpu_sched_hw_submission. See amdgpu_ring_init():<br>
            <br>
                     ring-&gt;ring_size = roundup_pow_of_two(max_dw * 4
            *<br>
            amdgpu_sched_hw_submission);<br>
            <br>
            Since we use 1024 for max_dw for the GFX, Compute and SDMA
            rings using <br>
            512 dw is perfectly ok.<br>
            <br>
            Even if we ever try to submit more than 1024 including
            padding we will <br>
            get a nice warning in the logs. See amdgpu_ring_alloc():<br>
            <br>
                     if (WARN_ON_ONCE(ndw &gt; ring-&gt;max_dw))<br>
                             return -ENOMEM;<br>
            <br>
            &gt; another reason is we keep each DMAframe to 256dw is for
            better <br>
            &gt; performance.<br>
            &gt;<br>
            Well considering what else we have in those command buffers
            I would <br>
            strongly say that this is negligible.<br>
            <br>
            So NAK on that patch as long as we don't have a good reason
            for it.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            Am 18.01.2017 um 11:11 schrieb Liu, Monk:<br>
            &gt;<br>
            &gt; &gt;First question why do we want to limit the dw per
            submit to 256? Some<br>
            &gt; &gt;limitation for SRIOV?<br>
            &gt;<br>
            &gt;<br>
            &gt; [ML]<br>
            &gt;<br>
            &gt; suppose hw_submit_count in gpu_scheduler is 2 (by
            default), and <br>
            &gt; without suppress frame size under 256, we may sometime
            submit 256dw, <br>
            &gt; and sometime submit 512 dw, and that could lead to CPU
            override ring <br>
            &gt; buffer content which is under processing by GPU, e.g. :<br>
            &gt;<br>
            &gt;<br>
            &gt; we assume ring buffer size = 512 dw (so ring buffer can
            hold 2 hw <br>
            &gt; submit) for easy understanding.<br>
            &gt;<br>
            &gt;<br>
            &gt; hw_count =2;<br>
            &gt;<br>
            &gt; submit job-1 (take 256 dw)<br>
            &gt;<br>
            &gt; hw_count = 1;<br>
            &gt;<br>
            &gt; submit job-2 (take 256 dw) //now ring buffer is full<br>
            &gt;<br>
            &gt; hw_count =0;<br>
            &gt;<br>
            &gt; gpu_scheduler waiting<br>
            &gt;<br>
            &gt; ...<br>
            &gt;<br>
            &gt; job-1 signaled, then hw_count =&gt; 1<br>
            &gt;<br>
            &gt; submit job3, and the job3 is filled in the head of RB
            (wrapped)<br>
            &gt;<br>
            &gt; but job3 take 512 dw (e.g. it takes 259 dw, but we
            aligned it to 512)<br>
            &gt;<br>
            &gt;<br>
            &gt; job-2 still under processing, but the package belongs
            to job-2 is <br>
            &gt; override by job3, disaster ...<br>
            &gt;<br>
            &gt;<br>
            &gt; another reason is we keep each DMAframe to 256dw is for
            better <br>
            &gt; performance.<br>
            &gt;<br>
            &gt;<br>
            &gt; BR Monk<br>
            &gt;<br>
            &gt;
            ------------------------------------------------------------------------<br>
            &gt; *发件人:* Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            &gt; *发送时间:* 2017年1月18日 17:28:15<br>
            &gt; *收件人:* Liu, Monk; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; *主题:* Re: [PATCH] drm/amdgpu:guarantee 128dws between
            vm flush and IB<br>
            &gt; Am 18.01.2017 um 06:55 schrieb Monk Liu:<br>
            &gt; &gt; previously we always insert 128nops behind
            vm_flush, which<br>
            &gt; &gt; may lead to DAMframe size above 256 dw and
            automatially aligned<br>
            &gt; &gt; to 512 dw.<br>
            &gt; &gt;<br>
            &gt; &gt; now we calculate how many DWs already inserted
            after vm_flush<br>
            &gt; &gt; and make up for the reset to pad up to 128dws
            before emit_ib.<br>
            &gt; &gt;<br>
            &gt; &gt; that way we only take 256 dw per submit.<br>
            &gt;<br>
            &gt; First question why do we want to limit the dw per
            submit to 256? Some<br>
            &gt; limitation for SRIOV?<br>
            &gt;<br>
            &gt; Then for the implementation, please don't add all that
            counting to the<br>
            &gt; different functions. Instead save the current position
            in the ring in<br>
            &gt; emit_vm_flush and then calculate in emit_cntxcntl() how
            many dw we still<br>
            &gt; need to add to have at least 128. E.g. call the
            variable something like<br>
            &gt; last_vm_flush_pos.<br>
            &gt;<br>
            &gt; That makes the code way more robust towards any
            changes.<br>
            &gt;<br>
            &gt; Regards,<br>
            &gt; Christian.<br>
            &gt;<br>
            &gt; &gt;<br>
            &gt; &gt; Change-Id:
            Iac198e16f35b071476ba7bd48ab338223f6fe650<br>
            &gt; &gt; Signed-off-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; &gt; ---<br>
            &gt; &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +<br>
            &gt; &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 24
            ++++++++++++++++++++++--<br>
            &gt; &gt;   2 files changed, 23 insertions(+), 2
            deletions(-)<br>
            &gt; &gt;<br>
            &gt; &gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
            &gt; &gt; index c813cbe..1dbe600 100644<br>
            &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
            &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
            &gt; &gt; @@ -173,6 +173,7 @@ struct amdgpu_ring {<br>
            &gt; &gt;   #if defined(CONFIG_DEBUG_FS)<br>
            &gt; &gt;        struct dentry *ent;<br>
            &gt; &gt;   #endif<br>
            &gt; &gt; +     u32 dws_between_vm_ib;<br>
            &gt; &gt;   };<br>
            &gt; &gt;<br>
            &gt; &gt;   int amdgpu_ring_alloc(struct amdgpu_ring *ring,
            unsigned ndw);<br>
            &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
            <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; &gt; index 5f37313..76b1315 100644<br>
            &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; &gt; @@ -5670,6 +5670,8 @@ static void <br>
            &gt; gfx_v8_0_ring_emit_gds_switch(struct amdgpu_ring *ring,<br>
            &gt; &gt;        amdgpu_ring_write(ring,
            amdgpu_gds_reg_offset[vmid].oa);<br>
            &gt; &gt;        amdgpu_ring_write(ring, 0);<br>
            &gt; &gt;        amdgpu_ring_write(ring, (1 &lt;&lt;
            (oa_size + oa_base)) - (1 &lt;&lt; <br>
            &gt; oa_base));<br>
            &gt; &gt; +<br>
            &gt; &gt; +     ring-&gt;dws_between_vm_ib += 20;<br>
            &gt; &gt;   }<br>
            &gt; &gt;<br>
            &gt; &gt;   static uint32_t wave_read_ind(struct
            amdgpu_device *adev, uint32_t <br>
            &gt; simd, uint32_t wave, uint32_t address)<br>
            &gt; &gt; @@ -6489,6 +6491,8 @@ static void <br>
            &gt; gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)<br>
            &gt; &gt;        amdgpu_ring_write(ring, ref_and_mask);<br>
            &gt; &gt;        amdgpu_ring_write(ring, ref_and_mask);<br>
            &gt; &gt;        amdgpu_ring_write(ring, 0x20); /* poll
            interval */<br>
            &gt; &gt; +<br>
            &gt; &gt; +     ring-&gt;dws_between_vm_ib += 7;<br>
            &gt; &gt;   }<br>
            &gt; &gt;<br>
            &gt; &gt;   static void gfx_v8_0_ring_emit_vgt_flush(struct
            amdgpu_ring *ring)<br>
            &gt; &gt; @@ -6500,6 +6504,8 @@ static void <br>
            &gt; gfx_v8_0_ring_emit_vgt_flush(struct amdgpu_ring *ring)<br>
            &gt; &gt;        amdgpu_ring_write(ring,
            PACKET3(PACKET3_EVENT_WRITE, 0));<br>
            &gt; &gt;        amdgpu_ring_write(ring,
            EVENT_TYPE(VGT_FLUSH) |<br>
            &gt; &gt;                EVENT_INDEX(0));<br>
            &gt; &gt; +<br>
            &gt; &gt; +     ring-&gt;dws_between_vm_ib += 4;<br>
            &gt; &gt;   }<br>
            &gt; &gt;<br>
            &gt; &gt;<br>
            &gt; &gt; @@ -6573,6 +6579,7 @@ static void <br>
            &gt; gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring,
            u64 addr,<br>
            &gt; &gt;        amdgpu_ring_write(ring,
            lower_32_bits(seq));<br>
            &gt; &gt;        amdgpu_ring_write(ring,
            upper_32_bits(seq));<br>
            &gt; &gt;<br>
            &gt; &gt; +     ring-&gt;dws_between_vm_ib += 6;<br>
            &gt; &gt;   }<br>
            &gt; &gt;<br>
            &gt; &gt;   static void
            gfx_v8_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)<br>
            &gt; &gt; @@ -6639,6 +6646,8 @@ static void
            gfx_v8_0_ring_emit_vm_flush(struct <br>
            &gt; amdgpu_ring *ring,<br>
            &gt; &gt;                /* GFX8 emits 128 dw nop to prevent
            CE access VM <br>
            &gt; before vm_flush finish */<br>
            &gt; &gt;                amdgpu_ring_insert_nop(ring, 128);<br>
            &gt; &gt;        }<br>
            &gt; &gt; +<br>
            &gt; &gt; +     ring-&gt;dws_between_vm_ib = 0; /* clear
            before recalculate */<br>
            &gt; &gt;   }<br>
            &gt; &gt;<br>
            &gt; &gt;   static u32 gfx_v8_0_ring_get_wptr_compute(struct
            amdgpu_ring *ring)<br>
            &gt; &gt; @@ -6711,9 +6720,11 @@ static void
            gfx_v8_ring_emit_cntxcntl(struct <br>
            &gt; amdgpu_ring *ring, uint32_t flags)<br>
            &gt; &gt;   {<br>
            &gt; &gt;        uint32_t dw2 = 0;<br>
            &gt; &gt;<br>
            &gt; &gt; -     if (amdgpu_sriov_vf(ring-&gt;adev))<br>
            &gt; &gt; +     if (amdgpu_sriov_vf(ring-&gt;adev)) {<br>
            &gt; &gt;               
            gfx_v8_0_ring_emit_ce_meta_init(ring,<br>
            &gt; &gt;                        (flags &amp;
            AMDGPU_VM_DOMAIN) ? AMDGPU_CSA_VADDR <br>
            &gt; : ring-&gt;adev-&gt;virt.csa_vmid0_addr);<br>
            &gt; &gt; +             ring-&gt;dws_between_vm_ib += 8;<br>
            &gt; &gt; +     }<br>
            &gt; &gt;<br>
            &gt; &gt;        dw2 |= 0x80000000; /* set load_enable
            otherwise this package <br>
            &gt; is just NOPs */<br>
            &gt; &gt;        if (flags &amp; AMDGPU_HAVE_CTX_SWITCH) {<br>
            &gt; &gt; @@ -6739,10 +6750,19 @@ static void
            gfx_v8_ring_emit_cntxcntl(struct <br>
            &gt; amdgpu_ring *ring, uint32_t flags)<br>
            &gt; &gt;        amdgpu_ring_write(ring,
            PACKET3(PACKET3_CONTEXT_CONTROL, 1));<br>
            &gt; &gt;        amdgpu_ring_write(ring, dw2);<br>
            &gt; &gt;        amdgpu_ring_write(ring, 0);<br>
            &gt; &gt; +     ring-&gt;dws_between_vm_ib += 3;<br>
            &gt; &gt;<br>
            &gt; &gt; -     if (amdgpu_sriov_vf(ring-&gt;adev))<br>
            &gt; &gt; +     if (amdgpu_sriov_vf(ring-&gt;adev)) {<br>
            &gt; &gt;               
            gfx_v8_0_ring_emit_de_meta_init(ring,<br>
            &gt; &gt;                        (flags &amp;
            AMDGPU_VM_DOMAIN) ? AMDGPU_CSA_VADDR <br>
            &gt; : ring-&gt;adev-&gt;virt.csa_vmid0_addr);<br>
            &gt; &gt; +             ring-&gt;dws_between_vm_ib += 21;<br>
            &gt; &gt; +     }<br>
            &gt; &gt; +<br>
            &gt; &gt; +     /* emit_de_meta_init should be the last
            package right before <br>
            &gt; emi_ib,<br>
            &gt; &gt; +      * and we need to pad some NOPs before
            emit_ib to prevent CE <br>
            &gt; run ahead of<br>
            &gt; &gt; +      * vm_flush, which may trigger VM fault.<br>
            &gt; &gt; +      */<br>
            &gt; &gt; +     amdgpu_ring_insert_nop(ring, 128 -
            ring-&gt;dws_between_vm_ib);<br>
            &gt; &gt;   }<br>
            &gt; &gt;<br>
            &gt; &gt;   static void gfx_v8_0_ring_emit_rreg(struct
            amdgpu_ring *ring, <br>
            &gt; uint32_t reg)<br>
            &gt;<br>
            &gt;<br>
            <br>
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

--------------750AF50DE9186E023497AE48--

--===============1409244298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1409244298==--
