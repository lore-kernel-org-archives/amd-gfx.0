Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A713C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 06:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B429A10E64E;
	Wed,  4 May 2022 06:25:42 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63EC10E5C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 06:25:41 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id g6so1004342ejw.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 May 2022 23:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=T6D/28l+uPvLErGGaz610qF6w+FJhNqdm4E9I0fGAl0=;
 b=gZiVD/5ZPc2HNCxMSfJYym37R/nXRGPRtltQ2o9Ct5lWqBnOeVp4EEBhAYyrsAG96y
 lDgDkLxr8B3wP0DjYN2cxvN0t5yjqH8z9tBgb+xyJivNxjfRne1nm8Zo2J8vjmHFoENN
 u8Jb9jCu142pFlCPE66r5prbMdal7QSqVvmMnnR68IKzPHwKVtY3FC4IuxCwCt5lvZxh
 xWmZC2mbnEmvuQgOQ7SlAbrIssXLlSayLKkGnsZYvCOamMg88XzX+k1OPRbLebYplwWZ
 UVG58Npn5YtvKFc0X65vRGtiRFlZgQXRcKTokqvxWyoE13jqJ0qa2/G/TLjlBNHM2ttE
 8S5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=T6D/28l+uPvLErGGaz610qF6w+FJhNqdm4E9I0fGAl0=;
 b=XOVIpz1JDcqFkEO5sn2Iu+Gg+IW6nOQtBJ0ogpufwAi+WqIik0ldGhTZx89LbsU1iw
 UmRrsFAQVm2JTbe3TvYorMSOZbNbiCpflsTfEEnfCBSjSnrqTQy566JEwad+IM1IVhuv
 QcO50tu2iLVLR3hsHCYUh98LWY/xk/EWo4dyfjtlPVWOvl4EJRbUGs73mBn2AO4CQmrW
 M3BPvLzhJCUT2xEslitWJxv+rJWygL9R57QquKwSIq61uo46lyRn+oUMjsenq4HaakHz
 WDvN3cZYpyOsLcxoHWr5GaIRbzC60cOOfKnvpReLNR4OaOFTmcv2/qhGkNEA9gQti3wj
 YhMw==
X-Gm-Message-State: AOAM531MN0ciSK5gfh9B/qBhVUj+xuxfvJq9OarJevvw3N5x/7iIz1AE
 Ll5rrVFsxvy/WJ0ae2zayKM=
X-Google-Smtp-Source: ABdhPJw1mIvEoIfvoeZa7VqXpN/aki6srVlLIzsrCVnhqbGpUlJ+A5zMG/3F/girhBrd28twLEU1/g==
X-Received: by 2002:a17:907:60cf:b0:6f4:5128:233b with SMTP id
 hv15-20020a17090760cf00b006f45128233bmr12685250ejc.239.1651645540204; 
 Tue, 03 May 2022 23:25:40 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b7c9.dip0.t-ipconnect.de.
 [87.176.183.201]) by smtp.gmail.com with ESMTPSA id
 gv1-20020a1709072bc100b006f3ef214dd2sm5388196ejc.56.2022.05.03.23.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 May 2022 23:25:39 -0700 (PDT)
Message-ID: <04d2af18-1d38-5a8d-b272-a68c295ca213@gmail.com>
Date: Wed, 4 May 2022 08:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu/gmc11: avoid cpu accessing registers to flush
 VM
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
 <20220503200855.1163186-17-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220503200855.1163186-17-alexander.deucher@amd.com>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 03.05.22 um 22:08 schrieb Alex Deucher:
> From: Jack Xiao <Jack.Xiao@amd.com>
>
> Due to gfxoff on, cpu accessing registers is not expected.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 51 +++++++++++++++++++++++++-
>   1 file changed, 50 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 61db2a378008..032414d7429d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -265,6 +265,12 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   					uint32_t vmhub, uint32_t flush_type)
>   {
> +	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> +	struct dma_fence *fence;
> +	struct amdgpu_job *job;
> +
> +	int r;
> +
>   	if ((vmhub == AMDGPU_GFXHUB_0) && !adev->gfx.is_poweron)
>   		return;
>   
> @@ -288,8 +294,51 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	}
>   
>   	mutex_lock(&adev->mman.gtt_window_lock);
> -	gmc_v11_0_flush_vm_hub(adev, vmid, vmhub, 0);
> +
> +	if (vmhub == AMDGPU_MMHUB_0) {
> +		gmc_v11_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB_0, 0);
> +		mutex_unlock(&adev->mman.gtt_window_lock);
> +		return;
> +	}
> +
> +	BUG_ON(vmhub != AMDGPU_GFXHUB_0);

I've already responded on the internal review that this BUG_ON is not 
justified.

We should rather change the "if (vmhub ==..." above to make sure that 
all other HUBs don't use the gfxoff workaround.

Christian.

> +
> +	if (!adev->mman.buffer_funcs_enabled ||
> +	    !adev->ib_pool_ready ||
> +	    amdgpu_in_reset(adev) ||
> +	    ring->sched.ready == false) {
> +		gmc_v11_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
> +		mutex_unlock(&adev->mman.gtt_window_lock);
> +		return;
> +	}
> +
> +	r = amdgpu_job_alloc_with_ib(adev, 16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +				     &job);
> +	if (r)
> +		goto error_alloc;
> +
> +	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
> +	job->vm_needs_flush = true;
> +	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
> +	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> +	r = amdgpu_job_submit(job, &adev->mman.entity,
> +			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
> +	if (r)
> +		goto error_submit;
> +
> +	mutex_unlock(&adev->mman.gtt_window_lock);
> +
> +	dma_fence_wait(fence, false);
> +	dma_fence_put(fence);
> +
> +	return;
> +
> +error_submit:
> +	amdgpu_job_free(job);
> +
> +error_alloc:
>   	mutex_unlock(&adev->mman.gtt_window_lock);
> +	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
>   	return;
>   }
>   

