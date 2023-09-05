Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DBECA101A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 22:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432EF10E099;
	Tue,  5 Sep 2023 22:40:21 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5E510E099
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 22:40:19 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ab3aa9ae33so1455577b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693953618; x=1694558418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juzhg2q0V4JhQjZb7dEt4noSTQ9BtCbe2Q+5S+pM+t0=;
 b=r4pG8bQeTRjM61EeZ+oe+8qmJO1XbJZwz45vFC4E/D2TaQewKJJW7O4L4fHZXI/ivT
 RyLmo7Zr/ZsKiI8BJHC8psBNRYImfIiAxhEM+PI/q/b+aa7nvE8ZPLINWe7ZNEdxrngp
 Qp4UHbjMQfLGzCENoA7OY+br64TCpHm2KYXw2Cg0xQzdp9yDXAh9NAkRUYr3atO6/Ktg
 UF2Z7DvJmeCKc0i1ey9deFmIO79T+Aqa2RKfx2UeGnXX7eFX+jgLJ9GWqbsEckE3XH3M
 FjBNxCJNxaqdzRUKpz5PbS0NO91TtevLWx7O+fnjIFswnaYUuKtSdUV5JRqi9c7K4rK7
 33CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693953618; x=1694558418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=juzhg2q0V4JhQjZb7dEt4noSTQ9BtCbe2Q+5S+pM+t0=;
 b=ixUDTF4PI2LIGQLfp+15g9lsCauTSHw6kzhyhk2dFpsNp2azJ+eQaAcQ5YW5pzC897
 4lY0C+HdYoITQYErctLZIuPo60f3MG5n2sC4FR2K6s2cAlmwBNJmsr1L9C49YfwM7CCe
 2hOoNYc2Y9+zw9K3anyW17cYSFLM3QeDyUcQAxTtLtjrjp0Vwpc0cMuwrSGOZ5UvR4Su
 v0zr7Pos1ICWXABiwMgbMC6waoIMbbdOljlHD+MkNA/u0BiBm4yoG77QBoFL5lMhNN93
 NXTSWyZOkSL3OtdbWYi4ZQWHABd697drfUsz6GS5mkHS+qmq4MyrS+U5Gbnro/wLgYq3
 S9YA==
X-Gm-Message-State: AOJu0YxQHR4atDyeEe6ZHefZxDgK72Mz64IrISxZlKacyTsM/8hQmDgQ
 /lNdvGvEqNIueSXHjhrF5HfhiQ5hp1RjiI9QRSQ=
X-Google-Smtp-Source: AGHT+IE0L6S6ecFyZfHvSZtvrif45X/uZGoVguUAUIG4sx9nC2XSzxoRAkqV3EI0Ub2vxLQ5/Co62P4PZAnyLOMwyew=
X-Received: by 2002:a05:6808:1ab3:b0:3a7:25c6:7b83 with SMTP id
 bm51-20020a0568081ab300b003a725c67b83mr12819746oib.11.1693953618236; Tue, 05
 Sep 2023 15:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-6-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-6-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 18:40:07 -0400
Message-ID: <CADnq5_PeW6d2DXpqfwXkUraq5Vj+e=NvS8SjSWE6axm-94sW9A@mail.gmail.com>
Subject: Re: [PATCH 05/11] drm/amdgpu: fix and cleanup
 gmc_v8_0_flush_gpu_tlb_pasid
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 5, 2023 at 3:00=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Testing for reset is pointless since the reset can start right after the
> test. Grab the reset semaphore instead.
>
> The same PASID can be used by more than once VMID, build a mask of VMIDs
> to reset instead of just restting the first one.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 5af235202513..2d51531a1f2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -31,6 +31,7 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_gem.h"
> +#include "amdgpu_reset.h"
>
>  #include "gmc/gmc_8_1_d.h"
>  #include "gmc/gmc_8_1_sh_mask.h"
> @@ -616,25 +617,24 @@ static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdg=
pu_device *adev,
>                                         uint16_t pasid, uint32_t flush_ty=
pe,
>                                         bool all_hub, uint32_t inst)
>  {
> +       u32 mask =3D 0x0;
>         int vmid;
> -       unsigned int tmp;
>
> -       if (amdgpu_in_reset(adev))
> -               return -EIO;
> +       if(!down_read_trylock(&adev->reset_domain->sem))
> +               return 0;
>
>         for (vmid =3D 1; vmid < 16; vmid++) {
> +               u32 tmp =3D RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>
> -               tmp =3D RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>                 if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
> -                       (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) =3D=
=3D pasid) {
> -                       WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
> -                       RREG32(mmVM_INVALIDATE_RESPONSE);
> -                       break;
> -               }
> +                   (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) =3D=3D pa=
sid)
> +                       mask |=3D 1 << vmid;
>         }
>
> +       WREG32(mmVM_INVALIDATE_REQUEST, mask);
> +       RREG32(mmVM_INVALIDATE_RESPONSE);
> +       up_read(&adev->reset_domain->sem);
>         return 0;
> -
>  }
>
>  /*
> --
> 2.34.1
>
