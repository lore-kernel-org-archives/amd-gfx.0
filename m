From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/8] drm/amdgpu: reserve vram for memory training
Date: Wed, 9 Oct 2019 13:40:33 +0200
Message-ID: <045b7cfd-989f-7cff-310f-92d9780e73fe@gmail.com>
References: <20191008192934.5481-1-alexander.deucher@amd.com>
 <20191008192934.5481-8-alexander.deucher@amd.com>
 <a9d04519-0ec0-41f6-289f-be156caccf76@amd.com>
 <SN1PR12MB2544F1BE7D37DEC4721AF95D95950@SN1PR12MB2544.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1693187088=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN1PR12MB2544F1BE7D37DEC4721AF95D95950-z7L1TMIYDg7bG+2ccTdVRgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>, "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1693187088==
Content-Type: multipart/alternative;
 boundary="------------4B0E7261945FCFA47FAA3ADA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4B0E7261945FCFA47FAA3ADA
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.10.19 um 13:12 schrieb Yin, Tianci (Rico):
> Here is where you definitively set "ret" so DO NOT preinitialize it to 0,
> just to avoid "pesky compiler unininitialized variable warnings"--those
> are helpful to make the code more secure: a variable should be 
> intentionally
> initialized in all paths.
>
> Rico: Still in confusion, pre-initialization can avoid "uninitialized 
> variable", why should we can't pre-initialize?

Because it avoids the uninitialized variable warning :)

See we really want the warning because it means that we have a bug in 
the code somewhere.

Regards,
Christian.

