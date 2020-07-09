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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B69C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D3120774
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 20:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+dbCYhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D3120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D085D6EB31;
	Thu,  9 Jul 2020 20:41:23 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F0C6EB31
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 20:41:22 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id o8so3410961wmh.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jul 2020 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/GNc56K4NOgmQhQ/E9kgDE0qqAsYi4RQTuOuiza0imA=;
 b=q+dbCYhDHukt9ECBBZXC2sfj2oSu+wDdBFtkwODa8zlGOa/HbgejWHhQ/ilU2bkYtE
 KXGfx6/hIHsi9yFUkcPXv/KCmgfF5yng/qUydpJBr5tZ1BHel5MvV0RXJbGYSaXnvwvo
 dQfXertiDR4FEKTcW3UyqG0LoVfMpArkfn8EeTdzIUJvvSsT8XrieNuKHFid0leneviq
 LGlid4YZPXTKckLoSYzBSRsYlDdKjKwBE4kpGKK+BGyRqvXF9/Mxe9twRJKqtm/TleIR
 4fm8lzPCxNBkUPq5BL0xEIOP8W8c8WwYK7EqRHH64rTjBeSE1aamNoE3Jmkz2GSUOO8J
 fcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/GNc56K4NOgmQhQ/E9kgDE0qqAsYi4RQTuOuiza0imA=;
 b=m2zCU788XoIWDapSCKRTJq3r3tLZsEaHjoacVbBaEp7+isp0OSWmbepnNNQ65WfYlL
 XcENnL1/fu7rvEaJh0PHNmTHUyypXHX1OiTJ3a4fMXMaKT/jlKvGlHanahh1QIru0aKJ
 WstS7WHN4tRUvav1MgbcxnwV5Te701XN63yFkHF9oXfSTIdgaSR96A0MZpCjCIHu9vwv
 TBvBtWCWt4faOgWnQeoggeBOtUROmVDDo+zcxZFwXzqHjMh/WzI7eSzj+9rOG+L5Zsl1
 F9r7ErRXYobJJIHALY6Oi4fxCAALVZOfYsxj8Q2e7UIpvaQouKaRdXnzxlLqFwNDwlOr
 Z+nA==
X-Gm-Message-State: AOAM530lPbEp80PYtMr3pbaxbGmtljMr0SWNixvr84SnM6a2r2E+umcK
 VShQeU40Kl8mXp5NNywVnlNPOic4nYASVMTvbdzWam5D
X-Google-Smtp-Source: ABdhPJxpqwHDaNzglFstpcTlaybOkEzA1Xo0fo/5AjLEx6vG1HsF9qQPwG6M8p/zf7NowgCFSeeef/B2pino1XnzWeU=
X-Received: by 2002:a1c:dd09:: with SMTP id u9mr1710398wmg.70.1594327281586;
 Thu, 09 Jul 2020 13:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200703083303.478-1-evan.quan@amd.com>
 <20200703083303.478-4-evan.quan@amd.com>
In-Reply-To: <20200703083303.478-4-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jul 2020 16:41:10 -0400
Message-ID: <CADnq5_Mya7WFFJsWdxGSJ8Gbg97HU1cP6Qrd8W7Oz2rOG8o5Pw@mail.gmail.com>
Subject: Re: [PATCH 04/14] drm/amd/powerplay: update Sienna Cichlid default
 dpm table setup
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

