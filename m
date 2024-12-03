Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFD3E77171
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 08:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3413910EC29;
	Wed,  4 Dec 2024 08:16:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JWQondln";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E057610EA53
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nVlxG4cAu3RhDAHBZgdqzlNjm9iSxgqWpgA3lbw6qP8=; b=JWQondln8Gl4QOipRz7uN9Bmgb
 JR50O5+5KQa3lwjrO9mKo1b1SngBt4Udan8vA4omSWHTReoM1fKz5PsKN80JcERZz1DJr0w1VYvoH
 KhmKe1BEU7Zlq3fN/usADmO9GJ0+KCrSv4ubzU4kUJazOCPcL/Jk2CUBP4NaQ2k1Dbv+nN7RLtQ0+
 6keCFv2S2938hr7gRkCsQSug87THJdUIFdw1HEh2/s+b/yG23HxdfK58DYxhel/zVuD4QRJz3sYfo
 znl9zHlkTpuJJ+7jdcsUyq+Wv2w/WWE6z2QFnAlU//3H93ypp+XDZGBaE3++7HClVjzzwZvudXq3T
 UWlwQqxQ==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1tIUdK-00FuJe-2f; Tue, 03 Dec 2024 16:16:14 +0100
Message-ID: <c4d38e8c-5d43-43fc-ba51-2b6d067bd5f1@igalia.com>
Date: Tue, 3 Dec 2024 15:16:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] drm/amdgpu: track bo memory stats at runtime
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241128185404.2672-1-Yunxiang.Li@amd.com>
 <20241128185404.2672-6-Yunxiang.Li@amd.com>
 <1321f782-4bf7-45da-a610-38f9f388f043@igalia.com>
 <SA1PR12MB85992E5B5FEC4BDF3AEC77AAED362@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <SA1PR12MB85992E5B5FEC4BDF3AEC77AAED362@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 04 Dec 2024 08:16:42 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 03/12/2024 15:03, Li, Yunxiang (Teddy) wrote:
> [Public]
> 
>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Sent: Tuesday, December 3, 2024 9:42
>> On 28/11/2024 18:54, Yunxiang Li wrote:
>>> Before, every time fdinfo is queried we try to lock all the BOs in the
>>> VM and calculate memory usage from scratch. This works okay if the
>>> fdinfo is rarely read and the VMs don't have a ton of BOs. If either
>>> of these conditions is not true, we get a massive performance hit.
>>>
>>> In this new revision, we track the BOs as they change states. This way
>>> when the fdinfo is queried we only need to take the status lock and
>>> copy out the usage stats with minimal impact to the runtime
>>> performance. With this new approach however, we would no longer be
>>> able to track active buffers.
>>>
>>> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  15 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  18 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 110 +++++-------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   4 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   4 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 175 +++++++++++++++-----
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  17 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
>>>    8 files changed, 204 insertions(+), 140 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index b144404902255..423cea4e571ee 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -36,6 +36,7 @@
>>>    #include "amdgpu_gem.h"
>>>    #include "amdgpu_dma_buf.h"
>>>    #include "amdgpu_xgmi.h"
>>> +#include "amdgpu_vm.h"
>>>    #include <drm/amdgpu_drm.h>
>>>    #include <drm/ttm/ttm_tt.h>
>>>    #include <linux/dma-buf.h>
>>> @@ -190,6 +191,14 @@ static void amdgpu_dma_buf_unmap(struct
>> dma_buf_attachment *attach,
>>>      }
>>>    }
>>>
>>> +static void amdgpu_dma_buf_release(struct dma_buf *buf) {
>>> +   struct amdgpu_bo *bo = gem_to_amdgpu_bo(buf->priv);
>>> +
>>> +   amdgpu_vm_bo_update_shared(bo, -1);
>>> +   drm_gem_dmabuf_release(buf);
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_dma_buf_begin_cpu_access - &dma_buf_ops.begin_cpu_access
>> implementation
>>>     * @dma_buf: Shared DMA buffer
>>> @@ -237,7 +246,7 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
>>>      .unpin = amdgpu_dma_buf_unpin,
>>>      .map_dma_buf = amdgpu_dma_buf_map,
>>>      .unmap_dma_buf = amdgpu_dma_buf_unmap,
>>> -   .release = drm_gem_dmabuf_release,
>>> +   .release = amdgpu_dma_buf_release,
>>>      .begin_cpu_access = amdgpu_dma_buf_begin_cpu_access,
>>>      .mmap = drm_gem_dmabuf_mmap,
>>>      .vmap = drm_gem_dmabuf_vmap,
>>> @@ -265,8 +274,10 @@ struct dma_buf *amdgpu_gem_prime_export(struct
>> drm_gem_object *gobj,
>>>              return ERR_PTR(-EPERM);
>>>
>>>      buf = drm_gem_prime_export(gobj, flags);
>>> -   if (!IS_ERR(buf))
>>> +   if (!IS_ERR(buf)) {
>>>              buf->ops = &amdgpu_dmabuf_ops;
>>> +           amdgpu_vm_bo_update_shared(bo, +1);
>>> +   }
>>>
>>>      return buf;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>>> index 7717e3e4f05b5..e625e2481747e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>>> @@ -60,7 +60,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct
>> drm_file *file)
>>>      struct amdgpu_fpriv *fpriv = file->driver_priv;
>>>      struct amdgpu_vm *vm = &fpriv->vm;
>>>
>>> -   struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST + 1] = { };
>>> +   struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST];
>>>      ktime_t usage[AMDGPU_HW_IP_NUM];
>>>      const char *pl_name[] = {
>>>              [TTM_PL_VRAM] = "vram",
>>> @@ -72,15 +72,8 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct
>> drm_file *file)
>>>              [AMDGPU_PL_DOORBELL] = "doorbell",
>>>      };
>>>      unsigned int hw_ip, i;
>>> -   int ret;
>>> -
>>> -   ret = amdgpu_bo_reserve(vm->root.bo, false);
>>> -   if (ret)
>>> -           return;
>>> -
>>> -   amdgpu_vm_get_memory(vm, stats, ARRAY_SIZE(stats));
>>> -   amdgpu_bo_unreserve(vm->root.bo);
>>>
>>> +   amdgpu_vm_get_memory(vm, stats);
>>>      amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
>>>
>>>      /*
>>> @@ -97,7 +90,6 @@ void amdgpu_show_fdinfo(struct drm_printer *p,
>>> struct drm_file *file)
>>>
>>>              drm_print_memory_stats(p,
>>>                                     &stats[i].drm,
>>> -                                  DRM_GEM_OBJECT_ACTIVE |
>>>                                     DRM_GEM_OBJECT_RESIDENT |
>>>                                     DRM_GEM_OBJECT_PURGEABLE,
>>>                                     pl_name[i]);
>>> @@ -115,9 +107,11 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct
>> drm_file *file)
>>>      drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
>>>                 stats[TTM_PL_VRAM].evicted/1024UL);
>>>      drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
>>> -              stats[TTM_PL_VRAM].requested/1024UL);
>>> +              (stats[TTM_PL_VRAM].drm.shared +
>>> +               stats[TTM_PL_VRAM].drm.private) / 1024UL);
>>>      drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
>>> -              stats[TTM_PL_TT].requested/1024UL);
>>> +              (stats[TTM_PL_TT].drm.shared +
>>> +               stats[TTM_PL_TT].drm.private) / 1024UL);
>>>
>>>      for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>>>              if (!usage[hw_ip])
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 951b20e40fd35..96f4b8904e9a6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1258,7 +1258,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object
>> *bo,
>>>              return;
>>>
>>>      abo = ttm_to_amdgpu_bo(bo);
>>> -   amdgpu_vm_bo_invalidate(abo, evict);
>>> +   amdgpu_vm_bo_move(abo, new_mem, evict);
>>>
>>>      amdgpu_bo_kunmap(abo);
>>>
>>> @@ -1271,75 +1271,6 @@ void amdgpu_bo_move_notify(struct
>> ttm_buffer_object *bo,
>>>                           old_mem ? old_mem->mem_type : -1);
>>>    }
>>>
>>> -void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>> -                     struct amdgpu_mem_stats *stats,
>>> -                     unsigned int sz)
>>> -{
>>> -   const unsigned int domain_to_pl[] = {
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_CPU)]      = TTM_PL_SYSTEM,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_GTT)]      = TTM_PL_TT,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_VRAM)]     = TTM_PL_VRAM,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_GDS)]      =
>> AMDGPU_PL_GDS,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_GWS)]      =
>> AMDGPU_PL_GWS,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_OA)]       = AMDGPU_PL_OA,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_DOORBELL)] =
>> AMDGPU_PL_DOORBELL,
>>> -   };
>>> -   struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>> -   struct ttm_resource *res = bo->tbo.resource;
>>> -   struct drm_gem_object *obj = &bo->tbo.base;
>>> -   uint64_t size = amdgpu_bo_size(bo);
>>> -   unsigned int type;
>>> -
>>> -   if (!res) {
>>> -           /*
>>> -            * If no backing store use one of the preferred domain for basic
>>> -            * stats. We take the MSB since that should give a reasonable
>>> -            * view.
>>> -            */
>>> -           BUILD_BUG_ON(TTM_PL_VRAM < TTM_PL_TT ||
>>> -                        TTM_PL_VRAM < TTM_PL_SYSTEM);
>>> -           type = fls(bo->preferred_domains &
>> AMDGPU_GEM_DOMAIN_MASK);
>>> -           if (!type)
>>> -                   return;
>>> -           type--;
>>> -           if (drm_WARN_ON_ONCE(&adev->ddev,
>>> -                                type >= ARRAY_SIZE(domain_to_pl)))
>>> -                   return;
>>> -           type = domain_to_pl[type];
>>> -   } else {
>>> -           type = res->mem_type;
>>> -   }
>>> -
>>> -   if (drm_WARN_ON_ONCE(&adev->ddev, type >= sz))
>>> -           return;
>>> -
>>> -   /* DRM stats common fields: */
>>> -
>>> -   if (drm_gem_object_is_shared_for_memory_stats(obj))
>>> -           stats[type].drm.shared += size;
>>> -   else
>>> -           stats[type].drm.private += size;
>>> -
>>> -   if (res) {
>>> -           stats[type].drm.resident += size;
>>> -
>>> -           if (!dma_resv_test_signaled(obj->resv,
>> DMA_RESV_USAGE_BOOKKEEP))
>>> -                   stats[type].drm.active += size;
>>> -           else if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>> -                   stats[type].drm.purgeable += size;
>>> -   }
>>> -
>>> -   /* amdgpu specific stats: */
>>> -
>>> -   if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>>> -           stats[TTM_PL_VRAM].requested += size;
>>> -           if (type != TTM_PL_VRAM)
>>> -                   stats[TTM_PL_VRAM].evicted += size;
>>> -   } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>>> -           stats[TTM_PL_TT].requested += size;
>>> -   }
>>> -}
>>> -
>>>    /**
>>>     * amdgpu_bo_release_notify - notification about a BO being released
>>>     * @bo: pointer to a buffer object
>>> @@ -1554,6 +1485,45 @@ u64 amdgpu_bo_gpu_offset_no_check(struct
>> amdgpu_bo *bo)
>>>      return amdgpu_gmc_sign_extend(offset);
>>>    }
>>>
>>> +/**
>>> + * amdgpu_bo_mem_stats_placement - bo placement for memory accounting
>>> + * @bo:    the buffer object we should look at
>>> + *
>>> + * BO can have multiple preferred placements, to avoid double
>>> +counting we want
>>> + * to file it under a single placement for memory stats.
>>> + * Luckily, if we take the highest set bit in preferred_domains the
>>> +result is
>>> + * quite sensible.
>>> + *
>>> + * Returns:
>>> + * Which of the placements should the BO be accounted under.
>>> + */
>>> +uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo) {
>>> +   uint32_t domain = bo->preferred_domains &
>> AMDGPU_GEM_DOMAIN_MASK;
>>> +
>>> +   if (!domain)
>>> +           return TTM_PL_SYSTEM;
>>> +
>>> +   switch (rounddown_pow_of_two(domain)) {
>>> +   case AMDGPU_GEM_DOMAIN_CPU:
>>> +           return TTM_PL_SYSTEM;
>>> +   case AMDGPU_GEM_DOMAIN_GTT:
>>> +           return TTM_PL_TT;
>>> +   case AMDGPU_GEM_DOMAIN_VRAM:
>>> +           return TTM_PL_VRAM;
>>> +   case AMDGPU_GEM_DOMAIN_GDS:
>>> +           return AMDGPU_PL_GDS;
>>> +   case AMDGPU_GEM_DOMAIN_GWS:
>>> +           return AMDGPU_PL_GWS;
>>> +   case AMDGPU_GEM_DOMAIN_OA:
>>> +           return AMDGPU_PL_OA;
>>> +   case AMDGPU_GEM_DOMAIN_DOORBELL:
>>> +           return AMDGPU_PL_DOORBELL;
>>> +   default:
>>> +           return TTM_PL_SYSTEM;
>>> +   }
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_bo_get_preferred_domain - get preferred domain
>>>     * @adev: amdgpu device object
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index ce3314152d20f..bdc9a5bc4da46 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -305,9 +305,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device
>> *adev, struct dma_resv *resv,
>>>    int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>>>    u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>>>    u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo); -void
>>> amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>> -                     struct amdgpu_mem_stats *stats,
>>> -                     unsigned int size);
>>> +uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>>>    uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>>>                                          uint32_t domain);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 2852a6064c9ac..86cb83fb2283c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -26,15 +26,15 @@
>>>
>>>    #include <linux/dma-direction.h>
>>>    #include <drm/gpu_scheduler.h>
>>> +#include <drm/ttm/ttm_placement.h>
>>>    #include "amdgpu_vram_mgr.h"
>>> -#include "amdgpu.h"
>>>
>>>    #define AMDGPU_PL_GDS             (TTM_PL_PRIV + 0)
>>>    #define AMDGPU_PL_GWS             (TTM_PL_PRIV + 1)
>>>    #define AMDGPU_PL_OA              (TTM_PL_PRIV + 2)
>>>    #define AMDGPU_PL_PREEMPT (TTM_PL_PRIV + 3)
>>>    #define AMDGPU_PL_DOORBELL        (TTM_PL_PRIV + 4)
>>> -#define __AMDGPU_PL_LAST   (TTM_PL_PRIV + 4)
>>> +#define __AMDGPU_PL_LAST   (TTM_PL_PRIV + 5)
>>
>> I like the the convention where "last" is equal to the last used index but maybe it is
>> just me. I guess you strongly wanted to avoid the "+ 1"
>> in code albeit for a price in making it less obvious.
> 
> Perhaps "_END" is a more common name for what I'm doing here, and yeah, I found that in earlier patches I had missed the +1 was required here and got an off by one bug.

