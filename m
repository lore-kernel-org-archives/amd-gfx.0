Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE002E7FDF0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 21:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F8710E4B4;
	Mon,  2 Feb 2026 21:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eyHmCTSz";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F0C10E4B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 21:44:47 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b78c97f57bso279717eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 13:44:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770068686; cv=none;
 d=google.com; s=arc-20240605;
 b=lMxUILO1WfrxuDITDVXjUolG8qPYvknSo4Zh/NrlfWPHnA0JTuXuyewuMGvBZiU0bO
 8g/POthLuMk8ecLnDETh82647vLI3eOsfgr/pW3gYTrm1Rmc8XX7lf0ni/UWV7DMIRaX
 xm7G77gRlzvq8fmElBunnkzL+2dza95jt9i/8+E7F1aW7ha3pK/ZvqW3muj4D41rNJHi
 XgnP7mkD44U8Jzd+yvv1FwJN+qO9fckY4wTCTi9PE5iSKqkFcRfSw8k73B2qwnpqUoTU
 wS0mHb1sng7mgGhPRgdCrzXqsBs1/vHGQayiUdF36QkvYcaSmCVPYC28jgJJtmn3HfV2
 uBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EABUEbyImp7udN33MgOzxCFCBQqgwZVYD9IwUcNorco=;
 fh=s6nM05VHrAFo9bZBlA3it4uByhZCTcfNUWrqF3/3HpQ=;
 b=L+tRQ43S8hBqTZE4VEGN7pXCyXlCArK24zZsGPzQYA/PgQQIrX6dzne1TOWgU/z3YC
 a1UaGk+58M5tuTEST4aCv1oHxwzyXBJPcSYzU7iJg9+hRiPY8by+4CSOLE6BM2urMW16
 EYqBrmclf3GdSbbV1mn0r9N8m9Nknc+s44MbTRKtNsDbWN6zI0hzurxEd1pr8jxCT+OD
 MM7w9T2MpuD/pbEkyOk9u3dNr9/Ws/qyUjuWXwXKVLsi0BV5DvZ2OiY79rVGhZJN1xhf
 roGraNERQrGvxGvNXaPTDRplFgkedczY/LZQ3G0AFrc0jewX/+XtwDwjlhUUmL2O8e9s
 H/CA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770068686; x=1770673486; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EABUEbyImp7udN33MgOzxCFCBQqgwZVYD9IwUcNorco=;
 b=eyHmCTSzaEsToW3/ZD9fO4zzsdAz6XHCb4mqTVpJUDrdY5iHigZVHjakdE4qAJjRhR
 46J3CxbeRfST7qwIu/PN8lvcr8JMYBtGYMmrWeNdydvJRjVObCtB6E+DY1YSWj+Ol3lf
 kAL9UPUHBdA1lhvM6hOz4fexvZVO9nfdhToVjGczg96LG7RxAiEnZUQt5m6+JKcTZduZ
 40SSMpY8ffQjI8vJBVo9GCIVdP1qu3qqp9pHB/4WG773c0ZOvTtjZ0O8595tyuE4lLRV
 xgQc2G7WjTAwXodNVrGhmTItQg7u6yoajsWeUzV76GM3NOHkEZTJec3w4eksTAKaImxE
 IHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770068686; x=1770673486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EABUEbyImp7udN33MgOzxCFCBQqgwZVYD9IwUcNorco=;
 b=aCfUJCVmJI7ihkZEchxazht6ngMrvtSwVKBAGE88VPveyNsXbdEwWIQoUP7HCRbJ9Z
 ZRNnXnj2uD50ECDNawQd7dPOghFoPwqIs3FY7JLMApervUr3r2F0g+kxPD2Be1Xmm/Qg
 AVz1tUDEsC5o3t1VARILiFyse1Zu+wkdfOrVfMzrVTnqZ9rnTCvaVjBANU6nVplE4qQf
 1pQbXOQu6wG8vZgTFtJHpjIlMW68UnNHCHqSB6Pkv9OQDDmYMNhgRjkL0JNte141s3VI
 T7rA27d98sgORmQNFChWKdBBzOG3zuObmcS1zXyOF0bD1zamA+UBL52hAyiBQqXXzbP6
 6SBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSIwYNpYzEzosnPwWodnbTLCtWcKHDK2nhNPaoH2uLZKO4TohvnpT1bAdGx+uPtLYsHO3gxfg/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yywn6H+L3rqTP/fP+2jdRk0eS4Fo9x3EKw1qYJ/LhpCIZirbkXA
 nVF+Exvmz48VvjdPhxQu5PKYhW+l6+GgF6OrATQvktdsv6ki/7YFf/Ky/WDhd2joKuUQ9zFvT8G
 AtZc2nsrD190Xe/XrMTIxP30/LfocEz0=
X-Gm-Gg: AZuq6aI0VfVL3xM5emdW+Whs1bsIqqLXIvhTYu7KE3QShuDMGJJncGYt+cxqbWTo0e7
 OUXKRSWBA2OkSm0c+hrj1XzFA9LurqOqnDCg6YIoFbbwPfwLeJf9fJIqG/NtqEcwpNEd9XlB/Qo
 mHW744BhNTr7aYN/XDeTLXfbfRclNJWNKjI1lVSs40sP4XmPvqD/l2eHrJeLh7N510mYB/3QxJ1
 hmytq5kmFyr65Rau0bEv+N6PiC8Vg8O8jV0EkrBTQ2Q+oqTtMZS/8b38cHv/2aBtg//MUk4
X-Received: by 2002:a05:7022:e98d:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-125c0fa8f87mr3590678c88.2.1770068686365; Mon, 02 Feb 2026
 13:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20260202125149.2067-1-christian.koenig@amd.com>
