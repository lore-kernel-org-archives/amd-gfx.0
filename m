Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6E4CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 20:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACFC10EA94;
	Fri, 19 Sep 2025 20:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i7nn/QtI";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 955FD10EA94
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 20:30:37 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-24498e93b8fso3249445ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758313837; x=1758918637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNFp4pDeEZP/S2AXfySdFFxiBPsHRDyOo76vGXd7KkY=;
 b=i7nn/QtIyAKOP3T1BuCUf6eUrTObJMtk7aru6f+9BsPW5tAlNedZ/o9hEBNBPfGHcA
 z6/q3RuIEjUEbp+nPqvTbT5IjEN7fX0Kj4PPT1z4TKWG/amdX/gPkgXlMuENeH1b92Tt
 hHGMXDZAf/oGJRJ7TKFs6dmkw3kXSAFIlP4Dn+vFGDNfPu1SrfS13a8PJ6w0VEMjzokF
 2GrngT4zdeaaW1azJz7Gc1gVWoyPtK+wAqVMcO2Jw2hV9P/AFXrVbiTDfanuKGKidg3q
 WQQBNAHXATleKJKSg7+3MkATH+1CergtQZqUQAnEQ6Rja6xde0J2Bry9ByFHn2xREy1F
 Ydwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758313837; x=1758918637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNFp4pDeEZP/S2AXfySdFFxiBPsHRDyOo76vGXd7KkY=;
 b=ii6sLY8dfbsCBCwowxtz8eyR1BS+ztSwuKWnMeR/HqiXoqWuSZIzZ9m3AEjZ/f7Qy8
 Mo81oiOK7KZh019ooeX9u5DZokfkPL1u40SPdZksxunaezYp2Mqgt8sdTyluGWpqC3gq
 0j1fXMbaOoMzTSrGHGnFBzqAZOJEtpw8hrbhEKT85zrW/qRbU3Ey+FmaP9nE/7RJWg3k
 2pQochSSc+9RBup+5Rzm19yMhOtlinVic4dqakZpE6NMLAWXf9hUeoZV57LEKlaJWCVm
 HlxLXn4+JqLxa8dj2MSwv90/IzriGl63Fzh/ou9nCMSdfIx7174lFkjksrjovMnCz8F+
 Q1Yw==
X-Gm-Message-State: AOJu0YwB6nuoR0ti121JStiWKeAc8K0dVfc0wbPKBlmyArR23KKhmb0L
 QYnZN1/8aaVhzz14nAWz1kASy925BxdZtovKm80SvZ5Ailu3YNsH/G94ZKxD+EbUFA1BxZ3QqwH
 qRalsq2AnzyJgRQAZ4MrkkKqe7oXcYSA=
X-Gm-Gg: ASbGnctzW9eEnCd+/9PH+PnNoVoxl41DiK5gjp7kUMqYgTTDLvZM+YvbHU+CUaeNNR3
 UmJIkoyRiSWqk19x4cMwFaMN17NNyYxx3wzAHKyDWovh8DVXy4xySMVAzZWD5m6icgV6/Hxp0oL
 qwM8R24WUMcQp7PjX/vaJiJYhEk1J5GPL+YmeeeD94cq1gw+PUfz1O4YmHKy8PTWthLw0eqtaNx
 eI+gMk=
X-Google-Smtp-Source: AGHT+IHZQSLwOm8vH6ELmscvYF1XvG2h1G5VUe9dJUrWmyyYgqM+EwvN8zWPpVMjmMmEaOhELy4ZHIox1yUjH3u7S1I=
X-Received: by 2002:a17:902:da81:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-269ba26087cmr32520215ad.0.1758313837069; Fri, 19 Sep 2025
 13:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
 <20250919081113.2797985-6-Prike.Liang@amd.com>
In-Reply-To: <20250919081113.2797985-6-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 16:30:24 -0400
X-Gm-Features: AS18NWDz1ZEcU25OvtA35mAiBamqOg_2AaazmIfOpf8D1rUMzNKHGO5ePhKE4_Y
Message-ID: <CADnq5_NXrsV6YuXfQPu1yUvO-_ZYJsxvy=c8rdae39g1uQg-Rg@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] drm/amdgpu: validate userq va for GEM unmap
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

On Fri, Sep 19, 2025 at 4:19=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> When a user unmaps a userq VA, the driver must ensure
> the queue has no in-flight jobs. If there is pending work,
> the kernel should wait for the attached eviction (bookkeeping)
> fence to signal before deleting the mapping.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 31 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 12 +++++++++
>  3 files changed, 46 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 402145d64714..224d09019997 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1195,3 +1195,34 @@ int amdgpu_userq_start_sched_for_enforce_isolation=
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
> +       dev_warn_once(adev->dev, "now unmapping a vital queue va:%llx\n",=
 saddr);
> +       /**
> +        * The userq VA mapping reservation should include the eviction f=
ence,
> +        * if the eviction fence can't signal successfully during unmappi=
ng,
> +        * then driver will warn to flag this improper unmap of the userq=
 VA.
> +        * Note: The eviction fence may be attached to different BOs, and=
 this
> +        * unmap is only for one kind of userq VAs, so at this point supp=
ose
> +        * the eviction fence is always unsignaled.
> +        */
> +       if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
> +               ret =3D dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKE=
EP, true,
> +                                           MAX_SCHEDULE_TIMEOUT);
> +               if (ret <=3D 0)
> +                       return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index f19416feb7ef..7bbbb5988fc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -146,4 +146,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(st=
ruct amdgpu_device *adev,
>                                                    u32 idx);
>  int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
>                                    u64 addr, u64 expected_size);
> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> +                                      struct amdgpu_bo_va_mapping *mappi=
ng,
> +                                      uint64_t saddr);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 1ccd348bf48b..e12a314d27a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1966,6 +1966,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>         struct amdgpu_bo_va_mapping *mapping;
>         struct amdgpu_vm *vm =3D bo_va->base.vm;
>         bool valid =3D true;
> +       int r;
>
>         saddr /=3D AMDGPU_GPU_PAGE_SIZE;
>
> @@ -1986,6 +1987,17 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
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
> +                       dev_warn_once(adev->dev,
> +                                     "Here should be an improper unmap r=
equest from user space\n");

Rephrase the error here.  Maybe something like:

"Attempt to unmap an active userq buffer\n"

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> +       }
> +
>         list_del(&mapping->list);
>         amdgpu_vm_it_remove(mapping, &vm->va);
>         mapping->bo_va =3D NULL;
> --
> 2.34.1
>
