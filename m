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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E4C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED658206DC
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 20:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHSETPOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED658206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A329A6E5C8;
	Thu,  4 Jun 2020 20:49:36 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2668A6E5C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 20:49:35 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f185so7043700wmf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VChlRzqSz+1PFYZvwGycE+v+MoQXCbkFuW67ghRYC60=;
 b=QHSETPOPvc0/172JitiopL3rk6rgT7TY+qK2rv3l0yGv8sDo7nS+tVy7/5mte5r9xY
 yY9pK3oNujopmU5tKhpcinQF+AMzOIDGIXIkuNLrLJA3zteBxidtJ6VPm1WkAAxhGQV9
 6DTsMHH+X2JBNsGQ9zTXPeA+sy9JmUqYWwtHbrxEGvksA/y8k9YVcmdA4tXnpz9axUEd
 OrzJxvOcatKTKS0AcV4Yz/q7NDzzu6SC7Vy5cpzosE1gzyC/CK2BZSpQBLewSocZ/Nn4
 JPa+pfR5ZjgZ8nBgu9r43IHBNI5Be+ljrq8Xw7yPNnETOdfu1+lfC6tw5+hgFp8feZBA
 zZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VChlRzqSz+1PFYZvwGycE+v+MoQXCbkFuW67ghRYC60=;
 b=GGgCZGzR9Ta4SofzAZFzCQjB1Ow01zFEsJ9HFLt/VcRQh5cxUDvxktdXzIVCdwJcw3
 jt/AMZFlcNtH5Spz331X9lendSs/QN3Fk91+ScN76Xz8smPvXjbu+J9DdhAOFOcZRkGM
 OU4pOA3dqLdBRiVXY6k63oQ8okpZ4GKlG5OKJGyOzIOtFs1BqqWiytaYtWBmlgvX86mZ
 nt1Vv/HcyWCaR5F/kP4CN8vcX6qXTFMw6uRBpkkcr/6rWpgUXhy+tsCMfVwVUXZcNlOa
 hlraCg+VAKHmGW+C7+wLt7/mt9YgP3Sgv9vlFezOOipXaBVSFknyACICK343yOu807i6
 0+IQ==
X-Gm-Message-State: AOAM530hDjfRI6DnPJyF+LTBTnUgwP2B+1muVirYtzyyJjrbEgeQANut
 YUhWDwiadZS5O4nVIuIcccik/k3B6oCG0lLEuA4W4w==
X-Google-Smtp-Source: ABdhPJy5NSOcGWfxLhi+dRQgr0ciSMGhG9Ys2XUaba6fLDPxifZvRoMcZo2t/XVzrroOohfdUOd3wQHSmPdCH9XTGrI=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr5651178wmp.73.1591303773709; 
 Thu, 04 Jun 2020 13:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 16:49:22 -0400
Message-ID: <CADnq5_NACKL5yGp4bJ1+Lp5FkDz9VcG2-nTEO93o-zqKVmCjLw@mail.gmail.com>
Subject: Re: [PATCH 01/16] drm/amd/powerplay: eliminate asic type check
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

On Thu, Jun 4, 2020 at 12:46 AM Evan Quan <evan.quan@amd.com> wrote:
>
> By moving ASIC specific code into its own file.

