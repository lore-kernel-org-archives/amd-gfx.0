Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F98FC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 06:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F5710F7DB;
	Tue, 23 Apr 2024 06:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q1qypKum";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEE010FAC8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:12:34 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-34b66f0500aso440928f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 23:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713852752; x=1714457552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uBTc6iWNx7Zd2dmMuSaV9L6yCuW3+rnUpn4T6qTnsvg=;
 b=Q1qypKumosMcUZTqh+w6tbQ6beAoo+dc2i6TEKo+6xYu/aMNkA/FKlKYcr5EX2F4ww
 7N+ZAGzMpvr2pq7fXQwDYB259M2paQfSZjOQpezqGeRsDMCdAQTb2g35rShP/QVRWAjM
 pfWojgRMW8j2ifG6KmdURWHmyeuNiSL8gPG/pYRkKJ4JcTnbLro0PoYXHXn4PrSa2D6l
 4kU7a6OBGdymZ4zcQRT+PhNeypNq9NmVVS1LvXFUSNBeu3TvhKsB062QvhuTVsZcAMO8
 9juOVNH8R7/oG4Hh9aO1VW2n5i7r2jlelmYE8Py2VE6c95LHWt1J+FRZPqfEQ6k8AEqW
 lpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713852752; x=1714457552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBTc6iWNx7Zd2dmMuSaV9L6yCuW3+rnUpn4T6qTnsvg=;
 b=IZ/JY9h3K9Oper2v3LAEPkYUbovSCxNl3Y71iVLqDl+buZbXglov3rwH8V3qUE44xm
 sZWM5/pczIeXk+VOW0wpcskCrko0WQutRx48R5BaRGUmx4M7xJvURhp3c3kt/IWbuDPh
 Rug8ZPRzNUXW4DacIm1kxT6eLW37xL/4M2IojqRhLNBmAGDjepN90lx7eDaNy7TH/xlJ
 aEuNmv1/GIuq+BayfgEhHePv8o3ck9UGq64Pn2L5LfRsticIa3AOHeJHVaiLFvvsrtbp
 AHMak+3Az/WXTi9C5kClfQa5X9xP+XHdwmlUjRrBo4D3i9O9hhrcSD9ESkPbHPU+zmPJ
 MoTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKdTb1bZ5gSk00QWWX4ZQR+AjUB19IhTjiNGGnt2vXsNphbTuQ6SEsbCeXn4B4fXYxp4DJupafrqtHS9S6sKWf8mk7mn9UoAxxX3p8vQ==
X-Gm-Message-State: AOJu0YxyD9wrGZugw/jgJVThwdFmu2wux2wDmKUleCyeaMg8ZrPg35I9
 AD910c7PJXxXkz+spthBUxqQvvasRAGQ460f5yF4hr1NzbfwxnOZ
X-Google-Smtp-Source: AGHT+IFAYWOyxLMevVoDfMmVGC0BMe19exoZkyLxusvyHJRIcnD7X6mua4VrkJUKsA0vwtCbeeeyEg==
X-Received: by 2002:adf:ef12:0:b0:347:3a0d:c665 with SMTP id
 e18-20020adfef12000000b003473a0dc665mr8170148wro.67.1713852751857; 
 Mon, 22 Apr 2024 23:12:31 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a5d6912000000b0034997769ae4sm13699093wru.15.2024.04.22.23.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 23:12:31 -0700 (PDT)
Message-ID: <959d6fe8-b5e4-4ffe-918c-cbd29a2342e1@gmail.com>
Date: Tue, 23 Apr 2024 08:12:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add a spinlock to wb allocation
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240422143738.322710-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240422143738.322710-1-alexander.deucher@amd.com>
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

Am 22.04.24 um 16:37 schrieb Alex Deucher:
> As we use wb slots more dynamically, we need to lock
> access to avoid racing on allocation or free.

Wait a second. Why are we using the wb slots dynamically?

The number of slots made available is statically calculated, when this 
is suddenly used dynamically we have quite a bug here.

Regards,
Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++++-
>   2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cac0ca64367b..f87d53e183c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -502,6 +502,7 @@ struct amdgpu_wb {
>   	uint64_t		gpu_addr;
>   	u32			num_wb;	/* Number of wb slots actually reserved for amdgpu. */
>   	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
> +	spinlock_t		lock;
>   };
>   
>   int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f8a34db5d9e3..869256394136 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1482,13 +1482,17 @@ static int amdgpu_device_wb_init(struct amdgpu_device *adev)
>    */
>   int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
>   {
> -	unsigned long offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
> +	unsigned long flags, offset;
>   
> +	spin_lock_irqsave(&adev->wb.lock, flags);
> +	offset = find_first_zero_bit(adev->wb.used, adev->wb.num_wb);
>   	if (offset < adev->wb.num_wb) {
>   		__set_bit(offset, adev->wb.used);
> +		spin_unlock_irqrestore(&adev->wb.lock, flags);
>   		*wb = offset << 3; /* convert to dw offset */
>   		return 0;
>   	} else {
> +		spin_unlock_irqrestore(&adev->wb.lock, flags);
>   		return -EINVAL;
>   	}
>   }
> @@ -1503,9 +1507,13 @@ int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb)
>    */
>   void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>   {
> +	unsigned long flags;
> +
>   	wb >>= 3;
> +	spin_lock_irqsave(&adev->wb.lock, flags);
>   	if (wb < adev->wb.num_wb)
>   		__clear_bit(wb, adev->wb.used);
> +	spin_unlock_irqrestore(&adev->wb.lock, flags);
>   }
>   
>   /**
> @@ -4061,6 +4069,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	spin_lock_init(&adev->se_cac_idx_lock);
>   	spin_lock_init(&adev->audio_endpt_idx_lock);
>   	spin_lock_init(&adev->mm_stats.lock);
> +	spin_lock_init(&adev->wb.lock);
>   
>   	INIT_LIST_HEAD(&adev->shadow_list);
>   	mutex_init(&adev->shadow_list_lock);

