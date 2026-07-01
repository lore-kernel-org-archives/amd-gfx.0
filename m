Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09FDC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458A610F032;
	Wed,  1 Jul 2026 16:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G2rGuTar";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D93010F00E
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:32 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so4937015e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922651; x=1783527451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1BmWOa6OMYPgCd691OpWNqoXn3BVHxBf1U7KRzIoMZQ=;
 b=G2rGuTarnJubPxySpr/z8OyqxL7uohYC1kaMg8RfazhT0zxtJyN4hiRyJmJWe/zgOG
 pfGCfCgD78q6AaTvVzk1CdwrsxHQ/vAlJKz+u2XGiiizmPSTViwcr9Ei+SNkeY1eqqP5
 zRiCcflxZdX4NA9dNCeznxFNXjJCgUMPYkmb4eOvyy5ACXrSBsWoqGzTLuxfCV+2tCv3
 HOIUUxL1z3hbKAh962qaCHKQxEESi4WSTbkIuy3oRPNJu3Jfw5DV3kJzoVzFgWeINvQx
 vgJqRzhzkRnDuKr3FTmMD1okld1tBSuG/0KHO08HitSquX4q5XM+s7qQh7+fIGONt4lT
 CU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922651; x=1783527451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BmWOa6OMYPgCd691OpWNqoXn3BVHxBf1U7KRzIoMZQ=;
 b=f0dqqm9a2EAs73aLBy/Z6wA+A7kUclqYILLbyDhwos5qaDSRzw9THaQFo3hgz47mvM
 lPB/1PThEWZ7TlcZTaeYjeXjWAhiYy48Ebgl1i4lZJEeTSUe/ow5cE4f2fJC5Q+ViJ8X
 rIEsBgfsJ/UyNYgg4kFq4r40Wx28oZneVHLMjqmNHSxWgfAxtYmb1q2IEgrky51dihNg
 DazR3swOR1D76LR/L35oyBdwYoC9pjCRQEyYNaR2X1rbNRbAc/dLuTEbri1BZnsk1R09
 Y3I6rwsc/WC+Xk39NCzz2+dnb9d5cwYOqqvPG1MyyqL35n95uud610qtKQJIFvAB8wOO
 XAuw==
X-Gm-Message-State: AOJu0YwuzC8YbqXVMbn3zDhjshiU+yOPsBluLaN9Op0LIsxeQlmEqP1H
 or95YvTloRc6PH28Ag7t/Ij3R/GbkKetNu+R9/KxrdBIm41KpAeC1IdgJCCsdg4j
X-Gm-Gg: AfdE7clUqhODduETHySyf5soZZGkDjvyoJGdLC3VhpeWRBpzoHBfY7expn2KbDWWQca
 gBjVdNCzIPfBNPIm+EN0mdixlSftZXutPuxKtd4fQBzpdASy1d5L9Gmw4TSlAS53H44ur2v/+ij
 OeySiW2sT61jGAF5qOn6DuS3AQ0k2THoboth+gYss5gAqjJXw2HvsK9fQCc/G4vBqqId4hcaY2m
 6M5TIXM/kAN+mLx7fNjaRStBUiawLjrZ9vOdCIjBD0nBASqEnfnbSm+cvOF9XyqAz2N3G6lhlqf
 t77S1TKZu98yJzO6DI325m8Rd2I8H/wRu06M1DRhpzRhM2LMmMwq/8YMGayvFEh+kjqWjRtxclN
 6UgmYWF/I3vQtPLFoaFifjSnDnDp7KlzwvoRTts2+RwdQ6rT9LqMeg6O0gOzRMUYk6udh36sWYa
 3dMXGZxhOzdmulvyRQ
X-Received: by 2002:a05:600c:8b05:b0:492:5145:f054 with SMTP id
 5b1f17b1804b1-493c3cf8c29mr21927085e9.26.1782922650574; 
 Wed, 01 Jul 2026 09:17:30 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:29 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/14] drm/amdgpu: Improve retry fault handling (v3)
Date: Wed,  1 Jul 2026 18:17:07 +0200
Message-ID: <20260701161721.85681-1-timur.kristof@gmail.com>
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

With this series, the kernel is able to mitigate
most page faults on Navi 3 and 4 without causing a
hang and without a need to reset the GPU, when the
amdgpu.noretry=0 module parameter is set.

Fix various issues with retry fault handling.

Enable filter CAM on Navi 3 and 4 which is a
HW block that filters the repeated page fault
interrupts that happen when retry faults are
enabled, making the handling more efficient.

Changes in v2:

* Reordered patches in the series to put bug fixes first
* Enable retry fault interrupt in init_system_aperture_regs()
  instead of in set_fault_enable_default()
* Added a patch to respect the noretry flag on GFX12.1 too

Changes in v3:

* This series now includes fixes for Navi 4 too which
  were previously submitted in a separate series.
* Dropped patch that improved handling of timestamps
  on the page fault interrupts. I'll come up with
  a different solution for that problem later.
* Dropped patches that solve race condition between
  retry fault handling and filter CAM ACK because
  they conflict with Christian's ongoing work.
  I'll revisit that later.
* Reworked the series into smaller patches for
  easier reviews.
* Addressed comments from Tvrtko's review.
  Thank you Tvrtko for taking the time to review!

Timur Kristóf (14):
  drm/amdgpu: Respect noretry flag for retry faults on GFX12.1
  drm/amdgpu/gfxhub: Enable retry fault interrupts when needed
  drm/amdgpu/ih: Don't perturb HW registers when accessing soft IH ring
  drm/amdgpu/ih: Add retry_cam_ack IH function pointer
  drm/amdgpu/ih6.1: Use IH_SW_RING_SIZE for soft IH ring instead of
    PAGE_SIZE
  drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH ring instead of
    PAGE_SIZE
  drm/amdgpu/gmc11: Pass cam_index to retry fault handler
  drm/amdgpu/gmc12: Pass cam_index to retry fault handler
  drm/amdgpu/gmc12: Use AMDGPU_PTE_IS_PTE flag for init_pte_flags on
    GFX12.0
  drm/amdgpu/vm: Use init PTE flags and NOALLOC in
    amdgpu_vm_handle_fault()
  drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH 6.0
  drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell for retry CAM on IH
    7.0
  drm/amdgpu/ih6.0: Enable retry CAM on Navi 3 dGPUs
  drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  7 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c |  9 +++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   |  9 +++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    |  9 +++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    |  9 +++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    |  9 +++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    |  9 +++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  |  9 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  5 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c      |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c        | 25 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c        |  9 ++++++-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c        | 30 +++++++++------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c      |  4 +++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c      |  8 +++++-
 20 files changed, 133 insertions(+), 43 deletions(-)

-- 
2.54.0

