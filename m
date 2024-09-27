Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65631CEBF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 07:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF4610E206;
	Fri, 27 Sep 2024 07:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XOFPCG0d";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A0E10E206
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 07:13:52 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so14394525e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727421231; x=1728026031; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p0aIJUbbD52CiHFs3mdVWZKQuKglsVGCitNlq5GvifM=;
 b=XOFPCG0d8+pwtYNNLNq/tT6vQEVV+YNriICWGfaOwv/gfzE6sS1msR0MSGbGdi+55p
 uEQ2kjrPQnEjweN6/pJC8v98oZYCGWD5xfJMzgRXwpvEaD8W2BsNA7g2PBeKDoYPozuT
 Tr0cEvjNKkx4kTU8bVibyVHU/Tb8mbWShKWy9WFTxIaPxZ/z63F2jwP2mfUl1wMoSw2u
 mk4Kzsb2c7WEhTlyVyB6R5Gh+X7w5yRxU6qoRUz+ToK6jAYIKcfObRJRhRfqooDtV7zE
 JJxHHh1MZgJrpKY4P3alMkCTPN193K0XBHx3Fr2VEHa3HdaOkj6wWDkck+Zz84e12eB2
 tSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727421231; x=1728026031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0aIJUbbD52CiHFs3mdVWZKQuKglsVGCitNlq5GvifM=;
 b=dHwVpPIg5NZBPSlV6VZTTqhqqwmbcsytZye6048pk1V7LgINsoRxHKBwtGfyjYMwVB
 xs1irpwm9rcReHCAgL6UTlp4qPjlYF7DsnxdROQA9igf/blG1SKnEVMk5sSFr53rUCGR
 nIwX7hyzFvMmQxqmUbiFeYXAUTZwV0+vzlmlKyQunrKwYQuI52CzNS1Bi3oMP/VxjPs4
 6zGgsucaA4D3xROB2ySKEIzT3NSbvIBtg6W8w9t3eNJnVAifHZ0x73vEt9afhlOWRWtu
 IlmK0c/QmbMOyH58/6VJKDjKl3q5V3+tMMv4khaaTvbj5tAV8dW9qZ25XkjINux9pGkl
 p/RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6i3r+B+9T7DvbtW0cpYs0zU1xAY4jvVxtB9WPD7rVDH9SzoNc8N0FMxL253gC9SvSjelbibSr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWf2B+t6oT4z0EF2YfavCjQt9XtRfIIrvjUIYombWu2BTly6v7
 hi5kPdiFOv0jchphug+FUcH0yDhzvzAzYECLNLVnVXmpQrvbD0PPpggS/0ia
X-Google-Smtp-Source: AGHT+IH6EoyB/O9NpehSkDLfcJc1JKDwv4BKel9Kmv72mH3S9Ya/s5jw5ErTh/bsCHbB6CFncJS3Mg==
X-Received: by 2002:a05:600c:348b:b0:42b:af5a:109 with SMTP id
 5b1f17b1804b1-42f584646b9mr13072295e9.24.1727421230533; 
 Fri, 27 Sep 2024 00:13:50 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a52915sm65924055e9.39.2024.09.27.00.13.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 00:13:49 -0700 (PDT)
Message-ID: <98980fa6-2dca-4195-9afc-6311a1c35dc4@gmail.com>
Date: Fri, 27 Sep 2024 09:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: simplify vram alloc logic since 2GB
 limitation removed
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com
References: <20240923081931.2126969-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240923081931.2126969-1-yifan1.zhang@amd.com>
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

Arun please take a look at that.

Looks valid to me in general.

Thanks,
Christian.

Am 23.09.24 um 10:19 schrieb Yifan Zhang:
> Make vram alloc loop simpler after 2GB limitation removed.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 7d26a962f811..3d129fd61fa7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -455,7 +455,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
>   	u64 vis_usage = 0, max_bytes, min_block_size;
>   	struct amdgpu_vram_mgr_resource *vres;
> -	u64 size, remaining_size, lpfn, fpfn;
> +	u64 size, lpfn, fpfn;
>   	unsigned int adjust_dcc_size = 0;
>   	struct drm_buddy *mm = &mgr->mm;
>   	struct drm_buddy_block *block;
> @@ -516,25 +516,23 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   	    adev->gmc.gmc_funcs->get_dcc_alignment)
>   		adjust_dcc_size = amdgpu_gmc_get_dcc_alignment(adev);
>   
> -	remaining_size = (u64)vres->base.size;
> +	size = (u64)vres->base.size;
>   	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc_size) {
>   		unsigned int dcc_size;
>   
>   		dcc_size = roundup_pow_of_two(vres->base.size + adjust_dcc_size);
> -		remaining_size = (u64)dcc_size;
> +		size = (u64)dcc_size;
>   
>   		vres->flags |= DRM_BUDDY_TRIM_DISABLE;
>   	}
>   
>   	mutex_lock(&mgr->lock);
> -	while (remaining_size) {
> +	while (true) {
>   		if (tbo->page_alignment)
>   			min_block_size = (u64)tbo->page_alignment << PAGE_SHIFT;
>   		else
>   			min_block_size = mgr->default_page_size;
>   
> -		size = remaining_size;
> -
>   		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc_size)
>   			min_block_size = size;
>   		else if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
> @@ -562,10 +560,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   		if (unlikely(r))
>   			goto error_free_blocks;
>   
> -		if (size > remaining_size)
> -			remaining_size = 0;
> -		else
> -			remaining_size -= size;
> +		break;
>   	}
>   	mutex_unlock(&mgr->lock);
>   