> ------------------------------------------------------------------------
> *From:* Tuikov, Luben <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Wednesday, October 9, 2019 11:44
> *To:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Yin, Tianci 
> (Rico) <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
> *Subject:* Re: [PATCH 7/8] drm/amdgpu: reserve vram for memory training
> On 2019-10-08 3:29 p.m., Alex Deucher wrote:
> > From: "Tianci.Yin" <tianci.yin-5C7GfCeVMHo@public.gmane.org>
> >
> > memory training using specific fixed vram segment, reserve these
> > segments before anyone may allocate it.
> >
> > Change-Id: I1436755813a565608a2857a683f535377620a637
> > Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> > Signed-off-by: Tianci.Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 96 +++++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 74a9bd94f10c..0819721af16e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1667,6 +1667,93 @@ static int 
> amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
> > &adev->fw_vram_usage.va);
> >  }
> >
> > +/*
> > + * Memoy training reservation functions
> > + */
>
> Include an empty line between the two comments, just as you would
> a paragraph in written text.
>
> > +/**
> > + * amdgpu_ttm_training_reserve_vram_fini - free memory training 
> reserved vram
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * free memory training reserved vram if it has been reserved.
> > + */
> > +static int amdgpu_ttm_training_reserve_vram_fini(struct 
> amdgpu_device *adev)
> > +{
> > +     int ret = 0;
> > +     struct psp_memory_training_context *ctx = 
> &adev->psp.mem_train_ctx;
> > +
> > +     ctx->init = PSP_MEM_TRAIN_NOT_SUPPORT;
> > +     if(ctx->c2p_bo) {
>
> Space after keywords, according to LKCS:
> if (...)
>
> > + amdgpu_bo_free_kernel(&ctx->c2p_bo, NULL, NULL);
> > +             ctx->c2p_bo = NULL;
> > +     }
> > +     if(ctx->p2c_bo) {
>
> Space after keywords, according to LKCS:
> if (...)
>
> > + amdgpu_bo_free_kernel(&ctx->p2c_bo, NULL, NULL);
> > +             ctx->p2c_bo = NULL;
> > +     }
> > +
> > +     return ret;
> > +}
>
> Get rid of "ret" variable altogether as it is not used in this function.
>
> > +
> > +/**
> > + * amdgpu_ttm_training_reserve_vram_init - create bo vram 
> reservation from memory training
> > + *
> > + * @adev: amdgpu_device pointer
> > + *
> > + * create bo vram reservation from memory training.
> > + */
> > +static int amdgpu_ttm_training_reserve_vram_init(struct 
> amdgpu_device *adev)
> > +{
> > +     int ret = 0;
>
> DO NOT preinitialize ret.
>
> > +     struct psp_memory_training_context *ctx = 
> &adev->psp.mem_train_ctx;
> > +
> > +     memset(ctx, 0, sizeof(*ctx));
> > +     if(!adev->fw_vram_usage.mem_train_support) {
>
> Space after keywords: "if (".
>
> > +             DRM_DEBUG("memory training does not support!\n");
> > +             return 0;
> > +     }
> > +
> > +     ctx->c2p_train_data_offset = adev->fw_vram_usage.mem_train_fb_loc;
> > +     ctx->p2c_train_data_offset = (adev->gmc.mc_vram_size - 
> GDDR6_MEM_TRAINING_OFFSET);
> > +     ctx->train_data_size = GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
> > +
> > + 
> DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
> > +               ctx->train_data_size,
> > +               ctx->p2c_train_data_offset,
> > +               ctx->c2p_train_data_offset);
> > +
> > +     ret = amdgpu_bo_create_kernel_at(adev,
>
> Here is where you definitively set "ret" so DO NOT preinitialize it to 0,
> just to avoid "pesky compiler unininitialized variable warnings"--those
> are helpful to make the code more secure: a variable should be 
> intentionally
> initialized in all paths.
>
> > + ctx->p2c_train_data_offset,
> > + ctx->train_data_size,
> > + AMDGPU_GEM_DOMAIN_VRAM,
> > + &ctx->p2c_bo,
> > +                                      NULL);
> > +     if(ret) {
>
> Space after keywords "if (".
>
> > +             DRM_ERROR("alloc p2c_bo failed(%d)!\n", ret);
> > +             ret = -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     ret = amdgpu_bo_create_kernel_at(adev,
> > + ctx->c2p_train_data_offset,
> > + ctx->train_data_size,
> > + AMDGPU_GEM_DOMAIN_VRAM,
> > + &ctx->c2p_bo,
> > +                                      NULL);
> > +     if(ret) {
>
> Space after keywords: "if (", according to LKCS.
>
> Regards,
> Luben
>
> > +             DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
> > +             ret = -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
> > +     return 0;
> > +
> > +err_out:
> > +     amdgpu_ttm_training_reserve_vram_fini(adev);
> > +     return ret;
> > +}
> > +
> >  /**
> >   * amdgpu_ttm_init - Init the memory management (ttm) as well as 
> various
> >   * gtt/vram related fields.
> > @@ -1740,6 +1827,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >                return r;
> >        }
> >
> > +     /*
> > +      *The reserved vram for memory training must be pinned to the 
> specified
> > +      *place on the VRAM, so reserve it early.
> > +      */
> > +     r = amdgpu_ttm_training_reserve_vram_init(adev);
> > +     if (r)
> > +             return r;
> > +
> >        /* allocate memory as required for VGA
> >         * This is used for VGA emulation and pre-OS scanout buffers to
> >         * avoid display artifacts while transitioning between pre-OS
> > @@ -1825,6 +1920,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
> >                return;
> >
> >        amdgpu_ttm_debugfs_fini(adev);
> > +     amdgpu_ttm_training_reserve_vram_fini(adev);
> >        amdgpu_ttm_fw_reserve_vram_fini(adev);
> >        if (adev->mman.aper_base_kaddr)
> > iounmap(adev->mman.aper_base_kaddr);
> >
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------4B0E7261945FCFA47FAA3ADA
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 09.10.19 um 13:12 schrieb Yin,
      Tianci (Rico):<br>
    </div>
    <blockquote type="cite"
cite="mid:SN1PR12MB2544F1BE7D37DEC4721AF95D95950-z7L1TMIYDg7bG+2ccTdVRgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <font size="2"><span style="font-size:11pt">Here is where you
            definitively set "ret" so DO NOT preinitialize it to 0,<br>
          </span></font></div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <font size="2"><span style="font-size:11pt">just to avoid "pesky
            compiler unininitialized variable warnings"--those<br>
            are helpful to make the code more secure: a variable should
            be intentionally<br>
            initialized in all paths.</span></font></div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        <span style="color: rgb(12, 100, 192);">Rico: Still in
          confusion, pre-initialization can avoid "uninitialized
          variable", why should we can't pre-initialize?
        </span><br>
      </div>
    </blockquote>
    <br>
    Because it avoids the uninitialized variable warning :)<br>
    <br>
    See we really want the warning because it means that we have a bug
    in the code somewhere.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:SN1PR12MB2544F1BE7D37DEC4721AF95D95950-z7L1TMIYDg7bG+2ccTdVRgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Tuikov, Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov-5C7GfCeVMHo@public.gmane.org">&lt;Luben.Tuikov-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Wednesday, October 9, 2019 11:44<br>
          <b>To:</b> Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
          <b>Cc:</b> Deucher, Alexander
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>; Yin, Tianci (Rico)
          <a class="moz-txt-link-rfc2396E" href="mailto:Tianci.Yin-5C7GfCeVMHo@public.gmane.org">&lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Subject:</b> Re: [PATCH 7/8] drm/amdgpu: reserve vram for
          memory training</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">On 2019-10-08 3:29 p.m., Alex Deucher
              wrote:<br>
              &gt; From: "Tianci.Yin" <a class="moz-txt-link-rfc2396E" href="mailto:tianci.yin-5C7GfCeVMHo@public.gmane.org">&lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; <br>
              &gt; memory training using specific fixed vram segment,
              reserve these<br>
              &gt; segments before anyone may allocate it.<br>
              &gt; <br>
              &gt; Change-Id: I1436755813a565608a2857a683f535377620a637<br>
              &gt; Reviewed-by: Alex Deucher
              <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; Signed-off-by: Tianci.Yin <a class="moz-txt-link-rfc2396E" href="mailto:tianci.yin-5C7GfCeVMHo@public.gmane.org">&lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              &gt; ---<br>
              &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 96
              +++++++++++++++++++++++++<br>
              &gt;  1 file changed, 96 insertions(+)<br>
              &gt; <br>
              &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
              &gt; index 74a9bd94f10c..0819721af16e 100644<br>
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
              &gt; @@ -1667,6 +1667,93 @@ static int
              amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device
              *adev)<br>
              &gt;                                         
              &amp;adev-&gt;fw_vram_usage.va);<br>
              &gt;  }<br>
              &gt;  <br>
              &gt; +/*<br>
              &gt; + * Memoy training reservation functions<br>
              &gt; + */<br>
              <br>
              Include an empty line between the two comments, just as
              you would<br>
              a paragraph in written text.<br>
              <br>
              &gt; +/**<br>
              &gt; + * amdgpu_ttm_training_reserve_vram_fini - free
              memory training reserved vram<br>
              &gt; + *<br>
              &gt; + * @adev: amdgpu_device pointer<br>
              &gt; + *<br>
              &gt; + * free memory training reserved vram if it has been
              reserved.<br>
              &gt; + */<br>
              &gt; +static int
              amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device
              *adev)<br>
              &gt; +{<br>
              &gt; +     int ret = 0;<br>
              &gt; +     struct psp_memory_training_context *ctx =
              &amp;adev-&gt;psp.mem_train_ctx;<br>
              &gt; +<br>
              &gt; +     ctx-&gt;init = PSP_MEM_TRAIN_NOT_SUPPORT;<br>
              &gt; +     if(ctx-&gt;c2p_bo) {<br>
              <br>
              Space after keywords, according to LKCS:<br>
              if (...)<br>
              <br>
              &gt; +            
              amdgpu_bo_free_kernel(&amp;ctx-&gt;c2p_bo, NULL, NULL);<br>
              &gt; +             ctx-&gt;c2p_bo = NULL;<br>
              &gt; +     }<br>
              &gt; +     if(ctx-&gt;p2c_bo) {<br>
              <br>
              Space after keywords, according to LKCS:<br>
              if (...)<br>
              <br>
              &gt; +            
              amdgpu_bo_free_kernel(&amp;ctx-&gt;p2c_bo, NULL, NULL);<br>
              &gt; +             ctx-&gt;p2c_bo = NULL;<br>
              &gt; +     }<br>
              &gt; +<br>
              &gt; +     return ret;<br>
              &gt; +}<br>
              <br>
              Get rid of "ret" variable altogether as it is not used in
              this function.<br>
              <br>
              &gt; +<br>
              &gt; +/**<br>
              &gt; + * amdgpu_ttm_training_reserve_vram_init - create bo
              vram reservation from memory training<br>
              &gt; + *<br>
              &gt; + * @adev: amdgpu_device pointer<br>
              &gt; + *<br>
              &gt; + * create bo vram reservation from memory training.<br>
              &gt; + */<br>
              &gt; +static int
              amdgpu_ttm_training_reserve_vram_init(struct amdgpu_device
              *adev)<br>
              &gt; +{<br>
              &gt; +     int ret = 0;<br>
              <br>
              DO NOT preinitialize ret.<br>
              <br>
              &gt; +     struct psp_memory_training_context *ctx =
              &amp;adev-&gt;psp.mem_train_ctx;<br>
              &gt; +<br>
              &gt; +     memset(ctx, 0, sizeof(*ctx));<br>
              &gt; +     if(!adev-&gt;fw_vram_usage.mem_train_support) {<br>
              <br>
              Space after keywords: "if (".<br>
              <br>
              &gt; +             DRM_DEBUG("memory training does not
              support!\n");<br>
              &gt; +             return 0;<br>
              &gt; +     }<br>
              &gt; +<br>
              &gt; +     ctx-&gt;c2p_train_data_offset =
              adev-&gt;fw_vram_usage.mem_train_fb_loc;<br>
              &gt; +     ctx-&gt;p2c_train_data_offset =
              (adev-&gt;gmc.mc_vram_size - GDDR6_MEM_TRAINING_OFFSET);<br>
              &gt; +     ctx-&gt;train_data_size =
              GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;<br>
              &gt; +<br>
              &gt; +    
DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",<br>
              &gt; +               ctx-&gt;train_data_size,<br>
              &gt; +               ctx-&gt;p2c_train_data_offset,<br>
              &gt; +               ctx-&gt;c2p_train_data_offset);<br>
              &gt; +<br>
              &gt; +     ret = amdgpu_bo_create_kernel_at(adev,<br>
              <br>
              Here is where you definitively set "ret" so DO NOT
              preinitialize it to 0,<br>
              just to avoid "pesky compiler unininitialized variable
              warnings"--those<br>
              are helpful to make the code more secure: a variable
              should be intentionally<br>
              initialized in all paths.<br>
              <br>
              &gt; +                                     
              ctx-&gt;p2c_train_data_offset,<br>
              &gt; +                                     
              ctx-&gt;train_data_size,<br>
              &gt; +                                     
              AMDGPU_GEM_DOMAIN_VRAM,<br>
              &gt; +                                     
              &amp;ctx-&gt;p2c_bo,<br>
              &gt; +                                      NULL);<br>
              &gt; +     if(ret) {<br>
              <br>
              Space after keywords "if (".<br>
              <br>
              &gt; +             DRM_ERROR("alloc p2c_bo failed(%d)!\n",
              ret);<br>
              &gt; +             ret = -ENOMEM;<br>
              &gt; +             goto err_out;<br>
              &gt; +     }<br>
              &gt; +<br>
              &gt; +     ret = amdgpu_bo_create_kernel_at(adev,<br>
              &gt; +                                     
              ctx-&gt;c2p_train_data_offset,<br>
              &gt; +                                     
              ctx-&gt;train_data_size,<br>
              &gt; +                                     
              AMDGPU_GEM_DOMAIN_VRAM,<br>
              &gt; +                                     
              &amp;ctx-&gt;c2p_bo,<br>
              &gt; +                                      NULL);<br>
              &gt; +     if(ret) {<br>
              <br>
              Space after keywords: "if (", according to LKCS.<br>
              <br>
              Regards,<br>
              Luben<br>
              <br>
              &gt; +             DRM_ERROR("alloc c2p_bo failed(%d)!\n",
              ret);<br>
              &gt; +             ret = -ENOMEM;<br>
              &gt; +             goto err_out;<br>
              &gt; +     }<br>
              &gt; +<br>
              &gt; +     ctx-&gt;init = PSP_MEM_TRAIN_RESERVE_SUCCESS;<br>
              &gt; +     return 0;<br>
              &gt; +<br>
              &gt; +err_out:<br>
              &gt; +     amdgpu_ttm_training_reserve_vram_fini(adev);<br>
              &gt; +     return ret;<br>
              &gt; +}<br>
              &gt; +<br>
              &gt;  /**<br>
              &gt;   * amdgpu_ttm_init - Init the memory management
              (ttm) as well as various<br>
              &gt;   * gtt/vram related fields.<br>
              &gt; @@ -1740,6 +1827,14 @@ int amdgpu_ttm_init(struct
              amdgpu_device *adev)<br>
              &gt;                return r;<br>
              &gt;        }<br>
              &gt;  <br>
              &gt; +     /*<br>
              &gt; +      *The reserved vram for memory training must be
              pinned to the specified<br>
              &gt; +      *place on the VRAM, so reserve it early.<br>
              &gt; +      */<br>
              &gt; +     r =
              amdgpu_ttm_training_reserve_vram_init(adev);<br>
              &gt; +     if (r)<br>
              &gt; +             return r;<br>
              &gt; +<br>
              &gt;        /* allocate memory as required for VGA<br>
              &gt;         * This is used for VGA emulation and pre-OS
              scanout buffers to<br>
              &gt;         * avoid display artifacts while transitioning
              between pre-OS<br>
              &gt; @@ -1825,6 +1920,7 @@ void amdgpu_ttm_fini(struct
              amdgpu_device *adev)<br>
              &gt;                return;<br>
              &gt;  <br>
              &gt;        amdgpu_ttm_debugfs_fini(adev);<br>
              &gt; +     amdgpu_ttm_training_reserve_vram_fini(adev);<br>
              &gt;        amdgpu_ttm_fw_reserve_vram_fini(adev);<br>
              &gt;        if (adev-&gt;mman.aper_base_kaddr)<br>
              &gt;               
              iounmap(adev-&gt;mman.aper_base_kaddr);<br>
              &gt; <br>
              <br>
            </div>
          </span></font></div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------4B0E7261945FCFA47FAA3ADA--

--===============1693187088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1693187088==--
