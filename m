Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0475BCD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 23:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3516010E181;
	Mon, 25 May 2026 23:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gbg6Uj+R";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C1CA10E181
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 23:29:58 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so9703504f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779751797; x=1780356597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pofAKsPoQ7FPs9w7p9x1Q6YTYwhLa+xiG2ALfS82yA=;
 b=Gbg6Uj+Rs1ZntJLzTakMEpORcCpZu25vT+PeVldlQM3GpZE3LuueEV1dbg9P3aQBRE
 BWKHBJdgnORqjxRDCFWAK+z34iWQ2Uf5U0yE9iTYzdVJQdrpkdCiytCgBy/HA8bY5kom
 hJdESPc6U7QqY+/Jg8cqBgjt6IFdqZ+b1gdKQPHviZn5/Wa72Lkjxto1Ye3Aal+PBee/
 n2bUPNu4gjLbvUGN2+erVpfm/1m7n35pixurH4OagWtTCqw2XrlUbaHh3foq//ADGqFA
 UqupV9cwJZ3lrvWegoCh2q8BKh0UAMiphv2/5JXL1O6vFnxITu/QvYIYzW7wI12c6l8X
 0GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779751797; x=1780356597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6pofAKsPoQ7FPs9w7p9x1Q6YTYwhLa+xiG2ALfS82yA=;
 b=PE0PACRg0Hd3+pMX5Yt5m3EqZxbTq9kgX1J8Ff6uWXXYhFgMpF7XBA6g/b4R9XuF3L
 r0MEKlp1JFWMgXTc59aPhTBn8MrNjYrZnIvfAdo7yxyI8L51qIpTTJVydLwTXXpdoOCD
 /j2hjZW3GXR2cxN8u3i/lwG5OZp93uMvK5dHHJ6/PIjMmN5xNnKlmFlwCyzZrqmajqSk
 /Lf5gRrt5X6nA70qbeFQUVPgREkMx0SVVS+vJkDmNVSX6pHc1DThCoXAvqxuF/+AtiH6
 4RZfCeFH20a33LDniwkf4GPQ+fGT33wvzHyowfQtpwIJhhvl4+865YcK1aconszGFxfy
 CkNA==
X-Gm-Message-State: AOJu0YyVWSmPj2yIeZ98Y8BD2MzQOMDxWkb0TAYUuB1syhB9r0LfGT/B
 ly0DqoyYqH9nAGCKlQV2YPOYEJ8Tv5inPExIIotG6PFp4sBrQw84sA9A
X-Gm-Gg: Acq92OEqPxFKJnG+apAvC1i5Db10XAsXdZFOwsrUEJcXhQkjmNNoEDmlGF2jvylrRDg
 9tzqRBaLas35TEVzi8n8Xea0ODLgN3kjcnRVDcgqKV8aYrDFRyoGc17TUvXLLKRsRvCUmd8q6lg
 dqqWJxplGWvxBhj2XrbGtrJOMM5NKubnPICgUf/V258cdefPwLACPbjnJMtZPK86Z+eZvBbkiMn
 rTynW92AZ0k7OyuzrW5gHtgKxcbCkyG6dVd1bIxsfEHjPIHhRuMHp1WUeHow3MDE5Oai1m+E0sK
 v6k/XcU1T42XLry6BuaFe1fsTasJfnlG6QYbTaImtK9weVxN9AukSA88clDJPW0BwikwGfY2ytH
 9xVou1LSzRUH+xG2c3KjXiCxpB7pnp68XPXzhi7J48DxvTSeBjh1DoWT1LipJ++IKHeuh54kCrh
 nGBPaw1TZtdKpppujqWeUO2l+TFD6zPisNfcT+TYxDY8Er8Jw2kcV4lWD0zfB/ZNlS6xrTusAaq
 6VVqwP68HA2ekRzdNrNPNjhTpiwrQ==
X-Received: by 2002:a05:6000:2003:b0:45e:b311:3d74 with SMTP id
 ffacd0b85a97d-45eb36acd1bmr26856147f8f.22.1779751796339; 
 Mon, 25 May 2026 16:29:56 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5e484sm29528945f8f.30.2026.05.25.16.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 16:29:55 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Vock Natalie <natalie.vock@gmx.de>
Subject: Re: [PATCH 8/8] drm/amdgpu: restructure VM state machine v2
Date: Tue, 26 May 2026 01:29:54 +0200
Message-ID: <2840173.vuYhMxLoTh@timur-max>
In-Reply-To: <20260427182723.1715-8-christian.koenig@amd.com>
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-8-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. =C3=A1prilis 27., h=C3=A9tf=C5=91 20:27:23 k=C3=B6z=C3=A9p-eur=C3=
=B3pai ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> Instead of coming up with more sophisticated names for states a VM BO
> can be in, group them by the type of BO first and then by the state.
>=20
> So we end with BO type kernel, always_valid and individual and then states
> evicted, moved and idle.
>=20
> Not much functional change, except that evicted_user is moved back
> together with the other BOs again which makes the handling in
> amdgpu_vm_validate() a bit more complex.
>=20
> Also fixes a problem with user queues and amdgpu_vm_ready(). We didn't
> considered the VM ready when user BOs were not ideally placed, harmless
> performance impact for kernel queues but a complete show stopper for
> userqueues.
>=20
> v2: fix a few typos in comments, rename the BO types to make them more
>     descriptive, fix a couple of bugs found during testing
> v3: squashed together with revert to old status lock handling, looks
>     like the first patch still had some bug which this one here should fi=
x.
>     Fix a missing lock around debugfs printing.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Hi Christian,

