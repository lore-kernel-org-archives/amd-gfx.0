From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix bug with IH ring setup
Date: Tue, 13 Nov 2018 09:06:45 +0100
Message-ID: <f362c7da-b95d-7c88-2c9d-71fb30143cc2@gmail.com>
References: <1542050408-19731-1-git-send-email-Philip.Yang@amd.com>
 <BN6PR12MB18094950A3FC8AA193D0A821F7C10@BN6PR12MB1809.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0344888291=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18094950A3FC8AA193D0A821F7C10-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0344888291==
Content-Type: multipart/alternative;
 boundary="------------EBE3ADD2A30050845FD90744"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EBE3ADD2A30050845FD90744
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Am 12.11.18 um 20:33 schrieb Deucher, Alexander:
>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Yang, Philip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Monday, November 12, 2018 2:20 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Yang, Philip
> *Subject:* [PATCH] drm/amdgpu: fix bug with IH ring setup
> The bug limits the IH ring wptr address to 40bit. When the system memory
> is bigger than 1TB, the bus address is more than 40bit, this causes the
> interrupt cannot be handled and cleared correctly.
>
> Change-Id: I3cd1b8ad046b38945372f2fd1a2d225624893e28
> Signed-off-by: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index a99f717..a0fda6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -129,7 +129,7 @@ static int vega10_ih_irq_init(struct amdgpu_device 
> *adev)
>          else
>                  wptr_off = adev->wb.gpu_addr + 
> (adev->irq.ih.wptr_offs * 4);
>          WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO, 
> lower_32_bits(wptr_off));
> -       WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI, 
> upper_32_bits(wptr_off) & 0xFF);
> +       WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI, 
> upper_32_bits(wptr_off) & 0xFFFF);
>
>          /* set rptr, wptr to 0 */
>          WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
> -- 
> 2.7.4
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


--------------EBE3ADD2A30050845FD90744
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      <br>
      Am 12.11.18 um 20:33 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB18094950A3FC8AA193D0A821F7C10-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper" style="font-size: 12pt; color:
        rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif,
        &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,
        &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
        Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Reviewed-by: Alex
          Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        </p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Monday, November 12, 2018 2:20 PM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Cc:</b> Yang, Philip<br>
              <b>Subject:</b> [PATCH] drm/amdgpu: fix bug with IH ring
              setup</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">The bug limits the IH ring wptr
                  address to 40bit. When the system memory<br>
                  is bigger than 1TB, the bus address is more than
                  40bit, this causes the<br>
                  interrupt cannot be handled and cleared correctly.<br>
                  <br>
                  Change-Id: I3cd1b8ad046b38945372f2fd1a2d225624893e28<br>
                  Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang-5C7GfCeVMHo@public.gmane.org">&lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  ---<br>
                   drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 2 +-<br>
                   1 file changed, 1 insertion(+), 1 deletion(-)<br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
                  b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
                  index a99f717..a0fda6f 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
                  @@ -129,7 +129,7 @@ static int
                  vega10_ih_irq_init(struct amdgpu_device *adev)<br>
                           else<br>
                                   wptr_off = adev-&gt;wb.gpu_addr +
                  (adev-&gt;irq.ih.wptr_offs * 4);<br>
                           WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO,
                  lower_32_bits(wptr_off));<br>
                  -       WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI,
                  upper_32_bits(wptr_off) &amp; 0xFF);<br>
                  +       WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI,
                  upper_32_bits(wptr_off) &amp; 0xFFFF);<br>
                   <br>
                           /* set rptr, wptr to 0 */<br>
                           WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);<br>
                  -- <br>
                  2.7.4<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk129845" class="OWAAutoLink"
                    previewremoved="true" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                </div>
              </span></font></div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------EBE3ADD2A30050845FD90744--

--===============0344888291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0344888291==--
