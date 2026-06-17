Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C3BCD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C1110F0CA;
	Wed, 17 Jun 2026 19:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bEJluO6l";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF5610F0C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:34 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so569905e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723673; x=1782328473; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4l+SrwpdOtDEyq2VQi6XZMItQ3lVpMzkuVdwCu3ZbPU=;
 b=bEJluO6lSqgVvBSaGO8F22bJibFDAz9DSbcfTCx/w3z/YzqNR28o7nvwJrniIfDQCa
 RUsCCtdLykQ4HjYDH3ZCnLZfOcVaoGQfVTuM9pjvE0uRhirotj8GJIEbE6A6lmmdCYSb
 wae1h6IcianYtom83Y6BLzbnlQa+jn3NQTJlD0h1yE5KZ4ELMTVjWsWlSSCEfSU6bE/H
 I1K0IVE6iQJrCuXF+nhqqtqXidHFtr1d6y7ZcH89F9RkJWJ9MlwpJ0CQGZbChbFIuI/o
 rAgQeFbCSOzzqnJvrQ9BS/BNQPYbQZTgmr/juDYuHZpt3SwozQOOdMLsQYQp3PsHbyf5
 XQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723673; x=1782328473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4l+SrwpdOtDEyq2VQi6XZMItQ3lVpMzkuVdwCu3ZbPU=;
 b=KkJfUEXTmFsuNcJZQVc0upAHiqLQOdeJOWk+rHZ4NlZoU1dMDhKi/gkiylnKMfBfAM
 8cjxVvJW1+TUxpa6Oafwk1Fqvc2Hj+JlikmrZ17AhF1k4hRhLoYFamo5ty3jbaSUvMqD
 5fUbvdn0OdTzQ2TxFDf94TzSllVUFujxI5D/i1/MiTTJXchLlyso+sgsDNtKwnmkfYCh
 ONWK/sJuxYLHH7Xtbg/SKpJB8C++9NSdeyNJuihStOVzD/SgIefQwZLGO/qIOlGH19B0
 ovn7kK1g/mwyk12lqTuKtIDa+XfzMrdF5IXs4/OYAId1VpyJr6VTC9F6Vc4U+d84zd22
 DH0Q==
X-Gm-Message-State: AOJu0YxzLWY/TC4kmOM16GfPP550W+cN5VW38yY/WGwUi1YLTh9ztgGU
 spge9rhkgHl2rxRiHBOJNbq9ljsQ7kk7Y3vNREE4Lh/lEnWtCfJFJikuCgTGQg==
X-Gm-Gg: Acq92OFn41my/WNkWGAYe5qwbWqtEl25mnnrREVsVs5wJ+1XUTLSLHcH54qiEJbXoNC
 rcGF+5zN1wzicWmH/Dp9FSfThd2H7N1YbAerey75sFwTHqy+xK9J5WjXMLH1HMGpbcbcXORhSyM
 1k4iGEmcBI/zEhKN3VJEXKErOEZP78wc5NoZwRjaQUwEnBB0FkrEy5gAylKM/AJaCZp0o3aptwG
 ZC2pRLd0a+O6SUwOJjyCZDVlBsDKgT4Zr1qsEClpf29uM3g4eb15ErtiShfNYNHn8HYr7QEGloG
 EKO2ZmfyfgiJ9oyF/0BfilL7MzfwGIOAUgsjoLBnGmFvUoEjT0Ro6YZyPrlTMcy/px22kErLVnd
 J4fmWWVqctk3SIF5nZQE4SDwMh8xH+8GaR25/NF9+4q+llmUgBr3FhbI8EEd44UCxHDqK5txt7p
 S290TOA0RwTq798D3NbzGfwBp/mx1pmkbjmXd8F8uKxjcvQUWS1FXLzw==
X-Received: by 2002:a7b:c34a:0:b0:490:e60b:5fb5 with SMTP id
 5b1f17b1804b1-492341421femr50406615e9.34.1781723672924; 
 Wed, 17 Jun 2026 12:14:32 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:31 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 00/17] drm/amdgpu: Rework IP block soft reset on GFX8
