Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC4AC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E742068D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 14:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlVWMKWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E742068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5612C6E3F9;
	Tue,  2 Jun 2020 14:50:05 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0D26E3F9
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 14:50:03 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id l10so3679030wrr.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xEmzexCifyiubXmaCTEn/Nra8kuzQIzx+3Ha+AAiaiM=;
 b=rlVWMKWh7UtY3OvVzrQSKjSBqoI9KIHJvC7N8avp0r8ifdnGmndDaGNUOJuUwAv87v
 aTrATEzAjtRe5GubjYWImMDS1lEwMSDtrda6vnloCB8k4x74M5ylW12ht3M+VY7CUWB9
 c8GjX9uP6G7WWdzwfHsnGz3i/kQsCyAvgHATRrL3ck2KNnX9TQJFLITcevoNE3OSi239
 GBdQqX6XwpasSC5G5iYLkkigUP/wYLILyPZV/LynLU22lkzcli8suPErNX1FjJopudz7
 WaeWzYh+nhK6Fp22udw1w3qXcaP9TcI394KM9NDV0n7u16ztSewMu04OVp9/s36IVBH1
 GbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xEmzexCifyiubXmaCTEn/Nra8kuzQIzx+3Ha+AAiaiM=;
 b=o4bPfLDBDEy5cyHkwlluNILkEU1KuV9PJIVYMXh6FSvyvAzkc99vz6Ly+FjoSPS6db
 aZd2ol8pv7+rI6k6c0tjSa9xuuaYddqkvcHX3e9pM4stBj33JXGrqmvS/c5KTv07Ju73
 5ZqfD3A5hABF59GKuhyiZDkfkPTByUw4JraVFSmuvUzycYtK4ZFF7xuGWYKOJq/UXOl/
 x0tztWu9FVIlFlrovLjkz5Lu8wG9twzX9xNg//4D1DB46AuAY3X+Jas7Gx4on81l16Im
 fAmhzS8/14VZV0XziXWwJuJyip5gVZnYiJATXuRj4yyOUDNlgMbVJMG8h2AafGLutx3o
 OOYg==
X-Gm-Message-State: AOAM530tUqEMncYNtXSsVJwfJKJq+3j7LBM0vJboidcC0NHN0uWuGvnE
 abSVQZTvrtJE1wMP3irnUNCXcW/nljI9XCEGL0M=
X-Google-Smtp-Source: ABdhPJx4OPXYUabielsVr7zC5Z8cOYvWB1YhvK5/6IlRHwBThDSNuDs/ZHk59ktyHWjOoB3BDLC1tplwO1iTYEY28as=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr27865996wrs.374.1591109402181; 
 Tue, 02 Jun 2020 07:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200601073003.13044-1-evan.quan@amd.com>
In-Reply-To: <20200601073003.13044-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 10:49:51 -0400
Message-ID: <CADnq5_Mm0S4X-oEYkWpz8e6dZ=LwTDNFm-Dxgtg2o8DKv9f4-Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/powerplay: drop unnecessary CHIP_ARCTURUS
 guard
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

On Mon, Jun 1, 2020 at 3:30 AM Evan Quan <evan.quan@amd.com> wrote:
>
> These APIs internally guard they will not break ARCTURUS.
>
> Change-Id: Ib6775c1c8c5211ea45db6c3fb604a8279411ab37
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 38 +++++++++-----------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c |  8 ++---
>  2 files changed, 20 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 5294aa7cdde1..4998ea942760 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1049,11 +1049,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>                 return 0;
>         }
>
> -       if (adev->asic_type != CHIP_ARCTURUS) {
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
> @@ -1159,19 +1157,17 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>                 }
>         }
>
> -       if (adev->asic_type != CHIP_ARCTURUS) {
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
> @@ -1188,11 +1184,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
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
> index 302b7e9cb5ba..e856ad36ab01 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2429,16 +2429,16 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
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
> @@ -2462,7 +2462,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .baco_exit = smu_v11_0_baco_exit,
>         .get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
>         .set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
> -       .override_pcie_parameters = smu_v11_0_override_pcie_parameters,
> +       .override_pcie_parameters = NULL,
>         .get_pptable_power_limit = arcturus_get_pptable_power_limit,
>         .set_df_cstate = arcturus_set_df_cstate,
>         .allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
