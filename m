Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AA6C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 06:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEDC10E2B3;
	Thu, 28 Apr 2022 06:48:42 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE3710E2B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 06:48:40 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id i5so5337881wrc.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 23:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=bN3vqx5BzyPaJYWEUejOtrv+Ce6WbuQjIcbDAqKhhQs=;
 b=pzvi5DVRQ8aTB/AcctfSROzbM3v0sXnGvJS1KI6YDNz8maadw0qVojGIbajjixq7Dn
 9pXmqXJ247JV8SMhyCJlw3KFS8dH4mTrPLhPQGYyRMYuXtrM+hHa3reQb7asJDRZxkvx
 F6RA3ZNSaPO2x7ibvVEWQXUWbU8PqAcZUYbD7Mq0BnODDjAzzvbN3H/jI99r9tI7ZLgO
 eJxYerKSMAboxVOVLxVyXeZ7h7yny5I5Xs8GjUPCi4mM9SVUuqP1zsG2eDn2MpZNX0ru
 ccb5WSTZFSg45SF5qJ464zac9AhNwm69BqFyTFwZEan+iGE0uQgr0ZmfUjueLwe3R0Vs
 lNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=bN3vqx5BzyPaJYWEUejOtrv+Ce6WbuQjIcbDAqKhhQs=;
 b=wI/qhwzGjWqQcYRUkYtIXTo8fceYBVA7NVr5yRccXIofM2trT7IusVRwYrrSXiTREC
 nil3cXf+ALs3hjd+Cskji99gYFI9QuSlGoSIH9I5JFSg8X2PtHU8U7XYTvr/CdtC8FSl
 ck4Vmbqpm95aiWMmxLFF5fVfdfGSlLZJ8UpnAq2W5v24kfjnh2VSgPVpQ5d3Zr+bN0Q+
 /TX3xEnVYevIfWIiBBPzssPIHQ0iRL3v5FPtlth9MukQrk4+/9B6CR2+VLSpukaB0Usx
 5+evP9rysR1ifXYB8g9AbyEGopw+hhLxBage5inqkeNn6a4B2Ep0Gwdi7fh5wvRpAyJq
 IdtQ==
X-Gm-Message-State: AOAM530KTgaP2vL7xlTA2mIbLXBn7ToBD0eXr6yE5LTaQ1fFHmyIXWfG
 cvnJPHqG1hEa5dwFu7v2y/ejX367kUk=
X-Google-Smtp-Source: ABdhPJw8OsRhojvPaTq8ZraMXem5RVXvUmf94ElU4hx/HMd/0o0bHXS/EVej/8ClVE+V1aKhFL2bvw==
X-Received: by 2002:adf:da50:0:b0:204:7d8:b654 with SMTP id
 r16-20020adfda50000000b0020407d8b654mr25398326wrl.607.1651128519033; 
 Wed, 27 Apr 2022 23:48:39 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b9e1.dip0.t-ipconnect.de.
 [87.176.185.225]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d6482000000b0020a96536fcdsm16459115wri.57.2022.04.27.23.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Apr 2022 23:48:38 -0700 (PDT)
Message-ID: <05b5464c-9d2c-844a-ef0a-818d04ed9592@gmail.com>
Date: Thu, 28 Apr 2022 08:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Yu, Lang" <Lang.Yu@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20220428021109.2571-1-ricetons@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220428021109.2571-1-ricetons@gmail.com>
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
Cc: Haohui Mai <ricetons@gmail.com>, Haohui Mai <haohui@alt-chain.io>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adding a few more people to review this.

Am 28.04.22 um 04:11 schrieb ricetons@gmail.com:
> From: Haohui Mai <haohui@alt-chain.io>
>
> The patch fully deactivates the DMA engine before setting up the ring
> buffer to avoid potential data races and crashes.
>
> Signed-off-by: Haohui Mai <haohui@alt-chain.io>

 From my side this is Acked-by: Christian König 
<christian.koenig@amd.com>, but I'm not so deeply into the hardware 
programming sequence to fully judge.

