Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51927C33CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 11:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C85D2072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 11:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhmuTWFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C85D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB0A96E9CA;
	Fri, 10 Jan 2020 11:29:05 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57C86E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 11:29:04 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id u2so1595132wmc.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 03:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=v5xgcOZEPDefZujhGIWwTuhStb0hY5FAma1f/zNjm+s=;
 b=fhmuTWFQDwwalb02axADAww6k3DdwSucZwVEqUt6/MjD0+xncp4O3SKtxYo7opYwPr
 R3A+LhjckC5VgQMLrzTwQl57XjSXZ0zEbxdPfG/UAnIgM481wOJyrIplKM11e4tBMRa+
 QUuDC50EvEpDrI3E/knn+njoTSiwuZNC8WYKASPtOHSIMmJm7PqvL/ceV8b+feqkOaI4
 6IlKcXFu9rpPDUbRyHb/uJew6w/klPq36+171/iec/8lM0D26VhAhdItQIJyxSirpJIZ
 imCYcq/8PW49XaK2cxRB/XIBRkV4mb5wYTY2CoBpcjJ/1b7DHgSytv1iPw9WmzoafMjM
 O9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=v5xgcOZEPDefZujhGIWwTuhStb0hY5FAma1f/zNjm+s=;
 b=ggk7rgL665FVKfqSkzEEYn6Y3Zfn+LArdqETRDEsbYYgfUmNZ7y0L48lQu6Ob7fBv5
 sdAzypZA/cWpZIXhwIBnMjB6XQbf3A9vPqx3lDoK+kbbg9cpSIR7q9XqYsdMTDV+j47W
 99VksZ9/egc5RHSKwt6yBWo5uNM37uTQ0h8GIOn5XsaAFUJ4YQUBT5v2OvTGUrJqW6mi
 wI8LIWl6hFkb1MdsqkhvWFIl5umE6JjtNBS8kiDkfSsJSD89lW//BYeqRTK/G5zCx/NO
 zKUzefuLLGS9fVHbImb+J2FFM6EmPMUXakWoVu7TXGK+dRlVTLnmpmRZwgTVZhvPIQwe
 2uVA==
X-Gm-Message-State: APjAAAX1ZmAOSGmsSHOPdZU5a81r3NbLYRCSW1HTbKI5B8qIQA453413
 rtDpLxpGYuki7UkV6F4NKOwh3qsb
X-Google-Smtp-Source: APXvYqzpodGRr1gbqcQKf7L+bpU14KuBVIQyeyjYErzFn6go1udJOYcLUoJnRmLoQyz5FUpTTV8kDQ==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr3724421wml.3.1578655743228;
 Fri, 10 Jan 2020 03:29:03 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id n8sm1868955wrx.42.2020.01.10.03.29.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jan 2020 03:29:02 -0800 (PST)
Subject: Re: [PATCH 1/8] drm/amdgpu: Avoid reclaim fs while eviction lock
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200110004335.113095-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6eadf115-8ed0-22bd-9de9-b036c772e08c@gmail.com>
Date: Fri, 10 Jan 2020 12:29:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200110004335.113095-1-alex.sierra@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like you send that patch set out twice.

Which one is the most recent one?

Regards,
Christian.

Am 10.01.20 um 01:43 schrieb Alex Sierra:
> [Why]
> Avoid reclaim filesystem while eviction lock is held called from
> MMU notifier.
>
> [How]
> Setting PF_MEMALLOC_NOFS flags while eviction mutex is locked.
> Using memalloc_nofs_save / memalloc_nofs_restore API.
>
> Change-Id: I5531c9337836e7d4a430df3f16dcc82888e8018c
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 40 +++++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  6 +++-
>   2 files changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b999b67ff57a..d6aba4f9df74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -82,6 +82,32 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>   
> +/**
> + * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
> + * happens while holding this lock anywhere to prevent deadlocks when
> + * an MMU notifier runs in reclaim-FS context.
> + */
> +static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> +{
> +	mutex_lock(&vm->eviction_lock);
> +	vm->saved_flags = memalloc_nofs_save();
> +}
> +
> +static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
> +{
> +	if (mutex_trylock(&vm->eviction_lock)) {
> +		vm->saved_flags = memalloc_nofs_save();
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> +{
> +	memalloc_nofs_restore(vm->saved_flags);
> +	mutex_unlock(&vm->eviction_lock);
> +}
> +
>   /**
>    * amdgpu_vm_level_shift - return the addr shift for each level
>    *
> @@ -678,9 +704,9 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		}
>   	}
>   
> -	mutex_lock(&vm->eviction_lock);
> +	amdgpu_vm_eviction_lock(vm);
>   	vm->evicting = false;
> -	mutex_unlock(&vm->eviction_lock);
> +	amdgpu_vm_eviction_unlock(vm);
>   
>   	return 0;
>   }
> @@ -1559,7 +1585,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	if (!(flags & AMDGPU_PTE_VALID))
>   		owner = AMDGPU_FENCE_OWNER_KFD;
>   
> -	mutex_lock(&vm->eviction_lock);
> +	amdgpu_vm_eviction_lock(vm);
>   	if (vm->evicting) {
>   		r = -EBUSY;
>   		goto error_unlock;
> @@ -1576,7 +1602,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	r = vm->update_funcs->commit(&params, fence);
>   
>   error_unlock:
> -	mutex_unlock(&vm->eviction_lock);
> +	amdgpu_vm_eviction_unlock(vm);
>   	return r;
>   }
>   
> @@ -2537,18 +2563,18 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>   		return false;
>   
>   	/* Try to block ongoing updates */
> -	if (!mutex_trylock(&bo_base->vm->eviction_lock))
> +	if (!amdgpu_vm_eviction_trylock(bo_base->vm))
>   		return false;
>   
>   	/* Don't evict VM page tables while they are updated */
>   	if (!dma_fence_is_signaled(bo_base->vm->last_direct) ||
>   	    !dma_fence_is_signaled(bo_base->vm->last_delayed)) {
> -		mutex_unlock(&bo_base->vm->eviction_lock);
> +		amdgpu_vm_eviction_unlock(bo_base->vm);
>   		return false;
>   	}
>   
>   	bo_base->vm->evicting = true;
> -	mutex_unlock(&bo_base->vm->eviction_lock);
> +	amdgpu_vm_eviction_unlock(bo_base->vm);
>   	return true;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 100547f094ff..c21a36bebc0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -30,6 +30,7 @@
>   #include <drm/gpu_scheduler.h>
>   #include <drm/drm_file.h>
>   #include <drm/ttm/ttm_bo_driver.h>
> +#include <linux/sched/mm.h>
>   
>   #include "amdgpu_sync.h"
>   #include "amdgpu_ring.h"
> @@ -242,9 +243,12 @@ struct amdgpu_vm {
>   	/* tree of virtual addresses mapped */
>   	struct rb_root_cached	va;
>   
> -	/* Lock to prevent eviction while we are updating page tables */
> +	/* Lock to prevent eviction while we are updating page tables
> +	 * use vm_eviction_lock/unlock(vm)
> +	 */
>   	struct mutex		eviction_lock;
>   	bool			evicting;
> +	unsigned int		saved_flags;
>   
>   	/* BOs who needs a validation */
>   	struct list_head	evicted;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
