Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB1EC4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 14:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA8F10EE5B;
	Thu,  1 Feb 2024 14:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TVMcHJsx";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7A610E39D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 12:19:10 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-51124d43943so1264513e87.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Feb 2024 04:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706789889; x=1707394689; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AaIt4D/tFtRubftGQdhmayByvnNDcJrz8tK0tc47yFk=;
 b=TVMcHJsxSjmT/bC9yzfjazXXP7M1qlp6CyhmQDKa/Ot+S4q7GSeO4vWBxDfi8gG0tl
 gKIN5pkQs40TPTQuFZV5ALYe9aV4s8d32H79l1U+9QZCQGn7fqxYUZNbrHAKcDwtCMgp
 pVcnaG0/EmAudWhKLW/EImkGg+ltGEfnVvcVWiLDg+2BoTlpp46BPmzB8xdockL+Ll0c
 ccfzYAYXxErqePKL7KzA6U1wLogn8X7LnG5pavCTg2YgMcc/irYBye2aegopqbllvhCu
 AHG+2TZLFiGSdMJL1kBRRoGJoWzvBKSz2T/ozm7I6hAzVmZ5ikr3vHJu8TU7kJXmmjOF
 1ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706789889; x=1707394689;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AaIt4D/tFtRubftGQdhmayByvnNDcJrz8tK0tc47yFk=;
 b=Hl1DNr0Ji1JZZJitNhyRtyE4V3C9K94pVFWH6tBbcCTKEYYlY+OwbAXuKnPwvTn1Kb
 TgWF+JvSYDkkX9lStXz5Azajwb1iUmgjHfhfUMexlWYY6lBq9wNNrSzbMCHl131Y3930
 8KQMhc9PT5DEKa+nOGLa88kDe/LABEv+dttrwsAAMO4kzCnLKyD+YKtFStgr1Jj4IIy/
 LajHuMWfaKR+yteuWCZYz/guTvFPrrVyxlnPDNzdJ1YoKFRy4Nh9SdMKDWs6LbFDQIh5
 oltPYJ0hq93yZ6tcuuUWJq0/IathDwzeoc3uF48+7LI++wbxvNnoBTCTZ2KuidK3E+Z5
 3Ggw==
X-Gm-Message-State: AOJu0YykwFTmLTk/Z+agsyA6eO/HRmO6X4LQcf2DTSFP+MOgW5VCXSfv
 dlS6zad5Lb07XTPvUP2SrumSpWtF1ZfBPV/r89tcXxbd5dNhe+8/GvHmGXrUBlwFr7X1XZbV5QU
 D
X-Google-Smtp-Source: AGHT+IFAYT2gYYnJ9Q5LUueTQwxTcUZO5JQ5HxQ8ouX7Dgj9/pPbfcJbFxqbL8qZPel7N5SejEfHMw==
X-Received: by 2002:a19:6754:0:b0:511:2a0f:9114 with SMTP id
 e20-20020a196754000000b005112a0f9114mr1774176lfj.7.1706789889004; 
 Thu, 01 Feb 2024 04:18:09 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWkrl4rJuuToz0pzVVIOPvLhp+oWsadmjo8j309UsQmD658kjMu2V2KCf4/WS004IAsBkF7N1Q+ind5W4EB6d7AREm+rhGs3fo=
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 lj7-20020a170907188700b00a366c9781b7sm1645100ejc.168.2024.02.01.04.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:18:08 -0800 (PST)
Date: Thu, 1 Feb 2024 15:18:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: bigeasy@linutronix.de
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amd/display: Simplify the per-CPU usage.
Message-ID: <e31dedcc-1aa8-4430-a2f5-9e37ca25410f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 01 Feb 2024 14:17:33 +0000
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

Hello Sebastian Andrzej Siewior,

The patch de5e73dc6baf: "drm/amd/display: Simplify the per-CPU
usage." from Sep 21, 2023 (linux-next), leads to the following Smatch
static checker warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn30/dcn30_resource.c:2385 dcn30_resource_construct() warn: sleeping in atomic context
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:2136 dcn32_resource_construct() warn: sleeping in atomic context

drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn30/dcn30_resource.c
    2263 static bool dcn30_resource_construct(
    2264         uint8_t num_virtual_links,
    2265         struct dc *dc,
    2266         struct dcn30_resource_pool *pool)
    2267 {
    2268         int i;
    2269         struct dc_context *ctx = dc->ctx;
    2270         struct irq_service_init_data init_data;
    2271         struct ddc_service_init_data ddc_init_data = {0};
    2272         uint32_t pipe_fuses = read_pipe_fuses(ctx);
    2273         uint32_t num_pipes = 0;
    2274 
    2275         if (!(pipe_fuses == 0 || pipe_fuses == 0x3e)) {
    2276                 BREAK_TO_DEBUGGER();
    2277                 dm_error("DC: Unexpected fuse recipe for navi2x !\n");
    2278                 /* fault to single pipe */
    2279                 pipe_fuses = 0x3e;
    2280         }
    2281 
    2282         DC_FP_START();
                 ^^^^^^^^^^^^^^
Preempt disabled here.

    2283 
    2284         ctx->dc_bios->regs = &bios_regs;
    2285 
    2286         pool->base.res_cap = &res_cap_dcn3;
    2287 
    2288         pool->base.funcs = &dcn30_res_pool_funcs;
    2289 
    2290         /*************************************************
    2291          *  Resource + asic cap harcoding                *
    2292          *************************************************/
    2293         pool->base.underlay_pipe_index = NO_UNDERLAY_PIPE;
    2294         pool->base.pipe_count = pool->base.res_cap->num_timing_generator;
    2295         pool->base.mpcc_count = pool->base.res_cap->num_timing_generator;
    2296         dc->caps.max_downscale_ratio = 600;
    2297         dc->caps.i2c_speed_in_khz = 100;
    2298         dc->caps.i2c_speed_in_khz_hdcp = 100; /*1.4 w/a not applied by default*/
    2299         dc->caps.max_cursor_size = 256;
    2300         dc->caps.min_horizontal_blanking_period = 80;
    2301         dc->caps.dmdata_alloc_size = 2048;
    2302         dc->caps.mall_size_per_mem_channel = 8;
    2303         /* total size = mall per channel * num channels * 1024 * 1024 */
    2304         dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel * dc->ctx->dc_bios->vram_info.num_chans * 1048576;
    2305         dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
    2306 
    2307         dc->caps.max_slave_planes = 2;
    2308         dc->caps.max_slave_yuv_planes = 2;
    2309         dc->caps.max_slave_rgb_planes = 2;
    2310         dc->caps.post_blend_color_processing = true;
    2311         dc->caps.force_dp_tps4_for_cp2520 = true;
    2312         dc->caps.extended_aux_timeout_support = true;
    2313         dc->caps.dmcub_support = true;
    2314 
    2315         /* Color pipeline capabilities */
    2316         dc->caps.color.dpp.dcn_arch = 1;
    2317         dc->caps.color.dpp.input_lut_shared = 0;
    2318         dc->caps.color.dpp.icsc = 1;
    2319         dc->caps.color.dpp.dgam_ram = 0; // must use gamma_corr
    2320         dc->caps.color.dpp.dgam_rom_caps.srgb = 1;
    2321         dc->caps.color.dpp.dgam_rom_caps.bt2020 = 1;
    2322         dc->caps.color.dpp.dgam_rom_caps.gamma2_2 = 1;
    2323         dc->caps.color.dpp.dgam_rom_caps.pq = 1;
    2324         dc->caps.color.dpp.dgam_rom_caps.hlg = 1;
    2325         dc->caps.color.dpp.post_csc = 1;
    2326         dc->caps.color.dpp.gamma_corr = 1;
    2327         dc->caps.color.dpp.dgam_rom_for_yuv = 0;
    2328 
    2329         dc->caps.color.dpp.hw_3d_lut = 1;
    2330         dc->caps.color.dpp.ogam_ram = 1;
    2331         // no OGAM ROM on DCN3
    2332         dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
    2333         dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
    2334         dc->caps.color.dpp.ogam_rom_caps.gamma2_2 = 0;
    2335         dc->caps.color.dpp.ogam_rom_caps.pq = 0;
    2336         dc->caps.color.dpp.ogam_rom_caps.hlg = 0;
    2337         dc->caps.color.dpp.ocsc = 0;
    2338 
    2339         dc->caps.color.mpc.gamut_remap = 1;
    2340         dc->caps.color.mpc.num_3dluts = pool->base.res_cap->num_mpc_3dlut; //3
    2341         dc->caps.color.mpc.ogam_ram = 1;
    2342         dc->caps.color.mpc.ogam_rom_caps.srgb = 0;
    2343         dc->caps.color.mpc.ogam_rom_caps.bt2020 = 0;
    2344         dc->caps.color.mpc.ogam_rom_caps.gamma2_2 = 0;
    2345         dc->caps.color.mpc.ogam_rom_caps.pq = 0;
    2346         dc->caps.color.mpc.ogam_rom_caps.hlg = 0;
    2347         dc->caps.color.mpc.ocsc = 1;
    2348 
    2349         dc->caps.dp_hdmi21_pcon_support = true;
    2350         dc->caps.max_v_total = (1 << 15) - 1;
    2351 
    2352         /* read VBIOS LTTPR caps */
    2353         {
    2354                 if (ctx->dc_bios->funcs->get_lttpr_caps) {
    2355                         enum bp_result bp_query_result;
    2356                         uint8_t is_vbios_lttpr_enable = 0;
    2357 
    2358                         bp_query_result = ctx->dc_bios->funcs->get_lttpr_caps(ctx->dc_bios, &is_vbios_lttpr_enable);
    2359                         dc->caps.vbios_lttpr_enable = (bp_query_result == BP_RESULT_OK) && !!is_vbios_lttpr_enable;
    2360                 }
    2361 
    2362                 if (ctx->dc_bios->funcs->get_lttpr_interop) {
    2363                         enum bp_result bp_query_result;
    2364                         uint8_t is_vbios_interop_enabled = 0;
    2365 
    2366                         bp_query_result = ctx->dc_bios->funcs->get_lttpr_interop(ctx->dc_bios,
    2367                                         &is_vbios_interop_enabled);
    2368                         dc->caps.vbios_lttpr_aware = (bp_query_result == BP_RESULT_OK) && !!is_vbios_interop_enabled;
    2369                 }
    2370         }
    2371 
    2372         if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
    2373                 dc->debug = debug_defaults_drv;
    2374 
    2375         // Init the vm_helper
    2376         if (dc->vm_helper)
    2377                 vm_helper_init(dc->vm_helper, 16);
    2378 
    2379         /*************************************************
    2380          *  Create resources                             *
    2381          *************************************************/
    2382 
    2383         /* Clock Sources for Pixel Clock*/
    2384         pool->base.clock_sources[DCN30_CLK_SRC_PLL0] =
--> 2385                         dcn30_clock_source_create(ctx, ctx->dc_bios,
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
sleeping allocation here.


    2386                                 CLOCK_SOURCE_COMBO_PHY_PLL0,
    2387                                 &clk_src_regs[0], false);
    2388         pool->base.clock_sources[DCN30_CLK_SRC_PLL1] =
    2389                         dcn30_clock_source_create(ctx, ctx->dc_bios,
    2390                                 CLOCK_SOURCE_COMBO_PHY_PLL1,
    2391                                 &clk_src_regs[1], false);
    2392         pool->base.clock_sources[DCN30_CLK_SRC_PLL2] =
    2393                         dcn30_clock_source_create(ctx, ctx->dc_bios,
    2394                                 CLOCK_SOURCE_COMBO_PHY_PLL2,
    2395                                 &clk_src_regs[2], false);
    2396         pool->base.clock_sources[DCN30_CLK_SRC_PLL3] =
    2397                         dcn30_clock_source_create(ctx, ctx->dc_bios,
    2398                                 CLOCK_SOURCE_COMBO_PHY_PLL3,
    2399                                 &clk_src_regs[3], false);
    2400         pool->base.clock_sources[DCN30_CLK_SRC_PLL4] =
    2401                         dcn30_clock_source_create(ctx, ctx->dc_bios,
    2402                                 CLOCK_SOURCE_COMBO_PHY_PLL4,
    2403                                 &clk_src_regs[4], false);
    2404         pool->base.clock_sources[DCN30_CLK_SRC_PLL5] =
    2405                         dcn30_clock_source_create(ctx, ctx->dc_bios,
    2406                                 CLOCK_SOURCE_COMBO_PHY_PLL5,
    2407                                 &clk_src_regs[5], false);
    2408 
    2409         pool->base.clk_src_count = DCN30_CLK_SRC_TOTAL;
    2410 
    2411         /* todo: not reuse phy_pll registers */
    2412         pool->base.dp_clock_source =
    2413                         dcn30_clock_source_create(ctx, ctx->dc_bios,
    2414                                 CLOCK_SOURCE_ID_DP_DTO,
    2415                                 &clk_src_regs[0], true);
    2416 
    2417         for (i = 0; i < pool->base.clk_src_count; i++) {
    2418                 if (pool->base.clock_sources[i] == NULL) {
    2419                         dm_error("DC: failed to create clock sources!\n");
    2420                         BREAK_TO_DEBUGGER();
    2421                         goto create_fail;
    2422                 }
    2423         }
    2424 
    2425         /* DCCG */
    2426         pool->base.dccg = dccg30_create(ctx, &dccg_regs, &dccg_shift, &dccg_mask);
    2427         if (pool->base.dccg == NULL) {
    2428                 dm_error("DC: failed to create dccg!\n");
    2429                 BREAK_TO_DEBUGGER();
    2430                 goto create_fail;
    2431         }
    2432 
    2433         /* PP Lib and SMU interfaces */
    2434         init_soc_bounding_box(dc, pool);
    2435 
    2436         num_pipes = dcn3_0_ip.max_num_dpp;
    2437 
    2438         for (i = 0; i < dcn3_0_ip.max_num_dpp; i++)
    2439                 if (pipe_fuses & 1 << i)
    2440                         num_pipes--;
    2441 
    2442         dcn3_0_ip.max_num_dpp = num_pipes;
    2443         dcn3_0_ip.max_num_otg = num_pipes;
    2444 
    2445         dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
    2446 
    2447         /* IRQ */
    2448         init_data.ctx = dc->ctx;
    2449         pool->base.irqs = dal_irq_service_dcn30_create(&init_data);
    2450         if (!pool->base.irqs)
    2451                 goto create_fail;
    2452 
    2453         /* HUBBUB */
    2454         pool->base.hubbub = dcn30_hubbub_create(ctx);
    2455         if (pool->base.hubbub == NULL) {
    2456                 BREAK_TO_DEBUGGER();
    2457                 dm_error("DC: failed to create hubbub!\n");
    2458                 goto create_fail;
    2459         }
    2460 
    2461         /* HUBPs, DPPs, OPPs and TGs */
    2462         for (i = 0; i < pool->base.pipe_count; i++) {
    2463                 pool->base.hubps[i] = dcn30_hubp_create(ctx, i);
    2464                 if (pool->base.hubps[i] == NULL) {
    2465                         BREAK_TO_DEBUGGER();
    2466                         dm_error(
    2467                                 "DC: failed to create hubps!\n");
    2468                         goto create_fail;
    2469                 }
    2470 
    2471                 pool->base.dpps[i] = dcn30_dpp_create(ctx, i);
    2472                 if (pool->base.dpps[i] == NULL) {
    2473                         BREAK_TO_DEBUGGER();
    2474                         dm_error(
    2475                                 "DC: failed to create dpps!\n");
    2476                         goto create_fail;
    2477                 }
    2478         }
    2479 
    2480         for (i = 0; i < pool->base.res_cap->num_opp; i++) {
    2481                 pool->base.opps[i] = dcn30_opp_create(ctx, i);
    2482                 if (pool->base.opps[i] == NULL) {
    2483                         BREAK_TO_DEBUGGER();
    2484                         dm_error(
    2485                                 "DC: failed to create output pixel processor!\n");
    2486                         goto create_fail;
    2487                 }
    2488         }
    2489 
    2490         for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
    2491                 pool->base.timing_generators[i] = dcn30_timing_generator_create(
    2492                                 ctx, i);
    2493                 if (pool->base.timing_generators[i] == NULL) {
    2494                         BREAK_TO_DEBUGGER();
    2495                         dm_error("DC: failed to create tg!\n");
    2496                         goto create_fail;
    2497                 }
    2498         }
    2499         pool->base.timing_generator_count = i;
    2500         /* PSR */
    2501         pool->base.psr = dmub_psr_create(ctx);
    2502 
    2503         if (pool->base.psr == NULL) {
    2504                 dm_error("DC: failed to create PSR obj!\n");
    2505                 BREAK_TO_DEBUGGER();
    2506                 goto create_fail;
    2507         }
    2508 
    2509         /* ABM */
    2510         for (i = 0; i < pool->base.res_cap->num_timing_generator; i++) {
    2511                 pool->base.multiple_abms[i] = dmub_abm_create(ctx,
    2512                                 &abm_regs[i],
    2513                                 &abm_shift,
    2514                                 &abm_mask);
    2515                 if (pool->base.multiple_abms[i] == NULL) {
    2516                         dm_error("DC: failed to create abm for pipe %d!\n", i);
    2517                         BREAK_TO_DEBUGGER();
    2518                         goto create_fail;
    2519                 }
    2520         }
    2521         /* MPC and DSC */
    2522         pool->base.mpc = dcn30_mpc_create(ctx, pool->base.mpcc_count, pool->base.res_cap->num_mpc_3dlut);
    2523         if (pool->base.mpc == NULL) {
    2524                 BREAK_TO_DEBUGGER();
    2525                 dm_error("DC: failed to create mpc!\n");
    2526                 goto create_fail;
    2527         }
    2528 
    2529         for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
    2530                 pool->base.dscs[i] = dcn30_dsc_create(ctx, i);
    2531                 if (pool->base.dscs[i] == NULL) {
    2532                         BREAK_TO_DEBUGGER();
    2533                         dm_error("DC: failed to create display stream compressor %d!\n", i);
    2534                         goto create_fail;
    2535                 }
    2536         }
    2537 
    2538         /* DWB and MMHUBBUB */
    2539         if (!dcn30_dwbc_create(ctx, &pool->base)) {
    2540                 BREAK_TO_DEBUGGER();
    2541                 dm_error("DC: failed to create dwbc!\n");
    2542                 goto create_fail;
    2543         }
    2544 
    2545         if (!dcn30_mmhubbub_create(ctx, &pool->base)) {
    2546                 BREAK_TO_DEBUGGER();
    2547                 dm_error("DC: failed to create mcif_wb!\n");
    2548                 goto create_fail;
    2549         }
    2550 
    2551         /* AUX and I2C */
    2552         for (i = 0; i < pool->base.res_cap->num_ddc; i++) {
    2553                 pool->base.engines[i] = dcn30_aux_engine_create(ctx, i);
    2554                 if (pool->base.engines[i] == NULL) {
    2555                         BREAK_TO_DEBUGGER();
    2556                         dm_error(
    2557                                 "DC:failed to create aux engine!!\n");
    2558                         goto create_fail;
    2559                 }
    2560                 pool->base.hw_i2cs[i] = dcn30_i2c_hw_create(ctx, i);
    2561                 if (pool->base.hw_i2cs[i] == NULL) {
    2562                         BREAK_TO_DEBUGGER();
    2563                         dm_error(
    2564                                 "DC:failed to create hw i2c!!\n");
    2565                         goto create_fail;
    2566                 }
    2567                 pool->base.sw_i2cs[i] = NULL;
    2568         }
    2569 
    2570         /* Audio, Stream Encoders including DIG and virtual, MPC 3D LUTs */
    2571         if (!resource_construct(num_virtual_links, dc, &pool->base,
    2572                         &res_create_funcs))
    2573                 goto create_fail;
    2574 
    2575         /* HW Sequencer and Plane caps */
    2576         dcn30_hw_sequencer_construct(dc);
    2577 
    2578         dc->caps.max_planes =  pool->base.pipe_count;
    2579 
    2580         for (i = 0; i < dc->caps.max_planes; ++i)
    2581                 dc->caps.planes[i] = plane_cap;
    2582 
    2583         dc->cap_funcs = cap_funcs;
    2584 
    2585         if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
    2586                 ddc_init_data.ctx = dc->ctx;
    2587                 ddc_init_data.link = NULL;
    2588                 ddc_init_data.id.id = dc->ctx->dc_bios->fw_info.oem_i2c_obj_id;
    2589                 ddc_init_data.id.enum_id = 0;
    2590                 ddc_init_data.id.type = OBJECT_TYPE_GENERIC;
    2591                 pool->base.oem_device = dc->link_srv->create_ddc_service(&ddc_init_data);
    2592         } else {
    2593                 pool->base.oem_device = NULL;
    2594         }
    2595 
    2596         DC_FP_END();
    2597 
    2598         return true;
    2599 
    2600 create_fail:
    2601 
    2602         DC_FP_END();
    2603         dcn30_resource_destruct(pool);
    2604 
    2605         return false;
    2606 }

regards,
dan carpenter
