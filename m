Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFCAC79F99
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171F910E158;
	Tue,  8 Sep 2026 18:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iMGSrbcG";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0676D10E158
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:04 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so927695e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891062; x=1789495862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9MlTXSylTDqX/cQ8XFp/Tq3HcEJ7Mm+2gMc9Ncz9sjo=;
 b=iMGSrbcGGx5fRpOJe3d/XhsTa/81L+0pLy9aaz/nMjCDYrr2aZQepjAzZqTPzb+h8f
 v6G4jys6wQ/tjalB4SK7M8QoHp0Cw86upPl/aRYLaT1WWw2m8zU1KWPdekuxtsv6TH+w
 5zFom83YcmAB8oBhqiYkLPFcLR1M6chXCNDLWIdO9tb/MWgIMX7ZsYFiNAGifKUu6KiA
 qBh3xqrZhL1Eqdw04Wqotd/OI9HRd9maQVBo5QikdXdNxHCbALcXxXWZew3/sMxG9dcD
 +toYRubYUxxCLCraKKYYwdZ14veJZMf+0LzcVAR7Q6T2t3FacFVBMDPHPClqtPUjrtPO
 LRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891062; x=1789495862;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9MlTXSylTDqX/cQ8XFp/Tq3HcEJ7Mm+2gMc9Ncz9sjo=;
 b=Tjm8oVBCdEGMbQH68GgJzGFY7C5Js2x2BXGvppGQmdqTwVR7oPHfL4e+CaT4nh7NH4
 Ae4ZAGdM1DpKE8SCPlgs7K9c5NYG9ypv591M4XrCVi0krjJKy30yoIBCDxwfadhehaaR
 7GkMTSBzZpAMMGFPfxlsk5zk238dqSNxFLvJQMEExte0N8y8t5/zxyjY6UrATxD5YwS+
 JrQj59O1KScOuZ0sebx5jl9dLpwSF2HU8AtIp173u5LMDJMXwry09RoMtDiYInoWV6zx
 CXdG3bT7u+7ot9KwSCE5DXYPFxKGVuz0FMosU0IElrJ3JP9P3tSrsX09XNNML1LnkAkL
 nn8A==
X-Gm-Message-State: AFuF++k4lPTxuSbZMn/wDQkXNwRXDksChE3iS+1THzvAz4hRMHWS/wtH
 AdGADJaWB1Ps0pd3RaUEb4fTisdpXjNmuiyqxjJpwsBReag0U3u6lOhcZRcrHVZ5
X-Gm-Gg: AYBFou36yGyDHNyUypRTK1+Pa/lpQfdCQb5sfyphIy6YhBScWiEHy3culWKZwS2ZSoK
 aWGRvUOtXpNekzgP+5wDtGVFRb8p37N8DrXjUF2SFqH7wjNW350h+Zq8Wp6bIUn12ibE5K1p4M3
 90NeHRuhMNbAzoObjFrdJSr6NHW79lnEBs7Z+WK3wp6M/SC6g6hC1oIysLO3ovFl9GKTt6ryc8l
 ITA0WixDS4pRiqUpZmprzGgyzi7JMJwpPQ4CauGbolo28BVkVwlYitRzKWJm1pnjzzFaCy56Yyb
 BPJ0qUeC3zYh+Dv5COHx/IBJNw5hVHSPRGb9kkFr4B7XbqiY/s8vjBsExA/erPSR0wjddnR96kj
 1mJdVye8ZHtjScWF0ZtHlvk+R0d8RVpQcYxmKqMn/5GOf4oSgCbYloe/R7csaQS/YkjDlRAQht6
 ItLU2JgIPcNlyUVz6POZZG9VY2Gmr1vKN/1KGVJJ014bNTaQanjRVRxuZH+y06Ti2gAHMe8rPIP
 mJLNxMkirAFFjolK/pt
X-Received: by 2002:a05:600c:3f05:b0:49c:e1f1:3dd5 with SMTP id
 5b1f17b1804b1-49d1f223e83mr21444575e9.4.1788891061777; 
 Tue, 08 Sep 2026 11:11:01 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:01 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/9] drm/amdgpu/sdma: Improve existing SDMA queue resets (v4)
Date: Tue,  8 Sep 2026 20:10:43 +0200
Message-ID: <20260908181052.381126-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Improve SDMA queue reset for SDMA v4.4.2, v5.0, v5.2
and also moves some functionality from backend-specific
code to common code in the amdgpu_sdma.c file.

This prepares for implementing SDMA recovery
on more generations, as the same logic can be shared
with all SDMA HW generations that don't use the MES.
The actual recovery implementation for various
older SDMA versions will come in subsequent patch series
after this one is accepted.

Changes in v2:

* Added a fix for an issue in SDMA v4.4.2
* Further simplified some code

Changes in v3:

* Fixed typo (wrong scheduler for page ring)

Changes in v4:

* Added helper function to clear ring contents and pointers

Timur Kristóf (9):
  drm/amdgpu/sdma: Remove unimplemented soft_reset() for SDMA and SI DMA
  drm/amdgpu/sdma: Remove superfluous rlc_resume and rlc_stop functions
  drm/amdgpu/sdma: Fix executing duplicate commands after recovery on
    SDMA v4.4.2
  drm/amdgpu/sdma: Remove unnecessary guilty tracking of SDMA queues
  drm/amdgpu: Add amdgpu_ring_clear_ring_and_ptrs()
  drm/amdgpu/sdma: Clear SDMA rings after reset before starting them
  drm/amdgpu/sdma: Move SDMA v5.x queue reset to common code
  drm/amdgpu/sdma: Always handle kernel queues in
    amdgpu_sdma_reset_engine()
  drm/amdgpu/sdma: Use common SDMA legacy queue reset on SDMA v4.4.2

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |  21 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 102 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  11 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |  32 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |  30 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  38 +----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  40 +----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 158 ++----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  60 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  52 +-----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  27 ---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  27 ---
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   7 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   2 +-
 15 files changed, 121 insertions(+), 488 deletions(-)

-- 
2.55.0

