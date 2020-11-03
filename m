Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0A4C388F2
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C14206E3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhoxKlXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C14206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD976EC1D;
	Tue,  3 Nov 2020 08:15:10 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC096E13A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 01:01:03 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id r7so13368655qkf.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2020 17:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mv9isvUt+LEvjw4o/hcsMbvGhVuYXvN3pOe4dIFmCAQ=;
 b=HhoxKlXIpqPbR60B+SZwtul758hXnYFT3dzZDcxLFCmPGoLAivFWHdhzzw761I40+e
 mcdE3WB51vFEpijC3XobAOGhwXf1PwU86hsafI7tT7z9hYb8L/BlripGyDGKc/bvTh82
 q7mlEiqhL8n9CIF0A+dT4QCO23bMEGDYQ4Pqwp34zbdqPKy90FXwqmjmhjBHNgEra+f8
 C/Ps0c7SOzcOwhqSYRjsJcAK+7bzCF0+hnjDvWthdOQbSfryXin8x1pw3hRM5eMQDDII
 7I+4xc5Bs2R0biV6gM29kttQ0wdPraWS5zKTcF6dxb+8rkszslBqhZGDnyg2zLfW4ZGL
 78/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mv9isvUt+LEvjw4o/hcsMbvGhVuYXvN3pOe4dIFmCAQ=;
 b=XF2Z7gPIaZAfVd1sEWgi0+tn66eJAcSd2ftfgYkGBHNKzVOicv7iS1JxAJRP6r+rak
 VqSk5fiZIoHjmQ/nalbpu1GjTK3s0+swDhXAqz4IOx3a159M+5HqX8shnNKydZteUI7I
 Q/0y8r5eIh2jCUAJxgDFAYNV4q3iha0m8ad5r4CoWS/6zSJZnS8sNUL/hdU4nAJrEGBH
 X7+RHyMorcQM4CLwkCSip+3KFHZy9sIb/bWbFlSou8XQZATdnuMBdBt8UZSW2MQVUHlm
 dhFjEN4mLjuyyK+JZKH61QNRJYxfiNgYiZjLIJiSoCaIAtWGNJ+OyC0fVp46SuTl5ZkI
 aCQg==
X-Gm-Message-State: AOAM531jDOdIAbNKtjDMYO0nFx4YBiawaopRqkJ1RL2pBNd5jAD8UIfE
 +ZUiQxMUFGciaUg81c6z/kY=
X-Google-Smtp-Source: ABdhPJzJYk1R0fOfe2kFSwdafN7/CE1MriNasZ8e1SJfQrUMC4llJwZc9su9aOtXR60TCbcVNwpgLA==
X-Received: by 2002:a05:620a:12ee:: with SMTP id
 f14mr16356902qkl.238.1604365261898; 
 Mon, 02 Nov 2020 17:01:01 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
 by smtp.gmail.com with ESMTPSA id g27sm9423391qkk.135.2020.11.02.17.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 17:01:00 -0800 (PST)
Date: Mon, 2 Nov 2020 18:00:59 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into
 CONFIG_DRM_AMD_DC_DCN
Message-ID: <20201103010059.GA3268770@ubuntu-m3-large-x86>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <20201016165004.1218352-4-alexander.deucher@amd.com>
 <20201029221410.GA1982624@ubuntu-m3-large-x86>
 <CADnq5_OKYmpobjJGQ0sGTbkz3RNuuOBadySLE5URvh0CjxdD8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_OKYmpobjJGQ0sGTbkz3RNuuOBadySLE5URvh0CjxdD8w@mail.gmail.com>
X-Mailman-Approved-At: Tue, 03 Nov 2020 08:15:01 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 02, 2020 at 05:33:14PM -0500, Alex Deucher wrote:
> On Thu, Oct 29, 2020 at 6:14 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 12:50:04PM -0400, Alex Deucher wrote:
> > > Avoids confusion in configurations.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > This patch causes a build failure with Fedora's aarch64 config (at
> > commit 2e3a5bc5feeab1ed21f0105f1440a2ff0aef62f9):
> >
> 
> Does the attached patch fix it?
> 
> Alex

Closer:

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- olddefconfig drivers/gpu/drm/amd/amdgpu/amdgpu.ko
  LINK     resolve_btfids
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: In function 'dcn_bw_calc_rq_dlg_ttu':
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:516:1: warning: the frame size of 1600 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  516 | }
      | ^
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
In file included from ./include/linux/printk.h:409,
                 from ./include/linux/kernel.h:16,
                 from ./include/linux/list.h:9,
                 from ./include/linux/kprobes.h:21,
                 from ./include/linux/kgdb.h:19,
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
./include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
  424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
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
make[5]: Target '__build' not remade because of errors.
make[4]: *** [scripts/Makefile.build:500: drivers/gpu/drm/amd/amdgpu] Error 2
make[4]: Target '__build' not remade because of errors.
make[3]: *** [scripts/Makefile.build:500: drivers/gpu/drm] Error 2
make[3]: Target '__build' not remade because of errors.
make[2]: *** [scripts/Makefile.build:500: drivers/gpu] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [Makefile:1797: drivers] Error 2
make[1]: Target 'drivers/gpu/drm/amd/amdgpu/amdgpu.ko' not remade because of errors.
make: *** [Makefile:335: __build_one_by_one] Error 2
make: Target 'clean' not remade because of errors.
make: Target 'olddefconfig' not remade because of errors.
make: Target 'drivers/gpu/drm/amd/amdgpu/amdgpu.ko' not remade because of errors.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
