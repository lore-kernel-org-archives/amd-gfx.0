Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0F0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CF7206C3
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 19:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWlnGLIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CF7206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8766E330;
	Tue,  9 Jun 2020 19:50:08 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CD66E330
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 19:50:06 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id x6so22606670wrm.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jun 2020 12:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S3I0kLRQgBiqlAkFG2ZvKjt3/iF6D0R/0q3mQo0xh9M=;
 b=IWlnGLIMlxmhdmKER1e+DsSOkb64PZhlzOVZS4E4ZXjZsSuMiz+E/Hcrttqx5YlIRp
 creKbtJymVfVXlBFW9NT5O7ClmSMn8YtJu1adK0SvGTKf/SAuoWd6AKMBGiUAC/pwmW+
 +JKg7PBVK/Xbq0va/fsdtCZBlYdsEXbBh8lvdAdxVhAMvZB+hIBuKGh84+eVuiXuDfo0
 8bxZkWXmDGFNfxj+DgYM18gq5HhuvScn7Bc7dnaRUB0LQo8/7O8XCuruhznFMN/3vGYO
 xhj23l1GCdcQAcoZIq6a9rwQIiMbcrnLE1nx/qdbr2KnKovG6diu3eAIHftRje3PzDvM
 h7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S3I0kLRQgBiqlAkFG2ZvKjt3/iF6D0R/0q3mQo0xh9M=;
 b=bI/uWEbxawXE6B3vqETcrupNrkjeOJiByJMuoLDpTyU9j2rqoBUZpEkq1hpmM0dnFr
 2M3APrQjzip8ei75aGZArOvHoUpc3PTcSqi0Y3BBwgLQRF+NJ5827LHpDE4phjWYT6x5
 YoLDvBnRsPz50WaJo5FRI1KRRzQaVsFDhtgMTr9mbSVQ8MaTmJvkjPz5iOxtrPUrJYft
 KX/jrk7rhRNoIQD5TzSSdaDXSkipiRVX0usfuYaKKBeU7oZJ2UIhXaqiKujfAEZjjYnB
 zQHFrRm6i8liKLrn/oJ+x+G7BAxzwLJBqcSoWHZ2thIBM1GeJusmZR0qsSPZiKdubIDk
 HJyw==
X-Gm-Message-State: AOAM530hzTd2hLyPvqgnrCZ5I6KSVlK+eodKcVX1EjkucxarqsH9Pi0g
 qv3xBdSCG5wM53J2XAMaRndoYa2hgwM2tPuKtoGCPu3t
X-Google-Smtp-Source: ABdhPJxYZEBfyPlgfJpT4Kpp72GK+JllXJhKW3wAUHRc6+Mr7DLOc0LHSulHnMYtMcm2/r4+skD8KWdBGtsfnwVb7g8=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr6562779wrp.419.1591732205244; 
 Tue, 09 Jun 2020 12:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200609100953.11866-1-evan.quan@amd.com>
In-Reply-To: <20200609100953.11866-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Jun 2020 15:49:54 -0400
Message-ID: <CADnq5_NzpdOxqAnviu94eyCYV7qQxDp_ZmQ4OQt6iSO7o0QCZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/powerplay: drop redundant
 .set_min_dcefclk_deep_sleep API
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

