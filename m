Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A71CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 16:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AE010E0E1;
	Thu, 11 Sep 2025 16:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6gaXhgI";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBAE10E0E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 16:24:36 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7728ec910caso71466b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757607876; x=1758212676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlyuT+cnwZbhSVw/EjsAxFo4e+KzcWKBTrT8vxth9Ew=;
 b=V6gaXhgIzkuraKGeVyYfAJuuK94kOU5m+xEOGFCnqpQpYeFQIhvgsp3x+d0c1MqY1B
 8ADfSTMi5kpV2wmty9EOI1eUstlAurzJIqx6GpgC5KVdqT4jmmotsvjxjJ0bQUgSoNvF
 OoIU7YFv8qgH5rwoAqAm+iAQsPxQEBqh1nKv0bsQ5xxMfAw6aCL16eh9+5v9L6Nix5q3
 uMkhAD0kp5WGbGaDhFlmmanXv5Mo5mEdWpUJJ72Gwi3u1zEih2aNvqbEgMJWiBw54g1D
 03CEkoaP7JWlMoNAab45+DcA6F11FA3PtxZt5ZDSFgBKlBAEHGiSGSM7RGVRwcZrK8dK
 nllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757607876; x=1758212676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlyuT+cnwZbhSVw/EjsAxFo4e+KzcWKBTrT8vxth9Ew=;
 b=Aq0r2w+wAyPE46S56NK2Z+z7D9tJAEJkRVSu5XxCHnPdK5PBJy3UfKSrmloS06kxxJ
 CyxIXhSwVNKf/wUqKVqzI2Mr3KJuzb0/dB9TQMbSaRrvIkleNUa07ixAL2rOTiu0mThu
 77IroJTOANCX3wRMZj2Q8GSpUst1iRuqzzr63E9eH64WnoGGt2071sP1UUkPYDr/5WXG
 /g4T7kj8n/Pt2XezlqiFVPSdSjsf9lcJKORfKdcCVPDYkJ9sI+XtPLutFM+U7Erfi3sH
 uBp+s4aFxc134OAf2aPqF/xGZhGIsmHwcg4hAMXgeFYCra4rAjO7SLxQeUaGrNqmfNBM
 9B5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl/y6Nvg0b1elUA+BoyFHWSW6Jk7IjtcuR5P6QDr411Zjss/9F9voNRwg0AGPpDMERAzaNM/pr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpeLh+EJo3/OsZU2+yMLUPXftpwZmuXPr+trjftejWXq+cn15L
 ygyTa/U2OnLGKYvWCPSsexzXTKNxh1FKQ7Trsj4yUeKWNs7eHidutCziAvoQ96O4QUQ4eIT6YY6
 kVVBjruT/W9vGReSG/W1A13/ivoWWkBA=
X-Gm-Gg: ASbGncszW0UteSQtOaQug8b9USPO4Z6KJENU+Q6Kdzag8q6mz1wOTNbuXpp2j9vG9rS
 grf75UWPIXS1E8jadKAqWR4d76tm/qUAxZR7sRPQYlKN9bzrARUETIa/JEZ12BGVd967Cz5/nH6
 IVDkBa6LoS6cagpP3Ogm7w3vHZLqi9VBIo/AQpX7NrZierh9tD12Sqh16+LJ0kll0K1aojj0Fyn
 vpyu9c=
X-Google-Smtp-Source: AGHT+IH7H9l3kci7TQw5uzLqACkE+ywxMBEFwXovrnWnYp4MFgNkID6ZljiLoE2hdcGPdzuofICGukJiiTXVr6Nx1gE=
X-Received: by 2002:a05:6a20:1595:b0:240:d39:ffc1 with SMTP id
 adf61e73a8af0-2534547a733mr12759113637.5.1757607875417; Thu, 11 Sep 2025
 09:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250911120950.3343-1-christian.koenig@amd.com>
