Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB84C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 21:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056A661B4D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 21:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 056A661B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D9C6E0D1;
	Mon, 15 Nov 2021 21:15:37 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14DD6E0D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 21:15:36 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id r26so37580602oiw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 13:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QFszae+LTGepm+8OasJVoTumaVgMy0uel4chf+7NGKU=;
 b=eNSY/QTeWccETvwpsBpfwd00DvFIg2v+nQ1CB7O2Eq/e8fEH0/36m4/wmzGmx+HSoe
 ZkB44CI3f3ivfGFQnav+fc0Gqvd+n5xrki4aTbKRYClVx92y3/jmneDYhaRF5hCouQvY
 E+mVyiU+9Ku0fR0XzI9+gUJQnWVCluyN2dmMR/FN7sD/29SLuxf+cyPC2RajsQUWm/6K
 SyFjGmESHIWXyLoNcL0XUVqbgm1ET7wCU4mQWp7m+/7HwA0jNl4iwEGbl5jllaXb84BH
 MJwz1uUUybVJ/G0B4ar5okBJspdoDszqU104i0veucSSWGrNMJM1oy7bqkJByYy8s3mh
 7+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QFszae+LTGepm+8OasJVoTumaVgMy0uel4chf+7NGKU=;
 b=2qEQDLs/KQ6+Z0JVeQf+rfkyWqgYdYflBh02otqYpGG6GN/MvMwQa26aUNfi53C5mX
 1Uo/jvGEPc6zW+zTx7xLwWMMw7jQXT/Vpr+PnNCDNMWl4iBI1KI67q7tKs09lJNqJwtY
 6amvXtBzNSIEyVsMjnt00WY2WRIHc+yB7C2LY0XxCDE0AsSKiEvaLJ+bw1HI+dhgqUCZ
 egoDYo9IwqZtpRADHc5Bc8ucTjIu1G/O8lW3JDSj4+5ynmachV4tJidxTMaa9dkZbgzY
 mcloDdyQ2wWBzxOKb4LOX5uPnN389Pw/Bvo4Mx2VM90exQUT2V842rlyAs5cMqO4mAwm
 7xNQ==
X-Gm-Message-State: AOAM5338J8JkpVTEqzR3ynr/RSyUD5+2zOcwOH3DWDLCF5pk+bcIIhUC
 VsoArqwnRL6DTkQfAHJn/LH3XFskTrYYtbf0H9U=
X-Google-Smtp-Source: ABdhPJwwjJxCvm8LcIy7s8eDoQS6PGrURQ3Jt1TD3ODUOz/IPfXMfGhQUTAm0oTqRSy1c7r3GbuzLdlvHlFmek5d5RQ=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr215912oib.120.1637010935963; 
 Mon, 15 Nov 2021 13:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20211112174632.48205-1-surbhi.kakarya@amd.com>
 <CADnq5_Nvtege4LHemFnbnnA4qEmfCNWvCK1Owc1NGpHom0mKSg@mail.gmail.com>
 <DM6PR12MB3929AE532047ACB9FF6D260C8E989@DM6PR12MB3929.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3929AE532047ACB9FF6D260C8E989@DM6PR12MB3929.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Nov 2021 16:15:25 -0500
Message-ID: <CADnq5_Op5WkW0yNe=NPF9Ef9KPT8QJ72DkUf+7iDNnPzrnLDxg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Add sysfs interface for retrieving gpu
 metrics(V2)
