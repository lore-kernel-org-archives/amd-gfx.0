Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729BEC636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 17:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0861B10E424;
	Mon,  6 Feb 2023 17:01:17 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FA310E424
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 17:01:14 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-15f97c478a8so15799691fac.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gltdSL8/xwMfRpD+/KoPJu2zZ092g7iqfg4EcMWU5mM=;
 b=MG1CHEXdNydJA8NsxDWWTUsspPmc4eaOOdjsGRwLj/3PqGebH60yqQ2JSfgAJFDS6u
 Mzl5AKciY54Xyw51ruo7ymWhcepaz6bgAU3dxd7oM7vix/GTAH+YOxj7SQUMjtBsENXE
 fJKHRTbh8sxUhVK99MGZXK9bojYayHwzHa3rGov//tH3PDrdRWb/F/4tpSakvOkb6jxk
 AEq8pnghnKsZ8VGXjSdg/BBK/TH/crrRrrsDRs3n2B9B1vOGZ3dePGBtoArwosDqZy37
 KxqDrwE59HGgpxzUmWyhW62mTZhkqHBqNxT9NRivsnxoNuJtCez0qLECELUuHcfK3Q6z
 Bapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gltdSL8/xwMfRpD+/KoPJu2zZ092g7iqfg4EcMWU5mM=;
 b=WwlU1cWgM5meBPH4EOCbI1V1ij0eAtKSh2pt5CBJKp76QueRVKkjgebFZ7poAPutPr
 8n9T2jcc3ASOJfY8RiZmyVLwKKkZ4hrpR3Uw5vsWZoV/ItV9ETM9KYRzrjTNlOtslDvf
 VPYJ1MVNZU6qJbE8fryZkKEpbtBsT18yL6nxJFS7nFTYKuCnPMmDSoSyUGr6Sy7WMS4k
 TYKSLq+ur07PazojkwnPjAjdGyxNGuOlyNjNfBvFRRUkov9D87aVaGIlkB9vK78h7DBs
 Mzyo0Vfl7mF2kMoq7t8N2x9ALirdzpWCovrszwkwmEtijp3rsrvwcVMbifcvqPx0F+dH
 P44w==
X-Gm-Message-State: AO0yUKUhHrNFqwYSz4YsrUZUXUttn/O0vdjibm6vOV/psKnuVtxku3As
 ih8SFqPhkDYsgdxBydrl2E3dk0FDnpKVm0nqLJCcUAL6
X-Google-Smtp-Source: AK7set80wOfPodkLcNALmu0OBA8m2BIRDXrflY6sBFDkV5s3WC3rTO0Uo/C3WFeJfKmXqthoI67xAFzpsfxqZk2Dtng=
X-Received: by 2002:a05:6870:891f:b0:163:8cc6:86a with SMTP id
 i31-20020a056870891f00b001638cc6086amr2156209oao.46.1675702873337; Mon, 06
 Feb 2023 09:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20230203190836.1987-1-shashank.sharma@amd.com>
 <20230203190836.1987-16-shashank.sharma@amd.com>
 <b94aa331-ce65-fbe2-6695-32e68ec68236@amd.com>
In-Reply-To: <b94aa331-ce65-fbe2-6695-32e68ec68236@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 12:01:02 -0500
Message-ID: <CADnq5_Nyqs=uXWTY_Q_iJH+yLQ7q_sQFqGzCA5i3HUPC+z5L-A@mail.gmail.com>
Subject: Re: [PATCH 12/13] drm/amdgpu: add domain info in bo_create_kernel_at
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 6, 2023 at 11:51 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 03.02.23 um 20:08 schrieb Shashank Sharma:
> > From: Shashank Sharma <contactshashanksharma@gmail.com>
> >
> > This patch adds a domain input variable for amdgpu_bo_create_kernel_at,
> > so that it could be used for both VRAM and DOORBELL domains objects. It
> > also adds supporting code for existing callers.
>
> We should probably drop this one as well.
>
> We just removed the domain from the function because we only have BIOS
> reserved regions in VRAM, never anywhere else.
>
> Allocating a doorbell for the kernel is not really an use case for
> amdgpu_bo_create_kernel_at().

We just need some way to guarantee that the kernel always gets the
first page.  It's required for SR-IOV compatibility.

Alex