This patch regresses GPU recovery.
(Tested on SI, haven't had time to test other GPUs yet.)

It hits the following warning:
WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:635 at amdgpu_vm_pde_upd=
ate
And then this error:
[drm:amdgpu_gem_va_update_vm [amdgpu]] *ERROR* Couldn't update BO_VA (-22)

Please fix.

Thanks & best regards,
Timur

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  65 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 534 +++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  69 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>  4 files changed, 298 insertions(+), 374 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c index
> 28e0695b53e7..07e30acbdc3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -805,41 +805,50 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args) if (r)
>  		goto clean_mqd;
>=20
> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	/* Make sure a concurrent close operation doesn't kill our userq */
> +	kref_get(&queue->refcount);
> +	r =3D xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> +		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
> +		     GFP_KERNEL);
> +	if (r) {
> +		/*
> +		 * This drops the extra and last reference which should=20
take
> +		 * care of all cleanup.
> +		 */
> +		amdgpu_userq_put(queue);
> +		amdgpu_userq_put(queue);
> +		return r;
> +	}
>=20
>  	/* don't map the queue if scheduling is halted */
> +	/* TODO: That is racy! */
>  	if (!adev->userq_halt_for_enforce_isolation ||
>  	    ((queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
>  	     (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE))) {
> +
> +		/* TODO: We could skip mapping if ev fence is signaled=20
*/
> +		amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr,
> +					     &fpriv->evf_mgr);
>  		r =3D amdgpu_userq_map_helper(queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map=20
Queue\n");
>  			mutex_unlock(&uq_mgr->userq_mutex);
> -			goto clean_doorbell;
> +			/* Prevent racing with close */
> +			if (xa_erase(&uq_mgr->userq_xa, qid) =3D=3D=20
queue)
> +				amdgpu_userq_put(queue);
> +			amdgpu_userq_put(queue);
> +			return r;
>  		}
> +		mutex_unlock(&uq_mgr->userq_mutex);
>  	}
>=20
>  	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> -	mutex_unlock(&uq_mgr->userq_mutex);
> -
> -	r =3D xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> -		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
> -		     GFP_KERNEL);
> -	if (r) {
> -		/*
> -		 * This drops the last reference which should take care=20
of
> -		 * all cleanup.
> -		 */
> -		amdgpu_userq_put(queue);
> -		return r;
> -	}
>=20
>  	amdgpu_debugfs_userq_init(filp, queue, qid);
> +	amdgpu_userq_put(queue);
>  	args->out.queue_id =3D qid;
>  	return 0;
>=20
> -clean_doorbell:
> -	xa_erase_irq(&adev->userq_doorbell_xa, index);
>  clean_mqd:
>  	uq_funcs->mqd_destroy(queue);
>  clean_mapping:
> @@ -1035,12 +1044,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *ad=
ev,
> struct drm_exec *exec, struct amdgpu_bo *bo;
>  	int ret;
>=20
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va =3D list_first_entry(&vm->invalidated,
> +	spin_lock(&vm->individual_lock);
> +	while (!list_empty(&vm->always_valid.evicted)) {
> +		bo_va =3D list_first_entry(&vm->always_valid.evicted,
>  					 struct amdgpu_bo_va,
>  					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->individual_lock);
>=20
>  		bo =3D bo_va->base.bo;
>  		ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -1052,14 +1061,14 @@ amdgpu_userq_bo_validate(struct amdgpu_device *ad=
ev,
> struct drm_exec *exec, if (ret)
>  			return ret;
>=20
> -		/* This moves the bo_va to the done list */
> +		/* This moves the bo_va to the idle list */
>  		ret =3D amdgpu_vm_bo_update(adev, bo_va, false);
>  		if (ret)
>  			return ret;
>=20
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->individual_lock);
>  	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->individual_lock);
>=20
>  	return 0;
>  }
> @@ -1091,7 +1100,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr
> *uq_mgr) if (unlikely(ret))
>  			goto unlock_all;
>=20
> -		ret =3D amdgpu_vm_lock_done_list(vm, &exec, 1);
> +		ret =3D amdgpu_vm_lock_individual(vm, &exec, 1);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto unlock_all;
> @@ -1134,7 +1143,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr
> *uq_mgr)
>=20
>  	key =3D 0;
>  	/* Validate User Ptr BOs */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status)=20
{
>  		bo =3D bo_va->base.bo;
>  		if (!bo)
>  			continue;
> @@ -1184,10 +1193,10 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr
> *uq_mgr)
>=20
>  	/*
>  	 * We need to wait for all VM updates to finish before restarting=20
the
> -	 * queues. Using the done list like that is now ok since=20
everything is
> +	 * queues. Using the idle list like that is now ok since everything=20
is
>  	 * locked in place.
>  	 */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status)
> +	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status)
>  		dma_fence_wait(bo_va->last_pt_update, false);
>  	dma_fence_wait(vm->last_update, false);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 6b58b0ecfa06..9f71a146f1f6
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -138,6 +138,47 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm
> *vm) dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>  }
>=20
> +/* Initialize the amdgpu_vm_bo_status object */
> +static void amdgpu_vm_bo_status_init(struct amdgpu_vm_bo_status *lists)
> +{
> +	INIT_LIST_HEAD(&lists->evicted);
> +	INIT_LIST_HEAD(&lists->moved);
> +	INIT_LIST_HEAD(&lists->idle);
> +}
> +
> +/*
> + * Make sure we have the lock to modify the vm_bo status and return the
> object + * with the status lists.
> + */
> +static struct amdgpu_vm_bo_status *
> +amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
> +{
> +	struct amdgpu_vm *vm =3D vm_bo->vm;
> +	struct amdgpu_bo *bo =3D vm_bo->bo;
> +
> +	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		/* No extra locking needed, protected by the root PD=20
resv lock */
> +		amdgpu_vm_assert_locked(vm);
> +
> +		if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
> +			return &vm->kernel;
> +
> +		return &vm->always_valid;
> +	}
> +
> +	spin_lock(&vm_bo->vm->individual_lock);
> +	return &vm->individual;
> +}
> +
> +/* Eventually unlock the status list lock again */
> +static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
> +{
> +	if (amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		amdgpu_vm_assert_locked(vm_bo->vm);
> +	else
> +		spin_unlock(&vm_bo->vm->individual_lock);
> +}
> +
>  /**
>   * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
>   *
> @@ -157,37 +198,44 @@ bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm
> *vm, struct amdgpu_bo *bo) *
>   * @vm_bo: vm_bo which is evicted
>   *
> - * State for PDs/PTs and per VM BOs which are not at the location they
> should - * be.
> + * State for vm_bo objects meaning the underlying BO was evicted and need
> to + * move in place again.
>   */
>  static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -	struct amdgpu_vm *vm =3D vm_bo->vm;
> -	struct amdgpu_bo *bo =3D vm_bo->bo;
> +	struct amdgpu_vm_bo_status *lists;
>=20
> +	lists =3D amdgpu_vm_bo_lock_lists(vm_bo);
>  	vm_bo->moved =3D true;
> -	amdgpu_vm_assert_locked(vm);
> -	spin_lock(&vm_bo->vm->status_lock);
> -	if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
> -		list_move(&vm_bo->vm_status, &vm->evicted);
> -	else
> -		list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -	spin_unlock(&vm_bo->vm->status_lock);
> +	list_move(&vm_bo->vm_status, &lists->evicted);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>  }
>  /**
>   * amdgpu_vm_bo_moved - vm_bo is moved
>   *
>   * @vm_bo: vm_bo which is moved
>   *
> - * State for per VM BOs which are moved, but that change is not yet
> reflected - * in the page tables.
> + * State for vm_bo objects meaning the underlying BO was moved but the n=
ew
> + * location not yet reflected in the page tables.
>   */
>  static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -	spin_unlock(&vm_bo->vm->status_lock);
> +	struct amdgpu_vm_bo_status *lists;
> +	struct amdgpu_bo *bo =3D vm_bo->bo;
> +
> +	/*
> +	 * The root PD doesn't have a parent PDE and goes directly into the
> +	 * idle state.
> +	 */
> +	lists =3D amdgpu_vm_bo_lock_lists(vm_bo);
> +	if (bo && bo->tbo.type =3D=3D ttm_bo_type_kernel && !bo->parent) {
> +		vm_bo->moved =3D false;
> +		list_move(&vm_bo->vm_status, &lists->idle);
> +	} else {
> +		vm_bo->moved =3D true;
> +		list_move(&vm_bo->vm_status, &lists->moved);
> +	}
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>  }
>=20
>  /**
> @@ -195,120 +243,43 @@ static void amdgpu_vm_bo_moved(struct
> amdgpu_vm_bo_base *vm_bo) *
>   * @vm_bo: vm_bo which is now idle
>   *
> - * State for PDs/PTs and per VM BOs which have gone through the state
> machine - * and are now idle.
> + * State for vm_bo objects meaning we are done with the state machine and
> no + * further action is necessary.
>   */
>  static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	spin_unlock(&vm_bo->vm->status_lock);
> -	vm_bo->moved =3D false;
> -}
> +	struct amdgpu_vm_bo_status *lists;
>=20
> -/**
> - * amdgpu_vm_bo_invalidated - vm_bo is invalidated
> - *
> - * @vm_bo: vm_bo which is now invalidated
> - *
> - * State for normal BOs which are invalidated and that change not yet
> reflected - * in the PTs.
> - */
> -static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->status_lock);
> -}
> -
> -/**
> - * amdgpu_vm_bo_evicted_user - vm_bo is evicted
> - *
> - * @vm_bo: vm_bo which is evicted
> - *
> - * State for BOs used by user mode queues which are not at the location
> they - * should be.
> - */
> -static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	vm_bo->moved =3D true;
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> -	spin_unlock(&vm_bo->vm->status_lock);
> -}
> -
> -/**
> - * amdgpu_vm_bo_relocated - vm_bo is reloacted
> - *
> - * @vm_bo: vm_bo which is relocated
> - *
> - * State for PDs/PTs which needs to update their parent PD.
> - * For the root PD, just move to idle state.
> - */
> -static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	if (vm_bo->bo->parent) {
> -		spin_lock(&vm_bo->vm->status_lock);
> -		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -		spin_unlock(&vm_bo->vm->status_lock);
> -	} else {
> -		amdgpu_vm_bo_idle(vm_bo);
> -	}
> -}
> -
> -/**
> - * amdgpu_vm_bo_done - vm_bo is done
> - *
> - * @vm_bo: vm_bo which is now done
> - *
> - * State for normal BOs which are invalidated and that change has been
> updated - * in the PTs.
> - */
> -static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	spin_lock(&vm_bo->vm->status_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -	spin_unlock(&vm_bo->vm->status_lock);
> +	lists =3D amdgpu_vm_bo_lock_lists(vm_bo);
> +	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		vm_bo->moved =3D false;
> +	list_move(&vm_bo->vm_status, &lists->idle);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>  }
>=20
>  /**
>   * amdgpu_vm_bo_reset_state_machine - reset the vm_bo state machine
>   * @vm: the VM which state machine to reset
>   *
> - * Move all vm_bo object in the VM into a state where they will be updat=
ed
> - * again during validation.
> + * Move all vm_bo object in the VM into a state where their location will
> be + * updated in the page tables again.
>   */
>  static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>  {
> -	struct amdgpu_vm_bo_base *vm_bo, *tmp;
> -
>  	amdgpu_vm_assert_locked(vm);
> +	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
> +	list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved);
>=20
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->done, &vm->invalidated);
> -	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
> -		vm_bo->moved =3D true;
> -
> -	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
> -		struct amdgpu_bo *bo =3D vm_bo->bo;
> -
> -		vm_bo->moved =3D true;
> -		if (!bo || bo->tbo.type !=3D ttm_bo_type_kernel)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm-
>moved);
> -		else if (bo->parent)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm-
>relocated);
> -	}
> -	spin_unlock(&vm->status_lock);
> +	spin_lock(&vm->individual_lock);
> +	list_splice_init(&vm->individual.idle, &vm->individual.moved);
> +	spin_unlock(&vm->individual_lock);
>  }
>=20
>  /**
>   * amdgpu_vm_update_shared - helper to update shared memory stat
>   * @base: base structure for tracking BO usage in a VM
>   *
> - * Takes the vm status_lock and updates the shared memory stat. If the
> basic + * Takes the vm stats_lock and updates the shared memory stat. If
> the basic * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats
> need to be called * as well.
>   */
> @@ -321,7 +292,7 @@ static void amdgpu_vm_update_shared(struct
> amdgpu_vm_bo_base *base) bool shared;
>=20
>  	dma_resv_assert_held(bo->tbo.base.resv);
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>  	shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>  	if (base->shared !=3D shared) {
>  		base->shared =3D shared;
> @@ -333,7 +304,7 @@ static void amdgpu_vm_update_shared(struct
> amdgpu_vm_bo_base *base) vm->stats[bo_memtype].drm.private +=3D size;
>  		}
>  	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>  }
>=20
>  /**
> @@ -358,11 +329,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *b=
o)
>   *        be bo->tbo.resource
>   * @sign: if we should add (+1) or subtract (-1) from the stat
>   *
> - * Caller need to have the vm status_lock held. Useful for when multiple
> update + * Caller need to have the vm stats_lock held. Useful for when
> multiple update * need to happen at the same time.
>   */
>  static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
> -			    struct ttm_resource *res, int sign)
> +					  struct ttm_resource=20
*res, int sign)
>  {
>  	struct amdgpu_vm *vm =3D base->vm;
>  	struct amdgpu_bo *bo =3D base->bo;
> @@ -386,7 +357,8 @@ static void amdgpu_vm_update_stats_locked(struct
> amdgpu_vm_bo_base *base, */
>  		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>  			vm->stats[res_memtype].drm.purgeable +=3D=20
size;
> -		if (!(bo->preferred_domains &=20
amdgpu_mem_type_to_domain(res_memtype)))
> +		if (!(bo->preferred_domains &
> +		      amdgpu_mem_type_to_domain(res_memtype)))
>  			vm->stats[bo_memtype].evicted +=3D size;
>  	}
>  }
> @@ -405,9 +377,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base
> *base, {
>  	struct amdgpu_vm *vm =3D base->vm;
>=20
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>  	amdgpu_vm_update_stats_locked(base, res, sign);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>  }
>=20
>  /**
> @@ -428,37 +400,34 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base
> *base, base->next =3D NULL;
>  	INIT_LIST_HEAD(&base->vm_status);
>=20
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>  	if (!bo)
>  		return;
> +
>  	base->next =3D bo->vm_bo;
>  	bo->vm_bo =3D base;
>=20
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>  	base->shared =3D drm_gem_object_is_shared_for_memory_stats(&bo-
>tbo.base);
>  	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>=20
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> +	if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		amdgpu_vm_bo_idle(base);
>  		return;
> -
> -	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +	}
>=20
>  	ttm_bo_set_bulk_move(&bo->tbo, &vm->lru_bulk_move);
> -	if (bo->tbo.type =3D=3D ttm_bo_type_kernel && bo->parent)
> -		amdgpu_vm_bo_relocated(base);
> -	else
> -		amdgpu_vm_bo_idle(base);
>=20
> +	/*
> +	 * When a per VM isn't in the desired domain put it into the=20
evicted
> +	 * state to make sure that it gets validated on the next best=20
occasion.
> +	 */
>  	if (bo->preferred_domains &
>  	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
> -		return;
> -
> -	/*
> -	 * we checked all the prerequisites, but it looks like this per vm=20
bo
> -	 * is currently evicted. add the bo to the evicted list to make=20
sure it
> -	 * is validated on next vm use to avoid fault.
> -	 * */
> -	amdgpu_vm_bo_evicted(base);
> +		amdgpu_vm_bo_moved(base);
> +	else
> +		amdgpu_vm_bo_evicted(base);
>  }
>=20
>  /**
> @@ -479,41 +448,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct
> drm_exec *exec, }
>=20
>  /**
> - * amdgpu_vm_lock_done_list - lock all BOs on the done list
> + * amdgpu_vm_lock_individual - lock all BOs on the individual idle list
>   * @vm: vm providing the BOs
>   * @exec: drm execution context
>   * @num_fences: number of extra fences to reserve
>   *
> - * Lock the BOs on the done list in the DRM execution context.
> + * Lock the BOs on the individual idle list in the DRM execution context.
>   */
> -int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
> -			     unsigned int num_fences)
> +int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exe=
c,
> +			      unsigned int num_fences)
>  {
> -	struct list_head *prev =3D &vm->done;
> +	struct list_head *prev =3D &vm->individual.idle;
>  	struct amdgpu_bo_va *bo_va;
>  	struct amdgpu_bo *bo;
>  	int ret;
>=20
>  	/* We can only trust prev->next while holding the lock */
> -	spin_lock(&vm->status_lock);
> -	while (!list_is_head(prev->next, &vm->done)) {
> +	spin_lock(&vm->individual_lock);
> +	while (!list_is_head(prev->next, &vm->individual.idle)) {
>  		bo_va =3D list_entry(prev->next, typeof(*bo_va),=20
base.vm_status);
>=20
>  		bo =3D bo_va->base.bo;
>  		if (bo) {
>  			amdgpu_bo_ref(bo);
> -			spin_unlock(&vm->status_lock);
> +			spin_unlock(&vm->individual_lock);
>=20
>  			ret =3D drm_exec_prepare_obj(exec, &bo-
>tbo.base, 1);
>  			amdgpu_bo_unref(&bo);
>  			if (unlikely(ret))
>  				return ret;
>=20
> -			spin_lock(&vm->status_lock);
> +			spin_lock(&vm->individual_lock);
>  		}
>  		prev =3D prev->next;
>  	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->individual_lock);
>=20
>  	return 0;
>  }
> @@ -609,10 +578,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, void *param)
>  {
>  	uint64_t new_vm_generation =3D amdgpu_vm_generation(adev, vm);
> -	struct amdgpu_vm_bo_base *bo_base;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_vm_bo_base *bo_base, *tmp;
>  	int r;
>=20
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>  	if (vm->generation !=3D new_vm_generation) {
>  		vm->generation =3D new_vm_generation;
>  		amdgpu_vm_bo_reset_state_machine(vm);
> @@ -622,49 +591,59 @@ int amdgpu_vm_validate(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, return r;
>  	}
>=20
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->evicted)) {
> -		bo_base =3D list_first_entry(&vm->evicted,
> -					   struct=20
amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
> +	list_for_each_entry_safe(bo_base, tmp, &vm->kernel.evicted,=20
vm_status) {
> +		r =3D validate(param, bo_base->bo);
> +		if (r)
> +			return r;
>=20
> -		bo =3D bo_base->bo;
> +		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base-
>bo));
> +		amdgpu_vm_bo_moved(bo_base);
> +	}
>=20
> -		r =3D validate(param, bo);
> +	/*
> +	 * As soon as all page tables are in place we can start updating=20
them
> +	 * again.
> +	 */
> +	amdgpu_vm_eviction_lock(vm);
> +	vm->evicting =3D false;
> +	amdgpu_vm_eviction_unlock(vm);
> +
> +	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
> +				 vm_status) {
> +		r =3D validate(param, bo_base->bo);
>  		if (r)
>  			return r;
>=20
> -		if (bo->tbo.type !=3D ttm_bo_type_kernel) {
> -			amdgpu_vm_bo_moved(bo_base);
> -		} else {
> -			vm->update_funcs-
>map_table(to_amdgpu_bo_vm(bo));
> -			amdgpu_vm_bo_relocated(bo_base);
> -		}
> -		spin_lock(&vm->status_lock);
> +		amdgpu_vm_bo_moved(bo_base);
>  	}
> -	while (ticket && !list_empty(&vm->evicted_user)) {
> -		bo_base =3D list_first_entry(&vm->evicted_user,
> -					   struct=20
amdgpu_vm_bo_base,
> -					   vm_status);
> -		spin_unlock(&vm->status_lock);
>=20
> -		bo =3D bo_base->bo;
> -		dma_resv_assert_held(bo->tbo.base.resv);
> +	if (!ticket)
> +		return 0;
> +
> +	spin_lock(&vm->individual_lock);
> +restart:
> +	list_for_each_entry(bo_base, &vm->individual.evicted, vm_status) {
> +		struct amdgpu_bo *bo =3D bo_base->bo;
> +
> +		if (dma_resv_locking_ctx(bo->tbo.base.resv) !=3D ticket)
> +			continue;
> +
> +		spin_unlock(&vm->individual_lock);
>=20
>  		r =3D validate(param, bo);
>  		if (r)
>  			return r;
>=20
> -		amdgpu_vm_bo_invalidated(bo_base);
> +		amdgpu_vm_bo_moved(bo_base);
>=20
> -		spin_lock(&vm->status_lock);
> +		/* It's a bit inefficient to always jump back to the=20
start, but
> +		 * we would need to re-structure the KFD for properly=20
fixing
> +		 * that.
> +		 */
> +		spin_lock(&vm->individual_lock);
> +		goto restart;
>  	}
> -	spin_unlock(&vm->status_lock);
> -
> -	amdgpu_vm_eviction_lock(vm);
> -	vm->evicting =3D false;
> -	amdgpu_vm_eviction_unlock(vm);
> +	spin_unlock(&vm->individual_lock);
>=20
>  	return 0;
>  }
> @@ -689,9 +668,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  	ret =3D !vm->evicting;
>  	amdgpu_vm_eviction_unlock(vm);
>=20
> -	spin_lock(&vm->status_lock);
> -	ret &=3D list_empty(&vm->evicted);
> -	spin_unlock(&vm->status_lock);
> +	ret &=3D list_empty(&vm->kernel.evicted);
>=20
>  	spin_lock(&vm->immediate.lock);
>  	ret &=3D !vm->immediate.stopped;
> @@ -985,18 +962,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *ade=
v,
>  			  struct amdgpu_vm *vm, bool immediate)
>  {
>  	struct amdgpu_vm_update_params params;
> -	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm_bo_base *entry, *tmp;
>  	bool flush_tlb_needed =3D false;
> -	LIST_HEAD(relocated);
>  	int r, idx;
>=20
>  	amdgpu_vm_assert_locked(vm);
>=20
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->relocated, &relocated);
> -	spin_unlock(&vm->status_lock);
> -
> -	if (list_empty(&relocated))
> +	if (list_empty(&vm->kernel.moved))
>  		return 0;
>=20
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -1012,7 +984,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>=20
> -	list_for_each_entry(entry, &relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
>  		/* vm_flush_needed after updating moved PDEs */
>  		flush_tlb_needed |=3D entry->moved;
>=20
> @@ -1028,11 +1000,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *ad=
ev,
> if (flush_tlb_needed)
>  		atomic64_inc(&vm->tlb_seq);
>=20
> -	while (!list_empty(&relocated)) {
> -		entry =3D list_first_entry(&relocated, struct=20
amdgpu_vm_bo_base,
> -					 vm_status);
> +	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
>  		amdgpu_vm_bo_idle(entry);
> -	}
>=20
>  error:
>  	drm_dev_exit(idx);
> @@ -1260,9 +1229,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev,
> struct amdgpu_vm *vm, void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>  			  struct amdgpu_mem_stats=20
stats[__AMDGPU_PL_NUM])
>  {
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->stats_lock);
>  	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->stats_lock);
>  }
>=20
>  /**
> @@ -1406,7 +1375,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
> struct amdgpu_bo_va *bo_va, else
>  			amdgpu_vm_bo_idle(&bo_va->base);
>  	} else {
> -		amdgpu_vm_bo_done(&bo_va->base);
> +		amdgpu_vm_bo_idle(&bo_va->base);
>  	}
>=20
>  	list_splice_init(&bo_va->invalids, &bo_va->valids);
> @@ -1629,29 +1598,25 @@ int amdgpu_vm_handle_moved(struct amdgpu_device
> *adev, struct amdgpu_vm *vm,
>  			   struct ww_acquire_ctx *ticket)
>  {
> -	struct amdgpu_bo_va *bo_va;
> +	struct amdgpu_bo_va *bo_va, *tmp;
>  	struct dma_resv *resv;
>  	bool clear, unlock;
>  	int r;
>=20
> -	spin_lock(&vm->status_lock);
> -	while (!list_empty(&vm->moved)) {
> -		bo_va =3D list_first_entry(&vm->moved, struct=20
amdgpu_bo_va,
> -					 base.vm_status);
> -		spin_unlock(&vm->status_lock);
> -
> +	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
> +				 base.vm_status) {
>  		/* Per VM BOs never need to bo cleared in the page=20
tables */
>  		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
>  		if (r)
>  			return r;
> -		spin_lock(&vm->status_lock);
>  	}
>=20
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va =3D list_first_entry(&vm->invalidated, struct=20
amdgpu_bo_va,
> -					 base.vm_status);
> +	spin_lock(&vm->individual_lock);
> +	while (!list_empty(&vm->individual.moved)) {
> +		bo_va =3D list_first_entry(&vm->individual.moved,
> +					 typeof(*bo_va),=20
base.vm_status);
>  		resv =3D bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->individual_lock);
>=20
>  		/* Try to reserve the BO to avoid clearing its ptes */
>  		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1681,11 +1646,11 @@ int amdgpu_vm_handle_moved(struct amdgpu_device
> *adev, drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>  		    (!bo_va->base.bo->tbo.resource ||
>  		     bo_va->base.bo->tbo.resource->mem_type =3D=3D=20
TTM_PL_SYSTEM))
> -			amdgpu_vm_bo_evicted_user(&bo_va->base);
> +			amdgpu_vm_bo_evicted(&bo_va->base);
>=20
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->individual_lock);
>  	}
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->individual_lock);
>=20
>  	return 0;
>  }
> @@ -2223,9 +2188,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>  		}
>  	}
>=20
> -	spin_lock(&vm->status_lock);
> +	spin_lock(&vm->individual_lock);
>  	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->status_lock);
> +	spin_unlock(&vm->individual_lock);
>=20
>  	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>  		list_del(&mapping->list);
> @@ -2305,14 +2270,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo,
> bool evicted)
>=20
>  		if (bo_base->moved)
>  			continue;
> -		bo_base->moved =3D true;
> -
> -		if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
> -			amdgpu_vm_bo_relocated(bo_base);
> -		else if (amdgpu_vm_is_bo_always_valid(vm, bo))
> -			amdgpu_vm_bo_moved(bo_base);
> -		else
> -			amdgpu_vm_bo_invalidated(bo_base);
> +		amdgpu_vm_bo_moved(bo_base);
>  	}
>  }
>=20
> @@ -2333,10 +2291,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, stru=
ct
> ttm_resource *new_mem, for (bo_base =3D bo->vm_bo; bo_base; bo_base =3D
> bo_base->next) {
>  		struct amdgpu_vm *vm =3D bo_base->vm;
>=20
> -		spin_lock(&vm->status_lock);
> +		spin_lock(&vm->stats_lock);
>  		amdgpu_vm_update_stats_locked(bo_base, bo-
>tbo.resource, -1);
>  		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
> -		spin_unlock(&vm->status_lock);
> +		spin_unlock(&vm->stats_lock);
>  	}
>=20
>  	amdgpu_vm_bo_invalidate(bo, evicted);
> @@ -2603,16 +2561,14 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, vm->va =3D RB_ROOT_CACHED;
>  	for (i =3D 0; i < AMDGPU_MAX_VMHUBS; i++)
>  		vm->reserved_vmid[i] =3D NULL;
> -	INIT_LIST_HEAD(&vm->evicted);
> -	INIT_LIST_HEAD(&vm->evicted_user);
> -	INIT_LIST_HEAD(&vm->relocated);
> -	INIT_LIST_HEAD(&vm->moved);
> -	INIT_LIST_HEAD(&vm->idle);
> -	INIT_LIST_HEAD(&vm->invalidated);
> -	spin_lock_init(&vm->status_lock);
> +
> +	amdgpu_vm_bo_status_init(&vm->kernel);
> +	amdgpu_vm_bo_status_init(&vm->always_valid);
> +	spin_lock_init(&vm->individual_lock);
> +	amdgpu_vm_bo_status_init(&vm->individual);
>  	INIT_LIST_HEAD(&vm->freed);
> -	INIT_LIST_HEAD(&vm->done);
>  	INIT_KFIFO(vm->faults);
> +	spin_lock_init(&vm->stats_lock);
>=20
>  	r =3D amdgpu_vm_init_entities(adev, vm);
>  	if (r)
> @@ -3089,100 +3045,64 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> *adev, u32 pasid, }
>=20
>  #if defined(CONFIG_DEBUG_FS)
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
> -	u64 total_idle =3D 0;
> -	u64 total_evicted =3D 0;
> -	u64 total_relocated =3D 0;
> -	u64 total_moved =3D 0;
> -	u64 total_invalidated =3D 0;
> -	u64 total_done =3D 0;
> -	unsigned int total_idle_objs =3D 0;
> -	unsigned int total_evicted_objs =3D 0;
> -	unsigned int total_relocated_objs =3D 0;
> -	unsigned int total_moved_objs =3D 0;
> -	unsigned int total_invalidated_objs =3D 0;
> -	unsigned int total_done_objs =3D 0;
> -	unsigned int id =3D 0;
>=20
> -	amdgpu_vm_assert_locked(vm);
> +/* print the debug info for a specific set of status lists */
> +static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
> +					     struct=20
amdgpu_vm_bo_status *lists)
> +{
> +	struct amdgpu_vm_bo_base *base;
> +	unsigned int id;
>=20
> -	spin_lock(&vm->status_lock);
> -	seq_puts(m, "\tIdle BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_idle +=3D amdgpu_bo_print_info(id++, bo_va-
>base.bo, m);
> -	}
> -	total_idle_objs =3D id;
>  	id =3D 0;
> -
>  	seq_puts(m, "\tEvicted BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)=20
{
> -		if (!bo_va->base.bo)
> +	list_for_each_entry(base, &lists->evicted, vm_status) {
> +		if (!base->bo)
>  			continue;
> -		total_evicted +=3D amdgpu_bo_print_info(id++, bo_va-
>base.bo, m);
> -	}
> -	total_evicted_objs =3D id;
> -	id =3D 0;
>=20
> -	seq_puts(m, "\tRelocated BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->relocated,=20
base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_relocated +=3D amdgpu_bo_print_info(id++, bo_va-
>base.bo, m);
> +		amdgpu_bo_print_info(id++, base->bo, m);
>  	}
> -	total_relocated_objs =3D id;
> -	id =3D 0;
>=20
> +	id =3D 0;
>  	seq_puts(m, "\tMoved BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	list_for_each_entry(base, &lists->moved, vm_status) {
> +		if (!base->bo)
>  			continue;
> -		total_moved +=3D amdgpu_bo_print_info(id++, bo_va-
>base.bo, m);
> +
> +		amdgpu_bo_print_info(id++, base->bo, m);
>  	}
> -	total_moved_objs =3D id;
> -	id =3D 0;
>=20
> -	seq_puts(m, "\tInvalidated BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated,=20
base.vm_status) {
> -		if (!bo_va->base.bo)
> +	id =3D 0;
> +	seq_puts(m, "\tIdle BOs:\n");
> +	list_for_each_entry(base, &lists->moved, vm_status) {
> +		if (!base->bo)
>  			continue;
> -		total_invalidated +=3D amdgpu_bo_print_info(id++,=09
bo_va->base.bo, m);
> +
> +		amdgpu_bo_print_info(id++, base->bo, m);
>  	}
> -	total_invalidated_objs =3D id;
> -	id =3D 0;
> +}
>=20
> -	seq_puts(m, "\tDone BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_done +=3D amdgpu_bo_print_info(id++, bo_va-
>base.bo, m);
> -	}
> -	spin_unlock(&vm->status_lock);
> -	total_done_objs =3D id;
> -
> -	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n",=20
total_idle,
> -		   total_idle_objs);
> -	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n",
> total_evicted, -		   total_evicted_objs);
> -	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n",
> total_relocated, -		   total_relocated_objs);
> -	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n",
> total_moved, -		   total_moved_objs);
> -	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n",
> total_invalidated, -		   total_invalidated_objs);
> -	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n",=20
total_done,
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
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->always_valid);
> +
> +	seq_puts(m, "\tIndividual BOs:\n");
> +	spin_lock(&vm->individual_lock);
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->individual);
> +	spin_unlock(&vm->individual_lock);
>  }
>  #endif
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index f33ea7f8509b..cc96a3e6252f
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -205,17 +205,34 @@ struct amdgpu_vm_bo_base {
>  	/* protected by bo being reserved */
>  	struct amdgpu_vm_bo_base	*next;
>=20
> -	/* protected by vm status_lock */
> +	/* protected by vm reservation and invalidated_lock */
>  	struct list_head		vm_status;
>=20
>  	/* if the bo is counted as shared in mem stats
> -	 * protected by vm status_lock */
> +	 * protected by vm BO being reserved */
>  	bool				shared;
>=20
>  	/* protected by the BO being reserved */
>  	bool				moved;
>  };
>=20
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
> +	/* BOs which moved but new location hasn't been updated in the PDs/
PTs */
> +	struct list_head		moved;
> +
> +	/* BOs done with the state machine and need no further action */
> +	struct list_head		idle;
> +};
> +
>  /* provided by hw blocks that can write ptes, e.g., sdma */
>  struct amdgpu_vm_pte_funcs {
>  	/* number of dw to reserve per operation */
> @@ -345,47 +362,29 @@ struct amdgpu_vm {
>  	bool			evicting;
>  	unsigned int		saved_flags;
>=20
> -	/* Lock to protect vm_bo add/del/move on all lists of vm */
> -	spinlock_t		status_lock;
> -
> -	/* Memory statistics for this vm, protected by status_lock */
> +	/* Memory statistics for this vm, protected by stats_lock */
> +	spinlock_t		stats_lock;
>  	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>=20
> +	/* BO's belonging to PD/PT which are internal to the kernel. */
> +	struct amdgpu_vm_bo_status	kernel;
> +
>  	/*
> -	 * The following lists contain amdgpu_vm_bo_base objects for=20
either
> -	 * PDs, PTs or per VM BOs. The state transits are:
> -	 *
> -	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> +	 * BOs allocated by userspace where the dma_resv is shared with the
> +	 * root PD
>  	 */
> -
> -	/* Per-VM and PT BOs who needs a validation */
> -	struct list_head	evicted;
> -
> -	/* PT BOs which relocated and their parent need an update */
> -	struct list_head	relocated;
> -
> -	/* per VM BOs moved, but not yet updated in the PT */
> -	struct list_head	moved;
> -
> -	/* All BOs of this VM not currently in the state machine */
> -	struct list_head	idle;
> +	struct amdgpu_vm_bo_status	always_valid;
>=20
>  	/*
>  	 * The following lists contain amdgpu_vm_bo_base objects for BOs=20
which
> -	 * have their own dma_resv object and not depend on the root PD.=20
Their
> -	 * state transits are:
> +	 * have their own dma_resv object and not depend on the root PD.
>  	 *
> -	 * evicted_user or invalidated -> done
> +	 * Lists are protected by the individual_lock.
>  	 */
> +	spinlock_t			individual_lock;
>=20
> -	/* BOs for user mode queues that need a validation */
> -	struct list_head	evicted_user;
> -
> -	/* regular invalidated BOs, but not yet updated in the PT */
> -	struct list_head	invalidated;
> -
> -	/* BOs which are invalidated, has been updated in the PTs */
> -	struct list_head        done;
> +	/* Userspace BOs with individual resv object */
> +	struct amdgpu_vm_bo_status	individual;
>=20
>  	/*
>  	 * This list contains amdgpu_bo_va_mapping objects which have been=20
freed
> @@ -507,8 +506,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev,
> struct amdgpu_vm *vm); void amdgpu_vm_fini(struct amdgpu_device *adev,
> struct amdgpu_vm *vm); int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct
> drm_exec *exec, unsigned int num_fences);
> -int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
> -			     unsigned int num_fences);
> +int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exe=
c,
> +			      unsigned int num_fences);
>  bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>  uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_=
vm
> *vm); int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm
> *vm, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> a930f1522f96..ff334f4dcc90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -544,9 +544,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base
> *entry) entry->bo->vm_bo =3D NULL;
>  	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>=20
> -	spin_lock(&entry->vm->status_lock);
>  	list_del(&entry->vm_status);
> -	spin_unlock(&entry->vm->status_lock);
>  	amdgpu_bo_unref(&entry->bo);
>  }
>=20
> @@ -590,7 +588,6 @@ static void amdgpu_vm_pt_add_list(struct
> amdgpu_vm_update_params *params, struct amdgpu_vm_pt_cursor seek;
>  	struct amdgpu_vm_bo_base *entry;
>=20
> -	spin_lock(&params->vm->status_lock);
>  	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor,=20
seek,
> entry) { if (entry && entry->bo)
>  			list_move(&entry->vm_status, &params-
>tlb_flush_waitlist);
> @@ -598,7 +595,6 @@ static void amdgpu_vm_pt_add_list(struct
> amdgpu_vm_update_params *params,
>=20
>  	/* enter start node now */
>  	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
> -	spin_unlock(&params->vm->status_lock);
>  }
>=20
>  /**




