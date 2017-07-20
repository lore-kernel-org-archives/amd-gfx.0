From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [Mesa-dev] [RFC PATCH] radeonsi: set a per-buffer flag that
 disables inter-process sharing (v2)
Date: Thu, 20 Jul 2017 10:20:56 +0800
Message-ID: <59701388.5080909@amd.com>
References: <1500408524-925-1-git-send-email-maraeo@gmail.com>
 <596F0BD7.3070805@amd.com>
 <CAAxE2A5ygzBpB-56BowZ+iwf-wgistwY4Xo-puKM=cQ2bbQyEw@mail.gmail.com>
 <CAAxE2A5WYEdp7WSLB=UE82qER9aS05zfAQP+MTM6bjw+cOPJeQ@mail.gmail.com>
 <CAAxE2A60fT46jpntj=rCXTHrs0QXdNSFEnYdHVRuccd446+_pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1251262686=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A60fT46jpntj=rCXTHrs0QXdNSFEnYdHVRuccd446+_pA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1251262686==
Content-Type: multipart/alternative;
	boundary="------------030604010906070007030507"

--------------030604010906070007030507
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2017年07月19日 23:34, Marek Olšák wrote:
>
>
> On Jul 19, 2017 3:36 AM, "zhoucm1" <david1.zhou-5C7GfCeVMHo@public.gmane.org 
> <mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>
>
>     On 2017年07月19日 04:08, Marek Olšák wrote:
>
>         From: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org
>         <mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org>>
>
>         For lower overhead in the CS ioctl.
>         Winsys allocators are not used with interprocess-sharable
>         resources.
>
>     Hi Marek,
>
>     Could I know from how your this way reduces overhead in CS ioctl?
>     reusing BO to short bo list?
>
>
> The kernel part of the work hasn't been done yet. The idea is that 
> nonsharable buffers don't have to be revalidated by TTM,
OK, Maybe I only can see the whole picture of this idea when you 
complete kernel part.
Out of curious,  why/how can nonsharable buffers be revalidated by TTM 
without exposing like amdgpu_bo_make_resident api?

With mentioned in another thread, if we can expose make_resident api, we 
can remove bo_list, even we can remove reservation operation in CS ioctl.
And now, I think our bo list is a very bad design,
first, umd must create bo list for every command submission, this is a 
extra cpu overhead compared with traditional way.
second, kernel also have to iterate the list, when bo list is too long, 
like OpenCL program, they always throw several thousands BOs to bo list, 
reservation must keep these thousands ww_mutex safe, CPU overhead is too 
big.

So I strongly suggest we should expose make_resident api to user space. 
if cannot, I want to know any specific reason to see if we can solve it.


