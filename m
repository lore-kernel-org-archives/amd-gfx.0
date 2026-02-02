Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89921E7FDE0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 21:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BFC10E457;
	Mon,  2 Feb 2026 21:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYdY/XB+";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 475A410E457
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 21:51:07 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1233608c7e9so250027c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 13:51:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770069066; cv=none;
 d=google.com; s=arc-20240605;
 b=FpdmSRgW4bPnx9DFLrrIzVzkWYDm90cW5PUITxZhaVaLxMycgxxZegYa//y74o4vD6
 Cg0cIziMM8NNeQwocGWfvxZp9NACmUTNM1IgTRLf+uTJ0DOLBL2xfzRPaQeRSgiXre4B
 UcoRm7Qq+vkalW9E34/3FxCEMZiR+uienqqdDuA0StvaWQgZkn+CMwiIsxDKzhik/stU
 ffWYQsAcEyAvx4NmIxAU0zVPnP/OJ2+TedkuIlx2MGRaIxdCoaalMc/5CxA1bgQRubY0
 6bYfEDzPuGSb1HBWEvOvIdfSHzDrZVyAf2/kToSdWGIkuVobI6NDbXUTCa80c8d2KpJw
 R2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1o8oZaHdnnQyOnnx3/qnzqzn5Ij5kIg0OtYrXdB8GxY=;
 fh=UxfrRZ5KTqdMJYl2uvQrXeXqWRKN2iNswRW1EVURe8Q=;
 b=CH1ovsBkaQ1g1qXEFkFwouMPDFf3gfavt/6yuAfhxqQKxFx+7n2FFeabaxVtW8TfCE
 UQgce1k6VPVL+ItoUNRMz0eJsoxkVscSD3ZD0wPp3/mOmp/yrkHY3gnPEdYzu68PH3aJ
 BAcFKOyKy8W+7dL2c1Hcm34IrbyIzEux357N9PrEPtlZghy5nrYGMyTWeC75sLkE7QpM
 LlbixXzna4iQF1KCTSsAM0FP8wi4SPyoKqQEeukWUwBcFP5nShDbcE3uFaiuXgS4Kbxo
 W3Xd+tG18XUX2Nb8LJuD3eHG/y62fcVSWDrHZAUa635HbWR4bQ5IHNNWlmtSGWTqvo3t
 5DHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770069066; x=1770673866; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1o8oZaHdnnQyOnnx3/qnzqzn5Ij5kIg0OtYrXdB8GxY=;
 b=HYdY/XB+OC/Gbr/uHfE0AeAz+TCU8g3MXmchhYU6Cc0nYRjZAnkZOj9/hPTz135hEn
 wwe1p0VoMtz0+uQ4oHjV4QJdgTNhHtMVNd8Sr63x36tiQWUDzrJF1P9WdtxRASeBmzrT
 KTsyDRJRRVHpWcs7xcIRPUT0U1xUdn2VXn4aWe4WE5ynjGZgT/6sty2hnMny3P91tqD5
 sdOZT2C23v2mxyiKMO01cjEW3rzvhX6XL8D4QKVV/qefMjycro1TWAAhSSlupHunrsHF
 QgmbRKmXojygFbhsRUWe75oTVwM+I6bLkz0r/l9vlRmHuFyb/A86M9s37FkVYjR/UTXY
 Fjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770069066; x=1770673866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1o8oZaHdnnQyOnnx3/qnzqzn5Ij5kIg0OtYrXdB8GxY=;
 b=WZT+5zsTG3OqZHNuZXkKs1pKHda1O5MdwucnMlvgmG1jMRnDxCuYklQTHU0NjSWe+b
 OGRsMgSiIpA0Acjggudh7jQIV4DkemroNEV/Cc79IUkkr4oot9rF47D+YkayWPohALjy
 CqvAKj/tGOjC6gHkB2RB3WrrubDDo/7D8FitthcfOhmc7dVA0v06sJqUVTkkouezKZnD
 PWabP3Pj41Gg3HF+ZOTVokABYpOU9REPvs+NnztLhGGkn9+Rzeth+hBOfCJuPEByws1S
 zKN3+TQG2iWouE/1AjPLJZ5uo7K018lQr+JVG6WW0fpk4MfjELNmUbTJ2JD+iepQgQso
 FvOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsg1RPmkkeovbEg867jPS1WV52OD6irtaOoRalDqgC4Xh2+PP26fA9dY/32UNQENwAllrD9Hxy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQlyq7dSzQwidWjK8sGWwqHyBZ6QEy7n0O+sVjsCOeuC4wHgCj
 dm56jSJPzLxdWhxXOTvp+g8T+N2gbaAWXcbogOooiMjvJH0B7sp6gVolM9sj+Q3pvuUQ/qXxta6
 cUUDgdMQkPkhFDtDDYte7ntS7OhTrrN+rfmkW
