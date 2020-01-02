Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBFAC2D0DC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 09:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF6021655
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 09:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOyYfzdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF6021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1362B89D4D;
	Thu,  2 Jan 2020 09:16:51 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47AED89D4D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 09:16:49 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id j42so38534171wrj.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jan 2020 01:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=NI4Qv3lOeRn3ptiKFqSkvBxZ4zUV246Y7Tcr0nbBNtc=;
 b=mOyYfzddtaJSqN13xFFHXp0jPBdMbeV5cUnIW0056mE/fMJMJeJq7HQVL24vzGnT/c
 6n+9gFNJdbsnXilkMaDrKoZ+1hyYOtRfGthiz5ZmWLh4gJmSOZBDTwF7rHbMliKBY7zi
 wNf5PAWSu6e7GQi00izgYRqDqvbATd5pLii7+JSTVPGFMIEExgv0fc33elXJ4+Pf/5Qh
 Pc8Ea9K4ryiBSpVNPzgJImKmoWGOcp4L2EBKaEoC+s2y6HwJ6UHagMDb4ZUrmQWKkJgy
 03cUK4bG5MTLHLIn90lFepRWg5n6ghzsPXFhdmamFTNPJxulVsfmB70IKd/8bZs4Z/Ob
 FukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=NI4Qv3lOeRn3ptiKFqSkvBxZ4zUV246Y7Tcr0nbBNtc=;
 b=OZV8WzyEHVfAbIuXT6xbwMhaajw5ZrkXS7wdFPwZdougLVhbX7xdVufnDYM+BqKfXZ
 rm1s5FjipiPF5uS5O3dPrtHzHQyTvRLIrRzYytCUANaVmyY52VWqXKGM4GqMmLlRUUkX
 /Y6LPvcwsqxw5bJ0wmncMXkzIk0TNb7ckd5fY/giivX6rkETkAE6v7gcWZH5hHMCkxDm
 uqDQoq78miDIvG+o+dgMwEJ/hqID/AfTKbhPt4wKyytntl4i8hQelLS/gFUzm7TCjQEf
 oIGNOHXdshi9JzLO4h5fBVencKFDMGsFkNJDJJyG+oLTUGNGisZZMdISfXVORxjOz+Z8
 sf8g==
X-Gm-Message-State: APjAAAUcDYLl7Cilht/qkPWppSs49eO1FS+5+qsmOXPA5n75dL3nEtgB
 G8693/tmYKT5/BxfqQSWD3oiLkKh
X-Google-Smtp-Source: APXvYqyZyue0alSCPtPyxL+4p6dHAr+GbxqAmqQQ0JGam/MaFk0ZifPB7ndkCoi32d6kccnT1Ev4Fg==
X-Received: by 2002:a05:6000:12ce:: with SMTP id
 l14mr86470776wrx.342.1577956607696; 
 Thu, 02 Jan 2020 01:16:47 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z83sm8018063wmg.2.2020.01.02.01.16.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jan 2020 01:16:47 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/amdgpu: Avoid reclaim fs while eviction lock
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191220062442.33635-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ec87bb40-83e1-f40e-6bf3-ca128f328ddd@gmail.com>
Date: Thu, 2 Jan 2020 10:16:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191220062442.33635-1-alex.sierra@amd.com>
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

Am 20.12.19 um 07:24 schrieb Alex Sierra:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 28 +++++++++++++++++++++++++-
>   2 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b999b67ff57a..b36daa6230fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -678,9 +678,9 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		}
>   	}
>   
> -	mutex_lock(&vm->eviction_lock);
> +	vm_eviction_lock(vm);
>   	vm->evicting = false;
> -	mutex_unlock(&vm->eviction_lock);
> +	vm_eviction_unlock(vm);
>   
>   	return 0;
>   }
> @@ -1559,7 +1559,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	if (!(flags & AMDGPU_PTE_VALID))
>   		owner = AMDGPU_FENCE_OWNER_KFD;
>   
> -	mutex_lock(&vm->eviction_lock);
> +	vm_eviction_lock(vm);
>   	if (vm->evicting) {
>   		r = -EBUSY;
>   		goto error_unlock;
> @@ -1576,7 +1576,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   	r = vm->update_funcs->commit(&params, fence);
>   
>   error_unlock:
> -	mutex_unlock(&vm->eviction_lock);
> +	vm_eviction_unlock(vm);
>   	return r;
>   }
>   
> @@ -2537,18 +2537,18 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>   		return false;
>   
>   	/* Try to block ongoing updates */
> -	if (!mutex_trylock(&bo_base->vm->eviction_lock))
> +	if (!vm_eviction_trylock(bo_base->vm))
>   		return false;
>   
>   	/* Don't evict VM page tables while they are updated */
>   	if (!dma_fence_is_signaled(bo_base->vm->last_direct) ||
>   	    !dma_fence_is_signaled(bo_base->vm->last_delayed)) {
> -		mutex_unlock(&bo_base->vm->eviction_lock);
> +		vm_eviction_unlock(bo_base->vm);
>   		return false;
>   	}
>   
>   	bo_base->vm->evicting = true;
> -	mutex_unlock(&bo_base->vm->eviction_lock);
> +	vm_eviction_unlock(bo_base->vm);
>   	return true;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 100547f094ff..d35aa76469ec 100644
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
> +	unsigned int            saved_flags;
>   
>   	/* BOs who needs a validation */
>   	struct list_head	evicted;
> @@ -436,4 +440,26 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
>   
> +/* vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
> + * happens while holding this lock anywhere to prevent deadlocks when
> + * an MMU notifier runs in reclaim-FS context.
> + */
> +static inline void vm_eviction_lock(struct amdgpu_vm *vm)

Please add a proper amdgpu_ prefix to the function names.

Additional to that please don't put local static functions into the 
header, those shouldn't be used outside of the VM code.

Christian.

> +{
> +	mutex_lock(&vm->eviction_lock);
> +	vm->saved_flags = memalloc_nofs_save();
> +}
> +static inline int vm_eviction_trylock(struct amdgpu_vm *vm)
> +{
> +	if (mutex_trylock(&vm->eviction_lock)) {
> +		vm->saved_flags = memalloc_nofs_save();
> +		return 1;
> +	}
> +	return 0;
> +}
> +static inline void vm_eviction_unlock(struct amdgpu_vm *vm)
> +{
> +	memalloc_nofs_restore(vm->saved_flags);
> +	mutex_unlock(&vm->eviction_lock);
> +}
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
