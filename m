Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159B1CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 22:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4080710E7D3;
	Wed, 13 Aug 2025 22:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mWd9w8ec";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C710510E7D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 22:37:47 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-244582766a8so438955ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755124667; x=1755729467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tei+DQTEQ0wIPYqCvibbPCm1gh4BG5xKH2d8BJoW68w=;
 b=mWd9w8ecBIe/lyIUt6vW1CqAU44FnMRwf/4pAQcjP+u66PRtPGgDDefyS0cUuVE+e4
 yjVvDzQmELLg/PwPfxlNTdPMYuPFvuXxxbw4AFmkXCNII5flEBDv831XoXy2N2Y4CiZx
 1kiChp+WkK5rKzecFKwcXkXe2FULb4NA/9o4rEMM9JvCJgQu74kl79FdR436FUSwNVq4
 1CL2XpMUCiiMMkmqIt2l5AzmJ9M4oeHjloXTxZjtSPY6ZqkNhJ69qtOuzgF+MBr6XqwQ
 YkyC7KcTNPzfd8h1/wbKg5xMGykeAf9h/gs89TVv3QIKs/y2/nrPNaHqdnT4WoHDOV5T
 xjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755124667; x=1755729467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tei+DQTEQ0wIPYqCvibbPCm1gh4BG5xKH2d8BJoW68w=;
 b=DECX2XbT96rEv9HVdCl/bHEtU70toDh57XsWD6k7XSKRypSuIpqq1RNXdvTbW8qjA5
 omaHPFKD9Cz8S7JC2iJydVOozh5INnhRYYwySc3/8bjO1yhouNW+HCWDA166H1Ek3990
 /FhL/p/tUvUmMeayuAMQXQqx6D90LuYz/epRsf68m7ZII8XHihpR73nA+wTtsHDMUht7
 sGLSTViQ/RQxOO2acLckinTDfuEH56IBfwkNT5euBEm1y7iILL0dqre3s4VQd+0i2J2+
 GcQGqFXMP5JCukT5ClmL0mC+AQYyNiHlnwzE6w6m/J+u8zilezslXB5/0RmlhU0hAwEz
 s4aA==
X-Gm-Message-State: AOJu0Yzn/GetG1btW+Vcc1p/wltbE7LAIhDhlFVBLh3FmZj26eKejF2W
 jN9LAyBQHB0UakzYaU2VAO4aRZmTYTWRwOM9E9mso0sVDiCwfLSTqOYjYPvCmGMdJ5lNjKFmLI/
 DDYghG2RjBtUEk2pxGZZguhyRAWqc5q74dH4m
X-Gm-Gg: ASbGncteOCIg3xFASczB8Vs7E/Z+f383hnwVkHBK0yEHEWpbxNjO8dSQ1zDQ2+FyLP9
 h+KkqFIWSYNcIDfyqminHvj5UKdbeXyQYhVI652smVssRZyazWnCNFfWTListWA75asv5UbNDYh
 Zf4CAmPNP+MkTUmUEA3KvbCivy79f7xNywcS4cQ233zzjtvN1Ydu3qf0fGMJjySSFHnUGy5e77B
 zc7HnYOFqE8wvN2Hw==
X-Google-Smtp-Source: AGHT+IFLYvYo1GKvxoLFxZFQS6bxQ04418bp0qg9GihBokbUownk8z3uAkFzuF9qKpSE4+yC24iEm3+kb8EgpxOKAJs=
X-Received: by 2002:a17:902:db12:b0:240:8a87:a187 with SMTP id
 d9443c01a7336-244582c2540mr5787175ad.0.1755124667195; Wed, 13 Aug 2025
 15:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
 <20250808062910.1613453-14-Prike.Liang@amd.com>
In-Reply-To: <20250808062910.1613453-14-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 18:37:35 -0400
X-Gm-Features: Ac12FXzuzUY_4MPExGBjMQxOddlkxnGRcIWQh3FcHFSwkR47jZT12CxC-yweRYw
Message-ID: <CADnq5_Mavhnw4r-RZcdYYEtYtdRuh5LEbKHVNZ6gz9vt5_jQ6Q@mail.gmail.com>
Subject: Re: [PATCH v8 14/14] drm/amdgpu: validate userq va for GEM unmap
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

The start address may not align with the start address of the vital
queue buffers.   Just retain a list of vital virtual address ranges
for each userq and then check if the address range the user wants to
unmap falls into any of those ranges.   If so, then preempt and unmap
the queue and set the status to USER_UNMAPPED or something like that.
Then you don't have to worry about queue specific details as to what
addresses are vital for that queue type.

Alex

