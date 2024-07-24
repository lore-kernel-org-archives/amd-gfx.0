Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACE0C3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 07:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F58910E21C;
	Wed, 24 Jul 2024 07:34:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HkkV3BHo";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F6210E21C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 07:34:54 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-36844375001so3706500f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721806492; x=1722411292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dxPjM6PaxWuBCc/Lsahqo6jWvoiItCmt19sg7KR/DAg=;
 b=HkkV3BHoWya6gX/oKDwV1Bo2L/nSkQl/24tPL3vAY+vaH7xIP8oQSh4V2GXLbTI1XC
 R87Z14ESce5+myJuYWz/xroVEkMdyzc+ULtWdhtTkjDBy89iK68Ev+FEUaGkDbgmATmj
 sAnzWwu8qUGQamkLDlavz8KfMrSyEKFb4SB5W8JJWbAoHrLbQkUCa06MkA1VtXuCvmYQ
 3xf4KDm5RkaVnsxmTBiOSe9rQ8alZz2Eqvv/XWZ/Dlx7+bR8Y1+dAUdxkO41M5UMcRFd
 ZeMyweZfr/kWNjssjQUH5hEASC95vW05+iYBYHS0Sl2NTJZ6EwyhNYXvtQ560+P85h3r
 UFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721806492; x=1722411292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxPjM6PaxWuBCc/Lsahqo6jWvoiItCmt19sg7KR/DAg=;
 b=ef90n/gFJypkcuFg/VIDfy+E3a4Ow7xuAYMoFwkrU/3HbKRLkuf6Owx07MJbJ8E2Xo
 SXV4YPCPn0lQF+lY7CqcXhdv+iNRavOhkc3YThuKpFVL/+m6rNudSNOsOEGl4ExNaYha
 NLKe6YvTuvAFU5I8SYHsqdqp/FlSkGxGT//+wVnsEGE5KiNBseSimtCBeOetQWONvU/c
 qsTG7J7o4nWad6u97Vb0U7AkRXxA//SA8RpeQIntSz3wmnlR0zMKKv9OINYmO5EZpH7I
 k5N3Us3CF218eqqtdWsmd3BFNVlh2afp9lR+siyyahozfdXPHSaJNIx7LzGrN8eIE3zI
 aoVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwfFBxn8GMQM7+Xj4ZvLwEJmGoUVnAhStNBQC1bSU0LlRPtWrwuO68q484+lgQ4sHSaPK25u4rJnx7/vrW4yTgBiY3uzFrVBNBtclGXg==
X-Gm-Message-State: AOJu0YwXPF7+tSHl9KbkD7hbbuG0XiqAQ3j7lL6IWK+nH1jIN7P2W6ZI
 MFVnhc+sbP85bqjsNOIbfn4OprI1TV8RNg5J5j3tyvH4/hOQ41Ud
X-Google-Smtp-Source: AGHT+IHh/K4hXj1ojZ/i46iuvl6RlAE9caSkIzN2yr2eGsQpBZtQjioJE2kG6caoWKGDcigMYShxyw==
X-Received: by 2002:adf:a155:0:b0:368:6f64:3076 with SMTP id
 ffacd0b85a97d-369f5b0ec14mr784985f8f.7.1721806491881; 
 Wed, 24 Jul 2024 00:34:51 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878694ba0sm13494029f8f.61.2024.07.24.00.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 00:34:51 -0700 (PDT)
Message-ID: <e6cdf6fa-c225-46e8-8576-51d3ce61e655@gmail.com>
Date: Wed, 24 Jul 2024 09:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix Coverity explicit null dereferenced
 warnings
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
References: <20240724070655.366937-1-tim.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240724070655.366937-1-tim.huang@amd.com>
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

Am 24.07.24 um 09:06 schrieb Tim Huang:
> This is to address the Coverity explicit null dereferenced warnings
> by NULL returns from amdgpu_mes_ctx_get_offs* but without follow-up
> Checks. Meanwhile refactor the code to keep only one *_get_gpu/cpu_addr.

Well nice that you are looking into that, but the short term plan is to 
remove the in kernel MES tests again.

That should also fix the Coverity warnings. Arun already created a patch 
for that which will probably be merged in the next weeks.

Regards,
Christian.

