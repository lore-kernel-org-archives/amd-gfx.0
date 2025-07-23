Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6949CC83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B141410E7FA;
	Wed, 23 Jul 2025 15:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BSFcNIju";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 856F110E7FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:22 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so647306f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286301; x=1753891101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s7Bb2bkbINX8vl8ohKoPIZOgpdLwurI8ziNiQq9fbf0=;
 b=BSFcNIjuctQkhsbiYPIwhPkjrqdnP8O5ZmA7KCY+zZU2x7a6JP5yrG4jCXcOCcRk1k
 XVru7sL/04oI666S3MijXSCSkvdsEW/MchnHgN1/4zYNlMPV9g75zQUfjas9Aofo1Wp7
 9VQbCDqnEH3YOSbMu6pbWWUlBziEehEKnccZHDL0GaUoy/nPcV280NrKP5MHhj/tXSKP
 E5N0uOGeRW32hIQeof4qA4rBvSYgqEu/8fyimGWh+HWymg3bEKDaLdjJ6ZJu90Fnkx4a
 u8jQhQWhHLYfBpJf7L3Oi5HU08Sru6KXwUM75kIvzlBWIRVy+B08thQPerLiKhLUKcRY
 fHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286301; x=1753891101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7Bb2bkbINX8vl8ohKoPIZOgpdLwurI8ziNiQq9fbf0=;
 b=jaRQnu8fQs55pCjTLIt8G1g6rzK9LSL2iV+6R5gj7oGU0c2Bg7zA/0X1uhoNzvFFrp
 9wqlgLc5esB3J5BCLDNP5uKpRqFP6yrk4le70pgpt4T7N3UUHFrUDIQlEAmSyN5rH9kq
 4ctT1tfIppktxlmlEXzgtw3Q4VoRzTgEaKK10jOwGKh0rCQ1mQWrDEmjx3N109pjnebe
 beZj2x862WJyUwFcMMGSXhl+d+eHUVAWpS5coHLBHs2ody5p37Bo0JK4Vr76IJY/zrOd
 bOIfZHC8SMEKh5JAOrlqDjG/pueO1Rh5B2+RyLYouPq3+YvVfKC86Ua75QhxhnDhGeCH
 3Pew==
X-Gm-Message-State: AOJu0YxZVd9WI0q+PZdYeH9ZaSC8pH130suoAMKRrRDx11wrlp78JMdP
 JyZZVpFS2QIcB9YMQXAbIz4IrjYfPKa+a8XolkirhNTParwRRz4X8n7ssUqHWA==
X-Gm-Gg: ASbGncstXREe3qamSxqk1phIeJkbnpNkJwERf6UZLemnhxqcpl6xjmaPbaWkMSe+xbA
 uH7IoKvntD0o8vkwoOWDDuRNQe3oAesFgMV0CkQ1e1INEnQNyknSzMaVjsAdBgCK/hJYuOqqO+W
 MjKzkTyzc6FJwyw+PLjNZvvDFaHpK1wSwvJLnR8xuSrqXqUSx/f89BZriuBqCs4Ih0lZJduVJFn
 DQiXLseUMjlXjhljjuJOXmszF5QG8rX0xtz//300VXp5/Nf91ANs5E1LFgVm8emr2XY+DdqJZpf
 ICbUkpMTSuW3ARyrLovCQotptQtsZfGmqNwkOKS4u84Xg3tj2q78pPeNVPUd4FJBx9v/4tY8JvW
 nBPfMpnlYzKvLUBheD/145O0eObcohrhUcPMaye+8x4ZS679yws+yD3VGwAQ9Vcy4bk1Ta/VV4K
 JhtBNWJ70SC+UANVohlvkxlE8Yc2fWXepe/5oa
X-Google-Smtp-Source: AGHT+IFMUgbO/Krne3derNrc7yodMjQ0CjRpwjpqGxPAaVusyUGwK1wL8uVig6tIRaTSjFX0FIMl9A==
X-Received: by 2002:a05:6000:230d:b0:3a4:dfbe:2b14 with SMTP id
 ffacd0b85a97d-3b7694dfcb9mr2710502f8f.16.1753286300645; 
 Wed, 23 Jul 2025 08:58:20 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/20] Analog connector support in DC
