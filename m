Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53749C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 13:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5ACB10E5B8;
	Fri, 20 Oct 2023 13:58:56 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFA710E5A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 12:39:27 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso5978115e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697805566; x=1698410366; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=15enNSxmYBZ09EDrUSrkXsq1f4PGgu82HzQdMjX/AMQ=;
 b=Ke8L4cQRz83SIRNaoAY/Y16FKGUswbLKyfGJybfSFmwUjjLzZWdcSbjX2H+ZHBk8GJ
 9ravH00YAMr8D6THIEm4JHzICfhPSoQBXNOL/dlh79fY3gfc1KlYAFWIJXZfOnH0lMsc
 8N8MqdWUlOr3F4XD1E9QsREVvU/uuAiqWapcXc4uLX0rkNBhl3PvLL8MzgaMlPmXUX3t
 tFdAk49VaWE+ub1Sm1On/za+GyFNZ+34wlUkO0sUYffW5Sid1rJfkcxEhW3/AOUF6YmR
 cQ6N3lBqmRS0mPOmCQPB0peFoYLsjtdRUGdRrbREx6ycTsw7FoH6bc1mjgI9m2lj3D55
 vuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697805566; x=1698410366;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=15enNSxmYBZ09EDrUSrkXsq1f4PGgu82HzQdMjX/AMQ=;
 b=RYFzz2kOTz4267deqjfVYPSov3USPvULNi97nTbLvxV1MqoLmMByaIEoG9df9AvslR
 ILjg0LkW03j9S7IFauK1nRk9DwUPyzVDEmflcwsCcllKGutuafZ0FKjZSXhNtZJKaklR
 lES7LUa+s2TO0UleO2zDsOUpA02TBOC9aLBjiYMI+MkgPQPa/VVU5RgsPK3HMkTp2lo3
 jh5veW6FaRpkVhap/HmdqvlB406GhfOzSIc8f10JZHGyPWIFDE4weChv3vPBSQVihe90
 lw3NdvlMJlLhJqthb4ebSnz7Gm2KNdsKTXqrZCF0X17Si4jObMck3fW/AlLgQMH2Rea/
 sC1g==
X-Gm-Message-State: AOJu0Ywn9fvxAIVUbgR6vxFV+GoczExGODMWObDD6SbLjwQ0n1hodRKV
 4TmR8TwuvM/pIDVO9lnzYoIpov4Oxtm2VfMhsBQ=
X-Google-Smtp-Source: AGHT+IFlqsuMyVfd+sNpWGOr/lrbiQSjStgOu1onQ4U/5ImnlCQYQo4rUooAflboI+ZbC6E8xkK3jw==
X-Received: by 2002:adf:e808:0:b0:32d:9a36:b518 with SMTP id
 o8-20020adfe808000000b0032d9a36b518mr1228679wrm.69.1697805565928; 
 Fri, 20 Oct 2023 05:39:25 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 h2-20020a5d5042000000b0032d886039easm1627746wrt.14.2023.10.20.05.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 05:39:25 -0700 (PDT)
Date: Fri, 20 Oct 2023 15:39:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qingqing.Zhuo@amd.com
Subject: [bug report] drm/amd/display: Introduce DML2
Message-ID: <5a81e878-fe41-414f-9a21-0379656a9e63@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 20 Oct 2023 13:58:55 +0000
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

