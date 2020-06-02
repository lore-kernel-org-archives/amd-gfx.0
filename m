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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4727C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958E8206C3
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 15:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rF19QHVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958E8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4707F6E40C;
	Tue,  2 Jun 2020 15:06:37 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C40D6E40C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 15:06:36 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id h5so3757135wrc.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2zULKU0uA2FQcV6hyx7Ikw6/hFei5cLSBTkp6tEK0t4=;
 b=rF19QHVUS4qqe60A7MfFteJ9R8pP7IFxYkHaFPMiYOihFIjBxtu8S/FM6qVwxB6SQa
 7/fNp3fn9zwNvyRCRRawvYkkCs6p8ninflL/HiDzVn+AVohBfUzftZ4t0aIID6e6H3BP
 DdbgRi1nR/EivZrcRGvf2WFBnEK9JYNuLM+lKkpsgPJQmzldGZebEE6x1YFUhAis/O7z
 2NTLlaP02AFW52wVYyVqJ38BtFDKp8MsLCryGF4cSXlmrJ+e+2r+dh57o+eGNuxVExeT
 wLgLhNNxVJSEwkZQ7bCdKoK/i+JVGvsGk6a2YMhizQkbH0+fZZWjti+IO8XUVHfRsLfe
 RtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2zULKU0uA2FQcV6hyx7Ikw6/hFei5cLSBTkp6tEK0t4=;
 b=HwfwCPmX/s2HXuljBCc/Z463xnbweH8ddoIAFsmQOM0Q0k20FiVqxep/XtRvUhb0vP
 eKeCI0Lu7DYqk2jLcQIIAnSEm/mQdQ+PqAEFnmiqq/q4nm8xsg9rUTdt0tllFCemWJPS
 DtZztmcJW72G12+aXCAnfqe0NC2WLLtoaoOWFbYweDAz4uEKvSqsPbPzOOTqa55DcO7O
 3goNugQ7OLuT/reaEA0bkM+lFVHq0v60HPvVzCM5pZSdP5PbqEGTS2QpKzZZiJQaeH+Y
 DXITEvlipY77mddTYpyErM/4iNpJj5eFjIASZu6bT5YaASfIm+yugD8FtMahCjBEnPF5
 DDKA==
X-Gm-Message-State: AOAM530NrMI4ewEiVQoWZtiZ35Kv6LRKa+RKToufVCzXWcy7D73iA77n
 bFG9SyP8KDCQCsIxxZm54Lt95UVQsO+T3QiVe/I=
X-Google-Smtp-Source: ABdhPJxVcoG83T1IR3NmOHKP/KA07xHfuFkUEfPgN0z4bDcWbhBqSzOTeyIki+5f8OWbFnpnUsuHOoa7YTxunturYws=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr26282045wrq.362.1591110394867; 
 Tue, 02 Jun 2020 08:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200601073003.13044-1-evan.quan@amd.com>
 <20200601073003.13044-6-evan.quan@amd.com>
In-Reply-To: <20200601073003.13044-6-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 11:06:23 -0400
Message-ID: <CADnq5_OFfyEmjsgjSSXApeTF0J2CUCGGu4LjE1HouO-n3UcXZg@mail.gmail.com>
Subject: Re: [PATCH 6/9] drm/amd/powerplay: clean up the overdrive settings
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

