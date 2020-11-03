Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22D3C388F9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 21:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8910720757
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 21:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW6gYDp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8910720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162716E8F2;
	Tue,  3 Nov 2020 21:15:38 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D9DA6E8E4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 18:27:08 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id w5so8261675qvn.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SsznNNNL9XRUk3heDJtTz6IafgIVD9jOGJsXmLbOtns=;
 b=WW6gYDp2qiF5CjeBpvraxn5UFlddDWc99m9lX/wH0Lge26UoWncogPvUEL33yjd4Gi
 8OjcM+ctHDS8bHPCwS9xztfTeH+iK6Pb4VDnRonoE5ypg6P4GUni7FtssLka23m91NtD
 YrVjP8/Wbi64Xfx1+bd07ELcJntlHGxoyX//gYZ9gWPqLAfBdZ+b8bObcCgon3lYkW+U
 AQDDEme/UEt1Dvxot/BwWJJLPJYWMfRlxABRKN7eVBOgQ3GpjU427EwIJUrrPkjluufU
 nl4Bn58ULb00V4vbfUHsX8hI92mobbXEDgBXLTm61or/AnfGh9+YVfD3QrGvEUyCWGTs
 FGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SsznNNNL9XRUk3heDJtTz6IafgIVD9jOGJsXmLbOtns=;
 b=lXRncly4AS2dKHl4zE7J9XC4lHhLBRfpcqvdaeHv9eWbVk7a3QpdJpUL6y7INuFCxw
 7NoJiH2/22RgoFA1FzTJSnKMWxmglNlWuJQh8E0wUpTi1Lx5tWc6uqMqXiWpiqrURo1T
 +5H3PGM4EdJe7B+rUTDVUQICMiLB44pvpccyZHhXN5WRtZLKVvamYTJBOl2XstrzHdXI
 eCY8LYYEGwBx7ZB7CTzKH02975ZRhN0rkLTA4YNBHxIYeKVOOgxoRrvmjiF6RdZr+msd
 o/MBYiUpmIbHPmrixMFBfxXlZduR1QoVCz4aja3uXDZbeQNB0Ys7kz99cwmvguqP7YZ9
 6w6A==
X-Gm-Message-State: AOAM531Kftr4hkB3iZKAmFfru2WaUyrYT3Eyn36BESMxQCv5BU3V/9j7
 /7+hJRG5a8NHu3RHFqg2gWM=
X-Google-Smtp-Source: ABdhPJzzhXfBJeNbYtivZg4fs1HpWNTxP7vh4+8ovEFjWaj4LP8t7pDYKhiWvEKG7yFBGFs9SjzHvg==
X-Received: by 2002:a0c:99e1:: with SMTP id y33mr8033687qve.62.1604428027353; 
 Tue, 03 Nov 2020 10:27:07 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
 by smtp.gmail.com with ESMTPSA id z22sm10880062qkg.65.2020.11.03.10.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 10:27:06 -0800 (PST)
Date: Tue, 3 Nov 2020 11:27:05 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into
 CONFIG_DRM_AMD_DC_DCN
Message-ID: <20201103182705.GA1750585@ubuntu-m3-large-x86>
References: <20201016165004.1218352-1-alexander.deucher@amd.com>
 <20201016165004.1218352-4-alexander.deucher@amd.com>
 <20201029221410.GA1982624@ubuntu-m3-large-x86>
 <CADnq5_OKYmpobjJGQ0sGTbkz3RNuuOBadySLE5URvh0CjxdD8w@mail.gmail.com>
 <20201103010059.GA3268770@ubuntu-m3-large-x86>
 <CADnq5_NrPOc26rzHWxS9TpBqCjpv3rhnaTS_O6B++YX7wEwOjA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_NrPOc26rzHWxS9TpBqCjpv3rhnaTS_O6B++YX7wEwOjA@mail.gmail.com>
X-Mailman-Approved-At: Tue, 03 Nov 2020 21:15:37 +0000
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

On Tue, Nov 03, 2020 at 12:41:27PM -0500, Alex Deucher wrote:
> On Mon, Nov 2, 2020 at 8:01 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Nov 02, 2020 at 05:33:14PM -0500, Alex Deucher wrote:
> > > On Thu, Oct 29, 2020 at 6:14 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > On Fri, Oct 16, 2020 at 12:50:04PM -0400, Alex Deucher wrote:
> > > > > Avoids confusion in configurations.
> > > > >
> > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > >
> > > > This patch causes a build failure with Fedora's aarch64 config (at
> > > > commit 2e3a5bc5feeab1ed21f0105f1440a2ff0aef62f9):
> > > >
> > >
> > > Does the attached patch fix it?
> > >
> > > Alex
> >
> > Closer:
> >
> 
> How about this one?
> 
> Alex

I still see three errors it looks like.

$ git revert -n 18128bd7c2929495df79adff83037bf6f588c10c

$ b4 am -o - 20201103173944.717710-1-alexander.deucher@amd.com | git apply -v -3
Looking up https://lore.kernel.org/r/20201103173944.717710-1-alexander.deucher%40amd.com
Grabbing thread from lore.kernel.org/amd-gfx
Analyzing 1 messages in the thread
---
Writing /tmp/tmpdyrsmuwtb4-am-stdout
  [PATCH] drm/amdgpu/display: FP fixes for DCN3.x (v2)
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20201103173944.717710-1-alexander.deucher@amd.com
 Base: not found (applies clean to current tree)
---
Checking patch drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile...
Checking patch drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c...
Checking patch drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c...
Checking patch drivers/gpu/drm/amd/display/dc/dml/Makefile...
Applied patch drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile cleanly.
Applied patch drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c cleanly.
Applied patch drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c cleanly.
Applied patch drivers/gpu/drm/amd/display/dc/dml/Makefile cleanly.

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- clean olddefconfig drivers/gpu/drm/amd/amdgpu/amdgpu.ko
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

Cheers,
Nathan
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
