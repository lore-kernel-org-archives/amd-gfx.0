Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526D7CD37B6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 09:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA13A10ED89;
	Wed, 13 May 2026 09:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="HLf+6ZS7";
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="rhpUV+q+";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4A010ED97
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1778663746; bh=DOqFj6pt+tRabR94V+kOdkK
 nO7UWvVIv+6NDYg0EMLg=; b=HLf+6ZS7HJDtb2Q4R+FgOkINPeUKdF0p6tRY67pIo3utJKGRzl
 6bIqADBGIC5IPw6UMP7Ew4FxPqVs33RtlABQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1778663746; bh=DOqFj6pt+tRabR94V+kOdkK
 nO7UWvVIv+6NDYg0EMLg=; b=rhpUV+q+FZ65aF9l9AxSd+JhIK0SobTYQ2eXjJaqYMkbnVe6g/
 3cfqQRHLMPxRgPcI0eumJATAb09XhFfMAUxk7dLVD9YmZSWgn1yi0/3sSdV13dYtxeJ7ieWj13t
 R7F0cPF4y8uF8H+Zd8H6NkXF8OM6+NKHf+LCQA/kN0/lenedmFRJ0I1CLpOJee43FScsdbLm0Dh
 gMlQid0sHam5bszAT/lZSOX/B5aoBJe18ex8fQ+w8FmQ6Z0HzoPJl/Rr8DBWjw9XLeJ8XhL8Qrq
 G567bPGYxgYNDn1j+nICqGZrs3OjFDihGkz2Ot5LXteiEGSoiYrmyv22UpDFIabRVIw==;
Message-ID: <81f4c3d9-a7ea-47b4-9f39-3c78e7d51a5f@damsy.net>
Date: Wed, 13 May 2026 11:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: add userq fence emit and signal
 tracepoints
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
 <20260511135435.3818345-3-Prike.Liang@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260511135435.3818345-3-Prike.Liang@amd.com>
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



Le 11/05/2026 à 15:54, Prike Liang a écrit :
> Add ftrace events for user queue fence emission and completion.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 48 +++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  8 ++++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 484fbb00068b..d421a44ef933 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -661,6 +661,54 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_map_end,
>   DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_unmap_end,
>   	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>   	     TP_ARGS(queue, result));
> +
> +TRACE_EVENT(amdgpu_userq_fence_emit,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue, u64 seqno,
> +		     unsigned int num_read_handles,
> +		     unsigned int num_write_handles,
> +		     unsigned int num_syncobj_handles),
> +	    TP_ARGS(queue, seqno, num_read_handles, num_write_handles,
> +		    num_syncobj_handles),
> +	    TP_STRUCT__entry(
> +			     __field(struct amdgpu_usermode_queue *, queue)
> +			     __field(u64, doorbell_index)
> +			     __field(int, queue_type)
> +			     __field(u64, seqno)
> +			     __field(unsigned int, num_read_handles)
> +			     __field(unsigned int, num_write_handles)
> +			     __field(unsigned int, num_syncobj_handles)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->queue = queue;
> +			   __entry->doorbell_index = queue ? queue->doorbell_index : 0;
> +			   __entry->queue_type = queue ? queue->queue_type : -1;
> +			   __entry->seqno = seqno;
> +			   __entry->num_read_handles = num_read_handles;
> +			   __entry->num_write_handles = num_write_handles;
> +			   __entry->num_syncobj_handles = num_syncobj_handles;
> +			   ),
> +	    TP_printk("queue=%p, doorbell=%llu, type=%d, seqno=%llu, read=%u, write=%u, syncobj=%u",
> +		      __entry->queue, __entry->doorbell_index,
> +		      __entry->queue_type, __entry->seqno,
> +		      __entry->num_read_handles, __entry->num_write_handles,
> +		      __entry->num_syncobj_handles)
> +);
> +TRACE_EVENT(amdgpu_userq_fence_signal,
> +	    TP_PROTO(u64 context, u64 seqno, u64 rptr),
> +	    TP_ARGS(context, seqno, rptr),
> +	    TP_STRUCT__entry(
> +			     __field(u64, context)
> +			     __field(u64, seqno)
> +			     __field(u64, rptr)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->context = context;
> +			   __entry->seqno = seqno;
> +			   __entry->rptr = rptr;
> +			   ),
> +	    TP_printk("context=%llu, seqno=%llu, rptr=%llu",
> +		      __entry->context, __entry->seqno, __entry->rptr)
> +);

Could you replace this patch with my version? The event names are more consistent with the kernel 
queue ones and it also has one event for dependencies.

Pierre-Eric


>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 369914cab555..50d1c3627279 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -31,6 +31,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_userq_fence.h"
> +#include "amdgpu_trace.h"
>   
>   #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
>   
> @@ -168,6 +169,9 @@ amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>   	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
>   		fence = &userq_fence->base;
>   		list_del_init(&userq_fence->link);
> +		trace_amdgpu_userq_fence_signal(fence_drv->context,
> +						userq_fence->base.seqno,
> +						rptr);
>   		dma_fence_signal(fence);
>   		/* Drop fence_drv_array outside fence_list_lock
>   		 * to avoid the recursion lock.
> @@ -530,6 +534,10 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   
>   	/* Create the new fence */
>   	amdgpu_userq_fence_init(queue, fence, wptr);
> +	trace_amdgpu_userq_fence_emit(queue, fence->base.seqno,
> +				      num_read_bo_handles,
> +				      num_write_bo_handles,
> +				      num_syncobj_handles);
>   
>   	mutex_unlock(&userq_mgr->userq_mutex);
>   
