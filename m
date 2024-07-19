Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B58C3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 15:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB17E10EC4B;
	Fri, 19 Jul 2024 15:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eQCNUW2z";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B1710EC4B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 15:44:21 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3684eb5be64so632300f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721403860; x=1722008660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BGFmdAEQD0QxxtgrIcKvmZExZNlNNY/U9VKGLwAfzSo=;
 b=eQCNUW2z6Ly98pHnHuv1t3oikG0VOgowPNGB0ift1v/oIjjS4kpiY3Yw9gRF5zheVl
 S47x6yLBNLW9OfXyoX++Wb6taeLvld89KHaHyejYwp2YbVwy72xxzkiWUcjpXf+YQpv8
 bCR+ohXkwmH2XzQPrl91RdbwNoWWT799f2/O5ANmH23LyBfLL1g1/oMYCbVG5Mf+Ko1G
 GjKGgDRP5HYvaA8wom5RNUR71AsLojai4PyqCBKdC8VHXxTGAngs2i1w3T4G1i6OlmO1
 ith4q48bdRFUDBVm8xDMHTM3Xd6l7lPIdOFq8I09bfSe0StB6eQBZ1dCupP5sn0Oo7La
 on7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721403860; x=1722008660;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BGFmdAEQD0QxxtgrIcKvmZExZNlNNY/U9VKGLwAfzSo=;
 b=L/xGM/4iGFbFFGiWb/JaYAjlJg/q0ptvkuQ3RE/nkVXpicdBBNuxIxj9O0UBMcrdK1
 ODawFT+6Z7j+8vS/ubC/aV40UlJtSgJtjq6/3ahvamBpaN+XKNgMeYUBGbrQTjCqgEvH
 0a4hQAqodMkAj7xVUeN5KVO5as7DMASmQyhaSil7DUF/o231vxk5QZVSAG1xi5gMxr3P
 kjkuBfkc4x8nvv4Ccw5jmYzfCZk68p0BitG37Ae3z2/d4G32raPP4YMd4gzux+ZUl5RX
 Y1qgs3OOWiQk1ZZD3EVN6Gwra3lXarCmK5IYfwbzjcSAiykbBHKRJ7jq5zm7GV25p61m
 KSPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaU0nxCfxYei0yHco+tMQTSsEEyQGcKgg+pro480I2H/dIeZvf0dmywx4FInJBLNS4e01qspSwEksmvIlGBj91Air2+CqajkoDdr8DRQ==
X-Gm-Message-State: AOJu0YzRqO5zad+Y8BBsOcrUafjpKHHhlf8CFlogRYObF8onomT1sQpl
 XNgbyaS531JqAljQ7Acc97swMuxKb5BHwKDogblUc+iQge8mVCWgTsDyrIIi
X-Google-Smtp-Source: AGHT+IHpoekabKSnIeDQa4o6YKNyMQwpWd1yiUt8C7Z0NY8W1ijT7AOS+fIBHinEFexkDjAaG8H8NQ==
X-Received: by 2002:adf:9b98:0:b0:366:e89c:342b with SMTP id
 ffacd0b85a97d-368316fac01mr4239691f8f.52.1721403859372; 
 Fri, 19 Jul 2024 08:44:19 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ced05sm1927119f8f.67.2024.07.19.08.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 08:44:19 -0700 (PDT)
Message-ID: <bfca2c44-9e40-4e04-bfcf-1285b3552707@gmail.com>
Date: Fri, 19 Jul 2024 17:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/mes: fix mes ring buffer overflow
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240719091615.1534436-1-Jack.Xiao@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240719091615.1534436-1-Jack.Xiao@amd.com>
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

