Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5D7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4290610D0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4290610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359AD6E174;
	Tue, 19 Oct 2021 15:43:40 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162226E174
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 15:43:39 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id v127so12529742wme.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aj4A91T/FyprqNYlMqVtizm2MkiRqtDPK5060R05UQg=;
 b=A81+Q05FNDPlmOfdIcPSB/GoWQwtKwt2yQZ8r+SclcFEp1X6BBdQC/ftiYjq/IDtr2
 aXlc/2VoPg7b3CQT0U9dvzq9DJg3L2j6z6ZPNj9c52rmVdCMEU8M4r8yLyiigaeiMzGT
 VvOTvUMkWh3dP0QLdnpTGDhWryRIjIRp43RnMHUWQkRBo7btvPy1eb7wdEOecxTB50Kp
 bX3MOL9uWX1BjfIoN6eOtsvXUp7/aQZab3G8Dr//v3fxYDNxjHDqvvLZqPd3ND0Zo/cV
 fAmSBg9BHkSxKxIYKxMU9Gji7NtZd14skwSudHo7udGt38ZO49VgacuZDbQvEN06F/In
 zfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aj4A91T/FyprqNYlMqVtizm2MkiRqtDPK5060R05UQg=;
 b=3SX5qO6xBP3jnkBeXqkk8Z0YoLiH/VTUtdL1Kv1Nhc2/zBYhQVzQjBTmSbIpHk61Jl
 DoKUVRUV4Mv0CW6yEDbXMhowt4zWtb2H5pX4VyqVZrZiF2Xmx6kL6Dn3QtYJorpr0OJq
 /hS6+bW0bZ3cAqTGKB/p0tuZioBeXmF1xj/MILpdZVVTk2K9cg3bVLpfUzFOc8OnkPCs
 R3nBUrdSKlxCQuWr9uSFo4jRDALMk3bcBf4XOK+gJvcAM5UlrZIxV7tdMFQHvN6Whp7s
 qFS6k5bvIk0Dw+HVnJA/pCZmYAn5LLzDBzGuDluDBa7CCzDuYbslQadroWKlolqmVStR
 PRhQ==
X-Gm-Message-State: AOAM533SxMvZDZNzbqBLRiUh7htzPBOOBBEXZ9jjtEPWpHpk+EO1jbui
 8iNuFx/6klut1Q19uamBofBjflNetDI=
X-Google-Smtp-Source: ABdhPJyvd6xhq+cuO4IAiBs2lW6HE0owtFDpLx5sOr0X8EGrnnAKPlRRQUVsp9KmP9jk77JcxQE1YA==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr43978324wrn.219.1634658217271; 
 Tue, 19 Oct 2021 08:43:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4fc4:fae2:bc41:a808?
 ([2a02:908:1252:fb60:4fc4:fae2:bc41:a808])
 by smtp.gmail.com with ESMTPSA id h22sm2733468wmq.42.2021.10.19.08.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 08:43:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: recover gart table at resume
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20211019132200.10352-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c99524ce-1720-6a0f-ba6a-525c493c2a4b@gmail.com>
Date: Tue, 19 Oct 2021 17:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019132200.10352-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Am 19.10.21 um 15:22 schrieb Nirmoy Das:
> Get rid off pin/unpin and evict and swap back gart
> page table which should make things less likely to break.
>
> Also remove 2nd call to amdgpu_device_evict_resources()
> as we don't need it.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 -----
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 16 ++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 17 +++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 16 ++++++++++++----
>   4 files changed, 37 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41ce86244144..22ff229ab981 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3941,11 +3941,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	amdgpu_fence_driver_hw_fini(adev);
>   
>   	amdgpu_device_ip_suspend_phase2(adev);
> -	/* This second call to evict device resources is to evict
> -	 * the gart page table using the CPU.
> -	 */
> -	amdgpu_device_evict_resources(adev);
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3ec5ff5a6dbe..18e3f3c5aae6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -992,9 +992,16 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (!adev->in_suspend) {
> +		r = amdgpu_gart_table_vram_pin(adev);
> +		if (r)
> +			return r;

I think you can move the functionality of pinning into 
amdgpu_gart_table_vram_alloc().

> +	} else {
> +		r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
> +							    TTM_PL_TT));
> +		if (r)
> +			return r;
> +	}

And add a wrapper around this call here. Something like 
amdgpu_gart_recover() or similar.

Regards,
Christian.

>   
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
> @@ -1062,7 +1069,8 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
> +	if (!adev->in_suspend)
> +		amdgpu_gart_table_vram_unpin(adev);
>   }
>   
>   static int gmc_v10_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 492ebed2915b..0ef50ad3d7d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -837,9 +837,17 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +
> +	if (!adev->in_suspend) {
> +		r = amdgpu_gart_table_vram_pin(adev);
> +		if (r)
> +			return r;
> +	} else {
> +		r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
> +							    TTM_PL_TT));
> +		if (r)
> +			return r;
> +	}
>   
>   	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>   
> @@ -992,7 +1000,8 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
> +	if (!adev->in_suspend)
> +		amdgpu_gart_table_vram_unpin(adev);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..1bbcefd53974 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1714,9 +1714,16 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
>   
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (!adev->in_suspend) {
> +		r = amdgpu_gart_table_vram_pin(adev);
> +		if (r)
> +			return r;
> +	} else {
> +		r = amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev,
> +							    TTM_PL_TT));
> +		if (r)
> +			return r;
> +	}
>   
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
> @@ -1793,7 +1800,8 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
> +	if (!adev->in_suspend)
> +		amdgpu_gart_table_vram_unpin(adev);
>   }
>   
>   static int gmc_v9_0_hw_fini(void *handle)

