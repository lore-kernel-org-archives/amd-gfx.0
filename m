Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6786FCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA01E10E0B0;
	Tue, 19 May 2026 10:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FMAsnaK6";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA7C10E0B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:22 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so2894695f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186081; x=1779790881; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sap7dqEz50tznE0CI8r6GQUEy0r8GWlQ7YgLaYK9H8Y=;
 b=FMAsnaK6VqmyJzLtENm93jfns3OltUQRAeFIvp93PTfuSLfC9TMyJqsh9f4fzPhVhh
 UEDersdq1NmRVfTuevLNd6XOO7EqhbHhQAUww/Q0Rky7JYjaEcFYBB3zd5vxA5Cqeq5K
 cKYyI3DiQEpJX3HdG/QXSS2sCcWriM6PGMN7aDkPTa+8irlXJVYnIaDmQFE7J3eE1o0W
 NaAj8EutVjyZESyLumTB5ckM8a2rRmHcwX1+6T2PIl9sSC6XekqZPkbUCzgxDWsBelKd
 A8ErRGmdzoYk/JDzln4Or308L/oPz1UZJkvdu9Y1aKXwsjhMt97yX/q5TbRKuBxouhkQ
 Z9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186081; x=1779790881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sap7dqEz50tznE0CI8r6GQUEy0r8GWlQ7YgLaYK9H8Y=;
 b=AuMJhGCQkeRs9pyHDqbMdrMYcfQt2kjML89eBRn8wczuSjTQ1dNbN9IB3r+5CMJpVg
 4bCuK0HETixyQO3URb/PIuPc7MNsKIJO83yL+v8Noij2qPMfafycNUso031/r3QS8hGq
 40iibXzS3rFEa3zySL87u1Wi27gDLbXeT7WSe1XVwXH+fE2ZdLePPVrXnKnKn6bO7YNg
 wcqUdHErQCbm2yCbF7acRAbrTjsWN0Mkspc4D7CJ2ZxjeAb8G5FNAwLE8fZfiHD7pP92
 s8V9yUUNKiJREr8facGqzPPILBwPKZTWVKkPUaSIf6gvJ03wXuoUsr0OSaxDQrvNzKJR
 utfw==
X-Gm-Message-State: AOJu0YwgG5fmV2GGc0xHefHTeuPbs58o2F8EnqSrPSYGCV7AovIft52u
 eJDA4A3pyYsFVyAmMyHENNjYq5rEKGPDoa0f9o/Lmd0INqSEdx2Wf0BSzLtXao39
X-Gm-Gg: Acq92OGrFfegnGpGhR8y42JulWshNzwxzzRHKtDrQc2eXL6mlhiHQvrQ5wiRqkG/Xul
 zWIq93TQhfN412jrszR7NHn2rHz9FjGGWetYnXpM1sMZc0J90xsPbE8AJ9DHEcR2SL9B3tSJH+M
 pJ/TIMvihAf9n8sRXethoZodvGUhea/cXVUuX4+DKJXBACsEXGREVM6Vb9+iFGVMsvYg80tHajn
 6KP1qRq3CeJfSplE17FgFJan1EErkuAREm/HstoG5CW5wGObAAd2pDB6bQfhIz0rDSUwJGxY/eu
 1yCNH7rtyF6tM2xA6wEgXEeF6XEFNIDTFAoeF3eDq9x4qTFYD7hwsw+vVuCYSszVE9O/TwoZ0X2
 D76WKvlpqZ9KAS/6KybMjnMLuNMXaSuXTokY9DvPlVsCg8Fy7yrLM6tTZxTomSDJuDe3QWMNaIV
 3HPf0wB/J7HEQGoGBmO0fJtCstLZANlf5k94bq+70RYlxwqi6kReFn9Yv41n6AcZnTquQKsndzP
 G0=