Am 19.07.24 um 11:16 schrieb Jack Xiao:
> wait memory room until enough before writing mes packets
> to avoid ring buffer overflow.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 18 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 18 ++++++++++++++----
>   2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 8ce51b9236c1..68c74adf79f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -168,7 +168,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	const char *op_str, *misc_op_str;
>   	unsigned long flags;
>   	u64 status_gpu_addr;
> -	u32 status_offset;
> +	u32 seq, status_offset;
>   	u64 *status_ptr;
>   	signed long r;
>   	int ret;
> @@ -196,6 +196,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	if (r)
>   		goto error_unlock_free;
>   
> +	seq = ++ring->fence_drv.sync_seq;
> +	r = amdgpu_fence_wait_polling(ring,
> +				      seq - ring->fence_drv.num_fences_mask,
> +				      timeout);
> +	if (r < 1)
> +		goto error_undo;
> +
>   	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
>   	api_status->api_completion_fence_addr = status_gpu_addr;
>   	api_status->api_completion_fence_value = 1;
> @@ -208,8 +215,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>   	mes_status_pkt.api_status.api_completion_fence_addr =
>   		ring->fence_drv.gpu_addr;
> -	mes_status_pkt.api_status.api_completion_fence_value =
> -		++ring->fence_drv.sync_seq;
> +	mes_status_pkt.api_status.api_completion_fence_value = seq;
>   
>   	amdgpu_ring_write_multiple(ring, &mes_status_pkt,
>   				   sizeof(mes_status_pkt) / 4);
> @@ -229,7 +235,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   		dev_dbg(adev->dev, "MES msg=%d was emitted\n",
>   			x_pkt->header.opcode);
>   
> -	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
> +	r = amdgpu_fence_wait_polling(ring, seq, timeout);
>   	if (r < 1 || !*status_ptr) {
>   
>   		if (misc_op_str)
> @@ -252,6 +258,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	amdgpu_device_wb_free(adev, status_offset);
>   	return 0;
>   
> +error_undo:
> +	dev_err(adev->dev, "MES ring buffer is full.\n");
> +	amdgpu_ring_undo(ring);
> +
>   error_unlock_free:
>   	spin_unlock_irqrestore(&mes->ring_lock, flags);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index c9f74231ad59..48e01206bcc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -154,7 +154,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	const char *op_str, *misc_op_str;
>   	unsigned long flags;
>   	u64 status_gpu_addr;
> -	u32 status_offset;
> +	u32 seq, status_offset;
>   	u64 *status_ptr;
>   	signed long r;
>   	int ret;
> @@ -182,6 +182,13 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	if (r)
>   		goto error_unlock_free;
>   
> +	seq = ++ring->fence_drv.sync_seq;
> +	r = amdgpu_fence_wait_polling(ring,
> +				      seq - ring->fence_drv.num_fences_mask,

That's what's amdgpu_fence_emit_polling() does anyway.

So this here just moves the polling a bit earlier.

I think we rather need to increase the MES ring size instead.

Regards,
Christian.


> +				      timeout);
> +	if (r < 1)
> +		goto error_undo;
> +
>   	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
>   	api_status->api_completion_fence_addr = status_gpu_addr;
>   	api_status->api_completion_fence_value = 1;
> @@ -194,8 +201,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>   	mes_status_pkt.api_status.api_completion_fence_addr =
>   		ring->fence_drv.gpu_addr;
> -	mes_status_pkt.api_status.api_completion_fence_value =
> -		++ring->fence_drv.sync_seq;
> +	mes_status_pkt.api_status.api_completion_fence_value = seq;
>   
>   	amdgpu_ring_write_multiple(ring, &mes_status_pkt,
>   				   sizeof(mes_status_pkt) / 4);
> @@ -215,7 +221,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   		dev_dbg(adev->dev, "MES msg=%d was emitted\n",
>   			x_pkt->header.opcode);
>   
> -	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
> +	r = amdgpu_fence_wait_polling(ring, seq, timeout);
>   	if (r < 1 || !*status_ptr) {
>   
>   		if (misc_op_str)
> @@ -238,6 +244,10 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>   	amdgpu_device_wb_free(adev, status_offset);
>   	return 0;
>   
> +error_undo:
> +	dev_err(adev->dev, "MES ring buffer is full.\n");
> +	amdgpu_ring_undo(ring);
> +
>   error_unlock_free:
>   	spin_unlock_irqrestore(&mes->ring_lock, flags);
>   

