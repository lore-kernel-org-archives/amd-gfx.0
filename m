Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD1CC05027
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 17:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D378A10E703;
	Mon, 20 Feb 2023 17:09:46 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3284710E703
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 17:09:45 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-172129e9cf1so1634618fac.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 09:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3DGbvp6gfTJj1PzTN0dcchj6ivi97vIaqgoVxCKRsKM=;
 b=I0iTJP9VWjnXBgkR/1wf1uJmpDhomUtsPRE3vv9t1Nj913RxWc2O01e+7S3lZCn7D4
 LrMl/mpX25Vk3T9d0eHzc+hh7h2ahSe4zp/pwPB5Jj3afHpUKVqNnemfzRa9bejW88Nm
 tijkYzD3S8HKawjcAa93DCpljD6+ZxfoC3/AQ/pfqaRP7AgX+mdb0p/72g/JeHIXXUSP
 AOUYK6KZGflIdG4pVYVHY6JOCHhNv/MAbBuD/vhV/fOmQ2yzTBEQmQhrp8w9oA54Xb0j
 d80xweXcqHEUtaGCeGmljtf8ApFAP+x9vy9JIYdrmwS3nXkGUqHz663nNaKOrcXNAYKc
 IEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3DGbvp6gfTJj1PzTN0dcchj6ivi97vIaqgoVxCKRsKM=;
 b=7l6Rtm2bFgRBt5uX5CQEKVboznXFXel+DpuVIY1xEhpuue3ydRm7tGzKYjwYtM2Sg8
 pEhRBxd/Xx3giUWAqI9tI4aPOrVx7vxkHTKhk/JdrF3b0XyTKr4re4bGQoYx0Q6cWZtU
 Yy+Zy3yVMBOT+MFt/0U6Ymsy/eD3aJR0lQrN2J/A+gG3GYLzy8i8vGU++xfLnZbPfLk8
 /Z35JZITIINtz6KAjo/CW5AksjbvUZIegk1bTg/VDyozlHXLwaOQMImFFlvIoOcCcY4v
 W15r3m6AqUQiydw6zNi+f1irL8LLHwnzYwtF4kGwJ2s73Zdpo2W01uEJj/yYeTx7bFsa
 tYaQ==
X-Gm-Message-State: AO0yUKXdMRqbjhxiit1P+8+HH619rXJ11b7CS3Gvh4mm/Uiq7cRUjnwG
 eop/6QHk3+8s6KPgLS8Wk7UcIWQmOSesBNm+8MX85suj
X-Google-Smtp-Source: AK7set+CdpnVMUHmxgA2r5kV0dQ5cVgzFoax0rjC+O8M41xd5GTM8sv1zP5koIwG5U2fErmWh8tn5A2ZFjDcOzyoXeo=
X-Received: by 2002:a05:6870:e88d:b0:16e:91ef:75a0 with SMTP id
 q13-20020a056870e88d00b0016e91ef75a0mr1041311oan.138.1676912984336; Mon, 20
 Feb 2023 09:09:44 -0800 (PST)
MIME-Version: 1.0
References: <20230213211030.5295-1-mario.limonciello@amd.com>
 <MN0PR12MB6101412F199DB12681D0D565E2A49@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101412F199DB12681D0D565E2A49@MN0PR12MB6101.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Feb 2023 12:09:33 -0500
Message-ID: <CADnq5_NKwBFHhx_TW2CSD0Ha46g5QGDDQBBqh=G78H672XQNKQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Don't allow s0ix on APUs older than Raven
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 20, 2023 at 11:56 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Monday, February 13, 2023 15:11
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: [PATCH v2] drm/amd: Don't allow s0ix on APUs older than Raven
> >
> > APUs before Raven didn't support s0ix.  As we just relieved some
> > of the safety checks for s0ix to improve power consumption on
> > APUs that support it but that are missing BIOS support a new
> > blind spot was introduced that a user could "try" to run s0ix.
> >
> > Plug this hole so that if users try to run s0ix on anything older
> > than Raven it will just skip suspend of the GPU.
> >
> > Fixes: cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
> > Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > v1->v2:
> >  * Don't run any suspend code or resume code in this case
>
> Any feedback for this patch?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

I think for S0ix and dGPUs, we probably need some additional work as
well.  If the user tries s2idle and the platform doesn't actually
support s0ix (i.e., doesn't actually turn off the power rails), we
should be using the runtime suspend routines for BACO/BOCO rather than
the S3 suspend routines.

Alex


>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 7 ++++++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > index fa7375b97fd47..25e902077caf6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1073,6 +1073,9 @@ bool amdgpu_acpi_is_s0ix_active(struct
> > amdgpu_device *adev)
> >           (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
> >               return false;
> >
> > +     if (adev->asic_type < CHIP_RAVEN)
> > +             return false;
> > +
> >       /*
> >        * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is
> > generally
> >        * risky to do any special firmware-related preparations for entering
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 6c2fe50b528e0..1f6d93dc3d72b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2414,8 +2414,10 @@ static int amdgpu_pmops_suspend(struct device
> > *dev)
> >
> >       if (amdgpu_acpi_is_s0ix_active(adev))
> >               adev->in_s0ix = true;
> > -     else
> > +     else if (amdgpu_acpi_is_s3_active(adev))
> >               adev->in_s3 = true;
> > +     if (!adev->in_s0ix && !adev->in_s3)
> > +             return 0;
> >       return amdgpu_device_suspend(drm_dev, true);
> >  }
> >
> > @@ -2436,6 +2438,9 @@ static int amdgpu_pmops_resume(struct device
> > *dev)
> >       struct amdgpu_device *adev = drm_to_adev(drm_dev);
> >       int r;
> >
> > +     if (!adev->in_s0ix && !adev->in_s3)
> > +             return 0;
> > +
> >       /* Avoids registers access if device is physically gone */
> >       if (!pci_device_is_present(adev->pdev))
> >               adev->no_hw_access = true;
> > --
> > 2.25.1
