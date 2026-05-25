Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1689CD5BD0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D90510E0F3;
	Mon, 25 May 2026 11:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BJRzMRCn";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F7210E0F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:33:25 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so27393835e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779708803; x=1780313603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=plBGWmypbPVHJhcrIrDU6jdzJSlExeJuE3yfMT4FwJA=;
 b=BJRzMRCn1aJ8H9VAZfuOMMclUsgukFrIPY0Q8vkSi86evYL53EvlM3KWE3Act6zoWv
 B6BPNOFJJGJcEvCaUQvGQXYvHKmMlPYuTehv4UxH4DvTslEPxfa59s/PW84J94M1loHv
 l2WGEcWBTpJpFyCJQpcjdo3nNKKdEtcgP5qj9Ap84A930mnfEh8lH0gcO+7Bcm4bK+jd
 o3cpo6o2lEgwmDhKHfBclO7WlsEJacX4iab/+mWI3+GjpaNMaEQrU4eYNaNW2iHr7ks2
 0SFo7ZNDLlRDQLeAgWLSqEkJ6s1d/ChbzzqUdE5PBnH6X7nOeYO8BPAk5ITdf6H6Ucnn
 nCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779708803; x=1780313603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plBGWmypbPVHJhcrIrDU6jdzJSlExeJuE3yfMT4FwJA=;
 b=dZYoZOWt6je2tyCNAIKCq31v7wxQ0mMG+6g1RzBZ0bndTFzs6Xo8krOF+AmSemo3c8
 OjjtkdHbCz2yx0IqGS0LB14qWI7MVBcodquL80roA+zPpdlfTmi2qUTKwy1REfsxil/A
 FmMMreWQhQ7oy0s4C3ehxFP6qO/3aYux3pL4BZp5FYRuHif7ZzwNQ9YYudbJfSlIWfyX
 2f93O/2l8QqGL2rULjtBcw7LTiKpNtDwuIt+0l7cy+otiw8BC1xi344kNJ2S2CNm0ip7
 84QDxcfMpF4lCj0/mk3iAr+bs905UTwvySxKUMEg0f6wLx5bnKu5TH2R/Y1ZqTRCBPks
 27iA==
X-Gm-Message-State: AOJu0YyzQgu835fhnjJTOaF+5Weh4yoMOzMHwfqVSz3e0ZDHRQlhiY1E
 1Ify/QTdNKsmVpRlzUBmPNCcQuP/Se93MI/T9gPP2ohhdVecqr5To+Xw8kk6mw==
X-Gm-Gg: Acq92OEcUMDLxzcxUkpXeSi8sI6W9po6JLYhnZL8cVXYy08Z6ymNcAqBKwW1QGSoIMc
 316ySfB8x7zNx2IJ59l5HcG3t+xp5RSSxzDy/919UHcqxR+5pI3V1OVzvYaTcxkhVG4hXtT+64j
 S8gzdF6uEFElvAkRO7gnALVUE98gHh+hs55J3pQaGjcuAuXSn4sCAcMHJTb9SwRdYDu8XeiE5aY
 DyNqR1b7aX6JXfkpmlJXk/EQWcCtQ3/LJ1tu0HBXL3G1rxtoun0cDRssIcwBjjC+nzaSRzvygD0
 1ErYuaHsJZNX7DNsZs0gmaJkcqZ9RPVCnizLP4h4Tu31D2/9VAPu0eiqFO0lR47mux+d6YFMXxt
 0bfNLkRZqFHbN4onsxhMD0OVBcc8NgcV5FDIM3WIPoxC0jpi4Nxo2cix2tWLuyylQ1j0cLEz3mU
 3zYhXbS+MZ+XjUH03goMNCchxQlCGp+zkgyoxQt52vV/Tsm7yBPVwhrPRl9II9GFT5
X-Received: by 2002:a05:600c:1992:b0:48a:76a3:2b9b with SMTP id
 5b1f17b1804b1-490426c5416mr222654115e9.17.1779708803089; 
 Mon, 25 May 2026 04:33:23 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm241047845e9.0.2026.05.25.04.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:33:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/4] drm/amdgpu/uvd: Fix UVD BO memory placement issues (v2)
Date: Mon, 25 May 2026 13:33:16 +0200
Message-ID: <20260525113321.17953-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
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

UVD 4.x and older have two requirements for CS BOs:
1. All BOs must not cross 256M segments
2. MSG and FB BOs must be located in the same segment as the VCPU BO

The amdgpu_uvd code attempts to solve those requirements,
but unfortunately it has hit various limitations:

* VCPU BO may be placed in a different segment
* GTT manager doesn't respect placement requirements
* GTT allocations may cross 256M
* GTT->GTT moves are not implemented

Let's solve these issues by fixing the GTT manager,
making sure that GTT allocations are placed in 256M segments.
Also fix forcing MSG and FB BOs to the UVD segment
when the UVD segment isn't the first segment, which can be
the case when resizable BAR is enabled.

This series should be backported to 7.0 and 7.1 because
technically this may have been a regression for some users
caused by switching to amdgpu by default.

Changes in v2:

* Fix GTT->GTT moves instead of specifying a placement in
  the amdgpu_ttm_alloc_gart() function.
* Move MSG and FB BOs to the VCPU segments, leave all other
  BOs in segment 0 like before.

Timur Kristóf (4):
  drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions
  drm/amdgpu: Fix amdgpu_bo_move() when old_mem and new_mem are both GTT
  drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x and older
  drm/amdgpu/uvd: Fix forcing MSG, FB BOs into VCPU segment when it
    isn't at 0 (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 30 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 18 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     | 50 ++++++++++++++-------
 3 files changed, 81 insertions(+), 17 deletions(-)

-- 
2.54.0

