From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 6/8] drm/amd/display: enable GPU VM support
Date: Thu, 26 Oct 2017 14:09:30 -0400
Message-ID: <590b04be-64ca-eb26-9fce-986c44297769@amd.com>
References: <1509033983-2977-1-git-send-email-deathsimple@vodafone.de>
 <1509033983-2977-6-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0840308919=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1509033983-2977-6-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0840308919==
Content-Type: multipart/alternative;
 boundary="------------783A85284D8EA6D748619DC3"

This is a multi-part message in MIME format.
--------------783A85284D8EA6D748619DC3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Andrey Grodzovsky<andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>


On 2017-10-26 12:06 PM, Christian König wrote:
> From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> Just set the bit so that DC does the hardware programming.
>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2188f20..ed4351a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -417,6 +417,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   
>   	init_data.dce_environment = DCE_ENV_PRODUCTION_DRV;
>   
> +	init_data.flags.gpu_vm_support = true;
> +
>   	if (amdgpu_dc_log)
>   		init_data.log_mask = DC_DEFAULT_LOG_MASK;
>   	else


--------------783A85284D8EA6D748619DC3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <pre wrap="">Reviewed-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a></pre>
    <br>
    <div class="moz-cite-prefix">On 2017-10-26 12:06 PM, Christian König
      wrote:<br>
    </div>
    <blockquote
      cite="mid:1509033983-2977-6-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type="cite">
      <pre wrap="">From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>

Just set the bit so that DC does the hardware programming.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2188f20..ed4351a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -417,6 +417,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.dce_environment = DCE_ENV_PRODUCTION_DRV;
 
+	init_data.flags.gpu_vm_support = true;
+
 	if (amdgpu_dc_log)
 		init_data.log_mask = DC_DEFAULT_LOG_MASK;
 	else
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------783A85284D8EA6D748619DC3--

--===============0840308919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0840308919==--
