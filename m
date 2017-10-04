From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 12/12] drm/amdgpu/sriov:no shadow buffer recovery
Date: Wed, 4 Oct 2017 12:56:18 +0200
Message-ID: <9b08e030-1a47-39ef-8010-64c51d4560e8@amd.com>
References: <1506751432-21789-1-git-send-email-Monk.Liu@amd.com>
 <1506751432-21789-13-git-send-email-Monk.Liu@amd.com>
 <e767c6f2-4050-c697-2075-c3d744e6b379@gmail.com>
 <BLUPR12MB0449346A746E70A7BE88FEA084730@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0726371900=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0449346A746E70A7BE88FEA084730-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0726371900==
Content-Type: multipart/alternative;
 boundary="------------04B0D2884067CF563F0B039E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------04B0D2884067CF563F0B039E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Ah! Sorry, my fault.

I've missed the "no" and thought you wanted to abandon all processing 
because VRAM is always lost.

Going to review the remaining patches today.

Christian.

Am 04.10.2017 um 11:41 schrieb Liu, Monk:
>
> Why ? the page tables are resided in VRAM, no need to recovery if no 
> VRAM lost
>
> Sent from Mail <https://go.microsoft.com/fwlink/?LinkId=550986> for 
> Windows 10
>
> *From: *Christian König <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent: *2017年10月1日17:36
> *To: *Liu, Monk <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject: *Re: [PATCH 12/12] drm/amdgpu/sriov:no shadow buffer recovery
>
> Am 30.09.2017 um 08:03 schrieb Monk Liu:
> > 1, we have deadlock unresloved between shadow bo recovery
> > and ctx_do_release,
> >
> > 2, for loose mode gpu reset we always assume VRAM not lost
> > so there is no need to do that from begining
> >
> > Change-Id: I5259f9d943239bd1fa2e45eb446ef053299fbfb1
> > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>
> NAK, even when VRAM ist lost we must restore the page tables or
> otherwise no process would be able to proceed.
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29 
> -----------------------------
> >   1 file changed, 29 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index c3f10b5..8ae7a2c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2840,9 +2840,7 @@ int amdgpu_sriov_gpu_reset(struct 
> amdgpu_device *adev, struct amdgpu_job *job)
> >   {
> >        int i, j, r = 0;
> >        int resched;
> > -     struct amdgpu_bo *bo, *tmp;
> >        struct amdgpu_ring *ring;
> > -     struct dma_fence *fence = NULL, *next = NULL;
> >
> >        /* other thread is already into the gpu reset so just quit 
> and come later */
> >        if (!atomic_add_unless(&adev->in_sriov_reset, 1, 1))
> > @@ -2909,33 +2907,6 @@ int amdgpu_sriov_gpu_reset(struct 
> amdgpu_device *adev, struct amdgpu_job *job)
> >        /* release full control of GPU after ib test */
> >        amdgpu_virt_release_full_gpu(adev, true);
> >
> > -     DRM_INFO("recover vram bo from shadow\n");
> > -
> > -     ring = adev->mman.buffer_funcs_ring;
> > -     mutex_lock(&adev->shadow_list_lock);
> > -     list_for_each_entry_safe(bo, tmp, &adev->shadow_list, 
> shadow_list) {
> > -             next = NULL;
> > -             amdgpu_recover_vram_from_shadow(adev, ring, bo, &next);
> > -             if (fence) {
> > -                     r = dma_fence_wait(fence, false);
> > -                     if (r) {
> > -                             WARN(r, "recovery from shadow isn't 
> completed\n");
> > -                             break;
> > -                     }
> > -             }
> > -
> > -             dma_fence_put(fence);
> > -             fence = next;
> > -     }
> > -     mutex_unlock(&adev->shadow_list_lock);
> > -
> > -     if (fence) {
> > -             r = dma_fence_wait(fence, false);
> > -             if (r)
> > -                     WARN(r, "recovery from shadow isn't completed\n");
> > -     }
> > -     dma_fence_put(fence);
> > -
> >        for (i = j; i < j + AMDGPU_MAX_RINGS; ++i) {
> >                ring = adev->rings[i % AMDGPU_MAX_RINGS];
> >                if (!ring || !ring->sched.thread)
>
>


--------------04B0D2884067CF563F0B039E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Ah! Sorry, my fault.<br>
      <br>
      I've missed the "no" and thought you wanted to abandon all
      processing because VRAM is always lost.<br>
      <br>
      Going to review the remaining patches today.<br>
      <br>
      Christian.<br>
      <br>
      Am 04.10.2017 um 11:41 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449346A746E70A7BE88FEA084730-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <meta name="x_Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>
<!--
@font-face
	{font-family:SimSun}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:DengXian}
a:x_link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:x_visited, span.x_MsoHyperlinkFollowed
	{color:#954F72;
	text-decoration:underline}
.x_MsoChpDefault
	{}
@page WordSection1
	{margin:72.0pt 90.0pt 72.0pt 90.0pt}
div.x_WordSection1
	{}
-->
</style>
      <div link="blue" vlink="#954F72" lang="ZH-CN">
        <div class="x_WordSection1">
          <p class="x_MsoNormal"><span lang="EN-US">Why ? the page
              tables are resided in VRAM, no need to recovery if no VRAM
              lost</span><span style="font-size:12.0pt" lang="EN-US"></span></p>
          <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
          <p class="x_MsoNormal"><span lang="EN-US">Sent from <a
                href="https://go.microsoft.com/fwlink/?LinkId=550986"
                moz-do-not-send="true">
                Mail</a> for Windows 10</span></p>
          <p class="x_MsoNormal"><span style="font-size:12.0pt;
              font-family:SimSun" lang="EN-US"> </span></p>
          <div style="border:none; border-top:solid #E1E1E1 1.0pt;
            padding:3.0pt 0cm 0cm 0cm">
            <p class="x_MsoNormal" style="border:none; padding:0cm"><b><span
                  lang="EN-US">From:
                </span></b><span lang="EN-US"><a
                  href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                  moz-do-not-send="true">Christian König</a><br>
                <b>Sent: </b>2017</span>年<span lang="EN-US">10</span>月<span
                lang="EN-US">1</span>日<span lang="EN-US"> 17:36<br>
                <b>To: </b><a href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                  moz-do-not-send="true">Liu, Monk</a>; <a
                  href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                  moz-do-not-send="true">
                  amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject: </b>Re: [PATCH 12/12] drm/amdgpu/sriov:no
                shadow buffer recovery</span></p>
          </div>
          <p class="x_MsoNormal"><span style="font-size:12.0pt;
              font-family:SimSun" lang="EN-US"> </span></p>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">Am 30.09.2017 um 08:03 schrieb Monk
            Liu:<br>
            &gt; 1, we have deadlock unresloved between shadow bo
            recovery<br>
            &gt; and ctx_do_release,<br>
            &gt;<br>
            &gt; 2, for loose mode gpu reset we always assume VRAM not
            lost<br>
            &gt; so there is no need to do that from begining<br>
            &gt;<br>
            &gt; Change-Id: I5259f9d943239bd1fa2e45eb446ef053299fbfb1<br>
            &gt; Signed-off-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <br>
            NAK, even when VRAM ist lost we must restore the page tables
            or <br>
            otherwise no process would be able to proceed.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            &gt; ---<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29
            -----------------------------<br>
            &gt;   1 file changed, 29 deletions(-)<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; index c3f10b5..8ae7a2c 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
            &gt; @@ -2840,9 +2840,7 @@ int amdgpu_sriov_gpu_reset(struct
            amdgpu_device *adev, struct amdgpu_job *job)<br>
            &gt;   {<br>
            &gt;        int i, j, r = 0;<br>
            &gt;        int resched;<br>
            &gt; -     struct amdgpu_bo *bo, *tmp;<br>
            &gt;        struct amdgpu_ring *ring;<br>
            &gt; -     struct dma_fence *fence = NULL, *next = NULL;<br>
            &gt;   <br>
            &gt;        /* other thread is already into the gpu reset so
            just quit and come later */<br>
            &gt;        if
            (!atomic_add_unless(&amp;adev-&gt;in_sriov_reset, 1, 1))<br>
            &gt; @@ -2909,33 +2907,6 @@ int
            amdgpu_sriov_gpu_reset(struct amdgpu_device *adev, struct
            amdgpu_job *job)<br>
            &gt;        /* release full control of GPU after ib test */<br>
            &gt;        amdgpu_virt_release_full_gpu(adev, true);<br>
            &gt;   <br>
            &gt; -     DRM_INFO("recover vram bo from shadow\n");<br>
            &gt; -<br>
            &gt; -     ring = adev-&gt;mman.buffer_funcs_ring;<br>
            &gt; -     mutex_lock(&amp;adev-&gt;shadow_list_lock);<br>
            &gt; -     list_for_each_entry_safe(bo, tmp,
            &amp;adev-&gt;shadow_list, shadow_list) {<br>
            &gt; -             next = NULL;<br>
            &gt; -             amdgpu_recover_vram_from_shadow(adev,
            ring, bo, &amp;next);<br>
            &gt; -             if (fence) {<br>
            &gt; -                     r = dma_fence_wait(fence, false);<br>
            &gt; -                     if (r) {<br>
            &gt; -                             WARN(r, "recovery from
            shadow isn't completed\n");<br>
            &gt; -                             break;<br>
            &gt; -                     }<br>
            &gt; -             }<br>
            &gt; -<br>
            &gt; -             dma_fence_put(fence);<br>
            &gt; -             fence = next;<br>
            &gt; -     }<br>
            &gt; -     mutex_unlock(&amp;adev-&gt;shadow_list_lock);<br>
            &gt; -<br>
            &gt; -     if (fence) {<br>
            &gt; -             r = dma_fence_wait(fence, false);<br>
            &gt; -             if (r)<br>
            &gt; -                     WARN(r, "recovery from shadow
            isn't completed\n");<br>
            &gt; -     }<br>
            &gt; -     dma_fence_put(fence);<br>
            &gt; -<br>
            &gt;        for (i = j; i &lt; j + AMDGPU_MAX_RINGS; ++i) {<br>
            &gt;                ring = adev-&gt;rings[i %
            AMDGPU_MAX_RINGS];<br>
            &gt;                if (!ring || !ring-&gt;sched.thread)<br>
            <br>
            <br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------04B0D2884067CF563F0B039E--

--===============0726371900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0726371900==--
