Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A121CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDDB20775
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inGLZi6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDDB20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E3D6EB34;
	Thu,  9 Jul 2020 20:47:36 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74B06EB34
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 20:47:34 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id f2so3733947wrp.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qUfY1iGbcxldFIX1VRzTvkyOxO0L89AW/1JNmV1FW9g=;
 b=inGLZi6XHA33NUcJgrxhtAsd8Rc5f8AX0w4mUX9rjXoQCok+VsSuRAo9iY1KPwAI/N
 u1Lv2GVHXIA3FTlxIkpInNTjPutjePMaV6MJiQtdCE8xIXL2r0e3Zr5a+97IESYDqYps
 YS2J8JB2Oexw8IvlsQbokIz1wB1bvnQwjlNp86yowPS3zC0W37wtJs0X7IU+qcra01Xs
 PjrLRBBW5eTb7SaqFVaVjCffXLp2zDJZUF5tY5d6hO1LULentRtO35ayX/S4p+c3tnuy
 X93aDT+yWU1dPd5ZbGTkqogha4TQ+cTrfWpcGevN47uK2PLzeXyZy/Fz1a3P8xGa+G5g
 Yo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qUfY1iGbcxldFIX1VRzTvkyOxO0L89AW/1JNmV1FW9g=;
 b=A7XeNc6gciVgGCRQdWOpM6aYbVpJyDuU97iOXaXesD2Uk10O//J6rMGZgT65VnVtuZ
 UCYU45JmBCH4JwPEJNvC6vlXUZ6yr7Arsrp1GL7iaWp8ZNOhL1vhW7+mBc4Yj4t7Suvw
 3Z9W7o//qclUVWYSYv/zI6mfbKVVUWwYpaz1HmkxrkndkwSapvn1+uJ9t9HeSW4RhfBN
 yXnPn6ZevDvx2UlOIXMfXPe3RzGYRk4GYKFqMlJV9lL2qQDHPXeO4tuntwu+iH1DgVOu
 5sf3uGFVXgrH312EPcn/X0HHllo0gjOjGGuKGKAzpwUEj6KlQG6kQpuIuMRWoEnjVQ/i
 ikcg==
X-Gm-Message-State: AOAM531H4KXk4x0Zic6DEYfkg7OaOx7FzJCV0khjEdq0tJ4syWbCKRsh
 +VC6iwM06Gm06U0jH6h5ChfSlfcWkpd7YqJfapd+IO9w
X-Google-Smtp-Source: ABdhPJzdPRsYI4Ov0Za21Z1HAUW0agBQO7YR+odLjVnj2wn/d8uaWPzC611qZa/f4POrFabrkYzIGifkP2iFw0Ip7tU=
X-Received: by 2002:adf:dd8d:: with SMTP id x13mr63775251wrl.362.1594327653459; 
 Thu, 09 Jul 2020 13:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200703083303.478-1-evan.quan@amd.com>
 <20200703083303.478-14-evan.quan@amd.com>
In-Reply-To: <20200703083303.478-14-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2020 16:47:22 -0400
Message-ID: <CADnq5_PZz+g4X-BVxS8wgGbmhycYS8M+2n6RpZpwKK4k+RnwPQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] drm/amd/powerplay: drop unused APIs and parameters
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 3, 2020 at 4:34 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Leftover of previous performance level setting cleanups.
>
> Change-Id: Idddc4adce365b34eacbc13f75cc0629859c6d412
> Signed-off-by: Evan Quan <evan.quan@amd.com>

