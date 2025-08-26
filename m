Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34EFCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 15:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3110710E10E;
	Tue, 26 Aug 2025 15:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DKI6IUP9";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFBB10E10E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 15:22:23 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2463d76f04aso6211455ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756221743; x=1756826543; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1KuZQX0mm+dpN3YsJbo+XWXmujvsOltiYN1iY02Q9k=;
 b=DKI6IUP9PXfdTloNDPIQAx8/wTi+Nkv6weTvnTXJpA6DuncI5cpW77JRlx/3VIrylJ
 R3V6QeKaubZ9QHL5/D4+RZNtPvlk1Xebk8HR0h/DDF70y4VoS6NR+nQeHaDrEMGXBTSN
 iFarJ9qqBhGq1ovJcgO2tZ55RiZC4L+bEBikWeqnWnElzg8cLe/1cmzWs4rpouprcu5T
 6MiLc9OIbqdD5c9I4VjvnankdbcsZg2BTmCgfKLeqJJh3Cm8TSfbZ6fftO9Rw3lk3SxC
 3AvLoWGKwN+XFq5FP+PLuwu16MLAxuTov1+05cnPUuiqv4mfWikCTRku8duCveFPusBG
 qiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756221743; x=1756826543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1KuZQX0mm+dpN3YsJbo+XWXmujvsOltiYN1iY02Q9k=;
 b=Gse6bf5KrdwMnkF2ms5QgEYqUVOY/XB1MAF1hjVSFt1KdbRsNqOPAT2hg9pkz0Rh4A
 A1HiEV6FAAZnE8Ldcnf7oluw9OV2tKp97QDidfDNPr8NJkvEp2nqpuA37ZQkVsZHZHxC
 2ebXaVJDl6PBHxlbeHu6gkLbu0fjOy6oq5frRTrNSLD9OyNALxqxUdKifnFsYPdTzjt9
 zKhHRNHKaquD0kprhFF0VnQEFnWn30COebcfjrmxg5uXYDg4e5Bk1QyrYuffd0kgAKpX
 431N/s7X/4SO/hoZGvDyVCYCs511FB64lejSxKToaN5VeSXCFzmkEcOPX70hN9gB0iP8
 LqZg==
X-Gm-Message-State: AOJu0Ywn4PFE6dR/FgpDKShr+hUjruZZ4w1dbAG+gBGfc+RoUuSkLOoY
 TLlu2igczd71HKZ4YPQnOzal7P3HHF8S9vYNfz1GVlxOQlQMZD3xsOrwxkoa7gr7zUZ0CF+dTcc
 FzFuBifeli/kwM+mV7/jU6te3RzzSumkR5A==
X-Gm-Gg: ASbGncsCbgZBLNxgUtJmCCOusgws4UoApgx8fiWoCuRj2X+OOzOW5QPoIM18KYxzwxE
 SHRad8FaylGSp5lVpsBaDAjV8rIiPo/NwP4ZG9PVitdtvW0dlupSD0nPy7kUZfKVRjObCZjv7qE
 DAbDLcCMuF7Y3tBZONSRSyyutijdNxnFmYGRqqaFvh9pYBfPwQaEGAH0gUuhlL418l5DUlvHFRk
 taU7c94+Wcy7qtRZJ/ubxC6Uopd
X-Google-Smtp-Source: AGHT+IH+EaeHESwhXK3qNMk4iodRdplFTqWuUn2WEqR8rBRHfc/NywPKFBtvf2MtzHHduPn4zOKpIdTQq/hEhFfLtUg=
X-Received: by 2002:a17:903:22c8:b0:246:a93c:aa0d with SMTP id
 d9443c01a7336-246a93cacc7mr78058625ad.11.1756221742943; Tue, 26 Aug 2025
 08:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
 <20250826074646.1775241-8-Prike.Liang@amd.com>
In-Reply-To: <20250826074646.1775241-8-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 11:22:11 -0400
X-Gm-Features: Ac12FXxbKa-sz-N1TjUswYSxDM88T12axA73YCDocGdWlsXhFbOXcDCNaUE-i-Q
Message-ID: <CADnq5_PDwsgY-sjkeCQ=eiiCF4Z4XXcGN3Q5d5D05obr6BXeZQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/14] drm/amdgpu: add userq object va track helpers
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

On Tue, Aug 26, 2025 at 3:47=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Add the userq object virtual address get(),mapped() and put()
> helpers for tracking the userq obj va address usage.
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
> index 0aeb7a96ccbf..562d12f9d0d2 100644
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
> @@ -445,6 +613,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
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
> @@ -475,7 +646,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
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
> index 0eb2a9c2e340..30067f80eadf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -54,6 +54,13 @@ struct amdgpu_usermode_queue {
>         enum amdgpu_userq_state state;
>         uint64_t                doorbell_handle;
>         uint64_t                doorbell_index;
> +       uint64_t                queue_va;
> +       uint64_t                rptr_va;
> +       uint64_t                wptr_va;
> +       uint64_t                eop_va;
> +       uint64_t                shadow_va;
> +       uint64_t                csa_va;

Just store a list of critical virtual addresses.  Otherwise we are
going to have a ton of IP specific things in here.  For each critical
address, just push the address on the list.  Then in the VM unmap
code, just walk the list for each queue and if the user tries to umap
a critical buffer, preempt the queue and set an error on it.

Alex

> +
>         uint64_t                flags;
>         struct amdgpu_mqd_prop  *userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
> @@ -137,4 +144,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(s=
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
> index 6e29e85bbf9f..42d6cd90be59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -262,6 +262,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                 userq_props->hqd_active =3D false;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +               queue->eop_va =3D compute_mqd->eop_va;
>                 kfree(compute_mqd);
>         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
>                 struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
> @@ -283,6 +284,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
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
>                                         shadow_info.shadow_size)) {
> @@ -314,6 +317,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                 }
>
>                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
> +               queue->csa_va =3D mqd_sdma_v11->csa_va;
>                 kfree(mqd_sdma_v11);
>         }
>
> --
> 2.34.1
>
