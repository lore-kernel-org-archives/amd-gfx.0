Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB48C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 15:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061DA10E52C;
	Tue, 31 Oct 2023 15:19:10 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F5910E52C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 15:19:07 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1dcfe9cd337so2554379fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698765547; x=1699370347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNQ8HwZxmG+pHrcTTleOPjnIhvt2StNieUgZmdk0ppo=;
 b=BQkn1+Pmq0OFUoe2fuDg3Z0F2Gqa579vR4QdM1socPQZnDmwHc9Tuv7oAB2mf23CKI
 ahuZ7+NEbqaJRCkuQrii8Zr7ls+GVJiTMJO53FEDGc2DJH/QCyHk//zn+ieixw8seAJW
 8df5mVguQWqxYPaOnWesvCy9xyOCVer8ZlxgqbREHLyYLpkx9CQvqRq/Eeela26yAVy4
 hVmImY5dHFhZK8jMXroQ1Y/egdllUirAH0iqOymhkHyx2hvciVrVcaOtotgEEiUQExGG
 A6jQKGOgtFsgbAjAitQSc+ZVBu57+5uNjuOQdtULhzql7ceYgNf/bOXJADg/aeFJT4/b
 fCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698765547; x=1699370347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNQ8HwZxmG+pHrcTTleOPjnIhvt2StNieUgZmdk0ppo=;
 b=HjIQpJW7WS1GDgEesYtQxAOXD3BTsMdO7F2wZ3h9KM35WE4a9Q+TEm9f/BPIj9C1+U
 xGuRzeqgxRMPuCbwpLs65Cur71abI4wVNmR40yueE7ED/JMKo8bZn9dohgojUzbl/k63
 Cm/sZRMEyJHuyRd01uapjrPONNyrBqzBxN+dQhQpfj/Pm1tNaP7hrv8v3j6DmooXXn6b
 GY3D1kzVX6/CgPOkHiQSSPscPMrmctzofIgEFTnrRmcGXsagwWlFToCwj4Ogx8jH1++L
 DQjvct1CJ8xi4Y/QKHGatV2SjLn5G0iZP1ai8HC8ywyA6S8s+YNJFeKT1O3IwTfIGvxY
 NJvQ==
X-Gm-Message-State: AOJu0YyJYf1zyNqtjrJgqdFu1lbP8/ARwNPVESbvgnrdk3eUPWUqeBM9
 I4xkwlQit35ahu9ypk6jFniRO31rKxzNMGCpsHI=
X-Google-Smtp-Source: AGHT+IEwMf+izwItIa8CMAMkIv6Dqjr2VqgfDXcKX2oSL7aczq/jE3+AUL4MkxqKIavF49iLQrqVNXeZtAxXWO43ShU=
X-Received: by 2002:a05:6871:5c4d:b0:1e9:de37:a75d with SMTP id
 os13-20020a0568715c4d00b001e9de37a75dmr14194274oac.17.1698765546989; Tue, 31
 Oct 2023 08:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231031145534.2501-1-christian.koenig@amd.com>
In-Reply-To: <20231031145534.2501-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Oct 2023 11:18:55 -0400
Message-ID: <CADnq5_N1St5NDG-uAtVnEcj1P+f0jt-Rp-3kND_XjTTbqmbbGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix error handling in amdgpu_vm_init
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alexander.Deucher@amd.com, Kenny.Ho@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 31, 2023 at 11:12=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> When clearing the root PD fails we need to properly release it again.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 31 +++++++++++++-------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index d72daf15662f..5877f6e9b893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2042,7 +2042,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long=
 timeout)
>   * Returns:
>   * 0 for success, error for failure.
>   */
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int=
32_t xcp_id)
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                  int32_t xcp_id)
>  {
>         struct amdgpu_bo *root_bo;
>         struct amdgpu_bo_vm *root;
> @@ -2061,6 +2062,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, stru=
ct amdgpu_vm *vm, int32_t xcp
>         INIT_LIST_HEAD(&vm->done);
>         INIT_LIST_HEAD(&vm->pt_freed);
>         INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
> +       INIT_KFIFO(vm->faults);
>
>         /* create scheduler entities for page table updates */
>         r =3D drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NO=
RMAL,
> @@ -2103,34 +2105,33 @@ int amdgpu_vm_init(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm, int32_t xcp
>                                 false, &root, xcp_id);
>         if (r)
>                 goto error_free_delayed;
> -       root_bo =3D &root->bo;
> +
> +       root_bo =3D amdgpu_bo_ref(&root->bo);
>         r =3D amdgpu_bo_reserve(root_bo, true);
> -       if (r)
> -               goto error_free_root;
> +       if (r) {
> +               amdgpu_bo_unref(&root->shadow);
> +               amdgpu_bo_unref(&root_bo);
> +               goto error_free_delayed;
> +       }
>
> +       amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
>         r =3D dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
>         if (r)
> -               goto error_unreserve;
> -
> -       amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
> +               goto error_free_root;
>
>         r =3D amdgpu_vm_pt_clear(adev, vm, root, false);
>         if (r)
> -               goto error_unreserve;
> +               goto error_free_root;
>
>         amdgpu_bo_unreserve(vm->root.bo);
> -
> -       INIT_KFIFO(vm->faults);
> +       amdgpu_bo_unref(&root_bo);
>
>         return 0;
>
> -error_unreserve:
> -       amdgpu_bo_unreserve(vm->root.bo);
> -
>  error_free_root:
> -       amdgpu_bo_unref(&root->shadow);
> +       amdgpu_vm_pt_free_root(adev, vm);
> +       amdgpu_bo_unreserve(vm->root.bo);
>         amdgpu_bo_unref(&root_bo);
> -       vm->root.bo =3D NULL;
>
>  error_free_delayed:
>         dma_fence_put(vm->last_tlb_flush);
> --
> 2.34.1
>
