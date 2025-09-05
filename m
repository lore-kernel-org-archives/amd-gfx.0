Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9595CA1010
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 16:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6D410E304;
	Fri,  5 Sep 2025 16:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mxcE4MyR";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E0910E304
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 16:49:35 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-329b641fda0so300930a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757090975; x=1757695775; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l54VtNA9gbLw6PdA+UYpLSy/X1XJq07gvWI3syNhhAg=;
 b=mxcE4MyRfl+QtlxSVch094q6epE15Ia3UCxgg0V5pdzMyfa0A7hglnG74p6VIybSak
 V/DHmIJysP5pKrCsUD9wBle+qxvl+M2mXfsYLkLkoP6coyDfs5ds2PscByZHd03a6JvV
 mFz1+ITMtpwk8mEf0Pi1TyYWoiKquroDXCgpfoy88qaVHVxag7mAj/5rWcfDAlqqLU5G
 oai9NRFH6F9W1kY5yPKbWKplxnXjbp03SdOMX7crCu7wnkgf8RJOCoLawptx0vrFO7kl
 2Bt9Y5b+MLnSDkw/U/OfnD6bnaSORkuDN4KvMghJOprhaNxZArm6U3kkSUfuh7almEQn
 oa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757090975; x=1757695775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l54VtNA9gbLw6PdA+UYpLSy/X1XJq07gvWI3syNhhAg=;
 b=o2ndDKz2MO+wtLy4YZdTXXsx82nNDuoYEMu2sinETaSmwHB6YI6cG1jORvae9g4NuH
 KPxITlvGcWpTczJQV1YCNTa2e8TvgwA+p+8MkTbGh+lZ1Yh+Puyj9674jN57sZK57fXN
 XaJvaofC8ItpQ1vyHAkSNBL+ramXrjDWwqhWUKA2TjPDkdu25tgwCAtBl1YALO1XjC3p
 utYa/h3FsAQyD9Th0djmGp4N/dxXgdn3qgZuVTwXB9sxa91YB0a00gzSuHBo3jiyA5+6
 /l1mEFZkAm5vtvy5KfRWNDCc2t9AjOk0tqJFv2WVo9NWRC9ovx7FmZXMWFJL2taNqWYC
 ubMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr8pksz7Dg/wvazreS4cRym1oY8Lk71TFRmk24s1Rybqppbx0N8/9B/HXK2ZJ8iKbiVaqILGu3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhN2oanczLhPHUfcLhVVGeCPytXt3ZQ7ZfSV1CBCfabL1rkJqc
 AXVqcrsQ9LtBmcg3wn2/TCPFKLa7+/dSIaEIwvB1XgnmClDxJAAJRVY0sguBImIbrmTcOhVx8cb
 Ds+MJiiV4Vb9LIGmhoMRK1vzXJxvOZCI=
X-Gm-Gg: ASbGnctIwP80rfnO7AehClFHJkskEtGgRo3j5jYa596uock+eCOT9fgpB43Pzs9Gv33
 6JvO5JcUlW00P8qS4jGDxCO8/KGBDGgHzHc5QWKyRjYsY1WkCmMybbUePJP2/9o/vSGBm9fpcpu
 01TquVvDOrox74rHAKGR4jCZnZLAwOk2mnhzIxTEyE2DHnrUTc20xDcSEANK6xjnwSSdYBNpUO+
 BMSk40=
X-Google-Smtp-Source: AGHT+IHQcn6o9vL0DKukBicZxXf5jlnPgVwkw5NRn3XQUArCHgIhAqPC/pZJiy2cQc+ZBRVzB53WCJRorbmNiq6CAN8=
X-Received: by 2002:a17:90a:2ca7:b0:32b:4c51:628a with SMTP id
 98e67ed59e1d1-32b4c51649fmr6071177a91.8.1757090974664; Fri, 05 Sep 2025
 09:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250905112701.2443-1-christian.koenig@amd.com>
 <20250905112701.2443-3-christian.koenig@amd.com>
