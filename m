Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC0DC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81E420727
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 04:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvn7xK86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81E420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429D36E94F;
	Fri, 30 Oct 2020 04:12:15 +0000 (UTC)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE2F6E914
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 22:14:14 +0000 (UTC)
Received: by mail-il1-x141.google.com with SMTP id p10so4725989ile.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2020 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BU1E7k0peh2jCd9qr3mdn1YGzNw3V6El06MX66g8Ub4=;
 b=Kvn7xK86xCehkeDZWIXA6qXBIQHj/dZX7EdN/blVTwzZsvr9MjTL7Q1C+Ypl0VUdAH
 MKYsEntyG+cQMF9DeIr4a+0+sAh6SbWcu5Wa47g4mKzvluXOE2qMx9458tmCv8a59hPk
 j/GG/98UR9nAWOzxQ7iW0hCyGG+4z73o5XoDZS4HFEkgjdQfIYenwakdcb1601+1Buyu
 cr9o+GrcaBn1y5Kj1rhWTm6qFJZGC2waDkt7EhqHWu0+WZa3o5cCSOJhY/qzZfv0uCh6
 KXsrKVaIcqGmmcn0y/Ctt+SrYZMuvamy92kscHqr6qF8F7cmUd7Oaiw1TejhFe+p/8fC
 dAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BU1E7k0peh2jCd9qr3mdn1YGzNw3V6El06MX66g8Ub4=;
 b=WlWbWfvc9gpk/68tMaVb7RT2Ic+bZt/v8i0QPxq2l+ITq6z9dcfn8qGbKgHj/XnXP0
 JJXKG3qAvg4jJoG+Z6r6bJGW53JITgLTqERMHJ8P+E2KPeXd/AIUmajJEIf52JlUfIAA
 LWJTiu96GZaODHjbUepH7Un20EBGmb6WOyVI+fat2nvcwb+zPauFBo99ec5w6SKHOx/F
 JKh3BeSu5uzEjYzaDXgrk2ccT2z3JT9fMesnazalhNOoKOQachlToWgq6QPWFNXS9stM
 TflhMleQdVE3GcOhenfhkaxQJH1oKQIKpzsg24XdPfLr96JAL/ezAWT1pLt8NU72JUC7
 L9rQ==
X-Gm-Message-State: AOAM532BNNAcbHn8313usk4KHiDevShbftyUQTO79avBG05WKbGdUvVo
 9TJgUw5G5xPa6qCuEirLDgY=
X-Google-Smtp-Source: ABdhPJy6LWcSjQ7EAgp07nEA++rEQ2ZarXubI82p/VJTdGCeM1wsHZNwHtnctAxI3Przw+y5DU4HBQ==
X-Received: by 2002:a92:a008:: with SMTP id e8mr5356088ili.83.1604009653276;
 Thu, 29 Oct 2020 15:14:13 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
 by smtp.gmail.com with ESMTPSA id s85sm4051278ilk.41.2020.10.29.15.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 15:14:12 -0700 (PDT)
Date: Thu, 29 Oct 2020 15:14:10 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into
 CONFIG_DRM_AMD_DC_DCN
Message-ID: <20201029221410.GA1982624@ubuntu-m3-large-x86>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <20201016165004.1218352-4-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016165004.1218352-4-alexander.deucher@amd.com>
X-Mailman-Approved-At: Fri, 30 Oct 2020 04:12:14 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 16, 2020 at 12:50:04PM -0400, Alex Deucher wrote:
> Avoids confusion in configurations.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This patch causes a build failure with Fedora's aarch64 config (at
commit 2e3a5bc5feeab1ed21f0105f1440a2ff0aef62f9):

