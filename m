Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3176DFA3743
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 21:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF88410E70D;
	Thu, 27 Oct 2022 21:53:53 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E5110E033
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 19:53:50 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id bp11so3955654wrb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 12:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dJhvE1wrXqNaDnf3qxehmNOVSmrog8ZQt8ZKnj1Ow9A=;
 b=fxJNejyMkqENsTVBpqHNQZaRJ6Wgg7mu+FtdRePBeUCp61M16fjt40qOfR/4tL+rZc
 w8sfrNHiVG3xIZ0cGtJdNh5iw6ESyVndXW+r9YDhPgz6DAE+ZAI+7yMViLkFr/XN2csc
 BME6qvwr+otiEaQE97iZ7mVcxsELiiI6+TtzhH20IgADkClIpdeFBRWXx2QkiC2Pnl6c
 sNyrXqLsNfdewjZRXismXbFhZ9Z42ZCrqXLjkBvVffOsLBJ3teBwEi2tq0oMDOElihom
 BN8r/RtQv3WY4DO4sBZFK2IcXBrp3ypIjChUyC7kgDArJ6jvOHFFa80VYBFMqO+W9yiO
 +Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dJhvE1wrXqNaDnf3qxehmNOVSmrog8ZQt8ZKnj1Ow9A=;
 b=pKkCWsEi7RDsOXMkKghz9d7Bt0oTTjwOsWPHsc4EmJT5bvMWQBp1luoEKr4wTSgEA1
 UGdHP2bWuz7j5dx0I7V1U6J0sm3UZGGRgoX9q8GYZNmAaSQtI9Ak95Z4T1FQgrNdDfHl
 Sb7MgKx7n6ol8DN7g7famXyU/9/1lFOWg01c05GsMSDCsgWWXy2coig0BXLsA1yuO/XW
 qXXLSxs00xAg8XXdWnztpae/cMPmPUNtEXeBZgPTsZgtSvyfRNA+zG57QtFZ9RgOQZ3O
 xuGiTA7JqDkpA+dM2rHzx22powwjEa6/0wUsrvYM2pD0jVV0R8+l3kZ7uF2osRb4EuaN
 RJkg==
X-Gm-Message-State: ACrzQf0Kca7B72R17Oa/BdoxsE/nbSVMRJ0JraqmwKN/+X792Firw5xX
 Y/WIn0LJY2vPfYCrU20oBYI=
X-Google-Smtp-Source: AMsMyM7wVbJF0ku4PEGKKzGsvOyR3GkV85+lxtqNP0d93Ac+EEKDFpze++xx815DWUKEHZ06iWxJnQ==
X-Received: by 2002:adf:f743:0:b0:236:7309:1209 with SMTP id
 z3-20020adff743000000b0023673091209mr13886316wrp.14.1666900429010; 
 Thu, 27 Oct 2022 12:53:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a05600001d200b0023647841c5bsm1837976wrx.60.2022.10.27.12.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Oct 2022 12:53:48 -0700 (PDT)
From: Ao Zhong <hacc1225@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3 0/1] drm/amd/display: add DCN support for ARM64
Date: Thu, 27 Oct 2022 21:52:27 +0200
Message-Id: <20221027195227.5312-1-hacc1225@gmail.com>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 21:53:48 +0000
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

Change Since V2:
- Drop CONFIG_DRM_AMD_DC_DCN check when initializing the dml_rcflags for ARM64
- Drop CONFIG_ARM64 and CONFIG_DRM_AMD_DC_DCN check for the per-file cflags list entirely

Change Since V1:
- replace $(dml_rcflags_arm64) with $(dml_rcflags) in dml/Makefile

Ao Zhong (1):
  drm/amd/display: add DCN support for ARM64

 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 20 +++++++++++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.37.4

