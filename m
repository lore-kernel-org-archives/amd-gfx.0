Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFF6CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 09:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA5A10E293;
	Wed, 13 May 2026 09:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="UR4llAS7";
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="UFFghO1U";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AECBC10E293
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1778663868; bh=ZoFC+q/UObhvQwgY19KFGx8
 zlJpvMLgrng2Gg8BunsE=; b=UR4llAS7EEK1+B3Kx5TYh+1uZgDwtVX3UJMoH3jZL1Fpa1Z6iu
 HS7OLIddRkIxwMNT7wEwQRwavcorToQD31Bg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1778663868; bh=ZoFC+q/UObhvQwgY19KFGx8
 zlJpvMLgrng2Gg8BunsE=; b=UFFghO1Ux0dev/D8v3dlxeY+QE4tUqZvP4EJSRUi9hCwkCYen7
 oQQHaXLQ/Yyw1e2npesfb5oKL5GL9J3O2D8llGFEtUfQSLtJMusQKu/2VmMijSzVzjtv53c2zBm
 07lz6VC+ejlD/WjBgot3wqlJp8TNsGWFgCur6u3lL8i28u5LZoBf/ZVP7zEGkPM+cSJ2r8ITeBV
 UCYOoJAPRPzqUfmrIM7xTOYOoRG0xVsz9/7YGoovzmLOF4WApiVPF5k/L/Q+prorJ5rKME665Y+
 vpyMtYdhMdxrZGzh123j6GPHgTLNgcS0srinI7XSMYWdnjIlhC2L+AsQKs4QUttGDnA==;
Message-ID: <9132afee-bc28-4e70-9f5d-9065f425a871@damsy.net>
Date: Wed, 13 May 2026 11:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: add eviction fence tracepoints for userq
 profiling
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
 <20260511135435.3818345-4-Prike.Liang@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260511135435.3818345-4-Prike.Liang@amd.com>
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
> Add ftrace events for the userq eviction fence lifecycle.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  8 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 42 +++++++++++++++++++
>   2 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 5ae477c49a53..9358f9b35914 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -24,6 +24,7 @@
>   #include <linux/sched.h>
>   #include <drm/drm_exec.h>
>   #include "amdgpu.h"
> +#include "amdgpu_trace.h"
>   
>   static const char *
>   amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
> @@ -44,6 +45,8 @@ static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
>   {
>   	struct amdgpu_eviction_fence *ev_fence = to_ev_fence(f);
>   
> +	trace_amdgpu_userq_eviction_fence_enable_signaling(f->context,
> +							   f->seqno);
>   	schedule_work(&ev_fence->evf_mgr->suspend_work);
>   	return true;
>   }
> @@ -84,6 +87,8 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>   	 * next fence.
>   	 */
>   	dma_fence_signal(ev_fence);
> +	trace_amdgpu_userq_eviction_fence_signal(ev_fence->context,
> +						 ev_fence->seqno);
>   	dma_fence_end_signalling(cookie);
>   	dma_fence_put(ev_fence);
>   
> @@ -138,7 +143,8 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>   	/* Remember it for newly added BOs */
>   	dma_fence_put(evf_mgr->ev_fence);
>   	evf_mgr->ev_fence = &ev_fence->base;
> -
> +	trace_amdgpu_userq_eviction_fence_emit(ev_fence->base.context,
> +					       ev_fence->base.seqno);
>   	/* And add it to all existing BOs */
>   	drm_exec_for_each_locked_object(exec, index, obj) {
>   		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d421a44ef933..5191f4e957d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -709,6 +709,48 @@ TRACE_EVENT(amdgpu_userq_fence_signal,
>   	    TP_printk("context=%llu, seqno=%llu, rptr=%llu",
>   		      __entry->context, __entry->seqno, __entry->rptr)
>   );
> +TRACE_EVENT(amdgpu_userq_eviction_fence_emit,
> +	    TP_PROTO(u64 context, u64 seqno),
> +	    TP_ARGS(context, seqno),
> +	    TP_STRUCT__entry(
> +			     __field(u64, context)
> +			     __field(u64, seqno)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->context = context;
> +			   __entry->seqno = seqno;
> +			   ),
> +	    TP_printk("context=%llu, seqno=%llu",
> +		      __entry->context, __entry->seqno)

I'll leave it to others to decide if these events are useful, but if you keep them please use 
"fence=%llu:%llu" for consistency.

Pierre-Eric

> +);
> +TRACE_EVENT(amdgpu_userq_eviction_fence_enable_signaling,
> +	    TP_PROTO(u64 context, u64 seqno),
> +	    TP_ARGS(context, seqno),
> +	    TP_STRUCT__entry(
> +			     __field(u64, context)
> +			     __field(u64, seqno)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->context = context;
> +			   __entry->seqno = seqno;
> +			   ),
> +	    TP_printk("context=%llu, seqno=%llu",
> +		      __entry->context, __entry->seqno)
> +);
> +TRACE_EVENT(amdgpu_userq_eviction_fence_signal,
> +	    TP_PROTO(u64 context, u64 seqno),
> +	    TP_ARGS(context, seqno),
> +	    TP_STRUCT__entry(
> +			     __field(u64, context)
> +			     __field(u64, seqno)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->context = context;
> +			   __entry->seqno = seqno;
> +			   ),
> +	    TP_printk("context=%llu, seqno=%llu",
> +		      __entry->context, __entry->seqno)
> +);
>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>   
