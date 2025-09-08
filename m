Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691BACA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 21:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1210110E5F1;
	Mon,  8 Sep 2025 21:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W5+tTfxH";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E24EB10E5F1
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 21:55:13 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-248f2da72edso9203955ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757368513; x=1757973313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVWiGtcwr+rzcaH9oyPBMx1VsTQrZ7sysuCpe2AiNX4=;
 b=W5+tTfxHumodD1A+xvzgwJaGkdJQEsdYD9MZ1cv+44mb0o/nrPppyqUKSwBLJrAxcH
 t479RrvOBMeTv2vQCHashNwR9u2tJuQet1LVenlNQ8AvshjfhZkDmeNbt0262Kh5kWLY
 ubgPN0odjGXbN1dNKdflScI7hdzayaPTtlBMKSfUdGeZXXjgNckgm8I08coo/XFTzX0N
 xXDBzwXQudY5AMGiA1sJdvA8UaLHqwiRebabqHTXDUcuQ7uQxFYbTq3WVTdOek+T3zjh
 XjeYDRlbMIIOzVvoD9zckAX3lXS9ZSJRbcYmWsDtG5QLyLC0wzLdiae1dit0Bno3w22n
 1OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757368513; x=1757973313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVWiGtcwr+rzcaH9oyPBMx1VsTQrZ7sysuCpe2AiNX4=;
 b=r64TSdxOWtWxfE+8z5z4fMlqXRQt+P15JaDiwrsCOIHioERUhDIUyjD0MDAD7PXjPw
 pLfQGhzA3xi5WfLRwOdXm+rDPO/2AKkJpK8byI17QG3kek/Q/g9f73meJxUkFpT3UW6K
 C8I9h8Nw57RUCSomXmv3g73V3Myi1crrLmjVsCWRa84GuvfkiMoxM72lpcO4rxurR+o6
 qDWzQkQLYNOSpJi7XeP2PWfhZrr2WrvbvyTfQAt/Zp7RfR8qOxLr0s7dlrV3a0D4Q5Hn
 EcqXcv2dRsjsUHSPMGK2Xnx0yC/3/Vq6PhPxGmJm6B9N/3H6BSsZJ0w6czYlFejekfpN
 rSkA==
X-Gm-Message-State: AOJu0Yz5hKiLNNSW2EBNXD2yWRz05q4I8/0G8dznankgmpf07t5OkoMz
 7fzvDKy3GE6c1Czx6ksP3MS457tFlYdyBfxGR0Yw/iBpGz2POoHOiS8gbrtmlxZKM8gxYI4zsdB
 JYEBmM4SlJpx/x0KoyFmFhLVzS5sQkac=
X-Gm-Gg: ASbGncsZGuSHkp/ttcBrYcxH3NUg8J95ABVje0/Xulf8cDYxvvIYEJrY82xKe8uZhtS
 0xGDro2An5oOlJvTKYsQr6BNj7xryTDs8Rr464ViOZ5iEnvORGWmklnTXBxjoh1KB5psFeEPDeL
 Ul664Ytwbwjw5eBHLbaeo2xHjOkGlbQM4wbZHGQpLRFoadRHM+IztUIlb1uwtCysF7VEFrgdLD2
 SPTYPI=
X-Google-Smtp-Source: AGHT+IGIgkOF3hHL/OSSKPojYqeTLN5a+3mB47UTwfH5et4ks+2BNXRMPNWwTrVJ5JS2mqd+Bq8RpnskvEMQFl33jyQ=
X-Received: by 2002:a17:90b:4c12:b0:327:e280:2a4d with SMTP id
 98e67ed59e1d1-32d43eff965mr5905169a91.2.1757368513296; Mon, 08 Sep 2025
 14:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
 <20250908084846.1873894-8-Prike.Liang@amd.com>
In-Reply-To: <20250908084846.1873894-8-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 17:55:01 -0400
X-Gm-Features: Ac12FXyLqiO3jjKjjBnjnPZ9GWzJZpJ745gi8CoztisvM64LmXkeq2KQcHimymI
Message-ID: <CADnq5_NrSjB3+kPuq_kQXOKfiOSSsoJgfdr+MUGpUzfMcCCbuQ@mail.gmail.com>
Subject: Re: [PATCH v10 08/14] drm/amdgpu: add userq object va track helpers
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
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

On Mon, Sep 8, 2025 at 4:49=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> wr=
ote:
>
> Add the userq object virtual address get(),mapped() and put()
> helpers for tracking the userq obj va address usage.

This adds too much queue specific info to the user queue structure.
Just set the bo_va flag when you validate the VAs in patch 7.  Then
when we validate the BOs in amdgpu_userq_restore_worker() verify that
all of the buffers with the bo_va flag are present.  If they are not,
fail the buffer validation and set the error on the queue(s).  If you
want a per queue list, just use a list_head in the userq structure for
critical VAs.

Alex


Alex


