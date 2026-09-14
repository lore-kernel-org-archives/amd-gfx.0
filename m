Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C6CC88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 12:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA03110EE34;
	Mon, 14 Sep 2026 12:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zi8Agn9d";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A8010ED54
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 11:01:27 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a9ba73bee8so1385468a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789383686; x=1789988486; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IWs0iOTBLkOtRO6p+tIihi90CDGL/D5Gtff9wqnHqAc=;
 b=Zi8Agn9dgTrAEIZQoo6aLGZXWMbt+OVqidk1eg/TjXN4R6Ml3QvYsGLis8dThYXGgZ
 gkA/chqt2sXGw/nln+oBRZCEQ615NH7ZNYCcES1X2PAiOuHyHbCGCMjBmPu75vdV3bXn
 MhKQmENn3rQFW3sKI1gqS8+JJrjW2m+bxFFmq1HjYu+Dpztaun05KAGrsusBNYNOUgWx
 KGdBPIqeASe9RPr4lU1jULAIhTr26PwfULcxgvIrac59UNyDvDKzROgUXv8RL8Fl97BI
 M90xBphpKqu01GOMqUCGeHru/xs5BeESB6GKkg0y8EYP87AptTpwQJ5OiMqCz9Ukkk62
 /92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789383686; x=1789988486;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IWs0iOTBLkOtRO6p+tIihi90CDGL/D5Gtff9wqnHqAc=;
 b=BAuCFoxvokkPeSyjkdjJXqgRIcvhsT7YaiCpn37MN1q/KPrn1YxCFt1xw+6eTLUz4g
 3xFC80CyBYdmxYHGrrmhWFeeHVXU5ePaZuD+X8cPasFzKUE5UXDUOikGcssIWRhg6OhH
 wXkM9QCUDKzJWnzIbpEZljsO6M/4omqUmkis/6hJ1dwQDO4gLREKQYl/ZuU1NeQMiaha
 82jdoUaZi1cDBykImWgYVumLR3zmogZAM3IpUIb1oD/381haT5T+7IPx5rL3IEJUR+VI
 b0j/1cWfGBKyj1POOxBiaMbL01cqkerN0M0uzpttKJ81lUlul909BB/K6z1F+a7zwcF6
 YxKA==
X-Gm-Message-State: AFuF++kkj6EPZDfHwLy2/um6amOxk2vuD78F++jFceC64yqRnRJMGRpK
 6CuoxlINJX7LXfAdcAPRr/Vqd4bjSk/BZ3/E2BYy9gdjXZ5DsqfPNGlT
X-Gm-Gg: AYBFou2MqK70A0187fsN84nXjaTrOiegaqMU+Ww+b20KPdjkLNmZy5Dro3pcLqHoR2r
 jwTgpTMF3bSR/bDGLcC1mbzhQNL95Q1nqFvUxv3vPw44gURnF5n7yRHzr00gjRUN7PL3rEj7few
 /C2r+RKvK+ZOxvoBt2cuZk0AZSQPdxlENBPXSAGM3pF3IpbYQkDJhPiTvjUMvGNG8rdau2gDjkk
 9EiXSC83du7P1Yb5RyWBENySsZLpLq0eaYk+SiMYVMbKbNGT7at+jQN6MfqY9CmTZ52qWhsOJ5E
 5ABI0+WRicuj/aiZ360VSy1IVZc+HqK2DQeksAXz9c/oE+gtAIY5yOxUlCrEzkKnCQsbereLVD1
 NyA+DttSMUVcwg4ZrVaByJxvELwKdQ+GvKexxiWt/0u0jl1gj2W60ZfQxEd2wOrQDqtiEvi9SmS
 x9i6KfT7XYw8csgHVW3/Lkf9W85L/vADNtWGqdZ7i+Pwq0yHvSjZXP9QGpVMCEWxkw/WxYulSG2
 zbnRw==
X-Received: by 2002:a05:6402:a0ce:b0:6a6:32e3:9b9 with SMTP id
 4fb4d7f45d1cf-6a9f652d87fmr1251786a12.9.1789383685472; 
 Mon, 14 Sep 2026 04:01:25 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b58f8beesm3875783a12.8.2026.09.14.04.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 04:01:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:01:19 +0300
From: Dan Carpenter <error27@gmail.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Add new sources for DCN6
Message-ID: <aqfT_w8H_hN1ywfY@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 14 Sep 2026 12:47:06 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Aurabindo Pillai,

