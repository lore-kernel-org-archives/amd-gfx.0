Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF4DC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 12:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC9C210E038;
	Fri,  4 Nov 2022 12:51:45 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C8710E038
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 12:51:43 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 m7-20020a05600c090700b003cf8a105d9eso3105582wmp.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Nov 2022 05:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AzFsyUy1t0J8g8YiB0YZTIvWk5vUKqH4plk99lbpkDo=;
 b=evdOu9tO8iVI4d5V5MkvdtLsqal913ZhVX2vadrqtdlm91+u88P1oUIwK2evDCOmIK
 PDcpRiAP9dd5Vfg6mcQ7VZfWWi4Cwr6Oqm4xYYQAUcsWFKZibAlKMfqtiFfH5xBy3ylR
 3U6Tm57pXC+bZr4PInFi3+faor/ci8GWPYZI4Nn7U/6oNBJNwg08XqoE166gkM//pPVk
 TzOZfSWfIuAVjiTGxA8iufYDINhzXCkaWcVwHKNiLrVYV2M9QSCNCInvMbA0nHxyl7ym
 JJlrtnt75Sx4LdXt1tVgECC5niMQIdsPUJ6FCJp6Hy5ZZjfW+WazXuvrn4Z6TKu4bpGz
 0T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AzFsyUy1t0J8g8YiB0YZTIvWk5vUKqH4plk99lbpkDo=;
 b=gcHfCblH1gnbsYMGSMU8BbHOe+ZlwSIAQldZZiLApfVSM/BBOE+Y0j5n5pHqVUghDx
 0AdoQObIary4y2F+daGhNzpKQkWhugizECPPtz/bvXUXgcB8oR0SyTgI1DzDWLGwYCmt
 514bAUK8fDGLcZzGzy/9QzF0RDMx0/61YE2fuZQ4VtwNI8qEiq6K72syjcjhm4QLO3gC
 mxYn9+7+co3mZRrNpLXPCe8vtsgUHNXPzihgJU5UBoXhV4Y3TglG1qqB0MEw71TXuxHe
 W0zOa7BmDCOJz+a5uPtu8Qijdw/EJG97sIJxCLJlZsalMW4AaCTPb29JC+KTScHIppod
 KObg==
X-Gm-Message-State: ACrzQf3m+QBrX+9uxyVp8RMu7WrrMovuaYBs73XMXnMfaLGzFDK3+lBf
 SbFg6oe8T8/kAKMf8D3zwS1qV2mhPfg=
X-Google-Smtp-Source: AMsMyM77vTmysFi9nMuqcIJxqEDb+uM6OoHbAiqqjYyhsooR+blq+e32bDv1K/wyXVh7bxTfWy1ATw==
X-Received: by 2002:a7b:c451:0:b0:3cf:9ad3:a061 with SMTP id
 l17-20020a7bc451000000b003cf9ad3a061mr1591474wmi.55.1667566301538; 
 Fri, 04 Nov 2022 05:51:41 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8469:5663:826a:8164?
 ([2a02:908:1256:79a0:8469:5663:826a:8164])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a05600c199400b003cf9bf5208esm930679wmq.19.2022.11.04.05.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Nov 2022 05:51:40 -0700 (PDT)
Message-ID: <03e86291-7dea-92e4-0295-8c7ff431ef64@gmail.com>
Date: Fri, 4 Nov 2022 13:51:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amd/amdgpu: Enable gfx pipe1 and fix related issues
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221104111952.298814-1-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221104111952.298814-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



Am 04.11.22 um 12:19 schrieb Emily Deng:
> Starting from SIENNA CICHLID asic supports two gfx pipes, enabling
> two graphics queues for performance concern.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 42 ++++++++++++-------------
>   2 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 331aa191910c..0072f36b44d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -33,7 +33,7 @@
>   	container_of((e), struct amdgpu_ctx_entity, entity)
>   
>   const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
> -	[AMDGPU_HW_IP_GFX]	=	1,
> +	[AMDGPU_HW_IP_GFX]	=	2,

Again, please completely drop this. That change absolutely makes no 
sense at all.

Regards,
Christian.

>   	[AMDGPU_HW_IP_COMPUTE]	=	4,
>   	[AMDGPU_HW_IP_DMA]	=	2,
>   	[AMDGPU_HW_IP_UVD]	=	1,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 49d34c7bbf20..bbf18060611e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4606,7 +4606,7 @@ static int gfx_v10_0_sw_init(void *handle)
>   	case IP_VERSION(10, 3, 3):
>   	case IP_VERSION(10, 3, 7):
>   		adev->gfx.me.num_me = 1;
> -		adev->gfx.me.num_pipe_per_me = 1;
> +		adev->gfx.me.num_pipe_per_me = 2;
>   		adev->gfx.me.num_queue_per_pipe = 1;
>   		adev->gfx.mec.num_mec = 2;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
> @@ -6008,6 +6008,24 @@ static int gfx_v10_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static int gfx_v10_0_wait_for_idle(void *handle)
> +{
> +	unsigned i;
> +	u32 tmp;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		/* read MC_STATUS */
> +		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS) &
> +			GRBM_STATUS__GUI_ACTIVE_MASK;
> +
> +		if (!REG_GET_FIELD(tmp, GRBM_STATUS, GUI_ACTIVE))
> +			return 0;
> +		udelay(1);
> +	}
> +	return -ETIMEDOUT;
> +}
> +
>   static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ring *ring;
> @@ -6069,7 +6087,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
>   	amdgpu_ring_write(ring, 0x8000);
>   
>   	amdgpu_ring_commit(ring);
> -
> +	gfx_v10_0_wait_for_idle(adev);
>   	/* submit cs packet to copy state 0 to next available state */
>   	if (adev->gfx.num_gfx_rings > 1) {
>   		/* maximum supported gfx ring is 2 */
> @@ -7404,24 +7422,6 @@ static bool gfx_v10_0_is_idle(void *handle)
>   		return true;
>   }
>   
> -static int gfx_v10_0_wait_for_idle(void *handle)
> -{
> -	unsigned i;
> -	u32 tmp;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	for (i = 0; i < adev->usec_timeout; i++) {
> -		/* read MC_STATUS */
> -		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS) &
> -			GRBM_STATUS__GUI_ACTIVE_MASK;
> -
> -		if (!REG_GET_FIELD(tmp, GRBM_STATUS, GUI_ACTIVE))
> -			return 0;
> -		udelay(1);
> -	}
> -	return -ETIMEDOUT;
> -}
> -
>   static int gfx_v10_0_soft_reset(void *handle)
>   {
>   	u32 grbm_soft_reset = 0;
> @@ -8466,7 +8466,7 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   		}
>   		reg_mem_engine = 0;
>   	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> +		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>   		reg_mem_engine = 1; /* pfp */
>   	}
>   

