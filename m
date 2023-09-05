Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D89CA101A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 22:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17C310E529;
	Tue,  5 Sep 2023 22:48:19 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17AE010E529
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 22:48:18 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ab244ef065so2131938b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693954097; x=1694558897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S494mGGLZq6l4K9OmqAsNnqemuscHH4cJDtmt3MvrFE=;
 b=eTfBMgHqh/f8aUn3mujwyiIX+ktFZ3d5iTUy42AvKRLTRlvEOKMzgJZ412x2WWmEML
 9hPsxzH7Rkqy4fzmA+4yRc/93Aas9TXcHzND9SdcNKRpxzC4tKfNFYOJT4TeWBZUo09e
 EAiVBWLfd0asIFef2yNoaDyFRWvHVaPxRfLt/JaONvJI+bQ02gb0VY5v48aRcweASnWo
 XbciWjGyMvCY5b/0BqbKonrJ1oDzytFd0NJfVNXluDX0iBXN6AAlL7E86Nxxb10giNgB
 LkpWWom2VvGl2Fmg/I66SBrUef+nowasEFLegqHKOdOe9bp732vzJY2ssw83QF1/DIg1
 pS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693954097; x=1694558897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S494mGGLZq6l4K9OmqAsNnqemuscHH4cJDtmt3MvrFE=;
 b=ljBWKQdAyn+QJxG0kbEvsJDJZhh4MlLmlnoYO0wDqeWARkjYhKGU7J+RJT15MnU+JJ
 bAl9nZg2F5h+vt6VytTuxdT30BaqlRgrv/jAUxH9Yua0X9Yw8Us+c52+H/Wtb9mNM2r3
 UeDJv3BCTPJ5m34nC44r+pjcCp5c0681WoKZ9n7sElN7YDPAi0B8Yqy0HltknM0D/Gve
 w6gxPzAWzuIfVYpSs5Xt69Cmt+BuFp+zMXGWLOsLLceauUvRXND5T13lD9kknqlPSdLn
 RzKu8MYS5FduKiUSYJl+br6AvV+n6Y8YsgeHI4CootvComj6XKJ+9fdd6iFSg77+52ci
 dqCg==
X-Gm-Message-State: AOJu0YwVrcoGGDBJAyrZ6mnU21WUsmXjVMTTdmbk4KAtmR0ULZJEJDON
 FIDuf2zmP40jwOzfhx+I1qVGgosS8BfNRJ8Uwjd9FlAVJ04=
X-Google-Smtp-Source: AGHT+IGFEdCHVTikE7noHSmjRE+nI/q8A0PnbEDayKALNGbrpPn4px1UVi8UURddUw8fTAKe6ku1VOLkCXno9wv5t+4=
X-Received: by 2002:a05:6808:bc2:b0:3a4:1c16:b1bc with SMTP id
 o2-20020a0568080bc200b003a41c16b1bcmr18451770oik.12.1693954097154; Tue, 05
 Sep 2023 15:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-10-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-10-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 18:48:06 -0400
Message-ID: <CADnq5_Nc=_GEqwjaAShnvV2xTLQx5Y5UH0jqgkxZfmiQj3LfoQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] drm/amdgpu: drop error return from
 flush_gpu_tlb_pasid
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

