Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6F110FCACE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A19310EEE7;
	Wed,  1 Apr 2026 18:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ze0yHTiA";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0F410E20C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:29 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2c56aa62931so3207464eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003969; x=1775608769; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ojh5tnUEiYmVdPjcqv3/1ea9VGb3tz1tyyEb2cwTcr4=;
 b=Ze0yHTiAb0pHTWMutm6hgyImF2Vpduv7Xt5bivkg0m9tKokaGooFqpO1QK6FRoRLXL
 Z4VU7Hi7UI/re6mS2dLVrtUBT33bE6WHHOpo830JOksLkioiFwH9iCRfWcMklq3kuEQt
 AvrNlDQ8D1MaGncimywEzXq2sFEKM5zlA6aOfl2KOUM21tnKWmx2WhbogpQabCow9SAe
 gg4cCocldmTK6uoebFSZuLQ/ZuacJoRX00TbOuaxsBFy4A24iCtcmKmKc/5m6x+RICDV
 PD8BJe2dXLBf4f+8nCE/3AZHoyXmyjPJkSdRDSIEd6WKNKBbc9qSz8Km0qX7xKKEBE2x
 3xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003969; x=1775608769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ojh5tnUEiYmVdPjcqv3/1ea9VGb3tz1tyyEb2cwTcr4=;
 b=Ov0E/v6P2NKPVAdECs7kCPQQBhkdl6C+sBp+xWASfMSR1DkAyMT/5YowSifPInW7A2
 ud5OMOdHBVcj9nnssZ1Y/eI4q3pGtuRtXJ/GIETC27+jkBCP64l83iYpERMp2q+qBCgR
 KOM8LXjS4aasp8lipTma7JN6In6guREpLTOaNmof7jNZS/J7yEhojtPPd+7XC8yK5MAj
 XCMdMYagmgv+OIe/zBT3uzkQB36QJrOs1ljD+Ec+QasYj1h9n/FyD4Mb7cptKiItDzpS
 3PYjt24v9byJRFUrXEGJJt6jIXsmeMq9S/9y0458RqnGP4fLCjvw1RNmgGvtE4NsqqjI
 YJUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzlxEZvLXV/PGHk+0tzkS4nQMVKOyLjIETODU0OSGl6BqCHkadds8nTXhGY3bFHOcw63Fs45Xa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwL9Ij6g5CP9nnk39Krn9Riffn9Woony4rEBi/WbDIhI8+WF+YV
 jeF4VwBzL86bGmxHf/oaamMjkXTEAjfhL0gayKpuLTVBrLIMhvD2X/uO
X-Gm-Gg: ATEYQzxLyG4oejPdZ0fdbyeVTIt30d1xz94jPmnCByiJPWN/4Sa8d3cQHjOzqA6Oiv3
 /tsmmzW5oe5bZY2y0W9IAOhCPTU/vh4Z/4oRP+EVZUB5Nz/9hKAoTHd/sJmFZ0p+XqghbBlcYC+
 MDAxY3k/1TsieAcIOscBXEOtjS6iVL+j1GNe+E4S2+h7Pe1Qalo2XY4AToZFyfgAnZBs2jo69vr
 xMr3ZOa+ftUYJEdhMPYz20rXoV+MhI5iT50JQLhI3Q+6f7vMLlSCknNHIVDHAdLJu4oqJRTAgUr
 b5tPAcziTU1Vd+dDHS7DbGU7sPpcpvNzgfRQp9Qr14iMUOriAIrgRfAudxHG15jFtl7KrLK6Yrg
 i5IQC7nB4NhBE9FV57+LSW/+lmizwtBDHF+7XHFISsAflgbktPkJsKs7B8QVNniQ/ifjsYuGV7C
 Oi9Tkxr+yhxIOE4MD9qkLbSjThUJroxRz8B0oJIZdftaw2IqGZf9FQV64=
X-Received: by 2002:a05:7300:4309:b0:2c5:b23e:48a5 with SMTP id
 5a478bee46e88-2c9309866f8mr836144eec.1.1775003967392; 
 Tue, 31 Mar 2026 17:39:27 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 00/10] drm: amdgpu: backport suspend fixes for CI
Date: Tue, 31 Mar 2026 17:38:58 -0700
Message-ID: <20260401003908.3438-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

Work that completed in kernel 6.18 resulted in working suspend with DC
on old hardware. This series aims to backport it to 6.12 to have working
suspend there as well.

All commits were applied with git cherry-pick, the only changes being
adding upstream commit, and signing off.

Tested on AMD HD7750 with:
radeon.si_support=0 amdgpu.si_support=1 amdgpu.dc=1
on Arch Linux.

v2: add extra upstream fix.

Charlene Liu (1):
  drm/amd/display: Correct logic check error for fastboot

Kenneth Feng (2):
  drm/amd/amdgpu: decouple ASPM with pcie dpm
  drm/amd/amdgpu: disable ASPM in some situations

Timur Kristóf (7):
  drm/amd/display: Disable fastboot on DCE 6 too
  drm/amd/display: Reject modes with too high pixel clock on DCE6-10
  drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4
  drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
  drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
  drm/amd/display: Disable scaling on DCE6 for now
  drm/amd: Disable ASPM on SI

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 39 +++++++++++-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 20 ++++---
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  |  5 ++
 .../drm/amd/display/dc/dce60/dce60_resource.c | 59 +++++++++++++------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 +-
 .../dc/resource/dce100/dce100_resource.c      | 10 +++-
 .../dc/resource/dce80/dce80_resource.c        | 10 +++-
 7 files changed, 117 insertions(+), 32 deletions(-)

--
2.53.0

