From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 5/6] [V2]drm/amdgpu: disable dpm before turn off clock
 when vce idle.
Date: Wed, 26 Oct 2016 12:59:35 +0200
Message-ID: <a391b023-8aba-08e9-c6ad-da6f5677c137@vodafone.de>
References: <CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0017269182=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0017269182==
Content-Type: multipart/alternative;
 boundary="------------61297BB9237C8B959F6DAFB8"

This is a multi-part message in MIME format.
--------------61297BB9237C8B959F6DAFB8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 26.10.2016 um 12:46 schrieb Zhu, Rex:
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

It's good practice to add a short note what changed with v2 of the patch 
in the commit message, e.g. something like "v2: move return value check 
as well".

With that fixed that patch is Reviewed-by: Christian König 
<christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> index 54a7019..8f6e7a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> @@ -4258,13 +4258,12 @@ static int ci_update_vce_dpm(struct amdgpu_device *adev,
>   
>   			ret = ci_enable_vce_dpm(adev, true);
>   		} else {
> +			ret = ci_enable_vce_dpm(adev, false);
> +			if (ret)
> +				return ret;
>   			/* turn the clocks off when not encoding */
>   			ret = amdgpu_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
>   							    AMD_CG_STATE_GATE);
> -			if (ret)
> -				return ret;
> -
> -			ret = ci_enable_vce_dpm(adev, false);
>   		}
>   	}
>   	return ret;
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------61297BB9237C8B959F6DAFB8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 26.10.2016 um 12:46 schrieb Zhu,
      Rex:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <pre wrap="">Signed-off-by: Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a></pre>
    </blockquote>
    <br>
    It's good practice to add a short note what changed with v2 of the
    patch in the commit message, e.g. something like "v2: move return
    value check as well".<br>
    <br>
    With that fixed that patch is Reviewed-by: Christian König
    <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote
cite="mid:CY4PR12MB16873ED9F5D23ED1F91DD8FBFBAB0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <pre wrap="">
---
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
index 54a7019..8f6e7a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
@@ -4258,13 +4258,12 @@ static int ci_update_vce_dpm(struct amdgpu_device *adev,
 
 			ret = ci_enable_vce_dpm(adev, true);
 		} else {
+			ret = ci_enable_vce_dpm(adev, false);
+			if (ret)
+				return ret;
 			/* turn the clocks off when not encoding */
 			ret = amdgpu_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							    AMD_CG_STATE_GATE);
-			if (ret)
-				return ret;
-
-			ret = ci_enable_vce_dpm(adev, false);
 		}
 	}
 	return ret;
</pre>
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

--------------61297BB9237C8B959F6DAFB8--

--===============0017269182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0017269182==--
