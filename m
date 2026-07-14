Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC92C44507
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 18:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545C010E2A5;
	Tue, 14 Jul 2026 18:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="IFTAlfjd";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E5C10E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 18:47:17 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so752032f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 11:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784054836; x=1784659636; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a9WXmmNJpTQqyIjoQ4EEaDTQ3drn6iTSUmSO7RWtW9s=;
 b=IFTAlfjdjAz1GbOQ4ggmuxoxiJ3DT7lFYrpCPXD8xwmYAOgt6EiEewL9PFC10xNgrL
 DmGKWlovkCcHiBPjDo3kUTj3hFY+ksl/YAImkkeM9aQWGXutcyB8WkbFbDyddC39pS3U
 fXRJhQl7jDbHqniGI4EZr9ALk61J7cgVMTuNHx+/U5gySsPAtEELE8TLsKwlkQJX8bwa
 XVVRkDi/EjE+gDvrvILPO5PsTg4rHqzB0JKvk0Sa4XKJl3wa8+lLuVV33Azg31fXZKXb
 y2PDQ1F/p96jqlq+wEWazNY7xLFDqJZ2mjdAy0gONqDM/8dAWkXSHyNsFSSnisW+sNTN
 qRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784054836; x=1784659636;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a9WXmmNJpTQqyIjoQ4EEaDTQ3drn6iTSUmSO7RWtW9s=;
 b=kjCX7gVrqaJ/vlmhM5INoFvOiy9shAXj+DW0XadG1mm5/1LQGt2M1dmqQqGmNOQNn7
 NdoVRcUSZ9D12jVo4kX9Rak2nhtyI/nBFhlDH/fKxBfkXSCje425QuPB95L+9qlSalqR
 i3VsiVxZgWf8Gs8CftIjya1JyMCHmvjUYdI86hg8QWWn+kFvK54//v2kG8IAlvp/b3QE
 Ttx2x/DhoFxPZgirvfn+TLpW1vbr4M0WBDmzC1SiIl4+0HzQTvKON1Dbzqsz6DbdpHcx
 EGVrGvBUxItXGn8r4TlIJ2X5R+UBXwg7uQh/Mw2WcryyhvPKTxsrQsM9wH5Wx+rkJiXo
 mJWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbE3IwBSRxhFvNoF3f+ZgUUqE9dBXEwE2pT4qHu/2Wd0udUef7xpzcNs9FBUdlHGaA+J46WCRy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxlJ3aB4k95aR0h67aJfi95G30i0vGC2Zw9QdQHCVlonKe8GO5
 Ts4z+qJtUW9RNFD0sbAxhFB2XzcjAxjAt+CZoSNxU7xq7EUJU0KqYpdBPwABpbRoNjE=
X-Gm-Gg: AfdE7cnFUJNKK2T2qhMyuYRnTPbfN8N65Y0FoIth1Auz/RfrRPsJyMtcltyPHtPJu9/
 x/6IS30o4O3bPSZV0+JcIfXBfgl0TmeqSdFtsLIjRPKzPb+e13klHlt4MYkr37AJ4yfZ/QJ9A67
 6VP22dWJL3bqNcWlcsF2dVTjuh6GPzrJ+b3ZE5lRHOvT8k8u0OwarQKebg8Vc8mnVxBtnk+KCyp
 VzynDjDeSquXO9BnqhtqE8IxomY7hdsnPhdsQvd7vhB5F5aNy0THOiZ0gRr8rnSu8YUGSPzczHO
 vjlUt+CiO68bzSvQy2swIWBEPVY/WpGGPyaw1h6Es30ggBwo1WPP/aTX5sML3YvVyhnzPiRqb0k
 YG+bs3MVV1/k+meEDDvHtgHX8wjq67Inby3M7KdNMDkA8rAyqaZHMnSQhCBDAHycxnkZZ/5Yecb
 GwaKBmwiV7iYmEjqJGAtCJoDnXoRoq2YCCmA==
X-Received: by 2002:a05:6000:2011:b0:470:2fb1:3dca with SMTP id
 ffacd0b85a97d-47f2dcd7487mr17050259f8f.30.1784054835326; 
 Tue, 14 Jul 2026 11:47:15 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a5d7sm10081119f8f.10.2026.07.14.11.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 11:47:14 -0700 (PDT)
Message-ID: <f0fe75db-5ded-4370-b931-3ef3827f0b16@ursulin.net>
Date: Tue, 14 Jul 2026 19:47:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu/gfx7: Refactor MQD initialization and
 finalization
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-3-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260713125838.30607-3-timur.kristof@gmail.com>
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


