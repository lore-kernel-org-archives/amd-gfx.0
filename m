Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B578C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 09:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70D710F537;
	Fri, 12 Apr 2024 09:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dcud9Zvx";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9971310F529
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 09:24:17 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4180e794579so288865e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712913856; x=1713518656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFeyeDliAwVOYrwwOuRLG0G1biTa9NnZzr65Sn20rC8=;
 b=Dcud9ZvxH5gYh1Z3s9gbsD8P6cCj67QN5vFJGERHkBudpXQ4q/HYPBt15Q4R9/kXGF
 XbwGH5L3n2L5fbHkeqThqorhPYevoWOb8+QhyGUslBkCzlCEns73d5XSgpJxUOxFXtaD
 V9CyLu0wemePXypzxIQa0jqGoPCTmcYUXrnh8nUX7zZ9uG1yNc5NSZG5To/F3tz/ynKR
 FZbP4Cp1YmeaQvdKbXB8m116xpYilyRP5NtzMbtV7l1PB10MTsVxXP2DAcWU400s8e75
 BLP78MA19Hl699WQUUFnTe7v3aLsvBh+Uzqt6nmu6KrEl5vfJOde4DzFW53AqDS2b+o7
 4stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712913856; x=1713518656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFeyeDliAwVOYrwwOuRLG0G1biTa9NnZzr65Sn20rC8=;
 b=jzDnZ+m+Led0su8UX2YuVpOR9AWZ6ZCFmqAbBMNrF0Q2uaU/IY1VqeEFwY05e8YMr0
 fVqRaEUJdUd74urPkGXySqBhAyDnY/zohVOB2jpvZo9yx+JSsGtkX6Kpe8oQivs7JO8C
 MXREsV0SxCKSdc2yz5m3NPSxO5RG+sc7VM4u9uAeyoqgFhhW5ED9ZwrGl4DkQOUe559A
 PhKAKAHHOkUonL4RoI0OD3pS1oufhT/I6l6Wfc4MN8OnJyNGTPLvrTOSOVKO+MRMYMv8
 Xq/rsfxkQZ8W8wKINSiqL3mREHQbMcI1C/BG2qPEzxXavAzR+P4Vg0O9debM6jScWQkV
 47Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7Iv8O+c9if1hLYdagN0DiXpVyrmBKkgbTlriT4HWVA7Nb1jLRJEtDkAgWVqXQVEH3afjZJbhkkJ2K007LYmI6RRe8m9u45lyk6Mk+pA==
X-Gm-Message-State: AOJu0YxC2Y+7hM/SIZwV1R2CZcosEa5m0ZlX1t59HJbRo5g9M5GxYm4i
 C0+eFDVTq5x8mbiX/UDdTfIMLb869TRz3pOfxZYdgAxWm6hRtCns
X-Google-Smtp-Source: AGHT+IHvlah2fmVLGnSUKj42c9lwkd8GtymAMveo0CB6g13B1Ss4mhQRESvjCFz0cQXdhhVZVgg5ug==
X-Received: by 2002:a05:600c:4e01:b0:418:e7b:5110 with SMTP id
 b1-20020a05600c4e0100b004180e7b5110mr91903wmq.5.1712913855796; 
 Fri, 12 Apr 2024 02:24:15 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a05600c450900b00417e01ce03bsm4056620wmo.17.2024.04.12.02.24.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 02:24:15 -0700 (PDT)
Message-ID: <3110de1a-9379-4058-8a65-5d50b04fba92@gmail.com>
Date: Fri, 12 Apr 2024 11:24:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: Fix incorrect return value
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: yipechai@amd.com, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com,
 Candice.Li@amd.com, KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240412085546.1459735-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240412085546.1459735-1-YiPeng.Chai@amd.com>
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

Am 12.04.24 um 10:55 schrieb YiPeng Chai:
> [Why]
>    After calling amdgpu_vram_mgr_reserve_range
> multiple times with the same address, calling
> amdgpu_vram_mgr_query_page_status will always
> return -EBUSY.
>    From the second call to amdgpu_vram_mgr_reserve_range,
> the same address will be added to the reservations_pending
> list again and is never moved to the reserved_pages list
> because the address had been reserved.

Well just to make it clear that approach is a NAK until my concerns are 
solved.

Regards,
Christian.

>
> [How]
>    First add the address status check before calling
> amdgpu_vram_mgr_do_reserve, if the address is already
> reserved, do nothing; If the address is already in the
> reservations_pending list, directly reserve memory;
> only add new nodes for the addresses that are not in the
> reserved_pages list and reservations_pending list.
>
> V2:
>   Avoid repeated locking/unlocking.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 25 +++++++++++++-------
>   1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 1e36c428d254..a636d3f650b1 100644
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
> @@ -340,19 +339,27 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
>   				  uint64_t start, uint64_t size)
>   {
>   	struct amdgpu_vram_reservation *rsv;
> +	int ret = 0;
>   
> -	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
> -	if (!rsv)
> -		return -ENOMEM;
> +	ret = amdgpu_vram_mgr_query_page_status(mgr, start);
> +	if (!ret)
> +		return 0;
>   
> -	INIT_LIST_HEAD(&rsv->allocated);
> -	INIT_LIST_HEAD(&rsv->blocks);
> +	if (ret == -ENOENT) {
> +		rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
> +		if (!rsv)
> +			return -ENOMEM;
>   
> -	rsv->start = start;
> -	rsv->size = size;
> +		INIT_LIST_HEAD(&rsv->allocated);
> +		INIT_LIST_HEAD(&rsv->blocks);
> +
> +		rsv->start = start;
> +		rsv->size = size;
> +	}
>   
>   	mutex_lock(&mgr->lock);
> -	list_add_tail(&rsv->blocks, &mgr->reservations_pending);
> +	if (ret == -ENOENT)
> +		list_add_tail(&rsv->blocks, &mgr->reservations_pending);
>   	amdgpu_vram_mgr_do_reserve(&mgr->manager);
>   	mutex_unlock(&mgr->lock);
>   