In-Reply-To: <20250911120950.3343-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 12:24:23 -0400
X-Gm-Features: Ac12FXxB5HCbHMUe1fPKcrnhVXXBOmYeN--eLi5jqBSksnquuXYnYVkW4m7PaMU
Message-ID: <CADnq5_PL+4iWUF_jN25i8z=TQOTZB_AvQakW89WxxbpGQDx1gA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: fix userq VM validation v4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Sunil.Khatri@amd.com, Philip.Yang@amd.com, Prike.Liang@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Thu, Sep 11, 2025 at 8:09=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That was actually complete nonsense and not validating the BOs
> at all. The code just cleared all VM areas were it couldn't grab the
> lock for a BO.
>
> Try to fix this. Only compile tested at the moment.
>
> v2: fix fence slot reservation as well as pointed out by Sunil.
>     also validate PDs, PTs, per VM BOs and update PDEs
> v3: grab the status_lock while working with the done list.
> v4: rename functions, add some comments, fix waiting for updates to
>     complete.
> v4: rename amdgpu_vm_lock_done_list(), add some more comments
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 148 +++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  35 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |   2 +
>  3 files changed, 110 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 9608fe3b5a9e..0ccbd3c5d88d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -661,108 +661,106 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr =
*uq_mgr)
>         return ret;
>  }
>
> +static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
> +{
> +       struct ttm_operation_ctx ctx =3D { false, false };
> +
> +       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +       return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +}
> +
> +/* Handle all BOs on the invalidated list, validate them and update the =
PTs */
>  static int
> -amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
> +amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *ex=
ec,
> +                        struct amdgpu_vm *vm)
>  {
>         struct ttm_operation_ctx ctx =3D { false, false };
> +       struct amdgpu_bo_va *bo_va;
> +       struct amdgpu_bo *bo;
>         int ret;
>
> -       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +       spin_lock(&vm->status_lock);
> +       while (!list_empty(&vm->invalidated)) {
> +               bo_va =3D list_first_entry(&vm->invalidated,
> +                                        struct amdgpu_bo_va,
> +                                        base.vm_status);
> +               spin_unlock(&vm->status_lock);
>
> -       ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -       if (ret)
> -               DRM_ERROR("Fail to validate\n");
> +               bo =3D bo_va->base.bo;
> +               ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> +               if (unlikely(ret))
> +                       return ret;
>
> -       return ret;
> +               amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +               ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +               if (ret)
> +                       return ret;
> +
> +               /* This moves the bo_va to the done list */
> +               ret =3D amdgpu_vm_bo_update(adev, bo_va, false);
> +               if (ret)
> +                       return ret;
> +
> +               spin_lock(&vm->status_lock);
> +       }
> +       spin_unlock(&vm->status_lock);
> +
> +       return 0;
>  }
>
> +/* Make sure the whole VM is ready to be used */
>  static int
> -amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  {
>         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
> -       struct amdgpu_vm *vm =3D &fpriv->vm;
>         struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_vm *vm =3D &fpriv->vm;
>         struct amdgpu_bo_va *bo_va;
> -       struct ww_acquire_ctx *ticket;
>         struct drm_exec exec;
> -       struct amdgpu_bo *bo;
> -       struct dma_resv *resv;
> -       bool clear, unlock;
> -       int ret =3D 0;
> +       int ret;
>
>         drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>         drm_exec_until_all_locked(&exec) {
> -               ret =3D amdgpu_vm_lock_pd(vm, &exec, 2);
> +               ret =3D amdgpu_vm_lock_pd(vm, &exec, 1);
>                 drm_exec_retry_on_contention(&exec);
> -               if (unlikely(ret)) {
> -                       drm_file_err(uq_mgr->file, "Failed to lock PD\n")=
;
> +               if (unlikely(ret))
>                         goto unlock_all;
> -               }
> -
> -               /* Lock the done list */
> -               list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> -                       bo =3D bo_va->base.bo;
> -                       if (!bo)
> -                               continue;
>
> -                       ret =3D drm_exec_lock_obj(&exec, &bo->tbo.base);
> -                       drm_exec_retry_on_contention(&exec);
> -                       if (unlikely(ret))
> -                               goto unlock_all;
> -               }
> -       }
> -
> -       spin_lock(&vm->status_lock);
> -       while (!list_empty(&vm->moved)) {
> -               bo_va =3D list_first_entry(&vm->moved, struct amdgpu_bo_v=
a,
> -                                        base.vm_status);
> -               spin_unlock(&vm->status_lock);
> -
> -               /* Per VM BOs never need to bo cleared in the page tables=
 */
> -               ret =3D amdgpu_vm_bo_update(adev, bo_va, false);
> -               if (ret)
> +               ret =3D amdgpu_vm_lock_done_list(vm, &exec, 1);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(ret))
>                         goto unlock_all;
> -               spin_lock(&vm->status_lock);
> -       }
> -
> -       ticket =3D &exec.ticket;
> -       while (!list_empty(&vm->invalidated)) {
> -               bo_va =3D list_first_entry(&vm->invalidated, struct amdgp=
u_bo_va,
> -                                        base.vm_status);
> -               resv =3D bo_va->base.bo->tbo.base.resv;
> -               spin_unlock(&vm->status_lock);
>
> -               bo =3D bo_va->base.bo;
> -               ret =3D amdgpu_userq_validate_vm_bo(NULL, bo);
> -               if (ret) {
> -                       drm_file_err(uq_mgr->file, "Failed to validate BO=
\n");
> +               /* This validates PDs, PTs and per VM BOs */
> +               ret =3D amdgpu_vm_validate(adev, vm, NULL,
> +                                        amdgpu_userq_validate_vm,
> +                                        NULL);
> +               if (unlikely(ret))
>                         goto unlock_all;
> -               }
>
> -               /* Try to reserve the BO to avoid clearing its ptes */
> -               if (!adev->debug_vm && dma_resv_trylock(resv)) {
> -                       clear =3D false;
> -                       unlock =3D true;
> -               /* The caller is already holding the reservation lock */
> -               } else if (dma_resv_locking_ctx(resv) =3D=3D ticket) {
> -                       clear =3D false;
> -                       unlock =3D false;
> -               /* Somebody else is using the BO right now */
> -               } else {
> -                       clear =3D true;
> -                       unlock =3D false;
> -               }
> +               /* This locks and validates the remaining evicted BOs */
> +               ret =3D amdgpu_userq_bo_validate(adev, &exec, vm);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(ret))
> +                       goto unlock_all;
> +       }
>
> -               ret =3D amdgpu_vm_bo_update(adev, bo_va, clear);
> +       ret =3D amdgpu_vm_handle_moved(adev, vm, NULL);
> +       if (ret)
> +               goto unlock_all;
>
> -               if (unlock)
> -                       dma_resv_unlock(resv);
> -               if (ret)
> -                       goto unlock_all;
> +       ret =3D amdgpu_vm_update_pdes(adev, vm, false);
> +       if (ret)
> +               goto unlock_all;
>
> -               spin_lock(&vm->status_lock);
> -       }
> -       spin_unlock(&vm->status_lock);
> +       /*
> +        * We need to wait for all VM updates to finish before restarting=
 the
> +        * queues. Using the done list like that is now ok since everythi=
ng is
> +        * locked in place.
> +        */
> +       list_for_each_entry(bo_va, &vm->done, base.vm_status)
> +               dma_fence_wait(bo_va->last_pt_update, false);
> +       dma_fence_wait(vm->last_update, false);
>
>         ret =3D amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exe=
c);
>         if (ret)
> @@ -783,7 +781,7 @@ static void amdgpu_userq_restore_worker(struct work_s=
truct *work)
>
>         mutex_lock(&uq_mgr->userq_mutex);
>
> -       ret =3D amdgpu_userq_validate_bos(uq_mgr);
> +       ret =3D amdgpu_userq_vm_validate(uq_mgr);
>         if (ret) {
>                 drm_file_err(uq_mgr->file, "Failed to validate BOs to res=
tore\n");
>                 goto unlock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index bd12d8ff15a4..9980c0cded94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -484,6 +484,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct d=
rm_exec *exec,
>                                     2 + num_fences);
>  }
>
> +/**
> + * amdgpu_vm_lock_done_list - lock all BOs on the done list
> + * @exec: drm execution context
> + * @num_fences: number of extra fences to reserve
> + *
> + * Lock the BOs on the done list in the DRM execution context.
> + */
> +int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec=
,
> +                            unsigned int num_fences)
> +{
> +       struct list_head *prev =3D &vm->done;
> +       struct amdgpu_bo_va *bo_va;
> +       struct amdgpu_bo *bo;
> +       int ret;
> +
> +       /* We can only trust prev->next while holding the lock */
> +       spin_lock(&vm->status_lock);
> +       while (!list_is_head(prev->next, &vm->done)) {
> +               bo_va =3D list_entry(prev->next, typeof(*bo_va), base.vm_=
status);
> +               spin_unlock(&vm->status_lock);
> +
> +               bo =3D bo_va->base.bo;
> +               if (bo) {
> +                       ret =3D drm_exec_prepare_obj(exec, &bo->tbo.base,=
 1);
> +                       if (unlikely(ret))
> +                               return ret;
> +               }
> +               spin_lock(&vm->status_lock);
> +               prev =3D prev->next;
> +       }
> +       spin_unlock(&vm->status_lock);
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_vm_move_to_lru_tail - move all BOs to the end of LRU
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index e045c1590d78..3409904b5c63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -491,6 +491,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev=
, struct amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>                       unsigned int num_fences);
> +int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec=
,
> +                            unsigned int num_fences);
>  bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>  uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_=
vm *vm);
>  int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> --
> 2.43.0
>
