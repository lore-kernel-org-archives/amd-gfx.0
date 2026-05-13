Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A576CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 09:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C9310E5C0;
	Wed, 13 May 2026 09:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="p62zGn8T";
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="uOKIjNE0";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B59910E293
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; r=y; 
 h=From:To:Subject:Date:Message-ID; t=1778663640; bh=C9chbBf7IaNkVaRjjfPec8T
 2ibaqMfb01CPAbT0IDv0=; b=p62zGn8TexhQ5vcRg1mmxAydTtKxLSu6s5Wxa+cmZaUdh1Q7HW
 TlTmzXlp7SF9v6XJfWg1MCLpTckHPqM2R8CA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
 r=y; 
 h=From:To:Subject:Date:Message-ID; t=1778663640; bh=C9chbBf7IaNkVaRjjfPec8T
 2ibaqMfb01CPAbT0IDv0=; b=uOKIjNE02KSUAZTw8GvN9Mncxy1888jevGMV6MYLthIQR9llrv
 zPzVhJ8/zo0wE0iqi+EgqHrxksDgmS0DOPEmBuGtb6eBXABfZK4htadJejmtDEk23azdhpXCiDK
 NdxyUndgq2nHKVvsX9Av53B7Lakromi/WDX1jdZZaRd0/4fbj5XOJ7W0S2eXsD011p2ZgOpyD6P
 /Eqi2ackB7rMGFJIE2O+J61lJ5QOvWpjTFB7v5BdYtBPl/kECLCd7YRJu8wBafW3/HHe5DZMyhZ
 9Xlt5fhm53WMkQL7pgkZpzWSMvN/tZn18qCfOX+cjAkNqagQVfAx+MEPg6zjkwLZwSg==;
Message-ID: <a3c2bd86-10d5-421f-9336-7a165323e190@damsy.net>
Date: Wed, 13 May 2026 11:14:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: add userq queue state transition
 tracepoints
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
 <20260511135435.3818345-2-Prike.Liang@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20260511135435.3818345-2-Prike.Liang@amd.com>
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
> Add ftrace events around user queue preempt, restore, map and unmap
> operations to profile runtime queue state transitions.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 25 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 12 ++++++++++-
>   2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 5a01f63d1f32..484fbb00068b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -636,6 +636,31 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
>   	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>   	     TP_ARGS(queue, result));
>   
> +
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_preempt_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_restore_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_map_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_unmap_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_preempt_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_restore_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_map_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_unmap_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 50c46d31fbae..83aee0810513 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -340,13 +340,16 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>   	int r;
>   
>   	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
> +		trace_amdgpu_userq_preempt_start(queue);
>   		r = userq_funcs->preempt(queue);
>   		if (r) {
>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
> +			trace_amdgpu_userq_preempt_end(queue, r);
>   			return r;
>   		} else {
>   			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
>   		}
> +		trace_amdgpu_userq_preempt_end(queue, r);

I prefer having only 2 trace points: trace_amdgpu_userq_state_change_start / end.
The _start event would print the current state and the _end one would print the new state.

Also these events should be used eveywhere "queue->state" is modified.

Pierre-Eric


>   	}
>   	return 0;
>   }
> @@ -360,12 +363,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
>   	int r = 0;
>   
>   	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
> +		trace_amdgpu_userq_restore_start(queue);
>   		r = userq_funcs->restore(queue);
>   		if (r) {
>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
>   		} else {
>   			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>   		}
> +		trace_amdgpu_userq_restore_end(queue, r);
>   	}
>   
>   	return r;
> @@ -381,14 +386,16 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>   
>   	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
>   	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
> -
> +		trace_amdgpu_userq_unmap_start(queue);
>   		r = userq_funcs->unmap(queue);
>   		if (r) {
>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
> +			trace_amdgpu_userq_unmap_end(queue, r);
>   			return r;
>   		} else {
>   			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
>   		}
> +		trace_amdgpu_userq_unmap_end(queue, 0);
>   	}
>   
>   	return 0;
> @@ -403,13 +410,16 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>   	int r;
>   
>   	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
> +		trace_amdgpu_userq_map_start(queue);
>   		r = userq_funcs->map(queue);
>   		if (r) {
>   			queue->state = AMDGPU_USERQ_STATE_HUNG;
> +			trace_amdgpu_userq_map_end(queue, r);
>   			return r;
>   		} else {
>   			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>   		}
> +		trace_amdgpu_userq_map_end(queue, 0);
>   	}
>   
>   	return 0;