You might want to clarify that the macros check if the asic has the
callback, so no need to explicitly check.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Change-Id: Ib6775c1c8c5211ea45db6c3fb604a8279411ab37
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 59 +++++++------------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  8 +--
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 18 ++++++
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  6 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  5 --
>  5 files changed, 45 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 78ab0d46eddd..b2c1ad95edf7 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1055,12 +1055,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>                 return 0;
>         }
>
> -       if (adev->asic_type != CHIP_ARCTURUS &&
> -           adev->asic_type != CHIP_SIENNA_CICHLID) {
> -               ret = smu_init_display_count(smu, 0);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret = smu_init_display_count(smu, 0);
> +       if (ret)
> +               return ret;
>
>         if (initialize) {
>                 /* get boot_values from vbios to set revision, gfxclk, and etc. */
> @@ -1134,21 +1131,10 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> -       if (adev->asic_type == CHIP_NAVI10) {
> -               if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
> -                                                     adev->pdev->revision == 0xc3 ||
> -                                                     adev->pdev->revision == 0xca ||
> -                                                     adev->pdev->revision == 0xcb)) ||
> -                   (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
> -                                                     adev->pdev->revision == 0xf4 ||
> -                                                     adev->pdev->revision == 0xf5 ||
> -                                                     adev->pdev->revision == 0xf6))) {
> -                       ret = smu_disable_umc_cdr_12gbps_workaround(smu);
> -                       if (ret) {
> -                               pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
> -                               return ret;
> -                       }
> -               }
> +       ret = smu_disable_umc_cdr_12gbps_workaround(smu);
> +       if (ret) {
> +               pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
> +               return ret;
>         }
>
>         if (smu->ppt_funcs->set_power_source) {
> @@ -1166,20 +1152,17 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>                 }
>         }
>
> -       if (adev->asic_type != CHIP_ARCTURUS &&
> -           adev->asic_type != CHIP_SIENNA_CICHLID) {
> -               ret = smu_notify_display_change(smu);
> -               if (ret)
> -                       return ret;
> +       ret = smu_notify_display_change(smu);
> +       if (ret)
> +               return ret;
>
> -               /*
> -                * Set min deep sleep dce fclk with bootup value from vbios via
> -                * SetMinDeepSleepDcefclk MSG.
> -                */
> -               ret = smu_set_min_dcef_deep_sleep(smu);
> -               if (ret)
> -                       return ret;
> -       }
> +       /*
> +        * Set min deep sleep dce fclk with bootup value from vbios via
> +        * SetMinDeepSleepDcefclk MSG.
> +        */
> +       ret = smu_set_min_dcef_deep_sleep(smu);
> +       if (ret)
> +               return ret;
>
>         /*
>          * Set initialized values (get from vbios) to dpm tables context such as
> @@ -1196,11 +1179,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>                         return ret;
>         }
>
> -       if (adev->asic_type != CHIP_ARCTURUS) {
> -               ret = smu_override_pcie_parameters(smu);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret = smu_override_pcie_parameters(smu);
> +       if (ret)
> +               return ret;
>
>         ret = smu_set_default_od_settings(smu, initialize);
>         if (ret)
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index df7b408319f7..1de5304d12bf 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2463,16 +2463,16 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .populate_smc_tables = smu_v11_0_populate_smc_pptable,
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
> -       .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> +       .set_min_dcef_deep_sleep = NULL,
>         .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>         .system_features_control = smu_v11_0_system_features_control,
>         .send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
> -       .init_display_count = smu_v11_0_init_display_count,
> +       .init_display_count = NULL,
>         .set_allowed_mask = smu_v11_0_set_allowed_mask,
>         .get_enabled_mask = smu_v11_0_get_enabled_mask,
> -       .notify_display_change = smu_v11_0_notify_display_change,
> +       .notify_display_change = NULL,
>         .set_power_limit = smu_v11_0_set_power_limit,
>         .get_current_clk_freq = smu_v11_0_get_current_clk_freq,
>         .init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
> @@ -2496,7 +2496,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .baco_exit = smu_v11_0_baco_exit,
>         .get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
>         .set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
> -       .override_pcie_parameters = smu_v11_0_override_pcie_parameters,
> +       .override_pcie_parameters = NULL,
>         .get_pptable_power_limit = arcturus_get_pptable_power_limit,
>         .set_df_cstate = arcturus_set_df_cstate,
>         .allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 68142f6798c6..a43c16befffd 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2209,12 +2209,30 @@ static int navi10_dummy_pstate_control(struct smu_context *smu, bool enable)
>         return result;
>  }
>
> +static inline bool navi10_need_umc_cdr_12gbps_workaround(struct amdgpu_device *adev)
> +{
> +       if (adev->asic_type != CHIP_NAVI10)
> +               return false;
> +
> +       if (adev->pdev->device == 0x731f &&
> +           (adev->pdev->revision == 0xc2 ||
> +            adev->pdev->revision == 0xc3 ||
> +            adev->pdev->revision == 0xca ||
> +            adev->pdev->revision == 0xcb))
> +               return true;
> +       else
> +               return false;
> +}
> +
>  static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
>  {
>         uint32_t uclk_count, uclk_min, uclk_max;
>         uint32_t smu_version;
>         int ret = 0;
>
> +       if (!navi10_need_umc_cdr_12gbps_workaround(smu->adev))
> +               return 0;
> +
>         ret = smu_get_smc_version(smu, NULL, &smu_version);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index ce16cabb0780..f83df6adcbce 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -2463,16 +2463,16 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .populate_smc_tables = smu_v11_0_populate_smc_pptable,
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
> -       .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
> +       .set_min_dcef_deep_sleep = NULL,
>         .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>         .system_features_control = smu_v11_0_system_features_control,
>         .send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
> -       .init_display_count = smu_v11_0_init_display_count,
> +       .init_display_count = NULL,
>         .set_allowed_mask = smu_v11_0_set_allowed_mask,
>         .get_enabled_mask = smu_v11_0_get_enabled_mask,
> -       .notify_display_change = smu_v11_0_notify_display_change,
> +       .notify_display_change = NULL,
>         .set_power_limit = smu_v11_0_set_power_limit,
>         .get_current_clk_freq = smu_v11_0_get_current_clk_freq,
>         .init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 06b376a1396d..d4509ceb7854 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -836,11 +836,6 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
>  int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
>  {
>         int ret = 0;
> -       struct amdgpu_device *adev = smu->adev;
> -
> -       /* Sienna_Cichlid do not support to change display num currently */
> -       if (adev->asic_type == CHIP_SIENNA_CICHLID)
> -               return 0;
>
>         if (!smu->pm_enabled)
>                 return ret;
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
