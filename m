Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F859CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 14:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E5810E767;
	Tue,  9 Sep 2025 14:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E0pnmdX4";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A1510E24F
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 14:18:03 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-244580523a0so61024645ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757427483; x=1758032283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K2Tjdqso+F+6YTAWuvpvdkjKywUIVgYnEuBMVKSaQbU=;
 b=E0pnmdX4uotAAv7N2SL9i4spX7lu/ZFfYNyn1BSMbm57l2KDrzF0H5VOVy65K9YAnh
 cxOSkfLhrvMKLfSW0/xjDMevYkx7h4KyVA99N5susH+1s+RpIKRup7nu3lUnneel54ZH
 Ak4ZCkzwdj4P37hr11xPgaL710YDtZfgxJ7/FQB6KD7B6RmkI4P0uCrPEor3DNoeOVLz
 rlR6Rn+ArekxAqda6py49JHcQTgGoZKfDyGlk+43FoBWMU11n8fqMRkLmtLsjUfd8CSj
 dNseqhYPZ6TOMM0w8nKchCjWQM5gbl3h1Hhbanct+yA2u6eF8eW8WNp8OtRVBnJe6mLh
 sBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757427483; x=1758032283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K2Tjdqso+F+6YTAWuvpvdkjKywUIVgYnEuBMVKSaQbU=;
 b=M83aJsaw52DEFLzHcjKHWut4juCQXQXC2C13yBLPkwfUxL/Da7Kg0BZqv0gcDjmo8i
 fRt8bl6XgDJhiiTvHirF0HN8yjcRWibfqPAcZPnuQToVpktqqsywwAMgONCCq9TI7Cy7
 AUPKC0SuIvf5NTCNqgsjLxP3lLzPu9VRIfz3rOiYh+mcWZJJhkv3I3rChCV2djWWkgpG
 HFc7XXj98mbp5EqyIDxQ7ZM/YfiJRzaqm31IuqhwmbXw9JUM6bAV3fHgHAZD/x1a9Thx
 vr6vulbMAEsn6Adp6pIq8pQ4qsYzGAz8Z7mWu0zWJvgrgpNo9h6WLneUIOfwp8PhF8sP
 anyg==
X-Gm-Message-State: AOJu0Yyjs2MGL15iY43KWCraMtJyJadJtHe4MQY8Wk3TaUr9I009ev/E
 zJdx5mCVDwYz4wr8w18TODCCQJwYXKOeGb6nL84OECSHCfizHWXj1T/tzEcE0w==
X-Gm-Gg: ASbGncvdCnaKsdQ5i12Pqbrz/XKq6YHOSNyrRRWx/w86ngj3NSD0fif42H9Gm8PPr8n
 UZC6sBl7EmfZfqTaWN1o4grgRtfKOPeh7l3sJHcc6nB93UfNTZRUrfB2GaffUSCfr0lqrHm8LhX
 fEiPFMRvgHTjUKETpSYFqzzNI2C7iVe36ThT8u2Gm0NOnafNBCjwib7P8ExPsOp6ob9PPxGyoS0
 Ze5wqhCUxCI43FCBL0PXFUlPZvCPxTSGWmUXQgRvQkUHDQCHNoqShrMOtfZSIu1HnpNrSyRWlGs
 AWHjPr4BqJMxM+Ejbv0bYHdZvM5N9WjOeXBXf9RIOm8tSSAWE8MLqvRG6eV1cXpK9h/2o5WKy4n
 sw2NK2xnNUKW71OVMvkgCwASsdG5fqdp1RAfwHY4X8khrrFrZyruE+kxX9CEW8v2fF30jFhP/is
 9TSlE8J+dyQRrhLdeEaW/Jo8f4Q32itor6yRJIKA==
X-Google-Smtp-Source: AGHT+IE5enO/J8psI4qmQTm87B/rrTCz4dhSOEPYFQ2ROVa4hFKUv7EzqrtdYdzyG6IxIXwzpV/eNw==
X-Received: by 2002:a17:903:950:b0:24a:9475:3db2 with SMTP id
 d9443c01a7336-25170c47740mr154493345ad.35.1757427481738; 
 Tue, 09 Sep 2025 07:18:01 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24D7A10085C74347BA908E23.dsl.pool.telekom.hu.
 [2001:4c4e:24d7:a100:85c7:4347:ba90:8e23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24b1ba1718bsm196057255ad.39.2025.09.09.07.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:18:01 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/3] Hook up DC to legacy_dpm (v2)
Date: Tue,  9 Sep 2025 16:17:49 +0200
Message-ID: <20250909141752.9517-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Hook up DC to legacy DPM, making SI and KV DPM aware of power
management related requirements that come from DC. This is
necessary for DC to function correctly on these chips when DPM
is enabled.

Background:

The power management code (DPM) needs to be aware of requirements
from the display engine in order to select power states that are
compatible with the display engine being able to interact with the
currently connected displays.

v2 of this series is rebased on latest amd-staging-drm-next.

Timur Kristóf (3):
  drm/amd/display: Add pixel_clock to amd_pp_display_configuration
  drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)
  drm/amd/pm: Remove unneeded legacy DPM related code.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
 .../drm/amd/display/dc/dm_services_types.h    |  2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 87 +++++++++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 -
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  8 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 +++++---------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
 13 files changed, 73 insertions(+), 120 deletions(-)

-- 
2.51.0

