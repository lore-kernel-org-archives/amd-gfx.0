Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE93CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 19:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BDB10EB82;
	Thu, 11 Sep 2025 19:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ThpzG2ZA";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1822E10EB82
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 19:01:50 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-25c70a8f783so1253655ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757617309; x=1758222109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVopzppsuBR/ckJvcnA7YeTuOCy2glaXPVCeJNamb+0=;
 b=ThpzG2ZA3lsgJ1lW431lD2ZOzHAPUYKBc8k80/7gqgb+DFgma00DlV5x1VT72MkCXy
 5lkp51WE+Lf+DFBPkqMWvFeYWrOG2ErbgbNu/5IOuKHDArDyM7iZAqbp1HqXE5gz6Jmx
 9aeYtaDgkNSadWayAjkNQY5ITJ8py2iK1QZ0PGA218P9H/BlG1syAcyo2IBQD1qPKBkA
 XqVHpr3D8FurMlroVY36GsUevpmAzJTtCkxIyiP9t4oJ2CWgJ8C8VuWFSgMbFuTUnrLR
 Vv7Qluo+y28hkf3dQM6k4qk2sp9WM4FdaAxu/SIeUGn3h30tqpu6QwSk02/QX7whJjtn
 Iajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757617309; x=1758222109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVopzppsuBR/ckJvcnA7YeTuOCy2glaXPVCeJNamb+0=;
 b=w8cVCjAnw/1wI893DbjYlwVeqowG/SRNcR40U5QR3V+PjPTsnFsYkyQLPy0HZvYNOJ
 g5iaCX0tW9NTkqgPv3oKqXb8PZ+cDXkFirzIQl0HGfAINXRefpDe3MHg1mN4doH5tLe0
 Fk0e9OxV1NxsXoNfkVKSPC7jAF0Y+FmcEmU8Wk3y+XrmejAYpgZUCUAfUBvfSOsd7MBy
 3I5vhLIFbjae58BipJzA/zsiLPQdUStsQlTscT6gehnDjM6f3rSEPR1Isz4GmJNZmFx1
 xCk5J61gj0geMVjJ7sS/e/Iqk+dcaARXBv59hOcsr5lzYH/Kei2A0m5XTzpnd8QaWUVe
 NCtQ==
X-Gm-Message-State: AOJu0YzeV4dBuIiJ1/vmCUTMJKE4N2MxeZM18N+6HhkFlfvltmMbr6Vt
 MBw9QFwAVUtBwYFwb5wzDRoNdr8LsvWXqtku0l6EUpCmRza6eR1rS1T8r8DwG8+7zjN+Fj2z8+i
 sCh+dO5sVQpT+ZakuEV8rGwuDQTQWoBQ=
X-Gm-Gg: ASbGncsOrOaP6+HBMk6AC/ffRgbSWkCucVlSeR0P0hr6zwx9XpjHo0FyGI+PTnS3uRI
 5C26hFeL0SLSjM5vq/doZg0CUIGplDGHxfDM4f68pqnAEIOuXOQjDJ890DZRAMsNZQ+GenXYrTw
 dVf73KLYA/s9N2T++8GU2bEY2nXfi/tHhlLftWrqtZ3DpxIF8fhpAfc38iESQ7KcwEP89xETxZB
 ET9w6pUDDhcaJCUwHIQyZ01tr5u
X-Google-Smtp-Source: AGHT+IGcXDRUKj6PAkMIX3NZYEh6h7tvP0Ysg9Gs8VR+gsrx2R7nR8AzaojMgriwEl6leSjURaGYjNUf/ZKMxlL9OOw=
X-Received: by 2002:a17:902:d4c3:b0:24c:b881:201 with SMTP id
 d9443c01a7336-25d271485dcmr2239135ad.9.1757617309157; Thu, 11 Sep 2025
 12:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
 <20250910113731.2688320-5-Prike.Liang@amd.com>
In-Reply-To: <20250910113731.2688320-5-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 15:01:36 -0400
X-Gm-Features: Ac12FXxOlGiT4776cjXniUN9fXb4ekdWmdZjoBw6nPIhcgNADQguhRp9l13ogQc
Message-ID: <CADnq5_NzTtXFS6H8_04mY--8Ljqnr8buvPnon0eR9J3Dc5maLQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm/amdgpu: add userq object va track helpers
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

On Wed, Sep 10, 2025 at 7:54=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Add the userq object virtual address get(),mapped() and put()
> helpers for tracking the userq obj va address usage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 66 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  9 ++-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++---
>  4 files changed, 75 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index 656b8a931dae..52c2d1731aab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -96,6 +96,7 @@ struct amdgpu_bo_va {
>          * if non-zero, cannot unmap from GPU because user queues may sti=
ll access it
>          */
>         unsigned int                    queue_refcount;
> +       atomic_t                        userq_va_mapped;
>  };
>
>  struct amdgpu_bo {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index ba7be4db5a01..f9e817acfdea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -44,7 +44,8 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_de=
vice *adev)
>         return userq_ip_mask;
>  }
>
> -int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,

I don't think we need the queue here as a parameter.

