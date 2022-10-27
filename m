Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68880FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 14:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CFE10E667;
	Thu, 27 Oct 2022 14:58:56 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D06710E65E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 14:45:56 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id jb18so1187106wmb.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IAqC1HKVNV7rs1WtvU904YHZiDgWJOrzWfsvwETeujE=;
 b=ZQoJZJ2pk+FgSb1zhCFw99ZrOd1qW+do1Yf8a+dkAAlCE6k8NxK9xdhLHyUvvWW+jC
 huXB5GgpKQ+07AreOh+yv1jtXRuwazerG7nTymYzeFp1YTg1h67pgLfzqw5C8nXTlANS
 V4+npoMjBTsNgBH3HCLsIWar4Zn4p9UjD5w4h/Enc5RD6Zx+sgJ2A2WuDoemMh4AUXRj
 mjnzPLXDvZA3dZcMLwKPTuZhP1SmqCtDdUruxsPH3QEmlY+hjTnECpTXLnMJXIrVSqHE
 r7gLsfRtqm/UefSqqs3oBYTLIz9651i6IyQhukU2vuKK4uZgBZm47mCOAXUymAvgFVae
 8plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IAqC1HKVNV7rs1WtvU904YHZiDgWJOrzWfsvwETeujE=;
 b=IJuQPVm1dPqPJpxAaFb3cQgLXMMIMcf7o2aZFRiiGMAc8wukIS8cGWZTxmJWf9NuhW
 kn186pUgWvnNkP2vTiKmUcjhAyDw9ADFRU90BCGJrTCibkn2dhojC2sqd0rp2sbbQFpx
 emjyPadeDRi3oVZiO8cQ7Qq59Gaq7AIX4BwbN8rzxt7qFQfgfk/gFoi7blQqiOvuEgRS
 MEs1fcNXgl5/z5skQ1hJ4LPdoy3jN7KiqrZhtKraxXYNVZf6RaS/hselO6BxIy0gTbkI
 E2IOtPxQEsiCGP0wyWKs5t8VKzZFpsF+YY72HNwOn8dMQJtIA30IgPcnlsNW5fHVUad7
 slcA==
X-Gm-Message-State: ACrzQf0M+3IhVdzjG+zw8Dx7no9s6qAbs6lsRn6ixD3EKEgEHGUDEjk4
 T/ZmukksB7EhmYBcCZUffaw=
X-Google-Smtp-Source: AMsMyM6keI129AiE2PP1FBIClELOYwSPfhUKJbouSNXbxR1dFjbffgYRhgYiL6wHA69bcp1B+gJ1gA==
X-Received: by 2002:a05:600c:3545:b0:3cc:74b:736a with SMTP id
 i5-20020a05600c354500b003cc074b736amr6026791wmq.145.1666881954572; 
 Thu, 27 Oct 2022 07:45:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a5d50c6000000b00236576c8eddsm1340914wrt.12.2022.10.27.07.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Oct 2022 07:45:54 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 0/1] drm/amd/display: add DCN support for ARM64
Date: Thu, 27 Oct 2022 16:45:27 +0200
Message-Id: <20221027144527.4247-1-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 14:58:52 +0000
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

Change Since V1:
replace $(dml_rcflags_arm64) with $(dml_rcflags) in dml/Makefile

Ao Zhong (1):
  drm/amd/display: add DCN support for ARM64

 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 21 ++++++++++++++++++-
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.37.4

