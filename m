Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2855EC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 16:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A718610E0A9;
	Tue, 24 Jun 2025 16:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FeVvI8yH";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D1C10E0A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 16:56:19 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b31aecc78a3so896377a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750784179; x=1751388979; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzdDA+LDQU0jkfECYt4oiOzux/GD4Ozw5BxdnE2yJZU=;
 b=FeVvI8yHk8sD+yQcFEOFtp6w2Z9osjlSWFfVszCR4GmBkC2YralE+CskHtVDHg/kVU
 JORMvBaVtSnhUi19akipCxplpYkirKcnLZS2JQFOcAhmZkWfjdbYMEI/mHt1iP7oQuvA
 Bd9Xaq9cf2l9zDuiD8O/bCxm4rgbi9PLU78ARMKEyIlKW+X7AMyAFxylwhvftYd7zHQz
 l/jqSYw4jh2DAGE4IBUIKj7gwoUqN44jR28ovNzCefSynP4rBfihMrODddMo8aaYKRn+
 MDhgR98QkgX59skEDNNnrHS93JYQvdFgODwzoW0vUlwNlAEwYfdYFsZPsYrXyVQ529Mv
 TT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750784179; x=1751388979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nzdDA+LDQU0jkfECYt4oiOzux/GD4Ozw5BxdnE2yJZU=;
 b=Z0jxZE/6L8NctkO+Vlxc2BDXp7hyTZnQViSf3aV9oNPbeiNLyX+Xw1vPRYufLO9N+Q
 /xs5T+hzMjdTy1uU0fgJaJowmr1E4qucrLBsNou6H3balyCTPafP005OZvpdm63hAvDh
 6wT1b3BOTejOHvjlCQ2dMfFY3dIlNCvUc0NPbTGUYN2amHboGU+8kjFOUgSHgzPMcHEa
 Q4FNr/SVjZHMAU0b/NXBBhFCToHpmNKYxxHjyPZKQeg44H6355w9U+WpM8A42xB/B3aM
 hlNlSJylNnFvCRTl/N5l+ioLWUH4SXvnz699rDAhKJenv4kLpv2Mr5ZJb/Z2BWdPvLvy
 uWtQ==
X-Gm-Message-State: AOJu0YzXMFkKgtAeE3M9iGsG2RxuUG6qXUc8MV/osFeI8QAuTAkjnF/i
 wqE5lIhTHdBOJMnIPR1WthstWqfJ2j2WjLTktgGQp7tlvdAIXJf6yF6jZZqyqW9BN671IY9T886
 e+2PunUDLbIDzJnzDaGgS+6ZEJvS+0RKIew==
X-Gm-Gg: ASbGncuQ8LE61f1RSoFMByw0Z0WDj21qlhaSsN/lCD91kWcXLdCo32tZilF9yTxMErS
 fhmeljgY8Ilv/Y+vvF9/rqg/ayt6C9lRE5VbnLyvs7hOJTJ+qZ0jQsUOhmLI5V4ptRmkuBegcmm
 pptqnjkje3bhb+YRgkp0KfJ6paHUV9gKr2XJ0uqgkpcMGu
X-Google-Smtp-Source: AGHT+IHIcZkw6ft5wPDwYVzobP0IshGsK7sjSHUnKJwp4HJxyMOyg9Nch+yuTMj5gMwvQ2GbUESmC5BSditpz6a5Q9I=
X-Received: by 2002:a17:90a:ec83:b0:314:29ff:6845 with SMTP id
 98e67ed59e1d1-3159d8c7e4amr10102353a91.4.1750784177493; Tue, 24 Jun 2025
 09:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-4-Prike.Liang@amd.com>
