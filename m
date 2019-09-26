From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma'
 workaround for navi
Date: Thu, 26 Sep 2019 14:29:26 +0200
Message-ID: <608f4e8a-ef35-6fbc-cda6-51c3803af014@gmail.com>
References: <20190926080746.20765-1-xiaojie.yuan@amd.com>
 <BN8PR12MB36027CA5662543E7F956657589860@BN8PR12MB3602.namprd12.prod.outlook.com>
 <BN6PR12MB1809591CB4102B70BEC82E93F7860@BN6PR12MB1809.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1169247151=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809591CB4102B70BEC82E93F7860-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is a multi-part message in MIME format.
--===============1169247151==
Content-Type: multipart/alternative;
 boundary="------------F7EF14EA4E76D9D44665EAA8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F7EF14EA4E76D9D44665EAA8
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Stop, wait a second guys!

This will disable the workaround for Navi10 and that is certainly not 
correct:
> !(adev->asic_type >= CHIP_NAVI10 && adev->asic_type <= CHIP_NAVI12)

Christian.


Am 26.09.19 um 14:26 schrieb Deucher, Alexander:
> Please add a patch description.  With that fixed:
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Thursday, September 26, 2019 4:09 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Cc:* alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Subject:* Re: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from 
> sdma' workaround for navi
> Hi Alex,
>
> This patch is to add the asic_type check which is missing after 
> drm-next branch rebase.
>
> BR,
> Xiaojie
> ------------------------------------------------------------------------
> *From:* Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Thursday, September 26, 2019 4:08 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Cc:* alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Yuan, Xiaojie 
> <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
> *Subject:* [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from 
> sdma' workaround for navi
> Fixes: 767acabdac81 ("drm/amd/powerplay: add baco smu reset function 
> for smu11")
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index cb3f61873baa..dc2e68e019eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -292,6 +292,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct 
> amdgpu_device *adev, uint32_t vmid,
>
>          if (!adev->mman.buffer_funcs_enabled ||
>              !adev->ib_pool_ready ||
> +           !(adev->asic_type >= CHIP_NAVI10 && adev->asic_type <= 
> CHIP_NAVI12) ||
>              adev->in_gpu_reset) {
>                  gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
> mutex_unlock(&adev->mman.gtt_window_lock);
> -- 
> 2.20.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------F7EF14EA4E76D9D44665EAA8
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Stop, wait a second guys!<br>
      <br>
      This will disable the workaround for Navi10 and that is certainly
      not correct:<br>
      <blockquote type="cite"><font size="2"><span
            style="font-size:11pt">
            !(adev-&gt;asic_type &gt;= CHIP_NAVI10 &amp;&amp;
            adev-&gt;asic_type &lt;= CHIP_NAVI12)</span></font></blockquote>
      <br>
      Christian.<br>
      <br>
      <br>
      Am 26.09.19 um 14:26 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1809591CB4102B70BEC82E93F7860-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Please add a patch description.  With that fixed:<br>
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Yuan, Xiaojie <a class="moz-txt-link-rfc2396E" href="mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">&lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Thursday, September 26, 2019 4:09 AM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
          <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
          <b>Subject:</b> Re: [PATCH] drm/amdgpu/gmc10: apply the
          'invalidation from sdma' workaround for navi</font>
        <div> </div>
      </div>
      <style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
      <div dir="ltr">
        <div style="font-family:Calibri,Helvetica,sans-serif;
          font-size:11pt; color:rgb(0,0,0)">
          Hi Alex,</div>
        <div style="font-family:Calibri,Helvetica,sans-serif;
          font-size:11pt; color:rgb(0,0,0)">
          <br>
        </div>
        <div style="font-family:Calibri,Helvetica,sans-serif;
          font-size:11pt; color:rgb(0,0,0)">
          This patch is to add the asic_type check which is missing
          after drm-next branch rebase.</div>
        <div style="font-family:Calibri,Helvetica,sans-serif;
          font-size:11pt; color:rgb(0,0,0)">
          <br>
        </div>
        <div style="font-family:Calibri,Helvetica,sans-serif;
          font-size:11pt; color:rgb(0,0,0)">
          BR,</div>
        <div style="font-family:Calibri,Helvetica,sans-serif;
          font-size:11pt; color:rgb(0,0,0)">
          Xiaojie<br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Yuan, Xiaojie <a class="moz-txt-link-rfc2396E" href="mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">&lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <b>Sent:</b> Thursday, September 26, 2019 4:08 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
            <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>; Yuan, Xiaojie
            <a class="moz-txt-link-rfc2396E" href="mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">&lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdgpu/gmc10: apply the
            'invalidation from sdma' workaround for navi</font>
          <div> </div>
        </div>
        <div class="x_BodyFragment"><font size="2"><span
              style="font-size:11pt">
              <div class="x_PlainText">Fixes: 767acabdac81
                ("drm/amd/powerplay: add baco smu reset function for
                smu11")<br>
                Signed-off-by: Xiaojie Yuan <a class="moz-txt-link-rfc2396E" href="mailto:xiaojie.yuan-5C7GfCeVMHo@public.gmane.org">&lt;xiaojie.yuan-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                ---<br>
                 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +<br>
                 1 file changed, 1 insertion(+)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
                b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                index cb3f61873baa..dc2e68e019eb 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
                @@ -292,6 +292,7 @@ static void
                gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev,
                uint32_t vmid,<br>
                 <br>
                         if (!adev-&gt;mman.buffer_funcs_enabled ||<br>
                             !adev-&gt;ib_pool_ready ||<br>
                +           !(adev-&gt;asic_type &gt;= CHIP_NAVI10
                &amp;&amp; adev-&gt;asic_type &lt;= CHIP_NAVI12) ||<br>
                             adev-&gt;in_gpu_reset) {<br>
                                 gmc_v10_0_flush_vm_hub(adev, vmid,
                AMDGPU_GFXHUB_0, 0);<br>
                                
                mutex_unlock(&amp;adev-&gt;mman.gtt_window_lock);<br>
                -- <br>
                2.20.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
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

--------------F7EF14EA4E76D9D44665EAA8--

--===============1169247151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1169247151==--
