Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6A9C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 13:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B9A112CA1;
	Tue, 16 Apr 2024 13:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I/4WKv9P";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969B5112CA1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 13:36:25 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-41896acb32fso3863635e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 06:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713274584; x=1713879384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxlnTMsPOy1vugn+GGTTn+jnjsmgz5dgNdB6oGbgHLU=;
 b=I/4WKv9PimYEYYxPMR9D/gVcnXSNUR6w2XZ0Fh4YaMFkojk1GfhCAWcTUDPIPnf8R8
 PQg3p4PMjmlVyf1REbNjpdofRF5xr//3J57k4f5vs7yjcJlNHcVJD5n3AidJeJJ1N3oB
 cSHH7paJYBHpSVCl911x44axSeu9cdUgy/y3nEFPf4xN8lfb555rEEKjhWcaLenauy1c
 aS5Y+KRWXuqM2HZWf5STyBdFTQP8wNRyec61jGpYcyYnp2cza9qSRYSD5KgpiSo+uBrT
 Wj9xFoXVBg7M9pAQdD7AMwAtlFS8o5apZ6wQ4PLt7EL8nTU3sP0kZlpGhMWuJrCFz++C
 OTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713274584; x=1713879384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxlnTMsPOy1vugn+GGTTn+jnjsmgz5dgNdB6oGbgHLU=;
 b=EUSOkHbTdfUTwuaWpVsBH7o4eKwaELwpYLT44L7MGImn4inEFjX9Qd88YyvAIpjDgq
 Kg8DweqMaaBizU66Fn/3KL6BOdLRIKDapu9VItceF3VjxeYWcfGH7AMW3Xd7iYqYcS4t
 BXjmsXbQxZdeyXdH124+hCKgmA32NrRiGHsOvy8SgJtFsJFWcOAyeGK1x548QYISvomd
 qq6mBfRhnKjQ44ENSGR79GZHLWcBxQ/Mo6TX0nKWQwQT7YyFtHVt0kiwoqqY/gLimEfk
 ccupBOsqra/E5/fMVciQrY0+FNwIZL8pII/UU8A0iqx+p20Gyv6JWp85sUQohFenI7vI
 Eq7w==
X-Gm-Message-State: AOJu0YylzVTl1SBOlE19yWZYhWFu9PdGPQWJX89i/UQjBkI7oj/jLTxm
 aQUMk6/axcC1mN5A8l5WNh+K9GM8v//Cv4QuQAkSYqhVUkRM456q
X-Google-Smtp-Source: AGHT+IHvHf9SjWs/QCo+dJnZaOPbQ0k5dXKe2fL+Bye+1f/iVZSxk1QXEjO4bpm+KmzOJji0aomQ2A==
X-Received: by 2002:a05:600c:511d:b0:417:eb6d:102f with SMTP id
 o29-20020a05600c511d00b00417eb6d102fmr10563903wms.8.1713274583373; 
 Tue, 16 Apr 2024 06:36:23 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a05600c350600b004163321790esm19994439wmq.19.2024.04.16.06.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 06:36:23 -0700 (PDT)
Message-ID: <39ae20c6-0963-49ff-8277-619a0a6a8a02@gmail.com>
Date: Tue, 16 Apr 2024 15:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm:amdgpu: enable IH RB ring1 for IH v6.0
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240416133423.3346-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240416133423.3346-1-sunil.khatri@amd.com>
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

Am 16.04.24 um 15:34 schrieb Sunil Khatri:
> We need IH ring1 for handling the pagefault
> interrupts which are overflowing the default
> ring for specific usecases.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire 
series.

> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index ad4ad39f128f..26dc99232eb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -549,8 +549,15 @@ static int ih_v6_0_sw_init(void *handle)
>   	adev->irq.ih.use_doorbell = true;
>   	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
>   
> -	adev->irq.ih1.ring_size = 0;
> -	adev->irq.ih2.ring_size = 0;
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, IH_RING_SIZE,
> +					use_bus_addr);
> +		if (r)
> +			return r;
> +
> +		adev->irq.ih1.use_doorbell = true;
> +		adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
> +	}
>   
>   	/* initialize ih control register offset */
>   	ih_v6_0_init_register_offset(adev);

