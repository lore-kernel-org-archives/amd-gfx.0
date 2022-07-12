Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3DCC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 08:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914AB9331E;
	Tue, 12 Jul 2022 08:07:21 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F359331D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 08:07:20 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id sz17so12905438ejc.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Lp1UmlV/0X4/Cfb50A/s1v9suWHYjVqleTb13jQGt6U=;
 b=EWU24aeb2bzq2LxyThn/OiMIccLxFEkF2EuTdCX16NM9cQ997Wr4iNFw7B5hRftB6+
 MaG7eTp21wutKDMj0Qz9xBNZEuVAJ2PYerQZQLhFxtB+QMUE+ckt7cXMkx8g6ymq9MaF
 MSnfJbLjUwzSaOHaO9TgNaooWuCGNDbslHI3Z/+auj603OJFCYvKlGQon4+f3EK7XH4m
 efy/FDQd1JBUYHFajlPGfazioW77KR4n2jJSYaDsUn2kOtPca4cqBGFvAaPZB07peVRW
 sK+mbG6H1vNeYRFR4TWRC1MkjzhLzK37t+MqlWdiObIRClEvLmfbBcmhEhSDVA2Uaxrm
 eQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Lp1UmlV/0X4/Cfb50A/s1v9suWHYjVqleTb13jQGt6U=;
 b=Vj4zOEYt2Q2u2BULEn9DQGiCbes+pXYiPBpIo9PQa9uq+HEeSh37eOOqjO3MNldSbA
 TWGfHYTAqniV5syb3uBF1fhGE4sBVf3gHJZEgE6dW6pSZNCC02jFBqzLLDVI2n0WcBAY
 0fQ4eS58oTBajboMLqTs49x2UduRk3/+r/JSa0k7f65yCB8Llk84GvOyin+bLo5N+3fX
 Nernpl88IDyqunGJ730xEqtopufyXC7ArFXZAKScObURvKhZn8lKlHTCmjI56+qUdLZX
 ptfTUIbUheE+TT1L6dYB7HDAwhwbjKelgWBSPjg2qErpnsID63GvoPPfnebq3Bf9FK6N
 qHEw==
X-Gm-Message-State: AJIora/h0kQCf23t72+mh7DxSRM/gYmxnw+feXCqYswiJJngbGLczAXZ
 895lVY50380AmAymVWUMOVY=
X-Google-Smtp-Source: AGRyM1tbtbaZ358K6oH0d1rXZhS7xUhHCW8Aa00rgiV+gbUlyFHKO5FBsAL6ONs+gstttE4BLnFo/g==
X-Received: by 2002:a17:907:3f1d:b0:726:c927:769b with SMTP id
 hq29-20020a1709073f1d00b00726c927769bmr22440308ejc.754.1657613238898; 
 Tue, 12 Jul 2022 01:07:18 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 r9-20020a17090609c900b0072b41776dd1sm2991181eje.24.2022.07.12.01.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jul 2022 01:07:18 -0700 (PDT)
Message-ID: <4e6c8eac-d4e2-54fe-2a3d-8949ad70d696@gmail.com>
Date: Tue, 12 Jul 2022 10:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: Protect the amdgpu_bo_list list with
 a mutex
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712053924.91960-1-luben.tuikov@amd.com>
 <20220712053924.91960-2-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220712053924.91960-2-luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.07.22 um 07:39 schrieb Luben Tuikov:
> Protect the struct amdgpu_bo_list with a mutex. This is used during command
> submission in order to avoid buffer object corruption as recorded in
> the link below.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 31 +++++++++++++++++++--
>   3 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 714178f1b6c6ed..2168163aad2d38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -40,7 +40,7 @@ static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
>   {
>   	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
>   						   rhead);
> -
> +	mutex_destroy(&list->bo_list_mutex);
>   	kvfree(list);
>   }
>   
> @@ -136,6 +136,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>   
>   	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>   
> +	mutex_init(&list->bo_list_mutex);
>   	*result = list;
>   	return 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 044b41f0bfd9ce..717984d4de6858 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -48,6 +48,10 @@ struct amdgpu_bo_list {
>   	struct amdgpu_bo *oa_obj;
>   	unsigned first_userptr;
>   	unsigned num_entries;
> +
> +	/* Protect access during command submission.
> +	 */
> +	struct mutex bo_list_mutex;
>   };
>   
>   int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 36ac1f1d11e6b4..0b2932c20ec777 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -517,6 +517,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   			return r;
>   	}
>   
> +	mutex_lock(&p->bo_list->bo_list_mutex);

That lock/unlock placement is not correct and probably the reason why 
you still run into trouble with this patch.

You need to grab the lock before the call to amdgpu_bo_list_get_list() 
and drop it either after a call to ttm_eu_backoff_reservation() or 
ttm_eu_fence_buffer_objects().

If the lock is dropped anywhere in between we would have list corruption 
again.

Regards,
Christian.

