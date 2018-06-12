From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove unused parameter for va update
Date: Tue, 12 Jun 2018 14:38:11 +0800
Message-ID: <79f96c2f-ca73-0180-929c-33893c7be28b@amd.com>
References: <1528783264-3582-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0287402523=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528783264-3582-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0287402523==
Content-Type: multipart/alternative;
	boundary="------------020F9D761334DC921483165B"
Content-Language: en-US

--------------020F9D761334DC921483165B
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年06月12日 14:01, Junwei Zhang wrote:
> Don't need validation list any more
>
> Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 5fb156a..eff716d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -510,7 +510,6 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>    * @adev: amdgpu_device pointer
>    * @vm: vm to update
>    * @bo_va: bo_va to update
> - * @list: validation list
>    * @operation: map, unmap or clear
>    *
>    * Update the bo_va directly after setting its address. Errors are not
> @@ -519,7 +518,6 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>   static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   				    struct amdgpu_vm *vm,
>   				    struct amdgpu_bo_va *bo_va,
> -				    struct list_head *list,
>   				    uint32_t operation)
>   {
>   	int r;
> @@ -673,7 +671,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   		break;
>   	}
>   	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !amdgpu_vm_debug)
> -		amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va, &list,
> +		amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>   					args->operation);
>   
>   error_backoff:


--------------020F9D761334DC921483165B
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018年06月12日 14:01, Junwei Zhang
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1528783264-3582-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">Don't need validation list any more

Signed-off-by: Junwei Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a></pre>
    </blockquote>
    Reviewed-by: Chunming Zhou <a class="moz-txt-link-rfc2396E"
      href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org">&lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
    <br>
    <blockquote type="cite"
      cite="mid:1528783264-3582-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5fb156a..eff716d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -510,7 +510,6 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
  * @adev: amdgpu_device pointer
  * @vm: vm to update
  * @bo_va: bo_va to update
- * @list: validation list
  * @operation: map, unmap or clear
  *
  * Update the bo_va directly after setting its address. Errors are not
@@ -519,7 +518,6 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 				    struct amdgpu_vm *vm,
 				    struct amdgpu_bo_va *bo_va,
-				    struct list_head *list,
 				    uint32_t operation)
 {
 	int r;
@@ -673,7 +671,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 	if (!r &amp;&amp; !(args-&gt;flags &amp; AMDGPU_VM_DELAY_UPDATE) &amp;&amp; !amdgpu_vm_debug)
-		amdgpu_gem_va_update_vm(adev, &amp;fpriv-&gt;vm, bo_va, &amp;list,
+		amdgpu_gem_va_update_vm(adev, &amp;fpriv-&gt;vm, bo_va,
 					args-&gt;operation);
 
 error_backoff:
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------020F9D761334DC921483165B--

--===============0287402523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0287402523==--
