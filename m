Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D99C4167B
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Dec 2023 05:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3D810E24F;
	Sun,  3 Dec 2023 05:08:18 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29A110E24F
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Dec 2023 05:08:15 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40bda47b7c1so12715105e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Dec 2023 21:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1701580094; x=1702184894; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FSw7/OXyMNoub9WY9OYs5gc6rYNUR08nZLlBmIfrS7Q=;
 b=faDxKkD6Di+KfFYDBv/cBgaxYnH9L+jrKbdsU6guxeVA9FFz6VDNAR2RXuqsj5tT6g
 8hk14D4i+SCc8EVRMMeVlnS5d9CXlngqq7wHB+lJrla+cRXMu/0rC5YTd8x7U35mehs1
 kEoAzjjlS/ZDCbRpDbDpnffdUUDNJU8EETCvEp64aCR5tV+/aRQOAGCDtwBd4or3VhvI
 vm5rK3vktW024YoGJ6QSjUsC7WjDgwQISfU+pJX2AWnMXdsp8v3FbV6xgxGc2uxfVEbi
 F5REXrfXEZ8edMXozas8kpebURsvbvIUSG8bSVJKD9UjARMQWeaV8zc1W+pKqlHkFyC5
 oVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701580094; x=1702184894;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FSw7/OXyMNoub9WY9OYs5gc6rYNUR08nZLlBmIfrS7Q=;
 b=sFwWjO3fMax6/rwvlBVLoAXi+zPkCrfCeycaCon+sWFuuiixi627XR41Rm2paJaZZc
 cem9Kbb+IKmmk/pg1xHh1s0CfUMwhXWzYC0MFrXusm3UeuUvJ6s2dXgqCsitiUr0dbFe
 0dNJ8KUk+nuYRdJisURlKZub3ErcuX0Lx5xLMdhi2C5tUFZbmp4iNZwkym7xWbJ63D4/
 xx0b/yUbSobpIluClvg/hsy8rpBS6ZzRIenExmD2pc3+i+exbMLMbykpULMAh6fmAEKR
 pcpte6XxYBcnmAZen6a9Q6WRcgSf6fDUb7NQIcArsGGaK1YShGnC/Wr5N96zp2X1S7Rq
 LS4g==
X-Gm-Message-State: AOJu0YxBTY0vGLgAY6cEPFppftpVMn/AuCXptTCO5QvDyeNb0SqDxlZ9
 5nMO92ASSnC27SWdI4qGTvagt6xp3p7s0Vbol+k=
X-Google-Smtp-Source: AGHT+IEcIviOph8IyRf4rcoJLjumeWxbFINdfDNG1mBzNHg/CQNCj4SKMoornxQQhOMigJVaoZvOag==
X-Received: by 2002:a05:600c:4d0d:b0:40b:5f03:b41b with SMTP id
 u13-20020a05600c4d0d00b0040b5f03b41bmr710006wmp.317.1701580094095; 
 Sat, 02 Dec 2023 21:08:14 -0800 (PST)
Received: from [192.168.0.89]
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 fa10-20020a05600c518a00b00405442edc69sm14190223wmb.14.2023.12.02.21.08.13
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 21:08:13 -0800 (PST)
Message-ID: <341480fc-f3cd-4e94-b4ab-4a1643b03ee4@froggi.es>
Date: Sun, 3 Dec 2023 05:08:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <20231202001740.120840-1-friedrich.vock@gmx.de>
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

Interesting!

Gamescope also uses a high priority dedicated compute queue.
I'll see if this improves things on Deck with FSR, and other (sad) times 
we have to composite.

Have you looked at how things change with gpuvis at all by the way?

- Joshie 🐸✨

On 12/2/23 00:17, Friedrich Vock wrote:
> This improves latency if the GPU is already busy with other work.
> This is useful for VR compositors that submit highly latency-sensitive
> compositing work on high-priority compute queues while the GPU is busy
> rendering the next frame.
> 
> Userspace merge request:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
> 
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  3 ++-
>   4 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9505dc8f9d69..4b923a156c4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {
>   	uint64_t eop_gpu_addr;
>   	uint32_t hqd_pipe_priority;
>   	uint32_t hqd_queue_priority;
> +	bool allow_tunneling;
>   	bool hqd_active;
>   };
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 231d49132a56..4d98e8879be8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
>   				    struct amdgpu_mqd_prop *prop)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> +	bool is_high_prio_compute = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
> +				    amdgpu_gfx_is_high_priority_compute_queue(adev, ring);
> +	bool is_high_prio_gfx = ring->funcs->type == AMDGPU_RING_TYPE_GFX &&
> +				amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);
> 
>   	memset(prop, 0, sizeof(*prop));
> 
> @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
>   	 */
>   	prop->hqd_active = ring->funcs->type == AMDGPU_RING_TYPE_KIQ;
> 
> -	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
> -	     amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) ||
> -	    (ring->funcs->type == AMDGPU_RING_TYPE_GFX &&
> -	     amdgpu_gfx_is_high_priority_graphics_queue(adev, ring))) {
> +	prop->allow_tunneling = is_high_prio_compute;
> +	if (is_high_prio_compute || is_high_prio_gfx) {
>   		prop->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_HIGH;
>   		prop->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index c8a3bf01743f..73f6d7e72c73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
>   #endif
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
> +	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> +			    prop->allow_tunneling);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>   	mqd->cp_hqd_pq_control = tmp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index c659ef0f47ce..bdcf96df69e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
>   			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
> +	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> +			    prop->allow_tunneling);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>   	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>   	mqd->cp_hqd_pq_control = tmp;
> --
> 2.43.0
> 