$ git bisect log
# bad: [3f267ec60b922eff2a5c90d532357a39f155b730] Add linux-next specific files for 20201029
# good: [23859ae44402f4d935b9ee548135dd1e65e2cbf4] Merge tag 'trace-v5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect start '3f267ec60b922eff2a5c90d532357a39f155b730' '23859ae44402f4d935b9ee548135dd1e65e2cbf4'
# good: [bfa70a4ea4bfa6f87b58cf8b90b88297389c92b7] Merge remote-tracking branch 'mtd/mtd/next' into master
git bisect good bfa70a4ea4bfa6f87b58cf8b90b88297389c92b7
# bad: [14870a06b100ecb99cdd4c5034c250d418748481] Merge remote-tracking branch 'drm-misc/for-linux-next' into master
git bisect bad 14870a06b100ecb99cdd4c5034c250d418748481
# bad: [09a7bb5dfcf41dfe259c2fc2b47c226ea25ecfb8] Merge remote-tracking branch 'amdgpu/drm-next' into master
git bisect bad 09a7bb5dfcf41dfe259c2fc2b47c226ea25ecfb8
# good: [7d92c1fd11e247f4b9200c45ad810204e34872a8] drm/amd/pm: populate the bootup LCLK frequency
git bisect good 7d92c1fd11e247f4b9200c45ad810204e34872a8
# good: [35a4644c935ee8263b1d99a0fe4d5370deb4f606] drm/amd/display: Don't trigger flip twice when ODM combine in use
git bisect good 35a4644c935ee8263b1d99a0fe4d5370deb4f606
# good: [f6638d0e6f93501dae110d66445c159309aa366a] drm/amd/pm: correct the checks for sclk/mclk SS support
git bisect good f6638d0e6f93501dae110d66445c159309aa366a
# good: [191a3c04799e4d1c1153442647629669bbf6c882] drm/amdgpu: enable MULTI_MON_PP_MCLK_SWITCH DC feature at default
git bisect good 191a3c04799e4d1c1153442647629669bbf6c882
# good: [b889e62cdb3b47cf2b4c373a110fd2814011c4bb] drm/amdgpu: add another raven1 gfxoff quirk
git bisect good b889e62cdb3b47cf2b4c373a110fd2814011c4bb
# bad: [3a357c0ba7a84c708e2990deb3b6664f8d36f74a] drm/amd/display: Fix incorrect dsc force enable logic
git bisect bad 3a357c0ba7a84c708e2990deb3b6664f8d36f74a
# good: [2b6f5e8426d6dbeb0b6e8e95964309ea046fa43d] drm/amdgpu/display: remove dal_cmd_tbl_helper_dcn2_get_table2
git bisect good 2b6f5e8426d6dbeb0b6e8e95964309ea046fa43d
# bad: [5d7dd14d6bdc2d44f07cec98be65b6edbff2e51c] drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into CONFIG_DRM_AMD_DC_DCN (v2)
git bisect bad 5d7dd14d6bdc2d44f07cec98be65b6edbff2e51c
# good: [98b30b31b28c2477ff7248e1a01627b2c83a711f] drm/amdgpu: drop CONFIG_DRM_AMD_DC_DCN3_01 from atomfirmware.h
git bisect good 98b30b31b28c2477ff7248e1a01627b2c83a711f
# first bad commit: [5d7dd14d6bdc2d44f07cec98be65b6edbff2e51c] drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into CONFIG_DRM_AMD_DC_DCN (v2)

$ curl -LSso .config 'https://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/fedora.git/plain/fedora/configs/kernel-5.9.1-aarch64.config?h=kernel-5.9.1-300.fc33'

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- olddefconfig drivers/gpu/drm/amd/amdgpu/amdgpu.ko
...
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_calc_rq_dlg_ttu':
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:516:1: warning: the frame size of 1600 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  516 | }
      | ^
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: In function 'vg_clk_mgr_helper_populate_bw_params.isra':
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:689:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  689 |   bw_params->wm_table.entries[WM_D].pstate_latency_us = LPDDR_MEM_RETRAIN_LATENCY;
      |                                                       ^
make[5]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.o] Error 1
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c: In function 'dcn3_build_wm_range_table':
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:110:9: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  110 |  double pstate_latency_us = clk_mgr->base.ctx->dc->dml.soc.dram_clock_change_latency_us;
      |         ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:111:9: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  111 |  double sr_exit_time_us = clk_mgr->base.ctx->dc->dml.soc.sr_exit_time_us;
      |         ^~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:112:9: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  112 |  double sr_enter_plus_exit_time_us = clk_mgr->base.ctx->dc->dml.soc.sr_enter_plus_exit_time_us;
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:117:81: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  117 |  clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us = pstate_latency_us;
      |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:118:79: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  118 |  clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us = sr_exit_time_us;
      |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:119:90: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  119 |  clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
      |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:139:113: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  139 |  clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.pstate_latency_us = clk_mgr->base.ctx->dc->dml.soc.dummy_pstate_latency_us;
      |                                                                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:139:81: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  139 |  clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.pstate_latency_us = clk_mgr->base.ctx->dc->dml.soc.dummy_pstate_latency_us;
      |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:140:79: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  140 |  clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us = sr_exit_time_us;
      |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:141:90: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  141 |  clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
      |  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.o] Error 1
