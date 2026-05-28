Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F7CCD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 12:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805CC10F0D2;
	Thu, 28 May 2026 12:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sIkkeY4l";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F040310F0D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 12:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dZxDnAKgNNrtXBYl70Eh0JDweNPzW7iHV1yWraaPYi4=; b=sIkkeY4lZz1TYsCMBAWwEg+E7t
 XDZQSaB2vhQN0t9OiJ1RAuR3Kq5yzTiGnHKhKbWgNGYkwKOq0tF+uvHWJnQ+0D7UUw43AvKS6X+AJ
 qoni3vpnRa5cBSf+TPNTX/hlyA5LiputD86x8Kjj95HhNBOhRD9qdmtJrL2oyat6Vfl/PhRXmLABB
 BAEOAWGdibysenbbEFU6n8kBhOxXn/jQwDuP2sJC5ekRWaRmLRUriP+sNqMS5k7jCfj2kWNWn6voQ
 qBWZPFd2BQooqUS8Tp/C0NpsJHzqyw0cBsga3YKNSNtjpHtnObstmVVukQiwICwQWSYHOt0cWstx6
 OWwCSNPg==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wSZbh-009M7Y-5M; Thu, 28 May 2026 14:13:01 +0200
Message-ID: <b4036865-a18b-4382-8139-3da6a48c260d@igalia.com>
Date: Thu, 28 May 2026 13:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] drm/amdgpu: Add driver managed buffer copy
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20260526160630.35562-1-tvrtko.ursulin@igalia.com>
 <20260526160630.35562-6-tvrtko.ursulin@igalia.com>
 <546f4e04-e45e-4678-b71d-a63a4d223cc2@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <546f4e04-e45e-4678-b71d-a63a4d223cc2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 27/05/2026 12:46, Christian König wrote:
> On 5/26/26 18:06, Tvrtko Ursulin wrote:
>> Saving and restoring buffer object content poses a challenge for the
>> checkpoint and restore process for at least two reasons.
>>
>> For example not all objects can be exported as dma-buf to enable copying
>> from a separate client context, neither can any objects be easily copied
>> from the same context since the injected CRIU code is unaware of the GPU
>> virtual memory free and allocated ranges.
>>
>> Lets bypass both problems by simply exposing access to the alrady present
>> fast kernel copy via a new DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER ioctl.
> 
> Oh nice, that was on the TODO list for KFD integration as well.

That's good to hear! I was worried this one could be shot down in flames.

>> By giving the kernel simply the source and destination handles it is able
>> to copy them without the need for objects to be mapped, or shared with a
>> separate client.
>>
>> For now this is implemented fully synchronous but can easily be extended
>> for more parallelsim.
> 
> Looks reasonable of hand but I would rather like to have an output DMA-fence (drm_syncobj) instead of the dma_fence_wait().

I opted for simplicity for the RFC but I can certainly add an output 
fence. I guess that way userspace could implement parallel/pipelined 
save/restore for maximum performance.

Marking as TODO for RFC v2.

Regards,

Tvrtko

