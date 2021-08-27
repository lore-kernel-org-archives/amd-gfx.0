Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D58C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 06:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E61C60FD8
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 06:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E61C60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6BE6E8DD;
	Fri, 27 Aug 2021 06:19:32 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB37F6E8D9;
 Fri, 27 Aug 2021 06:19:30 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id q14so8709724wrp.3;
 Thu, 26 Aug 2021 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+AguZAlrQoxj42ILnica86lsa2f+1oRMBhrtxq3bVdE=;
 b=uRrOCA5/XTQYPQMW7C6sVoTXkZGPV6OuJHaL6MoRYwu7SYQc7u8dRLt9GgbSe6lGm5
 vbjWFf48LKEPAtGxUx+Pj47gsctGWUvojNtNunr7e22zfzFiuanFVELUq+eP5+q3porU
 ZnpcfRCdoehtSOK4ebivL+xFvIHA0oN30NFo8iYKjrsGe5KjVI9J4Ajad9swl10dbI9R
 EHu9ChW++nS6HcXE1V8Xxi+xmyq4x7SxT/mjxbmXmhqjBEXS+w9mXVQhPsieWKniCp1f
 5Kc0Wwgt1y5ZvbAEUcBSVhBPtbxnZZpO7ZB0SZ0/4VvbsB7GgYiHoQHg9Ri8Lefnwjrk
 K+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+AguZAlrQoxj42ILnica86lsa2f+1oRMBhrtxq3bVdE=;
 b=FzWjcbAe/zcV6e11eACNrohMCFwd1oEHhX0Fha0yHmeEIumsCtbuTq3BTQfToslbc/
 TMCql6BXAhX4uWYZePd+tDyyShAMTJ5+09dRIHv/s071eiUthOkOlxdIMHLKYPbrhgJE
 24E7uMQI/dvyToc2hsuOh9auzUZaBhjkeKg4VxJlQUBaqAZ/t0QXZqkr9fEH/gXCwjEK
 fKqgx7Lrer3YCWGpdjBp6c87JeFV4PBxKBi5lsYDkZaQ8DFVUjNB3FBGoRa0JAl/M6jJ
 +8VxxH6u9zSwWEtXPpjMOWIAG8q6O97IFB/5sakxbqdZGV+YB16i8kl8YrqFLQPWqG5K
 PR0A==
X-Gm-Message-State: AOAM533zMj1pki//XHvUykETiqUyIGIEWzGmMdqGGnPSulVUfBdS6jhL
 ct1odG6MzE41WmNqiqtqZ88=
X-Google-Smtp-Source: ABdhPJw0ixrtqugaz1oDDlR3m90vKl4CDdxnkNykc6hhBYG4OcL9Hc2HgyUbi7wj49gCvsrSqPsdhA==
X-Received: by 2002:adf:f50a:: with SMTP id q10mr8110858wro.271.1630045169421; 
 Thu, 26 Aug 2021 23:19:29 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id b18sm5381803wrr.89.2021.08.26.23.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Aug 2021 23:19:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] drm/ttm: Create pinned list
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20210826172708.229134-1-andrey.grodzovsky@amd.com>
 <20210826172708.229134-2-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c655e76e-feaf-f1be-df8d-cf75eb3d6e02@gmail.com>
Date: Fri, 27 Aug 2021 08:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826172708.229134-2-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Am 26.08.21 um 19:27 schrieb Andrey Grodzovsky:
> This list will be used to capture all non VRAM BOs not
> on LRU so when device is hot unplugged we can iterate
> the list and unmap DMA mappings before device is removed.
>
> v2:
> Reanme function to ttm_bo_move_to_pinned
> Keep deleting BOs from LRU in the new function
> if they have no resource struct assigned to them.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c       | 30 ++++++++++++++++++++++++++----
>   drivers/gpu/drm/ttm/ttm_resource.c |  1 +
>   include/drm/ttm/ttm_resource.h     |  1 +
>   3 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 1b950b45cf4b..64594819e9e7 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -69,7 +69,29 @@ static void ttm_bo_mem_space_debug(struct ttm_buffer_object *bo,
>   	}
>   }
>   
> -static void ttm_bo_del_from_lru(struct ttm_buffer_object *bo)
> +static inline void ttm_bo_move_to_pinned_or_del(struct ttm_buffer_object *bo)
> +{
> +	struct ttm_device *bdev = bo->bdev;
> +	struct ttm_resource_manager *man = NULL;
> +
> +	if (bo->resource)
> +		man = ttm_manager_type(bdev, bo->resource->mem_type);
> +
> +	/*
> +	 * Some BOs might be in transient state where they don't belong
> +	 * to any domain at the moment, simply remove them from whatever
> +	 * LRU list they are still hanged on to keep previous functionality
> +	 */
> +	if (man && man->use_tt)
> +		list_move_tail(&bo->lru, &man->pinned);
> +	else
> +		list_del_init(&bo->lru);

Mhm, I'm wondering if we shouldn't keep the pinned list per device then.

But either way patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

Thanks,
Christian.

> +
> +	if (bdev->funcs->del_from_lru_notify)
> +		bdev->funcs->del_from_lru_notify(bo);
> +}
> +
> +static inline void ttm_bo_del_from_lru(struct ttm_buffer_object *bo)
>   {
>   	struct ttm_device *bdev = bo->bdev;
>   
> @@ -98,7 +120,7 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
>   		dma_resv_assert_held(bo->base.resv);
>   
>   	if (bo->pin_count) {
> -		ttm_bo_del_from_lru(bo);
> +		ttm_bo_move_to_pinned_or_del(bo);
>   		return;
>   	}
>   
> @@ -339,7 +361,7 @@ static int ttm_bo_cleanup_refs(struct ttm_buffer_object *bo,
>   		return ret;
>   	}
>   
> -	ttm_bo_del_from_lru(bo);
> +	ttm_bo_move_to_pinned_or_del(bo);
>   	list_del_init(&bo->ddestroy);
>   	spin_unlock(&bo->bdev->lru_lock);
>   	ttm_bo_cleanup_memtype_use(bo);
> @@ -1154,7 +1176,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
>   		return 0;
>   	}
>   
> -	ttm_bo_del_from_lru(bo);
> +	ttm_bo_move_to_pinned_or_del(bo);
>   	/* TODO: Cleanup the locking */
>   	spin_unlock(&bo->bdev->lru_lock);
>   
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 2431717376e7..91165f77fe0e 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -85,6 +85,7 @@ void ttm_resource_manager_init(struct ttm_resource_manager *man,
>   
>   	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i)
>   		INIT_LIST_HEAD(&man->lru[i]);
> +	INIT_LIST_HEAD(&man->pinned);
>   	man->move = NULL;
>   }
>   EXPORT_SYMBOL(ttm_resource_manager_init);
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index 140b6b9a8bbe..1ec0d5ebb59f 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -130,6 +130,7 @@ struct ttm_resource_manager {
>   	 */
>   
>   	struct list_head lru[TTM_MAX_BO_PRIORITY];
> +	struct list_head pinned;
>   
>   	/*
>   	 * Protected by @move_lock.

