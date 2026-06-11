Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4269CD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 12:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5153D10E77A;
	Thu, 11 Jun 2026 12:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="M3HOw+Pj";
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="hGZ/j2js";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F9110E77A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1781180146; bh=vbjEm0taPtS/8PHiYBW0db1
 kzvK1RzaBWNU05OjEN3A=; b=M3HOw+PjB3EALcdcqazYa0zjse1qtSWuADZn8FExbNd4REJvTS
 CE0vobG9n4lg/uH3YZRG6Ab3DaSCq7MfzDAQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1781180146; bh=vbjEm0taPtS/8PHiYBW0db1
 kzvK1RzaBWNU05OjEN3A=; b=hGZ/j2jspXkdo+3y4DoOKaCYwRn9bVKK/A7m9qh92fiOmfmYwx
 /2FRcHcB2ZoZqKBLN1YemOLyE/80wQwimmj9lx4rRENUGkrPVR9FVdGC7iF3oOgdpeCUvIQHKkw
 Rw6vYdSEtt6uxnvlwqiSnGGeTdQWkKS886hrwaHAuseQWoufRIqEIvuf8kSsZ2qi+w04BjnLx5b
 56mLCALVn3MNUnCLlg6sK0U6LW3roD3JoobIN68juMF56VyjK19jd69P+fpJ5VdPAV1RHNRBhDk
 gQUe/2af/5eTLDWxrJ/DTjCHirY3lB3lCdxCH1EL4yfoiZGYUePVKXY2HE/1jsJl9Xg==;
Message-ID: <8bedfbb4-86d2-43ce-b593-fd93dbb4b10e@damsy.net>
Date: Thu, 11 Jun 2026 14:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdgpu: add userq job and state transition
 trace events
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Pierre-eric.Pelloux-prayer@amd.com
References: <20260611083311.191012-1-Prike.Liang@amd.com>
 <20260611083311.191012-3-Prike.Liang@amd.com>
 <8290c672-f85f-4525-acac-094073e3d6a3@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <8290c672-f85f-4525-acac-094073e3d6a3@amd.com>
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

Hi,


Le 11/06/2026 à 11:38, Christian König a écrit :
> 
> 
> On 6/11/26 10:33, Prike Liang wrote:
>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>
>> Add ftrace events for tracking the userq fence emit, signal
>> and queue state transition.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Co-developed-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 113 ++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 ++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  12 +-
>>   3 files changed, 143 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>> index df98be22f1f5..9f8506f04e9e 100644
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
>> @@ -636,6 +638,117 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
>>   	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>>   	     TP_ARGS(queue, result));
>>   
>> +TRACE_EVENT(amdgpu_userq_emit_fence,
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
>> +TRACE_EVENT(amdgpu_userq_run_queue,
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
>> +TRACE_EVENT(amdgpu_userq_wait_deps,
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
>> index 64b9127ef931..ede2263d8458 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -294,11 +294,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
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
>> @@ -314,10 +318,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
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
>> @@ -335,12 +343,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
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
>> @@ -357,11 +368,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
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
>> @@ -900,6 +915,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>   		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>>   			drm_file_err(uq_mgr->file,
>>   				     "trying restore queue without va mapping\n");
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
>>   			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>   			continue;
>>   		}
>> @@ -1392,12 +1408,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
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
>> @@ -1416,6 +1434,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>>   
>>   	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>   		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
>> +			trace_amdgpu_userq_state_start(queue);
>> +
>>   			userq_funcs = adev->userq_funcs[queue->queue_type];
>>   			/* Re-map queue */
>>   			r = userq_funcs->map(queue);
>> @@ -1423,6 +1443,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>>   				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
>>   				continue;
>>   			}
>> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>   			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>   		}
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index c0d68863fa17..95ee133f749e 100644
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
>> @@ -528,6 +528,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	/* Create the new fence */
>>   	amdgpu_userq_fence_init(queue, fence, wptr);
>>   
>> +	trace_amdgpu_userq_emit_fence(dev->dev, queue, fence);
>> +
>>   	mutex_unlock(&userq_mgr->userq_mutex);
>>   
>>   	/*
>> @@ -701,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
>>   }
>>   
>>   static int
>> -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>> +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *filp,
>>   				    struct drm_amdgpu_userq_wait *wait_info,
>>   				    u32 *syncobj_handles, u64 *timeline_points,
>>   				    u32 *timeline_handles,
>> @@ -835,6 +837,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>   		goto free_fences;
>>   	}
>>   
>> +	trace_amdgpu_userq_run_queue(dev->dev, waitq);
> 
> That one clearly needs a better name or we can maybe even completely drop it.
> 
> The queue doesn't run, what we do here is to start gathering the fences the queue need to wait for.

Let's remove this tracepoint for now.

Pierre-Eric


> 
> Apart from that looks good to me,
> Christian.
> 
>> +
>>   	for (i = 0, cnt = 0; i < num_fences; i++) {
>>   		struct amdgpu_userq_fence_driver *fence_drv;
>>   		struct amdgpu_userq_fence *userq_fence;
>> @@ -869,6 +873,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>   
>>   		amdgpu_userq_fence_driver_get(fence_drv);
>>   
>> +		trace_amdgpu_userq_wait_deps(dev->dev, waitq, userq_fence);
>> +
>>   		/* Store drm syncobj's gpu va address and value */
>>   		fence_info[cnt].va = fence_drv->va;
>>   		fence_info[cnt].value = fences[i]->seqno;
>> @@ -969,7 +975,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   						   gobj_write,
>>   						   gobj_read);
>>   	} else {
>> -		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
>> +		r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
>>   							syncobj_handles,
>>   							timeline_points,
>>   							timeline_handles,
