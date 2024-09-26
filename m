Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078E0CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 11:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC3BD10EAD1;
	Thu, 26 Sep 2024 11:38:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bgD0XoP4";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6AEC10EAD1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 11:38:44 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so8201165e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 04:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727350723; x=1727955523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2u4xnG6VXrNU42yzMbI9vnS8eOqn5VtGEZw53byPoWg=;
 b=bgD0XoP4AtZ17uCKi5IkT1GlHUtgwN/ISNZryRfxQg8a+prMCgyYGe90KybKFTv9iY
 pxjDjVZukj/SQ9CJaah/8H6/gggA0odeKfvnHWlURMBn6ds19drKLs+7H/FW0H4u5FNs
 wfhE+9BTz/7rBQamYJvrs2RByuMP8Fj1npz0GEUzrEGv8JTV+GYbptFoPTYROTki+0Bt
 5QVDHOG+Q9jz+ouINn9qVhldB4K45Xi3I7ezR6QTF9nz/2mqguO3Ovh9wkhEwuFkjX10
 4Gf8EoEbwqD7afXhG8pO1ZVQKM1fQJgWlv0bDnBhkyyP2nyTqwjLMo0Dgd0QNFfUKLUi
 /9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727350723; x=1727955523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2u4xnG6VXrNU42yzMbI9vnS8eOqn5VtGEZw53byPoWg=;
 b=GdsqdLsinzYPcaacOVVD55Wm9V8qLxGrWMR448ckdD2sHREquKQ3ZnHnMU7j9IZvF1
 01QANVjZ6Ip4AwLOg1wcOJz1ChxwJzFChTlni697Kb5T3Rfy1ZMb9CaOrMwlMcf8VHj/
 Jrs1MA0gV/Jl9HBg9fMWFk6KQsqDMQ1XJh94NI1qgNt4P+ORB7zfcS0QKXfJCs0lGtkW
 xGH8lBJKvBSWMHoB2mvawRJlipJ3uqubG/ZHEePC+Gp1Wc0b0qDBrJY7IjR+bbrLKzOm
 KWdz+omRpzxkAWstd0RvFnZ/h6UnPOfe8Vm19eXGDmLJFufTKmrvbjOMfZ/wdLHlrWDY
 qFDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfjHUDGXPcAQCs+g0XrdviSrMLEWbHr2xahJ12DBHl/yQciXUTGhkMr3ECwNjhBPZNaTSRE/G2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqXpWCwVL9h5aOpRqUQm/WxO1aKpOU9+eRyS2TMWlgyvmuop2j
 u3TXnko+aE1iT+2dX7mO5sDhI1Ax0xZOJ71tjg+ncjEB01BwS0LOH2PNriiF
X-Google-Smtp-Source: AGHT+IFhTYriAZlt/C9M4A+3/823QOraTx8Rxrzwz+C/YQ24CIgkN8OEfT8i+R9pRXBE2x9KW1OgPw==
X-Received: by 2002:a05:600c:c85:b0:426:5416:67e0 with SMTP id
 5b1f17b1804b1-42e9614ce9emr39079335e9.31.1727350722898; 
 Thu, 26 Sep 2024 04:38:42 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a1f2aasm44462975e9.45.2024.09.26.04.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 04:38:42 -0700 (PDT)
Message-ID: <0653d0fe-9b43-4038-a605-2f0ec9e27855@gmail.com>
Date: Thu, 26 Sep 2024 13:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/08] drm/amdgpu: screen freeze and userq driver crash
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
 <20240925195928.142001-2-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240925195928.142001-2-Arunpravin.PaneerSelvam@amd.com>
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

Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
> Screen freeze and userq fence driver crash while playing Xonotic
>
> v2: (Christian)
>      - There is change that fence might signal in between testing
>        and grabbing the lock. Hence we can move the lock above the
>        if..else check and use the dma_fence_is_signaled_locked().
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 96d1caf4c815..97b1af574407 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -185,6 +185,7 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   	struct amdgpu_userq_fence *userq_fence;
>   	struct dma_fence *fence;
> +	unsigned long flags;
>   
>   	fence_drv = userq->fence_drv;
>   	if (!fence_drv)
> @@ -232,14 +233,14 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   		userq_fence->fence_drv_array_count = 0;
>   	}
>   
> -	spin_lock(&fence_drv->fence_list_lock);
>   	/* Check if hardware has already processed the job */
> -	if (!dma_fence_is_signaled(fence))
> +	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> +	if (!dma_fence_is_signaled_locked(fence))
>   		list_add_tail(&userq_fence->link, &fence_drv->fences);
>   	else
>   		dma_fence_put(fence);
>   
> -	spin_unlock(&fence_drv->fence_list_lock);
> +	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>   
>   	*f = fence;
>   

