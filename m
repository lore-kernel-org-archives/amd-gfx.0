Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53048CF6497
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 10:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7C210E2F1;
	Mon, 30 Sep 2024 10:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OrRdeXrn";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC1610E2F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 10:28:40 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so38775595e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727692119; x=1728296919; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7K208D53BCa8C1kc8EqeLKoPiXf3LKW+BHCYH/2hERQ=;
 b=OrRdeXrnAHYV2gdW8MGZEXYLw/cXjKh6JBji0dGkrUnzrXwqPz992EsW8CU2L46A9U
 A6/vE8Tllz/lpku1+J3ZG4N58eXsnaiWfVOZem9lAEF07BZUkv0z7Sr4AQb2gBjyI3w5
 EdcPeRlYf771uZKQ2LgYzwixSmpnucWHRWuTZY/U0yMa01t09f8aWUUYCVeRVnlR8TQT
 gFMYIkmi7aPUd9jEYM1fOtX9A7uwo/pwoL8CgV4FC1lhFvMw/s/ZRlWesPV3grFRGhf5
 H0vWGiSYgl/4ZrBlXAAIdcN/vRSqB9pCkMDzM89mEBDxcEYjwQagxQmEM7uY5nzutbgI
 HBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727692119; x=1728296919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7K208D53BCa8C1kc8EqeLKoPiXf3LKW+BHCYH/2hERQ=;
 b=L8J/+ilhMEyGCOz3RkSAk6Q7oMH6Gl/hmSL7Z2lRt1lKqVBW2jdVWY+JV4bcJehRYp
 kE0NFcDx91BH35OBBbUfK1YM0Lopu4l6rH+UOpKsG96t5qxD10qb5t5Ub5evjSFe6XyJ
 oi5lJ3Fv1Zb9LAr+5YL7O+ivlQsE7iy/QRwf2bWFYJwW5gGGIskiy9hz006fk1w2Pwj7
 A2QCbxu7j3dpGAD8zkEGljDLpOL/YNE6JJguESj2/O3Ts99IQR8oy2LmLbDqHjn/Zthj
 Uvcj2mRzSE7dqpLBlkhdcSxXqeckLkdL0dCmlBLYdutPAIsU9tYxsr/Aqh4dlsn4sNWA
 eiog==
X-Gm-Message-State: AOJu0YxOZ7qqU5Zxht8detV+ghFaVssS4rwmyw1FQXJ6qZqdSHS9tJdo
 LxTgdU5n96lArJUhquFWye3SzMJGTwUpxxmWh29hqu/XBtgqpe0/
X-Google-Smtp-Source: AGHT+IFohqdgzcJgLUIM9ZERl8bGos5heORu9baPUMvFixYwYtT/JWfgYlaGXq7Km+KEUDWoGfvtMA==
X-Received: by 2002:adf:fc09:0:b0:371:a844:d326 with SMTP id
 ffacd0b85a97d-37cd5b10634mr5978270f8f.43.1727692118297; 
 Mon, 30 Sep 2024 03:28:38 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd565e427sm8665727f8f.35.2024.09.30.03.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 03:28:37 -0700 (PDT)
Message-ID: <402ae9d1-1ed3-4f7a-aaac-f21d2765bed0@gmail.com>
Date: Mon, 30 Sep 2024 12:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] drm/amdgpu: update the handle ptr in late_init
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240927150059.2232708-1-sunil.khatri@amd.com>
 <20240927150059.2232708-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240927150059.2232708-2-sunil.khatri@amd.com>
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

