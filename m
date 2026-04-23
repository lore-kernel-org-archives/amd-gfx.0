Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B343FFDEE45
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6C010F236;
	Thu, 23 Apr 2026 19:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YGDCrm/N";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618B510F236
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:24 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4411e1eba51so3589225f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971723; x=1777576523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XD9YqW1ZhBfWVo9tTfxBp7CNJmkjnAPhJ+3R1hcOLYk=;
 b=YGDCrm/NpNuhLa/EJPZ5ryGM9ywW3nEqqI6qRYxHpEndhzu/U2+KsBjvcc/w/MkRDf
 Naf1QC/E20qVVj5gijI/Phs4rsvyoFdfwxJBN5j1fr648Nzm7g1FZ9zVIbLDbBhBvj9w
 aQECW0qKOQQygeFEzr2cEfJTvHxsPSuE7sK+ljZGOqxYQDgXpfU12e8erRH7Ea89ae6v
 wQmsAnP1jNjD4d7QLThsfSgWnN/K+26lhmuUL6cZAoALx9pT+WUBHeVuD7e4vhB9UhVb
 +eJudeGttB6TdfoxwrZDZFUHklQYvC1f3f/RmSro1HbkD4XgSkg8HJeMc/ZE8j6aP/Kf
 H9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971723; x=1777576523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XD9YqW1ZhBfWVo9tTfxBp7CNJmkjnAPhJ+3R1hcOLYk=;
 b=hMKe+yYhwN6y4mXsCxVdQ7zKA4q3g9/KLUMcbi3P+1DHcSORZWPZGqSiGm1S/+X1d0
 wCtoeRfW4SZihWGh68oADzalVAmECDG+0kZiK1+k2D6qP+SzAfTMNfi4Zc1KE7VvEGdd
 A0EtQ+cPDhD0/UrfvjC389BXrwOaFghQ+aXOmGUoVzFvOV/bX7sNRLCSnn4GsCtHL6P6
 YEppzZQnrN6da+8hDYdPnkGNezTpD5wIohDSzCHTB0EbCFXzDDFwA0QelqP703haWqlH
 XSkyQ3//ol3zslTDuh51PLKEH9yTXsMTLd8bANID4oqQXh8hzwwCb040I5KJajZzwW0r
 KgTw==
X-Gm-Message-State: AOJu0YzC5A92WbSrisP1Z2cgBTLjaFz+5otBRLEWen6IB6eO6et/oSYG
 FBoiDEqeppnG6cd30z07Hld8w/k/OSxP0O7BsQ5Cfd7bKhpsUWuzA7gzauOxjR6/
X-Gm-Gg: AeBDieuexy4tdpcCnwEhXc4E5cdCP2Pm0s85k3wKW+NQ5I5HyVX/UuGcw/ymjrZuJVs
 SzKqakwHM0yXNReu2PxAYHk9Xv5bUK25LHiT8qn9YAZ18jQPK/nxo+xSpzI8l/BH3dHyoe+4eSL
 A9B9xM6j1b5hLZ5Fe7ntRZ4QPjJJw9EROxfRe2T4bzk/SuOyo0bXo+ewK8OLY2dZ39k2SI/XRon
 NUKvsi8INCiN6U8Y23t/sj9Hdvf4VpbORk/9/KQKDAGgedtcHsfqyOKNQrIGK2kG5SRw9WHvEAB
 gr+0EPNzCgg5ycqMDwvB6h2Ve5xvo8slKnFswBuJobJhx8Psc5yjlgm2/VdbiQBTVszW/STq7zI
 CopV4Yx/BMCJROGbY8zOyh11QWDW0bZ1eR6PzaFWkgWU2wI8DWJT5ieEiczmT9Rr7xrx7f7csQ1
 qx1WWaxln11KdmIznQ4Hr4a8XuqEBI9XF1BLR/giQhv8E4e+KClvN83xnVsq8nc8oTVpfrDWG0H
 CgdhQ==
X-Received: by 2002:a05:6000:220c:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-43fe3db9c7cmr43578149f8f.9.1776971722610; 
 Thu, 23 Apr 2026 12:15:22 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/14] drm/amd: Delete defunct DAL power level code
Date: Thu, 23 Apr 2026 21:15:05 +0200
Message-ID: <20260423191519.73127-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Timur Kristóf (14):
  drm/amd/display: Delete unimplemented
    dm_pp_apply_power_level_change_request()
  drm/amd/display: Delete dce_get_required_clocks_state()
  drm/amd/display: Remove min/max clock levels from clk_mgr
  drm/amd/display: Delete max_clocks_state from dm_pp_static_clock_info
  drm/amd/display: Set max supported display clock without
    max_clks_by_state
  drm/amd/display: Delete max_clks_by_state from DCE clock manager
  drm/amd/display: Delete disp_clk_voltage from integrated info
  drm/amd/display: Delete dm_pp_clocks_state
  drm/amd/pm: Delete unused get_display_power_level() function
  drm/amd/pm: Delete dummy get_dal_power_level implementations
  drm/amd/pm: Delete non-functional SMU8 get_dal_power_level
    implementation
  drm/amd/pm: Delete vddc_dep_on_dal_pwrl
  drm/amd/pm: Delete get_dal_power_level
  drm/amd/pm: Delete PP_DAL_POWERLEVEL

 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  39 -----
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  36 -----
 .../drm/amd/display/dc/bios/bios_parser2.c    |   9 --
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 144 ++----------------
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   3 -
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  25 ---
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  41 -----
 .../dc/clk_mgr/dce120/dce120_clk_mgr.c        |  16 --
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   4 -
 .../drm/amd/display/dc/dm_services_types.h    |  30 ----
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   4 -
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
 24 files changed, 11 insertions(+), 573 deletions(-)

-- 
2.53.0

