Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03311C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 15:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A1189286;
	Tue, 25 Jan 2022 15:35:21 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A0089286
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 15:35:20 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 x52-20020a05683040b400b0059ea92202daso10869983ott.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 07:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u40K+xnAAn3wS5+M8HRdds0xx6AvAy4plPhFZjExY9Y=;
 b=TGoCUtQ/Y+c/0aegAtyJj+pLwRflJxAZD/IDsW3EAcN13BG+Dh9EDMplCoCrdJ/Q3k
 naoyQTkKxrjvTNpjZzxNbkZHY/6YLt6AmokbcQuVM2FBpvwMPZXk8NJPQ7PS7ocFRpQW
 syQSalIP31M9I191Q/oz7iWzOlVeWFVI8NjdslMBZip01OjT3ZrCONA0M/Iv+UfhwWBq
 uvC29+k2PLWV+6DvhZfb0/JH156EapPcrqW02UAHWyJXTBuJ4/PbXBgSHoNEMusaWKY2
 sS0lfo1EXywD6N5x2hr8W9niA1BOcOUWYZ+3Zdcww98nOtCfIhD3vEpycU2uKHqb4/3y
 KQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u40K+xnAAn3wS5+M8HRdds0xx6AvAy4plPhFZjExY9Y=;
 b=VavBWR93KGuPGjWTHFQseACcGqvr+p45vL9Js080+hCxI6Rx6CXor+RTFdDKYpuE1u
 Ik2iGZzHC3BKCMqDM0Atq/leftPlEx/dend7OQdXJpefCRUUnWo6TV2zNQkRvQxwRMsW
 8uoRx2fB3BKzircrExS2BP6rIX8tWxtK9r1PLHg4SXm6mFPGqZEAM1n3ePcGq99sP6Zn
 zxwyrdiB8hfv11tVWdjId75gEk5EokjS+1aPnfvGCCTJ8uhKMfEVFQAqlCseuznFr+1K
 4eM6bbjsAjQGz97EZwHKuZTNjPfYlzHK2H8sEbR3XVFNY+TjvJ2XT4m5NuqWq6DeUTuU
 LSbw==
X-Gm-Message-State: AOAM533DAtBEMCuhAJXCiFDKabt6SfOsf0U1YMZrGkjVf/O+uefeMvsy
 p/HpQYtSSVCBAHGmRldqpcFCh3vxp4+1k6Gj6Fqod6RARGQ=
X-Google-Smtp-Source: ABdhPJyXtwSy3jM1eKj9W5D4wip87ZDkbFvpUWQcuaqrtPQATE9IFVUlHAJ7qVFqQCD28tVZEk/+CULP489kwbp3HtA=
X-Received: by 2002:a05:6830:1d90:: with SMTP id
 y16mr15165740oti.200.1643124919873; 
 Tue, 25 Jan 2022 07:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20220125085614.101348-1-evan.quan@amd.com>
 <20220125085614.101348-2-evan.quan@amd.com>
In-Reply-To: <20220125085614.101348-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jan 2022 10:35:08 -0500
Message-ID: <CADnq5_NU+65__oY3P4V06FfpRkHesgL2v5YmOtQTYswSJr9T+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: fix the deadlock observed on
 performance_level setting
To: Evan Quan <evan.quan@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 25, 2022 at 3:57 AM Evan Quan <evan.quan@amd.com> wrote:
>
> The sub-routine(amdgpu_gfx_off_ctrl) tried to obtain the lock
> adev->pm.mutex which was actually hold by amdgpu_dpm_force_performance_level.
> A deadlock happened then.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Id692829381dedc6380f5464d74107d696f7abca1

I think in the long term, we should fix up the logic to allow us to
keep the lock across the whole function, but for now,

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 50 ++++++++++-------------------
>  1 file changed, 17 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 5fc33893a68c..ef574c96b41c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -692,25 +692,16 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
>                 amdgpu_dpm_compute_clocks(adev);
>  }
>
> -static enum amd_dpm_forced_level amdgpu_dpm_get_performance_level_locked(struct amdgpu_device *adev)
> +enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
>  {
>         const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>         enum amd_dpm_forced_level level;
>
> +       mutex_lock(&adev->pm.mutex);
>         if (pp_funcs->get_performance_level)
>                 level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
>         else
>                 level = adev->pm.dpm.forced_level;
> -
> -       return level;
> -}
> -
> -enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
> -{
> -       enum amd_dpm_forced_level level;
> -
> -       mutex_lock(&adev->pm.mutex);
> -       level = amdgpu_dpm_get_performance_level_locked(adev);
>         mutex_unlock(&adev->pm.mutex);
>
>         return level;
> @@ -725,23 +716,16 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>                                         AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
>                                         AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
>                                         AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
> -       int ret = 0;
>
>         if (!pp_funcs->force_performance_level)
>                 return 0;
>
> -       mutex_lock(&adev->pm.mutex);
> -
> -       if (adev->pm.dpm.thermal_active) {
> -               ret = -EINVAL;
> -               goto out;
> -       }
> +       if (adev->pm.dpm.thermal_active)
> +               return -EINVAL;
>
> -       current_level = amdgpu_dpm_get_performance_level_locked(adev);
> -       if (current_level == level) {
> -               ret = 0;
> -               goto out;
> -       }
> +       current_level = amdgpu_dpm_get_performance_level(adev);
> +       if (current_level == level)
> +               return 0;
>
>         if (adev->asic_type == CHIP_RAVEN) {
>                 if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
> @@ -755,10 +739,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>         }
>
>         if (!(current_level & profile_mode_mask) &&
> -           (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
> -               ret = -EINVAL;
> -               goto out;
> -       }
> +           (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
> +               return -EINVAL;
>
>         if (!(current_level & profile_mode_mask) &&
>               (level & profile_mode_mask)) {
> @@ -780,17 +762,19 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>                                                        AMD_PG_STATE_GATE);
>         }
>
> +       mutex_lock(&adev->pm.mutex);
> +
>         if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
> -                                             level))
> -               ret = -EINVAL;
> +                                             level)) {
> +               mutex_unlock(&adev->pm.mutex);
> +               return -EINVAL;
> +       }
>
> -       if (!ret)
> -               adev->pm.dpm.forced_level = level;
> +       adev->pm.dpm.forced_level = level;
>
> -out:
>         mutex_unlock(&adev->pm.mutex);
>
> -       return ret;
> +       return 0;
>  }
>
>  int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
> --
> 2.29.0
>
