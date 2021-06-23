Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF098C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 12:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE33600D3
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 12:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE33600D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6696E8D6;
	Wed, 23 Jun 2021 12:50:59 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74276E8D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 12:50:58 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id n20so3291894edv.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pzOq/itbvN2zuhnrQnCZ7e8DUAtW8s36yGBj5pwCSOY=;
 b=eknuo3wtzO8BZM3Tb+Mo8rbErwCTPVq+3Z7WC9m6XxtuvtdwzoVuwwb+SKa+O8BiHa
 mQNXwxv7NueSIcoD7+tD9v+FWCkZFtKYShUkTMweuwSfClX9+v+GE9UmnzFEylrqdiPX
 B2e068aNt2CMFxCIF93Ju4amMSusig7xwEjE/3U1wvC4E5DXIva0MDdsbnF4di+keLCk
 uTY59LHo8S131DlFoOewPWio3WgC6noocOSGFCaEpyozA4LwSItrzWP3HdYTTQnL1v5X
 /pmL4UzO4kuIS4JRTeuJsYPm1QJrEichQW8FivblSjgVhdk2/tiiMaI9RTnlH0Eq1ptU
 BOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pzOq/itbvN2zuhnrQnCZ7e8DUAtW8s36yGBj5pwCSOY=;
 b=DkixFnUe/KCiUZ+V1PWgMIwrLdpHvSikTW4Inl7jKRrxXspU9nQa94yA05ZQX3c8y3
 UYCw4pu/8fHpxPCVZQ5oSQhxUFPGrHOAAlUXWj9sgnEbkoC5MbuCQCidjQm/Kv6ilWBv
 UiVIgfdL3viZOarceMzxieWK3kn5a5EC2PIv8y2uowfNAAcmOpV3ZbxRe9jmEHIOXgV1
 0gd27mvduCqY7rGeP5qYwpig+rIW9sgLVpgduV41HmVe1m/5dj1w7z+gm7DVD6goaPlV
 e8oUpY3UkHVlHhbokvlf71l9+R4xWlk4R8q7Gw7kp8nyKudpnTDES5YDjQaovK+1x0oU
 HWuQ==
X-Gm-Message-State: AOAM530kPvJp6oEuKANFV+y/cWRRzfS79LcuUf6EyjPNzFCEi5BpKHoE
 Xp28dDytEKKdLRaumvrkSNo=
X-Google-Smtp-Source: ABdhPJzAv8v++LejnYm3I+kWdsvTEGIDa9Hajjr6neaGdKhcixr6EwuslcHpOdHgeV5V45TUSsI+pg==
X-Received: by 2002:a05:6402:42cb:: with SMTP id
 i11mr11951085edc.242.1624452657313; 
 Wed, 23 Jun 2021 05:50:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:871f:87e2:f394:e667?
 ([2a02:908:1252:fb60:871f:87e2:f394:e667])
 by smtp.gmail.com with ESMTPSA id jl21sm5628099ejc.42.2021.06.23.05.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jun 2021 05:50:56 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: use xarray for storing pasid in vm
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210623122506.7397-1-nirmoy.das@amd.com>
 <20210623122506.7397-2-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f0c5f68f-8e54-c302-8f4a-b68f3898f391@gmail.com>
Date: Wed, 23 Jun 2021 14:50:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623122506.7397-2-nirmoy.das@amd.com>
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 23.06.21 um 14:25 schrieb Nirmoy Das:
> Replace idr with xarray as we actually need hash functionality.
> Cleanup code related to vm pasid by adding helper function.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 134 +++++++++++--------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   3 +-
>   2 files changed, 60 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index be841d62a1d4..e047e56a4be2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -87,6 +87,39 @@ struct amdgpu_prt_cb {
>   	struct dma_fence_cb cb;
>   };
>   
> +static int amdgpu_vm_set_pasid(struct amdgpu_device *adev,
> +			       struct amdgpu_vm *vm,
> +			       unsigned long pasid)

Some kerneldoc please describing why we have that function.

> +{
> +	unsigned long flags;
> +	int r;
> +
> +	if (pasid) {

You should probably reorder the code so that the old pasid is first 
removed and then eventually the new one added.

> +		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +		r = xa_err(__xa_store(&adev->vm_manager.pasids, pasid, vm,
> +				      GFP_ATOMIC));
> +		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);

As far as I can see this can just use xa_store() which also drops the 
need for GFP_ATOMIC here.

> +		if (r < 0)
> +			return r;
> +	} else {
> +		unsigned long index;
> +		struct amdgpu_vm *res;
> +
> +		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +		xa_for_each(&adev->vm_manager.pasids, index, res) {
> +			if (res == vm) {
> +				__xa_erase(&adev->vm_manager.pasids, index);
> +				break;
> +			}
> +		}
> +		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);

That is really ugly, why is that necessary?

