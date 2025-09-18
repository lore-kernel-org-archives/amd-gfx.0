Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4FCCAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494FC10E0E2;
	Thu, 18 Sep 2025 20:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WaKVQuk0";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5503310E0E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 20:49:51 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2697051902fso2653295ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758228591; x=1758833391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZPJGGVzXsgJjprft3DxBZOVafKFsk/uC2+dOklWwAY=;
 b=WaKVQuk0DUN7beY7CNDzCmhdM4PR1qJ569kRBrRZSzS+JsHOmemOhxJc4HLmkNTnDr
 3PFq8obezVFj29xWoZlg76P3UwOu3bM6Mgl0dMkz90fCRexzJ+ldMVgCKKqVA2CC2MuN
 YDtHImX/jZxgYk7DE+WYUhmT2HiPXr8pFXRMDyT6bERvlY5dl5eVKhUdfYXmZrsktEDG
 cvE6r4KDjm8zJOc6HtmSlt5391Agu1ntwQXjfecN1B/io/JsLy1iyAj80Twvkk04kQJ+
 3QRlIDN1UxxcG4vWcVKklLWeyMv5UXU2BXKoRxh50vEjqOGt3itWze8Xrp3VLRfNPbsO
 ySgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758228591; x=1758833391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZPJGGVzXsgJjprft3DxBZOVafKFsk/uC2+dOklWwAY=;
 b=wPXpHr250+vdNY+ZKjgcrbQdDzBD8efIE9NKWFmGdx/DcS6dqTrHPcs1uysRnkBBwD
 79MCo9tJ/jM7/re2OpyT2I3mv3V5nZ+TO6tpxvQdmvs/mutPFdpgBFRKLgPw3UCClm6J
 hjxBKH66Wwnfi3QjDWIxlA8PBeeUzFyF+SY3cOHGPllcBMoQW+nEGd3+mk7gYPYsSvdK
 yNd18EjbyQ44LVwxxule6KDXrmv2LgH7XWZzu0NQJy5nqLNpjXEsvkuDPQ5teoNwyEtf
 XXilrw/n0pTrBcSXOG054P/LenA4NXhQ9AksnpvzpMPJvXqZoUMm8ym/8xItjfCgUArT
 4UOw==
X-Gm-Message-State: AOJu0YzpT+MImOJEYQHcQOxQ2aahYHMZQdoNtdxnnS64DoIFl3tKg5n9
 b/+vc7THvF+N3Tzsl6z11q78jzeK/WzUSxh0Re8L6qDAdwDh0t3P+OHsDqztdUGm6fT6rk7uL7e
 58Yk3MuuymrX/XjdbeQTAI1rA1FmfN+g=
X-Gm-Gg: ASbGncud9j7HPMKYM1+p2Y03J7WPNzpIlG86voeBvNvRjUBZYa0tb98eUJlGYBFYeyR
 XnFmG3g6EpZiT4Ari4esBZJDLye4RJUyWGxcdOH9IuBqFfsKJh7CCrYXr64GAIgH7coIyfbtY/1
 ngzvORlm8/m8htEGg+w2ei9qvtlkSnYqmkHNIm2ZPYaArVYnZ1bltmO4pIkbyuwb8NDt6uKGolC
 5xfy3S+og546ZIMVCnJhW8VOA==
X-Google-Smtp-Source: AGHT+IF049eb1qi4TEJ7OD8q+xGbpBlS1V8NqPIl3qPRfwECrCdxlO9/d8mU/hHqFNST+jYsWIKX71Ss05lS70EtGVs=
X-Received: by 2002:a17:902:d4d0:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-269ba464124mr6446745ad.4.1758228590650; Thu, 18 Sep 2025
 13:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
 <20250918081815.2755437-6-Prike.Liang@amd.com>
In-Reply-To: <20250918081815.2755437-6-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 16:49:38 -0400
X-Gm-Features: AS18NWDryESTjqxUkzumGsLWwtwptSApPLz9TqmvEAW21tmfIXcKCGoEpnQB2EA
Message-ID: <CADnq5_NTNhogXAbe00EnVnD5SkgSnZMrkhVbeWyzdDugjZzFmg@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] drm/amdgpu: add userq object va track helpers
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

