Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A63C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 17:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A640113620;
	Tue, 17 May 2022 17:46:59 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46F4113620
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 17:46:57 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id n24so23145419oie.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2+9+8Kf1H5UORl+UMgA8WkvINbwhbSipwyaqslKxdmA=;
 b=QZCIt56o/Lp33T45zKjRMtH29nwFqroWzscKC1S3RJxV6SI7D/ukN5f9vxRG1UJn4C
 +54/NijsCwqbCMTak6XZtLc+MSaH8gfgU6TwNICr5t6fdMA79mYrv1DT/EQlp306cJHH
 XWyHn6S7r1AgnuUNnzyPKCREQ8UAsXD1fVJJCe/xZYXmH57fME6IP9rqj8+y7RTGASQo
 yMn2h+CvVsqYvB55ZOai0XRj4vj3cxhGg21+obhj5thCPyLp7Zam0A5Vfg5BzH21Cy0U
 O/kX4yLEcyCYkiOXwgkDj9XKKQxeQDaF/P3F93fjAnHGSW67ppflD/s4uJcahouINSZf
 5KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2+9+8Kf1H5UORl+UMgA8WkvINbwhbSipwyaqslKxdmA=;
 b=5Ay6B9JE3dhT7BQlReCdKiIC4Via2/0Ywu1MKKHLmxxQsTOS4Qzc3G3fikbDtxq3v4
 CeUulTxf35mskQ30zRH/O6rJ37i2+v0fEAMjV+FYTiQ47HLHbBvYA1eSNYIxcNVvf5DK
 UNGeYgDNkB7NH6Mthudw4Bv2M8klqf7/WYnkdfVHE8cexPhuEYnOBjHiM0fFlLS3nyuE
 HwaaejudX+oy1icD2R+5W3FqOtpEg5gof+YEhUiYK9Ty80Z/tQPYS3VG3wzxI/Z+2/CH
 SJsdANkrMkQVeGAWLL8dI8hd9SmvJ5E0rGMve1q+VyFTH4AhsxMU4nYec0xjoPjuTD+f
 mG3Q==
X-Gm-Message-State: AOAM5318up/pLsYM3kGbLSDKn1Gp+yt0DDCx5OwmYftv5Dg7wuMplUGM
 SOEEkX2YzMlCpW0sh54H8OD7moAg2r7wtqomqulpvWLJ
X-Google-Smtp-Source: ABdhPJye+ZnARYvZARtZ7RqKUJqR+YF4+oS36tIo4vhwowKQ7uswYhH17lv0HPCcmRWiKyXvCdg78jUWYhtA6U/mcBw=
X-Received: by 2002:a05:6808:178d:b0:326:3fe9:7f03 with SMTP id
 bg13-20020a056808178d00b003263fe97f03mr15827838oib.200.1652809617015; Tue, 17
 May 2022 10:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220517170037.6505-1-mario.limonciello@amd.com>
In-Reply-To: <20220517170037.6505-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 13:46:45 -0400
Message-ID: <CADnq5_PKW+_x7_uPrYXjnh4Wgs_rQoY25D3q37keFx0f58daTQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Don't reset dGPUs if the system is going to
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

On Tue, May 17, 2022 at 1:00 PM Mario Limonciello
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v1->v2:
>  * Add missing stub function for non CONFIG_ACPI case
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  2 +-
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3c20c2eadf4e..76df583663c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1378,9 +1378,11 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
>  bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
> +bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>  #else
>  static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
> +static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
>  static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
>  #endif
>
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
> 2.25.1
>
