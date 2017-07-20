From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Mesa-dev] [RFC PATCH] radeonsi: set a per-buffer flag that
 disables inter-process sharing (v2)
Date: Thu, 20 Jul 2017 10:59:42 -0400
Message-ID: <CAAxE2A6uFyqhWfJBNzojyMqFmk-AGyQmScwqScMjLutBQX5usA@mail.gmail.com>
References: <1500408524-925-1-git-send-email-maraeo@gmail.com>
 <596F0BD7.3070805@amd.com>
 <CAAxE2A5ygzBpB-56BowZ+iwf-wgistwY4Xo-puKM=cQ2bbQyEw@mail.gmail.com>
 <CAAxE2A5WYEdp7WSLB=UE82qER9aS05zfAQP+MTM6bjw+cOPJeQ@mail.gmail.com>
 <CAAxE2A60fT46jpntj=rCXTHrs0QXdNSFEnYdHVRuccd446+_pA@mail.gmail.com>
 <59701388.5080909@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0268658970=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <59701388.5080909-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: mesa-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0268658970==
Content-Type: multipart/alternative; boundary="94eb2c118822afb3a80554c0ff28"

--94eb2c118822afb3a80554c0ff28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Jul 19, 2017 10:21 PM, "zhoucm1" <david1.zhou-5C7GfCeVMHo@public.gmane.org> wrote:



On 2017=E5=B9=B407=E6=9C=8819=E6=97=A5 23:34, Marek Ol=C5=A1=C3=A1k wrote:



On Jul 19, 2017 3:36 AM, "zhoucm1" <david1.zhou-5C7GfCeVMHo@public.gmane.org> wrote:



On 2017=E5=B9=B407=E6=9C=8819=E6=97=A5 04:08, Marek Ol=C5=A1=C3=A1k wrote:

> From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>
> For lower overhead in the CS ioctl.
> Winsys allocators are not used with interprocess-sharable resources.
>
Hi Marek,

Could I know from how your this way reduces overhead in CS ioctl? reusing
BO to short bo list?


The kernel part of the work hasn't been done yet. The idea is that
nonsharable buffers don't have to be revalidated by TTM,

OK, Maybe I only can see the whole picture of this idea when you complete
kernel part.
Out of curious,  why/how can nonsharable buffers be revalidated by TTM
without exposing like amdgpu_bo_make_resident api?


I think the idea is that all nonsharable buffers will be backed by the same
reservation object, so TTM can skip buffer validation if no buffer has been
moved. It's just an optimization for the current design.


With mentioned in another thread, if we can expose make_resident api, we
can remove bo_list, even we can remove reservation operation in CS ioctl.
And now, I think our bo list is a very bad design,
first, umd must create bo list for every command submission, this is a
extra cpu overhead compared with traditional way.
second, kernel also have to iterate the list, when bo list is too long,
like OpenCL program, they always throw several thousands BOs to bo list,
reservation must keep these thousands ww_mutex safe, CPU overhead is too
big.

So I strongly suggest we should expose make_resident api to user space. if
cannot, I want to know any specific reason to see if we can solve it.


Yeah, I think the BO list idea is likely to die sooner or later. It made
sense for GL before bindless was a thing. Nowadays I don't see much value
in it.

