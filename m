Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D40C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 08:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F01510E1F5;
	Mon, 19 Aug 2024 08:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJxuBPZb";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8E710E1F5
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 08:29:39 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so35339055e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 01:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724056178; x=1724660978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4kAe8h++1uFGltRSCCc/k1cuyecs60zgOGV2GFGEzqk=;
 b=ZJxuBPZbeiECFXVmousRBvVSL0Q+LU+eMT/R4JZNZHlY3NU3rBeomeYydcAqqXnb6V
 H8n1XLXExT/mv4bkCmLAMMbCkFpGxfiBOJf1RPJ/RdO6Mq0Vh9o33dSoobkcV75ZIlj2
 k2RRteizEFkmTvX1lBWYQ2kO1THAIz9+DlrZ4SggAd5/YLYupndbmOKIZ7C2JBOKmHOZ
 OTJJvELhCPlk/S145Wxt8vi+EeBLO/bNiKTPnHNXZIq4YLgV5P8OpMkrH1Q2rjI+RFid
 1vdSa1xyueftN24WW0YGgWgkEFycCVdFCJiHTm5dHwNl8iAAMjFQ2dpNTHUVBVAYWKVh
 a6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724056178; x=1724660978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4kAe8h++1uFGltRSCCc/k1cuyecs60zgOGV2GFGEzqk=;
 b=Q4eOokJDQnNQQY+qSM9kRB1dgcCPLyHExcDD9t6KOwhJM7AIvc9AY+cuTVbopH/QFa
 dqKfRdn9f+2uIMDgbwYDf9sFuWGpnMY/ZBUMIWN/Mf6pV1x1KjzKbbWWt8aWzB6zgwXO
 ewwjmBUg+MV44cMGw/JTpcAQI0jTNJC7hvby8TMZS45iV7Z4KwjbnlBG/UycThfL9QLy
 hsPb3ObnkQ/+Qsyw//+jf3Q4zuqP5OKkU8eFl6x3pgN1o6dVi7OivWKEN8ZHEdwc11aT
 BZYgDJXrQWBtN9W2m6iW6Mbtd3aN/s9FRpO7ST8GI0hXMY8HbrXX2Ch8BH+jE5Pzh4yc
 +Lzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4zr12CH/tlLSD/vRq7ZOMjXafi6VfgHNCF69ZP+KG4V8z3Tgug4zk00X1SATGzvCbMOkWVm6pOitjXeWB9UmEFjGarYW51ktwe0r+sg==
X-Gm-Message-State: AOJu0YyZr8HaxBt4vCn0QTI+312cqA5TqczYJ2eCIUk0WH0v9sPUwCIW
 af7OeuZicCGpKLN+12EQrbbVdblEUyxhugslE7Ko52AqLu+gCyo7FD3ETITc
X-Google-Smtp-Source: AGHT+IGWNq9GWXXNTcWZKCLhxYKt37Bl+5JYAfI1zahgotKVoodX4A6cAnS3knF1eyxhorwoqzhfvw==
X-Received: by 2002:a05:600c:1c8f:b0:428:23c8:1e54 with SMTP id
 5b1f17b1804b1-429ed7b8360mr78661595e9.18.1724056177177; 
 Mon, 19 Aug 2024 01:29:37 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a1b8sm9880117f8f.5.2024.08.19.01.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 01:29:36 -0700 (PDT)
Message-ID: <0f5d4a46-9f27-40c3-9b55-1f139240c964@gmail.com>
Date: Mon, 19 Aug 2024 10:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add DCC GFX12 flag to enable address alignment
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, frank.min@amd.com
References: <20240805140125.549000-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240805140125.549000-1-Arunpravin.PaneerSelvam@amd.com>
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

Am 05.08.24 um 16:01 schrieb Arunpravin Paneer Selvam:
> We require this flag AMDGPU_GEM_CREATE_GFX12_DCC or any other
> kernel level GFX12 DCC flag to differentiate the DCC buffers and other
> pinned display buffers(which has TTM_PL_FLAG_CONTIGUOUS enabled).

That's a pretty bad idea, the DCC flag is not the right approach to 
differentiate this.

What other pinned display buffers are you talking about? As far as I can 
see that patch shouldn't be necessary in any way.

Regards,
Christian.

>
> If we use the TTM_PL_FLAG_CONTIGUOUS flag for DCC buffers, we may over
> allocate for all the pinned display buffers unnecessarily that leads to
> memory allocation failure.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 5415a5cc7789..7de0ac07a060 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -509,7 +509,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   		/* Allocate blocks in desired range */
>   		vres->flags |= DRM_BUDDY_RANGE_ALLOCATION;
>   
> -	if (adev->gmc.gmc_funcs->get_dcc_alignment)
> +	if (bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC &&
> +	    adev->gmc.gmc_funcs->get_dcc_alignment)
>   		adjust_dcc_size = amdgpu_gmc_get_dcc_alignment(adev);
>   
>   	remaining_size = (u64)vres->base.size;

