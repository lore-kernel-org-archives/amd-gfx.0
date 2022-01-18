Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FB2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 20:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B203210E553;
	Tue, 18 Jan 2022 20:15:21 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A2710E553
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 20:15:21 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 q13-20020a9d4b0d000000b0059b1209d708so5301548otf.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 12:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hLW/jRu73R/sMnRrnz9wSxqGnvPtT8gco9awqiMoAXc=;
 b=HX+i7SS4sO49ytpr5H0P8SJ5VzLI0ORaAahyZ7q76f+tlO4ZNMHvR4OhnFAwbY7Y0G
 4knyCGcl13k2LsT5U8ahy6T1qqbTyRcC5lm3xB/tsUIctg2F5QHClgMFwwOP0ppis7du
 uDLln+kzjXtEjaNUcNPZ/+lQT37Pi+TL5Im/PH2OM6Qd1rscM1vPCRu0g3ALgmn879WW
 c1lL8y1gIcCLZLtukhAVAsTNVs6HCCKY/I7O3FCc4urmg0u6LqSGmPJDzwXbwesoxKko
 BHXRr2EvaC5PWYILK4zDu5FdHW4qBrVD5nlr0gih7xpy++WjNm2SjoSeJBGnyovbaUg/
 Spgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hLW/jRu73R/sMnRrnz9wSxqGnvPtT8gco9awqiMoAXc=;
 b=fgKjDthlZqiBfRyMr6yvGj6yYi0UCU323LHkRY+I+U01s/G1WtcC6VlQP9QBsMqhAs
 qYXgxsJEJHGNxIYVOdfpGwHY3mLsf6REPQeUjRzHrjwbaPOMzQKgAgFKYQHLan/LEFsQ
 IL9KSU0JLibS7SKFV+wUvUfkI9lkGIrO6LwnyFxg8ZqoK8nYCXCRFKxLQjE9lToyyCBL
 Q26i0GBb53qr7JgRjnvO0BWFmvgpKX0H5oEPyJUEWAlsNbaPZgo5thjmf8i7YUa/c25K
 vzKyoa2hh1l4+2HagYSqn+AlbBaERICBtBsOdz0WJkVu357lcs2b4wBeBZG/p1IU/jnQ
 gEWQ==
X-Gm-Message-State: AOAM532dsukRGyrD/N/YMS92sVq7Ctw0PLQH1OhPiMsr1BphpsLeKw71
 qUB1u95pJITOSVPEyAhfdwW0z1eIa/f8fCXemHzIDOFw
X-Google-Smtp-Source: ABdhPJzwiq3ZPM4pnn8qJtdHVNsKnRQF7TmzvBlF0vDwD+BkXQjlTDAw1PjuRWJEJ+osWUCpnUYaF3ZsW5POtxpTa88=
X-Received: by 2002:a05:6830:19e6:: with SMTP id
 t6mr19626498ott.357.1642536920218; 
 Tue, 18 Jan 2022 12:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20220118161552.11122-1-jinhuieric.huang@amd.com>
 <CADnq5_OVpDd7O+q=9N8j14dwa-+2PqKjmDvKv6JkQGiiuQDYSQ@mail.gmail.com>
 <2f7705db-d5ac-3e7c-a991-79634c0b9f8c@amd.com>
 <DM5PR12MB1308EAE234EBFD55B3374B3085589@DM5PR12MB1308.namprd12.prod.outlook.com>
 <CADnq5_N4i9+FfzUGD8UWrVjc-9rs78PEzMW9wpWeqe4JqQnvfg@mail.gmail.com>
 <f182bb24-d2ff-f1e0-1a20-4b71b665d558@amd.com>
In-Reply-To: <f182bb24-d2ff-f1e0-1a20-4b71b665d558@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jan 2022 15:15:09 -0500
Message-ID: <CADnq5_Op0HFpBJj5AorW8erkNBKcdXJ_3z=nF7K3EjMq5Mzq=g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
To: Eric Huang <jinhuieric.huang@amd.com>
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 18, 2022 at 3:13 PM Eric Huang <jinhuieric.huang@amd.com> wrote:
>
> I understand Alex's concern. I think usually we only check the version
> when a feature is only available in a specific version, and other
> version or newer version doesn't have.
>
> In case of FW fix, we assume the driver and FWs have to be synchronous.
> If we have driver backward compatibility for FWs, there must be a lot of
> redundant codes for FW version check. So this patch and SDMA fix will be
> pushed into ROCm 5.1 release branch at the same time.

We need to check.  The firmwares are not distributed in lock step with
the driver.

Alex


>
> Regards,
> Eric
>
> On 2022-01-18 14:35, Alex Deucher wrote:
> > On Tue, Jan 18, 2022 at 2:27 PM Russell, Kent <Kent.Russell@amd.com> wrote:
> >> [AMD Official Use Only]
> >>
> >> I think what he means is that if we are using SDMA v17, this will cause issues, won't it? Should we check that SDMA version is >=18 before enabling it? Or am I misunderstanding the fix?
> > Yes, that was my concern.
> >
> > Alex
> >
> >>   Kent
> >>
> >>> -----Original Message-----
> >>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Huang
> >>> Sent: Tuesday, January 18, 2022 2:09 PM
> >>> To: Alex Deucher <alexdeucher@gmail.com>
> >>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> >>> Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
> >>>
> >>> The SDMA fix is generic and not in a specific version of FW, so we don't
> >>> have to check.
> >>>
> >>> Thanks,
> >>> Eric
> >>>
> >>> On 2022-01-18 11:35, Alex Deucher wrote:
> >>>> On Tue, Jan 18, 2022 at 11:16 AM Eric Huang <jinhuieric.huang@amd.com> wrote:
> >>>>> SDMA FW fixes the hang issue for adding heavy-weight TLB
> >>>>> flush on Arcturus, so we can enable it.
> >>>> Do we need to check for a specific fw version?
> >>>>
> >>>> Alex
> >>>>
> >>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> >>>>> ---
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +++++---
> >>>>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 3 ++-
> >>>>>    2 files changed, 7 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>>>> index a64cbbd943ba..7b24a920c12e 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>>>> @@ -1892,10 +1892,12 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
> >>>>>                                   true);
> >>>>>           ret = unreserve_bo_and_vms(&ctx, false, false);
> >>>>>
> >>>>> -       /* Only apply no TLB flush on Aldebaran to
> >>>>> -        * workaround regressions on other Asics.
> >>>>> +       /* Only apply no TLB flush on Aldebaran and Arcturus
> >>>>> +        * to workaround regressions on other Asics.
> >>>>>            */
> >>>>> -       if (table_freed && (adev->asic_type != CHIP_ALDEBARAN))
> >>>>> +       if (table_freed &&
> >>>>> +           (adev->asic_type != CHIP_ALDEBARAN) &&
> >>>>> +           (adev->asic_type != CHIP_ARCTURUS))
> >>>>>                   *table_freed = true;
> >>>>>
> >>>>>           goto out;
> >>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> >>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> >>>>> index b570c0454ce9..ef4d676cc71c 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> >>>>> @@ -1806,7 +1806,8 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file
> >>> *filep,
> >>>>>           }
> >>>>>           mutex_unlock(&p->mutex);
> >>>>>
> >>>>> -       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2)) {
> >>>>> +       if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
> >>>>> +           KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)) {
> >>>>>                   err = amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
> >>>>>                                   (struct kgd_mem *) mem, true);
> >>>>>                   if (err) {
> >>>>> --
> >>>>> 2.25.1
> >>>>>
>
