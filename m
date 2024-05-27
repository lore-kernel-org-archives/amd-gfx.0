Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1F4C25B79
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 23:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9889110FD53;
	Mon, 27 May 2024 23:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OQvzDJlG";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5058510FD53
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 23:16:42 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2bdf3f4d5ffso147178a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 16:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716851801; x=1717456601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM9edLETxZOiAVHZ0EF/Gzr5tAJvMLSPMiCaM9ZV9tw=;
 b=OQvzDJlGO3q/PRlFXYmIgW3DV3B9zgEgBIvf9USQwcVOJWywraSKduAtrZToS1ESnA
 9SVNTXxvl28Tc9SWDttdJ83lt7EvqSnnu32TihsOLd/Wyz6UHfiMehjBEmkNh5Qvm6yr
 gJWnLUt0tDh5WVMpBEvLkKqAWwLkPJUvm1PxszDBtDxvgjYNAv0BFT48E0Gw+8xSlQNb
 nCQ/TH9RjkpE0EYEj6Qm0KDO9m5V5pAwZWZCvFAODvf9fc6lES4wIxsqTvJVya+SlctB
 gmvuND5P8YYUHsM9p+Kk8K8Y10EtkKh8MPrNWvK/Df0Lf3d9fj9J+V3b9IzsilctXwm8
 ylag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716851801; x=1717456601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NM9edLETxZOiAVHZ0EF/Gzr5tAJvMLSPMiCaM9ZV9tw=;
 b=p5VF9HzDc8zol1X4du1OR9VsW36VkBgBCFgJMgqJLyIdhKggGwJS5XYzmHGWcTcEd/
 uhyDkcE0FuJCkdtxvUmZJMgzsynLN6Ptv1Cqxv4Ra5Rwec9ocvcWnUeY/povu781Y2UW
 hZJeb+j8jJsLrJP0/eKUZI7vL6RIHODO7841hyKgi7uggGAROpxKsokQFzAQDszlj5ca
 xC9sjcpcvVrFfZd0+2ugUXy+vUMpo+YrC2bUKj7m8qCfnAXbmGUfnbGhXQm35c5SYU6x
 cCT8DFrsuUytcPmKwUhFpoRp3FA72yogM2GE2VTi6ijLBxAvWkhZ3/v2CfWRTQi2f6z6
 6HXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPvi3L+rxxtl5n4+z4movgjkfxSzU+F9pD8mp9neP7Vvv5tX9z7YkU8+FnKPw4wTWkxhHdHeXVzlOXkL3AO/bMsoLZwjaTYAQCCIEdKg==
X-Gm-Message-State: AOJu0YxDar4rhztyXJBwqtOgxwDwsjqlR242ayD8lTXHk9wX08HXQ8jJ
 MzN5n/LmhYju+IeNaEqFlfUjrcs82CFJB112nqthJJf1fU8oGWTMg0iwhHdDzLM6BStzD80wM0O
 I7U7oqp2xrq4RfQZ9m8NDvyWQ15RutQ==
X-Google-Smtp-Source: AGHT+IGuAO/7aN0m4PlkKb708skXnTQZF4f/MFNw9Vqth9HedfZvEj1uY+u2aolLlfyMrDgWP8rPkgLxeqzAw6cYORE=
X-Received: by 2002:a17:90a:e7c6:b0:2bf:8f9f:4adb with SMTP id
 98e67ed59e1d1-2bf8f9f4c62mr5363674a91.1.1716851801261; Mon, 27 May 2024
 16:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240524140807.3186797-1-alexander.deucher@amd.com>
 <10603bd8-7f6c-4a5f-a5f6-c493cc8df64c@amd.com>
In-Reply-To: <10603bd8-7f6c-4a5f-a5f6-c493cc8df64c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 May 2024 19:16:29 -0400
Message-ID: <CADnq5_PhPqdkWpAfCt2C34J=6e2cj+V4BOsSgheJi8a1qzqnCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: simplify APU VRAM handling
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, May 27, 2024 at 3:22=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> On 2024-05-24 10:08, Alex Deucher wrote:
> > With commit 89773b85599a
> > ("drm/amdkfd: Let VRAM allocations go to GTT domain on small APUs")
> > big and small APU "VRAM" handling in KFD was unified.  Since AMD_IS_APU
> > is set for both big and small APUs, we can simplify the checks in
> > the code.
> >
> > v2: clean up a few more places (Lang)
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> This is a lot cleaner, thanks. I was looking for something like this
> when I reviewed the original patch but missed it. I found it now in
> amdgpu_discovery_set_ip_blocks (I think).

Yes, that's the place.

Alex