Commit 7f7d7ea1fa51 ("drm/amd/display: Add new sources for DCN6")
from Jul 22, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn50/dcn50_hwseq.c:641 dcn50_init_hw()
	error: we previously assumed 'dc->clk_mgr' could be null (see line 541)

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn50/dcn50_hwseq.c
    529 void dcn50_init_hw(struct dc *dc)
    530 {
    531         struct abm **abms = dc->res_pool->multiple_abms;
    532         struct dce_hwseq *hws = dc->hwseq;
    533         struct dc_bios *dcb = dc->ctx->dc_bios;
    534         struct resource_pool *res_pool = dc->res_pool;
    535         unsigned int i;
    536         unsigned int edp_num;
    537         uint32_t backlight = MAX_BACKLIGHT_LEVEL;
    538         uint32_t user_level = MAX_BACKLIGHT_LEVEL;
    539         int current_dchub_ref_freq = 0;
    540 
    541         if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
                    ^^^^^^^^^^^
Check for NULL

    542                 dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
    543 
    544                 // mark dcmode limits present if any clock has distinct AC and DC values from SMU
    545                 dc->caps.dcmode_power_limits_present = dc->clk_mgr->funcs->is_dc_mode_present &&
    546                                 dc->clk_mgr->funcs->is_dc_mode_present(dc->clk_mgr);
    547         }
    548 
    549         // Initialize the dccg
    550         if (res_pool->dccg->funcs->dccg_init)
    551                 res_pool->dccg->funcs->dccg_init(res_pool->dccg);
    552 
    553         // Disable DMUB Initialization until IPS state programming is finalized
    554         //if (!dcb->funcs->is_accelerated_mode(dcb)) {
    555         //        hws->funcs.bios_golden_init(dc);
    556         //}
    557 
    558         // Set default OPTC memory power states
    559         if (dc->debug.enable_mem_low_power.bits.optc) {
    560                 // Shutdown when unassigned and light sleep in VBLANK
    561                 REG_SET_2(ODM_MEM_PWR_CTRL3, 0, ODM_MEM_UNASSIGNED_PWR_MODE, 3, ODM_MEM_VBLANK_PWR_MODE, 1);
    562         }
    563 
    564         if (dc->debug.enable_mem_low_power.bits.vga) {
    565                 // Power down VGA memory
    566                 REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
    567         }
    568 
    569         if (dc->ctx->dc_bios->fw_info_valid) {
    570                 res_pool->ref_clocks.xtalin_clock_inKhz =
    571                                 dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
    572 
    573                 if (res_pool->hubbub) {
    574                         (res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
    575                                         dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
    576                                         &res_pool->ref_clocks.dccg_ref_clock_inKhz);
    577 
    578                         current_dchub_ref_freq = res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
    579 
    580                         (res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
    581                                         res_pool->ref_clocks.dccg_ref_clock_inKhz,
    582                                         &res_pool->ref_clocks.dchub_ref_clock_inKhz);
    583                 } else {
    584                         // Not all ASICs have DCCG sw component
    585                         res_pool->ref_clocks.dccg_ref_clock_inKhz =
    586                                         res_pool->ref_clocks.xtalin_clock_inKhz;
    587                         res_pool->ref_clocks.dchub_ref_clock_inKhz =
    588                                         res_pool->ref_clocks.xtalin_clock_inKhz;
    589                 }
    590         } else
    591                 ASSERT_CRITICAL(false);
    592 
    593         for (i = 0; i < dc->link_count; i++) {
    594                 /* Power up AND update implementation according to the
    595                  * required signal (which may be different from the
    596                  * default signal on connector).
    597                  */
    598                 struct dc_link *link = dc->links[i];
    599 
    600                 link->link_enc->funcs->hw_init(link->link_enc);
    601 
    602                 /* Check for enabled DIG to identify enabled display */
    603                 if (link->link_enc->funcs->is_dig_enabled &&
    604                         link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
    605                         link->link_status.link_active = true;
    606                         link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
    607                         if (link->link_enc->funcs->fec_is_active &&
    608                                         link->link_enc->funcs->fec_is_active(link->link_enc))
    609                                 link->fec_state = dc_link_fec_enabled;
    610                 }
    611         }
    612 
    613         /* enable_power_gating_plane before dsc_pg_control because
    614          * FORCEON = 1 with hw default value on bootup, resume from s3
    615          */
    616         if (hws->funcs.enable_power_gating_plane)
    617                 hws->funcs.enable_power_gating_plane(dc->hwseq, true);
    618 
    619         /* we want to turn off all dp displays before doing detection */
    620         dc->link_srv->blank_all_dp_displays(dc);
    621 
    622         /* If taking control over from VBIOS, we may want to optimize our first
    623          * mode set, so we need to skip powering down pipes until we know which
    624          * pipes we want to use.
    625          * Otherwise, if taking control is not possible, we need to power
    626          * everything down.
    627          */
    628         if (dcb->funcs->is_accelerated_mode(dcb) || !dc->config.seamless_boot_edp_requested) {
    629                 /* Disable boot optimizations means power down everything including PHY, DIG,
    630                  * and OTG (i.e. the boot is not optimized because we do a full power down).
    631                  */
    632                 if (dc->hwss.enable_accelerated_mode && dc->debug.disable_boot_optimizations)
    633                         dc->hwss.enable_accelerated_mode(dc, dc->current_state);
    634                 else
    635                         hws->funcs.init_pipes(dc, dc->current_state);
    636 
    637                 if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
    638                         dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
    639                                         !dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
    640 
--> 641                 dcn50_initialize_min_clocks(dc);
                                                    ^^
Unchecked dereference.

    642 
    643                 /* On HW init, allow idle optimizations after pipes have been turned off.
    644                  *
    645                  * In certain D3 cases (i.e. BOCO / BOMACO) it's possible that hardware state
    646                  * is reset (i.e. not in idle at the time hw init is called), but software state
    647                  * still has idle_optimizations = true, so we must disable idle optimizations first
    648                  * (i.e. set false), then re-enable (set true).
    649                  */
    650                 dc_allow_idle_optimizations(dc, false);
    651                 dc_allow_idle_optimizations(dc, true);
    652         }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
