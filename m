Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71698FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 11:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13CDB10EB2E;
	Tue, 28 Apr 2026 11:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ixvAKgti";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A256B10EB2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 11:40:49 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so103772505e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777376448; x=1777981248; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sHeB+go/zZC53xVXHMnqafQ7Ya/z04/1WDavSA3PEAk=;
 b=ixvAKgtia7ryNGpo1eAnykqEK4v88aaFlysCpSl4G7KX3gu2ACzXyLkkSnSxNTf1XN
 LSDi1evBhOQ7JT0Yde2MpITpQMo/2F0bEU0cD9VzYKy1gpWKWm7gE4RYCY4XrdWZXsrH
 TJJ2tE8GXPYYAHKz5o9qmZ6gFq5Z2nLCjdPM2pGIVWX4/PogTRXHQ4HEcNpajGPDvyw1
 QBxwKth7RaTL+LS09MxL1cUs5f+xGrefuN0SnSe0dHcbHm/eaavJ4DMTRAkwnC7ZvV8F
 4J9/t8GKSp7JWRzeVXKP0NjgmEBjzVqAb9mHuZC3UkQES6rSFR2TJUSSb0rMi62t/7m/
 KD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376448; x=1777981248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHeB+go/zZC53xVXHMnqafQ7Ya/z04/1WDavSA3PEAk=;
 b=lQSHgpARy/6vfSPFDqFEmUZ4fO4T95UJrDvz1x9gfppudZy60bv69AwofHrsQWs7Yx
 Ygzt1ZHkIqu4dHcHMjqrOzjrNjTrcNxZkBY6mYmNNjsrOQnS98+4pvV99jBT0eeWO7TF
 wpwKYXWdYuMAlFLWMEOXWa1COt13SwK4ei6H/udo3YT5wBOHgcRkn+kHUPvZY8nMBDm6
 veE3UFAUnUmGcJf2Znrh2eAo09TjjjFMcptEik9cQx/07GJxUpHYZFaaj96hx3pEa4cW
 yH6+J+md3SayGUFQ4ImS5q6KgaLxRJnkSvf/CYK0KFLixQA1lzPgM3KAE9qeJEYTmzy5
 gcfA==
X-Gm-Message-State: AOJu0YxRqfoY1eJTFQHTTQANvPd2XLfLBd+bxsgrlV897NDVLUEalsDU
 PLhVZqf3AVOhlekMX8ST6UqjT627CFVf9c0lkfspfDCHe7Lx8vlxHILJXufvndiE
X-Gm-Gg: AeBDiet+S3kVvxOmPmTZe4tXh68SuZzxvwPmwzu+O4V5iygewJ9pPBEXMAKfaBZ9f5d
 XiNOUYTq3SYkjAbtrFJpAQ2qnsiLNepHORDHPUL46D/+7F1QLASdzHn5TBnXUBBWBfGNjq7RX0K
 LXti9qLgufZ2/VavSq60+LZMee/kLpPraxMvi8GcEuiakSMeVnIAlPADSLmIqwp19O38Mvu3agX
 og88YVFezsBgyDdBQ/tj2IUeGU4FBPvD5gY/6tSa4n9nKA+rze5lssQw+kUFqGRyBaYyjPEOm0s
 euevBgnf0dG5efORXgBQ5ONrKehBtFI4azTntShtIEdpaziEtEMd4Z49fyVhUT3Bv19qYDrZkUM
 /MlT+iHpM6k0yVoWW5ALjyKsiNJJpzvqKq2XNOdWPvQTtfrnc+rOXb7M1OPuJj3p5TrgmSZjokO
 MovI3GVZ4Zdp6wi0AsMZwASHrvsmtj3hhFC4bbhRNnVVBABvDb4qij1rBAmgyR3XNBAdToKyssG
 wh4
X-Received: by 2002:a05:600c:1d1a:b0:489:1c1f:35f9 with SMTP id
 5b1f17b1804b1-48a77afd2a5mr41453175e9.9.1777376447945; 
 Tue, 28 Apr 2026 04:40:47 -0700 (PDT)
Received: from Timur-Hyperion.home (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775e4bd0sm25048275e9.8.2026.04.28.04.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:40:47 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/6] drm/amd/display: Fix embedded panels without DDC
Date: Tue, 28 Apr 2026 13:40:39 +0200
Message-ID: <20260428114045.40710-1-timur.kristof@gmail.com>
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

On some laptops, the embedded panel (eg. LVDS)
doesn't have DDC (display data channel).
In this case, the driver should use an EDID
that is hardcoded in the VBIOS.

DC currently doesn't do that and just fails,
leaving users with a blank screen.
This series fixes embedded panels without DDC,
allowing this case up to DCE 8.

Timur Kristóf (6):
  drm/amd/display: Allow embedded connectors without DDC
  drm/amd/display: Allow DCE link encoder without AUX registers
  drm/amd/display: Allow constructing DCE6 link encoder without DDC
  drm/amd/display: Allow constructing DCE8 link encoder without DDC
  drm/amd/display: Read EDID from VBIOS embedded panel info
  drm/amd/display: Use EDID from VBIOS embedded panel info

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 44 +++++++++++++
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 62 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  4 +-
 .../drm/amd/display/dc/gpio/gpio_service.c    |  3 +
 .../drm/amd/display/dc/link/link_factory.c    |  4 +-
 .../dc/resource/dce60/dce60_resource.c        |  3 +-
 .../dc/resource/dce80/dce80_resource.c        |  3 +-
 .../display/include/grph_object_ctrl_defs.h   |  4 ++
 9 files changed, 124 insertions(+), 5 deletions(-)

-- 
2.53.0