On Tue, Sep 5, 2023 at 2:30=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That function never fails, drop the error return.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 7 +++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 7 +++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 9 ++++-----
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 9 ++++-----
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 8 +++-----
>  7 files changed, 24 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index b5f1a1218725..15814cb801e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -638,9 +638,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_dev=
ice *adev, uint16_t pasid,
>
>         if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
>             !down_read_trylock(&adev->reset_domain->sem)) {
> -               return adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pas=
id,
> -                                                               flush_typ=
e,
> -                                                               all_hub, =
inst);
> +               adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> +                                                        flush_type, all_=
hub,
> +                                                        inst);
> +               return 0;
>         }
>
>         /* 2 dwords flush + 8 dwords fence */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index 7732d4ef845e..dd0ede75e5d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -130,9 +130,9 @@ struct amdgpu_gmc_funcs {
>         void (*flush_gpu_tlb)(struct amdgpu_device *adev, uint32_t vmid,
>                                 uint32_t vmhub, uint32_t flush_type);
>         /* flush the vm tlb via pasid */
> -       int (*flush_gpu_tlb_pasid)(struct amdgpu_device *adev, uint16_t p=
asid,
> -                                       uint32_t flush_type, bool all_hub=
,
> -                                       uint32_t inst);
> +       void (*flush_gpu_tlb_pasid)(struct amdgpu_device *adev, uint16_t =
pasid,
> +                                   uint32_t flush_type, bool all_hub,
> +                                   uint32_t inst);
>         /* flush the vm tlb via ring */
>         uint64_t (*emit_flush_gpu_tlb)(struct amdgpu_ring *ring, unsigned=
 vmid,
>                                        uint64_t pd_addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 407ddb926941..40d432d46469 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -337,9 +337,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>   *
>   * Flush the TLB for the requested pasid.
>   */
> -static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> -                                       uint16_t pasid, uint32_t flush_ty=
pe,
> -                                       bool all_hub, uint32_t inst)
> +static void gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> +                                         uint16_t pasid, uint32_t flush_=
type,
> +                                         bool all_hub, uint32_t inst)
>  {
>         uint16_t queried;
>         int vmid, i;
> @@ -362,7 +362,6 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>                                                 flush_type);
>                 }
>         }
> -       return 0;
>  }
>
>  static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index aa39c1087e44..50bc5f151038 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -299,9 +299,9 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>   *
>   * Flush the TLB for the requested pasid.
>   */
> -static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> -                                       uint16_t pasid, uint32_t flush_ty=
pe,
> -                                       bool all_hub, uint32_t inst)
> +static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> +                                         uint16_t pasid, uint32_t flush_=
type,
> +                                         bool all_hub, uint32_t inst)
>  {
>         uint16_t queried;
>         int vmid, i;
> @@ -324,7 +324,6 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>                                                 flush_type);
>                 }
>         }
> -       return 0;
>  }
>
>  static uint64_t gmc_v11_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index 9e19a752f94b..fa3586efacd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -423,15 +423,15 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *a=
dev)
>   *
>   * Flush the TLB for the requested pasid.
>   */
> -static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> -                                       uint16_t pasid, uint32_t flush_ty=
pe,
> -                                       bool all_hub, uint32_t inst)
> +static void gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> +                                        uint16_t pasid, uint32_t flush_t=
ype,
> +                                        bool all_hub, uint32_t inst)
>  {
>         u32 mask =3D 0x0;
>         int vmid;
>
>         if(!down_read_trylock(&adev->reset_domain->sem))
> -               return 0;
> +               return;
>
>         for (vmid =3D 1; vmid < 16; vmid++) {
>                 u32 tmp =3D RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
> @@ -444,7 +444,6 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
>         WREG32(mmVM_INVALIDATE_REQUEST, mask);
>         RREG32(mmVM_INVALIDATE_RESPONSE);
>         up_read(&adev->reset_domain->sem);
> -       return 0;
>  }
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 2d51531a1f2d..ffcd79d28b9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -613,15 +613,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *a=
dev)
>   *
>   * Flush the TLB for the requested pasid.
>   */
> -static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> -                                       uint16_t pasid, uint32_t flush_ty=
pe,
> -                                       bool all_hub, uint32_t inst)
> +static void gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> +                                        uint16_t pasid, uint32_t flush_t=
ype,
> +                                        bool all_hub, uint32_t inst)
>  {
>         u32 mask =3D 0x0;
>         int vmid;
>
>         if(!down_read_trylock(&adev->reset_domain->sem))
> -               return 0;
> +               return;
>
>         for (vmid =3D 1; vmid < 16; vmid++) {
>                 u32 tmp =3D RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
> @@ -634,7 +634,6 @@ static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
>         WREG32(mmVM_INVALIDATE_REQUEST, mask);
>         RREG32(mmVM_INVALIDATE_RESPONSE);
>         up_read(&adev->reset_domain->sem);
> -       return 0;
>  }
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 39016b6900d3..94ba16536fc2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -950,9 +950,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>   *
>   * Flush the TLB for the requested pasid.
>   */
> -static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> -                                       uint16_t pasid, uint32_t flush_ty=
pe,
> -                                       bool all_hub, uint32_t inst)
> +static void gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
> +                                        uint16_t pasid, uint32_t flush_t=
ype,
> +                                        bool all_hub, uint32_t inst)
>  {
>         uint16_t queried;
>         int i, vmid;
> @@ -976,8 +976,6 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu=
_device *adev,
>                                                flush_type);
>                 }
>         }
> -
> -       return 0;
>  }
>
>  static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
> --
> 2.34.1
>
