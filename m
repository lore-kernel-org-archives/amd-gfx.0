Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3087EECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 09:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DDC510E8CD;
	Wed, 14 Sep 2022 09:11:42 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1165610E8CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 09:11:39 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id u9so33257918ejy.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=GaKBvurBtkFAvgTy5DylJhTS9B+HwHGUNv1Vam+5hHM=;
 b=atTwtDBy25Qb6c2Vf0J7PTq5+TMPrMAg2vX3Jka8EmUFVMTUzQMvkTcEsANIKaldeB
 oJ0FzQZZssxH/YLaUJTy118gQAC3/6HXAQr4PntsK7TUP02NDDqyHTY469Kxuhn1Kca5
 ds+a0BhzYRw4b8nb3DTiIaJIRg0JmIQ2v60aOR+0RXbfrOzqYDmDWgbd1ToMkMYEdifJ
 1BChA9YPyJbK3SNBFYpW6nFMoSBvv4oye/NZfYChv2ogxnkhk/+vPKv6qnYEZ0Ntzi4y
 5Um9WPUy5Q6bqRjLOlvksjAbl+No6bHBRd4l09ttwmThtDuOQB7JXmfM9sOY5FkPc7Rs
 bPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=GaKBvurBtkFAvgTy5DylJhTS9B+HwHGUNv1Vam+5hHM=;
 b=51InC277atVsXDiamtM5YO0UB8wDJLDaNj/zAGlDDpI75yeVX+sYdYn1fdZbfT2Sa0
 tdlVKppISDGbYnDCeWqJ2rEZURYxvXbee+WR9HtouvZB5wVAONvTEqUARnAOMh0Gcdeq
 seR7/Q4fIuJU416M6NEV5dZqkAD/F6jVsfnuN0O/Qj8o7PKPPEYcHA5t7i0Dd/lBd6WW
 ve2XG9K96la7lk6MgmGq6Ib60ZqeONuNFGSHLWfWDqL/xycDn7oh0ABh1nE7CQ/IHO/9
 wSYya6m1+MiarHbaAefLTWy1i5AWlZPl49kvOoN1kytrtsXNrUpDB9xhLoQiaTG5SLpg
 Xa9A==
X-Gm-Message-State: ACgBeo19buYWlCxYl9Arm3eY16WXCQIHaULRUeCLBwY66mmgtYSw5bp1
 G88vjIlvKAmk9ymMsZY3LqqsFVErZBw=
X-Google-Smtp-Source: AA6agR443P81uZzBk+iNsQKw6CyNuRzfiIvd++bmFM5qxJfce26luxAM232bysZmd/lzNGsmd6vX2A==
X-Received: by 2002:a17:906:ef8c:b0:77c:8f77:330 with SMTP id
 ze12-20020a170906ef8c00b0077c8f770330mr10984630ejb.604.1663146697598; 
 Wed, 14 Sep 2022 02:11:37 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:158e:603b:8394:aba3?
 ([2a02:908:1256:79a0:158e:603b:8394:aba3])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a508dca000000b0044bfdbd8a33sm9320637edh.88.2022.09.14.02.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Sep 2022 02:11:37 -0700 (PDT)
Message-ID: <fb5fd947-1384-08c6-229c-4adb0636fc56@gmail.com>
Date: Wed, 14 Sep 2022 11:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/2] drm/amdgpu: SDMA update use unlocked iterator
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220913200507.8849-1-Philip.Yang@amd.com>
 <20220913200507.8849-2-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220913200507.8849-2-Philip.Yang@amd.com>
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
Cc: felix.kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.09.22 um 22:05 schrieb Philip Yang:
> SDMA update page table may be called from unlocked context, this
> generate below warning. Use unlocked iterator to handle this case.
>
> WARNING: CPU: 0 PID: 1475 at
> drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
> Call Trace:
>   dma_resv_iter_first+0x43/0xa0
>   amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
>   amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
>   amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
>   svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
>   svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
>   __mmu_notifier_invalidate_range_start+0x1d3/0x230
>   unmap_vmas+0x140/0x150
>   unmap_region+0xa8/0x110
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 1fd3cbca20a2..718db7d98e5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -211,12 +211,15 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>   	int r;
>   
>   	/* Wait for PD/PT moves to be completed */
> -	dma_resv_for_each_fence(&cursor, bo->tbo.base.resv,
> -				DMA_RESV_USAGE_KERNEL, fence) {
> +	dma_resv_iter_begin(&cursor, bo->tbo.base.resv, DMA_RESV_USAGE_KERNEL);
> +	dma_resv_for_each_fence_unlocked(&cursor, fence) {
>   		r = amdgpu_sync_fence(&p->job->sync, fence);
> -		if (r)
> +		if (r) {
> +			dma_resv_iter_end(&cursor);
>   			return r;
> +		}
>   	}
> +	dma_resv_iter_end(&cursor);
>   
>   	do {
>   		ndw = p->num_dw_left;

