Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25B9106703B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 14:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9703210EA25;
	Thu, 12 Mar 2026 14:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="UBJMPUv6";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECAE310EA25
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 14:32:19 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso11160005e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773325938; x=1773930738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/wjpukm7TWC0E4V2h0SKtrivAYCqfrzHlVwmQ8W2vZw=;
 b=UBJMPUv680+FzZl1fOTFiwbifr7dGqPFnJRa7HjQOrHMxkNlYcDoLKF9SuxK0+6nq7
 7Ge1P4vGpKLDtCthyexc8Tyr+wTr0ClmR9tRn+LHPvBcX7UCDuizlRvMwB8nKEfuDqiU
 f/FHce6rU3iUj9kwkC140G893CZLkRyZsd27Z/PcridaHQi9Sq6CB3/+OEiqlcS31amv
 /47GdMnj615Sbt1tWwke8k+/RJxBZtdE/oAFR60yLsSpBxg5xpGHmVt7zvatFK++KiRU
 ynMwFVKdws4a+EJP/AYVKstL+pyfM/vySC0CJxze5oImuujtkbHKLv/D+HZXrwC6tYCr
 6hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773325938; x=1773930738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/wjpukm7TWC0E4V2h0SKtrivAYCqfrzHlVwmQ8W2vZw=;
 b=IMB2tzFSD1hVcLTME1VUS4UgCnTrEHMV9I/XWU11VBwADqQK/grQ1DKnOFD9tHrbyd
 P7evLbH8y43z/p9GNSgXugZTAbZZ/VZ7KVWbQTFnhnVV7WKBg3p3Htip1/gQagLHz0v8
 aT631XlN4rurVw7bBxsRhOnUM6UzETtPn+d2RyV78RANylJqQ20VwcRo6ALPzME4p95T
 tpcakEKfip7GhCHXgVdPwtCrMOuseFwngt5F7NPC0fjYvJls+SQKDmu+KIUkzFBqxSaj
 uazG3kLV+udUv7M6qW5jaiakwqY6VKi2/JteJ8x0l8Yi1MWtIazUFPDHAY2mlScYaINY
 yJLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeTNJD3kW9W7JOjcze9zxXdQoRMvoucIwKLoGYWUv8R0+BaovgaRKJJul/0b+1nnGG8ylErn03@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8thx1uCEsWIoBb7aBDcDi3nlbvVP/l16MnQn1M4XxGtwR1UBn
 YQin36GuBmVps9QDAE0Z1VVNVtZIsCK/4Hz/pU0SMb630ye2qVcNFDqixe/8Hk1paAk=
X-Gm-Gg: ATEYQzzR+zdNHUBApod8j4q3lDgkuHx7/swLvxt4EkrD+/DolH43dMrJpkSNhAyv3Rl
 VK19EhT4BkBKLFYiaG5vuOJmiuoFyfDOaIxyjDDjEi0NwY2WhBmhG4Vd9wnIPdnsAIsH/LD2A+C
 MZI5/ZWr4bTEukKfwUrnhL3rGmqK5pyY6kCOecb8iJuqiyO0FruSOWOOKe6eAX04j1NLOApEUnT
 ewIg6tL04I0y3bnEGjgJ3Ahfixt5YSrS/8b6dXPci8A/5tiaR8llnkj1ePUNQC+VK96JXLIC6fZ
 Q/42TSS4SnJMnZEvkIL7tOYdK0PMsAmYaCGxviCaqQtsaz4aNGEgyzB0m2T0FsdBGA/CS6nS38l
 w4b9oiaOZWtIgVI+HJYix+OtIZlMdxasewwMP9VMV4VWeBpo5kU6+5HKN9J1giLtHAlnkoJ+T13
 sqgFzPFcqZU9/sfZpROLS6I1fBR2b4Pob2M2BWvleEg4kG
X-Received: by 2002:a05:600c:310b:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-4854f590efamr56065015e9.11.1773325937809; 
 Thu, 12 Mar 2026 07:32:17 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0c3a10sm45539595e9.12.2026.03.12.07.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 07:32:17 -0700 (PDT)
