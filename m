Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D15ED2B92E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DA110E5C5;
	Tue,  5 Nov 2024 14:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dfMAZnCW";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF5910E5C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:32:22 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so4046605f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2024 06:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730817141; x=1731421941; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SC/qCTqU+V4S+IzfQrabuNTlSdU7sDN0O329ug4MjJY=;
 b=dfMAZnCWLI6Qntk4sYFhACOKkIdd5zUcMyzZLGWDEIrG0mi6pd/L/ot6Dkf4nhnB0P
 4Zkw3HIcNukuROYq7ndNdIp0764viCXX4uT78bLxX5VJ8ft+jz9hLHQdSPgHfjbdNGax
 OvWh9O7hO1pXrjcTjCUDtxA+N5gt2x9OygxhHEyi2A6tvob80Fm3o6YXXaeD1urj0XKr
 e/Pwa5vA8+o71p6ELEUyHAFpS2RMn8Pdr/qQzPE6f88Wr68Y1DqLxAmO9oXiIK05WCgs
 AAZ0ohlDbSSe1V98EXJL0BHr9OuNVWznF5WJ7Vp3Rig6oqMQpV2jsjAuf+t1e6z41Ks5
 h/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730817141; x=1731421941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SC/qCTqU+V4S+IzfQrabuNTlSdU7sDN0O329ug4MjJY=;
 b=nW8HdCznv9Ad5ZDYLnqfbDKrflZJeNuAvwajS+SXGQNg2DJUkZGgQdGU/+mReAO1c8
 M7rt+AkmimJOHlVKR4vsDwgf3/AluGK+5duKYOev5P48oACO2S1c9HrQ18tYRAPWsPqR
 7DlMi7l5korYLhUqD9H6qBlkt/2qgWYRyC6IfVrlJaNjw8qlAftXeMmZTJHuwJ9IOcYs
 TP/L4UtYrgVVu6F1W2ZunVY0Jc7OxZaVIm80WF3oT2LbCnkIlYctubD5I8lbCCcOhNCb
 Hl/K77Jt+OXZYZgBEI5pln8vuoOSA+QJN+bmABPnLY6OVYmAC2YXElaCaUGzQosGONDW
 7NfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3UTQzwsmfHkai6jqyNE65ORPTaEAX0NVfh8iiliU+YjY79cRT/9MOkBz4CZud+V8BOK/qcbBO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWlpaqWL6BF8C8Rm1bf47knU6GFtTkQurzAMpZUfRGeVKwbyX2
 iLpwGZ5P+xXIPbtkyYQZXI+ACDCAfxHwSouPgwum7QbJjKqoC9Zv
X-Google-Smtp-Source: AGHT+IH7nR4NOfI3GdTO+pmGM/a99B0A7l34lWXlrQKrf0X8gFeCrvdJSea8kMKt/+lkNAfXUtBIZw==
X-Received: by 2002:a5d:4d48:0:b0:37d:49d1:1e89 with SMTP id
 ffacd0b85a97d-3806115ab56mr27002932f8f.27.1730817140728; 
 Tue, 05 Nov 2024 06:32:20 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d473bsm16478427f8f.35.2024.11.05.06.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 06:32:20 -0800 (PST)
Message-ID: <1dca3ab2-cbb4-416b-a655-6eab9312c348@gmail.com>
Date: Tue, 5 Nov 2024 15:32:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix return random value when multiple threads
 read registers via mes.
To: Chong Li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, Emily.Deng@amd.com, lincao12@amd.com,
 dandjelk@amd.com, zhengyin@amd.com
References: <20241105092454.40017-1-chongli2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241105092454.40017-1-chongli2@amd.com>
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

Am 05.11.24 um 10:24 schrieb Chong Li:
> The currect code use the address "adev->mes.read_val_ptr" to
> store the value read from register via mes.
> So when multiple threads read register,
> multiple threads have to share the one address,
> and overwrite the value each other.
>
> Assign an address by "amdgpu_device_wb_get" to store register value.
> each thread will has an address to store register value.
>
> Signed-off-by: Chong Li <chongli2@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 30 +++++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ---
>   2 files changed, 13 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 83d0f731fb65..a8f7173b2663 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -189,17 +189,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   			(uint64_t *)&adev->wb.wb[adev->mes.query_status_fence_offs[i]];
>   	}
>   
> -	r = amdgpu_device_wb_get(adev, &adev->mes.read_val_offs);
> -	if (r) {
> -		dev_err(adev->dev,
> -			"(%d) read_val_offs alloc failed\n", r);
> -		goto error;
> -	}
> -	adev->mes.read_val_gpu_addr =
> -		adev->wb.gpu_addr + (adev->mes.read_val_offs * 4);
> -	adev->mes.read_val_ptr =
> -		(uint32_t *)&adev->wb.wb[adev->mes.read_val_offs];
> -
>   	r = amdgpu_mes_doorbell_init(adev);
>   	if (r)
>   		goto error;
> @@ -220,8 +209,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   			amdgpu_device_wb_free(adev,
>   				      adev->mes.query_status_fence_offs[i]);
>   	}
> -	if (adev->mes.read_val_ptr)
> -		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>   
>   	idr_destroy(&adev->mes.pasid_idr);
>   	idr_destroy(&adev->mes.gang_id_idr);
> @@ -246,8 +233,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>   			amdgpu_device_wb_free(adev,
>   				      adev->mes.query_status_fence_offs[i]);
>   	}
> -	if (adev->mes.read_val_ptr)
> -		amdgpu_device_wb_free(adev, adev->mes.read_val_offs);
>   
>   	amdgpu_mes_doorbell_free(adev);
>   
> @@ -918,10 +903,19 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
>   {
>   	struct mes_misc_op_input op_input;
>   	int r, val = 0;
> +	uint32_t addr_offset = 0;
> +	uint64_t read_val_gpu_addr;
> +	uint32_t *read_val_ptr;
>   
> +	if (amdgpu_device_wb_get(adev, &addr_offset)) {
> +		DRM_ERROR("critical bug! too many mes readers\n");
> +		goto error;
> +	}
> +	read_val_gpu_addr = adev->wb.gpu_addr + (addr_offset * 4);
> +	read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];
>   	op_input.op = MES_MISC_OP_READ_REG;
>   	op_input.read_reg.reg_offset = reg;
> -	op_input.read_reg.buffer_addr = adev->mes.read_val_gpu_addr;
> +	op_input.read_reg.buffer_addr = read_val_gpu_addr;
>   
>   	if (!adev->mes.funcs->misc_op) {
>   		DRM_ERROR("mes rreg is not supported!\n");
> @@ -932,9 +926,11 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	if (r)
>   		DRM_ERROR("failed to read reg (0x%x)\n", reg);
>   	else
> -		val = *(adev->mes.read_val_ptr);
> +		val = *(read_val_ptr);
>   
>   error:
> +	if (addr_offset)
> +		amdgpu_device_wb_free(adev, addr_offset);
>   	return val;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 45e3508f0f8e..83f45bb48427 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -119,9 +119,6 @@ struct amdgpu_mes {
>   	uint32_t			query_status_fence_offs[AMDGPU_MAX_MES_PIPES];
>   	uint64_t			query_status_fence_gpu_addr[AMDGPU_MAX_MES_PIPES];
>   	uint64_t			*query_status_fence_ptr[AMDGPU_MAX_MES_PIPES];
> -	uint32_t                        read_val_offs;
> -	uint64_t			read_val_gpu_addr;
> -	uint32_t			*read_val_ptr;
>   
>   	uint32_t			saved_flags;
>   

