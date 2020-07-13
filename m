Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F221CC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B992D2065F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9WNwiwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B992D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832C46E397;
	Mon, 13 Jul 2020 14:53:33 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9D26E397
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 14:53:32 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id k6so16879471wrn.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SOdUdT+jkqXpw6WPd0OvsXrVl5HuCwTvqdn+2TD0/XY=;
 b=U9WNwiwjBvRWUc3r0GMU02IYJnoG5LrUpDIA/IuscN7YTMqfGuztxnJcaqHDjmpxSy
 oBGa4ylpAz3gZerSS0BneYObx2hXXb4Hy0mpV59LA8FJ2SZ886xwcOrdes3CaNfQgEyA
 CmMoLWJhQ2/Tffe60WqWLOFNcj2sB+htJbSV5+Y1j6YKatzXC+lJb5+dRodBIDFcC5qE
 qbuYHNFp3oGpp1N0PtmnTych/CxP7F3N/rb4RweVqgJGyCGdE2iqVM7gvxvB896zyic4
 PKOh39+c4yqBKo2Ph+F75CYBbKROwGedV+ryNg5Uj32eVBbmZexyR6PjTQRihwcJyNMa
 MSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SOdUdT+jkqXpw6WPd0OvsXrVl5HuCwTvqdn+2TD0/XY=;
 b=LUkGOIl8dBR81IRgEwFNU/9sLlWTfAu0+HxAxpHHooM5gwp1V6i3iNVmAlsP1gUUD6
 YCgU5uLUs14w1pF/EX2dRTc7492RIybZuSoixxvwmZl8cq5AWfgRLsGhlVx46sYXm7K9
 6hjH6i+bRukHnFrWsiZEd/YowRPgpfy3VqspAUoahXRhqHgMkE8nTH3l6/MG2AnWsM2y
 h5o24Ckfxkqq41PPAPMY35ziL7irM8pvvcKOLQ76zHsnJ8MOXD37l8GiU07TeFq6ePvN
 /8ooBZXyezD+eHsfojcdunPgKhV4sChUuFoasmXu+X1kFgkjQa8+GBs7Yk09uroTB66s
 Rw9A==
X-Gm-Message-State: AOAM533KX8ffltMf4LV7e7YoArv43wK7Kfo/acQlrKhPDKDd6tDfhj42
 BglFuocNyOV99rtiwccN4ARAacFO9r4RxWpf/Ps=
X-Google-Smtp-Source: ABdhPJwGNAyMZxyuF3nIK1OmBRPdVq7ciyeYZOe3TA3wVMMwXxux9rQYW1AwGuyICjipmyHA1Prn+XScmitpWW5hYlE=
X-Received: by 2002:a5d:5549:: with SMTP id g9mr84875203wrw.419.1594652011424; 
 Mon, 13 Jul 2020 07:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200710044746.23538-1-evan.quan@amd.com>
 <20200710044746.23538-12-evan.quan@amd.com>
In-Reply-To: <20200710044746.23538-12-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2020 10:53:20 -0400
Message-ID: <CADnq5_MuK_-ycTiWcyLR=VJ2Xqvrkdwp4-ozOR4dZS_eFMvxCg@mail.gmail.com>
Subject: Re: [PATCH 12/16] drm/amd/powerplay: drop Sienna Cichlid specific
 set_soft_freq_limited_range
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

On Fri, Jul 10, 2020 at 12:48 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Use the common smu_v11_0_set_soft_freq_limited_range.
>
> Change-Id: I9f8772880b324ce9e741291751bb1b8ff4c36ea3
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 20 ++-----------------
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  1 -
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 +++++++++++++++----
>  3 files changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 27f77bde184f..141944df97b0 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -1046,22 +1046,6 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>         return size;
>  }
>
> -int sienna_cichlid_set_soft_freq_limited_range(struct smu_context *smu,
> -                                     enum smu_clk_type clk_type,
> -                                     uint32_t min, uint32_t max)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       int ret;
> -
> -       if (clk_type == SMU_GFXCLK)
> -               amdgpu_gfx_off_ctrl(adev, false);
> -       ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min, max);
> -       if (clk_type == SMU_GFXCLK)
> -               amdgpu_gfx_off_ctrl(adev, true);
> -
> -       return ret;
> -}
> -
>  static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
>                                    enum smu_clk_type clk_type, uint32_t mask)
>  {
> @@ -1097,7 +1081,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context *smu,
>                 if (ret)
>                         goto forec_level_out;
>
> -               ret = sienna_cichlid_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
> +               ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
>                 if (ret)
>                         goto forec_level_out;
>                 break;
> @@ -2566,7 +2550,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .baco_enter = smu_v11_0_baco_enter,
>         .baco_exit = smu_v11_0_baco_exit,
>         .get_dpm_ultimate_freq = sienna_cichlid_get_dpm_ultimate_freq,
> -       .set_soft_freq_limited_range = sienna_cichlid_set_soft_freq_limited_range,
> +       .set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
>         .override_pcie_parameters = smu_v11_0_override_pcie_parameters,
>         .set_thermal_range = sienna_cichlid_set_thermal_range,
>  };
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 1c808ffe3ab1..91d3965bbe80 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -93,7 +93,6 @@
>  #define smu_asic_set_performance_level(smu, level)                     smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
>  #define smu_dump_pptable(smu)                                          smu_ppt_funcs(dump_pptable, 0, smu)
>  #define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)                smu_ppt_funcs(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, freq)
> -#define smu_set_soft_freq_limited_range(smu, clk_type, min, max)       smu_ppt_funcs(set_soft_freq_limited_range, -EINVAL, smu, clk_type, min, max)
>  #define smu_override_pcie_parameters(smu)                              smu_ppt_funcs(override_pcie_parameters, 0, smu)
>  #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)  smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
>  #define smu_set_thermal_range(smu, range)                              smu_ppt_funcs(set_thermal_range, 0, smu, range)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index f96ff062eb64..c2779d0b51f6 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1745,9 +1745,12 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type c
>         return ret;
>  }
>
> -int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
> -                           uint32_t min, uint32_t max)
> +int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu,
> +                                         enum smu_clk_type clk_type,
> +                                         uint32_t min,
> +                                         uint32_t max)
>  {
> +       struct amdgpu_device *adev = smu->adev;
>         int ret = 0, clk_id = 0;
>         uint32_t param;
>
> @@ -1755,12 +1758,16 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
>         if (clk_id < 0)
>                 return clk_id;
>
> +       if (clk_type == SMU_GFXCLK &&
> +           adev->asic_type == CHIP_SIENNA_CICHLID)
> +               amdgpu_gfx_off_ctrl(adev, false);
> +
>         if (max > 0) {
>                 param = (uint32_t)((clk_id << 16) | (max & 0xffff));
>                 ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
>                                                   param, NULL);
>                 if (ret)
> -                       return ret;
> +                       goto out;
>         }
>
>         if (min > 0) {
> @@ -1768,9 +1775,14 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
>                 ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
>                                                   param, NULL);
>                 if (ret)
> -                       return ret;
> +                       goto out;
>         }
>
> +out:
> +       if (clk_type == SMU_GFXCLK &&
> +           adev->asic_type == CHIP_SIENNA_CICHLID)
> +               amdgpu_gfx_off_ctrl(adev, true);
> +
>         return ret;
>  }
>
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
