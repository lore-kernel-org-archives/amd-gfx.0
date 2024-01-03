Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB840C47077
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63AE710E33B;
	Wed,  3 Jan 2024 14:57:35 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4379E10E33B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:57:34 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3374e332124so475353f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704293852; x=1704898652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vRhmsoNwZ8Tlvjtjlw3e30Su8VSpBRNy8GVIyvl2Rag=;
 b=h/CcXe4MC1Xn7WN1szC6T6e2XZb9iefZZAMjZEIsp0xuoU6+BZKx39aNKBPbav4lfs
 3WBKwOjJ18APpH54GScHN8Uyc66rs4DIM7yh4H18cOkEcEZcRO8qpbFgEHwl2fYvW4kp
 hrM8kLPF8tdDuOt2pVxHsMnSnwv7xVpBRD8lmZKm7q91db0T0943Lo/yiZZGWLwFcRA0
 3R3NU7xKQylZu3Z6rXcK+4eApsF727pIoYKThkz5nwt9QFbj4OR9xj4BlJPfIe//PYkp
 K7PjLnofIk0ahXb9Oxcx91d5ntrbFfV+NqMUhQJh6kTXP/pEgmYvj8IOLKAa1bCKLS24
 KlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704293852; x=1704898652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vRhmsoNwZ8Tlvjtjlw3e30Su8VSpBRNy8GVIyvl2Rag=;
 b=fb24xDHrSB3gYbZvngXL1k4C3D/i8Vn8OzkquWyHwods6bKyCtXsCWVNpbuCaXfvg0
 T3JDoruA7vucgc9gJSw+QTKvE1fDN507mtOYHK8wT+V32U7fvAXvNcEdz6KrS2kZ9CaZ
 +vzpNLV8PG3XM9WmKnF+XqA/Q50RYXJ9JL/eW78iVfZMIzz4m8MQaYObzK/B/JmnIR4x
 +nxmSI+5J9h24MqJ3J0z9gPVj4C8WBQ+8G8ORM5M2WTxOIAALZ8bKNtbGhaF18bnpP1K
 wtcmHPCfshSywLPhuLzC/UN8u1nb3gVSUOkIym5baf8A7sc2+K/2GOKp7qfkiCY5Hl9I
 kCVQ==
X-Gm-Message-State: AOJu0Yzkg7gQDrwZkWDWFayWPbk0lMIvhobIkYt0qUgMkWsqRhDI82RJ
 Wji9s2ZO9QX0ufgs9YOjsII=
X-Google-Smtp-Source: AGHT+IF/bDddjFiquXS7A7zvLE35lTqENA3d4VzduObVis7gFrLo5xTaN394d0vnNCCyq9b/ZexNNA==
X-Received: by 2002:a5d:4d07:0:b0:336:8657:60df with SMTP id
 z7-20020a5d4d07000000b00336865760dfmr9501811wrt.79.1704293852355; 
 Wed, 03 Jan 2024 06:57:32 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 e25-20020adfa459000000b003365951cef9sm31105295wra.55.2024.01.03.06.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 06:57:31 -0800 (PST)
Message-ID: <6290f537-530b-4698-b3d0-18069b3441eb@gmail.com>
Date: Wed, 3 Jan 2024 15:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9/10
 _0_hw_init()' function
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20231222113434.1683616-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20231222113434.1683616-1-srinivasan.shanmugam@amd.com>
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.12.23 um 12:34 schrieb Srinivasan Shanmugam:
> The gmc_v6/7/8/9/10 _0_hw_init() function in emulation checks whether
> all of the memory range of shared system memory could be accessed by
> GPU, from this aspect, -EIO is returned for error scenarios.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:919 gmc_v6_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1103 gmc_v7_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1223 gmc_v8_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2344 gmc_v9_0_hw_init() warn: missing error code? 'r'
>
> Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  | 11 +++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 11 +++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 11 +++++++----
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 11 +++++++----
>   5 files changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index a5a05c16c10d..6172816f54da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1004,7 +1004,7 @@ static int gmc_v10_0_hw_init(void *handle)
>   	if (amdgpu_emu_mode == 1) {
>   		r = amdgpu_gmc_vram_checking(adev);
>   		if (r)
> -			return r;
> +			return -EIO;

We should probably adjust amdgpu_gmc_vram_checking() instead to return 
-EIO when it failed.

The number of not matching bytes is actually completely uninteresting to 
the caller.

Regards,
Christian.

>   	}
>   
>   	if (adev->umc.funcs && adev->umc.funcs->init_registers)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 42e103d7077d..68e3fff02308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -913,10 +913,13 @@ static int gmc_v6_0_hw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (amdgpu_emu_mode == 1)
> -		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +	if (amdgpu_emu_mode == 1) {
> +		r = amdgpu_gmc_vram_checking(adev);
> +		if (r)
> +			return -EIO;
> +	}
> +
> +	return 0;
>   }
>   
>   static int gmc_v6_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index efc16e580f1e..1a6bee9b4777 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1097,10 +1097,13 @@ static int gmc_v7_0_hw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (amdgpu_emu_mode == 1)
> -		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +	if (amdgpu_emu_mode == 1) {
> +		r = amdgpu_gmc_vram_checking(adev);
> +		if (r)
> +			return -EIO;
> +	}
> +
> +	return 0;
>   }
>   
>   static int gmc_v7_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index ff4ae73d27ec..192041c707a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1217,10 +1217,13 @@ static int gmc_v8_0_hw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (amdgpu_emu_mode == 1)
> -		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +	if (amdgpu_emu_mode == 1) {
> +		r = amdgpu_gmc_vram_checking(adev);
> +		if (r)
> +			return -EIO;
> +	}
> +
> +	return 0;
>   }
>   
>   static int gmc_v8_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 473a774294ce..f2ef1d8107f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2338,10 +2338,13 @@ static int gmc_v9_0_hw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (amdgpu_emu_mode == 1)
> -		return amdgpu_gmc_vram_checking(adev);
> -	else
> -		return r;
> +	if (amdgpu_emu_mode == 1) {
> +		r = amdgpu_gmc_vram_checking(adev);
> +		if (r)
> +			return -EIO;
> +	}
> +
> +	return 0;
>   }
>   
>   /**

