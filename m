Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A467CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 19:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F338F10E03C;
	Thu, 11 Sep 2025 19:18:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fLk1kiEj";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D66810E03C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 19:18:19 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-24498e93b8fso1587925ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 12:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757618299; x=1758223099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZKHQ7PXC7nCVmaNPWl6CJ2alAld4TrTeugE437m5+q8=;
 b=fLk1kiEjx8OtWcqlWPP8Adnv3QpZcv0i0PWbc3Ky1FUteY+9+P+Qzdeafbgr6y4MsD
 wPYNRVs94wyd2l4ry+E3vSki85RNHGUdysjNyybcKCODaTrqNwjoV8oQ5+KTQcC5uL6B
 V6L3Aa7MG01enu38ThURHp6jQMjfqPczluud2N9HChQK9McsHZ7TsGbEuwGqzy8qsHNs
 YiWBfIujgPdG1WvtoiM5lVN1MKRVDS80TC0njMUp05zghtGYSSV0+Z6tC0lW61dsQSsV
 lhVZCa2I9o5sol71kEXYc0ugOLflbfiYv/exGX1iPm99SrOpagu08ubZ2Qhi3r3BZB89
 iGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757618299; x=1758223099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZKHQ7PXC7nCVmaNPWl6CJ2alAld4TrTeugE437m5+q8=;
 b=MTa7EvLjoVmpZvMJNKvYcROkDhrcIyQB/ESP//aN2SEZJe3RhHYbmA9F4DLUb/PHW4
 PQd0go0sudFARcPPlD0kveLh9ZBiBwvP6HZSpSZ+L5OZmPbB8hA7Dsn11qQ5OVlqdb5N
 52y0ZGZJAekyaqg3732JonrC1V373c0hpQuhP+ja5bzL0G9pbsZRBUSqlek4BUjjsWk5
 KdlTriYQUsetBlJQ6eqSuC9Cs6E2yV2d5wpVjKGBH4dJQijiqifaaIeQQiMsRWLwqQwk
 OpIKxZYeurKKS8bQDEJlzEiVD7V4P8LLMz1H0mGnidRJOoueAzgsLXgrgb9Mk6mRQnij
 EkZQ==
X-Gm-Message-State: AOJu0YyBXhlNZkDDiGJ3nB0BjmXR/DnbVl80YXrYJ5XoKpp/2MkW6y5b
 qUGkMaWaJlGh0arFcM+DHcHoxK1XFwvshXYFuqgHjE3dOsWylwACKoyUFlfr1jSPo2vrKQyRddB
 1MkLZy4b2pNCJNW6z+FwbaWC9bivl9Q72Eg==
X-Gm-Gg: ASbGncvNx0RO8LtuUlZdY6iIkfxb0BjpUlB7vpulm1XrkSNtrgZA5KjjXC5ewg5tqZc
 WQVJ6aAhC7PVPZe9bpBMFVKV5r+MPMvULKcByIkHhieeGRdL+Lmx0nATgXV0LGwtTWZGga13Jcm
 GMNHv0Eh1NfrhbEmXL6XmngZM+IfLqe6nAbrfyYE+aWFx8x9zPRAut2KtX2/6BG3Pjww1kj2n9a
 Ie+Sb6WJzp+Tv/idg==
X-Google-Smtp-Source: AGHT+IHuKAONJFYa9ShPxDadx38eQCuHTu+vNfCnRjbdiL4wZ8Ba5KwhCkkaoxp/vD5hmdPsr7h6nyxemzaENp+LaZQ=
X-Received: by 2002:a17:902:fcd0:b0:24b:26d7:e28e with SMTP id
 d9443c01a7336-25d2675db6amr1805285ad.5.1757618298837; Thu, 11 Sep 2025
 12:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
 <20250910113731.2688320-9-Prike.Liang@amd.com>
In-Reply-To: <20250910113731.2688320-9-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 15:18:05 -0400
X-Gm-Features: Ac12FXxygwD1C5WX9Dkh0eino3O0C5q5OwMxVVWYf1q-IAAHjtJhYQzQ3pO3e1c
Message-ID: <CADnq5_P4t4T9Aewg5Zp8X1aqSf1W0asvVJYPPUn1jLTUz7y8mg@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/amdgpu: validate userq va for GEM unmap
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

On Wed, Sep 10, 2025 at 7:44=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> When a user unmaps a userq VA, the driver must ensure
> the queue has no in-flight jobs. If there is pending work,
> the kernel should wait for the attached eviction (bookkeeping)
> fence to signal before deleting the mapping.
>

Seems reasonable to me, but it would be good to get Christian's input
here as well.

Alex

> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 29 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 11 +++++++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index fa44a47b2734..7976951c1a87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1188,3 +1188,32 @@ int amdgpu_userq_start_sched_for_enforce_isolation=
(struct amdgpu_device *adev,
>         mutex_unlock(&adev->userq_mutex);
>         return ret;
>  }
> +
> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> +                                      struct amdgpu_bo_va_mapping *mappi=
ng,
> +                                      uint64_t saddr)
> +{
> +       u32 ip_mask =3D amdgpu_userq_get_supported_ip_mask(adev);
> +       struct amdgpu_bo_va *bo_va =3D mapping->bo_va;
> +       struct dma_resv *resv =3D bo_va->base.bo->tbo.base.resv;
> +       int ret;
> +
> +       if (!ip_mask)
> +               return 0;
> +
> +       dev_warn(adev->dev, "now unmapping a vital queue va:%llx\n", sadd=
r);
> +       /**
> +        * The userq VA mapping reservation should include the eviction f=
ence, if the eviction fence
> +        * can't signal successfully during unmapping, then driver will w=
arn to flag this improper unmap
> +        * of the userq VA.
> +        * Note: The eviction fence may be attached to different BOs, and=
 this unmap is only for one kind
> +        * of userq VAs, so at this point suppose the eviction fence is a=
lways unsignaled.
> +        */
> +       if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
> +               ret =3D dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKE=
EP, true, MAX_SCHEDULE_TIMEOUT);
> +               if (ret <=3D 0)
> +                       return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index cd63f7d79a95..65a8b750e664 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -159,4 +159,7 @@ int amdgpu_userq_buffer_vas_put(struct amdgpu_device =
*adev,
>                                 struct amdgpu_usermode_queue *queue);
>  bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
>                                     struct amdgpu_usermode_queue *queue);
> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> +                                      struct amdgpu_bo_va_mapping *mappi=
ng,
> +                                      uint64_t saddr);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index bd12d8ff15a4..ccde1f040cef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1941,6 +1941,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>         struct amdgpu_bo_va_mapping *mapping;
>         struct amdgpu_vm *vm =3D bo_va->base.vm;
>         bool valid =3D true;
> +       int r;
>
>         saddr /=3D AMDGPU_GPU_PAGE_SIZE;
>
> @@ -1961,6 +1962,16 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>                         return -ENOENT;
>         }
>
> +       /* It's unlikely to happen that the mapping userq hasn't been idl=
ed
> +        * during user requests GEM unmap IOCTL except for forcing the un=
map
> +        * from user space.
> +        */
> +       if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
> +               r =3D amdgpu_userq_gem_va_unmap_validate(adev, mapping, s=
addr);
> +               if (unlikely(r =3D=3D -EBUSY))
> +                       dev_warn(adev->dev, "Here should be an improper u=
nmap request from user space\n");
> +       }
> +
>         list_del(&mapping->list);
>         amdgpu_vm_it_remove(mapping, &vm->va);
>         mapping->bo_va =3D NULL;
> --
> 2.34.1
>