Message-ID: <b0a6f3b1-c11e-4b5d-ba12-a4e7564518a4@ursulin.net>
Date: Thu, 12 Mar 2026 14:32:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu: restructure VM state machine
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-2-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260310191327.2279-2-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/03/2026 19:13, Christian König wrote:
> Instead of comming up with more sophisticated names for states a VM BO

s/comming/coming/, and maybe a comma after "in" in the row below.

> can be in group them by the type of BO first and then by the state.
> 
> So we end with BO type kernel, shared_resv and individual_resv and then
> states evicted, moved and idle.
> 
> Not much functional change, except that evicted_user is moved back
> together with the other BOs again which makes the handling in
> amdgpu_vm_validate() a bit more complex. Also fixes a problem with user
> queues and amdgpu_vm_ready().

It would be good to describe the problem at least a little bit, 
especially if it was a significant reason for the patch.

> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 397 +++++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  55 ++-
>   3 files changed, 197 insertions(+), 265 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 32541f1bde6d..65783f9584c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1041,8 +1041,8 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   	int ret;
>   
>   	spin_lock(&vm->invalidated_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated,
> +	while (!list_empty(&vm->individual_resv.evicted)) {
> +		bo_va = list_first_entry(&vm->individual_resv.evicted,
>   					 struct amdgpu_bo_va,
>   					 base.vm_status);
>   		spin_unlock(&vm->invalidated_lock);
> @@ -1057,7 +1057,7 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   		if (ret)
>   			return ret;
>   
> -		/* This moves the bo_va to the done list */
> +		/* This moves the bo_va to the idle list */
>   		ret = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (ret)
>   			return ret;
> @@ -1139,7 +1139,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   
>   	key = 0;
>   	/* Validate User Ptr BOs */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +	list_for_each_entry(bo_va, &vm->individual_resv.idle, base.vm_status) {
>   		bo = bo_va->base.bo;
>   		if (!bo)
>   			continue;
> @@ -1192,7 +1192,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   	 * queues. Using the done list like that is now ok since everything is
>   	 * locked in place.
>   	 */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status)
> +	list_for_each_entry(bo_va, &vm->individual_resv.idle, base.vm_status)
>   		dma_fence_wait(bo_va->last_pt_update, false);
>   	dma_fence_wait(vm->last_update, false);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b89013a6aa0b..3ce17fe1a3b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -138,143 +138,115 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>   	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   }
>   
> -/**
> - * amdgpu_vm_bo_evicted - vm_bo is evicted
> - *
> - * @vm_bo: vm_bo which is evicted
> - *
> - * State for PDs/PTs and per VM BOs which are not at the location they should
> - * be.
> +/* Initialize the amdgpu_vm_bo_status object */
> +static void amdgpu_vm_bo_status_init(struct amdgpu_vm_bo_status *lists)
> +{
> +	INIT_LIST_HEAD(&lists->evicted);
> +	INIT_LIST_HEAD(&lists->moved);
> +	INIT_LIST_HEAD(&lists->idle);
> +}
> +
> +/*
> + * Make sure we have the lock to modify the vm_bo status and return the object
> + * with the status lists.
>    */
> -static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
> +static struct amdgpu_vm_bo_status *
> +amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
>   {
>   	struct amdgpu_vm *vm = vm_bo->vm;
>   	struct amdgpu_bo *bo = vm_bo->bo;
>   
> -	vm_bo->moved = true;
> -	amdgpu_vm_assert_locked(vm);
> -	if (bo->tbo.type == ttm_bo_type_kernel)
> -		list_move(&vm_bo->vm_status, &vm->evicted);
> -	else
> -		list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -}
> -/**
> - * amdgpu_vm_bo_moved - vm_bo is moved
> - *
> - * @vm_bo: vm_bo which is moved
> - *
> - * State for per VM BOs which are moved, but that change is not yet reflected
> - * in the page tables.
> - */
> -static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -}
> +	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		/* No extra locking needed, protected by the root PD resv lock */
> +		amdgpu_vm_assert_locked(vm);
>   
> -/**
> - * amdgpu_vm_bo_idle - vm_bo is idle
> - *
> - * @vm_bo: vm_bo which is now idle
> - *
> - * State for PDs/PTs and per VM BOs which have gone through the state machine
> - * and are now idle.
> - */
> -static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	vm_bo->moved = false;
> +		if (bo->tbo.type == ttm_bo_type_kernel)
> +			return &vm->kernel;
> +
> +		return &vm->shared_resv;
> +	}
> +
> +	spin_lock(&vm_bo->vm->invalidated_lock);
> +	return &vm->individual_resv;
>   }
>   
> -/**
> - * amdgpu_vm_bo_invalidated - vm_bo is invalidated
> - *
> - * @vm_bo: vm_bo which is now invalidated
> - *
> - * State for normal BOs which are invalidated and that change not yet reflected
> - * in the PTs.
> - */
> -static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
> +/* Eventually unlock the status list lock again */
> +static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	spin_lock(&vm_bo->vm->invalidated_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->invalidated_lock);
> +	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		spin_unlock(&vm_bo->vm->invalidated_lock);

