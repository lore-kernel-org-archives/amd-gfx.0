From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/6] drm/amdgpu/gfx9: remove spurious line in kiq setup
Date: Wed, 7 Jun 2017 17:58:19 -0400
Message-ID: <a661785e-c159-a471-a664-55d35e1f7f2b@amd.com>
References: <1496864097-4322-1-git-send-email-alexander.deucher@amd.com>
 <1496864097-4322-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0083492165=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496864097-4322-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0083492165==
Content-Type: multipart/alternative;
 boundary="------------41989C20A1F57C6A09CE515D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------41989C20A1F57C6A09CE515D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>


On 2017-06-07 03:34 PM, Alex Deucher wrote:
> This overrode what queue was actually assigned for kiq.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e0193e4..4c47754f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1054,7 +1054,6 @@ static int gfx_v9_0_kiq_init_ring(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>   
> -	ring->queue = 0;
>   	ring->eop_gpu_addr = kiq->eop_gpu_addr;
>   	sprintf(ring->name, "kiq %d.%d.%d", ring->me, ring->pipe, ring->queue);
>   	r = amdgpu_ring_init(adev, ring, 1024,


--------------41989C20A1F57C6A09CE515D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Reviewed-by: Alex Xie <a class="moz-txt-link-rfc2396E"
        href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a></p>
    <br>
    <div class="moz-cite-prefix">On 2017-06-07 03:34 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1496864097-4322-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">This overrode what queue was actually assigned for kiq.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e0193e4..4c47754f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1054,7 +1054,6 @@ static int gfx_v9_0_kiq_init_ring(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	ring-&gt;queue = 0;
 	ring-&gt;eop_gpu_addr = kiq-&gt;eop_gpu_addr;
 	sprintf(ring-&gt;name, "kiq %d.%d.%d", ring-&gt;me, ring-&gt;pipe, ring-&gt;queue);
 	r = amdgpu_ring_init(adev, ring, 1024,
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------41989C20A1F57C6A09CE515D--

--===============0083492165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0083492165==--