On Mon, Jun 1, 2020 at 3:31 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Eliminate the buffer allocation and drop the unnecessary
> overdrive table uploading.
>
> Change-Id: I8ba5383a330e6d5355cea219147500c1b4a43f47
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  2 +-
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +-
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 -
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 74 +++++++++----------
>  drivers/gpu/drm/amd/powerplay/smu_internal.h  |  4 +-
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 -----
>  6 files changed, 38 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index b079ac6325d0..9b81b6519a96 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1215,7 +1215,7 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>         if (ret)
>                 return ret;
>
> -       ret = smu_set_default_od_settings(smu, initialize);
> +       ret = smu_set_default_od_settings(smu);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 14f4a850b553..4aa63dc79124 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -480,7 +480,7 @@ struct pptable_funcs {
>                                              uint32_t *value);
>         int (*get_thermal_temperature_range)(struct smu_context *smu, struct smu_temperature_range *range);
>         int (*get_uclk_dpm_states)(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states);
> -       int (*set_default_od_settings)(struct smu_context *smu, bool initialize);
> +       int (*set_default_od_settings)(struct smu_context *smu);
>         int (*set_performance_level)(struct smu_context *smu, enum amd_dpm_forced_level level);
>         int (*display_disable_memory_clock_switch)(struct smu_context *smu, bool disable_memory_clock_switch);
>         void (*dump_pptable)(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 51868dc33238..8d317e05f65b 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -258,8 +258,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
>
>  int smu_v11_0_override_pcie_parameters(struct smu_context *smu);
>
> -int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize, size_t overdrive_table_size);
> -
>  uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu);
>
>  int smu_v11_0_set_performance_level(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index db38fb10524d..caa4355b601e 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1969,55 +1969,49 @@ static bool navi10_is_baco_supported(struct smu_context *smu)
>         return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
>  }
>
> -static int navi10_set_default_od_settings(struct smu_context *smu, bool initialize) {
> -       OverDriveTable_t *od_table, *boot_od_table;
> +static int navi10_set_default_od_settings(struct smu_context *smu)
> +{
> +       OverDriveTable_t *od_table =
> +               (OverDriveTable_t *)smu->smu_table.overdrive_table;
> +       OverDriveTable_t *boot_od_table =
> +               (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
>         int ret = 0;
>
> -       ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
> -       if (ret)
> +       ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, false);
> +       if (ret) {
> +               pr_err("Failed to get overdrive table!\n");
>                 return ret;
> +       }
>
> -       od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
> -       boot_od_table = (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> -       if (initialize) {
> -               if (od_table) {
> -                       if (!od_table->GfxclkVolt1) {
> -                               ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                                               &od_table->GfxclkVolt1,
> -                                                                               od_table->GfxclkFreq1);
> -                               if (ret)
> -                                       od_table->GfxclkVolt1 = 0;
> -                               if (boot_od_table)
> -                                       boot_od_table->GfxclkVolt1 = od_table->GfxclkVolt1;
> -                       }
> -
> -                       if (!od_table->GfxclkVolt2) {
> -                               ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                                               &od_table->GfxclkVolt2,
> -                                                                               od_table->GfxclkFreq2);
> -                               if (ret)
> -                                       od_table->GfxclkVolt2 = 0;
> -                               if (boot_od_table)
> -                                       boot_od_table->GfxclkVolt2 = od_table->GfxclkVolt2;
> -                       }
> +       if (!od_table->GfxclkVolt1) {
> +               ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> +                                                               &od_table->GfxclkVolt1,
> +                                                               od_table->GfxclkFreq1);
> +               if (ret)
> +                       return ret;
> +       }
>
> -                       if (!od_table->GfxclkVolt3) {
> -                               ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                                               &od_table->GfxclkVolt3,
> -                                                                               od_table->GfxclkFreq3);
> -                               if (ret)
> -                                       od_table->GfxclkVolt3 = 0;
> -                               if (boot_od_table)
> -                                       boot_od_table->GfxclkVolt3 = od_table->GfxclkVolt3;
> -                       }
> -               }
> +       if (!od_table->GfxclkVolt2) {
> +               ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> +                                                               &od_table->GfxclkVolt2,
> +                                                               od_table->GfxclkFreq2);
> +               if (ret)
> +                       return ret;
>         }
>
> -       if (od_table) {
> -               navi10_dump_od_table(od_table);
> +       if (!od_table->GfxclkVolt3) {
> +               ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
> +                                                               &od_table->GfxclkVolt3,
> +                                                               od_table->GfxclkFreq3);
> +               if (ret)
> +                       return ret;
>         }
>
> -       return ret;
> +       memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> +
> +       navi10_dump_od_table(od_table);
> +
> +       return 0;
>  }
>
>  static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type, long input[], uint32_t size) {
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 33086f94267a..0c7d5f0b1cd1 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -70,8 +70,8 @@
>         ((smu)->ppt_funcs->system_features_control ? (smu)->ppt_funcs->system_features_control((smu), (en)) : 0)
>  #define smu_init_max_sustainable_clocks(smu) \
>         ((smu)->ppt_funcs->init_max_sustainable_clocks ? (smu)->ppt_funcs->init_max_sustainable_clocks((smu)) : 0)
> -#define smu_set_default_od_settings(smu, initialize) \
> -       ((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu), (initialize)) : 0)
> +#define smu_set_default_od_settings(smu) \
> +       ((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu)) : 0)
>
>  #define smu_send_smc_msg_with_param(smu, msg, param, read_arg) \
>         ((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send_smc_msg_with_param((smu), (msg), (param), (read_arg)) : 0)
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 7a97a4510c6d..891781a5c0d4 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1898,26 +1898,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
>
>  }
>
> -int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize, size_t overdrive_table_size)
> -{
> -       struct smu_table_context *table_context = &smu->smu_table;
> -       int ret = 0;
> -
> -       if (initialize) {
> -               ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
> -               if (ret) {
> -                       pr_err("Failed to export overdrive table!\n");
> -                       return ret;
> -               }
> -       }
> -       ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, true);
> -       if (ret) {
> -               pr_err("Failed to import overdrive table!\n");
> -               return ret;
> -       }
> -       return ret;
> -}
> -
>  int smu_v11_0_set_performance_level(struct smu_context *smu,
>                                     enum amd_dpm_forced_level level)
>  {
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