MesaGL will keep tracking the BO list because it's a requirement for good
GL performance (it determines whether to flush IBs before BO
synchronization, it allows tracking fences for each BO, which are used to
determine dependencies between IBs, and that all allows async SDMA and
async compute for GL, which doesn't have separate queues).

However, we don't need any BO list at the libdrm level and lower. I think a
BO_CREATE flag that causes that the buffer is added to a kernel-side per-fd
BO list would be sufficient. How the kernel manages its BO list should be
its own implementation detail. Initially we can just move the current BO
list management into the kernel.

Marek





Regards,
David Zhou

so it should remove a lot of kernel overhead and the BO list remains the
same.

Marek



Thanks,
David Zhou


> v2: It shouldn't crash anymore, but the kernel will reject the new flag.
> ---
>   src/gallium/drivers/radeon/r600_buffer_common.c |  7 +++++
>   src/gallium/drivers/radeon/radeon_winsys.h      | 20 +++++++++++---
>   src/gallium/winsys/amdgpu/drm/amdgpu_bo.c       | 36
> ++++++++++++++++---------
>   src/gallium/winsys/radeon/drm/radeon_drm_bo.c   | 27 +++++++++++-------=
-
>   4 files changed, 62 insertions(+), 28 deletions(-)
>
> diff --git a/src/gallium/drivers/radeon/r600_buffer_common.c
> b/src/gallium/drivers/radeon/r600_buffer_common.c
> index dd1c209..2747ac4 100644
> --- a/src/gallium/drivers/radeon/r600_buffer_common.c
> +++ b/src/gallium/drivers/radeon/r600_buffer_common.c
> @@ -160,20 +160,27 @@ void r600_init_resource_fields(struct
> r600_common_screen *rscreen,
>         }
>         /* Tiled textures are unmappable. Always put them in VRAM. */
>         if ((res->b.b.target !=3D PIPE_BUFFER && !rtex->surface.is_linear=
) ||
>             res->flags & R600_RESOURCE_FLAG_UNMAPPABLE) {
>                 res->domains =3D RADEON_DOMAIN_VRAM;
>                 res->flags |=3D RADEON_FLAG_NO_CPU_ACCESS |
>                          RADEON_FLAG_GTT_WC;
>         }
>   +     /* Only displayable single-sample textures can be shared between
> +        * processes. */
> +       if (res->b.b.target =3D=3D PIPE_BUFFER ||
> +           res->b.b.nr_samples >=3D 2 ||
> +           rtex->surface.micro_tile_mode !=3D RADEON_MICRO_MODE_DISPLAY)
> +               res->flags |=3D RADEON_FLAG_NO_INTERPROCESS_SHARING;
> +
>         /* If VRAM is just stolen system memory, allow both VRAM and
>          * GTT, whichever has free space. If a buffer is evicted from
>          * VRAM to GTT, it will stay there.
>          *
>          * DRM 3.6.0 has good BO move throttling, so we can allow VRAM-on=
ly
>          * placements even with a low amount of stolen VRAM.
>          */
>         if (!rscreen->info.has_dedicated_vram &&
>             (rscreen->info.drm_major < 3 || rscreen->info.drm_minor < 6) =
&&
>             res->domains =3D=3D RADEON_DOMAIN_VRAM) {
> diff --git a/src/gallium/drivers/radeon/radeon_winsys.h
> b/src/gallium/drivers/radeon/radeon_winsys.h
> index 351edcd..0abcb56 100644
> --- a/src/gallium/drivers/radeon/radeon_winsys.h
> +++ b/src/gallium/drivers/radeon/radeon_winsys.h
> @@ -47,20 +47,21 @@ enum radeon_bo_domain { /* bitfield */
>       RADEON_DOMAIN_GTT  =3D 2,
>       RADEON_DOMAIN_VRAM =3D 4,
>       RADEON_DOMAIN_VRAM_GTT =3D RADEON_DOMAIN_VRAM | RADEON_DOMAIN_GTT
>   };
>     enum radeon_bo_flag { /* bitfield */
>       RADEON_FLAG_GTT_WC =3D        (1 << 0),
>       RADEON_FLAG_NO_CPU_ACCESS =3D (1 << 1),
>       RADEON_FLAG_NO_SUBALLOC =3D   (1 << 2),
>       RADEON_FLAG_SPARSE =3D        (1 << 3),
> +    RADEON_FLAG_NO_INTERPROCESS_SHARING =3D (1 << 4),
>   };
>     enum radeon_bo_usage { /* bitfield */
>       RADEON_USAGE_READ =3D 2,
>       RADEON_USAGE_WRITE =3D 4,
>       RADEON_USAGE_READWRITE =3D RADEON_USAGE_READ | RADEON_USAGE_WRITE,
>         /* The winsys ensures that the CS submission will be scheduled
> after
>        * previously flushed CSs referencing this BO in a conflicting way.
>        */
> @@ -685,28 +686,33 @@ static inline enum radeon_bo_domain
> radeon_domain_from_heap(enum radeon_heap hea
>       default:
>           assert(0);
>           return (enum radeon_bo_domain)0;
>       }
>   }
>     static inline unsigned radeon_flags_from_heap(enum radeon_heap heap)
>   {
>       switch (heap) {
>       case RADEON_HEAP_VRAM_NO_CPU_ACCESS:
> -        return RADEON_FLAG_GTT_WC | RADEON_FLAG_NO_CPU_ACCESS;
> +        return RADEON_FLAG_GTT_WC |
> +               RADEON_FLAG_NO_CPU_ACCESS |
> +               RADEON_FLAG_NO_INTERPROCESS_SHARING;
> +
>       case RADEON_HEAP_VRAM:
>       case RADEON_HEAP_VRAM_GTT:
>       case RADEON_HEAP_GTT_WC:
> -        return RADEON_FLAG_GTT_WC;
> +        return RADEON_FLAG_GTT_WC |
> +               RADEON_FLAG_NO_INTERPROCESS_SHARING;
> +
>       case RADEON_HEAP_GTT:
>       default:
> -        return 0;
> +        return RADEON_FLAG_NO_INTERPROCESS_SHARING;
>       }
>   }
>     /* The pb cache bucket is chosen to minimize pb_cache misses.
>    * It must be between 0 and 3 inclusive.
>    */
>   static inline unsigned radeon_get_pb_cache_bucket_index(enum
> radeon_heap heap)
>   {
>       switch (heap) {
>       case RADEON_HEAP_VRAM_NO_CPU_ACCESS:
> @@ -724,22 +730,28 @@ static inline unsigned radeon_get_pb_cache_bucket_i=
ndex(enum
> radeon_heap heap)
>     /* Return the heap index for winsys allocators, or -1 on failure. */
>   static inline int radeon_get_heap_index(enum radeon_bo_domain domain,
>                                           enum radeon_bo_flag flags)
>   {
>       /* VRAM implies WC (write combining) */
>       assert(!(domain & RADEON_DOMAIN_VRAM) || flags & RADEON_FLAG_GTT_WC=
);
>       /* NO_CPU_ACCESS implies VRAM only. */
>       assert(!(flags & RADEON_FLAG_NO_CPU_ACCESS) || domain =3D=3D
> RADEON_DOMAIN_VRAM);
>   +    /* Resources with interprocess sharing don't use any winsys
> allocators. */
> +    if (!(flags & RADEON_FLAG_NO_INTERPROCESS_SHARING))
> +        return -1;
> +
>       /* Unsupported flags: NO_SUBALLOC, SPARSE. */
> -    if (flags & ~(RADEON_FLAG_GTT_WC | RADEON_FLAG_NO_CPU_ACCESS))
> +    if (flags & ~(RADEON_FLAG_GTT_WC |
> +                  RADEON_FLAG_NO_CPU_ACCESS |
> +                  RADEON_FLAG_NO_INTERPROCESS_SHARING))
>           return -1;
>         switch (domain) {
>       case RADEON_DOMAIN_VRAM:
>           if (flags & RADEON_FLAG_NO_CPU_ACCESS)
>               return RADEON_HEAP_VRAM_NO_CPU_ACCESS;
>           else
>               return RADEON_HEAP_VRAM;
>       case RADEON_DOMAIN_VRAM_GTT:
>           return RADEON_HEAP_VRAM_GTT;
> diff --git a/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
> b/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
> index 97bbe23..06b8198 100644
> --- a/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
> +++ b/src/gallium/winsys/amdgpu/drm/amdgpu_bo.c
> @@ -31,20 +31,24 @@
>     #include "amdgpu_cs.h"
>     #include "os/os_time.h"
>   #include "state_tracker/drm_driver.h"
>   #include <amdgpu_drm.h>
>   #include <xf86drm.h>
>   #include <stdio.h>
>   #include <inttypes.h>
>   +#ifndef AMDGPU_GEM_CREATE_NO_INTERPROCESS_SHARING
> +#define AMDGPU_GEM_CREATE_NO_INTERPROCESS_SHARING (1 << 6)
> +#endif
> +
>   /* Set to 1 for verbose output showing committed sparse buffer ranges. =
*/
>   #define DEBUG_SPARSE_COMMITS 0
>     struct amdgpu_sparse_backing_chunk {
>      uint32_t begin, end;
>   };
>     static struct pb_buffer *
>   amdgpu_bo_create(struct radeon_winsys *rws,
>                    uint64_t size,
> @@ -395,20 +399,22 @@ static struct amdgpu_winsys_bo
> *amdgpu_create_bo(struct amdgpu_winsys *ws,
>        if (initial_domain & RADEON_DOMAIN_VRAM)
>         request.preferred_heap |=3D AMDGPU_GEM_DOMAIN_VRAM;
>      if (initial_domain & RADEON_DOMAIN_GTT)
>         request.preferred_heap |=3D AMDGPU_GEM_DOMAIN_GTT;
>        if (flags & RADEON_FLAG_NO_CPU_ACCESS)
>         request.flags |=3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>      if (flags & RADEON_FLAG_GTT_WC)
>         request.flags |=3D AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +   if (flags & RADEON_FLAG_NO_INTERPROCESS_SHARING)
> +      request.flags |=3D AMDGPU_GEM_CREATE_NO_INTERPROCESS_SHARING;
>        r =3D amdgpu_bo_alloc(ws->dev, &request, &buf_handle);
>      if (r) {
>         fprintf(stderr, "amdgpu: Failed to allocate a buffer:\n");
>         fprintf(stderr, "amdgpu:    size      : %"PRIu64" bytes\n", size)=
;
>         fprintf(stderr, "amdgpu:    alignment : %u bytes\n", alignment);
>         fprintf(stderr, "amdgpu:    domains   : %u\n", initial_domain);
>         goto error_bo_alloc;
>      }
>   @@ -1127,21 +1133,21 @@ static void amdgpu_buffer_set_metadata(struct
> pb_buffer *_buf,
>     static struct pb_buffer *
>   amdgpu_bo_create(struct radeon_winsys *rws,
>                    uint64_t size,
>                    unsigned alignment,
>                    enum radeon_bo_domain domain,
>                    enum radeon_bo_flag flags)
>   {
>      struct amdgpu_winsys *ws =3D amdgpu_winsys(rws);
>      struct amdgpu_winsys_bo *bo;
> -   unsigned usage =3D 0, pb_cache_bucket;
> +   unsigned usage =3D 0, pb_cache_bucket =3D 0;
>        /* VRAM implies WC. This is not optional. */
>      assert(!(domain & RADEON_DOMAIN_VRAM) || flags & RADEON_FLAG_GTT_WC)=
;
>        /* NO_CPU_ACCESS is valid with VRAM only. */
>      assert(domain =3D=3D RADEON_DOMAIN_VRAM || !(flags &
> RADEON_FLAG_NO_CPU_ACCESS));
>        /* Sub-allocate small buffers from slabs. */
>      if (!(flags & (RADEON_FLAG_NO_SUBALLOC | RADEON_FLAG_SPARSE)) &&
>          size <=3D (1 << AMDGPU_SLAB_MAX_SIZE_LOG2) &&
> @@ -1182,48 +1188,52 @@ no_slab:
>      /* This flag is irrelevant for the cache. */
>      flags &=3D ~RADEON_FLAG_NO_SUBALLOC;
>        /* Align size to page size. This is the minimum alignment for norm=
al
>       * BOs. Aligning this here helps the cached bufmgr. Especially small
> BOs,
>       * like constant/uniform buffers, can benefit from better and more
> reuse.
>       */
>      size =3D align64(size, ws->info.gart_page_size);
>      alignment =3D align(alignment, ws->info.gart_page_size);
>   -   int heap =3D radeon_get_heap_index(domain, flags);
> -   assert(heap >=3D 0 && heap < RADEON_MAX_CACHED_HEAPS);
> -   usage =3D 1 << heap; /* Only set one usage bit for each heap. */
> +   bool use_reusable_pool =3D flags & RADEON_FLAG_NO_INTERPROCESS_SHARIN=
G;
>   -   pb_cache_bucket =3D radeon_get_pb_cache_bucket_index(heap);
> -   assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
> +   if (use_reusable_pool) {
> +       int heap =3D radeon_get_heap_index(domain, flags);
> +       assert(heap >=3D 0 && heap < RADEON_MAX_CACHED_HEAPS);
> +       usage =3D 1 << heap; /* Only set one usage bit for each heap. */
>   -   /* Get a buffer from the cache. */
> -   bo =3D (struct amdgpu_winsys_bo*)
> -        pb_cache_reclaim_buffer(&ws->bo_cache, size, alignment, usage,
> -                                pb_cache_bucket);
> -   if (bo)
> -      return &bo->base;
> +       pb_cache_bucket =3D radeon_get_pb_cache_bucket_index(heap);
> +       assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
> +
> +       /* Get a buffer from the cache. */
> +       bo =3D (struct amdgpu_winsys_bo*)
> +            pb_cache_reclaim_buffer(&ws->bo_cache, size, alignment,
> usage,
> +                                    pb_cache_bucket);
> +       if (bo)
> +          return &bo->base;
> +   }
>        /* Create a new one. */
>      bo =3D amdgpu_create_bo(ws, size, alignment, usage, domain, flags,
>                            pb_cache_bucket);
>      if (!bo) {
>         /* Clear the cache and try again. */
>         pb_slabs_reclaim(&ws->bo_slabs);
>         pb_cache_release_all_buffers(&ws->bo_cache);
>         bo =3D amdgpu_create_bo(ws, size, alignment, usage, domain, flags=
,
>                               pb_cache_bucket);
>         if (!bo)
>            return NULL;
>      }
>   -   bo->u.real.use_reusable_pool =3D true;
> +   bo->u.real.use_reusable_pool =3D use_reusable_pool;
>      return &bo->base;
>   }
>     static struct pb_buffer *amdgpu_bo_from_handle(struct radeon_winsys
> *rws,
>                                                  struct winsys_handle
> *whandle,
>                                                  unsigned *stride,
>                                                  unsigned *offset)
>   {
>      struct amdgpu_winsys *ws =3D amdgpu_winsys(rws);
>      struct amdgpu_winsys_bo *bo;
> diff --git a/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
> b/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
> index 8027a5f..15e9d38 100644
> --- a/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
> +++ b/src/gallium/winsys/radeon/drm/radeon_drm_bo.c
> @@ -907,21 +907,21 @@ static void radeon_bo_set_metadata(struct pb_buffer
> *_buf,
>     static struct pb_buffer *
>   radeon_winsys_bo_create(struct radeon_winsys *rws,
>                           uint64_t size,
>                           unsigned alignment,
>                           enum radeon_bo_domain domain,
>                           enum radeon_bo_flag flags)
>   {
>       struct radeon_drm_winsys *ws =3D radeon_drm_winsys(rws);
>       struct radeon_bo *bo;
> -    unsigned usage =3D 0, pb_cache_bucket;
> +    unsigned usage =3D 0, pb_cache_bucket =3D 0;
>         assert(!(flags & RADEON_FLAG_SPARSE)); /* not supported */
>         /* Only 32-bit sizes are supported. */
>       if (size > UINT_MAX)
>           return NULL;
>         /* VRAM implies WC. This is not optional. */
>       if (domain & RADEON_DOMAIN_VRAM)
>           flags |=3D RADEON_FLAG_GTT_WC;
> @@ -962,46 +962,51 @@ no_slab:
>       /* This flag is irrelevant for the cache. */
>       flags &=3D ~RADEON_FLAG_NO_SUBALLOC;
>         /* Align size to page size. This is the minimum alignment for
> normal
>        * BOs. Aligning this here helps the cached bufmgr. Especially smal=
l
> BOs,
>        * like constant/uniform buffers, can benefit from better and more
> reuse.
>        */
>       size =3D align(size, ws->info.gart_page_size);
>       alignment =3D align(alignment, ws->info.gart_page_size);
>   -    int heap =3D radeon_get_heap_index(domain, flags);
> -    assert(heap >=3D 0 && heap < RADEON_MAX_CACHED_HEAPS);
> -    usage =3D 1 << heap; /* Only set one usage bit for each heap. */
> +    bool use_reusable_pool =3D flags & RADEON_FLAG_NO_INTERPROCESS_SHARI=
NG;
>   -    pb_cache_bucket =3D radeon_get_pb_cache_bucket_index(heap);
> -    assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
> +    /* Shared resources don't use cached heaps. */
> +    if (use_reusable_pool) {
> +        int heap =3D radeon_get_heap_index(domain, flags);
> +        assert(heap >=3D 0 && heap < RADEON_MAX_CACHED_HEAPS);
> +        usage =3D 1 << heap; /* Only set one usage bit for each heap. */
>   -    bo =3D radeon_bo(pb_cache_reclaim_buffer(&ws->bo_cache, size,
> alignment,
> -                                           usage, pb_cache_bucket));
> -    if (bo)
> -        return &bo->base;
> +        pb_cache_bucket =3D radeon_get_pb_cache_bucket_index(heap);
> +        assert(pb_cache_bucket < ARRAY_SIZE(ws->bo_cache.buckets));
> +
> +        bo =3D radeon_bo(pb_cache_reclaim_buffer(&ws->bo_cache, size,
> alignment,
> +                                               usage, pb_cache_bucket));
> +        if (bo)
> +            return &bo->base;
> +    }
>         bo =3D radeon_create_bo(ws, size, alignment, usage, domain, flags=
,
>                             pb_cache_bucket);
>       if (!bo) {
>           /* Clear the cache and try again. */
>           if (ws->info.has_virtual_memory)
>               pb_slabs_reclaim(&ws->bo_slabs);
>           pb_cache_release_all_buffers(&ws->bo_cache);
>           bo =3D radeon_create_bo(ws, size, alignment, usage, domain, fla=
gs,
>                                 pb_cache_bucket);
>           if (!bo)
>               return NULL;
>       }
>   -    bo->u.real.use_reusable_pool =3D true;
> +    bo->u.real.use_reusable_pool =3D use_reusable_pool;
>         mtx_lock(&ws->bo_handles_mutex);
>       util_hash_table_set(ws->bo_handles, (void*)(uintptr_t)bo->handle,
> bo);
>       mtx_unlock(&ws->bo_handles_mutex);
>         return &bo->base;
>   }
>     static struct pb_buffer *radeon_winsys_bo_from_ptr(struct
> radeon_winsys *rws,
>                                                      void *pointer,
> uint64_t size)
>

--94eb2c118822afb3a80554c0ff28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Jul 19, 2017 10:21 PM, &quot;zhoucm1&quot; &lt;<a href=3D"mail=
to:david1.zhou-5C7GfCeVMHo@public.gmane.org">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br type=3D"attri=
bution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><div class=3D"quoted-text">
    <br>
    <br>
    <div class=3D"m_-6147598457318751040moz-cite-prefix">On 2017=E5=B9=B407=
=E6=9C=8819=E6=97=A5 23:34, Marek Ol=C5=A1=C3=A1k
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">
        <div><br>
          <div class=3D"gmail_extra"><br>
            <div class=3D"gmail_quote">On Jul 19, 2017 3:36 AM, &quot;zhouc=
m1&quot;
              &lt;<a href=3D"mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">=
david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt;
              wrote:<br type=3D"attribution">
              <blockquote class=3D"m_-6147598457318751040quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <div class=3D"m_-6147598457318751040quoted-text"><br>
                  <br>
                  On 2017=E5=B9=B407=E6=9C=8819=E6=97=A5 04:08, Marek Ol=C5=
=A1=C3=A1k wrote:<br>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
                    From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek=
.olsak-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
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
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">The kernel part of the work hasn&#39;t been done
          yet. The idea is that nonsharable buffers don&#39;t have to be
          revalidated by TTM,</div>
      </div>
    </blockquote></div>
    OK, Maybe I only can see the whole picture of this idea when you
    complete kernel part.<br>
    Out of curious,=C2=A0 why/how can nonsharable buffers be revalidated by
    TTM without exposing like amdgpu_bo_make_resident api?<br></div></block=
quote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I thi=
nk the idea is that all nonsharable buffers will be backed by the same rese=
rvation object, so TTM can skip buffer validation if no buffer has been mov=
ed. It&#39;s just an optimization for the current design.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"=
gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div text=3D"#000000" bgcolor=3D"#FFF=
FFF">
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
    can solve it.<br></div></blockquote></div></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Yeah, I think the BO list idea is likely to di=
e sooner or later. It made sense for GL before bindless was a thing. Nowada=
ys I don&#39;t see much value in it.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">MesaGL will keep tracking the BO list because it&#39;s a requi=
rement for good GL performance (it determines whether to flush IBs before B=
O synchronization, it allows tracking fences for each BO, which are used to=
 determine dependencies between IBs, and that all allows async SDMA and asy=
nc compute for GL, which doesn&#39;t have separate queues).</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">However, we don&#39;t need any BO lis=
t at the libdrm level and lower. I think a BO_CREATE flag that causes that =
the buffer is added to a kernel-side per-fd BO list would be sufficient. Ho=
w the kernel manages its BO list should be its own implementation detail. I=
nitially we can just move the current BO list management into the kernel.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Marek</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockqu=
ote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <br>
    <br>
    Regards,<br>
    David Zhou<div class=3D"elided-text"><br>
    <blockquote type=3D"cite">
      <div dir=3D"auto">
        <div dir=3D"auto"> so it should remove a lot of kernel overhead
          and the BO list remains the same.</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Marek</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">
          <div class=3D"gmail_extra">
            <div class=3D"gmail_quote">
              <blockquote class=3D"m_-6147598457318751040quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <br>
                Thanks,<br>
                David Zhou
                <div class=3D"m_-6147598457318751040elided-text"><br>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
                    <br>
                    v2: It shouldn&#39;t crash anymore, but the kernel will
                    reject the new flag.<br>
                    ---<br>
                    =C2=A0 src/gallium/drivers/radeon/r60<wbr>0_buffer_comm=
on.c
                    |=C2=A0 7 +++++<br>
                    =C2=A0 src/gallium/drivers/radeon/rad<wbr>eon_winsys.h=
=C2=A0 =C2=A0
                    =C2=A0 | 20 +++++++++++---<br>
                    =C2=A0 src/gallium/winsys/amdgpu/drm/<wbr>amdgpu_bo.c=
=C2=A0 =C2=A0
                    =C2=A0 =C2=A0| 36 ++++++++++++++++---------<br>
                    =C2=A0 src/gallium/winsys/radeon/drm/<wbr>radeon_drm_bo=
.c=C2=A0
                    =C2=A0| 27 +++++++++++--------<br>
                    =C2=A0 4 files changed, 62 insertions(+), 28 deletions(=
-)<br>
                    <br>
                    diff --git a/src/gallium/drivers/radeon/r<wbr>600_buffe=
r_common.c
                    b/src/gallium/drivers/radeon/r<wbr>600_buffer_common.c<=
br>
                    index dd1c209..2747ac4 100644<br>
                    --- a/src/gallium/drivers/radeon/r<wbr>600_buffer_commo=
n.c<br>
                    +++ b/src/gallium/drivers/radeon/r<wbr>600_buffer_commo=
n.c<br>
                    @@ -160,20 +160,27 @@ void
                    r600_init_resource_fields(stru<wbr>ct
                    r600_common_screen *rscreen,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Tiled textures are unmap=
pable. Always put
                    them in VRAM. */<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((res-&gt;b.b.target !=
=3D PIPE_BUFFER
                    &amp;&amp; !rtex-&gt;surface.is_linear) ||<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;flags=
 &amp;
                    R600_RESOURCE_FLAG_UNMAPPABLE) {<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 res-&gt;domains =3D
                    RADEON_DOMAIN_VRAM;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 res-&gt;flags |=3D
                    RADEON_FLAG_NO_CPU_ACCESS |<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RADEON_FLAG_GTT_WC;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
                    =C2=A0 +=C2=A0 =C2=A0 =C2=A0/* Only displayable single-=
sample textures
                    can be shared between<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * processes. */<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (res-&gt;b.b.target =3D=
=3D PIPE_BUFFER ||<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res-&gt;b.b.n=
r_samples &gt;=3D 2 ||<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rtex-&gt;surf=
ace.micro_tile_mode !=3D
                    RADEON_MICRO_MODE_DISPLAY)<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0res-&gt;flags |=3D
                    RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING;<br>
                    +<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If VRAM is just stolen s=
ystem memory,
                    allow both VRAM and<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* GTT, whichever has =
free space. If a
                    buffer is evicted from<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* VRAM to GTT, it wil=
l stay there.<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* DRM 3.6.0 has good =
BO move throttling, so
                    we can allow VRAM-only<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* placements even wit=
h a low amount of
                    stolen VRAM.<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!rscreen-&gt;info.has_d=
edicated_<wbr>vram
                    &amp;&amp;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (rscreen-&gt;=
info.drm_major &lt; 3 ||
                    rscreen-&gt;info.drm_minor &lt; 6) &amp;&amp;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;domai=
ns =3D=3D RADEON_DOMAIN_VRAM) {<br>
                    diff --git a/src/gallium/drivers/radeon/r<wbr>adeon_win=
sys.h
                    b/src/gallium/drivers/radeon/r<wbr>adeon_winsys.h<br>
                    index 351edcd..0abcb56 100644<br>
                    --- a/src/gallium/drivers/radeon/r<wbr>adeon_winsys.h<b=
r>
                    +++ b/src/gallium/drivers/radeon/r<wbr>adeon_winsys.h<b=
r>
                    @@ -47,20 +47,21 @@ enum radeon_bo_domain { /*
                    bitfield */<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_DOMAIN_GTT=C2=A0 =3D 2,<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_DOMAIN_VRAM =3D 4,<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_DOMAIN_VRAM_GTT =3D RADEON_=
DOMAIN_VRAM |
                    RADEON_DOMAIN_GTT<br>
                    =C2=A0 };<br>
                    =C2=A0 =C2=A0 enum radeon_bo_flag { /* bitfield */<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_FLAG_GTT_WC =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0),<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_FLAG_NO_CPU_ACCESS =3D (1 &=
lt;&lt; 1),<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_FLAG_NO_SUBALLOC =3D=C2=A0 =
=C2=A0(1 &lt;&lt; 2),<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_FLAG_SPARSE =3D=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3),<br>
                    +=C2=A0 =C2=A0 RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING=
 =3D (1
                    &lt;&lt; 4),<br>
                    =C2=A0 };<br>
                    =C2=A0 =C2=A0 enum radeon_bo_usage { /* bitfield */<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_USAGE_READ =3D 2,<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_USAGE_WRITE =3D 4,<br>
                    =C2=A0 =C2=A0 =C2=A0 RADEON_USAGE_READWRITE =3D RADEON_=
USAGE_READ |
                    RADEON_USAGE_WRITE,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The winsys ensures that =
the CS submission
                    will be scheduled after<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0* previously flushed CSs ref=
erencing this BO
                    in a conflicting way.<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
                    @@ -685,28 +686,33 @@ static inline enum
                    radeon_bo_domain radeon_domain_from_heap(enum
                    radeon_heap hea<br>
                    =C2=A0 =C2=A0 =C2=A0 default:<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(0);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (enum radeon_=
bo_domain)0;<br>
                    =C2=A0 =C2=A0 =C2=A0 }<br>
                    =C2=A0 }<br>
                    =C2=A0 =C2=A0 static inline unsigned
                    radeon_flags_from_heap(enum radeon_heap heap)<br>
                    =C2=A0 {<br>
                    =C2=A0 =C2=A0 =C2=A0 switch (heap) {<br>
                    =C2=A0 =C2=A0 =C2=A0 case RADEON_HEAP_VRAM_NO_CPU_ACCES=
S<wbr>:<br>
                    -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RADEON_FLAG_GTT_WC =
|
                    RADEON_FLAG_NO_CPU_ACCESS;<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RADEON_FLAG_GTT_WC =
|<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0RADEON_FLAG_NO_CPU_ACCESS |<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0RADEON_FLAG_NO_INTERPROCESS_S<wbr>HARING;<br>
                    +<br>
                    =C2=A0 =C2=A0 =C2=A0 case RADEON_HEAP_VRAM:<br>
                    =C2=A0 =C2=A0 =C2=A0 case RADEON_HEAP_VRAM_GTT:<br>
                    =C2=A0 =C2=A0 =C2=A0 case RADEON_HEAP_GTT_WC:<br>
                    -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RADEON_FLAG_GTT_WC;=
<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RADEON_FLAG_GTT_WC =
|<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0RADEON_FLAG_NO_INTERPROCESS_S<wbr>HARING;<br>
                    +<br>
                    =C2=A0 =C2=A0 =C2=A0 case RADEON_HEAP_GTT:<br>
                    =C2=A0 =C2=A0 =C2=A0 default:<br>
                    -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RADEON_FLAG_NO_INTE=
RPROCESS_SH<wbr>ARING;<br>
                    =C2=A0 =C2=A0 =C2=A0 }<br>
                    =C2=A0 }<br>
                    =C2=A0 =C2=A0 /* The pb cache bucket is chosen to minim=
ize
                    pb_cache misses.<br>
                    =C2=A0 =C2=A0* It must be between 0 and 3 inclusive.<br=
>
                    =C2=A0 =C2=A0*/<br>
                    =C2=A0 static inline unsigned
                    radeon_get_pb_cache_bucket_ind<wbr>ex(enum
                    radeon_heap heap)<br>
                    =C2=A0 {<br>
                    =C2=A0 =C2=A0 =C2=A0 switch (heap) {<br>
                    =C2=A0 =C2=A0 =C2=A0 case RADEON_HEAP_VRAM_NO_CPU_ACCES=
S<wbr>:<br>
                    @@ -724,22 +730,28 @@ static inline unsigned
                    radeon_get_pb_cache_bucket_ind<wbr>ex(enum
                    radeon_heap heap)<br>
                    =C2=A0 =C2=A0 /* Return the heap index for winsys alloc=
ators,
                    or -1 on failure. */<br>
                    =C2=A0 static inline int radeon_get_heap_index(enum
                    radeon_bo_domain domain,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 enum
                    radeon_bo_flag flags)<br>
                    =C2=A0 {<br>
                    =C2=A0 =C2=A0 =C2=A0 /* VRAM implies WC (write combinin=
g) */<br>
                    =C2=A0 =C2=A0 =C2=A0 assert(!(domain &amp; RADEON_DOMAI=
N_VRAM) ||
                    flags &amp; RADEON_FLAG_GTT_WC);<br>
                    =C2=A0 =C2=A0 =C2=A0 /* NO_CPU_ACCESS implies VRAM only=
. */<br>
                    =C2=A0 =C2=A0 =C2=A0 assert(!(flags &amp;
                    RADEON_FLAG_NO_CPU_ACCESS) || domain =3D=3D
                    RADEON_DOMAIN_VRAM);<br>
                    =C2=A0 +=C2=A0 =C2=A0 /* Resources with interprocess sh=
aring don&#39;t
                    use any winsys allocators. */<br>
                    +=C2=A0 =C2=A0 if (!(flags &amp;
                    RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING))<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
                    +<br>
                    =C2=A0 =C2=A0 =C2=A0 /* Unsupported flags: NO_SUBALLOC,=
 SPARSE. */<br>
                    -=C2=A0 =C2=A0 if (flags &amp; ~(RADEON_FLAG_GTT_WC |
                    RADEON_FLAG_NO_CPU_ACCESS))<br>
                    +=C2=A0 =C2=A0 if (flags &amp; ~(RADEON_FLAG_GTT_WC |<b=
r>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RADEON_FLAG_NO_CPU_ACCESS |<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING))<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (domain) {<br>
                    =C2=A0 =C2=A0 =C2=A0 case RADEON_DOMAIN_VRAM:<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; RADE=
ON_FLAG_NO_CPU_ACCESS)<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return=
 RADEON_HEAP_VRAM_NO_CPU_ACCESS<wbr>;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return=
 RADEON_HEAP_VRAM;<br>
                    =C2=A0 =C2=A0 =C2=A0 case RADEON_DOMAIN_VRAM_GTT:<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RADEON_HEAP_V=
RAM_GTT;<br>
                    diff --git a/src/gallium/winsys/amdgpu/dr<wbr>m/amdgpu_=
bo.c
                    b/src/gallium/winsys/amdgpu/dr<wbr>m/amdgpu_bo.c<br>
                    index 97bbe23..06b8198 100644<br>
                    --- a/src/gallium/winsys/amdgpu/dr<wbr>m/amdgpu_bo.c<br=
>
                    +++ b/src/gallium/winsys/amdgpu/dr<wbr>m/amdgpu_bo.c<br=
>
                    @@ -31,20 +31,24 @@<br>
                    =C2=A0 =C2=A0 #include &quot;amdgpu_cs.h&quot;<br>
                    =C2=A0 =C2=A0 #include &quot;os/os_time.h&quot;<br>
                    =C2=A0 #include &quot;state_tracker/drm_driver.h&quot;<=
br>
                    =C2=A0 #include &lt;amdgpu_drm.h&gt;<br>
                    =C2=A0 #include &lt;xf86drm.h&gt;<br>
                    =C2=A0 #include &lt;stdio.h&gt;<br>
                    =C2=A0 #include &lt;inttypes.h&gt;<br>
                    =C2=A0 +#ifndef AMDGPU_GEM_CREATE_NO_INTERPROC<wbr>ESS_=
SHARING<br>
                    +#define AMDGPU_GEM_CREATE_NO_INTERPROC<wbr>ESS_SHARING
                    (1 &lt;&lt; 6)<br>
                    +#endif<br>
                    +<br>
                    =C2=A0 /* Set to 1 for verbose output showing committed
                    sparse buffer ranges. */<br>
                    =C2=A0 #define DEBUG_SPARSE_COMMITS 0<br>
                    =C2=A0 =C2=A0 struct amdgpu_sparse_backing_chunk {<br>
                    =C2=A0 =C2=A0 =C2=A0uint32_t begin, end;<br>
                    =C2=A0 };<br>
                    =C2=A0 =C2=A0 static struct pb_buffer *<br>
                    =C2=A0 amdgpu_bo_create(struct radeon_winsys *rws,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0uint64_t size,<br>
                    @@ -395,20 +399,22 @@ static struct amdgpu_winsys_bo
                    *amdgpu_create_bo(struct amdgpu_winsys *ws,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0if (initial_domain &amp; RAD=
EON_DOMAIN_VRAM)<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 request.preferred_heap |=3D
                    AMDGPU_GEM_DOMAIN_VRAM;<br>
                    =C2=A0 =C2=A0 =C2=A0if (initial_domain &amp; RADEON_DOM=
AIN_GTT)<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 request.preferred_heap |=3D
                    AMDGPU_GEM_DOMAIN_GTT;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; RADEON_FLAG_=
NO_CPU_ACCESS)<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 request.flags |=3D
                    AMDGPU_GEM_CREATE_NO_CPU_ACCES<wbr>S;<br>
                    =C2=A0 =C2=A0 =C2=A0if (flags &amp; RADEON_FLAG_GTT_WC)=
<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 request.flags |=3D
                    AMDGPU_GEM_CREATE_CPU_GTT_USWC<wbr>;<br>
                    +=C2=A0 =C2=A0if (flags &amp; RADEON_FLAG_NO_INTERPROCE=
SS_SH<wbr>ARING)<br>
                    +=C2=A0 =C2=A0 =C2=A0 request.flags |=3D
                    AMDGPU_GEM_CREATE_NO_INTERPROC<wbr>ESS_SHARING;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_bo_alloc(ws-&gt=
;dev, &amp;request,
                    &amp;buf_handle);<br>
                    =C2=A0 =C2=A0 =C2=A0if (r) {<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;amdgp=
u: Failed to allocate
                    a buffer:\n&quot;);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;amdgp=
u:=C2=A0 =C2=A0 size=C2=A0 =C2=A0 =C2=A0 :
                    %&quot;PRIu64&quot; bytes\n&quot;, size);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;amdgp=
u:=C2=A0 =C2=A0 alignment : %u
                    bytes\n&quot;, alignment);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;amdgp=
u:=C2=A0 =C2=A0 domains=C2=A0 =C2=A0:
                    %u\n&quot;, initial_domain);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error_bo_alloc;<br>
                    =C2=A0 =C2=A0 =C2=A0}<br>
                    =C2=A0 @@ -1127,21 +1133,21 @@ static void
                    amdgpu_buffer_set_metadata(str<wbr>uct pb_buffer
                    *_buf,<br>
                    =C2=A0 =C2=A0 static struct pb_buffer *<br>
                    =C2=A0 amdgpu_bo_create(struct radeon_winsys *rws,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0uint64_t size,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0unsigned alignment,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0enum radeon_bo_domain domain,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0enum radeon_bo_flag flags)<br>
                    =C2=A0 {<br>
                    =C2=A0 =C2=A0 =C2=A0struct amdgpu_winsys *ws =3D amdgpu=
_winsys(rws);<br>
                    =C2=A0 =C2=A0 =C2=A0struct amdgpu_winsys_bo *bo;<br>
                    -=C2=A0 =C2=A0unsigned usage =3D 0, pb_cache_bucket;<br=
>
                    +=C2=A0 =C2=A0unsigned usage =3D 0, pb_cache_bucket =3D=
 0;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0/* VRAM implies WC. This is =
not optional. */<br>
                    =C2=A0 =C2=A0 =C2=A0assert(!(domain &amp; RADEON_DOMAIN=
_VRAM) ||
                    flags &amp; RADEON_FLAG_GTT_WC);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0/* NO_CPU_ACCESS is valid wi=
th VRAM only. */<br>
                    =C2=A0 =C2=A0 =C2=A0assert(domain =3D=3D RADEON_DOMAIN_=
VRAM || !(flags
                    &amp; RADEON_FLAG_NO_CPU_ACCESS));<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Sub-allocate small buffer=
s from slabs. */<br>
                    =C2=A0 =C2=A0 =C2=A0if (!(flags &amp; (RADEON_FLAG_NO_S=
UBALLOC |
                    RADEON_FLAG_SPARSE)) &amp;&amp;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size &lt;=3D (1 &lt;&=
lt;
                    AMDGPU_SLAB_MAX_SIZE_LOG2) &amp;&amp;<br>
                    @@ -1182,48 +1188,52 @@ no_slab:<br>
                    =C2=A0 =C2=A0 =C2=A0/* This flag is irrelevant for the =
cache. */<br>
                    =C2=A0 =C2=A0 =C2=A0flags &amp;=3D ~RADEON_FLAG_NO_SUBA=
LLOC;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Align size to page size. =
This is the
                    minimum alignment for normal<br>
                    =C2=A0 =C2=A0 =C2=A0 * BOs. Aligning this here helps th=
e cached
                    bufmgr. Especially small BOs,<br>
                    =C2=A0 =C2=A0 =C2=A0 * like constant/uniform buffers, c=
an benefit
                    from better and more reuse.<br>
                    =C2=A0 =C2=A0 =C2=A0 */<br>
                    =C2=A0 =C2=A0 =C2=A0size =3D align64(size,
                    ws-&gt;info.gart_page_size);<br>
                    =C2=A0 =C2=A0 =C2=A0alignment =3D align(alignment,
                    ws-&gt;info.gart_page_size);<br>
                    =C2=A0 -=C2=A0 =C2=A0int heap =3D radeon_get_heap_index=
(domain,
                    flags);<br>
                    -=C2=A0 =C2=A0assert(heap &gt;=3D 0 &amp;&amp; heap &lt=
;
                    RADEON_MAX_CACHED_HEAPS);<br>
                    -=C2=A0 =C2=A0usage =3D 1 &lt;&lt; heap; /* Only set on=
e usage
                    bit for each heap. */<br>
                    +=C2=A0 =C2=A0bool use_reusable_pool =3D flags &amp;
                    RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING;<br>
                    =C2=A0 -=C2=A0 =C2=A0pb_cache_bucket =3D
                    radeon_get_pb_cache_bucket_ind<wbr>ex(heap);<br>
                    -=C2=A0 =C2=A0assert(pb_cache_bucket &lt;
                    ARRAY_SIZE(ws-&gt;bo_cache.bucket<wbr>s));<br>
                    +=C2=A0 =C2=A0if (use_reusable_pool) {<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0int heap =3D radeon_get_hea=
p_index(domain,
                    flags);<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0assert(heap &gt;=3D 0 &amp;=
&amp; heap &lt;
                    RADEON_MAX_CACHED_HEAPS);<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0usage =3D 1 &lt;&lt; heap; =
/* Only set one
                    usage bit for each heap. */<br>
                    =C2=A0 -=C2=A0 =C2=A0/* Get a buffer from the cache. */=
<br>
                    -=C2=A0 =C2=A0bo =3D (struct amdgpu_winsys_bo*)<br>
                    -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_cache_reclaim_buffer(&a=
mp;ws-&gt;b<wbr>o_cache,
                    size, alignment, usage,<br>
                    -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_cache_bucket=
);<br>
                    -=C2=A0 =C2=A0if (bo)<br>
                    -=C2=A0 =C2=A0 =C2=A0 return &amp;bo-&gt;base;<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0pb_cache_bucket =3D
                    radeon_get_pb_cache_bucket_ind<wbr>ex(heap);<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0assert(pb_cache_bucket &lt;
                    ARRAY_SIZE(ws-&gt;bo_cache.bucket<wbr>s));<br>
                    +<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get a buffer from the ca=
che. */<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0bo =3D (struct amdgpu_winsy=
s_bo*)<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_cache_rec=
laim_buffer(&amp;ws-&gt;b<wbr>o_cache,
                    size, alignment, usage,<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    pb_cache_bucket);<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bo)<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;bo-&gt;=
base;<br>
                    +=C2=A0 =C2=A0}<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Create a new one. */<br>
                    =C2=A0 =C2=A0 =C2=A0bo =3D amdgpu_create_bo(ws, size, a=
lignment,
                    usage, domain, flags,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pb_cache_bucket);<br>
                    =C2=A0 =C2=A0 =C2=A0if (!bo) {<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clear the cache and try =
again. */<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_slabs_reclaim(&amp;ws-&g=
t;bo_slabs<wbr>);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_cache_release_all_buffer=
s(&amp;<wbr>ws-&gt;bo_cache);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo =3D amdgpu_create_bo(ws,=
 size, alignment,
                    usage, domain, flags,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_cache_bucket);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!bo)<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<b=
r>
                    =C2=A0 =C2=A0 =C2=A0}<br>
                    =C2=A0 -=C2=A0 =C2=A0bo-&gt;u.real.use_reusable_pool =
=3D true;<br>
                    +=C2=A0 =C2=A0bo-&gt;u.real.use_reusable_pool =3D
                    use_reusable_pool;<br>
                    =C2=A0 =C2=A0 =C2=A0return &amp;bo-&gt;base;<br>
                    =C2=A0 }<br>
                    =C2=A0 =C2=A0 static struct pb_buffer
                    *amdgpu_bo_from_handle(struct radeon_winsys *rws,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0struct winsys_handle *whandle,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0unsigned *stride,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0unsigned *offset)<br>
                    =C2=A0 {<br>
                    =C2=A0 =C2=A0 =C2=A0struct amdgpu_winsys *ws =3D amdgpu=
_winsys(rws);<br>
                    =C2=A0 =C2=A0 =C2=A0struct amdgpu_winsys_bo *bo;<br>
                    diff --git a/src/gallium/winsys/radeon/dr<wbr>m/radeon_=
drm_bo.c
                    b/src/gallium/winsys/radeon/dr<wbr>m/radeon_drm_bo.c<br=
>
                    index 8027a5f..15e9d38 100644<br>
                    --- a/src/gallium/winsys/radeon/dr<wbr>m/radeon_drm_bo.=
c<br>
                    +++ b/src/gallium/winsys/radeon/dr<wbr>m/radeon_drm_bo.=
c<br>
                    @@ -907,21 +907,21 @@ static void
                    radeon_bo_set_metadata(struct pb_buffer *_buf,<br>
                    =C2=A0 =C2=A0 static struct pb_buffer *<br>
                    =C2=A0 radeon_winsys_bo_create(struct radeon_winsys *rw=
s,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t size,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned alignment,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum radeon_bo_domain
                    domain,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum radeon_bo_flag flags)<br>
                    =C2=A0 {<br>
                    =C2=A0 =C2=A0 =C2=A0 struct radeon_drm_winsys *ws =3D
                    radeon_drm_winsys(rws);<br>
                    =C2=A0 =C2=A0 =C2=A0 struct radeon_bo *bo;<br>
                    -=C2=A0 =C2=A0 unsigned usage =3D 0, pb_cache_bucket;<b=
r>
                    +=C2=A0 =C2=A0 unsigned usage =3D 0, pb_cache_bucket =
=3D 0;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!(flags &amp; RADEON=
_FLAG_SPARSE));
                    /* not supported */<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Only 32-bit sizes are su=
pported. */<br>
                    =C2=A0 =C2=A0 =C2=A0 if (size &gt; UINT_MAX)<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* VRAM implies WC. This is=
 not optional. */<br>
                    =C2=A0 =C2=A0 =C2=A0 if (domain &amp; RADEON_DOMAIN_VRA=
M)<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D RADEON_FL=
AG_GTT_WC;<br>
                    @@ -962,46 +962,51 @@ no_slab:<br>
                    =C2=A0 =C2=A0 =C2=A0 /* This flag is irrelevant for the=
 cache. */<br>
                    =C2=A0 =C2=A0 =C2=A0 flags &amp;=3D ~RADEON_FLAG_NO_SUB=
ALLOC;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Align size to page size.=
 This is the
                    minimum alignment for normal<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0* BOs. Aligning this here he=
lps the cached
                    bufmgr. Especially small BOs,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0* like constant/uniform buff=
ers, can benefit
                    from better and more reuse.<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
                    =C2=A0 =C2=A0 =C2=A0 size =3D align(size,
                    ws-&gt;info.gart_page_size);<br>
                    =C2=A0 =C2=A0 =C2=A0 alignment =3D align(alignment,
                    ws-&gt;info.gart_page_size);<br>
                    =C2=A0 -=C2=A0 =C2=A0 int heap =3D radeon_get_heap_inde=
x(domain,
                    flags);<br>
                    -=C2=A0 =C2=A0 assert(heap &gt;=3D 0 &amp;&amp; heap &l=
t;
                    RADEON_MAX_CACHED_HEAPS);<br>
                    -=C2=A0 =C2=A0 usage =3D 1 &lt;&lt; heap; /* Only set o=
ne usage
                    bit for each heap. */<br>
                    +=C2=A0 =C2=A0 bool use_reusable_pool =3D flags &amp;
                    RADEON_FLAG_NO_INTERPROCESS_SH<wbr>ARING;<br>
                    =C2=A0 -=C2=A0 =C2=A0 pb_cache_bucket =3D
                    radeon_get_pb_cache_bucket_ind<wbr>ex(heap);<br>
                    -=C2=A0 =C2=A0 assert(pb_cache_bucket &lt;
                    ARRAY_SIZE(ws-&gt;bo_cache.bucket<wbr>s));<br>
                    +=C2=A0 =C2=A0 /* Shared resources don&#39;t use cached=
 heaps. */<br>
                    +=C2=A0 =C2=A0 if (use_reusable_pool) {<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int heap =3D radeon_get_he=
ap_index(domain,
                    flags);<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(heap &gt;=3D 0 &amp=
;&amp; heap &lt;
                    RADEON_MAX_CACHED_HEAPS);<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usage =3D 1 &lt;&lt; heap;=
 /* Only set one
                    usage bit for each heap. */<br>
                    =C2=A0 -=C2=A0 =C2=A0 bo =3D radeon_bo(pb_cache_reclaim=
_buf<wbr>fer(&amp;ws-&gt;bo_cache,
                    size, alignment,<br>
                    -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0usage,
                    pb_cache_bucket));<br>
                    -=C2=A0 =C2=A0 if (bo)<br>
                    -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;bo-&gt;base;<b=
r>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_cache_bucket =3D
                    radeon_get_pb_cache_bucket_ind<wbr>ex(heap);<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(pb_cache_bucket &lt=
;
                    ARRAY_SIZE(ws-&gt;bo_cache.bucket<wbr>s));<br>
                    +<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bo =3D radeon_bo(pb_cache_=
reclaim_buf<wbr>fer(&amp;ws-&gt;bo_cache,
                    size, alignment,<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0usage, pb_cache_bucket));<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bo)<br>
                    +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;=
bo-&gt;base;<br>
                    +=C2=A0 =C2=A0 }<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo =3D radeon_create_bo(ws,=
 size, alignment,
                    usage, domain, flags,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_cache_bucket);<br>
                    =C2=A0 =C2=A0 =C2=A0 if (!bo) {<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clear the cache a=
nd try again. */<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ws-&gt;info.has_=
virtual_memory)<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_sla=
bs_reclaim(&amp;ws-&gt;bo_slabs<wbr>);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_cache_release_all=
_buffers(&amp;<wbr>ws-&gt;bo_cache);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo =3D radeon_create=
_bo(ws, size, alignment,
                    usage, domain, flags,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pb_cache_bucket);<=
br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!bo)<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return=
 NULL;<br>
                    =C2=A0 =C2=A0 =C2=A0 }<br>
                    =C2=A0 -=C2=A0 =C2=A0 bo-&gt;u.real.use_reusable_pool =
=3D true;<br>
                    +=C2=A0 =C2=A0 bo-&gt;u.real.use_reusable_pool =3D
                    use_reusable_pool;<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 mtx_lock(&amp;ws-&gt;bo_han=
dles_mutex<wbr>);<br>
                    =C2=A0 =C2=A0 =C2=A0 util_hash_table_set(ws-&gt;bo_han<=
wbr>dles,
                    (void*)(uintptr_t)bo-&gt;handle, bo);<br>
                    =C2=A0 =C2=A0 =C2=A0 mtx_unlock(&amp;ws-&gt;bo_handles_=
mut<wbr>ex);<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;bo-&gt;base;<br=
>
                    =C2=A0 }<br>
                    =C2=A0 =C2=A0 static struct pb_buffer
                    *radeon_winsys_bo_from_ptr(str<wbr>uct radeon_winsys
                    *rws,<br>
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0void *pointer, uint64_t size)<br>
                  </blockquote>
                  <br>
                </div>
              </blockquote>
            </div>
          </div>
          <div class=3D"gmail_extra" dir=3D"auto"><br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </div></div>

</blockquote></div><br></div></div></div>

--94eb2c118822afb3a80554c0ff28--

--===============0268658970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0268658970==--
