Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EFFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 13:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0133A10F18F;
	Wed, 27 Apr 2022 13:57:23 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF4F10F18F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 13:57:21 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id i27so3554791ejd.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=GrjymGWNeOuf4wAqA6msZGMoTf9TaebYjw/EShsqgBI=;
 b=LVUh0WB5FdObMcNJqwC9Wr3C72lw30eOX0qWiwWpAYMUod+azCkDl0OyFpB7Pg55Xo
 FBJjzaCgdYdunuie3mmhkCXBDPn0X6mcFius8nRiBt36OFffiDclEY9cCinnqSkyC18k
 8kfjn7s+HzeDQqSeK7isQL3wxiLX4kaUM/DSGaPON4fYJhC3krSw2fLUfRgJInvrDbYW
 LWH4Rt+QdxccxKAk2E5F65/u2BvzKoo4oqqjToVJwLab/Ox2ChTGvVpUBqcwRj8ttb2P
 0hNDxRb8rvtRZcd2qzNJeWqTRH4dz40vTqg5uqPhL3hJfLCHWFJr8izkzJryvmQnHWA6
 7LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=GrjymGWNeOuf4wAqA6msZGMoTf9TaebYjw/EShsqgBI=;
 b=y6RWZFjQTUtzaYTHzZHILP+mcCBSHd1W/l42idLc0qlJe7OrQARZJY7CHx9EP0qev2
 srKIZHm1rSlvjlAgQxMtB7spFePZnf4RuqZAdNg3aHLrsg0Fjt32dVqCxZytdaUnQxCV
 q8A1zYHw438D0y6TVmmQaVwOLqSHxueDVeTVCrNF/ffUmQkOOahIOXZUsM7DaoXLAdK5
 P4LnezcBX7b+Bw45pxcwjskXrxwgyBxQqUhxWN+tslbggTfCPvUgHtjMYgFgx3nhrlDr
 +uX0WDObQ6EFvSb5NPdAT2USfClwpfzbg5VkiM9yaPus+CFhFYEzQUmthhw0irDjfHUm
 qRuA==
X-Gm-Message-State: AOAM532Yx6vrz6hgyzAK2/OQ1DdSY5HWGZDL22HhfXv/OJmZ8AuILIno
 1TY8aIXMxg9ebYTLBOTMLo1hRL9cKTE=
X-Google-Smtp-Source: ABdhPJwKe3tG6boPc9GGrkXBtPFz2UyLhKRmEDBCt1io1hp8Lyo6VGmSlr6/6Hws/77QKWI/BM7gFw==
X-Received: by 2002:a17:907:7dac:b0:6f3:be1f:af39 with SMTP id
 oz44-20020a1709077dac00b006f3be1faf39mr5617667ejc.467.1651067839835; 
 Wed, 27 Apr 2022 06:57:19 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:7420:a21a:88a4:93c6?
 ([2a02:908:1256:79a0:7420:a21a:88a4:93c6])
 by smtp.gmail.com with ESMTPSA id
 b89-20020a509f62000000b00425e21479fdsm5712705edf.19.2022.04.27.06.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Apr 2022 06:57:17 -0700 (PDT)
Message-ID: <9473b58d-4377-3f10-7561-e6d77bc1af8b@gmail.com>
Date: Wed, 27 Apr 2022 15:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Content-Language: en-US
To: ricetons@gmail.com, amd-gfx@lists.freedesktop.org
References: <20220427123113.29345-1-ricetons@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220427123113.29345-1-ricetons@gmail.com>
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
Cc: Haohui Mai <haohui@alt-chain.io>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 27.04.22 um 14:31 schrieb ricetons@gmail.com:
> From: Haohui Mai <haohui@alt-chain.io>
>
> The patch fully deactivates the DMA engine before setting up the ring
> buffer to avoid potential data races and crashes.
>
> Signed-off-by: Haohui Mai <haohui@alt-chain.io>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 94 ++++++++++++++------------
>   1 file changed, 50 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 013d2dec81d0..cb3987dd3bda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>   	}
>   }
>   
> -
>   /**
>    * sdma_v5_2_gfx_stop - stop the gfx async dma engines
>    *
> @@ -505,17 +504,19 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> + * context switch for an instance
>    *
>    * @adev: amdgpu_device pointer
> - * @enable: enable/disable the DMA MEs context switch.
> + * @i: the index of the SDMA instance
>    *
> - * Halt or unhalt the async dma engines context switch.
> + * Unhalt the async dma engines context switch.
>    */
> -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int i)

