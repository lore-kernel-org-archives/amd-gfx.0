Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32973C25B67
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 07:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD1610E939;
	Fri, 27 Oct 2023 07:07:48 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6917E10E938
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 07:07:46 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32f5b83f254so1190522f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 00:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698390465; x=1698995265; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rbfbcvvg+tjJALU3lXqnf2zXYOovhPStXCFqcANhw7A=;
 b=HSFmbHmRiY1Iy+RI6VlHepTBba5FAj/gsJg4uX8a/2Xt9u7/wzLtxVKbObGkXiv5uN
 HXwLwJa38yLhmKBO9SfM5xBqjTb2M0qnWa1XiOH6eZGqzCIeHNLX1QOADFhkrHwDvdKj
 Zv4zW27RigpHlY7gMooW2II6Bzdl9Pq8tha5eoPLRjpBKtSwK5E1HwEb7gJI0YvL/E6A
 xahF1TIID+x+997lrPZizfXM2R85YIHKo5A33PJAMd6GGh1ceXKI2Q0ioZiL2vSe/7+1
 A1Y+NdILJqyeI4bgzVRnXjXGyz+eCEGPZiVmLhV2ZKuHH2qaQwMYbixpDD7owEM3jo4/
 tWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698390465; x=1698995265;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rbfbcvvg+tjJALU3lXqnf2zXYOovhPStXCFqcANhw7A=;
 b=ctfn8fe1lIobWj6A8l3emxjkYxl5JmnqHMTEP03d2qz0Ag9B3pWnDa8qisgclWyu7B
 RqhNqAb1YW6q5slXvRYQznVCBpmFnz6Ifz+Un1WLYxggD8yf+5zcQqEFz6uClGEvyXH8
 Fm8T5CoWg5f1yEwtpK4K9ktHOzG5moxXfTQXXd+PtHDaBaps6sUEtGhiHB+AHdIQAMpc
 YsKQ7s6jHcKDGgH36iss/8wLmTzQv+kpueQjjgHuDhFkd4k11CdZJXZD69NCN92xD7WZ
 Tt0/dkcRNrkfvrB10mcnl1F4CFAmzQPaAWIppDA0LalsYmTrObDmTkPRx/gpAY8Tv7ln
 aFEg==
X-Gm-Message-State: AOJu0YxpeBlMCff6NQXQJ2jsPp2XO9mP8ocBoGBZsDXPx7xiwYmBkohr
 0WmnvDCOzX+IA/F68Y7LJE2rn9eFD0L9aw==
X-Google-Smtp-Source: AGHT+IEJGMWVW5GjkLes8hFKzo0djrvDL8e42pJl75AB9BlwoJpnklZES7aduHPzYvBg+4rwWXN4lw==
X-Received: by 2002:a5d:67c8:0:b0:32d:812d:907e with SMTP id
 n8-20020a5d67c8000000b0032d812d907emr1119729wrw.65.1698390464539; 
 Fri, 27 Oct 2023 00:07:44 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 k6-20020adff286000000b0031984b370f2sm1101269wro.47.2023.10.27.00.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:07:44 -0700 (PDT)
Message-ID: <bc7b3159-9a31-40b6-bbf8-403597f8267d@gmail.com>
Date: Fri, 27 Oct 2023 09:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx10,11: use memcpy_to/fromio for MQDs
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231026185609.28627-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231026185609.28627-1-alexander.deucher@amd.com>
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

Am 26.10.23 um 20:56 schrieb Alex Deucher:
> Since they were moved to VRAM, we need to use the IO
> variants of memcpy.
>
> Fixes: 1cfb4d612127 ("drm/amdgpu: put MQDs in VRAM")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ++++++------
>   2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9032d7a24d7c..306252cd67fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6457,11 +6457,11 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
>   		nv_grbm_select(adev, 0, 0, 0, 0);
>   		mutex_unlock(&adev->srbm_mutex);
>   		if (adev->gfx.me.mqd_backup[mqd_idx])
> -			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
> +			memcpy_fromio(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
>   	} else {
>   		/* restore mqd with the backup copy */
>   		if (adev->gfx.me.mqd_backup[mqd_idx])
> -			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
> +			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
>   		/* reset the ring */
>   		ring->wptr = 0;
>   		*ring->wptr_cpu_addr = 0;
> @@ -6735,7 +6735,7 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
>   	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
>   		/* reset MQD to a clean status */
>   		if (adev->gfx.kiq[0].mqd_backup)
> -			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
> +			memcpy_toio(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
>   
>   		/* reset ring buffer */
>   		ring->wptr = 0;
> @@ -6758,7 +6758,7 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
>   		mutex_unlock(&adev->srbm_mutex);
>   
>   		if (adev->gfx.kiq[0].mqd_backup)
> -			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
> +			memcpy_fromio(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
>   	}
>   
>   	return 0;
> @@ -6779,11 +6779,11 @@ static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
>   		mutex_unlock(&adev->srbm_mutex);
>   
>   		if (adev->gfx.mec.mqd_backup[mqd_idx])
> -			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
> +			memcpy_fromio(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
>   	} else {
>   		/* restore MQD to a clean status */
>   		if (adev->gfx.mec.mqd_backup[mqd_idx])
> -			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
> +			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
>   		/* reset ring buffer */
>   		ring->wptr = 0;
>   		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 762d7a19f1be..43d066bc5245 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -3684,11 +3684,11 @@ static int gfx_v11_0_gfx_init_queue(struct amdgpu_ring *ring)
>   		soc21_grbm_select(adev, 0, 0, 0, 0);
>   		mutex_unlock(&adev->srbm_mutex);
>   		if (adev->gfx.me.mqd_backup[mqd_idx])
> -			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
> +			memcpy_fromio(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
>   	} else {
>   		/* restore mqd with the backup copy */
>   		if (adev->gfx.me.mqd_backup[mqd_idx])
> -			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
> +			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
>   		/* reset the ring */
>   		ring->wptr = 0;
>   		*ring->wptr_cpu_addr = 0;
> @@ -3977,7 +3977,7 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
>   	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
>   		/* reset MQD to a clean status */
>   		if (adev->gfx.kiq[0].mqd_backup)
> -			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
> +			memcpy_toio(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
>   
>   		/* reset ring buffer */
>   		ring->wptr = 0;
> @@ -4000,7 +4000,7 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
>   		mutex_unlock(&adev->srbm_mutex);
>   
>   		if (adev->gfx.kiq[0].mqd_backup)
> -			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
> +			memcpy_fromio(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
>   	}
>   
>   	return 0;
> @@ -4021,11 +4021,11 @@ static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring)
>   		mutex_unlock(&adev->srbm_mutex);
>   
>   		if (adev->gfx.mec.mqd_backup[mqd_idx])
> -			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
> +			memcpy_fromio(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
>   	} else {
>   		/* restore MQD to a clean status */
>   		if (adev->gfx.mec.mqd_backup[mqd_idx])
> -			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
> +			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
>   		/* reset ring buffer */
>   		ring->wptr = 0;
>   		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);