Date: Wed, 17 Jun 2026 21:14:11 +0200
Message-ID: <20260617191428.1784083-1-timur.kristof@gmail.com>
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

IP block soft reset is a way to reset just one IP block
in a GPU without resetting the whole GPU or losing the
contents of VRAM. Currently this is implemented for various
IP blocks, but actually only used on Carrizo and Stoney
as part of the ASIC reset code, and it fails.

Let's rework that.

Delete the defunct code from the ASIC reset code path.
Also delete check_soft_reset() and pre/post_soft_reset()
which were quite useless and redundant (see the commit
messages for details).

Add IP block soft reset as a GPU recovery method instead.
This works similarly to ring reset, but will affect all
rings that belong to the IP block. For example, a GFX
IP block soft reset will affect all graphics and compute
rings. It is called when a job is timed out. Attempt
to minimize the effect on non-guilty jobs, then back
up the contents of all affected rings, perform the HW
specific soft reset, then restore the rings.
For this, I am also including some patches from Alex
which were written for pipe reset and solve some
problems also for IP block soft reset.

Finally, let's fix up the soft reset implementation
on GFX8 to make sure it works on every GFX8 chip.
Specifically, fix an issue with compute rings hanging
after the reset, and fix an issue with increased power
consumption after the reset, among others.
With those issues gone, enable the new GPU recovery
method on GFX8.

Tested with the "hard_reset_cp_wait" test case from the
Hang Test Suite created by Natalie Vock and Konstantin Seurer.
This Vulkan testcase waits for an event that never occurs,
effectively a WAIT_REG_MEM packet that intentionally hangs.
IP block soft reset can resolve that hang and allow
the rest of the system to move on and keep functioning
without needing a full ASIC reset.

Tested on the following chips:

Polaris 10 (Radeon RX 570)
Polaris 11 (Radeon RX 560)
Polaris 12 (Radeon RX 550)
Fiji (Radeon R9 Nano)
Tonga (Radeon R9 380X)
Carrizo (A8-9600)

Alex Deucher (4):
  drm/amdgpu: don't reemit if there is nothing to reemit
  drm/amdgpu: track guilty fence for queue reset
  drm/amdgpu/fence: add helper to extract the guilty fence (v2)
  drm/amdgpu: amdgpu_ring_set_fence_errors_and_reemit() handle NULL
    fence

Timur Kristóf (13):
  drm/amdgpu: Clarify name of soft recovery to avoid confusion
  drm/amdgpu: Clean up defunct soft reset from ASIC reset code path
  drm/amdgpu: Delete GMC 8 soft reset
  drm/amdgpu: Delete soft reset code from legacy display driver
  drm/amdgpu: Delete check_soft_reset() from amd_ip_funcs
  drm/amdgpu: Delete pre/post_soft_reset() from amd_ip_funcs
  drm/amdgpu: Add IP block soft reset as a GPU recovery method
  drm/amdgpu/gfx8: Stop CP and RLC during reset
  drm/amdgpu/gfx8: Return error when testing all rings
  drm/amdgpu/gfx8: Support COND_EXEC on compute rings
  drm/amdgpu/gfx8: Adjust EDC GPR workaround
  drm/amdgpu/gfx8: Fixup IP block soft reset
  drm/amdgpu/gfx8: Enable IP block soft reset as a GPU recovery method

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 179 +-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  54 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c        | 154 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      | 171 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   8 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |   7 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  66 ------
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  57 -----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  57 -----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  36 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 224 +++++-------------
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 125 ----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      |   3 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c      |   3 -
 drivers/gpu/drm/amd/amdgpu/nv.c               |   6 -
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |  62 -----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  18 --
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  18 --
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c        |  18 --
 drivers/gpu/drm/amd/amdgpu/si.c               |   7 -
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   9 -
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  12 -
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  11 -
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  10 -
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |  40 ----
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  45 ----
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |  69 ------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |   3 -
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c       |   3 -
 drivers/gpu/drm/amd/amdgpu/vi.c               |  22 --
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 -
 drivers/gpu/drm/amd/include/amd_shared.h      |   3 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 -
 39 files changed, 487 insertions(+), 1058 deletions(-)

-- 
2.54.0

