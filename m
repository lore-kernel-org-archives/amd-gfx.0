Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011A1EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 08:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6613510E4AC;
	Thu, 15 Jun 2023 08:51:30 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD3610E4A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 08:51:27 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f8c74af64fso15400695e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686819086; x=1689411086;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aQJCXpqf8RE3VRQaDxA8HAntJG/pPG54YShpcSB511Q=;
 b=aHlOBj4IZ+xTkj0HakJ5IFZ3zfLXPUJ+kT1Cc8O/vxPkZcLOjfMYy/tdozUuzUFzbG
 5a7uFKKJXoJ5yAlgLZCzKNjSQk/TBkMonxy37ceHYV1V4qdQFR0CxPlfhfwuXFOufDO4
 mJPqjlDEKjiBYrgpObu162eF76LLRH0DjkWyZsmwqMK6iPpohteDhX86Jr5Weeqei0Fg
 bMxxQmjUtyhtMOQ4U2ahAIDjA+D/B+7f3lPxD2u6HQBizJG3ljeUQ91/PMM1iziyjTBO
 l2LZFw/F8ZrO1VOpyMg2VHyqMm7sAEaSDGzphUQU6GTMkXpGx8qH7RGApR9HaXftUh6E
 uctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686819086; x=1689411086;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQJCXpqf8RE3VRQaDxA8HAntJG/pPG54YShpcSB511Q=;
 b=SK0y7y/yQjDSGkcUs1uJiwxrMxm4z7EWy5WkjDcnYeGecpPHUfSVGvVrLueVEGliNQ
 iwheJ9di7JlgBXRmoou/SVQ6fB/nhwGqpA98gs3c7Po/CB9+EpSUfRW7WQtxpNLznafz
 o+/IUXn12LcaJLevq0DOzyNLdYctCe4jsQd8LH2GAg9+OQAuUuQW6r37vZ0Eb/S828md
 ZdXolICyK/rjibmAg6GakTircwjnHvpujJPAzWZwXmEH8KtGe5tjfHm4bN+/3hL5h+uj
 cViSPIy2zbl48D5PJqKIXFgDHOOU4PosUWWGufjftRW/atQyat4KQwkgqvKdZJgTjVN/
 7DgA==
X-Gm-Message-State: AC+VfDzxe7ro+1oetmbB4eNs8i5Z59IteIcqCAA5kbXaAj6hsKkYNrP/
 gI3U0xg8Mas9LU1EapdAERZtYwyCb10=
X-Google-Smtp-Source: ACHHUZ5eNJled77Wk88aLA9/GLqTEIS2grvWI/ImcEYFW05oUj7US2+8+UqMN14bkhWSIkcc/Sj+BA==
X-Received: by 2002:a5d:560d:0:b0:30a:ae5b:9e93 with SMTP id
 l13-20020a5d560d000000b0030aae5b9e93mr11110223wrv.11.1686819085547; 
 Thu, 15 Jun 2023 01:51:25 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1502:3e00:a4b7:5833:1db2:7e82?
 ([2a00:e180:1502:3e00:a4b7:5833:1db2:7e82])
 by smtp.gmail.com with ESMTPSA id
 cs6-20020a056000088600b0030ae849c70csm20431522wrb.37.2023.06.15.01.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 01:51:25 -0700 (PDT)
Message-ID: <40172d7d-4f42-158e-d656-826cfa25d063@gmail.com>
Date: Thu, 15 Jun 2023 10:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] drm/amdgpu/bu: Use legacy TLB flush for gfx943
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20230510175630.938276-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230510175630.938276-1-alexander.deucher@amd.com>
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
Cc: Philip Yang <Philip.Yang@amd.com>, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

All those workaround were only to be used during bringup and are not 
supposed for upstreaming.

Especially we probably don't want the module parameter to override the 
MTYPE used in the VM mappings in a release.

Christian.

Am 10.05.23 um 19:56 schrieb Alex Deucher:
> From: Graham Sider <Graham.Sider@amd.com>
>
> Invalidate TLBs via a legacy flush request (flush_type=0) prior to the
> heavyweight flush requests (flush_type=2) in gmc_v9_0.c. This is
> temporarily required to mitigate a bug causing CPC UTCL1 to return stale
> translations after invalidation requests in address range mode.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index f000e0e89bd0..d28ffdb07ae6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -833,6 +833,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		 */
>   		inv_req = gmc_v9_0_get_invalidate_req(vmid, 2);
>   		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
> +	} else if (flush_type == 2 &&
> +		   adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
> +		/* FIXME: Temporarily add a legacy flush (type 0) before heavyweight
> +		 * flush for gfx943 to mitigate a bug which causes CPC UTCL1 to return
> +		 * stale translations even after TLB heavyweight flush.
> +		 */
> +		inv_req = gmc_v9_0_get_invalidate_req(vmid, 0);
> +		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
>   	} else {
>   		inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
>   		inv_req2 = 0;
> @@ -976,6 +984,15 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   		if (vega20_xgmi_wa)
>   			kiq->pmf->kiq_invalidate_tlbs(ring,
>   						      pasid, 2, all_hub);
> +
> +		/* FIXME: Temporarily add a legacy flush (type 0) before heavyweight
> +		 * flush for gfx943 to mitigate a bug which causes CPC UTCL1 to return
> +		 * stale translations even after TLB heavyweight flush.
> +		 */
> +		if (flush_type == 2 && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
> +			kiq->pmf->kiq_invalidate_tlbs(ring,
> +						pasid, 0, all_hub);
> +
>   		kiq->pmf->kiq_invalidate_tlbs(ring,
>   					pasid, flush_type, all_hub);
>   		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);

