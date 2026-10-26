Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F0606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HhaX5Ai0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79F210E093;
	Mon, 26 Oct 2026 08:41:54 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1318E10E093
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 08:41:49 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so22126305e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793004107; x=1793608907; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6IVCdkrCh0aEwNonaEiXhM6+cOrjo2BCO6M2E4R9GcE=;
 b=HhaX5Ai03Xob/2DP1hLtRStdR9nA6OneVY4QCsyyYTUjo3ORhEfyxkUfavt0/WsL59
 sBdC3tFUCmwrH/ahlZudBuf+VJKHOxXKWkOZLOBMKA8pteEd5weLWcCc1EOVTmOkcVyO
 RfT3dz9EwuuCCJCwcBj6IhmQijW2i+TxaBzdmm2wqpNwWTT3tlYtmmV7F77QarVu5AeE
 XmRUFkILNrbHjkm/Eg0UlchzbmLMOR7e9isy8J5pfIAMBXkWPoq1T+1OBMlAlsffmxNY
 IsDJ21k8oqZZX2hMGJ8f/r3Te028Z8EcM3PuRLrAkdlG1lZxgXElP7b4+e+JNSd8MrC4
 maNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793004107; x=1793608907;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6IVCdkrCh0aEwNonaEiXhM6+cOrjo2BCO6M2E4R9GcE=;
 b=HMof7Yv2ShdOB6/rTDVRgkrF+aLR4tiw6QbcPMg0FDVFlOZ/vJl4DB9Bu9gT/zHGaU
 1sUKvoHX0la9y/ic4KaDkDqv5IHrBKLN3kWiSM0uPfCUNnEJI6yV0GdfzM5HDShDKk7s
 J7uBXtDbGkY5WmFn0S4ZFVWjN690QiBUcwf4/g6LHPcEIai5Crtv4qCIkE5e+mE7QRu/
 WAnQfM48zNOiKbD00iSzujxqYbijV/xGUmTxXjK+GBOiNC1u/7BI2FW/eSjX2f2kDm9C
 FtDqhXOQCw/DRP1YMUH9vdluPN6lMDe0tejWdDGKuM2yKz15uJtWIVa8bKZh3l5BjjuX
 6//Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRc2IuPaE183GTAFAzgou/FYm9fQvc1KY8sTOqzwD0000DuzX2BD0HQHyXHqTzc1iUFLpO2igE@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL8jsZiABYqU0l7bq3kaCBM75OEMSykLOhwrJ433uAjJ5mbqSfb
 emug2UwCLef9YFOULTpseDgZY8XDLbdc105CB+cy/75GCjtEJ1HE9zeyAJ7C6Ntc
X-Gm-Gg: AYBFou0D41fpATpHlNcR8RQ87a3ybgNQ0Wttfcz9nUb2uK8XDqxEA7rKNQhsHApHjCD
 gYoLVc3obyhlOCJfdmBQo+QvV92ZcHcWKii89rbY6deCQ2FmrXTYQT7dd/Oqu1sUKArKzLyPvdc
 oKP85/fOLs4qeSt1cbmZcfyMcwilqQtNILSe0wPVfNbxneI+Y3plCWpiTzNj60QPqmzHYBSshQ5
 ZrWaTrRryXa4SbWoyXMFw7pgfWKXLHdXKK11pzOVGbkDyo5+irkLN3qJzKQ0xFnKozyKh8Qu36a
 n2wa3JN5dmzldLfH7/f1hSQnyyBlfDlWiGE5Xf3f4VXrnnn+UiN41AOje5dtmUqisbi5K9eugjE
 bPYhBf5INCU8gc1K0DOV5WMOkQ9yctBPSjyBbekdNJcuot3rDH6Yc32KhRG5UxFaeb2KxfsiB6R
 xyXEHp/lhQnmEEsHBFh/hY9cVTs7JJzmnE5CUwM9nqpwcqBprF2saeRuhbJJTDv6p9IQnfPAiEK
 HAhLbLhQbggKPcDnZ9Ti8HlBBxe6PYp7yO4bnci7PgDyeI43LMxmptkBcvvnWDpCQ/litWd42Ot
 h+nAXVuk
X-Received: by 2002:a05:600c:c16b:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4a35aae5cbamr106099815e9.0.1793004107065; 
 Mon, 26 Oct 2026 01:41:47 -0700 (PDT)
Received: from [10.254.154.13] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a74d7f18a3sm3307815e9.1.2026.10.26.01.41.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 01:41:46 -0700 (PDT)
Message-ID: <458301ce-6fb7-466c-9ab7-f3eea221c0ae@gmail.com>
Date: Mon, 26 Oct 2026 09:41:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: fix wake event stealing in fence_is_signaled
 polling
