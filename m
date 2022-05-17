Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D9CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 14:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A2910E0E8;
	Tue, 17 May 2022 14:07:50 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76E910E08B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 14:07:48 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id w123so22401431oiw.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OR18mWt9cYzFTEu2Cz7YOxxF4iQjDXEVtWwNcZYNHUw=;
 b=N/Vet4ljChUIBep8IIxibJj0aqcjrHuEf/WGJId1ClS79aDfydR0ZgJSJwnFMKC7sc
 4Dus/KCwlsF5YFCHiVmLBnUsVKmaqn0M6I+CGljPjh/5EGpzi4+5I4ia4k8aiiwEU2M1
 nBrxqZhtn5i1xR2UyZaeAZKX3WPo146sLxtoAdnYi9BdtIpz8R7UDaMnmCklG/19wnWA
 mK9vdm3JT+lwhgohToTF9je4XV2wnOFe2CGyZ4ScDgMBBbW75uww7aqDa6KeOu9YirwU
 Il5FnDyfB3FH8FourkKDWY3pqFQwQyFlXmsiwL+24v2q2LEhJtJFJ14ZlrOOfy0SXkJC
 t+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OR18mWt9cYzFTEu2Cz7YOxxF4iQjDXEVtWwNcZYNHUw=;
 b=IXMccqyasj18XHku5biZkU2dFqrtqmRiVkfoLzXxhbkEoq9urgcwQyn5rw33asCIt7
 43CuQhHnZW9vsO6CJSj5m196bob8KGBYiGzpgqNvSjmDdwd5hIaq3LsV1ouJQSaTZw+8
 HfK9PEMtxrSeHNzAKx/mWVcMUrX2lt3zxSMKsGgr/dxvX1RvoIy356h3YJ37MkPG12XW
 Ei1F8zwC1ank6KWcfhWr/EQdK7FGz6gwTIFszVdJCkintpU0xbX2CMin385RWFm/eHjI
 1QF93rhjwBgxGguCtCzysPaR9Ca8oQuE8rlgz7HU8JFERjTDwOuoToctnm1zlwKUppyf
 h7nQ==
X-Gm-Message-State: AOAM5320i/jDAlKy4OJuX7ZC35QDGV17PYrGG4/s0tc6YpeaSfNtPqH6
 TQKTrANM19Q4p0pTjQ8dBdSzj2hfAvfN+cK/ZPUY74Kp
X-Google-Smtp-Source: ABdhPJz+DxX0QMeWyG/funZo3W1y6Lo0A7zucYh3K9yDEtfkNb3xbUOYV/g6XUNnga12YWmwxMqCJRTTd1ie0/IyIcc=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr11192356oiw.253.1652796466807; Tue, 17
 May 2022 07:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220517133944.25612-1-mario.limonciello@amd.com>
 <CADnq5_OT9RkdSOW7vnT6+g72wENDr201taaHTs5op9kWApgeNw@mail.gmail.com>
 <MN0PR12MB6101503EA34F43D880C203BFE2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101503EA34F43D880C203BFE2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 10:07:34 -0400
Message-ID: <CADnq5_O+=Ldx46DTEtDBf=QmWcCysz8FukaYJ2ESdBQNmx=fUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 17, 2022 at 10:06 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Tuesday, May 17, 2022 08:43
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
> > s2idle
> >
> > On Tue, May 17, 2022 at 9:39 AM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > An A+A configuration on ASUS ROG Strix G513QY proves that the ASIC
> > > reset for handling aborted suspend can't work with s2idle.
> > >
> > > This functionality was introduced in commit daf8de0874ab5b
> > ("drm/amdgpu:
> > > always reset the asic in suspend (v2)").  A few other commits have
> > > gone on top of the ASIC reset, but this still doesn't work on the A+A
> > > configuration in s2idle.
> > >
> > > Avoid doing the reset on dGPUs specifically when using s2idle.
> > >
> > > Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend
> > (v2)")
> > > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitla
> > b.freedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F2008&amp;data=05%7C01%7Cmario.limonciello%40amd.com%
> > 7C38a880b8d03147194bb608da380b3142%7C3dd8961fe4884e608e11a82d994
> > e183d%7C0%7C0%7C637883917968950850%7CUnknown%7CTWFpbGZsb3d8
> > eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > D%7C3000%7C%7C%7C&amp;sdata=lNeeucWFganu9GLey2YAqXfgbYT4DUBb
> > fQA6XuwGslA%3D&amp;reserved=0
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > But I think maybe we should just drop all of this in the longer term.
> > We are slowly dropping every case where we reset the GPU.  I'm not
> > even sure it actually fixes the issue it was originally added to fix
> > at this point because the actual reset has moved to the no-irq
> > callback which will most likely not get called on an aborted suspend
> > anyway.
> >
>
> So perhaps for now this patch and in the next cycle or two maybe folks who worked
> on the aborted suspend case can try to trigger an aborted suspend w/ dGPUs + S3
> and see whether it's actually working and tear everything out if it doesn't as you say.
>

Yes, that was my thinking.

Alex


> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 14 ++++++++++++++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  2 +-
> > >  3 files changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > index 3c20c2eadf4e..9cf3d65f17d7 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > @@ -1378,6 +1378,7 @@ static inline int
> > amdgpu_acpi_smart_shift_update(struct drm_device *dev,
> > >
> > >  #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
> > >  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
> > > +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
> > >  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
> > >  #else
> > >  static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device
> > *adev) { return false; }
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > index 0e12315fa0cb..98ac53ee6bb5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > > @@ -1045,6 +1045,20 @@ bool amdgpu_acpi_is_s3_active(struct
> > amdgpu_device *adev)
> > >                 (pm_suspend_target_state == PM_SUSPEND_MEM);
> > >  }
> > >
> > > +/**
> > > + * amdgpu_acpi_should_gpu_reset
> > > + *
> > > + * @adev: amdgpu_device_pointer
> > > + *
> > > + * returns true if should reset GPU, false if not
> > > + */
> > > +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
> > > +{
> > > +       if (adev->flags & AMD_IS_APU)
> > > +               return false;
> > > +       return pm_suspend_target_state != PM_SUSPEND_TO_IDLE;
> > > +}
> > > +
> > >  /**
> > >   * amdgpu_acpi_is_s0ix_active
> > >   *
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index 16871baee784..a84766c13ac5 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -2315,7 +2315,7 @@ static int amdgpu_pmops_suspend_noirq(struct
> > device *dev)
> > >         struct drm_device *drm_dev = dev_get_drvdata(dev);
> > >         struct amdgpu_device *adev = drm_to_adev(drm_dev);
> > >
> > > -       if (!adev->in_s0ix)
> > > +       if (amdgpu_acpi_should_gpu_reset(adev))
> > >                 return amdgpu_asic_reset(adev);
> > >
> > >         return 0;
> > > --
> > > 2.34.1
> > >