X-Received: by 2002:a05:6000:4308:b0:45e:8ad3:86a9 with SMTP id
 ffacd0b85a97d-45e8ad388bemr3229658f8f.8.1779186081132; 
 Tue, 19 May 2026 03:21:21 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/14] drm/amd: Delete defunct DAL power level code
Date: Tue, 19 May 2026 12:21:04 +0200
Message-ID: <20260519102118.246466-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Delete unused code related to DAL power levels.
It seems that the DAL power level concept has been
never fully implemented and was thus non-functional
in amdgpu.

DCE 11.0 and 11.2 never actually relied on the
power level because they calculate all necessary
power requirements in dce_calcs and communicate
that using dm_pp_apply_display_requirements() to
the power management code.

DCE 6, 8 and 10 also didn't rely on power levels
because they always just set the maximum possible
display clock and the power management code
already takes that into account when setting the
power state. This was somewhat improved recently
by also using dm_pp_apply_display_requirements()
on these DCE versions.

The code base for newer GPUs doesn't use the
concept of power levels anymore either, so
this change reduces the maintenance burden
of the old DCE code.

On the DC side:

dm_pp_apply_power_level_change_request() was never
implemented in amdgpu_dm, and DC has been working
fine for years without it. Let's delete the dummy
function and the code that calls it.

With that, we can also delete the power levels
and the static arrays containing hardcoded power
level values. These were never used for anything,
only for finding the maximum supported display clock.

On the AMDGPU PM side:

The get_dal_power_level() implementations were
dummy on SMU10, Vega10, Vega12 and Vega20 meaning
that they didn't return an actual DAL power level,
and were non-functional on SMU8 which always
returned the highest possible power level.
Nothing actually relied on the power level
returned by these functions. Let's delete them.

What's next:

After this code cleanup lands, I have plans to
further improve display power management on old DCE.

Changes in v2:

Applied review suggestions.

Timur Kristóf (14):
  drm/amd/display: Delete unimplemented
    dm_pp_apply_power_level_change_request() (v2)
  drm/amd/display: Delete dce_get_required_clocks_state()
  drm/amd/display: Remove min/max clock levels from clk_mgr (v2)
  drm/amd/display: Delete max_clocks_state
  drm/amd/display: Set max supported display clock without
    max_clks_by_state (v2)
  drm/amd/display: Delete max_clks_by_state from DCE clock manager (v2)
  drm/amd/display: Delete disp_clk_voltage from integrated info (v2)
  drm/amd/display: Delete dm_pp_clocks_state
  drm/amd/pm: Delete unused get_display_power_level() function
  drm/amd/pm: Delete dummy get_dal_power_level implementations
  drm/amd/pm: Delete non-functional SMU8 get_dal_power_level
    implementation
  drm/amd/pm: Delete vddc_dep_on_dal_pwrl
  drm/amd/pm: Delete get_dal_power_level
  drm/amd/pm: Delete PP_DAL_POWERLEVEL

 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  55 -------
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  36 -----
 .../drm/amd/display/dc/bios/bios_parser2.c    |  18 ---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 144 ++----------------
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   3 -
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  25 ---
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  41 -----
 .../dc/clk_mgr/dce120/dce120_clk_mgr.c        |  16 --
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   8 -
 .../drm/amd/display/dc/dm_services_types.h    |  30 ----
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  10 --
 .../display/include/grph_object_ctrl_defs.h   |   9 --
 drivers/gpu/drm/amd/include/dm_pp_interface.h |  19 ---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 -
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  22 ---
 .../amd/pm/powerplay/hwmgr/hardwaremanager.c  |  10 --
 .../amd/pm/powerplay/hwmgr/processpptables.c  |   1 -
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |  48 ------
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  64 --------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  18 ---
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  16 --
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |  17 ---
 .../amd/pm/powerplay/inc/hardwaremanager.h    |   3 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   4 -
 24 files changed, 11 insertions(+), 608 deletions(-)

-- 
2.54.0