To: Bogdan Metla <edistuo.revresbo@gmail.com>, amd-gfx@lists.freedesktop.org, 
 Philipp Stanner <phasta@kernel.org>
References: <20261012204357.785030-1-edistuo.revresbo@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20261012204357.785030-1-edistuo.revresbo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/12/26 22:43, Bogdan Metla wrote:
> Commit 5f08eee9c3fb ("drm/radeon: restore hardware polling in
> fence_is_signaled to fix performance regression") restored hardware
> polling by calling radeon_fence_activity() inside the dma-fence
> .signaled callback.
> 
> During the review of that patch, the automated kernel reviewer
> flagged a [High] severity issue: radeon_fence_activity() in the
> .signaled callback consumes hardware state without waking up wait
> queues. Because last_seq is advanced there, a later interrupt-driven
> radeon_fence_process() sees no new activity (seq <= last_seq),
> returns false and skips wake_up_all(). This steals the wake event
> and can leave tasks waiting on fences hanging indefinitely.
> 
> Reproduced on Radeon HD 5450 (Cedar), where interrupts can be
> missed under heavy 2D redraw load: the screen freezes while the
> cursor keeps moving, and recovery requires new GPU work (e.g.
> glxgears) or a modeset to trigger a fresh interrupt.
> 
> Fix this by scheduling a deferred work item when
> radeon_fence_activity() reports new completions inside
> radeon_fence_is_signaled(). The worker calls wake_up_all()
> unconditionally from process context, which restores the stolen
> wake event without re-introducing the self-deadlock on the fence
> lock, and without rw_semaphore manipulation in atomic context.
> schedule_work() is idempotent, so repeated polling is cheap.

Yeah that is just another workaround because of the broken dma_fence signaling design.

I think we should just fix the dma_fence design instead of applying more and more workarounds to each individual dma_fence backend.

Regards,
Christian.

> 
> Assisted-by: LLM
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5955
> Fixes: 5f08eee9c3fb ("drm/radeon: restore hardware polling in fence_is_signaled to fix performance regression")
> Signed-off-by: Bogdan Metla <edistuo.revresbo@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon.h       |  1 +
>  drivers/gpu/drm/radeon/radeon_fence.c | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
> index 527b9d19d7..61b01df87f 100644
> --- a/drivers/gpu/drm/radeon/radeon.h
> +++ b/drivers/gpu/drm/radeon/radeon.h
> @@ -370,6 +370,7 @@ struct radeon_fence_driver {
>  	atomic64_t			last_seq;
>  	bool				initialized, delayed_irq;
>  	struct delayed_work		lockup_work;
> +	struct work_struct		wake_work;
>  };
>  
>  struct radeon_fence {
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
> index 2998655692..5016dd0cbc 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -155,6 +155,15 @@ int radeon_fence_emit(struct radeon_device *rdev,
>  	return 0;
>  }
>  
> +static void radeon_fence_wake_work(struct work_struct *work)
> +{
> +	struct radeon_fence_driver *fence_drv =
> +		  container_of(work, struct radeon_fence_driver, wake_work);
> +	struct radeon_device *rdev = fence_drv->rdev;
> +
> +	wake_up_all(&rdev->fence_queue);
> +}
> +
>  /*
>   * radeon_fence_check_signaled - callback from fence_queue
>   *
> @@ -361,7 +370,8 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
>  		return true;
>  
>  	if (down_read_trylock(&rdev->exclusive_lock)) {
> -		radeon_fence_activity(rdev, ring);
> +		if (radeon_fence_activity(rdev, ring))
> +			schedule_work(&rdev->fence_drv[ring].wake_work);
>  		up_read(&rdev->exclusive_lock);
>  
>  		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
> @@ -826,6 +836,7 @@ static void radeon_fence_driver_init_ring(struct radeon_device *rdev, int ring)
>  	rdev->fence_drv[ring].initialized = false;
>  	INIT_DELAYED_WORK(&rdev->fence_drv[ring].lockup_work,
>  			  radeon_fence_check_lockup);
> +	INIT_WORK(&rdev->fence_drv[ring].wake_work, radeon_fence_wake_work);
>  	rdev->fence_drv[ring].rdev = rdev;
>  }
>  
> @@ -873,6 +884,7 @@ void radeon_fence_driver_fini(struct radeon_device *rdev)
>  			radeon_fence_driver_force_completion(rdev, ring);
>  		}
>  		cancel_delayed_work_sync(&rdev->fence_drv[ring].lockup_work);
> +		cancel_work_sync(&rdev->fence_drv[ring].wake_work);
>  		wake_up_all(&rdev->fence_queue);
>  		radeon_scratch_free(rdev, rdev->fence_drv[ring].scratch_reg);
>  		rdev->fence_drv[ring].initialized = false;

