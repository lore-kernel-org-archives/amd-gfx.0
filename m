Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40552C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 15:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F43D8F0DB;
	Mon, 11 Jul 2022 15:30:13 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671AA8F0C9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 15:30:12 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id fd6so6709705edb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RwHCEwZ+KyKIc2eCvfeQFmEKY7KG5pWcRFN+HiB23Mo=;
 b=X+Ci2lvOzejtzzZNGXQvaLVunvdVwBH8HjrorWNSTRE9HCxEz5MX/5lh/qYtAJkixc
 UDkaE7bG+wqhWGZcCEoEFLsvJ+e0jhNCsXNslnkDn1lP2FTDqoJrP4EKxNqgukhLQ3eF
 Y6qyXsdcE0eyFOCy0p+ZpYXCfFGlLS2OpIeAaLRGrhvn77Dady6LtYCwB8k6gdhAm+AZ
 r7MLPkr7qxKWZnOnkB2///VmU6YE5YBpUlKECT7ojgcbFzPcx3l9UEJBI8hc6Fo6kNrg
 DPMEPqOfHDmc2nEX3Ne3b6QGP6tI/LPCIwKamDQFlX0sp59NlqwTqnZLclSFLxiNmBVP
 c1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RwHCEwZ+KyKIc2eCvfeQFmEKY7KG5pWcRFN+HiB23Mo=;
 b=zx3QmT6dC0ScJqDcW6XeGCVBSDg2qZYRGW+FYcXGYOPmiJvyBI3letGR6E6axIaKBI
 xNYl54lJG7sihuXNynDlwselOrmMIdBH7ecr9PHMvp7RTuHCzuu0gMUOy+Zdgs7JeqHC
 NYxagWINI0vhkmugt7SyJZeEZ2+jh7RZ2qSW8sBw2Id3/3Y650YMZgpTRgny4LVaIfdr
 T2xDlCEGd84JuYhl0QdIgtvzv8QugeRwcBDCTtu/vYitvqH4dWDHGzC6ioGWowDohbOo
 yeldNtVCqDCbGyXvry8qOLY6lne34KdElzVPafmbh46qaQwHe3EP8xoQZOkzJeZLCPzp
 tKgQ==
X-Gm-Message-State: AJIora8o/oRDta/pmWChMEFvTOUXrbLFVpMmYgzSFcqpVZznWgs4k1jd
 d/EVtVL+nTIruUjSV5Lp9X6CA/CfbkI8gYTiWgkX5/sm
X-Google-Smtp-Source: AGRyM1vPPEpO7EU1RaelAzpt2HqdBrb800P96i3g5YlfszEYN1zBwjbUdis1KUzn1wn046U8nNqhcEfFJWShBZW8ftA=
X-Received: by 2002:a05:6402:13:b0:439:ffe8:bec9 with SMTP id
 d19-20020a056402001300b00439ffe8bec9mr25985231edu.297.1657553410955; Mon, 11
 Jul 2022 08:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220711135808.11949-1-guchun.chen@amd.com>
In-Reply-To: <20220711135808.11949-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Jul 2022 11:29:59 -0400
Message-ID: <CADnq5_O87os48QwD9714fBMcJxhF5AqTHeyeSvRsptppZ-ki8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: use cached SMU feature mask in runpm
To: Guchun Chen <guchun.chen@amd.com>
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
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 11, 2022 at 9:58 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> SMU will perform dpm disablement when entering BACO,
> and enable them later on, so talking to SMU to get
> enabled features in runpm cycle as BACO support check
> is not reliable. Hence, use a cached value to fix it.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 4 ++++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 9 +++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 5 +++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 8 +++++++-
>  6 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1cc9260e75de..dc2e78bb7224 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2478,6 +2478,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>         }
>
>         adev->in_runpm = true;
> +
> +       /* cache SMU feature mask */
> +       amdgpu_dpm_set_cached_feature_mask(adev);
> +
>         if (amdgpu_device_supports_px(drm_dev))
>                 drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 956b6ce81c84..211f73a987d6 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1702,3 +1702,12 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>
>         return ret;
>  }
> +
> +void amdgpu_dpm_set_cached_feature_mask(struct amdgpu_device *adev)
> +{
> +       struct smu_context *smu = adev->powerplay.pp_handle;
> +
> +       mutex_lock(&adev->pm.mutex);
> +       smu_set_cached_enabled_mask(smu);
> +       mutex_unlock(&adev->pm.mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 524fb09437e5..e9c002a561c2 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -543,4 +543,5 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
>                                                   unsigned int *num_states);
>  int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
>                                    struct dpm_clocks *clock_table);
> +void amdgpu_dpm_set_cached_feature_mask(struct amdgpu_device *adev);
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index fd79b213fab4..e8ead58a00b4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3130,3 +3130,8 @@ int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size)
>
>         return ret;
>  }
> +
> +void smu_set_cached_enabled_mask(struct smu_context *smu)
> +{
> +       smu_feature_get_enabled_mask(smu, &smu->cache_enabled_mask);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index b81c657c7386..678123b5e2bf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -568,6 +568,8 @@ struct smu_context
>         u32 param_reg;
>         u32 msg_reg;
>         u32 resp_reg;
> +
> +       uint64_t cache_enabled_mask;
>  };
>
>  struct i2c_adapter;
> @@ -1465,5 +1467,6 @@ int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
>  void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
>  int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
>  int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size);
> +void smu_set_cached_enabled_mask(struct smu_context *smu);
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 15e4298c7cc8..b3087085622a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -499,7 +499,13 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
>         uint64_t enabled_features;
>         int feature_id;
>
> -       if (__smu_get_enabled_features(smu, &enabled_features)) {
> +       /* SMU will perform dpm disablement when entering BACO, and enable
> +        * them later on, so talking to SMU to get enabled features in runpm
> +        * stage is not reliable. Use a cache value for this instead to fix it.
> +        */
> +       if (adev->in_runpm) {
> +               enabled_features = smu->cache_enabled_mask;

Do we need to handle this differently for BOCO?

Alex

> +       } else if (__smu_get_enabled_features(smu, &enabled_features)) {
>                 dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
>                 return 0;
>         }
> --
> 2.17.1
>
