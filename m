Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BEFC98321
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 15:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C02010F4E5;
	Thu, 24 Sep 2026 15:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R4CjZl0U";
	dkim-atps=neutral
Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com
 [74.125.227.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF50C10F4E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 15:51:15 +0000 (UTC)
Received: by mail-vs2-f43.google.com with SMTP id
 ada2fe7eead31-7914360ecf5so72777137.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 08:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790265074; cv=none;
 d=google.com; s=arc-20260327;
 b=CHo+9VUnM1jG4GZjirmNy9N8oXYHAEKXg/6k7cUlVtRX9t1Q3oqgXdm+uLF11evNKe
 E7TA7nj0zkHrF/VDHnNWgf8k90Z6nuxCIdQIgIDtdoSSIr2a8fnfYDqrUkFb/YE5ZBHW
 hoYBuLJmIkvMmTwegotbot/ZlO8M2Q+S1v9rqXxV3N19Y7scy5S8OVhMJERZqb9epj2u
 hEBR8fjCYY763j732/MZJriUXBrAKduiBfcr3MxpW2RsIIjchd5l3XCgISllMdoChe6i
 Qaqv19BC9z+OGook4+r/9czaPBk6/oOrku6cgx4B4aAzRS/6kD0cbcTSchpggfWavk6c
 BtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=54TWgB5ibuc6v+AU6plf5/96UOO2I97Rto8VC9IsDAE=;
 fh=4VLIgh+umWlIyHxjlb5qQ6o+BmKzgqlgdLDIE6z0CCc=;
 b=QHqx3uiP1eTcivt2nSHAwwHvGBEwJxH0HFIcGT2je+A+HLB+cDjSXCmLKxJTp0BoUq
 /9CUi7oJ9+ntjRZabMdNzdYGUz97fH0aqe0wywEkvkkcYIxKS+YTUVC+2pi1R3XJyJVG
 QFhDi7POYv0U9CCiH2Ks4ou1sqpL8l/sSNv8ilMwBAvvPY8Q1k7qUVK840bSqeEK3wUz
 AwRafMk0hywJRgzeL/fDfc9+g/rehTizVOh7MChcJodEtpPx/pKoPDKMlPNDLpF2fyk3
 X2TT7FIf0sje4ew7rXdK8CQTeEdSkwyTT4urV1JoSWX4S070GTFx1uYpu9mE5MP6OfY6
 nxSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790265074; x=1790869874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=54TWgB5ibuc6v+AU6plf5/96UOO2I97Rto8VC9IsDAE=;
 b=R4CjZl0UFHPHzJOpFuSEqolWb5XuU3rR6bPjg0XoOw8Z3UEQpFcDsAlJy2WHNEQkyq
 11wvV+U1k3r7qzbYuHoInwmTmrJvBwCQlXKp2csUFBjd+t14x7YgqpQxMVbf+dsjC/1Z
 hfiKMKY7wHcgvSm0ThPD+hNQFUHnSuyHu1KHqTndU/ynZ1kJYS2y/p3hl1x6lFOjwJxF
 5TxE55aNHvg3VWkJauJNEYwBC9iz46U35HhZqoxef3yD+ArJSlo0B4cjLCVvOFsM+/pZ
 RDfioR5CoGmMBzqfSTo7JaW7Y/IWqVDgMZ5A7UmPkRrE0V7P5Sm6hDu/VkavDhSb16+N
 tGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790265074; x=1790869874;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=54TWgB5ibuc6v+AU6plf5/96UOO2I97Rto8VC9IsDAE=;
 b=xVFXq4PxNrmweLp2P5RP3Qngxles9RV4DHbHDGp8H9Qf8U1tZj7DY9u/1jgpWsNp4P
 rltfO3lGGom0NX8ROWxGXlO6V7EySB3iLP1qFz+ub3VSI1pr59dN0OjiIkfhEHPYBv2j
 c1SMhlGxG+dsst9FOjxmPWpJAz6l3mzy05mRGCR5tsiKVnNMCjuvFZH35tBvinGcRXPH
 5+H3gYxHFExWslT6t/AA0vFBgqpiwvbpJGor80ApGOGC8liHLXHjmpCr2ZuG7EmqIpFL
 ZHfWLjh5qIioC4HoLQr9HYzbpEP593uadJJGOBcJ46WLGLLUb8wM0I/RlZ/hG2xHxq21
 4gFQ==
X-Gm-Message-State: AFuF++kJZDtPw1WA6V31B87ypQyYd2xnyBAo4c8wpv4uo1mmv+VSq/aa
 2J4ZYj1raOjcckugvVSIayPPhZ3hVUxiyeT8Yijy9mp1TToJxXXTXbEU9Ys8krwATf22dndPPeg
 AqR19mO9KW7YVv49Uu5S3gdrx908dSbQ=
X-Gm-Gg: AYBFou03YD1z9du7lKgksRipL8b+/yakK5aMGoeDnfdptrh9WKAOpgGhG4eN1cHd97l
 Y/p0vTdKF+iAg0JcDH5t+uUne/1bdmi0sUtsdYzDGc1KhM5xFAIM5fc7gSQvoVwiGQ9R8iHOXN/
 P+evAYU1gMGCAewfpHLbuW5QGIcJ1xN/rqFac+z/ylgMPFvt9k7D0yUuSp4mJpGn0aQ/cbxuSlq
 Y729ZzN/C1rZIJdYXa7px2V+irlUdZ644ZQatTPb+E1qkpmuhBjJxTmpdXxVRk++Ae6dTa+6rt7
 uKMI61i2jL9Y1oIaBRU27RMRZHvJmqyW78aGid5O17ElJfDnP0+eFt4hqcZOTZG2t7QaPBfAXFM
 kPKpsz0y5WVHGfOiS2N0fBG79ooHVOejTMM3s6FbsdQ==
X-Received: by 2002:a05:6102:5801:b0:7a7:c789:88e with SMTP id
 ada2fe7eead31-7af1c8a2515mr1112681137.1.1790265074607; Thu, 24 Sep 2026
 08:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260924142129.745010-1-xiang.liu@amd.com>
In-Reply-To: <20260924142129.745010-1-xiang.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 11:51:01 -0400
X-Gm-Features: AclHuK-0EsfjIb56DjjS9YafhVcFdTnSEVgDb9gc6M0e1JZWCBISgpDbqDdp4lk
Message-ID: <CADnq5_PJ+CQE06VL=EA2TkAVfE680Us1fvigoTx1BzjhgXp=Mg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't leak bo_va when gem_object_open fails
To: Xiang Liu <xiang.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, 
 Stanley.Yang@amd.com, YiPeng.Chai@amd.com, Mukul.Joshi@amd.com
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

On Thu, Sep 24, 2026 at 10:31=E2=80=AFAM Xiang Liu <xiang.liu@amd.com> wrot=
e:
>
> drm_gem_handle_create_tail() skips the close() callback when open()
> returns an error, so a bo_va added before a failing step is never
> removed. It stays linked on bo->vm_bo and a later eviction of that BO
> dereferences the VM after it has been torn down.
>
> Validate and fence the BO before adding the bo_va, drop the bo_va when
> attaching the eviction fence fails, and propagate the allocation failure
> from amdgpu_vm_bo_add().
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 80 ++++++++++++++-----------
>  1 file changed, 45 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 9da1880ee76d..be0c642f3740 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -260,7 +260,7 @@ static int amdgpu_gem_object_open(struct drm_gem_obje=
ct *obj,
>         struct amdgpu_bo_va *bo_va;
>         struct mm_struct *mm;
>         struct drm_exec exec;
> -       int r;
> +       int r =3D 0;
>
>         mm =3D amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
>         if (mm && mm !=3D current->mm)
> @@ -270,6 +270,42 @@ static int amdgpu_gem_object_open(struct drm_gem_obj=
ect *obj,
>             !amdgpu_vm_is_bo_always_valid(vm, abo))
>                 return -EPERM;
>
> +       /* Validate and add eviction fence to DMABuf imports with dynamic
> +        * attachment in compute VMs. Re-validation will be done by
> +        * amdgpu_vm_validate. Fences are on the reservation shared with =
the
> +        * export, which is currently required to be validated and fenced
> +        * already by amdgpu_amdkfd_gpuvm_restore_process_bos.
> +        *
> +        * This runs before the BO is added to the VM: drm_gem_handle_cre=
ate_tail()
> +        * does not call the close() callback when open() fails, so nothi=
ng that
> +        * would need unwinding may exist yet.
> +        *
> +        * Nested locking below for the case that a GEM object is opened =
in
> +        * kfd_mem_export_dmabuf. Since the lock below is only taken for =
imports,
> +        * but not for export, this is a different lock class that cannot=
 lead to
> +        * circular lock dependencies.
> +        */
> +       if (vm->is_compute_context && vm->process_info &&
> +           drm_gem_is_imported(obj) &&
> +           dma_buf_is_dynamic(obj->import_attach->dmabuf)) {
> +               mutex_lock_nested(&vm->process_info->lock, 1);
> +               if (!WARN_ON(!vm->process_info->eviction_fence))
> +                       r =3D amdgpu_amdkfd_bo_validate_and_fence(abo,
> +                                       AMDGPU_GEM_DOMAIN_GTT,
> +                                       &vm->process_info->eviction_fence=
->base);
> +               mutex_unlock(&vm->process_info->lock);
> +               if (r) {
> +                       struct amdgpu_task_info *ti =3D amdgpu_vm_get_tas=
k_info_vm(vm);
> +
> +                       dev_warn(adev->dev, "validate_and_fence failed: %=
d\n", r);
> +                       if (ti) {
> +                               dev_warn(adev->dev, "pid %d\n", ti->task.=
pid);
> +                               amdgpu_vm_put_task_info(ti);
> +                       }
> +                       return r;
> +               }
> +       }
> +
>         drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>         drm_exec_until_all_locked(&exec) {
>                 r =3D drm_exec_prepare_obj(&exec, &abo->tbo.base, TTM_NUM=
_MOVE_FENCES + 1);
> @@ -287,47 +323,21 @@ static int amdgpu_gem_object_open(struct drm_gem_ob=
ject *obj,
>         bo_va =3D amdgpu_vm_bo_find(vm, abo);
>         if (!bo_va) {
>                 bo_va =3D amdgpu_vm_bo_add(adev, vm, abo);
> +               if (!bo_va) {
> +                       r =3D -ENOMEM;
> +                       goto out_unlock;
> +               }
>                 r =3D amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
> -               if (r)
> +               if (r) {
> +                       amdgpu_vm_bo_del(adev, bo_va);
>                         goto out_unlock;
> +               }
>         } else {
>                 ++bo_va->ref_count;
>         }
>
>         drm_exec_fini(&exec);
> -
> -       /* Validate and add eviction fence to DMABuf imports with dynamic
> -        * attachment in compute VMs. Re-validation will be done by
> -        * amdgpu_vm_validate. Fences are on the reservation shared with =
the
> -        * export, which is currently required to be validated and fenced
> -        * already by amdgpu_amdkfd_gpuvm_restore_process_bos.
> -        *
> -        * Nested locking below for the case that a GEM object is opened =
in
> -        * kfd_mem_export_dmabuf. Since the lock below is only taken for =
imports,
> -        * but not for export, this is a different lock class that cannot=
 lead to
> -        * circular lock dependencies.
> -        */
> -       if (!vm->is_compute_context || !vm->process_info)
> -               return 0;
> -       if (!drm_gem_is_imported(obj) ||
> -           !dma_buf_is_dynamic(obj->import_attach->dmabuf))
> -               return 0;
> -       mutex_lock_nested(&vm->process_info->lock, 1);
> -       if (!WARN_ON(!vm->process_info->eviction_fence)) {
> -               r =3D amdgpu_amdkfd_bo_validate_and_fence(abo, AMDGPU_GEM=
_DOMAIN_GTT,
> -                                                       &vm->process_info=
->eviction_fence->base);
> -               if (r) {
> -                       struct amdgpu_task_info *ti =3D amdgpu_vm_get_tas=
k_info_vm(vm);
> -
> -                       dev_warn(adev->dev, "validate_and_fence failed: %=
d\n", r);
> -                       if (ti) {
> -                               dev_warn(adev->dev, "pid %d\n", ti->task.=
pid);
> -                               amdgpu_vm_put_task_info(ti);
> -                       }
> -               }
> -       }
> -       mutex_unlock(&vm->process_info->lock);
> -       return r;
> +       return 0;
>
>  out_unlock:
>         drm_exec_fini(&exec);
> --
> 2.34.1
>
