Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03F9CA5FA3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 19:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2140E10EB95;
	Mon, 28 Sep 2026 19:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PEBtduqG";
	dkim-atps=neutral
Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com
 [74.125.226.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A69A10EB95
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 19:08:27 +0000 (UTC)
Received: by mail-ua2-f43.google.com with SMTP id
 a1e0cc1a2514c-98514b4115eso2283273241.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790622506; x=1791227306; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WCFB3dlN1fhDwMnRsYWiWMwwFNkMq+VKg4dTsxFPHRo=;
 b=PEBtduqGXHlcZgCSGBxR7RTSzG2vBtW/CH16eENqsZWwlOnc6qLHJKnCvKnmJKmHLy
 nVOhqVAZ94Ifa/V/daYCeupYdt2DSkx4NG4xXa+q4wroTsSNP6TzPtkIwyhfkxzURmok
 MgbAHz1o5EpkrkUwuynsRYhuUIxDpUiqlIpBTyWVk/rrx26IOjyxZVrpnjzbFREmasIj
 aCW5yi7ecg4r1WqWyIDunZFYawx14hFrJHqryTyQInbtlKYhYzpAQmFfmhRoLkLpA/yH
 CyF8JQjMS/yGU6m95O9Gzf6xYScSt8ThyHEM8pYFaW+PMa+3Y4J/TM9yDTDLyELNdflm
 Z/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790622506; x=1791227306;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WCFB3dlN1fhDwMnRsYWiWMwwFNkMq+VKg4dTsxFPHRo=;
 b=aAMuQvFDOQ8ie2NnRx9Xf/K2hlSIvtnStmGvFFk1M3ITsY47kbN4+ZDdjj4TSz65QY
 49XcE5qfAO0og+obeeC2TspdIlVo8+AjgXhSzLN2L4TFjjgNQ7Qvo+4z7amHEmJFSD4O
 F9dR7++qruMMS0OXmhxIBI0vkAsTvYwvTIiLZQ7fRXQfi8vF2SQxicqKLdEaqppLwh76
 etmxIJYgYIvxACyzsmqx3lk95OmFny2ss8iaP+Ebw7zlgEqsnY9DjM5FrmMNLnLctG4K
 q6XQuFw4E8nMyaByqXSNijZRDKDyXNNyxjaKHuSql145WLBJ0oVDfKfDNtFiVXQZXflx
 SEEQ==
X-Gm-Message-State: AFq9FYLu5YU438RaOosGxiSGgxjlmuhvGYVh34PRMdG8qCPE9PhvyDBt
 IDnParVwxq6QHk//KGx5Ci/3ij+TxZv3zJmMvvunPHvFu5I5Euky4gda
X-Gm-Gg: AYBFou2Jxz6Tqm0/WiOvL/jKowEq7Rcnh9uObcpD4ZN7XgFBZQ253g/kebdll11Gxx5
 l8gOd88OmzZNa0doH8Xo15gmSPhrSDLirJmPjKHgx/bOObBIrYbZpSry2FbBJOfWTAItrQwvLv9
 JN+FZ5OKwjgln5BpVawLPirFX5RXrSIH1lKh/H48unKpACeXjcrN275E02PJof8myWe5c3tbsf2
 hSuXaeU9hR3CKWSf+rTHxF+Kx8hu9wGAsccW4PIqAjpfTSg1eONtTI5ESijsEbHBt0AZ5SzDlnm
 aUyMUnuxf0x0JEGOJ2k16oZBNr7jhvIL7GgyIYhbpCxcrc/mptL0UAGvsfPCP+wJ7/yttQ/HhiB
 QuHBkTzNRGzWnbxiMNK9aLaojnJp7DAfcSbBqcAsPQfe3H6AgcK5CJ3GkiecTintuk+ZyDqC8Nj
 8y7XTJEBfFV3XOMrVlTcgdMQYedRbSSV/aqMKBhO7ukHLRLti2F219cHlP860PiTtuLW5w2Bt7A
 iI94C7aJkAojpoz+ckKXgbgRif9lvMXIsXWBEs4jkYY/gboSaqRGp/6fAtdW3Pr+G+ts8QNTc0I
 sVB9oWrhsg==
X-Received: by 2002:a05:6102:c53:b0:7a1:f7c3:3a45 with SMTP id
 ada2fe7eead31-7af1d6c4296mr5336078137.18.1790622506015; 
 Mon, 28 Sep 2026 12:08:26 -0700 (PDT)
Received: from timur-max.localnet
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7b39b15808esm10673820137.5.2026.09.28.12.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:08:25 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, cascardo@igalia.com,
 tvrtko.ursulin@igalia.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/9] drm/amdgpu: rework eviction lock handling into
 critical section v3
