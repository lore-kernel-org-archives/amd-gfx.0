Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1C0C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 06:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23CD610E169;
	Thu, 30 Mar 2023 06:14:15 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4E710E169
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 06:14:12 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id h8so72239768ede.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680156851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gEhVG72Af70+VSZlfdexQyr7KjfN8HBIB1/b12oGpQs=;
 b=OZx/Zf7z5ezwPtsN/HhVXqpW/t3wDtUR/phrWcYYs92/kNNK1CQOmaFHSqZdclM/sw
 SPDq6wnS/pRCQf7dzvBCNX7gWzI6/+wBlf6llTd04+hBu2ULUh2QXdf4ZFno9sb+rnpP
 B8V+cQyuk/XpfCfj8L2KO8IhLGCLDmQ3XoMs0FC1XLNlEd2jFHwtytmd3mNqaE+3Xc2w
 i3uVMSAknM3GVwcZnXQ8x8pnmboVVIKMP6TAeYjDqx5WrF/bY3bXRgUcrpJmqzsjLhy6
 VEHYsdi86dxlhoaQyFCBZ+Hqh7yIFsvo2oxhOvTbKmq99ASEQ0+vfDLiv4ixV2wG7OfL
 uIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680156851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gEhVG72Af70+VSZlfdexQyr7KjfN8HBIB1/b12oGpQs=;
 b=qtNlG3g97hDHfikGBFWmknST34T9i5fhkRN3upw/YiSXBquCs7dxt94e0rUhp73onc
 SWObIalXyrgtYKGO/89XJdJzpzivXHVJdbSedyKRuHq+onshFBbSLNVySV1wFUJlXl7c
 +Yabf2E1CpzER2J8AUn+NSNUxM91mnG8TjqrcQl63FPnW1uAgyqOLdJr7sgVKtbO32qa
 WvJa3st8oD5XaIyn6WdfY/r1hNt9Xh0j4SZjetsjFivg7SSEwKNy+c9t4rOW3GD/pSsy
 EEcpL+7fGsEqFc2vOuvhJXNsYwcOQ8T3c/+fq8s1kZ6mX6fhDhRhxXo1mwbBpiS7PFGo
 lPJA==
X-Gm-Message-State: AAQBX9c9STPLrBNT7FuPdhZ2/nZLhOUs2O2rUSSMH3VnPZEItncdVx4K
 xI4Lf4IKVQ/aBP7LqO8MtIK2bL4PLdY=
X-Google-Smtp-Source: AKy350a/aw3ZDl97/m+9OrnN7F1nYV3J9WDCxL5E9CHD6F+bH9wqtLwtoSvW46xJCjnjRCBfFpflEw==
X-Received: by 2002:a17:907:3f97:b0:93f:505b:9742 with SMTP id
 hr23-20020a1709073f9700b0093f505b9742mr21647624ejc.65.1680156850780; 
 Wed, 29 Mar 2023 23:14:10 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a170906549000b009334d87d106sm15227647ejo.147.2023.03.29.23.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Mar 2023 23:14:10 -0700 (PDT)
Message-ID: <1fe02341-805c-7203-0e2c-40ae7eeecd86@gmail.com>
Date: Thu, 30 Mar 2023 08:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 05/13] drm/amdgpu: add gfx11 emit shadow callback
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
 <20230329152521.1980681-6-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230329152521.1980681-6-alexander.deucher@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 17:25 schrieb Alex Deucher:
> From: Christian König <christian.koenig@amd.com>
>
> Add ring callback for gfx to update the CP firmware
> with the new shadow information before we process the
> IB.
>
> v2: add implementation for new packet (Alex)
> v3: add current FW version checks (Alex)
> v4: only initialize shadow on first use
>      Only set IB_VMID when a valid shadow buffer is present
>      (Alex)
> v5: Pass parameters rather than job to new ring callback (Alex)
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/nvd.h       |  5 ++++-
>   2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 4a50d0fbcdcf..1fc1e941f7df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5598,6 +5598,29 @@ static void gfx_v11_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
>   	amdgpu_ring_write(ring, 0);
>   }
>   
> +static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
> +					   u64 shadow_va, u64 csa_va,
> +					   u64 gds_va, bool init_shadow,
> +					   int vmid)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (!adev->gfx.cp_gfx_shadow)
> +		return;
> +
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
> +	amdgpu_ring_write(ring, lower_32_bits(shadow_va));
> +	amdgpu_ring_write(ring, upper_32_bits(shadow_va));
> +	amdgpu_ring_write(ring, lower_32_bits(gds_va));
> +	amdgpu_ring_write(ring, upper_32_bits(gds_va));
> +	amdgpu_ring_write(ring, lower_32_bits(csa_va));
> +	amdgpu_ring_write(ring, upper_32_bits(csa_va));
> +	amdgpu_ring_write(ring, shadow_va ?
> +			  PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid): 0);
> +	amdgpu_ring_write(ring, init_shadow ?
> +			  PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM : 0);
> +}
> +
>   static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
>   {
>   	unsigned ret;
> @@ -6219,6 +6242,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>   	.set_wptr = gfx_v11_0_ring_set_wptr_gfx,
>   	.emit_frame_size = /* totally 242 maximum if 16 IBs */
>   		5 + /* COND_EXEC */
> +		9 + /* SET_Q_PREEMPTION_MODE */
>   		7 + /* PIPELINE_SYNC */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> @@ -6245,6 +6269,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>   	.insert_nop = amdgpu_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
> +	.emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
>   	.init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
>   	.patch_cond_exec = gfx_v11_0_ring_emit_patch_cond_exec,
>   	.preempt_ib = gfx_v11_0_ring_preempt_ib,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
> index fd6b58243b03..631dafb92299 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
> @@ -462,6 +462,9 @@
>   #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
>   #define	PACKET3_RUN_LIST				0xA5
>   #define	PACKET3_MAP_PROCESS_VM				0xA6
> -
> +/* GFX11 */
> +#define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
> +#              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
> +#              define PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM    (1 << 0)
>   
>   #endif