Enabling the engine first and then setting it up is certainly incorrect, 
but could be that I'm missing something else. So please guys take a look 
as well.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 110 +++++++++++++------------
>   1 file changed, 59 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 013d2dec81d0..a22aafd2d7f6 100644
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
> @@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
> + * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> + * context switch for an instance
>    *
>    * @adev: amdgpu_device pointer
> - * @enable: enable/disable the DMA MEs context switch.
> + * @instance_idx: the index of the SDMA instance
>    *
> - * Halt or unhalt the async dma engines context switch.
> + * Unhalt the async dma engines context switch.
>    */
> -static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
>   {
>   	u32 f32_cntl, phase_quantum = 0;
> -	int i;
> +
> +	if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> +		return;
> +	}
>   
>   	if (amdgpu_sdma_phase_quantum) {
>   		unsigned value = amdgpu_sdma_phase_quantum;
> @@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>   		phase_quantum =
>   			value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
>   			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> -	}
> -
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (enable && amdgpu_sdma_phase_quantum) {
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> -			       phase_quantum);
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> -			       phase_quantum);
> -			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> -			       phase_quantum);
> -		}
>   
> -		if (!amdgpu_sriov_vf(adev)) {
> -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> -					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> -		}
> +		WREG32_SOC15_IP(GC,
> +			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> +			phase_quantum);
> +		WREG32_SOC15_IP(GC,
> +			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> +		    phase_quantum);
> +		WREG32_SOC15_IP(GC,
> +			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> +		    phase_quantum);
>   	}
>   
> +	if (!amdgpu_sriov_vf(adev)) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +				AUTO_CTXSW_ENABLE, 1);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> +	}
>   }
>   
>   /**
> - * sdma_v5_2_enable - stop the async dma engines
> + * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
>    *
>    * @adev: amdgpu_device pointer
> - * @enable: enable/disable the DMA MEs.
>    *
> - * Halt or unhalt the async dma engines.
> + * Halt the async dma engines context switch.
>    */
> -static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
> +static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
>   {
>   	u32 f32_cntl;
>   	int i;
>   
> -	if (!enable) {
> -		sdma_v5_2_gfx_stop(adev);
> -		sdma_v5_2_rlc_stop(adev);
> -	}
> +	if (amdgpu_sriov_vf(adev))
> +		return;
>   
> -	if (!amdgpu_sriov_vf(adev)) {
> -		for (i = 0; i < adev->sdma.num_instances; i++) {
> -			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> -			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
> -			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
> -		}
> +	for (i = 0; i < adev->sdma.num_instances; i++) {
> +		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +				AUTO_CTXSW_ENABLE, 0);
> +		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
>   	}
>   }
>   
> +/**
> + * sdma_v5_2_halt - stop the async dma engines
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Halt the async dma engines.
> + */
> +static void sdma_v5_2_halt(struct amdgpu_device *adev)
> +{
> +	sdma_v5_2_gfx_stop(adev);
> +	sdma_v5_2_rlc_stop(adev);
> +}
> +
>   /**
>    * sdma_v5_2_gfx_resume - setup and start the async dma engines
>    *
>    * @adev: amdgpu_device pointer
>    *
>    * Set up the gfx DMA ring buffers and enable them.
> + * It assumes that the dma engine is stopped for each instance.
> + * The function enables the engine and preemptions sequentially for each instance.
> + *
>    * Returns 0 for success, error for failure.
>    */
>   static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> @@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
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
> @@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
>   	int i, j;
>   
>   	/* halt the MEs */
> -	sdma_v5_2_enable(adev, false);
> +	sdma_v5_2_halt(adev);
>   
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   		if (!adev->sdma.instance[i].fw)
> @@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>   	int r = 0;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> -		sdma_v5_2_ctx_switch_enable(adev, false);
> -		sdma_v5_2_enable(adev, false);
> +		sdma_v5_2_ctx_switch_disable_all(adev);
> +		sdma_v5_2_halt(adev);
>   
>   		/* set RB registers */
>   		r = sdma_v5_2_gfx_resume(adev);
> @@ -881,12 +891,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
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
> @@ -1340,8 +1348,8 @@ static int sdma_v5_2_hw_fini(void *handle)
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	sdma_v5_2_ctx_switch_enable(adev, false);
> -	sdma_v5_2_enable(adev, false);
> +	sdma_v5_2_ctx_switch_disable_all(adev);
> +	sdma_v5_2_halt(adev);
>   
>   	return 0;
>   }

