From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the page fault of raven2
Date: Mon, 24 Sep 2018 10:49:02 +0200
Message-ID: <cce7a63c-d785-5e69-3caf-a881ffdea3e2@gmail.com>
References: <1537754820-17901-1-git-send-email-ray.huang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0366263192=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1537754820-17901-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0366263192==
Content-Type: multipart/alternative;
 boundary="------------3454D8E09747633750E62F8F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3454D8E09747633750E62F8F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.09.2018 um 04:07 schrieb Huang Rui:
> While the apg_end address is 0xffffffff, if add 1 with it, the value will be
> overflow and roll back to 0. So when 0 is written to
> mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, the system aperture is actually disabled. And
> so any access to vram will trigger a page fault.
>
> Raven2's HW issue only need increase the vram end address, and needn't do it on
> the agp.
>
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Cc: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Cc: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index 65f58eb..ceb7847 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -82,7 +82,8 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   		 * to get rid of the VM fault and hardware hang.
>   		 */
>   		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> -			     (max(adev->gmc.vram_end, adev->gmc.agp_end) >> 18) + 0x1);
> +			     max((adev->gmc.vram_end >> 18) + 0x1,
> +				 adev->gmc.agp_end >> 18));
>   	else
>   		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
>   			     max(adev->gmc.vram_end, adev->gmc.agp_end) >> 18);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index 80698b5..14649f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -100,7 +100,8 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
>   		 * to get rid of the VM fault and hardware hang.
>   		 */
>   		WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> -			     (max(adev->gmc.vram_end, adev->gmc.agp_end) >> 18) + 0x1);
> +			     max((adev->gmc.vram_end >> 18) + 0x1,
> +				 adev->gmc.agp_end >> 18));
>   	else
>   		WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
>   			     max(adev->gmc.vram_end, adev->gmc.agp_end) >> 18);
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------3454D8E09747633750E62F8F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 24.09.2018 um 04:07 schrieb Huang
      Rui:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1537754820-17901-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">While the apg_end address is 0xffffffff, if add 1 with it, the value will be
overflow and roll back to 0. So when 0 is written to
mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, the system aperture is actually disabled. And
so any access to vram will trigger a page fault.

Raven2's HW issue only need increase the vram end address, and needn't do it on
the agp.

Signed-off-by: Huang Rui <a class="moz-txt-link-rfc2396E" href="mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">&lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;</a>
Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
Cc: Marek Olšák <a class="moz-txt-link-rfc2396E" href="mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org">&lt;marek.olsak-5C7GfCeVMHo@public.gmane.org&gt;</a></pre>
    </blockquote>
    <br>
    Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
    <br>
    <blockquote type="cite"
      cite="mid:1537754820-17901-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 65f58eb..ceb7847 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -82,7 +82,8 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		 * to get rid of the VM fault and hardware hang.
 		 */
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-			     (max(adev-&gt;gmc.vram_end, adev-&gt;gmc.agp_end) &gt;&gt; 18) + 0x1);
+			     max((adev-&gt;gmc.vram_end &gt;&gt; 18) + 0x1,
+				 adev-&gt;gmc.agp_end &gt;&gt; 18));
 	else
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 			     max(adev-&gt;gmc.vram_end, adev-&gt;gmc.agp_end) &gt;&gt; 18);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 80698b5..14649f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -100,7 +100,8 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		 * to get rid of the VM fault and hardware hang.
 		 */
 		WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-			     (max(adev-&gt;gmc.vram_end, adev-&gt;gmc.agp_end) &gt;&gt; 18) + 0x1);
+			     max((adev-&gt;gmc.vram_end &gt;&gt; 18) + 0x1,
+				 adev-&gt;gmc.agp_end &gt;&gt; 18));
 	else
 		WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 			     max(adev-&gt;gmc.vram_end, adev-&gt;gmc.agp_end) &gt;&gt; 18);
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
    <br>
  </body>
</html>

--------------3454D8E09747633750E62F8F--

--===============0366263192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0366263192==--
