Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910BAC3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 08:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E112A10E49B;
	Tue, 23 Jul 2024 08:34:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DeZAmOOH";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F1E10E49B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 08:34:06 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2ef283c58f4so28357401fa.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721723645; x=1722328445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AJ2VNc2om1myjOGpQ6KrGhMJVYI0Y54L6d0Qtqmz9+4=;
 b=DeZAmOOHROfKsghYaau1BQKAsqGSMPTCFyHGn5sOjaBnSquesqgT68B29Dptb/k6rR
 z4uIidpqzrBh9IXEXDF+d6DxLGZ78+hQP+RaqoqEpRG1qy5FkTaJr2mLRLI8WSQ9oZGj
 okQMmN6C8r+hKKsb3uKYVna4DJLzr0tUDOCkQCUvZhxxZE/Shx3en7nOgei1HD/ybTIU
 0j5Ktc8nyX3fiUjIevIGGKT8wK0EGfgHPxK+jYnbIUHOZu/ov1ZAOMSG8M5yg5Ly3aYS
 08sFUhC4UaS6T5Xi3/FqbSJALcdilgM4b/CfaC2z0wn67SAXykGsRAdXFZu2yPrU7Gnk
 DtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721723645; x=1722328445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AJ2VNc2om1myjOGpQ6KrGhMJVYI0Y54L6d0Qtqmz9+4=;
 b=WFYoksyRVjvjkz8XVCn3RLwDxtS4cMqiyORF7M9R/HMpRV6EIyZes9e7GQQ3ZvTQCV
 EvBVXXNfq3w+3euE76dDEzNWW5SmhDgs0FinWNIeiCUl0y8oiUaCWXueML4IakQ9QL9g
 zCMjLwXX1W8i4ub5alZw25KbvSNJz87YnaVX6SfcLwpqbYKBplhOxG2yHSH94JCZJAdq
 pNrHuhOFnt39oZxFtcDVqOQCxow2X0j6F/t0meZgGxPGvxKpMSurYoUg/0N72ieE41Kx
 s47/Tq25L6/uRkO+4NTZDwa0IyqXqbfEcNLzENXnYFeRROM03oaBoIxc3jvSFDLEuSDy
 4L3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlL7pZGQKukP0zkyk3TrR6BjvN8b7B4gWrUh8I08hMID6xabkUjSBwl4tRqR9++MewX4FkxRYNIIy9NB87/qYDciCnoO8W0dZS+l3JUg==
X-Gm-Message-State: AOJu0Yxif9xxpIz8RKljWGHY4fxXJhE+kLhmcI9keGZ8KSPn6FKAVg3q
 qVIwkkm19iubAapAKvIAz4nON15XcvyqApRlUGGBx3Lm1VwlNGsT
X-Google-Smtp-Source: AGHT+IELOW43OX4gZY1Nnr5U0Zz1Jy5AIhYMHFNMxPUSVeyOS2CgrPcg7vM7L3jjOOGFxcL5RwxXUQ==
X-Received: by 2002:a2e:3013:0:b0:2ef:2247:987b with SMTP id
 38308e7fff4ca-2ef22479e5emr59960631fa.32.1721723644191; 
 Tue, 23 Jul 2024 01:34:04 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d9193350sm146558225e9.40.2024.07.23.01.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:34:03 -0700 (PDT)
Message-ID: <e78e5ace-9524-4dda-8d60-25bbf28a9311@gmail.com>
Date: Tue, 23 Jul 2024 10:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes: refine for maximum packet execution
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240723082737.2359410-1-Jack.Xiao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240723082737.2359410-1-Jack.Xiao@amd.com>
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

Am 23.07.24 um 10:27 schrieb Jack Xiao:
> Only allow API_NUMBER_OF_COMMAND_MAX packet in mes ring buffer,
> refine the code for maximum packet execution.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   | 2 +-
>   3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index ad49cecb20b8..dfe487521a4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -212,6 +212,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	 */
>   	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
>   		sched_hw_submission = max(sched_hw_submission, 256);
> +	else if (ring->funcs->type == AMDGPU_RING_TYPE_MES)
> +		sched_hw_submission = 32;

Yeah that looks like it makes sense.

>   	else if (ring == &adev->sdma.instance[0].page)
>   		sched_hw_submission = 256;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 68c74adf79f1..951f13e01ee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -198,7 +198,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   
>   	seq = ++ring->fence_drv.sync_seq;
>   	r = amdgpu_fence_wait_polling(ring,
> -				      seq - ring->fence_drv.num_fences_mask,
> +				      seq - (API_NUMBER_OF_COMMAND_MAX/2 - 1),

This looks a bit questionable. amdgpu_fence_wait_polling() doesn't apply 
the fence mask to the polled value.

So what happens if that overruns?

Additional to that we should really keep that logic in 
amdgpu_fence_emit_polling() and not each individual MES generation.

Regards,
Christian.

>   				      timeout);
>   	if (r < 1)
>   		goto error_undo;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 48e01206bcc4..dc65f28d1795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -184,7 +184,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   
>   	seq = ++ring->fence_drv.sync_seq;
>   	r = amdgpu_fence_wait_polling(ring,
> -				      seq - ring->fence_drv.num_fences_mask,
> +				      seq - (API_NUMBER_OF_COMMAND_MAX/2 - 1),
>   				      timeout);
>   	if (r < 1)
>   		goto error_undo;