In-Reply-To: <20260202125149.2067-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 16:44:33 -0500
X-Gm-Features: AZwV_QipXeHHRuaMq9zsoexX2u8HaeTwdSf09amFoPj0dLjbfY0nfhRUlVf-OWY
Message-ID: <CADnq5_NDT7wA-qKTn8vQU+Sm1Che-qs1BUXz2DO7ymdS3RZDzg@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu: lock both VM and BO in
 amdgpu_gem_object_open
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

On Mon, Feb 2, 2026 at 7:51=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The VM was not locked in the past since we initially only cleared the
> linked list element and not added it to any VM state.
>
> But this has changed quite some time ago, we just never realized this
> problem because the VM state lock was masking it.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 22 ++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  2 ++
>  4 files changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 768998c82b43..ec5130497743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -878,6 +878,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev,=
 struct kgd_mem *mem,
>         struct amdgpu_bo *bo[2] =3D {NULL, NULL};
>         struct amdgpu_bo_va *bo_va;
>         bool same_hive =3D false;
> +       struct drm_exec exec;
>         int i, ret;
>
>         if (!va) {
> @@ -958,19 +959,25 @@ static int kfd_mem_attach(struct amdgpu_device *ade=
v, struct kgd_mem *mem,
>                         goto unwind;
>                 }
>
> -               /* Add BO to VM internal data structures */
> -               ret =3D amdgpu_bo_reserve(bo[i], false);
> -               if (ret) {
> -                       pr_debug("Unable to reserve BO during memory atta=
ch");
> -                       goto unwind;
> +               drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +               drm_exec_until_all_locked(&exec) {
> +                       ret =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> +                       drm_exec_retry_on_contention(&exec);
> +                       if (unlikely(ret))
> +                               goto unwind;
> +                       ret =3D drm_exec_lock_obj(&exec, &bo[i]->tbo.base=
);
> +                       drm_exec_retry_on_contention(&exec);
> +                       if (unlikely(ret))
> +                               goto unwind;
>                 }
> +
>                 bo_va =3D amdgpu_vm_bo_find(vm, bo[i]);
>                 if (!bo_va)
>                         bo_va =3D amdgpu_vm_bo_add(adev, vm, bo[i]);
>                 else
>                         ++bo_va->ref_count;
>                 attachment[i]->bo_va =3D bo_va;
> -               amdgpu_bo_unreserve(bo[i]);
> +               drm_exec_fini(&exec);
>                 if (unlikely(!attachment[i]->bo_va)) {
>                         ret =3D -ENOMEM;
>                         pr_err("Failed to add BO object to VM. ret =3D=3D=
 %d\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 5f9fa2140f09..5c90de58cc28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -232,6 +232,7 @@ static int amdgpu_gem_object_open(struct drm_gem_obje=
ct *obj,
>         struct amdgpu_vm *vm =3D &fpriv->vm;
>         struct amdgpu_bo_va *bo_va;
>         struct mm_struct *mm;
> +       struct drm_exec exec;
>         int r;
>
>         mm =3D amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
> @@ -242,9 +243,18 @@ static int amdgpu_gem_object_open(struct drm_gem_obj=
ect *obj,
>             !amdgpu_vm_is_bo_always_valid(vm, abo))
>                 return -EPERM;
>
> -       r =3D amdgpu_bo_reserve(abo, false);
> -       if (r)
> -               return r;
> +       drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> +       drm_exec_until_all_locked(&exec) {
> +               r =3D drm_exec_prepare_obj(&exec, &abo->tbo.base, 1);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(r))
> +                       goto out_unlock;
> +
> +               r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(r))
> +                       goto out_unlock;
> +       }
>
>         amdgpu_vm_bo_update_shared(abo);
>         bo_va =3D amdgpu_vm_bo_find(vm, abo);
> @@ -260,8 +270,7 @@ static int amdgpu_gem_object_open(struct drm_gem_obje=
ct *obj,
>                 amdgpu_bo_unreserve(abo);
>                 return r;
>         }
> -
> -       amdgpu_bo_unreserve(abo);
> +       drm_exec_fini(&exec);
>
>         /* Validate and add eviction fence to DMABuf imports with dynamic
>          * attachment in compute VMs. Re-validation will be done by
> @@ -294,7 +303,10 @@ static int amdgpu_gem_object_open(struct drm_gem_obj=
ect *obj,
>                 }
>         }
>         mutex_unlock(&vm->process_info->lock);
> +       return r;
>
> +out_unlock:
> +       drm_exec_fini(&exec);
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 1878e0faa722..f69332eed051 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1445,6 +1445,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, =
struct drm_file *file_priv)
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
>         struct amdgpu_fpriv *fpriv;
> +       struct drm_exec exec;
>         int r, pasid;
>
>         /* Ensure IB tests are run on ring */
> @@ -1484,7 +1485,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev,=
 struct drm_file *file_priv)
>         if (r)
>                 goto error_pasid;
>
> +       drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> +       drm_exec_until_all_locked(&exec) {
> +               r =3D amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
> +               drm_exec_retry_on_contention(&exec);
> +               if (unlikely(r))
> +                       goto error_vm;
> +       }
> +
>         fpriv->prt_va =3D amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
> +       drm_exec_fini(&exec);
>         if (!fpriv->prt_va) {
>                 r =3D -ENOMEM;
>                 goto error_vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 6a2ea200d90c..b4bf1b7c214f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1735,6 +1735,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu=
_device *adev,
>  {
>         struct amdgpu_bo_va *bo_va;
>
> +       amdgpu_vm_assert_locked(vm);
> +
>         bo_va =3D kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>         if (bo_va =3D=3D NULL) {
>                 return NULL;
> --
> 2.43.0
>