On Fri, Jul 3, 2020 at 4:33 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Cache all clocks levels for every dpm table. They are needed
> by other APIs.
>
> Change-Id: Idaa853356720e48ab3279f420ba1ae18bb7de4fd
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 234 ++++++++++++++++--
>  1 file changed, 211 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> index f2bbe56798d7..d750d06378e9 100644
> --- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
> @@ -597,41 +597,229 @@ static int sienna_cichlid_allocate_dpm_context(struct smu_context *smu)
>
>  static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
>  {
> -       struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
> -       struct smu_table_context *table_context = &smu->smu_table;
> -       struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
> -       PPTable_t *driver_ppt = NULL;
> +       struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
> +       PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
> +       struct smu_11_0_dpm_table *dpm_table;
> +       int ret = 0;
>         int i;
>
> -        driver_ppt = table_context->driver_pptable;
> +       /* socclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.soc_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_SOCCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
> +
> +       /* gfxclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.gfx_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_GFXCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
> +
> +       /* uclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.uclk_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_UCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> -        dpm_context->dpm_tables.soc_table.min = driver_ppt->FreqTableSocclk[0];
> -        dpm_context->dpm_tables.soc_table.max = driver_ppt->FreqTableSocclk[NUM_SOCCLK_DPM_LEVELS - 1];
> +       /* fclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.fclk_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_FCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_FCLK].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> -        dpm_context->dpm_tables.gfx_table.min = driver_ppt->FreqTableGfx[0];
> -        dpm_context->dpm_tables.gfx_table.max = driver_ppt->FreqTableGfx[NUM_GFXCLK_DPM_LEVELS - 1];
> +       /* vclk0 dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.vclk_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_VCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_VCLK_0].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> -        dpm_context->dpm_tables.uclk_table.min = driver_ppt->FreqTableUclk[0];
> -        dpm_context->dpm_tables.uclk_table.max = driver_ppt->FreqTableUclk[NUM_UCLK_DPM_LEVELS - 1];
> +       /* vclk1 dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.vclk1_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_VCLK1,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_VCLK_1].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> -        dpm_context->dpm_tables.vclk_table.min = driver_ppt->FreqTableVclk[0];
> -        dpm_context->dpm_tables.vclk_table.max = driver_ppt->FreqTableVclk[NUM_VCLK_DPM_LEVELS - 1];
> +       /* dclk0 dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.dclk_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_DCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_DCLK_0].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> -        dpm_context->dpm_tables.dclk_table.min = driver_ppt->FreqTableDclk[0];
> -        dpm_context->dpm_tables.dclk_table.max = driver_ppt->FreqTableDclk[NUM_DCLK_DPM_LEVELS - 1];
> +       /* dclk1 dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.dclk1_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_DCLK1,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_DCLK_1].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> -        dpm_context->dpm_tables.dcef_table.min = driver_ppt->FreqTableDcefclk[0];
> -        dpm_context->dpm_tables.dcef_table.max = driver_ppt->FreqTableDcefclk[NUM_DCEFCLK_DPM_LEVELS - 1];
> +       /* dcefclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.dcef_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_DCEFCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_DCEFCLK].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> -        dpm_context->dpm_tables.pixel_table.min = driver_ppt->FreqTablePixclk[0];
> -        dpm_context->dpm_tables.pixel_table.max = driver_ppt->FreqTablePixclk[NUM_PIXCLK_DPM_LEVELS - 1];
> +       /* pixelclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.pixel_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_PIXCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_PIXCLK].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> -        dpm_context->dpm_tables.display_table.min = driver_ppt->FreqTableDispclk[0];
> -        dpm_context->dpm_tables.display_table.max = driver_ppt->FreqTableDispclk[NUM_DISPCLK_DPM_LEVELS - 1];
> +       /* displayclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.display_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_DISPCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_DISPCLK].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> -        dpm_context->dpm_tables.phy_table.min = driver_ppt->FreqTablePhyclk[0];
> -        dpm_context->dpm_tables.phy_table.max = driver_ppt->FreqTablePhyclk[NUM_PHYCLK_DPM_LEVELS - 1];
> +       /* phyclk dpm table setup */
> +       dpm_table = &dpm_context->dpm_tables.phy_table;
> +       if (smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT)) {
> +               ret = smu_v11_0_set_single_dpm_table(smu,
> +                                                    SMU_PHYCLK,
> +                                                    dpm_table);
> +               if (ret)
> +                       return ret;
> +               dpm_table->is_fine_grained =
> +                       !driver_ppt->DpmDescriptor[PPCLK_PHYCLK].SnapToDiscrete;
> +       } else {
> +               dpm_table->count = 1;
> +               dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
> +               dpm_table->dpm_levels[0].enabled = true;
> +               dpm_table->min = dpm_table->dpm_levels[0].value;
> +               dpm_table->max = dpm_table->dpm_levels[0].value;
> +       }
>
> +       /* lclk dpm table setup */
>         for (i = 0; i < MAX_PCIE_CONF; i++) {
>                 dpm_context->dpm_tables.pcie_table.pcie_gen[i] = driver_ppt->PcieGenSpeed[i];
>                 dpm_context->dpm_tables.pcie_table.pcie_lane[i] = driver_ppt->PcieLaneCount[i];
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
