Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3BDE73156
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 11:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DA310E433;
	Mon,  2 Feb 2026 11:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ql/iv4X8";
	dkim-atps=neutral
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA73F10E433
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 11:25:12 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so4583012f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 03:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770031511; x=1770636311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gY2o/AA2IbrfD+2cGc/MRx+DP2zXPexedogvXKrmhVo=;
 b=Ql/iv4X8jg0fwlPyqN26nr5ba7RX9qrsOXvhFTTai/JgACmnYR5qzirGUlCIx9tvHW
 qTRnksfjHpnnI/v43hmYVtzh5S9JpNcW/iqOX4a+kuLTgLXrZjA3ScmbMyDoZL2iVJuX
 dDbw+qm31KtZiQ6ssC5hDNKE9diFuwRayjYak9i7TXc3CZfUFZbx651JGhclrWSTEKVr
 N1mbP5vgEzidZM3qcIl1SLCZ5GkJCz3+BliQmP/NxFdBtULDPRibvSAdiPZieHtI//1E
 wj1COUstN8zcVs4ZVdpWPmz0KDWFLMXcTRj5iymwBx4IJg/yzePulkw00rCyNmslGF7D
 RCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031511; x=1770636311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gY2o/AA2IbrfD+2cGc/MRx+DP2zXPexedogvXKrmhVo=;
 b=KkF8iIe2fV2KFmZlzynL1Xa6Mv7XoFXB7Tdd9wnghsmhp+fXEcmoAXoGtLeXIhfxva
 YoG4vs3g0x8kduTESjJCOeKkeo+ZXZgbqAwgS0lBkIknL/RyillXW/EhYt+JfiiJ2/ni
 oXCk9SdeMxQvTaHiGnij+qGf0dseeUMa05bh/7vWf/du6wWGM4hj35GzSHxIiXbgzdHC
 HRZSgJyuVZEy7pDbYUgqgG23YnVA+Fse4GMk/93juG3d/dEMBhIYf4W0I7goNEN1x+Bm
 SuqPkiU0UAcD/SyukH2AMM5t/Woo4rIryV7EtfEiTBwKTr3roOmh9swuDFvVs6tJt36X
 c2Qg==
X-Gm-Message-State: AOJu0YwVMkXx7tf8ONsoAij44uRZafaUjmVsh7Eylde04CUKX8bL3/kY
 aeC+SBtFIr48A+/KZBpB38aGb5B1Q31cCk91G7A7dVezHSN3YjIkR+qE8WTzHWUm0j8=
X-Gm-Gg: AZuq6aK/ADFL4AkI5iDbzSdRq4NNVOrM1dRdpNSD+W1OvEQtgRLebG7+YpBQ2yKZfnG
 KnCxupflNuzlzUIiuLnQ9evyJC94xnPMhhhPpbbQEnF06pqQ3Sx9pA9IBLbWWIhsnwlRgLhDk8z
 SLEnMChOuxCHW7VRqOfAN9BgT1ql6f+hNfB3A27DdhSqpkdM8ff2o5zhU8r0NOFHw4s0YPIlkM6
 HFVAckkBwhPUbpi1SdXoeukjGggPCkELN0xHxmWotGGAZOvZEG1KgqKZj4CtcXwGHfUBLzjPazk
 5l5kRH3AKnBwMh01cqHyzSfBoFW4NC7aG7YsEdnjTq3AlZPMiJLD4CUorayZDQP91IJshNwvVcL
 tIgywfO8aCg3YceisV9/PQAHvf2ykWudnY8yi1VZc7CMt3XUxF+6y1zPgEqTBEVr/DWVOPn6hs2
 jIMGbl7lbOcDLd
X-Received: by 2002:a05:6000:4313:b0:432:dfea:1fa8 with SMTP id
 ffacd0b85a97d-435f3abc65cmr16063856f8f.45.1770031511127; 
 Mon, 02 Feb 2026 03:25:11 -0800 (PST)
Received: from Timur-Max ([109.137.72.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm43306225f8f.7.2026.02.02.03.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:25:10 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 siqueira@igalia.com, Mauro Rossi <issor.oruam@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/8] drm/amd/display: Fix and cleanup analog encoders
Date: Mon,  2 Feb 2026 12:25:00 +0100
Message-ID: <20260202112508.43000-1-timur.kristof@gmail.com>
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

Fix a "black screen" issue with analog connector support in DC.
The Radeon HD 7790 series seems specifically affected.
I recommend backporting the series to 6.19 to avoid regressions.

The series also makes the analog connector support more consistent
with the rest of the DC code base so it doesn't feel like a hack
anymore, ie. it brings analog connectors a bit closer to other
connector types.

Timur Kristóf (8):
  drm/amd/display: Use DCE 6 link encoder for DCE 6 analog connectors
  drm/amd/display: Fix disabling fastboot on DCE 6-8
  drm/amd/display: Don't call find_analog_engine() twice
  drm/amd/display: Turn off DAC in DCE link encoder using VBIOS
  drm/amd/display: Initialize DAC in DCE link encoder using VBIOS
  drm/amd/display: Set CRTC source for DAC using registers
  drm/amd/display: Enable DAC in DCE link encoder
  drm/amd/display: Remove unneeded DAC link encoder register

 .../drm/amd/display/dc/bios/command_table.c   |  3 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 58 ++++++++++++++-----
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  8 ++-
 .../amd/display/dc/dce/dce_stream_encoder.c   | 23 ++++++--
 .../amd/display/dc/dce/dce_stream_encoder.h   | 12 +++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 58 ++++---------------
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 14 ++++-
 .../drm/amd/display/dc/link/link_factory.c    |  1 -
 .../dc/resource/dce100/dce100_resource.c      |  8 ++-
 .../dc/resource/dce60/dce60_resource.c        | 11 ++--
 .../dc/resource/dce80/dce80_resource.c        |  8 ++-
 13 files changed, 127 insertions(+), 81 deletions(-)

-- 
2.52.0