On Thu, Sep 18, 2025 at 4:29=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Add the userq object virtual address get(),mapped() and put()
> helpers for tracking the userq obj va address usage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 73 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  | 15 ++++-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++--
>  4 files changed, 88 insertions(+), 14 deletions(-)
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
> index 3b57352e523a..71cac54791c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -44,7 +44,8 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_de=
vice *adev)
>         return userq_ip_mask;
>  }
>
> -int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
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
> +               amdgpu_userq_buffer_va_list_add(queue, va_map, user_addr)=
;
>                 amdgpu_bo_unreserve(vm->root.bo);
>                 return 0;
>         }
> @@ -76,6 +78,66 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *v=
m, u64 addr,
>         return r;
>  }
>
> +int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,

This should be static as the function is not used outside of this file.

> +                              struct amdgpu_bo_va_mapping *va_map, u64 a=
ddr)
> +{
> +       struct amdgpu_userq_va_cursor *va_cursor;
> +       struct userq_va_list;
> +
> +       va_cursor =3D kzalloc(sizeof(*va_cursor), GFP_KERNEL);
> +       if (!va_cursor)
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(&va_cursor->list);
> +       va_cursor->gpu_addr =3D addr;
> +       atomic_set(&va_map->bo_va->userq_va_mapped, 1);
> +       list_add(&va_cursor->list, &queue->userq_va_list);
> +
> +       return 0;
> +
> +}
> +
> +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)

This should be static as it's not used outside of this file.

> +{
> +       struct amdgpu_bo_va_mapping *mapping;
> +       bool r;
> +
> +       if (amdgpu_bo_reserve(vm->root.bo, false))
> +               return false;
> +
> +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, addr);
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
> +int amdgpu_userq_buffer_va_list_del(struct amdgpu_vm *vm,

This should be static as it's not used outside of this file.

> +                                   u64 addr)
> +{
> +       struct amdgpu_bo_va_mapping *mapping;
> +       int r;
> +
> +       r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +       if (r)
> +               return r;
> +
> +       mapping =3D amdgpu_vm_bo_lookup_mapping(vm, addr);
> +       if (!mapping)
> +               goto out_err;
> +
> +       atomic_set(&mapping->bo_va->userq_va_mapped, 0);
> +       amdgpu_bo_unreserve(vm->root.bo);

Why not remove from the list here as well?  The only place that calls
this just calls list_del() after calling this function.  Also move the
locking (amndgpu_bo_reserve()) into the caller for symmetry with
amdgpu_userq_buffer_va_list_add().

Alex



Alex

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
> @@ -141,6 +203,7 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>         uq_funcs->mqd_destroy(uq_mgr, queue);
>         amdgpu_userq_fence_driver_free(queue);
>         idr_remove(&uq_mgr->userq_idr, queue_id);
> +       list_del(&queue->userq_va_list);
>         kfree(queue);
>  }
>
> @@ -461,10 +524,11 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
>                 goto unlock;
>         }
>
> +       INIT_LIST_HEAD(&queue->userq_va_list);
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
> @@ -504,7 +568,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
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
> index 33a582200dda..e03bfa38c9ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -48,6 +48,11 @@ struct amdgpu_userq_obj {
>         struct amdgpu_bo *obj;
>  };
>
> +struct amdgpu_userq_va_cursor {
> +        uint64_t               gpu_addr;
> +       struct list_head        list;
> +};
> +
>  struct amdgpu_usermode_queue {
>         int                     queue_type;
>         enum amdgpu_userq_state state;
> @@ -68,6 +73,8 @@ struct amdgpu_usermode_queue {
>         int                     priority;
>         struct dentry           *debugfs_queue;
>         uint64_t                generation;
> +
> +       struct list_head        userq_va_list;
>  };
>
>  struct amdgpu_userq_funcs {
> @@ -138,7 +145,11 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(st=
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
> +int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
> +                              struct amdgpu_bo_va_mapping *va_map, u64 a=
ddr);
> +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
> +int amdgpu_userq_buffer_va_list_del(struct amdgpu_vm *vm, u64 addr);
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