Am 27.09.24 um 17:00 schrieb Sunil Khatri:
> Update the ptr handle to amdgpu_ip_block ptr in all
> the functions of late_init function ptr.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Apart from a few minor comments on patch #1 the whole series is 
Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c      |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/nv.c                   |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c                |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/soc21.c                |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/soc24.c                |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vi.c                   |  4 ++--
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++--
>   drivers/gpu/drm/amd/include/amd_shared.h          |  2 +-
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        |  4 ++--
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        |  4 ++--
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  4 ++--
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         |  6 +++---
>   34 files changed, 67 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 98fb0ba4f9cb..574aeca993e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -304,7 +304,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
>   
>   		if (adev->ip_blocks[i].version->funcs->late_init) {
>   			r = adev->ip_blocks[i].version->funcs->late_init(
> -				(void *)adev);
> +				&adev->ip_blocks[i]);
>   			if (r) {
>   				dev_err(adev->dev,
>   					"late_init of IP block <%s> failed %d after reset\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5aeea2aed323..e6e98b189072 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3196,7 +3196,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>   		if (!adev->ip_blocks[i].status.hw)
>   			continue;
>   		if (adev->ip_blocks[i].version->funcs->late_init) {
> -			r = adev->ip_blocks[i].version->funcs->late_init((void *)adev);
> +			r = adev->ip_blocks[i].version->funcs->late_init(&adev->ip_blocks[i]);
>   			if (r) {
>   				DRM_ERROR("late_init of IP block <%s> failed %d\n",
>   					  adev->ip_blocks[i].version->funcs->name, r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> index d7e377341367..74b1ec10be2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> @@ -784,9 +784,9 @@ static int umsch_mm_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int umsch_mm_late_init(void *handle)
> +static int umsch_mm_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_in_reset(adev) || adev->in_s0ix || adev->in_suspend)
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 3d0969a7ba69..8008dbd24967 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7722,9 +7722,9 @@ static int gfx_v10_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return gfx_v10_0_init_microcode(adev);
>   }
>   
> -static int gfx_v10_0_late_init(void *handle)
> +static int gfx_v10_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 690cd7b173f7..a1718c52ed18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5020,9 +5020,9 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return gfx_v11_0_init_microcode(adev);
>   }
>   
> -static int gfx_v11_0_late_init(void *handle)
> +static int gfx_v11_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 6423b20e9156..e3951a548726 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3717,9 +3717,9 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return gfx_v12_0_init_microcode(adev);
>   }
>   
> -static int gfx_v12_0_late_init(void *handle)
> +static int gfx_v12_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 3babf5b5a9dd..73404f24667f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4151,9 +4151,9 @@ static int gfx_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gfx_v7_0_late_init(void *handle)
> +static int gfx_v7_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index e80e071f193c..9778b89c7125 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5271,9 +5271,9 @@ static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gfx_v8_0_late_init(void *handle)
> +static int gfx_v8_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 8c98511144b2..5ae2b63c375c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4792,9 +4792,9 @@ static int gfx_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return gfx_v9_0_init_microcode(adev);
>   }
>   
> -static int gfx_v9_0_ecc_late_init(void *handle)
> +static int gfx_v9_0_ecc_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	/*
> @@ -4826,9 +4826,9 @@ static int gfx_v9_0_ecc_late_init(void *handle)
>   	return 0;
>   }
>   
> -static int gfx_v9_0_late_init(void *handle)
> +static int gfx_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> @@ -4843,7 +4843,7 @@ static int gfx_v9_0_late_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	r = gfx_v9_0_ecc_late_init(handle);
> +	r = gfx_v9_0_ecc_late_init(ip_block);
>   	if (r)
>   		return r;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 0dee2102d759..511bfa7a8bab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2529,9 +2529,9 @@ static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
>   	return gfx_v9_4_3_init_microcode(adev);
>   }
>   
> -static int gfx_v9_4_3_late_init(void *handle)
> +static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index f54f9bb89bca..ceb870d2ef13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -651,9 +651,9 @@ static int gmc_v10_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v10_0_late_init(void *handle)
> +static int gmc_v10_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 32dec30722ac..653b2e70b983 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -622,9 +622,9 @@ static int gmc_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v11_0_late_init(void *handle)
> +static int gmc_v11_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index e0d3d865a59a..3e126ebe7a8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -624,9 +624,9 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v12_0_late_init(void *handle)
> +static int gmc_v12_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 3a524319f31e..321d3828cb11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -772,9 +772,9 @@ static int gmc_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v6_0_late_init(void *handle)
> +static int gmc_v6_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS)
>   		return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 489b3c2ab660..993e2db4eb13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -940,9 +940,9 @@ static int gmc_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v7_0_late_init(void *handle)
> +static int gmc_v7_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS)
>   		return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index d564b1d8c828..784289ca27e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1046,9 +1046,9 @@ static int gmc_v8_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v8_0_late_init(void *handle)
> +static int gmc_v8_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS)
>   		return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index f274acdc49bc..73b6bf1b1432 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1601,9 +1601,9 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v9_0_late_init(void *handle)
> +static int gmc_v9_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int r;
>   
>   	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index d476cf771bbe..62da96fd7e8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1669,9 +1669,9 @@ static int mes_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int mes_v11_0_late_init(void *handle)
> +static int mes_v11_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
>   	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index a490d0e2c2cb..ae6afe3cfc9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1631,9 +1631,9 @@ static int mes_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int mes_v12_0_late_init(void *handle)
> +static int mes_v12_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
>   	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend)
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 63a3c725ceb9..f102063dc83c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -944,9 +944,9 @@ static int nv_common_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int nv_common_late_init(void *handle)
> +static int nv_common_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		xgpu_nv_mailbox_get_irq(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index cb5f84104717..acf00311547d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1780,9 +1780,9 @@ static int sdma_v4_0_process_ras_data_cb(struct amdgpu_device *adev,
>   		void *err_data,
>   		struct amdgpu_iv_entry *entry);
>   
> -static int sdma_v4_0_late_init(void *handle)
> +static int sdma_v4_0_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	sdma_v4_0_setup_ulv(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c7c4456586cc..45a1fa0c2c94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1318,9 +1318,9 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
>   		struct amdgpu_iv_entry *entry);
>   #endif
>   
> -static int sdma_v4_4_2_late_init(void *handle)
> +static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   #if 0
>   	struct ras_ih_if ih_info = {
>   		.cb = sdma_v4_4_2_process_ras_data_cb,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 481217c32d85..bda786d6caca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -213,7 +213,7 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
>   
>   		if (adev->ip_blocks[i].version->funcs->late_init) {
>   			r = adev->ip_blocks[i].version->funcs->late_init(
> -				(void *)adev);
> +				&adev->ip_blocks[i]);
>   			if (r) {
>   				dev_err(adev->dev,
>   					"late_init of IP block <%s> failed %d after reset\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> index 0af648931df5..e0c051818b5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -208,7 +208,7 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
>   
>   		if (adev->ip_blocks[i].version->funcs->late_init) {
>   			r = adev->ip_blocks[i].version->funcs->late_init(
> -				(void *)adev);
> +				&adev->ip_blocks[i]);
>   			if (r) {
>   				dev_err(adev->dev,
>   					"late_init of IP block <%s> failed %d after reset\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index e1161027ec3b..1a24634a100c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1202,9 +1202,9 @@ static int soc15_common_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int soc15_common_late_init(void *handle)
> +static int soc15_common_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		xgpu_ai_mailbox_get_irq(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index c9e88cd4349a..bc420ff85174 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -794,9 +794,9 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int soc21_common_late_init(void *handle)
> +static int soc21_common_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		xgpu_nv_mailbox_get_irq(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index 3dcb3d953509..12ed243a2df8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -440,9 +440,9 @@ static int soc24_common_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int soc24_common_late_init(void *handle)
> +static int soc24_common_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		xgpu_nv_mailbox_get_irq(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index c9ee4491ba64..ababcb7bc834 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1679,9 +1679,9 @@ static int vi_common_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int vi_common_late_init(void *handle)
> +static int vi_common_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		xgpu_vi_mailbox_get_irq(adev);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6972a8e2e0f2..f3b11f600670 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2591,9 +2591,9 @@ static int detect_mst_link_for_all_connectors(struct drm_device *dev)
>   	return ret;
>   }
>   
> -static int dm_late_init(void *handle)
> +static int dm_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	struct dmcu_iram_parameters params;
>   	unsigned int linear_lut[16];
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 67d75ac339bf..8d486b018441 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -380,7 +380,7 @@ struct amdgpu_ip_block;
>   struct amd_ip_funcs {
>   	char *name;
>   	int (*early_init)(struct amdgpu_ip_block *ip_block);
> -	int (*late_init)(void *handle);
> +	int (*late_init)(struct amdgpu_ip_block *ip_block);
>   	int (*sw_init)(void *handle);
>   	int (*sw_fini)(void *handle);
>   	int (*early_fini)(void *handle);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index ff71af96eb1a..adb44b5a9e42 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -2965,10 +2965,10 @@ static int kv_dpm_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int kv_dpm_late_init(void *handle)
> +static int kv_dpm_late_init(struct amdgpu_ip_block *ip_block)
>   {
>   	/* powerdown unused blocks for now */
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (!adev->pm.dpm_enabled)
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 5aa4eca21708..51cdaf040020 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7621,10 +7621,10 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int si_dpm_late_init(void *handle)
> +static int si_dpm_late_init(struct amdgpu_ip_block *ip_block)
>   {
>   	int ret;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (!adev->pm.dpm_enabled)
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 2af325b9fc19..903c19b4af20 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -216,9 +216,9 @@ static void pp_reserve_vram_for_smu(struct amdgpu_device *adev)
>   	}
>   }
>   
> -static int pp_late_init(void *handle)
> +static int pp_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
>   
>   	if (hwmgr && hwmgr->pm_en)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ba09dde79499..a1cd8c90a1ec 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -826,9 +826,9 @@ static int smu_apply_default_config_table_settings(struct smu_context *smu)
>   	return smu_set_config_table(smu, &adev->pm.config_table);
>   }
>   
> -static int smu_late_init(void *handle)
> +static int smu_late_init(struct amdgpu_ip_block *ip_block)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	struct smu_context *smu = adev->powerplay.pp_handle;
>   	int ret = 0;
>   
> @@ -2063,7 +2063,7 @@ static int smu_reset(struct smu_context *smu)
>   	if (ret)
>   		return ret;
>   
> -	ret = smu_late_init(adev);
> +	ret = smu_late_init(&adev->ip_blocks[AMD_IP_BLOCK_TYPE_SMC]);
>   	if (ret)
>   		return ret;
>   

