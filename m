Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BE8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 19:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE3010E1D3;
	Mon, 14 Mar 2022 19:35:17 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57CF910E1A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 19:35:16 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id w4so21400367edc.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=SMh/M0GxTexcmjVKlbztq86s3YwcMbjBRSjFP38/vjQ=;
 b=e7p2Th3gng/I3qvgnwR0X6+ZgM0x/1hfuqCY0Ba5DU+/U3i0kcOhBzgT7r33KJkD64
 6qbo3v0DWPYKpKy7hQx0egTvgT88IKOTYZo9s/kcYup+ZyM4qCPF6fiaANvu+6sht+Nm
 6MUZPSI4FTJ5DJqjCGi5SLLsxbZENGi2H1xTmpkB7DuAv2u3C27LHPbscFqUyL5Ul6L3
 x/S5nxKjPXBUn45Gsi+Ms0icWBfbMdXxvCDipy4FvHOSIiL1BbV5uMcn9p/q0c5wQjUM
 4xpnRIWgIBsmmsK/7zyQs1YFEDD+YDGgjQswdwDZBpg59Xm7u2yNOEoDcqaaUc3HATmU
 x1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=SMh/M0GxTexcmjVKlbztq86s3YwcMbjBRSjFP38/vjQ=;
 b=ykT+9qcEgD+h9aBO+g53PlYYPoNB1WVr6RUXgxJKWxQ8GRcnDzSqQUqjbg4mJONUZY
 4vJQMRbO4daF9/4yf48IzhsdZs91hpGRak1nMEIK9U8oNg7mkXRRtkcgrWvkACuWmAq3
 dkglpoh+M573LdgFyiOnsEdxr3rwTk4xpQk7ynPAd2vmfFyfD2P9RlLeixHFuIakjdZl
 BmEsvYecVgmFOCE62V4k0snox7JxobV9HI/Sjxl7ysWqvi9jA9ILdFwfbtjkAMhVoS+v
 prXLCUItzye2DKzvkh0HJSTZy0+4K9oTGc2OnQsmziy5+z/DVtQLgtJlAcJKKoWmrC6o
 ZWZA==
X-Gm-Message-State: AOAM530wMr843lhVp/QbLK+IccKGqZ1ZIRKFSm/13OVbes4dvRLM8jHe
 3bWejL+FH5TVjbDGl0wmxYg=
X-Google-Smtp-Source: ABdhPJy+omWU8qThv2Cyd0K9jezYDRT/bYI2RYaa/0Ie8hQagI0XQsXGR5Srdz9wGLF5jjCg+A5cvg==
X-Received: by 2002:a05:6402:4401:b0:417:f805:f70a with SMTP id
 y1-20020a056402440100b00417f805f70amr14948905eda.40.1647286514699; 
 Mon, 14 Mar 2022 12:35:14 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:bb72:15dd:d97a:aa7c?
 ([2a02:908:1252:fb60:bb72:15dd:d97a:aa7c])
 by smtp.gmail.com with ESMTPSA id
 er12-20020a056402448c00b00413d03ac4a2sm8087032edb.69.2022.03.14.12.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Mar 2022 12:35:14 -0700 (PDT)
Message-ID: <36a827c9-1ec9-1131-7d92-d5dc972472a1@gmail.com>
Date: Mon, 14 Mar 2022 20:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Use fw vram offset when allocating stolen
 vga memory.
Content-Language: en-US
To: Yongqiang Sun <yongqiang.sun@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220314185403.137623-1-yongqiang.sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220314185403.137623-1-yongqiang.sun@amd.com>
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
Cc: alexander.deucher@amd.com, nikola.veljkovic@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.03.22 um 19:54 schrieb Yongqiang Sun:
> [Why]
> Memory access violation will happen in case of allocate stolen vga
> memory with size isn't 0.
>
> [How]
> when allocating stolen vga memory, use fw vram offset as the start point
> instead of hard code value 0.

Please stop separating commit message into [Why] and [How], that is not 
well received everywhere.

Apart from that the patch is a certain NAK, you are messing things quite 
up here.

>
> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> Change-Id: I7c555a6c1fb4b3fa8685753b4bdcbe215f89ea1e
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 31 +++++++++++++++++++------
>   1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 41d6f604813d..1f635fdb0395 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1708,6 +1708,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	uint64_t gtt_size;
>   	int r;
>   	u64 vis_vram_limit;
> +	u64 memory_offset = adev->mman.fw_vram_usage_start_offset + adev->mman.fw_vram_usage_size;
>   
>   	mutex_init(&adev->mman.gtt_window_lock);
>   
> @@ -1774,24 +1775,40 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	 * This is used for VGA emulation and pre-OS scanout buffers to
>   	 * avoid display artifacts while transitioning between pre-OS
>   	 * and driver.  */
> -	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
> +	r = amdgpu_bo_create_kernel_at(adev,
> +					   memory_offset,
> +			           adev->mman.stolen_vga_size,

That is certainly incorrect. See function amdgpu_ttm_fw_reserve_vram_init().

The stolen VGA buffer always started at offset 0 and is independent of 
the range defined by fw_vram_usage_start_offset and fw_vram_usage_size.

Regards,
Christian.

>   				       AMDGPU_GEM_DOMAIN_VRAM,
>   				       &adev->mman.stolen_vga_memory,
>   				       NULL);
>   	if (r)
>   		return r;
> -	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
> +
> +	memory_offset += adev->mman.stolen_vga_size;
> +
> +	r = amdgpu_bo_create_kernel_at(adev,
> +					   memory_offset,
>   				       adev->mman.stolen_extended_size,
>   				       AMDGPU_GEM_DOMAIN_VRAM,
>   				       &adev->mman.stolen_extended_memory,
>   				       NULL);
>   	if (r)
>   		return r;
> -	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
> -				       adev->mman.stolen_reserved_size,
> -				       AMDGPU_GEM_DOMAIN_VRAM,
> -				       &adev->mman.stolen_reserved_memory,
> -				       NULL);
> +
> +	memory_offset += adev->mman.stolen_extended_size;
> +
> +	if (adev->mman.stolen_reserved_offset > memory_offset)
> +		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
> +						   adev->mman.stolen_reserved_size,
> +						   AMDGPU_GEM_DOMAIN_VRAM,
> +						   &adev->mman.stolen_reserved_memory,
> +						   NULL);
> +	else if (adev->mman.stolen_reserved_offset + adev->mman.stolen_reserved_size > memory_offset)
> +		r = amdgpu_bo_create_kernel_at(adev, memory_offset,
> +						adev->mman.stolen_reserved_offset + adev->mman.stolen_reserved_size - memory_offset,
> +						   AMDGPU_GEM_DOMAIN_VRAM,
> +						   &adev->mman.stolen_reserved_memory,
> +						   NULL);
>   	if (r)
>   		return r;
>   