X-Gm-Gg: AZuq6aLSHTwN6haJWcxDEac9MgQzxPJJXV8QcNM9byLTAfGFHI/0DMgP+iMscEE0k2E
 39meJLvDSKy1c3C9KKKUOhIuS1x+1MBxh+wX5Uaz/oCvqn0VIqtqY+C0JIAqROELulp3blAS6XL
 3PJsLGpTgHKFDyz9WoZfCU4edeJOaDDJSykIVNEgrDIN03ah0c3olZ8WXsOsVEqoF7/l0faaa2t
 vrA1KLHJOCPszjn1PuVABM04usC4mzCX/mjGseLcwuSCIKDzu0UdY0J6kb/gIo9xhFIeuup
X-Received: by 2002:a05:7022:ea21:b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-125c0fbfedfmr3092031c88.3.1770069066301; Mon, 02 Feb 2026
 13:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20260202125149.2067-1-christian.koenig@amd.com>
 <20260202125149.2067-2-christian.koenig@amd.com>
In-Reply-To: <20260202125149.2067-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 16:50:54 -0500
X-Gm-Features: AZwV_QhB1ZKwARCS1hZ77uwlnBr5B8Z9F9bqDovCO4xvoUPu43C_fDAQk2ZlsDA
Message-ID: <CADnq5_OgY3fv_UQ3iLsB8XgTu+74Ai4cFz+_p-BL=jVUe2RxOw@mail.gmail.com>
Subject: Re: [PATCH 2/9] drm/amdgpu: revert to old status lock handling v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com, 
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com, 
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
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

On Mon, Feb 2, 2026 at 1:12=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> This reverts commit 7e64d0e5979157ee5fc83e58ac61b4a36803c7f1.
>
> The problems were caused by not holding the VM lock while adding new
> BOs.

I think it would be clearer to restate the original commit message as
this just reverts a partial revert of a revert and the original goal
of the change is hard to sort out without digging through the commit
history.  E.g., from the original change:

Re-add a separate stats_lock and lockdep assertions that the correct
reservation lock is held all over the place.

This not only allows for better checks if a state transition is properly
protected by a lock, but also switching back to using list macros to
iterate over the state of lists protected by the dma_resv lock of the
root PD.

