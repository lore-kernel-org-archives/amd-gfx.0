Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701AACA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1089810EA14;
	Thu, 28 Aug 2025 15:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="db2Wa34Q";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D8610EA12
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:16 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45a1b0c52f3so6338355e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393875; x=1756998675; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MjgMS/XiyrWQ7rbkE+cfxbMoxwnJ3edzM/3kJDqjGP0=;
 b=db2Wa34QplJDEDIxrZZYrlPjZVmeXYw9RU12qMLZGMzOXkVn9WXOuimbbcYvmEr4hQ
 JLu5G+UCw3kQczamxv3OlA9zxShZnl6PFHHteUKaglbtlVynWMWIPflVgEAkreggNHaf
 vBaTh022hbQGcJHVXy06R2G7Id/Ixd6XB18p/q/je9AOk/fUopJJkm+Ts2jtsaiwonEU
 CSS4FAvGNS711+wD9Bj2Pjq9/WpcK9LBweQ8SzsQYEXUr4g9DpxN9tS7QK/sUB7MLiQ+
 d/qLZ9qRr7sgJkiqEA7Ok42UQROm5/P85FJ2i0dYUx0UOoidAQTdAC2p/VaOcP8VzX7Z
 HRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393875; x=1756998675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MjgMS/XiyrWQ7rbkE+cfxbMoxwnJ3edzM/3kJDqjGP0=;
 b=e/yP0wyxuZp319I2McN+TyyWAcg7dEJzsSWBCp4wOFDD1ldEYptQvcKMi19OmgsIHm
 QsP6KweAJwVl/iJWWrysaIZhwlbFW7jbnZ2P9DYD1D/MqI9qn/QmkACYbIfofqh71wmC
 xahYlVpjoPqXV8EyM1+p7q80Tco6jQ3gSTxBAFDbM2BSVjCL3y/STivAO86wJfIsT8n7
 6I0nB1nVeCkEW8lyrH9XjGn0Xyn24I+VbfrMu9YDiBPoOS3yiODSUZb0Pp+YwtoFwFv4
 xyWPsAsLHFxc50Qa5Yp4+7rXdpr+xjR/LwMujmaU15kkmkc9sI4iIXtRYxAcSEH9wgs5
 esgg==
X-Gm-Message-State: AOJu0YxoF7LieioeYjXZHgg6jak2Fd13TSbw9RzBzYZZ3cnj8UJtlh4L
 DUKskDzItQQSLhEdWUzZRN9YskY6odpqYZTPe/Yn9lIYBEh5BaS+Pcak1j+ZIQ==
X-Gm-Gg: ASbGnctHnf3CmiVhxg+Yl/5xJTCRvaZfgr8/L4cGfoCFu0u0KmWetDJKbo5LikoRtZb
 WYDBLlHRU5hXz/bQgDIJ7OFv7jZ42oEBhjyNMna7BPlogHX4gsEgFs9kn0sQjFaezU6qu51LvRb
 lFzRIpPS6JV2dQV1UpwzY9chu+vlaKp+/Usu4aQAtXpll6HWll0bdjA0oohA4HmByeag3x78mcr
 DlE4108cXXKzgFDLVrAotyK82yA5dzt+lefSST8/f6alDrmHtIMZGt2PtIxt2VPcLzLGUOXK711
 biYKRGAaXRHtw2nHROA5jeHXXuhuFN4rcdzaKGhLKFxT0Zgs4LpacNR1ctFw2EmBnMU7/+44TeL
 0BLWk9XwNZAe/0XwnPMfLw9h0nsnf09Vsseq0/jAH32HDrdhsxaLcLY6aNsxVHevzqLRVoHnli7
 YhVbEICRTde9hv2jp3LKP4O3bs9A==
X-Google-Smtp-Source: AGHT+IENS6A+CsjhpNzv1xl63FiNfcAk3+cIAklpoj+AdVR7NmtcDNAXmVv9u1+ByvZab/ah6KpjTw==
X-Received: by 2002:a05:600c:4fd4:b0:459:dde3:1a27 with SMTP id
 5b1f17b1804b1-45b517d4160mr207246365e9.26.1756393874886; 
 Thu, 28 Aug 2025 08:11:14 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:14 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/10] SI power management fixes (v3)
Date: Thu, 28 Aug 2025 17:11:02 +0200
Message-ID: <20250828151112.15965-1-timur.kristof@gmail.com>
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

This series fixes some power management issues on SI,
addressing the feedback I got for the previous versions.

Additionally, the following improvements were made:

There is now a patch that increases the SMC timeout.
This gets rid of some errors that happened when
switching between power states. Apparently the SMC can
sometimes take a long time.

Also removed one of the ad-hoc fixes from si_dpm because
it didn't actually address anything, and edited that
patch to focus on just solving the flickering on Oland.

And edited the si_upload_smc_data patch yet again to
program the soft registers to zero when there are no
displays connected.

Timur Kristóf (10):
  drm/amdgpu: Power up UVD 3 for FW validation (v2)
  drm/amd/pm: Disable ULV even if unsupported (v3)
  drm/amd/pm: Increase SMC timeout on SI and warn (v3)
  drm/amd/pm: Fix si_upload_smc_data (v3)
  drm/amd/pm: Adjust si_upload_smc_data register programming (v3)
  drm/amd/pm: Treat zero vblank time as too short in si_dpm (v3)
  drm/amd/pm: Disable MCLK switching with non-DC at 120 Hz+ (v2)
  drm/amd/pm: Disable SCLK switching on Oland with high pixel clocks
    (v3)
  drm/amd/pm: Remove wm_low and wm_high fields from amdgpu_crtc (v2)
  drm/amd/pm: Print VCE clocks too in si_dpm (v3)

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h     |  2 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c        |  1 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c        | 29 +++++-
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c |  7 ++
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c   | 93 ++++++++++++++------
 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c   | 26 +++++-
 9 files changed, 125 insertions(+), 42 deletions(-)

-- 
2.51.0