> +                                  struct amdgpu_vm *vm, u64 addr,
>                                    u64 expected_size)
>  {
>         struct amdgpu_bo_va_mapping *va_map;
> @@ -67,6 +68,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm=
, u64 addr,
>         /* Only validate the userq whether resident in the VM mapping ran=
ge */
>         if (user_addr >=3D va_map->start  &&
>             va_map->last - user_addr + 1 >=3D size) {
> +               amdgpu_userq_buffer_va_get(queue, va_map, user_addr);
>                 amdgpu_bo_unreserve(vm->root.bo);
>                 return 0;
>         }
> @@ -76,6 +78,61 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *v=
m, u64 addr,
>         return r;
>  }
>
> +int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,

struct amdgpu_vm *vm makes more sense then queue here.

> +                              struct amdgpu_bo_va_mapping *va_map, u64 a=
ddr)
> +{
> +       atomic_set(&va_map->bo_va->userq_va_mapped, 1);
> +       return 0;
> +
> +}
> +
> +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
> +{
> +       struct amdgpu_bo_va_mapping *mapping;
> +       u64 user_addr;
> +       bool r;
> +
> +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SH=
IFT;
> +
> +       if (amdgpu_bo_reserve(vm->root.bo, false))
> +               return false;
> +
> +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +       if (!IS_ERR_OR_NULL(mapping) && atomic_read(&mapping->bo_va->user=
q_va_mapped))
> +               r =3D true;
> +       else
> +               r =3D false;
> +       amdgpu_bo_unreserve(vm->root.bo);
> +
> +       return r;
> +}
> +
> +int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue,
> +                              u64 addr)

struct amdgpu_vm *vm makes more sense then queue here.

Alex

> +{
> +       struct amdgpu_bo_va_mapping *mapping;
> +       struct amdgpu_vm *vm =3D queue->vm;
> +       u64 user_addr;
> +       int r;
> +
> +       user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SH=
IFT;
> +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +       if (r)
> +               return r;
> +
> +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +       if (!mapping)
> +               goto out_err;
> +
> +       atomic_set(&mapping->bo_va->userq_va_mapped, 0);
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return 0;
> +
> +out_err:
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return -EINVAL;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -462,9 +519,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         }
>
>         /* Validate the userq virtual address.*/
> -       if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va,=
 args->in.queue_size) ||
> -           amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va, =
AMDGPU_GPU_PAGE_SIZE) ||
> -           amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va, =
AMDGPU_GPU_PAGE_SIZE)) {
> +       if (amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.qu=
eue_va, args->in.queue_size) ||
> +           amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.rp=
tr_va, AMDGPU_GPU_PAGE_SIZE ) ||
> +           amdgpu_userq_input_va_validate(queue, &fpriv->vm, args->in.wp=
tr_va, AMDGPU_GPU_PAGE_SIZE)) {
>                 kfree(queue);
>                 goto unlock;
>         }
> @@ -504,7 +561,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>                 goto unlock;
>         }
>
> -
>         qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_=
COUNT, GFP_KERNEL);
>         if (qid < 0) {
>                 drm_file_err(uq_mgr->file, "Failed to allocate a queue id=
\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 33a582200dda..6044afeeb741 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -53,6 +53,7 @@ struct amdgpu_usermode_queue {
>         enum amdgpu_userq_state state;
>         uint64_t                doorbell_handle;
>         uint64_t                doorbell_index;
> +
>         uint64_t                flags;
>         struct amdgpu_mqd_prop  *userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
> @@ -138,7 +139,11 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(st=
ruct amdgpu_device *adev,
>                                                   u32 idx);
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device =
*adev,
>                                                    u32 idx);
> -
> -int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
> +                                  struct amdgpu_vm *vm, u64 addr,
>                                    u64 expected_size);
> +int amdgpu_userq_buffer_va_get(struct amdgpu_usermode_queue *queue,
> +                              struct amdgpu_bo_va_mapping *va_map, u64 a=
ddr);
> +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
> +int amdgpu_userq_buffer_va_put(struct amdgpu_usermode_queue *queue, u64 =
addr);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 3a4fd6de08ce..e10e4b6a10d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -298,8 +298,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                         goto free_mqd;
>                 }
>
> -               if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd=
->eop_va,
> -                   max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
> +               if (amdgpu_userq_input_va_validate(queue, queue->vm, comp=
ute_mqd->eop_va,
> +                                       max_t(u32, PAGE_SIZE, AMDGPU_GPU_=
PAGE_SIZE)))
>                         goto free_mqd;
>
>                 userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
> @@ -330,8 +330,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
>
> -               if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11=
->shadow_va,
> -                   shadow_info.shadow_size))
> +               if (amdgpu_userq_input_va_validate(queue, queue->vm, mqd_=
gfx_v11->shadow_va,
> +                                       shadow_info.shadow_size))
>                         goto free_mqd;
>
>                 kfree(mqd_gfx_v11);
> @@ -350,9 +350,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                         r =3D -ENOMEM;
>                         goto free_mqd;
>                 }
> -
> -               if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v1=
1->csa_va,
> -                   shadow_info.csa_size))
> +               if (amdgpu_userq_input_va_validate(queue, queue->vm, mqd_=
sdma_v11->csa_va,
> +                                       shadow_info.csa_size))
>                         goto free_mqd;
>
>                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
> --
> 2.34.1
>
