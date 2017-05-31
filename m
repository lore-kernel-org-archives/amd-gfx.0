From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Optimize a function called by every IB
 sheduling
Date: Wed, 31 May 2017 15:07:06 +0200
Message-ID: <c856088d-e779-4f5f-6252-d7f547124861@vodafone.de>
References: <1496180868-2617-1-git-send-email-AlexBin.Xie@amd.com>
 <966bbfa3-488d-2a12-7ebd-cf59812928d6@vodafone.de>
 <MWHPR1201MB0045FC6C00CA6008273C385BF2F10@MWHPR1201MB0045.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0597998220=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0045FC6C00CA6008273C385BF2F10-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0597998220==
Content-Type: multipart/alternative;
 boundary="------------C858F71A8255E7F3CB3507E5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C858F71A8255E7F3CB3507E5
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

> I don't have strong opinion about where the code should be. But if we 
> put this code in VM, there will be one extra array index operation 
> because the VM bug is ring related. VM manager need to maintain an 
> array to manage this information.
>
Yeah, but array index suck when you access cache cold stuff as well.

My concern is not so much where to put the field, but rather where to 
put the code to detect this condition. That is a bug very deeply related 
to how the CP manages VMs and VMIDs and actually not specific to the ring.

Just send out a patch which uses the ring type again to check if that 
workaround applies or not. The heavy stuff was calling 
amdgpu_get_ip_block() on every command submission, one additional if 
shouldn't hurt us here.

Regards,
Christian.