patches 5-10, 12-14:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c         | 12 ++++++------
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  9 +++------
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 12 +-----------
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c     |  2 --
>  drivers/gpu/drm/amd/powerplay/smu_internal.h   |  5 -----
>  5 files changed, 10 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 26c8e39a78bd..c418613699ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1105,7 +1105,7 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
>         }
>
>         if (is_support_sw_smu(adev))
> -               ret = smu_force_clk_levels(&adev->smu, SMU_SCLK, mask, true);
> +               ret = smu_force_clk_levels(&adev->smu, SMU_SCLK, mask);
>         else if (adev->powerplay.pp_funcs->force_clock_level)
>                 ret = amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
>
> @@ -1173,7 +1173,7 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
>         }
>
>         if (is_support_sw_smu(adev))
> -               ret = smu_force_clk_levels(&adev->smu, SMU_MCLK, mask, true);
> +               ret = smu_force_clk_levels(&adev->smu, SMU_MCLK, mask);
>         else if (adev->powerplay.pp_funcs->force_clock_level)
>                 ret = amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
>
> @@ -1241,7 +1241,7 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
>         }
>
>         if (is_support_sw_smu(adev))
> -               ret = smu_force_clk_levels(&adev->smu, SMU_SOCCLK, mask, true);
> +               ret = smu_force_clk_levels(&adev->smu, SMU_SOCCLK, mask);
>         else if (adev->powerplay.pp_funcs->force_clock_level)
>                 ret = amdgpu_dpm_force_clock_level(adev, PP_SOCCLK, mask);
>         else
> @@ -1311,7 +1311,7 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
>         }
>
>         if (is_support_sw_smu(adev))
> -               ret = smu_force_clk_levels(&adev->smu, SMU_FCLK, mask, true);
> +               ret = smu_force_clk_levels(&adev->smu, SMU_FCLK, mask);
>         else if (adev->powerplay.pp_funcs->force_clock_level)
>                 ret = amdgpu_dpm_force_clock_level(adev, PP_FCLK, mask);
>         else
> @@ -1381,7 +1381,7 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
>         }
>
>         if (is_support_sw_smu(adev))
> -               ret = smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, mask, true);
> +               ret = smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, mask);
>         else if (adev->powerplay.pp_funcs->force_clock_level)
>                 ret = amdgpu_dpm_force_clock_level(adev, PP_DCEFCLK, mask);
>         else
> @@ -1451,7 +1451,7 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
>         }
>
>         if (is_support_sw_smu(adev))
> -               ret = smu_force_clk_levels(&adev->smu, SMU_PCIE, mask, true);
> +               ret = smu_force_clk_levels(&adev->smu, SMU_PCIE, mask);
>         else if (adev->powerplay.pp_funcs->force_clock_level)
>                 ret = amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);
>         else
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 4080b3c792ac..38b3b47d12b7 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1764,8 +1764,7 @@ int smu_set_display_count(struct smu_context *smu, uint32_t count)
>
>  int smu_force_clk_levels(struct smu_context *smu,
>                          enum smu_clk_type clk_type,
> -                        uint32_t mask,
> -                        bool lock_needed)
> +                        uint32_t mask)
>  {
>         struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>         int ret = 0;
> @@ -1778,14 +1777,12 @@ int smu_force_clk_levels(struct smu_context *smu,
>                 return -EINVAL;
>         }
>
> -       if (lock_needed)
> -               mutex_lock(&smu->mutex);
> +       mutex_lock(&smu->mutex);
>
>         if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels)
>                 ret = smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
>
> -       if (lock_needed)
> -               mutex_unlock(&smu->mutex);
> +       mutex_unlock(&smu->mutex);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 91c8b69da026..470b0377a860 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -476,13 +476,6 @@ struct pptable_funcs {
>         int (*display_config_changed)(struct smu_context *smu);
>         int (*apply_clocks_adjust_rules)(struct smu_context *smu);
>         int (*notify_smc_display_config)(struct smu_context *smu);
> -       int (*force_dpm_limit_value)(struct smu_context *smu, bool highest);
> -       int (*unforce_dpm_levels)(struct smu_context *smu);
> -       int (*get_profiling_clk_mask)(struct smu_context *smu,
> -                                     enum amd_dpm_forced_level level,
> -                                     uint32_t *sclk_mask,
> -                                     uint32_t *mclk_mask,
> -                                     uint32_t *soc_mask);
>         int (*set_cpu_power_state)(struct smu_context *smu);
>         bool (*is_dpm_running)(struct smu_context *smu);
>         int (*tables_init)(struct smu_context *smu, struct smu_table *tables);
> @@ -498,8 +491,6 @@ struct pptable_funcs {
>         int (*display_disable_memory_clock_switch)(struct smu_context *smu, bool disable_memory_clock_switch);
>         void (*dump_pptable)(struct smu_context *smu);
>         int (*get_power_limit)(struct smu_context *smu);
> -       int (*get_dpm_clk_limited)(struct smu_context *smu, enum smu_clk_type clk_type,
> -                                  uint32_t dpm_level, uint32_t *freq);
>         int (*set_df_cstate)(struct smu_context *smu, enum pp_df_cstate state);
>         int (*allow_xgmi_power_down)(struct smu_context *smu, bool en);
>         int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
> @@ -745,8 +736,7 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);
>  int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask);
>  int smu_force_clk_levels(struct smu_context *smu,
>                          enum smu_clk_type clk_type,
> -                        uint32_t mask,
> -                        bool lock_needed);
> +                        uint32_t mask);
>  int smu_set_mp1_state(struct smu_context *smu,
>                       enum pp_mp1_state mp1_state);
>  int smu_set_df_cstate(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 5b76d67d03d7..866ae014eda2 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -1041,13 +1041,11 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>         .get_smu_table_index = renoir_get_smu_table_index,
>         .tables_init = renoir_tables_init,
>         .set_power_state = NULL,
> -       .get_dpm_clk_limited = renoir_get_dpm_clk_limited,
>         .print_clk_levels = renoir_print_clk_levels,
>         .get_current_power_state = renoir_get_current_power_state,
>         .dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
>         .dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
>         .get_workload_type = renoir_get_workload_type,
> -       .get_profiling_clk_mask = renoir_get_profiling_clk_mask,
>         .force_clk_levels = renoir_force_clk_levels,
>         .set_power_profile_mode = renoir_set_power_profile_mode,
>         .set_performance_level = renoir_set_performance_level,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 1b357e349d1e..6eb375af543d 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -68,8 +68,6 @@
>  #define smu_display_config_changed(smu)                                        smu_ppt_funcs(display_config_changed, 0 , smu)
>  #define smu_apply_clocks_adjust_rules(smu)                             smu_ppt_funcs(apply_clocks_adjust_rules, 0, smu)
>  #define smu_notify_smc_display_config(smu)                             smu_ppt_funcs(notify_smc_display_config, 0, smu)
> -#define smu_force_dpm_limit_value(smu, highest)                                smu_ppt_funcs(force_dpm_limit_value, 0, smu, highest)
> -#define smu_unforce_dpm_levels(smu)                                    smu_ppt_funcs(unforce_dpm_levels, 0, smu)
>  #define smu_set_cpu_power_state(smu)                                   smu_ppt_funcs(set_cpu_power_state, 0, smu)
>  #define smu_msg_get_index(smu, msg)                                    smu_ppt_funcs(get_smu_msg_index, -EINVAL, smu, msg)
>  #define smu_clk_get_index(smu, clk)                                    smu_ppt_funcs(get_smu_clk_index, -EINVAL, smu, clk)
> @@ -92,7 +90,6 @@
>  #define smu_get_dpm_ultimate_freq(smu, param, min, max)                        smu_ppt_funcs(get_dpm_ultimate_freq, 0, smu, param, min, max)
>  #define smu_asic_set_performance_level(smu, level)                     smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
>  #define smu_dump_pptable(smu)                                          smu_ppt_funcs(dump_pptable, 0, smu)
> -#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)                smu_ppt_funcs(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, freq)
>  #define smu_override_pcie_parameters(smu)                              smu_ppt_funcs(override_pcie_parameters, 0, smu)
>  #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)  smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
>  #define smu_set_thermal_range(smu, range)                              smu_ppt_funcs(set_thermal_range, 0, smu, range)
> @@ -103,7 +100,5 @@
>  #define smu_get_unique_id(smu)                                         smu_ppt_funcs(get_unique_id, 0, smu)
>  #define smu_log_thermal_throttling(smu)                                        smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
>  #define smu_get_asic_power_limits(smu)                                 smu_ppt_funcs(get_power_limit, 0, smu)
> -#define smu_get_profiling_clk_mask(smu, level, sclk_mask, mclk_mask, soc_mask) \
> -       smu_ppt_funcs(get_profiling_clk_mask, 0, smu, level, sclk_mask, mclk_mask, soc_mask)
>
>  #endif
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
