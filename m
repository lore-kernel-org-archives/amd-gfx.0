Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1243C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 17:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A34F10E07D;
	Tue, 24 Jun 2025 17:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PI4dmb53";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE4910E07D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 17:15:14 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-313bcf6e565so817045a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750785314; x=1751390114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9iAj0u5TsmTbU/tDYXpovzM9emr7HgjntS833xrf2c=;
 b=PI4dmb53YdTkPpHdMQsyPAVEx6OQ0ugLAv7rm1N2VR7qxaHEoD76MlHknWJyhXrEFO
 KiC5f366YmuX6G+Uw7RIz6N25xWC6bOtgEj4ZyLfdApIk63SEJyIiRdckg2g/Kb2vJ96
 gFM6NLogw44YEfsdGd/DkuaYumz6e6bR+hvI1Bqep1KCmLXTWr5dJSqIcQYrdLs9xmQE
 kT82JHVxjqGqziZN0OLUWJKV0DGeCc0kndhAjVPTjiPeOmFddMjzd0ODNYs9czsumo2S
 NQLvMqyAjCNwqZaXsiVCfmhyt3hkgKmpbQIDILYh+MTf7gXlyqL/BEeNvHJdrXIZMRVR
 v+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750785314; x=1751390114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9iAj0u5TsmTbU/tDYXpovzM9emr7HgjntS833xrf2c=;
 b=mebE7A9ZZhj63bYU10ZweTBKfBcnHe1Y6Dr+qb9gYzrV8rmXZIEOA6bJziK1zHHEr4
 ZDOoReeWocmjyv6zvNokxHyT0vpOqpJEo/7n7s44/qnQXKmU3F1DWNXZBpz+RQvLX2I6
 dr+ox49FqMBGmRwZYyow/mhht2l3DJbX2M8Lmvfn5Iy9WN+8brKC8rIA6LYtpe9qNxso
 uTcrvmka3Bz3kvC++DQix4JmNSbr1dozbcgYBgXMeS4k6LA9njXNQvi2smXaD7P4o5XC
 lEBgfvfsl96ykaB9uDDnKoi/fp2c19MSp0EF1YzmbIuogVTOPnhr5hCf8nFr+yqdA8Yg
 pm9g==
X-Gm-Message-State: AOJu0YzQtoNOX7Tc5QhSk9pNhG82AtAOtbWxMqLHxeAhf7Ivf3oUughq
 GKpZywHuNZPJtVkIevwcGpmYaWbg/G++RP54BqbmXnBXgiBs1d9esY/bYiOHkNKPm2KCAi+d5Gn
 KNUIsx0GY1hAsJkoBRZluWcdq59AiciPaPA==
X-Gm-Gg: ASbGncvf967kMLu4GyOx8po7WZ9aPsuEoJvHt098h367YPt8NxMbJ5TS3cEfgUrbm3g
 oSitw/nqs2dAKG+fVHrV1hSfJF57cCGaB8XXFKnRGltGjewy56qCPed8/D4k6xxT/hTidHTrhK2
 8i5uYT1XKJ/36RYkmtQZlOlMZqtXn7Vnltz5EI44z9ogpm
X-Google-Smtp-Source: AGHT+IEKBIAjKhOruf4luWMkjHD9YsdnUeyuLoQmgTzmoJr+UwT458K36PSTp2aEQTVCokutC9P+uh0hgTvIMe0/Dss=
X-Received: by 2002:a17:90b:57ec:b0:311:9c9a:58e8 with SMTP id
 98e67ed59e1d1-3159d90f997mr8595102a91.7.1750785314173; Tue, 24 Jun 2025
 10:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-5-Prike.Liang@amd.com>
In-Reply-To: <20250624084535.1178476-5-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Jun 2025 13:15:00 -0400
X-Gm-Features: AX0GCFsoKsDGO71dWcxKRGkBIeFtt2moFDIuv6zdi4jHFF_gCOdjHm0GHICmGBU
Message-ID: <CADnq5_Ot27pk+hpk0ndQxmypbTr4i2z_uH3smsuHvzH9zkqTsw@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] drm/amdgpu: add userq object va track helpers
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

