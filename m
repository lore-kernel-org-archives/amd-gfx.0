Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B911C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 15:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE5D10E783;
	Tue, 17 Jun 2025 15:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Akowo7IH";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FAD10E36D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 15:35:19 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-313dc7be67aso748491a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750174519; x=1750779319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DT7MPDDrbZrR1dO3HUzhcPn2a+QyOU2FbNu8KVIIzQY=;
 b=Akowo7IHSBsm+rIAVXEA1Efisflkn6G67S/NNg6nnJlE0Y1IV46d8IjPBubP3FBu7P
 H7K5GzJvSQx7RfvWao5Nx+ohTZ5MzPFtW+W/EH43iXa8+8vMWaGzHFk75PDAqnoVm16t
 SCrmFhZGtdgvPQoh59s1UXcqEVdE7lwXazi6y2S1/tNF2AK17WNXIopgtwhNLb6RH8YW
 C+6/bzn4dg3A7hI1WyZnB6QRLS2CzFrosfqzWaVHQxuopYCbsDupIgVc2QLrV60c3WaN
 kXq3/Du2+T8MbBwgPGtDZkheanKhgmDFz3bs4Eq0Mq8f0UtAOAuys/vjUDS2EspsAh7a
 u0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750174519; x=1750779319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DT7MPDDrbZrR1dO3HUzhcPn2a+QyOU2FbNu8KVIIzQY=;
 b=JEvjk4Gp84yqLkhj+gGKR40JOS+OecjKqFlWo/poIpfhE/D4GpE3T3PFnVGvPyulaF
 sFGIbjmdSJkU8KKzgEZdVFje9hhiqEHlOEA4rRRE0UjVEqBZ1xCJXR80gy2YjnCRKvRm
 RtczjIbwG1oNvTk2kBc80Y7tfubhkqkO8wcpt5p3rxfcVP2B0ci6lMYGraFXODVJst3N
 M31DZrl3wSHpl/q3d36dIYBk9Y6OzkMyVp/CAb6mBb6uOo4l1OccR5UtOXYwvyMXRE8Q
 Bhxu1Sv6hgiTjbkSvUH09Opc5zqM9Z+ZK2cP8Qs9A6f+BJIvFF8gCQ6TFloC8dvAzHI+
 weUA==
X-Gm-Message-State: AOJu0YzWB65WHAUtmJS9mbHiEje8/wJIZEInVSE/sPMeF4thvJTOe0Bz
 D3pvwFiEM+KsM5QR5uIhfkNI2yOShKOWcmHd+16GWCLdBYxoxXiimO4ykxKAI1XtpvW+SNuN1GQ
 l1B9NxCftu8hQ2t5Jb9LT/W7mQyf921ebvQ==
X-Gm-Gg: ASbGncttRSLKcZ6kptszj+24eyHNqhglX/Ibjf73sJamQf2nhD+y05mxRVDauH3lRUy
 Mr2deA2IMT8C6+45OAsiya6S8JjUEs1NUqCdc7Jinht8oViUtt79JrOXZ+w7G2LydgTkZu1vSid
 YjMCnW8pJI5zSS9oRdLoPBUXezoaF7Jqtt35yR6jTdAwuy
X-Google-Smtp-Source: AGHT+IGUhbRe2fiB/nQJaxUzqsjbRHbrTMIlgN1BmvdOPqQOvTxJszkvwUCz7lNUEkcgzU3kddG+vj9JGUrN9WYq2b0=
X-Received: by 2002:a17:90a:e7c7:b0:311:a314:c2dd with SMTP id
 98e67ed59e1d1-313f1daf4b3mr8711899a91.4.1750174519331; Tue, 17 Jun 2025
 08:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
 <20250617080151.1093481-5-Prike.Liang@amd.com>
In-Reply-To: <20250617080151.1093481-5-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 11:35:07 -0400
X-Gm-Features: AX0GCFuNsVjRyRPffOJv9Zc3-TVUxV7Hk6atFDPvK0-djoMeNyKhrPg41Kg4xNA
Message-ID: <CADnq5_NqcnA4Adc5fmJVSHADp_NuLnuwn_tqfECb5NL7Gx63Ng@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] drm/amdgpu: add userq object va track helpers
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

On Tue, Jun 17, 2025 at 4:27=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Add the userq object virtual address get(),mapped() and put()
> helpers for tracking the userq obj va address usage.

Need to add the other metadata buffers to the tracking.

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 114 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  11 +++
>  2 files changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index db47e90b8c83..2882ef8fe719 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -76,6 +76,116 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *=
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
> +               amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
> +               amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va))
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
> +        * As the GEM userq bo will be unmapped by amdgpu_vm_bo_unmap() w=
hich is
> +        * invoked before destroying userq. So if the user wants to refer=
ence/dereference
> +        * the userq vm bo, then ensure the userq vm bo is dereferenced b=
efore amdgpu_vm_bo_unmap()
> +        * or unmap the userq bo VA at amdgpu_userq_destroy() directly; o=
therwise, that results in the
> +        * userq va BOs being referred to unbalanced and causing the fail=
ure of amdgpu_vm_bo_unmap().
> +        */

I don't follow this comment.  Why wouldn't this be balanced?

Alex

> +       /*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
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
> +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
> +                       struct amdgpu_usermode_queue *queue)
> +{
> +       amdgpu_userq_buffer_va_put(vm, queue->queue_va);
> +       amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
> +       amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
> +
> +       return 0;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -442,6 +552,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
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
> @@ -472,7 +585,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
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
> index 704935ca0c36..9543fbab7cc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -52,6 +52,10 @@ struct amdgpu_usermode_queue {
>         enum amdgpu_userq_state state;
>         uint64_t                doorbell_handle;
>         uint64_t                doorbell_index;
> +       uint64_t                queue_va;
> +       uint64_t                rptr_va;
> +       uint64_t                wptr_va;
> +
>         uint64_t                flags;
>         struct amdgpu_mqd_prop  *userq_prop;
>         struct amdgpu_userq_mgr *userq_mgr;
> @@ -134,4 +138,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(s=
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
> --
> 2.34.1
>