>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 172 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  14 ++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
>  3 files changed, 189 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 739135c3f450..5aebce63d86f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -76,6 +76,174 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *=
vm, u64 addr,
>         return r;
>  }
>
> +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr)
> +{
> +       struct amdgpu_bo_va_mapping *mapping;
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
> +       /*
> +        * Need to unify the following userq va reference.
> +        *  mqd  bo
> +        *  rptr bo
> +        *  wptr bo
> +        *  eop  bo
> +        *  shadow bo
> +        *  csa bo
> +        */
> +       /*amdgpu_bo_ref(mapping->bo_va->base.bo);*/
> +       mapping->bo_va->queue_refcount++;
> +
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return 0;
> +
> +out_err:
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return -EINVAL;
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
> +       if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->queue_refcount > =
0)
> +               r =3D true;
> +       else
> +               r =3D false;
> +       amdgpu_bo_unreserve(vm->root.bo);
> +
> +       return r;
> +}
> +
> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> +                       struct amdgpu_usermode_queue *queue)
> +{
> +
> +       switch (queue->queue_type) {
> +       case AMDGPU_HW_IP_GFX:
> +               if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->shadow_va) |=
|
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))
> +                       return true;
> +               break;
> +       case AMDGPU_HW_IP_COMPUTE:
> +               if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->eop_va))
> +                       return true;
> +               break;
> +       case AMDGPU_HW_IP_DMA:
> +               if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
> +                   amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))
> +                       return true;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return false;
> +}
> +
> +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr)
> +{
> +       struct amdgpu_bo_va_mapping *mapping;
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
> +       /*
> +        * TODO: It requires figuring out the root cause of userq va mapp=
ing
> +        * reference imbalance issue.
> +        */
> +       /*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
> +       mapping->bo_va->queue_refcount--;
> +
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return 0;
> +
> +out_err:
> +       amdgpu_bo_unreserve(vm->root.bo);
> +       return -EINVAL;
> +}
> +
> +static void amdgpu_userq_buffer_vas_get(struct amdgpu_vm *vm,
> +                       struct amdgpu_usermode_queue *queue)
> +{
> +
> +
> +       amdgpu_userq_buffer_va_get(vm, queue->queue_va);
> +       amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
> +       amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
> +
> +       switch (queue->queue_type) {
> +       case AMDGPU_HW_IP_GFX:
> +               amdgpu_userq_buffer_va_get(vm, queue->shadow_va);
> +               amdgpu_userq_buffer_va_get(vm, queue->csa_va);
> +               break;
> +       case AMDGPU_HW_IP_COMPUTE:
> +               amdgpu_userq_buffer_va_get(vm, queue->eop_va);
> +               break;
> +       case AMDGPU_HW_IP_DMA:
> +               amdgpu_userq_buffer_va_get(vm, queue->csa_va);
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +
> +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> +                       struct amdgpu_usermode_queue *queue)
> +{
> +       amdgpu_userq_buffer_va_put(vm, queue->queue_va);
> +       amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
> +       amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
> +
> +       switch (queue->queue_type) {
> +       case AMDGPU_HW_IP_GFX:
> +               amdgpu_userq_buffer_va_put(vm, queue->shadow_va);
> +               amdgpu_userq_buffer_va_put(vm, queue->csa_va);
> +               break;
> +       case AMDGPU_HW_IP_COMPUTE:
> +               amdgpu_userq_buffer_va_put(vm, queue->eop_va);
> +               break;
> +       case AMDGPU_HW_IP_DMA:
> +               amdgpu_userq_buffer_va_put(vm, queue->csa_va);
> +               break;
> +       default:
> +               break;
> +       }
> +       return 0;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -444,6 +612,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         queue->vm =3D &fpriv->vm;
>         queue->priority =3D priority;
>         queue->generation =3D amdgpu_vm_generation(adev, &fpriv->vm);
> +       queue->queue_va =3D args->in.queue_va;
> +       queue->rptr_va =3D args->in.rptr_va;
> +       queue->wptr_va =3D args->in.wptr_va;
>
>         db_info.queue_type =3D queue->queue_type;
>         db_info.doorbell_handle =3D queue->doorbell_handle;
> @@ -474,7 +645,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
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
> index 46e927df67c1..39d9bc6fc47a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -53,6 +53,13 @@ struct amdgpu_usermode_queue {
>         enum amdgpu_userq_state state;
>         uint64_t                doorbell_handle;
>         uint64_t                doorbell_index;
> +       uint64_t                queue_va;
> +       uint64_t                rptr_va;
> +       uint64_t                wptr_va;
> +       uint64_t                eop_va;
> +       uint64_t                shadow_va;
> +       uint64_t                csa_va;
> +
>         uint64_t                flags;
>         struct amdgpu_mqd_prop  *userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
> @@ -136,4 +143,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(s=
truct amdgpu_device *adev,
>
>  int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>                         u64 expected_size);
> +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr);
> +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
> +                       struct amdgpu_usermode_queue *queue);
> +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
> +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> +                       struct amdgpu_usermode_queue *queue);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 3bf328eb7b69..431397158fe5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -260,6 +260,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                 userq_props->hqd_active =3D false;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +               queue->eop_va =3D compute_mqd->eop_va;
>                 kfree(compute_mqd);
>         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
>                 struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
> @@ -281,6 +282,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +               queue->shadow_va =3D mqd_gfx_v11->shadow_va;
> +               queue->csa_va =3D mqd_gfx_v11->csa_va;
>
>                 if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11=
->shadow_va,
>                                         shadow_info.shadow_size))
> @@ -308,6 +311,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                         goto free_mqd;
>
>                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
> +               queue->csa_va =3D mqd_sdma_v11->csa_va;
>                 kfree(mqd_sdma_v11);
>         }
>
> --
> 2.34.1
>
