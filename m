Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17C4CCD1A5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Sep 2024 13:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D92F10E5AC;
	Wed, 18 Sep 2024 13:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QLMQ2g2L";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277F410E5AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Sep 2024 13:47:11 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso59103875e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Sep 2024 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726667229; x=1727272029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YvmaRz5BepGzWgYHgqP4IROPioZP9whN88DZBzI4o58=;
 b=QLMQ2g2L6Qmi6G8BkBC1fscymFC9ejx2idlWzzTBScKNRvugIvP3DOsIYlGWQwhm+U
 SAXNQjEvJ5q7sjRGMHLaLFgEM7oCRkSsZrtvAw4uFb9Y7xKi2zfo6Eb5vwSc7f8fP4rV
 vNlM8VEDWV01W/0Ea5kxvde+zUWuEy8DWY6AJVqdn9udEhhie7CLg9qSt6QHSe70QHd2
 wp6rhZEiBf+SW8u6g82YSEsaPou7Afbz2wMUD6nI581UvfXx87j+v5tpRh+y8CLaxo4u
 FAp86jXfwC5jvno9x5NMeKkIYzmsFK2Exy26PBQqkuQdBdM/Mdsg8vcn0c5Mcyx6ORQA
 +7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726667229; x=1727272029;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YvmaRz5BepGzWgYHgqP4IROPioZP9whN88DZBzI4o58=;
 b=pkzryaloElBm6MO4YlGSz9QwMvnEhmPNwQtg7GbtmOpkRoyOTnDKJVrBaeRSDTV4op
 nkvZYCEG5Bi5QFc1S72fCkgmbr3nALy4aCBnFiVhknCnsPCqGQRzzNjiavWREOrOPpxj
 7BATabiuGcJGZ7DjsXw7cLqZPCHiNTILnuYfrFEvIf5yMlledjPJYzuA6zGm+LzfB7Xa
 Qv/+bfjIzmDJ3rh4LdUR0AD6XtRDOKXhz7c/p566Woa90fBVKeklzoCFNyWFvsA0vHx+
 Z1pqpwA3pDPfkV0qt0oSPvM1T6VODROV8M+K9c5EV83fj2QRB8rywq5QUDppLTV6wQGJ
 NOQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnhDDDtyf2EOthPBiCoTLYFCc6TZxT8CBbT/ehNb6b5mLiaxh13cbqxedLAdTby5dN/OlbBuFJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3ZZHl9AKuxrqExlEiokT5E7rVwP5ykmZb7WuQKIDv9nO1tkfD
 T+EUt/ZoM24N2cU0DUjA6olrYcjo5yuHeVihv/XWyssjpE0G8f6ZDCIWyFD2
X-Google-Smtp-Source: AGHT+IFBwkn9vC1+pR/GTU8AzE8wy7wiSp9O4XJ/9c+N+zaMvDw6jxkMkgMNe4uZN4T/2Wk1VAycpw==
X-Received: by 2002:a05:600c:3b92:b0:42c:bbd5:af70 with SMTP id
 5b1f17b1804b1-42cdb56f1e0mr169837285e9.30.1726667229258; 
 Wed, 18 Sep 2024 06:47:09 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7051747asm17466305e9.36.2024.09.18.06.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 06:47:08 -0700 (PDT)
Message-ID: <48d9ce3b-0cfa-47b8-9807-fa32169876a5@gmail.com>
Date: Wed, 18 Sep 2024 15:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: reduce timeout
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240918133953.3786248-1-alexander.deucher@amd.com>
 <20240918133953.3786248-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240918133953.3786248-2-alexander.deucher@amd.com>
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

Am 18.09.24 um 15:39 schrieb Alex Deucher:
> The firmware timeout is 2s.  Reduce the driver timeout to
> 2.1 seconds to avoid back pressure on queue submissions.
>
> Fixes: 94b51a3d01ed ("drm/amdgpu/mes12: increase mes submission timeout")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

We should probably move that to a higher level.

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index ef05a41162306..186f778133974 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -146,7 +146,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   					    int api_status_off)
>   {
>   	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
> -	signed long timeout = 3000000; /* 3000 ms */
> +	signed long timeout = 2100000; /* 2100 ms */
>   	struct amdgpu_device *adev = mes->adev;
>   	struct amdgpu_ring *ring = &mes->ring[pipe];
>   	spinlock_t *ring_lock = &mes->ring_lock[pipe];