Regards,
David Zhou
> so it should remove a lot of kernel overhead and the BO list remains 
> the same.
>
> Marek
>
>
>
>     Thanks,
>     David Zhou
>
>
>         v2: It shouldn't crash anymore, but the kernel will reject the
>         new flag.
>         ---
>           src/gallium/drivers/radeon/r600_buffer_common.c |  7 +++++
>           src/gallium/drivers/radeon/radeon_winsys.h   | 20 +++++++++++---
>           src/gallium/winsys/amdgpu/drm/amdgpu_bo.c    | 36
>         ++++++++++++++++---------
>           src/gallium/winsys/radeon/drm/radeon_drm_bo.c  | 27
>         +++++++++++--------
>           4 files changed, 62 insertions(+), 28 deletions(-)
>
>         diff --git a/src/gallium/drivers/radeon/r600_buffer_common.c
>         b/src/gallium/drivers/radeon/r600_buffer_common.c
>         index dd1c209..2747ac4 100644
>         --- a/src/gallium/drivers/radeon/r600_buffer_common.c
>         +++ b/src/gallium/drivers/radeon/r600_buffer_common.c
>         @@ -160,20 +160,27 @@ void r600_init_resource_fields(struct
>         r600_common_screen *rscreen,
>                 }
>                 /* Tiled textures are unmappable. Always put them in
>         VRAM. */
>                 if ((res->b.b.target != PIPE_BUFFER &&
>         !rtex->surface.is_linear) ||
>                     res->flags & R600_RESOURCE_FLAG_UNMAPPABLE) {
>                         res->domains = RADEON_DOMAIN_VRAM;
>                         res->flags |= RADEON_FLAG_NO_CPU_ACCESS |
>                                  RADEON_FLAG_GTT_WC;
>                 }
>           +     /* Only displayable single-sample textures can be
>         shared between
>         +        * processes. */
>         +       if (res->b.b.target == PIPE_BUFFER ||
>         +           res->b.b.nr_samples >= 2 ||
>         +           rtex->surface.micro_tile_mode !=
>         RADEON_MICRO_MODE_DISPLAY)
>         +               res->flags |= RADEON_FLAG_NO_INTERPROCESS_SHARING;
>         +
>                 /* If VRAM is just stolen system memory, allow both
>         VRAM and
>                  * GTT, whichever has free space. If a buffer is
>         evicted from
>                  * VRAM to GTT, it will stay there.
>                  *
>                  * DRM 3.6.0 has good BO move throttling, so we can
>         allow VRAM-only
>                  * placements even with a low amount of stolen VRAM.
>                  */
>                 if (!rscreen->info.has_dedicated_vram &&
>                     (rscreen->info.drm_major < 3 ||
>         rscreen->info.drm_minor < 6) &&
>                     res->domains == RADEON_DOMAIN_VRAM) {
>         diff --git a/src/gallium/drivers/radeon/radeon_winsys.h
>         b/src/gallium/drivers/radeon/radeon_winsys.h
>         index 351edcd..0abcb56 100644
>         --- a/src/gallium/drivers/radeon/radeon_winsys.h
>         +++ b/src/gallium/drivers/radeon/radeon_winsys.h
>         @@ -47,20 +47,21 @@ enum radeon_bo_domain { /* bitfield */
>               RADEON_DOMAIN_GTT  = 2,
>               RADEON_DOMAIN_VRAM = 4,
>               RADEON_DOMAIN_VRAM_GTT = RADEON_DOMAIN_VRAM |
>         RADEON_DOMAIN_GTT
>           };
>             enum radeon_bo_flag { /* bitfield */
>               RADEON_FLAG_GTT_WC =        (1 << 0),
>               RADEON_FLAG_NO_CPU_ACCESS = (1 << 1),
>               RADEON_FLAG_NO_SUBALLOC =   (1 << 2),
>               RADEON_FLAG_SPARSE =        (1 << 3),
>         +    RADEON_FLAG_NO_INTERPROCESS_SHARING = (1 << 4),
>           };
>             enum radeon_bo_usage { /* bitfield */
>               RADEON_USAGE_READ = 2,
>               RADEON_USAGE_WRITE = 4,
>               RADEON_USAGE_READWRITE = RADEON_USAGE_READ |
>         RADEON_USAGE_WRITE,
>                 /* The winsys ensures that the CS submission will be
>         scheduled after
>                * previously flushed CSs referencing this BO in a
>         conflicting way.
>                */
>         @@ -685,28 +686,33 @@ static inline enum radeon_bo_domain
>         radeon_domain_from_heap(enum radeon_heap hea
>               default:
>                   assert(0);
>                   return (enum radeon_bo_domain)0;
>               }
>           }
>             static inline unsigned radeon_flags_from_heap(enum
>         radeon_heap heap)
>           {
>               switch (heap) {
>               case RADEON_HEAP_VRAM_NO_CPU_ACCESS:
>         -        return RADEON_FLAG_GTT_WC | RADEON_FLAG_NO_CPU_ACCESS;
>         +        return RADEON_FLAG_GTT_WC |
>         +               RADEON_FLAG_NO_CPU_ACCESS |
>         +               RADEON_FLAG_NO_INTERPROCESS_SHARING;
>         +
>               case RADEON_HEAP_VRAM:
>               case RADEON_HEAP_VRAM_GTT:
>               case RADEON_HEAP_GTT_WC:
>         -        return RADEON_FLAG_GTT_WC;
>         +        return RADEON_FLAG_GTT_WC |
>         +               RADEON_FLAG_NO_INTERPROCESS_SHARING;
>         +
>               case RADEON_HEAP_GTT:
>               default:
>         -        return 0;
>         +        return RADEON_FLAG_NO_INTERPROCESS_SHARING;
>               }
>           }
>             /* The pb cache bucket is chosen to minimize pb_cache misses.
>            * It must be between 0 and 3 inclusive.
>            */
>           static inline unsigned radeon_get_pb_cache_bucket_index(enum
>         radeon_heap heap)
>           {
>               switch (heap) {
>               case RADEON_HEAP_VRAM_NO_CPU_ACCESS:
>         @@ -724,22 +730,28 @@ static inline unsigned
>         radeon_get_pb_cache_bucket_index(enum radeon_heap heap)
>             /* Return the heap index for winsys allocators, or -1 on
>         failure. */
>           static inline int radeon_get_heap_index(enum
>         radeon_bo_domain domain,
>                                                   enum radeon_bo_flag
>         flags)
>           {
>               /* VRAM implies WC (write combining) */
>               assert(!(domain & RADEON_DOMAIN_VRAM) || flags &
>         RADEON_FLAG_GTT_WC);
>               /* NO_CPU_ACCESS implies VRAM only. */
>               assert(!(flags & RADEON_FLAG_NO_CPU_ACCESS) || domain ==
>         RADEON_DOMAIN_VRAM);
>           +    /* Resources with interprocess sharing don't use any
>         winsys allocators. */
>         +    if (!(flags & RADEON_FLAG_NO_INTERPROCESS_SHARING))
>         +        return -1;
>         +
>               /* Unsupported flags: NO_SUBALLOC, SPARSE. */
>         -    if (flags & ~(RADEON_FLAG_GTT_WC |
>         RADEON_FLAG_NO_CPU_ACCESS))
>         +    if (flags & ~(RADEON_FLAG_GTT_WC |
>         +                  RADEON_FLAG_NO_CPU_ACCESS |
>         +                  RADEON_FLAG_NO_INTERPROCESS_SHARING))
>                   return -1;
>                 switch (domain) {
>               case RADEON_DOMAIN_VRAM:
>                   if (flags & RADEON_FLAG_NO_CPU_ACCESS)
>                       return RADEON_HEAP_VRAM_NO_CPU_ACCESS;
>                   else
>                       return RADEON_HEAP_VRAM;
>               case RADEON_DOMAIN_VRAM_GTT:
>                   return RADEON_HEAP_VRAM_GTT;
>         diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
>         b/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
>         index 97bbe23..06b8198 100644
>         --- a/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
>         +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
>         @@ -31,20 +31,24 @@
>             #include "amdgpu_cs.h"
>             #include "os/os_time.h"
>           #include "state_tracker/drm_driver.h"
>           #include <amdgpu_drm.h>
>           #include <xf86drm.h>
>           #include <stdio.h>
>           #include <inttypes.h>
>           +#ifndef AMDGPU_GEM_CREATE_NO_INTERPROCESS_SHARING
>         +#define AMDGPU_GEM_CREATE_NO_INTERPROCESS_SHARING (1 << 6)
>         +#endif
>         +
>           /* Set to 1 for verbose output showing committed sparse
>         buffer ranges. */
>           #define DEBUG_SPARSE_COMMITS 0
>             struct amdgpu_sparse_backing_chunk {
>              uint32_t begin, end;
>           };
>             static struct pb_buffer *
>           amdgpu_bo_create(struct radeon_winsys *rws,
>                            uint64_t size,
>         @@ -395,20 +399,22 @@ static struct amdgpu_winsys_bo
>         *amdgpu_create_bo(struct amdgpu_winsys *ws,
>                if (initial_domain & RADEON_DOMAIN_VRAM)
>                 request.preferred_heap |= AMDGPU_GEM_DOMAIN_VRAM;
>              if (initial_domain & RADEON_DOMAIN_GTT)
>                 request.preferred_heap |= AMDGPU_GEM_DOMAIN_GTT;
>                if (flags & RADEON_FLAG_NO_CPU_ACCESS)
>                 request.flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>              if (flags & RADEON_FLAG_GTT_WC)
>                 request.flags |= AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>         +   if (flags & RADEON_FLAG_NO_INTERPROCESS_SHARING)
>         +      request.flags |= AMDGPU_GEM_CREATE_NO_INTERPROCESS_SHARING;
>                r = amdgpu_bo_alloc(ws->dev, &request, &buf_handle);
>              if (r) {
>                 fprintf(stderr, "amdgpu: Failed to allocate a buffer:\n");
>                 fprintf(stderr, "amdgpu:    size      : %"PRIu64"
>         bytes\n", size);
>                 fprintf(stderr, "amdgpu:    alignment : %u bytes\n",
>         alignment);
>                 fprintf(stderr, "amdgpu:    domains   : %u\n",
>         initial_domain);
>                 goto error_bo_alloc;
>              }
>           @@ -1127,21 +1133,21 @@ static void
>         amdgpu_buffer_set_metadata(struct pb_buffer *_buf,
>             static struct pb_buffer *
>           amdgpu_bo_create(struct radeon_winsys *rws,
>                            uint64_t size,
>                            unsigned alignment,
>                            enum radeon_bo_domain domain,
>                            enum radeon_bo_flag flags)
>           {
>              struct amdgpu_winsys *ws = amdgpu_winsys(rws);
>              struct amdgpu_winsys_bo *bo;
>         -   unsigned usage = 0, pb_cache_bucket;
>         +   unsigned usage = 0, pb_cache_bucket = 0;
>                /* VRAM implies WC. This is not optional. */
>              assert(!(domain & RADEON_DOMAIN_VRAM) || flags &
>         RADEON_FLAG_GTT_WC);
>                /* NO_CPU_ACCESS is valid with VRAM only. */
>              assert(domain == RADEON_DOMAIN_VRAM || !(flags &
>         RADEON_FLAG_NO_CPU_ACCESS));
>                /* Sub-allocate small buffers from slabs. */
>              if (!(flags & (RADEON_FLAG_NO_SUBALLOC |
>         RADEON_FLAG_SPARSE)) &&
>                  size <= (1 << AMDGPU_SLAB_MAX_SIZE_LOG2) &&
>         @@ -1182,48 +1188,52 @@ no_slab:
>              /* This flag is irrelevant for the cache. */
>              flags &= ~RADEON_FLAG_NO_SUBALLOC;
>                /* Align size to page size. This is the minimum
>         alignment for normal
>               * BOs. Aligning this here helps the cached bufmgr.
>         Especially small BOs,
>               * like constant/uniform buffers, can benefit from better
>         and more reuse.
>               */
>              size = align64(size, ws->info.gart_page_size);
>              alignment = align(alignment, ws->info.gart_page_size);
>           -   int heap = radeon_get_heap_index(domain, flags);
>         -   assert(heap >= 0 && heap < RADEON_MAX_CACHED_HEAPS);
>         -   usage = 1 << heap; /* Only set one usage bit for each heap. */
>         +   bool use_reusable_pool = flags &
>         RADEON_FLAG_NO_INTERPROCESS_SHARING;
>           -   pb_cache_bucket = radeon_get_pb_cache_bucket_index(heap);
>         -   assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
>         +   if (use_reusable_pool) {
>         +       int heap = radeon_get_heap_index(domain, flags);
>         +       assert(heap >= 0 && heap < RADEON_MAX_CACHED_HEAPS);
>         +       usage = 1 << heap; /* Only set one usage bit for each
>         heap. */
>           -   /* Get a buffer from the cache. */
>         -   bo = (struct amdgpu_winsys_bo*)
>         -        pb_cache_reclaim_buffer(&ws->bo_cache, size,
>         alignment, usage,
>         -                                pb_cache_bucket);
>         -   if (bo)
>         -      return &bo->base;
>         +       pb_cache_bucket = radeon_get_pb_cache_bucket_index(heap);
>         +       assert(pb_cache_bucket <
>         ARRAY_SIZE(ws->bo_cache.buckets));
>         +
>         +       /* Get a buffer from the cache. */
>         +       bo = (struct amdgpu_winsys_bo*)
>         +            pb_cache_reclaim_buffer(&ws->bo_cache, size,
>         alignment, usage,
>         + pb_cache_bucket);
>         +       if (bo)
>         +          return &bo->base;
>         +   }
>                /* Create a new one. */
>              bo = amdgpu_create_bo(ws, size, alignment, usage, domain,
>         flags,
>                                    pb_cache_bucket);
>              if (!bo) {
>                 /* Clear the cache and try again. */
>                 pb_slabs_reclaim(&ws->bo_slabs);
>                 pb_cache_release_all_buffers(&ws->bo_cache);
>                 bo = amdgpu_create_bo(ws, size, alignment, usage,
>         domain, flags,
>                                       pb_cache_bucket);
>                 if (!bo)
>                    return NULL;
>              }
>           -   bo->u.real.use_reusable_pool = true;
>         +   bo->u.real.use_reusable_pool = use_reusable_pool;
>              return &bo->base;
>           }
>             static struct pb_buffer *amdgpu_bo_from_handle(struct
>         radeon_winsys *rws,
>          struct winsys_handle *whandle,
>          unsigned *stride,
>          unsigned *offset)
>           {
>              struct amdgpu_winsys *ws = amdgpu_winsys(rws);
>              struct amdgpu_winsys_bo *bo;
>         diff --git a/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
>         b/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
>         index 8027a5f..15e9d38 100644
>         --- a/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
>         +++ b/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
>         @@ -907,21 +907,21 @@ static void
>         radeon_bo_set_metadata(struct pb_buffer *_buf,
>             static struct pb_buffer *
>           radeon_winsys_bo_create(struct radeon_winsys *rws,
>                                   uint64_t size,
>                                   unsigned alignment,
>                                   enum radeon_bo_domain domain,
>                                   enum radeon_bo_flag flags)
>           {
>               struct radeon_drm_winsys *ws = radeon_drm_winsys(rws);
>               struct radeon_bo *bo;
>         -    unsigned usage = 0, pb_cache_bucket;
>         +    unsigned usage = 0, pb_cache_bucket = 0;
>                 assert(!(flags & RADEON_FLAG_SPARSE)); /* not supported */
>                 /* Only 32-bit sizes are supported. */
>               if (size > UINT_MAX)
>                   return NULL;
>                 /* VRAM implies WC. This is not optional. */
>               if (domain & RADEON_DOMAIN_VRAM)
>                   flags |= RADEON_FLAG_GTT_WC;
>         @@ -962,46 +962,51 @@ no_slab:
>               /* This flag is irrelevant for the cache. */
>               flags &= ~RADEON_FLAG_NO_SUBALLOC;
>                 /* Align size to page size. This is the minimum
>         alignment for normal
>                * BOs. Aligning this here helps the cached bufmgr.
>         Especially small BOs,
>                * like constant/uniform buffers, can benefit from
>         better and more reuse.
>                */
>               size = align(size, ws->info.gart_page_size);
>               alignment = align(alignment, ws->info.gart_page_size);
>           -    int heap = radeon_get_heap_index(domain, flags);
>         -    assert(heap >= 0 && heap < RADEON_MAX_CACHED_HEAPS);
>         -    usage = 1 << heap; /* Only set one usage bit for each
>         heap. */
>         +    bool use_reusable_pool = flags &
>         RADEON_FLAG_NO_INTERPROCESS_SHARING;
>           -    pb_cache_bucket = radeon_get_pb_cache_bucket_index(heap);
>         -    assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
>         +    /* Shared resources don't use cached heaps. */
>         +    if (use_reusable_pool) {
>         +        int heap = radeon_get_heap_index(domain, flags);
>         +        assert(heap >= 0 && heap < RADEON_MAX_CACHED_HEAPS);
>         +        usage = 1 << heap; /* Only set one usage bit for each
>         heap. */
>           -    bo = radeon_bo(pb_cache_reclaim_buffer(&ws->bo_cache,
>         size, alignment,
>         -                                           usage,
>         pb_cache_bucket));
>         -    if (bo)
>         -        return &bo->base;
>         +        pb_cache_bucket = radeon_get_pb_cache_bucket_index(heap);
>         +        assert(pb_cache_bucket <
>         ARRAY_SIZE(ws->bo_cache.buckets));
>         +
>         +        bo = radeon_bo(pb_cache_reclaim_buffer(&ws->bo_cache,
>         size, alignment,
>         +  usage, pb_cache_bucket));
>         +        if (bo)
>         +            return &bo->base;
>         +    }
>                 bo = radeon_create_bo(ws, size, alignment, usage,
>         domain, flags,
>                                     pb_cache_bucket);
>               if (!bo) {
>                   /* Clear the cache and try again. */
>                   if (ws->info.has_virtual_memory)
>                       pb_slabs_reclaim(&ws->bo_slabs);
>                   pb_cache_release_all_buffers(&ws->bo_cache);
>                   bo = radeon_create_bo(ws, size, alignment, usage,
>         domain, flags,
>                                         pb_cache_bucket);
>                   if (!bo)
>                       return NULL;
>               }
>           -    bo->u.real.use_reusable_pool = true;
>         +    bo->u.real.use_reusable_pool = use_reusable_pool;
>                 mtx_lock(&ws->bo_handles_mutex);
>               util_hash_table_set(ws->bo_handles,
>         (void*)(uintptr_t)bo->handle, bo);
>               mtx_unlock(&ws->bo_handles_mutex);
>                 return &bo->base;
>           }
>             static struct pb_buffer *radeon_winsys_bo_from_ptr(struct
>         radeon_winsys *rws,
>          void *pointer, uint64_t size)
>
>
>


--------------030604010906070007030507
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2017年07月19日 23:34, Marek Olšák
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAAxE2A60fT46jpntj=rCXTHrs0QXdNSFEnYdHVRuccd446+_pA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="auto">
        <div><br>
          <div class="gmail_extra"><br>
            <div class="gmail_quote">On Jul 19, 2017 3:36 AM, "zhoucm1"
              &lt;<a moz-do-not-send="true"
                href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt;
              wrote:<br type="attribution">
              <blockquote class="quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <div class="quoted-text"><br>
                  <br>
                  On 2017年07月19日 04:08, Marek Olšák wrote:<br>
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    From: Marek Olšák &lt;<a moz-do-not-send="true"
                      href="mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" target="_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                    <br>
                    For lower overhead in the CS ioctl.<br>
                    Winsys allocators are not used with
                    interprocess-sharable resources.<br>
                  </blockquote>
                </div>
                Hi Marek,<br>
                <br>
                Could I know from how your this way reduces overhead in
                CS ioctl? reusing BO to short bo list?<br>
              </blockquote>
            </div>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">The kernel part of the work hasn't been done
          yet. The idea is that nonsharable buffers don't have to be
          revalidated by TTM,</div>
      </div>
    </blockquote>
    OK, Maybe I only can see the whole picture of this idea when you
    complete kernel part.<br>
    Out of curious,  why/how can nonsharable buffers be revalidated by
    TTM without exposing like amdgpu_bo_make_resident api?<br>
    <br>
    With mentioned in another thread, if we can expose make_resident
    api, we can remove bo_list, even we can remove reservation operation
    in CS ioctl.<br>
    And now, I think our bo list is a very bad design,<br>
    first, umd must create bo list for every command submission, this is
    a extra cpu overhead compared with traditional way.<br>
    second, kernel also have to iterate the list, when bo list is too
    long, like OpenCL program, they always throw several thousands BOs
    to bo list, reservation must keep these thousands ww_mutex safe, CPU
    overhead is too big.<br>
    <br>
    So I strongly suggest we should expose make_resident api to user
    space. if cannot, I want to know any specific reason to see if we
    can solve it.<br>
    <br>
    <br>
    Regards,<br>
    David Zhou<br>
    <blockquote
cite="mid:CAAxE2A60fT46jpntj=rCXTHrs0QXdNSFEnYdHVRuccd446+_pA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <div dir="auto">
        <div dir="auto"> so it should remove a lot of kernel overhead
          and the BO list remains the same.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_extra">
            <div class="gmail_quote">
              <blockquote class="quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <br>
                Thanks,<br>
                David Zhou
                <div class="elided-text"><br>
                  <blockquote class="gmail_quote" style="margin:0 0 0
                    .8ex;border-left:1px #ccc solid;padding-left:1ex">
                    <br>
                    v2: It shouldn't crash anymore, but the kernel will
                    reject the new flag.<br>
                    ---<br>
                      src/gallium/drivers/radeon/r60<wbr>0_buffer_common.c
                    |  7 +++++<br>
                      src/gallium/drivers/radeon/rad<wbr>eon_winsys.h   
                      | 20 +++++++++++---<br>
                      src/gallium/winsys/amdgpu/drm/<wbr>amdgpu_bo.c   
                       | 36 ++++++++++++++++---------<br>
                      src/gallium/winsys/radeon/drm/<wbr>radeon_drm_bo.c 
                     | 27 +++++++++++--------<br>
                      4 files changed, 62 insertions(+), 28 deletions(-)<br>
                    <br>
                    diff --git a/src/gallium/drivers/radeon/r<wbr>600_buffer_common.c
                    b/src/gallium/drivers/radeon/r<wbr>600_buffer_common.c<br>
                    index dd1c209..2747ac4 100644<br>
                    --- a/src/gallium/drivers/radeon/r<wbr>600_buffer_common.c<br>
                    +++ b/src/gallium/drivers/radeon/r<wbr>600_buffer_common.c<br>
                    @@ -160,20 +160,27 @@ void
                    r600_init_resource_fields(stru<wbr>ct
                    r600_common_screen *rscreen,<br>
                            }<br>
                            /* Tiled textures are unmappable. Always put
                    them in VRAM. */<br>
                            if ((res-&gt;b.b.target != PIPE_BUFFER
                    &amp;&amp; !rtex-&gt;surface.is_linear) ||<br>
                                res-&gt;flags &amp;
                    R600_RESOURCE_FLAG_UNMAPPABLE) {<br>
                                    res-&gt;domains =
                    RADEON_DOMAIN_VRAM;<br>
                                    res-&gt;flags |=
                    RADEON_FLAG_NO_CPU_ACCESS |<br>
                                             RADEON_FLAG_GTT_WC;<br>
                            }<br>
                      +     /* Only displayable single-sample textures
                    can be shared between<br>
                    +        * processes. */<br>
                    +       if (res-&gt;b.b.target == PIPE_BUFFER ||<br>
                    +           res-&gt;b.b.nr_samples &gt;= 2 ||<br>
                    +           rtex-&gt;surface.micro_tile_mode !=
                    RADEON_MICRO_MODE_DISPLAY)<br>
                    +               res-&gt;flags |=
                    RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING;<br>
                    +<br>
                            /* If VRAM is just stolen system memory,
                    allow both VRAM and<br>
                             * GTT, whichever has free space. If a
                    buffer is evicted from<br>
                             * VRAM to GTT, it will stay there.<br>
                             *<br>
                             * DRM 3.6.0 has good BO move throttling, so
                    we can allow VRAM-only<br>
                             * placements even with a low amount of
                    stolen VRAM.<br>
                             */<br>
                            if (!rscreen-&gt;info.has_dedicated_<wbr>vram
                    &amp;&amp;<br>
                                (rscreen-&gt;info.drm_major &lt; 3 ||
                    rscreen-&gt;info.drm_minor &lt; 6) &amp;&amp;<br>
                                res-&gt;domains == RADEON_DOMAIN_VRAM) {<br>
                    diff --git a/src/gallium/drivers/radeon/r<wbr>adeon_winsys.h
                    b/src/gallium/drivers/radeon/r<wbr>adeon_winsys.h<br>
                    index 351edcd..0abcb56 100644<br>
                    --- a/src/gallium/drivers/radeon/r<wbr>adeon_winsys.h<br>
                    +++ b/src/gallium/drivers/radeon/r<wbr>adeon_winsys.h<br>
                    @@ -47,20 +47,21 @@ enum radeon_bo_domain { /*
                    bitfield */<br>
                          RADEON_DOMAIN_GTT  = 2,<br>
                          RADEON_DOMAIN_VRAM = 4,<br>
                          RADEON_DOMAIN_VRAM_GTT = RADEON_DOMAIN_VRAM |
                    RADEON_DOMAIN_GTT<br>
                      };<br>
                        enum radeon_bo_flag { /* bitfield */<br>
                          RADEON_FLAG_GTT_WC =        (1 &lt;&lt; 0),<br>
                          RADEON_FLAG_NO_CPU_ACCESS = (1 &lt;&lt; 1),<br>
                          RADEON_FLAG_NO_SUBALLOC =   (1 &lt;&lt; 2),<br>
                          RADEON_FLAG_SPARSE =        (1 &lt;&lt; 3),<br>
                    +    RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING = (1
                    &lt;&lt; 4),<br>
                      };<br>
                        enum radeon_bo_usage { /* bitfield */<br>
                          RADEON_USAGE_READ = 2,<br>
                          RADEON_USAGE_WRITE = 4,<br>
                          RADEON_USAGE_READWRITE = RADEON_USAGE_READ |
                    RADEON_USAGE_WRITE,<br>
                            /* The winsys ensures that the CS submission
                    will be scheduled after<br>
                           * previously flushed CSs referencing this BO
                    in a conflicting way.<br>
                           */<br>
                    @@ -685,28 +686,33 @@ static inline enum
                    radeon_bo_domain radeon_domain_from_heap(enum
                    radeon_heap hea<br>
                          default:<br>
                              assert(0);<br>
                              return (enum radeon_bo_domain)0;<br>
                          }<br>
                      }<br>
                        static inline unsigned
                    radeon_flags_from_heap(enum radeon_heap heap)<br>
                      {<br>
                          switch (heap) {<br>
                          case RADEON_HEAP_VRAM_NO_CPU_ACCESS<wbr>:<br>
                    -        return RADEON_FLAG_GTT_WC |
                    RADEON_FLAG_NO_CPU_ACCESS;<br>
                    +        return RADEON_FLAG_GTT_WC |<br>
                    +               RADEON_FLAG_NO_CPU_ACCESS |<br>
                    +               RADEON_FLAG_NO_INTERPROCESS_S<wbr>HARING;<br>
                    +<br>
                          case RADEON_HEAP_VRAM:<br>
                          case RADEON_HEAP_VRAM_GTT:<br>
                          case RADEON_HEAP_GTT_WC:<br>
                    -        return RADEON_FLAG_GTT_WC;<br>
                    +        return RADEON_FLAG_GTT_WC |<br>
                    +               RADEON_FLAG_NO_INTERPROCESS_S<wbr>HARING;<br>
                    +<br>
                          case RADEON_HEAP_GTT:<br>
                          default:<br>
                    -        return 0;<br>
                    +        return RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING;<br>
                          }<br>
                      }<br>
                        /* The pb cache bucket is chosen to minimize
                    pb_cache misses.<br>
                       * It must be between 0 and 3 inclusive.<br>
                       */<br>
                      static inline unsigned
                    radeon_get_pb_cache_bucket_ind<wbr>ex(enum
                    radeon_heap heap)<br>
                      {<br>
                          switch (heap) {<br>
                          case RADEON_HEAP_VRAM_NO_CPU_ACCESS<wbr>:<br>
                    @@ -724,22 +730,28 @@ static inline unsigned
                    radeon_get_pb_cache_bucket_ind<wbr>ex(enum
                    radeon_heap heap)<br>
                        /* Return the heap index for winsys allocators,
                    or -1 on failure. */<br>
                      static inline int radeon_get_heap_index(enum
                    radeon_bo_domain domain,<br>
                                                              enum
                    radeon_bo_flag flags)<br>
                      {<br>
                          /* VRAM implies WC (write combining) */<br>
                          assert(!(domain &amp; RADEON_DOMAIN_VRAM) ||
                    flags &amp; RADEON_FLAG_GTT_WC);<br>
                          /* NO_CPU_ACCESS implies VRAM only. */<br>
                          assert(!(flags &amp;
                    RADEON_FLAG_NO_CPU_ACCESS) || domain ==
                    RADEON_DOMAIN_VRAM);<br>
                      +    /* Resources with interprocess sharing don't
                    use any winsys allocators. */<br>
                    +    if (!(flags &amp;
                    RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING))<br>
                    +        return -1;<br>
                    +<br>
                          /* Unsupported flags: NO_SUBALLOC, SPARSE. */<br>
                    -    if (flags &amp; ~(RADEON_FLAG_GTT_WC |
                    RADEON_FLAG_NO_CPU_ACCESS))<br>
                    +    if (flags &amp; ~(RADEON_FLAG_GTT_WC |<br>
                    +                  RADEON_FLAG_NO_CPU_ACCESS |<br>
                    +                  RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING))<br>
                              return -1;<br>
                            switch (domain) {<br>
                          case RADEON_DOMAIN_VRAM:<br>
                              if (flags &amp; RADEON_FLAG_NO_CPU_ACCESS)<br>
                                  return RADEON_HEAP_VRAM_NO_CPU_ACCESS<wbr>;<br>
                              else<br>
                                  return RADEON_HEAP_VRAM;<br>
                          case RADEON_DOMAIN_VRAM_GTT:<br>
                              return RADEON_HEAP_VRAM_GTT;<br>
                    diff --git a/src/gallium/winsys/amdgpu/dr<wbr>m/amdgpu_bo.c
                    b/src/gallium/winsys/amdgpu/dr<wbr>m/amdgpu_bo.c<br>
                    index 97bbe23..06b8198 100644<br>
                    --- a/src/gallium/winsys/amdgpu/dr<wbr>m/amdgpu_bo.c<br>
                    +++ b/src/gallium/winsys/amdgpu/dr<wbr>m/amdgpu_bo.c<br>
                    @@ -31,20 +31,24 @@<br>
                        #include "amdgpu_cs.h"<br>
                        #include "os/os_time.h"<br>
                      #include "state_tracker/drm_driver.h"<br>
                      #include &lt;amdgpu_drm.h&gt;<br>
                      #include &lt;xf86drm.h&gt;<br>
                      #include &lt;stdio.h&gt;<br>
                      #include &lt;inttypes.h&gt;<br>
                      +#ifndef AMDGPU_GEM_CREATE_NO_INTERPROC<wbr>ESS_SHARING<br>
                    +#define AMDGPU_GEM_CREATE_NO_INTERPROC<wbr>ESS_SHARING
                    (1 &lt;&lt; 6)<br>
                    +#endif<br>
                    +<br>
                      /* Set to 1 for verbose output showing committed
                    sparse buffer ranges. */<br>
                      #define DEBUG_SPARSE_COMMITS 0<br>
                        struct amdgpu_sparse_backing_chunk {<br>
                         uint32_t begin, end;<br>
                      };<br>
                        static struct pb_buffer *<br>
                      amdgpu_bo_create(struct radeon_winsys *rws,<br>
                                       uint64_t size,<br>
                    @@ -395,20 +399,22 @@ static struct amdgpu_winsys_bo
                    *amdgpu_create_bo(struct amdgpu_winsys *ws,<br>
                           if (initial_domain &amp; RADEON_DOMAIN_VRAM)<br>
                            request.preferred_heap |=
                    AMDGPU_GEM_DOMAIN_VRAM;<br>
                         if (initial_domain &amp; RADEON_DOMAIN_GTT)<br>
                            request.preferred_heap |=
                    AMDGPU_GEM_DOMAIN_GTT;<br>
                           if (flags &amp; RADEON_FLAG_NO_CPU_ACCESS)<br>
                            request.flags |=
                    AMDGPU_GEM_CREATE_NO_CPU_ACCES<wbr>S;<br>
                         if (flags &amp; RADEON_FLAG_GTT_WC)<br>
                            request.flags |=
                    AMDGPU_GEM_CREATE_CPU_GTT_USWC<wbr>;<br>
                    +   if (flags &amp; RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING)<br>
                    +      request.flags |=
                    AMDGPU_GEM_CREATE_NO_INTERPROC<wbr>ESS_SHARING;<br>
                           r = amdgpu_bo_alloc(ws-&gt;dev, &amp;request,
                    &amp;buf_handle);<br>
                         if (r) {<br>
                            fprintf(stderr, "amdgpu: Failed to allocate
                    a buffer:\n");<br>
                            fprintf(stderr, "amdgpu:    size      :
                    %"PRIu64" bytes\n", size);<br>
                            fprintf(stderr, "amdgpu:    alignment : %u
                    bytes\n", alignment);<br>
                            fprintf(stderr, "amdgpu:    domains   :
                    %u\n", initial_domain);<br>
                            goto error_bo_alloc;<br>
                         }<br>
                      @@ -1127,21 +1133,21 @@ static void
                    amdgpu_buffer_set_metadata(str<wbr>uct pb_buffer
                    *_buf,<br>
                        static struct pb_buffer *<br>
                      amdgpu_bo_create(struct radeon_winsys *rws,<br>
                                       uint64_t size,<br>
                                       unsigned alignment,<br>
                                       enum radeon_bo_domain domain,<br>
                                       enum radeon_bo_flag flags)<br>
                      {<br>
                         struct amdgpu_winsys *ws = amdgpu_winsys(rws);<br>
                         struct amdgpu_winsys_bo *bo;<br>
                    -   unsigned usage = 0, pb_cache_bucket;<br>
                    +   unsigned usage = 0, pb_cache_bucket = 0;<br>
                           /* VRAM implies WC. This is not optional. */<br>
                         assert(!(domain &amp; RADEON_DOMAIN_VRAM) ||
                    flags &amp; RADEON_FLAG_GTT_WC);<br>
                           /* NO_CPU_ACCESS is valid with VRAM only. */<br>
                         assert(domain == RADEON_DOMAIN_VRAM || !(flags
                    &amp; RADEON_FLAG_NO_CPU_ACCESS));<br>
                           /* Sub-allocate small buffers from slabs. */<br>
                         if (!(flags &amp; (RADEON_FLAG_NO_SUBALLOC |
                    RADEON_FLAG_SPARSE)) &amp;&amp;<br>
                             size &lt;= (1 &lt;&lt;
                    AMDGPU_SLAB_MAX_SIZE_LOG2) &amp;&amp;<br>
                    @@ -1182,48 +1188,52 @@ no_slab:<br>
                         /* This flag is irrelevant for the cache. */<br>
                         flags &amp;= ~RADEON_FLAG_NO_SUBALLOC;<br>
                           /* Align size to page size. This is the
                    minimum alignment for normal<br>
                          * BOs. Aligning this here helps the cached
                    bufmgr. Especially small BOs,<br>
                          * like constant/uniform buffers, can benefit
                    from better and more reuse.<br>
                          */<br>
                         size = align64(size,
                    ws-&gt;info.gart_page_size);<br>
                         alignment = align(alignment,
                    ws-&gt;info.gart_page_size);<br>
                      -   int heap = radeon_get_heap_index(domain,
                    flags);<br>
                    -   assert(heap &gt;= 0 &amp;&amp; heap &lt;
                    RADEON_MAX_CACHED_HEAPS);<br>
                    -   usage = 1 &lt;&lt; heap; /* Only set one usage
                    bit for each heap. */<br>
                    +   bool use_reusable_pool = flags &amp;
                    RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING;<br>
                      -   pb_cache_bucket =
                    radeon_get_pb_cache_bucket_ind<wbr>ex(heap);<br>
                    -   assert(pb_cache_bucket &lt;
                    ARRAY_SIZE(ws-&gt;bo_cache.bucket<wbr>s));<br>
                    +   if (use_reusable_pool) {<br>
                    +       int heap = radeon_get_heap_index(domain,
                    flags);<br>
                    +       assert(heap &gt;= 0 &amp;&amp; heap &lt;
                    RADEON_MAX_CACHED_HEAPS);<br>
                    +       usage = 1 &lt;&lt; heap; /* Only set one
                    usage bit for each heap. */<br>
                      -   /* Get a buffer from the cache. */<br>
                    -   bo = (struct amdgpu_winsys_bo*)<br>
                    -        pb_cache_reclaim_buffer(&amp;ws-&gt;b<wbr>o_cache,
                    size, alignment, usage,<br>
                    -                                pb_cache_bucket);<br>
                    -   if (bo)<br>
                    -      return &amp;bo-&gt;base;<br>
                    +       pb_cache_bucket =
                    radeon_get_pb_cache_bucket_ind<wbr>ex(heap);<br>
                    +       assert(pb_cache_bucket &lt;
                    ARRAY_SIZE(ws-&gt;bo_cache.bucket<wbr>s));<br>
                    +<br>
                    +       /* Get a buffer from the cache. */<br>
                    +       bo = (struct amdgpu_winsys_bo*)<br>
                    +            pb_cache_reclaim_buffer(&amp;ws-&gt;b<wbr>o_cache,
                    size, alignment, usage,<br>
                    +                                   
                    pb_cache_bucket);<br>
                    +       if (bo)<br>
                    +          return &amp;bo-&gt;base;<br>
                    +   }<br>
                           /* Create a new one. */<br>
                         bo = amdgpu_create_bo(ws, size, alignment,
                    usage, domain, flags,<br>
                                               pb_cache_bucket);<br>
                         if (!bo) {<br>
                            /* Clear the cache and try again. */<br>
                            pb_slabs_reclaim(&amp;ws-&gt;bo_slabs<wbr>);<br>
                            pb_cache_release_all_buffers(&amp;<wbr>ws-&gt;bo_cache);<br>
                            bo = amdgpu_create_bo(ws, size, alignment,
                    usage, domain, flags,<br>
                                                  pb_cache_bucket);<br>
                            if (!bo)<br>
                               return NULL;<br>
                         }<br>
                      -   bo-&gt;u.real.use_reusable_pool = true;<br>
                    +   bo-&gt;u.real.use_reusable_pool =
                    use_reusable_pool;<br>
                         return &amp;bo-&gt;base;<br>
                      }<br>
                        static struct pb_buffer
                    *amdgpu_bo_from_handle(struct radeon_winsys *rws,<br>
                                                                   
                     struct winsys_handle *whandle,<br>
                                                                   
                     unsigned *stride,<br>
                                                                   
                     unsigned *offset)<br>
                      {<br>
                         struct amdgpu_winsys *ws = amdgpu_winsys(rws);<br>
                         struct amdgpu_winsys_bo *bo;<br>
                    diff --git a/src/gallium/winsys/radeon/dr<wbr>m/radeon_drm_bo.c
                    b/src/gallium/winsys/radeon/dr<wbr>m/radeon_drm_bo.c<br>
                    index 8027a5f..15e9d38 100644<br>
                    --- a/src/gallium/winsys/radeon/dr<wbr>m/radeon_drm_bo.c<br>
                    +++ b/src/gallium/winsys/radeon/dr<wbr>m/radeon_drm_bo.c<br>
                    @@ -907,21 +907,21 @@ static void
                    radeon_bo_set_metadata(struct pb_buffer *_buf,<br>
                        static struct pb_buffer *<br>
                      radeon_winsys_bo_create(struct radeon_winsys *rws,<br>
                                              uint64_t size,<br>
                                              unsigned alignment,<br>
                                              enum radeon_bo_domain
                    domain,<br>
                                              enum radeon_bo_flag flags)<br>
                      {<br>
                          struct radeon_drm_winsys *ws =
                    radeon_drm_winsys(rws);<br>
                          struct radeon_bo *bo;<br>
                    -    unsigned usage = 0, pb_cache_bucket;<br>
                    +    unsigned usage = 0, pb_cache_bucket = 0;<br>
                            assert(!(flags &amp; RADEON_FLAG_SPARSE));
                    /* not supported */<br>
                            /* Only 32-bit sizes are supported. */<br>
                          if (size &gt; UINT_MAX)<br>
                              return NULL;<br>
                            /* VRAM implies WC. This is not optional. */<br>
                          if (domain &amp; RADEON_DOMAIN_VRAM)<br>
                              flags |= RADEON_FLAG_GTT_WC;<br>
                    @@ -962,46 +962,51 @@ no_slab:<br>
                          /* This flag is irrelevant for the cache. */<br>
                          flags &amp;= ~RADEON_FLAG_NO_SUBALLOC;<br>
                            /* Align size to page size. This is the
                    minimum alignment for normal<br>
                           * BOs. Aligning this here helps the cached
                    bufmgr. Especially small BOs,<br>
                           * like constant/uniform buffers, can benefit
                    from better and more reuse.<br>
                           */<br>
                          size = align(size,
                    ws-&gt;info.gart_page_size);<br>
                          alignment = align(alignment,
                    ws-&gt;info.gart_page_size);<br>
                      -    int heap = radeon_get_heap_index(domain,
                    flags);<br>
                    -    assert(heap &gt;= 0 &amp;&amp; heap &lt;
                    RADEON_MAX_CACHED_HEAPS);<br>
                    -    usage = 1 &lt;&lt; heap; /* Only set one usage
                    bit for each heap. */<br>
                    +    bool use_reusable_pool = flags &amp;
                    RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING;<br>
                      -    pb_cache_bucket =
                    radeon_get_pb_cache_bucket_ind<wbr>ex(heap);<br>
                    -    assert(pb_cache_bucket &lt;
                    ARRAY_SIZE(ws-&gt;bo_cache.bucket<wbr>s));<br>
                    +    /* Shared resources don't use cached heaps. */<br>
                    +    if (use_reusable_pool) {<br>
                    +        int heap = radeon_get_heap_index(domain,
                    flags);<br>
                    +        assert(heap &gt;= 0 &amp;&amp; heap &lt;
                    RADEON_MAX_CACHED_HEAPS);<br>
                    +        usage = 1 &lt;&lt; heap; /* Only set one
                    usage bit for each heap. */<br>
                      -    bo = radeon_bo(pb_cache_reclaim_buf<wbr>fer(&amp;ws-&gt;bo_cache,
                    size, alignment,<br>
                    -                                           usage,
                    pb_cache_bucket));<br>
                    -    if (bo)<br>
                    -        return &amp;bo-&gt;base;<br>
                    +        pb_cache_bucket =
                    radeon_get_pb_cache_bucket_ind<wbr>ex(heap);<br>
                    +        assert(pb_cache_bucket &lt;
                    ARRAY_SIZE(ws-&gt;bo_cache.bucket<wbr>s));<br>
                    +<br>
                    +        bo = radeon_bo(pb_cache_reclaim_buf<wbr>fer(&amp;ws-&gt;bo_cache,
                    size, alignment,<br>
                    +                                             
                     usage, pb_cache_bucket));<br>
                    +        if (bo)<br>
                    +            return &amp;bo-&gt;base;<br>
                    +    }<br>
                            bo = radeon_create_bo(ws, size, alignment,
                    usage, domain, flags,<br>
                                                pb_cache_bucket);<br>
                          if (!bo) {<br>
                              /* Clear the cache and try again. */<br>
                              if (ws-&gt;info.has_virtual_memory)<br>
                                  pb_slabs_reclaim(&amp;ws-&gt;bo_slabs<wbr>);<br>
                              pb_cache_release_all_buffers(&amp;<wbr>ws-&gt;bo_cache);<br>
                              bo = radeon_create_bo(ws, size, alignment,
                    usage, domain, flags,<br>
                                                    pb_cache_bucket);<br>
                              if (!bo)<br>
                                  return NULL;<br>
                          }<br>
                      -    bo-&gt;u.real.use_reusable_pool = true;<br>
                    +    bo-&gt;u.real.use_reusable_pool =
                    use_reusable_pool;<br>
                            mtx_lock(&amp;ws-&gt;bo_handles_mutex<wbr>);<br>
                          util_hash_table_set(ws-&gt;bo_han<wbr>dles,
                    (void*)(uintptr_t)bo-&gt;handle, bo);<br>
                          mtx_unlock(&amp;ws-&gt;bo_handles_mut<wbr>ex);<br>
                            return &amp;bo-&gt;base;<br>
                      }<br>
                        static struct pb_buffer
                    *radeon_winsys_bo_from_ptr(str<wbr>uct radeon_winsys
                    *rws,<br>
                                                                       
                     void *pointer, uint64_t size)<br>
                  </blockquote>
                  <br>
                </div>
              </blockquote>
            </div>
          </div>
          <div class="gmail_extra" dir="auto"><br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------030604010906070007030507--

--===============1251262686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1251262686==--
