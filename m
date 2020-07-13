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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F13C433F7
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849E620771
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exgsv44c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849E620771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375416E121;
	Mon, 13 Jul 2020 14:49:56 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644AC6E121
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 14:49:54 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id q5so16887085wru.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fjumo3WTMPn72d9zNR5i1pDZntXgJaTW6OYPtWvDeTA=;
 b=Exgsv44cXWSqqEhNk0N6DK4gEHjkVR63QPRVkhECmhJtqVeg7SPVN/Fhb34L2VsKRp
 RLUlnYUg8SYCCtLSkacUmA8jqTjjeGLM3HKPq9axRCNRThlkUqmoGGfs0TedXu7r+yzb
 AETStulvvFfMBKK9EiKfzbi+igq5U0Dh79fpuo8+1DdeK6/RDJCURPqb1HwmSM10Dok/
 L4Ohnl79ukEGPONhTy0qye9coGFslsCapHzFuhzOLK6tb5gLA1VTVzpptkFd2w8dTZbz
 23BaTWwAGYaysBUd57bI9TfMlzCHOhEQ1LXGmqAOaumlz/6ixtNbcvj3pFJAKYTpWdM1
 N2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fjumo3WTMPn72d9zNR5i1pDZntXgJaTW6OYPtWvDeTA=;
 b=Tk4HK9+s0O+eff0CEOEeJKsUDxvBZlZ+7FR3u0h0cIan6HI97hVhuMeDbu17l1Q/Wt
 +JwoqKNBOmRpl93jB86QlCisA7N+Cd0R5C1FsF/nqjs+7Vo8YayI9cr833+sXqFu54Em
 G2fsVuTPu+LAr9/Tpi5k2DT3gFPrybM22r33NRElWsnbDZTpIfJJPje+J8exgNM+FTAp
 Du7lgyTxnvfljcv+cXVd1P/R6Xp9kE+0XdLnYiDrRp1lVQTmULeF25fInpqXXVDTsLbc
 iN/z5FZr6ag6MIa/YOMAEIccVsnheQMjCkdAABBroHrZ5Z7WtxAqVND16s3ZW5GEK+EM
 PMaw==
X-Gm-Message-State: AOAM5324or196Cfxyen6E8vbxG0RHKwvJF2a0I0n6FRd2MIvJlSvwJ0i
 LE4EXbXr5pbPWyd00lq8mwzYLRTlgixIONkq3VCmv5tw
X-Google-Smtp-Source: ABdhPJyee5agMudWJ6E8cnkDLtpgmrY9tGRcSLFTKY0pTz+84DaJh2ApVGNdWuE+gp0H7XiiEwtxG4NQ1X8yzyovj88=
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr78999455wrw.111.1594651792824; 
 Mon, 13 Jul 2020 07:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200710044746.23538-1-evan.quan@amd.com>
 <20200710044746.23538-3-evan.quan@amd.com>
