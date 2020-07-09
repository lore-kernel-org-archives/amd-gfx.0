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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D6CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E4F20720
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRqf4rM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E4F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D426EB2F;
	Thu,  9 Jul 2020 20:32:46 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8716EB2F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 20:32:44 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f18so3254980wml.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k7Mbzaw7e150j1K3ZppILaL+FXuxzVTNEa78yLHBzbk=;
 b=tRqf4rM6cJIedqOSH3GwM0eElM98qam5POb4Em62+tXrFac4ArCK9UHAyWGjruGHoM
 s8zk7iLNqTGss9lcnFrTVSMvqxkaRTURX/yFPSdoUgU+oAvghB1IrjpTCi3qrdPBOTVJ
 cmcoaS5JATBMOC9ePSJXRKUYDpfeuVksCn+y2vzqv6rFJ0Zef1lWX1PZGx4R1BIh7i1p
 oaLxItz+bFDPCEIa3f4ogfQEFL/lIMLg6GrQ0neNPWLGzOtGLZH0pT1Xn63H3RezlLoB
 1vmFJC6/yNrbXpQEW2I0FoEBXqH8dpMnIbjogG5Nw6guSXZPThs/tTZMDJUIaIrxYDSe
 SJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k7Mbzaw7e150j1K3ZppILaL+FXuxzVTNEa78yLHBzbk=;
 b=GMUOvfqectSa67RNzEToUTqWEOIRg5Iy+Eo1ELTlS2rH7e3GZUSfsdaeYFotgTZj/6
 Ld7ktMmWQSX/ym4Sas4NrbULIZduQ6bGzh2ZKHB/dKnSvVt6ls7z6JBMeQluPkxkytMe
 fZh/LZMMts56rkSmKK7MkIZyAToGHWQUAwNCigQMYS6BsRB4EJnJ8Si6ptBk+PyGqhQd
 u3o/xf7QxBwa3zIfLdYOldOCJIQYxE9WHJfIYgt2YmZUhvVsy9zaSv3qsGaIYK/ryAjh
 vLTeT8DHS9vK/fi8Lr6Oih62aiRl5jtvp0Dvxi6MDMAfdMse138IMrzo6ne+ORaRAjen
 I5tw==
X-Gm-Message-State: AOAM530RhL6OOe3TWmzeecQQQ3I9gTpy6CNFBSl4f3tBiO7Z8jhUdTE5
 XaPBT4KOeelDGNVgAHddSzfq1WlBUqs6KqP13Oc=
X-Google-Smtp-Source: ABdhPJwEsbovqQK85RUcIpS0MTjhZPArioISp1H1MdQ9JFAvyZEFbViqCy8sUTf9tPqHnYQwfnHW7/SDmIFW30usW6I=
X-Received: by 2002:a1c:de07:: with SMTP id v7mr1737393wmg.56.1594326763261;
 Thu, 09 Jul 2020 13:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200702094702.8223-1-evan.quan@amd.com>
 <20200702094702.8223-4-evan.quan@amd.com>
In-Reply-To: <20200702094702.8223-4-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2020 16:32:31 -0400
Message-ID: <CADnq5_NvLz_0PbDe+GEWSv7J5a0zyLmGc9EYy7zPriyaAS2dbQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: put dpm frequency setting common
 code in smu_v11_0.c
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

