Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5A5C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16DD2075B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiT0zAB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16DD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6317F6E5C5;
	Thu,  4 Jun 2020 20:52:03 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86F16E5C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 20:52:01 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id q11so7586479wrp.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MLtBEiEtSXZAJu8Z4Zt7gQM/l+rgt71rY8ZIYJrxZwY=;
 b=DiT0zAB9p04RYV8waE6LwZ2v2rnq65IX759bBXuocaisVseXy9RSofpxb9v7Ecr0bd
 +WoJI0ltRUT6ilJIuA0mgtBongxDds5GSLInAAMM5YxUo/vpJvPDvoD4hr1iWw8Frjzr
 jJ5Wfoq0Zt4X5Z04iVuyu7YarT/ayeyQrWuh73z4NI1m2q2GUDfC0H18wfVa62ysET5T
 G+MwjWeXHUDogltA7T51xTGTxgTR4gt9HqkLj5sSQtURjmVtVuZvvZie0haEWdOLgI8L
 T6t+hXodnDmm2WeFi3sbgVsXLPSQkO0RCz7nN4ZJ8RuShNpmVjdQA8Pi0PwUKAhwoDsq
 FIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MLtBEiEtSXZAJu8Z4Zt7gQM/l+rgt71rY8ZIYJrxZwY=;
 b=lngnMENU7NxWKKOB098BF4h7RSDQSzyBS1Ne9KNsfa6AgilTiPjauZj3WedJcbkMSw
 vZE4toNRlraOH1OZBmQ7AtkxcTpQx4Za+LUa2r54C2CNRyqTJvKCBZflmBIGyG6GZVWR
 tG6f0umrjA1viM/z4Rans3rGgyEdW//P9xc7zz7Xv3KuEFx2Lw48GLM7JuPpkFo3Gl3+
 HipC92fhK960WuinJTZMlWm1UYHs8bpGoNqeMH9BAAMokB7OIhfehyIOAI9cyjTrNBc+
 hd/OY7x/HaqJlB5AxKZcpQxjSpPhc6mf4EE1PizMrrU7+7jDH8G7neO7ia31d4KIOrX+
 WIAA==
X-Gm-Message-State: AOAM5321ImDf/4uGH6grP4FFxv4akzKLThVyg9QiKq1PvdcsSDIEtltj
 IPdYmXhxDirXz3BGP4uvwMp8cvovqre4fVgTqNc=
X-Google-Smtp-Source: ABdhPJz/mTCshG5TQtNR0O/sHn9knROorQ9pjOmNLZR3K1PhhDVJfwrSXrI5uCmQytfn+4wZcjXhQQlHVmI35aWI0js=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr6449705wrs.374.1591303920522; 
 Thu, 04 Jun 2020 13:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-3-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 16:51:49 -0400
Message-ID: <CADnq5_MaspzvKrTKbtNfUy2smzJFkeCBdeVaxkEaZUQzqahL7w@mail.gmail.com>
Subject: Re: [PATCH 03/16] drm/amd/powerplay: implement a common API for dpms
 disablement
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