For me "NUM" is how many elements, "LAST" and "MAX" and "END" are all 
the index of the last element. :) But maybe point me to some examples of 
_END and if it is an established pattern to mean what you want it to 
then fine.

> 
>>>    #define AMDGPU_GTT_MAX_TRANSFER_SIZE      512
>>>    #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS   2
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index d0db155a9ab7c..26effcf703d47 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -36,6 +36,7 @@
>>>    #include <drm/ttm/ttm_tt.h>
>>>    #include <drm/drm_exec.h>
>>>    #include "amdgpu.h"
>>> +#include "amdgpu_vm.h"
>>>    #include "amdgpu_trace.h"
>>>    #include "amdgpu_amdkfd.h"
>>>    #include "amdgpu_gmc.h"
>>> @@ -310,6 +311,74 @@ static void amdgpu_vm_bo_reset_state_machine(struct
>> amdgpu_vm *vm)
>>>      spin_unlock(&vm->status_lock);
>>>    }
>>>
>>> +/**
>>> + * amdgpu_vm_update_shared - helper to update shared memory stat
>>> + * @base: base structure for tracking BO usage in a VM
>>> + * @sign: if we should add (+1) or subtract (-1) from the shared stat
>>> + *
>>> + * Takes the vm status_lock and updates the shared memory stat. If
>>> +the basic
>>> + * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need
>>> +to be called
>>> + * as well.
>>> + */
>>> +static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base,
>>> +int sign) {
>>> +   struct amdgpu_vm *vm = base->vm;
>>> +   struct amdgpu_bo *bo = base->bo;
>>> +   int64_t size = sign * amdgpu_bo_size(bo);
>>> +   uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
>>> +
>>> +   spin_lock(&vm->status_lock);
>>> +   vm->stats[bo_memtype].drm.shared += size;
>>> +   vm->stats[bo_memtype].drm.private -= size;
>>> +   spin_unlock(&vm->status_lock);
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_vm_update_stats - helper to update normal memory stat
>>> + * @base: base structure for tracking BO usage in a VM
>>> + * @res:  the ttm_resource to use for the purpose of accounting, may or may not
>>> + *        be bo->tbo.resource
>>> + * @sign: if we should add (+1) or subtract (-1) from the stat
>>> + *
>>> + * Takes the vm status_lock and updates the basic memory stat. If the
>>> +shared
>>> + * stat changed (e.g. buffer was exported) amdgpu_vm_update_shared
>>> +need to be
>>> + * called as well.
>>> + */
>>> +void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>>> +                       struct ttm_resource *res, int sign) {
>>> +   struct amdgpu_vm *vm = base->vm;
>>> +   struct amdgpu_bo *bo = base->bo;
>>> +   int64_t size = sign * amdgpu_bo_size(bo);
>>> +   uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
>>> +   bool shared =
>>> +drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>> +
>>> +   spin_lock(&vm->status_lock);
>>> +
>>> +   /* For drm-total- and drm-shared-, BO are accounted by their preferred
>>> +    * placement, see also amdgpu_bo_mem_stats_placement.
>>> +    */
>>> +   if (shared)
>>> +           vm->stats[bo_memtype].drm.shared += size;
>>> +   else
>>> +           vm->stats[bo_memtype].drm.private += size;
>>> +
>>> +   if (res && res->mem_type < __AMDGPU_PL_LAST) {
>>> +           uint32_t res_memtype = res->mem_type;
>>> +
>>> +           vm->stats[res_memtype].drm.resident += size;
>>> +           /* BO only count as purgeable if it is resident,
>>> +            * since otherwise there's nothing to purge.
>>> +            */
>>> +           if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>> +                   vm->stats[res_memtype].drm.purgeable += size;
>>> +           if (!(bo->preferred_domains &
>> amdgpu_mem_type_to_domain(res_memtype)))
>>> +                   vm->stats[bo_memtype].evicted += size;
>>
>> So for VRAM+CPU Mesa common case, when backing store is in system memory,
>> it not count as evicted? Intentionally?
> 
> Only when buffer prefers both placements. With this change the reported evicted stats matches the state machine for managing the buffers, the same comparison is done for adding the BO to the evicted list later in the code.

But it neither matches the current semantics nor offers anything 
interesting (in fact it would be misleading) to the userspace observing 
these stats, no?

Regards,

Tvrtko

>>> +   }
>>> +
>>> +   spin_unlock(&vm->status_lock);
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with the vm
>>>     *
>>> @@ -332,6 +401,7 @@ void amdgpu_vm_bo_base_init(struct
>> amdgpu_vm_bo_base *base,
>>>              return;
>>>      base->next = bo->vm_bo;
>>>      bo->vm_bo = base;
>>> +   amdgpu_vm_update_stats(base, bo->tbo.resource, +1);
>>>
>>>      if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>>              return;
>>> @@ -1082,53 +1152,11 @@ int amdgpu_vm_update_range(struct
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>      return r;
>>>    }
>>>
>>> -static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
>>> -                               struct amdgpu_mem_stats *stats,
>>> -                               unsigned int size)
>>> -{
>>> -   struct amdgpu_vm *vm = bo_va->base.vm;
>>> -   struct amdgpu_bo *bo = bo_va->base.bo;
>>> -
>>> -   if (!bo)
>>> -           return;
>>> -
>>> -   /*
>>> -    * For now ignore BOs which are currently locked and potentially
>>> -    * changing their location.
>>> -    */
>>> -   if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>> -       !dma_resv_trylock(bo->tbo.base.resv))
>>> -           return;
>>> -
>>> -   amdgpu_bo_get_memory(bo, stats, size);
>>> -   if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>> -           dma_resv_unlock(bo->tbo.base.resv);
>>> -}
>>> -
>>>    void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>> -                     struct amdgpu_mem_stats *stats,
>>> -                     unsigned int size)
>>> +                     struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST])
>>>    {
>>> -   struct amdgpu_bo_va *bo_va, *tmp;
>>> -
>>>      spin_lock(&vm->status_lock);
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> +   memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_LAST);
>>>      spin_unlock(&vm->status_lock);
>>>    }
>>>
>>> @@ -2075,6 +2103,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device
>> *adev,
>>>                      if (*base != &bo_va->base)
>>>                              continue;
>>>
>>> +                   amdgpu_vm_update_stats(*base, bo->tbo.resource, -1);
>>>                      *base = bo_va->base.next;
>>>                      break;
>>>              }
>>> @@ -2140,6 +2169,22 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>>>      return true;
>>>    }
>>>
>>> +/**
>>> + * amdgpu_vm_bo_update_shared - called when bo gets shared/unshared
>>> + *
>>> + * @bo: amdgpu buffer object
>>> + * @sign: if we should add (+1) or subtract (-1) the memory stat
>>> + *
>>> + * Update the per VM stats for all the vm  */ void
>>> +amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo, int sign) {
>>> +   struct amdgpu_vm_bo_base *bo_base;
>>> +
>>> +   for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next)
>>> +           amdgpu_vm_update_shared(bo_base, sign); }
>>> +
>>>    /**
>>>     * amdgpu_vm_bo_invalidate - mark the bo as invalid
>>>     *
>>> @@ -2173,6 +2218,28 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo
>> *bo, bool evicted)
>>>      }
>>>    }
>>>
>>> +/**
>>> + * amdgpu_vm_bo_move - handle BO move
>>> + *
>>> + * @bo: amdgpu buffer object
>>> + * @new_mem: the new placement of the BO move
>>> + * @evicted: is the BO evicted
>>> + *
>>> + * Update the memory stats for the new placement and mark @bo as invalid.
>>> + */
>>> +void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource
>> *new_mem,
>>> +                  bool evicted)
>>> +{
>>> +   struct amdgpu_vm_bo_base *bo_base;
>>> +
>>> +   for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>>> +           amdgpu_vm_update_stats(bo_base, bo->tbo.resource, -1);
>>> +           amdgpu_vm_update_stats(bo_base, new_mem, +1);
>>
>> FWIW dropping and re-acquiring the lock makes the readout from
>> amdgpu_vm_get_memory() non-atomic in terms of view consistency. Should be
>> worth adding a helper which does the move in one go, with one lock acquire
>> section.
> 
> Good point, thanks.
> 
>> Regards,
>>
>> Tvrtko
>>
>>> +   }
>>> +
>>> +   amdgpu_vm_bo_invalidate(bo, evicted); }
>>> +
>>>    /**
>>>     * amdgpu_vm_get_block_size - calculate VM page table size as power of two
>>>     *
>>> @@ -2589,6 +2656,16 @@ void amdgpu_vm_release_compute(struct
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>>      vm->is_compute_context = false;
>>>    }
>>>
>>> +static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm) {
>>> +   for (int i = 0; i < __AMDGPU_PL_LAST; ++i) {
>>> +           if (!(drm_memory_stats_is_zero(&vm->stats[i].drm) &&
>>> +                 vm->stats[i].evicted == 0))
>>> +                   return false;
>>> +   }
>>> +   return true;
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_vm_fini - tear down a vm instance
>>>     *
>>> @@ -2612,7 +2689,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
>>> struct amdgpu_vm *vm)
>>>
>>>      root = amdgpu_bo_ref(vm->root.bo);
>>>      amdgpu_bo_reserve(root, true);
>>> -   amdgpu_vm_put_task_info(vm->task_info);
>>>      amdgpu_vm_set_pasid(adev, vm, 0);
>>>      dma_fence_wait(vm->last_unlocked, false);
>>>      dma_fence_put(vm->last_unlocked);
>>> @@ -2660,6 +2736,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
>> struct amdgpu_vm *vm)
>>>              }
>>>      }
>>>
>>> +   if (!amdgpu_vm_stats_is_zero(vm)) {
>>> +           struct amdgpu_task_info *ti = vm->task_info;
>>> +
>>> +           dev_warn(adev->dev,
>>> +                    "VM memory stats for proc %s(%d) task %s(%d) is non-zero
>> when fini\n",
>>> +                    ti->process_name, ti->pid, ti->task_name, ti->tgid);
>>> +   }
>>> +
>>> +   amdgpu_vm_put_task_info(vm->task_info);
>>>    }
>>>
>>>    /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 6a1b344e15e1b..257cea4e4f23e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -35,6 +35,7 @@
>>>    #include "amdgpu_sync.h"
>>>    #include "amdgpu_ring.h"
>>>    #include "amdgpu_ids.h"
>>> +#include "amdgpu_ttm.h"
>>>
>>>    struct drm_exec;
>>>
>>> @@ -324,10 +325,7 @@ struct amdgpu_vm_fault_info {
>>>    struct amdgpu_mem_stats {
>>>      struct drm_memory_stats drm;
>>>
>>> -   /* buffers that requested this placement */
>>> -   uint64_t requested;
>>> -   /* buffers that requested this placement
>>> -    * but are currently evicted */
>>> +   /* buffers that requested this placement but are currently evicted
>>> +*/
>>>      uint64_t evicted;
>>>    };
>>>
>>> @@ -345,6 +343,9 @@ struct amdgpu_vm {
>>>      /* Lock to protect vm_bo add/del/move on all lists of vm */
>>>      spinlock_t              status_lock;
>>>
>>> +   /* Memory statistics for this vm, protected by the status_lock */
>>> +   struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST];
>>> +
>>>      /* Per-VM and PT BOs who needs a validation */
>>>      struct list_head        evicted;
>>>
>>> @@ -525,6 +526,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device
>> *adev,
>>>                      bool clear);
>>>    bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
>>>    void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
>>> +void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>>> +                       struct ttm_resource *new_res, int sign); void
>>> +amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo, int sign); void
>>> +amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
>>> +                  bool evicted);
>>>    uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
>>>    struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>>>                                     struct amdgpu_bo *bo);
>>> @@ -575,8 +581,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm
>> *vm);
>>>    void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>>>                              struct amdgpu_vm *vm);
>>>    void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>> -                     struct amdgpu_mem_stats *stats,
>>> -                     unsigned int size);
>>> +                     struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST]);
>>>
>>>    int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                     struct amdgpu_bo_vm *vmbo, bool immediate); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index f78a0434a48fa..b0bf216821152 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -537,6 +537,7 @@ static void amdgpu_vm_pt_free(struct
>> amdgpu_vm_bo_base *entry)
>>>      if (!entry->bo)
>>>              return;
>>>
>>> +   amdgpu_vm_update_stats(entry, entry->bo->tbo.resource, -1);
>>>      entry->bo->vm_bo = NULL;
>>>      ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>>>