Date: Wed, 23 Jul 2025 17:57:53 +0200
Message-ID: <20250723155813.9101-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
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

This series adds support for analog connectors to DC for DCE6-10.
There are two reasons to add this support:

1. GPUs that already use DC by default and have analog connectors.
Some Tonga and Hawaii graphics cards in fact have DVI-I connectors,
and the analog part doesn't work by default. This functionality
regressed when switching from the amdgpu legacy display code to DC.

2. GPUs that don't use amdgpu by default yet.
Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by default
yet, and missing analog connector support is cited as one of the
main reasons why not.

With this analog support added to DC, we could already fully switch
CIK discrete GPUs to use DC and switch them to the amdgpu driver.
For GFX7 APUs and SI, further fixes are needed before enabling DC.

Before starting this work, I asked Harry and Alex about how best
to do it and we agreed that we'd like to use the VBIOS to set up
the DAC. So I used the amdgpu legacy display code as a reference.
The first few commits add some minor changes to DC to prepare for
supporting analog stream and link encoders, then analog link
detection is added along with polling, and finally DAC load
detection support, which is useful for old displays and adapters.

Please let me know what you think.

Timur Kristóf (20):
  drm/amd/display: Determine DRM connector type more accurately
  drm/amd/display: Add analog bit to edid_caps
  drm/amd/display: Introduce MAX_LINK_ENCODERS
  drm/amd/display: Hook up DAC to bios_parser_encoder_control
  drm/amd/display: Add SelectCRTC_Source to BIOS parser
  drm/amd/display: Get maximum pixel clock from VBIOS
  drm/amd/display: Don't use stereo sync and audio on RGB signals
  drm/amd/display: Don't try to enable/disable HPD when unavailable
  drm/amd/display: Add concept of analog encoders
  drm/amd/display: Implement DCE analog stream encoders
  drm/amd/display: Implement DCE analog link encoders
  drm/amd/display: Support DAC in dce110_hwseq
  drm/amd/display: Add analog link detection
  drm/amd/display: Poll analog connectors
  drm/amd/display: Add DCE BIOS_SCRATCH_0 register
  drm/amd/display: Make get_support_mask_for_device_id reusable
  drm/amd/display: Add DAC_LoadDetection to BIOS parser
  drm/amd/display: Use DAC load detection on analog connectors
  drm/amd/display: Add common modes to analog displays without EDID
  drm/amdgpu: Use DC by default for Bonaire

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 144 +++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   8 +
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  95 +++++-
 .../drm/amd/display/dc/bios/command_table.c   | 286 ++++++++++++++++++
 .../drm/amd/display/dc/bios/command_table.h   |   6 +
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   9 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 +
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 100 ++++++
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  21 +-
 .../amd/display/dc/dce/dce_stream_encoder.c   |  14 +
 .../amd/display/dc/dce/dce_stream_encoder.h   |   5 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  75 ++++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  24 ++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  19 +-
 .../drm/amd/display/dc/link/link_detection.c  | 123 +++++++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
 .../drm/amd/display/dc/link/link_factory.c    |  31 ++
 .../dc/resource/dce100/dce100_resource.c      |  28 +-
 .../dc/resource/dce110/dce110_resource.c      |   2 +
 .../dc/resource/dce112/dce112_resource.c      |   2 +
 .../dc/resource/dce120/dce120_resource.c      |   1 +
 .../dc/resource/dce60/dce60_resource.c        |  26 +-
 .../dc/resource/dce80/dce80_resource.c        |  23 +-
 .../amd/display/include/bios_parser_types.h   |  11 +-
 .../display/include/grph_object_ctrl_defs.h   |   1 +
 .../drm/amd/display/include/signal_types.h    |   5 +
 34 files changed, 1027 insertions(+), 76 deletions(-)

-- 
2.50.1

