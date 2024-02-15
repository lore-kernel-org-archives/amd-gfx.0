Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545CEC4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 14:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD76610E917;
	Thu, 15 Feb 2024 14:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iAxIv2IV";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E8010E917
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 14:49:09 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-411a5b8765bso5787145e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708008548; x=1708613348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cpfZEhl2x2JtZzsbBH0wf6l3F4/twX7NFhU3Bb+3e3w=;
 b=iAxIv2IVh4jRXNfeUqVZiRrdQQ40dbddeep0oe/azxoYyrfzvO13isnYK02NaB3whM
 3XjcCxLP+ER4ckA6aeeu0s6TKXD7QbQ3y4NrP+tYbmragn0IhflCD7ZCcOdTvABwSLx2
 89PRh4g4rV+D3AipqcyaDxVilemZx/4ZDZnr5FMlBG+C3aNfDcb/dlKjGEDz2kgVUX5O
 M7UJ5sAJTtoQ7oKIb23887PjOI3HZtn2uMYE4n4eYOlaf9d69PH6rSF9MnoaM0N0zHiG
 DlRWwAh4V04WZMl8mPKz0pb0njxsLsnkD0vaBmUhyjkLBJiukxetCFoyzIWrF6s8ec5m
 dq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708008548; x=1708613348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cpfZEhl2x2JtZzsbBH0wf6l3F4/twX7NFhU3Bb+3e3w=;
 b=C/8LsukjCbKdGCFZat0MZR0uf2idsEaf42VuXbqHcf2CrvwCcoBIvCBbvE869uctQf
 F1kKKtFEmpGqoxUMgs84FEIBT1gXeaKl1vyfCBzvMPtu/ROiV8Q1+1X4oyp2eOKahRNZ
 3TtNtCAHVEKJRQeXmnNOJ9H6hGf7d7g6v1nEZl5aMzvuW032D2a5tM5/RP+xRs34fb6x
 DHIrcaXB4ClVpr1CbXZrek6fsFf8ZOIEn2On1feSRu3BtcFalJ+RHSsBZjCsyXh0ZeRz
 m/JWFPD92XwN9hjneRb1X6PNHkINgkygGoeOQ6mBbxb/1a4IBDIhvPSQ2pVY8k1rZK1z
 4vSg==
X-Gm-Message-State: AOJu0Yzs0G+wsT8+ATDAFBYo7pKtZ8Cqnmp0oX921QJTYrKUPZW83qx+
 WwyTzirVRFdnTlfchq+Cwj1FmUwFKZOVA5NcYXXTvUsTNu4fN2PV
X-Google-Smtp-Source: AGHT+IFzZRez/cv75Sk2n4UR39717MSiUxI5HR1ptuQu7qwx9AcQLM8+sxkijQKkDmot2j8wmEw6wA==
X-Received: by 2002:a05:600c:1d16:b0:410:e91d:fa6c with SMTP id
 l22-20020a05600c1d1600b00410e91dfa6cmr1790932wms.2.1708008548084; 
 Thu, 15 Feb 2024 06:49:08 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a5d5226000000b0033940016d6esm1969828wra.93.2024.02.15.06.49.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:49:07 -0800 (PST)
Message-ID: <ce054143-3a1b-4a26-b339-a4b0f509036a@gmail.com>
Date: Thu, 15 Feb 2024 15:49:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix missing parameter descriptions in
 ih_v7_0.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
References: <20240215123845.2327190-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240215123845.2327190-1-srinivasan.shanmugam@amd.com>
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

Am 15.02.24 um 13:38 schrieb Srinivasan Shanmugam:
> Rectifies kdoc warnings related to the 'ih' parameter in the
> 'ih_v7_0_get_wptr', 'ih_v7_0_irq_rearm', and 'ih_v7_0_set_rptr'
> functions within the 'ih_v7_0.c' file.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/ih_v7_0.c:392: warning: Function parameter or member 'ih' not described in 'ih_v7_0_get_wptr'
> drivers/gpu/drm/amd/amdgpu/ih_v7_0.c:432: warning: Function parameter or member 'ih' not described in 'ih_v7_0_irq_rearm'
> drivers/gpu/drm/amd/amdgpu/ih_v7_0.c:458: warning: Function parameter or member 'ih' not described in 'ih_v7_0_set_rptr'
>
> Fixes: b6ba7a165b13 ("drm/amdgpu: Add ih v7_0 ip block support")
> Cc: Likun Gao <Likun.Gao@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index 236806797b23..16fe428c0722 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -378,9 +378,10 @@ static void ih_v7_0_irq_disable(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * ih_v7_0_get_wptr - get the IH ring buffer wptr
> + * ih_v7_0_get_wptr() - get the IH ring buffer wptr
>    *
>    * @adev: amdgpu_device pointer
> + * @ih: IH ring buffer to fetch wptr
>    *
>    * Get the IH ring buffer wptr from either the register
>    * or the writeback memory buffer.  Also check for
> @@ -425,6 +426,7 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
>    * ih_v7_0_irq_rearm - rearm IRQ if lost
>    *
>    * @adev: amdgpu_device pointer
> + * @ih: IH ring to match
>    *
>    */
>   static void ih_v7_0_irq_rearm(struct amdgpu_device *adev,
> @@ -450,8 +452,7 @@ static void ih_v7_0_irq_rearm(struct amdgpu_device *adev,
>    * ih_v7_0_set_rptr - set the IH ring buffer rptr
>    *
>    * @adev: amdgpu_device pointer
> - *
> - * Set the IH ring buffer rptr.
> + * @ih: IH ring buffer to set rptr
>    */
>   static void ih_v7_0_set_rptr(struct amdgpu_device *adev,
>   			       struct amdgpu_ih_ring *ih)