In-Reply-To: <20200710044746.23538-3-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2020 10:49:41 -0400
Message-ID: <CADnq5_Ot2Uv+0GK088v_PZz2N_O09nNTbfwrU=v=0xTqm91x4Q@mail.gmail.com>
Subject: Re: [PATCH 03/16] drm/amd/powerplay: update Arcturus default dpm
 table setting
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
> Preparing for coming code sharing around performance level
> setting.
>
> Change-Id: Iaa77af7a272121503f09ad5fbfbe9dff2d2597b1
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 297 ++++++++-----------
>  1 file changed, 119 insertions(+), 178 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 5b793e354704..a3747ab4af32 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -291,7 +291,6 @@ static int arcturus_get_pwr_src_index(struct smu_context *smc, uint32_t index)
>         return mapping.map_to;
>  }
>
> -
>  static int arcturus_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER_PROFILE profile)
>  {
>         struct smu_11_0_cmn2aisc_mapping mapping;
> @@ -338,23 +337,11 @@ static int arcturus_allocate_dpm_context(struct smu_context *smu)
>  {
>         struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
>
> -       if (smu_dpm->dpm_context)
> -               return -EINVAL;
> -
> -       smu_dpm->dpm_context = kzalloc(sizeof(struct arcturus_dpm_table),
> +       smu_dpm->dpm_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
>                                        GFP_KERNEL);
>         if (!smu_dpm->dpm_context)
>                 return -ENOMEM;
> -
> -       if (smu_dpm->golden_dpm_context)
> -               return -EINVAL;
> -
> -       smu_dpm->golden_dpm_context = kzalloc(sizeof(struct arcturus_dpm_table),
> -                                             GFP_KERNEL);
> -       if (!smu_dpm->golden_dpm_context)
> -               return -ENOMEM;
> -
> -       smu_dpm->dpm_context_size = sizeof(struct arcturus_dpm_table);
> +       smu_dpm->dpm_context_size = sizeof(struct smu_11_0_dpm_context);
>
>         smu_dpm->dpm_current_power_state = kzalloc(sizeof(struct smu_power_state),
>                                        GFP_KERNEL);
> @@ -382,119 +369,84 @@ arcturus_get_allowed_feature_mask(struct smu_context *smu,
>         return 0;
>  }
>
> -static int
> -arcturus_set_single_dpm_table(struct smu_context *smu,
> -                           struct arcturus_single_dpm_table *single_dpm_table,
> -                           PPCLK_e clk_id)
> -{
> -       int ret = 0;
> -       uint32_t i, num_of_levels = 0, clk;
> -
> -       ret = smu_send_smc_msg_with_param(smu,
> -                       SMU_MSG_GetDpmFreqByIndex,
> -                       (clk_id << 16 | 0xFF),
> -                       &num_of_levels);
> -       if (ret) {
> -               dev_err(smu->adev->dev, "[%s] failed to get dpm levels!\n", __func__);
> -               return ret;
> -       }
> -
> -       single_dpm_table->count = num_of_levels;
> -       for (i = 0; i < num_of_levels; i++) {
> -               ret = smu_send_smc_msg_with_param(smu,
> -                               SMU_MSG_GetDpmFreqByIndex,
> -                               (clk_id << 16 | i),
> -                               &clk);
> -               if (ret) {
> -                       dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
> -                       return ret;
> -               }
> -               single_dpm_table->dpm_levels[i].value = clk;
> -               single_dpm_table->dpm_levels[i].enabled = true;
> -       }
> -       return 0;
> -}
> -
> -static void arcturus_init_single_dpm_state(struct arcturus_dpm_state *dpm_state)
> -{
> -       dpm_state->soft_min_level = 0x0;
> -       dpm_state->soft_max_level = 0xffff;
> -        dpm_state->hard_min_level = 0x0;
> -        dpm_state->hard_max_level = 0xffff;
> -}
> -
>  static int arcturus_set_default_dpm_table(struct smu_context *smu)
>  {
> -       int ret;
> -
> -       struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> -       struct arcturus_dpm_table *dpm_table = NULL;
> -       struct arcturus_single_dpm_table *single_dpm_table;
> -
> -       dpm_table = smu_dpm->dpm_context;
> +       struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
> +       PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
> +       struct smu_11_0_dpm_table *dpm_table = NULL;
> +       int ret = 0;
>
> -       /* socclk */
> -       single_dpm_table = &(dpm_table->soc_table);
> +       /* socclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.soc_table;
>         if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
> -               ret = arcturus_set_single_dpm_table(smu, single_dpm_table,
> -                                                 PPCLK_SOCCLK);
> -               if (ret) {
> -                       dev_err(smu->adev->dev, "[%s] failed to get socclk dpm levels!\n", __func__);
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_SOCCLK,
> +                                                    dpm_table);
> +               if (ret)
>                         return ret;
> -               }
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete;
>         } else {
> -               single_dpm_table->count = 1;
> -               single_dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
>         }
> -       arcturus_init_single_dpm_state(&(single_dpm_table->dpm_state));
>
> -       /* gfxclk */
> -       single_dpm_table = &(dpm_table->gfx_table);
> +       /* gfxclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.gfx_table;
>         if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
> -               ret = arcturus_set_single_dpm_table(smu, single_dpm_table,
> -                                                 PPCLK_GFXCLK);
> -               if (ret) {
> -                       dev_err(smu->adev->dev, "[SetupDefaultDpmTable] failed to get gfxclk dpm levels!");
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_GFXCLK,
> +                                                    dpm_table);
> +               if (ret)
>                         return ret;
> -               }
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete;
>         } else {
> -               single_dpm_table->count = 1;
> -               single_dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
>         }
> -       arcturus_init_single_dpm_state(&(single_dpm_table->dpm_state));
>
> -       /* memclk */
> -       single_dpm_table = &(dpm_table->mem_table);
> +       /* memclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.uclk_table;
>         if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
> -               ret = arcturus_set_single_dpm_table(smu, single_dpm_table,
> -                                                 PPCLK_UCLK);
> -               if (ret) {
> -                       dev_err(smu->adev->dev, "[SetupDefaultDpmTable] failed to get memclk dpm levels!");
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_UCLK,
> +                                                    dpm_table);
> +               if (ret)
>                         return ret;
> -               }
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete;
>         } else {
> -               single_dpm_table->count = 1;
> -               single_dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
>         }
> -       arcturus_init_single_dpm_state(&(single_dpm_table->dpm_state));
>
> -       /* fclk */
> -       single_dpm_table = &(dpm_table->fclk_table);
> +       /* fclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.fclk_table;
>         if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
> -               ret = arcturus_set_single_dpm_table(smu, single_dpm_table,
> -                                                 PPCLK_FCLK);
> -               if (ret) {
> -                       dev_err(smu->adev->dev, "[SetupDefaultDpmTable] failed to get fclk dpm levels!");
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_FCLK,
> +                                                    dpm_table);
> +               if (ret)
>                         return ret;
> -               }
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_FCLK].SnapToDiscrete;
>         } else {
> -               single_dpm_table->count = 1;
> -               single_dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
>         }
> -       arcturus_init_single_dpm_state(&(single_dpm_table->dpm_state));
> -
> -       memcpy(smu_dpm->golden_dpm_context, dpm_table,
> -              sizeof(struct arcturus_dpm_table));
>
>         return 0;
>  }
> @@ -622,7 +574,7 @@ static int arcturus_populate_umd_state_clk(struct smu_context *smu)
>
>  static int arcturus_get_clk_table(struct smu_context *smu,
>                         struct pp_clock_levels_with_latency *clocks,
> -                       struct arcturus_single_dpm_table *dpm_table)
> +                       struct smu_11_0_dpm_table *dpm_table)
>  {
>         int i, count;
>
> @@ -824,14 +776,14 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>         int i, now, size = 0;
>         int ret = 0;
>         struct pp_clock_levels_with_latency clocks;
> -       struct arcturus_single_dpm_table *single_dpm_table;
> +       struct smu_11_0_dpm_table *single_dpm_table;
>         struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> -       struct arcturus_dpm_table *dpm_table = NULL;
> +       struct smu_11_0_dpm_context *dpm_context = NULL;
>
>         if (amdgpu_ras_intr_triggered())
>                 return snprintf(buf, PAGE_SIZE, "unavailable\n");
>
> -       dpm_table = smu_dpm->dpm_context;
> +       dpm_context = smu_dpm->dpm_context;
>
>         switch (type) {
>         case SMU_SCLK:
> @@ -841,7 +793,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>                         return ret;
>                 }
>
> -               single_dpm_table = &(dpm_table->gfx_table);
> +               single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
>                 ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>                 if (ret) {
>                         dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
> @@ -868,7 +820,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>                         return ret;
>                 }
>
> -               single_dpm_table = &(dpm_table->mem_table);
> +               single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
>                 ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>                 if (ret) {
>                         dev_err(smu->adev->dev, "Attempt to get memory clk levels Failed!");
> @@ -891,7 +843,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>                         return ret;
>                 }
>
> -               single_dpm_table = &(dpm_table->soc_table);
> +               single_dpm_table = &(dpm_context->dpm_tables.soc_table);
>                 ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>                 if (ret) {
>                         dev_err(smu->adev->dev, "Attempt to get socclk levels Failed!");
> @@ -914,7 +866,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>                         return ret;
>                 }
>
> -               single_dpm_table = &(dpm_table->fclk_table);
> +               single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
>                 ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
>                 if (ret) {
>                         dev_err(smu->adev->dev, "Attempt to get fclk levels Failed!");
> @@ -937,20 +889,19 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>         return size;
>  }
>
> -static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
> -                                    uint32_t feature_mask)
> +static int arcturus_upload_dpm_level(struct smu_context *smu,
> +                                    bool max,
> +                                    uint32_t feature_mask,
> +                                    uint32_t level)
>  {
> -       struct arcturus_single_dpm_table *single_dpm_table;
> -       struct arcturus_dpm_table *dpm_table =
> +       struct smu_11_0_dpm_context *dpm_context =
>                         smu->smu_dpm.dpm_context;
>         uint32_t freq;
>         int ret = 0;
>
>         if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
>             (feature_mask & FEATURE_DPM_GFXCLK_MASK)) {
> -               single_dpm_table = &(dpm_table->gfx_table);
> -               freq = max ? single_dpm_table->dpm_state.soft_max_level :
> -                       single_dpm_table->dpm_state.soft_min_level;
> +               freq = dpm_context->dpm_tables.gfx_table.dpm_levels[level].value;
>                 ret = smu_send_smc_msg_with_param(smu,
>                         (max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
>                         (PPCLK_GFXCLK << 16) | (freq & 0xffff),
> @@ -964,9 +915,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
>
>         if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
>             (feature_mask & FEATURE_DPM_UCLK_MASK)) {
> -               single_dpm_table = &(dpm_table->mem_table);
> -               freq = max ? single_dpm_table->dpm_state.soft_max_level :
> -                       single_dpm_table->dpm_state.soft_min_level;
> +               freq = dpm_context->dpm_tables.uclk_table.dpm_levels[level].value;
>                 ret = smu_send_smc_msg_with_param(smu,
>                         (max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
>                         (PPCLK_UCLK << 16) | (freq & 0xffff),
> @@ -980,9 +929,7 @@ static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
>
>         if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT) &&
>             (feature_mask & FEATURE_DPM_SOCCLK_MASK)) {
> -               single_dpm_table = &(dpm_table->soc_table);
> -               freq = max ? single_dpm_table->dpm_state.soft_max_level :
> -                       single_dpm_table->dpm_state.soft_min_level;
> +               freq = dpm_context->dpm_tables.soc_table.dpm_levels[level].value;
>                 ret = smu_send_smc_msg_with_param(smu,
>                         (max ? SMU_MSG_SetSoftMaxByFreq : SMU_MSG_SetSoftMinByFreq),
>                         (PPCLK_SOCCLK << 16) | (freq & 0xffff),
> @@ -1000,8 +947,8 @@ static int arcturus_upload_dpm_level(struct smu_context *smu, bool max,
>  static int arcturus_force_clk_levels(struct smu_context *smu,
>                         enum smu_clk_type type, uint32_t mask)
>  {
> -       struct arcturus_dpm_table *dpm_table;
> -       struct arcturus_single_dpm_table *single_dpm_table;
> +       struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
> +       struct smu_11_0_dpm_table *single_dpm_table = NULL;
>         uint32_t soft_min_level, soft_max_level;
>         uint32_t smu_version;
>         int ret = 0;
> @@ -1021,12 +968,9 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
>         soft_min_level = mask ? (ffs(mask) - 1) : 0;
>         soft_max_level = mask ? (fls(mask) - 1) : 0;
>
> -       dpm_table = smu->smu_dpm.dpm_context;
> -
>         switch (type) {
>         case SMU_SCLK:
> -               single_dpm_table = &(dpm_table->gfx_table);
> -
> +               single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
>                 if (soft_max_level >= single_dpm_table->count) {
>                         dev_err(smu->adev->dev, "Clock level specified %d is over max allowed %d\n",
>                                         soft_max_level, single_dpm_table->count - 1);
> @@ -1034,18 +978,19 @@ static int arcturus_force_clk_levels(struct smu_context *smu,
>                         break;
>                 }
>
> -               single_dpm_table->dpm_state.soft_min_level =
> -                       single_dpm_table->dpm_levels[soft_min_level].value;
> -               single_dpm_table->dpm_state.soft_max_level =
> -                       single_dpm_table->dpm_levels[soft_max_level].value;
> -
> -               ret = arcturus_upload_dpm_level(smu, false, FEATURE_DPM_GFXCLK_MASK);
> +               ret = arcturus_upload_dpm_level(smu,
> +                                               false,
> +                                               FEATURE_DPM_GFXCLK_MASK,
> +                                               soft_min_level);
>                 if (ret) {
>                         dev_err(smu->adev->dev, "Failed to upload boot level to lowest!\n");
>                         break;
>                 }
>
> -               ret = arcturus_upload_dpm_level(smu, true, FEATURE_DPM_GFXCLK_MASK);
> +               ret = arcturus_upload_dpm_level(smu,
> +                                               true,
> +                                               FEATURE_DPM_GFXCLK_MASK,
> +                                               soft_max_level);
>                 if (ret)
>                         dev_err(smu->adev->dev, "Failed to upload dpm max level to highest!\n");
>
> @@ -1256,8 +1201,7 @@ static int arcturus_get_fan_speed_percent(struct smu_context *smu,
>         return ret;
>  }
>
> -
> -static uint32_t arcturus_find_lowest_dpm_level(struct arcturus_single_dpm_table *table)
> +static uint32_t arcturus_find_lowest_dpm_level(struct smu_11_0_dpm_table *table)
>  {
>         uint32_t i;
>
> @@ -1274,7 +1218,7 @@ static uint32_t arcturus_find_lowest_dpm_level(struct arcturus_single_dpm_table
>  }
>
>  static uint32_t arcturus_find_highest_dpm_level(struct smu_context *smu,
> -                                               struct arcturus_single_dpm_table *table)
> +                                               struct smu_11_0_dpm_table *table)
>  {
>         int i = 0;
>
> @@ -1299,34 +1243,33 @@ static uint32_t arcturus_find_highest_dpm_level(struct smu_context *smu,
>         return i;
>  }
>
> -
> -
>  static int arcturus_force_dpm_limit_value(struct smu_context *smu, bool highest)
>  {
> -       struct arcturus_dpm_table *dpm_table =
> -               (struct arcturus_dpm_table *)smu->smu_dpm.dpm_context;
> +       struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
>         struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(smu->adev, 0);
>         uint32_t soft_level;
>         int ret = 0;
>
>         /* gfxclk */
>         if (highest)
> -               soft_level = arcturus_find_highest_dpm_level(smu, &(dpm_table->gfx_table));
> +               soft_level = arcturus_find_highest_dpm_level(smu, &(dpm_context->dpm_tables.gfx_table));
>         else
> -               soft_level = arcturus_find_lowest_dpm_level(&(dpm_table->gfx_table));
> +               soft_level = arcturus_find_lowest_dpm_level(&(dpm_context->dpm_tables.gfx_table));
>
> -       dpm_table->gfx_table.dpm_state.soft_min_level =
> -               dpm_table->gfx_table.dpm_state.soft_max_level =
> -               dpm_table->gfx_table.dpm_levels[soft_level].value;
> -
> -       ret = arcturus_upload_dpm_level(smu, false, FEATURE_DPM_GFXCLK_MASK);
> +       ret = arcturus_upload_dpm_level(smu,
> +                                       false,
> +                                       FEATURE_DPM_GFXCLK_MASK,
> +                                       soft_level);
>         if (ret) {
>                 dev_err(smu->adev->dev, "Failed to upload boot level to %s!\n",
>                                 highest ? "highest" : "lowest");
>                 return ret;
>         }
>
> -       ret = arcturus_upload_dpm_level(smu, true, FEATURE_DPM_GFXCLK_MASK);
> +       ret = arcturus_upload_dpm_level(smu,
> +                                       true,
> +                                       FEATURE_DPM_GFXCLK_MASK,
> +                                       soft_level);
>         if (ret) {
>                 dev_err(smu->adev->dev, "Failed to upload dpm max level to %s!\n!",
>                                 highest ? "highest" : "lowest");
> @@ -1345,27 +1288,29 @@ static int arcturus_force_dpm_limit_value(struct smu_context *smu, bool highest)
>
>  static int arcturus_unforce_dpm_levels(struct smu_context *smu)
>  {
> -       struct arcturus_dpm_table *dpm_table =
> -               (struct arcturus_dpm_table *)smu->smu_dpm.dpm_context;
> +       struct smu_11_0_dpm_context *dpm_context =
> +               (struct smu_11_0_dpm_context *)smu->smu_dpm.dpm_context;
>         struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(smu->adev, 0);
>         uint32_t soft_min_level, soft_max_level;
>         int ret = 0;
>
>         /* gfxclk */
> -       soft_min_level = arcturus_find_lowest_dpm_level(&(dpm_table->gfx_table));
> -       soft_max_level = arcturus_find_highest_dpm_level(smu, &(dpm_table->gfx_table));
> -       dpm_table->gfx_table.dpm_state.soft_min_level =
> -               dpm_table->gfx_table.dpm_levels[soft_min_level].value;
> -       dpm_table->gfx_table.dpm_state.soft_max_level =
> -               dpm_table->gfx_table.dpm_levels[soft_max_level].value;
> -
> -       ret = arcturus_upload_dpm_level(smu, false, FEATURE_DPM_GFXCLK_MASK);
> +       soft_min_level = arcturus_find_lowest_dpm_level(&(dpm_context->dpm_tables.gfx_table));
> +       soft_max_level = arcturus_find_highest_dpm_level(smu, &(dpm_context->dpm_tables.gfx_table));
> +
> +       ret = arcturus_upload_dpm_level(smu,
> +                                       false,
> +                                       FEATURE_DPM_GFXCLK_MASK,
> +                                       soft_min_level);
>         if (ret) {
>                 dev_err(smu->adev->dev, "Failed to upload DPM Bootup Levels!");
>                 return ret;
>         }
>
> -       ret = arcturus_upload_dpm_level(smu, true, FEATURE_DPM_GFXCLK_MASK);
> +       ret = arcturus_upload_dpm_level(smu,
> +                                       true,
> +                                       FEATURE_DPM_GFXCLK_MASK,
> +                                       soft_max_level);
>         if (ret) {
>                 dev_err(smu->adev->dev, "Failed to upload DPM Max Levels!");
>                 return ret;
> @@ -1388,18 +1333,15 @@ arcturus_get_profiling_clk_mask(struct smu_context *smu,
>                                 uint32_t *mclk_mask,
>                                 uint32_t *soc_mask)
>  {
> -       struct arcturus_dpm_table *dpm_table =
> -               (struct arcturus_dpm_table *)smu->smu_dpm.dpm_context;
> -       struct arcturus_single_dpm_table *gfx_dpm_table;
> -       struct arcturus_single_dpm_table *mem_dpm_table;
> -       struct arcturus_single_dpm_table *soc_dpm_table;
> +       struct smu_11_0_dpm_context *dpm_context =
> +               (struct smu_11_0_dpm_context *)smu->smu_dpm.dpm_context;
> +       struct smu_11_0_dpm_table *gfx_dpm_table;
> +       struct smu_11_0_dpm_table *mem_dpm_table;
> +       struct smu_11_0_dpm_table *soc_dpm_table;
>
> -       if (!smu->smu_dpm.dpm_context)
> -               return -EINVAL;
> -
> -       gfx_dpm_table = &dpm_table->gfx_table;
> -       mem_dpm_table = &dpm_table->mem_table;
> -       soc_dpm_table = &dpm_table->soc_table;
> +       gfx_dpm_table = &dpm_context->dpm_tables.gfx_table;
> +       mem_dpm_table = &dpm_context->dpm_tables.uclk_table;
> +       soc_dpm_table = &dpm_context->dpm_tables.soc_table;
>
>         *sclk_mask = 0;
>         *mclk_mask = 0;
> @@ -2153,7 +2095,6 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
>         return ret;
>  }
>
> -
>  static void arcturus_fill_eeprom_i2c_req(SwI2cRequest_t  *req, bool write,
>                                   uint8_t address, uint32_t numbytes,
>                                   uint8_t *data)
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