Christian

> +	}
> +
> +	vm->pasid = pasid;
> +
> +	return 0;
> +}
> +
>   /*
>    * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
>    * happens while holding this lock anywhere to prevent deadlocks when
> @@ -2940,18 +2973,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
>   
>   	amdgpu_bo_unreserve(vm->root.bo);
>   
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		if (r < 0)
> -			goto error_free_root;
> -
> -		vm->pasid = pasid;
> -	}
> +	r = amdgpu_vm_set_pasid(adev, vm, pasid);
> +	if (r)
> +		goto error_free_root;
>   
>   	INIT_KFIFO(vm->faults);
>   
> @@ -3039,18 +3063,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto unreserve_bo;
>   
> -	if (pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
> -			      GFP_ATOMIC);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -
> -		if (r == -ENOSPC)
> -			goto unreserve_bo;
> -		r = 0;
> -	}
> +	/* remove previous {pasid:vm} entry first */
> +	r = amdgpu_vm_set_pasid(adev, vm, 0);
> +	r = amdgpu_vm_set_pasid(adev, vm, pasid);
> +	if (r)
> +		goto unreserve_bo;
>   
>   	/* Check if PD needs to be reinitialized and do it before
>   	 * changing any other state, in case it fails.
> @@ -3061,7 +3078,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   				       to_amdgpu_bo_vm(vm->root.bo),
>   				       false);
>   		if (r)
> -			goto free_idr;
> +			goto free_pasid_entry;
>   	}
>   
>   	/* Update VM state */
> @@ -3078,7 +3095,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		r = amdgpu_bo_sync_wait(vm->root.bo,
>   					AMDGPU_FENCE_OWNER_UNDEFINED, true);
>   		if (r)
> -			goto free_idr;
> +			goto free_pasid_entry;
>   
>   		vm->update_funcs = &amdgpu_vm_cpu_funcs;
>   	} else {
> @@ -3088,31 +3105,14 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->last_update = NULL;
>   	vm->is_compute_context = true;
>   
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		vm->pasid = 0;
> -	}
> -
>   	/* Free the shadow bo for compute VM */
>   	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
>   
> -	if (pasid)
> -		vm->pasid = pasid;
> -
>   	goto unreserve_bo;
>   
> -free_idr:
> -	if (pasid) {
> -		unsigned long flags;
> +free_pasid_entry:
> +	amdgpu_vm_set_pasid(adev, vm, 0);
>   
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
>   unreserve_bo:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   	return r;
> @@ -3128,14 +3128,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    */
>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   {
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -	}
> -	vm->pasid = 0;
> +	amdgpu_vm_set_pasid(adev, vm, 0);
>   	vm->is_compute_context = false;
>   }
>   
> @@ -3159,15 +3152,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
> -	if (vm->pasid) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> -		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> -		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> -		vm->pasid = 0;
> -	}
> -
> +	amdgpu_vm_set_pasid(adev, vm, 0);
>   	dma_fence_wait(vm->last_unlocked, false);
>   	dma_fence_put(vm->last_unlocked);
>   
> @@ -3249,8 +3234,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   	adev->vm_manager.vm_update_mode = 0;
>   #endif
>   
> -	idr_init(&adev->vm_manager.pasid_idr);
> -	spin_lock_init(&adev->vm_manager.pasid_lock);
> +	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
>   }
>   
>   /**
> @@ -3262,8 +3246,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>   {
> -	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
> -	idr_destroy(&adev->vm_manager.pasid_idr);
> +	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
> +	xa_destroy(&adev->vm_manager.pasids);
>   
>   	amdgpu_vmid_mgr_fini(adev);
>   }
> @@ -3332,13 +3316,13 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>   	struct amdgpu_vm *vm;
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>   
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm)
>   		*task_info = vm->task_info;
>   
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>   }
>   
>   /**
> @@ -3380,15 +3364,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   	struct amdgpu_vm *vm;
>   	int r;
>   
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm) {
>   		root = amdgpu_bo_ref(vm->root.bo);
>   		is_compute_context = vm->is_compute_context;
>   	} else {
>   		root = NULL;
>   	}
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>   
>   	if (!root)
>   		return false;
> @@ -3406,11 +3390,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		goto error_unref;
>   
>   	/* Double check that the VM still exists */
> -	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
> -	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>   	if (vm && vm->root.bo != root)
>   		vm = NULL;
> -	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>   	if (!vm)
>   		goto error_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ddb85a85cbba..31c467764162 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -359,8 +359,7 @@ struct amdgpu_vm_manager {
>   	/* PASID to VM mapping, will be used in interrupt context to
>   	 * look up VM of a page fault
>   	 */
> -	struct idr				pasid_idr;
> -	spinlock_t				pasid_lock;
> +	struct xarray				pasids;
>   };
>   
>   struct amdgpu_bo_va_mapping;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
