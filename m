Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698D8D5B16E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0211F10E055;
	Mon, 15 Dec 2025 01:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G40qX/7g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2434210E055
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1600860127
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E059C4CEF1;
 Mon, 15 Dec 2025 01:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761152;
 bh=L67TI/gHQwzoeHPbKr5F1Fc42LuVIzJVkl0uJ1blDOQ=;
 h=From:To:Cc:Subject:Date:From;
 b=G40qX/7gT2cL2pbP3yOw08oQCK6McEs1UijgWbPozemsc0ivS1K+34x9Pdgkimosg
 TWkOZuPMI9NWsVK9R483wePD8ZkBhDQWtXow+83fXGcEGaG8GwDGoip0xbsKdMNbJr
 scHSGfdiCJMQqnjEDVuuQlDh0KpIaP+KufhcXgToBD2i13Qi5F3/gpUPWVxYMbSW8Q
 hgoYGah4LsXyARaBz7EZpHEom7HAqFBpeqqTuN4SxJ/Ihuy3HO3rW9C0ULD+uBZapg
 Ak9IdgcER6Me1OBW/jPHGolhMmZbIlItOahgP571Cuox17T/a/bzbTs6LBlvOUAbU2
 7udooEMefoJyQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 0/9] Message handling improvements for amdgpu
Date: Sun, 14 Dec 2025 19:12:18 -0600
Message-ID: <20251215011227.161597-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

I noticed a lot of inconsistency in message handling.
 * sometimes two amdgpu prints in a message
 * sometimes no prints in a message
 * some messages are device specific, others aren't

This series improves a lot of the cases that I've found to:
1. print no more than one time
2. include the device whenever possible.

Mario Limonciello (AMD) (9):
  drm/amd: Drop "amdgpu kernel modesetting enabled" message
  drm/amdkfd: Correct the topology message for APUs
  drm/amd: Add correct prefix for VBIOS message
  drm/amd: Pass `adev` to amdgpu_gfx_parse_disable_cu()
  drm/amd: Drop dev_fmt prefix
  drm/amd/display: Fix DPMS log printing
  drm/amd: Convert amdgpu_display from DRM_* to drm_ macros
  drm/amd: Drop amdgpu prefix from message prints
  drm/amd: Convert DRM_*() to drm_*()

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |   7 +-
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  34 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  12 +-
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  40 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   5 +-
 .../drm/amd/amdgpu/amdgpu_fw_attestation.c    |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |   2 +-
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    |   6 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  16 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  14 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  18 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  25 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  14 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |   8 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |   8 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c         |   9 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  16 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  15 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   8 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 114 +++++-------------
 .../link/protocols/link_edp_panel_control.c   |   9 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  20 +--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   5 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   7 +-
 81 files changed, 352 insertions(+), 383 deletions(-)

-- 
2.43.0

