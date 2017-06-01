From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Move compute vm bug logic to amdgpu_vm.c
Date: Thu, 1 Jun 2017 09:50:59 -0400
Message-ID: <532a53b4-e443-e4d1-14ce-77b0fae9c11e@amd.com>
References: <1496272081-21584-1-git-send-email-AlexBin.Xie@amd.com>
 <183887cb-17a0-e457-0c92-c04cc4b7fb53@vodafone.de>
 <MWHPR1201MB0045729996FF89B47DCD29A3F2F60@MWHPR1201MB0045.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0502309801=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0045729996FF89B47DCD29A3F2F60-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0502309801==
Content-Type: multipart/alternative;
	boundary="------------123B8C3BEEF80B4F46C10748"

--------------123B8C3BEEF80B4F46C10748
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

When you git email-send first time, there is a message-id, when you 
would send follow up patches, using --in-reply-to="message-id" in your 
comment line, then that will be in the same thread.


Cheers,

Leo



On 06/01/2017 09:40 AM, Xie, AlexBin wrote:
>
> Ok. I will add the v2 next time. I did not add the v2 in case this 
> email list does not put the two patches under same thread...
>
>
> -Alex Bin
>
> ------------------------------------------------------------------------
> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Thursday, June 1, 2017 9:26 AM
> *To:* Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amdgpu: Move compute vm bug logic to 
> amdgpu_vm.c
> Am 01.06.2017 um 01:08 schrieb Alex Xie:
> >    In review, Christian would like to keep the logic
> >    inside amdgpu_vm.c with a cost of slightly slower.
> >    The loop is still optimized out with this patch.
> >
> > v2: remove the if statement. Now it is not slower.
> >
> > Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
>
> When you create a v2 of a patch please note that in the subject line as
> well.
>
> Either by using the "-v2" option with "git send-email" or by adding the
> v2 manually on the subject line.
>
> I sometimes get mails twice because they are send to multiple lists I'm
> registered on and that helps allot seeing that a patch changed and is
> not just a duplicated mail.
>
> Anyway this version is Reviewed-by: Christian König
> <christian.koeng-5C7GfCeVMHo@public.gmane.org> as well.
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 32 
> -------------------------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  5 ----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 38 
> ++++++++++++++++++++++++++++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +
> >   5 files changed, 39 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 89bc34a..2f1a4e9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2227,6 +2227,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
> >
> >        adev->accel_working = true;
> >
> > +     amdgpu_vm_check_compute_bug(adev);
> > +
> >        /* Initialize the buffer migration limit. */
> >        if (amdgpu_moverate >= 0)
> >                max_MBps = amdgpu_moverate;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > index 7d95435..31aa51d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -153,36 +153,6 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
> >   }
> >
> >   /**
> > - * amdgpu_ring_check_compute_vm_bug - check whether this ring has 
> compute vm bug
> > - *
> > - * @adev: amdgpu_device pointer
> > - * @ring: amdgpu_ring structure holding ring information
> > - */
> > -static void amdgpu_ring_check_compute_vm_bug(struct amdgpu_device 
> *adev,
> > -                                     struct amdgpu_ring *ring)
> > -{
> > -     const struct amdgpu_ip_block *ip_block;
> > -
> > -     ring->has_compute_vm_bug = false;
> > -
> > -     if (ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
> > -             /* only compute rings */
> > -             return;
> > -
> > -     ip_block = amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> > -     if (!ip_block)
> > -             return;
> > -
> > -     /* Compute ring has a VM bug for GFX version < 7.
> > -           And compute ring has a VM bug for GFX 8 MEC firmware 
> version < 673.*/
> > -     if (ip_block->version->major <= 7) {
> > -             ring->has_compute_vm_bug = true;
> > -     } else if (ip_block->version->major == 8)
> > -             if (adev->gfx.mec_fw_version < 673)
> > -                     ring->has_compute_vm_bug = true;
> > -}
> > -
> > -/**
> >    * amdgpu_ring_init - init driver ring struct.
> >    *
> >    * @adev: amdgpu_device pointer
> > @@ -288,8 +258,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, 
> struct amdgpu_ring *ring,
> >                DRM_ERROR("Failed to register debugfs file for rings 
> !\n");
> >        }
> >
> > -     amdgpu_ring_check_compute_vm_bug(adev, ring);
> > -
> >        return 0;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 334307e..ad399c8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -208,9 +208,4 @@ static inline void amdgpu_ring_clear_ring(struct 
> amdgpu_ring *ring)
> >
> >   }
> >
> > -static inline bool amdgpu_ring_has_compute_vm_bug(struct 
> amdgpu_ring *ring)
> > -{
> > -     return ring->has_compute_vm_bug;
> > -}
> > -
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index d4d05a8..6e32748 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -656,6 +656,41 @@ static int amdgpu_vm_alloc_reserved_vmid(struct 
> amdgpu_device *adev,
> >        return r;
> >   }
> >
> > +/**
> > + * amdgpu_vm_check_compute_bug - check whether asic has compute vm bug
> > + *
> > + * @adev: amdgpu_device pointer
> > + */
> > +void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
> > +{
> > +     const struct amdgpu_ip_block *ip_block;
> > +     bool has_compute_vm_bug;
> > +     struct amdgpu_ring *ring;
> > +     int i;
> > +
> > +     has_compute_vm_bug = false;
> > +
> > +     ip_block = amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
> > +     if (ip_block) {
> > +             /* Compute has a VM bug for GFX version < 7.
> > +                Compute has a VM bug for GFX 8 MEC firmware version 
> < 673.*/
> > +             if (ip_block->version->major <= 7)
> > +                     has_compute_vm_bug = true;
> > +             else if (ip_block->version->major == 8)
> > +                     if (adev->gfx.mec_fw_version < 673)
> > +                             has_compute_vm_bug = true;
> > +     }
> > +
> > +     for (i = 0; i < adev->num_rings; i++) {
> > +             ring = adev->rings[i];
> > +             if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
> > +                     /* only compute rings */
> > +                     ring->has_compute_vm_bug = has_compute_vm_bug;
> > +             else
> > +                     ring->has_compute_vm_bug = false;
> > +     }
> > +}
> > +
> >   bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> >                                  struct amdgpu_job *job)
> >   {
> > @@ -664,8 +699,7 @@ bool amdgpu_vm_need_pipeline_sync(struct 
> amdgpu_ring *ring,
> >        struct amdgpu_vm_id_manager *id_mgr = 
> &adev->vm_manager.id_mgr[vmhub];
> >        struct amdgpu_vm_id *id;
> >        bool gds_switch_needed;
> > -     bool vm_flush_needed = job->vm_needs_flush ||
> > -             amdgpu_ring_has_compute_vm_bug(ring);
> > +     bool vm_flush_needed = job->vm_needs_flush || 
> ring->has_compute_vm_bug;
> >
> >        if (job->vm_id == 0)
> >                return false;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > index 8309bc7..f5dba9c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -245,5 +245,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device 
> *adev, uint64_t vm_size);
> >   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct 
> drm_file *filp);
> >   bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> >                                  struct amdgpu_job *job);
> > +void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
> >
> >   #endif
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------123B8C3BEEF80B4F46C10748
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>When you git email-send first time, there is a message-id, when
      you would send follow up patches, using --in-reply-to="message-id"
      in your comment line, then that will be in the same thread.</p>
    <p><br>
    </p>
    <p>Cheers,<br>
    </p>
    <p>Leo</p>
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 06/01/2017 09:40 AM, Xie, AlexBin
      wrote:<br>
    </div>
    <blockquote
