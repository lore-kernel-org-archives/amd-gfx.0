Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC896C9832F
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jan 2026 17:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2251110E1C9;
	Sun, 18 Jan 2026 17:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PHzwSfDw";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E479F10E1C9
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:31:54 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b87cc82fd85so65473566b.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 09:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768757513; x=1769362313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RAPqCFb3AmNGwPaYrmiohXs+K+e+af6SqmIBLvX1hBE=;
 b=PHzwSfDwesH0oK9ZZITnHMPv6mC+TK8kp9wRGy4kAIePYO/APwNPuOkQgJogBkiwOx
 vnu+XSNdt5f7UOZcyr2zb/KRUh/bO8S2o1cXzvPEnS4oChP8CRC52C8b5tDhHk16E6KV
 KhuVM6rqWwn8MkpzmnWxgbtpGNgM/EW+2vohb1fs7fO+MlTS23Vzi9a2sUkSGXlZJcjr
 EZtv1cgloX2UENDCG5c9d5WiXoxtgxivHeTGJS31coHCRGJUxV7zcK5fGqetFiPeymd/
 hagsQNYWcOSwq4Xu4ffuj5psCzEmbMdE1r4ls4BtnRRNcavGSREZJW7DoYXcCwg6Zn1J
 o5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768757513; x=1769362313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RAPqCFb3AmNGwPaYrmiohXs+K+e+af6SqmIBLvX1hBE=;
 b=CfAmJmxH3M7ze03tmykiP360xtdBYBPr/oPjyFoDeiGaJnEHY+GwMnKCMRYX54wVes
 zhyItmAAjJJA1E/LIPKvws249jeINaT3nrnXhI4SInm8vYqBCjjIqR5k3tTDnG0nSkP2
 XfIGejH20wI/2w0HYtunfQdpIfnVjyNxnm1su5zTSS5Ti/Wn0fhyU1GXzDAu+P2u65Ef
 LPHZkxTaO4O8+qIe5ukR32kC5jLow0rlZQ01ks+sx30LDVnzeCpJI6dOV5xxd8vrz9ia
 Qz6ZGYJUL9oNN4uzMGJn+IhBfFc93CIw/uOn1KDVvVdmQQW9TI+5SvQjJTvupnErJsuZ
 hWCA==
X-Gm-Message-State: AOJu0Yzee0DNRPiilg1KCGKev88iZDgN5zAztQRPzzrtaTfFCrWuJM5W
 30URovGBZmW+ZK85Z9G7IePxIzYS8b4wdxttq6/V6YgAwgYyrbgDrOIqCxu81Q==
X-Gm-Gg: AY/fxX4+7g9VPCB+2kPg90O0wDTo6UsHhWVzDi9+SIJsUBaYn0oCIHG6wy1KMr0T0ZJ
 tW8udhxFLabiN8iiEP7jCe/YuOhylTOFIgDEVcBNgnvIs+OFlUIINN8vx+dLjb9slIt4WaZcd8U
 yjV/5n1/ClH2C5YdO9knmpSGW9J/mOB5Zgj3aO+jBNDTd1PGZJl5QFimOhtrNrwOX4POQLi4eo/
 hiwVBedFOITa6kp4XobYbxwnGMyBPwG638sFVSsL69FdBle/iLet5KqbG0gRdFYiW/NHWXZFljY
 SziclfX4X6SOrD2zVBGF0ra21pCcHXvQHYNPi6yE0uUQrr9UNLYP1Nxt80aOVcuXmcOa3pmPcPG
 VnBCh3GZFmTaJv8S1TL1KUbvEFJQMMR4B5Jrb1qIlguPBkQUnagGTcJAkdJ/5vpPrtQAyfgRyKw
 5cT7rSTq3t/s7DQfRRd8TDC4kAqBUgsO0jiKAyM+v83bU6Het/dNIgjqVwkGo45/RHoy89aNhj0
 1sE8se8XHXu
X-Received: by 2002:a17:906:730e:b0:b87:6c1e:9ffb with SMTP id
 a640c23a62f3a-b8796b8551emr771611766b.48.1768757513206; 
 Sun, 18 Jan 2026 09:31:53 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e735sm876868466b.13.2026.01.18.09.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 09:31:52 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/5] drm/amd/display: Clean up some DCE 6 code
Date: Sun, 18 Jan 2026 18:31:45 +0100
Message-ID: <20260118173150.19790-1-timur.kristof@gmail.com>
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

Reduce code duplication and ease maintenance burden for old
DCE versions. Clean up some code that was duplicated between
DCE 6 and the rest of DCE.

Timur Kristóf (5):
  drm/amd/display: Use dce_audio_create for DCE 6
  drm/amd/display: Delete unused dce_clk_mgr.c
  drm/amd/display: Remove unused dce60_clk_mgr register definitions
  drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
  drm/amd/display: Handle DCE 6 in dce110_register_irq_handlers

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 165 +--
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  12 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  64 +-
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 166 ---
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.h  |  36 -
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    | 131 ---
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |   9 -
 .../gpu/drm/amd/display/dc/dce/dce_clk_mgr.c  | 967 ------------------
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  11 -
 .../dc/resource/dce60/dce60_resource.c        |   2 +-
 10 files changed, 88 insertions(+), 1475 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c

-- 
2.52.0

