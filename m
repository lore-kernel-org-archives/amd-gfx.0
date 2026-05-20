Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE77DCD5BA4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 12:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B74110E10A;
	Wed, 20 May 2026 12:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="nhbRX+xK";
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="v2M7dDcs";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F4710E10A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1779279922; bh=sTXiwCuEjd51Y8Y1y+meVgG
 VS81wAazUBhyfUJS42eE=; b=nhbRX+xKWRNy23lXFoqn9MBWpc94yfTaIIprz5chaw9VkIWx+U
 /4xK2zqP/978wzMp/eVZf4kVxhL6KMe2ASDQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1779279922; bh=sTXiwCuEjd51Y8Y1y+meVgG
 VS81wAazUBhyfUJS42eE=; b=v2M7dDcsHh6xJk3y+L48V9cm5OE43wlyHsAIO5inDh7zmaezgj
 nSpiZ0GqGTEU7fjSiDdgRtEE5cHvXYzS+XJF/gKycnHFXXjn04EC/HZ8VtFCtV8xanvv13Tm/ZK
 UImDpb4ecrX8VHjPiwEoos63gaUOzUg1GtbLdGZIY1zzkdzq4nhgrs0conPVfODjduRAxl17Exr
 BAWDb61+EIiv1vG577bA3kJsPKfW8J8jrsAI/tfqiQ9m/UUi+Ag5RlTTeKr6KX9w5EslsWDLYq5
 lyVmn9rThmOjrO4j0wMyA1912c0CEWr6IFlT58dWug51q09irQ9FVYthntp0R3rRhAw==;
Message-ID: <53182667-ec08-4c88-a191-53b526b8a457@damsy.net>
Date: Wed, 20 May 2026 14:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: add userq job and state transition trace
 events
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, pierre-eric.pelloux-prayer@amd.com
References: <20260520063859.15914-1-Prike.Liang@amd.com>
 <20260520063859.15914-3-Prike.Liang@amd.com>
 <15b6482a-e102-430f-ad91-36d1024766df@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <15b6482a-e102-430f-ad91-36d1024766df@amd.com>
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



Le 20/05/2026 à 11:14, Christian König a écrit :
> On 5/20/26 08:38, Prike Liang wrote:
>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>
>> Add ftrace events for tracking the userq fence emit, signal
>> and queue state transition.
> 
> The queue trace points look good to me, but clear NAK to the fence trace points those just duplicates the common trace points in the dma_fence framework.

The dma_fence trace points don't contain enough context to be usable from a tool (no device, no 
client id at the very least).

The userqueue events are based on the gpu_scheduler traces and are what is required for UMR to 
implement its Activity view.

Pierre-Eric

> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 129 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 +++
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  13 +-
>>   3 files changed, 160 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index 4ff8a4d7bb8b..32d8c36caaf3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> @@ -28,6 +28,8 @@
>>   #include <linux/types.h>
>>   #include <linux/tracepoint.h>
>>   
>> +#include "amdgpu_userq_fence.h"
>> +
>>   #undef TRACE_SYSTEM
>>   #define TRACE_SYSTEM amdgpu
>>   #define TRACE_INCLUDE_FILE amdgpu_trace
>> @@ -659,6 +661,133 @@ DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_enable_sig
>>   DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_signal,
>>   	    TP_PROTO(u64 context, u64 seqno),
>>   	    TP_ARGS(context, seqno));
>> +TRACE_EVENT(amdgpu_userq_job_run,
>> +	    TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *fence),
>> +	    TP_ARGS(device, queue, fence),
>> +	    TP_STRUCT__entry(
>> +			     __field(u64, fence_context)
>> +			     __field(u64, fence_seqno)
>> +			     __string(dev, dev_name(device))
>> +			     __field(u64, doorbell_index)
>> +			     __field(u64, client_id)
>> +			     __field(u32, queue_type)
>> +			     ),
>> +	    TP_fast_assign(
>> +			   __entry->fence_context = fence->base.context;
>> +			   __entry->fence_seqno = fence->base.seqno;
>> +			   __assign_str(dev);
>> +			   __entry->doorbell_index = queue->doorbell_index;
>> +			   __entry->client_id = queue->userq_mgr->file->client_id;
>> +			   __entry->queue_type = queue->queue_type;
>> +			   ),
>> +	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, fence=%llu:%llu",
>> +		      __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index,
>> +		      __entry->fence_context,
>> +		      __entry->fence_seqno)
>> +);
>> +
>> +TRACE_EVENT(amdgpu_userq_job_done,
>> +	    TP_PROTO(struct amdgpu_userq_fence *fence),
>> +	    TP_ARGS(fence),
>> +	    TP_STRUCT__entry(
>> +			     __field(u64, fence_context)
>> +			     __field(u64, fence_seqno)
>> +			     ),
>> +	    TP_fast_assign(
>> +			   __entry->fence_context = fence->base.context;
>> +			   __entry->fence_seqno = fence->base.seqno;
>> +			   ),
>> +	    TP_printk("fence=%llu:%llu",
>> +		      __entry->fence_context,
>> +		      __entry->fence_seqno)
>> +);
>> +
>> +TRACE_EVENT(amdgpu_userq_job_queue,
>> +	    TP_PROTO(struct device *device,
>> +		     struct amdgpu_usermode_queue *queue),
>> +	    TP_ARGS(device, queue),
>> +	    TP_STRUCT__entry(__field(u64, context)
>> +			     __string(dev, dev_name(device))
>> +			     __field(u64, doorbell_index)
>> +			     __field(u64, client_id)
>> +			     __field(u32, queue_type)
>> +			     ),
>> +	    TP_fast_assign(__assign_str(dev);
>> +			   __entry->doorbell_index = queue->doorbell_index;
>> +			   __entry->queue_type = queue->queue_type;
>> +			   __entry->client_id = queue->userq_mgr->file->client_id;
>> +			   __entry->context = queue->fence_drv->context;
>> +			  ),
>> +	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu",
>> +		      __get_str(dev), __entry->client_id, __entry->queue_type,
>> +		      __entry->doorbell_index, __entry->context)
>> +);
>> +
>> +TRACE_EVENT(amdgpu_userq_job_add_dep,
>> +	    TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *dep),
>> +	    TP_ARGS(device, queue, dep),
>> +	    TP_STRUCT__entry(
>> +			     __field(u64, context)
>> +			     __field(u64, dep_context)
>> +			     __field(u64, dep_seqno)
>> +			     __string(dev, dev_name(device))
>> +			     __field(u64, doorbell_index)
>> +			     __field(u64, client_id)
>> +			     __field(u32, queue_type)
>> +			     ),
>> +	    TP_fast_assign(
>> +			   __assign_str(dev);
>> +			   __entry->doorbell_index = queue->doorbell_index;
>> +			   __entry->queue_type = queue->queue_type;
>> +			   __entry->client_id = queue->userq_mgr->file->client_id;
>> +			   __entry->context = queue->fence_drv->context;
>> +			   __entry->dep_context = dep->base.context;
>> +			   __entry->dep_seqno = dep->base.seqno;
>> +			   ),
>> +	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu depends on fence=%llu:%llu",
>> +		      __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->context,
>> +		      __entry->dep_context,
>> +		      __entry->dep_seqno)
>> +);
>> +
>> +TRACE_EVENT(amdgpu_userq_state_start,
>> +	    TP_PROTO(struct amdgpu_usermode_queue *queue),
>> +	    TP_ARGS(queue),
>> +	    TP_STRUCT__entry(
>> +			     __field(u64, doorbell_index)
>> +			     __field(u64, client_id)
>> +			     __field(u32, queue_type)
>> +			     __field(u32, from)
>> +			     ),
>> +	    TP_fast_assign(
>> +			   __entry->doorbell_index = queue->doorbell_index;
>> +			   __entry->queue_type = queue->queue_type;
>> +			   __entry->client_id = queue->userq_mgr->file->client_id;
>> +			   __entry->from = queue->state;
>> +			   ),
>> +	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, from=%d",
>> +		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->from)
>> +);
>> +
>> +TRACE_EVENT(amdgpu_userq_state_changed,
>> +	    TP_PROTO(struct amdgpu_usermode_queue *queue, enum amdgpu_userq_state new_state),
>> +	    TP_ARGS(queue, new_state),
>> +	    TP_STRUCT__entry(
>> +			     __field(u64, doorbell_index)
>> +			     __field(u64, client_id)
>> +			     __field(u32, queue_type)
>> +			     __field(u32, to)
>> +			     ),
>> +	    TP_fast_assign(
>> +			   __entry->doorbell_index = queue->doorbell_index;
>> +			   __entry->queue_type = queue->queue_type;
>> +			   __entry->client_id = queue->userq_mgr->file->client_id;
>> +			   __entry->to = new_state;
>> +			   ),
>> +	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, to=%d",
>> +		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
>> +);
>> +
>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>   #endif
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index e27f9a76f986..60d1186af286 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -329,11 +329,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>>   	int r;
>>   
>>   	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>> +		trace_amdgpu_userq_state_start(queue);
>> +
>>   		r = userq_funcs->preempt(queue);
>>   		if (r) {
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
>>   			return r;
>>   		} else {
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_PREEMPTED);
>>   			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
>>   		}
>>   	}
>> @@ -349,10 +353,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
>>   	int r = 0;
>>   
>>   	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
>> +		trace_amdgpu_userq_state_start(queue);
>> +
>>   		r = userq_funcs->restore(queue);
>>   		if (r) {
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
>>   		} else {
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>   			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>   		}
>>   	}
>> @@ -370,12 +378,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>>   
>>   	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
>>   	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
>> +		trace_amdgpu_userq_state_start(queue);
>>   
>>   		r = userq_funcs->unmap(queue);
>>   		if (r) {
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
>>   			return r;
>>   		} else {
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
>>   			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
>>   		}
>>   	}
>> @@ -392,11 +403,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>>   	int r;
>>   
>>   	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
>> +		trace_amdgpu_userq_state_start(queue);
>> +
>>   		r = userq_funcs->map(queue);
>>   		if (r) {
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
>>   			return r;
>>   		} else {
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>   			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>   		}
>>   	}
>> @@ -1007,6 +1022,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>   		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>>   			drm_file_err(uq_mgr->file,
>>   				     "trying restore queue without va mapping\n");
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
>>   			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>   			continue;
>>   		}
>> @@ -1502,12 +1518,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>>   		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
>>   			continue;
>>   
>> +		trace_amdgpu_userq_state_start(queue);
>>   		userq_funcs = adev->userq_funcs[queue->queue_type];
>>   		userq_funcs->unmap(queue);
>>   		/* just mark all queues as hung at this point.
>>   		 * if unmap succeeds, we could map again
>>   		 * in amdgpu_userq_post_reset() if vram is not lost
>>   		 */
>> +		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>   		queue->state = AMDGPU_USERQ_STATE_HUNG;
>>   		amdgpu_userq_fence_driver_force_completion(queue);
>>   	}
>> @@ -1526,6 +1544,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>>   
>>   	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>   		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
>> +			trace_amdgpu_userq_state_start(queue);
>> +
>>   			userq_funcs = adev->userq_funcs[queue->queue_type];
>>   			/* Re-map queue */
>>   			r = userq_funcs->map(queue);
>> @@ -1533,6 +1553,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>>   				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
>>   				continue;
>>   			}
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>   			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>   		}
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 008330a0d852..00cc7194321c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -30,7 +30,7 @@
>>   #include <drm/drm_syncobj.h>
>>   
>>   #include "amdgpu.h"
>> -#include "amdgpu_userq_fence.h"
>> +#include "amdgpu_trace.h"
>>   
>>   #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
>>   
>> @@ -169,6 +169,7 @@ amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>>   		fence = &userq_fence->base;
>>   		list_del_init(&userq_fence->link);
>>   		dma_fence_signal(fence);
>> +		trace_amdgpu_userq_job_done(userq_fence);
>>   		/* Drop fence_drv_array outside fence_list_lock
>>   		 * to avoid the recursion lock.
>>   		 */
>> @@ -528,6 +529,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	/* Create the new fence */
>>   	amdgpu_userq_fence_init(queue, fence, wptr);
>>   
>> +	trace_amdgpu_userq_job_run(dev->dev, queue, fence);
>> +
>>   	mutex_unlock(&userq_mgr->userq_mutex);
>>   
>>   	/*
>> @@ -701,7 +704,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
>>   }
>>   
>>   static int
>> -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>> +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *filp,
>>   				    struct drm_amdgpu_userq_wait *wait_info,
>>   				    u32 *syncobj_handles, u32 *timeline_points,
>>   				    u32 *timeline_handles,
>> @@ -835,6 +838,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>   		goto free_fences;
>>   	}
>>   
>> +	trace_amdgpu_userq_job_queue(dev->dev, waitq);
>> +
>>   	for (i = 0, cnt = 0; i < num_fences; i++) {
>>   		struct amdgpu_userq_fence_driver *fence_drv;
>>   		struct amdgpu_userq_fence *userq_fence;
>> @@ -869,6 +874,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>   
>>   		amdgpu_userq_fence_driver_get(fence_drv);
>>   
>> +		trace_amdgpu_userq_job_add_dep(dev->dev, waitq, userq_fence);
>> +
>>   		/* Store drm syncobj's gpu va address and value */
>>   		fence_info[cnt].va = fence_drv->va;
>>   		fence_info[cnt].value = fences[i]->seqno;
>> @@ -968,7 +975,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   						   gobj_write,
>>   						   gobj_read);
>>   	} else {
>> -		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
>> +		r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
>>   							syncobj_handles,
>>   							timeline_points,
>>   							timeline_handles,