The patch 7966f319c66d: "drm/amd/display: Introduce DML2" from Jul
28, 2023 (linux-next), leads to the following Smatch static checker
warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:2748 TruncToValidBPP()
	warn: inconsistent indenting

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c
    2736                 MinDSCBPP = 8;
    2737                 MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
    2738         } else {
    2739                 if (Output == dml_hdmi) {
    2740                         NonDSCBPP0 = 24;
    2741                         NonDSCBPP1 = 24;
    2742                         NonDSCBPP2 = 24;
    2743                 } else {
    2744                         NonDSCBPP0 = 16;
    2745                         NonDSCBPP1 = 20;
    2746                         NonDSCBPP2 = 24;
    2747         }
--> 2748         if (Format == dml_n422) {

This code should be indented another tab.

    2749                 MinDSCBPP = 7;
    2750                         MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
    2751                 } else {
    2752                         MinDSCBPP = 8;
    2753                         MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16.0;
    2754                 }
    2755         }
    2756 
    2757         if (Output == dml_dp2p0) {
    2758                 MaxLinkBPP = LinkBitRate * Lanes / PixelClock * 128.0 / 132.0 * 383.0 / 384.0 * 65536.0 / 65540.0;

There are a bunch of other warnings as well.  Too many to review.

regards,
dan carpenter

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2903 dm_resume() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dce_calcs.c:914 calculate_bandwidth() error: uninitialized symbol 'max_chunks_fbc_mode'.
drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dce_calcs.c:917 calculate_bandwidth() error: uninitialized symbol 'max_chunks_fbc_mode'.
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c:702 dcn35_clk_mgr_helper_populate_bw_params() warn: if statement not indented
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:1207 CalculatePrefetchSchedule() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:1288 CalculatePrefetchSchedule() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:1455 CalculatePrefetchSchedule() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:1558 CalculatePrefetchSchedule() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:2645 CalculateVMAndRowBytes() warn: previously used '*PixelPTEReqWidth' as divisor (see line 2634)
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:2748 TruncToValidBPP() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:2750 TruncToValidBPP() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:2812 TruncToValidBPP() warn: ignoring unreachable code.
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:3171 CalculateDCFCLKDeepSleep() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:3749 CalculateVMGroupAndRequestTimes() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:4051 CalculateStutterEfficiency() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:4201 CalculateSwathAndDETConfiguration() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:4247 CalculateSwathAndDETConfiguration() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:4784 CalculateSurfaceSizeInMall() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:4789 CalculateSurfaceSizeInMall() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:5196 CalculateVMRowAndSwath() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6013 CalculatePrefetchBandwithSupport() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6195 CalculateMaxVStartup() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6916 dml_core_mode_support() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:7206 dml_core_mode_support() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:7455 dml_core_mode_support() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:7869 dml_core_mode_support() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:7940 dml_core_mode_support() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8366 dml_core_mode_programming() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:9345 dml_core_mode_programming() warn: for statement not indented
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_util.c:116 dml_floor() warn: if statement not indented
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_util.c:150 dml_max() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_util.c:731 dml_get_num_active_planes() warn: if statement not indented
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c:459 dml2_svp_drr_schedulable() error: we previously assumed 'pipe->stream' could be null (see line 450)
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c:549 subvp_vblank_schedulable() error: we previously assumed 'subvp_pipe' could be null (see line 541)
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_mall_phantom.c:549 subvp_vblank_schedulable() warn: pointer dereferenced without being set 'subvp_pipe'
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_policy.c:206 dml2_policy_build_synthetic_soc_states() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_translation_helper.c:604 populate_dml_output_cfg_from_stream_state() warn: ignoring unreachable code.
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml2_wrapper.c:137 optimize_configuration() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:1014 dce110_edp_backlight_control() error: we previously assumed 'link->panel_cntl' could be null (see line 971)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1495 dcn10_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 1491)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1858 dcn10_set_output_transfer_func() warn: variable dereferenced before check 'stream' (see line 1841)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn201/dcn201_hwseq.c:240 dcn201_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 228)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c:1803 dcn20_program_pipe() error: we previously assumed 'pipe_ctx->plane_state' could be null (see line 1762)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c:2080 dcn20_post_unlock_program_front_end() error: we previously assumed 'hwseq' could be null (see line 2074)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c:851 dcn20_enable_stream_timing() warn: variable dereferenced before check 'pipe_ctx->stream_res.tg' (see line 758)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn21/dcn21_hwseq.c:249 dcn21_set_backlight_level() error: we previously assumed 'panel_cntl' could be null (see line 238)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:510 dcn30_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 480)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:635 dcn30_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 476)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:777 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream' could be null (see line 761)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:779 dcn30_apply_idle_power_optimizations() error: we previously assumed 'plane' could be null (see line 761)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn31/dcn31_hwseq.c:135 dcn31_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 126)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn31/dcn31_hwseq.c:257 dcn31_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 117)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:266 dcn32_apply_idle_power_optimizations() warn: variable dereferenced before check 'dc->current_state' (see line 258)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:802 dcn32_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 779)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn32/dcn32_hwseq.c:952 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 775)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:159 dcn35_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 150)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:206 dcn35_init_hw() error: we previously assumed 'res_pool->hubbub' could be null (see line 159)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:285 dcn35_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 136)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:973 dcn35_calc_blocks_to_gate() error: we previously assumed 'pipe_ctx->plane_res.hubp' could be null (see line 969)
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:976 dcn35_calc_blocks_to_gate() warn: always true condition '(pipe_ctx->plane_res.mpcc_inst >= 0) => (0-255 >= 0)'

regards,
dan carpenter
