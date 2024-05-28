Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52941C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 14:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F77C10E3BA;
	Tue, 28 May 2024 14:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FADIOzvk";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F139410E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 14:54:24 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-35507dfe221so583825f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716908063; x=1717512863; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8NUg5Db3UrQWg5VRhF2MNRbVisH8zKd6IDESz/FGOoQ=;
 b=FADIOzvkzuY76wsQYbVpnOF23DRSDMfDJolucoURdG7Z5yR9NAUmopZbuBsE2whFXl
 ZjlVWSx8nLsCWM+2F+P2rwwA2fVXkpPYDypsee59jNiF78dYqCUebRyDAbtV0JgK82W0
 6/L3rDqGcllLSbeI7gJWFe98pUXwueVTY0Vnwd7P6VpywilHuzCebhePs/QO0XqZJwzF
 EQi7gMeO2la2fopim0vLUJ3fYmvBDtO3QvTzE1Y3E28H0CddplHnPGQGz1hCxsQ9y18E
 7dFmTrfivr6zqfzkNl13NZGzem/mUv65fFAjDOcYTy6xeV7S6UEeYbC+esARUt0t9Jo2
 5kQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716908063; x=1717512863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8NUg5Db3UrQWg5VRhF2MNRbVisH8zKd6IDESz/FGOoQ=;
 b=AcoHKiM+0vsRfzIVBFS6hO6iXQ4Ji9bQ0X4KUuyv2joVqq7pv77cQG7X2z8oY7DPQo
 o+ifM37s/Hf8HJTeQQO3plWkWdeWC/ftQg9OBRM/7ALe8jEKvs/JM4aa68j/3Ld03b0n
 0uR/YvuZUdP94/W9n3GHiKHxTVEFyhjbTFNyeROT/3NsojCV7+wUbW4wEWnXWMx4SxjE
 W7cZus/RCnISaq6HsAuDS16wrBRM+7gE1PFaUMx92tsrXpKL8/hZ2QYQjTG73oTxs1HO
 a8QfOP7tFU3VXbLO1hBfbC+HIYJQOOP+nCqKeBupA0SiRmY0//p30chzjKG737KBWCKy
 kmJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQgNDwGv1pBEAFkEXHBY7fV2ulY30GLvYAM1AgyChokiQ9ThMPfnDnWrMxOzumyebIWY0523gV5Sij8RaonSboIBD+TDE1ZAqhGcTpbA==
X-Gm-Message-State: AOJu0YwGtu7PoAiSte3JAUz7JXGkSOo3Qe9JqvcYcC59Or10gC8j03mx
 BQ+uq+DrY6Imv+TjWQ6VS09j1y1EEWvkuoqQeJ4QakR+BA7ND8O7RaPqsZUC
X-Google-Smtp-Source: AGHT+IGvZqx2jA1/BffVM2Q3QToIUpn0DaH9X8MdJOk9QGYkdb+P9TyL3GH9n5/EmmUZ93JOcKdaKg==
X-Received: by 2002:a5d:698c:0:b0:354:fa7d:dcfe with SMTP id
 ffacd0b85a97d-35526c272b4mr14136482f8f.23.1716908062823; 
 Tue, 28 May 2024 07:54:22 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf03e3sm11954228f8f.101.2024.05.28.07.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 07:54:22 -0700 (PDT)
Message-ID: <d561a604-623e-4aac-b2ec-a53609c886d1@gmail.com>
Date: Tue, 28 May 2024 16:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add lock around VF RLCG interface
To: Victor Skvortsov <victor.skvortsov@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, lijo.lazar@amd.com,
 zhigang.luo@amd.com
References: <20240527201907.470066-1-victor.skvortsov@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240527201907.470066-1-victor.skvortsov@amd.com>
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

Am 27.05.24 um 22:19 schrieb Victor Skvortsov:
> flush_gpu_tlb may be called from another thread while
> device_gpu_recover is running.

No, that would be illegal. Where do you see that?

Regards,
Christian.

>
> Both of these threads access registers through the VF
> RLCG interface during VF Full Access. Add a lock around this interface
> to prevent race conditions between these threads.
>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 ++
>   3 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f5168b4c3b03..6711836054f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4049,6 +4049,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	mutex_init(&adev->grbm_idx_mutex);
>   	mutex_init(&adev->mn_lock);
>   	mutex_init(&adev->virt.vf_errors.lock);
> +	mutex_init(&adev->virt.rlcg_reg_lock);
>   	hash_init(adev->mn_hash);
>   	mutex_init(&adev->psp.mutex);
>   	mutex_init(&adev->notifier_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 3d5f58e76f2d..a72683f83390 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -982,6 +982,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>   	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
>   	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
>   	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
> +
> +	mutex_lock(&adev->virt.rlcg_reg_lock);
> +
>   	if (reg_access_ctrl->spare_int)
>   		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
>   
> @@ -1038,6 +1041,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>   	}
>   
>   	ret = readl(scratch_reg0);
> +
> +	mutex_unlock(&adev->virt.rlcg_reg_lock);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 642f1fd287d8..0ec246c74570 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -272,6 +272,8 @@ struct amdgpu_virt {
>   
>   	/* the ucode id to signal the autoload */
>   	uint32_t autoload_ucode_id;
> +
> +	struct mutex rlcg_reg_lock;
>   };
>   
>   struct amdgpu_video_codec_info;

