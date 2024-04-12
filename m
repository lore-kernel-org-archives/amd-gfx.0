Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DCCC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 09:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D982810F41F;
	Fri, 12 Apr 2024 09:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fwlv80V9";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C24910F41F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 09:22:44 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-346b480e1acso422805f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712913762; x=1713518562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ufBBSCXjvM9Un50MKX1rtpzv4T0NQpellRvbBWYIfjk=;
 b=fwlv80V9Rq5kpBUVeNKzuLMmAVAe0g9rpnLTWKJ9SexmN2+VHQ1BO58ih32qkzsA9T
 1TtBqCUJTfkzOdmNXeXxWSNFO81jCK5ugLXRR42Ko7NR5khj/boPJb/YY0N/m3Aaehiq
 CcddSqlFFr0As+6vipHqjXm1c+6jCxRVri4AQLLuQOnBnuUtaMgezQW+supmLsG4pn4I
 fBnWrKoy9fhJ1Z7cEhY7gc1qw/IFr/WOhqeCfwi35W5Mbv7mP6qrFHdlcF+bqleBpga4
 a/9v8FXT71ZSRFY/2/Tu0zvL5elBXmcpxwJVH1v62qWNZNBYC/D7TGuzuU0BAfiJtSVI
 WDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712913762; x=1713518562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufBBSCXjvM9Un50MKX1rtpzv4T0NQpellRvbBWYIfjk=;
 b=pXl++KmF8WyuOjQPBlSkukirNc0Y6jdNGSQ46l33QEV6uIapQopks+ZEVmm92Yum5/
 Qz/r+W4q6x6+ZDIH91swo7JKiZJBdV/XAhf3ekbUKZCdTKRsjAK7TNOTgBTZupn0lVn+
 8H8JVqKD9LROs9KEiCuEZCqDmMHuJJV7GLTY+F6PkktR4qxTIyPU58xGEShx1cJuyoC5
 8C5fFMnbLYXiSxBdJFCpV3RdMzuVFEFvKp/0gPJYfLL32QKOT8DYrDUYoTDWVy9F9p5g
 trmyyGSAruk46nTCqbW3s8aptmNrs2RGz9nn3BDlJeLNdHT/e17NPeqDKNsmQKmReh67
 d9vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcOj7WoSgCWJ3CPSbi15vHFNLCvY5ufRstaUrBu2FfTkmw3J9K3oOIHPXxWlnMNPR0GedO1ap7d1Ua8NJcFjnnD54bpoyfSFRKpdKbiQ==
X-Gm-Message-State: AOJu0YzQ5WjamjMs5WW9Kx9Lb44f0HNF3vjLNYt0y3RObHMNbjRpFVPl
 Aav7FEA3foG4lre+Vk3TTn4i9Iu5NLVYE+09l/Nc0IUdki4Cs/V4
X-Google-Smtp-Source: AGHT+IGwL3ZxLXKCYWjCqLduo9Tm7VBeit/gOARVF+8ZY6Q3frraVKvEK/o/y4dHsdkTzCQoTM+w/A==
X-Received: by 2002:a05:6000:178d:b0:341:ab37:6a25 with SMTP id
 e13-20020a056000178d00b00341ab376a25mr1529692wrg.43.1712913761835; 
 Fri, 12 Apr 2024 02:22:41 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a5d6245000000b0034334af2957sm3808963wrv.37.2024.04.12.02.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 02:22:41 -0700 (PDT)
Message-ID: <1b32c81c-8d50-4133-a6a0-19b70055576f@gmail.com>
Date: Fri, 12 Apr 2024 11:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix incorrect return value
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: yipechai@amd.com, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 Candice.Li@amd.com, KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240403070649.685497-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240403070649.685497-1-YiPeng.Chai@amd.com>
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

Am 03.04.24 um 09:06 schrieb YiPeng Chai:
> [Why]
>    After calling amdgpu_vram_mgr_reserve_range
> multiple times with the same address, calling
> amdgpu_vram_mgr_query_page_status will always
> return -EBUSY.
>    From the second call to amdgpu_vram_mgr_reserve_range,
> the same address will be added to the reservations_pending
> list again and is never moved to the reserved_pages list
> because the address had been reserved.

Well that sounds like a really bad idea to me. Why is the function 
called multiple times with the same address in the first place ?

Apart from that a note on the coding style below.

>
> [How]
>    First add the address status check before calling
> amdgpu_vram_mgr_do_reserve, if the address is already
> reserved, do nothing; If the address is already in the
> reservations_pending list, directly reserve memory;
> only add new nodes for the addresses that are not in the
> reserved_pages list and reservations_pending list.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 28 +++++++++++++-------
>   1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 1e36c428d254..0bf3f4092900 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -317,7 +317,6 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
>   
>   		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
>   			rsv->start, rsv->size);
> -
>   		vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
>   		atomic64_add(vis_usage, &mgr->vis_usage);
>   		spin_lock(&man->bdev->lru_lock);
> @@ -340,19 +339,30 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
>   				  uint64_t start, uint64_t size)
>   {
>   	struct amdgpu_vram_reservation *rsv;
> +	int ret = 0;

Don't initialize local variables when it isn't necessary.

>   
> -	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
> -	if (!rsv)
> -		return -ENOMEM;
> +	ret = amdgpu_vram_mgr_query_page_status(mgr, start);
> +	if (!ret)
> +		return 0;
> +
> +	if (ret == -ENOENT) {
> +		rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
> +		if (!rsv)
> +			return -ENOMEM;
>   
> -	INIT_LIST_HEAD(&rsv->allocated);
> -	INIT_LIST_HEAD(&rsv->blocks);
> +		INIT_LIST_HEAD(&rsv->allocated);
> +		INIT_LIST_HEAD(&rsv->blocks);
>   
> -	rsv->start = start;
> -	rsv->size = size;
> +		rsv->start = start;
> +		rsv->size = size;
> +
> +		mutex_lock(&mgr->lock);
> +		list_add_tail(&rsv->blocks, &mgr->reservations_pending);
> +		mutex_unlock(&mgr->lock);
> +
> +	}

You should probably not lock/unlock here.

Regards,
Christian.

>   
>   	mutex_lock(&mgr->lock);
> -	list_add_tail(&rsv->blocks, &mgr->reservations_pending);
>   	amdgpu_vram_mgr_do_reserve(&mgr->manager);
>   	mutex_unlock(&mgr->lock);
>   

