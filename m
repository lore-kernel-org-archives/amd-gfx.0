Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15D7CAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5417410E1CA;
	Wed, 17 Sep 2025 14:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EsEIZDm1";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFEF310E1CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:10:17 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-269640c2d4bso654865ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758118217; x=1758723017; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2bBDlUzZ8rqtJwLPuYCXBqAv8Fg2j/j3T65P0xiE2gs=;
 b=EsEIZDm1iOTIUjTEZBDuAiUJA3inD9Bucqf6k0xWg9vBxVX9L1pE/8vNeWLgU4WcWE
 NMvFSad5oTHVRHZ33K31N+1fWAFizu46rvPLcvDUFLw9FftjjuDqLHkU9P38VrN99kTs
 sgESbyU7/GNT3Z9bQgD9cjBh9h/W+enVga7Lm55QC0r+cQQ9yMzuXMArK/j70TC4bd8Y
 5dFeTIy/JHNGVHZQOaWwFfeocj+HwipCsxf8EIc2tb9kEJXi+5EMaGPythSUKlx82xfr
 ak25vhZ7ZBBUFauvA7EHXyZV6w0vqtQnCxmZZ3Y2N9XeB9wnPCTG4537iwXVcpL8aukT
 2cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758118217; x=1758723017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2bBDlUzZ8rqtJwLPuYCXBqAv8Fg2j/j3T65P0xiE2gs=;
 b=reNJQNuvDOswBpTA4wqGi/N9tB7niO2MKlKt9Qod6VkJ528Tn2AunPEAsL+dl8It4x
 nO6zNnQaCm7JcBggbnC4/dWXgVO9J+RCDvSjzz6BbZO+2T4bwy7KU377B+l64r7RmXd2
 dhlw4hTjk8INa4AZzIhVSIg9W/c7HyVP6bayFQ37LnUGo/b89FF41w/bHWSof41ho9Oz
 sz3+YqFpyRbpI6Sj/CjsXGn/q9c8/IPiE66+kioTWUY/SPRk4d0zB2/UREdY1WVzMUSJ
 7nHT2FWPoYiBUYT1QFUBcImjbmSDenHjuT2XCOxytS5eBAW93lrYHCo9UfoUt+DCIbSX
 UHxg==
X-Gm-Message-State: AOJu0YzYFKeN0cEYmg6iw67LPD9ohQjmNBzslSKk54VZ2Av5O2el9Hjo
 gvP7Rz8iWjiXd3DFa87pr8VIiFp1SejNq5IBQpUS+dSlYaFdOejKIxJmr4r17WtMoaem5XKwHeF
 D6xPI+M03wfkMd3iKZH36Y0rwHuWO7lk=
X-Gm-Gg: ASbGnct1+P8OFi8Ret5sWy3NxC0rtYTPT1t9H9Kth3/J21f2J2Eam7SvEayBrKJhsLm
 kKpANfA6xQHKiKe3dEaplnZqPJOlAliTTF9arztKSpE6f0EyV/GpU0zjllxEQ6JATA4dP9U19/O
 liB4AgjRiRlV5wTyiZEdpGqph9lfqh09PaRDMyoujqwIqkEdvJ/hQZqibRlidPYLNATSa4C29oN
 DJtiSIP
X-Google-Smtp-Source: AGHT+IF32L1J6xZ8ANfxo8ghZQ/mp76ZM1mmTpgnx5i9zVVYIaPzzlDqppHB9aJPWUZ8EOceED2k5kIkdnSqbhO2yCc=
X-Received: by 2002:a17:903:5d0:b0:24c:b36d:637 with SMTP id
 d9443c01a7336-26811ba4d0cmr11966105ad.1.1758118217094; Wed, 17 Sep 2025
 07:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
 <20250912055518.2719533-9-Prike.Liang@amd.com>
In-Reply-To: <20250912055518.2719533-9-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Sep 2025 10:10:05 -0400
X-Gm-Features: AS18NWBVjjXJullSTrwaKittR_r62bWmAxBCF-G_Pq-YEqJMCYkC3mxQ4AYnBOs
Message-ID: <CADnq5_O8AA=LvBwv518uwbW=YHBAuedg+WsoQodLwinTdL+hMg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] drm/amdgpu: validate userq va for GEM unmap
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

On Fri, Sep 12, 2025 at 2:04=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> When an user unmaps a userq VA, the driver must ensure
> the queue has no in-flight jobs. If there is pending work,
> the kernel should wait for the attached eviction (bookkeeping)
> fence to signal before deleting the mapping.
>
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
> index a13f186f0a8a..e14dcdcfe36e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1182,3 +1182,32 @@ int amdgpu_userq_start_sched_for_enforce_isolation=
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

dev_warn_once() so we don't spam the logs.

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
> index 8cd307be7256..c9a41876f10e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -157,4 +157,7 @@ int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, =
u64 addr);
>  int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
>                                 struct amdgpu_usermode_queue *queue);
>  bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)=
;
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

dev_warn_once().

This looks good to me, but it would be good to get Christian's input as wel=
l.

Alex

> +       }
> +
>         list_del(&mapping->list);
>         amdgpu_vm_it_remove(mapping, &vm->va);
>         mapping->bo_va =3D NULL;
> --
> 2.34.1
>
