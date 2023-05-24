Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F074C7EE2C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 09:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B319710E608;
	Wed, 24 May 2023 09:46:49 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF25410E06C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 06:38:00 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so351620f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684910278; x=1687502278;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GNqPpLwpUNEQmXIbMXpony0Q3J1hvpdlnn2gNOvSEkU=;
 b=eBV9CCWeXbqTkBiRKcW0YE6OHVd5JP0ZkvkC1PQLb2KXPOl0/aY4SR/e+QYbwt8LuW
 44CZ/tnqKnoSXxBczdJidumR8kA0hXBQKOZPuagjMz9/sgHWtDxotP/Na9NJUz0hlDLn
 3UC3Rj6m1IXVYifh96isRzU7e8Hyoid4L/orSVphSkBdUcvY+Vmyjjtc7eVxAlCRrUNu
 cafgBSQ6YCkQr3RkVxezBb7ucgMf4Ppj/Vuw4VsURwc9ZFybe4ewhgZU7M7OfQqMGe7A
 U7JCi8M7khnpKGqiylBXozPzb5McOH0oZ9I4fCQOosD3pGbT9sTOGei/u4TAHGrnjNm7
 89kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684910278; x=1687502278;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GNqPpLwpUNEQmXIbMXpony0Q3J1hvpdlnn2gNOvSEkU=;
 b=jjviiaEoSDwdsSk/Ci3toIKb1OKcdtKvjb4Q5mvW0lkmmyKgwfPEh3u6RG7xbGQaSp
 kEDcAC3OmD3bcRxNrhLk3xa+drIRCmWeMg5BS/tkNBolE4BVz4K3BIzqsCbAeanobS/H
 wiZTjSu0Ib1Z0Z1X2mqTZeFAW56/A/dYgSE6wwoRLMt4jCER1MCJtdZGlY8q08xbdCku
 42D+9j9fRFbKLhZVBEbgjlNEgbLC38VN2P+BUad1GY9R1gbmbPzNOtgfSiyAkHLiS0Nx
 anA1bjJNCZTTMAyPm+HIy5n0mxUTQeZETmvhrbHbXwsED4rhL84bANP53TnrQlfpVhTr
 RqCg==
X-Gm-Message-State: AC+VfDxRunBcCgA51m+HT0nPBwk2mfUerzxyHpLvtiaHZ6kWXSge4P4H
 yMvVhrSju+Y9DG/+R5kgxbkXbA==
X-Google-Smtp-Source: ACHHUZ6cNQjohZAljeAoPsHQQKUlKP7lpzOc88Wni8LvXQLBz9/k3UkOVzlzgW8gQdSBxbaB8WTWOg==
X-Received: by 2002:adf:f3cd:0:b0:307:a4ee:4a25 with SMTP id
 g13-20020adff3cd000000b00307a4ee4a25mr11438658wrp.28.1684910277820; 
 Tue, 23 May 2023 23:37:57 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 m13-20020adfe94d000000b002fda1b12a0bsm13521807wrn.2.2023.05.23.23.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 23:37:56 -0700 (PDT)
Date: Wed, 24 May 2023 09:37:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: qingqing.zhuo@amd.com
Subject: [bug report] drm/amd/display: Clean FPGA code in dc
Message-ID: <37aa75c2-ebd3-47b3-b1c7-9fc88d68a035@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 24 May 2023 09:46:48 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Qingqing Zhuo,

The patch 00df97e1df57: "drm/amd/display: Clean FPGA code in dc" from
Mar 16, 2023, leads to the following Smatch static checker warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c:775 rn_clk_mgr_construct()
warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 743)

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:731
vg_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 717)

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c:834
dcn314_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 773)

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:782
dcn31_clk_mgr_construct() warn: variable dereferenced before check 'ctx->dc_bios->integrated_info' (see line 721)