On Thu, Jul 2, 2020 at 5:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> As designed the common code shared among all smu v11 ASCIs go to
> smu_v11_0.c. This helps to maintain clear code layers.
>
> Change-Id: I1f848eba0b6b56f8b5ef6f0888ee6955ba1d2070
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 65 --------------
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  6 --
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 14 ++++
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 38 +++++----
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 18 ++--
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 84 +++++++++++++++++++
>  6 files changed, 129 insertions(+), 96 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 95685bb9582a..6839faaab611 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -284,71 +284,6 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
>         return ret;
>  }
>
> -int smu_get_dpm_freq_by_index(struct smu_context *smu, enum smu_clk_type clk_type,
> -                             uint16_t level, uint32_t *value)
> -{
> -       int ret = 0, clk_id = 0;
> -       uint32_t param;
> -
> -       if (!value)
> -               return -EINVAL;
> -
> -       if (!smu_clk_dpm_is_enabled(smu, clk_type))
> -               return 0;
> -
> -       clk_id = smu_clk_get_index(smu, clk_type);
> -       if (clk_id < 0)
> -               return clk_id;
> -
> -       param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
> -
> -       ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmFreqByIndex,
> -                                         param, value);
> -       if (ret)
> -               return ret;
> -
> -       /* BIT31:  0 - Fine grained DPM, 1 - Dicrete DPM
> -        * now, we un-support it */
> -       *value = *value & 0x7fffffff;
> -
> -       return ret;
> -}
> -
> -int smu_get_dpm_level_count(struct smu_context *smu, enum smu_clk_type clk_type,
> -                           uint32_t *value)
> -{
> -       return smu_get_dpm_freq_by_index(smu, clk_type, 0xff, value);
> -}
> -
> -int smu_get_dpm_level_range(struct smu_context *smu, enum smu_clk_type clk_type,
> -                           uint32_t *min_value, uint32_t *max_value)
> -{
> -       int ret = 0;
> -       uint32_t level_count = 0;
> -
> -       if (!min_value && !max_value)
> -               return -EINVAL;
> -
> -       if (min_value) {
> -               /* by default, level 0 clock value as min value */
> -               ret = smu_get_dpm_freq_by_index(smu, clk_type, 0, min_value);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       if (max_value) {
> -               ret = smu_get_dpm_level_count(smu, clk_type, &level_count);
> -               if (ret)
> -                       return ret;
> -
> -               ret = smu_get_dpm_freq_by_index(smu, clk_type, level_count - 1, max_value);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return ret;
> -}
> -
>  bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_type clk_type)
>  {
>         enum smu_feature_mask feature_id = 0;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index ae16cc4c2b2d..66912884f093 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -715,16 +715,10 @@ int smu_switch_power_profile(struct smu_context *smu,
>                              enum PP_SMC_POWER_PROFILE type,
>                              bool en);
>  int smu_get_smc_version(struct smu_context *smu, uint32_t *if_version, uint32_t *smu_version);
> -int smu_get_dpm_freq_by_index(struct smu_context *smu, enum smu_clk_type clk_type,
> -                             uint16_t level, uint32_t *value);
> -int smu_get_dpm_level_count(struct smu_context *smu, enum smu_clk_type clk_type,
> -                           uint32_t *value);
>  int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
>                            uint32_t *min, uint32_t *max);
>  int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
>                             uint32_t min, uint32_t max);
> -int smu_get_dpm_level_range(struct smu_context *smu, enum smu_clk_type clk_type,
> -                           uint32_t *min_value, uint32_t *max_value);
>  enum amd_dpm_forced_level smu_get_performance_level(struct smu_context *smu);
>  int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
>  int smu_set_display_count(struct smu_context *smu, uint32_t count);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 070f1f0f9926..3d746b75396e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -265,4 +265,18 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
>  int smu_v11_0_set_power_source(struct smu_context *smu,
>                                enum smu_power_src_type power_src);
>
> +int smu_v11_0_get_dpm_freq_by_index(struct smu_context *smu,
> +                                   enum smu_clk_type clk_type,
> +                                   uint16_t level,
> +                                   uint32_t *value);
> +
> +int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
> +                                 enum smu_clk_type clk_type,
> +                                 uint32_t *value);
> +
> +int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
> +                                 enum smu_clk_type clk_type,
> +                                 uint32_t *min_value,
> +                                 uint32_t *max_value);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index d88b2f200d94..d96e8334b5e2 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -881,13 +881,13 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>                 if (ret)
>                         return size;
>
> -               ret = smu_get_dpm_level_count(smu, clk_type, &count);
> +               ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
>                 if (ret)
>                         return size;
>
>                 if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
>                         for (i = 0; i < count; i++) {
> -                               ret = smu_get_dpm_freq_by_index(smu, clk_type, i, &value);
> +                               ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
>                                 if (ret)
>                                         return size;
>
> @@ -895,10 +895,10 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>                                                 cur_value == value ? "*" : "");
>                         }
>                 } else {
> -                       ret = smu_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
> +                       ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
>                         if (ret)
>                                 return size;
> -                       ret = smu_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
> +                       ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
>                         if (ret)
>                                 return size;
>
> @@ -1058,11 +1058,11 @@ static int navi10_force_clk_levels(struct smu_context *smu,
>                         soft_min_level = (soft_min_level >= 1 ? 1 : 0);
>                 }
>
> -               ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
> +               ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
>                 if (ret)
>                         return size;
>
> -               ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
> +               ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
>                 if (ret)
>                         return size;
>
> @@ -1110,7 +1110,7 @@ static int navi10_get_clock_by_type_with_latency(struct smu_context *smu,
>         case SMU_SOCCLK:
>         case SMU_MCLK:
>         case SMU_UCLK:
> -               ret = smu_get_dpm_level_count(smu, clk_type, &level_count);
> +               ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &level_count);
>                 if (ret)
>                         return ret;
>
> @@ -1118,7 +1118,7 @@ static int navi10_get_clock_by_type_with_latency(struct smu_context *smu,
>                 clocks->num_levels = level_count;
>
>                 for (i = 0; i < level_count; i++) {
> -                       ret = smu_get_dpm_freq_by_index(smu, clk_type, i, &freq);
> +                       ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &freq);
>                         if (ret)
>                                 return ret;
>
> @@ -1493,21 +1493,21 @@ static int navi10_get_profiling_clk_mask(struct smu_context *smu,
>                         *mclk_mask = 0;
>         } else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
>                 if(sclk_mask) {
> -                       ret = smu_get_dpm_level_count(smu, SMU_SCLK, &level_count);
> +                       ret = smu_v11_0_get_dpm_level_count(smu, SMU_SCLK, &level_count);
>                         if (ret)
>                                 return ret;
>                         *sclk_mask = level_count - 1;
>                 }
>
>                 if(mclk_mask) {
> -                       ret = smu_get_dpm_level_count(smu, SMU_MCLK, &level_count);
> +                       ret = smu_v11_0_get_dpm_level_count(smu, SMU_MCLK, &level_count);
>                         if (ret)
>                                 return ret;
>                         *mclk_mask = level_count - 1;
>                 }
>
>                 if(soc_mask) {
> -                       ret = smu_get_dpm_level_count(smu, SMU_SOCCLK, &level_count);
> +                       ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &level_count);
>                         if (ret)
>                                 return ret;
>                         *soc_mask = level_count - 1;
> @@ -1831,12 +1831,18 @@ static int navi10_set_peak_performance_level(struct smu_context *smu)
>                 sclk_freq = NAVI12_UMD_PSTATE_PEAK_GFXCLK;
>                 break;
>         default:
> -               ret = smu_get_dpm_level_range(smu, SMU_SCLK, NULL, &sclk_freq);
> +               ret = smu_v11_0_get_dpm_level_range(smu,
> +                                                   SMU_SCLK,
> +                                                   NULL,
> +                                                   &sclk_freq);
>                 if (ret)
>                         return ret;
>         }
>
> -       ret = smu_get_dpm_level_range(smu, SMU_UCLK, NULL, &uclk_freq);
> +       ret = smu_v11_0_get_dpm_level_range(smu,
> +                                           SMU_UCLK,
> +                                           NULL,
> +                                           &uclk_freq);
>         if (ret)
>                 return ret;
>
> @@ -2331,15 +2337,15 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
>         if (smu_version < 0x2A3200)
>                 return 0;
>
> -       ret = smu_get_dpm_level_count(smu, SMU_UCLK, &uclk_count);
> +       ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &uclk_count);
>         if (ret)
>                 return ret;
>
> -       ret = smu_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)0, &uclk_min);
> +       ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)0, &uclk_min);
>         if (ret)
>                 return ret;
>
> -       ret = smu_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)(uclk_count - 1), &uclk_max);
> +       ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, (uint16_t)(uclk_count - 1), &uclk_max);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index dfe192ce33ab..f2bbe56798d7 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -789,13 +789,13 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>                 if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
>                         amdgpu_gfx_off_ctrl(adev, false);
>
> -               ret = smu_get_dpm_level_count(smu, clk_type, &count);
> +               ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
>                 if (ret)
>                         goto print_clk_out;
>
>                 if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
>                         for (i = 0; i < count; i++) {
> -                               ret = smu_get_dpm_freq_by_index(smu, clk_type, i, &value);
> +                               ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
>                                 if (ret)
>                                         goto print_clk_out;
>
> @@ -803,10 +803,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>                                                 cur_value == value ? "*" : "");
>                         }
>                 } else {
> -                       ret = smu_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
> +                       ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
>                         if (ret)
>                                 goto print_clk_out;
> -                       ret = smu_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
> +                       ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
>                         if (ret)
>                                 goto print_clk_out;
>
> @@ -901,11 +901,11 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
>                         soft_min_level = (soft_min_level >= 1 ? 1 : 0);
>                 }
>
> -               ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
> +               ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
>                 if (ret)
>                         goto forec_level_out;
>
> -               ret = smu_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
> +               ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
>                 if (ret)
>                         goto forec_level_out;
>
> @@ -1312,7 +1312,7 @@ static int sienna_cichlid_get_profiling_clk_mask(struct smu_context *smu,
>         } else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
>                 if(sclk_mask) {
>                         amdgpu_gfx_off_ctrl(adev, false);
> -                       ret = smu_get_dpm_level_count(smu, SMU_SCLK, &level_count);
> +                       ret = smu_v11_0_get_dpm_level_count(smu, SMU_SCLK, &level_count);
>                         amdgpu_gfx_off_ctrl(adev, true);
>                         if (ret)
>                                 return ret;
> @@ -1320,14 +1320,14 @@ static int sienna_cichlid_get_profiling_clk_mask(struct smu_context *smu,
>                 }
>
>                 if(mclk_mask) {
> -                       ret = smu_get_dpm_level_count(smu, SMU_MCLK, &level_count);
> +                       ret = smu_v11_0_get_dpm_level_count(smu, SMU_MCLK, &level_count);
>                         if (ret)
>                                 return ret;
>                         *mclk_mask = level_count - 1;
>                 }
>
>                 if(soc_mask) {
> -                       ret = smu_get_dpm_level_count(smu, SMU_SOCCLK, &level_count);
> +                       ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &level_count);
>                         if (ret)
>                                 return ret;
>                         *soc_mask = level_count - 1;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 6c8b4230cbe2..03be59492af1 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1905,3 +1905,87 @@ int smu_v11_0_set_power_source(struct smu_context *smu,
>                                         NULL);
>  }
>
> +int smu_v11_0_get_dpm_freq_by_index(struct smu_context *smu,
> +                                   enum smu_clk_type clk_type,
> +                                   uint16_t level,
> +                                   uint32_t *value)
> +{
> +       int ret = 0, clk_id = 0;
> +       uint32_t param;
> +
> +       if (!value)
> +               return -EINVAL;
> +
> +       if (!smu_clk_dpm_is_enabled(smu, clk_type))
> +               return 0;
> +
> +       clk_id = smu_clk_get_index(smu, clk_type);
> +       if (clk_id < 0)
> +               return clk_id;
> +
> +       param = (uint32_t)(((clk_id & 0xffff) << 16) | (level & 0xffff));
> +
> +       ret = smu_send_smc_msg_with_param(smu,
> +                                         SMU_MSG_GetDpmFreqByIndex,
> +                                         param,
> +                                         value);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * BIT31:  0 - Fine grained DPM, 1 - Dicrete DPM
> +        * now, we un-support it
> +        */
> +       *value = *value & 0x7fffffff;
> +
> +       return ret;
> +}
> +
> +int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
> +                                 enum smu_clk_type clk_type,
> +                                 uint32_t *value)
> +{
> +       return smu_v11_0_get_dpm_freq_by_index(smu,
> +                                              clk_type,
> +                                              0xff,
> +                                              value);
> +}
> +
> +int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
> +                                 enum smu_clk_type clk_type,
> +                                 uint32_t *min_value,
> +                                 uint32_t *max_value)
> +{
> +       uint32_t level_count = 0;
> +       int ret = 0;
> +
> +       if (!min_value && !max_value)
> +               return -EINVAL;
> +
> +       if (min_value) {
> +               /* by default, level 0 clock value as min value */
> +               ret = smu_v11_0_get_dpm_freq_by_index(smu,
> +                                                     clk_type,
> +                                                     0,
> +                                                     min_value);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (max_value) {
> +               ret = smu_v11_0_get_dpm_level_count(smu,
> +                                                   clk_type,
> +                                                   &level_count);
> +               if (ret)
> +                       return ret;
> +
> +               ret = smu_v11_0_get_dpm_freq_by_index(smu,
> +                                                     clk_type,
> +                                                     level_count - 1,
> +                                                     max_value);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return ret;
> +}
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