In-Reply-To: <20250905112701.2443-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Sep 2025 12:49:22 -0400
X-Gm-Features: Ac12FXy8-haxwLf1oTG6AYGyYVe8jAseDBzTvWJQ7vQJxhah8oW-4zUFXXopDBQ
Message-ID: <CADnq5_P7W5B4Li_q1zr1rK=mdBKT_z6z4g3b8dCvid+pGEKNRQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: revert "Rename VM invalidate to status
 lock" v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 "Yang, Philip" <Philip.Yang@amd.com>
Cc: Sunil.Khatri@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, Prike.Liang@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

+ Philip

On Fri, Sep 5, 2025 at 7:27=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> This reverts commit 0479956c94b1cfa6a1ab9206eff76072944ece8b.

I would come up with a new title.  At this point this is more than a
revert and I think calling it out like that could lead to problems in
stable kernels if someone just tries to revert the original commit in
an older kernel.  Moreover, 0479956c94b1 really isn't what is actually
being reverted.  That was just a renaming patch, so no functional
change.  The patch this is actually reverting is whatever patch added
the invalidated_lock in the first place.

Maybe something like:

drm/amdgpu: rework VM invalidation locking

It turned out that protecting the status of each bo_va only with a
spinlock was just hiding problems instead of solving them.
Add a separate stats_lock and lockdep assertions that the correct
reservation lock is held all over the place. While at it also re-order
fields in the VM structure and try to improve the documentation a bit.


Additionally is there a reason why the programming pattern changed in
the list handling?  Most of the instances of:

while (!list_empty()) {
    entry =3D list_first_entry();

got converted to:

list_for_each_entry_safe();

but not all.  Would be good to explain why if there is a reason other
than just coding style.

>
> It turned out that protecting the status of each bo_va only with a
> spinlock was just hiding problems instead of solving them.
>
> Revert the whole approach, add a separate stats_lock and lockdep
> assertions that the correct reservation lock is held all over the place.
>
> While at it also re-order fields in the VM structure and try to improve
> the documentation a bit.
>
> v2: re-add missing check
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 168 +++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  25 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>  4 files changed, 96 insertions(+), 109 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index cb3432b12221..dd57e034ae1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -619,12 +619,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev=
, struct drm_exec *exec,
>         struct amdgpu_bo *bo;
>         int ret;
>
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->invalidated_lock);
>         while (!list_empty(&vm->invalidated)) {
>                 bo_va =3D list_first_entry(&vm->invalidated,
>                                          struct amdgpu_bo_va,
>                                          base.vm_status);
> -               spin_unlock(&vm->status_lock);
> +               spin_unlock(&vm->invalidated_lock);
>
>                 bo =3D bo_va->base.bo;
>                 ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -641,9 +641,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, =
struct drm_exec *exec,
>                 if (ret)
>                         return ret;
>
> -               spin_lock(&vm->status_lock);
> +               spin_lock(&vm->invalidated_lock);
>         }
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->invalidated_lock);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 31976ef75014..2d5e78a14124 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -127,6 +127,17 @@ struct amdgpu_vm_tlb_seq_struct {
>         struct dma_fence_cb cb;
>  };
>
> +/**
> + * amdgpu_vm_assert_locked - check if VM is correctly locked
> + * @vm: the VM which schould be tested
> + *
> + * Asserts that the VM root PD is locked.
> + */
> +static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
> +{
> +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +}
> +
>  /**
>   * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>   *
> @@ -143,6 +154,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
>  {
>         int r;
>
> +       amdgpu_vm_assert_locked(vm);
> +
>         if (vm->pasid =3D=3D pasid)
>                 return 0;
>
> @@ -181,12 +194,11 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_b=
o_base *vm_bo)
>         struct amdgpu_bo *bo =3D vm_bo->bo;
>
>         vm_bo->moved =3D true;
> -       spin_lock(&vm_bo->vm->status_lock);
> +       amdgpu_vm_assert_locked(vm);
>         if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
>                 list_move(&vm_bo->vm_status, &vm->evicted);
>         else
>                 list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -       spin_unlock(&vm_bo->vm->status_lock);
>  }
>  /**
>   * amdgpu_vm_bo_moved - vm_bo is moved
> @@ -198,9 +210,8 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_=
base *vm_bo)
>   */
>  static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -       spin_lock(&vm_bo->vm->status_lock);
> +       amdgpu_vm_assert_locked(vm_bo->vm);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -       spin_unlock(&vm_bo->vm->status_lock);
>  }
>
>  /**
> @@ -213,9 +224,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_ba=
se *vm_bo)
>   */
>  static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -       spin_lock(&vm_bo->vm->status_lock);
> +       amdgpu_vm_assert_locked(vm_bo->vm);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -       spin_unlock(&vm_bo->vm->status_lock);
>         vm_bo->moved =3D false;
>  }
>
> @@ -229,9 +239,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_bas=
e *vm_bo)
>   */
>  static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -       spin_lock(&vm_bo->vm->status_lock);
> +       spin_lock(&vm_bo->vm->invalidated_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -       spin_unlock(&vm_bo->vm->status_lock);
> +       spin_unlock(&vm_bo->vm->invalidated_lock);
>  }
>
>  /**
> @@ -244,10 +254,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_v=
m_bo_base *vm_bo)
>   */
>  static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>  {
> +       amdgpu_vm_assert_locked(vm_bo->vm);
>         vm_bo->moved =3D true;
> -       spin_lock(&vm_bo->vm->status_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> -       spin_unlock(&vm_bo->vm->status_lock);
>  }
>
>  /**
> @@ -260,13 +269,11 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu=
_vm_bo_base *vm_bo)
>   */
>  static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -       if (vm_bo->bo->parent) {
> -               spin_lock(&vm_bo->vm->status_lock);
> +       amdgpu_vm_assert_locked(vm_bo->vm);
> +       if (vm_bo->bo->parent)
>                 list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -               spin_unlock(&vm_bo->vm->status_lock);
> -       } else {
> +       else
>                 amdgpu_vm_bo_idle(vm_bo);
> -       }
>  }
>
>  /**
> @@ -279,9 +286,8 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_b=
o_base *vm_bo)
>   */
>  static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>  {
> -       spin_lock(&vm_bo->vm->status_lock);
> +       amdgpu_vm_assert_locked(vm_bo->vm);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -       spin_unlock(&vm_bo->vm->status_lock);
>  }
>
>  /**
> @@ -295,10 +301,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct=
 amdgpu_vm *vm)
>  {
>         struct amdgpu_vm_bo_base *vm_bo, *tmp;
>
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->invalidated_lock);
>         list_splice_init(&vm->done, &vm->invalidated);
>         list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>                 vm_bo->moved =3D true;
> +       spin_unlock(&vm->invalidated_lock);
> +
> +       amdgpu_vm_assert_locked(vm_bo->vm);
>         list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>                 struct amdgpu_bo *bo =3D vm_bo->bo;
>
> @@ -308,14 +317,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct=
 amdgpu_vm *vm)
>                 else if (bo->parent)
>                         list_move(&vm_bo->vm_status, &vm_bo->vm->relocate=
d);
>         }
> -       spin_unlock(&vm->status_lock);
>  }
>
>  /**
>   * amdgpu_vm_update_shared - helper to update shared memory stat
>   * @base: base structure for tracking BO usage in a VM
>   *
> - * Takes the vm status_lock and updates the shared memory stat. If the b=
asic
> + * Takes the vm stats_lock and updates the shared memory stat. If the ba=
sic
>   * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to b=
e called
>   * as well.
>   */
> @@ -327,7 +335,8 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_=
bo_base *base)
>         uint32_t bo_memtype =3D amdgpu_bo_mem_stats_placement(bo);
>         bool shared;
>
> -       spin_lock(&vm->status_lock);
> +       dma_resv_assert_held(bo->tbo.base.resv);
> +       spin_lock(&vm->stats_lock);
>         shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo.bas=
e);
>         if (base->shared !=3D shared) {
>                 base->shared =3D shared;
> @@ -339,7 +348,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_=
bo_base *base)
>                         vm->stats[bo_memtype].drm.private +=3D size;
>                 }
>         }
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->stats_lock);
>  }
>
>  /**
> @@ -364,11 +373,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *b=
o)
>   *        be bo->tbo.resource
>   * @sign: if we should add (+1) or subtract (-1) from the stat
>   *
> - * Caller need to have the vm status_lock held. Useful for when multiple=
 update
> + * Caller need to have the vm stats_lock held. Useful for when multiple =
update
>   * need to happen at the same time.
>   */
>  static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base=
,
> -                           struct ttm_resource *res, int sign)
> +                                         struct ttm_resource *res, int s=
ign)
>  {
>         struct amdgpu_vm *vm =3D base->vm;
>         struct amdgpu_bo *bo =3D base->bo;
> @@ -392,7 +401,8 @@ static void amdgpu_vm_update_stats_locked(struct amdg=
pu_vm_bo_base *base,
>                  */
>                 if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>                         vm->stats[res_memtype].drm.purgeable +=3D size;
> -               if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(r=
es_memtype)))
> +               if (!(bo->preferred_domains &
> +                     amdgpu_mem_type_to_domain(res_memtype)))
>                         vm->stats[bo_memtype].evicted +=3D size;
>         }
>  }
> @@ -411,9 +421,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base =
*base,
>  {
>         struct amdgpu_vm *vm =3D base->vm;
>
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->stats_lock);
>         amdgpu_vm_update_stats_locked(base, res, sign);
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->stats_lock);
>  }
>
>  /**
> @@ -439,10 +449,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_bas=
e *base,
>         base->next =3D bo->vm_bo;
>         bo->vm_bo =3D base;
>
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->stats_lock);
>         base->shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->t=
bo.base);
>         amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->stats_lock);
>
>         if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>                 return;
> @@ -500,10 +510,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struc=
t drm_exec *exec,
>         int ret;
>
>         /* We can only trust prev->next while holding the lock */
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->invalidated_lock);
>         while (!list_is_head(prev->next, &vm->done)) {
>                 bo_va =3D list_entry(prev->next, typeof(*bo_va), base.vm_=
status);
> -               spin_unlock(&vm->status_lock);
> +               spin_unlock(&vm->invalidated_lock);
>
>                 bo =3D bo_va->base.bo;
>                 if (bo) {
> @@ -511,10 +521,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struc=
t drm_exec *exec,
>                         if (unlikely(ret))
>                                 return ret;
>                 }
> -               spin_lock(&vm->status_lock);
> +               spin_lock(&vm->invalidated_lock);
>                 prev =3D prev->next;
>         }
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->invalidated_lock);
>
>         return 0;
>  }
> @@ -610,7 +620,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>                        void *param)
>  {
>         uint64_t new_vm_generation =3D amdgpu_vm_generation(adev, vm);
> -       struct amdgpu_vm_bo_base *bo_base;
> +       struct amdgpu_vm_bo_base *bo_base, *tmp;
>         struct amdgpu_bo *bo;
>         int r;
>
> @@ -623,13 +633,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
>                         return r;
>         }
>
> -       spin_lock(&vm->status_lock);
> -       while (!list_empty(&vm->evicted)) {
> -               bo_base =3D list_first_entry(&vm->evicted,
> -                                          struct amdgpu_vm_bo_base,
> -                                          vm_status);
> -               spin_unlock(&vm->status_lock);
> -
> +       list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>                 bo =3D bo_base->bo;
>
>                 r =3D validate(param, bo);
> @@ -642,26 +646,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>                         vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>                         amdgpu_vm_bo_relocated(bo_base);
>                 }
> -               spin_lock(&vm->status_lock);
>         }
> -       while (ticket && !list_empty(&vm->evicted_user)) {
> -               bo_base =3D list_first_entry(&vm->evicted_user,
> -                                          struct amdgpu_vm_bo_base,
> -                                          vm_status);
> -               spin_unlock(&vm->status_lock);
>
> -               bo =3D bo_base->bo;
> -               dma_resv_assert_held(bo->tbo.base.resv);
> -
> -               r =3D validate(param, bo);
> -               if (r)
> -                       return r;
> +       if (ticket) {
> +               list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> +                                        vm_status) {
> +                       bo =3D bo_base->bo;
> +                       dma_resv_assert_held(bo->tbo.base.resv);
>
> -               amdgpu_vm_bo_invalidated(bo_base);
> +                       r =3D validate(param, bo);
> +                       if (r)
> +                               return r;
>
> -               spin_lock(&vm->status_lock);
> +                       amdgpu_vm_bo_invalidated(bo_base);
> +               }
>         }
> -       spin_unlock(&vm->status_lock);
>
>         amdgpu_vm_eviction_lock(vm);
>         vm->evicting =3D false;
> @@ -684,13 +683,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  {
>         bool ret;
>
> +       amdgpu_vm_assert_locked(vm);
> +
>         amdgpu_vm_eviction_lock(vm);
>         ret =3D !vm->evicting;
>         amdgpu_vm_eviction_unlock(vm);
>
> -       spin_lock(&vm->status_lock);
>         ret &=3D list_empty(&vm->evicted);
> -       spin_unlock(&vm->status_lock);
>
>         spin_lock(&vm->immediate.lock);
>         ret &=3D !vm->immediate.stopped;
> @@ -981,16 +980,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *ade=
v,
>                           struct amdgpu_vm *vm, bool immediate)
>  {
>         struct amdgpu_vm_update_params params;
> -       struct amdgpu_vm_bo_base *entry;
> +       struct amdgpu_vm_bo_base *entry, *tmp;
>         bool flush_tlb_needed =3D false;
> -       LIST_HEAD(relocated);
>         int r, idx;
>
> -       spin_lock(&vm->status_lock);
> -       list_splice_init(&vm->relocated, &relocated);
> -       spin_unlock(&vm->status_lock);
> +       amdgpu_vm_assert_locked(vm);
>
> -       if (list_empty(&relocated))
> +       if (list_empty(&vm->relocated))
>                 return 0;
>
>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -1005,7 +1001,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *ade=
v,
>         if (r)
>                 goto error;
>
> -       list_for_each_entry(entry, &relocated, vm_status) {
> +       list_for_each_entry(entry, &vm->relocated, vm_status) {
>                 /* vm_flush_needed after updating moved PDEs */
>                 flush_tlb_needed |=3D entry->moved;
>
> @@ -1021,9 +1017,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *ade=
v,
>         if (flush_tlb_needed)
>                 atomic64_inc(&vm->tlb_seq);
>
> -       while (!list_empty(&relocated)) {
> -               entry =3D list_first_entry(&relocated, struct amdgpu_vm_b=
o_base,
> -                                        vm_status);
> +       list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
>                 amdgpu_vm_bo_idle(entry);
>         }
>
> @@ -1249,9 +1243,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
>  void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>                           struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>  {
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->stats_lock);
>         memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->stats_lock);
>  }
>
>  /**
> @@ -1618,29 +1612,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *=
adev,
>                            struct amdgpu_vm *vm,
>                            struct ww_acquire_ctx *ticket)
>  {
> -       struct amdgpu_bo_va *bo_va;
> +       struct amdgpu_bo_va *bo_va, *tmp;
>         struct dma_resv *resv;
>         bool clear, unlock;
>         int r;
>
> -       spin_lock(&vm->status_lock);
> -       while (!list_empty(&vm->moved)) {
> -               bo_va =3D list_first_entry(&vm->moved, struct amdgpu_bo_v=
a,
> -                                        base.vm_status);
> -               spin_unlock(&vm->status_lock);
> -
> +       list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) =
{
>                 /* Per VM BOs never need to bo cleared in the page tables=
 */
>                 r =3D amdgpu_vm_bo_update(adev, bo_va, false);
>                 if (r)
>                         return r;
> -               spin_lock(&vm->status_lock);
>         }
>
> +       spin_lock(&vm->invalidated_lock);
>         while (!list_empty(&vm->invalidated)) {
>                 bo_va =3D list_first_entry(&vm->invalidated, struct amdgp=
u_bo_va,
>                                          base.vm_status);

Why is this not converted to  list_for_each_entry_safe() like all of
the others above?

Alex


>                 resv =3D bo_va->base.bo->tbo.base.resv;
> -               spin_unlock(&vm->status_lock);
> +               spin_unlock(&vm->invalidated_lock);
>
>                 /* Try to reserve the BO to avoid clearing its ptes */
>                 if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1672,9 +1661,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ad=
ev,
>                      bo_va->base.bo->tbo.resource->mem_type =3D=3D TTM_PL=
_SYSTEM))
>                         amdgpu_vm_bo_evicted_user(&bo_va->base);
>
> -               spin_lock(&vm->status_lock);
> +               spin_lock(&vm->invalidated_lock);
>         }
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->invalidated_lock);
>
>         return 0;
>  }
> @@ -2203,9 +2192,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>                 }
>         }
>
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->invalidated_lock);
>         list_del(&bo_va->base.vm_status);
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->invalidated_lock);
>
>         list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>                 list_del(&mapping->list);
> @@ -2313,10 +2302,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, stru=
ct ttm_resource *new_mem,
>         for (bo_base =3D bo->vm_bo; bo_base; bo_base =3D bo_base->next) {
>                 struct amdgpu_vm *vm =3D bo_base->vm;
>
> -               spin_lock(&vm->status_lock);
> +               spin_lock(&vm->stats_lock);
>                 amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, =
-1);
>                 amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
> -               spin_unlock(&vm->status_lock);
> +               spin_unlock(&vm->stats_lock);
>         }
>
>         amdgpu_vm_bo_invalidate(bo, evicted);
> @@ -2583,11 +2572,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>         INIT_LIST_HEAD(&vm->relocated);
>         INIT_LIST_HEAD(&vm->moved);
>         INIT_LIST_HEAD(&vm->idle);
> +       spin_lock_init(&vm->invalidated_lock);
>         INIT_LIST_HEAD(&vm->invalidated);
> -       spin_lock_init(&vm->status_lock);
>         INIT_LIST_HEAD(&vm->freed);
>         INIT_LIST_HEAD(&vm->done);
>         INIT_KFIFO(vm->faults);
> +       spin_lock_init(&vm->stats_lock);
>
>         r =3D amdgpu_vm_init_entities(adev, vm);
>         if (r)
> @@ -3052,7 +3042,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm=
, struct seq_file *m)
>         unsigned int total_done_objs =3D 0;
>         unsigned int id =3D 0;
>
> -       spin_lock(&vm->status_lock);
> +       amdgpu_vm_assert_locked(vm);
> +
>         seq_puts(m, "\tIdle BOs:\n");
>         list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>                 if (!bo_va->base.bo)
> @@ -3090,11 +3081,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *=
vm, struct seq_file *m)
>         id =3D 0;
>
>         seq_puts(m, "\tInvalidated BOs:\n");
> +       spin_lock(&vm->invalidated_lock);
>         list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_st=
atus) {
>                 if (!bo_va->base.bo)
>                         continue;
>                 total_invalidated +=3D amdgpu_bo_print_info(id++, bo_va->=
base.bo, m);
>         }
> +       spin_unlock(&vm->invalidated_lock);
>         total_invalidated_objs =3D id;
>         id =3D 0;
>
> @@ -3104,7 +3097,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm=
, struct seq_file *m)
>                         continue;
>                 total_done +=3D amdgpu_bo_print_info(id++, bo_va->base.bo=
, m);
>         }
> -       spin_unlock(&vm->status_lock);
>         total_done_objs =3D id;
>
>         seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", to=
tal_idle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index f86b1a6afb0c..03219ba110b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
>         /* protected by bo being reserved */
>         struct amdgpu_vm_bo_base        *next;
>
> -       /* protected by vm status_lock */
> +       /* protected by vm reservation and status_lock */
>         struct list_head                vm_status;
>
>         /* if the bo is counted as shared in mem stats
> -        * protected by vm status_lock */
> +        * protected by vm BO being reserved */
>         bool                            shared;
>
>         /* protected by the BO being reserved */
> @@ -343,18 +343,13 @@ struct amdgpu_vm {
>         bool                    evicting;
>         unsigned int            saved_flags;
>
> -       /* Lock to protect vm_bo add/del/move on all lists of vm */
> -       spinlock_t              status_lock;
> -
> -       /* Memory statistics for this vm, protected by status_lock */
> +       /* Memory statistics for this vm, protected by stats_lock */
> +       spinlock_t              stats_lock;
>         struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>
>         /* Per-VM and PT BOs who needs a validation */
>         struct list_head        evicted;
>
> -       /* BOs for user mode queues that need a validation */
> -       struct list_head        evicted_user;
> -
>         /* PT BOs which relocated and their parent need an update */
>         struct list_head        relocated;
>
> @@ -364,15 +359,19 @@ struct amdgpu_vm {
>         /* All BOs of this VM not currently in the state machine */
>         struct list_head        idle;
>
> -       /* regular invalidated BOs, but not yet updated in the PT */
> +       /* Regular BOs for KFD queues that need a validation */
> +       struct list_head        evicted_user;
> +
> +       /* Regular invalidated BOs, need to be validated and updated in t=
he PT */
> +       spinlock_t              invalidated_lock;
>         struct list_head        invalidated;
>
> +       /* Regular BOs which are validated and location has been updated =
in the PTs */
> +       struct list_head        done;
> +
>         /* BO mappings freed, but not yet updated in the PT */
>         struct list_head        freed;
>
> -       /* BOs which are invalidated, has been updated in the PTs */
> -       struct list_head        done;
> -
>         /* contains the page directory */
>         struct amdgpu_vm_bo_base     root;
>         struct dma_fence        *last_update;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index 30022123b0bf..f57c48b74274 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -541,9 +541,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_bas=
e *entry)
>         entry->bo->vm_bo =3D NULL;
>         ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>
> -       spin_lock(&entry->vm->status_lock);
>         list_del(&entry->vm_status);
> -       spin_unlock(&entry->vm->status_lock);
>         amdgpu_bo_unref(&entry->bo);
>  }
>
> @@ -587,7 +585,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_up=
date_params *params,
>         struct amdgpu_vm_pt_cursor seek;
>         struct amdgpu_vm_bo_base *entry;
>
> -       spin_lock(&params->vm->status_lock);
>         for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, =
seek, entry) {
>                 if (entry && entry->bo)
>                         list_move(&entry->vm_status, &params->tlb_flush_w=
aitlist);
> @@ -595,7 +592,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_up=
date_params *params,
>
>         /* enter start node now */
>         list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist)=
;
> -       spin_unlock(&params->vm->status_lock);
>  }
>
>  /**
> --
> 2.43.0
>
