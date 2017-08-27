From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 9/9] drm/amdgpu: WIP add IOCTL interface for per VM BOs
Date: Sun, 27 Aug 2017 12:03:58 +0200
Message-ID: <fba30bfa-aa7c-d342-b4b6-85058f5db5bf@vodafone.de>
References: <1503653899-1781-1-git-send-email-deathsimple@vodafone.de>
 <1503653899-1781-9-git-send-email-deathsimple@vodafone.de>
 <19c04fac-1fdd-1436-e85c-95dd4ac02b1b@amd.com>
 <9304342a-def2-187e-4e9c-d872c58cdc17@vodafone.de>
 <CAAxE2A5dSR-PY+zZ3VeaT7iiCmj5jfty0hv7XZjz4HgOrApQHw@mail.gmail.com>
 <e7d5f9d9-ed3e-2654-9acd-c7339976006f@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------AF6ADB70000B19CB4515BEF5"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e7d5f9d9-ed3e-2654-9acd-c7339976006f-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------AF6ADB70000B19CB4515BEF5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.08.2017 um 21:19 schrieb Christian König:
> Am 25.08.2017 um 18:22 schrieb Marek Olšák:
>> On Fri, Aug 25, 2017 at 3:00 PM, Christian König
>> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> wrote:
>>> Am 25.08.2017 um 12:32 schrieb zhoucm1:
>>>>
>>>>
>>>> On 2017年08月25日 17:38, Christian König wrote:
>>>>> From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>
>>>>> Add the IOCTL interface so that applications can allocate per VM BOs.
>>>>>
>>>>> Still WIP since not all corner cases are tested yet, but this reduces
>>>>> average
>>>>> CS overhead for 10K BOs from 21ms down to 48us.
>>>> Wow, cheers, eventually you get per vm bo to same reservation with 
>>>> PD/pts,
>>>> indeed save a lot of bo list.
>>>
>>> Don't cheer to loud yet, that is a completely constructed test case.
>>>
>>> So far I wasn't able to archive any improvements with any real game 
>>> on this
>>> with Mesa.
>>>
>>> BTW: Marek can you take a look with some CPU bound tests? I can 
>>> provide a
>>> kernel branch if necessary.
>> Do you have a branch that works on Raven? This patch series doesn't,
>> and I didn't investigate why.
>
> I will come up with one on Monday.

Branch vm_improvements on 
git://people.freedesktop.org/~deathsimple/linux together with the 
attached patch should work.

Only testing on Tonga, but that's based on amd-staging-4.12 and so 
should work on Raven as well. If not I still have a bug somewhere which 
needs to be fixed.

