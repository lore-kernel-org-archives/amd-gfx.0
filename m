Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE36EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 19:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32AC60F45
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 19:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B32AC60F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232496F47F;
	Fri, 12 Nov 2021 19:41:27 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C3C6F47F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 19:41:25 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 b5-20020a9d60c5000000b0055c6349ff22so15361004otk.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 11:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hU2qh67pOj5nE30oDLM62Wa1qxdtFP59KnMzkeTpnhY=;
 b=TiO6UqKpvh2qy4NYeuQL9Hm+1YicYmfjmMvSD8/HSTUAcZJulEFgZ0UyUbgJLy4clS
 Y3Cig9MzhcopTHmjMmX+hFJjK7B1TR+iRfZugjgGfV7+PAyOsZRGE0wU1MCxUzcm6+BL
 SLL9SX2jVTsOcxBkODyIUs+MME9q3+0YeNDhJaGrJd1zCusPTrEEIQImBMHqmMx8NWQm
 BITImQ2/PZSta5absiwO2F1tlXa22irPA1jTiS8a3Dcd6JiK4vKEJlODIHOm7aR3Jfe+
 dfZ6pWquMu5HcEfy8st3A4cKyxcg2GtqWLQVoFwvGgBNlKS9XHxqtYfQlZeyPNnt5NNe
 eZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hU2qh67pOj5nE30oDLM62Wa1qxdtFP59KnMzkeTpnhY=;
 b=t5R4rF1Zke6UhhH6deCoUXcJVrtqUUHVkzgQm6RAed9diTvVxPUqDkTzTSWMvCDRQo
 Sfm6XD2j4MF1XnJOCw3TQg1RPrK2tloA4r97owMqWxxH+vYzU6bfu0v1606c1WhowppV
 HLSyQ90YxUbmS0V9fgNzVjUSN8h38lpAFI0vnWSgG/gjgb66ueEmmNCN/WzxIVTa+i/+
 PiNCxXb5SW8zOQ1tUHOwhYuY8+Og0IqXRXU2KU+HG3+CIDDQ6kDGUf8J+Hhv1829Gjbt
 zx/jrqYYmXy+myGq8zqSZdDPyukfS6W+ZmWRZU32cadi+sahKsBNpqxMa7ELdwZ3v1uD
 0jmw==
X-Gm-Message-State: AOAM533Xdgq3oR2jv4xo8dn0bZZUe2UwBRG3cUmpeepC3L6NlGGjRPt8
 Tyk+JGCrZeSiBokLwch/1sxnr35hWNEQOhJp3tiGaJ/WpGA=
X-Google-Smtp-Source: ABdhPJwqh2zBr82qjDsuf241TpZVLeFDXpqbHnkUNCvX2O+OlbW9F4HEXJ0M/5UisIUjdtLGoxt+GK+2yYQlkDO6lMw=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr14753365oto.357.1636746084766; 
 Fri, 12 Nov 2021 11:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20211112174632.48205-1-surbhi.kakarya@amd.com>
In-Reply-To: <20211112174632.48205-1-surbhi.kakarya@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Nov 2021 14:41:14 -0500
Message-ID: <CADnq5_Nvtege4LHemFnbnnA4qEmfCNWvCK1Owc1NGpHom0mKSg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Add sysfs interface for retrieving gpu
 metrics(V2)
To: Surbhi Kakarya <surbhi.kakarya@amd.com>
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
 Bokun Zhang <Bokun.Zhang@amd.com>, "monk.liu" <Monk.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, HaiJun.Chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 12, 2021 at 12:46 PM Surbhi Kakarya <surbhi.kakarya@amd.com> wrote:
>
> A new interface for UMD to retrieve gpu metrics data. This patch is
> based on an existing patch If7f3523915505c0ece0a56dfd476d2b8473440d4.
>

It's not clear what you are trying to do here.

> Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>
> Change-Id: I701110d78a85c092f5dda167a52350cc6dda7557
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c                     |  6 +++++-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h                |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c              |  4 +---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 ++++++++++
>  4 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 01cca08a774f..d60426daddae 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1800,8 +1800,12 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>                 return ret;
>         }
>
> -       if (adev->powerplay.pp_funcs->get_gpu_metrics)
> +       down_read(&adev->reset_sem);
> +       if (is_support_sw_smu(adev))
> +               size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
> +       else if (adev->powerplay.pp_funcs->get_gpu_metrics)
>                 size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
> +       up_read(&adev->reset_sem);
>

Why are you changing this code?
adev->powerplay.pp_funcs->get_gpu_metrics already points to
smu_sys_get_gpu_metrics().  Also why do you need to add the semaphore
locking?

>         if (size <= 0)
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 3557f4e7fc30..5ffe7e3bf1aa 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -1397,6 +1397,6 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable);
>
>  int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
>                        uint64_t event_arg);
> -
> +ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b06c59dcc1b4..ec81abe385e3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3005,9 +3005,8 @@ static int smu_get_dpm_clock_table(void *handle,
>         return ret;
>  }
>
> -static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
> +ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table)
>  {
> -       struct smu_context *smu = handle;
>         ssize_t size;
>
>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> @@ -3135,7 +3134,6 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>         .asic_reset_mode_2                = smu_mode2_reset,
>         .set_df_cstate                    = smu_set_df_cstate,
>         .set_xgmi_pstate                  = smu_set_xgmi_pstate,
> -       .get_gpu_metrics                  = smu_sys_get_gpu_metrics,

Why are you removing this?

>         .set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
>         .display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
>         .get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 3b1bf270ebc6..97d18e764665 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3619,6 +3619,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>         gpu_metrics->energy_accumulator =
>                 use_metrics_v2 ? metrics_v2->EnergyAccumulator : metrics->EnergyAccumulator;
>
> +       if (metrics->CurrGfxVoltageOffset)
> +               gpu_metrics->voltage_gfx =
> +                       (155000 - 625 * metrics->CurrGfxVoltageOffset) / 100;
> +       if (metrics->CurrMemVidOffset)
> +               gpu_metrics->voltage_mem =
> +                       (155000 - 625 * metrics->CurrMemVidOffset) / 100;
> +       if (metrics->CurrSocVoltageOffset)
> +               gpu_metrics->voltage_soc =
> +                       (155000 - 625 * metrics->CurrSocVoltageOffset) / 100;
> +

This change seems unrelated to the other changes in this patch.

Alex


>         average_gfx_activity = use_metrics_v2 ? metrics_v2->AverageGfxActivity : metrics->AverageGfxActivity;
>         if (average_gfx_activity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
>                 gpu_metrics->average_gfxclk_frequency =
> --
> 2.25.1
>
