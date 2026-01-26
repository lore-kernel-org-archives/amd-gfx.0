Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B260D1951B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D7110E49E;
	Mon, 26 Jan 2026 21:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PW22N+0D";
	dkim-atps=neutral
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CE310E49E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:41 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so4628358f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461720; x=1770066520; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SLV5j3vfJ85QJtxGrWgTzxqkfOg55gqc3cOo0r0CTPc=;
 b=PW22N+0D+GzzfSypHBB0M6d1pWTya08AnYKeV4MfPR1tfE0/cCiaUcRYVMY/CAtpSo
 iew3gvBXss2riRA3hB0TN5IxHdhNl3y8VqQA6MQp4kURKHQsSr03y+HSv0QuSHyzO3sz
 CcH5t6Pk3lMsSTm2MkTLLP/4qBhead9BYH9ji0dsWGUn9pRqK+dh8UmgTaAZo5nOlnbP
 lGkP8GhtporOW4xAonXNm92fH3GqFwu4vM3C7E6gxWt/rusYgrvgQKZSOqyUg0TKo/u0
 nh8yJgslf9rwDMHpFOMGjLYlucCWBFdsoOHDK5UGJG40gNNvTuOWMoEl6r+7S8lNhcvF
 uaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461720; x=1770066520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLV5j3vfJ85QJtxGrWgTzxqkfOg55gqc3cOo0r0CTPc=;
 b=rNK4j8M9nxkE/NGE3T/UHSNlPnQopUGonksF7XHjEVAFZuaysstcx4l8WosB7IxiWQ
 xRpplsp5R5V9XnagxR2dWY+gRYmVScegFjNNpk3JsU2oJxYr53TfsyIUV37XjAi5Ceey
 CYAEHrUlgLnwZUHhuO4V4JDGe+FeHmRN/4EoaCk2iPIXaiZmeLffpY0TZ+iSvz8GxeGQ
 l0uUWNhV/NZolpYlRbiih43GKnWbKA3yYbuKWMKkwdOC4b8q1a7CP3WYhHD3QA1sx6UR
 8vOMUmt+vipn/wqLG34c038uBdqhY0YXb3p13PVhAJfnd/aaRCzw1gzrJHW9qW5JCvx1
 BnMg==
X-Gm-Message-State: AOJu0Yz4gSUa7IaNq2WTMFdei0konZ3gmn0dvHglo6o1U/vcX9K6JTzE
 DIo4Q0jk2XXr4udHncOSao6nY4f+UJzScf/m/lRXAsR4Saaskbn6rlXoVViiV56A
X-Gm-Gg: AZuq6aKT6q4SQMSXxcylCEAH8lokvpSKBTSuXgKnvQBnDamaGid9BrLrvmGMyYPJE4r
 6EZtf19E4wmAtxyyzUMitww/J2j34e3jr5swqbadWp/5RR9Ot7Wyu0gUdXKEnul8fQR0zOFJRKH
 btSyZP0yhiexmHPvNOgKDtEf+JtwWFxeX2FFBH9fd/T7fXxL8hicU7s9CyW0tvOIFfSqsqvXPEC
 UpEQTGAJoL6nbVc+nJLDqJmCVeEFYm6ny2ps4wzGyXW5vPD35jRQXXhBBdEFSiT85TRRH+YftNB
 piDjLEeLUbl8EmINrAOPhylKmwscmnjzU5WM0A1ulTWIBdZir3i9If4+YsCCc50WNEVimFUQixm
 9/sGIKHT7mOTeKhABLj7XZNnXggJ9O88INPpFFCY2bgH6PxfaOvVOmjudFXepy5U87H7tF+1NMd
 S1IzpWDDPMAHeJyAhaVgG3Rx2SGHqE0PMDDfnU8rOY8XAvHZVIIaFH2l4WNNLav4s=
X-Received: by 2002:a05:6000:400d:b0:431:1ae:a3ca with SMTP id
 ffacd0b85a97d-435ca0e2adbmr10338493f8f.11.1769461719432; 
 Mon, 26 Jan 2026 13:08:39 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:38 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/14] drm/amd/display: Add support for external DP bridge
 encoders in DC
Date: Mon, 26 Jan 2026 22:08:23 +0100
Message-ID: <20260126210837.21885-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Some GPUs use external DP bridge encoders NUTMEG and TRAVIS
to implement analog and/or LVDS connections. Typically found in
CIK APU based laptops or on FM2 motherboards that have analog
connectors. These were necessary at the time because Kaveri
didn't have a built-in DAC nor LVDS support.

These devices sadly don't work transparently and need to be
controlled by the driver. This series implements that.

The first half of the series contains some minor fixes and
refactoring necessary for these external encoders to work.
The second half then adds the actual external encoder support.

When we query connector information from the VBIOS and
discover a connector using such an encoder, let's find the
real DisplayPort encoder and use that. Set the connector
signal type to DP, so the pre-existing DP code paths can
work with it without refactoring every signal type check
in the DC code base.

With that, we can now enable DC by default on CIK APUs too.
DC brings proper support for DP/HDMI audio, DP MST, VRR,
10-bit colors, some HDR features, atomic modesetting, etc.
without any loss of functionality.

Timur Kristóf (14):
  drm/amd/display: Use DCE 6 link encoder for DCE 6 analog connectors
  drm/amd/display: Only use analog link encoder with analog engine
  drm/amd/display: Only use analog stream encoder with analog engine
  drm/amd/display: Add color depth helper function to BIOS parser
  drm/amd/display: Refactor DAC load detection, move to HWSS
  drm/amd/display: Implement BIOS parser external encoder control
  drm/amd/display: Implement DDC probe over AUX channel
  drm/amd/display: Add ability for HWSS to prepare the DDC before use
  drm/amd/display: Use preferred DP link rate if specified
  drm/amd/display: Add DCE HWSS support for external DP bridge encoders
  drm/amd/display: Link detection for external DP bridge encoders
  drm/amd/display: Use external DP bridge encoders
  drm/amd/display: Implement DAC load detection on external DP bridge
    encoders
  drm/amdgpu: Use DC by default on CIK APUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  11 --
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   3 +
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  46 +++++--
 .../drm/amd/display/dc/bios/command_table.c   | 124 ++++++------------
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   6 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  67 ++++++++++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +
 .../drm/amd/display/dc/link/link_detection.c  |  56 ++++----
 .../drm/amd/display/dc/link/link_factory.c    |  29 +++-
 .../dc/link/protocols/link_dp_capability.c    |   2 +
 .../link/protocols/link_edp_panel_control.c   |   8 +-
 .../dc/resource/dce100/dce100_resource.c      |   8 +-
 .../dc/resource/dce60/dce60_resource.c        |   5 +-
 .../dc/resource/dce80/dce80_resource.c        |   3 +-
 .../amd/display/include/bios_parser_types.h   |   2 +
 17 files changed, 228 insertions(+), 157 deletions(-)

-- 
2.52.0

