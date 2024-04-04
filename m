Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DF6CD1292
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Apr 2024 12:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB1811B559;
	Thu,  4 Apr 2024 12:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GTNyoXko";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FFB11B55B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Apr 2024 12:24:23 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4162b016168so3140895e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Apr 2024 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712233462; x=1712838262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6NUUcCBkcnAtc1lWPTQckN+3e9ii76gEGMskvvjoWxo=;
 b=GTNyoXko1yKXtE5kT3WwwNY8UEJ0Wsav0AZtriJgppk/RSvhRxCtSZufSVx5T0IUGL
 a3/8nrjLUXo+T32nmUAhnW4R0RY4d01f8FfNtKSNgKeTrT9Wgdhrid8acH3Fe1/EJFAr
 OlSR30RMhL6aT1seZNbbikpnVXjGy9zU8TgQ36k1Q1u2h2zqr7Sm6wRX/nfZk0MSpjPt
 ow+xjqfcFVgBkJ9FeDqIqH7lg9wMtmQGsY4X7iC/gmz6rR2xZBT7Zb0pD7QMwT5xd2Ot
 fvFe4vUTwWJdaHPDfQnmx7CLr/y0GHhwe44QmUgGJKKFTwdY9MEzePWVeAdLN8/xv7hz
 a76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233462; x=1712838262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6NUUcCBkcnAtc1lWPTQckN+3e9ii76gEGMskvvjoWxo=;
 b=TPqDc7mLUYNYDhGRfgoP5muNIpHhdCJ4a+t0TvQdEhvp+hLaSlDzxLJVfPQQgoGzdW
 X4lG4GX/oFwumgjoW0nFVG1elcuF6ZZBjAPhOnjx7wuVNYWZ4cLwGgF9+BTSgGe46xWd
 wgO31aXDxSWPPjgrZDxxjWT1/5bf40KVUv0q8IvS0AbjzRscxUbJEn4/bx6CqSAz04Co
 QkHKLJF+OH+mkyeU7JTvLl/cGbtJvw743wilaP93veIMOM5g14IQBQY9mBiYzJrVLZNh
 26okC4LoNYU40Gpwa2mDILei3w+uR0eFwop835WYUiGvgaddu/6UvFPr355WqUzvKfDH
 g1NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9E0Y2ON9iTSmXBqLjCfkd18GrxPJRHIw2wTn+c6LG4A/ob+5d5FcLgTCJHRF9wkb2nPPibfx47O4fUERPa3oInvjOvtyQgV6HTcObSg==
X-Gm-Message-State: AOJu0YyZAOTb7UebA4EKae4YJnVRxyklBBCLfurBJW08kmQnHEaDIe6w
 o7RUWCfDwffStmqmKyqd/n+e+tKOwfl3f/0sqc/ko4JFWBfXTgIC
X-Google-Smtp-Source: AGHT+IFOvlsh/57edwEixzd51rjdRZ/NfBTnwUw2I9cf2ryJqKgH3nSQ3kwbv7vnf/2ldKeedR1jvQ==
X-Received: by 2002:a05:600c:4592:b0:416:1b17:ba4 with SMTP id
 r18-20020a05600c459200b004161b170ba4mr4779187wmo.16.1712233462085; 
 Thu, 04 Apr 2024 05:24:22 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a05600c35d200b004157ff88ad7sm2554919wmq.7.2024.04.04.05.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 05:24:21 -0700 (PDT)
Message-ID: <fa982b65-40b9-4a12-80da-701ffd4ae9d8@gmail.com>
Date: Thu, 4 Apr 2024 14:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the ring buffer size for queue VM flush
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240326082147.1694774-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240326082147.1694774-1-Prike.Liang@amd.com>
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

Am 26.03.24 um 09:21 schrieb Prike Liang:
> Here are the corrections needed for the queue ring buffer size
> calculation for the following cases:
> - Remove the KIQ VM flush ring usage.
> - Add the invalidate TLBs packet for gfx10 and gfx11 queue.
> - There's no VM flush and PFP sync, so remove the gfx9 real
>    ring and compute ring buffer usage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Good catch, that was probably just copied over from the gfx implementation.

When the function isn't used with the compute rings any more you can 
probably also remove this from gfx_v9_0_ring_emit_vm_flush():

         /* compute doesn't have PFP */
         if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {

With or without that the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 5 -----
>   3 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index d524f1a353ed..0c7312c0fa7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9186,7 +9186,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>   		7 + /* PIPELINE_SYNC */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> -		2 + /* VM_FLUSH */
> +		4 + /* VM_FLUSH */
>   		8 + /* FENCE for VM_FLUSH */
>   		20 + /* GDS switch */
>   		4 + /* double SWITCH_BUFFER,
> @@ -9276,7 +9276,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>   		7 + /* gfx_v10_0_ring_emit_pipeline_sync */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> -		2 + /* gfx_v10_0_ring_emit_vm_flush */
>   		8 + 8 + 8, /* gfx_v10_0_ring_emit_fence_kiq x3 for user fence, vm fence */
>   	.emit_ib_size =	7, /* gfx_v10_0_ring_emit_ib_compute */
>   	.emit_ib = gfx_v10_0_ring_emit_ib_compute,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 7a906318e451..5390dd2c51da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6191,7 +6191,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>   		7 + /* PIPELINE_SYNC */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> -		2 + /* VM_FLUSH */
> +		4 + /* VM_FLUSH */
>   		8 + /* FENCE for VM_FLUSH */
>   		20 + /* GDS switch */
>   		5 + /* COND_EXEC */
> @@ -6277,7 +6277,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
>   		7 + /* gfx_v11_0_ring_emit_pipeline_sync */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> -		2 + /* gfx_v11_0_ring_emit_vm_flush */
>   		8 + 8 + 8, /* gfx_v11_0_ring_emit_fence_kiq x3 for user fence, vm fence */
>   	.emit_ib_size =	7, /* gfx_v11_0_ring_emit_ib_compute */
>   	.emit_ib = gfx_v11_0_ring_emit_ib_compute,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 71b555993b7a..fce0b8238d13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -6872,7 +6872,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   		7 +  /* PIPELINE_SYNC */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> -		2 + /* VM_FLUSH */
>   		8 +  /* FENCE for VM_FLUSH */
>   		20 + /* GDS switch */
>   		4 + /* double SWITCH_BUFFER,
> @@ -6892,7 +6891,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
>   	.emit_fence = gfx_v9_0_ring_emit_fence,
>   	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
> -	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
>   	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
>   	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
>   	.test_ring = gfx_v9_0_ring_test_ring,
> @@ -6981,7 +6979,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>   		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> -		2 + /* gfx_v9_0_ring_emit_vm_flush */
>   		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
>   		7 + /* gfx_v9_0_emit_mem_sync */
>   		5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
> @@ -6990,7 +6987,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>   	.emit_ib = gfx_v9_0_ring_emit_ib_compute,
>   	.emit_fence = gfx_v9_0_ring_emit_fence,
>   	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
> -	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
>   	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
>   	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
>   	.test_ring = gfx_v9_0_ring_test_ring,
> @@ -7019,7 +7015,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
>   		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> -		2 + /* gfx_v9_0_ring_emit_vm_flush */
>   		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
>   	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
>   	.emit_fence = gfx_v9_0_ring_emit_fence_kiq,

