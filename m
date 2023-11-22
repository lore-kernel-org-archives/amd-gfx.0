Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2E9C61D9C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 14:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D237C10E64C;
	Wed, 22 Nov 2023 14:05:18 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B111810E2B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 03:06:26 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b83fc26e4cso46039b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 19:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1700622386; x=1701227186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n4I/LD7GmsgMbduRtQjHbuBVYFqV+JeYB9eIa+Lz0UU=;
 b=JnsVzVcTpISkoewDdl55KHfcycitatFg/qQDOtcHmGJ0FgqktZcLUzf42AdSwcnZyg
 262Iu3RQs27RnRAHUN8I/m7QrUOUmy63jqdLNo4ILkXkDJZC6fly99bI6CnwdiETqIh8
 TNRJfYtlG3jxwOU6wz26XLGsiMRC9aeQRjVmhg8mMpTDLee+pPshmRtTsNLpyrNmwQp6
 C1p3SFJC06U5UGxpGCOedDy/LqALtpN4lYUFxnz5k19SQF3TNFJwsi0jLRMbTq+hb75q
 GGuP6BMxpEjCkBUONU5XCts3adPYrqYG0LncOb7k+upYM91/elHezcgwl2GaPDJ/eVL+
 +YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700622386; x=1701227186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n4I/LD7GmsgMbduRtQjHbuBVYFqV+JeYB9eIa+Lz0UU=;
 b=J5mk5fVR+mOykqesAcE6bVyCzxIt6wlw18Ourys651xUDqG/DQZJ9YyAiXyW0foun2
 PsE5dlz9FFeNLDQOY1ShwbmydqzRGSAn4LIxEAexHCpczJq8VCaeZsRg+CXXk+yj49vm
 LZSnD7zUnaCVo+civw/HLRbL2Mky9MUkbw9X3ERX+1x5wW+TH5JkY0wGGru5Z0BY27SD
 dHrQGxaj/I+KNs/HGP5c1Yve4WmcIj/qeuMMyIC9d5nAKRrYjQBHUeQUfi4UkK2IHP+Q
 Mokm2hijCsXI4we5IAcUEafjcQ4EZphMd2D4Vaap7LTE6fqBsrebgroc78/AgjDhkwIG
 4ETA==
X-Gm-Message-State: AOJu0YyWsj6gZQDEdYn7M7AAZHbsoLC6juEBRVlb8Yjf4Bq1nxhs23FO
 pLuvUD0p4sGWcHXj3VsQDxg2Jg==
X-Google-Smtp-Source: AGHT+IEIpXI2h8pXg+ykpqNNYZiarqi3t5LKkDhtbal14Y2nnzqjhX+0ng3mTUwJLxHE3tG0iOG9Lg==
X-Received: by 2002:a05:6808:bce:b0:3b8:3ec6:8a41 with SMTP id
 o14-20020a0568080bce00b003b83ec68a41mr673776oik.45.1700622383389; 
 Tue, 21 Nov 2023 19:06:23 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s2-20020aa78282000000b006a77343b0ccsm8614917pfm.89.2023.11.21.19.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 19:06:23 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-riscv@lists.infradead.org
Subject: [PATCH 0/3] riscv: Add kernel-mode FPU support for amdgpu
Date: Tue, 21 Nov 2023 19:05:12 -0800
Message-ID: <20231122030621.3759313-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Nov 2023 14:05:10 +0000
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
Cc: Pan Xinhui <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series allows using newer AMD GPUs (e.g. Navi) on RISC-V boards
such as SiFive's HiFive Unmatched. Those GPUs need CONFIG_DRM_AMD_DC_FP
to initialize, which requires kernel-mode FPU support.

I'm sending these patches as one series so there is a user along with
the infrastructure being added. I assume patch 3 would be merged
separately, after patches 1-2 are merged.


Samuel Holland (3):
  riscv: Add support for kernel-mode FPU
  riscv: Factor out riscv-march-y to a separate Makefile
  drm/amd/display: Support DRM_AMD_DC_FP on RISC-V

 arch/riscv/Makefile                            | 12 +-----------
 arch/riscv/Makefile.isa                        | 15 +++++++++++++++
 arch/riscv/include/asm/switch_to.h             | 14 ++++++++++++++
 arch/riscv/kernel/process.c                    |  3 +++
 drivers/gpu/drm/amd/display/Kconfig            |  5 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c |  6 ++++--
 drivers/gpu/drm/amd/display/dc/dml/Makefile    |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dml2/Makefile   |  6 ++++++
 8 files changed, 53 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/Makefile.isa

-- 
2.42.0