Thanks,
Christian.
>
> Have a nice weekend guys,
> Christian.
>
>>
>> Marek
>>
>>> Regards,
>>> Christian.
>>>
>>>
>>>> overall looks good, I will take a detailed check for this tomorrow.
>>>>
>>>> Regards,
>>>> David Zhou
>>>>>
>>>>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  7 ++--
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c    |  2 +-
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   | 59
>>>>> ++++++++++++++++++++++---------
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c |  3 +-
>>>>>    include/uapi/drm/amdgpu_drm.h             |  2 ++
>>>>>    5 files changed, 51 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index b1e817c..21cab36 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -457,9 +457,10 @@ struct amdgpu_sa_bo {
>>>>>     */
>>>>>    void amdgpu_gem_force_release(struct amdgpu_device *adev);
>>>>>    int amdgpu_gem_object_create(struct amdgpu_device *adev, 
>>>>> unsigned long
>>>>> size,
>>>>> -                int alignment, u32 initial_domain,
>>>>> -                u64 flags, bool kernel,
>>>>> -                struct drm_gem_object **obj);
>>>>> +                 int alignment, u32 initial_domain,
>>>>> +                 u64 flags, bool kernel,
>>>>> +                 struct reservation_object *resv,
>>>>> +                 struct drm_gem_object **obj);
>>>>>      int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>>>>>                    struct drm_device *dev,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>>>>> index 0e907ea..7256f83 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
>>>>> @@ -144,7 +144,7 @@ static int amdgpufb_create_pinned_object(struct
>>>>> amdgpu_fbdev *rfbdev,
>>>>> AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>>>>>                           AMDGPU_GEM_CREATE_VRAM_CLEARED,
>>>>> -                       true, &gobj);
>>>>> +                       true, NULL, &gobj);
>>>>>        if (ret) {
>>>>>            pr_err("failed to allocate framebuffer (%d)\n", 
>>>>> aligned_size);
>>>>>            return -ENOMEM;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> index d028806..b8e8d67 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>>> @@ -44,11 +44,12 @@ void amdgpu_gem_object_free(struct drm_gem_object
>>>>> *gobj)
>>>>>    }
>>>>>      int amdgpu_gem_object_create(struct amdgpu_device *adev, 
>>>>> unsigned
>>>>> long size,
>>>>> -                int alignment, u32 initial_domain,
>>>>> -                u64 flags, bool kernel,
>>>>> -                struct drm_gem_object **obj)
>>>>> +                 int alignment, u32 initial_domain,
>>>>> +                 u64 flags, bool kernel,
>>>>> +                 struct reservation_object *resv,
>>>>> +                 struct drm_gem_object **obj)
>>>>>    {
>>>>> -    struct amdgpu_bo *robj;
>>>>> +    struct amdgpu_bo *bo;
>>>>>        int r;
>>>>>          *obj = NULL;
>>>>> @@ -59,7 +60,7 @@ int amdgpu_gem_object_create(struct amdgpu_device
>>>>> *adev, unsigned long size,
>>>>>      retry:
>>>>>        r = amdgpu_bo_create(adev, size, alignment, kernel, 
>>>>> initial_domain,
>>>>> -                 flags, NULL, NULL, 0, &robj);
>>>>> +                 flags, NULL, resv, 0, &bo);
>>>>>        if (r) {
>>>>>            if (r != -ERESTARTSYS) {
>>>>>                if (initial_domain == AMDGPU_GEM_DOMAIN_VRAM) {
>>>>> @@ -71,7 +72,7 @@ int amdgpu_gem_object_create(struct amdgpu_device
>>>>> *adev, unsigned long size,
>>>>>            }
>>>>>            return r;
>>>>>        }
>>>>> -    *obj = &robj->gem_base;
>>>>> +    *obj = &bo->gem_base;
>>>>>          return 0;
>>>>>    }
>>>>> @@ -136,13 +137,14 @@ void amdgpu_gem_object_close(struct 
>>>>> drm_gem_object
>>>>> *obj,
>>>>>        struct amdgpu_vm *vm = &fpriv->vm;
>>>>>          struct amdgpu_bo_list_entry vm_pd;
>>>>> -    struct list_head list;
>>>>> +    struct list_head list, duplicates;
>>>>>        struct ttm_validate_buffer tv;
>>>>>        struct ww_acquire_ctx ticket;
>>>>>        struct amdgpu_bo_va *bo_va;
>>>>>        int r;
>>>>>          INIT_LIST_HEAD(&list);
>>>>> +    INIT_LIST_HEAD(&duplicates);
>>>>>          tv.bo = &bo->tbo;
>>>>>        tv.shared = true;
>>>>> @@ -150,7 +152,7 @@ void amdgpu_gem_object_close(struct 
>>>>> drm_gem_object
>>>>> *obj,
>>>>>          amdgpu_vm_get_pd_bo(vm, &list, &vm_pd);
>>>>>    -    r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
>>>>> +    r = ttm_eu_reserve_buffers(&ticket, &list, false, &duplicates);
>>>>>        if (r) {
>>>>>            dev_err(adev->dev, "leaking bo va because "
>>>>>                "we fail to reserve bo (%d)\n", r);
>>>>> @@ -185,9 +187,12 @@ int amdgpu_gem_create_ioctl(struct drm_device 
>>>>> *dev,
>>>>> void *data,
>>>>>                    struct drm_file *filp)
>>>>>    {
>>>>>        struct amdgpu_device *adev = dev->dev_private;
>>>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>>>>        union drm_amdgpu_gem_create *args = data;
>>>>>        uint64_t flags = args->in.domain_flags;
>>>>>        uint64_t size = args->in.bo_size;
>>>>> +    struct reservation_object *resv = NULL;
>>>>>        struct drm_gem_object *gobj;
>>>>>        uint32_t handle;
>>>>>        int r;
>>>>> @@ -196,7 +201,8 @@ int amdgpu_gem_create_ioctl(struct drm_device 
>>>>> *dev,
>>>>> void *data,
>>>>>        if (flags & ~(AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
>>>>>                  AMDGPU_GEM_CREATE_NO_CPU_ACCESS |
>>>>>                  AMDGPU_GEM_CREATE_CPU_GTT_USWC |
>>>>> -              AMDGPU_GEM_CREATE_VRAM_CLEARED))
>>>>> +              AMDGPU_GEM_CREATE_VRAM_CLEARED |
>>>>> +              AMDGPU_GEM_CREATE_LOCAL))
>>>>>            return -EINVAL;
>>>>>          /* reject invalid gem domains */
>>>>> @@ -223,9 +229,25 @@ int amdgpu_gem_create_ioctl(struct drm_device 
>>>>> *dev,
>>>>> void *data,
>>>>>        }
>>>>>        size = roundup(size, PAGE_SIZE);
>>>>>    +    if (flags & AMDGPU_GEM_CREATE_LOCAL) {
>>>>> +        r = amdgpu_bo_reserve(vm->root.base.bo, false);
>>>>> +        if (r)
>>>>> +            return r;
>>>>> +
>>>>> +        resv = vm->root.base.bo->tbo.resv;
>>>>> +    }
>>>>> +
>>>>>        r = amdgpu_gem_object_create(adev, size, args->in.alignment,
>>>>>                         (u32)(0xffffffff & args->in.domains),
>>>>> -                     flags, false, &gobj);
>>>>> +                     flags, false, resv, &gobj);
>>>>> +    if (flags & AMDGPU_GEM_CREATE_LOCAL) {
>>>>> +        if (!r) {
>>>>> +            struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
>>>>> +
>>>>> +            abo->parent = amdgpu_bo_ref(vm->root.base.bo);
>>>>> +        }
>>>>> +        amdgpu_bo_unreserve(vm->root.base.bo);
>>>>> +    }
>>>>>        if (r)
>>>>>            return r;
>>>>>    @@ -267,9 +289,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device
>>>>> *dev, void *data,
>>>>>        }
>>>>>          /* create a gem object to contain this object in */
>>>>> -    r = amdgpu_gem_object_create(adev, args->size, 0,
>>>>> -                     AMDGPU_GEM_DOMAIN_CPU, 0,
>>>>> -                     0, &gobj);
>>>>> +    r = amdgpu_gem_object_create(adev, args->size, 0,
>>>>> AMDGPU_GEM_DOMAIN_CPU,
>>>>> +                     0, 0, NULL, &gobj);
>>>>>        if (r)
>>>>>            return r;
>>>>>    @@ -521,7 +542,7 @@ int amdgpu_gem_va_ioctl(struct drm_device 
>>>>> *dev,
>>>>> void *data,
>>>>>        struct amdgpu_bo_list_entry vm_pd;
>>>>>        struct ttm_validate_buffer tv;
>>>>>        struct ww_acquire_ctx ticket;
>>>>> -    struct list_head list;
>>>>> +    struct list_head list, duplicates;
>>>>>        uint64_t va_flags;
>>>>>        int r = 0;
>>>>>    @@ -557,6 +578,7 @@ int amdgpu_gem_va_ioctl(struct drm_device 
>>>>> *dev,
>>>>> void *data,
>>>>>        }
>>>>>          INIT_LIST_HEAD(&list);
>>>>> +    INIT_LIST_HEAD(&duplicates);
>>>>>        if ((args->operation != AMDGPU_VA_OP_CLEAR) &&
>>>>>            !(args->flags & AMDGPU_VM_PAGE_PRT)) {
>>>>>            gobj = drm_gem_object_lookup(filp, args->handle);
>>>>> @@ -573,7 +595,7 @@ int amdgpu_gem_va_ioctl(struct drm_device 
>>>>> *dev, void
>>>>> *data,
>>>>>          amdgpu_vm_get_pd_bo(&fpriv->vm, &list, &vm_pd);
>>>>>    -    r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
>>>>> +    r = ttm_eu_reserve_buffers(&ticket, &list, true, &duplicates);
>>>>>        if (r)
>>>>>            goto error_unref;
>>>>>    @@ -639,6 +661,7 @@ int amdgpu_gem_va_ioctl(struct drm_device 
>>>>> *dev,
>>>>> void *data,
>>>>>    int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>>>>>                struct drm_file *filp)
>>>>>    {
>>>>> +    struct amdgpu_device *adev = dev->dev_private;
>>>>>        struct drm_amdgpu_gem_op *args = data;
>>>>>        struct drm_gem_object *gobj;
>>>>>        struct amdgpu_bo *robj;
>>>>> @@ -686,6 +709,9 @@ int amdgpu_gem_op_ioctl(struct drm_device 
>>>>> *dev, void
>>>>> *data,
>>>>>            if (robj->allowed_domains == AMDGPU_GEM_DOMAIN_VRAM)
>>>>>                robj->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
>>>>>    +        if (robj->flags & AMDGPU_GEM_CREATE_LOCAL)
>>>>> +            amdgpu_vm_bo_invalidate(adev, robj, true);
>>>>> +
>>>>>            amdgpu_bo_unreserve(robj);
>>>>>            break;
>>>>>        default:
>>>>> @@ -715,8 +741,7 @@ int amdgpu_mode_dumb_create(struct drm_file
>>>>> *file_priv,
>>>>>        r = amdgpu_gem_object_create(adev, args->size, 0,
>>>>>                         AMDGPU_GEM_DOMAIN_VRAM,
>>>>> AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED,
>>>>> -                     ttm_bo_type_device,
>>>>> -                     &gobj);
>>>>> +                     false, NULL, &gobj);
>>>>>        if (r)
>>>>>            return -ENOMEM;
>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
>>>>> index 5b3f928..f407499 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
>>>>> @@ -136,7 +136,8 @@ struct dma_buf *amdgpu_gem_prime_export(struct
>>>>> drm_device *dev,
>>>>>    {
>>>>>        struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
>>>>>    -    if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
>>>>> +    if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) ||
>>>>> +        bo->flags & AMDGPU_GEM_CREATE_LOCAL)
>>>>>            return ERR_PTR(-EPERM);
>>>>>          return drm_gem_prime_export(dev, gobj, flags);
>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>>> b/include/uapi/drm/amdgpu_drm.h
>>>>> index d0ee739..05241a6 100644
>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>> @@ -89,6 +89,8 @@ extern "C" {
>>>>>    #define AMDGPU_GEM_CREATE_SHADOW        (1 << 4)
>>>>>    /* Flag that allocating the BO should use linear VRAM */
>>>>>    #define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS    (1 << 5)
>>>>> +/* Flag that BO is local in the VM */
>>>>> +#define AMDGPU_GEM_CREATE_LOCAL            (1 << 6)
>>>>>      struct drm_amdgpu_gem_create_in  {
>>>>>        /** the requested memory size */
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>


--------------AF6ADB70000B19CB4515BEF5
Content-Type: text/x-patch;
 name="0001-radeonsi-set-a-per-buffer-flag-that-disables-inter-p.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-radeonsi-set-a-per-buffer-flag-that-disables-inter-p.pa";
 filename*1="tch"

>From 6ef6fbf384808e11490ff77b3933aa27feb63f7b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 18 Jul 2017 16:08:44 -0400
Subject: [PATCH] radeonsi: set a per-buffer flag that disables inter-process
 sharing (v3)

For lower overhead in the CS ioctl.
Winsys allocators are not used with interprocess-sharable resources.

v2: It shouldn't crash anymore, but the kernel will reject the new flag.
v3 (christian): Rename the flag, avoid sending those buffers in the BO list.
---
 src/gallium/drivers/radeon/r600_buffer_common.c |  7 +++++
 src/gallium/drivers/radeon/radeon_winsys.h      | 20 ++++++++++---
 src/gallium/winsys/amdgpu/drm/amdgpu_bo.c       | 37 ++++++++++++++++---------
 src/gallium/winsys/amdgpu/drm/amdgpu_bo.h       |  2 ++
 src/gallium/winsys/amdgpu/drm/amdgpu_cs.c       | 25 +++++++++++++----
 src/gallium/winsys/radeon/drm/radeon_drm_bo.c   | 27 ++++++++++--------
 6 files changed, 84 insertions(+), 34 deletions(-)

diff --git a/src/gallium/drivers/radeon/r600_buffer_common.c b/src/gallium/drivers/radeon/r600_buffer_common.c
index dd1c209..2747ac4 100644
--- a/src/gallium/drivers/radeon/r600_buffer_common.c
+++ b/src/gallium/drivers/radeon/r600_buffer_common.c
@@ -167,6 +167,13 @@ void r600_init_resource_fields(struct r600_common_screen *rscreen,
 			 RADEON_FLAG_GTT_WC;
 	}
 
+	/* Only displayable single-sample textures can be shared between
+	 * processes. */
+	if (res->b.b.target == PIPE_BUFFER ||
+	    res->b.b.nr_samples >= 2 ||
+	    rtex->surface.micro_tile_mode != RADEON_MICRO_MODE_DISPLAY)
+		res->flags |= RADEON_FLAG_NO_INTERPROCESS_SHARING;
+
 	/* If VRAM is just stolen system memory, allow both VRAM and
 	 * GTT, whichever has free space. If a buffer is evicted from
 	 * VRAM to GTT, it will stay there.
diff --git a/src/gallium/drivers/radeon/radeon_winsys.h b/src/gallium/drivers/radeon/radeon_winsys.h
index b00b144..f0a0a92 100644
--- a/src/gallium/drivers/radeon/radeon_winsys.h
+++ b/src/gallium/drivers/radeon/radeon_winsys.h
@@ -54,6 +54,7 @@ enum radeon_bo_flag { /* bitfield */
     RADEON_FLAG_NO_CPU_ACCESS = (1 << 1),
     RADEON_FLAG_NO_SUBALLOC =   (1 << 2),
     RADEON_FLAG_SPARSE =        (1 << 3),
+    RADEON_FLAG_NO_INTERPROCESS_SHARING = (1 << 4),
 };
 
 enum radeon_bo_usage { /* bitfield */
@@ -661,14 +662,19 @@ static inline unsigned radeon_flags_from_heap(enum radeon_heap heap)
 {
     switch (heap) {
     case RADEON_HEAP_VRAM_NO_CPU_ACCESS:
-        return RADEON_FLAG_GTT_WC | RADEON_FLAG_NO_CPU_ACCESS;
+        return RADEON_FLAG_GTT_WC |
+               RADEON_FLAG_NO_CPU_ACCESS |
+               RADEON_FLAG_NO_INTERPROCESS_SHARING;
+
     case RADEON_HEAP_VRAM:
     case RADEON_HEAP_VRAM_GTT:
     case RADEON_HEAP_GTT_WC:
-        return RADEON_FLAG_GTT_WC;
+        return RADEON_FLAG_GTT_WC |
+               RADEON_FLAG_NO_INTERPROCESS_SHARING;
+
     case RADEON_HEAP_GTT:
     default:
-        return 0;
+        return RADEON_FLAG_NO_INTERPROCESS_SHARING;
     }
 }
 
@@ -700,8 +706,14 @@ static inline int radeon_get_heap_index(enum radeon_bo_domain domain,
     /* NO_CPU_ACCESS implies VRAM only. */
     assert(!(flags & RADEON_FLAG_NO_CPU_ACCESS) || domain == RADEON_DOMAIN_VRAM);
 
+    /* Resources with interprocess sharing don't use any winsys allocators. */
+    if (!(flags & RADEON_FLAG_NO_INTERPROCESS_SHARING))
+        return -1;
+
     /* Unsupported flags: NO_SUBALLOC, SPARSE. */
-    if (flags & ~(RADEON_FLAG_GTT_WC | RADEON_FLAG_NO_CPU_ACCESS))
+    if (flags & ~(RADEON_FLAG_GTT_WC |
+                  RADEON_FLAG_NO_CPU_ACCESS |
+                  RADEON_FLAG_NO_INTERPROCESS_SHARING))
         return -1;
 
     switch (domain) {
diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c b/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
index 97bbe23..d76d441 100644
--- a/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
+++ b/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
@@ -38,6 +38,10 @@
 #include <stdio.h>
 #include <inttypes.h>
 
+#ifndef AMDGPU_GEM_CREATE_LOCAL
+#define AMDGPU_GEM_CREATE_LOCAL (1 << 6)
+#endif
+
 /* Set to 1 for verbose output showing committed sparse buffer ranges. */
 #define DEBUG_SPARSE_COMMITS 0
 
@@ -402,6 +406,8 @@ static struct amdgpu_winsys_bo *amdgpu_create_bo(struct amdgpu_winsys *ws,
       request.flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
    if (flags & RADEON_FLAG_GTT_WC)
       request.flags |= AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+   if (flags & RADEON_FLAG_NO_INTERPROCESS_SHARING)
+      request.flags |= AMDGPU_GEM_CREATE_LOCAL;
 
    r = amdgpu_bo_alloc(ws->dev, &request, &buf_handle);
    if (r) {
@@ -435,6 +441,7 @@ static struct amdgpu_winsys_bo *amdgpu_create_bo(struct amdgpu_winsys *ws,
    bo->u.real.va_handle = va_handle;
    bo->initial_domain = initial_domain;
    bo->unique_id = __sync_fetch_and_add(&ws->next_bo_unique_id, 1);
+   bo->is_local = !!(request.flags & AMDGPU_GEM_CREATE_LOCAL);
 
    if (initial_domain & RADEON_DOMAIN_VRAM)
       ws->allocated_vram += align64(size, ws->info.gart_page_size);
@@ -1134,7 +1141,7 @@ amdgpu_bo_create(struct radeon_winsys *rws,
 {
    struct amdgpu_winsys *ws = amdgpu_winsys(rws);
    struct amdgpu_winsys_bo *bo;
-   unsigned usage = 0, pb_cache_bucket;
+   unsigned usage = 0, pb_cache_bucket = 0;
 
    /* VRAM implies WC. This is not optional. */
    assert(!(domain & RADEON_DOMAIN_VRAM) || flags & RADEON_FLAG_GTT_WC);
@@ -1189,19 +1196,23 @@ no_slab:
    size = align64(size, ws->info.gart_page_size);
    alignment = align(alignment, ws->info.gart_page_size);
 
-   int heap = radeon_get_heap_index(domain, flags);
-   assert(heap >= 0 && heap < RADEON_MAX_CACHED_HEAPS);
-   usage = 1 << heap; /* Only set one usage bit for each heap. */
+   bool use_reusable_pool = flags & RADEON_FLAG_NO_INTERPROCESS_SHARING;
 
-   pb_cache_bucket = radeon_get_pb_cache_bucket_index(heap);
-   assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
+   if (use_reusable_pool) {
+       int heap = radeon_get_heap_index(domain, flags);
+       assert(heap >= 0 && heap < RADEON_MAX_CACHED_HEAPS);
+       usage = 1 << heap; /* Only set one usage bit for each heap. */
 
-   /* Get a buffer from the cache. */
-   bo = (struct amdgpu_winsys_bo*)
-        pb_cache_reclaim_buffer(&ws->bo_cache, size, alignment, usage,
-                                pb_cache_bucket);
-   if (bo)
-      return &bo->base;
+       pb_cache_bucket = radeon_get_pb_cache_bucket_index(heap);
+       assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
+
+       /* Get a buffer from the cache. */
+       bo = (struct amdgpu_winsys_bo*)
+            pb_cache_reclaim_buffer(&ws->bo_cache, size, alignment, usage,
+                                    pb_cache_bucket);
+       if (bo)
+          return &bo->base;
+   }
 
    /* Create a new one. */
    bo = amdgpu_create_bo(ws, size, alignment, usage, domain, flags,
@@ -1216,7 +1227,7 @@ no_slab:
          return NULL;
    }
 
-   bo->u.real.use_reusable_pool = true;
+   bo->u.real.use_reusable_pool = use_reusable_pool;
    return &bo->base;
 }
 
diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_bo.h b/src/gallium/winsys/amdgpu/drm/amdgpu_bo.h
index 1311344..10b095d 100644
--- a/src/gallium/winsys/amdgpu/drm/amdgpu_bo.h
+++ b/src/gallium/winsys/amdgpu/drm/amdgpu_bo.h
@@ -115,6 +115,8 @@ struct amdgpu_winsys_bo {
    unsigned num_fences;
    unsigned max_fences;
    struct pipe_fence_handle **fences;
+
+   bool is_local;
 };
 
 struct amdgpu_slab {
diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
index 9cadfc4..7ec33c5 100644
--- a/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
+++ b/src/gallium/winsys/amdgpu/drm/amdgpu_cs.c
@@ -362,8 +362,9 @@ amdgpu_lookup_or_add_real_buffer(struct amdgpu_cs *acs, struct amdgpu_winsys_bo
 {
    struct amdgpu_cs_context *cs = acs->csc;
    unsigned hash;
-   int idx = amdgpu_lookup_buffer(cs, bo);
+   int idx;
 
+   idx = amdgpu_lookup_buffer(cs, bo);
    if (idx >= 0)
       return idx;
 
@@ -1123,6 +1124,8 @@ void amdgpu_cs_submit_ib(void *job, int thread_index)
       free(handles);
       mtx_unlock(&ws->global_bo_list_lock);
    } else {
+      unsigned num_handles;
+
       if (!amdgpu_add_sparse_backing_buffers(cs)) {
          r = -ENOMEM;
          goto bo_list_error;
@@ -1142,21 +1145,31 @@ void amdgpu_cs_submit_ib(void *job, int thread_index)
          }
       }
 
+      num_handles = 0;
       for (i = 0; i < cs->num_real_buffers; ++i) {
          struct amdgpu_cs_buffer *buffer = &cs->real_buffers[i];
 
+	 if (buffer->bo->is_local)
+            continue;
+
          assert(buffer->u.real.priority_usage != 0);
 
-         cs->handles[i] = buffer->bo->bo;
-         cs->flags[i] = (util_last_bit64(buffer->u.real.priority_usage) - 1) / 4;
+         cs->handles[num_handles] = buffer->bo->bo;
+         cs->flags[num_handles] = (util_last_bit64(buffer->u.real.priority_usage) - 1) / 4;
+	 ++num_handles;
       }
 
       if (acs->ring_type == RING_GFX)
          ws->gfx_bo_list_counter += cs->num_real_buffers;
 
-      r = amdgpu_bo_list_create(ws->dev, cs->num_real_buffers,
-                                cs->handles, cs->flags,
-                                &cs->request.resources);
+      if (num_handles) {
+         r = amdgpu_bo_list_create(ws->dev, num_handles,
+                                   cs->handles, cs->flags,
+                                   &cs->request.resources);
+      } else {
+         r = 0;
+	 cs->request.resources = 0;
+      }
    }
 bo_list_error:
 
diff --git a/src/gallium/winsys/radeon/drm/radeon_drm_bo.c b/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
index 8027a5f..15e9d38 100644
--- a/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
+++ b/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
@@ -914,7 +914,7 @@ radeon_winsys_bo_create(struct radeon_winsys *rws,
 {
     struct radeon_drm_winsys *ws = radeon_drm_winsys(rws);
     struct radeon_bo *bo;
-    unsigned usage = 0, pb_cache_bucket;
+    unsigned usage = 0, pb_cache_bucket = 0;
 
     assert(!(flags & RADEON_FLAG_SPARSE)); /* not supported */
 
@@ -969,17 +969,22 @@ no_slab:
     size = align(size, ws->info.gart_page_size);
     alignment = align(alignment, ws->info.gart_page_size);
 
-    int heap = radeon_get_heap_index(domain, flags);
-    assert(heap >= 0 && heap < RADEON_MAX_CACHED_HEAPS);
-    usage = 1 << heap; /* Only set one usage bit for each heap. */
+    bool use_reusable_pool = flags & RADEON_FLAG_NO_INTERPROCESS_SHARING;
 
-    pb_cache_bucket = radeon_get_pb_cache_bucket_index(heap);
-    assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
+    /* Shared resources don't use cached heaps. */
+    if (use_reusable_pool) {
+        int heap = radeon_get_heap_index(domain, flags);
+        assert(heap >= 0 && heap < RADEON_MAX_CACHED_HEAPS);
+        usage = 1 << heap; /* Only set one usage bit for each heap. */
 
-    bo = radeon_bo(pb_cache_reclaim_buffer(&ws->bo_cache, size, alignment,
-                                           usage, pb_cache_bucket));
-    if (bo)
-        return &bo->base;
+        pb_cache_bucket = radeon_get_pb_cache_bucket_index(heap);
+        assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
+
+        bo = radeon_bo(pb_cache_reclaim_buffer(&ws->bo_cache, size, alignment,
+                                               usage, pb_cache_bucket));
+        if (bo)
+            return &bo->base;
+    }
 
     bo = radeon_create_bo(ws, size, alignment, usage, domain, flags,
                           pb_cache_bucket);
@@ -994,7 +999,7 @@ no_slab:
             return NULL;
     }
 
-    bo->u.real.use_reusable_pool = true;
+    bo->u.real.use_reusable_pool = use_reusable_pool;
 
     mtx_lock(&ws->bo_handles_mutex);
     util_hash_table_set(ws->bo_handles, (void*)(uintptr_t)bo->handle, bo);
-- 
2.7.4


--------------AF6ADB70000B19CB4515BEF5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------AF6ADB70000B19CB4515BEF5--
