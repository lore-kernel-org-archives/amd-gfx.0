Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63D0ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 19:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393E610E163;
	Mon, 31 Oct 2022 19:40:05 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D6E10E143
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 19:39:01 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id o4so17413172wrq.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J3/rSxQE1Xug/60dw8xgqtSnw9Jfpx5WWVH4mLl2SyM=;
 b=VEZtM7Of0uvgOIBm9LqFfxuOrtmZlZ9ywmTw4uN9AAqMPPDVF0vMyLC8ccioTKFinS
 8Sx/6f4Wu1jACWzdzTN6Ds5HU+/rNu5Lm8+lzJ50aNyv1J5bbpQhttSfRlRv2HUC91Te
 K4XPhtio46+2Sd052W/TRWMzqvWg7Z5+a8AahCmvJIXVPSdLRqvVHenBGf0rpMwfuvdT
 7MTxSEsorJtv5ihgVStw0vaMqaCrXHMaqLqPjwjHJrkgP/juqHRu6NfIx7nrS5BV5UGK
 RCH8TxA4jWfY+3UTXibnPNwcbxfdm9ZL8ehg0arGk6IccyyUdjmK22i1G3tvr4H3/jIm
 odVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J3/rSxQE1Xug/60dw8xgqtSnw9Jfpx5WWVH4mLl2SyM=;
 b=kIxVH2YkvOxgRzns1sURC2EILpdZINoCc17FmysotST+4BkCCAvPzonIB14CUE5krF
 2rPOsuJOfRrfGt4nY6HcqAvrHxBJ8wW5pYXRMxro8xRK3AEAA24ehLVDhHpi6LhoBRPl
 2g0wLp7tSH02LzHto5zWC84KgLB+teoUZTbd7Urh5n7PeIcylalXm7RvaF9slLBT4NmY
 zGrDMwSsT3cWVKp+TvcWjfz5HQE/GyFHqSJRXlNujCYtXm2QUnMyDFugFR6du0KIUwnA
 FOHm727eejGiWifv9X1NzqNnqOy7wX0Td+4V/AiEhNqcqRWXFcChjEsaMkbVtj0DGVm9
 l+qg==
X-Gm-Message-State: ACrzQf2uq+ONlEy/UyWqHY2e2xg2bvoU87WF/JYiR+ng2momrB1/SrlV
 S0si2G9/JizPhFEn7Q2YM/4CLlDOBKqePg==
X-Google-Smtp-Source: AMsMyM7ddQvN7hSjOX/KEugGz7zogQHpjG7mh36wLY5nLwhz+F8aRQj6q53yl35chXB9i0YrwZs+WA==
X-Received: by 2002:a05:6000:90b:b0:22c:beec:5b26 with SMTP id
 bz11-20020a056000090b00b0022cbeec5b26mr9151098wrb.490.1667245140060; 
 Mon, 31 Oct 2022 12:39:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c414900b003b49ab8ff53sm8216806wmm.8.2022.10.31.12.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Oct 2022 12:38:59 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v4 0/1] drm/amd/display: add DCN support for ARM64
Date: Mon, 31 Oct 2022 20:37:38 +0100
Message-Id: <20221031193738.23538-1-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Oct 2022 19:39:59 +0000
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
Cc: Ao Zhong <hacc1225@gmail.com>, linux-arm-kernel@lists.infradead.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello everyone,

Recently I got a SBSA ARM64 workstation, and try to use it as my daily
drive machine after installing an AMD RX6400 graphics card.

Since the newer AMD GPUs require DCN (Display Core Next) support to work
properly, DCN is not supported on ARM64 platforms. Because some code in
DCN needs to use FPU, and aarch64 has no soft floating-point toolchain.

Displaycore developers have started isolating code that needs to use
FPU, and most of the code has been isolated. In the process of trying to
enable DCN support for the ARM64 platform, I found that there are two
remaining code blocks that are not isolated. Due to -mgeneral-regs-only
is enabled by default to compile the kernel on the ARM64 platform, these
two code blocks will cause the compilation to fail after enabling DCN
support.

I have submitted two patches to isolate the remaining two code blocks
that need to use the FPU.
Links: https://patchwork.freedesktop.org/patch/508813/
Links: https://patchwork.freedesktop.org/patch/508816/
After merging these two patches, we can enable DCN support for ARM64
platform.

I removed -mgeneral-regs-only CFLAG in the dml/Makefile for the code
that needs to use hardware FPU, and add a control mechanism in
amdgpu_dm/dc_fpu.c for ARM Neon.

Change Since V3:
- Check if CC_IS_CLANG is disabled, since current DCN build with clang
  on ARM64 is broken

Change Since V2:
- Drop CONFIG_DRM_AMD_DC_DCN check when initializing the dml_rcflags
  for ARM64
- Drop CONFIG_ARM64 and CONFIG_DRM_AMD_DC_DCN check for the per-file
  cflags list entirely

Change Since V1:
- replace $(dml_rcflags_arm64) with $(dml_rcflags) in dml/Makefile

Ao Zhong (1):
  drm/amd/display: add DCN support for ARM64

 drivers/gpu/drm/amd/display/Kconfig           |  3 ++-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 20 +++++++++++++++----
 3 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.37.4

