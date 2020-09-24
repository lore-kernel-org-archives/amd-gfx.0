Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CB4C4363D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 13:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458DC21D24
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 13:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm1cippp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458DC21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F3B6EB07;
	Thu, 24 Sep 2020 13:00:55 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1338B6EB07
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 13:00:55 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id g4so3714982wrs.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CvU+hrmAsOXjxn0qFSsX+//++o9N7QwQpguT7NPlHPs=;
 b=qm1cippp5/qLTr/HEEdE4ty2GdbiQwlbA8LqD3GBYFwX95Oasc9CkwmLKwZmVbEL6B
 +4h/4ZnZwIxY/tsjJCXF6ZbMXAq4u5civUeBLfFmN8f5vEMOkdCRzPi+DwxkI4GGpCOp
 w/FfbmZbDXIejDxZZDqQm57HYGDJgHH+NpzIdrj9K+5aMj8goKrl7npGNPPC9PbTIk+M
 m75U80Bs49G3v0UFnmb232gPQyfHCFXplDS5rxquvWl9Wn8Di0FXN47zeQUgIjFvNb/K
 J6LwwW+w1RtH1gHQPtaxIc5dmE+8Z+8u0Nk2TJJDcj6Gy1hnLxsaK21+BHZKAjwh2XvJ
 /zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CvU+hrmAsOXjxn0qFSsX+//++o9N7QwQpguT7NPlHPs=;
 b=PG+yJmMt79nmKm9bJ/JZa34ByrgjkQI+c/rTF/xpPYDyxu0mG1o/f24DIlUOnhjcZk
 MeQ9q6Dx9FE8LaMbuQNZIjp8artH1mE/A2qnJHW0UfcuXNDFY7lT5oP8bVv1Q75UJV3y
 Nbe+ShJg2edO4s4fpiIAnaWnzZu6qebNl731vD5XbH7dBZYt0zbUKoXtbvlq4t8ibfig
 1kn+qjYw/1GJYAVGkNPKRCW7UtldUtD62RNtse9VTwKh/dQx/J3tIQZuzq/bPF+h7aJe
 6xXU1IJiOp/FUFC2d2t1rVjKCEy3Dyhxftd7U6p2Q0ngUL/otmXetemcfGH+IFDW7yAg
 ib1g==
X-Gm-Message-State: AOAM531nZFpKGMtvb2XICUVdJYtn7AZzk6hjuilMVDSuqflSWdZkgCVM
 zrVzq7mLQpWcQ1SsRvuJNYAtdGTxkwasglrHo4o2AujL
X-Google-Smtp-Source: ABdhPJwSjq+PJ+djv1YSUJtsumWjiq9aOCmNwYmV+hHTUWSWeO0cWQQ35Y6KnY8czGZ5/+bybziRITjIauRCC6y8JMw=
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr4963190wro.362.1600952453692; 
 Thu, 24 Sep 2020 06:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200924101012.22845-1-evan.quan@amd.com>
In-Reply-To: <20200924101012.22845-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2020 09:00:42 -0400
Message-ID: <CADnq5_Nw6mdj38FVqg2Y67_eN04YSm1mSsS04RC09v7BHWNiWA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K
 monitors
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

On Thu, Sep 24, 2020 at 6:10 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Revert the guilty change introduced by the commit below:
> drm/amd/pm: postpone SOCCLK/UCLK enablement after DAL initialization(V2)
>
> Change-Id: I0cab619ffdf0f83b14ba5d2907e1b9c02a984e2f
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Won't this effectively disable the potential fix for multiple monitors
at boot time?

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43 ++++++-------------
>  1 file changed, 12 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 1695b36dc23c..be44cb941e73 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -316,6 +316,18 @@ navi10_get_allowed_feature_mask(struct smu_context *smu,
>         if (smu->dc_controlled_by_gpio)
>                 *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
>
> +       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
> +
> +       /* DPM UCLK enablement should be skipped for navi10 A0 secure board */
> +       if (!(is_asic_secure(smu) &&
> +            (adev->asic_type == CHIP_NAVI10) &&
> +            (adev->rev_id == 0)) &&
> +           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
> +                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> +                               | FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
> +
>         /* DS SOCCLK enablement should be skipped for navi10 A0 secure board */
>         if (is_asic_secure(smu) &&
>             (adev->asic_type == CHIP_NAVI10) &&
> @@ -2629,43 +2641,12 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
>
>  static int navi10_post_smu_init(struct smu_context *smu)
>  {
> -       struct smu_feature *feature = &smu->smu_feature;
>         struct amdgpu_device *adev = smu->adev;
> -       uint64_t feature_mask = 0;
>         int ret = 0;
>
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       /* For Naiv1x, enable these features only after DAL initialization */
> -       if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
> -               feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
> -
> -       /* DPM UCLK enablement should be skipped for navi10 A0 secure board */
> -       if (!(is_asic_secure(smu) &&
> -            (adev->asic_type == CHIP_NAVI10) &&
> -            (adev->rev_id == 0)) &&
> -           (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
> -               feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
> -                               | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> -                               | FEATURE_MASK(FEATURE_MEM_MVDD_SCALING_BIT);
> -
> -       if (!feature_mask)
> -               return 0;
> -
> -       bitmap_or(feature->allowed,
> -                 feature->allowed,
> -                 (unsigned long *)(&feature_mask),
> -                 SMU_FEATURE_MAX);
> -
> -       ret = smu_cmn_feature_update_enable_state(smu,
> -                                                 feature_mask,
> -                                                 true);
> -       if (ret) {
> -               dev_err(adev->dev, "Failed to post uclk/socclk dpm enablement!\n");
> -               return ret;
> -       }
> -
>         ret = navi10_run_umc_cdr_workaround(smu);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
