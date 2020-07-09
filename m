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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F8DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E608620775
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOPrzR5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E608620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4356EB34;
	Thu,  9 Jul 2020 20:45:34 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B75C66EB34
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 20:45:33 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id q15so3439296wmj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0DhaYXluPRBPVa8Jc0DBa+RKFrv1Kp/L94DWa8UX36I=;
 b=tOPrzR5NuVv1eAdiUrju4Uxk6wrVzbPyxBMOIldWLmSyV9VDOC+gA2Q5zlIWaXVmby
 YTBrjjc0KjCLKmr3bb24P0jb+hUU1il+JABxIJLUpkeoQ6vHGmgc2yQ5k25/QROyoejj
 WlU3h5rFM0vBuoaPG+QlM3cyx2OOKyF4uEklS75rL91lOdBVKaRIVpVABRmrki9/zPA1
 Kd1uSCV1WNyXJfxnn0KXcgbpKq+KOZB2RiOmgkvUCHXlo1Fvs4tBRPSOAoxevNfFGSrM
 Mip8lWysNMpLa7Mv0Ngdob6cnXZOlOB5rDByLpk+gV2A8vZHZHJo9qOmtiT/1XXNWO1S
 oFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0DhaYXluPRBPVa8Jc0DBa+RKFrv1Kp/L94DWa8UX36I=;
 b=XaZMAuuUU8lPd7FRmj2pHvoDGRmexmtT+FRXUkHdVXDojP89R5ya+1Iefm1UdBEXSF
 X6QDkM6wB/I5Ojlf30Hn8WwP1O5CD/2HouDAtabWiPnnK2cWhF+5/jwbO3FObtSqRk3F
 vyUaugopj2AgAuG8iVnoSad11RcL64Hale6IEoKqtQTBcEkZ+iCno7mvg9JyD5oP+n9+
 vm85We1u7hwZxhqTdZS82TdkpVS17pTnFhe8+c1uWPtLZz1qWb6Kjmu3p4LzPl6TLZl4
 Zw28bUd2RpVrBpYQROCOxLAonxfqYBruLvwVJu0OQ6HoEzOueUJnCl9ZfUbRYjsQPx6b
 mAig==
X-Gm-Message-State: AOAM530is4BA8NPJvEIVxWV4gbZ8YSdxgIwLEmmBWuVKwfRgkH7wS/Za
 9ZKHV65s1AUyG0gSySC9AnxoyG4kKI+fOvV/yU91Wg==
X-Google-Smtp-Source: ABdhPJwzqHO+bXD0f819cA74VFRiDKLUfrORIqHDd8avg5EhqIB5rZsoyx1DiAvDHc5Rsb+ZimU8CqRiOOjacdxFXTI=
X-Received: by 2002:a1c:3954:: with SMTP id g81mr1690520wma.73.1594327532370; 
 Thu, 09 Jul 2020 13:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200703083303.478-1-evan.quan@amd.com>
 <20200703083303.478-11-evan.quan@amd.com>
In-Reply-To: <20200703083303.478-11-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2020 16:45:21 -0400
Message-ID: <CADnq5_NckTisVjtGTeJVwqVN-gFFt+BfZRHmuNBx0-jKmooajA@mail.gmail.com>
Subject: Re: [PATCH 11/14] drm/amd/powerplay: drop Sienna Cichlid specific
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

On Fri, Jul 3, 2020 at 4:34 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Use the common smu_v11_0_set_soft_freq_limited_range.
>
> Change-Id: I9f8772880b324ce9e741291751bb1b8ff4c36ea3
> Signed-off-by: Evan Quan <evan.quan@amd.com>
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
> index 8fbfa0562007..1b357e349d1e 100644
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
> index c2564df304f7..1ed5ac946c05 100644
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

Is this specific to Sienna cichlid or do we need to check this on
other asics which support gfxoff as well?  Might be cleaner to have
some flag that we check (smu->disable_gfxoff_for_soft_limits or
something like that.) rather than adding all asic types in the code.

Alex

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