On Fri, Aug 8, 2025 at 2:29=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> wr=
ote:
>
> This change validates the userq to see whether can be
> unmapped prior to the userq VA GEM unmap. The solution
> is based on the following idea:
> 1) Find out the GEM unmap VA belonds to which userq,
> 2) Check the userq fence fence whether is signaled,
> 3) If the userq attached fences signal failed, then
>    mark it as illegal VA opt and give a warning message
>    for this illegal userspace request.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 107 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  10 ++
>  3 files changed, 118 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 771f57d09060..314d482849c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -676,7 +676,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>                 }
>         }
>
> -
>         args->out.queue_id =3D qid;
>
>  unlock:
> @@ -1214,3 +1213,109 @@ int amdgpu_userq_start_sched_for_enforce_isolatio=
n(struct amdgpu_device *adev,
>         mutex_unlock(&adev->userq_mutex);
>         return ret;
>  }
> +
> +/**
> + * amdgpu_userq_gem_va_unmap_queue_retrieve - find out userq by gem unma=
p va
> + * @queue: destinated userq for finding out from unmap va
> + * @va: the GEM unmap virtual address already aligned in mapping range
> + * Find out the corresponding userq by comparing
> + * the GEM unmap VA with userq VAs.
> + */
> +static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct amdgpu_userm=
ode_queue *queue,
> +                                                       uint64_t va)
> +{
> +       va =3D va << AMDGPU_GPU_PAGE_SHIFT | AMDGPU_GMC_HOLE_END;
> +
> +       switch (queue->queue_type) {
> +       case AMDGPU_HW_IP_GFX:
> +               if (queue->queue_va =3D=3D va ||
> +                   queue->wptr_va  =3D=3D va ||
> +                   queue->rptr_va  =3D=3D va ||
> +                   queue->shadow_va =3D=3D va ||
> +                   queue->csa_va  =3D=3D va)
> +                       return true;
> +               break;
> +       case AMDGPU_HW_IP_COMPUTE:
> +               if (queue->queue_va =3D=3D va ||
> +                   queue->wptr_va =3D=3D va ||
> +                   queue->rptr_va  =3D=3D va ||
> +                   queue->eop_va  =3D=3D va)
> +                       return true;
> +               break;
> +       case AMDGPU_HW_IP_DMA:
> +               if (queue->queue_va =3D=3D va ||
> +                   queue->wptr_va =3D=3D va ||
> +                   queue->rptr_va =3D=3D va ||
> +                   queue->csa_va =3D=3D va)
> +                       return true;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return false;
> +}
> +
> +
> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> +                               uint64_t va)
> +{
> +       u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
> +       struct amdgpu_usermode_queue *queue;
> +       struct amdgpu_userq_mgr *uqm, *tmp;
> +       int queue_id;
> +       int ret;
> +
> +       if (!ip_mask)
> +               return 0;
> +
> +       /**
> +        * validate the unmap va sequence:
> +        * 1) Find out the GEM unmap VA belonds to which userq,
> +        * 2) Check the userq fence whether is signaled,
> +        * 3) If the userq attached fences signal failed, then
> +        *    mark as invalid va opt and give a warning message
> +        *    for this illegal userspace request.
> +        */
> +
> +       if (mutex_trylock(&adev->userq_mutex)) {
> +               list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list,=
 list) {
> +
> +                       if (!mutex_trylock(&uqm->userq_mutex))
> +                               continue;
> +
> +                       idr_for_each_entry(&uqm->userq_idr, queue, queue_=
id) {
> +
> +                               if (!amdgpu_userq_gem_va_unmap_queue_retr=
ieve(queue, va)) {
> +                                       dev_dbg(uqm->adev->dev, "va: 0x%l=
lx not belond to queue id: %d\n",
> +                                               va, queue_id);
> +                                       continue;
> +                               }
> +
> +                               if (queue->last_fence && !dma_fence_is_si=
gnaled(queue->last_fence)) {
> +                                       drm_file_err(uqm->file, "an illeg=
al VA unmap for the userq\n");
> +                                       queue->state =3D AMDGPU_USERQ_STA=
TE_INVALID_VA;
> +                                       ret =3D -ETIMEDOUT;
> +                                       goto err;
> +                               }
> +                               /*
> +                                * At here still can't suspend the userq =
since here just one kind of
> +                                * VA unmapped, and some other VAs of use=
rq may still be mapped. After
> +                                * this point this VA mapping will be det=
eled and the VA will be unmapped
> +                                * so will not resume the userq when its =
VA unmapped.
> +                                */
> +                       }
> +                       mutex_unlock(&uqm->userq_mutex);
> +               }
> +       } else {
> +                       /* Maybe we need a try lock again before return*/
> +                       return -EBUSY;
> +       }
> +
> +       mutex_unlock(&adev->userq_mutex);
> +       return 0;
> +err:
> +       mutex_unlock(&uqm->userq_mutex);
> +       mutex_unlock(&adev->userq_mutex);
> +       return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index cf35b6140a3d..27ab8a6a7be6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -149,4 +149,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm =
*vm,
>  int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
>  int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
>                         struct amdgpu_usermode_queue *queue);
> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> +                               uint64_t va);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index f042372d9f2e..533954c0d234 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>         struct amdgpu_bo_va_mapping *mapping;
>         struct amdgpu_vm *vm =3D bo_va->base.vm;
>         bool valid =3D true;
> +       int r;
>
>         saddr /=3D AMDGPU_GPU_PAGE_SIZE;
>
> @@ -1949,6 +1950,15 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>                         return -ENOENT;
>         }
>
> +       /* It's unlikely to happen that the mapping userq hasn't been idl=
ed
> +        * during user requests GEM unmap IOCTL except for forcing the un=
map
> +        * from user space.
> +        */
> +
> +       r =3D amdgpu_userq_gem_va_unmap_validate(adev, saddr);
> +       if (unlikely(r && r !=3D -EBUSY))
> +               dev_warn(adev->dev, "Here should be an improper unmap req=
uest from user space\n");
> +
>         list_del(&mapping->list);
>         amdgpu_vm_it_remove(mapping, &vm->va);
>         mapping->bo_va =3D NULL;
> --
> 2.34.1
>