> +
>   	/* One for TTM and one for the CS job */
>   	amdgpu_bo_list_for_each_entry(e, p->bo_list)
>   		e->tv.num_shared = 2;
> @@ -544,6 +546,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		if (!e->user_pages) {
>   			DRM_ERROR("kvmalloc_array failure\n");
>   			r = -ENOMEM;
> +			mutex_unlock(&p->bo_list->bo_list_mutex);
>   			goto out_free_user_pages;
>   		}
>   
> @@ -551,6 +554,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		if (r) {
>   			kvfree(e->user_pages);
>   			e->user_pages = NULL;
> +			mutex_unlock(&p->bo_list->bo_list_mutex);
>   			goto out_free_user_pages;
>   		}
>   
> @@ -568,6 +572,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	if (unlikely(r != 0)) {
>   		if (r != -ERESTARTSYS)
>   			DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
> +		mutex_unlock(&p->bo_list->bo_list_mutex);
>   		goto out_free_user_pages;
>   	}
>   
> @@ -580,11 +585,14 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   			e->chain = dma_fence_chain_alloc();
>   			if (!e->chain) {
>   				r = -ENOMEM;
> +				mutex_unlock(&p->bo_list->bo_list_mutex);
>   				goto error_validate;
>   			}
>   		}
>   	}
>   
> +	mutex_unlock(&p->bo_list->bo_list_mutex);






> +
>   	/* Move fence waiting after getting reservation lock of
>   	 * PD root. Then there is no need on a ctx mutex lock.
>   	 */
> @@ -607,6 +615,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		goto error_validate;
>   	}
>   
> +	mutex_lock(&p->bo_list->bo_list_mutex);
>   	r = amdgpu_cs_list_validate(p, &duplicates);
>   	if (r)
>   		goto error_validate;
> @@ -614,6 +623,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	r = amdgpu_cs_list_validate(p, &p->validated);
>   	if (r)
>   		goto error_validate;
> +	mutex_unlock(&p->bo_list->bo_list_mutex);
>   
>   	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>   				     p->bytes_moved_vis);
> @@ -644,15 +654,18 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   
>   error_validate:
>   	if (r) {
> +		mutex_lock(&p->bo_list->bo_list_mutex);
>   		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>   			dma_fence_chain_free(e->chain);
>   			e->chain = NULL;
>   		}
>   		ttm_eu_backoff_reservation(&p->ticket, &p->validated);
> +		mutex_unlock(&p->bo_list->bo_list_mutex);
>   	}
>   
>   out_free_user_pages:
>   	if (r) {
> +		mutex_lock(&p->bo_list->bo_list_mutex);
>   		amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>   			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>   
> @@ -662,6 +675,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   			kvfree(e->user_pages);
>   			e->user_pages = NULL;
>   		}
> +		mutex_unlock(&p->bo_list->bo_list_mutex);
>   	}
>   	return r;
>   }
> @@ -704,6 +718,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
>   	if (error && backoff) {
>   		struct amdgpu_bo_list_entry *e;
>   
> +		mutex_lock(&parser->bo_list->bo_list_mutex);
>   		amdgpu_bo_list_for_each_entry(e, parser->bo_list) {
>   			dma_fence_chain_free(e->chain);
>   			e->chain = NULL;
> @@ -711,6 +726,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
>   
>   		ttm_eu_backoff_reservation(&parser->ticket,
>   					   &parser->validated);
> +		mutex_unlock(&parser->bo_list->bo_list_mutex);
>   	}
>   
>   	for (i = 0; i < parser->num_post_deps; i++) {
> @@ -839,6 +855,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   			return r;
>   	}
>   
> +	mutex_lock(&p->bo_list->bo_list_mutex);
>   	amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>   		/* ignore duplicates */
>   		bo = ttm_to_amdgpu_bo(e->tv.bo);
> @@ -850,13 +867,18 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   			continue;
>   
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
> -		if (r)
> +		if (r) {
> +			mutex_unlock(&p->bo_list->bo_list_mutex);
>   			return r;
> +		}
>   
>   		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
> -		if (r)
> +		if (r) {
> +			mutex_unlock(&p->bo_list->bo_list_mutex);
>   			return r;
> +		}
>   	}
> +	mutex_unlock(&p->bo_list->bo_list_mutex);
>   
>   	r = amdgpu_vm_handle_moved(adev, vm);
>   	if (r)
> @@ -874,6 +896,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   
>   	if (amdgpu_vm_debug) {
>   		/* Invalidate all BOs to test for userspace bugs */
> +		mutex_lock(&p->bo_list->bo_list_mutex);
>   		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>   			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>   
> @@ -883,6 +906,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   
>   			amdgpu_vm_bo_invalidate(adev, bo, false);
>   		}
> +		mutex_unlock(&p->bo_list->bo_list_mutex);
>   	}
>   
>   	return amdgpu_cs_sync_rings(p);
> @@ -1249,6 +1273,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	 * added to BOs.
>   	 */
>   	mutex_lock(&p->adev->notifier_lock);
> +	mutex_lock(&p->bo_list->bo_list_mutex);
>   
>   	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
>   	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
> @@ -1308,12 +1333,14 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	}
>   
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> +	mutex_unlock(&p->bo_list->bo_list_mutex);
>   	mutex_unlock(&p->adev->notifier_lock);
>   
>   	return 0;
>   
>   error_abort:
>   	drm_sched_job_cleanup(&job->base);
> +	mutex_unlock(&p->bo_list->bo_list_mutex);
>   	mutex_unlock(&p->adev->notifier_lock);
>   
>   error_unlock:

