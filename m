Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065C1CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 14:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A226610E9FA;
	Thu, 28 Aug 2025 14:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="le2roZwG";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9DC10E9F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 14:29:56 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-246c9de68c8so1660815ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756391396; x=1756996196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XwscCSbz2DiZrTNVcUin+2FDqKTFno5AGI4AQb5hes=;
 b=le2roZwGW+SiuTd02Ze6cNu/PRwfEAziUnTJ9wbaMr4PZJ8GfxOrPZ6ijZYvCQ13A+
 zrMiNZy4MSXuRprLBAHGLTOyn1eaWGO0pF5zuD1tcfStDoM0rhHCvlhTMD4dCIgq0fbM
 Zm1y8RmUWF0azGXJPIOs6xO3j8XSMJxY7wz5mq/FI4ZlrMcrVmWRZociU7ylZbiYcb3h
 C63W9ylkEIbJYnjFMWy9skGJhWW5UK27Cs9Dzoy576zTAm4xSE0cLH3XzicQuVd/nB/t
 VqFumZxM2tzmnKHekK7+33hWDbABGHrpmTc9epvudaMg+z0cVmk3diPaUCpHh0JiocFO
 YxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391396; x=1756996196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XwscCSbz2DiZrTNVcUin+2FDqKTFno5AGI4AQb5hes=;
 b=G4hbHINC3MXRzf+p8RgiDgW2/7S5B8JEOpK5Rfp4srf+hx8wOzC+3mFpSgJnzM9mhb
 TvQqBltq7/HLwdo12gc3XHsnOqCbx58D+U8JO79433gct7jBAsm7yZzpdVJYoMtH2Rpy
 zGHBgG9kuWJcW05oZg/AZJqtwvIxZeu7RX2UXJuTzTOVvYFOmzI7pli7L5UvumjRFRtq
 cLinDLdUtFGz+mr8zfYOVsScODxAHNpJQI5BEObjDsVybV7Rr7knRneQCSs0tUYw6ikN
 bJTy7EhyEziCD6JbbbPdEMyZ7zgGwgp6FNVSKdsJYVS/xOqmEdJMXnDkiWtk9kOiDJUb
 DKtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4JC9Idg1be+wJQJW4z3JNfPUARYMTfKogUrmwQQpyF/k9X3L3Gq/kSoPn2/mnCCnVWfj7vuJ5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywbv9xsbIqlmm1cpliCL3HLcEbHTfyyRdHa2oUbzPjBtI/spQu1
 FGGAYtpOLZd8ZBF8Lddui7tu21YWkDYTDQq4BchtbrmOng2qEHGYW8YIuU80wCWZgN5w9Lzh1Fp
 gJe1/3ssinNHBTMGY972rTh4kT/Ptilc=
X-Gm-Gg: ASbGncvNjujP1QMAle5EgVgnwHAmNXuFCXURm2JqsQsuZIShcjZmuLiBcu8vjpmH6B1
 8bPJzHW5gn1fRaeCIziugOg37wQdRkemc5tI4vfD86BqSBgoEbos5Z3a6wEccbho6KEkuc93XRg
 eDW/bqWmI1ehW8JqcFyBXn8ONbTT6odT+JpH9OtLw9B5hzzzI5r9GMDOncPt/f1ZDUR5mPq231b
 UX7PS0=
X-Google-Smtp-Source: AGHT+IEVUJoml+3VjWlnSnd2EX1YQNK/umTpPSWyRVprsRL9mIuynQV2ol9ieI4Xjq2JVbxHYakSIq1wKvmcY6Tc5cs=
X-Received: by 2002:a17:903:2303:b0:248:8a31:bf6f with SMTP id
 d9443c01a7336-2488a31c353mr65537305ad.4.1756391395985; Thu, 28 Aug 2025
 07:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250828094136.40078-1-christian.koenig@amd.com>
In-Reply-To: <20250828094136.40078-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 10:29:44 -0400
X-Gm-Features: Ac12FXzAhXVNwLJxRkZ9bPZW4jF8hEtODhK69-yrJ6ZYIviJetwAnRn6XWJLmZI
Message-ID: <CADnq5_N3wythEm3Ku9nTNE0fyy4PdsxdEy4Sx==fbdGnuADiFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix userq VM validation v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Sunil.Khatri@amd.com, alexander.deucher@amd.com, 
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

On Thu, Aug 28, 2025 at 5:41=E2=80=AFAM Christian K=C3=B6nig
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
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 118 ++++++++++------------
>  1 file changed, 56 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 424831997cb1..11edad1951c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -545,108 +545,102 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr =
*uq_mgr)
>         return ret;
>  }
>
> +static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)

I would rename this amdgpu_userq_bo_validate() for consistency (e.g.,
amdgpu_cs_bo_validate,()) and to make it clearer what it is doing.

> +{
> +       struct ttm_operation_ctx ctx =3D { false, false };
> +
> +       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +       return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +}
> +
>  static int
> -amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
> +amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *e=
xec,
> +                         struct amdgpu_vm *vm)
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
>  static int
> -amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
> +amdgpu_userq_update_vm(struct amdgpu_userq_mgr *uq_mgr)

Please add some comments to this function to make it clear what each
step is doing and why we are doing it.  Many of these functions have
very similar names and it's hard to follow what they are all doing
without double checking their implementations.  It would also be
helpful to plug in a comment about where we should plug in usr ptr
checks.  amdgpu_cs_parser_bos() could use similar comments if you have
a chance.

Other than that, the patch looks good to me.

Alex

>  {
>         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
> -       struct amdgpu_vm *vm =3D &fpriv->vm;
>         struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_vm *vm =3D &fpriv->vm;
>         struct amdgpu_bo_va *bo_va;
> -       struct ww_acquire_ctx *ticket;
>         struct drm_exec exec;
>         struct amdgpu_bo *bo;
> -       struct dma_resv *resv;
> -       bool clear, unlock;
>         int ret =3D 0;
>
>         drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>         drm_exec_until_all_locked(&exec) {
> -               ret =3D amdgpu_vm_lock_pd(vm, &exec, 2);
> +               ret =3D amdgpu_vm_lock_pd(vm, &exec, 1);
>                 drm_exec_retry_on_contention(&exec);
>                 if (unlikely(ret)) {
>                         drm_file_err(uq_mgr->file, "Failed to lock PD\n")=
;
>                         goto unlock_all;
>                 }
>
> -               /* Lock the done list */
>                 list_for_each_entry(bo_va, &vm->done, base.vm_status) {
>                         bo =3D bo_va->base.bo;
>                         if (!bo)
>                                 continue;
>
> -                       ret =3D drm_exec_lock_obj(&exec, &bo->tbo.base);
> +                       ret =3D drm_exec_prepare_obj(&exec, &bo->tbo.base=
, 1);
>                         drm_exec_retry_on_contention(&exec);
>                         if (unlikely(ret))
>                                 goto unlock_all;
>                 }
> -       }
>
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
> +               ret =3D amdgpu_vm_validate(adev, vm, NULL,
> +                                        amdgpu_userq_validate_vm,
> +                                        NULL);
> +               if (unlikely(ret))
>                         goto unlock_all;
> -               spin_lock(&vm->status_lock);
> -       }
>
> -       ticket =3D &exec.ticket;
> -       while (!list_empty(&vm->invalidated)) {
> -               bo_va =3D list_first_entry(&vm->invalidated, struct amdgp=
u_bo_va,
> -                                        base.vm_status);
> -               resv =3D bo_va->base.bo->tbo.base.resv;
> -               spin_unlock(&vm->status_lock);
> -
> -               bo =3D bo_va->base.bo;
> -               ret =3D amdgpu_userq_validate_vm_bo(NULL, bo);
> -               if (ret) {
> -                       drm_file_err(uq_mgr->file, "Failed to validate BO=
\n");
> +               ret =3D amdgpu_userq_validate_bos(adev, &exec, vm);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(ret))
>                         goto unlock_all;
> -               }
> -
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
> -
> -               ret =3D amdgpu_vm_bo_update(adev, bo_va, clear);
> +       }
>
> -               if (unlock)
> -                       dma_resv_unlock(resv);
> -               if (ret)
> -                       goto unlock_all;
> +       ret =3D amdgpu_vm_handle_moved(adev, vm, NULL);
> +       if (ret)
> +               goto unlock_all;
>
> -               spin_lock(&vm->status_lock);
> -       }
> -       spin_unlock(&vm->status_lock);
> +       ret =3D amdgpu_vm_update_pdes(adev, vm, false);
> +       if (ret)
> +               goto unlock_all;
>
>         ret =3D amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exe=
c);
>         if (ret)
> @@ -667,7 +661,7 @@ static void amdgpu_userq_restore_worker(struct work_s=
truct *work)
>
>         mutex_lock(&uq_mgr->userq_mutex);
>
> -       ret =3D amdgpu_userq_validate_bos(uq_mgr);
> +       ret =3D amdgpu_userq_update_vm(uq_mgr);
>         if (ret) {
>                 drm_file_err(uq_mgr->file, "Failed to validate BOs to res=
tore\n");
>                 goto unlock;
> --
> 2.43.0
>