On Tue, Jun 24, 2025 at 4:54=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Add the userq object virtual address get(),mapped() and put()
> helpers for tracking the userq obj va address usage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 132 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  14 +++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
>  3 files changed, 149 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index a20f7ccbe98e..cbbd1860a69a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -76,6 +76,134 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *=
vm, u64 addr,
>         return -EINVAL;
>  }
>
> +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr)
> +{
> +       struct amdgpu_bo_va_mapping *mapping;
> +       u64 user_addr;
> +       int r;
> +
> +       user_addr =3D amdgpu_userq_va_align(addr);
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
> +        *  doorbell bo
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
> +       user_addr =3D amdgpu_userq_va_align(addr);
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
> +       if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
> +           amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
> +           amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
> +           amdgpu_userq_buffer_va_mapped(vm, queue->eop_va) ||
> +           amdgpu_userq_buffer_va_mapped(vm, queue->shadow_va) ||
> +           amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))

Only some of these are relevant for each queue type.  Rather than
checking all of the critical buffers in all of your helper functions,
it might be cleaner to add new userq callbacks that only check/update
the relevant buffers for the queue type.

> +               return true;
> +       else
> +               return false;
> +}
> +
> +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr)
> +{
> +       struct amdgpu_bo_va_mapping *mapping;
> +       u64 user_addr;
> +       int r;
> +
> +       user_addr =3D amdgpu_userq_va_align(addr);
> +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +       if (r)
> +               return r;
> +
> +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +       if (!mapping)
> +               goto out_err;
> +       /*
> +        * If here refer to the userq VM BOs and keep the usage count by
> +        * amdgpu_bo_ref(mapping->bo_va->base.bo) at creating the userq I=
OCTL,
> +        * this reference and usage counter will be kept until amdgpu_use=
rq_destroy(),
> +        * while the userq VA is unmapped at amdgpu_vm_bo_unmap(), which =
is ahead of
> +        * amdgpu_userq_destroy(). So, when amdgpu_vm_bo_unmap() tries to=
 unmap the
> +        * userq VA mapping, it will result in an unmap error caused by t=
he BO's reference.
> +        */
> +       /*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/

I still don't follow this.  Why can't we get a reference in userq
create and put the reference in userq destroy.  If the app is freeing
the buffers before the queue, that's an app bug.

Alex

> +
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
> +       amdgpu_userq_buffer_va_get(vm, queue->queue_va);
> +       amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
> +       amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
> +       amdgpu_userq_buffer_va_get(vm, queue->eop_va);
> +       amdgpu_userq_buffer_va_get(vm, queue->shadow_va);
> +       amdgpu_userq_buffer_va_get(vm, queue->csa_va);
> +}
> +
> +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> +                       struct amdgpu_usermode_queue *queue)
> +{
> +       amdgpu_userq_buffer_va_put(vm, queue->queue_va);
> +       amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
> +       amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
> +       amdgpu_userq_buffer_va_put(vm, queue->eop_va);
> +       amdgpu_userq_buffer_va_put(vm, queue->shadow_va);
> +       amdgpu_userq_buffer_va_put(vm, queue->csa_va);
> +
> +       return 0;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -442,6 +570,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         queue->queue_type =3D args->in.ip_type;
>         queue->vm =3D &fpriv->vm;
>         queue->priority =3D priority;
> +       queue->queue_va =3D args->in.queue_va;
> +       queue->rptr_va =3D args->in.rptr_va;
> +       queue->wptr_va =3D args->in.wptr_va;
>
>         db_info.queue_type =3D queue->queue_type;
>         db_info.doorbell_handle =3D queue->doorbell_handle;
> @@ -472,7 +603,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
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
> index 704935ca0c36..194ec7a6b3b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -52,6 +52,13 @@ struct amdgpu_usermode_queue {
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
> @@ -134,4 +141,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(s=
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
> index 4615d3fba530..c9cde14064d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -263,6 +263,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                 userq_props->hqd_active =3D false;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> +               queue->eop_va =3D compute_mqd->eop_va;
>                 kfree(compute_mqd);
>         } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
>                 struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
> @@ -284,6 +285,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
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
> @@ -317,6 +320,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
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