Worth putting an assert vm is locked on the else path? Could be given 
the new API (amdgpu_vm_bo_lock_lists) is a bit odd in that for always 
valid it expects vm already locked and for other takes a different lock.

>   }
>   
>   /**
> - * amdgpu_vm_bo_evicted_user - vm_bo is evicted
> + * amdgpu_vm_bo_evicted - vm_bo is evicted
>    *
>    * @vm_bo: vm_bo which is evicted
>    *
> - * State for BOs used by user mode queues which are not at the location they
> - * should be.
> + * State for vm_bo objects meaning the underlying BO was evicted and need to
> + * move in place again.
>    */
> -static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
> +static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> +	struct amdgpu_vm_bo_status *lists;
> +
>   	vm_bo->moved = true;
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
> +	list_move(&vm_bo->vm_status, &lists->evicted);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
> -
>   /**
> - * amdgpu_vm_bo_relocated - vm_bo is reloacted
> + * amdgpu_vm_bo_moved - vm_bo is moved
>    *
> - * @vm_bo: vm_bo which is relocated
> + * @vm_bo: vm_bo which is moved
>    *
> - * State for PDs/PTs which needs to update their parent PD.
> - * For the root PD, just move to idle state.
> + * State for vm_bo objects meaning the underlying BO was moved but the new
> + * location not yet reflected in the page tables.
>    */
> -static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
> +static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	if (vm_bo->bo->parent)
> -		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -	else
> -		amdgpu_vm_bo_idle(vm_bo);
> +	struct amdgpu_vm_bo_status *lists;
> +
> +	vm_bo->moved = true;
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
> +	list_move(&vm_bo->vm_status, &lists->moved);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
>   
>   /**
> - * amdgpu_vm_bo_done - vm_bo is done
> + * amdgpu_vm_bo_idle - vm_bo is idle
>    *
> - * @vm_bo: vm_bo which is now done
> + * @vm_bo: vm_bo which is now idle
>    *
> - * State for normal BOs which are invalidated and that change has been updated
> - * in the PTs.
> + * State for vm_bo objects meaning we are done with the state machine and no
> + * further action is necessary.
>    */
> -static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
> +static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> +	struct amdgpu_vm_bo_status *lists;
> +
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
> +	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		vm_bo->moved = false;
> +	list_move(&vm_bo->vm_status, &lists->idle);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
>   
>   /**
>    * amdgpu_vm_bo_reset_state_machine - reset the vm_bo state machine
>    * @vm: the VM which state machine to reset
>    *
> - * Move all vm_bo object in the VM into a state where they will be updated
> - * again during validation.
> + * Move all vm_bo object in the VM into a state where their location will be
> + * updated in the page tables again.
>    */
>   static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   {
> -	struct amdgpu_vm_bo_base *vm_bo, *tmp;
> +	amdgpu_vm_assert_locked(vm);
> +	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
> +	list_splice_init(&vm->shared_resv.idle, &vm->shared_resv.moved);
>   
>   	spin_lock(&vm->invalidated_lock);
> -	list_splice_init(&vm->done, &vm->invalidated);
> -	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
> -		vm_bo->moved = true;
> +	list_splice_init(&vm->individual_resv.idle, &vm->individual_resv.moved);
>   	spin_unlock(&vm->invalidated_lock);
> -
> -	amdgpu_vm_assert_locked(vm);
> -	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
> -		struct amdgpu_bo *bo = vm_bo->bo;
> -
> -		vm_bo->moved = true;
> -		if (!bo || bo->tbo.type != ttm_bo_type_kernel)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -		else if (bo->parent)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -	}
>   }
>   
>   /**
> @@ -412,14 +384,16 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
>   	spin_unlock(&vm->stats_lock);
>   
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> +	if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		amdgpu_vm_bo_idle(base);

Hm on what list is it today?

>   		return;
> +	}
>   
>   	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   
>   	ttm_bo_set_bulk_move(&bo->tbo, &vm->lru_bulk_move);
>   	if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
> -		amdgpu_vm_bo_relocated(base);
> +		amdgpu_vm_bo_moved(base);
>   	else
>   		amdgpu_vm_bo_idle(base);
>   
> @@ -453,24 +427,24 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   }
>   
>   /**
> - * amdgpu_vm_lock_done_list - lock all BOs on the done list
> + * amdgpu_vm_lock_done_list - lock all BOs on the individual idle list
>    * @vm: vm providing the BOs
>    * @exec: drm execution context
>    * @num_fences: number of extra fences to reserve
>    *
> - * Lock the BOs on the done list in the DRM execution context.
> + * Lock the BOs on the individual idle list in the DRM execution context.
>    */
>   int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
>   			     unsigned int num_fences)
>   {
> -	struct list_head *prev = &vm->done;
> +	struct list_head *prev = &vm->individual_resv.idle;

Should this access be under the lock?

>   	struct amdgpu_bo_va *bo_va;
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
>   	/* We can only trust prev->next while holding the lock */
>   	spin_lock(&vm->invalidated_lock);
> -	while (!list_is_head(prev->next, &vm->done)) {
> +	while (!list_is_head(prev->next, &vm->individual_resv.idle)) {
>   		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>   
>   		bo = bo_va->base.bo;
> @@ -584,7 +558,6 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   {
>   	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>   	struct amdgpu_vm_bo_base *bo_base, *tmp;
> -	struct amdgpu_bo *bo;
>   	int r;
>   
>   	if (vm->generation != new_vm_generation) {
> @@ -596,38 +569,52 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			return r;
>   	}
>   
> -	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
> -		bo = bo_base->bo;
> -
> -		r = validate(param, bo);
> +	list_for_each_entry_safe(bo_base, tmp, &vm->kernel.evicted, vm_status) {
> +		r = validate(param, bo_base->bo);
>   		if (r)
>   			return r;
>   
> -		if (bo->tbo.type != ttm_bo_type_kernel) {
> -			amdgpu_vm_bo_moved(bo_base);
> -		} else {
> -			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
> -			amdgpu_vm_bo_relocated(bo_base);
> -		}
> +		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
>   
> -	if (ticket) {
> -		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> -					 vm_status) {
> -			bo = bo_base->bo;
> -			dma_resv_assert_held(bo->tbo.base.resv);
> +	amdgpu_vm_eviction_lock(vm);
> +	vm->evicting = false;
> +	amdgpu_vm_eviction_unlock(vm);

Is there a specific reason this block is right here and not at the end 
as today?

>   
> -			r = validate(param, bo);
> -			if (r)
> -				return r;
> +	list_for_each_entry_safe(bo_base, tmp, &vm->shared_resv.evicted,
> +				 vm_status) {
> +		r = validate(param, bo_base->bo);
> +		if (r)
> +			return r;
>   
> -			amdgpu_vm_bo_invalidated(bo_base);
> -		}
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
>   
> -	amdgpu_vm_eviction_lock(vm);
> -	vm->evicting = false;
> -	amdgpu_vm_eviction_unlock(vm);
> +	if (!ticket)
> +		return 0;
> +
> +	spin_lock(&vm->invalidated_lock);
> +	list_for_each_entry(bo_base, &vm->individual_resv.evicted, vm_status) {
> +		struct amdgpu_bo *bo = bo_base->bo;
> +
> +		if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket)
> +			continue;

What is this for?

> +
> +		spin_unlock(&vm->invalidated_lock);
> +
> +		r = validate(param, bo);
> +		if (r)
> +			return r;
> +
> +		/* need to grab the invalidated lock to trust prev here */
> +		spin_lock(&vm->invalidated_lock);
> +		tmp = list_entry(bo_base->vm_status.prev, typeof(*tmp),
> +				 vm_status);

Why is this safe? Lock was dropped while the current element was left in 
the list so anything could have happened. Even if current element was 
unlinked before dropping the lock, I don't see how it is safe to assume 
the previous element is still valid. Does it rely on dma-resve being 
held over the whole function? The current method of restarting from the 
head is certainly easier to understand.

> +		list_move(&bo_base->vm_status, &vm->individual_resv.moved);
> +		bo_base = tmp;
> +	}
> +	spin_unlock(&vm->invalidated_lock);
>   
>   	return 0;
>   }
> @@ -652,7 +639,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
>   
> -	ret &= list_empty(&vm->evicted);
> +	ret &= list_empty(&vm->kernel.evicted);
>   
>   	spin_lock(&vm->immediate.lock);
>   	ret &= !vm->immediate.stopped;
> @@ -952,7 +939,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   
>   	amdgpu_vm_assert_locked(vm);
>   
> -	if (list_empty(&vm->relocated))
> +	if (list_empty(&vm->kernel.moved))
>   		return 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -968,7 +955,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	list_for_each_entry(entry, &vm->relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
>   		/* vm_flush_needed after updating moved PDEs */
>   		flush_tlb_needed |= entry->moved;
>   
> @@ -984,9 +971,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (flush_tlb_needed)
>   		atomic64_inc(&vm->tlb_seq);
>   
> -	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
> +	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
>   		amdgpu_vm_bo_idle(entry);
> -	}
>   
>   error:
>   	drm_dev_exit(idx);
> @@ -1357,7 +1343,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		else
>   			amdgpu_vm_bo_idle(&bo_va->base);
>   	} else {
> -		amdgpu_vm_bo_done(&bo_va->base);
> +		amdgpu_vm_bo_idle(&bo_va->base);
>   	}
>   
>   	list_splice_init(&bo_va->invalids, &bo_va->valids);
> @@ -1585,7 +1571,8 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   	bool clear, unlock;
>   	int r;
>   
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> +	list_for_each_entry_safe(bo_va, tmp, &vm->shared_resv.moved,
> +				 base.vm_status) {
>   		/* Per VM BOs never need to bo cleared in the page tables */
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (r)
> @@ -1593,9 +1580,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   	}
>   
>   	spin_lock(&vm->invalidated_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
> -					 base.vm_status);
> +	while (!list_empty(&vm->individual_resv.moved)) {
> +		bo_va = list_first_entry(&vm->individual_resv.moved,
> +					 typeof(*bo_va), base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
>   		spin_unlock(&vm->invalidated_lock);
>   
> @@ -1627,7 +1614,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>   		    (!bo_va->base.bo->tbo.resource ||
>   		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
> -			amdgpu_vm_bo_evicted_user(&bo_va->base);
> +			amdgpu_vm_bo_evicted(&bo_va->base);
>   
>   		spin_lock(&vm->invalidated_lock);
>   	}
> @@ -2256,14 +2243,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>   
>   		if (bo_base->moved)
>   			continue;
> -		bo_base->moved = true;
> -
> -		if (bo->tbo.type == ttm_bo_type_kernel)
> -			amdgpu_vm_bo_relocated(bo_base);
> -		else if (amdgpu_vm_is_bo_always_valid(vm, bo))
> -			amdgpu_vm_bo_moved(bo_base);
> -		else
> -			amdgpu_vm_bo_invalidated(bo_base);
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
>   }
>   
> @@ -2554,15 +2534,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->va = RB_ROOT_CACHED;
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>   		vm->reserved_vmid[i] = NULL;
> -	INIT_LIST_HEAD(&vm->evicted);
> -	INIT_LIST_HEAD(&vm->evicted_user);
> -	INIT_LIST_HEAD(&vm->relocated);
> -	INIT_LIST_HEAD(&vm->moved);
> -	INIT_LIST_HEAD(&vm->idle);
> +
> +	amdgpu_vm_bo_status_init(&vm->kernel);
> +	amdgpu_vm_bo_status_init(&vm->shared_resv);
>   	spin_lock_init(&vm->invalidated_lock);
> -	INIT_LIST_HEAD(&vm->invalidated);
> +	amdgpu_vm_bo_status_init(&vm->individual_resv);
>   	INIT_LIST_HEAD(&vm->freed);
> -	INIT_LIST_HEAD(&vm->done);
>   	INIT_KFIFO(vm->faults);
>   	spin_lock_init(&vm->stats_lock);
>   
> @@ -3005,100 +2982,62 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   }
>   
>   #if defined(CONFIG_DEBUG_FS)
> -/**
> - * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
> - *
> - * @vm: Requested VM for printing BO info
> - * @m: debugfs file
> - *
> - * Print BO information in debugfs file for the VM
> - */
> -void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
> -{
> -	struct amdgpu_bo_va *bo_va, *tmp;
> -	u64 total_idle = 0;
> -	u64 total_evicted = 0;
> -	u64 total_relocated = 0;
> -	u64 total_moved = 0;
> -	u64 total_invalidated = 0;
> -	u64 total_done = 0;
> -	unsigned int total_idle_objs = 0;
> -	unsigned int total_evicted_objs = 0;
> -	unsigned int total_relocated_objs = 0;
> -	unsigned int total_moved_objs = 0;
> -	unsigned int total_invalidated_objs = 0;
> -	unsigned int total_done_objs = 0;
> -	unsigned int id = 0;
>   
> -	amdgpu_vm_assert_locked(vm);
> +/* print the debug info for a specific set of status lists */
> +static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
> +					     struct amdgpu_vm_bo_status *lists)
> +{
> +	struct amdgpu_vm_bo_base *base;
> +	unsigned int id;
>   
> -	seq_puts(m, "\tIdle BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_idle_objs = id;
>   	id = 0;
> -
>   	seq_puts(m, "\tEvicted BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	list_for_each_entry(base, &lists->evicted, vm_status) {
> +		if (!base->bo)
>   			continue;
> -		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_evicted_objs = id;
> -	id = 0;
>   
> -	seq_puts(m, "\tRelocated BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +		amdgpu_bo_print_info(id++, base->bo, m);

Probably just thinking out loud - given the format of the debugfs file 
is changing anyway, and that this id is both unstable cat-to-cat and 
also has no relation to the user handle which is output by the only 
other caller so could be confusing/misleading, I wonder if it is even 
worth bothering with it. For example you could pass zero and even modify 
(or not, optional) amdgpu_bo_print_info to skip it if handle is zero.

>   	}
> -	total_relocated_objs = id;
> -	id = 0;
>   
> +	id = 0;
>   	seq_puts(m, "\tMoved BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	list_for_each_entry(base, &lists->moved, vm_status) {
> +		if (!base->bo)
>   			continue;
> -		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +
> +		amdgpu_bo_print_info(id++, base->bo, m);
>   	}
> -	total_moved_objs = id;
> -	id = 0;
>   
> -	seq_puts(m, "\tInvalidated BOs:\n");
> -	spin_lock(&vm->invalidated_lock);
> -	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	id = 0;
> +	seq_puts(m, "\tIdle BOs:\n");
> +	list_for_each_entry(base, &lists->moved, vm_status) {
> +		if (!base->bo)
>   			continue;
> -		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
> +
> +		amdgpu_bo_print_info(id++, base->bo, m);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> -	total_invalidated_objs = id;
> -	id = 0;
> +}
>   
> -	seq_puts(m, "\tDone BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_done_objs = id;
> -
> -	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> -		   total_idle_objs);
> -	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
> -		   total_evicted_objs);
> -	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
> -		   total_relocated_objs);
> -	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
> -		   total_moved_objs);
> -	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
> -		   total_invalidated_objs);
> -	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
> -		   total_done_objs);
> +/**
> + * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
> + *
> + * @vm: Requested VM for printing BO info
> + * @m: debugfs file
> + *
> + * Print BO information in debugfs file for the VM
> + */
> +void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
> +{
> +	amdgpu_vm_assert_locked(vm);
> +
> +	seq_puts(m, "\tKernel PT/PDs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->kernel);
> +
> +	seq_puts(m, "\tPer VM BOs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->shared_resv);
> +
> +	seq_puts(m, "\tIndividual BOs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->individual_resv);
>   }
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index ae9449d5b00c..aa1180bf3caa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -216,6 +216,23 @@ struct amdgpu_vm_bo_base {
>   	bool				moved;
>   };
>   
> +/*
> + * The following status lists contain amdgpu_vm_bo_base objects for
> + * either PD/PTs, per VM BOs or BOs with individual resv object.
> + *
> + * The state transits are: evicted -> moved -> idle
> + */
> +struct amdgpu_vm_bo_status {
> +	/* BOs evicted which need to move into place again */
> +	struct list_head		evicted;
> +
> +	/* BOs which moved but new location hasn't been updated in the PDs/PTs */
> +	struct list_head		moved;
> +
> +	/* BOs done with the state machine and need no further action */
> +	struct list_head		idle;
> +};
> +
>   /* provided by hw blocks that can write ptes, e.g., sdma */
>   struct amdgpu_vm_pte_funcs {
>   	/* number of dw to reserve per operation */
> @@ -349,46 +366,22 @@ struct amdgpu_vm {
>   	spinlock_t		stats_lock;
>   	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>   
> -	/*
> -	 * The following lists contain amdgpu_vm_bo_base objects for either
> -	 * PDs, PTs or per VM BOs. The state transits are:
> -	 *
> -	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> -	 *
> -	 * Lists are protected by the root PD dma_resv lock.
> -	 */
> -
> -	/* Per-VM and PT BOs who needs a validation */
> -	struct list_head	evicted;
> -
> -	/* PT BOs which relocated and their parent need an update */
> -	struct list_head	relocated;
> +	/* kernel PD/Pts, resv is shared with the root PD */
> +	struct amdgpu_vm_bo_status	kernel;
>   
> -	/* per VM BOs moved, but not yet updated in the PT */
> -	struct list_head	moved;
> -
> -	/* All BOs of this VM not currently in the state machine */
> -	struct list_head	idle;
> +	/* userspace BOs where the resv object is shared with the root PD */
> +	struct amdgpu_vm_bo_status	shared_resv;
>   
>   	/*
>   	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
> -	 * have their own dma_resv object and not depend on the root PD. Their
> -	 * state transits are:
> -	 *
> -	 * evicted_user or invalidated -> done
> +	 * have their own dma_resv object and not depend on the root PD.
>   	 *
>   	 * Lists are protected by the invalidated_lock.
>   	 */
>   	spinlock_t		invalidated_lock;
>   
> -	/* BOs for user mode queues that need a validation */
> -	struct list_head	evicted_user;
> -
> -	/* regular invalidated BOs, but not yet updated in the PT */
> -	struct list_head	invalidated;
> -
> -	/* BOs which are invalidated, has been updated in the PTs */
> -	struct list_head        done;
> +	/* Userspace BOs with individual resv object */
> +	struct amdgpu_vm_bo_status	individual_resv;

Are all state transitions valid for all lists? If not it would be good 
to put that info in the respective comments.

>   
>   	/*
>   	 * This list contains amdgpu_bo_va_mapping objects which have been freed

Regards,

Tvrtko
