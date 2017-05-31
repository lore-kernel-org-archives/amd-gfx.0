From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: add saved_bo to save vce 4.0 context when
 suspend
Date: Wed, 31 May 2017 16:06:22 -0400
Message-ID: <db96eb28-fa40-1029-c2a4-12eeb200ac63@amd.com>
References: <20170531192826.17571-1-leo.liu@amd.com>
 <20170531192826.17571-3-leo.liu@amd.com>
 <BN6PR12MB1652D083E4A3123CFE3B3628F7F10@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2123864355=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652D083E4A3123CFE3B3628F7F10-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============2123864355==
Content-Type: multipart/alternative;
	boundary="------------D6094CB2218CD5A94BDD9596"

--------------D6094CB2218CD5A94BDD9596
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 05/31/2017 03:54 PM, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> > Of Leo Liu
> > Sent: Wednesday, May 31, 2017 3:28 PM
> > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Cc: Liu, Leo
> > Subject: [PATCH 3/3] drm/amdgpu: add saved_bo to save vce 4.0 context
> > when suspend
> >
> > We are using PSP to resume firmware after suspend, and it is
> > resumed at where it got suspended, so we'd better save the
> > the context.
> >
> > Signed-off-by: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
>
> Patches 1, 2 are:
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> A few comments below on patch 3.
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |  1 +
> >  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 39
> > ++++++++++++++++++++++++++++-----
> >  2 files changed, 35 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> > index c93f74a..5ce54cd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> > @@ -34,6 +34,7 @@ struct amdgpu_vce {
> >        struct amdgpu_bo        *vcpu_bo;
> >        uint64_t                gpu_addr;
> >        void                    *cpu_addr;
> > +     void                    *saved_bo;
> >        unsigned                fw_version;
> >        unsigned                fb_version;
> >        atomic_t handles[AMDGPU_MAX_VCE_HANDLES];
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > index 0b7fcc1..2230a99 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > @@ -522,8 +522,22 @@ static int vce_v4_0_hw_fini(void *handle)
> >
> >  static int vce_v4_0_suspend(void *handle)
> >  {
> > -     int r;
> >        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +     int r;
> > +
> > +     if (adev->vce.vcpu_bo == NULL)
> > +             return 0;
> > +
> > +     if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> > +             unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> > +             void *ptr = adev->vce.cpu_addr;
> > +
> > +             adev->vce.saved_bo = kmalloc(size, GFP_KERNEL);
>
> Might want to avoid malloc/free in the suspend/resume paths.  Just 
> malloc/free the memory at sw_init/fini time.

Just waste a bit memory if it never goes to suspend, but sure, I will 
fix it in v2.

Thanks,
Leo

>
> > +             if (!adev->vce.saved_bo)
> > +                     return -ENOMEM;
> > +
> > +             memcpy_fromio(adev->vce.saved_bo, ptr, size);
> > +     }
> >
> >        r = vce_v4_0_hw_fini(adev);
> >        if (r)
> > @@ -534,12 +548,27 @@ static int vce_v4_0_suspend(void *handle)
> >
> >  static int vce_v4_0_resume(void *handle)
> >  {
> > -     int r;
> >        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +     int r;
> >
> > -     r = amdgpu_vce_resume(adev);
> > -     if (r)
> > -             return r;
> > +     if (adev->vce.vcpu_bo == NULL)
> > +             return -EINVAL;
> > +
> > +     if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> > +             unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
> > +             void *ptr = adev->vce.cpu_addr;
> > +
> > +             if (adev->vce.saved_bo != NULL) {
> > +                     memcpy_toio(ptr, adev->vce.saved_bo, size);
> > +                     kfree(adev->vce.saved_bo);
> > +                     adev->vce.saved_bo = NULL;
> > +             } else
>
> Kernel coding style; should be } else { ... } to match the chunk above.
>
> > +                     memset_io(ptr, 0, size);
> > +     } else {
> > +             r = amdgpu_vce_resume(adev);
> > +             if (r)
> > +                     return r;
> > +     }
> >
> >        return vce_v4_0_hw_init(adev);
> >  }
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------D6094CB2218CD5A94BDD9596
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 05/31/2017 03:54 PM, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote
cite="mid:BN6PR12MB1652D083E4A3123CFE3B3628F7F10-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">&gt; -----Original Message-----<br>
            &gt; From: amd-gfx [<a moz-do-not-send="true"
              href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
            On Behalf<br>
            &gt; Of Leo Liu<br>
            &gt; Sent: Wednesday, May 31, 2017 3:28 PM<br>
            &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; Cc: Liu, Leo<br>
            &gt; Subject: [PATCH 3/3] drm/amdgpu: add saved_bo to save
            vce 4.0 context<br>
            &gt; when suspend<br>
            &gt; <br>
            &gt; We are using PSP to resume firmware after suspend, and
            it is<br>
            &gt; resumed at where it got suspended, so we'd better save
            the<br>
            &gt; the context.<br>
            &gt; <br>
            &gt; Signed-off-by: Leo Liu <a class="moz-txt-link-rfc2396E" href="mailto:leo.liu-5C7GfCeVMHo@public.gmane.org">&lt;leo.liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <br>
            Patches 1, 2 are:<br>
            Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            A few comments below on patch 3.<br>
            <br>
            <br>
            &gt; ---<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |  1 +<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 39<br>
            &gt; ++++++++++++++++++++++++++++-----<br>
            &gt;  2 files changed, 35 insertions(+), 5 deletions(-)<br>
            &gt; <br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h<br>
            &gt; index c93f74a..5ce54cd 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h<br>
            &gt; @@ -34,6 +34,7 @@ struct amdgpu_vce {<br>
            &gt;        struct amdgpu_bo        *vcpu_bo;<br>
            &gt;        uint64_t                gpu_addr;<br>
            &gt;        void                    *cpu_addr;<br>
            &gt; +     void                    *saved_bo;<br>
            &gt;        unsigned                fw_version;<br>
            &gt;        unsigned                fb_version;<br>
            &gt;        atomic_t               
            handles[AMDGPU_MAX_VCE_HANDLES];<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
            &gt; index 0b7fcc1..2230a99 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
            &gt; @@ -522,8 +522,22 @@ static int vce_v4_0_hw_fini(void
            *handle)<br>
            &gt; <br>
            &gt;  static int vce_v4_0_suspend(void *handle)<br>
            &gt;  {<br>
            &gt; -     int r;<br>
            &gt;        struct amdgpu_device *adev = (struct
            amdgpu_device *)handle;<br>
            &gt; +     int r;<br>
            &gt; +<br>
            &gt; +     if (adev-&gt;vce.vcpu_bo == NULL)<br>
            &gt; +             return 0;<br>
            &gt; +<br>
            &gt; +     if (adev-&gt;firmware.load_type ==
            AMDGPU_FW_LOAD_PSP) {<br>
            &gt; +             unsigned size =
            amdgpu_bo_size(adev-&gt;vce.vcpu_bo);<br>
            &gt; +             void *ptr = adev-&gt;vce.cpu_addr;<br>
            &gt; +<br>
            &gt; +             adev-&gt;vce.saved_bo = kmalloc(size,
            GFP_KERNEL);<br>
            <br>
            Might want to avoid malloc/free in the suspend/resume
            paths.  Just malloc/free the memory at sw_init/fini time.<br>
          </div>
        </span></font></blockquote>
    <br>
    <font size="2">Just waste a bit memory if it never goes to suspend,
      but sure, I will fix it in v2.<br>
      <br>
      Thanks,<br>
      Leo<br>
      <br>
    </font>
    <blockquote
cite="mid:BN6PR12MB1652D083E4A3123CFE3B3628F7F10-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite"><font size="2"><span style="font-size:10pt;">
          <div class="PlainText">
            <br>
            &gt; +             if (!adev-&gt;vce.saved_bo)<br>
            &gt; +                     return -ENOMEM;<br>
            &gt; +<br>
            &gt; +             memcpy_fromio(adev-&gt;vce.saved_bo, ptr,
            size);<br>
            &gt; +     }<br>
            &gt; <br>
            &gt;        r = vce_v4_0_hw_fini(adev);<br>
            &gt;        if (r)<br>
            &gt; @@ -534,12 +548,27 @@ static int vce_v4_0_suspend(void
            *handle)<br>
            &gt; <br>
            &gt;  static int vce_v4_0_resume(void *handle)<br>
            &gt;  {<br>
            &gt; -     int r;<br>
            &gt;        struct amdgpu_device *adev = (struct
            amdgpu_device *)handle;<br>
            &gt; +     int r;<br>
            &gt; <br>
            &gt; -     r = amdgpu_vce_resume(adev);<br>
            &gt; -     if (r)<br>
            &gt; -             return r;<br>
            &gt; +     if (adev-&gt;vce.vcpu_bo == NULL)<br>
            &gt; +             return -EINVAL;<br>
            &gt; +<br>
            &gt; +     if (adev-&gt;firmware.load_type ==
            AMDGPU_FW_LOAD_PSP) {<br>
            &gt; +             unsigned size =
            amdgpu_bo_size(adev-&gt;vce.vcpu_bo);<br>
            &gt; +             void *ptr = adev-&gt;vce.cpu_addr;<br>
            &gt; +<br>
            &gt; +             if (adev-&gt;vce.saved_bo != NULL) {<br>
            &gt; +                     memcpy_toio(ptr,
            adev-&gt;vce.saved_bo, size);<br>
            &gt; +                     kfree(adev-&gt;vce.saved_bo);<br>
            &gt; +                     adev-&gt;vce.saved_bo = NULL;<br>
            &gt; +             } else<br>
            <br>
            Kernel coding style; should be } else { ... } to match the
            chunk above.<br>
            <br>
            &gt; +                     memset_io(ptr, 0, size);<br>
            &gt; +     } else {<br>
            &gt; +             r = amdgpu_vce_resume(adev);<br>
            &gt; +             if (r)<br>
            &gt; +                     return r;<br>
            &gt; +     }<br>
            &gt; <br>
            &gt;        return vce_v4_0_hw_init(adev);<br>
            &gt;  }<br>
            &gt; --<br>
            &gt; 2.7.4<br>
            &gt; <br>
            &gt; _______________________________________________<br>
            &gt; amd-gfx mailing list<br>
            &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; <a moz-do-not-send="true"
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
    </blockquote>
    <br>
  </body>
</html>

--------------D6094CB2218CD5A94BDD9596--

--===============2123864355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2123864355==--