>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 ++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 17 +++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 12 ++++++------
>   11 files changed, 55 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index e499d6ba306b..fb708b695db8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1082,7 +1082,7 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
>   		int offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>   				      compute[ring->idx].mec_hpd);
>   		ring->eop_gpu_addr =
> -			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +			amdgpu_ring_get_gpu_addr(ring, offset);
>   	}
>   
>   	switch (queue_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index ad49cecb20b8..01dd7b30ba74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -169,16 +169,6 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
>   		ring->funcs->end_use(ring);
>   }
>   
> -#define amdgpu_ring_get_gpu_addr(ring, offset)				\
> -	(ring->is_mes_queue ?						\
> -	 (ring->mes_ctx->meta_data_gpu_addr + offset) :			\
> -	 (ring->adev->wb.gpu_addr + offset * 4))
> -
> -#define amdgpu_ring_get_cpu_addr(ring, offset)				\
> -	(ring->is_mes_queue ?						\
> -	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
> -	 (&ring->adev->wb.wb[offset]))
> -
>   /**
>    * amdgpu_ring_init - init driver ring struct.
>    *
> @@ -332,8 +322,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   
>   		offset = amdgpu_mes_ctx_get_offs(ring,
>   					 AMDGPU_MES_CTX_RING_OFFS);
> -		ring->gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		ring->ring = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		ring->gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		ring->ring = amdgpu_ring_get_cpu_addr(ring, offset);
>   		amdgpu_ring_clear_ring(ring);
>   
>   	} else if (ring->ring_obj == NULL) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 582053f1cd56..f65f13d147b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -436,14 +436,15 @@ static inline void amdgpu_ring_patch_cond_exec(struct amdgpu_ring *ring,
>   	ring->ring[offset] = cur - offset;
>   }
>   
> -#define amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset)			\
> -	(ring->is_mes_queue && ring->mes_ctx ?				\
> -	 (ring->mes_ctx->meta_data_gpu_addr + offset) : 0)
> -
> -#define amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset)			\
> -	(ring->is_mes_queue && ring->mes_ctx ?				\
> -	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
> -	 NULL)
> +#define amdgpu_ring_get_gpu_addr(ring, offset)				\
> +	(ring->is_mes_queue ?						\
> +	(ring->mes_ctx->meta_data_gpu_addr + offset) :			\
> +	(ring->adev->wb.gpu_addr + offset * 4))
> +
> +#define amdgpu_ring_get_cpu_addr(ring, offset)				\
> +	(ring->is_mes_queue ?						\
> +	((void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset)) : \
> +	((void *)(&ring->adev->wb.wb[offset])))
>   
>   int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 183a976ba29d..8eca0f1733ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -80,7 +80,7 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
>   
>   		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>   				  sdma[ring->idx].sdma_meta_data);
> -		csa_mc_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		csa_mc_addr = amdgpu_ring_get_gpu_addr(ring, offset);
>   	} else {
>   		r = amdgpu_sdma_get_index_from_ring(ring, &index);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index dcef39907449..abda3fba1cba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -546,11 +546,11 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   		padding = amdgpu_mes_ctx_get_offs(ring,
>   						  AMDGPU_MES_CTX_PADDING_OFFS);
>   
> -		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		ib.ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, padding);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, padding);
>   		*cpu_ptr = cpu_to_le32(0xCAFEDEAD);
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> @@ -5895,14 +5895,14 @@ static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>   				  gfx[0].gfx_meta_data) +
>   			offsetof(struct v10_gfx_meta_data, de_payload);
>   		de_payload_gpu_addr =
> -			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +			amdgpu_ring_get_gpu_addr(ring, offset);
>   		de_payload_cpu_addr =
> -			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +			amdgpu_ring_get_cpu_addr(ring, offset);
>   
>   		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>   				  gfx[0].gds_backup) +
>   			offsetof(struct v10_gfx_meta_data, de_payload);
> -		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		gds_addr = amdgpu_ring_get_gpu_addr(ring, offset);
>   	} else {
>   		offset = offsetof(struct v10_gfx_meta_data, de_payload);
>   		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index f384be0d1800..df817b898e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -456,11 +456,11 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   		padding = amdgpu_mes_ctx_get_offs(ring,
>   						  AMDGPU_MES_CTX_PADDING_OFFS);
>   
> -		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		ib.ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, padding);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, padding);
>   		*cpu_ptr = cpu_to_le32(0xCAFEDEAD);
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2929c8972ea7..b26658414f3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5359,7 +5359,7 @@ static void gfx_v9_0_ring_patch_ce_meta(struct amdgpu_ring *ring,
>   					  gfx[0].gfx_meta_data) +
>   			offsetof(struct v9_gfx_meta_data, ce_payload);
>   		ce_payload_cpu_addr =
> -			amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
> +			amdgpu_ring_get_cpu_addr(ring, payload_offset);
>   	} else {
>   		payload_offset = offsetof(struct v9_gfx_meta_data, ce_payload);
>   		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
> @@ -5391,7 +5391,7 @@ static void gfx_v9_0_ring_patch_de_meta(struct amdgpu_ring *ring,
>   					  gfx[0].gfx_meta_data) +
>   			offsetof(struct v9_gfx_meta_data, de_payload);
>   		de_payload_cpu_addr =
> -			amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
> +			amdgpu_ring_get_cpu_addr(ring, payload_offset);
>   	} else {
>   		payload_offset = offsetof(struct v9_gfx_meta_data, de_payload);
>   		de_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
> @@ -5590,9 +5590,9 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
>   				  gfx[0].gfx_meta_data) +
>   			offsetof(struct v9_gfx_meta_data, ce_payload);
>   		ce_payload_gpu_addr =
> -			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +			amdgpu_ring_get_gpu_addr(ring, offset);
>   		ce_payload_cpu_addr =
> -			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +			amdgpu_ring_get_cpu_addr(ring, offset);
>   	} else {
>   		offset = offsetof(struct v9_gfx_meta_data, ce_payload);
>   		ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> @@ -5688,14 +5688,14 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume, bo
>   				  gfx[0].gfx_meta_data) +
>   			offsetof(struct v9_gfx_meta_data, de_payload);
>   		de_payload_gpu_addr =
> -			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +			amdgpu_ring_get_gpu_addr(ring, offset);
>   		de_payload_cpu_addr =
> -			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +			amdgpu_ring_get_cpu_addr(ring, offset);
>   
>   		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
>   				  gfx[0].gds_backup) +
>   			offsetof(struct v9_gfx_meta_data, de_payload);
> -		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		gds_addr = amdgpu_ring_get_gpu_addr(ring, offset);
>   	} else {
>   		offset = offsetof(struct v9_gfx_meta_data, de_payload);
>   		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index b7d33d78bce0..533b1d9964b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -982,8 +982,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
>   		uint32_t offset = 0;
>   		offset = amdgpu_mes_ctx_get_offs(ring,
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> @@ -1060,13 +1060,13 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	if (ring->is_mes_queue) {
>   		uint32_t offset = 0;
>   		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
> -		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		ib.ptr = (void *)amdgpu_ring_get_cpu_addr(ring, offset);
>   
>   		offset = amdgpu_mes_ctx_get_offs(ring,
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 630b03f2ce3d..e94f52e34489 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -871,8 +871,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
>   		uint32_t offset = 0;
>   		offset = amdgpu_mes_ctx_get_offs(ring,
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> @@ -949,13 +949,13 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	if (ring->is_mes_queue) {
>   		uint32_t offset = 0;
>   		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
> -		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   
>   		offset = amdgpu_mes_ctx_get_offs(ring,
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index dab4c2db8c9d..e29260d5b694 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -845,8 +845,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>   		uint32_t offset = 0;
>   		offset = amdgpu_mes_ctx_get_offs(ring,
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> @@ -923,13 +923,13 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	if (ring->is_mes_queue) {
>   		uint32_t offset = 0;
>   		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
> -		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   
>   		offset = amdgpu_mes_ctx_get_offs(ring,
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 41b5e45697dc..efd3c9bdb7c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -857,8 +857,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>   		uint32_t offset = 0;
>   		offset = amdgpu_mes_ctx_get_offs(ring,
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> @@ -935,13 +935,13 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	if (ring->is_mes_queue) {
>   		uint32_t offset = 0;
>   		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
> -		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   
>   		offset = amdgpu_mes_ctx_get_offs(ring,
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
> -		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
> +		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);

