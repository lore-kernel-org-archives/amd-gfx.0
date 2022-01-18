Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A77C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 19:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEE710E53C;
	Tue, 18 Jan 2022 19:35:44 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057B510E53C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 19:35:44 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 a10-20020a9d260a000000b005991bd6ae3eso12130320otb.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 11:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YCGosHywqDJiiiOX4ekKanTqt2u6ya69LBZ0sUnoizk=;
 b=Z7buN3zzmP1v+aGdn4YEyMF6sX+IgLaJIAlIdRTkXruRSLMlpGiS/o4+HotmEFA1ln
 Yec8lqht9INFhBLicULOWD2b+MOz1jIWGkDEJoNXlmxRs6m4095bjWVyr54dSL4BFMj/
 G7WRVXpDF+NhbfVbGD6WZKehnPOq6pGe5bA6YqCTyAzo9XAYY1JeXeGOH8WjxIbD/0Bu
 JMTU9sZGQCjXVYnp77+/uvbcSVM6iBfEjn+UMZVVynAgjiTIow00nwNUL9J7LQKtiMTZ
 fAzeJ3z3/byir2SuF5JxdYSOG/JUP+SiGVLc5b842ocDrcGPGR11iQEa5pUEfyUM8lVb
 Zcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YCGosHywqDJiiiOX4ekKanTqt2u6ya69LBZ0sUnoizk=;
 b=7Np7wDb5mb5O1ApuFx7/y7Bp0aES1A27mA13URCu+52riVECV7l7R5FY0OHKbObIR+
 9/EElGg4KdMN78r2A6V1OAX5+0Gr4gYJ8Glm1XKQ2BZ9KSyF3QaBCyw+NTOHaoVjNAtJ
 SuU7kIYuH4REvL4FBrXTmWroazfyiGGz9CMAoBeCxgIHTaNbeK3jr7qjGcVRRLfWd57Y
 gy7/0mvrLvtbp5jT/FtsF2ZllIvnf8BgUyVGx1ydZBJ8/Apbl5AioYFzq2X3Om/taQNI
 rKNV5vMnEpMbP5ntaXkAUXfFlYEvoZ6dSsl4rrmeLvSqP+l+i0dnSFiPUyrW1CeUO3EB
 Kesw==
X-Gm-Message-State: AOAM531W0faCTVDGHxMMRkGXKWCVZ1HIcLL5GeIZs+dAC3GBs1rNI94d
 nhPobynXj1IFiZtRRERIjxW/azqZlccPUu1uz2k=
X-Google-Smtp-Source: ABdhPJw8OlKyM58iyn9tLvfFfrpMQnWixPdMlYEasNAiMXZPsZyFcMC3lWzVY1XqT36zXQM3Im6IsIJr6euEiI+PhV0=
X-Received: by 2002:a05:6830:1d90:: with SMTP id
 y16mr10606944oti.200.1642534543187; 
 Tue, 18 Jan 2022 11:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20220118161552.11122-1-jinhuieric.huang@amd.com>
 <CADnq5_OVpDd7O+q=9N8j14dwa-+2PqKjmDvKv6JkQGiiuQDYSQ@mail.gmail.com>
 <2f7705db-d5ac-3e7c-a991-79634c0b9f8c@amd.com>
 <DM5PR12MB1308EAE234EBFD55B3374B3085589@DM5PR12MB1308.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1308EAE234EBFD55B3374B3085589@DM5PR12MB1308.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jan 2022 14:35:32 -0500
Message-ID: <CADnq5_N4i9+FfzUGD8UWrVjc-9rs78PEzMW9wpWeqe4JqQnvfg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
To: "Russell, Kent" <Kent.Russell@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 18, 2022 at 2:27 PM Russell, Kent <Kent.Russell@amd.com> wrote:
>
> [AMD Official Use Only]
>
> I think what he means is that if we are using SDMA v17, this will cause issues, won't it? Should we check that SDMA version is >=18 before enabling it? Or am I misunderstanding the fix?

Yes, that was my concern.

Alex

>
>  Kent
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Huang
> > Sent: Tuesday, January 18, 2022 2:09 PM
> > To: Alex Deucher <alexdeucher@gmail.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
> >
> > The SDMA fix is generic and not in a specific version of FW, so we don't
> > have to check.
> >
> > Thanks,
> > Eric
> >
> > On 2022-01-18 11:35, Alex Deucher wrote:
> > > On Tue, Jan 18, 2022 at 11:16 AM Eric Huang <jinhuieric.huang@amd.com> wrote:
> > >> SDMA FW fixes the hang issue for adding heavy-weight TLB
> > >> flush on Arcturus, so we can enable it.
> > > Do we need to check for a specific fw version?
> > >
> > > Alex
> > >
> > >> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> > >> ---
> > >>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
> > >>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
> > >>   2 files changed, 7 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > >> index a64cbbd943ba..7b24a920c12e 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > >> @@ -1892,10 +1892,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
> > >>                                  true);
> > >>          ret = unreserve_bo_and_vms(&ctx, false, false);
> > >>
> > >> -       /* Only apply no TLB flush on Aldebaran to
> > >> -        * workaround regressions on other Asics.
> > >> +       /* Only apply no TLB flush on Aldebaran and Arcturus
> > >> +        * to workaround regressions on other Asics.
> > >>           */
> > >> -       if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
> > >> +       if (table_freed &&
> > >> +           (adev->asic_type != CHIP_ALDEBARAN) &&
> > >> +           (adev->asic_type != CHIP_ARCTURUS))
> > >>                  *table_freed = true;
> > >>
> > >>          goto out;
> > >> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > >> index b570c0454ce9..ef4d676cc71c 100644
> > >> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > >> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > >> @@ -1806,7 +1806,8 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file
> > *filep,
> > >>          }
> > >>          mutex_unlock(&p->mutex);
> > >>
> > >> -       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
> > >> +       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> > >> +           KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)) {
> > >>                  err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
> > >>                                  (struct kgd_mem *) mem, true);
> > >>                  if (err) {
> > >> --
> > >> 2.25.1
> > >>
>
