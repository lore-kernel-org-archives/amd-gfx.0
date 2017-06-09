From: axie <axie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/vm: fix warnings
Date: Fri, 9 Jun 2017 17:02:46 -0400
Message-ID: <4f587ff7-58bf-aaff-5ca1-a02ad29e2d3a@amd.com>
References: <1497024341-10401-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1971107589=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1497024341-10401-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============1971107589==
Content-Type: multipart/alternative;
 boundary="------------B0E9CB22609397B7192E0BA2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B0E9CB22609397B7192E0BA2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>


On 2017-06-09 12:05 PM, Alex Deucher wrote:
> silence uninitialized variable warnings.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index c4f1a30..28f35db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1023,11 +1023,11 @@ static int amdgpu_vm_update_level(struct amdgpu_device *adev,
>   				  unsigned level)
>   {
>   	struct amdgpu_bo *shadow;
> -	struct amdgpu_ring *ring;
> -	uint64_t pd_addr, shadow_addr;
> +	struct amdgpu_ring *ring = NULL;
> +	uint64_t pd_addr, shadow_addr = 0;
>   	uint32_t incr = amdgpu_vm_bo_size(adev, level + 1);
>   	uint64_t last_pde = ~0, last_pt = ~0, last_shadow = ~0;
> -	unsigned count = 0, pt_idx, ndw;
> +	unsigned count = 0, pt_idx, ndw = 0;
>   	struct amdgpu_job *job;
>   	struct amdgpu_pte_update_params params;
>   	struct dma_fence *fence = NULL;


--------------B0E9CB22609397B7192E0BA2
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
    <div class="moz-cite-prefix">On 2017-06-09 12:05 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1497024341-10401-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">silence uninitialized variable warnings.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c4f1a30..28f35db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1023,11 +1023,11 @@ static int amdgpu_vm_update_level(struct amdgpu_device *adev,
 				  unsigned level)
 {
 	struct amdgpu_bo *shadow;
-	struct amdgpu_ring *ring;
-	uint64_t pd_addr, shadow_addr;
+	struct amdgpu_ring *ring = NULL;
+	uint64_t pd_addr, shadow_addr = 0;
 	uint32_t incr = amdgpu_vm_bo_size(adev, level + 1);
 	uint64_t last_pde = ~0, last_pt = ~0, last_shadow = ~0;
-	unsigned count = 0, pt_idx, ndw;
+	unsigned count = 0, pt_idx, ndw = 0;
 	struct amdgpu_job *job;
 	struct amdgpu_pte_update_params params;
 	struct dma_fence *fence = NULL;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------B0E9CB22609397B7192E0BA2--

--===============1971107589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1971107589==--