>
> Acked-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++-------=
-
> >   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         |  2 +-
> >   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  6 ++----
> >   drivers/gpu/drm/amd/amdkfd/kfd_svm.h             |  1 -
> >   4 files changed, 11 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 336eb51c4839..3af00b57cd8a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -196,7 +196,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_d=
evice *adev,
> >                       return -EINVAL;
> >
> >               vram_size =3D KFD_XCP_MEMORY_SIZE(adev, xcp_id);
> > -             if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
> > +             if (adev->flags & AMD_IS_APU) {
> >                       system_mem_needed =3D size;
> >                       ttm_mem_needed =3D size;
> >               }
> > @@ -233,7 +233,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_d=
evice *adev,
> >       if (adev && xcp_id >=3D 0) {
> >               adev->kfd.vram_used[xcp_id] +=3D vram_needed;
> >               adev->kfd.vram_used_aligned[xcp_id] +=3D
> > -                             (adev->gmc.is_app_apu || adev->flags & AM=
D_IS_APU) ?
> > +                             (adev->flags & AMD_IS_APU) ?
> >                               vram_needed :
> >                               ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN=
);
> >       }
> > @@ -261,7 +261,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct amdgp=
u_device *adev,
> >
> >               if (adev) {
> >                       adev->kfd.vram_used[xcp_id] -=3D size;
> > -                     if (adev->gmc.is_app_apu || adev->flags & AMD_IS_=
APU) {
> > +                     if (adev->flags & AMD_IS_APU) {
> >                               adev->kfd.vram_used_aligned[xcp_id] -=3D =
size;
> >                               kfd_mem_limit.system_mem_used -=3D size;
> >                               kfd_mem_limit.ttm_mem_used -=3D size;
> > @@ -894,7 +894,7 @@ static int kfd_mem_attach(struct amdgpu_device *ade=
v, struct kgd_mem *mem,
> >        * if peer device has large BAR. In contrast, access over xGMI is
> >        * allowed for both small and large BAR configurations of peer de=
vice
> >        */
> > -     if ((adev !=3D bo_adev && !(adev->gmc.is_app_apu || adev->flags &=
 AMD_IS_APU)) &&
> > +     if ((adev !=3D bo_adev && !(adev->flags & AMD_IS_APU)) &&
> >           ((mem->domain =3D=3D AMDGPU_GEM_DOMAIN_VRAM) ||
> >            (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL) ||
> >            (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
> > @@ -1682,7 +1682,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct =
amdgpu_device *adev,
> >               - atomic64_read(&adev->vram_pin_size)
> >               - reserved_for_pt;
> >
> > -     if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
> > +     if (adev->flags & AMD_IS_APU) {
> >               system_mem_available =3D no_system_mem_limit ?
> >                                       kfd_mem_limit.max_system_mem_limi=
t :
> >                                       kfd_mem_limit.max_system_mem_limi=
t -
> > @@ -1730,7 +1730,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
> >       if (flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> >               domain =3D alloc_domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> >
> > -             if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) {
> > +             if (adev->flags & AMD_IS_APU) {
> >                       domain =3D AMDGPU_GEM_DOMAIN_GTT;
> >                       alloc_domain =3D AMDGPU_GEM_DOMAIN_GTT;
> >                       alloc_flags =3D 0;
> > @@ -1981,7 +1981,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
> >       if (size) {
> >               if (!is_imported &&
> >                  (mem->bo->preferred_domains =3D=3D AMDGPU_GEM_DOMAIN_V=
RAM ||
> > -                ((adev->gmc.is_app_apu || adev->flags & AMD_IS_APU) &&
> > +                ((adev->flags & AMD_IS_APU) &&
> >                   mem->bo->preferred_domains =3D=3D AMDGPU_GEM_DOMAIN_G=
TT)))
> >                       *size =3D bo_size;
> >               else
> > @@ -2404,7 +2404,7 @@ static int import_obj_create(struct amdgpu_device=
 *adev,
> >       (*mem)->bo =3D bo;
> >       (*mem)->va =3D va;
> >       (*mem)->domain =3D (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRA=
M) &&
> > -                      !(adev->gmc.is_app_apu || adev->flags & AMD_IS_A=
PU) ?
> > +                      !(adev->flags & AMD_IS_APU) ?
> >                        AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
> >
> >       (*mem)->mapped_to_gpu_memory =3D 0;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_migrate.c
> > index 4816fcb9803a..8ee3d07ffbdf 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > @@ -1023,7 +1023,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device=
 *adev)
> >       if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
> >               return -EINVAL;
> >
> > -     if (adev->gmc.is_app_apu || adev->flags & AMD_IS_APU)
> > +     if (adev->flags & AMD_IS_APU)
> >               return 0;
> >
> >       pgmap =3D &kfddev->pgmap;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_svm.c
> > index 28c2c1b66226..407636a68814 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> > @@ -2634,8 +2634,7 @@ svm_range_best_restore_location(struct svm_range =
*prange,
> >               return -1;
> >       }
> >
> > -     if (node->adev->gmc.is_app_apu ||
> > -         node->adev->flags & AMD_IS_APU)
> > +     if (node->adev->flags & AMD_IS_APU)
> >               return 0;
> >
> >       if (prange->preferred_loc =3D=3D gpuid ||
> > @@ -3353,8 +3352,7 @@ svm_range_best_prefetch_location(struct svm_range=
 *prange)
> >               goto out;
> >       }
> >
> > -     if (bo_node->adev->gmc.is_app_apu ||
> > -         bo_node->adev->flags & AMD_IS_APU) {
> > +     if (bo_node->adev->flags & AMD_IS_APU) {
> >               best_loc =3D 0;
> >               goto out;
> >       }
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd=
/amdkfd/kfd_svm.h
> > index 9c37bd0567ef..70c1776611c4 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> > @@ -201,7 +201,6 @@ void svm_range_list_lock_and_flush_work(struct svm_=
range_list *svms, struct mm_s
> >    * is initialized to not 0 when page migration register device memory=
.
> >    */
> >   #define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type !=3D 0=
 ||\
> > -                                     (adev)->gmc.is_app_apu ||\
> >                                       ((adev)->flags & AMD_IS_APU))
> >
> >   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
