Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3156BC02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 19:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D380710E611;
	Mon, 10 Feb 2025 19:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AyCy0okK";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF2510E616
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 19:42:33 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-38dd935a267so1578967f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 11:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739216552; x=1739821352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qx2WrK5OqBMHEJl6bwdsQkg9gPb2kMLf4xlK4RrtvM8=;
 b=AyCy0okK/TJQzwyKZymkY7h06BHQYC9Zu4680ZpahRW5F8WGpthbBbzD5+bm9hZ0Gg
 k6Zgqyq2sbkTT0Fbbw0LJvS1kFUwQznMvd1SM5S9v5sI+9805jQu7bwVZDXh9y99ce6O
 ZurjCVFBg6QgetcmwACrngTlyH+73LnqDZYRjAjpt4b5vu5WZMtzIrafMOSIcrJy8T8F
 G9AOF+c147VCbnlDsmmLE6LBWaojozKdqSvPYCpHiP3p74g2L3vaGG/TsvidF7Ya4ush
 aKnfocUpB4iMbBMOZ6Nz7XQZkd6dRjAX7vvE4cOzoAHV2LgsozYRwWRYbxOMNnsrZML8
 7kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739216552; x=1739821352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qx2WrK5OqBMHEJl6bwdsQkg9gPb2kMLf4xlK4RrtvM8=;
 b=d/OK804+X+vtqipec94eDtB0NriBXqUMoltMVOwtZzY9ItTUoQFTPPdN9XIYMjoDIS
 Gpy+GvxgcWy+aghKpdpY3F3Hvl4Sfjx+/ywMkXf2cCrsu/Vq4rSe2iSojJmJaJoXvSL2
 GXhQ8K5GElznm1rQZekkKEp94Aj2etKA4ikyPppfCKZd/nwGxNq7qCmCCmnY8rtVoeN6
 UYUirctWmaaP4uH0uKkSknagMsc4UcFCYwwB9OhlYRJjPXVG0Gn6x4Am5U3/UUZxPSvl
 ca19Ygfh1s7Dz8ZvFE/TbV7xYYgdHSf50B9RUh8Xhsn4Ee54RuDfWI3q9Nq8tV+uqakz
 Sq4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKTxF1E+exSjFaD39yJf4bMSEirHBD0a9D/oAUQyfC0E6C43Ec0CTK+qlNgbN8mOaRqCTWpIKS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTXDJ07z/TXPDGwCIcdFRSxOxOZLCEpA+YKGM1dMVppEQk+HMu
 aKjCdftdmQx16tm2LijS0RHf/nkRAZdM4jkOXXpn5wNue4kmRiOQus95UgeY
X-Gm-Gg: ASbGnctJZd2MRJNRC95ob60Hxk6owTE08g6bbjnpQVZxAbGtOfhn1057kcVHdGpEnsF
 V2O+bqPicVTEWkw3Iz222o2ZCGDMpdsR5xXW75KN6w3w0Z7q7AdHfojktaBkgxPyACHb36fGFWs
 02GAx04WWn/FFqUZlKLEqkw7nWivYupqHGCUAN/rMvtpz6fJFOT/Fej/GQO2H+dwbUetpWvEjrY
 0TfaoU/6bqtEeLSSfqT+zHwgs0LlLEjZEoq2hTV1GVOahBj3Pw4PMlng9xOrkZNt0IHc/WanC87
 GhBL6eZwGRioCZZhZ+pVGRTmQ1/umyNd+8fPh1MdvcUJ
X-Google-Smtp-Source: AGHT+IGnuGXq8HAr1Z+Zg8bncL0mJMr1YrkLRAptJ1JdL+x512qT5zT22bvxwRn3RYXWItGvX+y6Ug==
X-Received: by 2002:a05:6000:184b:b0:38d:d603:ff3e with SMTP id
 ffacd0b85a97d-38dd604006amr8866025f8f.21.1739216551945; 
 Mon, 10 Feb 2025 11:42:31 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd34f2af5sm7907937f8f.78.2025.02.10.11.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:42:30 -0800 (PST)
Message-ID: <9455ed23-ddfb-436a-b1a9-cdd7d5c5dd0c@gmail.com>
Date: Mon, 10 Feb 2025 20:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 lin cao <lin.cao@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shaoyun Liu <shaoyun.liu@amd.com>
References: <20250210162755.2488728-1-alexander.deucher@amd.com>
 <20250210162755.2488728-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250210162755.2488728-2-alexander.deucher@amd.com>
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



Am 10.02.25 um 17:27 schrieb Alex Deucher:
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>
> This commit introduces enhancements to the handling of the cleaner
> shader fence in the AMDGPU MES driver:
>
> - The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
>    KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
>    that requests are handled in a controlled manner and avoiding the
>    race conditions.
> - The CP (Compute Processor) firmware has been updated to use a private
>    bus for accessing specific registers, avoiding unnecessary operations
>    that could lead to issues in VF (Virtual Function) mode.
> - The cleaner shader fence memory address is now set correctly in the
>    `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
>    the cleaner shader execution. This is done by calculating the address
>    using the write-back memory base address and the cleaner fence offset.
>
> Cc: lin cao <lin.cao@amd.com>
> Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index e862a3febe2b2..661268172dcf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -754,7 +754,7 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>   	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
>   
> -	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +	ret = amdgpu_bo_create_kernel(adev, size + AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,

You might want to adjust the size calculation earlier in the function 
instead of here.

Christian.

>   				AMDGPU_GEM_DOMAIN_VRAM,
>   				&mes->resource_1,
>   				&mes->resource_1_gpu_addr,
> @@ -765,7 +765,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
>   	}
>   
>   	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
> -	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
> +	mes_set_hw_res_pkt.mes_info_ctx_size = size;
> +	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =
> +		mes->resource_1_gpu_addr + size;
> +
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>   			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
>   			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
> @@ -1632,7 +1635,8 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		goto failure;
>   
> -	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +	if (amdgpu_sriov_is_mes_info_enable(adev) ||
> +	    adev->gfx.enable_cleaner_shader) {
>   		r = mes_v11_0_set_hw_resources_1(&adev->mes);
>   		if (r) {
>   			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
> @@ -1665,10 +1669,13 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	if (amdgpu_sriov_is_mes_info_enable(adev)) {
> +
> +	if (amdgpu_sriov_is_mes_info_enable(adev) ||
> +	    adev->gfx.enable_cleaner_shader) {
>   		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
> -					&adev->mes.resource_1_addr);
> +				      &adev->mes.resource_1_addr);
>   	}
> +
>   	return 0;
>   }
>   