On Thu, Jun 4, 2020 at 12:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> So that code can be shared between .hw_fini and .suspend.
>
> Change-Id: I4a0eeb7cdecbf5b24fac3d0fe1d8fcb1ca9f0b0a
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 178 +++++++++------------
>  1 file changed, 77 insertions(+), 101 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index bd0fe71dffde..87205abb1e8b 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1318,9 +1318,77 @@ static int smu_hw_init(void *handle)
>         return ret;
>  }
>
> -static int smu_stop_dpms(struct smu_context *smu)
> +static int smu_disable_dpms(struct smu_context *smu)
>  {
> -       return smu_system_features_control(smu, false);
> +       struct amdgpu_device *adev = smu->adev;
> +       int ret = 0;
> +       bool use_baco = !smu->is_apu &&
> +               ((adev->in_gpu_reset &&
> +                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> +                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
> +
> +       /*
> +        * For custom pptable uploading, skip the DPM features
> +        * disable process on Navi1x ASICs.
> +        *   - As the gfx related features are under control of
> +        *     RLC on those ASICs. RLC reinitialization will be
> +        *     needed to reenable them. That will cost much more
> +        *     efforts.
> +        *
> +        *   - SMU firmware can handle the DPM reenablement
> +        *     properly.
> +        */
> +       if (smu->uploading_custom_pp_table &&
> +           (adev->asic_type >= CHIP_NAVI10) &&
> +           (adev->asic_type <= CHIP_NAVI12))
> +               return 0;
> +
> +       /*
> +        * For Sienna_Cichlid, PMFW will handle the features disablement properly
> +        * on BACO in. Driver involvement is unnecessary.
> +        */
> +       if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
> +            use_baco)
> +               return 0;
> +
> +       /*
> +        * Disable all enabled SMU features.
> +        * This should be handled in SMU FW, as a backup
> +        * driver can issue call to SMU FW until sequence
> +        * in SMU FW is operational.
> +        */
> +       ret = smu_system_features_control(smu, false);
> +       if (ret) {
> +               pr_err("Failed to disable smu features.\n");
> +               return ret;
> +       }
> +
> +       /*
> +        * For baco, need to leave BACO feature enabled
> +        *
> +        * Correct the way for checking whether SMU_FEATURE_BACO_BIT
> +        * is supported.
> +        *
> +        * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
> +        * always return false as the 'smu_system_features_control(smu, false)'
> +        * was just issued above which disabled all SMU features.
> +        *
> +        * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
> +        * now for the checking.
> +        */
> +       if (use_baco && (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0)) {
> +               ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
> +               if (ret) {
> +                       pr_warn("set BACO feature enabled failed, return %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       if (adev->asic_type >= CHIP_NAVI10 &&
> +           adev->gfx.rlc.funcs->stop)
> +               adev->gfx.rlc.funcs->stop(adev);
> +
> +       return ret;
>  }
>
>  static int smu_hw_fini(void *handle)
> @@ -1352,25 +1420,10 @@ static int smu_hw_fini(void *handle)
>                 return ret;
>         }
>
> -       /*
> -        * For custom pptable uploading, skip the DPM features
> -        * disable process on Navi1x ASICs.
> -        *   - As the gfx related features are under control of
> -        *     RLC on those ASICs. RLC reinitialization will be
> -        *     needed to reenable them. That will cost much more
> -        *     efforts.
> -        *
> -        *   - SMU firmware can handle the DPM reenablement
> -        *     properly.
> -        */
> -       if (!smu->uploading_custom_pp_table ||
> -                       !((adev->asic_type >= CHIP_NAVI10) &&
> -                               (adev->asic_type <= CHIP_NAVI12))) {
> -               ret = smu_stop_dpms(smu);
> -               if (ret) {
> -                       pr_warn("Fail to stop Dpms!\n");
> -                       return ret;
> -               }
> +       ret = smu_disable_dpms(smu);
> +       if (ret) {
> +               pr_warn("Fail to stop Dpms!\n");
> +               return ret;
>         }
>
>         kfree(table_context->driver_pptable);
> @@ -1409,78 +1462,11 @@ int smu_reset(struct smu_context *smu)
>         return ret;
>  }
>
> -static int smu_disable_dpm(struct smu_context *smu)
> -{
> -       struct amdgpu_device *adev = smu->adev;
> -       uint32_t smu_version;
> -       int ret = 0;
> -       bool use_baco = !smu->is_apu &&
> -               ((adev->in_gpu_reset &&
> -                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> -                ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
> -
> -       ret = smu_get_smc_version(smu, NULL, &smu_version);
> -       if (ret) {
> -               pr_err("Failed to get smu version.\n");
> -               return ret;
> -       }
> -
> -       /*
> -        * Disable all enabled SMU features.
> -        * This should be handled in SMU FW, as a backup
> -        * driver can issue call to SMU FW until sequence
> -        * in SMU FW is operational.
> -        */
> -       ret = smu_system_features_control(smu, false);
> -       if (ret) {
> -               pr_err("Failed to disable smu features.\n");
> -               return ret;
> -       }
> -
> -       /*
> -        * Arcturus does not have BACO bit in disable feature mask.
> -        * Enablement of BACO bit on Arcturus should be skipped.
> -        */
> -       if (adev->asic_type == CHIP_ARCTURUS) {
> -               if (use_baco && (smu_version > 0x360e00))
> -                       return 0;
> -       }
> -
> -       /* For baco, need to leave BACO feature enabled */
> -       if (use_baco) {
> -               /*
> -                * Correct the way for checking whether SMU_FEATURE_BACO_BIT
> -                * is supported.
> -                *
> -                * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
> -                * always return false as the 'smu_system_features_control(smu, false)'
> -                * was just issued above which disabled all SMU features.
> -                *
> -                * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
> -                * now for the checking.
> -                */
> -               if (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0) {
> -                       ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
> -                       if (ret) {
> -                               pr_warn("set BACO feature enabled failed, return %d\n", ret);
> -                               return ret;
> -                       }
> -               }
> -       }
> -
> -       return ret;
> -}
> -
>  static int smu_suspend(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         struct smu_context *smu = &adev->smu;
>         int ret;
> -       bool use_baco = !smu->is_apu &&
> -               ((adev->in_gpu_reset &&
> -                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> -                (adev->in_runpm && amdgpu_asic_supports_baco(adev)));
> -
>
>         if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
>                 return 0;
> @@ -1498,19 +1484,9 @@ static int smu_suspend(void *handle)
>                 return ret;
>         }
>
> -       /*
> -        * For Sienna_Cichlid, PMFW will handle the features disablement properly
> -        * on BACO in. Driver involvement is unnecessary.
> -        */
> -       if ((adev->asic_type != CHIP_SIENNA_CICHLID) || !use_baco) {
> -               ret = smu_disable_dpm(smu);
> -               if (ret)
> -                       return ret;
> -
> -               if (adev->asic_type >= CHIP_NAVI10 &&
> -                   adev->gfx.rlc.funcs->stop)
> -                       adev->gfx.rlc.funcs->stop(adev);
> -       }
> +       ret = smu_disable_dpms(smu);
> +       if (ret)
> +               return ret;
>
>         smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
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
