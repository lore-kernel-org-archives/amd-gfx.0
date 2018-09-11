From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add module parameter to enable/disable bulk
 move
Date: Tue, 11 Sep 2018 12:05:57 +0200
Message-ID: <506eed80-ab22-81a4-ef28-609c61701ef9@gmail.com>
References: <1536637283-6625-1-git-send-email-ray.huang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0248200575=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1536637283-6625-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom StDenis <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0248200575==
Content-Type: multipart/alternative;
 boundary="------------5384B64AE2925426FF3431A5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5384B64AE2925426FF3431A5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.09.2018 um 05:41 schrieb Huang Rui:
> The bulk moving mechanism still has bug on some corner cases. So disable it by
> default till it is fixed. We can use the module parameter to enable it for
> debugging.

Please no. Module parameters are for end users, not developers.

I really don't want a bug report that this option can crash the system.

Christian.

>
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> Cc: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Cc: Tom StDenis <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 11 +++++++++--
>   3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e992e0f..75fd7be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -134,6 +134,7 @@ extern int amdgpu_compute_multipipe;
>   extern int amdgpu_gpu_recovery;
>   extern int amdgpu_emu_mode;
>   extern uint amdgpu_smu_memory_pool_size;
> +extern int amdgpu_bulk_move_enabled;
>   
>   #ifdef CONFIG_DRM_AMDGPU_SI
>   extern int amdgpu_si_support;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b5c2ccb..d57d16e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -127,6 +127,7 @@ int amdgpu_compute_multipipe = -1;
>   int amdgpu_gpu_recovery = -1; /* auto */
>   int amdgpu_emu_mode = 0;
>   uint amdgpu_smu_memory_pool_size = 0;
> +int amdgpu_bulk_move_enabled = 0;
>   
>   /**
>    * DOC: vramlimit (int)
> @@ -532,6 +533,16 @@ MODULE_PARM_DESC(smu_memory_pool_size,
>   		"0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte");
>   module_param_named(smu_memory_pool_size, amdgpu_smu_memory_pool_size, uint, 0444);
>   
> +/**
> + * DOC: bulk_move_enabled (int)
> + * It is used to enable/disable bulk moving on LRU list mechanism for debugging
> + * and testing. The default is false (disabled).  It will be enabled by default
> + * till all corner cases are hammered out.
> + */
> +MODULE_PARM_DESC(bulk_move_enabled,
> +		 "Enable bulk moving on LRU list mechanism (1 = enabled, 0 = disabled (default)");
> +module_param_named(bulk_move_enabled, amdgpu_bulk_move_enabled, uint, 0444);
> +
>   #ifdef CONFIG_HSA_AMD
>   /**
>    * DOC: sched_policy (int)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9a5b1bb..ab95a9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -397,7 +397,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   	}
>   	spin_unlock(&glob->lru_lock);
>   
> -	vm->bulk_moveable = true;
> +	if (amdgpu_bulk_move_enabled)
> +		vm->bulk_moveable = true;
>   }
>   
>   /**
> @@ -1213,7 +1214,13 @@ int amdgpu_vm_update_directories(struct amdgpu_device *adev,
>   		bo_base = list_first_entry(&vm->relocated,
>   					   struct amdgpu_vm_bo_base,
>   					   vm_status);
> -		amdgpu_vm_bo_idle(bo_base);
> +		if (amdgpu_bulk_move_enabled)
> +			amdgpu_vm_bo_idle(bo_base);
> +		else {
> +			/* workaround: don't move PD/PT bos on LRU */
> +			list_del_init(&bo_base->vm_status);
> +			bo_base->moved = false;
> +		}
>   
>   		bo = bo_base->bo->parent;
>   		if (!bo)
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------5384B64AE2925426FF3431A5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 11.09.2018 um 05:41 schrieb Huang
      Rui:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1536637283-6625-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">The bulk moving mechanism still has bug on some corner cases. So disable it by
default till it is fixed. We can use the module parameter to enable it for
debugging.</pre>
    </blockquote>
    <br>
    Please no. Module parameters are for end users, not developers.<br>
    <br>
    I really don't want a bug report that this option can crash the
    system.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:1536637283-6625-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org">
      <pre wrap="">

Signed-off-by: Huang Rui <a class="moz-txt-link-rfc2396E" href="mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">&lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;</a>
Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
Cc: Tom StDenis <a class="moz-txt-link-rfc2396E" href="mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org">&lt;Tom.StDenis-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 11 +++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e992e0f..75fd7be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -134,6 +134,7 @@ extern int amdgpu_compute_multipipe;
 extern int amdgpu_gpu_recovery;
 extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
+extern int amdgpu_bulk_move_enabled;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b5c2ccb..d57d16e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -127,6 +127,7 @@ int amdgpu_compute_multipipe = -1;
 int amdgpu_gpu_recovery = -1; /* auto */
 int amdgpu_emu_mode = 0;
 uint amdgpu_smu_memory_pool_size = 0;
+int amdgpu_bulk_move_enabled = 0;
 
 /**
  * DOC: vramlimit (int)
@@ -532,6 +533,16 @@ MODULE_PARM_DESC(smu_memory_pool_size,
 		"0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte");
 module_param_named(smu_memory_pool_size, amdgpu_smu_memory_pool_size, uint, 0444);
 
+/**
+ * DOC: bulk_move_enabled (int)
+ * It is used to enable/disable bulk moving on LRU list mechanism for debugging
+ * and testing. The default is false (disabled).  It will be enabled by default
+ * till all corner cases are hammered out.
+ */
+MODULE_PARM_DESC(bulk_move_enabled,
+		 "Enable bulk moving on LRU list mechanism (1 = enabled, 0 = disabled (default)");
+module_param_named(bulk_move_enabled, amdgpu_bulk_move_enabled, uint, 0444);
+
 #ifdef CONFIG_HSA_AMD
 /**
  * DOC: sched_policy (int)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9a5b1bb..ab95a9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -397,7 +397,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 	}
 	spin_unlock(&amp;glob-&gt;lru_lock);
 
-	vm-&gt;bulk_moveable = true;
+	if (amdgpu_bulk_move_enabled)
+		vm-&gt;bulk_moveable = true;
 }
 
 /**
@@ -1213,7 +1214,13 @@ int amdgpu_vm_update_directories(struct amdgpu_device *adev,
 		bo_base = list_first_entry(&amp;vm-&gt;relocated,
 					   struct amdgpu_vm_bo_base,
 					   vm_status);
-		amdgpu_vm_bo_idle(bo_base);
+		if (amdgpu_bulk_move_enabled)
+			amdgpu_vm_bo_idle(bo_base);
+		else {
+			/* workaround: don't move PD/PT bos on LRU */
+			list_del_init(&amp;bo_base-&gt;vm_status);
+			bo_base-&gt;moved = false;
+		}
 
 		bo = bo_base-&gt;bo-&gt;parent;
 		if (!bo)
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

--------------5384B64AE2925426FF3431A5--

--===============0248200575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0248200575==--