To: "Kakarya, Surbhi" <Surbhi.Kakarya@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Bokun" <Bokun.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 15, 2021 at 3:49 PM Kakarya, Surbhi <Surbhi.Kakarya@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hi Alex,
>
> I am porting the patches (http://gerrit-git.amd.com/c/brahma/ec/linux/+/396997 and http://gerrit-git.amd.com/c/brahma/ec/linux/+/528745) to provide the necessary SMU utils (basic and system_status) support in this branch.
>

If you just want to populate the new fields in the metrics table, that
is all you need to do.  No need for any of the other changes.  I think
the last hunk of your patch is all you need.

Alex


> Thanks
> Surbhi
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, November 12, 2021 2:41 PM
> To: Kakarya, Surbhi <Surbhi.Kakarya@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Bokun <Bokun.Zhang@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Add sysfs interface for retrieving gpu metrics(V2)
>
> On Fri, Nov 12, 2021 at 12:46 PM Surbhi Kakarya <surbhi.kakarya@amd.com> wrote:
> >
> > A new interface for UMD to retrieve gpu metrics data. This patch is
> > based on an existing patch If7f3523915505c0ece0a56dfd476d2b8473440d4.
> >
>
> It's not clear what you are trying to do here.
>
> > Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
> > Change-Id: I701110d78a85c092f5dda167a52350cc6dda7557
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c                     |  6 +++++-
> >  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h                |  2 +-
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c              |  4 +---
> >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
> >  4 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > index 01cca08a774f..d60426daddae 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -1800,8 +1800,12 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
> >                 return ret;
> >         }
> >
> > -       if (adev->powerplay.pp_funcs->get_gpu_metrics)
> > +       down_read(&adev->reset_sem);
> > +       if (is_support_sw_smu(adev))
> > +               size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
> > +       else if (adev->powerplay.pp_funcs->get_gpu_metrics)
> >                 size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
> > +       up_read(&adev->reset_sem);
> >
>
> Why are you changing this code?
> adev->powerplay.pp_funcs->get_gpu_metrics already points to
> smu_sys_get_gpu_metrics().  Also why do you need to add the semaphore locking?
>
> >         if (size <= 0)
> >                 goto out;
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > index 3557f4e7fc30..5ffe7e3bf1aa 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > @@ -1397,6 +1397,6 @@ int smu_set_light_sbr(struct smu_context *smu,
> > bool enable);
> >
> >  int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
> >                        uint64_t event_arg);
> > -
> > +ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void
> > +**table);
> >  #endif
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index b06c59dcc1b4..ec81abe385e3 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -3005,9 +3005,8 @@ static int smu_get_dpm_clock_table(void *handle,
> >         return ret;
> >  }
> >
> > -static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
> > +ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void
> > +**table)
> >  {
> > -       struct smu_context *smu = handle;
> >         ssize_t size;
> >
> >         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) @@ -3135,7
> > +3134,6 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
> >         .asic_reset_mode_2                = smu_mode2_reset,
> >         .set_df_cstate                    = smu_set_df_cstate,
> >         .set_xgmi_pstate                  = smu_set_xgmi_pstate,
> > -       .get_gpu_metrics                  = smu_sys_get_gpu_metrics,
>
> Why are you removing this?
>
> >         .set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
> >         .display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
> >         .get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 3b1bf270ebc6..97d18e764665 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -3619,6 +3619,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >         gpu_metrics->energy_accumulator =
> >                 use_metrics_v2 ? metrics_v2->EnergyAccumulator :
> > metrics->EnergyAccumulator;
> >
> > +       if (metrics->CurrGfxVoltageOffset)
> > +               gpu_metrics->voltage_gfx =
> > +                       (155000 - 625 * metrics->CurrGfxVoltageOffset) / 100;
> > +       if (metrics->CurrMemVidOffset)
> > +               gpu_metrics->voltage_mem =
> > +                       (155000 - 625 * metrics->CurrMemVidOffset) / 100;
> > +       if (metrics->CurrSocVoltageOffset)
> > +               gpu_metrics->voltage_soc =
> > +                       (155000 - 625 * metrics->CurrSocVoltageOffset)
> > + / 100;
> > +
>
> This change seems unrelated to the other changes in this patch.
>
> Alex
>
>
> >         average_gfx_activity = use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
> >         if (average_gfx_activity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> >                 gpu_metrics->average_gfxclk_frequency =
> > --
> > 2.25.1
> >