>
> Christian.
>
> >
> > Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 1 +
> >   4 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index ef1f3106bc69..dec391fa42dc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -367,7 +367,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *a=
dev,
> >    * 0 on success, negative error code otherwise.
> >    */
> >   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> > -                            uint64_t offset, uint64_t size,
> > +                            uint64_t offset, uint64_t size, uint32_t d=
omain,
> >                              struct amdgpu_bo **bo_ptr, void **cpu_addr=
)
> >   {
> >       struct ttm_operation_ctx ctx =3D { false, false };
> > @@ -378,7 +378,7 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device=
 *adev,
> >       size =3D ALIGN(size, PAGE_SIZE);
> >
> >       r =3D amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
> > -                                   AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NUL=
L,
> > +                                   domain, bo_ptr, NULL,
> >                                     cpu_addr);
> >       if (r)
> >               return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.h
> > index bf9759758f0d..b2b7e55ac486 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > @@ -284,7 +284,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *a=
dev,
> >                           u32 domain, struct amdgpu_bo **bo_ptr,
> >                           u64 *gpu_addr, void **cpu_addr);
> >   int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
> > -                            uint64_t offset, uint64_t size,
> > +                            uint64_t offset, uint64_t size, uint32_t d=
omain,
> >                              struct amdgpu_bo **bo_ptr, void **cpu_addr=
);
> >   int amdgpu_bo_create_user(struct amdgpu_device *adev,
> >                         struct amdgpu_bo_param *bp,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 08355f981313..4cec90debe46 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1591,6 +1591,7 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct=
 amdgpu_device *adev)
> >       return amdgpu_bo_create_kernel_at(adev,
> >                                         adev->mman.fw_vram_usage_start_=
offset,
> >                                         adev->mman.fw_vram_usage_size,
> > +                                       AMDGPU_GEM_DOMAIN_VRAM,
> >                                         &adev->mman.fw_vram_usage_reser=
ved_bo,
> >                                         &adev->mman.fw_vram_usage_va);
> >   }
> > @@ -1616,6 +1617,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struc=
t amdgpu_device *adev)
> >       return amdgpu_bo_create_kernel_at(adev,
> >                                         adev->mman.drv_vram_usage_start=
_offset,
> >                                         adev->mman.drv_vram_usage_size,
> > +                                       AMDGPU_GEM_DOMAIN_VRAM,
> >                                         &adev->mman.drv_vram_usage_rese=
rved_bo,
> >                                         &adev->mman.drv_vram_usage_va);
> >   }
> > @@ -1696,6 +1698,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_d=
evice *adev)
> >               ret =3D amdgpu_bo_create_kernel_at(adev,
> >                                        ctx->c2p_train_data_offset,
> >                                        ctx->train_data_size,
> > +                                      AMDGPU_GEM_DOMAIN_VRAM,
> >                                        &ctx->c2p_bo,
> >                                        NULL);
> >               if (ret) {
> > @@ -1709,6 +1712,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_d=
evice *adev)
> >       ret =3D amdgpu_bo_create_kernel_at(adev,
> >                               adev->gmc.real_vram_size - adev->mman.dis=
covery_tmr_size,
> >                               adev->mman.discovery_tmr_size,
> > +                             AMDGPU_GEM_DOMAIN_VRAM,
> >                               &adev->mman.discovery_memory,
> >                               NULL);
> >       if (ret) {
> > @@ -1816,18 +1820,21 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >        * avoid display artifacts while transitioning between pre-OS
> >        * and driver.  */
> >       r =3D amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_s=
ize,
> > +                                    AMDGPU_GEM_DOMAIN_VRAM,
> >                                      &adev->mman.stolen_vga_memory,
> >                                      NULL);
> >       if (r)
> >               return r;
> >       r =3D amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size=
,
> >                                      adev->mman.stolen_extended_size,
> > +                                    AMDGPU_GEM_DOMAIN_VRAM,
> >                                      &adev->mman.stolen_extended_memory=
,
> >                                      NULL);
> >       if (r)
> >               return r;
> >       r =3D amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved=
_offset,
> >                                      adev->mman.stolen_reserved_size,
> > +                                    AMDGPU_GEM_DOMAIN_VRAM,
> >                                      &adev->mman.stolen_reserved_memory=
,
> >                                      NULL);
> >       if (r)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.c
> > index fc9edc3028b6..fd1f58158238 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -395,6 +395,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdg=
pu_device *adev)
> >                */
> >               if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAG=
E_SHIFT,
> >                                              AMDGPU_GPU_PAGE_SIZE,
> > +                                            AMDGPU_GEM_DOMAIN_VRAM,
> >                                              &bo, NULL))
> >                       DRM_DEBUG("RAS WARN: reserve vram for retired pag=
e %llx fail\n", bp);
> >
>
