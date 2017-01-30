From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 4/6] drm/amdgpu: implement PRT for GFX6
Date: Mon, 30 Jan 2017 15:14:27 +0100
Message-ID: <fc54cc73-6b75-59b3-f67a-9a395d749e23@vodafone.de>
References: <1485781060-1910-1-git-send-email-deathsimple@vodafone.de>
 <1485781060-1910-5-git-send-email-deathsimple@vodafone.de>
 <CY4PR12MB1768231152C68AFABF76535AF74B0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0478922604=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768231152C68AFABF76535AF74B0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org" <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>, "airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0478922604==
Content-Type: multipart/alternative;
 boundary="------------F2853642F54F5EC83BF2ABA6"

This is a multi-part message in MIME format.
--------------F2853642F54F5EC83BF2ABA6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> The changes to the GFX6/7/8 look reasonable though only question is 
> you read from mmVM_PRT_CNTL and then write to mmVM_CONTEXT1_CNTL .  Is 
> that expected?
Not at all! Looks like a copy&paste error while modifying the original 
patch. Thanks for catching this.

Also the whole set is so far only compile tested, still need to give it 
a run on all hardware generations anyway.

Christian.

Am 30.01.2017 um 14:59 schrieb StDenis, Tom:
>
> Minor nit: the comment says v8 😊
>
>
> The changes to the GFX6/7/8 look reasonable though only question is 
> you read from mmVM_PRT_CNTL and then write to mmVM_CONTEXT1_CNTL .  Is 
> that expected?
>
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Monday, January 30, 2017 07:57
> *To:* bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org; airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* [PATCH 4/6] drm/amdgpu: implement PRT for GFX6
> From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> Enable/disable the handling globally for now and
> print a warning when we enable it for the first time.
>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 63 
> +++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index e2b0b16..c23503e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -398,6 +398,68 @@ static void 
> gmc_v6_0_set_fault_enable_default(struct amdgpu_device *adev,
>          WREG32(mmVM_CONTEXT1_CNTL, tmp);
>  }
>
> + /**
> +   + * gmc_v8_0_set_prt - set PRT VM fault
> +   + *
> +   + * @adev: amdgpu_device pointer
> +   + * @enable: enable/disable VM fault handling for PRT
> +   +*/
> +static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)
> +{
> +       u32 tmp;
> +
> +       if (enable && !adev->mc.prt_warning) {
> +               dev_warn(adev->dev, "Disabling VM faults because of 
> PRT request!\n");
> +               adev->mc.prt_warning = true;
> +       }
> +
> +       tmp = RREG32(mmVM_PRT_CNTL);
> +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,
> + CB_DISABLE_READ_FAULT_ON_UNMAPPED_ACCESS,
> +                           enable);
> +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,
> + CB_DISABLE_WRITE_FAULT_ON_UNMAPPED_ACCESS,
> +                           enable);
> +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,
> + TC_DISABLE_READ_FAULT_ON_UNMAPPED_ACCESS,
> +                           enable);
> +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,
> + TC_DISABLE_WRITE_FAULT_ON_UNMAPPED_ACCESS,
> +                           enable);
> +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,
> + L2_CACHE_STORE_INVALID_ENTRIES,
> +                           enable);
> +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,
> + L1_TLB_STORE_INVALID_ENTRIES,
> +                           enable);
> +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,
> +                           MASK_PDE0_FAULT, enable);
> +       WREG32(mmVM_CONTEXT1_CNTL, tmp);
> +
> +       if (enable) {
> +               uint32_t low = AMDGPU_VA_RESERVED_SIZE >> 
> AMDGPU_GPU_PAGE_SHIFT;
> +               uint32_t high = adev->vm_manager.max_pfn;
> +
> +               WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, low);
> +               WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, low);
> +               WREG32(mmVM_PRT_APERTURE2_LOW_ADDR, low);
> +               WREG32(mmVM_PRT_APERTURE3_LOW_ADDR, low);
> +               WREG32(mmVM_PRT_APERTURE0_HIGH_ADDR, high);
> +               WREG32(mmVM_PRT_APERTURE1_HIGH_ADDR, high);
> +               WREG32(mmVM_PRT_APERTURE2_HIGH_ADDR, high);
> +               WREG32(mmVM_PRT_APERTURE3_HIGH_ADDR, high);
> +       } else {
> +               WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, 0xfffffff);
> +               WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, 0xfffffff);
> +               WREG32(mmVM_PRT_APERTURE2_LOW_ADDR, 0xfffffff);
> +               WREG32(mmVM_PRT_APERTURE3_LOW_ADDR, 0xfffffff);
> +               WREG32(mmVM_PRT_APERTURE0_HIGH_ADDR, 0x0);
> +               WREG32(mmVM_PRT_APERTURE1_HIGH_ADDR, 0x0);
> +               WREG32(mmVM_PRT_APERTURE2_HIGH_ADDR, 0x0);
> +               WREG32(mmVM_PRT_APERTURE3_HIGH_ADDR, 0x0);
> +       }
> +}
> +
>  static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
>  {
>          int r, i;
> @@ -1080,6 +1142,7 @@ static const struct amd_ip_funcs 
> gmc_v6_0_ip_funcs = {
>  static const struct amdgpu_gart_funcs gmc_v6_0_gart_funcs = {
>          .flush_gpu_tlb = gmc_v6_0_gart_flush_gpu_tlb,
>          .set_pte_pde = gmc_v6_0_gart_set_pte_pde,
> +       .set_prt = gmc_v6_0_set_prt,
>  };
>
>  static const struct amdgpu_irq_src_funcs gmc_v6_0_irq_funcs = {
> -- 
> 2.5.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - lists.freedesktop.org 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx 
> Archives. Using amd-gfx: To post a message to all the list members, 
> send email ...
>
>
>


--------------F2853642F54F5EC83BF2ABA6
Content-Type: multipart/related;
 boundary="------------6364D390E2AB30AF3463D982"


--------------6364D390E2AB30AF3463D982
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">The changes to the GFX6/7/8 look
        reasonable though only question is you read from
        <span style="font-family: Calibri, Arial, Helvetica, sans-serif,
          &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;,
          NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android
          Emoji&quot;, EmojiSymbols; font-size: 13.3333px;">
          mmVM_PRT_CNTL</span> and then write to <span
          style="font-family: Calibri, Arial, Helvetica, sans-serif,
          &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;,
          NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android
          Emoji&quot;, EmojiSymbols; font-size: 13.3333px;">
          mmVM_CONTEXT1_CNTL</span> .  Is that expected?</blockquote>
      Not at all! Looks like a copy&amp;paste error while modifying the
      original patch. Thanks for catching this.<br>
      <br>
      Also the whole set is so far only compile tested, still need to
      give it a run on all hardware generations anyway.<br>
      <br>
      Christian.<br>
      <br>
      Am 30.01.2017 um 14:59 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB1768231152C68AFABF76535AF74B0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p>Minor nit: the comment says v8 <img class="EmojiInsert"
            id="OWAEmoji249760" alt="😊" style="vertical-align: bottom;"
            src="cid:part1.A7DC9569.EFDA65F4-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"></p>
        <p><br>
        </p>
        <p>The changes to the GFX6/7/8 look reasonable though only
          question is you read from
          <span style="font-family: Calibri, Arial, Helvetica,
            sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            13.3333px;">
            mmVM_PRT_CNTL</span> and then write to <span
            style="font-family: Calibri, Arial, Helvetica, sans-serif,
            &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;,
            NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android
            Emoji&quot;, EmojiSymbols; font-size: 13.3333px;">
            mmVM_CONTEXT1_CNTL</span> .  Is that expected?</p>
        <p><br>
        </p>
        <p>Tom</p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>From:</b> amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf
                of Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Monday, January 30, 2017 07:57<br>
                <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org">bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br>
                <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> [PATCH 4/6] drm/amdgpu: implement PRT
                for GFX6</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">From: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <br>
                Enable/disable the handling globally for now and<br>
                print a warning when we enable it for the first time.<br>
                <br>
                Signed-off-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                ---<br>
                 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 63
                +++++++++++++++++++++++++++++++++++<br>
                 1 file changed, 63 insertions(+)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
                b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
                index e2b0b16..c23503e 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
                @@ -398,6 +398,68 @@ static void
                gmc_v6_0_set_fault_enable_default(struct amdgpu_device
                *adev,<br>
                         WREG32(mmVM_CONTEXT1_CNTL, tmp);<br>
                 }<br>
                 <br>
                + /**<br>
                +   + * gmc_v8_0_set_prt - set PRT VM fault<br>
                +   + *<br>
                +   + * @adev: amdgpu_device pointer<br>
                +   + * @enable: enable/disable VM fault handling for
                PRT<br>
                +   +*/<br>
                +static void gmc_v6_0_set_prt(struct amdgpu_device
                *adev, bool enable)<br>
                +{<br>
                +       u32 tmp;<br>
                +<br>
                +       if (enable &amp;&amp; !adev-&gt;mc.prt_warning)
                {<br>
                +               dev_warn(adev-&gt;dev, "Disabling VM
                faults because of PRT request!\n");<br>
                +               adev-&gt;mc.prt_warning = true;<br>
                +       }<br>
                +<br>
                +       tmp = RREG32(mmVM_PRT_CNTL);<br>
                +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,<br>
                +                          
                CB_DISABLE_READ_FAULT_ON_UNMAPPED_ACCESS,<br>
                +                           enable);<br>
                +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,<br>
                +                          
                CB_DISABLE_WRITE_FAULT_ON_UNMAPPED_ACCESS,<br>
                +                           enable);<br>
                +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,<br>
                +                          
                TC_DISABLE_READ_FAULT_ON_UNMAPPED_ACCESS,<br>
                +                           enable);<br>
                +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,<br>
                +                          
                TC_DISABLE_WRITE_FAULT_ON_UNMAPPED_ACCESS,<br>
                +                           enable);<br>
                +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,<br>
                +                          
                L2_CACHE_STORE_INVALID_ENTRIES,<br>
                +                           enable);<br>
                +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,<br>
                +                          
                L1_TLB_STORE_INVALID_ENTRIES,<br>
                +                           enable);<br>
                +       tmp = REG_SET_FIELD(tmp, VM_PRT_CNTL,<br>
                +                           MASK_PDE0_FAULT, enable);<br>
                +       WREG32(mmVM_CONTEXT1_CNTL, tmp);<br>
                +<br>
                +       if (enable) {<br>
                +               uint32_t low = AMDGPU_VA_RESERVED_SIZE
                &gt;&gt; AMDGPU_GPU_PAGE_SHIFT;<br>
                +               uint32_t high =
                adev-&gt;vm_manager.max_pfn;<br>
                +<br>
                +               WREG32(mmVM_PRT_APERTURE0_LOW_ADDR,
                low);<br>
                +               WREG32(mmVM_PRT_APERTURE1_LOW_ADDR,
                low);<br>
                +               WREG32(mmVM_PRT_APERTURE2_LOW_ADDR,
                low);<br>
                +               WREG32(mmVM_PRT_APERTURE3_LOW_ADDR,
                low);<br>
                +               WREG32(mmVM_PRT_APERTURE0_HIGH_ADDR,
                high);<br>
                +               WREG32(mmVM_PRT_APERTURE1_HIGH_ADDR,
                high);<br>
                +               WREG32(mmVM_PRT_APERTURE2_HIGH_ADDR,
                high);<br>
                +               WREG32(mmVM_PRT_APERTURE3_HIGH_ADDR,
                high);<br>
                +       } else {<br>
                +               WREG32(mmVM_PRT_APERTURE0_LOW_ADDR,
                0xfffffff);<br>
                +               WREG32(mmVM_PRT_APERTURE1_LOW_ADDR,
                0xfffffff);<br>
                +               WREG32(mmVM_PRT_APERTURE2_LOW_ADDR,
                0xfffffff);<br>
                +               WREG32(mmVM_PRT_APERTURE3_LOW_ADDR,
                0xfffffff);<br>
                +               WREG32(mmVM_PRT_APERTURE0_HIGH_ADDR,
                0x0);<br>
                +               WREG32(mmVM_PRT_APERTURE1_HIGH_ADDR,
                0x0);<br>
                +               WREG32(mmVM_PRT_APERTURE2_HIGH_ADDR,
                0x0);<br>
                +               WREG32(mmVM_PRT_APERTURE3_HIGH_ADDR,
                0x0);<br>
                +       }<br>
                +}<br>
                +<br>
                 static int gmc_v6_0_gart_enable(struct amdgpu_device
                *adev)<br>
                 {<br>
                         int r, i;<br>
                @@ -1080,6 +1142,7 @@ static const struct amd_ip_funcs
                gmc_v6_0_ip_funcs = {<br>
                 static const struct amdgpu_gart_funcs
                gmc_v6_0_gart_funcs = {<br>
                         .flush_gpu_tlb = gmc_v6_0_gart_flush_gpu_tlb,<br>
                         .set_pte_pde = gmc_v6_0_gart_set_pte_pde,<br>
                +       .set_prt = gmc_v6_0_set_prt,<br>
                 };<br>
                 <br>
                 static const struct amdgpu_irq_src_funcs
                gmc_v6_0_irq_funcs = {<br>
                -- <br>
                2.5.0<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  id="LPlnk685925" previewremoved="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                <div id="LPBorder_GT_14857846636950.18213166157152716"
                  style="margin-bottom: 20px; overflow: auto; width:
                  100%; text-indent: 0px;">
                  <table
                    id="LPContainer_14857846636930.6345001279342901"
                    style="width: 90%; background-color: rgb(255, 255,
                    255); position: relative; overflow: auto;
                    padding-top: 20px; padding-bottom: 20px; margin-top:
                    20px; border-top: 1px dotted rgb(200, 200, 200);
                    border-bottom: 1px dotted rgb(200, 200, 200);"
                    cellspacing="0">
                    <tbody>
                      <tr style="border-spacing: 0px;" valign="top">
                        <td
                          id="TextCell_14857846636940.48014062491777976"
                          colspan="2" style="vertical-align: top;
                          position: relative; padding: 0px; display:
                          table-cell;">
                          <div
                            id="LPTitle_14857846636940.9893355573948246"
                            style="top: 0px; color: rgb(59, 87, 119);
                            font-weight: normal; font-size: 21px;
                            font-family: wf_segoe-ui_light, &quot;Segoe
                            UI Light&quot;, &quot;Segoe WP Light&quot;,
                            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
                            Tahoma, Arial, sans-serif; line-height:
                            21px;">
                            <a moz-do-not-send="true"
                              id="LPUrlAnchor_14857846636950.10171241072401171"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                              target="_blank" style="text-decoration:
                              none;">amd-gfx Info Page -
                              lists.freedesktop.org</a></div>
                          <div
                            id="LPMetadata_14857846636950.8672987540780379"
                            style="margin: 10px 0px 16px; color:
                            rgb(102, 102, 102); font-weight: normal;
                            font-family: wf_segoe-ui_normal, &quot;Segoe
                            UI&quot;, &quot;Segoe WP&quot;, Tahoma,
                            Arial, sans-serif; font-size: 14px;
                            line-height: 14px;">
                            lists.freedesktop.org</div>
                          <div
                            id="LPDescription_14857846636950.14446370601966319"
                            style="display: block; color: rgb(102, 102,
                            102); font-weight: normal; font-family:
                            wf_segoe-ui_normal, &quot;Segoe UI&quot;,
                            &quot;Segoe WP&quot;, Tahoma, Arial,
                            sans-serif; font-size: 14px; line-height:
                            20px; max-height: 100px; overflow: hidden;">
                            To see the collection of prior postings to
                            the list, visit the amd-gfx Archives. Using
                            amd-gfx: To post a message to all the list
                            members, send email ...</div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
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

--------------6364D390E2AB30AF3463D982
Content-Type: image/png
Content-Transfer-Encoding: base64
Content-ID: <part1.A7DC9569.EFDA65F4-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAGXRFWHRTb2Z0d2FyZQBBZG9i
ZSBJbWFnZVJlYWR5ccllPAAAAYpJREFUeNpi/P//PwO1ACM2wf9njBWAVD4QBwCxApLUAyDe
AMQTGU3OPkDRA3QUIxaD+oFUAREOaQQa2IDTMKBB84FUAgk+WwA0MBFmGBOaixJIDKYEoD64
65igBjkge+3CrW94TUCTr4eGMdxl8TCZxMYHDIZR1xk2HPiA1SCQOEgepA4J5CMbFgAPhM1v
wfTFW9+xGgYTh6lD1s8IdKIAkH4PEz1w9jOYVpBiZ1CQZMMw7MHzXwwPnv0Esx2MeRESxmcY
WYCUAbJiFAVYAMgCbJbAvPmAWjmACZqS4aHdOOs5wdgEBcWE5a8Y0HIGPAIOwETtjXkYJqIq
xAAgeQM1ThTzkQ2biB5mC7a8xZ7kgeICvMzoYTsRJaMDY3U9chIBpaMHz34xxPsKgwMcFIsL
gckB5KL+YllkgyYAg6oQJW9Ck8h+5NgFhd3GAx/humAGI2cGIHYEGvYBW0YHGTgf2YX4MjkQ
F4IMwlkEIeXVfByGwsqzAwTLMywGg7wNcvED9AIR3TCAAAMAqh+p+YMVeBQAAAAASUVORK5C
YII=
--------------6364D390E2AB30AF3463D982--

--------------F2853642F54F5EC83BF2ABA6--

--===============0478922604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0478922604==--
