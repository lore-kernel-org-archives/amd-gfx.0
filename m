Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFCACD8C92
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 08:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AF110EFA4;
	Mon,  8 Jun 2026 08:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="USRjuu75";
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="Fbm9JgNj";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C2E10EFA4
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 08:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1780908828; bh=YKpIGGKqU7nQdiEaG3t4dMi
 XXGHqYRU8jhfJVHK5vao=; b=USRjuu75x2BE/r1QcYJSNyziVVoVFsUZaH5wU7rtI/PtLrJEk9
 1fjgIsbD5j3iD6eWpVQZUQwyoeLPgxVqznBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1780908828; bh=YKpIGGKqU7nQdiEaG3t4dMi
 XXGHqYRU8jhfJVHK5vao=; b=Fbm9JgNjK23Tk/ultN7+MB8beE1/BHw4ZPfcvKyjZfvWOPVQPT
 HpH+39psZtimsZrcKtI7EGR511f/fL6iDaCn7Q8c5jyu0xejeuGO4iBe17EeAY50p7PV0n4wwGB
 f4NdLSe7XqguyZR8/9/J5ZKEZhhQbL7h5xGdc3K/85s1c2Iiwh5gfPEfmtJ/+1red8voKZmjAn6
 2HbFFsiAcl9FPviWC0dNSxEwErjACFHL+9XfQUzLAGrwHcj07jvSfXbJWXelZD4qT+CjE7FMpQ2
 YwRY+FgJ2UN26z0wtt7KSnfdoK18OGXc2Urk6cks7LGKluCYFi56fs1Bpdc7IYBYtyQ==;
Message-ID: <4e1e2a69-7e38-4e0c-a2a3-a81d8efdf031@damsy.net>
Date: Mon, 8 Jun 2026 10:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add userq create and destroy tracepoints
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Pierre-eric.Pelloux-prayer@amd.com
References: <20260527122001.69831-1-Prike.Liang@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260527122001.69831-1-Prike.Liang@amd.com>
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



Le 27/05/2026 à 14:20, Prike Liang a écrit :
> Add ftrace events around user queue creation and destruction to profile
> queue setup and teardown latency.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 58 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  9 ++++
>   2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d13e64a69e25..df98be22f1f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
>   		      __entry->value)
>   );
>   
> +DECLARE_EVENT_CLASS(amdgpu_userq_queue,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	    TP_ARGS(queue),
> +	    TP_STRUCT__entry(
> +			     __field(void *, queue)
> +			     __field(u64, doorbell_index)
> +			     __field(int, queue_type)
> +			     __field(int, state)
> +			     __field(u32, xcp_id)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->queue = queue;
> +			   __entry->doorbell_index = queue->doorbell_index;


trace_amdgpu_userq_create_start() is called before this field is set.

> +			   __entry->queue_type = queue->queue_type;
> +			   __entry->state = queue->state;
> +			   __entry->xcp_id = queue->xcp_id;

this field seems never set for amdgpu_usermode_queue.

Pierre-Eric
> +			   ),
> +	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u",
> +		      __entry->queue, __entry->doorbell_index,
> +		      __entry->queue_type, __entry->state, __entry->xcp_id)
> +);
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_create_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_destroy_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DECLARE_EVENT_CLASS(amdgpu_userq_queue_result,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	    TP_ARGS(queue, result),
> +	    TP_STRUCT__entry(
> +			     __field(void *, queue)
> +			     __field(u64, doorbell_index)
> +			     __field(int, queue_type)
> +			     __field(int, state)
> +			     __field(u32, xcp_id)
> +			     __field(int, result)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->queue = queue;
> +			   __entry->doorbell_index = queue->doorbell_index;
> +			   __entry->queue_type = queue->queue_type;
> +			   __entry->state = queue->state;
> +			   __entry->xcp_id = queue->xcp_id;
> +			   __entry->result = result;
> +			   ),
> +	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u, result=%d",
> +		      __entry->queue, __entry->doorbell_index,
> +		      __entry->queue_type, __entry->state,
> +		      __entry->xcp_id, __entry->result)
> +);
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_create_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
> +
>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 38e310a8694d..9dc6cb579ac7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -33,6 +33,7 @@
>   #include "amdgpu_userq.h"
>   #include "amdgpu_hmm.h"
>   #include "amdgpu_userq_fence.h"
> +#include "amdgpu_trace.h"
>   
>   u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>   {
> @@ -509,6 +510,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>   	int r = 0;
>   
> +	trace_amdgpu_userq_destroy_start(queue);
> +
>   	cancel_delayed_work_sync(&uq_mgr->resume_work);
>   
>   	/* Cancel any pending hang detection work and cleanup */
> @@ -538,6 +541,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	amdgpu_bo_unpin(queue->wptr_obj.obj);
>   	amdgpu_bo_unreserve(queue->wptr_obj.obj);
>   	amdgpu_bo_unref(&queue->wptr_obj.obj);
> +	trace_amdgpu_userq_destroy_end(queue, r);
>   	kfree(queue);
>   
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -639,6 +643,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	INIT_DELAYED_WORK(&queue->hang_detect_work,
>   			  amdgpu_userq_hang_detect_work);
>   
> +	trace_amdgpu_userq_create_start(queue);
>   	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>   	if (r)
>   		goto free_queue;
> @@ -700,6 +705,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		r = amdgpu_userq_map_helper(queue);
>   		if (r) {
>   			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> +			trace_amdgpu_userq_create_end(queue, r);
>   			mutex_unlock(&uq_mgr->userq_mutex);
>   			goto erase_doorbell;
>   		}
> @@ -716,11 +722,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		 * This drops the last reference which should take care of
>   		 * all cleanup.
>   		 */
> +		trace_amdgpu_userq_create_end(queue, r);
>   		amdgpu_userq_put(queue);
>   		return r;
>   	}
>   
>   	amdgpu_debugfs_userq_init(filp, queue, qid);
> +	trace_amdgpu_userq_create_end(queue, 0);
>   	args->out.queue_id = qid;
>   	return 0;
>   
> @@ -736,6 +744,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   free_fence_drv:
>   	amdgpu_userq_fence_driver_free(queue);
>   free_queue:
> +	trace_amdgpu_userq_create_end(queue, r);
>   	kfree(queue);
>   err_pm_runtime:
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
