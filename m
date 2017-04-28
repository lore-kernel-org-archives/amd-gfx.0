From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add cu info wave_front_size
Date: Fri, 28 Apr 2017 10:20:53 +0200
Message-ID: <766cb2d2-8f0a-87e5-030a-da1c39de0821@vodafone.de>
References: <1493349046-23232-1-git-send-email-Jerry.Zhang@amd.com>
 <CY4PR12MB1831304F8CE5E84033D19A768C130@CY4PR12MB1831.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2121176453=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1831304F8CE5E84033D19A768C130-rpdhrqHFk04smaNQB2LitgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============2121176453==
Content-Type: multipart/alternative;
 boundary="------------265D5B80AC6BF75A353FAD18"

This is a multi-part message in MIME format.
--------------265D5B80AC6BF75A353FAD18
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Do I get it right that the branch doesn't compile without that?

If yes please add a comment in the commit message so that Alex has a 
chance of squashing this into the original one during upstreaming.

Either way the patch is Reviewed-by: Christian König 
<christian.koenig-5C7GfCeVMHo@public.gmane.org> as well.

Regards,
Christian.

Am 28.04.2017 um 05:20 schrieb Wang, Ken:
>
> Reviewed-by: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>
>
> ------------------------------------------------------------------------
> *From:* Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Friday, April 28, 2017 11:10:46 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Deucher, Alexander; Wang, Ken; Zhang, Jerry
> *Subject:* [PATCH] drm/amdgpu: add cu info wave_front_size
> missed that for gfx v9 info export
>
> Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 503010a..e330009 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -986,6 +986,7 @@ struct amdgpu_gfx_config {
>  struct amdgpu_cu_info {
>          uint32_t number; /* total active CU number */
>          uint32_t ao_cu_mask;
> +       uint32_t wave_front_size;
>          uint32_t bitmap[4][4];
>  };
>
> -- 
> 1.9.1
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------265D5B80AC6BF75A353FAD18
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Do I get it right that the branch
      doesn't compile without that?<br>
      <br>
      If yes please add a comment in the commit message so that Alex has
      a chance of squashing this into the original one during
      upstreaming.<br>
      <br>
      Either way the patch is Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> as well.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 28.04.2017 um 05:20 schrieb Wang, Ken:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB1831304F8CE5E84033D19A768C130-rpdhrqHFk04smaNQB2LitgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <meta content="text/html; charset=UTF-8">
      <style type="text/css" style="">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
      <div dir="ltr">
        <div id="x_divtagdefaultwrapper" dir="ltr"
          style="font-size:12pt; color:#000000;
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p>Reviewed-by: Ken Wang <a class="moz-txt-link-rfc2396E" href="mailto:Qingqing.Wang-5C7GfCeVMHo@public.gmane.org">&lt;Qingqing.Wang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>From:</b>
            Junwei Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <b>Sent:</b> Friday, April 28, 2017 11:10:46 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>Cc:</b> Deucher, Alexander; Wang, Ken; Zhang, Jerry<br>
            <b>Subject:</b> [PATCH] drm/amdgpu: add cu info
            wave_front_size</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">missed that for gfx v9 info export<br>
            <br>
            Signed-off-by: Junwei Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            ---<br>
             drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +<br>
             1 file changed, 1 insertion(+)<br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            index 503010a..e330009 100644<br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            @@ -986,6 +986,7 @@ struct amdgpu_gfx_config {<br>
             struct amdgpu_cu_info {<br>
                     uint32_t number; /* total active CU number */<br>
                     uint32_t ao_cu_mask;<br>
            +       uint32_t wave_front_size;<br>
                     uint32_t bitmap[4][4];<br>
             };<br>
             <br>
            -- <br>
            1.9.1<br>
            <br>
          </div>
        </span></font>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------265D5B80AC6BF75A353FAD18--

--===============2121176453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2121176453==--