On 13/07/2026 13:58, Timur Kristóf wrote:
> Call amdgpu_gfx_mqd_sw_init()/_fini() on GFX7 to initialize and
> finalize the MQD, just like GFX8 and newer; instead of doing
> an ad-hoc BO allocation. This introduces the possibility of
> doing an MQD backup instead of trying to reinitialize the
> MQD every time.
> 
> This solves an issue with GFX IP block soft reset where
> all compute rings would hang after the reset.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 106 +++++++++++++-------------
>   1 file changed, 51 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 65b8497ad5f0..9c4b3ac27e1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2698,25 +2698,6 @@ static int gfx_v7_0_cp_compute_load_microcode(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -/**
> - * gfx_v7_0_cp_compute_fini - stop the compute queues
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Stop the compute queues and tear down the driver queue
> - * info.
> - */
> -static void gfx_v7_0_cp_compute_fini(struct amdgpu_device *adev)
> -{
> -	int i;
> -
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
> -
> -		amdgpu_bo_free_kernel(&ring->mqd_obj, NULL, NULL);
> -	}
> -}
> -
>   static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
>   {
>   	amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, NULL);
> @@ -2788,28 +2769,29 @@ static void gfx_v7_0_compute_pipe_init(struct amdgpu_device *adev,
>   	mutex_unlock(&adev->srbm_mutex);
>   }
>   
> -static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev)
> +static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev, u32 req)
>   {
> -	int i;
> +	int i, r = 0;
>   
>   	/* disable the queue if it's active */
> -	if (RREG32(mmCP_HQD_ACTIVE) & 1) {
> -		WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
> +	if (RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK) {
> +		WREG32_FIELD(CP_HQD_DEQUEUE_REQUEST, DEQUEUE_REQ, req);
>   		for (i = 0; i < adev->usec_timeout; i++) {
> -			if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
> +			if (!(RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK))
>   				break;
>   			udelay(1);
>   		}
>   
>   		if (i == adev->usec_timeout)
> -			return -ETIMEDOUT;
> +			r = -ETIMEDOUT;
>   
> -		WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> -		WREG32(mmCP_HQD_PQ_RPTR, 0);
> -		WREG32(mmCP_HQD_PQ_WPTR, 0);
>   	}
>   
> -	return 0;
> +	WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
> +	WREG32(mmCP_HQD_PQ_RPTR, 0);
> +	WREG32(mmCP_HQD_PQ_WPTR, 0);
> +
> +	return r;

I can see this matches gfx_v8_0_deactivate_hqd. If I am not missing 
anything only to replace the hardcoded 1 with CP_HQD_ACTIVE__ACTIVE_MASK?

Is it okay to call the function mqd if the registers are hqd and is v7 
or v8 (which calls it hqd) more correct? Not saying either way, just 
observing a curiosity.

>   }
>   
>   static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
> @@ -2964,31 +2946,42 @@ static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd)
>   
>   static int gfx_v7_0_compute_queue_init(struct amdgpu_device *adev, int ring_id)
>   {
> -	int r;
> -	u64 mqd_gpu_addr;
> -	struct cik_mqd *mqd;
>   	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
> -
> -	r = amdgpu_bo_create_reserved(adev, sizeof(struct cik_mqd), PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
> -				      &mqd_gpu_addr, (void **)&mqd);
> -	if (r) {
> -		dev_warn(adev->dev, "(%d) create MQD bo failed\n", r);
> -		return r;
> +	struct cik_mqd *mqd = ring->mqd_ptr;
> +	int mqd_idx = ring - &adev->gfx.compute_ring[0];
> +
> +	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
> +		memset((void *)mqd, 0, ring->mqd_size);
> +		mutex_lock(&adev->srbm_mutex);
> +		cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +		gfx_v7_0_mqd_init(adev, mqd, ring->mqd_gpu_addr, ring);
> +		gfx_v7_0_mqd_deactivate(adev, 1);
> +		gfx_v7_0_mqd_commit(adev, mqd);
> +		cik_srbm_select(adev, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
> +
> +		if (adev->gfx.mec.mqd_backup[mqd_idx])
> +			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, ring->mqd_size);
> +	} else {
> +		/* restore MQD to a clean status */
> +		if (adev->gfx.mec.mqd_backup[mqd_idx])
> +			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], ring->mqd_size);
> +
> +		/* Re-commit the restored backup */
> +		mutex_lock(&adev->srbm_mutex);
> +		cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> +		gfx_v7_0_mqd_deactivate(adev, 2);
> +		gfx_v7_0_mqd_commit(adev, mqd);
> +		cik_srbm_select(adev, 0, 0, 0, 0);
> +		mutex_unlock(&adev->srbm_mutex);
> +
> +		/* reset ring buffer */
> +		ring->wptr = 0;
> +		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
> +		atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
> +		amdgpu_ring_clear_ring(ring);
>   	}
>   
> -	mutex_lock(&adev->srbm_mutex);
> -	cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> -
> -	gfx_v7_0_mqd_init(adev, mqd, mqd_gpu_addr, ring);
> -	gfx_v7_0_mqd_deactivate(adev);
> -	gfx_v7_0_mqd_commit(adev, mqd);
> -
> -	cik_srbm_select(adev, 0, 0, 0, 0);
> -	mutex_unlock(&adev->srbm_mutex);
> -
> -	amdgpu_bo_kunmap(ring->mqd_obj);
> -	amdgpu_bo_unreserve(ring->mqd_obj);
>   	return 0;
>   }

I think I can follow this - only the wptr and rptr reset is a bit 
different than what v8 does it. Any specific reason? Gfx9 then reverts 
back to a single ring->wptr = 0. I guess v8 is somehow special?

>   
> @@ -3020,10 +3013,8 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
>   	/* init the queues */
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>   		r = gfx_v7_0_compute_queue_init(adev, i);
> -		if (r) {
> -			gfx_v7_0_cp_compute_fini(adev);
> +		if (r)
>   			return r;
> -		}
>   	}
>   
>   	gfx_v7_0_cp_compute_enable(adev, true);
> @@ -4430,6 +4421,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		}
>   	}
>   
> +	/* create MQD for all compute queues */
> +	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct cik_mqd), 0);
> +	if (r)
> +		return r;
> +
>   	adev->gfx.ce_ram_size = 0x8000;
>   
>   	gfx_v7_0_gpu_early_init(adev);
> @@ -4452,7 +4448,7 @@ static int gfx_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>   		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
>   
> -	gfx_v7_0_cp_compute_fini(adev);
> +	amdgpu_gfx_mqd_sw_fini(adev, 0);
>   	amdgpu_gfx_rlc_fini(adev);
>   	gfx_v7_0_mec_fini(adev);
>   	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,

I am assuming all this applies only to compute because gfx is single 
instance on v7?

Anyway, it looks plausible to me so assuming you were able to exercise 
both paths:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