With that cleaned up,

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 146 ++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>  4 files changed, 68 insertions(+), 105 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index b700c2b91465..8feeaeea1c36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1058,12 +1058,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *ad=
ev, struct drm_exec *exec,
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
> @@ -1080,9 +1080,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev=
, struct drm_exec *exec,
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
> index b4bf1b7c214f..a8a4fffc5764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -153,12 +153,10 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_b=
o_base *vm_bo)
>
>         vm_bo->moved =3D true;
>         amdgpu_vm_assert_locked(vm);
> -       spin_lock(&vm_bo->vm->status_lock);
>         if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
>                 list_move(&vm_bo->vm_status, &vm->evicted);
>         else
>                 list_move_tail(&vm_bo->vm_status, &vm->evicted);
> -       spin_unlock(&vm_bo->vm->status_lock);
>  }
>  /**
>   * amdgpu_vm_bo_moved - vm_bo is moved
> @@ -171,9 +169,7 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_=
base *vm_bo)
>  static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>  {
>         amdgpu_vm_assert_locked(vm_bo->vm);
> -       spin_lock(&vm_bo->vm->status_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -       spin_unlock(&vm_bo->vm->status_lock);
>  }
>
>  /**
> @@ -187,9 +183,7 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_ba=
se *vm_bo)
>  static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>  {
>         amdgpu_vm_assert_locked(vm_bo->vm);
> -       spin_lock(&vm_bo->vm->status_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -       spin_unlock(&vm_bo->vm->status_lock);
>         vm_bo->moved =3D false;
>  }
>
> @@ -203,9 +197,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_bas=
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
> @@ -218,10 +212,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_v=
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
> @@ -235,13 +228,10 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu=
_vm_bo_base *vm_bo)
>  static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>  {
>         amdgpu_vm_assert_locked(vm_bo->vm);
> -       if (vm_bo->bo->parent) {
> -               spin_lock(&vm_bo->vm->status_lock);
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
> @@ -255,9 +245,7 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_b=
o_base *vm_bo)
>  static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>  {
>         amdgpu_vm_assert_locked(vm_bo->vm);
> -       spin_lock(&vm_bo->vm->status_lock);
>         list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> -       spin_unlock(&vm_bo->vm->status_lock);
>  }
>
>  /**
> @@ -271,13 +259,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct=
 amdgpu_vm *vm)
>  {
>         struct amdgpu_vm_bo_base *vm_bo, *tmp;
>
> -       amdgpu_vm_assert_locked(vm);
> -
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->invalidated_lock);
>         list_splice_init(&vm->done, &vm->invalidated);
>         list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>                 vm_bo->moved =3D true;
> +       spin_unlock(&vm->invalidated_lock);
>
> +       amdgpu_vm_assert_locked(vm);
>         list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>                 struct amdgpu_bo *bo =3D vm_bo->bo;
>
> @@ -287,14 +275,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct=
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
> @@ -307,7 +294,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_=
bo_base *base)
>         bool shared;
>
>         dma_resv_assert_held(bo->tbo.base.resv);
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->stats_lock);
>         shared =3D drm_gem_object_is_shared_for_memory_stats(&bo->tbo.bas=
e);
>         if (base->shared !=3D shared) {
>                 base->shared =3D shared;
> @@ -319,7 +306,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_=
bo_base *base)
>                         vm->stats[bo_memtype].drm.private +=3D size;
>                 }
>         }
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->stats_lock);
>  }
>
>  /**
> @@ -344,11 +331,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *b=
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
> @@ -372,7 +359,8 @@ static void amdgpu_vm_update_stats_locked(struct amdg=
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
> @@ -391,9 +379,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base =
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
> @@ -419,10 +407,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_bas=
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
> @@ -481,25 +469,25 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, =
struct drm_exec *exec,
>         int ret;
>
>         /* We can only trust prev->next while holding the lock */
> -       spin_lock(&vm->status_lock);
> +       spin_lock(&vm->invalidated_lock);
>         while (!list_is_head(prev->next, &vm->done)) {
>                 bo_va =3D list_entry(prev->next, typeof(*bo_va), base.vm_=
status);
>
>                 bo =3D bo_va->base.bo;
>                 if (bo) {
>                         amdgpu_bo_ref(bo);
> -                       spin_unlock(&vm->status_lock);
> +                       spin_unlock(&vm->invalidated_lock);
>
>                         ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base,=
 1);
>                         amdgpu_bo_unref(&bo);
>                         if (unlikely(ret))
>                                 return ret;
>
> -                       spin_lock(&vm->status_lock);
> +                       spin_lock(&vm->invalidated_lock);
>                 }
>                 prev =3D prev->next;
>         }
> -       spin_unlock(&vm->status_lock);
> +       spin_unlock(&vm->invalidated_lock);
>
>         return 0;
>  }
> @@ -595,7 +583,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm,
>                        void *param)
>  {
>         uint64_t new_vm_generation =3D amdgpu_vm_generation(adev, vm);
> -       struct amdgpu_vm_bo_base *bo_base;
> +       struct amdgpu_vm_bo_base *bo_base, *tmp;
>         struct amdgpu_bo *bo;
>         int r;
>
> @@ -608,13 +596,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, s=
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
> @@ -627,26 +609,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
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
> +       if (ticket) {
> +               list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> +                                        vm_status) {
> +                       bo =3D bo_base->bo;
> +                       dma_resv_assert_held(bo->tbo.base.resv);
>
> -               r =3D validate(param, bo);
> -               if (r)
> -                       return r;
> -
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
> @@ -675,9 +652,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>         ret =3D !vm->evicting;
>         amdgpu_vm_eviction_unlock(vm);
>
> -       spin_lock(&vm->status_lock);
>         ret &=3D list_empty(&vm->evicted);
> -       spin_unlock(&vm->status_lock);
>
>         spin_lock(&vm->immediate.lock);
>         ret &=3D !vm->immediate.stopped;
> @@ -967,18 +942,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *ade=
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
>         amdgpu_vm_assert_locked(vm);
>
> -       spin_lock(&vm->status_lock);
> -       list_splice_init(&vm->relocated, &relocated);
> -       spin_unlock(&vm->status_lock);
> -
> -       if (list_empty(&relocated))
> +       if (list_empty(&vm->relocated))
>                 return 0;
>
>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -994,7 +964,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>         if (r)
>                 goto error;
>
> -       list_for_each_entry(entry, &relocated, vm_status) {
> +       list_for_each_entry(entry, &vm->relocated, vm_status) {
>                 /* vm_flush_needed after updating moved PDEs */
>                 flush_tlb_needed |=3D entry->moved;
>
> @@ -1010,9 +980,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev=
,
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
> @@ -1239,9 +1207,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
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
> @@ -1608,29 +1576,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *=
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
>                 resv =3D bo_va->base.bo->tbo.base.resv;
> -               spin_unlock(&vm->status_lock);
> +               spin_unlock(&vm->invalidated_lock);
>
>                 /* Try to reserve the BO to avoid clearing its ptes */
>                 if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1662,9 +1625,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *ad=
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
> @@ -2207,9 +2170,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
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
> @@ -2317,10 +2280,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, stru=
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
> @@ -2608,11 +2571,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
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
> @@ -3080,7 +3044,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm=
, struct seq_file *m)
>
>         amdgpu_vm_assert_locked(vm);
>
> -       spin_lock(&vm->status_lock);
>         seq_puts(m, "\tIdle BOs:\n");
>         list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>                 if (!bo_va->base.bo)
> @@ -3118,11 +3081,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *=
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
> @@ -3132,7 +3097,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm=
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
> index 139642eacdd0..db9664ec55a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -205,11 +205,11 @@ struct amdgpu_vm_bo_base {
>         /* protected by bo being reserved */
>         struct amdgpu_vm_bo_base        *next;
>
> -       /* protected by vm status_lock */
> +       /* protected by vm reservation and invalidated_lock */
>         struct list_head                vm_status;
>
>         /* if the bo is counted as shared in mem stats
> -        * protected by vm status_lock */
> +        * protected by vm BO being reserved */
>         bool                            shared;
>
>         /* protected by the BO being reserved */
> @@ -345,10 +345,8 @@ struct amdgpu_vm {
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
>         /*
> @@ -356,6 +354,8 @@ struct amdgpu_vm {
>          * PDs, PTs or per VM BOs. The state transits are:
>          *
>          * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> +        *
> +        * Lists are protected by the root PD dma_resv lock.
>          */
>
>         /* Per-VM and PT BOs who needs a validation */
> @@ -376,7 +376,10 @@ struct amdgpu_vm {
>          * state transits are:
>          *
>          * evicted_user or invalidated -> done
> +        *
> +        * Lists are protected by the invalidated_lock.
>          */
> +       spinlock_t              invalidated_lock;
>
>         /* BOs for user mode queues that need a validation */
>         struct list_head        evicted_user;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_pt.c
> index 31a437ce9570..7bdd664f0770 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -544,9 +544,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_bas=
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
> @@ -590,7 +588,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_up=
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
> @@ -598,7 +595,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_up=
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
