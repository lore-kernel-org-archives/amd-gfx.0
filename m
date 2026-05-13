Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ECDCD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 16:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730B810E0F7;
	Wed, 13 May 2026 16:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="McMDOJf4";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833CD10E0F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 16:30:47 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso63300535e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778689846; x=1779294646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nVVc95Zli0SfeK9rqoLSUKXG4ZlADRrFj9cVHn4LtKw=;
 b=McMDOJf4UgVfPvfSSUV2wvrC37wwPTc0eWGfWCpitAwLZ64TOIOQVlLM6jWcqN9EDA
 LZ388h0wXSYIv/3Mb/5hnmRk6rSCkzaFk6MDp+RIOmyZ4deRP8NjDcLhy9WtBOAy0Dgr
 CHpbHENzcT+hwvwK5hOHL87L1hhjGhr3tsDOAL1xmAMbF6pOYmVe5ZTRjsIIyA36gKF0
 Zcjcie51WqxJyczmaO/YWnHMsh+vFiCUh7YOfcobcSf1H+AkXdRW4tRB5Siy26J4O2tr
 Y8qfMK2gdG9+sTRQbIGQNiteT8CPLSf8CibuS8rbG+TTRj+kXzJu7QxQJcXVoQfHdh8U
 YmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689846; x=1779294646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVVc95Zli0SfeK9rqoLSUKXG4ZlADRrFj9cVHn4LtKw=;
 b=d8DJ1+LmI9QU3G3SJyEgC79ZAj2p+vVY/+yC8Fr/ooJ/ALD3q3hGBvUmspYQnqpfGF
 tZ83Zgq4S2nqN3iwIqOpkC5CBsZ7rK63mhkP3hVlz+kA/RwSDojTYdcMytO6Sv/dyOWG
 j5RvuL9Zq9uiL8odw5GZ3BWAqaPIyr/n9vMHsylvBqX02OI1hc4Rom24aBU2Pd9N66SL
 2djQ7xTMqHMSh2tqbqlh0AayW5Vj5TPG+M/br7BfZ1PEWFUYmeHH91B8ATIhwQadgS6F
 btRxrpuOZ4bQ4xdBObWydhgSnVQ8i8CXZyOUHQlSWjPFYY/bPMpzyrIJj1OyVyl/nwdu
 EBdA==
X-Gm-Message-State: AOJu0Yxyjz87EN8EYct7+8v7MyjX2+vHcZl9917VvyYm9ciuVO5//r0S
 McIvcENNPfOgswtm4dWyWzPXfvSpor3g7SHajE35uG0pfVCtCe8qPygJdUSMTw==
X-Gm-Gg: Acq92OGrW/vx/Fkrwg80YBb9yFcT2DuLRmh3rRDf3mnxF/9Rd0HP/0cJ4fx5GKySH+1
 31fGqcRYq8LTS6/ccsV6HU57zXm/MnGCIFcItBMLF+FdFUMyEdk2DJvRge8F9WplAdgC4YqKxdA
 ozA1qysW8FVgcEyyRrrfiVtXJezxzu5m9TIQQT9stT5QurdV9qs51hHUTcMC9NgoFkqVr6H3I6R
 NSzLKB470molsKPBvScNDp3iSUdywGYGnfc37BibQhHNEXwkcmUhCMkXaoPlhxBNJH/njPOBLFt
 +t8glK2lt9ZFZVairn2wLdUDU2YYa+W09YKWFSRJ7T7B+A+5Q5lVt3TpxuQYQhrTM0wBHD+YuPR
 oWHCADYcSTzBmJb6BnVD9NbQ4oh+fYVO7Q0dgUuEPBXMHE21LTvBSAuDHz/XJNBHj2Nm2HJuWVa
 x04KAPz2qULTlQ78wzzh06vPx4qL4ki4ITPcYJuf9naVGhRiHAVatLPLk/zXzbfcrogaTU
X-Received: by 2002:a05:600c:5d2:b0:48f:d612:3c6e with SMTP id
 5b1f17b1804b1-48fd6123eadmr5674925e9.2.1778689845791; 
 Wed, 13 May 2026 09:30:45 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64b5271sm1846385e9.14.2026.05.13.09.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:30:45 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/6] drm/amdgpu: Improve retry fault handling
Date: Wed, 13 May 2026 18:30:37 +0200
Message-ID: <20260513163043.8725-1-timur.kristof@gmail.com>
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

Fix some issues regarding retry fault handling,
such as enabling the retry fault interrupt (necessary
for retry faults to work) and such.

Improve retry faults on Navi 3 dGPUs by enabling
the filter CAM, which can filter the repeated page
fault interrupts that happen when retry faults are
enabled, making the handling more efficient.

With this series, the kernel is able to mitigate
most page faults on Navi 3 without causing a hang
and without a need to reset the GPU, when the
amdgpu.noretry=0 module parameter is set.

Timur Kristóf (6):
  drm/amdgpu: Use gmc->noretry instead of amdgpu_noretry directly
  drm/amdgpu/gfxhub: Enable retry fault interrupts when needed
  drm/amdgpu/gfxhub: Program CRASH_ON_*_FAULT bits to 0 as needed
  drm/amdgpu/gmc: Don't compare page fault timestamps with other
    interrupts
  drm/amdgpu/ih: Add retry_cam_ack IH function pointer
  drm/amdgpu: Enable retry CAM on Navi 3 dGPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 17 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 17 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   | 19 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 15 +++++++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 15 +++++++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 15 +++++++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 15 +++++++++------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 17 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 17 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c        | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c        |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c      |  8 +++++++-
 22 files changed, 134 insertions(+), 71 deletions(-)

-- 
2.54.0

