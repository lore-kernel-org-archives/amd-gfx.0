Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAFEEB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A6C10E22B;
	Mon, 26 Jun 2023 15:23:12 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAD710E229
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:23:10 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fa8692a006so26144675e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687792987; x=1690384987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oza3Bpl1rFFYaztMVsDl7jxxduL2w4HuzoJzmykDINE=;
 b=jJTw3ISb3pUzB65PL/rZ5x5cqdb7gZUbUzY7f+MoHZctuRlgalRB0pbFWIdR161GQ9
 zIR5mz5d8RW1vO34epTkuuT4XNviP6aXyTZKyVqrK4IU5kPGUhMjCp7xOT1fBWpokWE9
 Zx10PzLMZtLSAHIZz/h/KXubqhMO904XsqQk+AH6TrB1j/Gdptlf+YksLSX6b+94ZbuC
 jAWVPXBUCqlxs8pcT3J+/Vj4BP2vlyifjgM4lc/kz6eY+fe29NzTK7TpoIUiHG99hnJI
 lOaJD69n7bBqvxQMhtXswFG9VdOsQGeXgQIh25Wrw30gB/wHfyAevGVFjYEWZ9A3iXr3
 QNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687792987; x=1690384987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oza3Bpl1rFFYaztMVsDl7jxxduL2w4HuzoJzmykDINE=;
 b=QK4+FNTXNgm/Ja9e+v1xTZENOwr4pUd+TBgftc2SImJ6Ej9YFAdNVDPuGTkkF2UMYF
 Lf+ZrATaDtlWI/PxxJPL7qJiMlFUOhLLvdp5gyr5rAttMROj3K40SQnFm5A7/2bn7HsY
 Ra/pkS9mfs2OYMExf4Yl2mCjy8ZXZeEzGHfOXyMKwv7SaBpYUo/xeVfhZRFbsTCY3RUz
 kpqBllP+HYw1iVFlklNr/V7gr5DLkk6ngAyxqVigWl6v2o0pIWdXFfZiYpcFiqQz8WZm
 ub6+FYHEBuT4ykg9wrl+rqQWuG00YaJ/l11swserzXqYSb/GprltAuoZ2111exybgQv+
 5xVQ==
X-Gm-Message-State: AC+VfDzJrWxfu+NtbBltgldGsbTLl9D5yOpazEnpabgV3hWPPYyyhwSw
 0si8Rva2T+PMOHBBgNrPM0g=
X-Google-Smtp-Source: ACHHUZ532Me0Dcixu3i1Cv/wsqxdjPj2vFnh31IIh/O1oRQ117adHITHYU0S5v2V0s2dn13jbt0UoQ==
X-Received: by 2002:a7b:ce18:0:b0:3fa:7eb6:2edb with SMTP id
 m24-20020a7bce18000000b003fa7eb62edbmr6627451wmc.19.1687792986343; 
 Mon, 26 Jun 2023 08:23:06 -0700 (PDT)
Received: from ?IPV6:2a00:e180:158d:7600:862:d9d5:c1f7:84a1?
 ([2a00:e180:158d:7600:862:d9d5:c1f7:84a1])
 by smtp.gmail.com with ESMTPSA id
 o7-20020adfeac7000000b003095bd71159sm7804495wrn.7.2023.06.26.08.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 08:23:05 -0700 (PDT)
Message-ID: <8b404308-44aa-bf11-b956-39a51025ce02@gmail.com>
Date: Mon, 26 Jun 2023 17:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu:update kernel vcn ring test
Content-Language: en-US
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 veerabadhran.gopalakrishnan@amd.com, sathishkumar.sundararaju@amd.com
References: <20230626145059.2238696-1-saleemkhan.jamadar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230626145059.2238696-1-saleemkhan.jamadar@amd.com>
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
Cc: srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.06.23 um 16:50 schrieb Saleemkhan Jamadar:
> add session context buffer to decoder ring test.
>
> v2 - put the buffer at the end of the IB (Christian)
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> Acked-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 30 ++++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
>   2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2d94f1b63bd6..04daaaf6ab34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -691,7 +691,8 @@ static void amdgpu_vcn_unified_ring_ib_checksum(uint32_t **ib_checksum,
>   
>   static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   				      struct amdgpu_ib *ib_msg,
> -				      struct dma_fence **fence)
> +				      struct dma_fence **fence,
> +					  uint64_t session_ctx_buf_gaddr)

That looks like it isn't correctly indented.

>   {
>   	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
>   	unsigned int ib_size_dw = 64;
> @@ -730,6 +731,14 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>   	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
>   
> +	if (session_ctx_buf_gaddr) {
> +		decode_buffer->valid_buf_flag |=
> +					cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
> +		decode_buffer->session_context_buffer_address_hi =
> +							cpu_to_le32(session_ctx_buf_gaddr >> 32);
> +		decode_buffer->session_context_buffer_address_lo =
> +							cpu_to_le32(session_ctx_buf_gaddr);
> +	}
>   	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>   	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
>   	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
> @@ -763,20 +772,34 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
>   	struct amdgpu_ib ib;
> +	struct amdgpu_bo *session_ctx_buf = NULL;
> +	void *cpu_addr = NULL;
> +	uint64_t gpu_addr = 0;
>   	long r;
>   
> +	r = amdgpu_bo_create_kernel(ring->adev, 128*1024, PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_VRAM |
> +				    AMDGPU_GEM_DOMAIN_GTT,
> +				    &session_ctx_buf,
> +				    &gpu_addr,
> +				    &cpu_addr);

That still creates a buffer for the session ctx instead of putting it 
into the IB.

> +	if (r) {
> +		dev_err(ring->adev->dev, "VCN ib test:%ld failed to allocate session ctx bo\n", r);
> +		return r;
> +	}
> +
>   	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
> +	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL, gpu_addr);
>   	if (r)
>   		goto error;
>   	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
>   	if (r)
>   		goto error;
>   
> -	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
> +	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence, gpu_addr);
>   	if (r)
>   		goto error;
>   
> @@ -788,6 +811,7 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   	dma_fence_put(fence);
>   error:
> +	amdgpu_bo_free_kernel(&session_ctx_buf, &gpu_addr, &cpu_addr);ebd59851c796c

Which is freed here.

>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index f1397ef66fd7..06f9ee91a1e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -166,6 +166,7 @@
>   
>   #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
>   #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
> +#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
>   
>   #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
>   #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
> @@ -357,6 +358,8 @@ struct amdgpu_vcn_decode_buffer {
>   	uint32_t valid_buf_flag;
>   	uint32_t msg_buffer_address_hi;
>   	uint32_t msg_buffer_address_lo;
> +	unsigned int session_context_buffer_address_hi;
> +	unsigned int session_context_buffer_address_lo;
>   	uint32_t pad[30];

that here looks incorrect as well.

Christian.

>   };
>   

