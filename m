Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B051BC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 03:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A557E10FDEE;
	Tue, 12 Jul 2022 03:22:45 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2AB89DAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 03:22:44 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-10c0d96953fso9018751fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:reply-to:from:in-reply-to:content-transfer-encoding;
 bh=PiwK9Nmh7rlUuN2rxi+dTGIvGoAmQHvMnrKoTi4RSRM=;
 b=PCR3nqMKVKAd+hMIeZ4nwbA/zbCe4nSP+M4o35yonNvm39YqSmIFfspt6ao9hejJWL
 h3uKcGUENGjlbHhKq9Qk/QIe9CvJRNp4aY7QulHNpcxRR0aSUPZoOiVlwnqawNpFFQ8E
 h0GVpEKkFKN4jM9F/vjF//ozOeIPHgDeZf6NqLdHsueEZALgkrGLgcZCv3q5zYrIbF1U
 wAuNZceEl/gc0khvHXQ5rPCttWoP8Ov58FXEAZxDwvpZFFSwUyip1C4PL6OOZo18IlEI
 atPCLLxtkuRn+OVOEuiS0LmJeuZkekQ4eqlDWIxjr/Sy8UZxwltkkVnaBb6rFu+qrWBe
 8jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:reply-to:from:in-reply-to
 :content-transfer-encoding;
 bh=PiwK9Nmh7rlUuN2rxi+dTGIvGoAmQHvMnrKoTi4RSRM=;
 b=qnMVILwou+3Z9SbZ/R4EjR8B8JFSnWgrgwhXb17EBXKcONe3LdAo85yh3o2meSbMJr
 xAtwarmEsNnxXPKF2PvdesodRaXJYUzJE0eHisudPtJKIvsFE4zwyIrCCvyY6Hugxm8J
 kVSnotKhQ1mG5rfBYaTe7WlcXqBUIZQz5XJcJ3Iemf9u6PFOLjEr35UAYJkljqXSNBp+
 hhTOLsKzdrpGGfSaTgvxOCJy+hPuU0ljENXVobqndbYUwxk7Bdqzdkx/Yqw4lNgJfJps
 l5Ljn75HFgkmXSyqaE1tCwbpy6nqgshuAXCMvWns5sCUz51Zs1LQLvHwJjGZqChmLE16
 4sUw==
X-Gm-Message-State: AJIora8ZZe1oND30BsduHXiXg9XUQyNUHufVWwSYmCQ1SiWFcDYuoC4h
 DL/APymUamz9cAeFj7LShTE=
X-Google-Smtp-Source: AGRyM1vakXKu/0aZOYqosYNqO4xABTq3FKFtXy8+6QOGcauFn2kTvKSm6GCh2mVl4qrPKCfYCbjoVA==
X-Received: by 2002:a05:6870:311b:b0:10c:b18e:9f17 with SMTP id
 v27-20020a056870311b00b0010cb18e9f17mr778064oaa.30.1657596163275; 
 Mon, 11 Jul 2022 20:22:43 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c2:8202::1000? ([2804:14c:4c2:8202::1000])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a056870524900b00101c9597c6fsm4023908oai.28.2022.07.11.20.22.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jul 2022 20:22:42 -0700 (PDT)
Message-ID: <62a6f649-5026-49a0-a574-1e73d63bdd67@gmail.com>
Date: Tue, 12 Jul 2022 00:22:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Revert "drm/amdgpu: remove ctx->lock"
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>
References: <62d06aef-ff23-93a3-dc36-c4840b1f6d80@amd.com>
 <20220621144227.664800-1-luben.tuikov@amd.com>
From: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
In-Reply-To: <20220621144227.664800-1-luben.tuikov@amd.com>
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
Reply-To: 20220621144227.664800-1-luben.tuikov@amd.com
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, siqueirajordao@riseup.net,
 magalilemes00@gmail.com, =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
 amd-gfx@lists.freedesktop.org, Melissa Wen <melissa.srw@gmail.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>,
 =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Trevor Woerner <twoerner@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 21/06/2022 11:42, Luben Tuikov wrote:
> This reverts commit e68efb27647f2106d6b545667f35b2ea39746b57.
> 
> We see that the bo validate list gets corrupted, in
> amdgpu_cs_list_validate(), the lobj->tv.bo is NULL. Then getting usermm on
> the next line, references a NULL bo and we get a koops.
> 
> Bisecting leads to the commit being reverted as the cause of the list
> corruption. See the link below for details of the corruption failure.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048#note_1427539
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 16 +++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   3 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 36ac1f1d11e6b4..e619031753b927 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -128,6 +128,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   		goto free_chunk;
>   	}
>   
> +	mutex_lock(&p->ctx->lock);
> +
>   	/* skip guilty context job */
>   	if (atomic_read(&p->ctx->guilty) == 1) {
>   		ret = -ECANCELED;
> @@ -585,16 +587,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		}
>   	}
>   
> -	/* Move fence waiting after getting reservation lock of
> -	 * PD root. Then there is no need on a ctx mutex lock.
> -	 */
> -	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
> -	if (unlikely(r != 0)) {
> -		if (r != -ERESTARTSYS)
> -			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> -		goto error_validate;
> -	}
> -
>   	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
>   					  &p->bytes_moved_vis_threshold);
>   	p->bytes_moved = 0;
> @@ -722,6 +714,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
>   	dma_fence_put(parser->fence);
>   
>   	if (parser->ctx) {
> +		mutex_unlock(&parser->ctx->lock);
>   		amdgpu_ctx_put(parser->ctx);
>   	}
>   	if (parser->bo_list)
> @@ -965,7 +958,7 @@ static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
>   	if (parser->job->uf_addr && ring->funcs->no_user_fence)
>   		return -EINVAL;
>   
> -	return 0;
> +	return amdgpu_ctx_wait_prev_fence(parser->ctx, parser->entity);
>   }
>   
>   static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
> @@ -1384,6 +1377,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		goto out;
>   
>   	r = amdgpu_cs_submit(&parser, cs);
> +
>   out:
>   	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 53f9268366f29e..2ef5296216d64d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -286,6 +286,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
>   	kref_init(&ctx->refcount);
>   	ctx->mgr = mgr;
>   	spin_lock_init(&ctx->ring_lock);
> +	mutex_init(&ctx->lock);
>   
>   	ctx->reset_counter = atomic_read(&mgr->adev->gpu_reset_counter);
>   	ctx->reset_counter_query = ctx->reset_counter;
> @@ -400,6 +401,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
>   		drm_dev_exit(idx);
>   	}
>   
> +	mutex_destroy(&ctx->lock);
>   	kfree(ctx);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 0fa0e56daf67e9..cc7c8afff4144c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -53,6 +53,7 @@ struct amdgpu_ctx {
>   	bool				preamble_presented;
>   	int32_t				init_priority;
>   	int32_t				override_priority;
> +	struct mutex			lock;
>   	atomic_t			guilty;
>   	unsigned long			ras_counter_ce;
>   	unsigned long			ras_counter_ue;
> 
> base-commit: f4b3c543a2a759ce657de4b6b7e88eaddee85ec2

Hello,

Applied on amd-staging-drm-next (with two additional commits from 
torvalds/master to allow me to compile using GCC12: 52a9dab6, 82880283) 
and tested with IGT using a RX580*; the errors on the "amd_cs_nop" tests 
are gone!

* Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 
470/480/570/570X/580/580X/590] (rev e7)

The remaining IGT tests matching ".*amdgpu.*" were not affected. (FYI, 
amdgpu/amd_plane, amdgpu/amd_bypass, amdgpu/amd_plane, 
amdgpu/amd_vrr_range are failing in here, some should skip instead, but 
that's another thread to come)

Tested-by: Tales Aparecida <tales.aparecida@gmail.com>

Thanks for your time,
Tales
