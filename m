From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] amdgpu: Add R600_DEBUG flag to reserve VMID per ctx.
Date: Tue, 31 Oct 2017 11:56:36 -0400
Message-ID: <4516e866-67e2-2234-97c0-a57cbc4650a7@amd.com>
References: <1509464412-30394-1-git-send-email-andrey.grodzovsky@amd.com>
 <078f3ca7-e108-6ce6-4e07-65d8f569eb45@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1041990847=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <078f3ca7-e108-6ce6-4e07-65d8f569eb45-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Samuel Pitoiset <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Marek.Olsak-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1041990847==
Content-Type: multipart/alternative;
 boundary="------------9800F7F9AF4B39FF65E4F6ED"

This is a multi-part message in MIME format.
--------------9800F7F9AF4B39FF65E4F6ED
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2017-10-31 11:50 AM, Samuel Pitoiset wrote:
>
>
> On 10/31/2017 04:40 PM, Andrey Grodzovsky wrote:
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   configure.ac                                  | 2 +-
>>   src/gallium/drivers/radeon/r600_pipe_common.c | 1 +
>>   src/gallium/drivers/radeon/r600_pipe_common.h | 1 +
>>   src/gallium/winsys/amdgpu/drm/amdgpu_cs.c     | 8 ++++++++
>>   src/gallium/winsys/amdgpu/drm/amdgpu_cs.h     | 3 +++
>>   src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c | 1 +
>>   src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h | 1 +
>>   7 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 9aa02f5..efc653a 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -74,7 +74,7 @@ AC_SUBST([OPENCL_VERSION])
>>   # in the first entry.
>>   LIBDRM_REQUIRED=2.4.75
>>   LIBDRM_RADEON_REQUIRED=2.4.71
>> -LIBDRM_AMDGPU_REQUIRED=2.4.85
>> +LIBDRM_AMDGPU_REQUIRED=2.4.86
>>   LIBDRM_INTEL_REQUIRED=2.4.75
>>   LIBDRM_NVVIEUX_REQUIRED=2.4.66
>>   LIBDRM_NOUVEAU_REQUIRED=2.4.66
>> diff --git a/src/gallium/drivers/radeon/r600_pipe_common.c 
>> b/src/gallium/drivers/radeon/r600_pipe_common.c
>> index b77d859..3364dac 100644
>> --- a/src/gallium/drivers/radeon/r600_pipe_common.c
>> +++ b/src/gallium/drivers/radeon/r600_pipe_common.c
>> @@ -851,6 +851,7 @@ static const struct debug_named_value 
>> common_debug_options[] = {
>>       { "dpbb", DBG(DPBB), "Enable DPBB." },
>>       { "dfsm", DBG(DFSM), "Enable DFSM." },
>>       { "nooutoforder", DBG(NO_OUT_OF_ORDER), "Disable out-of-order 
>> rasterization" },
>> +    { "reserve_vmid", DBG(RESERVE_VMID), "Force VMID resrvation per 
>> context." },
>
> "reservation".
>
> Can you also explain a bit what that stuff is? :)

It allows to have fixed VMID assigned to a process, otherwise each time 
a command is processed the next available VMID is assigned
according to a policy in KMD (amdgpu_vm_grab_id).

Thanks,
Andrey

>
> Thanks!
>
>>         DEBUG_NAMED_VALUE_END /* must be last */
>>   };
>> diff --git a/src/gallium/drivers/radeon/r600_pipe_common.h 
>> b/src/gallium/drivers/radeon/r600_pipe_common.h
>> index a7c91cb..94c8d4f 100644
>> --- a/src/gallium/drivers/radeon/r600_pipe_common.h
>> +++ b/src/gallium/drivers/radeon/r600_pipe_common.h
>> @@ -107,6 +107,7 @@ enum {
>>       DBG_NO_DISCARD_RANGE,
>>       DBG_NO_WC,
>>       DBG_CHECK_VM,
>> +    DBG_RESERVE_VMID,
>>         /* 3D engine options: */
>>       DBG_SWITCH_ON_EOP,
>> diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c 
>> b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
>> index 8f43e93..1155492 100644
>> --- a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
>> +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
>> @@ -256,6 +256,14 @@ static struct radeon_winsys_ctx 
>> *amdgpu_ctx_create(struct radeon_winsys *ws)
>>         goto error_create;
>>      }
>>   +   if (ctx->ws->reserve_vmid) {
>> +       r = amdgpu_vm_reserve_vmid(ctx->ctx, 0);
>> +       if (r) {
>> +        fprintf(stderr, "amdgpu: amdgpu_cs_ctx_create failed. 
>> (%i)\n", r);
>> +        goto error_create;
>> +       }
>> +   }
>> +
>>      alloc_buffer.alloc_size = ctx->ws->info.gart_page_size;
>>      alloc_buffer.phys_alignment = ctx->ws->info.gart_page_size;
>>      alloc_buffer.preferred_heap = AMDGPU_GEM_DOMAIN_GTT;
>> diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.h 
>> b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.h
>> index 1c3d0f0..d023841 100644
>> --- a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.h
>> +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.h
>> @@ -162,6 +162,9 @@ static inline bool amdgpu_fence_is_syncobj(struct 
>> amdgpu_fence *fence)
>>   static inline void amdgpu_ctx_unref(struct amdgpu_ctx *ctx)
>>   {
>>      if (p_atomic_dec_zero(&ctx->refcount)) {
>> +      if (ctx->ws->reserve_vmid)
>> +         amdgpu_vm_unreserve_vmid(ctx->ctx, 0);
>> +
>>         amdgpu_cs_ctx_free(ctx->ctx);
>>         amdgpu_bo_free(ctx->user_fence_bo);
>>         FREE(ctx);
>> diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c 
>> b/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c
>> index a210a27..b80a988 100644
>> --- a/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c
>> +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c
>> @@ -73,6 +73,7 @@ static bool do_winsys_init(struct amdgpu_winsys 
>> *ws, int fd)
>>        ws->check_vm = strstr(debug_get_option("R600_DEBUG", ""), 
>> "check_vm") != NULL;
>>      ws->debug_all_bos = debug_get_option_all_bos();
>> +   ws->reserve_vmid = strstr(debug_get_option("R600_DEBUG", ""), 
>> "reserve_vmid") != NULL;
>>        return true;
>>   diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h 
>> b/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h
>> index 8b62e2d..b4a3422 100644
>> --- a/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h
>> +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h
>> @@ -81,6 +81,7 @@ struct amdgpu_winsys {
>>        bool check_vm;
>>      bool debug_all_bos;
>> +   bool reserve_vmid;
>>        /* List of all allocated buffers */
>>      mtx_t global_bo_list_lock;
>>


--------------9800F7F9AF4B39FF65E4F6ED
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2017-10-31 11:50 AM, Samuel Pitoiset
      wrote:<br>
    </div>
    <blockquote
      cite="mid:078f3ca7-e108-6ce6-4e07-65d8f569eb45-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
      type="cite">
      <br>
      <br>
      On 10/31/2017 04:40 PM, Andrey Grodzovsky wrote:
      <br>
      <blockquote type="cite">Signed-off-by: Andrey Grodzovsky
        <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a>
        <br>
        ---
        <br>
          configure.ac                                  | 2 +-
        <br>
          src/gallium/drivers/radeon/r600_pipe_common.c | 1 +
        <br>
          src/gallium/drivers/radeon/r600_pipe_common.h | 1 +
        <br>
          src/gallium/winsys/amdgpu/drm/amdgpu_cs.c     | 8 ++++++++
        <br>
          src/gallium/winsys/amdgpu/drm/amdgpu_cs.h     | 3 +++
        <br>
          src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c | 1 +
        <br>
          src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h | 1 +
        <br>
          7 files changed, 16 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/configure.ac b/configure.ac
        <br>
        index 9aa02f5..efc653a 100644
        <br>
        --- a/configure.ac
        <br>
        +++ b/configure.ac
        <br>
        @@ -74,7 +74,7 @@ AC_SUBST([OPENCL_VERSION])
        <br>
          # in the first entry.
        <br>
          LIBDRM_REQUIRED=2.4.75
        <br>
          LIBDRM_RADEON_REQUIRED=2.4.71
        <br>
        -LIBDRM_AMDGPU_REQUIRED=2.4.85
        <br>
        +LIBDRM_AMDGPU_REQUIRED=2.4.86
        <br>
          LIBDRM_INTEL_REQUIRED=2.4.75
        <br>
          LIBDRM_NVVIEUX_REQUIRED=2.4.66
        <br>
          LIBDRM_NOUVEAU_REQUIRED=2.4.66
        <br>
        diff --git a/src/gallium/drivers/radeon/r600_pipe_common.c
        b/src/gallium/drivers/radeon/r600_pipe_common.c
        <br>
        index b77d859..3364dac 100644
        <br>
        --- a/src/gallium/drivers/radeon/r600_pipe_common.c
        <br>
        +++ b/src/gallium/drivers/radeon/r600_pipe_common.c
        <br>
        @@ -851,6 +851,7 @@ static const struct debug_named_value
        common_debug_options[] = {
        <br>
              { "dpbb", DBG(DPBB), "Enable DPBB." },
        <br>
              { "dfsm", DBG(DFSM), "Enable DFSM." },
        <br>
              { "nooutoforder", DBG(NO_OUT_OF_ORDER), "Disable
        out-of-order rasterization" },
        <br>
        +    { "reserve_vmid", DBG(RESERVE_VMID), "Force VMID resrvation
        per context." },
        <br>
      </blockquote>
      <br>
      "reservation".
      <br>
      <br>
      Can you also explain a bit what that stuff is? :)
      <br>
    </blockquote>
    <br>
    It allows to have fixed VMID assigned to a process, otherwise each
    time a command is processed the next available VMID is assigned <br>
    according to a policy in KMD (amdgpu_vm_grab_id).<br>
    <br>
    Thanks,<br>
    Andrey<br>
    <br>
    <span style="color: rgb(176, 204, 232); font-family: &quot;Source Sans Pro&quot;, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: 0.2px; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: pre-wrap; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(23, 51, 79); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"></span>
    <blockquote
      cite="mid:078f3ca7-e108-6ce6-4e07-65d8f569eb45-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
      type="cite">
      <br>
      Thanks!
      <br>
      <br>
      <blockquote type="cite">        DEBUG_NAMED_VALUE_END /* must be
        last */
        <br>
          };
        <br>
        diff --git a/src/gallium/drivers/radeon/r600_pipe_common.h
        b/src/gallium/drivers/radeon/r600_pipe_common.h
        <br>
        index a7c91cb..94c8d4f 100644
        <br>
        --- a/src/gallium/drivers/radeon/r600_pipe_common.h
        <br>
        +++ b/src/gallium/drivers/radeon/r600_pipe_common.h
        <br>
        @@ -107,6 +107,7 @@ enum {
        <br>
              DBG_NO_DISCARD_RANGE,
        <br>
              DBG_NO_WC,
        <br>
              DBG_CHECK_VM,
        <br>
        +    DBG_RESERVE_VMID,
        <br>
                /* 3D engine options: */
        <br>
              DBG_SWITCH_ON_EOP,
        <br>
        diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
        b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
        <br>
        index 8f43e93..1155492 100644
        <br>
        --- a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
        <br>
        +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
        <br>
        @@ -256,6 +256,14 @@ static struct radeon_winsys_ctx
        *amdgpu_ctx_create(struct radeon_winsys *ws)
        <br>
                goto error_create;
        <br>
             }
        <br>
          +   if (ctx-&gt;ws-&gt;reserve_vmid) {
        <br>
        +       r = amdgpu_vm_reserve_vmid(ctx-&gt;ctx, 0);
        <br>
        +       if (r) {
        <br>
        +        fprintf(stderr, "amdgpu: amdgpu_cs_ctx_create failed.
        (%i)\n", r);
        <br>
        +        goto error_create;
        <br>
        +       }
        <br>
        +   }
        <br>
        +
        <br>
             alloc_buffer.alloc_size =
        ctx-&gt;ws-&gt;info.gart_page_size;
        <br>
             alloc_buffer.phys_alignment =
        ctx-&gt;ws-&gt;info.gart_page_size;
        <br>
             alloc_buffer.preferred_heap = AMDGPU_GEM_DOMAIN_GTT;
        <br>
        diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.h
        b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.h
        <br>
        index 1c3d0f0..d023841 100644
        <br>
        --- a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.h
        <br>
        +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.h
        <br>
        @@ -162,6 +162,9 @@ static inline bool
        amdgpu_fence_is_syncobj(struct amdgpu_fence *fence)
        <br>
          static inline void amdgpu_ctx_unref(struct amdgpu_ctx *ctx)
        <br>
          {
        <br>
             if (p_atomic_dec_zero(&amp;ctx-&gt;refcount)) {
        <br>
        +      if (ctx-&gt;ws-&gt;reserve_vmid)
        <br>
        +         amdgpu_vm_unreserve_vmid(ctx-&gt;ctx, 0);
        <br>
        +
        <br>
                amdgpu_cs_ctx_free(ctx-&gt;ctx);
        <br>
                amdgpu_bo_free(ctx-&gt;user_fence_bo);
        <br>
                FREE(ctx);
        <br>
        diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c
        b/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c
        <br>
        index a210a27..b80a988 100644
        <br>
        --- a/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c
        <br>
        +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.c
        <br>
        @@ -73,6 +73,7 @@ static bool do_winsys_init(struct
        amdgpu_winsys *ws, int fd)
        <br>
               ws-&gt;check_vm = strstr(debug_get_option("R600_DEBUG",
        ""), "check_vm") != NULL;
        <br>
             ws-&gt;debug_all_bos = debug_get_option_all_bos();
        <br>
        +   ws-&gt;reserve_vmid = strstr(debug_get_option("R600_DEBUG",
        ""), "reserve_vmid") != NULL;
        <br>
               return true;
        <br>
          diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h
        b/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h
        <br>
        index 8b62e2d..b4a3422 100644
        <br>
        --- a/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h
        <br>
        +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_winsys.h
        <br>
        @@ -81,6 +81,7 @@ struct amdgpu_winsys {
        <br>
               bool check_vm;
        <br>
             bool debug_all_bos;
        <br>
        +   bool reserve_vmid;
        <br>
               /* List of all allocated buffers */
        <br>
             mtx_t global_bo_list_lock;
        <br>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------9800F7F9AF4B39FF65E4F6ED--

--===============1041990847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1041990847==--