>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 102 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  14 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |   7 ++
>>   include/uapi/drm/amdgpu_drm.h           |   8 ++
>>   6 files changed, 127 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 2b971de3c189..b927e3a3089e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3066,6 +3066,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_contexts_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_COPY_BUFFER, amdgpu_gem_copy_buffer_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>   
>>   static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 5eb8433229b4..4e0440cd6ee2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -1216,6 +1216,108 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>>   	return ret;
>>   }
>>   
>> +/**
>> + * amdgpu_gem_copy_buffer_ioctl - copy buffer object content
>> + *
>> + * @dev: drm device pointer
>> + * @data: drm_amdgpu_gem_copy_buffer
>> + * @filp: drm file pointer
>> + *
>> + * Returns:
>> + * 0 for success, -errno for errors.
>> + */
>> +int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
>> +				 struct drm_file *filp)
>> +{
>> +	struct amdgpu_copy_mem src_mem = {}, dst_mem = {};
>> +	struct drm_amdgpu_gem_copy_buffer *args = data;
>> +	struct amdgpu_device *adev = drm_to_adev(dev);
>> +	struct drm_gem_object *src_gobj, *dst_gobj;
>> +	struct amdgpu_bo *src_bo, *dst_bo;
>> +	struct dma_fence *fence = NULL;
>> +	struct drm_exec exec;
>> +	unsigned int e;
>> +	long timeout;
>> +	int r;
>> +
>> +	if (args->flags)
>> +		return -EINVAL;
>> +
>> +	src_gobj = drm_gem_object_lookup(filp, args->src_handle);
>> +	if (!src_gobj)
>> +		return -ENOENT;
>> +
>> +	dst_gobj = drm_gem_object_lookup(filp, args->dst_handle);
>> +	if (!dst_gobj) {
>> +		r = -ENOENT;
>> +		goto err_dst;
>> +	}
>> +
>> +	src_bo = gem_to_amdgpu_bo(src_gobj);
>> +	dst_bo = gem_to_amdgpu_bo(dst_gobj);
>> +
>> +	if (amdgpu_bo_size(src_bo) < amdgpu_bo_size(dst_bo)) {
>> +		r = -E2BIG;
>> +		goto err_sizes;
>> +	}
>> +
>> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>> +
>> +	drm_exec_until_all_locked(&exec) {
>> +		r = drm_exec_prepare_obj(&exec, &src_bo->tbo.base, 1);
>> +		drm_exec_retry_on_contention(&exec);
>> +		if (r)
>> +			goto err_unlock;
>> +
>> +		r = drm_exec_prepare_obj(&exec, &dst_bo->tbo.base, 1);
>> +		drm_exec_retry_on_contention(&exec);
>> +		if (r)
>> +			goto err_unlock;
>> +	}
>> +
>> +	src_mem.bo = &src_bo->tbo;
>> +	src_mem.mem = src_bo->tbo.resource;
>> +	dst_mem.bo = &dst_bo->tbo;
>> +	dst_mem.mem = dst_bo->tbo.resource;
>> +	e = atomic_inc_return(&adev->mman.next_move_entity) %
>> +			      adev->mman.num_move_entities;
>> +	r = amdgpu_ttm_copy_mem_to_mem(adev, &adev->mman.move_entities[e],
>> +				       &src_mem, &dst_mem,
>> +				       amdgpu_bo_size(src_bo),
>> +				       amdgpu_bo_encrypted(src_bo),
>> +				       dst_bo->tbo.base.resv, &fence);
>> +	if (r) {
>> +		goto err_unlock;
>> +	} else if (!fence) {
>> +		r = -ENXIO;
>> +		goto err_unlock;
>> +	}
>> +
>> +	dma_resv_add_fence(src_bo->tbo.base.resv, fence, DMA_RESV_USAGE_READ);
>> +	dma_resv_add_fence(dst_bo->tbo.base.resv, fence, DMA_RESV_USAGE_WRITE);
>> +	dma_fence_put(fence);
>> +	drm_exec_fini(&exec);
>> +
>> +	timeout = dma_resv_wait_timeout(dst_bo->tbo.base.resv,
>> +					DMA_RESV_USAGE_WRITE, true,
>> +					MAX_SCHEDULE_TIMEOUT);
>> +	if (timeout < 0)
>> +		return timeout;
>> +	else if (timeout == 0)
>> +		return -ETIME;
>> +	else
>> +		goto out_put;
>> +
>> +err_unlock:
>> +	drm_exec_fini(&exec);
>> +out_put:
>> +err_sizes:
>> +	drm_gem_object_put(dst_gobj);
>> +err_dst:
>> +	drm_gem_object_put(src_gobj);
>> +	return r;
>> +}
>> +
>>   static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>>   				  int width,
>>   				  int cpp,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>> index 0e17d9fc665f..64529680fdad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
>> @@ -71,6 +71,8 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>>   				  struct drm_file *filp);
>>   int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
>>   				   struct drm_file *filp);
>> +int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
>> +				 struct drm_file *filp);
>>   
>>   int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>>   				struct drm_file *filp);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 4023c84fe29d..3baad073ed54 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -294,13 +294,13 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>    *
>>    */
>>   __attribute__((nonnull))
>> -static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>> -				      struct amdgpu_ttm_buffer_entity *entity,
>> -				      const struct amdgpu_copy_mem *src,
>> -				      const struct amdgpu_copy_mem *dst,
>> -				      uint64_t size, bool tmz,
>> -				      struct dma_resv *resv,
>> -				      struct dma_fence **f)
>> +int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>> +			       struct amdgpu_ttm_buffer_entity *entity,
>> +			       const struct amdgpu_copy_mem *src,
>> +			       const struct amdgpu_copy_mem *dst,
>> +			       uint64_t size, bool tmz,
>> +			       struct dma_resv *resv,
>> +			       struct dma_fence **f)
>>   {
>>   	struct amdgpu_res_cursor src_mm, dst_mm;
>>   	struct dma_fence *fence = NULL;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 8c0424577dea..360a860b8280 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -286,4 +286,11 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
>>   				    enum dma_data_direction dir,
>>   				    struct sg_table *sgt);
>>   
>> +int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>> +			       struct amdgpu_ttm_buffer_entity *entity,
>> +			       const struct amdgpu_copy_mem *src,
>> +			       const struct amdgpu_copy_mem *dst,
>> +			       uint64_t size, bool tmz,
>> +			       struct dma_resv *resv,
>> +			       struct dma_fence **f);
>>   #endif
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index d2a7b4e9daed..1335a181eb39 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -59,6 +59,7 @@ extern "C" {
>>   #define DRM_AMDGPU_USERQ_WAIT		0x18
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>>   #define DRM_AMDGPU_GEM_LIST_CONTEXTS	0x20
>> +#define DRM_AMDGPU_GEM_COPY_BUFFER	0x21
>>   
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -81,6 +82,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
>> +#define DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_COPY_BUFFER, struct drm_amdgpu_gem_copy_buffer)
>>   
>>   /**
>>    * DOC: memory domains
>> @@ -206,6 +208,12 @@ union drm_amdgpu_gem_create {
>>   	struct drm_amdgpu_gem_create_out	out;
>>   };
>>   
>> +struct drm_amdgpu_gem_copy_buffer {
>> +	__u32	src_handle;
>> +	__u32	dst_handle;
>> +	__u64	flags;
>> +};
>> +
>>   /** Opcode to create new residency list.  */
>>   #define AMDGPU_BO_LIST_OP_CREATE	0
>>   /** Opcode to destroy previously created residency list */
> 