Better name the parameter instance.

Need to give that a full review when I have time.

Thanks for taking a look into this,
Christian.

>   {
>   	u32 f32_cntl, phase_quantum = 0;
> -	int i;
> +
> +	WARN_ON(i >= adev->sdma.num_instances);
>   
>   	if (amdgpu_sdma_phase_quantum) {
>   		unsigned value = amdgpu_sdma_phase_quantum;
> @@ -539,26 +540,44 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>   		phase_quantum =
>   			value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
>   			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> -	}
>   
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (enable && amdgpu_sdma_phase_quantum) {
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> -			       phase_quantum);
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> -			       phase_quantum);
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> -			       phase_quantum);
> -		}
> +		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> +		       phase_quantum);
> +		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> +		       phase_quantum);
> +		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> +		       phase_quantum);
> +	}
>   
> -		if (!amdgpu_sriov_vf(adev)) {
> -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> -					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> -		}
> +	if (!amdgpu_sriov_vf(adev)) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +				AUTO_CTXSW_ENABLE, 1);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
>   	}
> +}
>   
> +/**
> + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Halt the async dma engines context switch.
> + */
> +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> +{
> +	u32 f32_cntl;
> +	int i;
> +
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +				AUTO_CTXSW_ENABLE, 0);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> +	}
>   }
>   
>   /**
> @@ -571,21 +590,10 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>    */
>   static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
>   {
> -	u32 f32_cntl;
> -	int i;
> -
>   	if (!enable) {
>   		sdma_v5_2_gfx_stop(adev);
>   		sdma_v5_2_rlc_stop(adev);
>   	}
> -
> -	if (!amdgpu_sriov_vf(adev)) {
> -		for (i = 0; i < adev->sdma.num_instances; i++) {
> -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> -		}
> -	}
>   }
>   
>   /**
> @@ -594,6 +602,9 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
>    * @adev: amdgpu_device pointer
>    *
>    * Set up the gfx DMA ring buffers and enable them.
> + * It assumes that the dma engine is stopped for each instance.
> + * The function enables the engine and preemptions sequentially for each instance.
> + *
>    * Returns 0 for success, error for failure.
>    */
>   static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> @@ -737,10 +748,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>   
>   		ring->sched.ready = true;
>   
> -		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> -			sdma_v5_2_ctx_switch_enable(adev, true);
> -			sdma_v5_2_enable(adev, true);
> -		}
> +		sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
>   
>   		r = amdgpu_ring_test_ring(ring);
>   		if (r) {
> @@ -856,7 +864,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>   	int r = 0;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> -		sdma_v5_2_ctx_switch_enable(adev, false);
> +		sdma_v5_2_ctx_switch_disable_all(adev);
>   		sdma_v5_2_enable(adev, false);
>   
>   		/* set RB registers */
> @@ -881,12 +889,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>   		amdgpu_gfx_off_ctrl(adev, false);
>   
>   	sdma_v5_2_soft_reset(adev);
> -	/* unhalt the MEs */
> -	sdma_v5_2_enable(adev, true);
> -	/* enable sdma ring preemption */
> -	sdma_v5_2_ctx_switch_enable(adev, true);
>   
> -	/* start the gfx rings and rlc compute queues */
> +	/* Soft reset supposes to disable the dma engine and preemption.
> +	 * Now start the gfx rings and rlc compute queues.
> +	 */
>   	r = sdma_v5_2_gfx_resume(adev);
>   	if (adev->in_s0ix)
>   		amdgpu_gfx_off_ctrl(adev, true);
> @@ -1340,7 +1346,7 @@ static int sdma_v5_2_hw_fini(void *handle)
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	sdma_v5_2_ctx_switch_enable(adev, false);
> +	sdma_v5_2_ctx_switch_disable_all(adev);
>   	sdma_v5_2_enable(adev, false);
>   
>   	return 0;

