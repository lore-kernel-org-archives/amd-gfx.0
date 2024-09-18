Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FE5CCD1A0
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Sep 2024 13:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC2110E5AD;
	Wed, 18 Sep 2024 13:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LkK2uW4f";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC37C10E5AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Sep 2024 13:44:03 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-374bd0da617so4734439f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Sep 2024 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726667042; x=1727271842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wu2Z3E2GzYlNZ4S57MFZcr9Z620jFYoXcOhm0cyNadw=;
 b=LkK2uW4fJScVV6zvBE//i2a597heSy9Uf2wnMlFNRKwYcaurrvJYHZjDf++e2Odjhy
 SpSqBJ7OQw8bdIdHNV7KyxYPW/Miqs0wSH0eJRLJTmm1G76/8R2BSzNrlF3hTWDCKsh2
 Fg2rkE7vYHtDmuxFFXjTFVCDkAx8Q1tOTnhHuBaUYlXvf/Af67FSg0CvBrElrB1cmjC0
 o1GK1J4wM1fXmB9wBmTRaSY6syX/Uzp3ocWNCzrA7bQoW479u6mxHyfItSrhuzy+Lsuo
 6R9KvWTRP3gYULBQJg+KcO8kNPxPmjA4OIprPZsFIMZ0njZe6OvYcs1LgkkW4hRRJjjQ
 zbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726667042; x=1727271842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wu2Z3E2GzYlNZ4S57MFZcr9Z620jFYoXcOhm0cyNadw=;
 b=uejKPnh/FWwaI/ylkip9+cVsEZOD3A/P7uWH8EqgLpFLremMSueSDj7euqL/UHkX4v
 FPbo4GrOPWKkdKL7P0X0nBFYjvR4HOsiLYB4FFM/8Ob5Km0+a1hiSL1bUF/3ubyeO1p2
 DJ+h7iQb9ZhgvVquvMVg7Nfr997HS2kKcbO3kGZrHyOrEZ1t9mJq0cNrueGdrKAe848B
 C+Z/q8zbpA9kzwRnGPkVAYO95n/4ynhFlaLtXMl4A5+0s8aIc3Ifhiw5YR+8ChWg6zCW
 J64G88t540YTOBwJUJxaiQNBtsKXVBgR2moRv1kiXnswrgpuR4lsaT02mc6RH3WgL68O
 237A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXOtf47qkPbZY2ag0w7oR3jAhiU7krh7wscRrj4nh0j50gmcN69+ScL8rdYft8MWqa/Qt+V9I5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrCGy/77fitYhzmKQyn/VFkesso1BPRNe1B3WPixX2bLL67C6y
 fyJlXlxvaJa7T7jKcquHOGfx/H5EgqLiV29C6jkKqHG9qkF3sph2
X-Google-Smtp-Source: AGHT+IH57iIeMPhL762UphgWRE24s3Rq1i/N2v7KYpYZIKB2zFuKw2ANg9HgKFavc3kxgEwU9V9b0A==
X-Received: by 2002:a05:6000:12cb:b0:371:8c75:a085 with SMTP id
 ffacd0b85a97d-378c2d579aamr11567742f8f.58.1726667041994; 
 Wed, 18 Sep 2024 06:44:01 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780da68sm12367442f8f.111.2024.09.18.06.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 06:44:01 -0700 (PDT)
Message-ID: <2534c57c-e4bf-4df4-b5c6-e9864254f41d@gmail.com>
Date: Wed, 18 Sep 2024 15:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/mes11: reduce timeout
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240918133953.3786248-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240918133953.3786248-1-alexander.deucher@amd.com>
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
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/3627
> Fixes: f7c161a4c250 ("drm/amdgpu: increase mes submission timeout")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 3c923719e32d3..e2b3f859a1c05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -161,7 +161,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   						    int api_status_off)
>   {
>   	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
> -	signed long timeout = 3000000; /* 3000 ms */
> +	signed long timeout = 2100000; /* 2100 ms */
>   	struct amdgpu_device *adev = mes->adev;
>   	struct amdgpu_ring *ring = &mes->ring[0];
>   	struct MES_API_STATUS *api_status;

