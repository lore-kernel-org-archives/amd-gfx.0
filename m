Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC88C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 09:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5EC10E715;
	Fri,  4 Nov 2022 09:26:24 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F0D10E70B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 09:26:20 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id k2so11751174ejr.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Nov 2022 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zrcFjgBdruBCfvVWlTZc30rIu5QhOLLXDDk5IhT2alU=;
 b=bFnNgb/MSTnmaKLkk1qS1gK81P7wkNWoFwrSJBP4xfTSPGh/7avrTiiovd11aAVjTy
 M8huWGrfHTJwDS2fI7kyXdc/lp4+y2rVolVKsoDOv06ZZn6IvF78MmMRaJExvnzrVNTK
 RTpsWSHPbPCbnKW4M6bKOHQpmAm7CnVx8YtoeJdhlkt2CNy3BAnFA26B+YS+4/ylcy2I
 V9bEDGLhXxOm/8PCXQmRmZ1Ye3NqtUITDP/jwCCmzIhyq+VcFwoLnOuCrl7C34FRkXuo
 lyGaoWMArqhm+/+3uO01RSwEDE25TslymrtyPUzChkjnWdDhHSKQJb40QzEB85j7eHPl
 XeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zrcFjgBdruBCfvVWlTZc30rIu5QhOLLXDDk5IhT2alU=;
 b=tPiumVW6mEbw+t9eRPoRy+Jkg9txZmsHelaLQR6tR0sfedBNAccNmZPOyXoJF+uHZv
 /irbN7ewxxUJm/ScnypN884xBgBGXrdy377dA7ZMc+ytg1Qkxre8Ct0UHzOI0buZjHPL
 OvZlW7mXc0uoX0NrhPQ3KKp/sxHpGwfl04DKFOaUQ/JMrunHJeFjFI8zcU3n715Kf+FI
 SvmoUjpsNWND/0pTljjCZyI/7AqkDgisu5E17qi6TeTvkhtGaVfaNmQ/0YyFF6r2JbTW
 yECeIV+J3vFCCwEUDd3gUbPAKX9OWVhpgfGJOuV21Su6/hU+iGJ3+u80FCGv7RKE2dTC
 04jw==
X-Gm-Message-State: ACrzQf3S+ydh0fWty2/+zsUYYnnL4jBCUWwa+THZUjs9EFJ9bwuOqwju
 sHQTGA+ogslN/uHCSH01R0c=
X-Google-Smtp-Source: AMsMyM59GQOQmBb04XW1U4ln1JWWOzNhvx8R8Q+CjwXakErK90dFUnMCRoPhaTGvweva1Nvb7VXE5Q==
X-Received: by 2002:a17:906:6a02:b0:7ae:2793:aa19 with SMTP id
 qw2-20020a1709066a0200b007ae2793aa19mr5156010ejc.265.1667553978950; 
 Fri, 04 Nov 2022 02:26:18 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:8469:5663:826a:8164?
 ([2a02:908:1256:79a0:8469:5663:826a:8164])
 by smtp.gmail.com with ESMTPSA id
 bk22-20020a170906b0d600b0078ca30ee18bsm1604147ejb.95.2022.11.04.02.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Nov 2022 02:26:18 -0700 (PDT)
Message-ID: <87b6bd88-d747-bc3e-0ea8-b07cd4578f09@gmail.com>
Date: Fri, 4 Nov 2022 10:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amd/amdgpu: Enable gfx pipe1 and fix related issues
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <20221104003215.296666-1-Emily.Deng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221104003215.296666-1-Emily.Deng@amd.com>
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

Am 04.11.22 um 01:32 schrieb Emily Deng:
> Starting from SIENNA CICHLID asic supports two gfx pipes, enabling
> two graphics queues for performance concern.

With the printk still in the patch I assume that this is just a 
debugging patch?

>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 43 +++++++++++++------------
>   2 files changed, 23 insertions(+), 22 deletions(-)
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

That's an absolutely clear NAK and as far as I can see also unnecessary.

We don't want to expose the GFX queues as separate queues to userspace.

Instead the queues have separate priorities which userspace can select.

Regards,
Christian.

>   	[AMDGPU_HW_IP_COMPUTE]	=	4,
>   	[AMDGPU_HW_IP_DMA]	=	2,
>   	[AMDGPU_HW_IP_UVD]	=	1,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 49d34c7bbf20..9219cd29acd3 100644
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
> @@ -6008,6 +6008,25 @@ static int gfx_v10_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
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
> +	printk("Emily:gfx_v10_0_wait_for_idle\n");
> +	return -ETIMEDOUT;
> +}
> +
>   static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ring *ring;
> @@ -6069,7 +6088,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
>   	amdgpu_ring_write(ring, 0x8000);
>   
>   	amdgpu_ring_commit(ring);
> -
> +	gfx_v10_0_wait_for_idle(adev);
>   	/* submit cs packet to copy state 0 to next available state */
>   	if (adev->gfx.num_gfx_rings > 1) {
>   		/* maximum supported gfx ring is 2 */
> @@ -7404,24 +7423,6 @@ static bool gfx_v10_0_is_idle(void *handle)
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
> @@ -8466,7 +8467,7 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   		}
>   		reg_mem_engine = 0;
>   	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> +		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>   		reg_mem_engine = 1; /* pfp */
>   	}
>   

