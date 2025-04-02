Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B62BC28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 07:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1001010E6D3;
	Wed,  2 Apr 2025 07:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P0i5J+CE";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0CF810E6DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 07:38:50 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso3701385f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Apr 2025 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743579529; x=1744184329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p2rBVXRTjNAH6IBDkeUjzc6hTz5FBO9ieKpFWRx/MyQ=;
 b=P0i5J+CE8RXd2OfLHawc5HV3d/9iAVb8RwdYuiXt/GNh/4KK5vhEfk2gRIfi6GnclD
 niffzQmkoJOElIA52jcvvBD2ycQHp4lxLmCwU2G1xbSujBXgNzwIfrROKOzryQXdu8jf
 m4Gndm5uoB83xbciiBGsJDNVpo3R7Vjjx3gS0kUlBE4D9GRF71bEBKVunkInIpAzfUaL
 tUtFikfmDaAIeXlh/jsWtdvEme4seHgJW08QRbyk66fnSrR62Ewd14KnbX5hgeTab7d7
 ENdSi5WApE6l8EMj5K3x9wpcAuiQxFFrCDR4Bfdh8tp4ZhCHGYQVpy3GzUeRS5I822gM
 AyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743579529; x=1744184329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p2rBVXRTjNAH6IBDkeUjzc6hTz5FBO9ieKpFWRx/MyQ=;
 b=YSQ7VytxrwoSzmco/xqvxTxey45Q1PeuKU0eE5JFQkKdO2Rh/ENXXWSFz2vcM8Cl+4
 LYN4kgIfCQVXxpAZhUpGNZirnz/17j8YcLL4Bd3dxy1Sf9NqJXuxZobILlO4BtxfhxEH
 cVGWWfiQuJNGe/8WO6iGy2y7mJB7AN4oGOr3ugJq0RnvNzdeFEJCbGtrrEkBF5dSBfvb
 6gLT8ycba4bMP8zrABkRqyuOv0mjY0xUcrXp5WBae5YTgXnbQ/G51TvRn3pMrSjRX+Vh
 xqOnfAoMRehSVs79EWBuna3uMs3W+OWNCJfPF4kFD85itO+PRxlvLan5Y5XfJ5Z9m7kQ
 Yt8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx5E33YIITLPWxn6BGlbMtKtyRC2K4zA3FNXtNoWwjQITCg2ndT1jVBalG958H+DIFW4aF6as1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyL1SotFl3aeoMSDUmNmsRAudrFTpiHnsTgd4Cz4CoTeSgt+IvY
 zxqBfz1cuEnr8AO0hEG4cSWsZthL7Bdh8VvbJPbxD0/n28nPiDpa
X-Gm-Gg: ASbGncv6PtVGH84AHkJEpN9gB+CYxI8UnwKxNFytsxyVimDoc+/7tvoJje5ji6iOhbQ
 xIK1Ml4kYY34fyl8gok9XaDuqvLUAzDcBac7v8ui3X+ik6P2ipS0I50DIPOTJPII0Tt7SAPkaH7
 K9PtSzjNl3VEqxLEtszEogeSHjnjeNtnzi1xTY15R6b/xaBKf+lJFOSgnt+HFUNcRdOy187qeL1
 sM7wJ+/sNDV9TuNfmwcCHP9sCqJdCJn0rfomzr0XB5umH22OHI3o8Q8piVzpY65Oaeu4krF/K/o
 95ZtIdbUh9gwRSPsTFQNJ4MQxlmULPGwYCurYRIsJhD+4HOMzw146mPzp3ktna3A5AnZXzacGg=
 =
X-Google-Smtp-Source: AGHT+IFlk+QjGcFyLz08MsRfusZtCOZDsTpYKSa3EJfHp1RwAU4+YQCtKacM8K/WOegP5J/8ysSSuA==
X-Received: by 2002:a5d:47c8:0:b0:391:1806:e23f with SMTP id
 ffacd0b85a97d-39c120daed9mr11340973f8f.17.1743579529169; 
 Wed, 02 Apr 2025 00:38:49 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e393sm16401906f8f.72.2025.04.02.00.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 00:38:48 -0700 (PDT)
