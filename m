From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: drm/amdgpu: Add helper function to get buffer domain
Date: Mon, 28 May 2018 09:07:23 +0200
Message-ID: <b416465e-0561-8e2c-25b6-1792b4cac970@gmail.com>
References: <20180526001229.15509-1-Deepak.Sharma@amd.com>
 <f58bea93-8f1a-bc97-a0c6-a3d2f324275c@amd.com>
 <BN6PR12MB18092E2599E79AA9FCE2BB48F7680@BN6PR12MB1809.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0286606983=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18092E2599E79AA9FCE2BB48F7680-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0286606983==
Content-Type: multipart/alternative;
 boundary="------------76B9CAC3280C25A0F60314C5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------76B9CAC3280C25A0F60314C5
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org> for both as well.

Christian.

Am 26.05.2018 um 15:23 schrieb Deucher, Alexander:
>
> Both patches are:
>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> ------------------------------------------------------------------------
> *From:* Sharma, Deepak
> *Sent:* Friday, May 25, 2018 8:19:26 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; 
> michel-otUistvHUpPR7s880joybQ@public.gmane.org; Koenig, Christian
> *Subject:* Re: drm/amdgpu: Add helper function to get buffer domain
> If look fine , please give rb for this and
> https://patchwork.freedesktop.org/patch/224850/
>
> Thanks,
> Deepak
>
> On 05/25/2018 05:12 PM, Deepak Sharma wrote:
> > Move logic of getting supported domain to a helper
> > function
> >
> > Signed-off-by: Deepak Sharma <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 10 +++-------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 17 ++++++++++++-----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
> >   3 files changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > index 63758db5e2ea..556406a44da3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -750,19 +750,15 @@ int amdgpu_mode_dumb_create(struct drm_file 
> *file_priv,
> >        struct amdgpu_device *adev = dev->dev_private;
> >        struct drm_gem_object *gobj;
> >        uint32_t handle;
> > -     u32 domain = amdgpu_display_supported_domains(adev);
> > +     u32 domain;
> >        int r;
> >
> >        args->pitch = amdgpu_align_pitch(adev, args->width,
> > DIV_ROUND_UP(args->bpp, 8), 0);
> >        args->size = (u64)args->pitch * args->height;
> >        args->size = ALIGN(args->size, PAGE_SIZE);
> > -     if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
> > -             domain = AMDGPU_GEM_DOMAIN_VRAM;
> > -             if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
> > -                     domain = AMDGPU_GEM_DOMAIN_GTT;
> > -     }
> > -
> > +     domain = amdgpu_bo_get_preferred_pin_domain(adev,
> > + amdgpu_display_supported_domains(adev));
> >        r = amdgpu_gem_object_create(adev, args->size, 0, domain,
> > AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
> >                                     false, NULL, &gobj);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index 6a9e46ae7f0a..5e4e1bd90383 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -703,11 +703,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
> *bo, u32 domain,
> >        /* This assumes only APU display buffers are pinned with 
> (VRAM|GTT).
> >         * See function amdgpu_display_supported_domains()
> >         */
> > -     if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
> > -             domain = AMDGPU_GEM_DOMAIN_VRAM;
> > -             if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
> > -                     domain = AMDGPU_GEM_DOMAIN_GTT;
> > -     }
> > +     domain = amdgpu_bo_get_preferred_pin_domain(adev, domain);
> >
> >        if (bo->pin_count) {
> >                uint32_t mem_type = bo->tbo.mem.mem_type;
> > @@ -1066,3 +1062,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
> >
> >        return bo->tbo.offset;
> >   }
> > +
> > +uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
> > +                                         uint32_t domain)
> > +{
> > +     if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
> > +             domain = AMDGPU_GEM_DOMAIN_VRAM;
> > +             if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
> > +                     domain = AMDGPU_GEM_DOMAIN_GTT;
> > +     }
> > +     return domain;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > index 540e03fa159f..731748033878 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > @@ -289,7 +289,8 @@ int amdgpu_bo_restore_from_shadow(struct 
> amdgpu_device *adev,
> >                                  struct reservation_object *resv,
> >                                  struct dma_fence **fence,
> >                                  bool direct);
> > -
> > +uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
> > +                                         uint32_t domain);
> >
> >   /*
> >    * sub allocation
> >
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------76B9CAC3280C25A0F60314C5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> for both as well.<br>
      <br>
      Christian.<br>
      <br>
      Am 26.05.2018 um 15:23 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB18092E2599E79AA9FCE2BB48F7680-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Both patches are:</p>
        <p style="margin-top:0;margin-bottom:0">Reviewed-by: Alex
          Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Sharma, Deepak<br>
          <b>Sent:</b> Friday, May 25, 2018 8:19:26 PM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher, Alexander;
          <a class="moz-txt-link-abbreviated" href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>; Koenig, Christian<br>
          <b>Subject:</b> Re: drm/amdgpu: Add helper function to get
          buffer domain</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">If look fine , please give rb for
              this and <br>
              <a href="https://patchwork.freedesktop.org/patch/224850/"
                moz-do-not-send="true">https://patchwork.freedesktop.org/patch/224850/</a><br>
              <br>
              Thanks,<br>
              Deepak<br>
              <br>
              On 05/25/2018 05:12 PM, Deepak Sharma wrote:<br>
              &gt; Move logic of getting supported domain to a helper<br>
              &gt; function<br>
              &gt; <br>
              &gt; Signed-off-by: Deepak Sharma
              <a class="moz-txt-link-rfc2396E" href="mailto:Deepak.Sharma-5C7GfCeVMHo@public.gmane.org">&lt;Deepak.Sharma-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; ---<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 10
              +++-------<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 17
              ++++++++++++-----<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-<br>
              &gt;   3 files changed, 17 insertions(+), 13 deletions(-)<br>
              &gt; <br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
              &gt; index 63758db5e2ea..556406a44da3 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
              &gt; @@ -750,19 +750,15 @@ int
              amdgpu_mode_dumb_create(struct drm_file *file_priv,<br>
              &gt;        struct amdgpu_device *adev =
              dev-&gt;dev_private;<br>
              &gt;        struct drm_gem_object *gobj;<br>
              &gt;        uint32_t handle;<br>
              &gt; -     u32 domain =
              amdgpu_display_supported_domains(adev);<br>
              &gt; +     u32 domain;<br>
              &gt;        int r;<br>
              &gt;   <br>
              &gt;        args-&gt;pitch = amdgpu_align_pitch(adev,
              args-&gt;width,<br>
              &gt;                                        
              DIV_ROUND_UP(args-&gt;bpp, 8), 0);<br>
              &gt;        args-&gt;size = (u64)args-&gt;pitch *
              args-&gt;height;<br>
              &gt;        args-&gt;size = ALIGN(args-&gt;size,
              PAGE_SIZE);<br>
              &gt; -     if (domain == (AMDGPU_GEM_DOMAIN_VRAM |
              AMDGPU_GEM_DOMAIN_GTT)) {<br>
              &gt; -             domain = AMDGPU_GEM_DOMAIN_VRAM;<br>
              &gt; -             if (adev-&gt;gmc.real_vram_size &lt;=
              AMDGPU_SG_THRESHOLD)<br>
              &gt; -                     domain = AMDGPU_GEM_DOMAIN_GTT;<br>
              &gt; -     }<br>
              &gt; -<br>
              &gt; +     domain =
              amdgpu_bo_get_preferred_pin_domain(adev,<br>
              &gt; +                            
              amdgpu_display_supported_domains(adev));<br>
              &gt;        r = amdgpu_gem_object_create(adev,
              args-&gt;size, 0, domain,<br>
              &gt;                                    
              AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,<br>
              &gt;                                     false, NULL,
              &amp;gobj);<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              &gt; index 6a9e46ae7f0a..5e4e1bd90383 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              &gt; @@ -703,11 +703,7 @@ int
              amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,<br>
              &gt;        /* This assumes only APU display buffers are
              pinned with (VRAM|GTT).<br>
              &gt;         * See function
              amdgpu_display_supported_domains()<br>
              &gt;         */<br>
              &gt; -     if (domain == (AMDGPU_GEM_DOMAIN_VRAM |
              AMDGPU_GEM_DOMAIN_GTT)) {<br>
              &gt; -             domain = AMDGPU_GEM_DOMAIN_VRAM;<br>
              &gt; -             if (adev-&gt;gmc.real_vram_size &lt;=
              AMDGPU_SG_THRESHOLD)<br>
              &gt; -                     domain = AMDGPU_GEM_DOMAIN_GTT;<br>
              &gt; -     }<br>
              &gt; +     domain =
              amdgpu_bo_get_preferred_pin_domain(adev, domain);<br>
              &gt;   <br>
              &gt;        if (bo-&gt;pin_count) {<br>
              &gt;                uint32_t mem_type =
              bo-&gt;tbo.mem.mem_type;<br>
              &gt; @@ -1066,3 +1062,14 @@ u64
              amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)<br>
              &gt;   <br>
              &gt;        return bo-&gt;tbo.offset;<br>
              &gt;   }<br>
              &gt; +<br>
              &gt; +uint32_t amdgpu_bo_get_preferred_pin_domain(struct
              amdgpu_device *adev,<br>
              &gt; +                                         uint32_t
              domain)<br>
              &gt; +{<br>
              &gt; +     if (domain == (AMDGPU_GEM_DOMAIN_VRAM |
              AMDGPU_GEM_DOMAIN_GTT)) {<br>
              &gt; +             domain = AMDGPU_GEM_DOMAIN_VRAM;<br>
              &gt; +             if (adev-&gt;gmc.real_vram_size &lt;=
              AMDGPU_SG_THRESHOLD)<br>
              &gt; +                     domain = AMDGPU_GEM_DOMAIN_GTT;<br>
              &gt; +     }<br>
              &gt; +     return domain;<br>
              &gt; +}<br>
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
              &gt; index 540e03fa159f..731748033878 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
              &gt; @@ -289,7 +289,8 @@ int
              amdgpu_bo_restore_from_shadow(struct amdgpu_device *adev,<br>
              &gt;                                  struct
              reservation_object *resv,<br>
              &gt;                                  struct dma_fence
              **fence,<br>
              &gt;                                  bool direct);<br>
              &gt; -<br>
              &gt; +uint32_t amdgpu_bo_get_preferred_pin_domain(struct
              amdgpu_device *adev,<br>
              &gt; +                                         uint32_t
              domain);<br>
              &gt;   <br>
              &gt;   /*<br>
              &gt;    * sub allocation<br>
              &gt; <br>
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
    <br>
  </body>
</html>

--------------76B9CAC3280C25A0F60314C5--

--===============0286606983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0286606983==--
