Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF0AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 13:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEB4112D68;
	Tue, 17 May 2022 13:43:16 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00FB1112D4E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 13:43:14 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id q8so22273789oif.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 06:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GKXEDHppOHn6HbVcnH02ydxPX8b4ge+977xwK3TU2IQ=;
 b=ogEL5zu/rNTeXSlDoVo203A3yUbTDD4edHXTRUks8xlUF1AKjkDM24fWE79Uo1/rsk
 8R0+GRkFIO9GgahpnjcUbfU0HAqSuKei+h9ZS7Z1E5LTKQdniqaY3IVzrTRAKaQdueTi
 rhz9ZNPn7rUuxP4gTWl1uzIJ/bOPexwMMIlQ5BXgEDK7Q2AmrsGMp7IxRbsvtXIxzJWJ
 xY4Ywi6sEiqJ1mPW1RM1fZKQHrF5kdALD8t+k15IPZQk/M9Bv8hc7432S1d2PWXADpyK
 BEONtC3ff1pzdl6JJlkzl43H5bxRKrCP3+bC96cezl4fNIkMvuaD+ANdsVZ/LecXzuNL
 N79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GKXEDHppOHn6HbVcnH02ydxPX8b4ge+977xwK3TU2IQ=;
 b=vh+SNZDcMQ2myGarcgCFF8rLNqEKvtOlboP6HhQZuao55rpSiX+Imfksgu6vp5RPy3
 QrgZH2IHNbVGpP9dbJKviIrlNoxvEXHbMzMTiVPT5z13q/+lwvaqrtnQ6sJSHpQkqVeV
 Obd2ojGNaAnXETmwJEySJm+7PJznwaf6W6RhgRhUSAQbX1x3as9xnLTGD6A9uHh8YXxQ
 lB7tOoMdS2EmQ1O1m6rDEYLjAzGzred9mWSJf5At+cmAIQ/HANjxtnOQeqmKlqoi8xXt
 hi0bWAhnnpCZLM5TrsDuvXTsthKqFWdA2EZlKqhE5D7Usl+TTdIIxMinYZrYZ836PMY8
 8JKg==
X-Gm-Message-State: AOAM530WEJHEntCIIX5Rh7hr8WfdEnqgxrmYk/VN8lbFhdUUg1x9syV7
 wNevhecoeSpxraku6CiYKaJ1Ya+10rmVPHULFIG+lkR5
X-Google-Smtp-Source: ABdhPJw1DK+VEBpDsC0ZcOqpxUsrQMyvBr0ecksSP/FiRm1dM6FxZeSK9XhCKkgP+WUSSi0KT/t/JWYABojF/SJrGDM=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr11124371oiw.253.1652794994206; Tue, 17
 May 2022 06:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220517133944.25612-1-mario.limonciello@amd.com>
In-Reply-To: <20220517133944.25612-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 09:43:02 -0400
Message-ID: <CADnq5_OT9RkdSOW7vnT6+g72wENDr201taaHTs5op9kWApgeNw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 17, 2022 at 9:39 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> An A+A configuration on ASUS ROG Strix G513QY proves that the ASIC
> reset for handling aborted suspend can't work with s2idle.
>
> This functionality was introduced in commit daf8de0874ab5b ("drm/amdgpu:
> always reset the asic in suspend (v2)").  A few other commits have
> gone on top of the ASIC reset, but this still doesn't work on the A+A
> configuration in s2idle.
>
> Avoid doing the reset on dGPUs specifically when using s2idle.
>
> Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2008
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

But I think maybe we should just drop all of this in the longer term.
We are slowly dropping every case where we reset the GPU.  I'm not
even sure it actually fixes the issue it was originally added to fix
at this point because the actual reset has moved to the no-irq
callback which will most likely not get called on an aborted suspend
anyway.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3c20c2eadf4e..9cf3d65f17d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1378,6 +1378,7 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
>  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
> +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>  #else
>  static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 0e12315fa0cb..98ac53ee6bb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1045,6 +1045,20 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>                 (pm_suspend_target_state == PM_SUSPEND_MEM);
>  }
>
> +/**
> + * amdgpu_acpi_should_gpu_reset
> + *
> + * @adev: amdgpu_device_pointer
> + *
> + * returns true if should reset GPU, false if not
> + */
> +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
> +{
> +       if (adev->flags & AMD_IS_APU)
> +               return false;
> +       return pm_suspend_target_state != PM_SUSPEND_TO_IDLE;
> +}
> +
>  /**
>   * amdgpu_acpi_is_s0ix_active
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 16871baee784..a84766c13ac5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2315,7 +2315,7 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = drm_to_adev(drm_dev);
>
> -       if (!adev->in_s0ix)
> +       if (amdgpu_acpi_should_gpu_reset(adev))
>                 return amdgpu_asic_reset(adev);
>
>         return 0;
> --
> 2.34.1
>
