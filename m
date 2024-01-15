Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98927C3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 10:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41EB310E17B;
	Mon, 15 Jan 2024 10:26:10 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5478B10E290
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 10:26:08 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e8004629bso1124625e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 02:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705314367; x=1705919167; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b0ERJGdJKXuy2bRlb0EBBzuDaoF6eK/whbAY3GtjCXY=;
 b=PEJxbeWCCOBwpCtdjG5lxB6MT5tWqd4My3yOZzl6Vn7gAv6KuiCkupGE+aDFjbQy2B
 4GawpbBEV80zLzpMvFIYc2CxJZXXt/CWQ6q76KmvuRKjlZKpiqwMFbKyZ4xIxel+8QcK
 uYgA4KDqeZiu20huudY+4C+L2cAjCOxgJxnSCNetpko28NAuOlWYeqn/HtCuUuondwhB
 OU4CpsQ/bGx1aFMjOjrR/baTeZInom7lNtOHePYoXKp7LMrjXdHgy6YaqBXlp1oGJq3Z
 7Z7y69lQbrpQFw0qTIKadI+9ynCadCk9mycjkapRJrZBhTVvVrO7lDfKM7P666dGBVoA
 d/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705314367; x=1705919167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b0ERJGdJKXuy2bRlb0EBBzuDaoF6eK/whbAY3GtjCXY=;
 b=TtDOBEfPQfzJuBaHvFHDPerUWbFUZEPKXG5xlXcKocjjGUprf1EzLJEEYbujHAGwGo
 59Sz8J1cK1Gf+lqIoXakbi4SmHWWt5bLD/7Iqo+dwJHPWyBIkD0dk4lRN3psqu5EbfMM
 rIEozigGyouV2XjrjRmPxO+V8+Fs56dw0Ry1HawAMLIcnOMZul3vDZlv/gzdqZedQ2zF
 Ol7R3J/s3bW+xrx2DJda0+okDIcwIdmboFBeUmT9tLh/3k4OSEFP5BuL34oyV6jAh9k2
 cbZGs9FJEqoNVtDFFk6xLwohkGuN7P6RowTVa7QDM1ml3fSC/HtFiHFRVASSV9QICVxX
 VsKQ==
X-Gm-Message-State: AOJu0Yy+KXz1MYjTPvHVWlBdMcFn2w7XLtnEL++9Lcv91vU/wRst7xaO
 8f14onK54Vs3Ira1qtXNzbQ=
X-Google-Smtp-Source: AGHT+IGbc78kZgLpSNjQ1fWujBr7AiDioLbcsHrpuzSaiNIV1HYVMCiGG0f97yKDV0Swi7FmLmM9vQ==
X-Received: by 2002:a05:600c:4452:b0:40e:5bd0:d969 with SMTP id
 v18-20020a05600c445200b0040e5bd0d969mr1916363wmn.271.1705314366518; 
 Mon, 15 Jan 2024 02:26:06 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 i5-20020adfb645000000b003368c8d120fsm11510679wre.7.2024.01.15.02.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 02:26:06 -0800 (PST)
Message-ID: <ef01b29e-8529-43d2-befc-a3e3d8eaccf9@gmail.com>
Date: Mon, 15 Jan 2024 11:26:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Process fences on IH overflow
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <20240114130008.868941-2-friedrich.vock@gmx.de>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240114130008.868941-2-friedrich.vock@gmx.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Joshua Ashton <joshua@froggi.es>,
 stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.01.24 um 14:00 schrieb Friedrich Vock:
> If the IH ring buffer overflows, it's possible that fence signal events
> were lost. Check each ring for progress to prevent job timeouts/GPU
> hangs due to the fences staying unsignaled despite the work being done.

That's completely unnecessary and in some cases even harmful.

We already have a timeout handler for that and overflows point to severe 
system problem so they should never occur in a production system.

Regards,
Christian.

>
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index f3b0aaf3ebc6..2a246db1d3a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -209,6 +209,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   {
>   	unsigned int count;
>   	u32 wptr;
> +	int i;
>
>   	if (!ih->enabled || adev->shutdown)
>   		return IRQ_NONE;
> @@ -227,6 +228,20 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   		ih->rptr &= ih->ptr_mask;
>   	}
>
> +	/* If the ring buffer overflowed, we might have lost some fence
> +	 * signal interrupts. Check if there was any activity so the signal
> +	 * doesn't get lost.
> +	 */
> +	if (ih->overflow) {
> +		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> +			struct amdgpu_ring *ring = adev->rings[i];
> +
> +			if (!ring || !ring->fence_drv.initialized)
> +				continue;
> +			amdgpu_fence_process(ring);
> +		}
> +	}
> +
>   	amdgpu_ih_set_rptr(adev, ih);
>   	wake_up_all(&ih->wait_process);
>
> --
> 2.43.0
>