aarch64-linux-gcc: error: unrecognized command-line option '-msse2'
make[5]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_optc.o] Error 1
aarch64-linux-gcc: error: unrecognized command-line option '-msse2'
make[5]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.o] Error 1
In file included from ./include/linux/printk.h:405,
                 from ./include/linux/kernel.h:15,
                 from ./include/linux/list.h:9,
                 from ./include/linux/rculist.h:10,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from ./include/linux/ptrace.h:6,
                 from ./arch/arm64/include/asm/kgdb.h:14,
                 from ./include/linux/kgdb.h:20,
                 from ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:30,
                 from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                 from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.h:28,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:26:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c: In function 'dml_log_pipe_params':
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:200:3: note: in expansion of macro 'dml_print'
  200 |   dml_print("DML PARAMS:     pixel_rate_mhz             = %3.2f\n", pipe_dest->pixel_rate_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:200:3: note: in expansion of macro 'dml_print'
  200 |   dml_print("DML PARAMS:     pixel_rate_mhz             = %3.2f\n", pipe_dest->pixel_rate_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:200:3: note: in expansion of macro 'dml_print'
  200 |   dml_print("DML PARAMS:     pixel_rate_mhz             = %3.2f\n", pipe_dest->pixel_rate_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:210:3: note: in expansion of macro 'dml_print'
  210 |   dml_print("DML PARAMS:     hscl_ratio                 = %3.4f\n", scale_ratio_depth->hscl_ratio);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:210:3: note: in expansion of macro 'dml_print'
  210 |   dml_print("DML PARAMS:     hscl_ratio                 = %3.4f\n", scale_ratio_depth->hscl_ratio);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:210:3: note: in expansion of macro 'dml_print'
  210 |   dml_print("DML PARAMS:     hscl_ratio                 = %3.4f\n", scale_ratio_depth->hscl_ratio);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:211:3: note: in expansion of macro 'dml_print'
  211 |   dml_print("DML PARAMS:     vscl_ratio                 = %3.4f\n", scale_ratio_depth->vscl_ratio);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:211:3: note: in expansion of macro 'dml_print'
  211 |   dml_print("DML PARAMS:     vscl_ratio                 = %3.4f\n", scale_ratio_depth->vscl_ratio);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:211:3: note: in expansion of macro 'dml_print'
  211 |   dml_print("DML PARAMS:     vscl_ratio                 = %3.4f\n", scale_ratio_depth->vscl_ratio);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:212:3: note: in expansion of macro 'dml_print'
  212 |   dml_print("DML PARAMS:     hscl_ratio_c               = %3.4f\n", scale_ratio_depth->hscl_ratio_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:212:3: note: in expansion of macro 'dml_print'
  212 |   dml_print("DML PARAMS:     hscl_ratio_c               = %3.4f\n", scale_ratio_depth->hscl_ratio_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:212:3: note: in expansion of macro 'dml_print'
  212 |   dml_print("DML PARAMS:     hscl_ratio_c               = %3.4f\n", scale_ratio_depth->hscl_ratio_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:213:3: note: in expansion of macro 'dml_print'
  213 |   dml_print("DML PARAMS:     vscl_ratio_c               = %3.4f\n", scale_ratio_depth->vscl_ratio_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:213:3: note: in expansion of macro 'dml_print'
  213 |   dml_print("DML PARAMS:     vscl_ratio_c               = %3.4f\n", scale_ratio_depth->vscl_ratio_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:213:3: note: in expansion of macro 'dml_print'
  213 |   dml_print("DML PARAMS:     vscl_ratio_c               = %3.4f\n", scale_ratio_depth->vscl_ratio_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:214:3: note: in expansion of macro 'dml_print'
  214 |   dml_print("DML PARAMS:     vinit                      = %3.4f\n", scale_ratio_depth->vinit);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:214:3: note: in expansion of macro 'dml_print'
  214 |   dml_print("DML PARAMS:     vinit                      = %3.4f\n", scale_ratio_depth->vinit);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:214:3: note: in expansion of macro 'dml_print'
  214 |   dml_print("DML PARAMS:     vinit                      = %3.4f\n", scale_ratio_depth->vinit);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:215:3: note: in expansion of macro 'dml_print'
  215 |   dml_print("DML PARAMS:     vinit_c                    = %3.4f\n", scale_ratio_depth->vinit_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:215:3: note: in expansion of macro 'dml_print'
  215 |   dml_print("DML PARAMS:     vinit_c                    = %3.4f\n", scale_ratio_depth->vinit_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:215:3: note: in expansion of macro 'dml_print'
  215 |   dml_print("DML PARAMS:     vinit_c                    = %3.4f\n", scale_ratio_depth->vinit_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:216:3: note: in expansion of macro 'dml_print'
  216 |   dml_print("DML PARAMS:     vinit_bot                  = %3.4f\n", scale_ratio_depth->vinit_bot);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:216:3: note: in expansion of macro 'dml_print'
  216 |   dml_print("DML PARAMS:     vinit_bot                  = %3.4f\n", scale_ratio_depth->vinit_bot);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:216:3: note: in expansion of macro 'dml_print'
  216 |   dml_print("DML PARAMS:     vinit_bot                  = %3.4f\n", scale_ratio_depth->vinit_bot);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:217:3: note: in expansion of macro 'dml_print'
  217 |   dml_print("DML PARAMS:     vinit_bot_c                = %3.4f\n", scale_ratio_depth->vinit_bot_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:217:3: note: in expansion of macro 'dml_print'
  217 |   dml_print("DML PARAMS:     vinit_bot_c                = %3.4f\n", scale_ratio_depth->vinit_bot_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:217:3: note: in expansion of macro 'dml_print'
  217 |   dml_print("DML PARAMS:     vinit_bot_c                = %3.4f\n", scale_ratio_depth->vinit_bot_c);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:230:3: note: in expansion of macro 'dml_print'
  230 |   dml_print("DML PARAMS:     output_bpp                 = %3.4f\n", dout->output_bpp);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:230:3: note: in expansion of macro 'dml_print'
  230 |   dml_print("DML PARAMS:     output_bpp                 = %3.4f\n", dout->output_bpp);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:230:3: note: in expansion of macro 'dml_print'
  230 |   dml_print("DML PARAMS:     output_bpp                 = %3.4f\n", dout->output_bpp);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:240:3: note: in expansion of macro 'dml_print'
  240 |   dml_print("DML PARAMS:     dppclk_mhz                 = %3.2f\n", clks_cfg->dppclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:240:3: note: in expansion of macro 'dml_print'
  240 |   dml_print("DML PARAMS:     dppclk_mhz                 = %3.2f\n", clks_cfg->dppclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:240:3: note: in expansion of macro 'dml_print'
  240 |   dml_print("DML PARAMS:     dppclk_mhz                 = %3.2f\n", clks_cfg->dppclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:241:3: note: in expansion of macro 'dml_print'
  241 |   dml_print("DML PARAMS:     refclk_mhz                 = %3.2f\n", clks_cfg->refclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:241:3: note: in expansion of macro 'dml_print'
  241 |   dml_print("DML PARAMS:     refclk_mhz                 = %3.2f\n", clks_cfg->refclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:241:3: note: in expansion of macro 'dml_print'
  241 |   dml_print("DML PARAMS:     refclk_mhz                 = %3.2f\n", clks_cfg->refclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:242:3: note: in expansion of macro 'dml_print'
  242 |   dml_print("DML PARAMS:     dispclk_mhz                = %3.2f\n", clks_cfg->dispclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:242:3: note: in expansion of macro 'dml_print'
  242 |   dml_print("DML PARAMS:     dispclk_mhz                = %3.2f\n", clks_cfg->dispclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:242:3: note: in expansion of macro 'dml_print'
  242 |   dml_print("DML PARAMS:     dispclk_mhz                = %3.2f\n", clks_cfg->dispclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:243:3: note: in expansion of macro 'dml_print'
  243 |   dml_print("DML PARAMS:     dcfclk_mhz                 = %3.2f\n", clks_cfg->dcfclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:243:3: note: in expansion of macro 'dml_print'
  243 |   dml_print("DML PARAMS:     dcfclk_mhz                 = %3.2f\n", clks_cfg->dcfclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:243:3: note: in expansion of macro 'dml_print'
  243 |   dml_print("DML PARAMS:     dcfclk_mhz                 = %3.2f\n", clks_cfg->dcfclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:244:3: note: in expansion of macro 'dml_print'
  244 |   dml_print("DML PARAMS:     socclk_mhz                 = %3.2f\n", clks_cfg->socclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:244:3: note: in expansion of macro 'dml_print'
  244 |   dml_print("DML PARAMS:     socclk_mhz                 = %3.2f\n", clks_cfg->socclk_mhz);
      |   ^~~~~~~~~
./include/linux/dynamic_debug.h:157:26: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |                          ^
./include/linux/dynamic_debug.h:129:3: note: in definition of macro '__dynamic_func_call'
  129 |   func(&id, ##__VA_ARGS__);  \
      |   ^~~~
./include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
  157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
      |  ^~~~~~~~~~~~~~~~~~
./include/linux/printk.h:420:2: note: in expansion of macro 'dynamic_pr_debug'
  420 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~
./drivers/gpu/drm/amd/amdgpu/../display/include/logger_types.h:57:25: note: in expansion of macro 'pr_debug'
   57 | #define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
      |                         ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml_logger.h:33:30: note: in expansion of macro 'DC_LOG_DML'
   33 | #define dml_print(str, ...) {DC_LOG_DML(str, ##__VA_ARGS__); }
      |                              ^~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.c:244:3: note: in expansion of macro 'dml_print'
  244 |   dml_print("DML PARAMS:     socclk_mhz                 = %3.2f\n", clks_cfg->socclk_mhz);
      |   ^~~~~~~~~
make[5]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o] Error 1
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:30:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_min':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:32:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   32 | static inline double dml_min(double a, double b)
      |                      ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:32:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_floor':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:72:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   72 | static inline double dml_floor(double a, double granularity)
      |                      ^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:72:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_log2':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:98:19: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   98 | static inline int dml_log2(double x)
      |                   ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_ceil':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:67:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   67 | static inline double dml_ceil(double a, double granularity)
      |                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:67:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_max':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:47:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   47 | static inline double dml_max(double a, double b)
      |                      ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:47:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c: In function 'get_refcyc_per_delivery':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:43:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   43 | static double get_refcyc_per_delivery(struct display_mode_lib *mode_lib,
      |               ^~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:43:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:43:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:43:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c: In function 'calculate_ttu_cursor':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:873:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  873 | static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
      |             ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:873:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:873:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:873:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:873:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:873:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:30:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_pow':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:105:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  105 | static inline double dml_pow(double a, int exp)
      |                      ^~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:31:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_round':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:77:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   77 | static inline double dml_round(double a)
      |                      ^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_floor':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:72:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   72 | static inline double dml_floor(double a, double granularity)
      |                      ^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:72:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_min':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:32:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   32 | static inline double dml_min(double a, double b)
      |                      ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:32:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_ceil':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:67:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   67 | static inline double dml_ceil(double a, double granularity)
      |                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:67:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
make[5]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.o] Error 1
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_min3':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:37:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   37 | static inline double dml_min3(double a, double b, double c)
      |                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:37:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:37:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'RoundToDFSGranularityDown':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1371:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 1371 | static double RoundToDFSGranularityDown(double Clock, double VCOSpeed)
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1371:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'RoundToDFSGranularityUp':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1366:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 1366 | static double RoundToDFSGranularityUp(double Clock, double VCOSpeed)
      |               ^~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1366:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'dscceComputeDelay':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:734:21: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  734 | static unsigned int dscceComputeDelay(
      |                     ^~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:31:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_log2':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:98:19: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   98 | static inline int dml_log2(double x)
      |                   ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculatePrefetchSourceLines':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1678:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 1678 | static double CalculatePrefetchSourceLines(
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1678:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateRowBandwidth':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3397:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 3397 | static void CalculateRowBandwidth(
      |             ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3397:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3397:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateExtraLatency':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6575:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 6575 | static double CalculateExtraLatency(
      |               ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6575:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6575:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6575:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6575:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateExtraLatencyBytes':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6614:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 6614 | static double CalculateExtraLatencyBytes(
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6614:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6614:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateWriteBackDelay':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3344:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 3344 | static double CalculateWriteBackDelay(
      |               ^~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3344:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateUrgentLatency':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6660:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 6660 | static double CalculateUrgentLatency(
      |               ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6660:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6660:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6660:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6660:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6660:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateTWait':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3308:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 3308 | static double CalculateTWait(
      |               ^~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3308:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3308:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculatePrefetchSchedule':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
  879 | static bool CalculatePrefetchSchedule(
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:879:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateDynamicMetadataParameters':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3371:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 3371 | static void CalculateDynamicMetadataParameters(int MaxInterDCNTileRepeaters, double DPPCLK, double DISPCLK,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3371:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3371:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3371:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:31:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_max4':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:57:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   57 | static inline double dml_max4(double a, double b, double c, double d)
      |                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:57:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:57:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:57:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateUrgentBurstFactor':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5646:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 5646 | static void CalculateUrgentBurstFactor(
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5646:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5646:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5646:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5646:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5646:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5646:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5646:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5646:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateFlipSchedule':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 3436 | static void CalculateFlipSchedule(
      |             ^~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3436:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:31:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_min4':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:42:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   42 | static inline double dml_min4(double a, double b, double c, double d)
      |                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:42:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:42:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:42:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_max3':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:52:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   52 | static inline double dml_max3(double a, double b, double c)
      |                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:52:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:52:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateWatermarksAndDRAMSpeedChangeSupport':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 5365 | static void CalculateWatermarksAndDRAMSpeedChangeSupport(
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:5365:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateDCCConfiguration':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1376:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 1376 | static void CalculateDCCConfiguration(
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1376:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1376:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:31:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_max':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:47:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   47 | static inline double dml_max(double a, double b)
      |                      ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:47:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'CalculateStutterEfficiency':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6120:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 6120 | static void CalculateStutterEfficiency(
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6120:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6120:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6120:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'dml30_CalculateWriteBackDISPCLK':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3324:8: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 3324 | double dml30_CalculateWriteBackDISPCLK(
      |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3324:8: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3324:8: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3324:8: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:31:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h: In function 'dml_max5':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:62:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
   62 | static inline double dml_max5(double a, double b, double c, double d, double e)
      |                      ^~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:62:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:62:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:62:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/../dml_inline_defs.h:62:22: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'TruncToValidBPP':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3540:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 3540 | static double TruncToValidBPP(
      |               ^~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3540:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3540:15: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c: In function 'UseMinimumDCFCLK':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6679:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
 6679 | static void UseMinimumDCFCLK(
      |             ^~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6679:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6679:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6679:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6679:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6679:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:6679:13: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
make[5]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.o] Error 1
make[5]: Target '__build' not remade because of errors.
make[4]: *** [scripts/Makefile.build:500: drivers/gpu/drm/amd/amdgpu] Error 2
make[4]: Target '__build' not remade because of errors.
make[3]: *** [scripts/Makefile.build:500: drivers/gpu/drm] Error 2
make[3]: Target '__build' not remade because of errors.
make[2]: *** [scripts/Makefile.build:500: drivers/gpu] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [Makefile:1784: drivers] Error 2
make[1]: Target 'drivers/gpu/drm/amd/amdgpu/amdgpu.ko' not remade because of errors.
make: *** [Makefile:335: __build_one_by_one] Error 2
make: Target 'olddefconfig' not remade because of errors.
make: Target 'drivers/gpu/drm/amd/amdgpu/amdgpu.ko' not remade because of errors.

LLVM also sees a build failure but it is at modpost:



$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- LLVM=1 olddefconfig all
...
ERROR: modpost: "__gtsf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatdisf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__addsf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__gedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixsfdi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatsisf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixsfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__nesf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__ledf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatunsisf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__subdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatdidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixunssfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__eqdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__nedf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__ltdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__adddf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__floatunsidf" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__gtdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixunsdfsi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__divdf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__extendsfdf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__truncdfsf2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__muldf3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__fixdfdi" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
...

$ readelf -s drivers/gpu/drm/amd/amdgpu/amdgpu.ko |& grep UND |& grep __
...
 19448: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __fixdfdi
 19449: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __muldf3
 19450: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __truncdfsf2
 19451: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __extendsfdf2
 19452: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __divdf3
 19453: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __fixunsdfsi
 19455: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __gtdf2
 19456: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __floatunsidf
 19457: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __adddf3
 19458: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __ltdf2
 19459: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __nedf2
 19460: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __floatsidf
 19461: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __fixdfsi
 19462: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __eqdf2
 19463: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __fixunssfsi
 19464: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __floatdidf
 19465: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __subdf3
 19466: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __floatunsisf
 19467: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __ledf2
 19468: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __nesf2
 19469: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __fixsfsi
 19470: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __floatsisf
 19471: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __fixsfdi
 19472: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __gedf2
 19473: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __addsf3
 19474: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __floatdisf
 19475: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __gtsf2
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