cite="mid:MWHPR1201MB0045729996FF89B47DCD29A3F2F60-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p>Ok. I will add the v2 next time. I did not add the v2 in case
          this email list does not put the two patches under same
          thread...<br>
        </p>
        <br>
        <p>-Alex Bin<br>
        </p>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>From:</b> Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Thursday, June 1, 2017 9:26 AM<br>
                <b>To:</b> Xie, AlexBin; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: Move compute vm
                bug logic to amdgpu_vm.c</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Am 01.06.2017 um 01:08 schrieb Alex
                Xie:<br>
                &gt;    In review, Christian would like to keep the
                logic<br>
                &gt;    inside amdgpu_vm.c with a cost of slightly
                slower.<br>
                &gt;    The loop is still optimized out with this patch.<br>
                &gt;<br>
                &gt; v2: remove the if statement. Now it is not slower.<br>
                &gt;<br>
                &gt; Signed-off-by: Alex Xie <a class="moz-txt-link-rfc2396E" href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <br>
                When you create a v2 of a patch please note that in the
                subject line as <br>
                well.<br>
                <br>
                Either by using the "-v2" option with "git send-email"
                or by adding the <br>
                v2 manually on the subject line.<br>
                <br>
                I sometimes get mails twice because they are send to
                multiple lists I'm <br>
                registered on and that helps allot seeing that a patch
                changed and is <br>
                not just a duplicated mail.<br>
                <br>
                Anyway this version is Reviewed-by: Christian König <br>
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koeng-5C7GfCeVMHo@public.gmane.org">&lt;christian.koeng-5C7GfCeVMHo@public.gmane.org&gt;</a> as well.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2
                ++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 32
                -------------------------<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  5
                ----<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 38
                ++++++++++++++++++++++++++++--<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +<br>
                &gt;   5 files changed, 39 insertions(+), 39
                deletions(-)<br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; index 89bc34a..2f1a4e9 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; @@ -2227,6 +2227,8 @@ int amdgpu_device_init(struct
                amdgpu_device *adev,<br>
                &gt;   <br>
                &gt;        adev-&gt;accel_working = true;<br>
                &gt;   <br>
                &gt; +     amdgpu_vm_check_compute_bug(adev);<br>
                &gt; +<br>
                &gt;        /* Initialize the buffer migration limit. */<br>
                &gt;        if (amdgpu_moverate &gt;= 0)<br>
                &gt;                max_MBps = amdgpu_moverate;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
                &gt; index 7d95435..31aa51d 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
                &gt; @@ -153,36 +153,6 @@ void amdgpu_ring_undo(struct
                amdgpu_ring *ring)<br>
                &gt;   }<br>
                &gt;   <br>
                &gt;   /**<br>
                &gt; - * amdgpu_ring_check_compute_vm_bug - check
                whether this ring has compute vm bug<br>
                &gt; - *<br>
                &gt; - * @adev: amdgpu_device pointer<br>
                &gt; - * @ring: amdgpu_ring structure holding ring
                information<br>
                &gt; - */<br>
                &gt; -static void
                amdgpu_ring_check_compute_vm_bug(struct amdgpu_device
                *adev,<br>
                &gt; -                                     struct
                amdgpu_ring *ring)<br>
                &gt; -{<br>
                &gt; -     const struct amdgpu_ip_block *ip_block;<br>
                &gt; -<br>
                &gt; -     ring-&gt;has_compute_vm_bug = false;<br>
                &gt; -<br>
                &gt; -     if (ring-&gt;funcs-&gt;type !=
                AMDGPU_RING_TYPE_COMPUTE)<br>
                &gt; -             /* only compute rings */<br>
                &gt; -             return;<br>
                &gt; -<br>
                &gt; -     ip_block = amdgpu_get_ip_block(adev,
                AMD_IP_BLOCK_TYPE_GFX);<br>
                &gt; -     if (!ip_block)<br>
                &gt; -             return;<br>
                &gt; -<br>
                &gt; -     /* Compute ring has a VM bug for GFX version
                &lt; 7.<br>
                &gt; -           And compute ring has a VM bug for GFX 8
                MEC firmware version &lt; 673.*/<br>
                &gt; -     if (ip_block-&gt;version-&gt;major &lt;= 7) {<br>
                &gt; -             ring-&gt;has_compute_vm_bug = true;<br>
                &gt; -     } else if (ip_block-&gt;version-&gt;major ==
                8)<br>
                &gt; -             if (adev-&gt;gfx.mec_fw_version &lt;
                673)<br>
                &gt; -                     ring-&gt;has_compute_vm_bug =
                true;<br>
                &gt; -}<br>
                &gt; -<br>
                &gt; -/**<br>
                &gt;    * amdgpu_ring_init - init driver ring struct.<br>
                &gt;    *<br>
                &gt;    * @adev: amdgpu_device pointer<br>
                &gt; @@ -288,8 +258,6 @@ int amdgpu_ring_init(struct
                amdgpu_device *adev, struct amdgpu_ring *ring,<br>
                &gt;                DRM_ERROR("Failed to register
                debugfs file for rings !\n");<br>
                &gt;        }<br>
                &gt;   <br>
                &gt; -     amdgpu_ring_check_compute_vm_bug(adev, ring);<br>
                &gt; -<br>
                &gt;        return 0;<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                &gt; index 334307e..ad399c8 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
                &gt; @@ -208,9 +208,4 @@ static inline void
                amdgpu_ring_clear_ring(struct amdgpu_ring *ring)<br>
                &gt;   <br>
                &gt;   }<br>
                &gt;   <br>
                &gt; -static inline bool
                amdgpu_ring_has_compute_vm_bug(struct amdgpu_ring *ring)<br>
                &gt; -{<br>
                &gt; -     return ring-&gt;has_compute_vm_bug;<br>
                &gt; -}<br>
                &gt; -<br>
                &gt;   #endif<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; index d4d05a8..6e32748 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; @@ -656,6 +656,41 @@ static int
                amdgpu_vm_alloc_reserved_vmid(struct amdgpu_device
                *adev,<br>
                &gt;        return r;<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; +/**<br>
                &gt; + * amdgpu_vm_check_compute_bug - check whether
                asic has compute vm bug<br>
                &gt; + *<br>
                &gt; + * @adev: amdgpu_device pointer<br>
                &gt; + */<br>
                &gt; +void amdgpu_vm_check_compute_bug(struct
                amdgpu_device *adev)<br>
                &gt; +{<br>
                &gt; +     const struct amdgpu_ip_block *ip_block;<br>
                &gt; +     bool has_compute_vm_bug;<br>
                &gt; +     struct amdgpu_ring *ring;<br>
                &gt; +     int i;<br>
                &gt; +<br>
                &gt; +     has_compute_vm_bug = false;<br>
                &gt; +<br>
                &gt; +     ip_block = amdgpu_get_ip_block(adev,
                AMD_IP_BLOCK_TYPE_GFX);<br>
                &gt; +     if (ip_block) {<br>
                &gt; +             /* Compute has a VM bug for GFX
                version &lt; 7.<br>
                &gt; +                Compute has a VM bug for GFX 8 MEC
                firmware version &lt; 673.*/<br>
                &gt; +             if (ip_block-&gt;version-&gt;major
                &lt;= 7)<br>
                &gt; +                     has_compute_vm_bug = true;<br>
                &gt; +             else if
                (ip_block-&gt;version-&gt;major == 8)<br>
                &gt; +                     if
                (adev-&gt;gfx.mec_fw_version &lt; 673)<br>
                &gt; +                             has_compute_vm_bug =
                true;<br>
                &gt; +     }<br>
                &gt; +<br>
                &gt; +     for (i = 0; i &lt; adev-&gt;num_rings; i++) {<br>
                &gt; +             ring = adev-&gt;rings[i];<br>
                &gt; +             if (ring-&gt;funcs-&gt;type ==
                AMDGPU_RING_TYPE_COMPUTE)<br>
                &gt; +                     /* only compute rings */<br>
                &gt; +                     ring-&gt;has_compute_vm_bug =
                has_compute_vm_bug;<br>
                &gt; +             else<br>
                &gt; +                     ring-&gt;has_compute_vm_bug =
                false;<br>
                &gt; +     }<br>
                &gt; +}<br>
                &gt; +<br>
                &gt;   bool amdgpu_vm_need_pipeline_sync(struct
                amdgpu_ring *ring,<br>
                &gt;                                  struct amdgpu_job
                *job)<br>
                &gt;   {<br>
                &gt; @@ -664,8 +699,7 @@ bool
                amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,<br>
                &gt;        struct amdgpu_vm_id_manager *id_mgr =
                &amp;adev-&gt;vm_manager.id_mgr[vmhub];<br>
                &gt;        struct amdgpu_vm_id *id;<br>
                &gt;        bool gds_switch_needed;<br>
                &gt; -     bool vm_flush_needed = job-&gt;vm_needs_flush
                ||<br>
                &gt; -             amdgpu_ring_has_compute_vm_bug(ring);<br>
                &gt; +     bool vm_flush_needed = job-&gt;vm_needs_flush
                || ring-&gt;has_compute_vm_bug;<br>
                &gt;   <br>
                &gt;        if (job-&gt;vm_id == 0)<br>
                &gt;                return false;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; index 8309bc7..f5dba9c 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; @@ -245,5 +245,6 @@ void
                amdgpu_vm_adjust_size(struct amdgpu_device *adev,
                uint64_t vm_size);<br>
                &gt;   int amdgpu_vm_ioctl(struct drm_device *dev, void
                *data, struct drm_file *filp);<br>
                &gt;   bool amdgpu_vm_need_pipeline_sync(struct
                amdgpu_ring *ring,<br>
                &gt;                                  struct amdgpu_job
                *job);<br>
                &gt; +void amdgpu_vm_check_compute_bug(struct
                amdgpu_device *adev);<br>
                &gt;   <br>
                &gt;   #endif<br>
                <br>
                <br>
              </div>
            </span></font></div>
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
    <br>
  </body>
</html>

--------------123B8C3BEEF80B4F46C10748--

--===============0502309801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0502309801==--
