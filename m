From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sdma5: fix mask value of POLL_REGMEM packet
 for pipe sync
Date: Fri, 11 Oct 2019 10:53:48 +0200
Message-ID: <03836bb7-cfdd-b966-d46a-c09dd5eefe9e@gmail.com>
References: <20191009170923.15479-1-xiaojie.yuan@amd.com>
 <DM5PR12MB18207AE8E0DD7CCE9FB23E41F7950@DM5PR12MB1820.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1805723932=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB18207AE8E0DD7CCE9FB23E41F7950-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1805723932==
Content-Type: multipart/alternative;
 boundary="------------41AA3C65EED4B43414EEF479"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------41AA3C65EED4B43414EEF479
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Good catch! Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Am 09.10.19 um 19:11 schrieb Deucher, Alexander:
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Wednesday, October 9, 2019 1:09 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Cc:* Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>; Yuan, Xiaojie 
> <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
> *Subject:* [PATCH] drm/amdgpu/sdma5: fix mask value of POLL_REGMEM 
> packet for pipe sync
> sdma will hang once sequence number to be polled reaches 0x1000_0000
>
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c 
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index ad5c3566337c..3460c00f3eaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1126,7 +1126,7 @@ static void 
> sdma_v5_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>          amdgpu_ring_write(ring, addr & 0xfffffffc);
>          amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
>          amdgpu_ring_write(ring, seq); /* reference */
> -       amdgpu_ring_write(ring, 0xfffffff); /* mask */
> +       amdgpu_ring_write(ring, 0xffffffff); /* mask */
>          amdgpu_ring_write(ring, 
> SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
> SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
>  }
> -- 
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------41AA3C65EED4B43414EEF479
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Good catch! Reviewed-by: Christian
      König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      <br>
      Am 09.10.19 um 19:11 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB18207AE8E0DD7CCE9FB23E41F7950-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Yuan, Xiaojie <a class="moz-txt-link-rfc2396E" href="mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">&lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Wednesday, October 9, 2019 1:09 PM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
          <b>Cc:</b> Xiao, Jack <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao-5C7GfCeVMHo@public.gmane.org">&lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;</a>; Yuan, Xiaojie
          <a class="moz-txt-link-rfc2396E" href="mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">&lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;</a>; Zhang, Hawking
          <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Subject:</b> [PATCH] drm/amdgpu/sdma5: fix mask value of
          POLL_REGMEM packet for pipe sync</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">sdma will hang once sequence number
              to be polled reaches 0x1000_0000<br>
              <br>
              Signed-off-by: Xiaojie Yuan <a class="moz-txt-link-rfc2396E" href="mailto:xiaojie.yuan-5C7GfCeVMHo@public.gmane.org">&lt;xiaojie.yuan-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 +-<br>
               1 file changed, 1 insertion(+), 1 deletion(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
              b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
              index ad5c3566337c..3460c00f3eaa 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
              @@ -1126,7 +1126,7 @@ static void
              sdma_v5_0_ring_emit_pipeline_sync(struct amdgpu_ring
              *ring)<br>
                       amdgpu_ring_write(ring, addr &amp; 0xfffffffc);<br>
                       amdgpu_ring_write(ring, upper_32_bits(addr) &amp;
              0xffffffff);<br>
                       amdgpu_ring_write(ring, seq); /* reference */<br>
              -       amdgpu_ring_write(ring, 0xfffffff); /* mask */<br>
              +       amdgpu_ring_write(ring, 0xffffffff); /* mask */<br>
                       amdgpu_ring_write(ring,
              SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |<br>
                                        
              SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count,
              poll interval */<br>
               }<br>
              -- <br>
              2.20.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
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

--------------41AA3C65EED4B43414EEF479--

--===============1805723932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1805723932==--