On Tue, Jun 9, 2020 at 6:10 AM Evan Quan <evan.quan@amd.com> wrote:
>
> It has exactly the same functionality as .set_deep_sleep_dcefclk.
>
> Change-Id: Ib4d2d604ca014e194cb2b61ac770e4370ecad74d
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 11 +++++------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  3 +--
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     |  1 -
>  drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h      |  2 --
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c         |  1 -
>  drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c |  3 +--
>  drivers/gpu/drm/amd/powerplay/smu_internal.h       |  4 ++--
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 10 ----------
>  8 files changed, 9 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 6beae3b496be..89dd12536d58 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1269,7 +1269,8 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>          * Set min deep sleep dce fclk with bootup value from vbios via
>          * SetMinDeepSleepDcefclk MSG.
>          */
> -       ret = smu_set_min_dcef_deep_sleep(smu);
> +       ret = smu_set_min_dcef_deep_sleep(smu,
> +                                         smu->smu_table.boot_values.dcefclk / 100);
>         if (ret)
>                 return ret;
>
> @@ -1584,9 +1585,8 @@ int smu_display_configuration_change(struct smu_context *smu,
>
>         mutex_lock(&smu->mutex);
>
> -       if (smu->ppt_funcs->set_deep_sleep_dcefclk)
> -               smu->ppt_funcs->set_deep_sleep_dcefclk(smu,
> -                               display_config->min_dcef_deep_sleep_set_clk / 100);
> +       smu_set_min_dcef_deep_sleep(smu,
> +                                   display_config->min_dcef_deep_sleep_set_clk / 100);
>
>         for (index = 0; index < display_config->num_path_including_non_display; index++) {
>                 if (display_config->displays[index].controller_id != 0)
> @@ -2482,8 +2482,7 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
>
>         mutex_lock(&smu->mutex);
>
> -       if (smu->ppt_funcs->set_deep_sleep_dcefclk)
> -               ret = smu->ppt_funcs->set_deep_sleep_dcefclk(smu, clk);
> +       ret = smu_set_min_dcef_deep_sleep(smu, clk);
>
>         mutex_unlock(&smu->mutex);
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index c104844b28f1..96c9a348f8b3 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -2590,7 +2590,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .populate_smc_tables = smu_v11_0_populate_smc_pptable,
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
> -       .set_min_dcef_deep_sleep = NULL,
>         .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
> @@ -2605,7 +2604,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>         .init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
>         .enable_thermal_alert = smu_v11_0_enable_thermal_alert,
>         .disable_thermal_alert = smu_v11_0_disable_thermal_alert,
> -       .set_deep_sleep_dcefclk = smu_v11_0_set_deep_sleep_dcefclk,
> +       .set_deep_sleep_dcefclk = NULL,
>         .display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
>         .get_fan_control_mode = smu_v11_0_get_fan_control_mode,
>         .set_fan_control_mode = smu_v11_0_set_fan_control_mode,
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 8eaa6338ad44..3420a58fad03 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -510,7 +510,6 @@ struct pptable_funcs {
>         int (*powergate_sdma)(struct smu_context *smu, bool gate);
>         int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
>         int (*write_pptable)(struct smu_context *smu);
> -       int (*set_min_dcef_deep_sleep)(struct smu_context *smu);
>         int (*set_driver_table_location)(struct smu_context *smu);
>         int (*set_tool_table_location)(struct smu_context *smu);
>         int (*notify_memory_pool_location)(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> index 2e9939beb128..9ccf62e99dcb 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
> @@ -170,8 +170,6 @@ int smu_v11_0_check_fw_version(struct smu_context *smu);
>
>  int smu_v11_0_write_pptable(struct smu_context *smu);
>
> -int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu);
> -
>  int smu_v11_0_set_driver_table_location(struct smu_context *smu);
>
>  int smu_v11_0_set_tool_table_location(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 115794557190..abbfcce6d9ad 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2426,7 +2426,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>         .populate_smc_tables = smu_v11_0_populate_smc_pptable,
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
> -       .set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
>         .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index 81cc04de9b06..6a9d04cac240 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -2596,7 +2596,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .populate_smc_tables = smu_v11_0_populate_smc_pptable,
>         .check_fw_version = smu_v11_0_check_fw_version,
>         .write_pptable = smu_v11_0_write_pptable,
> -       .set_min_dcef_deep_sleep = NULL,
>         .set_driver_table_location = smu_v11_0_set_driver_table_location,
>         .set_tool_table_location = smu_v11_0_set_tool_table_location,
>         .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
> @@ -2611,7 +2610,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>         .init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
>         .enable_thermal_alert = smu_v11_0_enable_thermal_alert,
>         .disable_thermal_alert = smu_v11_0_disable_thermal_alert,
> -       .set_deep_sleep_dcefclk = smu_v11_0_set_deep_sleep_dcefclk,
> +       .set_deep_sleep_dcefclk = NULL,
>         .display_clock_voltage_request = smu_v11_0_display_clock_voltage_request,
>         .get_fan_control_mode = smu_v11_0_get_fan_control_mode,
>         .set_fan_control_mode = smu_v11_0_set_fan_control_mode,
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> index 094db34ddbd1..86c09098963a 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
> +++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
> @@ -51,8 +51,8 @@
>         ((smu)->ppt_funcs->check_fw_version ? (smu)->ppt_funcs->check_fw_version((smu)) : 0)
>  #define smu_write_pptable(smu) \
>         ((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs->write_pptable((smu)) : 0)
> -#define smu_set_min_dcef_deep_sleep(smu) \
> -       ((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs->set_min_dcef_deep_sleep((smu)) : 0)
> +#define smu_set_min_dcef_deep_sleep(smu, clk) \
> +       ((smu)->ppt_funcs->set_deep_sleep_dcefclk ? (smu)->ppt_funcs->set_deep_sleep_dcefclk((smu), (clk)) : 0)

Can you make the callback and macro names match?  E.g.,

 +#define smu_set_min_dcef_deep_sleep(smu, clk) \
 +       ((smu)->ppt_funcs->set_min_dcef_deep_sleep ?
(smu)->ppt_funcs->set_min_dcef_deep_sleep((smu), (clk)) : 0)

That makes it easier to trace the macro back to it's callback.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>  #define smu_set_driver_table_location(smu) \
>         ((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs->set_driver_table_location((smu)) : 0)
>  #define smu_set_tool_table_location(smu) \
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 06e3799aa923..5590dab46e8c 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -782,16 +782,6 @@ int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
>         return ret;
>  }
>
> -int smu_v11_0_set_min_dcef_deep_sleep(struct smu_context *smu)
> -{
> -       struct smu_table_context *table_context = &smu->smu_table;
> -
> -       if (!table_context)
> -               return -EINVAL;
> -
> -       return smu_v11_0_set_deep_sleep_dcefclk(smu, table_context->boot_values.dcefclk / 100);
> -}
> -
>  int smu_v11_0_set_driver_table_location(struct smu_context *smu)
>  {
>         struct smu_table *driver_table = &smu->smu_table.driver_table;
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