Date: Mon, 28 Sep 2026 15:08:24 -0400
Message-ID: <XurSVoYuT2KHd65dYXpHfQ@gmail.com>
In-Reply-To: <20260928151041.1857-1-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
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

On 2026. szeptember 28., h=C3=A9tf=C5=91 11:10:33 keleti =C3=A1llamokbeli n=
y=C3=A1ri id=C5=91 Christian=20
K=C3=B6nig wrote:
> Taking the eviction lock is actually just one step which we need to do
> in the critical section handling.
>=20
> Rename the functions to reflect that, use the update parameters instead of
> the vm to save the GFP flags.
>=20
> v2: rebased and reordered
> v3: fix rebase artefact, fix error handling in amdgpu_vm_pt_alloc
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Natalie Vock <nat@pixelcluster.dev>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  8 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 43 ++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 40 ++++++++---------
>  4 files changed, 54 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 29a66e39f3d60..7b949437564=
9f
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1170,11 +1170,9 @@ int amdgpu_vm_update_range(struct amdgpu_device
> *adev, struct amdgpu_vm *vm, params.override_pte =3D allow_override &&
> adev->gmc.override_pte;
>  	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>=20
> -	amdgpu_vm_eviction_lock(vm);
> -	if (vm->evicting) {
> -		r =3D -EBUSY;
> +	r =3D amdgpu_vm_begin_critical(&params);
> +	if (r)
>  		goto error_free;
> -	}
>=20
>  	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>  		struct dma_fence *tmp =3D dma_fence_get_stub();
> @@ -1258,7 +1256,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev,
> struct amdgpu_vm *vm,
>=20
>  error_free:
>  	kfree(tlb_cb);
> -	amdgpu_vm_eviction_unlock(vm);
> +	amdgpu_vm_end_critical(&params);
>  	drm_dev_exit(idx);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index 0f6634b749746..98cdd7e3475=
fb
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -289,7 +289,6 @@ struct amdgpu_vm {
>  	 */
>  	struct mutex		eviction_lock;
>  	bool			evicting;
> -	unsigned int		saved_flags;
>=20
>  	/* Memory statistics for this vm, protected by stats_lock */
>  	spinlock_t		stats_lock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h index
> ca86eaac75235..8ebb0b033291e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -51,7 +51,7 @@ struct amdgpu_vm_update_params {
>  	struct amdgpu_device *adev;
>=20
>  	/**
> -	 * @vm: optional amdgpu_vm we do this update for
> +	 * @vm: amdgpu_vm we do this update for
>  	 */
>  	struct amdgpu_vm *vm;
>=20
> @@ -93,6 +93,11 @@ struct amdgpu_vm_update_params {
>  	 */
>  	bool override_pte;
>=20
> +	/**
> +	 * @saved_flags: Saved flags for GFP reduction.
> +	 */
> +	unsigned int saved_flags;
> +
>  	/**
>  	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
>  	 */
> @@ -126,21 +131,37 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device
> *adev, struct amdgpu_vm_update_params *params);
>  int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm
> *vm);
>=20
> -/*
> - * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-=
=46S
> - * happens while holding this lock anywhere to prevent deadlocks when
> - * an MMU notifier runs in reclaim-FS context.
> +/**
> + * amdgpu_vm_begin_critical - start the critical section of the update
> + * @p: The update parameters
> + *
> + * Serialize all updates, check parameters and make sure that memory
> allocations + * don't enter the reclaim path so that we don't deadlock wi=
th
> MMU notifiers. + *
> + * Returns:
> + *
> + * 0 on success or a negative error code on failure.
> + * Even on error amdgpu_vm_end_critical() must still be called to clean =
up!
> */
> -static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
> +static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params
> *p) {
> -	mutex_lock(&vm->eviction_lock);
> -	vm->saved_flags =3D memalloc_noreclaim_save();
> +	mutex_lock(&p->vm->eviction_lock);
> +	p->saved_flags =3D memalloc_noreclaim_save();
> +	if (p->vm->evicting)
> +		return -EBUSY;
> +	return 0;
>  }
>=20
> -static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
> +/**
> + * amdgpu_vm_end_critical - end the critical section of the update
> + * @p: The update parameters
> + *
> + * Restore the GFP flags and drop the lock.
> + */
> +static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params
> *p) {
> -	memalloc_noreclaim_restore(vm->saved_flags);
> -	mutex_unlock(&vm->eviction_lock);
> +	memalloc_noreclaim_restore(p->saved_flags);
> +	mutex_unlock(&p->vm->eviction_lock);
>  }
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> 1cdf2b854f261..c03327f1242d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -505,52 +505,51 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, /**
>   * amdgpu_vm_pt_alloc - Allocate a specific page table
>   *
> - * @adev: amdgpu_device pointer
> - * @vm: VM to allocate page tables for
> + * @p: see amdgpu_vm_update_params definition
>   * @cursor: Which page table to allocate
> - * @immediate: use an immediate update
>   *
>   * Make sure a specific page table or directory is allocated.
>   *
>   * Returns:
> - * 1 if page table needed to be allocated, 0 if page table was already
> - * allocated, negative errno if an error occurred.
> + *
> + * 0 on success or a negative error code on failure.
>   */
> -static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
> -			      struct amdgpu_vm *vm,
> -			      struct amdgpu_vm_pt_cursor *cursor,
> -			      bool immediate)
> +static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
> +			      struct amdgpu_vm_pt_cursor *cursor)
>  {
>  	struct amdgpu_vm_bo_base *entry =3D cursor->entry;
>  	struct amdgpu_bo *pt_bo;
>  	struct amdgpu_bo_vm *pt;
> -	int r;
> +	int r, r2;
>=20
>  	if (entry->bo)
>  		return 0;
>=20
> -	amdgpu_vm_eviction_unlock(vm);
> -	r =3D amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
> -				vm->root.bo->xcp_id);
> -	amdgpu_vm_eviction_lock(vm);
> +	amdgpu_vm_end_critical(p);
> +	r =3D amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, p-
>immediate,
> +				&pt, p->vm->root.bo->xcp_id);
> +	r2 =3D amdgpu_vm_begin_critical(p);
>  	if (r)
>  		return r;
> +	if (r2)
> +		goto error_free_pt;
>=20
>  	/* Keep a reference to the root directory to avoid
>  	 * freeing them up in the wrong order.
>  	 */
>  	pt_bo =3D &pt->bo;
>  	pt_bo->parent =3D amdgpu_bo_ref(cursor->parent->bo);
> -	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
> -	r =3D amdgpu_vm_pt_clear(adev, vm, pt, immediate);
> +	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
> +	r =3D amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
>  	if (r)
> -		goto error_free_pt;
> +		goto error_unpin;
>=20
>  	return 0;
>=20
> -error_free_pt:
> -	if (vm->is_npa)
> +error_unpin:
> +	if (p->vm->is_npa)
>  		amdgpu_bo_unpin(pt_bo);
> +error_free_pt:
>  	amdgpu_bo_unref(&pt_bo);
>  	return r;
>  }
> @@ -838,8 +837,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_par=
ams
> *params, /* make sure that the page tables covering the
>  			 * address range are actually allocated
>  			 */
> -			r =3D amdgpu_vm_pt_alloc(params->adev, params-
>vm,
> -					       &cursor,=20
params->immediate);
> +			r =3D amdgpu_vm_pt_alloc(params, &cursor);
>  			if (r)
>  				return r;
>  		}