Am 31.05.2017 um 14:53 schrieb Xie, AlexBin:
>
> HI Christian,
>
>
> Too late. The code has been committed.
>
>
> I don't have strong opinion about where the code should be. But if we 
> put this code in VM, there will be one extra array index operation 
> because the VM bug is ring related. VM manager need to maintain an 
> array to manage this information.
>
>
> In the amdgpu_ring structure, there is already information like 
> vm_inv_eng and vmhub. Those are VM related information too. So this 
> one extra information is not new.
>
>
> Thanks,
>
> Alex Bin
>
> ------------------------------------------------------------------------
> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Wednesday, May 31, 2017 2:57 AM
> *To:* Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 1/3] drm/amdgpu: Optimize a function called by 
> every IB sheduling
> Am 30.05.2017 um 23:47 schrieb Alex Xie:
> >    Move several if statements and a loop statment from
> >    run time to initialization time.
>
> Yeah, that's exactly what I've suggested before as well.
>
> Just keep the code inside amdgpu_vm.c (and the variable inside
> amdgpu_vm_manager), since this isn't related to ring management at all.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 33 
> ++++++++++++++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 ++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 28 
> +--------------------------
> >   3 files changed, 40 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > index 6a85db0..7d95435 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -153,6 +153,36 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
> >   }
> >
> >   /**
> > + * amdgpu_ring_check_compute_vm_bug - check whether this ring has 
> compute vm bug
> > + *
> > + * @adev: amdgpu_device pointer
> > + * @ring: amdgpu_ring structure holding ring information
> > + */
> > +static void amdgpu_ring_check_compute_vm_bug(struct amdgpu_device 
> *adev,
> > +                                     struct amdgpu_ring *ring)
> > +{
> > +     const struct amdgpu_ip_block *ip_block;
> > +
> > +     ring->has_compute_vm_bug = false;
> > +
> > +     if (ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
> > +             /* only compute rings */
> > +             return;
> > +
> > +     ip_block = amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> > +     if (!ip_block)
> > +             return;
> > +
> > +     /* Compute ring has a VM bug for GFX version < 7.
> > +           And compute ring has a VM bug for GFX 8 MEC firmware 
> version < 673.*/
> > +     if (ip_block->version->major <= 7) {
> > +             ring->has_compute_vm_bug = true;
> > +     } else if (ip_block->version->major == 8)
> > +             if (adev->gfx.mec_fw_version < 673)
> > +                     ring->has_compute_vm_bug = true;
> > +}
> > +
> > +/**
> >    * amdgpu_ring_init - init driver ring struct.
> >    *
> >    * @adev: amdgpu_device pointer
> > @@ -257,6 +287,9 @@ int amdgpu_ring_init(struct amdgpu_device *adev, 
> struct amdgpu_ring *ring,
> >        if (amdgpu_debugfs_ring_init(adev, ring)) {
> >                DRM_ERROR("Failed to register debugfs file for rings 
> !\n");
> >        }
> > +
> > +     amdgpu_ring_check_compute_vm_bug(adev, ring);
> > +
> >        return 0;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index a9223a8..334307e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -185,6 +185,7 @@ struct amdgpu_ring {
> >        u64                     cond_exe_gpu_addr;
> >        volatile u32            *cond_exe_cpu_addr;
> >        unsigned                vm_inv_eng;
> > +     bool                    has_compute_vm_bug;
> >   #if defined(CONFIG_DEBUG_FS)
> >        struct dentry *ent;
> >   #endif
> > @@ -207,4 +208,9 @@ static inline void amdgpu_ring_clear_ring(struct 
> amdgpu_ring *ring)
> >
> >   }
> >
> > +static inline bool amdgpu_ring_has_compute_vm_bug(struct 
> amdgpu_ring *ring)
> > +{
> > +     return ring->has_compute_vm_bug;
> > +}
> > +
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index b2384b8..7a323f9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -656,32 +656,6 @@ static int amdgpu_vm_alloc_reserved_vmid(struct 
> amdgpu_device *adev,
> >        return r;
> >   }
> >
> > -static bool amdgpu_vm_ring_has_compute_vm_bug(struct amdgpu_ring *ring)
> > -{
> > -     struct amdgpu_device *adev = ring->adev;
> > -     const struct amdgpu_ip_block *ip_block;
> > -
> > -     if (ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
> > -             /* only compute rings */
> > -             return false;
> > -
> > -     ip_block = amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> > -     if (!ip_block)
> > -             return false;
> > -
> > -     if (ip_block->version->major <= 7) {
> > -             /* gfx7 has no workaround */
> > -             return true;
> > -     } else if (ip_block->version->major == 8) {
> > -             if (adev->gfx.mec_fw_version >= 673)
> > -                     /* gfx8 is fixed in MEC firmware 673 */
> > -                     return false;
> > -             else
> > -                     return true;
> > -     }
> > -     return false;
> > -}
> > -
> >   bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> >                                  struct amdgpu_job *job)
> >   {
> > @@ -691,7 +665,7 @@ bool amdgpu_vm_need_pipeline_sync(struct 
> amdgpu_ring *ring,
> >        struct amdgpu_vm_id *id;
> >        bool gds_switch_needed;
> >        bool vm_flush_needed = job->vm_needs_flush ||
> > - amdgpu_vm_ring_has_compute_vm_bug(ring);
> > +             amdgpu_ring_has_compute_vm_bug(ring);
> >
> >        if (job->vm_id == 0)
> >                return false;
>
>


--------------C858F71A8255E7F3CB3507E5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <p>I don't have strong opinion about where the code should be.
          But if we put this code in VM, there will be one extra array
          index operation because the VM bug is ring related. VM manager
          need to maintain an array to manage this information.</p>
      </blockquote>
      Yeah, but array index suck when you access cache cold stuff as
      well.<br>
      <br>
      My concern is not so much where to put the field, but rather where
      to put the code to detect this condition. That is a bug very
      deeply related to how the CP manages VMs and VMIDs and actually
      not specific to the ring.<br>
      <br>
      Just send out a patch which uses the ring type again to check if
      that workaround applies or not. The heavy stuff was calling
      amdgpu_get_ip_block() on every command submission, one additional
      if shouldn't hurt us here.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 31.05.2017 um 14:53 schrieb Xie, AlexBin:<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR1201MB0045FC6C00CA6008273C385BF2F10-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p>HI Christian,</p>
        <p><br>
        </p>
        <p>Too late. The code has been committed.</p>
        <p><br>
        </p>
        <p>I don't have strong opinion about where the code should be.
          But if we put this code in VM, there will be one extra array
          index operation because the VM bug is ring related. VM manager
          need to maintain an array to manage this information.</p>
        <p><br>
        </p>
        <p>In the <span>amdgpu_ring</span> structure, there is already
          information like <span>
            vm_inv_eng</span> and <span>vmhub</span>. Those are VM
          related information too. So this one extra information is not
          new.
          <br>
        </p>
        <p><br>
        </p>
        Thanks,
        <p>Alex Bin<br>
        </p>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" face="Calibri, sans-serif"
                color="#000000"><b>From:</b> Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Wednesday, May 31, 2017 2:57 AM<br>
                <b>To:</b> Xie, AlexBin; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu: Optimize a
                function called by every IB sheduling</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Am 30.05.2017 um 23:47 schrieb Alex
                Xie:<br>
                &gt;    Move several if statements and a loop statment
                from<br>
                &gt;    run time to initialization time.<br>
                <br>
                Yeah, that's exactly what I've suggested before as well.<br>
                <br>
                Just keep the code inside amdgpu_vm.c (and the variable
                inside <br>
                amdgpu_vm_manager), since this isn't related to ring
                management at all.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                &gt;<br>
                &gt; Signed-off-by: Alex Xie <a class="moz-txt-link-rfc2396E" href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 33
                ++++++++++++++++++++++++++++++++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6
                ++++++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 28
                +--------------------------<br>
                &gt;   3 files changed, 40 insertions(+), 27
                deletions(-)<br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
                &gt; index 6a85db0..7d95435 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
                &gt; @@ -153,6 +153,36 @@ void amdgpu_ring_undo(struct
                amdgpu_ring *ring)<br>
                &gt;   }<br>
                &gt;   <br>
                &gt;   /**<br>
                &gt; + * amdgpu_ring_check_compute_vm_bug - check
                whether this ring has compute vm bug<br>
                &gt; + *<br>
                &gt; + * @adev: amdgpu_device pointer<br>
                &gt; + * @ring: amdgpu_ring structure holding ring
                information<br>
                &gt; + */<br>
                &gt; +static void
                amdgpu_ring_check_compute_vm_bug(struct amdgpu_device
                *adev,<br>
                &gt; +                                     struct
                amdgpu_ring *ring)<br>
                &gt; +{<br>
                &gt; +     const struct amdgpu_ip_block *ip_block;<br>
                &gt; +<br>
                &gt; +     ring-&gt;has_compute_vm_bug = false;<br>
                &gt; +<br>
                &gt; +     if (ring-&gt;funcs-&gt;type !=
                AMDGPU_RING_TYPE_COMPUTE)<br>
                &gt; +             /* only compute rings */<br>
                &gt; +             return;<br>
                &gt; +<br>
                &gt; +     ip_block = amdgpu_get_ip_block(adev,
                AMD_IP_BLOCK_TYPE_GFX);<br>
                &gt; +     if (!ip_block)<br>
                &gt; +             return;<br>
                &gt; +<br>
                &gt; +     /* Compute ring has a VM bug for GFX version
                &lt; 7.<br>
                &gt; +           And compute ring has a VM bug for GFX 8
                MEC firmware version &lt; 673.*/<br>
                &gt; +     if (ip_block-&gt;version-&gt;major &lt;= 7) {<br>
                &gt; +             ring-&gt;has_compute_vm_bug = true;<br>
                &gt; +     } else if (ip_block-&gt;version-&gt;major ==
                8)<br>
                &gt; +             if (adev-&gt;gfx.mec_fw_version &lt;
                673)<br>
                &gt; +                     ring-&gt;has_compute_vm_bug =
                true;<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +/**<br>
                &gt;    * amdgpu_ring_init - init driver ring struct.<br>
                &gt;    *<br>
                &gt;    * @adev: amdgpu_device pointer<br>
                &gt; @@ -257,6 +287,9 @@ int amdgpu_ring_init(struct
                amdgpu_device *adev, struct amdgpu_ring *ring,<br>
                &gt;        if (amdgpu_debugfs_ring_init(adev, ring)) {<br>
                &gt;                DRM_ERROR("Failed to register
                debugfs file for rings !\n");<br>
                &gt;        }<br>
                &gt; +<br>
                &gt; +     amdgpu_ring_check_compute_vm_bug(adev, ring);<br>
                &gt; +<br>
                &gt;        return 0;<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                &gt; index a9223a8..334307e 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                &gt; @@ -185,6 +185,7 @@ struct amdgpu_ring {<br>
                &gt;        u64                     cond_exe_gpu_addr;<br>
                &gt;        volatile u32            *cond_exe_cpu_addr;<br>
                &gt;        unsigned                vm_inv_eng;<br>
                &gt; +     bool                    has_compute_vm_bug;<br>
                &gt;   #if defined(CONFIG_DEBUG_FS)<br>
                &gt;        struct dentry *ent;<br>
                &gt;   #endif<br>
                &gt; @@ -207,4 +208,9 @@ static inline void
                amdgpu_ring_clear_ring(struct amdgpu_ring *ring)<br>
                &gt;   <br>
                &gt;   }<br>
                &gt;   <br>
                &gt; +static inline bool
                amdgpu_ring_has_compute_vm_bug(struct amdgpu_ring *ring)<br>
                &gt; +{<br>
                &gt; +     return ring-&gt;has_compute_vm_bug;<br>
                &gt; +}<br>
                &gt; +<br>
                &gt;   #endif<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; index b2384b8..7a323f9 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; @@ -656,32 +656,6 @@ static int
                amdgpu_vm_alloc_reserved_vmid(struct amdgpu_device
                *adev,<br>
                &gt;        return r;<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; -static bool
                amdgpu_vm_ring_has_compute_vm_bug(struct amdgpu_ring
                *ring)<br>
                &gt; -{<br>
                &gt; -     struct amdgpu_device *adev = ring-&gt;adev;<br>
                &gt; -     const struct amdgpu_ip_block *ip_block;<br>
                &gt; -<br>
                &gt; -     if (ring-&gt;funcs-&gt;type !=
                AMDGPU_RING_TYPE_COMPUTE)<br>
                &gt; -             /* only compute rings */<br>
                &gt; -             return false;<br>
                &gt; -<br>
                &gt; -     ip_block = amdgpu_get_ip_block(adev,
                AMD_IP_BLOCK_TYPE_GFX);<br>
                &gt; -     if (!ip_block)<br>
                &gt; -             return false;<br>
                &gt; -<br>
                &gt; -     if (ip_block-&gt;version-&gt;major &lt;= 7) {<br>
                &gt; -             /* gfx7 has no workaround */<br>
                &gt; -             return true;<br>
                &gt; -     } else if (ip_block-&gt;version-&gt;major ==
                8) {<br>
                &gt; -             if (adev-&gt;gfx.mec_fw_version &gt;=
                673)<br>
                &gt; -                     /* gfx8 is fixed in MEC
                firmware 673 */<br>
                &gt; -                     return false;<br>
                &gt; -             else<br>
                &gt; -                     return true;<br>
                &gt; -     }<br>
                &gt; -     return false;<br>
                &gt; -}<br>
                &gt; -<br>
                &gt;   bool amdgpu_vm_need_pipeline_sync(struct
                amdgpu_ring *ring,<br>
                &gt;                                  struct amdgpu_job
                *job)<br>
                &gt;   {<br>
                &gt; @@ -691,7 +665,7 @@ bool
                amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,<br>
                &gt;        struct amdgpu_vm_id *id;<br>
                &gt;        bool gds_switch_needed;<br>
                &gt;        bool vm_flush_needed =
                job-&gt;vm_needs_flush ||<br>
                &gt; -            
                amdgpu_vm_ring_has_compute_vm_bug(ring);<br>
                &gt; +             amdgpu_ring_has_compute_vm_bug(ring);<br>
                &gt;   <br>
                &gt;        if (job-&gt;vm_id == 0)<br>
                &gt;                return false;<br>
                <br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------C858F71A8255E7F3CB3507E5--

--===============0597998220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0597998220==--