Also some indenting stuff:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/dcn314_fpu.c:269 dcn314_update_bw_bounding_box_fpu()
warn: inconsistent indenting

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dpms.c:2377 link_set_dpms_on()
warn: inconsistent indenting

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c
    698 void rn_clk_mgr_construct(
    699                 struct dc_context *ctx,
    700                 struct clk_mgr_internal *clk_mgr,
    701                 struct pp_smu_funcs *pp_smu,
    702                 struct dccg *dccg)
    703 {
    704         struct dc_debug_options *debug = &ctx->dc->debug;
    705         struct dpm_clocks clock_table = { 0 };
    706         enum pp_smu_status status = 0;
    707         int is_green_sardine = 0;
    708         struct clk_log_info log_info = {0};
    709 
    710 #if defined(CONFIG_DRM_AMD_DC_FP)
    711         is_green_sardine = ASICREV_IS_GREEN_SARDINE(ctx->asic_id.hw_internal_rev);
    712 #endif
    713 
    714         clk_mgr->base.ctx = ctx;
    715         clk_mgr->base.funcs = &dcn21_funcs;
    716 
    717         clk_mgr->pp_smu = pp_smu;
    718 
    719         clk_mgr->dccg = dccg;
    720         clk_mgr->dfs_bypass_disp_clk = 0;
    721 
    722         clk_mgr->dprefclk_ss_percentage = 0;
    723         clk_mgr->dprefclk_ss_divider = 1000;
    724         clk_mgr->ss_on_dprefclk = false;
    725         clk_mgr->dfs_ref_freq_khz = 48000;
    726 
    727         clk_mgr->smu_ver = rn_vbios_smu_get_smu_version(clk_mgr);
    728 
    729         clk_mgr->periodic_retraining_disabled = rn_vbios_smu_is_periodic_retraining_disabled(clk_mgr);
    730 
    731         /* SMU Version 55.51.0 and up no longer have an issue
    732          * that needs to limit minimum dispclk */
    733         if (clk_mgr->smu_ver >= SMU_VER_55_51_0)
    734                 debug->min_disp_clk_khz = 0;
    735 
    736         /* TODO: Check we get what we expect during bringup */
    737         clk_mgr->base.dentist_vco_freq_khz = get_vco_frequency_from_reg(clk_mgr);
    738 
    739         /* in case we don't get a value from the register, use default */
    740         if (clk_mgr->base.dentist_vco_freq_khz == 0)
    741                 clk_mgr->base.dentist_vco_freq_khz = 3600000;
    742 
    743         if (ctx->dc_bios->integrated_info->memory_type == LpDdr4MemType) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This dereference was in an if statement before so Smatch didn't
trigger a warning.

    744                 if (clk_mgr->periodic_retraining_disabled) {
    745                         rn_bw_params.wm_table = lpddr4_wm_table_with_disabled_ppt;
    746                 } else {
    747                         if (is_green_sardine)
    748                                 rn_bw_params.wm_table = lpddr4_wm_table_gs;
    749                         else
    750                                 rn_bw_params.wm_table = lpddr4_wm_table_rn;
    751                 }
    752         } else {
    753                 if (is_green_sardine)
    754                         rn_bw_params.wm_table = ddr4_wm_table_gs;
    755                 else {
    756                         if (ctx->dc->config.is_single_rank_dimm)
    757                                 rn_bw_params.wm_table = ddr4_1R_wm_table_rn;
    758                         else
    759                                 rn_bw_params.wm_table = ddr4_wm_table_rn;
    760                 }
    761         }
    762         /* Saved clocks configured at boot for debug purposes */
    763         rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
    764 
    765         clk_mgr->base.dprefclk_khz = 600000;
    766         dce_clock_read_ss_info(clk_mgr);
    767 
    768 
    769         clk_mgr->base.bw_params = &rn_bw_params;
    770 
    771         if (pp_smu && pp_smu->rn_funcs.get_dpm_clock_table) {
    772                 status = pp_smu->rn_funcs.get_dpm_clock_table(&pp_smu->rn_funcs.pp_smu, &clock_table);
    773 
    774                 if (status == PP_SMU_RESULT_OK &&
--> 775                     ctx->dc_bios && ctx->dc_bios->integrated_info) {
                            ^^^^^^^^^^^^
Checking for NULL after a dereference doesn't work.

    776                         rn_clk_mgr_helper_populate_bw_params (clk_mgr->base.bw_params, &clock_table, ctx->dc_bios->integrated_info);
    777                         /* treat memory config as single channel if memory is asymmetrics. */
    778                         if (ctx->dc->config.is_asymmetric_memory)
    779                                 clk_mgr->base.bw_params->num_channels = 1;
    780                 }
    781         }
    782 
    783         /* enable powerfeatures when displaycount goes to 0 */
    784         if (clk_mgr->smu_ver >= 0x00371500)
    785                 rn_vbios_smu_enable_48mhz_tmdp_refclk_pwrdwn(clk_mgr, !debug->disable_48mhz_pwrdwn);
    786 }

regards,
dan carpenter