Message-ID: <c3101846-4c9a-4e8e-978a-979c73a363fa@gmail.com>
Date: Wed, 2 Apr 2025 09:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7 V2] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
To: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 jonathan.kim@amd.com, jiadong.zhu@amd.com
References: <20250402030215.1074975-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250402030215.1074975-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 02.04.25 um 05:02 schrieb jesse.zhang@amd.com:
> From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
>
> Since KFD no longer registers its own callbacks for SDMA resets, and only KGD uses the reset mechanism,
> we can simplify the SDMA reset flow by directly calling the ring's `stop_queue` and `start_queue` functions.
> This patch removes the dynamic callback mechanism and prepares for its eventual deprecation.
>
> 1. **Remove Dynamic Callbacks**:
>    - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdma_reset_engine` are removed.
>    - Instead, the ring's `stop_queue` and `start_queue` functions are called directly during the reset process.
>
> 2. **Prepare for Deprecation of Dynamic Mechanism**:
>    - By removing the callback invocations, this patch prepares the codebase for the eventual removal of the dynamic callback registration mechanism.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 ++
>  3 files changed, 8 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 615c3d5c5a8d..1b66be2b49dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -237,6 +237,8 @@ struct amdgpu_ring_funcs {
>  	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>  	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>  	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> +	int (*stop_queue)(struct amdgpu_device *adev, uint32_t instance_id);
> +	int (*start_queue)(struct amdgpu_device *adev, uint32_t instance_id);

The those parameters doesn't seem to make sense here.

A specific ring is always associated with a certain instance and that here are the per ring operations.

Instead you should give the ring as parameters to the callback.

Regards,
Christian.

>  	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>  	bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 0a9893fee828..7d862c887a1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -558,16 +558,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
>   *
> - * This function performs the following steps:
> - * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
> - * 2. Resets the specified SDMA engine instance.
> - * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to restore their state.
> - *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  {
> -	struct sdma_on_reset_funcs *funcs;
>  	int ret = 0;
>  	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
>  	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
> @@ -589,18 +583,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  		page_sched_stopped = true;
>  	}
>  
> -	/* Invoke all registered pre_reset callbacks */
> -	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> -		if (funcs->pre_reset) {
> -			ret = funcs->pre_reset(adev, instance_id);
> -			if (ret) {
> -				dev_err(adev->dev,
> -				"beforeReset callback failed for instance %u: %d\n",
> -					instance_id, ret);
> -				goto exit;
> -			}
> -		}
> -	}
> +	if (gfx_ring->funcs->stop_queue)
> +		gfx_ring->funcs->stop_queue(adev, instance_id);
>  
>  	/* Perform the SDMA reset for the specified instance */
>  	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> @@ -609,18 +593,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
>  		goto exit;
>  	}
>  
> -	/* Invoke all registered post_reset callbacks */
> -	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
> -		if (funcs->post_reset) {
> -			ret = funcs->post_reset(adev, instance_id);
> -			if (ret) {
> -				dev_err(adev->dev,
> -				"afterReset callback failed for instance %u: %d\n",
> -					instance_id, ret);
> -				goto exit;
> -			}
> -		}
> -	}
> +	if (gfx_ring->funcs->start_queue)
> +		gfx_ring->funcs->start_queue(adev, instance_id);
>  
>  exit:
>  	/* Restart the scheduler's work queue for the GFX and page rings
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 688a720bbbbd..df82a97a5388 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -2143,6 +2143,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  	.reset = sdma_v4_4_2_reset_queue,
> +	.stop_queue = sdma_v4_4_2_stop_queue,
> +	.start_queue = sdma_v4_4_2_restore_queue,
>  	.is_guilty = sdma_v4_4_2_ring_is_guilty,
>  };
>  

