Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8EACA1010
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 16:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8BF710EC0C;
	Fri,  5 Sep 2025 16:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U26ljBBQ";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AA210EC27
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 16:12:12 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b4fb8d3a2edso162490a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757088732; x=1757693532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3KUoNGqGTNulP7WH29/Dh1Zj8A7oH4IR+oja+7m77w=;
 b=U26ljBBQWmCmaF9uWm99/E9+pClgT+Fmw9EahaoZHEpgF9uIevb2/gkufNo2j9bTjb
 dgf/igExkbYSZog88k62+wd5azBMJ7K8QFh2Ri2JJkbjL2Bgy7fVRr/zdGY4Gnt82ViV
 4ZQUQURegQAJlhkRguKwlRW7SHhd214RJFJ3NwsoliDJioyhbbVAYVPM3jtBWd7B2HA0
 cum7AzxpS9Zw6rEH4enFYl8XOffbEn6021nrBbrUmzH3sWT4ZDJQ3PF/+G0/oFvhyUI6
 DsNEbdZsck6dnPyl1pLNX4YXigce4svCH6y+1TfQmZNBEjfVLcSd1sZpvLgLP8ylYVqW
 vmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757088732; x=1757693532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3KUoNGqGTNulP7WH29/Dh1Zj8A7oH4IR+oja+7m77w=;
 b=w2pJ2B7SpnCpRrqggEJMdayh2w2Wz/wNTSuoZnSXboq2Avfvi6dtHq5pFZoGZPqXL8
 cza9rZTXvVSyVhBvc2a0SzhFMLH5FdN15E+gKeNkly1Y3ychIgg+7OqwxTsz4NdAn9KR
 LyBS5h4Z1C8dKAmnTUv98pVro6U7a+SXZzz0lqvreUryTvPuocwqblkGX1OytyVMHJiy
 c6W3XguFacLSeVds0Z32qtMWzLEQoeqIhRLprdiqNoUrnJyEG3MJz64J3GZ40WQUY5AJ
 ysD30Un0xVHr2q1orV19wH9B8Du9YMMV/My5h0OlvuVJLN3nriE7qIvIrPKkGTc3agv9
 M2KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOHcwcAInAY+1zAjHQOgw6uBU5iK7ypX07hu47xXcxuuUIzw+e1YpIXsPaI5OFR4Ah1M3m10iL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycPHe7vpo6N7KMNof5jdsZvFdcbeYd1ohvv8yrkyWi9bR+yUO5
 Pden0Rp1JvjCs+iz3zUSJrzZeAPfPiBrX1JFlakUeT8e8ArU4rMlx290Klt8f2jLT3jxiEZqth9
 H9cAIDJBK+LGM5RTKfaAAARmSn2VbF+g=
X-Gm-Gg: ASbGncvMZzXbG+sPMcF9wszYhUHt2D/ERUkVyxHBA0VMHWARfZAlo4Wdf5jkBGIXxvx
 dDwsPqIo6cikWpq3K4EE8Nwqy96DpkXIL4w/qRPypOCZqfHIaYzJBH303lR7F3VoQDtUnSG6TBo
 df/ewG+Ro1jFMFvzGjJVjv0XPN4xnD1k2ToRdVEmtatAI0Vn8myp9FYLke4lMXOx4imTr5X4AJS
 FiRr/X3AefJAkYLhw==
X-Google-Smtp-Source: AGHT+IF5jAyv5WAvaqzupYqfJPaW480WtTLglv7UTji+ALC+fuuEOAwnaMvmcwTwfdrAZ53/oKJcG/UJy9kSuw6JCdk=
X-Received: by 2002:a17:90b:4d07:b0:32b:4ddf:d47d with SMTP id
 98e67ed59e1d1-32b4ddfd612mr8301556a91.4.1757088732056; Fri, 05 Sep 2025
 09:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250905112701.2443-1-christian.koenig@amd.com>
In-Reply-To: <20250905112701.2443-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Sep 2025 12:12:00 -0400
X-Gm-Features: Ac12FXylAHV4EOmMV2y-NW24CGwdHfgxrbumeUzSOry9iTZgQCynRzg3dRvmJKM
Message-ID: <CADnq5_Pke7EeSM5aBaus1UZwd2t60U9a7kY=JL3gw13kAQWHpQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix userq VM validation v4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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

On Fri, Sep 5, 2025 at 7:27=E2=80=AFAM Christian K=C3=B6nig
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
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 146 +++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  35 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |   2 +
>  3 files changed, 108 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index e228c1e6800d..cb3432b12221 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -601,108 +601,104 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr =
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

Would be good to add a comment here or in the VM code in general
explaining why we have all of the vm lists, what they are used for,
and why we validate these specific lists when we do.   Probably makes
more sense to put this as kerneldoc in the vm code since this also
applies to the CS code.

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
> +               ret =3D amdgpu_vm_lock_done(vm, &exec, 1);
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

Add a comment here.  something like:
/* validate the evicted BOs */

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

Add a comment here:
/* validate the invalidated list */
Or change the function name to better reflect what it's doing.

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
> @@ -723,7 +719,7 @@ static void amdgpu_userq_restore_worker(struct work_s=
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
> index bd12d8ff15a4..ec29fec1739e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -484,6 +484,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct d=
rm_exec *exec,
>                                     2 + num_fences);
>  }
>
> +/**
> + * amdgpu_vm_lock_done - lock all BOs on the done list
> + * @exec: drm execution context
> + * @num_fences: number of extra fences to reserve
> + *
> + * Lock the BOs on the done list in the DRM execution context.
> + */
> +int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,

Maybe rename this to amdgpu_vm_lock_done_list()?  Every time I saw
this function I read it has "i'm done with the lock" rather than "lock
the done list".

Alex

> +                       unsigned int num_fences)
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
> index e045c1590d78..f86b1a6afb0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -491,6 +491,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev=
, struct amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>                       unsigned int num_fences);
> +int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
> +                       unsigned int num_fences);
>  bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>  uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_=
vm *vm);
>  int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> --
> 2.43.0
>