In-Reply-To: <20250624084535.1178476-4-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Jun 2025 12:56:05 -0400
X-Gm-Features: AX0GCFuUFp6wSrM4nk5NSHr4hEqopv8aVYHzSVQwyXsIUgUehYmLolesWpDk3KY
Message-ID: <CADnq5_NNxKrG3e2o=Z-F7Sf4Ffc_8O--gWYhJLqR9twNoFojSQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] drm/amdgpu: validate userq buffer virtual
 address and size
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Tue, Jun 24, 2025 at 4:46=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> It needs to validate the userq object virtual address whether
> it is validated in vm mapping.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 44 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 25 ++++++++++++
>  3 files changed, 71 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index acaea4416ed2..a20f7ccbe98e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -31,6 +31,8 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
>
> +#define amdgpu_userq_va_align(va) (va & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_=
GPU_PAGE_SHIFT
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>         int i;
> @@ -44,6 +46,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
evice *adev)
>         return userq_ip_mask;
>  }
>
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +                               u64 expected_size)
> +{
> +       struct amdgpu_bo_va_mapping *va_map;
> +       u64 user_addr;
> +       u64 size;
> +       int r;
> +
> +       user_addr =3D amdgpu_userq_va_align(addr);
> +       size =3D expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +       if (r)
> +               return r;
> +
> +       va_map =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +       if (!va_map)
> +               goto out_err;
> +       /* Only validate the userq whether resident in the VM mapping ran=
ge */
> +       if (user_addr >=3D va_map->start &&
> +           (size !=3D 0 && user_addr + size - 1 <=3D va_map->last)) {
> +               amdgpu_bo_unreserve(vm->root.bo);
> +               return 0;
> +       }
> +
> +out_err:
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return -EINVAL;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -391,6 +423,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>                 r =3D -EINVAL;
>                 goto unlock;
>         }
> +       /* Validate the userq virtual address.*/
> +       if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va,=
 args->in.queue_size) ||
> +           amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, =
PAGE_SIZE) ||
> +           amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, =
PAGE_SIZE)) {
> +               drm_file_err(uq_mgr->file, "Usermode queue input virt add=
ress is invalid\n");
> +               r =3D -EINVAL;
> +               goto unlock;
> +       }
>
>         queue =3D kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNE=
L);
>         if (!queue) {
> @@ -500,6 +540,10 @@ static int amdgpu_userq_input_args_validate(struct d=
rm_device *dev,
>                         return -EINVAL;
>                 }
>
> +               /* As the queue_va and wptr_va etc are the useq cpu acces=
s address and they
> +                * are also come from the user space IOCTL request, so th=
ey may need a access_ok()
> +                * check before trying accessing them.
> +                */

This comment is incorrect.  These are GPU virtual addresses.  With
that fixed, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>                 if (args->in.queue_va =3D=3D AMDGPU_BO_INVALID_OFFSET ||
>                     args->in.queue_va =3D=3D 0 ||
>                     args->in.queue_size =3D=3D 0) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index ec040c2fd6c9..704935ca0c36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
uct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device =
*adev,
>                                                    u32 idx);
>
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +                       u64 expected_size);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index dbacdfcb6f7b..4615d3fba530 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>         struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_ty=
pe];
>         struct drm_amdgpu_userq_in *mqd_user =3D args_in;
>         struct amdgpu_mqd_prop *userq_props;
> +       struct amdgpu_gfx_shadow_info shadow_info;
>         int r;
>
>         /* Structure to initialize MQD for userqueue using generic MQD in=
it function */
> @@ -231,6 +232,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>         userq_props->doorbell_index =3D queue->doorbell_index;
>         userq_props->fence_address =3D queue->fence_drv->gpu_addr;
>
> +       if (adev->gfx.funcs->get_gfx_shadow_info)
> +               adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, =
true);
>         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>                 struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
>
> @@ -247,6 +250,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                         goto free_mqd;
>                 }
>
> +               if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd=
->eop_va,
> +                                       max_t(u32, PAGE_SIZE, AMDGPU_GPU_=
PAGE_SIZE))) {
> +                       drm_file_err(uq_mgr->file, "EOP VA is invalid\n")=
;
> +                       r =3D -EINVAL;
> +                       goto free_mqd;
> +               }
> +
>                 userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
>                 userq_props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_N=
ORMAL;
>                 userq_props->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIO=
RITY_MINIMUM;
> @@ -274,6 +284,14 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +
> +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11=
->shadow_va,
> +                                       shadow_info.shadow_size)) {
> +                       drm_file_err(uq_mgr->file, "shadow VA is invalid\=
n");
> +                       r =3D -EINVAL;
> +                       goto free_mqd;
> +               }
> +
>                 kfree(mqd_gfx_v11);
>         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
>                 struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> @@ -291,6 +309,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                         goto free_mqd;
>                 }
>
> +               if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v1=
1->csa_va,
> +                                       shadow_info.csa_size)) {
> +                       drm_file_err(uq_mgr->file, "CSA VA is invalid\n")=
;
> +                       r =3D -EINVAL;
> +                       goto free_mqd;
> +               }
> +
>                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
>                 kfree(mqd_sdma_v11);
>         }
> --
> 2.34.1
>
