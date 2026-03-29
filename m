Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14468F3D60A
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB9610E0CF;
	Sun, 29 Mar 2026 16:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UDsVa5FW";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BC910E0CF
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 16:03:11 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso48316775e9.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774800189; x=1775404989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xUgJd9OOqV3kcgGZAQ87UdDecn/5pfBPuvfbIlhey4Y=;
 b=UDsVa5FWKD4c4mvg97yzdhccOmlue1p+PKQDXdYQuHwt9MPzIR414zJK6ao/elJ6uO
 wmWfp5flEy308VYl+W10ZLPwJKrNMRxHIl9v96Cf4dd5k15A+uSZ3Gqd8mWMNuN0Ug/s
 Eho1rPNnjX/hPg2HBd8MaXP0Eivcff5He63AVLs9gHC7kYjAsbyai23/oUxbquVkLocJ
 2gpO25EM1W0oOzWbPJLbvxqsga2w07SmsKeo8ZgSYO7Pu+hGjj0lHL3/IWxyI4Z8TmyN
 Hb2G/RJ/BkhqcCfNhcIzdr3LWnp/v+0MSLQUxaHxnllF3g9DN93qRdqoz/D3zqnzmaWD
 3oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774800189; x=1775404989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUgJd9OOqV3kcgGZAQ87UdDecn/5pfBPuvfbIlhey4Y=;
 b=Xodf6XitZXxp8x/J6d9+W0bUP+oo7e3oBeNyczsQf6aa1rQjhSrpMLBsVmsW/3x4nN
 WFSMhKadt95xZntYlcC2Q7AAtmqcoUd/eH9MQ4RAU9JysMQmcyU65Nt5x6Dt2wWys50t
 i61MnlHRJ9HcTOBlp49fKM+0pyd7G80c5cDPyBIZh4Wgy1GgNKgPamZl+z3U+yGn78sC
 S9aBHrlbkfSu0jzTY6ICtIwDRurPNLjPljGlrG0qElMlF8HhRcr1a7VMB4COPcbOHzb5
 LxJee9va6al6rAjpT2ZBj/D9s4wIuqvcGFLK53hgMj/0+OKRgSNq5eF7yGuJQYPRSFut
 ZMzg==
X-Gm-Message-State: AOJu0Yx+dINzql15QON4Sd6nJGqu7JNpPxAlv1QBbJfmYAXI2tSDVehu
 d/lIVYaLkp6DbrnAlzZnpNpEZ+1vmHZFOMExKwszoFSBS+Fzo/Ph0zyi4di3Hg==
X-Gm-Gg: ATEYQzxwvvT3XSfc5GqD05fvorrs6AWWHFIZtD+wrYYY4ecfDRIzOqTsvkJeYsgOqk8
 6/0sZpPrUDwu320V7JbZQMbRQzj9gXqgC/38donsSPkpS5uY2AyWFaY8VkYy03c6At0eBn8s0hy
 nbL1s1XvyTfEhqAV3rRR9qm/4aPy8DsWuNDVu7Ho5ZJAGi8lWNaynzcnuSJBUxdKjA5yEjKR/8b
 W46uw7wkfjqL0E10Y8k9TqJA6b1m3Xvq0/eR619Vfe8zTUaVm+fG/EVKv3WNPCO80NBzZAcVBFg
 Se9DNwrCfRD/WzCmEMtJkyvbaUtqTL5ppC21DIr7O0WQr0TtMCRgeEd3/GuxaBU7NLDHXyU0Mxb
 L3Q5gvS/9l6x59ITtlCwOMtwI9Ts+jmTkWEZfGHZzaQcZGDGwvePTvNPjGRLLuDkiMcvYyN8RXw
 BG+fBkAsvhZ6c+xaiWL7xOV40xSa4bIkZ/1OlE3gexT7NvoXB69HsqcJ8GKeI386GeBPs=
X-Received: by 2002:a05:600c:6819:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-48727f238d9mr168430935e9.26.1774800189302; 
 Sun, 29 Mar 2026 09:03:09 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm217428915e9.12.2026.03.29.09.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 09:03:08 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/9] Various SMU7 power management fixes
Date: Sun, 29 Mar 2026 18:02:57 +0200
Message-ID: <20260329160306.3417458-1-timur.kristof@gmail.com>
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

This series fixes various issues that I found on two GPUs:

R9 390X (Hawaii, Asus ROG branded):
Add SCLK cap to fix stability issues, fix PCI ID typo.
And a few minor fixes affecting CI GPUs.

R9 M380 (Bonaire, found in an iMac from 2015):
Disable MCLK switching, use highest MCLK.

Additionally, fix possible black screen on boot caused by
a non-functional implementation of the voltage dependency on
the display clock. The fix affects all GPUs with SMU7,
hopefully improving stability for CI, VI and Polaris GPUs.

Looking forward to reviews and feedback!

Timur Kristóf (9):
  drm/amd/pm/ci: Use highest MCLK on CI when MCLK DPM is disabled
  drm/amd/pm/ci: Disable MCLK DPM on problematic CI ASICs
  drm/amd/pm/smu7: Fix SMU7 voltage dependency on display clock
  drm/amd/pm/smu7: Remove non-functional SMU7 voltage dependency on DAL
  drm/amd/pm/ci: Fix powertune defaults for Hawaii 0x67B0
  drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
  drm/amd/pm/ci: Fill DW8 fields from SMC
  drm/amd/pm/smu7: Add SCLK cap for quirky Hawaii board
  drm/amdgpu/uvd4.2: Don't initialize UVD 4.2 when DPM is disabled

 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   5 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c    |  15 +++
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 123 ++++++++++++++++--
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h   |   1 +
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   |  84 ------------
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.h   |   2 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   2 +-
 .../drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |  15 ++-
 8 files changed, 142 insertions(+), 105 deletions(-)

-- 
2.53.0

