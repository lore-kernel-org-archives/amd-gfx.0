Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCA5C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 08:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C7D10E99E;
	Fri, 28 Mar 2025 08:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T/AlNHC9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01BC110E945
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3322C614C7;
 Thu, 27 Mar 2025 20:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A74C4CEEA;
 Thu, 27 Mar 2025 20:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107957;
 bh=moPiSXPpHqeFbk2qmgBvVV5c33nPW8zOIDbrkdDCyv4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T/AlNHC9wzqq3QiNW4RPsm2Cnd2lGoVcdEZtwcaKkrH/VLnx7IdX1qPHVkYRVuU8G
 KjZaiDxEANVU21TpN5EDUntxvaCUn8PKCC9j/J+rSYQxD5JaEGVLPRy5NiOm95x4TN
 1o7pZPLZjXyXZNgrXaQfP3HhC1M9S6rGJLEV3u5e93IaOF4cM2i2DLxoCbWI+fBHDo
 SmLrtopUec30kcXtG7YBhlvjQdhRYipY94IwBMKvJqtzXO10KdTVdEHcESZXphUKIE
 ezbyukb4taa4lf2hf3JntF9hxkaN/uXht9DcDITTSyDNWTJpBgxNCUqV7gHxMI2xjz
 De6M74/Hpxf6Q==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 13/14] drm/amd: Convert DRM_*() and dev_*() macros to drm_*()
Date: Thu, 27 Mar 2025 15:38:57 -0500
Message-ID: <20250327203858.3796086-14-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Mar 2025 08:18:37 +0000
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

From: Mario Limonciello <mario.limonciello@amd.com>

Messages emitted by amdgpu with legacy DRM macros don't
show which device they are using. To make messages clearer in
multi-GPU systems adjust to drm_*() macros.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  22 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   2 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  44 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 279 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 102 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  81 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  21 +-
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    |  14 +-
 .../drm/amd/amdgpu/amdgpu_fw_attestation.c    |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  74 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  58 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  56 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 222 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c    |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  96 +++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  48 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c  |  34 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c     |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  58 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  62 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  42 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  36 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  54 ++--
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   8 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |  14 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  36 +--
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  40 +--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  40 +--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  38 +--
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c          |   6 +-
 drivers/gpu/drm/amd/amdgpu/df_v4_3.c          |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 102 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 124 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  88 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  22 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  22 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  54 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  80 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c         |  26 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       |  60 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  50 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c   |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c    |  14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  16 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  16 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  32 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  26 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  38 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  48 +--
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   4 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |   5 +-
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |  10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  48 +--
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  52 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c       |  14 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       |  14 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c       |  14 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c       |  14 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  12 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  24 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  26 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c        |  24 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  22 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  18 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  24 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  24 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |  18 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |  22 +-
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  16 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  18 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  10 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c         |  18 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c    |   8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |  12 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |  24 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  20 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |  16 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  10 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  20 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  34 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |   6 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c         |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  60 ++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  10 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  10 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   8 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  56 ++--
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  26 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  86 +++---
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   4 +-
 .../drm/amd/pm/powerplay/hwmgr/common_baco.c  |   2 +-
 .../drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |   2 +-
 .../amd/pm/powerplay/smumgr/smu10_smumgr.c    |   4 +-
 .../drm/amd/pm/powerplay/smumgr/smu7_smumgr.c |   2 +-
 .../drm/amd/pm/powerplay/smumgr/smu9_smumgr.c |   2 +-
 .../amd/pm/powerplay/smumgr/vega20_smumgr.c   |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 106 +++----
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   8 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   8 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  16 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |   2 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  14 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  35 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  70 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |   2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |   4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  14 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  84 +++---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  45 +--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  10 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  54 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   6 +-
 226 files changed, 2416 insertions(+), 2354 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index e13fbd9741412..8b88edb36853c 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -236,7 +236,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 	cmn_block =
 		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_COMMON);
 	if (unlikely(!cmn_block)) {
-		dev_err(adev->dev, "Failed to get BIF handle\n");
+		drm_err(adev_to_drm(adev), "Failed to get BIF handle\n");
 		return -EINVAL;
 	}
 	r = amdgpu_ip_block_resume(cmn_block);
@@ -247,14 +247,14 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 	adev->gfxhub.funcs->init(adev);
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r) {
-		dev_err(adev->dev, "GFXHUB gart reenable failed after reset\n");
+		drm_err(adev_to_drm(adev), "GFXHUB gart reenable failed after reset\n");
 		return r;
 	}
 
 	/* Reload GFX firmware */
 	r = psp_load_fw_list(&adev->psp, ucode_list, ucode_count);
 	if (r) {
-		dev_err(adev->dev, "GFX ucode load failed after reset\n");
+		drm_err(adev_to_drm(adev), "GFX ucode load failed after reset\n");
 		return r;
 	}
 
@@ -264,7 +264,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 	/* Wait for FW reset event complete */
 	r = amdgpu_dpm_wait_for_event(adev, SMU_EVENT_RESET_COMPLETE, 0);
 	if (r) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Failed to get response from firmware after reset\n");
 		return r;
 	}
@@ -294,7 +294,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 			r = adev->ip_blocks[i].version->funcs->late_init(
 				&adev->ip_blocks[i]);
 			if (r) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 					"late_init of IP block <%s> failed %d after reset\n",
 					adev->ip_blocks[i].version->funcs->name,
 					r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index b4ad163f42a76..926406ef61460 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -865,7 +865,8 @@ static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
 	if (ret)
 		return ret;
 
-	dev_info(adev->dev, "amdgpu set smu aca debug mode %s success\n", val ? "on" : "off");
+	drm_info(adev_to_drm(adev),
+		"amdgpu set smu aca debug mode %s success\n", val ? "on" : "off");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4cec3a873995c..f41b0d1a97329 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -155,7 +155,7 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
 	ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
 			      &kfd_client_funcs);
 	if (ret) {
-		dev_err(adev->dev, "Failed to init DRM client: %d\n",
+		drm_err(adev_to_drm(adev), "Failed to init DRM client: %d\n",
 			ret);
 		return ret;
 	}
@@ -315,7 +315,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 
 	r = amdgpu_bo_create(adev, &bp, &bo);
 	if (r) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"failed to allocate BO for amdkfd (%d)\n", r);
 		return r;
 	}
@@ -323,25 +323,25 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	/* map the buffer */
 	r = amdgpu_bo_reserve(bo, true);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to reserve bo for amdkfd\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to reserve bo for amdkfd\n", r);
 		goto allocate_mem_reserve_bo_failed;
 	}
 
 	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to pin bo for amdkfd\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to pin bo for amdkfd\n", r);
 		goto allocate_mem_pin_bo_failed;
 	}
 
 	r = amdgpu_ttm_alloc_gart(&bo->tbo);
 	if (r) {
-		dev_err(adev->dev, "%p bind failed\n", bo);
+		drm_err(adev_to_drm(adev), "%p bind failed\n", bo);
 		goto allocate_mem_kmap_bo_failed;
 	}
 
 	r = amdgpu_bo_kmap(bo, &cpu_ptr_tmp);
 	if (r) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"(%d) failed to map bo to kernel for amdkfd\n", r);
 		goto allocate_mem_kmap_bo_failed;
 	}
@@ -394,7 +394,7 @@ int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 
 	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"failed to allocate gws BO for amdkfd (%d)\n", r);
 		return r;
 	}
@@ -469,7 +469,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 	}
 	mem_info->vram_width = adev->gmc.vram_width;
 
-	pr_debug("Address base: %pap public 0x%llx private 0x%llx\n",
+	drm_dbg(adev_to_drm(adev), "Address base: %pap public 0x%llx private 0x%llx\n",
 			&adev->gmc.aper_base,
 			mem_info->local_mem_size_public,
 			mem_info->local_mem_size_private);
@@ -634,7 +634,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 		ring = &adev->sdma.instance[1].ring;
 		break;
 	default:
-		pr_err("Invalid engine in IB submission: %d\n", engine);
+		drm_err(adev_to_drm(adev), "Invalid engine in IB submission: %d\n", engine);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -656,7 +656,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
 
 	if (ret) {
-		DRM_ERROR("amdgpu: failed to schedule IB.\n");
+		drm_err(adev_to_drm(adev), "amdgpu: failed to schedule IB.\n");
 		goto err_ib_sched;
 	}
 
@@ -676,7 +676,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 	if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
 	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) ||
 		(IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 12)) {
-		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
+		drm_dbg(adev_to_drm(adev), "GFXOFF is %s\n", idle ? "enabled" : "disabled");
 		amdgpu_gfx_off_ctrl(adev, idle);
 	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
 		(adev->flags & AMD_IS_APU)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index ffbaa8bc5eea9..e753fb193a2cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -73,7 +73,7 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 
 	switch (engine_id) {
 	default:
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "Invalid sdma engine id (%d), using engine id 0\n",
 			 engine_id);
 		fallthrough;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 6d08bc2781a39..8e73924ef1781 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -135,7 +135,7 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 
 	switch (engine_id) {
 	default:
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "Invalid sdma engine id (%d), using engine id 0\n",
 			 engine_id);
 		fallthrough;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 088d09cc7a724..43e060e3d799e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -186,7 +186,7 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 
 	switch (engine_id) {
 	default:
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "Invalid sdma engine id (%d), using engine id 0\n",
 			 engine_id);
 		fallthrough;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 199693369c7ce..fd132305fe18a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -66,7 +66,7 @@ static void amdgpu_benchmark_log_results(struct amdgpu_device *adev,
 
 	throughput = div64_s64(throughput, time_ms);
 
-	dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
+	drm_info(adev_to_drm(adev), "amdgpu: %s %u bo moves of %u kB from"
 		 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
 		 kind, n, size >> 10, sdomain, ddomain, time_ms,
 		 throughput * 8, throughput);
@@ -110,7 +110,7 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 out_cleanup:
 	/* Check error value now. The value can be overwritten when clean up.*/
 	if (r < 0)
-		dev_info(adev->dev, "Error while benchmarking BO move.\n");
+		drm_info(adev_to_drm(adev), "Error while benchmarking BO move.\n");
 
 	if (sobj)
 		amdgpu_bo_free_kernel(&sobj, &saddr, NULL);
@@ -145,7 +145,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 	mutex_lock(&adev->benchmark_mutex);
 	switch (test_number) {
 	case 1:
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "benchmark test: %d (simple test, VRAM to GTT and GTT to VRAM)\n",
 			 test_number);
 		/* simple test, VRAM to GTT and GTT to VRAM */
@@ -159,7 +159,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 			goto done;
 		break;
 	case 2:
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "benchmark test: %d (simple test, VRAM to VRAM)\n",
 			 test_number);
 		/* simple test, VRAM to VRAM */
@@ -169,7 +169,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 			goto done;
 		break;
 	case 3:
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "benchmark test: %d (GTT to VRAM, buffer size sweep, powers of 2)\n",
 			 test_number);
 		/* GTT to VRAM, buffer size sweep, powers of 2 */
@@ -182,7 +182,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 4:
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "benchmark test: %d (VRAM to GTT, buffer size sweep, powers of 2)\n",
 			 test_number);
 		/* VRAM to GTT, buffer size sweep, powers of 2 */
@@ -195,7 +195,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 5:
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "benchmark test: %d (VRAM to VRAM, buffer size sweep, powers of 2)\n",
 			 test_number);
 		/* VRAM to VRAM, buffer size sweep, powers of 2 */
@@ -208,7 +208,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 6:
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "benchmark test: %d (GTT to VRAM, buffer size sweep, common modes)\n",
 			 test_number);
 		/* GTT to VRAM, buffer size sweep, common modes */
@@ -221,7 +221,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 7:
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "benchmark test: %d (VRAM to GTT, buffer size sweep, common modes)\n",
 			 test_number);
 		/* VRAM to GTT, buffer size sweep, common modes */
@@ -234,7 +234,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		}
 		break;
 	case 8:
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "benchmark test: %d (VRAM to VRAM, buffer size sweep, common modes)\n",
 			 test_number);
 		/* VRAM to VRAM, buffer size sweep, common modes */
@@ -248,7 +248,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		break;
 
 	default:
-		dev_info(adev->dev, "Unknown benchmark %d\n", test_number);
+		drm_info(adev_to_drm(adev), "Unknown benchmark %d\n", test_number);
 		r = -EINVAL;
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 00e96419fcdad..f462d97664ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -187,7 +187,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 	len = ALIGN(len, 4);
 	adev->bios = kmalloc(len, GFP_KERNEL);
 	if (!adev->bios) {
-		DRM_ERROR("no memory to allocate for BIOS\n");
+		drm_err(adev_to_drm(adev), "no memory to allocate for BIOS\n");
 		return false;
 	}
 	adev->bios_size = len;
@@ -274,7 +274,7 @@ static int amdgpu_atrm_call(acpi_handle atrm_handle, uint8_t *bios,
 
 	status = acpi_evaluate_object(atrm_handle, NULL, &atrm_arg, &buffer);
 	if (ACPI_FAILURE(status)) {
-		DRM_ERROR("failed to evaluate ATRM got %s\n", acpi_format_exception(status));
+		acpi_handle_err(atrm_handle, "failed to evaluate ATRM got %s\n", acpi_format_exception(status));
 		return -ENODEV;
 	}
 
@@ -321,7 +321,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
 	if (!adev->bios) {
-		dev_err(adev->dev, "Unable to allocate bios\n");
+		drm_err(adev_to_drm(adev), "Unable to allocate bios\n");
 		return false;
 	}
 
@@ -366,7 +366,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		return false;
 	tbl_size = hdr->length;
 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
-		dev_info(adev->dev, "ACPI VFCT table present but broken (too short #1),skipping\n");
+		drm_info(adev_to_drm(adev), "ACPI VFCT table present but broken (too short #1),skipping\n");
 		return false;
 	}
 
@@ -379,13 +379,13 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 
 		offset += sizeof(VFCT_IMAGE_HEADER);
 		if (offset > tbl_size) {
-			dev_info(adev->dev, "ACPI VFCT image header truncated,skipping\n");
+			drm_info(adev_to_drm(adev), "ACPI VFCT image header truncated,skipping\n");
 			return false;
 		}
 
 		offset += vhdr->ImageLength;
 		if (offset > tbl_size) {
-			dev_info(adev->dev, "ACPI VFCT image truncated,skipping\n");
+			drm_info(adev_to_drm(adev), "ACPI VFCT image truncated,skipping\n");
 			return false;
 		}
 
@@ -408,7 +408,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		}
 	}
 
-	dev_info(adev->dev, "ACPI VFCT table present but broken (too short #2),skipping\n");
+	drm_info(adev_to_drm(adev), "ACPI VFCT table present but broken (too short #2),skipping\n");
 	return false;
 }
 #else
@@ -421,26 +421,26 @@ static inline bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 static bool amdgpu_get_bios_apu(struct amdgpu_device *adev)
 {
 	if (amdgpu_acpi_vfct_bios(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from VFCT\n");
+		drm_info(adev_to_drm(adev), "Fetched VBIOS from VFCT\n");
 		goto success;
 	}
 
 	if (amdgpu_read_bios_from_vram(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
+		drm_info(adev_to_drm(adev), "Fetched VBIOS from VRAM BAR\n");
 		goto success;
 	}
 
 	if (amdgpu_read_bios(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
+		drm_info(adev_to_drm(adev), "Fetched VBIOS from ROM BAR\n");
 		goto success;
 	}
 
 	if (amdgpu_read_platform_bios(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from platform\n");
+		drm_info(adev_to_drm(adev), "Fetched VBIOS from platform\n");
 		goto success;
 	}
 
-	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
+	drm_err(adev_to_drm(adev), "Unable to locate a BIOS ROM\n");
 	return false;
 
 success:
@@ -457,55 +457,55 @@ static bool amdgpu_prefer_rom_resource(struct amdgpu_device *adev)
 static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
 {
 	if (amdgpu_atrm_get_bios(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from ATRM\n");
+		drm_info(adev_to_drm(adev), "Fetched VBIOS from ATRM\n");
 		goto success;
 	}
 
 	if (amdgpu_acpi_vfct_bios(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from VFCT\n");
+		drm_info(adev_to_drm(adev), "Fetched VBIOS from VFCT\n");
 		goto success;
 	}
 
 	/* this is required for SR-IOV */
 	if (amdgpu_read_bios_from_vram(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
+		drm_info(adev_to_drm(adev), "Fetched VBIOS from VRAM BAR\n");
 		goto success;
 	}
 
 	if (amdgpu_prefer_rom_resource(adev)) {
 		if (amdgpu_read_bios(adev)) {
-			dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
+			drm_info(adev_to_drm(adev), "Fetched VBIOS from ROM BAR\n");
 			goto success;
 		}
 
 		if (amdgpu_read_platform_bios(adev)) {
-			dev_info(adev->dev, "Fetched VBIOS from platform\n");
+			drm_info(adev_to_drm(adev), "Fetched VBIOS from platform\n");
 			goto success;
 		}
 
 	} else {
 		if (amdgpu_read_platform_bios(adev)) {
-			dev_info(adev->dev, "Fetched VBIOS from platform\n");
+			drm_info(adev_to_drm(adev), "Fetched VBIOS from platform\n");
 			goto success;
 		}
 
 		if (amdgpu_read_bios(adev)) {
-			dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
+			drm_info(adev_to_drm(adev), "Fetched VBIOS from ROM BAR\n");
 			goto success;
 		}
 	}
 
 	if (amdgpu_read_bios_from_rom(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from ROM\n");
+		drm_info(adev_to_drm(adev), "Fetched VBIOS from ROM\n");
 		goto success;
 	}
 
 	if (amdgpu_read_disabled_bios(adev)) {
-		dev_info(adev->dev, "Fetched VBIOS from disabled ROM BAR\n");
+		drm_info(adev_to_drm(adev), "Fetched VBIOS from disabled ROM BAR\n");
 		goto success;
 	}
 
-	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
+	drm_err(adev_to_drm(adev), "Unable to locate a BIOS ROM\n");
 	return false;
 
 success:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index c9df887579545..15a58cd73d2c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -73,7 +73,7 @@ static uint32_t amdgpu_cgs_read_ind_register(struct cgs_device *cgs_device,
 	case CGS_IND_REG_SE_CAC:
 		return RREG32_SE_CAC(index);
 	case CGS_IND_REG__AUDIO_ENDPT:
-		DRM_ERROR("audio endpt register access not implemented.\n");
+		drm_err(adev_to_drm(adev), "audio endpt register access not implemented.\n");
 		return 0;
 	default:
 		BUG();
@@ -101,7 +101,7 @@ static void amdgpu_cgs_write_ind_register(struct cgs_device *cgs_device,
 	case CGS_IND_REG_SE_CAC:
 		return WREG32_SE_CAC(index, value);
 	case CGS_IND_REG__AUDIO_ENDPT:
-		DRM_ERROR("audio endpt register access not implemented.\n");
+		drm_err(adev_to_drm(adev), "audio endpt register access not implemented.\n");
 		return;
 	default:
 		BUG();
@@ -151,7 +151,7 @@ static uint32_t fw_type_convert(struct cgs_device *cgs_device, uint32_t fw_type)
 		result = AMDGPU_UCODE_ID_STORAGE;
 		break;
 	default:
-		DRM_ERROR("Firmware type not supported\n");
+		drm_err(adev_to_drm(adev), "Firmware type not supported\n");
 	}
 	return result;
 }
@@ -193,7 +193,7 @@ static uint16_t amdgpu_get_firmware_version(struct cgs_device *cgs_device,
 	case CGS_UCODE_ID_STORAGE:
 		break;
 	default:
-		DRM_ERROR("firmware type %d do not have version\n", type);
+		drm_err(adev_to_drm(adev), "firmware type %d do not have version\n", type);
 		break;
 	}
 	return fw_version;
@@ -349,7 +349,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				strscpy(fw_name, "amdgpu/vega20_smc.bin");
 				break;
 			default:
-				DRM_ERROR("SMC firmware not supported\n");
+				drm_err(adev_to_drm(adev), "SMC firmware not supported\n");
 				return -EINVAL;
 			}
 
@@ -357,7 +357,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 						   AMDGPU_UCODE_REQUIRED,
 						   "%s", fw_name);
 			if (err) {
-				DRM_ERROR("Failed to load firmware \"%s\"", fw_name);
+				drm_err(adev_to_drm(adev), "Failed to load firmware \"%s\"", fw_name);
 				amdgpu_ucode_release(&adev->pm.fw);
 				return err;
 			}
@@ -402,7 +402,7 @@ struct cgs_device *amdgpu_cgs_create_device(struct amdgpu_device *adev)
 		kmalloc(sizeof(*cgs_device), GFP_KERNEL);
 
 	if (!cgs_device) {
-		DRM_ERROR("Couldn't allocate CGS device structure\n");
+		drm_err(adev_to_drm(adev), "Couldn't allocate CGS device structure\n");
 		return NULL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 360e07a5c7c1f..255c0c6df38d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -100,7 +100,7 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
 			hdr->notify_type = MCE;
 		break;
 	default:
-		dev_err(adev->dev, "Unknown CPER Type\n");
+		drm_err(adev_to_drm(adev), "Unknown CPER Type\n");
 		break;
 	}
 
@@ -266,7 +266,7 @@ struct cper_hdr *amdgpu_cper_alloc_entry(struct amdgpu_device *adev,
 		size += (BOOT_SEC_LEN * section_count);
 		break;
 	default:
-		dev_err(adev->dev, "Unknown CPER Type!\n");
+		drm_err(adev_to_drm(adev), "Unknown CPER Type!\n");
 		return NULL;
 	}
 
@@ -290,7 +290,7 @@ int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
 
 	fatal = amdgpu_cper_alloc_entry(adev, AMDGPU_CPER_TYPE_FATAL, 1);
 	if (!fatal) {
-		dev_err(adev->dev, "fail to alloc cper entry for ue record\n");
+		drm_err(adev_to_drm(adev), "fail to alloc cper entry for ue record\n");
 		return -ENOMEM;
 	}
 
@@ -322,7 +322,7 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev)
 
 	bp_threshold = amdgpu_cper_alloc_entry(adev, AMDGPU_CPER_TYPE_BP_THRESHOLD, 1);
 	if (!bp_threshold) {
-		dev_err(adev->dev, "fail to alloc cper entry for bad page threshold record\n");
+		drm_err(adev_to_drm(adev), "fail to alloc cper entry for bad page threshold record\n");
 		return -ENOMEM;
 	}
 
@@ -348,7 +348,7 @@ static enum cper_error_severity amdgpu_aca_err_type_to_cper_sev(struct amdgpu_de
 	case ACA_ERROR_TYPE_DEFERRED:
 		return CPER_SEV_NON_FATAL_UNCORRECTED;
 	default:
-		dev_err(adev->dev, "Unknown ACA error type!\n");
+		drm_err(adev_to_drm(adev), "Unknown ACA error type!\n");
 		return CPER_SEV_FATAL;
 	}
 }
@@ -368,7 +368,7 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 
 	corrected = amdgpu_cper_alloc_entry(adev, AMDGPU_CPER_TYPE_RUNTIME, bank_count);
 	if (!corrected) {
-		dev_err(adev->dev, "fail to allocate cper entry for ce records\n");
+		drm_err(adev_to_drm(adev), "fail to allocate cper entry for ce records\n");
 		return -ENOMEM;
 	}
 
@@ -554,7 +554,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 
 	r = amdgpu_cper_ring_init(adev);
 	if (r) {
-		dev_err(adev->dev, "failed to initialize cper ring, r = %d\n", r);
+		drm_err(adev_to_drm(adev), "failed to initialize cper ring, r = %d\n", r);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 4375e50194184..8a0da8b419fc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -373,7 +373,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 			   chunk_ib->ib_bytes : 0,
 			   AMDGPU_IB_POOL_DELAYED, ib);
 	if (r) {
-		DRM_ERROR("Failed to get ib !\n");
+		drm_err(adev_to_drm(p->adev), "Failed to get ib !\n");
 		return r;
 	}
 
@@ -445,7 +445,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
 
 	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
 	if (r) {
-		DRM_ERROR("syncobj %u failed to find fence @ %llu (%d)!\n",
+		drm_err(adev_to_drm(p->adev), "syncobj %u failed to find fence @ %llu (%d)!\n",
 			  handle, point, r);
 		return r;
 	}
@@ -879,7 +879,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 					 sizeof(struct page *),
 					 GFP_KERNEL);
 		if (!e->user_pages) {
-			DRM_ERROR("kvmalloc_array failure\n");
+			drm_err(adev_to_drm(p->adev), "kvmalloc_array failure\n");
 			r = -ENOMEM;
 			goto out_free_user_pages;
 		}
@@ -960,7 +960,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
 			       amdgpu_cs_bo_validate, p);
 	if (r) {
-		DRM_ERROR("amdgpu_vm_validate() failed.\n");
+		drm_err(adev_to_drm(p->adev), "amdgpu_vm_validate() failed.\n");
 		goto out_free_user_pages;
 	}
 
@@ -1038,13 +1038,13 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 		va_start = ib->gpu_addr & AMDGPU_GMC_HOLE_MASK;
 		r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
 		if (r) {
-			DRM_ERROR("IB va_start is invalid\n");
+			drm_err(adev_to_drm(ring->adev), "IB va_start is invalid\n");
 			return r;
 		}
 
 		if ((va_start + ib->length_dw * 4) >
 		    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
-			DRM_ERROR("IB va_start+ib_bytes is invalid\n");
+			drm_err(adev_to_drm(ring->adev), "IB va_start+ib_bytes is invalid\n");
 			return -EINVAL;
 		}
 
@@ -1212,7 +1212,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
 	if (r) {
 		if (r != -ERESTARTSYS)
-			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
+			drm_err(adev_to_drm(p->adev), "amdgpu_ctx_wait_prev_fence failed.\n");
 		return r;
 	}
 
@@ -1440,7 +1440,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	r = amdgpu_cs_parser_bos(&parser, data);
 	if (r) {
 		if (r == -ENOMEM)
-			DRM_ERROR("Not enough memory for command submission!\n");
+			drm_err(adev_to_drm(adev), "Not enough memory for command submission!\n");
 		else if (r != -ERESTARTSYS && r != -EAGAIN)
 			DRM_DEBUG("Failed to process the buffer list %d!\n", r);
 		goto error_fini;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index cfdf558b48b64..7ff7e4889e94e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -76,7 +76,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r)) {
-			DRM_ERROR("failed to reserve CSA,PD BOs: err=%d\n", r);
+			drm_err(adev_to_drm(adev), "failed to reserve CSA,PD BOs: err=%d\n", r);
 			goto error;
 		}
 	}
@@ -92,7 +92,7 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			     AMDGPU_PTE_EXECUTABLE);
 
 	if (r) {
-		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
+		drm_err(adev_to_drm(adev), "failed to do bo_map on static CSA, err=%d\n", r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		goto error;
 	}
@@ -116,14 +116,14 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r)) {
-			DRM_ERROR("failed to reserve CSA,PD BOs: err=%d\n", r);
+			drm_err(adev_to_drm(adev), "failed to reserve CSA,PD BOs: err=%d\n", r);
 			goto error;
 		}
 	}
 
 	r = amdgpu_vm_bo_unmap(adev, bo_va, csa_addr);
 	if (r) {
-		DRM_ERROR("failed to do bo_unmap on static CSA, err=%d\n", r);
+		drm_err(adev_to_drm(adev), "failed to do bo_unmap on static CSA, err=%d\n", r);
 		goto error;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c43d1b6e5d66b..b457961ca73d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -438,18 +438,18 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 	struct drm_sched_entity *ctx_entity;
 
 	if (hw_ip >= AMDGPU_HW_IP_NUM) {
-		DRM_ERROR("unknown HW IP type: %d\n", hw_ip);
+		drm_err(adev_to_drm(ctx->mgr->adev), "unknown HW IP type: %d\n", hw_ip);
 		return -EINVAL;
 	}
 
 	/* Right now all IPs have only one instance - multiple rings. */
 	if (instance != 0) {
-		DRM_DEBUG("invalid ip instance: %d\n", instance);
+		drm_dbg(adev_to_drm(ctx->mgr->adev), "invalid ip instance: %d\n", instance);
 		return -EINVAL;
 	}
 
 	if (ring >= amdgpu_ctx_num_entities[hw_ip]) {
-		DRM_DEBUG("invalid ring: %d %d\n", hw_ip, ring);
+		drm_dbg(adev_to_drm(ctx->mgr->adev), "invalid ring: %d %d\n", hw_ip, ring);
 		return -EINVAL;
 	}
 
@@ -462,7 +462,7 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 	ctx_entity = &ctx->entities[hw_ip][ring]->entity;
 	r = drm_sched_entity_error(ctx_entity);
 	if (r) {
-		DRM_DEBUG("error entity %p\n", ctx_entity);
+		drm_dbg(adev_to_drm(ctx->mgr->adev), "error entity %p\n", ctx_entity);
 		return r;
 	}
 
@@ -874,7 +874,7 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
 
 	r = dma_fence_wait(other, true);
 	if (r < 0 && r != -ERESTARTSYS)
-		DRM_ERROR("Error (%ld) waiting for fence!\n", r);
+		drm_err(adev_to_drm(ctx->mgr->adev), "Error (%ld) waiting for fence!\n", r);
 
 	dma_fence_put(other);
 	return r;
@@ -929,7 +929,7 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 
 	idr_for_each_entry(idp, ctx, id) {
 		if (kref_read(&ctx->refcount) != 1) {
-			DRM_ERROR("ctx %p is still alive\n", ctx);
+			drm_err(adev_to_drm(mgr->adev), "ctx %p is still alive\n", ctx);
 			continue;
 		}
 
@@ -959,7 +959,7 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 
 	idr_for_each_entry(idp, ctx, id) {
 		if (kref_put(&ctx->refcount, amdgpu_ctx_fini) != 1)
-			DRM_ERROR("ctx %p is still alive\n", ctx);
+			drm_err(adev_to_drm(mgr->adev), "ctx %p is still alive\n", ctx);
 	}
 
 	idr_destroy(&mgr->ctx_handles);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a1450f13d9632..b29ae3df12ff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1953,7 +1953,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 
 	if (atomic_read(&ring->fence_drv.last_seq) !=
 	    ring->fence_drv.sync_seq) {
-		DRM_INFO("ring %d was preempted\n", ring->idx);
+		drm_info(adev_to_drm(adev), "ring %d was preempted\n", ring->idx);
 
 		amdgpu_ib_preempt_mark_partial_job(ring);
 
@@ -2041,14 +2041,14 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
-		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
+		drm_err(adev_to_drm(adev), "unable to create amdgpu_preempt_ib debugsfs file\n");
 		return PTR_ERR(ent);
 	}
 
 	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
 				  &fops_sclk_set);
 	if (IS_ERR(ent)) {
-		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
+		drm_err(adev_to_drm(adev), "unable to create amdgpu_set_sclk debugsfs file\n");
 		return PTR_ERR(ent);
 	}
 
@@ -2061,7 +2061,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	r = amdgpu_debugfs_regs_init(adev);
 	if (r)
-		DRM_ERROR("registering register debugfs failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "registering register debugfs failed (%d).\n", r);
 
 	amdgpu_debugfs_firmware_init(adev);
 	amdgpu_ta_if_debugfs_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 7b50741dc097c..68dd39a5d934b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -336,7 +336,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
 
 	if (!coredump) {
-		DRM_ERROR("%s: failed to allocate memory for coredump\n", __func__);
+		drm_err(adev_to_drm(adev), "%s: failed to allocate memory for coredump\n", __func__);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 04abbc46ef602..69a4eba40512a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -480,26 +480,26 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 	case 2:
 		if (bamaco_support & MACO_SUPPORT) {
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
-			dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
+			drm_info(adev_to_drm(adev), "Forcing BAMACO for runtime pm\n");
 		} else if (bamaco_support == BACO_SUPPORT) {
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			dev_info(adev->dev, "Requested mode BAMACO not available,fallback to use BACO\n");
+			drm_info(adev_to_drm(adev), "Requested mode BAMACO not available,fallback to use BACO\n");
 		}
 		break;
 	case 1:
 		if (bamaco_support & BACO_SUPPORT) {
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
-			dev_info(adev->dev, "Forcing BACO for runtime pm\n");
+			drm_info(adev_to_drm(adev), "Forcing BACO for runtime pm\n");
 		}
 		break;
 	case -1:
 	case -2:
 		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
-			dev_info(adev->dev, "Using ATPX for runtime pm\n");
+			drm_info(adev_to_drm(adev), "Using ATPX for runtime pm\n");
 		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
 			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
-			dev_info(adev->dev, "Using BOCO for runtime pm\n");
+			drm_info(adev_to_drm(adev), "Using BOCO for runtime pm\n");
 		} else {
 			if (!bamaco_support)
 				goto no_runtime_pm;
@@ -523,15 +523,15 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
 				if (bamaco_support & MACO_SUPPORT) {
 					adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
-					dev_info(adev->dev, "Using BAMACO for runtime pm\n");
+					drm_info(adev_to_drm(adev), "Using BAMACO for runtime pm\n");
 				} else {
-					dev_info(adev->dev, "Using BACO for runtime pm\n");
+					drm_info(adev_to_drm(adev), "Using BACO for runtime pm\n");
 				}
 			}
 		}
 		break;
 	case 0:
-		dev_info(adev->dev, "runtime pm is manually disabled\n");
+		drm_info(adev_to_drm(adev), "runtime pm is manually disabled\n");
 		break;
 	default:
 		break;
@@ -539,7 +539,7 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
 
 no_runtime_pm:
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
-		dev_info(adev->dev, "Runtime PM not available\n");
+		drm_info(adev_to_drm(adev), "Runtime PM not available\n");
 }
 /**
  * amdgpu_device_supports_smart_shift - Is the device dGPU with
@@ -1286,14 +1286,14 @@ u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev)
  */
 static uint32_t amdgpu_invalid_rreg(struct amdgpu_device *adev, uint32_t reg)
 {
-	DRM_ERROR("Invalid callback to read register 0x%04X\n", reg);
+	drm_err(adev_to_drm(adev), "Invalid callback to read register 0x%04X\n", reg);
 	BUG();
 	return 0;
 }
 
 static uint32_t amdgpu_invalid_rreg_ext(struct amdgpu_device *adev, uint64_t reg)
 {
-	DRM_ERROR("Invalid callback to read register 0x%llX\n", reg);
+	drm_err(adev_to_drm(adev), "Invalid callback to read register 0x%llX\n", reg);
 	BUG();
 	return 0;
 }
@@ -1310,14 +1310,14 @@ static uint32_t amdgpu_invalid_rreg_ext(struct amdgpu_device *adev, uint64_t reg
  */
 static void amdgpu_invalid_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 {
-	DRM_ERROR("Invalid callback to write register 0x%04X with 0x%08X\n",
+	drm_err(adev_to_drm(adev), "Invalid callback to write register 0x%04X with 0x%08X\n",
 		  reg, v);
 	BUG();
 }
 
 static void amdgpu_invalid_wreg_ext(struct amdgpu_device *adev, uint64_t reg, uint32_t v)
 {
-	DRM_ERROR("Invalid callback to write register 0x%llX with 0x%08X\n",
+	drm_err(adev_to_drm(adev), "Invalid callback to write register 0x%llX with 0x%08X\n",
 		  reg, v);
 	BUG();
 }
@@ -1334,14 +1334,14 @@ static void amdgpu_invalid_wreg_ext(struct amdgpu_device *adev, uint64_t reg, ui
  */
 static uint64_t amdgpu_invalid_rreg64(struct amdgpu_device *adev, uint32_t reg)
 {
-	DRM_ERROR("Invalid callback to read 64 bit register 0x%04X\n", reg);
+	drm_err(adev_to_drm(adev), "Invalid callback to read 64 bit register 0x%04X\n", reg);
 	BUG();
 	return 0;
 }
 
 static uint64_t amdgpu_invalid_rreg64_ext(struct amdgpu_device *adev, uint64_t reg)
 {
-	DRM_ERROR("Invalid callback to read register 0x%llX\n", reg);
+	drm_err(adev_to_drm(adev), "Invalid callback to read register 0x%llX\n", reg);
 	BUG();
 	return 0;
 }
@@ -1358,14 +1358,14 @@ static uint64_t amdgpu_invalid_rreg64_ext(struct amdgpu_device *adev, uint64_t r
  */
 static void amdgpu_invalid_wreg64(struct amdgpu_device *adev, uint32_t reg, uint64_t v)
 {
-	DRM_ERROR("Invalid callback to write 64 bit register 0x%04X with 0x%08llX\n",
+	drm_err(adev_to_drm(adev), "Invalid callback to write 64 bit register 0x%04X with 0x%08llX\n",
 		  reg, v);
 	BUG();
 }
 
 static void amdgpu_invalid_wreg64_ext(struct amdgpu_device *adev, uint64_t reg, uint64_t v)
 {
-	DRM_ERROR("Invalid callback to write 64 bit register 0x%llX with 0x%08llX\n",
+	drm_err(adev_to_drm(adev), "Invalid callback to write 64 bit register 0x%llX with 0x%08llX\n",
 		  reg, v);
 	BUG();
 }
@@ -1384,7 +1384,7 @@ static void amdgpu_invalid_wreg64_ext(struct amdgpu_device *adev, uint64_t reg,
 static uint32_t amdgpu_block_invalid_rreg(struct amdgpu_device *adev,
 					  uint32_t block, uint32_t reg)
 {
-	DRM_ERROR("Invalid callback to read register 0x%04X in block 0x%04X\n",
+	drm_err(adev_to_drm(adev), "Invalid callback to read register 0x%04X in block 0x%04X\n",
 		  reg, block);
 	BUG();
 	return 0;
@@ -1405,7 +1405,7 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
 				      uint32_t block,
 				      uint32_t reg, uint32_t v)
 {
-	DRM_ERROR("Invalid block callback to write register 0x%04X in block 0x%04X with 0x%08X\n",
+	drm_err(adev_to_drm(adev), "Invalid block callback to write register 0x%04X in block 0x%04X with 0x%08X\n",
 		  reg, block, v);
 	BUG();
 }
@@ -1596,7 +1596,7 @@ static int amdgpu_device_wb_init(struct amdgpu_device *adev)
 					    &adev->wb.wb_obj, &adev->wb.gpu_addr,
 					    (void **)&adev->wb.wb);
 		if (r) {
-			dev_warn(adev->dev, "(%d) create WB bo failed\n", r);
+			drm_warn(adev_to_drm(adev), "(%d) create WB bo failed\n", r);
 			return r;
 		}
 
@@ -1692,7 +1692,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
 	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
-		DRM_WARN("System can't access extended configuration space, please check!!\n");
+		drm_warn(adev_to_drm(adev), "System can't access extended configuration space, please check!!\n");
 
 	/* skip if the bios has already enabled large BAR */
 	if (adev->gmc.real_vram_size &&
@@ -1732,9 +1732,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	r = pci_resize_resource(adev->pdev, 0, rbar_size);
 	if (r == -ENOSPC)
-		DRM_INFO("Not enough PCI address space for a large BAR.");
+		drm_info(adev_to_drm(adev), "Not enough PCI address space for a large BAR.");
 	else if (r && r != -ENOTSUPP)
-		DRM_ERROR("Problem resizing BAR0 (%d).", r);
+		drm_err(adev_to_drm(adev), "Problem resizing BAR0 (%d).", r);
 
 	pci_assign_unassigned_bus_resources(adev->pdev->bus);
 
@@ -1836,7 +1836,7 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
 	case 0:
 		return false;
 	default:
-		DRM_ERROR("Invalid value for amdgpu.seamless: %d\n",
+		drm_err(adev_to_drm(adev), "Invalid value for amdgpu.seamless: %d\n",
 			  amdgpu_seamless);
 		return false;
 	}
@@ -1945,7 +1945,7 @@ static void amdgpu_device_check_block_size(struct amdgpu_device *adev)
 		return;
 
 	if (amdgpu_vm_block_size < 9) {
-		dev_warn(adev->dev, "VM page table size (%d) too small\n",
+		drm_warn(adev_to_drm(adev), "VM page table size (%d) too small\n",
 			 amdgpu_vm_block_size);
 		amdgpu_vm_block_size = -1;
 	}
@@ -1966,7 +1966,7 @@ static void amdgpu_device_check_vm_size(struct amdgpu_device *adev)
 		return;
 
 	if (amdgpu_vm_size < 1) {
-		dev_warn(adev->dev, "VM size (%d) too small, min is 1GB\n",
+		drm_warn(adev_to_drm(adev), "VM size (%d) too small, min is 1GB\n",
 			 amdgpu_vm_size);
 		amdgpu_vm_size = -1;
 	}
@@ -1984,7 +1984,7 @@ static void amdgpu_device_check_smu_prv_buffer_size(struct amdgpu_device *adev)
 		return;
 
 	if (!is_os_64) {
-		DRM_WARN("Not 64-bit OS, feature not supported\n");
+		drm_warn(adev_to_drm(adev), "Not 64-bit OS, feature not supported\n");
 		goto def_value;
 	}
 	si_meminfo(&si);
@@ -1999,7 +1999,7 @@ static void amdgpu_device_check_smu_prv_buffer_size(struct amdgpu_device *adev)
 		if (total_memory < dram_size_seven_GB)
 			goto def_value1;
 	} else {
-		DRM_WARN("Smu memory pool size not supported\n");
+		drm_warn(adev_to_drm(adev), "Smu memory pool size not supported\n");
 		goto def_value;
 	}
 	adev->pm.smu_prv_buffer_size = amdgpu_smu_memory_pool_size << 28;
@@ -2007,7 +2007,7 @@ static void amdgpu_device_check_smu_prv_buffer_size(struct amdgpu_device *adev)
 	return;
 
 def_value1:
-	DRM_WARN("No enough system memory\n");
+	drm_warn(adev_to_drm(adev), "No enough system memory\n");
 def_value:
 	adev->pm.smu_prv_buffer_size = 0;
 }
@@ -2062,25 +2062,25 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 	int i;
 
 	if (amdgpu_sched_jobs < 4) {
-		dev_warn(adev->dev, "sched jobs (%d) must be at least 4\n",
+		drm_warn(adev_to_drm(adev), "sched jobs (%d) must be at least 4\n",
 			 amdgpu_sched_jobs);
 		amdgpu_sched_jobs = 4;
 	} else if (!is_power_of_2(amdgpu_sched_jobs)) {
-		dev_warn(adev->dev, "sched jobs (%d) must be a power of 2\n",
+		drm_warn(adev_to_drm(adev), "sched jobs (%d) must be a power of 2\n",
 			 amdgpu_sched_jobs);
 		amdgpu_sched_jobs = roundup_pow_of_two(amdgpu_sched_jobs);
 	}
 
 	if (amdgpu_gart_size != -1 && amdgpu_gart_size < 32) {
 		/* gart size must be greater or equal to 32M */
-		dev_warn(adev->dev, "gart size (%d) too small\n",
+		drm_warn(adev_to_drm(adev), "gart size (%d) too small\n",
 			 amdgpu_gart_size);
 		amdgpu_gart_size = -1;
 	}
 
 	if (amdgpu_gtt_size != -1 && amdgpu_gtt_size < 32) {
 		/* gtt size must be greater or equal to 32M */
-		dev_warn(adev->dev, "gtt size (%d) too small\n",
+		drm_warn(adev_to_drm(adev), "gtt size (%d) too small\n",
 				 amdgpu_gtt_size);
 		amdgpu_gtt_size = -1;
 	}
@@ -2088,22 +2088,22 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 	/* valid range is between 4 and 9 inclusive */
 	if (amdgpu_vm_fragment_size != -1 &&
 	    (amdgpu_vm_fragment_size > 9 || amdgpu_vm_fragment_size < 4)) {
-		dev_warn(adev->dev, "valid range is between 4 and 9\n");
+		drm_warn(adev_to_drm(adev), "valid range is between 4 and 9\n");
 		amdgpu_vm_fragment_size = -1;
 	}
 
 	if (amdgpu_sched_hw_submission < 2) {
-		dev_warn(adev->dev, "sched hw submission jobs (%d) must be at least 2\n",
+		drm_warn(adev_to_drm(adev), "sched hw submission jobs (%d) must be at least 2\n",
 			 amdgpu_sched_hw_submission);
 		amdgpu_sched_hw_submission = 2;
 	} else if (!is_power_of_2(amdgpu_sched_hw_submission)) {
-		dev_warn(adev->dev, "sched hw submission jobs (%d) must be a power of 2\n",
+		drm_warn(adev_to_drm(adev), "sched hw submission jobs (%d) must be a power of 2\n",
 			 amdgpu_sched_hw_submission);
 		amdgpu_sched_hw_submission = roundup_pow_of_two(amdgpu_sched_hw_submission);
 	}
 
 	if (amdgpu_reset_method < -1 || amdgpu_reset_method > 4) {
-		dev_warn(adev->dev, "invalid option for reset method, reverting to default\n");
+		drm_warn(adev_to_drm(adev), "invalid option for reset method, reverting to default\n");
 		amdgpu_reset_method = -1;
 	}
 
@@ -2140,7 +2140,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
-		pr_info("switched on\n");
+		drm_info(dev, "switched on\n");
 		/* don't suspend or resume card normally */
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
@@ -2148,12 +2148,12 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		amdgpu_device_load_pci_state(pdev);
 		r = pci_enable_device(pdev);
 		if (r)
-			DRM_WARN("pci_enable_device failed (%d)\n", r);
+			drm_warn(dev, "pci_enable_device failed (%d)\n", r);
 		amdgpu_device_resume(dev, true);
 
 		dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	} else {
-		pr_info("switched off\n");
+		drm_info(dev, "switched off\n");
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 		amdgpu_device_prepare(dev);
 		amdgpu_device_suspend(dev, true);
@@ -2220,7 +2220,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 		r = adev->ip_blocks[i].version->funcs->set_clockgating_state(
 			&adev->ip_blocks[i], state);
 		if (r)
-			DRM_ERROR("set_clockgating_state of IP block <%s> failed %d\n",
+			drm_err(adev_to_drm(adev), "set_clockgating_state of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
 	}
 	return r;
@@ -2254,7 +2254,7 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
 			&adev->ip_blocks[i], state);
 		if (r)
-			DRM_ERROR("set_powergating_state of IP block <%s> failed %d\n",
+			drm_err(adev_to_drm(adev), "set_powergating_state of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
 	}
 	return r;
@@ -2413,7 +2413,7 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 		break;
 	}
 
-	dev_info(adev->dev, "detected ip block number %d <%s>\n",
+	drm_info(adev_to_drm(adev), "detected ip block number %d <%s>\n",
 		 adev->num_ip_blocks, ip_block_version->funcs->name);
 
 	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
@@ -2471,7 +2471,7 @@ static void amdgpu_device_enable_virtual_display(struct amdgpu_device *adev)
 			}
 		}
 
-		DRM_INFO("virtual display string:%s, %s:virtual_display:%d, num_crtc:%d\n",
+		drm_info(adev_to_drm(adev), "virtual display string:%s, %s:virtual_display:%d, num_crtc:%d\n",
 			 amdgpu_virtual_display, pci_address_name,
 			 adev->enable_virtual_display, adev->mode_info.num_crtc);
 
@@ -2484,7 +2484,7 @@ void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && !adev->enable_virtual_display) {
 		adev->mode_info.num_crtc = 1;
 		adev->enable_virtual_display = true;
-		DRM_INFO("virtual_display:%d, num_crtc:%d\n",
+		drm_info(adev_to_drm(adev), "virtual_display:%d, num_crtc:%d\n",
 			 adev->enable_virtual_display, adev->mode_info.num_crtc);
 	}
 }
@@ -2539,7 +2539,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 				   AMDGPU_UCODE_OPTIONAL,
 				   "amdgpu/%s_gpu_info.bin", chip_name);
 	if (err) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Failed to get gpu_info firmware \"%s_gpu_info.bin\"\n",
 			chip_name);
 		goto out;
@@ -2603,7 +2603,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		break;
 	}
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Unsupported gpu_info table %d\n", hdr->header.ucode_version);
 		err = -EINVAL;
 		goto out;
@@ -2718,7 +2718,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		ip_block = &adev->ip_blocks[i];
 
 		if ((amdgpu_ip_block_mask & (1 << i)) == 0) {
-			DRM_WARN("disabled ip block: %d <%s>\n",
+			drm_warn(adev_to_drm(adev), "disabled ip block: %d <%s>\n",
 				  i, adev->ip_blocks[i].version->funcs->name);
 			adev->ip_blocks[i].status.valid = false;
 		} else if (ip_block->version->funcs->early_init) {
@@ -2726,7 +2726,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			if (r == -ENOENT) {
 				adev->ip_blocks[i].status.valid = false;
 			} else if (r) {
-				DRM_ERROR("early_init of IP block <%s> failed %d\n",
+				drm_err(adev_to_drm(adev), "early_init of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
 				total = false;
 			} else {
@@ -2758,7 +2758,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 				if (adev->bios) {
 					r = amdgpu_atombios_init(adev);
 					if (r) {
-						dev_err(adev->dev,
+						drm_err(adev_to_drm(adev),
 							"amdgpu_atombios_init failed\n");
 						amdgpu_vf_error_put(
 							adev,
@@ -2808,7 +2808,7 @@ static int amdgpu_device_ip_hw_init_phase1(struct amdgpu_device *adev)
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH) {
 			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
 			if (r) {
-				DRM_ERROR("hw_init of IP block <%s> failed %d\n",
+				drm_err(adev_to_drm(adev), "hw_init of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
 				return r;
 			}
@@ -2833,7 +2833,7 @@ static int amdgpu_device_ip_hw_init_phase2(struct amdgpu_device *adev)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
 		if (r) {
-			DRM_ERROR("hw_init of IP block <%s> failed %d\n",
+			drm_err(adev_to_drm(adev), "hw_init of IP block <%s> failed %d\n",
 				  adev->ip_blocks[i].version->funcs->name, r);
 			return r;
 		}
@@ -2872,7 +2872,7 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			} else {
 				r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
 				if (r) {
-					DRM_ERROR("hw_init of IP block <%s> failed %d\n",
+					drm_err(adev_to_drm(adev), "hw_init of IP block <%s> failed %d\n",
 							  adev->ip_blocks[i].version->funcs->name, r);
 					return r;
 				}
@@ -2922,19 +2922,19 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 				   ring->sched_score, ring->name,
 				   adev->dev);
 		if (r) {
-			DRM_ERROR("Failed to create scheduler on ring %s.\n",
+			drm_err(adev_to_drm(adev), "Failed to create scheduler on ring %s.\n",
 				  ring->name);
 			return r;
 		}
 		r = amdgpu_uvd_entity_init(adev, ring);
 		if (r) {
-			DRM_ERROR("Failed to create UVD scheduling entity on ring %s.\n",
+			drm_err(adev_to_drm(adev), "Failed to create UVD scheduling entity on ring %s.\n",
 				  ring->name);
 			return r;
 		}
 		r = amdgpu_vce_entity_init(adev, ring);
 		if (r) {
-			DRM_ERROR("Failed to create VCE scheduling entity on ring %s.\n",
+			drm_err(adev_to_drm(adev), "Failed to create VCE scheduling entity on ring %s.\n",
 				  ring->name);
 			return r;
 		}
@@ -2972,7 +2972,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->funcs->sw_init) {
 			r = adev->ip_blocks[i].version->funcs->sw_init(&adev->ip_blocks[i]);
 			if (r) {
-				DRM_ERROR("sw_init of IP block <%s> failed %d\n",
+				drm_err(adev_to_drm(adev), "sw_init of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
 				goto init_failed;
 			}
@@ -2987,7 +2987,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 			/* need to do common hw init early so everything is set up for gmc */
 			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
 			if (r) {
-				DRM_ERROR("hw_init %d failed %d\n", i, r);
+				drm_err(adev_to_drm(adev), "hw_init %d failed %d\n", i, r);
 				goto init_failed;
 			}
 			adev->ip_blocks[i].status.hw = true;
@@ -2999,17 +2999,17 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 			r = amdgpu_device_mem_scratch_init(adev);
 			if (r) {
-				DRM_ERROR("amdgpu_mem_scratch_init failed %d\n", r);
+				drm_err(adev_to_drm(adev), "amdgpu_mem_scratch_init failed %d\n", r);
 				goto init_failed;
 			}
 			r = adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
 			if (r) {
-				DRM_ERROR("hw_init %d failed %d\n", i, r);
+				drm_err(adev_to_drm(adev), "hw_init %d failed %d\n", i, r);
 				goto init_failed;
 			}
 			r = amdgpu_device_wb_init(adev);
 			if (r) {
-				DRM_ERROR("amdgpu_device_wb_init failed %d\n", r);
+				drm_err(adev_to_drm(adev), "amdgpu_device_wb_init failed %d\n", r);
 				goto init_failed;
 			}
 			adev->ip_blocks[i].status.hw = true;
@@ -3021,14 +3021,14 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 							       AMDGPU_GEM_DOMAIN_GTT,
 							       AMDGPU_CSA_SIZE);
 				if (r) {
-					DRM_ERROR("allocate CSA failed %d\n", r);
+					drm_err(adev_to_drm(adev), "allocate CSA failed %d\n", r);
 					goto init_failed;
 				}
 			}
 
 			r = amdgpu_seq64_init(adev);
 			if (r) {
-				DRM_ERROR("allocate seq64 failed %d\n", r);
+				drm_err(adev_to_drm(adev), "allocate seq64 failed %d\n", r);
 				goto init_failed;
 			}
 		}
@@ -3039,7 +3039,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	r = amdgpu_ib_pool_init(adev);
 	if (r) {
-		dev_err(adev->dev, "IB initialization failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "IB initialization failed (%d).\n", r);
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_IB_INIT_FAIL, 0, r);
 		goto init_failed;
 	}
@@ -3218,7 +3218,7 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 			r = adev->ip_blocks[i].version->funcs->set_clockgating_state(&adev->ip_blocks[i],
 										     state);
 			if (r) {
-				DRM_ERROR("set_clockgating_state(gate) of IP block <%s> failed %d\n",
+				drm_err(adev_to_drm(adev), "set_clockgating_state(gate) of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
 				return r;
 			}
@@ -3255,7 +3255,7 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 			r = adev->ip_blocks[i].version->funcs->set_powergating_state(&adev->ip_blocks[i],
 											state);
 			if (r) {
-				DRM_ERROR("set_powergating_state(gate) of IP block <%s> failed %d\n",
+				drm_err(adev_to_drm(adev), "set_powergating_state(gate) of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
 				return r;
 			}
@@ -3322,7 +3322,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->funcs->late_init) {
 			r = adev->ip_blocks[i].version->funcs->late_init(&adev->ip_blocks[i]);
 			if (r) {
-				DRM_ERROR("late_init of IP block <%s> failed %d\n",
+				drm_err(adev_to_drm(adev), "late_init of IP block <%s> failed %d\n",
 					  adev->ip_blocks[i].version->funcs->name, r);
 				return r;
 			}
@@ -3332,7 +3332,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 
 	r = amdgpu_ras_late_init(adev);
 	if (r) {
-		DRM_ERROR("amdgpu_ras_late_init failed %d", r);
+		drm_err(adev_to_drm(adev), "amdgpu_ras_late_init failed %d", r);
 		return r;
 	}
 
@@ -3346,7 +3346,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 
 	r = amdgpu_device_enable_mgpu_fan_boost();
 	if (r)
-		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "enable mgpu fan boost failed (%d).\n", r);
 
 	/* For passthrough configuration on arcturus and aldebaran, enable special handling SBR */
 	if (amdgpu_passthrough(adev) &&
@@ -3379,7 +3379,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 				r = amdgpu_xgmi_set_pstate(gpu_instance->adev,
 						AMDGPU_XGMI_PSTATE_MIN);
 				if (r) {
-					DRM_ERROR("pstate setting failed (%d).\n", r);
+					drm_err(adev_to_drm(adev), "pstate setting failed (%d).\n", r);
 					break;
 				}
 			}
@@ -3396,13 +3396,13 @@ static void amdgpu_ip_block_hw_fini(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	if (!ip_block->version->funcs->hw_fini) {
-		DRM_ERROR("hw_fini of IP block <%s> not defined\n",
+		drm_err(adev_to_drm(ip_block->adev), "hw_fini of IP block <%s> not defined\n",
 			  ip_block->version->funcs->name);
 	} else {
 		r = ip_block->version->funcs->hw_fini(ip_block);
 		/* XXX handle errors */
 		if (r) {
-			DRM_DEBUG("hw_fini of IP block <%s> failed %d\n",
+			drm_dbg(adev_to_drm(ip_block->adev), "hw_fini of IP block <%s> failed %d\n",
 				  ip_block->version->funcs->name, r);
 		}
 	}
@@ -3466,7 +3466,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 
 	if (amdgpu_sriov_vf(adev)) {
 		if (amdgpu_virt_release_full_gpu(adev, false))
-			DRM_ERROR("failed to release exclusive mode on fini\n");
+			drm_err(adev_to_drm(adev), "failed to release exclusive mode on fini\n");
 	}
 
 	return 0;
@@ -3547,7 +3547,7 @@ static void amdgpu_device_delayed_init_work_handler(struct work_struct *work)
 
 	r = amdgpu_ib_ring_tests(adev);
 	if (r)
-		DRM_ERROR("ib ring test failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "ib ring test failed (%d).\n", r);
 }
 
 static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
@@ -3586,7 +3586,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 	 * scenario. Add the missing df cstate disablement here.
 	 */
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
-		dev_warn(adev->dev, "Failed to disallow df cstate");
+		drm_warn(adev_to_drm(adev), "Failed to disallow df cstate");
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -3681,7 +3681,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
 				r = amdgpu_dpm_set_mp1_state(adev, adev->mp1_state);
 				if (r) {
-					DRM_ERROR("SMC failed to set mp1 state %d, %d\n",
+					drm_err(adev_to_drm(adev), "SMC failed to set mp1 state %d, %d\n",
 							adev->mp1_state, r);
 					return r;
 				}
@@ -3751,7 +3751,7 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 
 			r = block->version->funcs->hw_init(&adev->ip_blocks[i]);
 			if (r) {
-				dev_err(adev->dev, "RE-INIT-early: %s failed\n",
+				drm_err(adev_to_drm(adev), "RE-INIT-early: %s failed\n",
 					 block->version->funcs->name);
 				return r;
 			}
@@ -3793,7 +3793,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 			}
 
 			if (r) {
-				dev_err(adev->dev, "RE-INIT-late: %s failed\n",
+				drm_err(adev_to_drm(adev), "RE-INIT-late: %s failed\n",
 					 block->version->funcs->name);
 				break;
 			}
@@ -4075,7 +4075,7 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 
 fail:
 	if (adev->asic_reset_res)
-		DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
+		drm_warn(adev_to_drm(adev), "ASIC reset failed with error, %d for drm dev, %s",
 			 adev->asic_reset_res, adev_to_drm(adev)->unique);
 	amdgpu_put_xgmi_hive(hive);
 }
@@ -4114,7 +4114,7 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 				continue;
 			} else if (timeout < 0) {
 				timeout = MAX_SCHEDULE_TIMEOUT;
-				dev_warn(adev->dev, "lockup timeout disabled");
+				drm_warn(adev_to_drm(adev), "lockup timeout disabled");
 				add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 			} else {
 				timeout = msecs_to_jiffies(timeout);
@@ -4199,7 +4199,7 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 		adev->gfx.mcbp = true;
 
 	if (adev->gfx.mcbp)
-		DRM_INFO("MCBP is enabled\n");
+		drm_info(adev_to_drm(adev), "MCBP is enabled\n");
 }
 
 /**
@@ -4267,7 +4267,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->audio_endpt_rreg = &amdgpu_block_invalid_rreg;
 	adev->audio_endpt_wreg = &amdgpu_block_invalid_wreg;
 
-	DRM_INFO("initializing kernel modesetting (%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X).\n",
+	drm_info(ddev, "initializing kernel modesetting (%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X).\n",
 		 amdgpu_asic_name[adev->asic_type], pdev->vendor, pdev->device,
 		 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
 
@@ -4383,8 +4383,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (!adev->rmmio)
 		return -ENOMEM;
 
-	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
-	DRM_INFO("register mmio size: %u\n", (unsigned int)adev->rmmio_size);
+	drm_info(ddev, "register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
+	drm_info(ddev, "register mmio size: %u\n", (unsigned int)adev->rmmio_size);
 
 	/*
 	 * Reset domain needs to be present early, before XGMI hive discovered
@@ -4403,7 +4403,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
-		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
+		drm_err(adev_to_drm(adev), "invalid lockup_timeout parameter syntax\n");
 		return r;
 	}
 
@@ -4471,7 +4471,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	if (!adev->have_atomics_support)
-		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
+		drm_info(adev_to_drm(adev), "PCIE atomic ops is not supported\n");
 
 	/* doorbell bar mapping and doorbell index init*/
 	amdgpu_doorbell_init(adev);
@@ -4493,7 +4493,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 */
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
 		if (adev->gmc.xgmi.num_physical_nodes) {
-			dev_info(adev->dev, "Pending hive reset.\n");
+			drm_info(adev_to_drm(adev), "Pending hive reset.\n");
 			amdgpu_set_init_level(adev,
 					      AMDGPU_INIT_LEVEL_MINIMAL_XGMI);
 		} else if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
@@ -4510,7 +4510,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 
 		if (r) {
-		  dev_err(adev->dev, "asic reset on init failed\n");
+		  drm_err(adev_to_drm(adev), "asic reset on init failed\n");
 		  goto failed;
 		}
 	}
@@ -4518,14 +4518,14 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Post card if necessary */
 	if (amdgpu_device_need_post(adev)) {
 		if (!adev->bios) {
-			dev_err(adev->dev, "no vBIOS found\n");
+			drm_err(adev_to_drm(adev), "no vBIOS found\n");
 			r = -EINVAL;
 			goto failed;
 		}
-		DRM_INFO("GPU posting now...\n");
+		drm_info(adev_to_drm(adev), "GPU posting now...\n");
 		r = amdgpu_device_asic_init(adev);
 		if (r) {
-			dev_err(adev->dev, "gpu post error!\n");
+			drm_err(adev_to_drm(adev), "gpu post error!\n");
 			goto failed;
 		}
 	}
@@ -4535,7 +4535,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			/* Initialize clocks */
 			r = amdgpu_atomfirmware_get_clock_info(adev);
 			if (r) {
-				dev_err(adev->dev, "amdgpu_atomfirmware_get_clock_info failed\n");
+				drm_err(adev_to_drm(adev), "amdgpu_atomfirmware_get_clock_info failed\n");
 				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_GET_CLOCK_FAIL, 0, 0);
 				goto failed;
 			}
@@ -4543,7 +4543,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			/* Initialize clocks */
 			r = amdgpu_atombios_get_clock_info(adev);
 			if (r) {
-				dev_err(adev->dev, "amdgpu_atombios_get_clock_info failed\n");
+				drm_err(adev_to_drm(adev), "amdgpu_atombios_get_clock_info failed\n");
 				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_GET_CLOCK_FAIL, 0, 0);
 				goto failed;
 			}
@@ -4556,7 +4556,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Fence driver */
 	r = amdgpu_fence_driver_sw_init(adev);
 	if (r) {
-		dev_err(adev->dev, "amdgpu_fence_driver_sw_init failed\n");
+		drm_err(adev_to_drm(adev), "amdgpu_fence_driver_sw_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);
 		goto failed;
 	}
@@ -4566,14 +4566,14 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	r = amdgpu_device_ip_init(adev);
 	if (r) {
-		dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
+		drm_err(adev_to_drm(adev), "amdgpu_device_ip_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
 		goto release_ras_con;
 	}
 
 	amdgpu_fence_driver_hw_init(adev);
 
-	dev_info(adev->dev,
+	drm_info(adev_to_drm(adev),
 		"SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
 			adev->gfx.config.max_shader_engines,
 			adev->gfx.config.max_sh_per_se,
@@ -4605,7 +4605,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
 		r = amdgpu_device_ip_late_init(adev);
 		if (r) {
-			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
+			drm_err(adev_to_drm(adev), "amdgpu_device_ip_late_init failed\n");
 			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
 			goto release_ras_con;
 		}
@@ -4643,11 +4643,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	r = amdgpu_device_attr_sysfs_init(adev);
 	if (r)
-		dev_err(adev->dev, "Could not create amdgpu device attr\n");
+		drm_err(adev_to_drm(adev), "Could not create amdgpu device attr\n");
 
 	r = devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
 	if (r)
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Could not create amdgpu board attributes\n");
 
 	amdgpu_fru_sysfs_init(adev);
@@ -4657,7 +4657,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
 	if (r)
-		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
+		drm_err(adev_to_drm(adev), "amdgpu_pmu_init failed\n");
 
 	/* Have stored pci confspace at hand for restore in sudden PCI error */
 	if (amdgpu_device_cache_pci_state(adev->pdev))
@@ -4701,7 +4701,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		!amdgpu_sriov_runtime(adev) &&
 		amdgpu_virt_mmio_blocked(adev) &&
 		!amdgpu_virt_wait_reset(adev)) {
-		dev_err(adev->dev, "VF exclusive mode timeout\n");
+		drm_err(adev_to_drm(adev), "VF exclusive mode timeout\n");
 		/* Don't send request since VF is inactive. */
 		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
 		adev->virt.ops = NULL;
@@ -4747,7 +4747,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
  */
 void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 {
-	dev_info(adev->dev, "amdgpu: finishing device.\n");
+	drm_info(adev_to_drm(adev), "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
 
 	if (adev->mman.initialized)
@@ -4887,7 +4887,7 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 
 	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
 	if (ret)
-		DRM_WARN("evicting device resources failed\n");
+		drm_warn(adev_to_drm(adev), "evicting device resources failed\n");
 	return ret;
 }
 
@@ -5001,7 +5001,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	}
 
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D3))
-		DRM_WARN("smart shift update failed\n");
+		drm_warn(dev, "smart shift update failed\n");
 
 	if (notify_clients)
 		drm_client_dev_suspend(adev_to_drm(adev), false);
@@ -5066,13 +5066,13 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (amdgpu_device_need_post(adev)) {
 		r = amdgpu_device_asic_init(adev);
 		if (r)
-			dev_err(adev->dev, "amdgpu asic init failed\n");
+			drm_err(dev, "amdgpu asic init failed\n");
 	}
 
 	r = amdgpu_device_ip_resume(adev);
 
 	if (r) {
-		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
+		drm_err(dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		goto exit;
 	}
 
@@ -5129,7 +5129,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	adev->in_suspend = false;
 
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
-		DRM_WARN("smart shift update failed\n");
+		drm_warn(dev, "smart shift update failed\n");
 
 	return 0;
 }
@@ -5163,7 +5163,8 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
 				adev->ip_blocks[i].version->funcs->check_soft_reset(
 					&adev->ip_blocks[i]);
 		if (adev->ip_blocks[i].status.hang) {
-			dev_info(adev->dev, "IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
+			drm_info(adev_to_drm(adev),
+				"IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
 			asic_hang = true;
 		}
 	}
@@ -5224,7 +5225,7 @@ static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) ||
 		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP) {
 			if (adev->ip_blocks[i].status.hang) {
-				dev_info(adev->dev, "Some block need full reset!\n");
+				drm_info(adev_to_drm(adev), "Some block need full reset!\n");
 				return true;
 			}
 		}
@@ -5446,7 +5447,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 	return true;
 
 disabled:
-		dev_info(adev->dev, "GPU recovery disabled.\n");
+		drm_info(adev_to_drm(adev), "GPU recovery disabled.\n");
 		return false;
 }
 
@@ -5458,7 +5459,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	if (adev->bios)
 		amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
+	drm_info(adev_to_drm(adev), "GPU mode1 reset\n");
 
 	/* Cache the state before bus master disable. The saved config space
 	 * values are used in other cases like restore after mode-2 reset.
@@ -5469,10 +5470,10 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	pci_clear_master(adev->pdev);
 
 	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
-		dev_info(adev->dev, "GPU smu mode1 reset\n");
+		drm_info(adev_to_drm(adev), "GPU smu mode1 reset\n");
 		ret = amdgpu_dpm_mode1_reset(adev);
 	} else {
-		dev_info(adev->dev, "GPU psp mode1 reset\n");
+		drm_info(adev_to_drm(adev), "GPU psp mode1 reset\n");
 		ret = psp_gpu_reset(adev);
 	}
 
@@ -5504,7 +5505,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	return 0;
 
 mode1_reset_failed:
-	dev_err(adev->dev, "GPU mode1 reset failed\n");
+	drm_err(adev_to_drm(adev), "GPU mode1 reset failed\n");
 	return ret;
 }
 
@@ -5512,7 +5513,7 @@ int amdgpu_device_link_reset(struct amdgpu_device *adev)
 {
 	int ret = 0;
 
-	dev_info(adev->dev, "GPU link reset\n");
+	drm_info(adev_to_drm(adev), "GPU link reset\n");
 
 	if (!adev->pcie_reset_ctx.occurs_dpc)
 		ret = amdgpu_dpm_link_reset(adev);
@@ -5527,7 +5528,7 @@ int amdgpu_device_link_reset(struct amdgpu_device *adev)
 	return 0;
 
 link_reset_failed:
-	dev_err(adev->dev, "GPU link reset failed\n");
+	drm_err(adev_to_drm(adev), "GPU link reset failed\n");
 	return ret;
 }
 
@@ -5588,7 +5589,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			r = amdgpu_device_ip_soft_reset(adev);
 			amdgpu_device_ip_post_soft_reset(adev);
 			if (r || amdgpu_device_ip_check_soft_reset(adev)) {
-				dev_info(adev->dev, "soft reset failed, will fallback to full reset!\n");
+				drm_info(adev_to_drm(adev), "soft reset failed, will fallback to full reset!\n");
 				need_full_reset = true;
 			}
 		}
@@ -5660,7 +5661,7 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 					amdgpu_coredump(tmp_adev, false, vram_lost, reset_context->job);
 
 				if (vram_lost) {
-					DRM_INFO("VRAM is lost due to GPU reset!\n");
+					drm_info(adev_to_drm(tmp_adev), "VRAM is lost due to GPU reset!\n");
 					amdgpu_inc_vram_lost(tmp_adev);
 				}
 
@@ -5737,7 +5738,7 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 			amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
 			r = amdgpu_ib_ring_tests(tmp_adev);
 			if (r) {
-				dev_err(tmp_adev->dev, "ib ring test failed (%d).\n", r);
+				drm_err(adev_to_drm(tmp_adev), "ib ring test failed (%d).\n", r);
 				r = -EAGAIN;
 				goto end;
 			}
@@ -5790,7 +5791,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				r = amdgpu_asic_reset(tmp_adev);
 
 			if (r) {
-				dev_err(tmp_adev->dev,
+				drm_err(adev_to_drm(tmp_adev),
 					"ASIC reset failed with error, %d for drm dev, %s",
 					r, adev_to_drm(tmp_adev)->unique);
 				goto out;
@@ -5902,7 +5903,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 			break;
 
 		if (expires < ktime_get_mono_fast_ns()) {
-			dev_warn(adev->dev, "failed to suspend display audio\n");
+			drm_warn(adev_to_drm(adev), "failed to suspend display audio\n");
 			pci_dev_put(p);
 			/* TODO: abort the succeeding gpu reset? */
 			return -ETIMEDOUT;
@@ -6234,13 +6235,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 */
 	if (need_emergency_restart && amdgpu_ras_get_context(adev) &&
 		amdgpu_ras_get_context(adev)->reboot) {
-		DRM_WARN("Emergency reboot.");
+		drm_warn(adev_to_drm(adev), "Emergency reboot.");
 
 		ksys_sync_helper();
 		emergency_restart();
 	}
 
-	dev_info(adev->dev, "GPU %s begin!\n",
+	drm_info(adev_to_drm(adev), "GPU %s begin!\n",
 		need_emergency_restart ? "jobs stop":"reset");
 
 	if (!amdgpu_sriov_vf(adev))
@@ -6267,7 +6268,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 */
 	if (job && dma_fence_is_signaled(&job->hw_fence)) {
 		job_signaled = true;
-		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
+		drm_info(adev_to_drm(adev), "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
 	}
 
@@ -6287,7 +6288,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	if (r)
-		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
+		drm_info(adev_to_drm(adev), "GPU reset end with ret = %d\n", r);
 
 	atomic_set(&adev->reset_domain->reset_res, r);
 	return r;
@@ -6585,7 +6586,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 		!adev->gmc.xgmi.connected_to_cpu &&
 		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
 	if (!p2p_access)
-		dev_info(adev->dev, "PCIe P2P access from peer device %s is not supported by the chipset\n",
+		drm_info(adev_to_drm(adev), "PCIe P2P access from peer device %s is not supported by the chipset\n",
 			pci_name(peer_adev->pdev));
 
 	bool is_large_bar = adev->gmc.visible_vram_size &&
@@ -6664,7 +6665,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 	struct list_head device_list;
 	int r = 0;
 
-	dev_info(adev->dev, "PCI error: detected callback!!\n");
+	drm_info(adev_to_drm(adev), "PCI error: detected callback!!\n");
 
 	if (!amdgpu_dpm_is_link_reset_supported(adev)) {
 		dev_warn(adev->dev, "No support for XGMI hive yet...\n");
@@ -6675,11 +6676,11 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 	switch (state) {
 	case pci_channel_io_normal:
-		dev_info(adev->dev, "pci_channel_io_normal: state(%d)!!\n", state);
+		drm_info(adev_to_drm(adev), "pci_channel_io_normal: state(%d)!!\n", state);
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	case pci_channel_io_frozen:
 		/* Fatal error, prepare for slot reset */
-		dev_info(adev->dev, "pci_channel_io_frozen: state(%d)!!\n", state);
+		drm_info(adev_to_drm(adev), "pci_channel_io_frozen: state(%d)!!\n", state);
 
 		if (hive)
 			mutex_lock(&hive->hive_lock);
@@ -6698,7 +6699,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		/* Permanent error, prepare for device removal */
-		dev_info(adev->dev, "pci_channel_io_perm_failure: state(%d)!!\n", state);
+		drm_info(adev_to_drm(adev), "pci_channel_io_perm_failure: state(%d)!!\n", state);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
@@ -6714,7 +6715,7 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	dev_info(adev->dev, "PCI error: mmio enabled callback!!\n");
+	drm_info(adev_to_drm(adev), "PCI error: mmio enabled callback!!\n");
 
 	/* TODO - dump whatever for debugging purposes */
 
@@ -6751,7 +6752,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	    amdgpu_ras_in_recovery(adev))
 		return PCI_ERS_RESULT_RECOVERED;
 
-	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
+	drm_info(adev_to_drm(adev), "PCI error: slot reset callback!!\n");
 
 	memset(&reset_context, 0, sizeof(reset_context));
 
@@ -6798,9 +6799,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	if (!r) {
 		if (amdgpu_device_cache_pci_state(adev->pdev))
 			pci_restore_state(adev->pdev);
-		dev_info(adev->dev, "PCIe error recovery succeeded\n");
+		drm_info(adev_to_drm(adev), "PCIe error recovery succeeded\n");
 	} else {
-		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
+		drm_err(adev_to_drm(adev), "PCIe error recovery failed, err:%d\n", r);
 		if (tmp_adev) {
 			list_for_each_entry(tmp_adev, &device_list, reset_list)
 				amdgpu_device_unset_mp1_state(tmp_adev);
@@ -6831,7 +6832,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 	struct amdgpu_hive_info *hive = NULL;
 	struct amdgpu_device *tmp_adev = NULL;
 
-	dev_info(adev->dev, "PCI error: resume callback!!\n");
+	drm_info(adev_to_drm(adev), "PCI error: resume callback!!\n");
 
 	/* Only continue execution for the case of pci_channel_io_frozen */
 	if (adev->pci_channel_state != pci_channel_io_frozen)
@@ -6875,11 +6876,11 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
 		adev->pci_state = pci_store_saved_state(pdev);
 
 		if (!adev->pci_state) {
-			DRM_ERROR("Failed to store PCI saved state");
+			drm_err(adev_to_drm(adev), "Failed to store PCI saved state");
 			return false;
 		}
 	} else {
-		DRM_WARN("Failed to save PCI state, err:%d\n", r);
+		drm_warn(adev_to_drm(adev), "Failed to save PCI state, err:%d\n", r);
 		return false;
 	}
 
@@ -6900,7 +6901,7 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
 	if (!r) {
 		pci_restore_state(pdev);
 	} else {
-		DRM_WARN("Failed to load PCI state, err:%d\n", r);
+		drm_warn(adev_to_drm(adev), "Failed to load PCI state, err:%d\n", r);
 		return false;
 	}
 
@@ -7214,7 +7215,7 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
 		tmp_ = RREG32(reg_addr);
 		loop--;
 		if (!loop) {
-			DRM_WARN("Register(%d) [%s] failed to reach value 0x%08x != 0x%08xn",
+			drm_warn(adev_to_drm(adev), "Register(%d) [%s] failed to reach value 0x%08x != 0x%08xn",
 				  inst, reg_name, (uint32_t)expected_value,
 				  (uint32_t)(tmp_ & (mask)));
 			ret = -ETIMEDOUT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index dc2713ec95a5b..32c90211d28d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -311,7 +311,7 @@ static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
 
 	r = request_firmware(&fw, fw_name, adev->dev);
 	if (r) {
-		dev_err(adev->dev, "can't load firmware \"%s\"\n",
+		drm_err(adev_to_drm(adev), "can't load firmware \"%s\"\n",
 			fw_name);
 		return r;
 	}
@@ -447,11 +447,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	/* Read from file if it is the preferred option */
 	fw_name = amdgpu_discovery_get_fw_name(adev);
 	if (fw_name != NULL) {
-		dev_info(adev->dev, "use ip discovery information from file");
+		drm_info(adev_to_drm(adev), "use ip discovery information from file");
 		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
 
 		if (r) {
-			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
+			drm_err(adev_to_drm(adev), "failed to read ip discovery binary from file\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -465,7 +465,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	/* check the ip discovery binary signature */
 	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"get invalid ip discovery binary signature\n");
 		r = -EINVAL;
 		goto out;
@@ -480,7 +480,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 					      size, checksum)) {
-		dev_err(adev->dev, "invalid ip discovery binary checksum\n");
+		drm_err(adev_to_drm(adev), "invalid ip discovery binary checksum\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -493,14 +493,14 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		struct ip_discovery_header *ihdr =
 			(struct ip_discovery_header *)(adev->mman.discovery_bin + offset);
 		if (le32_to_cpu(ihdr->signature) != DISCOVERY_TABLE_SIGNATURE) {
-			dev_err(adev->dev, "invalid ip discovery data table signature\n");
+			drm_err(adev_to_drm(adev), "invalid ip discovery data table signature\n");
 			r = -EINVAL;
 			goto out;
 		}
 
 		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 						      le16_to_cpu(ihdr->size), checksum)) {
-			dev_err(adev->dev, "invalid ip discovery data table checksum\n");
+			drm_err(adev_to_drm(adev), "invalid ip discovery data table checksum\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -515,14 +515,14 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			(struct gpu_info_header *)(adev->mman.discovery_bin + offset);
 
 		if (le32_to_cpu(ghdr->table_id) != GC_TABLE_ID) {
-			dev_err(adev->dev, "invalid ip discovery gc table id\n");
+			drm_err(adev_to_drm(adev), "invalid ip discovery gc table id\n");
 			r = -EINVAL;
 			goto out;
 		}
 
 		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 						      le32_to_cpu(ghdr->size), checksum)) {
-			dev_err(adev->dev, "invalid gc data table checksum\n");
+			drm_err(adev_to_drm(adev), "invalid gc data table checksum\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -537,14 +537,14 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			(struct harvest_info_header *)(adev->mman.discovery_bin + offset);
 
 		if (le32_to_cpu(hhdr->signature) != HARVEST_TABLE_SIGNATURE) {
-			dev_err(adev->dev, "invalid ip discovery harvest table signature\n");
+			drm_err(adev_to_drm(adev), "invalid ip discovery harvest table signature\n");
 			r = -EINVAL;
 			goto out;
 		}
 
 		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 						      sizeof(struct harvest_table), checksum)) {
-			dev_err(adev->dev, "invalid harvest data table checksum\n");
+			drm_err(adev_to_drm(adev), "invalid harvest data table checksum\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -559,14 +559,14 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			(struct vcn_info_header *)(adev->mman.discovery_bin + offset);
 
 		if (le32_to_cpu(vhdr->table_id) != VCN_INFO_TABLE_ID) {
-			dev_err(adev->dev, "invalid ip discovery vcn table id\n");
+			drm_err(adev_to_drm(adev), "invalid ip discovery vcn table id\n");
 			r = -EINVAL;
 			goto out;
 		}
 
 		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 						      le32_to_cpu(vhdr->size_bytes), checksum)) {
-			dev_err(adev->dev, "invalid vcn data table checksum\n");
+			drm_err(adev_to_drm(adev), "invalid vcn data table checksum\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -581,14 +581,14 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 			(struct mall_info_header *)(adev->mman.discovery_bin + offset);
 
 		if (le32_to_cpu(mhdr->table_id) != MALL_INFO_TABLE_ID) {
-			dev_err(adev->dev, "invalid ip discovery mall table id\n");
+			drm_err(adev_to_drm(adev), "invalid ip discovery mall table id\n");
 			r = -EINVAL;
 			goto out;
 		}
 
 		if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + offset,
 						      le32_to_cpu(mhdr->size_bytes), checksum)) {
-			dev_err(adev->dev, "invalid mall data table checksum\n");
+			drm_err(adev_to_drm(adev), "invalid mall data table checksum\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -618,13 +618,13 @@ static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
 					uint8_t instance, uint16_t hw_id)
 {
 	if (instance >= HWIP_MAX_INSTANCE) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Unexpected instance_number (%d) from ip discovery blob\n",
 			instance);
 		return -EINVAL;
 	}
 	if (hw_id >= HW_ID_MAX) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Unexpected hw_id (%d) from ip discovery blob\n",
 			hw_id);
 		return -EINVAL;
@@ -711,7 +711,7 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 	offset = le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset);
 
 	if (!offset) {
-		dev_err(adev->dev, "invalid harvest table offset\n");
+		drm_err(adev_to_drm(adev), "invalid harvest table offset\n");
 		return;
 	}
 
@@ -1090,7 +1090,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 				ip_hw_id->hw_id_kset.kobj.ktype = &ip_hw_id_ktype;
 				res = kset_register(&ip_hw_id->hw_id_kset);
 				if (res) {
-					DRM_ERROR("Couldn't register ip_hw_id kset");
+					drm_err(adev_to_drm(adev), "Couldn't register ip_hw_id kset");
 					kfree(ip_hw_id);
 					return res;
 				}
@@ -1099,7 +1099,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 								&ip_hw_id->hw_id_kset.kobj,
 								hw_id_names[ii]);
 					if (res) {
-						DRM_ERROR("Couldn't create IP link %s in IP Die:%s\n",
+						drm_err(adev_to_drm(adev), "Couldn't create IP link %s in IP Die:%s\n",
 							  hw_id_names[ii],
 							  kobject_name(&ip_die_entry->ip_kset.kobj));
 					}
@@ -1113,7 +1113,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 							     ip->num_base_address),
 						 GFP_KERNEL);
 			if (!ip_hw_instance) {
-				DRM_ERROR("no memory for ip_hw_instance");
+				drm_err(adev_to_drm(adev), "no memory for ip_hw_instance");
 				return -ENOMEM;
 			}
 			ip_hw_instance->hw_id = le16_to_cpu(ip->hw_id); /* == ii */
@@ -1194,7 +1194,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 		ip_die_entry->ip_kset.kobj.ktype = &ip_die_entry_ktype;
 		res = kset_register(&ip_die_entry->ip_kset);
 		if (res) {
-			DRM_ERROR("Couldn't register ip_die_entry kset");
+			drm_err(adev_to_drm(adev), "Couldn't register ip_die_entry kset");
 			kfree(ip_die_entry);
 			return res;
 		}
@@ -1222,7 +1222,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 	res = kobject_init_and_add(&adev->ip_top->kobj, &ip_discovery_ktype,
 				   &adev->dev->kobj, "ip_discovery");
 	if (res) {
-		DRM_ERROR("Couldn't init and add ip_discovery/");
+		drm_err(adev_to_drm(adev), "Couldn't init and add ip_discovery/");
 		goto Err;
 	}
 
@@ -1232,7 +1232,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 	die_kset->kobj.ktype = &die_kobj_ktype;
 	res = kset_register(&adev->ip_top->die_kset);
 	if (res) {
-		DRM_ERROR("Couldn't register die_kset");
+		drm_err(adev_to_drm(adev), "Couldn't register die_kset");
 		goto Err;
 	}
 
@@ -1327,7 +1327,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 	r = amdgpu_discovery_init(adev);
 	if (r) {
-		DRM_ERROR("amdgpu_discovery_init failed\n");
+		drm_err(adev_to_drm(adev), "amdgpu_discovery_init failed\n");
 		return r;
 	}
 
@@ -1350,7 +1350,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		ip_offset = die_offset + sizeof(*dhdr);
 
 		if (le16_to_cpu(dhdr->die_id) != i) {
-			DRM_ERROR("invalid die id %d, expected %d\n",
+			drm_err(adev_to_drm(adev), "invalid die id %d, expected %d\n",
 					le16_to_cpu(dhdr->die_id), i);
 			return -EINVAL;
 		}
@@ -1392,7 +1392,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 					adev->jpeg.inst_mask |=
 						(1U << ip->instance_number);
 				} else {
-					dev_err(adev->dev, "Too many VCN instances: %d vs %d\n",
+					drm_err(adev_to_drm(adev), "Too many VCN instances: %d vs %d\n",
 						adev->vcn.num_vcn_inst + 1,
 						AMDGPU_MAX_VCN_INSTANCES);
 				}
@@ -1408,7 +1408,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 					adev->sdma.sdma_mask |=
 						(1U << ip->instance_number);
 				} else {
-					dev_err(adev->dev, "Too many SDMA instances: %d vs %d\n",
+					drm_err(adev_to_drm(adev), "Too many SDMA instances: %d vs %d\n",
 						adev->sdma.num_instances + 1,
 						AMDGPU_MAX_SDMA_INSTANCES);
 				}
@@ -1418,7 +1418,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				if (adev->vpe.num_instances < AMDGPU_MAX_VPE_INSTANCES)
 					adev->vpe.num_instances++;
 				else
-					dev_err(adev->dev, "Too many VPE instances: %d vs %d\n",
+					drm_err(adev_to_drm(adev), "Too many VPE instances: %d vs %d\n",
 						adev->vpe.num_instances + 1,
 						AMDGPU_MAX_VPE_INSTANCES);
 			}
@@ -1570,7 +1570,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	u16 offset;
 
 	if (!adev->mman.discovery_bin) {
-		DRM_ERROR("ip discovery uninitialized\n");
+		drm_err(adev_to_drm(adev), "ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
@@ -1657,7 +1657,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 		}
 		break;
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Unhandled GC info table %d.%d\n",
 			le16_to_cpu(gc_info->v1.header.version_major),
 			le16_to_cpu(gc_info->v1.header.version_minor));
@@ -1680,7 +1680,7 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 	u16 offset;
 
 	if (!adev->mman.discovery_bin) {
-		DRM_ERROR("ip discovery uninitialized\n");
+		drm_err(adev_to_drm(adev), "ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
@@ -1714,7 +1714,7 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 		adev->gmc.mall_size = (uint64_t)mall_size_per_umc * adev->gmc.num_umc;
 		break;
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Unhandled MALL info table %d.%d\n",
 			le16_to_cpu(mall_info->v1.header.version_major),
 			le16_to_cpu(mall_info->v1.header.version_minor));
@@ -1735,7 +1735,7 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 	int v;
 
 	if (!adev->mman.discovery_bin) {
-		DRM_ERROR("ip discovery uninitialized\n");
+		drm_err(adev_to_drm(adev), "ip discovery uninitialized\n");
 		return -EINVAL;
 	}
 
@@ -1745,7 +1745,7 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 	 * check for defensive purposes.
 	 */
 	if (adev->vcn.num_vcn_inst > VCN_INFO_TABLE_MAX_NUM_INSTANCES) {
-		dev_err(adev->dev, "invalid vcn instances\n");
+		drm_err(adev_to_drm(adev), "invalid vcn instances\n");
 		return -EINVAL;
 	}
 
@@ -1768,7 +1768,7 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 		}
 		break;
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Unhandled VCN info table %d.%d\n",
 			le16_to_cpu(vcn_info->v1.header.version_major),
 			le16_to_cpu(vcn_info->v1.header.version_minor));
@@ -1803,7 +1803,7 @@ static int amdgpu_discovery_refresh_nps_info(struct amdgpu_device *adev,
 	if (!amdgpu_discovery_verify_checksum((uint8_t *)nps_data,
 					      le32_to_cpu(nhdr->size_bytes),
 					      checksum)) {
-		dev_err(adev->dev, "nps data refresh, checksum mismatch\n");
+		drm_err(adev_to_drm(adev), "nps data refresh, checksum mismatch\n");
 		return -EINVAL;
 	}
 
@@ -1832,7 +1832,7 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 		nps_info = &nps_data;
 	} else {
 		if (!adev->mman.discovery_bin) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"fetch mem range failed, ip discovery uninitialized\n");
 			return -EINVAL;
 		}
@@ -1871,7 +1871,7 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 		*ranges = mem_ranges;
 		break;
 	default:
-		dev_err(adev->dev, "Unhandled NPS info table %d.%d\n",
+		drm_err(adev_to_drm(adev), "Unhandled NPS info table %d.%d\n",
 			le16_to_cpu(nps_info->v1.header.version_major),
 			le16_to_cpu(nps_info->v1.header.version_minor));
 		return -EINVAL;
@@ -1928,7 +1928,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &soc24_common_ip_block);
 		break;
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Failed to add common ip block(GC_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, GC_HWIP, 0));
 		return -EINVAL;
@@ -1984,7 +1984,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v12_0_ip_block);
 		break;
 	default:
-		dev_err(adev->dev, "Failed to add gmc ip block(GC_HWIP:0x%x)\n",
+		drm_err(adev_to_drm(adev), "Failed to add gmc ip block(GC_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, GC_HWIP, 0));
 		return -EINVAL;
 	}
@@ -2028,7 +2028,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &ih_v7_0_ip_block);
 		break;
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, OSSSYS_HWIP, 0));
 		return -EINVAL;
@@ -2092,7 +2092,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &psp_v14_0_ip_block);
 		break;
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Failed to add psp ip block(MP0_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, MP0_HWIP, 0));
 		return -EINVAL;
@@ -2152,7 +2152,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Failed to add smu ip block(MP1_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, MP1_HWIP, 0));
 		return -EINVAL;
@@ -2212,7 +2212,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
 				amdgpu_ip_version(adev, DCE_HWIP, 0));
 			return -EINVAL;
@@ -2228,7 +2228,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
 				amdgpu_ip_version(adev, DCI_HWIP, 0));
 			return -EINVAL;
@@ -2287,7 +2287,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v12_0_ip_block);
 		break;
 	default:
-		dev_err(adev->dev, "Failed to add gfx ip block(GC_HWIP:0x%x)\n",
+		drm_err(adev_to_drm(adev), "Failed to add gfx ip block(GC_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, GC_HWIP, 0));
 		return -EINVAL;
 	}
@@ -2343,7 +2343,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v7_0_ip_block);
 		break;
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, SDMA0_HWIP, 0));
 		return -EINVAL;
@@ -2362,7 +2362,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 				amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
 			break;
 		default:
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Failed to add uvd v7 ip block(UVD_HWIP:0x%x)\n",
 				amdgpu_ip_version(adev, UVD_HWIP, 0));
 			return -EINVAL;
@@ -2375,7 +2375,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 				amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
 			break;
 		default:
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Failed to add VCE v4 ip block(VCE_HWIP:0x%x)\n",
 				amdgpu_ip_version(adev, VCE_HWIP, 0));
 			return -EINVAL;
@@ -2439,7 +2439,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &jpeg_v5_0_1_ip_block);
 			break;
 		default:
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
 				amdgpu_ip_version(adev, UVD_HWIP, 0));
 			return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 35c778426a7c7..0f74b79cad824 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -181,7 +181,7 @@ static void amdgpu_display_unpin_work_func(struct work_struct *__work)
 		amdgpu_bo_unpin(work->old_abo);
 		amdgpu_bo_unreserve(work->old_abo);
 	} else
-		DRM_ERROR("failed to reserve buffer after flip\n");
+		drm_err(adev_to_drm(work->adev), "failed to reserve buffer after flip\n");
 
 	amdgpu_bo_unref(&work->old_abo);
 	kfree(work->shared);
@@ -229,7 +229,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 	/* pin the new buffer */
 	r = amdgpu_bo_reserve(new_abo, false);
 	if (unlikely(r != 0)) {
-		DRM_ERROR("failed to reserve new abo buffer before flip\n");
+		drm_err(adev_to_drm(adev), "failed to reserve new abo buffer before flip\n");
 		goto cleanup;
 	}
 
@@ -238,14 +238,14 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 		r = amdgpu_bo_pin(new_abo,
 				  amdgpu_display_supported_domains(adev, new_abo->flags));
 		if (unlikely(r != 0)) {
-			DRM_ERROR("failed to pin new abo buffer before flip\n");
+			drm_err(adev_to_drm(adev), "failed to pin new abo buffer before flip\n");
 			goto unreserve;
 		}
 	}
 
 	r = amdgpu_ttm_alloc_gart(&new_abo->tbo);
 	if (unlikely(r != 0)) {
-		DRM_ERROR("%p bind failed\n", new_abo);
+		drm_err(adev_to_drm(adev), "%p bind failed\n", new_abo);
 		goto unpin;
 	}
 
@@ -253,7 +253,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 				&work->shared_count,
 				&work->shared);
 	if (unlikely(r != 0)) {
-		DRM_ERROR("failed to get fences for buffer\n");
+		drm_err(adev_to_drm(adev), "failed to get fences for buffer\n");
 		goto unpin;
 	}
 
@@ -288,7 +288,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 
 pflip_cleanup:
 	if (unlikely(amdgpu_bo_reserve(new_abo, false) != 0)) {
-		DRM_ERROR("failed to reserve new abo in error path\n");
+		drm_err(adev_to_drm(adev), "failed to reserve new abo in error path\n");
 		goto cleanup;
 	}
 unpin:
@@ -417,15 +417,15 @@ void amdgpu_display_print_display_setup(struct drm_device *dev)
 	int i = 0;
 
 	drm_connector_list_iter_begin(dev, &iter);
-	DRM_INFO("AMDGPU Display Connectors\n");
+	drm_info(dev, "AMDGPU Display Connectors\n");
 	drm_for_each_connector_iter(connector, &iter) {
 		amdgpu_connector = to_amdgpu_connector(connector);
-		DRM_INFO("Connector %d:\n", i);
-		DRM_INFO("  %s\n", connector->name);
+		drm_info(dev, "Connector %d:\n", i);
+		drm_info(dev, "  %s\n", connector->name);
 		if (amdgpu_connector->hpd.hpd != AMDGPU_HPD_NONE)
-			DRM_INFO("  %s\n", hpd_names[amdgpu_connector->hpd.hpd]);
+			drm_info(dev, "  %s\n", hpd_names[amdgpu_connector->hpd.hpd]);
 		if (amdgpu_connector->ddc_bus) {
-			DRM_INFO("  DDC: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+			drm_info(dev, "  DDC: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
 				 amdgpu_connector->ddc_bus->rec.mask_clk_reg,
 				 amdgpu_connector->ddc_bus->rec.mask_data_reg,
 				 amdgpu_connector->ddc_bus->rec.a_clk_reg,
@@ -435,11 +435,11 @@ void amdgpu_display_print_display_setup(struct drm_device *dev)
 				 amdgpu_connector->ddc_bus->rec.y_clk_reg,
 				 amdgpu_connector->ddc_bus->rec.y_data_reg);
 			if (amdgpu_connector->router.ddc_valid)
-				DRM_INFO("  DDC Router 0x%x/0x%x\n",
+				drm_info(dev, "  DDC Router 0x%x/0x%x\n",
 					 amdgpu_connector->router.ddc_mux_control_pin,
 					 amdgpu_connector->router.ddc_mux_state);
 			if (amdgpu_connector->router.cd_valid)
-				DRM_INFO("  Clock/Data Router 0x%x/0x%x\n",
+				drm_info(dev, "  Clock/Data Router 0x%x/0x%x\n",
 					 amdgpu_connector->router.cd_mux_control_pin,
 					 amdgpu_connector->router.cd_mux_state);
 		} else {
@@ -449,35 +449,57 @@ void amdgpu_display_print_display_setup(struct drm_device *dev)
 			    connector->connector_type == DRM_MODE_CONNECTOR_DVIA ||
 			    connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
 			    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB)
-				DRM_INFO("  DDC: no ddc bus - possible BIOS bug - please report to xorg-driver-ati@lists.x.org\n");
+				drm_info(dev, "  DDC: no ddc bus - possible BIOS bug - please report to xorg-driver-ati@lists.x.org\n");
 		}
-		DRM_INFO("  Encoders:\n");
+		drm_info(dev, "  Encoders:\n");
 		list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
 			amdgpu_encoder = to_amdgpu_encoder(encoder);
 			devices = amdgpu_encoder->devices & amdgpu_connector->devices;
 			if (devices) {
 				if (devices & ATOM_DEVICE_CRT1_SUPPORT)
-					DRM_INFO("    CRT1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    CRT1: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_CRT2_SUPPORT)
-					DRM_INFO("    CRT2: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    CRT2: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_LCD1_SUPPORT)
-					DRM_INFO("    LCD1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    LCD1: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP1_SUPPORT)
-					DRM_INFO("    DFP1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    DFP1: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP2_SUPPORT)
-					DRM_INFO("    DFP2: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    DFP2: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP3_SUPPORT)
-					DRM_INFO("    DFP3: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    DFP3: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP4_SUPPORT)
-					DRM_INFO("    DFP4: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    DFP4: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP5_SUPPORT)
-					DRM_INFO("    DFP5: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    DFP5: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP6_SUPPORT)
-					DRM_INFO("    DFP6: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    DFP6: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_TV1_SUPPORT)
-					DRM_INFO("    TV1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    TV1: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_CV_SUPPORT)
-					DRM_INFO("    CV: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev,
+						"    CV: %s\n",
+						encoder_names[amdgpu_encoder->encoder_id]);
 			}
 		}
 		i++;
@@ -694,7 +716,7 @@ extract_render_dcc_offset(struct amdgpu_device *adev,
 	if (unlikely(r)) {
 		/* Don't show error message when returning -ERESTARTSYS */
 		if (r != -ERESTARTSYS)
-			DRM_ERROR("Unable to reserve buffer: %d\n", r);
+			drm_err(adev_to_drm(adev), "Unable to reserve buffer: %d\n", r);
 		return r;
 	}
 
@@ -827,7 +849,7 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 
 		if (has_xor) {
 			if (num_pipes == num_pkrs && num_pkrs == 0) {
-				DRM_ERROR("invalid number of pipes and packers\n");
+				drm_err(adev_to_drm(adev), "invalid number of pipes and packers\n");
 				return -EINVAL;
 			}
 
@@ -1764,7 +1786,8 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
 				aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 				if (r != 0)
-					dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
+					drm_err(adev_to_drm(adev),
+						"Failed to pin cursor BO (%d)\n", r);
 				amdgpu_crtc->cursor_addr = amdgpu_bo_gpu_offset(aobj);
 				amdgpu_bo_unreserve(aobj);
 			}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 8e81a83d37d84..023dc773b7de7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -351,7 +351,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 
 	r = ttm_bo_validate(&bo->tbo, &placement, &ctx);
 	if (r) {
-		DRM_ERROR("Failed to invalidate DMA-buf import (%d))\n", r);
+		drm_err(adev_to_drm(adev), "Failed to invalidate DMA-buf import (%d))\n", r);
 		return;
 	}
 
@@ -385,7 +385,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 			r = amdgpu_vm_handle_moved(adev, vm, ticket);
 
 		if (r && r != -EBUSY)
-			DRM_ERROR("Failed to invalidate VM page tables (%d))\n",
+			drm_err(adev_to_drm(adev), "Failed to invalidate VM page tables (%d))\n",
 				  r);
 
 		dma_resv_unlock(resv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 3f3662e8b8710..ce0bb9f9148af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -41,7 +41,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 	if (index < adev->doorbell.num_kernel_doorbells)
 		return readl(adev->doorbell.cpu_addr + index);
 
-	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
+	drm_err(adev_to_drm(adev), "reading beyond doorbell aperture: 0x%08x!\n", index);
 	return 0;
 }
 
@@ -63,7 +63,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 	if (index < adev->doorbell.num_kernel_doorbells)
 		writel(v, adev->doorbell.cpu_addr + index);
 	else
-		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
+		drm_err(adev_to_drm(adev), "writing beyond doorbell aperture: 0x%08x!\n", index);
 }
 
 /**
@@ -83,7 +83,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 	if (index < adev->doorbell.num_kernel_doorbells)
 		return atomic64_read((atomic64_t *)(adev->doorbell.cpu_addr + index));
 
-	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
+	drm_err(adev_to_drm(adev), "reading beyond doorbell aperture: 0x%08x!\n", index);
 	return 0;
 }
 
@@ -105,7 +105,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 	if (index < adev->doorbell.num_kernel_doorbells)
 		atomic64_set((atomic64_t *)(adev->doorbell.cpu_addr + index), v);
 	else
-		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
+		drm_err(adev_to_drm(adev), "writing beyond doorbell aperture: 0x%08x!\n", index);
 }
 
 /**
@@ -166,7 +166,7 @@ int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
 				    NULL,
 				    (void **)&adev->doorbell.cpu_addr);
 	if (r) {
-		DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
+		drm_err(adev_to_drm(adev), "Failed to allocate kernel doorbells, err=%d\n", r);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9d82d0f003eb7..dd9ed44d9d46b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2220,32 +2220,32 @@ static void amdgpu_get_secondary_funcs(struct amdgpu_device *adev)
 static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 {
 	if (amdgpu_debug_mask & AMDGPU_DEBUG_VM) {
-		pr_info("debug: VM handling debug enabled\n");
+		drm_info(adev_to_drm(adev), "debug: VM handling debug enabled\n");
 		adev->debug_vm = true;
 	}
 
 	if (amdgpu_debug_mask & AMDGPU_DEBUG_LARGEBAR) {
-		pr_info("debug: enabled simulating large-bar capability on non-large bar system\n");
+		drm_info(adev_to_drm(adev), "debug: enabled simulating large-bar capability on non-large bar system\n");
 		adev->debug_largebar = true;
 	}
 
 	if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY) {
-		pr_info("debug: soft reset for GPU recovery disabled\n");
+		drm_info(adev_to_drm(adev), "debug: soft reset for GPU recovery disabled\n");
 		adev->debug_disable_soft_recovery = true;
 	}
 
 	if (amdgpu_debug_mask & AMDGPU_DEBUG_USE_VRAM_FW_BUF) {
-		pr_info("debug: place fw in vram for frontdoor loading\n");
+		drm_info(adev_to_drm(adev), "debug: place fw in vram for frontdoor loading\n");
 		adev->debug_use_vram_fw_buf = true;
 	}
 
 	if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_RAS_ACA) {
-		pr_info("debug: enable RAS ACA\n");
+		drm_info(adev_to_drm(adev), "debug: enable RAS ACA\n");
 		adev->debug_enable_ras_aca = true;
 	}
 
 	if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_EXP_RESETS) {
-		pr_info("debug: enable experimental reset features\n");
+		drm_info(adev_to_drm(adev), "debug: enable experimental reset features\n");
 		adev->debug_exp_resets = true;
 	}
 
@@ -2304,7 +2304,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		supports_atomic = true;
 
 	if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
-		DRM_INFO("This hardware requires experimental hardware support.\n"
+		dev_info(&pdev->dev,
+			"This hardware requires experimental hardware support.\n"
 			 "See modparam exp_hw_support\n");
 		return -ENODEV;
 	}
@@ -2391,7 +2392,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 retry_init:
 	ret = drm_dev_register(ddev, flags);
 	if (ret == -EAGAIN && ++retry <= 3) {
-		DRM_INFO("retry init %d\n", retry);
+		dev_info(&pdev->dev, "retry init %d\n", retry);
 		/* Don't request EX mode too frequently which is attacking */
 		msleep(5000);
 		goto retry_init;
@@ -2426,7 +2427,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 	ret = amdgpu_debugfs_init(adev);
 	if (ret)
-		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
+		drm_err(ddev, "Creating debugfs files failed (%d).\n", ret);
 
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		/* only need to skip on ATPX */
@@ -2780,7 +2781,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
-	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
+	drm_dbg(drm_dev, "asic/device is runtime suspended\n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 1ae88c459da51..64a0faf62ad01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -152,19 +152,19 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, fru_addr, buf,
 				 sizeof(buf));
 	if (len != 8) {
-		DRM_ERROR("Couldn't read the IPMI Common Header: %d", len);
+		drm_err(adev_to_drm(adev), "Couldn't read the IPMI Common Header: %d", len);
 		return len < 0 ? len : -EIO;
 	}
 
 	if (buf[0] != 1) {
-		DRM_ERROR("Bad IPMI Common Header version: 0x%02x", buf[0]);
+		drm_err(adev_to_drm(adev), "Bad IPMI Common Header version: 0x%02x", buf[0]);
 		return -EIO;
 	}
 
 	for (csum = 0; len > 0; len--)
 		csum += buf[len - 1];
 	if (csum) {
-		DRM_ERROR("Bad IPMI Common Header checksum: 0x%02x", csum);
+		drm_err(adev_to_drm(adev), "Bad IPMI Common Header checksum: 0x%02x", csum);
 		return -EIO;
 	}
 
@@ -179,12 +179,12 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	/* Read the header of the PIA. */
 	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, buf, 3);
 	if (len != 3) {
-		DRM_ERROR("Couldn't read the Product Info Area header: %d", len);
+		drm_err(adev_to_drm(adev), "Couldn't read the Product Info Area header: %d", len);
 		return len < 0 ? len : -EIO;
 	}
 
 	if (buf[0] != 1) {
-		DRM_ERROR("Bad IPMI Product Info Area version: 0x%02x", buf[0]);
+		drm_err(adev_to_drm(adev), "Bad IPMI Product Info Area version: 0x%02x", buf[0]);
 		return -EIO;
 	}
 
@@ -197,14 +197,14 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia, size);
 	if (len != size) {
 		kfree(pia);
-		DRM_ERROR("Couldn't read the Product Info Area: %d", len);
+		drm_err(adev_to_drm(adev), "Couldn't read the Product Info Area: %d", len);
 		return len < 0 ? len : -EIO;
 	}
 
 	for (csum = 0; size > 0; size--)
 		csum += pia[size - 1];
 	if (csum) {
-		DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
+		drm_err(adev_to_drm(adev), "Bad Product Info Area checksum: 0x%02x", csum);
 		kfree(pia);
 		return -EIO;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
index 328a1b9635481..5d09c3f485c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
@@ -62,17 +62,17 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 	struct FW_ATT_RECORD fw_att_record = {0};
 
 	if (size < sizeof(struct FW_ATT_RECORD)) {
-		DRM_WARN("FW attestation input buffer not enough memory");
+		drm_warn(adev_to_drm(adev), "FW attestation input buffer not enough memory");
 		return -EINVAL;
 	}
 
 	if ((*pos + sizeof(struct FW_ATT_DB_HEADER)) >= FW_ATTESTATION_MAX_SIZE) {
-		DRM_WARN("FW attestation out of bounds");
+		drm_warn(adev_to_drm(adev), "FW attestation out of bounds");
 		return 0;
 	}
 
 	if (psp_get_fw_attestation_records_addr(&adev->psp, &records_addr)) {
-		DRM_WARN("Failed to get FW attestation record address");
+		drm_warn(adev_to_drm(adev), "Failed to get FW attestation record address");
 		return -EINVAL;
 	}
 
@@ -86,11 +86,12 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 					  false);
 
 		if (fw_att_hdr.AttDbCookie != FW_ATTESTATION_DB_COOKIE) {
-			DRM_WARN("Invalid FW attestation cookie");
+			drm_warn(adev_to_drm(adev), "Invalid FW attestation cookie");
 			return -EINVAL;
 		}
 
-		DRM_INFO("FW attestation version = 0x%X", fw_att_hdr.AttDbVersion);
+		drm_info(adev_to_drm(adev),
+			"FW attestation version = 0x%X", fw_att_hdr.AttDbVersion);
 	}
 
 	amdgpu_device_vram_access(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index b2033f8352f50..d27a6d64ed32e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -151,7 +151,7 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev)
 		return -EFAULT;
 	}
 
-	dev_info(adev->dev, "%s dma_addr:%pad\n", __func__, &dma_addr);
+	drm_info(adev_to_drm(adev), "%s dma_addr:%pad\n", __func__, &dma_addr);
 	/* Create SG table */
 	sg = kmalloc(sizeof(*sg), GFP_KERNEL);
 	if (!sg) {
@@ -187,7 +187,7 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device *adev)
 
 	ret = amdgpu_bo_reserve(bo, true);
 	if (ret) {
-		dev_err(adev->dev, "(%d) failed to reserve bo for GART system bo\n", ret);
+		drm_err(adev_to_drm(adev), "(%d) failed to reserve bo for GART system bo\n", ret);
 		goto error;
 	}
 
@@ -433,7 +433,7 @@ int amdgpu_gart_init(struct amdgpu_device *adev)
 
 	/* We need PAGE_SIZE >= AMDGPU_GPU_PAGE_SIZE */
 	if (PAGE_SIZE < AMDGPU_GPU_PAGE_SIZE) {
-		DRM_ERROR("Page size is smaller than GPU page size!\n");
+		drm_err(adev_to_drm(adev), "Page size is smaller than GPU page size!\n");
 		return -EINVAL;
 	}
 	r = amdgpu_gart_dummy_page_init(adev);
@@ -442,7 +442,7 @@ int amdgpu_gart_init(struct amdgpu_device *adev)
 	/* Compute table size */
 	adev->gart.num_cpu_pages = adev->gmc.gart_size / PAGE_SIZE;
 	adev->gart.num_gpu_pages = adev->gmc.gart_size / AMDGPU_GPU_PAGE_SIZE;
-	DRM_INFO("GART: num cpu pages %u, num gpu pages %u\n",
+	drm_info(adev_to_drm(adev), "GART: num cpu pages %u, num gpu pages %u\n",
 		 adev->gart.num_cpu_pages, adev->gart.num_gpu_pages);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index c1d8cee7894b2..dc85713985d66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -324,9 +324,9 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		if (r) {
 			struct amdgpu_task_info *ti = amdgpu_vm_get_task_info_vm(vm);
 
-			dev_warn(adev->dev, "validate_and_fence failed: %d\n", r);
+			drm_warn(adev_to_drm(adev), "validate_and_fence failed: %d\n", r);
 			if (ti) {
-				dev_warn(adev->dev, "pid %d\n", ti->pid);
+				drm_warn(adev_to_drm(adev), "pid %d\n", ti->pid);
 				amdgpu_vm_put_task_info(ti);
 			}
 		}
@@ -375,7 +375,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 
 	r = amdgpu_vm_clear_freed(adev, vm, &fence);
 	if (unlikely(r < 0))
-		dev_err(adev->dev, "failed to clear page "
+		drm_err(adev_to_drm(adev), "failed to clear page "
 			"tables on GEM object close (%ld)\n", r);
 	if (r || !fence)
 		goto out_unlock;
@@ -385,7 +385,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 
 out_unlock:
 	if (r)
-		dev_err(adev->dev, "leaking bo va (%ld)\n", r);
+		drm_err(adev_to_drm(adev), "leaking bo va (%ld)\n", r);
 	drm_exec_fini(&exec);
 }
 
@@ -469,7 +469,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 			/* if gds bo is created from user space, it must be
 			 * passed to bo list
 			 */
-			DRM_ERROR("GDS bo cannot be per-vm-bo\n");
+			drm_err(adev_to_drm(adev), "GDS bo cannot be per-vm-bo\n");
 			return -EINVAL;
 		}
 		flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0cf11e0fa2985..84eb79767c762 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -122,15 +122,15 @@ void amdgpu_gfx_parse_disable_cu(struct amdgpu_device *adev, unsigned int *mask,
 		int ret = sscanf(p, "%u.%u.%u", &se, &sh, &cu);
 
 		if (ret < 3) {
-			DRM_ERROR("amdgpu: could not parse disable_cu\n");
+			drm_err(adev_to_drm(adev), "amdgpu: could not parse disable_cu\n");
 			return;
 		}
 
 		if (se < max_se && sh < max_sh && cu < 16) {
-			DRM_INFO("amdgpu: disabling CU %u.%u.%u\n", se, sh, cu);
+			drm_info(adev_to_drm(adev), "amdgpu: disabling CU %u.%u.%u\n", se, sh, cu);
 			mask[se * max_sh + sh] |= 1u << cu;
 		} else {
-			DRM_ERROR("amdgpu: disable_cu %u.%u.%u is out of range\n",
+			drm_err(adev_to_drm(adev), "amdgpu: disable_cu %u.%u.%u is out of range\n",
 				  se, sh, cu);
 		}
 
@@ -149,7 +149,7 @@ static bool amdgpu_gfx_is_graphics_multipipe_capable(struct amdgpu_device *adev)
 static bool amdgpu_gfx_is_compute_multipipe_capable(struct amdgpu_device *adev)
 {
 	if (amdgpu_compute_multipipe != -1) {
-		DRM_INFO("amdgpu: forcing compute pipe policy %d\n",
+		drm_info(adev_to_drm(adev), "amdgpu: forcing compute pipe policy %d\n",
 			 amdgpu_compute_multipipe);
 		return amdgpu_compute_multipipe == 1;
 	}
@@ -295,7 +295,7 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
 		return 0;
 	}
 
-	dev_err(adev->dev, "Failed to find a queue for KIQ\n");
+	drm_err(adev_to_drm(adev), "Failed to find a queue for KIQ\n");
 	return -EINVAL;
 }
 
@@ -330,7 +330,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)
 	r = amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
 	if (r)
-		dev_warn(adev->dev, "(%d) failed to init kiq ring\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) failed to init kiq ring\n", r);
 
 	return r;
 }
@@ -358,7 +358,7 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 				    AMDGPU_GEM_DOMAIN_GTT, &kiq->eop_obj,
 				    &kiq->eop_gpu_addr, (void **)&hpd);
 	if (r) {
-		dev_warn(adev->dev, "failed to create KIQ bo (%d).\n", r);
+		drm_warn(adev_to_drm(adev), "failed to create KIQ bo (%d).\n", r);
 		return r;
 	}
 
@@ -366,7 +366,7 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 
 	r = amdgpu_bo_reserve(kiq->eop_obj, true);
 	if (unlikely(r != 0))
-		dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) reserve kiq eop bo failed\n", r);
 	amdgpu_bo_kunmap(kiq->eop_obj);
 	amdgpu_bo_unreserve(kiq->eop_obj);
 
@@ -402,14 +402,14 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 					    &ring->mqd_gpu_addr,
 					    &ring->mqd_ptr);
 		if (r) {
-			dev_warn(adev->dev, "failed to create ring mqd ob (%d)", r);
+			drm_warn(adev_to_drm(adev), "failed to create ring mqd ob (%d)", r);
 			return r;
 		}
 
 		/* prepare MQD backup */
 		kiq->mqd_backup = kzalloc(mqd_size, GFP_KERNEL);
 		if (!kiq->mqd_backup) {
-			dev_warn(adev->dev,
+			drm_warn(adev_to_drm(adev),
 				 "no memory to create MQD backup for ring %s\n", ring->name);
 			return -ENOMEM;
 		}
@@ -424,7 +424,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 							    domain, &ring->mqd_obj,
 							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 				if (r) {
-					dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
+					drm_warn(adev_to_drm(adev),
+						"failed to create ring mqd bo (%d)", r);
 					return r;
 				}
 
@@ -432,7 +433,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 				/* prepare MQD backup */
 				adev->gfx.me.mqd_backup[i] = kzalloc(mqd_size, GFP_KERNEL);
 				if (!adev->gfx.me.mqd_backup[i]) {
-					dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
+					drm_warn(adev_to_drm(adev),
+						"no memory to create MQD backup for ring %s\n", ring->name);
 					return -ENOMEM;
 				}
 			}
@@ -448,7 +450,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 						    domain, &ring->mqd_obj,
 						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 			if (r) {
-				dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
+				drm_warn(adev_to_drm(adev),
+					"failed to create ring mqd bo (%d)", r);
 				return r;
 			}
 
@@ -456,7 +459,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			/* prepare MQD backup */
 			adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[j]) {
-				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
+				drm_warn(adev_to_drm(adev),
+					"no memory to create MQD backup for ring %s\n", ring->name);
 				return -ENOMEM;
 			}
 		}
@@ -627,7 +631,7 @@ static int amdgpu_gfx_mes_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		spin_lock(&kiq->ring_lock);
 		r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->set_resources_size);
 		if (r) {
-			dev_err(adev->dev, "Failed to lock KIQ (%d).\n", r);
+			drm_err(adev_to_drm(adev), "Failed to lock KIQ (%d).\n", r);
 			spin_unlock(&kiq->ring_lock);
 			return r;
 		}
@@ -636,7 +640,7 @@ static int amdgpu_gfx_mes_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		r = amdgpu_ring_test_helper(kiq_ring);
 		spin_unlock(&kiq->ring_lock);
 		if (r)
-			dev_err(adev->dev, "KIQ failed to set resources\n");
+			drm_err(adev_to_drm(adev), "KIQ failed to set resources\n");
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
@@ -644,7 +648,7 @@ static int amdgpu_gfx_mes_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		r = amdgpu_mes_map_legacy_queue(adev,
 						&adev->gfx.compute_ring[j]);
 		if (r) {
-			dev_err(adev->dev, "failed to map compute queue\n");
+			drm_err(adev_to_drm(adev), "failed to map compute queue\n");
 			return r;
 		}
 	}
@@ -673,7 +677,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		 * generation exposes more than 64 queues. If so, the
 		 * definition of queue_mask needs updating */
 		if (WARN_ON(i > (sizeof(queue_mask)*8))) {
-			DRM_ERROR("Invalid KCQ enabled: %d\n", i);
+			drm_err(adev_to_drm(adev), "Invalid KCQ enabled: %d\n", i);
 			break;
 		}
 
@@ -682,7 +686,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 
 	amdgpu_device_flush_hdp(adev, NULL);
 
-	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
+	drm_info(adev_to_drm(adev), "kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
 		 kiq_ring->queue);
 
 	spin_lock(&kiq->ring_lock);
@@ -690,7 +694,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 					adev->gfx.num_compute_rings +
 					kiq->pmf->set_resources_size);
 	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		drm_err(adev_to_drm(adev), "Failed to lock KIQ (%d).\n", r);
 		spin_unlock(&kiq->ring_lock);
 		return r;
 	}
@@ -711,7 +715,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 	if (r)
-		DRM_ERROR("KCQ enable failed\n");
+		drm_err(adev_to_drm(adev), "KCQ enable failed\n");
 
 	return r;
 }
@@ -733,7 +737,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 			r = amdgpu_mes_map_legacy_queue(adev,
 							&adev->gfx.gfx_ring[j]);
 			if (r) {
-				DRM_ERROR("failed to map gfx queue\n");
+				drm_err(adev_to_drm(adev), "failed to map gfx queue\n");
 				return r;
 			}
 		}
@@ -747,7 +751,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 		r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
 						adev->gfx.num_gfx_rings);
 		if (r) {
-			DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+			drm_err(adev_to_drm(adev), "Failed to lock KIQ (%d).\n", r);
 			spin_unlock(&kiq->ring_lock);
 			return r;
 		}
@@ -768,7 +772,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 	if (r)
-		DRM_ERROR("KGQ enable failed\n");
+		drm_err(adev_to_drm(adev), "KGQ enable failed\n");
 
 	return r;
 }
@@ -966,7 +970,7 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
 
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register gfx ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register gfx ras block!\n");
 		return err;
 	}
 
@@ -1029,7 +1033,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 
 	ih_data.head = *ras_if;
 
-	DRM_ERROR("CP ECC ERROR IRQ\n");
+	drm_err(adev_to_drm(adev), "CP ECC ERROR IRQ\n");
 	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
 	return 0;
 }
@@ -1120,7 +1124,7 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 failed_kiq_read:
 	if (reg_val_offs)
 		amdgpu_device_wb_free(adev, reg_val_offs);
-	dev_err(adev->dev, "failed to read reg:%x\n", reg);
+	drm_err(adev_to_drm(adev), "failed to read reg:%x\n", reg);
 	return ~0;
 }
 
@@ -1185,7 +1189,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 failed_unlock:
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_write:
-	dev_err(adev->dev, "failed to write reg:%x\n", reg);
+	drm_err(adev_to_drm(adev), "failed to write reg:%x\n", reg);
 }
 
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
@@ -1193,7 +1197,7 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 	if (amdgpu_num_kcq == -1) {
 		return 8;
 	} else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
-		dev_warn(adev->dev, "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
+		drm_warn(adev_to_drm(adev), "set kernel compute queue number to 8 due to invalid parameter provided by user\n");
 		return 8;
 	}
 	return amdgpu_num_kcq;
@@ -1327,7 +1331,7 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
 		fw_size = le32_to_cpu(cp_hdr_v2_0->data_size_bytes);
 		break;
 	default:
-		dev_err(adev->dev, "Invalid ucode id %u\n", ucode_id);
+		drm_err(adev_to_drm(adev), "Invalid ucode id %u\n", ucode_id);
 		return;
 	}
 
@@ -1449,7 +1453,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	r = drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
 				  &sched, 1, NULL);
 	if (r) {
-		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
+		drm_err(adev_to_drm(adev), "Failed setting up GFX kernel entity.\n");
 		goto err;
 	}
 
@@ -1825,17 +1829,17 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 
 	r = amdgpu_gfx_sysfs_xcp_init(adev);
 	if (r) {
-		dev_err(adev->dev, "failed to create xcp sysfs files");
+		drm_err(adev_to_drm(adev), "failed to create xcp sysfs files");
 		return r;
 	}
 
 	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
 	if (r)
-		dev_err(adev->dev, "failed to create isolation sysfs files");
+		drm_err(adev_to_drm(adev), "failed to create isolation sysfs files");
 
 	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
 	if (r)
-		dev_err(adev->dev, "failed to create reset mask sysfs files");
+		drm_err(adev_to_drm(adev), "failed to create reset mask sysfs files");
 
 	return r;
 }
@@ -1925,7 +1929,7 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 		 * WARN_ON_ONCE.
 		 */
 		if (WARN_ON_ONCE(adev->gfx.kfd_sch_req_count[idx] == 0)) {
-			dev_err(adev->dev, "Attempted to enable KFD scheduler when reference count is already zero\n");
+			drm_err(adev_to_drm(adev), "Attempted to enable KFD scheduler when reference count is already zero\n");
 			goto unlock;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 464625282872a..74caf9839f580 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -224,7 +224,7 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 		mc->fb_start = mc->vram_start;
 		mc->fb_end = mc->vram_end;
 	}
-	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
+	drm_info(adev_to_drm(adev), "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
 			mc->mc_vram_size >> 20, mc->vram_start,
 			mc->vram_end, mc->real_vram_size >> 20);
 }
@@ -255,10 +255,10 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
 	mc->fb_start = hive_vram_start;
 	mc->fb_end = hive_vram_end;
-	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
+	drm_info(adev_to_drm(adev), "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
 			mc->mc_vram_size >> 20, mc->vram_start,
 			mc->vram_end, mc->real_vram_size >> 20);
-	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
+	drm_info(adev_to_drm(adev), "GART: %lluM 0x%016llX - 0x%016llX\n",
 			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
 }
 
@@ -288,7 +288,7 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 	size_af = max_mc_address + 1 - ALIGN(mc->fb_end + 1, four_gb);
 
 	if (mc->gart_size > max(size_bf, size_af)) {
-		dev_warn(adev->dev, "limiting GART\n");
+		drm_warn(adev_to_drm(adev), "limiting GART\n");
 		mc->gart_size = max(size_bf, size_af);
 	}
 
@@ -311,7 +311,7 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 
 	mc->gart_start &= ~(four_gb - 1);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
-	dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
+	drm_info(adev_to_drm(adev), "GART: %lluM 0x%016llX - 0x%016llX\n",
 			mc->gart_size >> 20, mc->gart_start, mc->gart_end);
 }
 
@@ -351,7 +351,7 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 	}
 
 	mc->agp_end = mc->agp_start + mc->agp_size - 1;
-	dev_info(adev->dev, "AGP: %lluM 0x%016llX - 0x%016llX\n",
+	drm_info(adev_to_drm(adev), "AGP: %lluM 0x%016llX - 0x%016llX\n",
 			mc->agp_size >> 20, mc->agp_start, mc->agp_end);
 }
 
@@ -602,7 +602,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 
 		inv_eng = ffs(vm_inv_engs[vmhub]);
 		if (!inv_eng) {
-			dev_err(adev->dev, "no VM inv eng for ring %s\n",
+			drm_err(adev_to_drm(adev), "no VM inv eng for ring %s\n",
 				ring->name);
 			return -EINVAL;
 		}
@@ -610,7 +610,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		ring->vm_inv_eng = inv_eng - 1;
 		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
 
-		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
+		drm_info(adev_to_drm(adev), "ring %s uses VM inv eng %u on hub %u\n",
 			 ring->name, ring->vm_inv_eng, ring->vm_hub);
 		/* SDMA has a special packet which allows it to use the same
 		 * invalidation engine for all the rings in one instance.
@@ -623,7 +623,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 		shared_ring = amdgpu_sdma_get_shared_ring(adev, ring);
 		if (shared_ring) {
 			shared_ring->vm_inv_eng = ring->vm_inv_eng;
-			dev_info(adev->dev, "ring %s shares VM invalidation engine %u with ring %s on hub %u\n",
+			drm_info(adev_to_drm(adev), "ring %s shares VM invalidation engine %u with ring %s on hub %u\n",
 					ring->name, ring->vm_inv_eng, shared_ring->name, ring->vm_hub);
 			continue;
 		}
@@ -692,7 +692,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 error_alloc:
 	mutex_unlock(&adev->mman.gtt_window_lock);
-	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
+	drm_err(adev_to_drm(adev), "Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
@@ -762,7 +762,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
 		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
-			dev_err(adev->dev, "timeout waiting for kiq fence\n");
+			drm_err(adev_to_drm(adev), "timeout waiting for kiq fence\n");
 			r = -ETIME;
 		}
 	}
@@ -823,7 +823,7 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 	amdgpu_ring_undo(ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq:
-	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
+	drm_err(adev_to_drm(adev), "failed to write reg %x wait reg %x\n", reg0, reg1);
 }
 
 /**
@@ -847,11 +847,11 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 1):
 		if (amdgpu_tmz == 0) {
 			adev->gmc.tmz_enabled = false;
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Trusted Memory Zone (TMZ) feature disabled (cmd line)\n");
 		} else {
 			adev->gmc.tmz_enabled = true;
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Trusted Memory Zone (TMZ) feature enabled\n");
 		}
 		break;
@@ -877,17 +877,17 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 		 */
 		if (amdgpu_tmz < 1) {
 			adev->gmc.tmz_enabled = false;
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Trusted Memory Zone (TMZ) feature disabled as experimental (default)\n");
 		} else {
 			adev->gmc.tmz_enabled = true;
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Trusted Memory Zone (TMZ) feature enabled as experimental (cmd line)\n");
 		}
 		break;
 	default:
 		adev->gmc.tmz_enabled = false;
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "Trusted Memory Zone (TMZ) feature not supported\n");
 		break;
 	}
@@ -1207,8 +1207,8 @@ static ssize_t current_memory_partition_store(struct device *dev,
 		adev->gmc.requested_nps_mode = mode;
 	}
 
-	dev_info(
-		adev->dev,
+	drm_info(
+		adev_to_drm(adev),
 		"NPS mode change requested, please remove and reload the driver\n");
 
 	return count;
@@ -1289,8 +1289,8 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 	 * Adjust if there are holes expected in any NPS domain.
 	 */
 	if (*exp_ranges && (range_cnt != *exp_ranges)) {
-		dev_warn(
-			adev->dev,
+		drm_warn(
+			adev_to_drm(adev),
 			"NPS config mismatch - expected ranges: %d discovery - nps mode: %d, nps ranges: %d",
 			*exp_ranges, nps_type, range_cnt);
 		ret = -EINVAL;
@@ -1299,8 +1299,8 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 
 	for (i = 0; i < range_cnt; ++i) {
 		if (ranges[i].base_address >= ranges[i].limit_address) {
-			dev_warn(
-				adev->dev,
+			drm_warn(
+				adev_to_drm(adev),
 				"Invalid NPS range - nps mode: %d, range[%d]: base: %llx limit: %llx",
 				nps_type, i, ranges[i].base_address,
 				ranges[i].limit_address);
@@ -1314,8 +1314,8 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 				ranges[i].base_address) <=
 			    min(ranges[j].limit_address,
 				ranges[i].limit_address)) {
-				dev_warn(
-					adev->dev,
+				drm_warn(
+					adev_to_drm(adev),
 					"overlapping ranges detected [ %llx - %llx ] | [%llx - %llx]",
 					ranges[j].base_address,
 					ranges[j].limit_address,
@@ -1354,7 +1354,7 @@ int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
 		return -EOPNOTSUPP;
 
 	if (!adev->psp.funcs) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"PSP interface not available for nps mode change request");
 		return -EINVAL;
 	}
@@ -1402,10 +1402,10 @@ void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev)
 	r = adev->gmc.gmc_funcs->request_mem_partition_mode(adev, req_nps_mode);
 out:
 	if (r)
-		dev_err(adev->dev, "NPS mode change request failed\n");
+		drm_err(adev_to_drm(adev), "NPS mode change request failed\n");
 	else
-		dev_info(
-			adev->dev,
+		drm_info(
+			adev_to_drm(adev),
 			"NPS mode change request done, reload driver to complete the change\n");
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index b6cf801939aa5..7a062259ee75e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -34,7 +34,7 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 	ras = adev->hdp.ras;
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register hdp ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register hdp ras block!\n");
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index e36fede7f74c3..02b6d998bc915 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -82,7 +82,7 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
 				  false, MAX_SCHEDULE_TIMEOUT);
 	mutex_unlock(&adev->notifier_lock);
 	if (r <= 0)
-		DRM_ERROR("(%ld) failed to wait for user bo\n", r);
+		drm_err(adev_to_drm(adev), "(%ld) failed to wait for user bo\n", r);
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 8179d0814db99..72ffd761a6798 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -204,7 +204,7 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 		i2c->bit.data = i2c;
 		ret = i2c_bit_add_bus(&i2c->adapter);
 		if (ret) {
-			DRM_ERROR("Failed to register bit i2c %s\n", name);
+			drm_err(dev, "Failed to register bit i2c %s\n", name);
 			goto out_free;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 802743efa3b39..13ffad1d3f20e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -71,7 +71,7 @@ int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = amdgpu_sa_bo_new(&adev->ib_pools[pool_type],
 				     &ib->sa_bo, size);
 		if (r) {
-			dev_err(adev->dev, "failed to get a new IB (%d)\n", r);
+			drm_err(adev_to_drm(adev), "failed to get a new IB (%d)\n", r);
 			return r;
 		}
 
@@ -164,18 +164,18 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	}
 
 	if (!ring->sched.ready) {
-		dev_err(adev->dev, "couldn't schedule ib on ring <%s>\n", ring->name);
+		drm_err(adev_to_drm(adev), "couldn't schedule ib on ring <%s>\n", ring->name);
 		return -EINVAL;
 	}
 
 	if (vm && !job->vmid) {
-		dev_err(adev->dev, "VM IB without ID\n");
+		drm_err(adev_to_drm(adev), "VM IB without ID\n");
 		return -EINVAL;
 	}
 
 	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
 	    (!ring->funcs->secure_submission_supported)) {
-		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
+		drm_err(adev_to_drm(adev), "secure submissions not supported on ring <%s>\n", ring->name);
 		return -EINVAL;
 	}
 
@@ -184,7 +184,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	r = amdgpu_ring_alloc(ring, alloc_size);
 	if (r) {
-		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "scheduling IB failed (%d).\n", r);
 		return r;
 	}
 
@@ -284,7 +284,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	r = amdgpu_fence_emit(ring, f, job, fence_flags);
 	if (r) {
-		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
+		drm_err(adev_to_drm(adev), "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
 			amdgpu_vmid_reset(adev, ring->vm_hub, job->vmid);
 		amdgpu_ring_undo(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 19ce4da285e8d..9c4c69a3eb29d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -142,7 +142,7 @@ void amdgpu_irq_disable_all(struct amdgpu_device *adev)
 				r = src->funcs->set(adev, src, k,
 						    AMDGPU_IRQ_STATE_DISABLE);
 				if (r)
-					DRM_ERROR("error disabling interrupt (%d)\n",
+					drm_err(adev_to_drm(adev), "error disabling interrupt (%d)\n",
 						  r);
 			}
 		}
@@ -286,7 +286,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	/* we only need one vector */
 	r = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
 	if (r < 0) {
-		dev_err(adev->dev, "Failed to alloc msi vectors\n");
+		drm_err(adev_to_drm(adev), "Failed to alloc msi vectors\n");
 		return r;
 	}
 
@@ -478,7 +478,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 	} else if ((src = adev->irq.client[client_id].sources[src_id])) {
 		r = src->funcs->process(adev, src, &entry);
 		if (r < 0)
-			DRM_ERROR("error processing interrupt (%d)\n", r);
+			drm_err(adev_to_drm(adev), "error processing interrupt (%d)\n", r);
 		else if (r)
 			handled = true;
 
@@ -728,7 +728,7 @@ int amdgpu_irq_add_domain(struct amdgpu_device *adev)
 	adev->irq.domain = irq_domain_add_linear(NULL, AMDGPU_MAX_IRQ_SRC_ID,
 						 &amdgpu_hw_irqdomain_ops, adev);
 	if (!adev->irq.domain) {
-		DRM_ERROR("GPU irq add domain failed\n");
+		drm_err(adev_to_drm(adev), "GPU irq add domain failed\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1a6cfef4c071a..50abd9d7ca2bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -38,12 +38,12 @@ static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
 {
 	int i;
 
-	dev_info(adev->dev, "Dumping IP State\n");
+	drm_info(adev_to_drm(adev), "Dumping IP State\n");
 	for (i = 0; i < adev->num_ip_blocks; i++)
 		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
 			adev->ip_blocks[i].version->funcs
 				->dump_ip_state((void *)&adev->ip_blocks[i]);
-	dev_info(adev->dev, "Dumping IP State Completed\n");
+	drm_info(adev_to_drm(adev), "Dumping IP State Completed\n");
 
 	amdgpu_coredump(adev, true, false, job);
 }
@@ -95,7 +95,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	int r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
-		dev_info(adev->dev, "%s - device unplugged skipping recovery on scheduler:%s",
+		drm_info(adev_to_drm(adev), "%s - device unplugged skipping recovery on scheduler:%s",
 			 __func__, s_job->sched->name);
 
 		/* Effectively the job is aborted as the device is gone */
@@ -113,18 +113,18 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 	if (amdgpu_gpu_recovery &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
-		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
+		drm_err(adev_to_drm(adev), "ring %s timeout, but soft recovered\n",
 			s_job->sched->name);
 		goto exit;
 	}
 
-	dev_err(adev->dev, "ring %s timeout, signaled seq=%u, emitted seq=%u\n",
+	drm_err(adev_to_drm(adev), "ring %s timeout, signaled seq=%u, emitted seq=%u\n",
 		job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
 		ring->fence_drv.sync_seq);
 
 	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
 	if (ti) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Process information: process %s pid %d thread %s pid %d\n",
 			ti->process_name, ti->tgid, ti->task_name, ti->pid);
 		amdgpu_vm_put_task_info(ti);
@@ -132,11 +132,11 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 	/* attempt a per ring reset */
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
-		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
+		drm_err(adev_to_drm(adev), "Ring reset disabled by debug mask\n");
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		bool is_guilty;
 
-		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
+		drm_err(adev_to_drm(adev), "Starting %s ring reset\n", s_job->sched->name);
 		/* stop the scheduler, but don't mess with the
 		 * bad job yet because if ring reset fails
 		 * we'll fall back to full GPU reset.
@@ -165,10 +165,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			}
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, 0);
-			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
+			drm_err(adev_to_drm(adev), "Ring %s reset succeeded\n", ring->sched.name);
 			goto exit;
 		}
-		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
+		drm_err(adev_to_drm(adev), "Ring %s reset failure\n", ring->sched.name);
 	}
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
@@ -189,7 +189,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
 		if (r)
-			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
+			drm_err(adev_to_drm(adev), "GPU Recovery Failed: %d\n", r);
 	} else {
 		drm_sched_suspend_timeout(&ring->sched);
 		if (amdgpu_sriov_vf(adev))
@@ -425,7 +425,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
 				       &fence);
 		if (r)
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Error scheduling IBs (%d) in ring(%s)", r,
 				ring->name);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index dda29132dfb2c..38e67a8122be3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -59,7 +59,7 @@ int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
 					&adev->jpeg.inst[i].dpg_sram_gpu_addr,
 					&adev->jpeg.inst[i].dpg_sram_cpu_addr);
 			if (r) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 				"JPEG %d (%d) failed to allocate DPG bo\n", i, r);
 				return r;
 			}
@@ -319,7 +319,7 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 	ras = adev->jpeg.ras;
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register jpeg ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register jpeg ras block!\n");
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cd6eb7a3bc58a..7d632d0d13e2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -105,7 +105,7 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 	mutex_lock(&mgpu_info.mutex);
 
 	if (mgpu_info.num_gpu >= MAX_GPU_INSTANCE) {
-		DRM_ERROR("Cannot register more gpu instance\n");
+		drm_err(adev_to_drm(adev), "Cannot register more gpu instance\n");
 		mutex_unlock(&mgpu_info.mutex);
 		return;
 	}
@@ -1357,7 +1357,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 
 	if (amdgpu_ras_intr_triggered()) {
-		DRM_ERROR("RAS Intr triggered, device disabled!!");
+		drm_err(adev_to_drm(adev), "RAS Intr triggered, device disabled!!");
 		return -EHWPOISON;
 	}
 
@@ -1375,7 +1375,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
-		dev_warn(adev->dev, "No more PASIDs available!");
+		drm_warn(adev_to_drm(adev), "No more PASIDs available!");
 		pasid = 0;
 	}
 
@@ -1539,7 +1539,7 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
 	u32 count;
 
 	if (pipe >= adev->mode_info.num_crtc) {
-		DRM_ERROR("Invalid crtc %u\n", pipe);
+		drm_err(adev_to_drm(adev), "Invalid crtc %u\n", pipe);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 3ca03b5e0f913..c3ded9fa8cdc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -93,7 +93,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev)
 
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register mca.mp0 ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register mca.mp0 ras block!\n");
 		return err;
 	}
 
@@ -117,7 +117,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev)
 
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register mca.mp1 ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register mca.mp1 ras block!\n");
 		return err;
 	}
 
@@ -141,7 +141,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
 
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register mca.mpio ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register mca.mpio ras block!\n");
 		return err;
 	}
 
@@ -519,7 +519,7 @@ static int amdgpu_mca_smu_debug_mode_set(void *data, u64 val)
 	if (ret)
 		return ret;
 
-	dev_info(adev->dev, "amdgpu set smu mca debug mode %s success\n", val ? "on" : "off");
+	drm_info(adev_to_drm(adev), "amdgpu set smu mca debug mode %s success\n", val ? "on" : "off");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index c52071841226f..3caed6a24be29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -47,7 +47,7 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 	/* Bitmap for dynamic allocation of kernel doorbells */
 	mes->doorbell_bitmap = bitmap_zalloc(PAGE_SIZE / sizeof(u32), GFP_KERNEL);
 	if (!mes->doorbell_bitmap) {
-		DRM_ERROR("Failed to allocate MES doorbell bitmap\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate MES doorbell bitmap\n");
 		return -ENOMEM;
 	}
 
@@ -73,7 +73,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
 				    &adev->mes.event_log_gpu_addr,
 				    &adev->mes.event_log_cpu_addr);
 	if (r) {
-		dev_warn(adev->dev, "failed to create MES event log buffer (%d)", r);
+		drm_warn(adev_to_drm(adev), "failed to create MES event log buffer (%d)", r);
 		return r;
 	}
 
@@ -159,7 +159,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES; i++) {
 		r = amdgpu_device_wb_get(adev, &adev->mes.sch_ctx_offs[i]);
 		if (r) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"(%d) ring trail_fence_offs wb alloc failed\n",
 				r);
 			goto error;
@@ -172,7 +172,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		r = amdgpu_device_wb_get(adev,
 				 &adev->mes.query_status_fence_offs[i]);
 		if (r) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 			      "(%d) query_status_fence_offs wb alloc failed\n",
 			      r);
 			goto error;
@@ -256,7 +256,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
 	r = adev->mes.funcs->suspend_gang(&adev->mes, &input);
 	amdgpu_mes_unlock(&adev->mes);
 	if (r)
-		DRM_ERROR("failed to suspend all gangs");
+		drm_err(adev_to_drm(adev), "failed to suspend all gangs");
 
 	return r;
 }
@@ -280,7 +280,7 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
 	r = adev->mes.funcs->resume_gang(&adev->mes, &input);
 	amdgpu_mes_unlock(&adev->mes);
 	if (r)
-		DRM_ERROR("failed to resume all gangs");
+		drm_err(adev_to_drm(adev), "failed to resume all gangs");
 
 	return r;
 }
@@ -306,7 +306,7 @@ int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
 	if (!queue) {
 		spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
 		amdgpu_mes_unlock(&adev->mes);
-		DRM_ERROR("queue id %d doesn't exist\n", queue_id);
+		drm_err(adev_to_drm(adev), "queue id %d doesn't exist\n", queue_id);
 		return -EINVAL;
 	}
 	spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
@@ -320,7 +320,7 @@ int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
 
 	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
 	if (r)
-		DRM_ERROR("failed to reset hardware queue, queue id = %d\n",
+		drm_err(adev_to_drm(adev), "failed to reset hardware queue, queue id = %d\n",
 			  queue_id);
 
 	amdgpu_mes_unlock(&adev->mes);
@@ -342,7 +342,7 @@ int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue_type,
 	queue_input.vmid = vmid;
 	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
 	if (r)
-		DRM_ERROR("failed to reset hardware queue by mmio, queue id = %d\n",
+		drm_err(adev_to_drm(adev), "failed to reset hardware queue by mmio, queue id = %d\n",
 			  queue_id);
 	return r;
 }
@@ -364,7 +364,7 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 
 	r = adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
 	if (r)
-		DRM_ERROR("failed to map legacy queue\n");
+		drm_err(adev_to_drm(adev), "failed to map legacy queue\n");
 
 	return r;
 }
@@ -387,7 +387,7 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 
 	r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input);
 	if (r)
-		DRM_ERROR("failed to unmap legacy queue\n");
+		drm_err(adev_to_drm(adev), "failed to unmap legacy queue\n");
 
 	return r;
 }
@@ -414,7 +414,7 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 
 	r = adev->mes.funcs->reset_legacy_queue(&adev->mes, &queue_input);
 	if (r)
-		DRM_ERROR("failed to reset legacy queue\n");
+		drm_err(adev_to_drm(adev), "failed to reset legacy queue\n");
 
 	return r;
 }
@@ -428,7 +428,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	uint32_t *read_val_ptr;
 
 	if (amdgpu_device_wb_get(adev, &addr_offset)) {
-		DRM_ERROR("critical bug! too many mes readers\n");
+		drm_err(adev_to_drm(adev), "critical bug! too many mes readers\n");
 		goto error;
 	}
 	read_val_gpu_addr = adev->wb.gpu_addr + (addr_offset * 4);
@@ -438,13 +438,13 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	op_input.read_reg.buffer_addr = read_val_gpu_addr;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes rreg is not supported!\n");
+		drm_err(adev_to_drm(adev), "mes rreg is not supported!\n");
 		goto error;
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to read reg (0x%x)\n", reg);
+		drm_err(adev_to_drm(adev), "failed to read reg (0x%x)\n", reg);
 	else
 		val = *(read_val_ptr);
 
@@ -465,14 +465,14 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 	op_input.write_reg.reg_value = val;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes wreg is not supported!\n");
+		drm_err(adev_to_drm(adev), "mes wreg is not supported!\n");
 		r = -EINVAL;
 		goto error;
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to write reg (0x%x)\n", reg);
+		drm_err(adev_to_drm(adev), "failed to write reg (0x%x)\n", reg);
 
 error:
 	return r;
@@ -492,14 +492,14 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 	op_input.wrm_reg.mask = mask;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes reg_write_reg_wait is not supported!\n");
+		drm_err(adev_to_drm(adev), "mes reg_write_reg_wait is not supported!\n");
 		r = -EINVAL;
 		goto error;
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to reg_write_reg_wait\n");
+		drm_err(adev_to_drm(adev), "failed to reg_write_reg_wait\n");
 
 error:
 	return r;
@@ -517,14 +517,14 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 	op_input.wrm_reg.mask = mask;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes reg wait is not supported!\n");
+		drm_err(adev_to_drm(adev), "mes reg wait is not supported!\n");
 		r = -EINVAL;
 		goto error;
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to reg_write_reg_wait\n");
+		drm_err(adev_to_drm(adev), "failed to reg_write_reg_wait\n");
 
 error:
 	return r;
@@ -541,7 +541,7 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 	int r;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes set shader debugger is not supported!\n");
+		drm_err(adev_to_drm(adev), "mes set shader debugger is not supported!\n");
 		return -EINVAL;
 	}
 
@@ -565,7 +565,7 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to set_shader_debugger\n");
+		drm_err(adev_to_drm(adev), "failed to set_shader_debugger\n");
 
 	amdgpu_mes_unlock(&adev->mes);
 
@@ -579,7 +579,7 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
 	int r;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes flush shader debugger is not supported!\n");
+		drm_err(adev_to_drm(adev), "mes flush shader debugger is not supported!\n");
 		return -EINVAL;
 	}
 
@@ -591,7 +591,7 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to set_shader_debugger\n");
+		drm_err(adev_to_drm(adev), "failed to set_shader_debugger\n");
 
 	amdgpu_mes_unlock(&adev->mes);
 
@@ -670,7 +670,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], AMDGPU_UCODE_REQUIRED,
 				 "%s", fw_name);
 	if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
-		dev_info(adev->dev, "try to fall back to %s_mes.bin\n", ucode_prefix);
+		drm_info(adev_to_drm(adev), "try to fall back to %s_mes.bin\n", ucode_prefix);
 		r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
 					 AMDGPU_UCODE_REQUIRED,
 					 "amdgpu/%s_mes.bin", ucode_prefix);
@@ -748,14 +748,14 @@ static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
 	op_input.change_config.option.limit_single_process = enable ? 1 : 0;
 
 	if (!adev->mes.funcs->misc_op) {
-		dev_err(adev->dev, "mes change config is not supported!\n");
+		drm_err(adev_to_drm(adev), "mes change config is not supported!\n");
 		r = -EINVAL;
 		goto error;
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		dev_err(adev->dev, "failed to change_config.\n");
+		drm_err(adev_to_drm(adev), "failed to change_config.\n");
 
 error:
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index 0f6b1021fef39..5c2135e4355e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -32,7 +32,7 @@ int amdgpu_mmhub_ras_sw_init(struct amdgpu_device *adev)
 	ras = adev->mmhub.ras;
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register mmhub ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register mmhub ras block!\n");
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index d085687a47ea1..a6faa36ce0353 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -33,7 +33,7 @@ int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev)
 	ras = adev->nbio.ras;
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register pcie_bif ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register pcie_bif ras block!\n");
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d09db052e282d..3d03f9af26619 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -262,7 +262,7 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 	if (!*bo_ptr) {
 		r = amdgpu_bo_create(adev, &bp, bo_ptr);
 		if (r) {
-			dev_err(adev->dev, "(%d) failed to allocate kernel bo\n",
+			drm_err(adev_to_drm(adev), "(%d) failed to allocate kernel bo\n",
 				r);
 			return r;
 		}
@@ -271,19 +271,19 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 
 	r = amdgpu_bo_reserve(*bo_ptr, false);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to reserve kernel bo\n", r);
 		goto error_free;
 	}
 
 	r = amdgpu_bo_pin(*bo_ptr, domain);
 	if (r) {
-		dev_err(adev->dev, "(%d) kernel bo pin failed\n", r);
+		drm_err(adev_to_drm(adev), "(%d) kernel bo pin failed\n", r);
 		goto error_unreserve;
 	}
 
 	r = amdgpu_ttm_alloc_gart(&(*bo_ptr)->tbo);
 	if (r) {
-		dev_err(adev->dev, "%p bind failed\n", *bo_ptr);
+		drm_err(adev_to_drm(adev), "%p bind failed\n", *bo_ptr);
 		goto error_unpin;
 	}
 
@@ -293,7 +293,7 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 	if (cpu_addr) {
 		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
 		if (r) {
-			dev_err(adev->dev, "(%d) kernel bo map failed\n", r);
+			drm_err(adev_to_drm(adev), "(%d) kernel bo map failed\n", r);
 			goto error_unpin;
 		}
 	}
@@ -383,25 +383,25 @@ int amdgpu_bo_create_isp_user(struct amdgpu_device *adev,
 	gem_obj = amdgpu_gem_prime_import(&adev->ddev, dma_buf);
 	*bo = gem_to_amdgpu_bo(gem_obj);
 	if (!(*bo)) {
-		dev_err(adev->dev, "failed to get valid isp user bo\n");
+		drm_err(adev_to_drm(adev), "failed to get valid isp user bo\n");
 		return -EINVAL;
 	}
 
 	r = amdgpu_bo_reserve(*bo, false);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to reserve isp user bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to reserve isp user bo\n", r);
 		return r;
 	}
 
 	r = amdgpu_bo_pin(*bo, domain);
 	if (r) {
-		dev_err(adev->dev, "(%d) isp user bo pin failed\n", r);
+		drm_err(adev_to_drm(adev), "(%d) isp user bo pin failed\n", r);
 		goto error_unreserve;
 	}
 
 	r = amdgpu_ttm_alloc_gart(&(*bo)->tbo);
 	if (r) {
-		dev_err(adev->dev, "%p bind failed\n", *bo);
+		drm_err(adev_to_drm(adev), "%p bind failed\n", *bo);
 		goto error_unpin;
 	}
 
@@ -982,7 +982,7 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
 
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (unlikely(r)) {
-		dev_err(adev->dev, "%p pin failed\n", bo);
+		drm_err(adev_to_drm(adev), "%p pin failed\n", bo);
 		goto error;
 	}
 
@@ -1065,7 +1065,7 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 				adev->gmc.aper_size);
 
 		if (r) {
-			DRM_ERROR("Unable to set WC memtype for the aperture base\n");
+			drm_err(adev_to_drm(adev), "Unable to set WC memtype for the aperture base\n");
 			return r;
 		}
 
@@ -1074,10 +1074,10 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 				adev->gmc.aper_size);
 	}
 
-	DRM_INFO("Detected VRAM RAM=%lluM, BAR=%lluM\n",
+	drm_info(adev_to_drm(adev), "Detected VRAM RAM=%lluM, BAR=%lluM\n",
 		 adev->gmc.mc_vram_size >> 20,
 		 (unsigned long long)adev->gmc.aper_size >> 20);
-	DRM_INFO("RAM width %dbits %s\n",
+	drm_info(adev_to_drm(adev), "RAM width %dbits %s\n",
 		 adev->gmc.vram_width, amdgpu_vram_names[adev->gmc.vram_type]);
 	return amdgpu_ttm_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ab3fe7b42da7a..e049c314a6179 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -190,7 +190,7 @@ static inline int amdgpu_bo_reserve(struct amdgpu_bo *bo, bool no_intr)
 	r = ttm_bo_reserve(&bo->tbo, !no_intr, false, NULL);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
-			dev_err(adev->dev, "%p reserve failed\n", bo);
+			drm_err(adev_to_drm(adev), "%p reserve failed\n", bo);
 		return r;
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index 34b5e22b44e5f..a5e6499064935 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -109,7 +109,7 @@ int amdgpu_preempt_mgr_init(struct amdgpu_device *adev)
 
 	ret = device_create_file(adev->dev, &dev_attr_mem_info_preempt_used);
 	if (ret) {
-		DRM_ERROR("Failed to create device file mem_info_preempt_used\n");
+		drm_err(adev_to_drm(adev), "Failed to create device file mem_info_preempt_used\n");
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6be3692561f6d..27bcc1661cae2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -327,18 +327,18 @@ static int psp_memory_training_init(struct psp_context *psp)
 	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
 
 	if (ctx->init != PSP_MEM_TRAIN_RESERVE_SUCCESS) {
-		dev_dbg(psp->adev->dev, "memory training is not supported!\n");
+		drm_dbg(adev_to_drm(psp->adev), "memory training is not supported!\n");
 		return 0;
 	}
 
 	ctx->sys_cache = kzalloc(ctx->train_data_size, GFP_KERNEL);
 	if (ctx->sys_cache == NULL) {
-		dev_err(psp->adev->dev, "alloc mem_train_ctx.sys_cache failed!\n");
+		drm_err(adev_to_drm(psp->adev), "alloc mem_train_ctx.sys_cache failed!\n");
 		ret = -ENOMEM;
 		goto Err_out;
 	}
 
-	dev_dbg(psp->adev->dev,
+	drm_dbg(adev_to_drm(psp->adev),
 		"train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
 		ctx->train_data_size,
 		ctx->p2c_train_data_offset,
@@ -385,7 +385,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 
 	if (db_header.cookie != PSP_RUNTIME_DB_COOKIE_ID) {
 		/* runtime db doesn't exist, exit */
-		dev_dbg(adev->dev, "PSP runtime database doesn't exist\n");
+		drm_dbg(adev_to_drm(adev), "PSP runtime database doesn't exist\n");
 		return false;
 	}
 
@@ -395,7 +395,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 
 	if (db_dir.entry_count >= PSP_RUNTIME_DB_DIAG_ENTRY_MAX_COUNT) {
 		/* invalid db entry count, exit */
-		dev_warn(adev->dev, "Invalid PSP runtime database entry count\n");
+		drm_warn(adev_to_drm(adev), "Invalid PSP runtime database entry count\n");
 		return false;
 	}
 
@@ -406,7 +406,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 			case PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG:
 				if (db_dir.entry_list[i].size < sizeof(struct psp_runtime_boot_cfg_entry)) {
 					/* invalid db entry size */
-					dev_warn(adev->dev, "Invalid PSP runtime database boot cfg entry size\n");
+					drm_warn(adev_to_drm(adev), "Invalid PSP runtime database boot cfg entry size\n");
 					return false;
 				}
 				/* read runtime database entry */
@@ -417,7 +417,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 			case PSP_RUNTIME_ENTRY_TYPE_PPTABLE_ERR_STATUS:
 				if (db_dir.entry_list[i].size < sizeof(struct psp_runtime_scpm_entry)) {
 					/* invalid db entry size */
-					dev_warn(adev->dev, "Invalid PSP runtime database scpm entry size\n");
+					drm_warn(adev_to_drm(adev), "Invalid PSP runtime database scpm entry size\n");
 					return false;
 				}
 				/* read runtime database entry */
@@ -446,7 +446,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 
 	psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!psp->cmd) {
-		dev_err(adev->dev, "Failed to allocate memory to command buffer!\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory to command buffer!\n");
 		ret = -ENOMEM;
 	}
 
@@ -493,13 +493,13 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	if (mem_training_ctx->enable_mem_training) {
 		ret = psp_memory_training_init(psp);
 		if (ret) {
-			dev_err(adev->dev, "Failed to initialize memory training!\n");
+			drm_err(adev_to_drm(adev), "Failed to initialize memory training!\n");
 			return ret;
 		}
 
 		ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
 		if (ret) {
-			dev_err(adev->dev, "Failed to process memory training!\n");
+			drm_err(adev_to_drm(adev), "Failed to process memory training!\n");
 			return ret;
 		}
 	}
@@ -729,12 +729,12 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 */
 	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
 		if (ucode)
-			dev_warn(psp->adev->dev,
+			drm_warn(adev_to_drm(psp->adev),
 				 "failed to load ucode %s(0x%X) ",
 				 amdgpu_ucode_name(ucode->ucode_id), ucode->ucode_id);
 		if (psp_err_warn(psp))
-			dev_warn(
-				psp->adev->dev,
+			drm_warn(
+				adev_to_drm(psp->adev),
 				"psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
 				psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id),
 				psp->cmd_buf_mem->cmd_id,
@@ -856,7 +856,7 @@ static int psp_tmr_init(struct psp_context *psp)
 	    psp->fw_pri_buf) {
 		ret = psp_load_toc(psp, &tmr_size);
 		if (ret) {
-			dev_err(psp->adev->dev, "Failed to load toc\n");
+			drm_err(adev_to_drm(psp->adev), "Failed to load toc\n");
 			return ret;
 		}
 	}
@@ -906,7 +906,7 @@ static int psp_tmr_load(struct psp_context *psp)
 
 	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
 	if (psp->tmr_bo)
-		dev_info(psp->adev->dev, "reserve 0x%lx from 0x%llx for PSP TMR\n",
+		drm_info(adev_to_drm(psp->adev), "reserve 0x%lx from 0x%llx for PSP TMR\n",
 			 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
@@ -940,7 +940,7 @@ static int psp_tmr_unload(struct psp_context *psp)
 	cmd = acquire_psp_cmd_buf(psp);
 
 	psp_prep_tmr_unload_cmd_buf(psp, cmd);
-	dev_dbg(psp->adev->dev, "free PSP TMR buffer\n");
+	drm_dbg(adev_to_drm(psp->adev), "free PSP TMR buffer\n");
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -1072,11 +1072,11 @@ int psp_memory_partition(struct psp_context *psp, int mode)
 	cmd->cmd_id = GFX_CMD_ID_FB_NPS_MODE;
 	cmd->cmd.cmd_memory_part.mode = mode;
 
-	dev_info(psp->adev->dev,
+	drm_info(adev_to_drm(psp->adev),
 		 "Requesting %d memory partition change through PSP", mode);
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 	if (ret)
-		dev_err(psp->adev->dev,
+		drm_err(adev_to_drm(psp->adev),
 			"PSP request failed to change to NPS%d mode\n", mode);
 
 	release_psp_cmd_buf(psp);
@@ -1097,7 +1097,7 @@ int psp_spatial_partition(struct psp_context *psp, int mode)
 	cmd->cmd_id = GFX_CMD_ID_SRIOV_SPATIAL_PART;
 	cmd->cmd.cmd_spatial_part.mode = mode;
 
-	dev_info(psp->adev->dev, "Requesting %d partitions through PSP", mode);
+	drm_info(adev_to_drm(psp->adev), "Requesting %d partitions through PSP", mode);
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 
 	release_psp_cmd_buf(psp);
@@ -1194,7 +1194,7 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 	psp_prep_reg_prog_cmd_buf(cmd, reg, value);
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 	if (ret)
-		dev_err(psp->adev->dev, "PSP failed to program reg id %d\n", reg);
+		drm_err(adev_to_drm(psp->adev), "PSP failed to program reg id %d\n", reg);
 
 	release_psp_cmd_buf(psp);
 
@@ -1611,22 +1611,22 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
 
 	switch (ras_cmd->ras_status) {
 	case TA_RAS_STATUS__ERROR_UNSUPPORTED_IP:
-		dev_warn(psp->adev->dev,
+		drm_warn(adev_to_drm(psp->adev),
 			 "RAS WARNING: cmd failed due to unsupported ip\n");
 		break;
 	case TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
-		dev_warn(psp->adev->dev,
+		drm_warn(adev_to_drm(psp->adev),
 			 "RAS WARNING: cmd failed due to unsupported error injection\n");
 		break;
 	case TA_RAS_STATUS__SUCCESS:
 		break;
 	case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
 		if (ras_cmd->cmd_id == TA_RAS_COMMAND__TRIGGER_ERROR)
-			dev_warn(psp->adev->dev,
+			drm_warn(adev_to_drm(psp->adev),
 				 "RAS WARNING: Inject error to critical region is not allowed\n");
 		break;
 	default:
-		dev_warn(psp->adev->dev,
+		drm_warn(adev_to_drm(psp->adev),
 			 "RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
 		break;
 	}
@@ -1661,7 +1661,7 @@ static int psp_ras_send_cmd(struct psp_context *psp,
 			in, sizeof(ras_cmd->ras_in_message.address));
 		break;
 	default:
-		dev_err(psp->adev->dev, "Invalid ras cmd id: %u\n", cmd);
+		drm_err(adev_to_drm(psp->adev), "Invalid ras cmd id: %u\n", cmd);
 		ret = -EINVAL;
 		goto err_out;
 	}
@@ -1711,17 +1711,17 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 		return ret;
 
 	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER) {
-		dev_warn(psp->adev->dev, "RAS: Unsupported Interface\n");
+		drm_warn(adev_to_drm(psp->adev), "RAS: Unsupported Interface\n");
 		return -EINVAL;
 	}
 
 	if (!ret) {
 		if (ras_cmd->ras_out_message.flags.err_inject_switch_disable_flag) {
-			dev_warn(psp->adev->dev, "ECC switch disabled\n");
+			drm_warn(adev_to_drm(psp->adev), "ECC switch disabled\n");
 
 			ras_cmd->ras_status = TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE;
 		} else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
-			dev_warn(psp->adev->dev,
+			drm_warn(adev_to_drm(psp->adev),
 				 "RAS internal register access blocked\n");
 
 		psp_ras_ta_check_status(psp);
@@ -1785,7 +1785,7 @@ int psp_ras_initialize(struct psp_context *psp)
 
 	if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
 	    !adev->psp.ras_context.context.bin_desc.start_addr) {
-		dev_info(adev->dev, "RAS: optional ras ta ucode is not available\n");
+		drm_info(adev_to_drm(adev), "RAS: optional ras ta ucode is not available\n");
 		return 0;
 	}
 
@@ -1806,7 +1806,7 @@ int psp_ras_initialize(struct psp_context *psp)
 			if ((adev->ras_default_ecc_enabled || amdgpu_ras_enable == 1) &&
 				amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC)) {
 				if (boot_cfg == 1) {
-					dev_info(adev->dev, "GECC is enabled\n");
+					drm_info(adev_to_drm(adev), "GECC is enabled\n");
 				} else {
 					/* enable GECC in next boot cycle if it is disabled
 					 * in boot config, or force enable GECC if failed to
@@ -1825,7 +1825,7 @@ int psp_ras_initialize(struct psp_context *psp)
 					    amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
 						dev_warn(adev->dev, "GECC is disabled, set amdgpu_ras_enable=1 to enable GECC in next boot cycle if needed\n");
 					else
-						dev_info(adev->dev, "GECC is disabled\n");
+						drm_info(adev_to_drm(adev), "GECC is disabled\n");
 				} else {
 					/* disable GECC in next boot cycle if ras is
 					 * disabled by module parameter amdgpu_ras_enable
@@ -1873,7 +1873,7 @@ int psp_ras_initialize(struct psp_context *psp)
 		mutex_init(&psp->ras_context.mutex);
 	} else {
 		if (ras_cmd->ras_status)
-			dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
+			drm_warn(adev_to_drm(adev), "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
 
 		/* fail to load RAS TA */
 		psp->ras_context.context.initialized = false;
@@ -1967,7 +1967,7 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 
 	if (!psp->hdcp_context.context.bin_desc.size_bytes ||
 	    !psp->hdcp_context.context.bin_desc.start_addr) {
-		dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is not available\n");
+		drm_info(adev_to_drm(psp->adev), "HDCP: optional hdcp ta ucode is not available\n");
 		return 0;
 	}
 
@@ -2041,7 +2041,7 @@ static int psp_dtm_initialize(struct psp_context *psp)
 
 	if (!psp->dtm_context.context.bin_desc.size_bytes ||
 	    !psp->dtm_context.context.bin_desc.start_addr) {
-		dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is not available\n");
+		drm_info(adev_to_drm(psp->adev), "DTM: optional dtm ta ucode is not available\n");
 		return 0;
 	}
 
@@ -2112,7 +2112,7 @@ static int psp_rap_initialize(struct psp_context *psp)
 
 	if (!psp->rap_context.context.bin_desc.size_bytes ||
 	    !psp->rap_context.context.bin_desc.start_addr) {
-		dev_info(psp->adev->dev, "RAP: optional rap ta ucode is not available\n");
+		drm_info(adev_to_drm(psp->adev), "RAP: optional rap ta ucode is not available\n");
 		return 0;
 	}
 
@@ -2138,7 +2138,7 @@ static int psp_rap_initialize(struct psp_context *psp)
 		/* free rap shared memory */
 		psp_ta_free_shared_buf(&psp->rap_context.context.mem_context);
 
-		dev_warn(psp->adev->dev, "RAP TA initialize fail (%d) status %d.\n",
+		drm_warn(adev_to_drm(psp->adev), "RAP TA initialize fail (%d) status %d.\n",
 			 ret, status);
 
 		return ret;
@@ -2214,7 +2214,7 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 
 	if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
 	    !psp->securedisplay_context.context.bin_desc.start_addr) {
-		dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta ucode is not available\n");
+		drm_info(adev_to_drm(psp->adev), "SECUREDISPLAY: securedisplay ta ucode is not available\n");
 		return 0;
 	}
 
@@ -2249,13 +2249,13 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 		psp_securedisplay_terminate(psp);
 		/* free securedisplay shared memory */
 		psp_ta_free_shared_buf(&psp->securedisplay_context.context.mem_context);
-		dev_err(psp->adev->dev, "SECUREDISPLAY TA initialize fail.\n");
+		drm_err(adev_to_drm(psp->adev), "SECUREDISPLAY TA initialize fail.\n");
 		return -EINVAL;
 	}
 
 	if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS) {
 		psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
-		dev_err(psp->adev->dev, "SECUREDISPLAY: query securedisplay TA failed. ret 0x%x\n",
+		drm_err(adev_to_drm(psp->adev), "SECUREDISPLAY: query securedisplay TA failed. ret 0x%x\n",
 			securedisplay_cmd->securedisplay_out_message.query_ta.query_cmd_ret);
 		/* don't try again */
 		psp->securedisplay_context.context.bin_desc.size_bytes = 0;
@@ -2346,7 +2346,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
 			ret = psp_bootloader_load_kdb(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load kdb failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load kdb failed!\n");
 				return ret;
 			}
 		}
@@ -2355,7 +2355,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_spl != NULL)) {
 			ret = psp_bootloader_load_spl(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load spl failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load spl failed!\n");
 				return ret;
 			}
 		}
@@ -2364,7 +2364,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_sysdrv != NULL)) {
 			ret = psp_bootloader_load_sysdrv(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load sys drv failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load sys drv failed!\n");
 				return ret;
 			}
 		}
@@ -2373,7 +2373,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_soc_drv != NULL)) {
 			ret = psp_bootloader_load_soc_drv(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load soc drv failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load soc drv failed!\n");
 				return ret;
 			}
 		}
@@ -2382,7 +2382,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_intf_drv != NULL)) {
 			ret = psp_bootloader_load_intf_drv(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load intf drv failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load intf drv failed!\n");
 				return ret;
 			}
 		}
@@ -2391,7 +2391,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_dbg_drv != NULL)) {
 			ret = psp_bootloader_load_dbg_drv(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load dbg drv failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load dbg drv failed!\n");
 				return ret;
 			}
 		}
@@ -2400,7 +2400,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_ras_drv != NULL)) {
 			ret = psp_bootloader_load_ras_drv(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load ras_drv failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load ras_drv failed!\n");
 				return ret;
 			}
 		}
@@ -2409,7 +2409,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_ipkeymgr_drv != NULL)) {
 			ret = psp_bootloader_load_ipkeymgr_drv(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load ipkeymgr_drv failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load ipkeymgr_drv failed!\n");
 				return ret;
 			}
 		}
@@ -2418,7 +2418,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_spdm_drv != NULL)) {
 			ret = psp_bootloader_load_spdm_drv(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load spdm_drv failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load spdm_drv failed!\n");
 				return ret;
 			}
 		}
@@ -2427,7 +2427,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_sos != NULL)) {
 			ret = psp_bootloader_load_sos(psp);
 			if (ret) {
-				dev_err(adev->dev, "PSP load sos failed!\n");
+				drm_err(adev_to_drm(adev), "PSP load sos failed!\n");
 				return ret;
 			}
 		}
@@ -2435,7 +2435,7 @@ static int psp_hw_start(struct psp_context *psp)
 
 	ret = psp_ring_create(psp, PSP_RING_TYPE__KM);
 	if (ret) {
-		dev_err(adev->dev, "PSP create ring failed!\n");
+		drm_err(adev_to_drm(adev), "PSP create ring failed!\n");
 		return ret;
 	}
 
@@ -2445,7 +2445,7 @@ static int psp_hw_start(struct psp_context *psp)
 	if (!psp->boot_time_tmr || psp->autoload_supported) {
 		ret = psp_tmr_init(psp);
 		if (ret) {
-			dev_err(adev->dev, "PSP tmr init failed!\n");
+			drm_err(adev_to_drm(adev), "PSP tmr init failed!\n");
 			return ret;
 		}
 	}
@@ -2465,7 +2465,7 @@ static int psp_hw_start(struct psp_context *psp)
 	if (!psp->boot_time_tmr || !psp->autoload_supported) {
 		ret = psp_tmr_load(psp);
 		if (ret) {
-			dev_err(adev->dev, "PSP load tmr failed!\n");
+			drm_err(adev_to_drm(adev), "PSP load tmr failed!\n");
 			return ret;
 		}
 	}
@@ -2755,7 +2755,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct psp_context *psp,
 
 	ret = psp_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
 	if (ret)
-		dev_err(psp->adev->dev, "Unknown firmware type\n");
+		drm_err(adev_to_drm(psp->adev), "Unknown firmware type\n");
 
 	return ret;
 }
@@ -2828,13 +2828,13 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	      amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(11, 0, 2)))) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret)
-			dev_err(adev->dev, "Failed to set MP1 state prepare for reload\n");
+			drm_err(adev_to_drm(adev), "Failed to set MP1 state prepare for reload\n");
 	}
 
 	ret = psp_execute_ip_fw_load(psp, ucode);
 
 	if (ret)
-		dev_err(adev->dev, "PSP load smu failed!\n");
+		drm_err(adev_to_drm(adev), "PSP load smu failed!\n");
 
 	return ret;
 }
@@ -2939,7 +2939,7 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 		    adev->virt.autoload_ucode_id : AMDGPU_UCODE_ID_RLC_G)) {
 			ret = psp_rlc_autoload_start(psp);
 			if (ret) {
-				dev_err(adev->dev, "Failed to start rlc autoload\n");
+				drm_err(adev_to_drm(adev), "Failed to start rlc autoload\n");
 				return ret;
 			}
 		}
@@ -2961,7 +2961,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 
 		ret = psp_ring_init(psp, PSP_RING_TYPE__KM);
 		if (ret) {
-			dev_err(adev->dev, "PSP ring init failed!\n");
+			drm_err(adev_to_drm(adev), "PSP ring init failed!\n");
 			goto failed;
 		}
 	}
@@ -2976,13 +2976,13 @@ static int psp_load_fw(struct amdgpu_device *adev)
 
 	ret = psp_asd_initialize(psp);
 	if (ret) {
-		dev_err(adev->dev, "PSP load asd failed!\n");
+		drm_err(adev_to_drm(adev), "PSP load asd failed!\n");
 		goto failed1;
 	}
 
 	ret = psp_rl_load(adev);
 	if (ret) {
-		dev_err(adev->dev, "PSP load RL failed!\n");
+		drm_err(adev_to_drm(adev), "PSP load RL failed!\n");
 		goto failed1;
 	}
 
@@ -2993,7 +2993,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 			 * Instead of stop driver initialization
 			 */
 			if (ret)
-				dev_err(psp->adev->dev,
+				drm_err(adev_to_drm(psp->adev),
 					"XGMI: Failed to initialize XGMI session\n");
 		}
 	}
@@ -3001,27 +3001,27 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (psp->ta_fw) {
 		ret = psp_ras_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"RAS: Failed to initialize RAS\n");
 
 		ret = psp_hdcp_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"HDCP: Failed to initialize HDCP\n");
 
 		ret = psp_dtm_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"DTM: Failed to initialize DTM\n");
 
 		ret = psp_rap_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"RAP: Failed to initialize RAP\n");
 
 		ret = psp_securedisplay_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"SECUREDISPLAY: Failed to initialize SECUREDISPLAY\n");
 	}
 
@@ -3052,7 +3052,7 @@ static int psp_hw_init(struct amdgpu_ip_block *ip_block)
 
 	ret = psp_load_fw(adev);
 	if (ret) {
-		dev_err(adev->dev, "PSP firmware loading failed\n");
+		drm_err(adev_to_drm(adev), "PSP firmware loading failed\n");
 		goto failed;
 	}
 
@@ -3099,7 +3099,7 @@ static int psp_suspend(struct amdgpu_ip_block *ip_block)
 	    psp->xgmi_context.context.initialized) {
 		ret = psp_xgmi_terminate(psp);
 		if (ret) {
-			dev_err(adev->dev, "Failed to terminate xgmi ta\n");
+			drm_err(adev_to_drm(adev), "Failed to terminate xgmi ta\n");
 			goto out;
 		}
 	}
@@ -3107,46 +3107,46 @@ static int psp_suspend(struct amdgpu_ip_block *ip_block)
 	if (psp->ta_fw) {
 		ret = psp_ras_terminate(psp);
 		if (ret) {
-			dev_err(adev->dev, "Failed to terminate ras ta\n");
+			drm_err(adev_to_drm(adev), "Failed to terminate ras ta\n");
 			goto out;
 		}
 		ret = psp_hdcp_terminate(psp);
 		if (ret) {
-			dev_err(adev->dev, "Failed to terminate hdcp ta\n");
+			drm_err(adev_to_drm(adev), "Failed to terminate hdcp ta\n");
 			goto out;
 		}
 		ret = psp_dtm_terminate(psp);
 		if (ret) {
-			dev_err(adev->dev, "Failed to terminate dtm ta\n");
+			drm_err(adev_to_drm(adev), "Failed to terminate dtm ta\n");
 			goto out;
 		}
 		ret = psp_rap_terminate(psp);
 		if (ret) {
-			dev_err(adev->dev, "Failed to terminate rap ta\n");
+			drm_err(adev_to_drm(adev), "Failed to terminate rap ta\n");
 			goto out;
 		}
 		ret = psp_securedisplay_terminate(psp);
 		if (ret) {
-			dev_err(adev->dev, "Failed to terminate securedisplay ta\n");
+			drm_err(adev_to_drm(adev), "Failed to terminate securedisplay ta\n");
 			goto out;
 		}
 	}
 
 	ret = psp_asd_terminate(psp);
 	if (ret) {
-		dev_err(adev->dev, "Failed to terminate asd\n");
+		drm_err(adev_to_drm(adev), "Failed to terminate asd\n");
 		goto out;
 	}
 
 	ret = psp_tmr_terminate(psp);
 	if (ret) {
-		dev_err(adev->dev, "Failed to terminate tmr\n");
+		drm_err(adev_to_drm(adev), "Failed to terminate tmr\n");
 		goto out;
 	}
 
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
 	if (ret)
-		dev_err(adev->dev, "PSP ring stop failed\n");
+		drm_err(adev_to_drm(adev), "PSP ring stop failed\n");
 
 out:
 	return ret;
@@ -3158,12 +3158,12 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct psp_context *psp = &adev->psp;
 
-	dev_info(adev->dev, "PSP is resuming...\n");
+	drm_info(adev_to_drm(adev), "PSP is resuming...\n");
 
 	if (psp->mem_train_ctx.enable_mem_training) {
 		ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
 		if (ret) {
-			dev_err(adev->dev, "Failed to process memory training!\n");
+			drm_err(adev_to_drm(adev), "Failed to process memory training!\n");
 			return ret;
 		}
 	}
@@ -3184,13 +3184,13 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
 
 	ret = psp_asd_initialize(psp);
 	if (ret) {
-		dev_err(adev->dev, "PSP load asd failed!\n");
+		drm_err(adev_to_drm(adev), "PSP load asd failed!\n");
 		goto failed;
 	}
 
 	ret = psp_rl_load(adev);
 	if (ret) {
-		dev_err(adev->dev, "PSP load RL failed!\n");
+		drm_err(adev_to_drm(adev), "PSP load RL failed!\n");
 		goto failed;
 	}
 
@@ -3200,34 +3200,34 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
 		 * Instead of stop driver initialization
 		 */
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"XGMI: Failed to initialize XGMI session\n");
 	}
 
 	if (psp->ta_fw) {
 		ret = psp_ras_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"RAS: Failed to initialize RAS\n");
 
 		ret = psp_hdcp_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"HDCP: Failed to initialize HDCP\n");
 
 		ret = psp_dtm_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"DTM: Failed to initialize DTM\n");
 
 		ret = psp_rap_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"RAP: Failed to initialize RAP\n");
 
 		ret = psp_securedisplay_initialize(psp);
 		if (ret)
-			dev_err(psp->adev->dev,
+			drm_err(adev_to_drm(psp->adev),
 				"SECUREDISPLAY: Failed to initialize SECUREDISPLAY\n");
 	}
 
@@ -3236,7 +3236,7 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 failed:
-	dev_err(adev->dev, "PSP resume failed\n");
+	drm_err(adev_to_drm(adev), "PSP resume failed\n");
 	mutex_unlock(&adev->firmware.mutex);
 	return ret;
 }
@@ -3297,10 +3297,10 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 		write_frame = ring_buffer_start + (psp_write_ptr_reg / rb_frame_size_dw);
 	/* Check invalid write_frame ptr address */
 	if ((write_frame < ring_buffer_start) || (ring_buffer_end < write_frame)) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"ring_buffer_start = %p; ring_buffer_end = %p; write_frame = %p\n",
 			ring_buffer_start, ring_buffer_end, write_frame);
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"write_frame is pointing to address out of bounds\n");
 		return -EINVAL;
 	}
@@ -3455,7 +3455,7 @@ static int parse_sos_bin_descriptor(struct psp_context *psp,
 		psp->spdm_drv.start_addr	= ucode_start_addr;
 		break;
 	default:
-		dev_warn(psp->adev->dev, "Unsupported PSP FW type: %d\n", desc->fw_type);
+		drm_warn(adev_to_drm(psp->adev), "Unsupported PSP FW type: %d\n", desc->fw_type);
 		break;
 	}
 
@@ -3500,7 +3500,7 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 	}
 
 	if ((adev->psp.sys.size_bytes == 0) || (adev->psp.sos.size_bytes == 0)) {
-		dev_warn(adev->dev, "PSP SOS FW not available");
+		drm_warn(adev_to_drm(adev), "PSP SOS FW not available");
 		return -EINVAL;
 	}
 
@@ -3529,7 +3529,7 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 	sos_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.sos_fw->data;
 	ucode_array_start_addr = (uint8_t *)sos_hdr +
 		le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
-	amdgpu_ucode_print_psp_hdr(&sos_hdr->header);
+	amdgpu_ucode_print_psp_hdr(adev, &sos_hdr->header);
 
 	switch (sos_hdr->header.header_version_major) {
 	case 1:
@@ -3574,7 +3574,7 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 		fw_bin_count = le32_to_cpu(sos_hdr_v2_0->psp_fw_bin_count);
 
 		if (fw_bin_count >= UCODE_MAX_PSP_PACKAGING) {
-			dev_err(adev->dev, "packed SOS count exceeds maximum limit\n");
+			drm_err(adev_to_drm(adev), "packed SOS count exceeds maximum limit\n");
 			err = -EINVAL;
 			goto out;
 		}
@@ -3601,7 +3601,7 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 		}
 		break;
 	default:
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"unsupported psp sos firmware\n");
 		err = -EINVAL;
 		goto out;
@@ -3702,7 +3702,7 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
 			ucode_start_addr;
 		break;
 	default:
-		dev_warn(psp->adev->dev, "Unsupported TA type: %d\n", desc->fw_type);
+		drm_warn(adev_to_drm(psp->adev), "Unsupported TA type: %d\n", desc->fw_type);
 		break;
 	}
 
@@ -3777,7 +3777,7 @@ static int parse_ta_v2_microcode(struct psp_context *psp)
 		return -EINVAL;
 
 	if (le32_to_cpu(ta_hdr->ta_fw_bin_count) >= UCODE_MAX_PSP_PACKAGING) {
-		dev_err(adev->dev, "packed TA count exceeds maximum limit\n");
+		drm_err(adev_to_drm(adev), "packed TA count exceeds maximum limit\n");
 		return -EINVAL;
 	}
 
@@ -3812,7 +3812,7 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 		err = parse_ta_v2_microcode(psp);
 		break;
 	default:
-		dev_err(adev->dev, "unsupported TA header version\n");
+		drm_err(adev_to_drm(adev), "unsupported TA header version\n");
 		err = -EINVAL;
 	}
 
@@ -3830,7 +3830,7 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 	int err = 0;
 
 	if (!amdgpu_sriov_vf(adev)) {
-		dev_err(adev->dev, "cap microcode should only be loaded under SRIOV\n");
+		drm_err(adev_to_drm(adev), "cap microcode should only be loaded under SRIOV\n");
 		return -EINVAL;
 	}
 
@@ -3838,10 +3838,10 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 				   "amdgpu/%s_cap.bin", chip_name);
 	if (err) {
 		if (err == -ENODEV) {
-			dev_warn(adev->dev, "cap microcode does not exist, skip\n");
+			drm_warn(adev_to_drm(adev), "cap microcode does not exist, skip\n");
 			err = 0;
 		} else {
-			dev_err(adev->dev, "fail to initialize cap microcode\n");
+			drm_err(adev_to_drm(adev), "fail to initialize cap microcode\n");
 		}
 		goto out;
 	}
@@ -3874,12 +3874,12 @@ int psp_config_sq_perfmon(struct psp_context *psp,
 		return 0;
 
 	if (xcp_id > MAX_XCP) {
-		dev_err(psp->adev->dev, "invalid xcp_id %d\n", xcp_id);
+		drm_err(adev_to_drm(psp->adev), "invalid xcp_id %d\n", xcp_id);
 		return -EINVAL;
 	}
 
 	if (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6)) {
-		dev_err(psp->adev->dev, "Unsupported MP0 version 0x%x for CONFIG_SQ_PERFMON command\n",
+		drm_err(adev_to_drm(psp->adev), "Unsupported MP0 version 0x%x for CONFIG_SQ_PERFMON command\n",
 			amdgpu_ip_version(psp->adev, MP0_HWIP, 0));
 		return -EINVAL;
 	}
@@ -3893,7 +3893,7 @@ int psp_config_sq_perfmon(struct psp_context *psp,
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 	if (ret)
-		dev_warn(psp->adev->dev, "PSP failed to config sq: xcp%d core%d reg%d perfmon%d\n",
+		drm_warn(adev_to_drm(psp->adev), "PSP failed to config sq: xcp%d core%d reg%d perfmon%d\n",
 			xcp_id, core_override_enable, reg_override_enable, perfmon_override_enable);
 
 	release_psp_cmd_buf(psp);
@@ -3924,7 +3924,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
 	if (!ip_block || !ip_block->status.late_initialized) {
-		dev_info(adev->dev, "PSP block is not ready yet\n.");
+		drm_info(adev_to_drm(adev), "PSP block is not ready yet\n.");
 		return -EBUSY;
 	}
 
@@ -3933,7 +3933,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 	mutex_unlock(&adev->psp.mutex);
 
 	if (ret) {
-		dev_err(adev->dev, "Failed to read USBC PD FW, err = %d\n", ret);
+		drm_err(adev_to_drm(adev), "Failed to read USBC PD FW, err = %d\n", ret);
 		return ret;
 	}
 
@@ -3956,7 +3956,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
 	if (!ip_block || !ip_block->status.late_initialized) {
-		dev_err(adev->dev, "PSP block is not ready yet.");
+		drm_err(adev_to_drm(adev), "PSP block is not ready yet.");
 		return -EBUSY;
 	}
 
@@ -3989,7 +3989,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	amdgpu_ucode_release(&usbc_pd_fw);
 fail:
 	if (ret) {
-		dev_err(adev->dev, "Failed to load USBC PD FW, err = %d", ret);
+		drm_err(adev_to_drm(adev), "Failed to load USBC PD FW, err = %d", ret);
 		count = ret;
 	}
 
@@ -4036,7 +4036,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 
 	/* Safeguard against memory drain */
 	if (adev->psp.vbflash_image_size > AMD_VBIOS_FILE_MAX_SIZE_B) {
-		dev_err(adev->dev, "File size cannot exceed %u\n", AMD_VBIOS_FILE_MAX_SIZE_B);
+		drm_err(adev_to_drm(adev), "File size cannot exceed %u\n", AMD_VBIOS_FILE_MAX_SIZE_B);
 		kvfree(adev->psp.vbflash_tmp_buf);
 		adev->psp.vbflash_tmp_buf = NULL;
 		adev->psp.vbflash_image_size = 0;
@@ -4055,7 +4055,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 	adev->psp.vbflash_image_size += count;
 	mutex_unlock(&adev->psp.mutex);
 
-	dev_dbg(adev->dev, "IFWI staged for update\n");
+	drm_dbg(adev_to_drm(adev), "IFWI staged for update\n");
 
 	return count;
 }
@@ -4075,7 +4075,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	if (adev->psp.vbflash_image_size == 0)
 		return -EINVAL;
 
-	dev_dbg(adev->dev, "PSP IFWI flash process initiated\n");
+	drm_dbg(adev_to_drm(adev), "PSP IFWI flash process initiated\n");
 
 	ret = amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,
 					AMDGPU_GPU_PAGE_SIZE,
@@ -4100,11 +4100,11 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	adev->psp.vbflash_image_size = 0;
 
 	if (ret) {
-		dev_err(adev->dev, "Failed to load IFWI, err = %d\n", ret);
+		drm_err(adev_to_drm(adev), "Failed to load IFWI, err = %d\n", ret);
 		return ret;
 	}
 
-	dev_dbg(adev->dev, "PSP IFWI flash process done\n");
+	drm_dbg(adev_to_drm(adev), "PSP IFWI flash process done\n");
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 38face981c3e3..cc59df861e724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -183,7 +183,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 	set_ta_context_funcs(psp, ta_type, &context);
 
 	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_terminate) {
-		dev_err(adev->dev, "Unsupported function to terminate TA\n");
+		drm_err(adev_to_drm(adev), "Unsupported function to terminate TA\n");
 		ret = -EOPNOTSUPP;
 		goto err_free_bin;
 	}
@@ -202,7 +202,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 
 	ret = psp_fn_ta_terminate(psp);
 	if (ret || context->resp_status) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Failed to unload embedded TA (%d) and status (0x%X)\n",
 			ret, context->resp_status);
 		if (!ret)
@@ -217,14 +217,14 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 	context->bin_desc.start_addr         = ta_bin;
 
 	if (!psp->ta_funcs->fn_ta_initialize) {
-		dev_err(adev->dev, "Unsupported function to initialize TA\n");
+		drm_err(adev_to_drm(adev), "Unsupported function to initialize TA\n");
 		ret = -EOPNOTSUPP;
 		goto err_free_ta_shared_buf;
 	}
 
 	ret = psp_fn_ta_initialize(psp);
 	if (ret || context->resp_status) {
-		dev_err(adev->dev, "Failed to load TA via debugfs (%d) and status (0x%X)\n",
+		drm_err(adev_to_drm(adev), "Failed to load TA via debugfs (%d) and status (0x%X)\n",
 			ret, context->resp_status);
 		if (!ret)
 			ret = -EINVAL;
@@ -272,13 +272,13 @@ static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf, size
 	context->session_id = ta_id;
 
 	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_terminate) {
-		dev_err(adev->dev, "Unsupported function to terminate TA\n");
+		drm_err(adev_to_drm(adev), "Unsupported function to terminate TA\n");
 		return -EOPNOTSUPP;
 	}
 
 	ret = psp_fn_ta_terminate(psp);
 	if (ret || context->resp_status) {
-		dev_err(adev->dev, "Failed to unload TA via debugfs (%d) and status (0x%X)\n",
+		drm_err(adev_to_drm(adev), "Failed to unload TA via debugfs (%d) and status (0x%X)\n",
 			ret, context->resp_status);
 		if (!ret)
 			ret = -EINVAL;
@@ -338,13 +338,13 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 	set_ta_context_funcs(psp, ta_type, &context);
 
 	if (!context || !context->initialized) {
-		dev_err(adev->dev, "TA is not initialized\n");
+		drm_err(adev_to_drm(adev), "TA is not initialized\n");
 		ret = -EINVAL;
 		goto err_free_shared_buf;
 	}
 
 	if (!psp->ta_funcs || !psp->ta_funcs->fn_ta_invoke) {
-		dev_err(adev->dev, "Unsupported function to invoke TA\n");
+		drm_err(adev_to_drm(adev), "Unsupported function to invoke TA\n");
 		ret = -EOPNOTSUPP;
 		goto err_free_shared_buf;
 	}
@@ -358,7 +358,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 
 	ret = psp_fn_ta_invoke(psp, cmd_id);
 	if (ret || context->resp_status) {
-		dev_err(adev->dev, "Failed to invoke TA via debugfs (%d) and status (0x%X)\n",
+		drm_err(adev_to_drm(adev), "Failed to invoke TA via debugfs (%d) and status (0x%X)\n",
 			ret, context->resp_status);
 		if (!ret) {
 			ret = -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
index 123bcf5c2bb13..9aee91f4c08f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
@@ -73,30 +73,30 @@ static ssize_t amdgpu_rap_debugfs_write(struct file *f, const char __user *buf,
 	case 2:
 		ret = psp_rap_invoke(&adev->psp, op, &status);
 		if (!ret && status == TA_RAP_STATUS__SUCCESS) {
-			dev_info(adev->dev, "RAP L0 validate test success.\n");
+			drm_info(adev_to_drm(adev), "RAP L0 validate test success.\n");
 		} else {
 			rap_shared_mem = (struct ta_rap_shared_memory *)
 					 adev->psp.rap_context.context.mem_context.shared_buf;
 			rap_cmd_output = &(rap_shared_mem->rap_out_message.output);
 
-			dev_info(adev->dev, "RAP test failed, the output is:\n");
-			dev_info(adev->dev, "\tlast_subsection: 0x%08x.\n",
+			drm_info(adev_to_drm(adev), "RAP test failed, the output is:\n");
+			drm_info(adev_to_drm(adev), "\tlast_subsection: 0x%08x.\n",
 				 rap_cmd_output->last_subsection);
-			dev_info(adev->dev, "\tnum_total_validate: 0x%08x.\n",
+			drm_info(adev_to_drm(adev), "\tnum_total_validate: 0x%08x.\n",
 				 rap_cmd_output->num_total_validate);
-			dev_info(adev->dev, "\tnum_valid: 0x%08x.\n",
+			drm_info(adev_to_drm(adev), "\tnum_valid: 0x%08x.\n",
 				 rap_cmd_output->num_valid);
-			dev_info(adev->dev, "\tlast_validate_addr: 0x%08x.\n",
+			drm_info(adev_to_drm(adev), "\tlast_validate_addr: 0x%08x.\n",
 				 rap_cmd_output->last_validate_addr);
-			dev_info(adev->dev, "\tlast_validate_val: 0x%08x.\n",
+			drm_info(adev_to_drm(adev), "\tlast_validate_val: 0x%08x.\n",
 				 rap_cmd_output->last_validate_val);
-			dev_info(adev->dev, "\tlast_validate_val_exptd: 0x%08x.\n",
+			drm_info(adev_to_drm(adev), "\tlast_validate_val_exptd: 0x%08x.\n",
 				 rap_cmd_output->last_validate_val_exptd);
 		}
 		break;
 	default:
-		dev_info(adev->dev, "Unsupported op id: %d, ", op);
-		dev_info(adev->dev, "Only support op 2(L0 validate test).\n");
+		drm_info(adev_to_drm(adev), "Unsupported op id: %d, ", op);
+		drm_info(adev_to_drm(adev), "Only support op 2(L0 validate test).\n");
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebf1f63d04427..198452f48bff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -171,14 +171,14 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 
 	if ((address >= adev->gmc.mc_vram_size) ||
 	    (address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 		         "RAS WARN: input address 0x%llx is invalid.\n",
 		         address);
 		return -EINVAL;
 	}
 
 	if (amdgpu_ras_check_bad_page(adev, address)) {
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "RAS WARN: 0x%llx has already been marked as bad page!\n",
 			 address);
 		return 0;
@@ -200,9 +200,9 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 
 	amdgpu_ras_error_data_fini(&err_data);
 
-	dev_warn(adev->dev, "WARNING: THIS IS ONLY FOR TEST PURPOSES AND WILL CORRUPT RAS EEPROM\n");
-	dev_warn(adev->dev, "Clear EEPROM:\n");
-	dev_warn(adev->dev, "    echo 1 > /sys/kernel/debug/dri/0/ras/ras_eeprom_reset\n");
+	drm_warn(adev_to_drm(adev), "WARNING: THIS IS ONLY FOR TEST PURPOSES AND WILL CORRUPT RAS EEPROM\n");
+	drm_warn(adev_to_drm(adev), "Clear EEPROM:\n");
+	drm_warn(adev_to_drm(adev), "    echo 1 > /sys/kernel/debug/dri/0/ras/ras_eeprom_reset\n");
 
 	return 0;
 }
@@ -485,7 +485,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 	int ret = 0;
 
 	if (!amdgpu_ras_get_error_query_ready(adev)) {
-		dev_warn(adev->dev, "RAS WARN: error injection "
+		drm_warn(adev_to_drm(adev), "RAS WARN: error injection "
 				"currently inaccessible\n");
 		return size;
 	}
@@ -516,7 +516,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 		if ((data.inject.address >= adev->gmc.mc_vram_size &&
 		    adev->gmc.mc_vram_size) ||
 		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
-			dev_warn(adev->dev, "RAS WARN: input address "
+			drm_warn(adev_to_drm(adev), "RAS WARN: input address "
 					"0x%llx is invalid.",
 					data.inject.address);
 			ret = -EINVAL;
@@ -526,7 +526,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 		/* umc ce/ue error injection for a bad page is not allowed */
 		if ((data.head.block == AMDGPU_RAS_BLOCK__UMC) &&
 		    amdgpu_ras_check_bad_page(adev, data.inject.address)) {
-			dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has "
+			drm_warn(adev_to_drm(adev), "RAS WARN: inject: 0x%llx has "
 				 "already been marked as bad!\n",
 				 data.inject.address);
 			break;
@@ -637,7 +637,7 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 	if (amdgpu_ip_version(obj->adev, MP0_HWIP, 0) != IP_VERSION(11, 0, 2) &&
 	    amdgpu_ip_version(obj->adev, MP0_HWIP, 0) != IP_VERSION(11, 0, 4)) {
 		if (amdgpu_ras_reset_error_status(obj->adev, info.head.block))
-			dev_warn(obj->adev->dev, "Failed to reset error counter and error status");
+			drm_warn(adev_to_drm(obj->adev), "Failed to reset error counter and error status");
 	}
 
 	if (info.head.block == AMDGPU_RAS_BLOCK__UMC)
@@ -661,7 +661,7 @@ static inline void put_obj(struct ras_manager *obj)
 	}
 
 	if (obj && (obj->use < 0))
-		DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", get_ras_block_str(&obj->head));
+		drm_err(adev_to_drm(obj->adev), "RAS ERROR: Unbalance obj(%s) use\n", get_ras_block_str(&obj->head));
 }
 
 /* make one obj and return it. */
@@ -831,7 +831,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 
 		ret = psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
-			dev_err(adev->dev, "ras %s %s failed poison:%d ret:%d\n",
+			drm_err(adev_to_drm(adev), "ras %s %s failed poison:%d ret:%d\n",
 				enable ? "enable":"disable",
 				get_ras_block_str(head),
 				amdgpu_ras_is_poison_mode_supported(adev), ret);
@@ -874,7 +874,7 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu_device *adev,
 			if (ret == -EINVAL) {
 				ret = __amdgpu_ras_feature_enable(adev, head, 1);
 				if (!ret)
-					dev_info(adev->dev,
+					drm_info(adev_to_drm(adev),
 						"RAS INFO: %s setup object\n",
 						get_ras_block_str(head));
 			}
@@ -999,7 +999,7 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct amdgpu_de
 
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
-			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
+			drm_warn(adev_to_drm(adev), "Warning: abnormal ras list node.\n");
 			continue;
 		}
 
@@ -1577,7 +1577,7 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 	}
 
 	if (ret)
-		dev_err(adev->dev, "ras inject %s failed %d\n",
+		drm_err(adev_to_drm(adev), "ras inject %s failed %d\n",
 			get_ras_block_str(&info->head), ret);
 
 	return ret;
@@ -1616,7 +1616,7 @@ static int amdgpu_ras_query_error_count_helper(struct amdgpu_device *adev,
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(11, 0, 2) &&
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(11, 0, 4)) {
 		if (amdgpu_ras_reset_error_status(adev, query_info->head.block))
-			dev_warn(adev->dev,
+			drm_warn(adev_to_drm(adev),
 				 "Failed to reset error counter and error status\n");
 	}
 
@@ -2127,7 +2127,7 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 
 	r = sysfs_create_group(&adev->dev->kobj, &group);
 	if (r)
-		dev_err(adev->dev, "Failed to create RAS sysfs group!");
+		drm_err(adev_to_drm(adev), "Failed to create RAS sysfs group!");
 
 	return 0;
 }
@@ -2210,7 +2210,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 		poison_stat = block_obj->hw_ops->query_poison_status(adev);
 		if (!poison_stat) {
 			/* Not poison consumption interrupt, no need to handle it */
-			dev_info(adev->dev, "No RAS poison status in %s poison IH.\n",
+			drm_info(adev_to_drm(adev), "No RAS poison status in %s poison IH.\n",
 					block_obj->ras_comm.name);
 
 			return;
@@ -2487,7 +2487,7 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev, enum ras_e
 		    amdgpu_ip_version(adev, MP0_HWIP, 0) !=
 			    IP_VERSION(13, 0, 0)) {
 			if (amdgpu_ras_reset_error_status(adev, info.head.block))
-				dev_warn(adev->dev, "Failed to reset error counter and error status");
+				drm_warn(adev_to_drm(adev), "Failed to reset error counter and error status");
 		}
 	}
 }
@@ -2994,7 +2994,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12) {
 			if (amdgpu_ras_eeprom_append(control,
 					&data->bps[bad_page_num], save_count)) {
-				dev_err(adev->dev, "Failed to save EEPROM table data!");
+				drm_err(adev_to_drm(adev), "Failed to save EEPROM table data!");
 				return -EIO;
 			}
 		} else {
@@ -3002,13 +3002,13 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 				if (amdgpu_ras_eeprom_append(control,
 						&data->bps[bad_page_num +
 						i * adev->umc.retire_unit], 1)) {
-					dev_err(adev->dev, "Failed to save EEPROM table data!");
+					drm_err(adev_to_drm(adev), "Failed to save EEPROM table data!");
 					return -EIO;
 				}
 			}
 		}
 
-		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
+		drm_info(adev_to_drm(adev), "Saved %d pages to EEPROM table.\n", save_count);
 	}
 
 	return 0;
@@ -3035,7 +3035,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 
 	ret = amdgpu_ras_eeprom_read(control, bps, control->ras_num_recs);
 	if (ret) {
-		dev_err(adev->dev, "Failed to load EEPROM table records!");
+		drm_err(adev_to_drm(adev), "Failed to load EEPROM table records!");
 	} else {
 		if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
 			for (i = 0; i < control->ras_num_recs; i++) {
@@ -3160,7 +3160,7 @@ int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
 
 	ret = kfifo_put(&con->poison_fifo, poison_msg);
 	if (!ret) {
-		dev_err(adev->dev, "Poison message fifo is full!\n");
+		drm_err(adev_to_drm(adev), "Poison message fifo is full!\n");
 		return -ENOSPC;
 	}
 
@@ -3300,7 +3300,7 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	} while (total_detect_count < need_query_count);
 
 	if (query_data_timeout) {
-		dev_warn(adev->dev, "Can't find deferred error! count: %u\n",
+		drm_warn(adev_to_drm(adev), "Can't find deferred error! count: %u\n",
 			(need_query_count - total_detect_count));
 		return -ENOENT;
 	}
@@ -3537,7 +3537,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 		kthread_run(amdgpu_ras_page_retirement_thread, adev, "umc_page_retirement");
 	if (IS_ERR(con->page_retirement_thread)) {
 		con->page_retirement_thread = NULL;
-		dev_warn(adev->dev, "Failed to create umc_page_retirement thread!!!\n");
+		drm_warn(adev_to_drm(adev), "Failed to create umc_page_retirement thread!!!\n");
 	}
 
 	INIT_DELAYED_WORK(&con->page_retirement_dwork, amdgpu_ras_do_page_retirement);
@@ -3554,7 +3554,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_info)
 	kfree(*data);
 	con->eh_data = NULL;
 out:
-	dev_warn(adev->dev, "Failed to initialize ras recovery! (%d)\n", ret);
+	drm_warn(adev_to_drm(adev), "Failed to initialize ras recovery! (%d)\n", ret);
 
 	/*
 	 * Except error threshold exceeding case, other failure cases in this
@@ -3668,16 +3668,16 @@ static void amdgpu_ras_query_ras_capablity_from_vbios(struct amdgpu_device *adev
 {
 	/* mem_ecc cap */
 	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
-		dev_info(adev->dev, "MEM ECC is active.\n");
+		drm_info(adev_to_drm(adev), "MEM ECC is active.\n");
 		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__UMC |
 					 1 << AMDGPU_RAS_BLOCK__DF);
 	} else {
-		dev_info(adev->dev, "MEM ECC is not presented.\n");
+		drm_info(adev_to_drm(adev), "MEM ECC is not presented.\n");
 	}
 
 	/* sram_ecc cap */
 	if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
-		dev_info(adev->dev, "SRAM ECC is active.\n");
+		drm_info(adev_to_drm(adev), "SRAM ECC is active.\n");
 		if (!amdgpu_sriov_vf(adev))
 			adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
 						  1 << AMDGPU_RAS_BLOCK__DF);
@@ -3706,7 +3706,7 @@ static void amdgpu_ras_query_ras_capablity_from_vbios(struct amdgpu_device *adev
 		if (!adev->gmc.xgmi.num_physical_nodes)
 			adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__XGMI_WAFL);
 	} else {
-		dev_info(adev->dev, "SRAM ECC is not presented.\n");
+		drm_info(adev_to_drm(adev), "SRAM ECC is not presented.\n");
 	}
 }
 
@@ -3738,7 +3738,7 @@ static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
 		if (df_poison && umc_poison)
 			con->poison_supported = true;
 		else if (df_poison != umc_poison)
-			dev_warn(adev->dev,
+			drm_warn(adev_to_drm(adev),
 				"Poison setting is inconsistent in DF/UMC(%d:%d)!\n",
 				df_poison, umc_poison);
 	}
@@ -4028,7 +4028,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
-	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
+	drm_info(adev_to_drm(adev), "RAS INFO: ras initialized successfully, "
 		 "hardware ability[%x] ras_mask[%x]\n",
 		 adev->ras_hw_enabled, adev->ras_enabled);
 
@@ -4261,7 +4261,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		obj = node->ras_obj;
 		if (!obj) {
-			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
+			drm_warn(adev_to_drm(adev), "Warning: abnormal ras list node.\n");
 			continue;
 		}
 
@@ -4271,7 +4271,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 		if (obj->ras_late_init) {
 			r = obj->ras_late_init(adev, &obj->ras_comm);
 			if (r) {
-				dev_err(adev->dev, "%s failed to execute ras_late_init! ret:%d\n",
+				drm_err(adev_to_drm(adev), "%s failed to execute ras_late_init! ret:%d\n",
 					obj->ras_comm.name, r);
 				return r;
 			}
@@ -4440,7 +4440,7 @@ int amdgpu_ras_mark_ras_event_caller(struct amdgpu_device *adev, enum ras_event_
 
 out:
 	if (ret && caller)
-		dev_warn(adev->dev, "failed mark ras event (%d) in %ps, ret:%d\n",
+		drm_warn(adev_to_drm(adev), "failed mark ras event (%d) in %ps, ret:%d\n",
 			 (int)type, caller, ret);
 
 	return ret;
@@ -4584,7 +4584,7 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	umc_inst = GET_UMC_INST(m->ipid);
 	ch_inst = GET_CHAN_INDEX(m->ipid);
 
-	dev_info(adev->dev, "Uncorrectable error detected in UMC inst: %d, chan_idx: %d",
+	drm_info(adev_to_drm(adev), "Uncorrectable error detected in UMC inst: %d, chan_idx: %d",
 			     umc_inst, ch_inst);
 
 	if (!amdgpu_umc_page_retirement_mca(adev, m->addr, ch_inst, umc_inst))
@@ -4893,7 +4893,7 @@ void amdgpu_ras_inst_query_ras_error_count(struct amdgpu_device *adev,
 		amdgpu_ras_get_error_type_name(err_type, err_type_name);
 		if (!mem_list) {
 			/* memory_list is not supported */
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "%ld %s hardware errors detected in %s, instance: %d, memory_id: %d\n",
 				 err_cnt, err_type_name,
 				 reg_list[i].block_name,
@@ -4901,7 +4901,7 @@ void amdgpu_ras_inst_query_ras_error_count(struct amdgpu_device *adev,
 		} else {
 			for (j = 0; j < mem_list_size; j++) {
 				if (memory_id == mem_list[j].memory_id) {
-					dev_info(adev->dev,
+					drm_info(adev_to_drm(adev),
 						 "%ld %s hardware errors detected in %s, instance: %d, memory block: %s\n",
 						 err_cnt, err_type_name,
 						 reg_list[i].block_name,
@@ -5122,52 +5122,52 @@ static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device *adev,
 	hbm_id = ((1 == AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error)) ? 0 : 1);
 
 	if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, memory training failed\n",
 			 socket_id, aid_id, hbm_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, fw_status: 0x%x, firmware load failed at boot time\n",
 			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, fw_status: 0x%x, wafl link training failed\n",
 			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, fw_status: 0x%x, xgmi link training failed\n",
 			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, fw_status: 0x%x, usr cp link training failed\n",
 			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, fw_status: 0x%x, usr dp link training failed\n",
 			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, hbm memory test failed\n",
 			 socket_id, aid_id, hbm_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, hbm: %d, fw_status: 0x%x, hbm bist test failed\n",
 			 socket_id, aid_id, hbm_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_DATA_ABORT(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, fw_status: 0x%x, data abort exception\n",
 			 socket_id, aid_id, fw_status);
 
 	if (AMDGPU_RAS_GPU_ERR_GENERIC(boot_error))
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "socket: %d, aid: %d, fw_status: 0x%x, Boot Controller Generic Error\n",
 			 socket_id, aid_id, fw_status);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0ea7cfaf3587d..dd666f2180af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -277,9 +277,9 @@ static int __write_table_header(struct amdgpu_ras_eeprom_control *control)
 	up_read(&adev->reset_domain->sem);
 
 	if (res < 0) {
-		DRM_ERROR("Failed to write EEPROM table header:%d", res);
+		drm_err(adev_to_drm(adev), "Failed to write EEPROM table header:%d", res);
 	} else if (res < RAS_TABLE_HEADER_SIZE) {
-		DRM_ERROR("Short write:%d out of %d\n",
+		drm_err(adev_to_drm(adev), "Short write:%d out of %d\n",
 			  res, RAS_TABLE_HEADER_SIZE);
 		res = -EIO;
 	} else {
@@ -323,7 +323,7 @@ static int __write_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 
 	buf = kzalloc(RAS_TABLE_V2_1_INFO_SIZE, GFP_KERNEL);
 	if (!buf) {
-		DRM_ERROR("Failed to alloc buf to write table ras info\n");
+		drm_err(adev_to_drm(adev), "Failed to alloc buf to write table ras info\n");
 		return -ENOMEM;
 	}
 
@@ -338,9 +338,9 @@ static int __write_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 	up_read(&adev->reset_domain->sem);
 
 	if (res < 0) {
-		DRM_ERROR("Failed to write EEPROM table ras info:%d", res);
+		drm_err(adev_to_drm(adev), "Failed to write EEPROM table ras info:%d", res);
 	} else if (res < RAS_TABLE_V2_1_INFO_SIZE) {
-		DRM_ERROR("Short write:%d out of %d\n",
+		drm_err(adev_to_drm(adev), "Short write:%d out of %d\n",
 			  res, RAS_TABLE_V2_1_INFO_SIZE);
 		res = -EIO;
 	} else {
@@ -606,12 +606,12 @@ static int __amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
 				  buf, buf_size);
 	up_read(&adev->reset_domain->sem);
 	if (res < 0) {
-		DRM_ERROR("Writing %d EEPROM table records error:%d",
+		drm_err(adev_to_drm(adev), "Writing %d EEPROM table records error:%d",
 			  num, res);
 	} else if (res < buf_size) {
 		/* Short write, return error.
 		 */
-		DRM_ERROR("Wrote %d records out of %d",
+		drm_err(adev_to_drm(adev), "Wrote %d records out of %d",
 			  res / RAS_TABLE_RECORD_SIZE, num);
 		res = -EIO;
 	} else {
@@ -786,7 +786,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	buf_size = control->ras_num_recs * RAS_TABLE_RECORD_SIZE;
 	buf = kcalloc(control->ras_num_recs, RAS_TABLE_RECORD_SIZE, GFP_KERNEL);
 	if (!buf) {
-		DRM_ERROR("allocating memory for table of size %d bytes failed\n",
+		drm_err(adev_to_drm(adev), "allocating memory for table of size %d bytes failed\n",
 			  control->tbl_hdr.tbl_size);
 		res = -ENOMEM;
 		goto Out;
@@ -799,11 +799,11 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 				 buf, buf_size);
 	up_read(&adev->reset_domain->sem);
 	if (res < 0) {
-		DRM_ERROR("EEPROM failed reading records:%d\n",
+		drm_err(adev_to_drm(adev), "EEPROM failed reading records:%d\n",
 			  res);
 		goto Out;
 	} else if (res < buf_size) {
-		DRM_ERROR("EEPROM read %d out of %d bytes\n",
+		drm_err(adev_to_drm(adev), "EEPROM read %d out of %d bytes\n",
 			  res, buf_size);
 		res = -EIO;
 		goto Out;
@@ -865,10 +865,10 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 		return 0;
 
 	if (num == 0) {
-		DRM_ERROR("will not append 0 records\n");
+		drm_err(adev_to_drm(adev), "will not append 0 records\n");
 		return -EINVAL;
 	} else if (num > control->ras_max_record_count) {
-		DRM_ERROR("cannot append %d records than the size of table %d\n",
+		drm_err(adev_to_drm(adev), "cannot append %d records than the size of table %d\n",
 			  num, control->ras_max_record_count);
 		return -EINVAL;
 	}
@@ -923,12 +923,12 @@ static int __amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 				 buf, buf_size);
 	up_read(&adev->reset_domain->sem);
 	if (res < 0) {
-		DRM_ERROR("Reading %d EEPROM table records error:%d",
+		drm_err(adev_to_drm(adev), "Reading %d EEPROM table records error:%d",
 			  num, res);
 	} else if (res < buf_size) {
 		/* Short read, return error.
 		 */
-		DRM_ERROR("Read %d records out of %d",
+		drm_err(adev_to_drm(adev), "Read %d records out of %d",
 			  res / RAS_TABLE_RECORD_SIZE, num);
 		res = -EIO;
 	} else {
@@ -963,10 +963,10 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 		return 0;
 
 	if (num == 0) {
-		DRM_ERROR("will not read 0 records\n");
+		drm_err(adev_to_drm(adev), "will not read 0 records\n");
 		return -EINVAL;
 	} else if (num > control->ras_num_recs) {
-		DRM_ERROR("too many records to read:%d available:%d\n",
+		drm_err(adev_to_drm(adev), "too many records to read:%d available:%d\n",
 			  num, control->ras_num_recs);
 		return -EINVAL;
 	}
@@ -1299,7 +1299,7 @@ static int __verify_ras_table_checksum(struct amdgpu_ras_eeprom_control *control
 
 	buf = kzalloc(buf_size, GFP_KERNEL);
 	if (!buf) {
-		DRM_ERROR("Out of memory checking RAS table checksum.\n");
+		drm_err(adev_to_drm(adev), "Out of memory checking RAS table checksum.\n");
 		return -ENOMEM;
 	}
 
@@ -1308,7 +1308,7 @@ static int __verify_ras_table_checksum(struct amdgpu_ras_eeprom_control *control
 				 control->ras_header_offset,
 				 buf, buf_size);
 	if (res < buf_size) {
-		DRM_ERROR("Partial read for checksum, res:%d\n", res);
+		drm_err(adev_to_drm(adev), "Partial read for checksum, res:%d\n", res);
 		/* On partial reads, return -EIO.
 		 */
 		if (res >= 0)
@@ -1333,7 +1333,7 @@ static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 
 	buf = kzalloc(RAS_TABLE_V2_1_INFO_SIZE, GFP_KERNEL);
 	if (!buf) {
-		DRM_ERROR("Failed to alloc buf to read EEPROM table ras info\n");
+		drm_err(adev_to_drm(adev), "Failed to alloc buf to read EEPROM table ras info\n");
 		return -ENOMEM;
 	}
 
@@ -1345,7 +1345,7 @@ static int __read_table_ras_info(struct amdgpu_ras_eeprom_control *control)
 				 control->i2c_address + control->ras_info_offset,
 				 buf, RAS_TABLE_V2_1_INFO_SIZE);
 	if (res < RAS_TABLE_V2_1_INFO_SIZE) {
-		DRM_ERROR("Failed to read EEPROM table ras info, res:%d", res);
+		drm_err(adev_to_drm(adev), "Failed to read EEPROM table ras info, res:%d", res);
 		res = res >= 0 ? -EIO : res;
 		goto Out;
 	}
@@ -1386,7 +1386,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 				 control->i2c_address + control->ras_header_offset,
 				 buf, RAS_TABLE_HEADER_SIZE);
 	if (res < RAS_TABLE_HEADER_SIZE) {
-		DRM_ERROR("Failed to read EEPROM table header, res:%d", res);
+		drm_err(adev_to_drm(adev), "Failed to read EEPROM table header, res:%d", res);
 		return res >= 0 ? -EIO : res;
 	}
 
@@ -1440,7 +1440,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 		res = __verify_ras_table_checksum(control);
 		if (res)
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"RAS table incorrect checksum or error:%d\n",
 				res);
 
@@ -1460,7 +1460,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 		res = __verify_ras_table_checksum(control);
 		if (res) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"RAS Table incorrect checksum or error:%d\n",
 				res);
 			return -EINVAL;
@@ -1472,7 +1472,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 			 * so that at least one more record can be saved,
 			 * before the page count threshold is reached.
 			 */
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "records:%d threshold:%d, resetting "
 				 "RAS table header signature",
 				 control->ras_num_bad_pages,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dd98fc292afc8..93d4798a91d38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -279,7 +279,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(struct amdgpu_devic
 
 	reset_domain = kvzalloc(sizeof(struct amdgpu_reset_domain), GFP_KERNEL);
 	if (!reset_domain) {
-		DRM_ERROR("Failed to allocate amdgpu_reset_domain!");
+		drm_err(adev_to_drm(adev), "Failed to allocate amdgpu_reset_domain!");
 		return NULL;
 	}
 
@@ -288,7 +288,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(struct amdgpu_devic
 
 	reset_domain->wq = create_singlethread_workqueue(wq_name);
 	if (!reset_domain->wq) {
-		DRM_ERROR("Failed to allocate wq for amdgpu_reset_domain!");
+		drm_err(adev_to_drm(adev), "Failed to allocate wq for amdgpu_reset_domain!");
 		amdgpu_reset_put_reset_domain(reset_domain);
 		return NULL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf2..b7bd46a0e1910 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -154,7 +154,7 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
 	uint32_t count;
 
 	if (ring->count_dw < 0)
-		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
+		drm_err(adev_to_drm(ring->adev), "amdgpu: writing more dwords to the ring than expected!\n");
 
 	/* We pad to match fetch size */
 	count = ring->funcs->align_mask + 1 -
@@ -249,31 +249,31 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 
 	r = amdgpu_device_wb_get(adev, &ring->rptr_offs);
 	if (r) {
-		dev_err(adev->dev, "(%d) ring rptr_offs wb alloc failed\n", r);
+		drm_err(adev_to_drm(adev), "(%d) ring rptr_offs wb alloc failed\n", r);
 		return r;
 	}
 
 	r = amdgpu_device_wb_get(adev, &ring->wptr_offs);
 	if (r) {
-		dev_err(adev->dev, "(%d) ring wptr_offs wb alloc failed\n", r);
+		drm_err(adev_to_drm(adev), "(%d) ring wptr_offs wb alloc failed\n", r);
 		return r;
 	}
 
 	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
 	if (r) {
-		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
+		drm_err(adev_to_drm(adev), "(%d) ring fence_offs wb alloc failed\n", r);
 		return r;
 	}
 
 	r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
 	if (r) {
-		dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc failed\n", r);
+		drm_err(adev_to_drm(adev), "(%d) ring trail_fence_offs wb alloc failed\n", r);
 		return r;
 	}
 
 	r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
 	if (r) {
-		dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
+		drm_err(adev_to_drm(adev), "(%d) ring cond_exec_polling wb alloc failed\n", r);
 		return r;
 	}
 
@@ -308,7 +308,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	if (ring->funcs->type != AMDGPU_RING_TYPE_CPER) {
 		r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
 		if (r) {
-			dev_err(adev->dev, "failed initializing fences (%d).\n", r);
+			drm_err(adev_to_drm(adev), "failed initializing fences (%d).\n", r);
 			return r;
 		}
 
@@ -341,7 +341,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 					    &ring->gpu_addr,
 					    (void **)&ring->ring);
 		if (r) {
-			dev_err(adev->dev, "(%d) ring create failed\n", r);
+			drm_err(adev_to_drm(adev), "(%d) ring create failed\n", r);
 			return r;
 		}
 		amdgpu_ring_clear_ring(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 1c66da1c3fb42..af037b3604a9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -59,7 +59,7 @@ static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
 	end = s_end & ring->buf_mask;
 
 	if (start == end) {
-		DRM_ERROR("no more data copied from sw ring\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "no more data copied from sw ring\n");
 		return;
 	}
 	if (start > end) {
@@ -92,7 +92,7 @@ static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
 	}
 
 	if (!e) {
-		DRM_ERROR("%s no low priority ring found\n", __func__);
+		drm_err(adev_to_drm(mux->real_ring->adev), "%s no low priority ring found\n", __func__);
 		return;
 	}
 
@@ -139,7 +139,7 @@ static void amdgpu_mux_resubmit_fallback(struct timer_list *t)
 
 	if (!spin_trylock(&mux->lock)) {
 		amdgpu_ring_mux_schedule_resubmit(mux);
-		DRM_ERROR("reschedule resubmit\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "reschedule resubmit\n");
 		return;
 	}
 	amdgpu_mux_resubmit_chunks(mux);
@@ -161,7 +161,7 @@ int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
 
 	amdgpu_mux_chunk_slab = KMEM_CACHE(amdgpu_mux_chunk, SLAB_HWCACHE_ALIGN);
 	if (!amdgpu_mux_chunk_slab) {
-		DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "create amdgpu_mux_chunk cache failed\n");
 		return -ENOMEM;
 	}
 
@@ -196,7 +196,7 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
 	struct amdgpu_mux_entry *e;
 
 	if (mux->num_ring_entries >= mux->ring_entry_size) {
-		DRM_ERROR("add sw ring exceeding max entry size\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "add sw ring exceeding max entry size\n");
 		return -ENOENT;
 	}
 
@@ -220,7 +220,7 @@ void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
 
 	e = amdgpu_ring_mux_sw_entry(mux, ring);
 	if (!e) {
-		DRM_ERROR("cannot find entry for sw ring\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "cannot find entry for sw ring\n");
 		spin_unlock(&mux->lock);
 		return;
 	}
@@ -255,7 +255,7 @@ u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ri
 
 	e = amdgpu_ring_mux_sw_entry(mux, ring);
 	if (!e) {
-		DRM_ERROR("cannot find entry for sw ring\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "cannot find entry for sw ring\n");
 		return 0;
 	}
 
@@ -285,7 +285,7 @@ u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ri
 
 	e = amdgpu_ring_mux_sw_entry(mux, ring);
 	if (!e) {
-		DRM_ERROR("no sw entry found!\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "no sw entry found!\n");
 		return 0;
 	}
 
@@ -440,13 +440,13 @@ void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
 
 	e = amdgpu_ring_mux_sw_entry(mux, ring);
 	if (!e) {
-		DRM_ERROR("cannot find entry!\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "cannot find entry!\n");
 		return;
 	}
 
 	chunk = kmem_cache_alloc(amdgpu_mux_chunk_slab, GFP_KERNEL);
 	if (!chunk) {
-		DRM_ERROR("alloc amdgpu_mux_chunk_slab failed\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "alloc amdgpu_mux_chunk_slab failed\n");
 		return;
 	}
 
@@ -466,7 +466,7 @@ static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct a
 
 	e = amdgpu_ring_mux_sw_entry(mux, ring);
 	if (!e) {
-		DRM_ERROR("cannot find entry!\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "cannot find entry!\n");
 		return;
 	}
 
@@ -489,13 +489,13 @@ void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux,
 
 	e = amdgpu_ring_mux_sw_entry(mux, ring);
 	if (!e) {
-		DRM_ERROR("cannot find entry!\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "cannot find entry!\n");
 		return;
 	}
 
 	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
 	if (!chunk) {
-		DRM_ERROR("cannot find chunk!\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "cannot find chunk!\n");
 		return;
 	}
 
@@ -510,7 +510,7 @@ void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux,
 		chunk->ce_offset = offset;
 		break;
 	default:
-		DRM_ERROR("invalid type (%d)\n", type);
+		drm_err(adev_to_drm(mux->real_ring->adev), "invalid type (%d)\n", type);
 		break;
 	}
 }
@@ -522,13 +522,13 @@ void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *rin
 
 	e = amdgpu_ring_mux_sw_entry(mux, ring);
 	if (!e) {
-		DRM_ERROR("cannot find entry!\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "cannot find entry!\n");
 		return;
 	}
 
 	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
 	if (!chunk) {
-		DRM_ERROR("cannot find chunk!\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "cannot find chunk!\n");
 		return;
 	}
 
@@ -559,7 +559,7 @@ bool amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux *mux)
 	}
 
 	if (!ring) {
-		DRM_ERROR("cannot find low priority ring\n");
+		drm_err(adev_to_drm(mux->real_ring->adev), "cannot find low priority ring\n");
 		return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index db5791e1a7cef..85cbf5cf3defa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -101,7 +101,7 @@ int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws)
 				      &adev->gfx.rlc.save_restore_gpu_addr,
 				      (void **)&adev->gfx.rlc.sr_ptr);
 	if (r) {
-		dev_warn(adev->dev, "(%d) create RLC sr bo failed\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) create RLC sr bo failed\n", r);
 		amdgpu_gfx_rlc_fini(adev);
 		return r;
 	}
@@ -139,7 +139,7 @@ int amdgpu_gfx_rlc_init_csb(struct amdgpu_device *adev)
 				      &adev->gfx.rlc.clear_state_gpu_addr,
 				      (void **)&adev->gfx.rlc.cs_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create rlc csb bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create rlc csb bo\n", r);
 		amdgpu_gfx_rlc_fini(adev);
 		return r;
 	}
@@ -166,7 +166,7 @@ int amdgpu_gfx_rlc_init_cpt(struct amdgpu_device *adev)
 				      &adev->gfx.rlc.cp_table_gpu_addr,
 				      (void **)&adev->gfx.rlc.cp_table_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create cp table bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create cp table bo\n", r);
 		amdgpu_gfx_rlc_fini(adev);
 		return r;
 	}
@@ -312,7 +312,7 @@ static int amdgpu_gfx_rlc_init_microcode_v2_0(struct amdgpu_device *adev)
 		kmalloc(adev->gfx.rlc.reg_list_format_size_bytes +
 			adev->gfx.rlc.reg_list_size_bytes, GFP_KERNEL);
 	if (!adev->gfx.rlc.register_list_format) {
-		dev_err(adev->dev, "failed to allocate memory for rlc register_list_format\n");
+		drm_err(adev_to_drm(adev), "failed to allocate memory for rlc register_list_format\n");
 		return -ENOMEM;
 	}
 
@@ -523,7 +523,7 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 
 	if (version_major < 2) {
 		/* only support rlc_hdr v2.x and onwards */
-		dev_err(adev->dev, "unsupported rlc fw hdr\n");
+		drm_err(adev_to_drm(adev), "unsupported rlc fw hdr\n");
 		return -EINVAL;
 	}
 
@@ -533,7 +533,7 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 
 	err = amdgpu_gfx_rlc_init_microcode_v2_0(adev);
 	if (err) {
-		dev_err(adev->dev, "fail to init rlc v2_0 microcode\n");
+		drm_err(adev_to_drm(adev), "fail to init rlc v2_0 microcode\n");
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 39070b2a4c04f..fa1dd9c382c53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -54,7 +54,7 @@ int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
 				    &sa_manager->bo, &sa_manager->gpu_addr,
 				    &sa_manager->cpu_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to allocate bo for manager\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate bo for manager\n", r);
 		return r;
 	}
 
@@ -67,7 +67,7 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
 			       struct amdgpu_sa_manager *sa_manager)
 {
 	if (sa_manager->bo == NULL) {
-		dev_err(adev->dev, "no bo for sa manager\n");
+		drm_err(adev_to_drm(adev), "no bo for sa manager\n");
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index b0a8abc7a8ecf..7a4ae6fc04cc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -108,7 +108,7 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
 		break;
 	default:
-		DRM_ERROR("Invalid sched op specified: %d\n", args->in.op);
+		drm_err(adev_to_drm(adev), "Invalid sched op specified: %d\n", args->in.op);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 0a9893fee8285..ace529eea4223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -321,7 +321,7 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register sdma ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register sdma ras block!\n");
 		return err;
 	}
 
@@ -594,7 +594,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		if (funcs->pre_reset) {
 			ret = funcs->pre_reset(adev, instance_id);
 			if (ret) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 				"beforeReset callback failed for instance %u: %d\n",
 					instance_id, ret);
 				goto exit;
@@ -605,7 +605,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
 	if (ret) {
-		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
+		drm_err(adev_to_drm(adev), "Failed to reset SDMA instance %u\n", instance_id);
 		goto exit;
 	}
 
@@ -614,7 +614,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		if (funcs->post_reset) {
 			ret = funcs->post_reset(adev, instance_id);
 			if (ret) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 				"afterReset callback failed for instance %u: %d\n",
 					instance_id, ret);
 				goto exit;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 41ebe690eeffa..6ee8de66c2d89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -127,7 +127,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUERY_TA);
 		if (!ret) {
 			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS)
-				dev_info(adev->dev, "SECUREDISPLAY: query securedisplay TA ret is 0x%X\n",
+				drm_info(adev_to_drm(adev), "SECUREDISPLAY: query securedisplay TA ret is 0x%X\n",
 					securedisplay_cmd->securedisplay_out_message.query_ta.query_cmd_ret);
 			else
 				psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
@@ -136,7 +136,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		break;
 	case 2:
 		if (size < 3 || phy_id >= TA_SECUREDISPLAY_MAX_PHY) {
-			dev_err(adev->dev, "Invalid input: %s\n", str);
+			drm_err(adev_to_drm(adev), "Invalid input: %s\n", str);
 			return -EINVAL;
 		}
 		mutex_lock(&psp->securedisplay_context.mutex);
@@ -146,7 +146,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
 		if (!ret) {
 			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
-				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is: %*ph\n",
+				drm_info(adev_to_drm(adev), "SECUREDISPLAY: I2C buffer out put is: %*ph\n",
 					 TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
 					 securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);
 			} else {
@@ -156,7 +156,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		mutex_unlock(&psp->securedisplay_context.mutex);
 		break;
 	default:
-		dev_err(adev->dev, "Invalid input: %s\n", str);
+		drm_err(adev_to_drm(adev), "Invalid input: %s\n", str);
 	}
 
 	pm_runtime_mark_last_busy(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 3939761be31c9..fb3a06fec80e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -98,14 +98,14 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
 			     va_flags);
 	if (r) {
-		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
+		drm_err(adev_to_drm(adev), "failed to do bo_map on userq sem, err=%d\n", r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		goto error;
 	}
 
 	r = amdgpu_vm_bo_update(adev, *bo_va, false);
 	if (r) {
-		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
+		drm_err(adev_to_drm(adev), "failed to do vm_bo_update on userq sem\n");
 		amdgpu_vm_bo_del(adev, *bo_va);
 		goto error;
 	}
@@ -249,7 +249,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
 				    &adev->seq64.sbo, &adev->seq64.gpu_addr,
 				    (void **)&adev->seq64.cpu_base_addr);
 	if (r) {
-		dev_warn(adev->dev, "(%d) create seq64 failed\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) create seq64 failed\n", r);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e8d7c23f22c6a..500cbdf4d20c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -299,7 +299,7 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	struct amdgpu_bo *abo_src, *abo_dst;
 
 	if (!adev->mman.buffer_funcs_enabled) {
-		DRM_ERROR("Trying to move memory with ring turned off.\n");
+		drm_err(adev_to_drm(adev), "Trying to move memory with ring turned off.\n");
 		return -EINVAL;
 	}
 
@@ -934,7 +934,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
 	if (gtt->userptr) {
 		r = amdgpu_ttm_tt_pin_userptr(bdev, ttm);
 		if (r) {
-			DRM_ERROR("failed to pin userptr\n");
+			drm_err(adev_to_drm(adev), "failed to pin userptr\n");
 			return r;
 		}
 	} else if (ttm->page_flags & TTM_TT_FLAG_EXTERNAL) {
@@ -1729,7 +1729,7 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev,
 	ctx->train_data_size =
 		GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES;
 
-	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
+	drm_dbg(adev_to_drm(adev), "train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
 			ctx->train_data_size,
 			ctx->p2c_train_data_offset,
 			ctx->c2p_train_data_offset);
@@ -1750,7 +1750,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		if (amdgpu_atomfirmware_mem_training_supported(adev))
 			mem_train_support = true;
 		else
-			DRM_DEBUG("memory training does not support!\n");
+			drm_dbg(adev_to_drm(adev), "memory training does not support!\n");
 	}
 
 	/*
@@ -1781,7 +1781,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 						 &ctx->c2p_bo,
 						 NULL);
 		if (ret) {
-			DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
+			drm_err(adev_to_drm(adev), "alloc c2p_bo failed(%d)!\n", ret);
 			amdgpu_ttm_training_reserve_vram_fini(adev);
 			return ret;
 		}
@@ -1793,13 +1793,13 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 			adev, adev->gmc.real_vram_size - reserve_size,
 			reserve_size, &adev->mman.fw_reserved_memory, NULL);
 		if (ret) {
-			DRM_ERROR("alloc tmr failed(%d)!\n", ret);
+			drm_err(adev_to_drm(adev), "alloc tmr failed(%d)!\n", ret);
 			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
 					      NULL, NULL);
 			return ret;
 		}
 	} else {
-		DRM_DEBUG_DRIVER("backdoor fw loading path for PSP TMR, no reservation needed\n");
+		drm_dbg_driver(adev_to_drm(adev), "backdoor fw loading path for PSP TMR, no reservation needed\n");
 	}
 
 	return 0;
@@ -1864,13 +1864,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 			       adev->need_swiotlb,
 			       dma_addressing_limited(adev->dev));
 	if (r) {
-		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
+		drm_err(adev_to_drm(adev), "Failed initializing buffer object driver(%d).\n", r);
 		return r;
 	}
 
 	r = amdgpu_ttm_pools_init(adev);
 	if (r) {
-		DRM_ERROR("failed to init ttm pools(%d).\n", r);
+		drm_err(adev_to_drm(adev), "failed to init ttm pools(%d).\n", r);
 		return r;
 	}
 	adev->mman.initialized = true;
@@ -1878,7 +1878,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* Initialize VRAM pool with all of VRAM divided into pages */
 	r = amdgpu_vram_mgr_init(adev);
 	if (r) {
-		DRM_ERROR("Failed initializing VRAM heap.\n");
+		drm_err(adev_to_drm(adev), "Failed initializing VRAM heap.\n");
 		return r;
 	}
 
@@ -1891,7 +1891,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 				adev->gmc.visible_vram_size);
 
 	else if (adev->gmc.is_app_apu)
-		DRM_DEBUG_DRIVER(
+		drm_dbg_driver(adev_to_drm(adev),
 			"No need to ioremap when real vram size is 0\n");
 	else
 #endif
@@ -1955,10 +1955,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	} else {
-		DRM_DEBUG_DRIVER("Skipped stolen memory reservation\n");
+		drm_dbg_driver(adev_to_drm(adev), "Skipped stolen memory reservation\n");
 	}
 
-	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
+	drm_info(adev_to_drm(adev), "%uM of VRAM memory ready\n",
 		 (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024)));
 
 	/* Compute GTT size, either based on TTM limit
@@ -1981,10 +1981,10 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* Initialize GTT memory pool */
 	r = amdgpu_gtt_mgr_init(adev, gtt_size);
 	if (r) {
-		DRM_ERROR("Failed initializing GTT heap.\n");
+		drm_err(adev_to_drm(adev), "Failed initializing GTT heap.\n");
 		return r;
 	}
-	DRM_INFO("amdgpu: %uM of GTT memory ready.\n",
+	drm_info(adev_to_drm(adev), "%uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
 	if (adev->flags & AMD_IS_APU) {
@@ -1995,47 +1995,47 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* Initialize doorbell pool on PCI BAR */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_DOORBELL, adev->doorbell.size / PAGE_SIZE);
 	if (r) {
-		DRM_ERROR("Failed initializing doorbell heap.\n");
+		drm_err(adev_to_drm(adev), "Failed initializing doorbell heap.\n");
 		return r;
 	}
 
 	/* Create a boorbell page for kernel usages */
 	r = amdgpu_doorbell_create_kernel_doorbells(adev);
 	if (r) {
-		DRM_ERROR("Failed to initialize kernel doorbells.\n");
+		drm_err(adev_to_drm(adev), "Failed to initialize kernel doorbells.\n");
 		return r;
 	}
 
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
-		DRM_ERROR("Failed initializing PREEMPT heap.\n");
+		drm_err(adev_to_drm(adev), "Failed initializing PREEMPT heap.\n");
 		return r;
 	}
 
 	/* Initialize various on-chip memory pools */
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_GDS, adev->gds.gds_size);
 	if (r) {
-		DRM_ERROR("Failed initializing GDS heap.\n");
+		drm_err(adev_to_drm(adev), "Failed initializing GDS heap.\n");
 		return r;
 	}
 
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_GWS, adev->gds.gws_size);
 	if (r) {
-		DRM_ERROR("Failed initializing gws heap.\n");
+		drm_err(adev_to_drm(adev), "Failed initializing gws heap.\n");
 		return r;
 	}
 
 	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_OA, adev->gds.oa_size);
 	if (r) {
-		DRM_ERROR("Failed initializing oa heap.\n");
+		drm_err(adev_to_drm(adev), "Failed initializing oa heap.\n");
 		return r;
 	}
 	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_GTT,
 				&adev->mman.sdma_access_bo, NULL,
 				&adev->mman.sdma_access_ptr))
-		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
+		drm_warn(adev_to_drm(adev), "Debug VRAM access will use slowpath MM access\n");
 
 	return 0;
 }
@@ -2087,7 +2087,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
-	DRM_INFO("amdgpu: ttm finalized\n");
+	drm_info(adev_to_drm(adev), "amdgpu: ttm finalized\n");
 }
 
 /**
@@ -2119,7 +2119,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 					  DRM_SCHED_PRIORITY_KERNEL, &sched,
 					  1, NULL);
 		if (r) {
-			DRM_ERROR("Failed setting up TTM BO move entity (%d)\n",
+			drm_err(adev_to_drm(adev), "Failed setting up TTM BO move entity (%d)\n",
 				  r);
 			return;
 		}
@@ -2128,7 +2128,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 					  DRM_SCHED_PRIORITY_NORMAL, &sched,
 					  1, NULL);
 		if (r) {
-			DRM_ERROR("Failed setting up TTM BO move entity (%d)\n",
+			drm_err(adev_to_drm(adev), "Failed setting up TTM BO move entity (%d)\n",
 				  r);
 			goto error_free_entity;
 		}
@@ -2200,7 +2200,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	int r;
 
 	if (!direct_submit && !ring->sched.ready) {
-		DRM_ERROR("Trying to move memory with ring turned off.\n");
+		drm_err(adev_to_drm(adev), "Trying to move memory with ring turned off.\n");
 		return -EINVAL;
 	}
 
@@ -2235,7 +2235,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 
 error_free:
 	amdgpu_job_free(job);
-	DRM_ERROR("Error scheduling IBs (%d)\n", r);
+	drm_err(adev_to_drm(adev), "Error scheduling IBs (%d)\n", r);
 	return r;
 }
 
@@ -2354,7 +2354,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 	int r;
 
 	if (!adev->mman.buffer_funcs_enabled) {
-		DRM_ERROR("Trying to clear memory with ring turned off.\n");
+		drm_err(adev_to_drm(adev), "Trying to clear memory with ring turned off.\n");
 		return -EINVAL;
 	}
 
@@ -2414,7 +2414,7 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
 		man = ttm_manager_type(&adev->mman.bdev, mem_type);
 		break;
 	default:
-		DRM_ERROR("Trying to evict invalid memory type\n");
+		drm_err(adev_to_drm(adev), "Trying to evict invalid memory type\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 0a1ef95b28668..8fdaf2009bbf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -38,7 +38,7 @@ static int amdgpu_umc_convert_error_address(struct amdgpu_device *adev,
 				err_data, err_addr, ch_inst, umc_inst);
 		break;
 	default:
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "UMC address to Physical address translation is not supported\n");
 		return AMDGPU_RAS_FAIL;
 	}
@@ -60,7 +60,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 		kcalloc(adev->umc.max_ras_err_cnt_per_query,
 			sizeof(struct eeprom_table_record), GFP_KERNEL);
 	if (!err_data.err_addr) {
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			"Failed to alloc memory for umc error record in MCA notifier!\n");
 		ret = AMDGPU_RAS_FAIL;
 		goto out_fini_err_data;
@@ -121,7 +121,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			 * even NOMEM error is encountered
 			 */
 			if(!err_data->err_addr)
-				dev_warn(adev->dev, "Failed to alloc memory for "
+				drm_warn(adev_to_drm(adev), "Failed to alloc memory for "
 						"umc error address record!\n");
 			else
 				err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
@@ -148,7 +148,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			 * even NOMEM error is encountered
 			 */
 			if(!err_data->err_addr)
-				dev_warn(adev->dev, "Failed to alloc memory for "
+				drm_warn(adev_to_drm(adev), "Failed to alloc memory for "
 						"umc error address record!\n");
 			else
 				err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
@@ -259,7 +259,7 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_device *adev,
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
 			adev->virt.ops->ras_poison_handler(adev, block);
 		else
-			dev_warn(adev->dev,
+			drm_warn(adev_to_drm(adev),
 				"No ras_poison_handler interface in SRIOV!\n");
 	}
 
@@ -293,7 +293,7 @@ int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev)
 
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register umc ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register umc ras block!\n");
 		return err;
 	}
 
@@ -415,7 +415,7 @@ static int amdgpu_umc_loop_all_aid(struct amdgpu_device *adev, umc_func func,
 				node_inst, umc_inst, ch_inst);
 			ret = func(adev, node_inst, umc_inst, ch_inst, data);
 			if (ret) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 					"Node %d umc %d ch %d func returns %d\n",
 					node_inst, umc_inst, ch_inst, ret);
 				return ret;
@@ -441,7 +441,7 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 		LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
 			ret = func(adev, node_inst, umc_inst, ch_inst, data);
 			if (ret) {
-				dev_err(adev->dev, "Node %d umc %d ch %d func returns %d\n",
+				drm_err(adev_to_drm(adev), "Node %d umc %d ch %d func returns %d\n",
 					node_inst, umc_inst, ch_inst, ret);
 				return ret;
 			}
@@ -450,7 +450,7 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
 		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
 			ret = func(adev, 0, umc_inst, ch_inst, data);
 			if (ret) {
-				dev_err(adev->dev, "Umc %d ch %d func returns %d\n",
+				drm_err(adev_to_drm(adev), "Umc %d ch %d func returns %d\n",
 					umc_inst, ch_inst, ret);
 				return ret;
 			}
@@ -514,7 +514,7 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 	err_data.err_addr = kcalloc(adev->umc.retire_unit,
 				sizeof(struct eeprom_table_record), GFP_KERNEL);
 	if (!err_data.err_addr) {
-		dev_warn(adev->dev, "Failed to alloc memory in bad page lookup!\n");
+		drm_warn(adev_to_drm(adev), "Failed to alloc memory in bad page lookup!\n");
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index cd707d70a0bf8..69b9a6d309d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -55,7 +55,7 @@ int amdgpu_umsch_mm_query_fence(struct amdgpu_umsch_mm *umsch)
 
 	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, adev->usec_timeout);
 	if (r < 1) {
-		dev_err(adev->dev, "ring umsch timeout, emitted fence %u\n",
+		drm_err(adev_to_drm(adev), "ring umsch timeout, emitted fence %u\n",
 			ring->fence_drv.sync_seq);
 		return -ETIMEDOUT;
 	}
@@ -195,7 +195,7 @@ int amdgpu_umsch_mm_allocate_ucode_buffer(struct amdgpu_umsch_mm *umsch)
 				      &adev->umsch_mm.ucode_fw_gpu_addr,
 				      (void **)&adev->umsch_mm.ucode_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create umsch_mm fw ucode bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create umsch_mm fw ucode bo\n", r);
 		return r;
 	}
 
@@ -227,7 +227,7 @@ int amdgpu_umsch_mm_allocate_ucode_data_buffer(struct amdgpu_umsch_mm *umsch)
 				      &adev->umsch_mm.data_fw_gpu_addr,
 				      (void **)&adev->umsch_mm.data_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create umsch_mm fw data bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create umsch_mm fw data bo\n", r);
 		return r;
 	}
 
@@ -274,7 +274,7 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 
 	r = amdgpu_device_wb_get(adev, &adev->umsch_mm.wb_index);
 	if (r) {
-		dev_err(adev->dev, "failed to alloc wb for umsch: %d\n", r);
+		drm_err(adev_to_drm(adev), "failed to alloc wb for umsch: %d\n", r);
 		return r;
 	}
 
@@ -287,7 +287,7 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 				    &adev->umsch_mm.cmd_buf_gpu_addr,
 				    (void **)&adev->umsch_mm.cmd_buf_ptr);
 	if (r) {
-		dev_err(adev->dev, "failed to allocate cmdbuf bo %d\n", r);
+		drm_err(adev_to_drm(adev), "failed to allocate cmdbuf bo %d\n", r);
 		amdgpu_device_wb_free(adev, adev->umsch_mm.wb_index);
 		return r;
 	}
@@ -299,7 +299,7 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 				    &adev->umsch_mm.log_gpu_addr,
 				    &adev->umsch_mm.log_cpu_addr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to allocate umsch debug bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate umsch debug bo\n", r);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 74758b5ffc6c8..acf68264ed2d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -262,7 +262,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 
 	r = amdgpu_ucode_request(adev, &adev->uvd.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
 	if (r) {
-		dev_err(adev->dev, "amdgpu_uvd: Can't validate firmware \"%s\"\n",
+		drm_err(adev_to_drm(adev), "amdgpu_uvd: Can't validate firmware \"%s\"\n",
 			fw_name);
 		amdgpu_ucode_release(&adev->uvd.fw);
 		return r;
@@ -279,7 +279,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		DRM_INFO("Found UVD firmware Version: %u.%u Family ID: %u\n",
+		drm_info(adev_to_drm(adev), "Found UVD firmware Version: %u.%u Family ID: %u\n",
 			version_major, version_minor, family_id);
 
 		/*
@@ -298,7 +298,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		if ((adev->asic_type == CHIP_POLARIS10 ||
 		     adev->asic_type == CHIP_POLARIS11) &&
 		    (adev->uvd.fw_version < FW_1_66_16))
-			DRM_ERROR("POLARIS10/11 UVD firmware version %u.%u is too old.\n",
+			drm_err(adev_to_drm(adev), "POLARIS10/11 UVD firmware version %u.%u is too old.\n",
 				  version_major, version_minor);
 	} else {
 		unsigned int enc_major, enc_minor, dec_minor;
@@ -306,7 +306,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		dec_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
 		enc_minor = (le32_to_cpu(hdr->ucode_version) >> 24) & 0x3f;
 		enc_major = (le32_to_cpu(hdr->ucode_version) >> 30) & 0x3;
-		DRM_INFO("Found UVD firmware ENC: %u.%u DEC: .%u Family ID: %u\n",
+		drm_info(adev_to_drm(adev), "Found UVD firmware ENC: %u.%u DEC: .%u Family ID: %u\n",
 			enc_major, enc_minor, dec_minor, family_id);
 
 		adev->uvd.max_handles = AMDGPU_MAX_UVD_HANDLES;
@@ -329,7 +329,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 					    &adev->uvd.inst[j].gpu_addr,
 					    &adev->uvd.inst[j].cpu_addr);
 		if (r) {
-			dev_err(adev->dev, "(%d) failed to allocate UVD bo\n", r);
+			drm_err(adev_to_drm(adev), "(%d) failed to allocate UVD bo\n", r);
 			return r;
 		}
 	}
@@ -411,7 +411,7 @@ int amdgpu_uvd_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 		r = drm_sched_entity_init(&adev->uvd.entity, DRM_SCHED_PRIORITY_NORMAL,
 					  &sched, 1, NULL);
 		if (r) {
-			DRM_ERROR("Failed setting up UVD kernel entity.\n");
+			drm_err(adev_to_drm(adev), "Failed setting up UVD kernel entity.\n");
 			return r;
 		}
 	}
@@ -531,7 +531,7 @@ void amdgpu_uvd_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
 			r = amdgpu_uvd_get_destroy_msg(ring, handle, false,
 						       &fence);
 			if (r) {
-				DRM_ERROR("Error destroying UVD %d!\n", r);
+				drm_err(adev_to_drm(adev), "Error destroying UVD %d!\n", r);
 				continue;
 			}
 
@@ -587,7 +587,7 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
 
 	r = amdgpu_cs_find_mapping(ctx->parser, addr, &bo, &mapping);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
+		drm_err(adev_to_drm(ctx->parser->adev), "Can't find BO for addr 0x%08llx\n", addr);
 		return r;
 	}
 
@@ -780,17 +780,17 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		break;
 
 	default:
-		DRM_ERROR("UVD codec not handled %d!\n", stream_type);
+		drm_err(adev_to_drm(adev), "UVD codec not handled %d!\n", stream_type);
 		return -EINVAL;
 	}
 
 	if (width > pitch) {
-		DRM_ERROR("Invalid UVD decoding target pitch!\n");
+		drm_err(adev_to_drm(adev), "Invalid UVD decoding target pitch!\n");
 		return -EINVAL;
 	}
 
 	if (dpb_size < min_dpb_size) {
-		DRM_ERROR("Invalid dpb_size in UVD message (%d / %d)!\n",
+		drm_err(adev_to_drm(adev), "Invalid dpb_size in UVD message (%d / %d)!\n",
 			  dpb_size, min_dpb_size);
 		return -EINVAL;
 	}
@@ -823,13 +823,13 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 	int i;
 
 	if (offset & 0x3F) {
-		DRM_ERROR("UVD messages must be 64 byte aligned!\n");
+		drm_err(adev_to_drm(adev), "UVD messages must be 64 byte aligned!\n");
 		return -EINVAL;
 	}
 
 	r = amdgpu_bo_kmap(bo, &ptr);
 	if (r) {
-		DRM_ERROR("Failed mapping the UVD) message (%ld)!\n", r);
+		drm_err(adev_to_drm(adev), "Failed mapping the UVD) message (%ld)!\n", r);
 		return r;
 	}
 
@@ -840,7 +840,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 
 	if (handle == 0) {
 		amdgpu_bo_kunmap(bo);
-		DRM_ERROR("Invalid UVD handle!\n");
+		drm_err(adev_to_drm(adev), "Invalid UVD handle!\n");
 		return -EINVAL;
 	}
 
@@ -852,7 +852,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 		/* try to alloc a new handle */
 		for (i = 0; i < adev->uvd.max_handles; ++i) {
 			if (atomic_read(&adev->uvd.handles[i]) == handle) {
-				DRM_ERROR(")Handle 0x%x already in use!\n",
+				drm_err(adev_to_drm(adev), ")Handle 0x%x already in use!\n",
 					  handle);
 				return -EINVAL;
 			}
@@ -863,7 +863,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 			}
 		}
 
-		DRM_ERROR("No more free UVD handles!\n");
+		drm_err(adev_to_drm(adev), "No more free UVD handles!\n");
 		return -ENOSPC;
 
 	case 1:
@@ -877,14 +877,14 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 		for (i = 0; i < adev->uvd.max_handles; ++i) {
 			if (atomic_read(&adev->uvd.handles[i]) == handle) {
 				if (adev->uvd.filp[i] != ctx->parser->filp) {
-					DRM_ERROR("UVD handle collision detected!\n");
+					drm_err(adev_to_drm(adev), "UVD handle collision detected!\n");
 					return -EINVAL;
 				}
 				return 0;
 			}
 		}
 
-		DRM_ERROR("Invalid UVD handle 0x%x!\n", handle);
+		drm_err(adev_to_drm(adev), "Invalid UVD handle 0x%x!\n", handle);
 		return -ENOENT;
 
 	case 2:
@@ -895,7 +895,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 		return 0;
 
 	default:
-		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
+		drm_err(adev_to_drm(adev), "Illegal UVD message type (%d)!\n", msg_type);
 	}
 
 	amdgpu_bo_kunmap(bo);
@@ -920,7 +920,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 
 	r = amdgpu_cs_find_mapping(ctx->parser, addr, &bo, &mapping);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
+		drm_err(adev_to_drm(ctx->parser->adev), "Can't find BO for addr 0x%08llx\n", addr);
 		return r;
 	}
 
@@ -938,7 +938,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 	cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx) >> 1;
 	if (cmd < 0x4) {
 		if ((end - start) < ctx->buf_sizes[cmd]) {
-			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
+			drm_err(adev_to_drm(ctx->parser->adev), "buffer (%d) to small (%d / %d)!\n", cmd,
 				  (unsigned int)(end - start),
 				  ctx->buf_sizes[cmd]);
 			return -EINVAL;
@@ -946,26 +946,26 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 
 	} else if (cmd == 0x206) {
 		if ((end - start) < ctx->buf_sizes[4]) {
-			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
+			drm_err(adev_to_drm(ctx->parser->adev), "buffer (%d) to small (%d / %d)!\n", cmd,
 					  (unsigned int)(end - start),
 					  ctx->buf_sizes[4]);
 			return -EINVAL;
 		}
 	} else if ((cmd != 0x100) && (cmd != 0x204)) {
-		DRM_ERROR("invalid UVD command %X!\n", cmd);
+		drm_err(adev_to_drm(ctx->parser->adev), "invalid UVD command %X!\n", cmd);
 		return -EINVAL;
 	}
 
 	if (!ctx->parser->adev->uvd.address_64_bit) {
 		if ((start >> 28) != ((end - 1) >> 28)) {
-			DRM_ERROR("reloc %llx-%llx crossing 256MB boundary!\n",
+			drm_err(adev_to_drm(ctx->parser->adev), "reloc %llx-%llx crossing 256MB boundary!\n",
 				  start, end);
 			return -EINVAL;
 		}
 
 		if ((cmd == 0 || cmd == 0x3) &&
 		    (start >> 28) != (ctx->parser->adev->uvd.inst->gpu_addr >> 28)) {
-			DRM_ERROR("msg/fb buffer %llx-%llx out of 256MB segment!\n",
+			drm_err(adev_to_drm(ctx->parser->adev), "msg/fb buffer %llx-%llx out of 256MB segment!\n",
 				  start, end);
 			return -EINVAL;
 		}
@@ -977,7 +977,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 		if (r)
 			return r;
 	} else if (!ctx->has_msg_cmd) {
-		DRM_ERROR("Message needed before other commands are send!\n");
+		drm_err(adev_to_drm(ctx->parser->adev), "Message needed before other commands are send!\n");
 		return -EINVAL;
 	}
 
@@ -1002,7 +1002,7 @@ static int amdgpu_uvd_cs_reg(struct amdgpu_uvd_cs_ctx *ctx,
 		unsigned int reg = ctx->reg + i;
 
 		if (ctx->idx >= ctx->ib->length_dw) {
-			DRM_ERROR("Register command after end of CS!\n");
+			drm_err(adev_to_drm(ctx->parser->adev), "Register command after end of CS!\n");
 			return -EINVAL;
 		}
 
@@ -1022,7 +1022,7 @@ static int amdgpu_uvd_cs_reg(struct amdgpu_uvd_cs_ctx *ctx,
 		case mmUVD_NO_OP:
 			break;
 		default:
-			DRM_ERROR("Invalid reg 0x%X!\n", reg);
+			drm_err(adev_to_drm(ctx->parser->adev), "Invalid reg 0x%X!\n", reg);
 			return -EINVAL;
 		}
 		ctx->idx++;
@@ -1059,7 +1059,7 @@ static int amdgpu_uvd_cs_packets(struct amdgpu_uvd_cs_ctx *ctx,
 			++ctx->idx;
 			break;
 		default:
-			DRM_ERROR("Unknown packet type %d !\n", type);
+			drm_err(adev_to_drm(ctx->parser->adev), "Unknown packet type %d !\n", type);
 			return -EINVAL;
 		}
 	}
@@ -1092,7 +1092,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
 	job->vm = NULL;
 
 	if (ib->length_dw % 16) {
-		DRM_ERROR("UVD IB length (%d) not 16 dwords aligned!\n",
+		drm_err(adev_to_drm(parser->adev), "UVD IB length (%d) not 16 dwords aligned!\n",
 			  ib->length_dw);
 		return -EINVAL;
 	}
@@ -1115,7 +1115,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
 		return r;
 
 	if (!ctx.has_msg_cmd) {
-		DRM_ERROR("UVD-IBs need a msg command!\n");
+		drm_err(adev_to_drm(parser->adev), "UVD-IBs need a msg command!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b9060bcd48064..51911b5beb561 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -160,7 +160,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 
 	r = amdgpu_ucode_request(adev, &adev->vce.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
 	if (r) {
-		dev_err(adev->dev, "amdgpu_vce: Can't validate firmware \"%s\"\n",
+		drm_err(adev_to_drm(adev), "amdgpu_vce: Can't validate firmware \"%s\"\n",
 			fw_name);
 		amdgpu_ucode_release(&adev->vce.fw);
 		return r;
@@ -172,7 +172,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 	version_major = (ucode_version >> 20) & 0xfff;
 	version_minor = (ucode_version >> 8) & 0xfff;
 	binary_id = ucode_version & 0xff;
-	DRM_INFO("Found VCE firmware Version: %d.%d Binary ID: %d\n",
+	drm_info(adev_to_drm(adev), "Found VCE firmware Version: %d.%d Binary ID: %d\n",
 		version_major, version_minor, binary_id);
 	adev->vce.fw_version = ((version_major << 24) | (version_minor << 16) |
 				(binary_id << 8));
@@ -183,7 +183,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 				    &adev->vce.vcpu_bo,
 				    &adev->vce.gpu_addr, &adev->vce.cpu_addr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to allocate VCE bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate VCE bo\n", r);
 		return r;
 	}
 
@@ -243,7 +243,7 @@ int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 		r = drm_sched_entity_init(&adev->vce.entity, DRM_SCHED_PRIORITY_NORMAL,
 					  &sched, 1, NULL);
 		if (r != 0) {
-			DRM_ERROR("Failed setting up VCE run queue.\n");
+			drm_err(adev_to_drm(adev), "Failed setting up VCE run queue.\n");
 			return r;
 		}
 	}
@@ -295,14 +295,14 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
 
 	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to reserve VCE bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to reserve VCE bo\n", r);
 		return r;
 	}
 
 	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
 	if (r) {
 		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
-		dev_err(adev->dev, "(%d) VCE map failed\n", r);
+		drm_err(adev_to_drm(adev), "(%d) VCE map failed\n", r);
 		return r;
 	}
 
@@ -419,7 +419,7 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
 
 		r = amdgpu_vce_get_destroy_msg(ring, handle, false, NULL);
 		if (r)
-			DRM_ERROR("Error destroying VCE handle (%d)!\n", r);
+			drm_err(adev_to_drm(adev), "Error destroying VCE handle (%d)!\n", r);
 
 		adev->vce.filp[i] = NULL;
 		atomic_set(&adev->vce.handles[i], 0);
@@ -621,7 +621,7 @@ static int amdgpu_vce_validate_bo(struct amdgpu_cs_parser *p,
 
 	r = amdgpu_cs_find_mapping(p, addr, &bo, &mapping);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%010llx %d %d %d %d\n",
+		drm_err(adev_to_drm(p->adev), "Can't find BO for addr 0x%010llx %d %d %d %d\n",
 			  addr, lo, hi, size, index);
 		return r;
 	}
@@ -664,14 +664,14 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
 
 	r = amdgpu_cs_find_mapping(p, addr, &bo, &mapping);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%010llx %d %d %d %d\n",
+		drm_err(adev_to_drm(p->adev), "Can't find BO for addr 0x%010llx %d %d %d %d\n",
 			  addr, lo, hi, size, index);
 		return r;
 	}
 
 	if ((addr + (uint64_t)size) >
 	    (mapping->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
-		DRM_ERROR("BO too small for addr 0x%010llx %d %d\n",
+		drm_err(adev_to_drm(p->adev), "BO too small for addr 0x%010llx %d %d\n",
 			  addr, lo, hi);
 		return -EINVAL;
 	}
@@ -705,7 +705,7 @@ static int amdgpu_vce_validate_handle(struct amdgpu_cs_parser *p,
 	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
 		if (atomic_read(&p->adev->vce.handles[i]) == handle) {
 			if (p->adev->vce.filp[i] != p->filp) {
-				DRM_ERROR("VCE handle collision detected!\n");
+				drm_err(adev_to_drm(p->adev), "VCE handle collision detected!\n");
 				return -EINVAL;
 			}
 			return i;
@@ -722,7 +722,7 @@ static int amdgpu_vce_validate_handle(struct amdgpu_cs_parser *p,
 		}
 	}
 
-	DRM_ERROR("No more free VCE handles!\n");
+	drm_err(adev_to_drm(p->adev), "No more free VCE handles!\n");
 	return -EINVAL;
 }
 
@@ -755,7 +755,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 		uint32_t cmd = amdgpu_ib_get_value(ib, idx + 1);
 
 		if ((len < 8) || (len & 3)) {
-			DRM_ERROR("invalid VCE command length (%d)!\n", len);
+			drm_err(adev_to_drm(p->adev), "invalid VCE command length (%d)!\n", len);
 			r = -EINVAL;
 			goto out;
 		}
@@ -844,7 +844,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 				allocated |= 1 << session_idx;
 
 			} else if (!(allocated & (1 << session_idx))) {
-				DRM_ERROR("Handle already in use!\n");
+				drm_err(adev_to_drm(p->adev), "Handle already in use!\n");
 				r = -EINVAL;
 				goto out;
 			}
@@ -929,13 +929,13 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 			break;
 
 		default:
-			DRM_ERROR("invalid VCE command (0x%x)!\n", cmd);
+			drm_err(adev_to_drm(p->adev), "invalid VCE command (0x%x)!\n", cmd);
 			r = -EINVAL;
 			goto out;
 		}
 
 		if (session_idx == -1) {
-			DRM_ERROR("no session command at start of IB\n");
+			drm_err(adev_to_drm(p->adev), "no session command at start of IB\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -944,7 +944,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 	}
 
 	if (allocated & ~created) {
-		DRM_ERROR("New session without create command!\n");
+		drm_err(adev_to_drm(p->adev), "New session without create command!\n");
 		r = -ENOENT;
 	}
 
@@ -987,7 +987,7 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
 		uint32_t cmd = amdgpu_ib_get_value(ib, idx + 1);
 
 		if ((len < 8) || (len & 3)) {
-			DRM_ERROR("invalid VCE command length (%d)!\n", len);
+			drm_err(adev_to_drm(p->adev), "invalid VCE command length (%d)!\n", len);
 			r = -EINVAL;
 			goto out;
 		}
@@ -1010,7 +1010,7 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
 				allocated |= 1 << session_idx;
 
 			} else if (!(allocated & (1 << session_idx))) {
-				DRM_ERROR("Handle already in use!\n");
+				drm_err(adev_to_drm(p->adev), "Handle already in use!\n");
 				r = -EINVAL;
 				goto out;
 			}
@@ -1026,7 +1026,7 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
 		}
 
 		if (session_idx == -1) {
-			DRM_ERROR("no session command at start of IB\n");
+			drm_err(adev_to_drm(p->adev), "no session command at start of IB\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -1035,7 +1035,7 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
 	}
 
 	if (allocated & ~created) {
-		DRM_ERROR("New session without create command!\n");
+		drm_err(adev_to_drm(p->adev), "New session without create command!\n");
 		r = -ENOENT;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c8885c3d54b33..fe877591845d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -154,7 +154,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 		if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
 				 !strncmp("F7A0114", bios_ver, 7))) {
 			adev->vcn.inst[i].indirect_sram = false;
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Steam Deck quirk: indirect SRAM disabled on BIOS %s\n", bios_ver);
 		}
 	}
@@ -182,7 +182,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 		enc_major = fw_check;
 		dec_ver = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf;
 		vep = (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			 "Found VCN firmware Version ENC: %u.%u DEC: %u VEP: %u Revision: %u\n",
 			 enc_major, enc_minor, dec_ver, vep, fw_rev);
 	} else {
@@ -191,7 +191,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 		family_id = le32_to_cpu(hdr->ucode_version) & 0xff;
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		dev_info(adev->dev, "Found VCN firmware Version: %u.%u Family ID: %u\n",
+		drm_info(adev_to_drm(adev), "Found VCN firmware Version: %u.%u Family ID: %u\n",
 			 version_major, version_minor, family_id);
 	}
 
@@ -222,7 +222,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 				    &adev->vcn.inst[i].gpu_addr,
 				    &adev->vcn.inst[i].cpu_addr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate vcn bo\n", r);
 		return r;
 	}
 
@@ -247,7 +247,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i)
 					    &adev->vcn.inst[i].dpg_sram_gpu_addr,
 					    &adev->vcn.inst[i].dpg_sram_cpu_addr);
 		if (r) {
-			dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
+			drm_err(adev_to_drm(adev), "VCN %d (%d) failed to allocate DPG bo\n", i, r);
 			return r;
 		}
 	}
@@ -1111,7 +1111,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev, int i)
 		hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
 		/* currently only support 2 FW instances */
 		if (i >= 2) {
-			dev_info(adev->dev, "More then 2 VCN FW instances!\n");
+			drm_info(adev_to_drm(adev), "More then 2 VCN FW instances!\n");
 			return;
 		}
 		idx = AMDGPU_UCODE_ID_VCN + i;
@@ -1250,7 +1250,7 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
 			adev->virt.ops->ras_poison_handler(adev, ras_if->block);
 		else
-			dev_warn(adev->dev,
+			drm_warn(adev_to_drm(adev),
 				"No ras_poison_handler interface in SRIOV for VCN!\n");
 	}
 
@@ -1294,7 +1294,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 	ras = adev->vcn.ras;
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register vcn ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register vcn ras block!\n");
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0bb8cbe0dcc05..3eec4b280f1e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -150,9 +150,9 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 		virt->ops->req_init_data(adev);
 
 	if (adev->virt.req_init_data_ver > 0)
-		DRM_INFO("host supports REQ_INIT_DATA handshake\n");
+		drm_info(adev_to_drm(adev), "host supports REQ_INIT_DATA handshake\n");
 	else
-		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
+		drm_warn(adev_to_drm(adev), "host doesn't support REQ_INIT_DATA handshake\n");
 }
 
 /**
@@ -205,12 +205,12 @@ int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev)
 				    &adev->virt.mm_table.gpu_addr,
 				    (void *)&adev->virt.mm_table.cpu_addr);
 	if (r) {
-		DRM_ERROR("failed to alloc mm table and error = %d.\n", r);
+		drm_err(adev_to_drm(adev), "failed to alloc mm table and error = %d.\n", r);
 		return r;
 	}
 
 	memset((void *)adev->virt.mm_table.cpu_addr, 0, PAGE_SIZE);
-	DRM_INFO("MM table gpu addr = 0x%llx, cpu addr = %p.\n",
+	drm_info(adev_to_drm(adev), "MM table gpu addr = 0x%llx, cpu addr = %p.\n",
 		 adev->virt.mm_table.gpu_addr,
 		 adev->virt.mm_table.cpu_addr);
 	return 0;
@@ -460,7 +460,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	if (pf2vf_info->size > 1024) {
-		dev_err(adev->dev, "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
+		drm_err(adev_to_drm(adev), "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
 		return -EINVAL;
 	}
 
@@ -471,7 +471,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			adev->virt.fw_reserve.checksum_key, checksum);
 		if (checksum != checkval) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
 				checksum, checkval);
 			return -EINVAL;
@@ -487,7 +487,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			0, checksum);
 		if (checksum != checkval) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
 				checksum, checkval);
 			return -EINVAL;
@@ -528,7 +528,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_telemetry_en_caps.all;
 		break;
 	default:
-		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
+		drm_err(adev_to_drm(adev), "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
 		return -EINVAL;
 	}
 
@@ -645,7 +645,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 							&adev->kfd.reset_work))
 				return;
 			else
-				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
+				drm_err(adev_to_drm(adev), "Failed to queue work! at %s", __func__);
 		}
 
 		goto out;
@@ -661,7 +661,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 {
 	if (adev->virt.vf2pf_update_interval_ms != 0) {
-		DRM_INFO("clean up the vf2pf work item\n");
+		drm_info(adev_to_drm(adev), "clean up the vf2pf work item\n");
 		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
 		adev->virt.vf2pf_update_interval_ms = 0;
 	}
@@ -675,7 +675,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.vf2pf_update_retry_cnt = 0;
 
 	if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
-		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
+		drm_warn(adev_to_drm(adev), "Currently fw_vram and drv_vram should not have values at the same time!");
 	} else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
 		/* go through this logic in ip_init and reset to init workqueue*/
 		amdgpu_virt_exchange_data(adev);
@@ -1059,13 +1059,13 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	unsigned long flags;
 
 	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"indirect registers access through rlcg is not available\n");
 		return 0;
 	}
 
 	if (adev->gfx.xcc_mask && (((1 << xcc_id) & adev->gfx.xcc_mask) == 0)) {
-		dev_err(adev->dev, "invalid xcc\n");
+		drm_err(adev_to_drm(adev), "invalid xcc\n");
 		return 0;
 	}
 
@@ -1116,20 +1116,20 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 		if (i >= timeout || (tmp & AMDGPU_RLCG_SCRATCH1_ERROR_MASK) != 0) {
 			if (amdgpu_sriov_rlcg_error_report_enabled(adev)) {
 				if (tmp & AMDGPU_RLCG_VFGATE_DISABLED) {
-					dev_err(adev->dev,
+					drm_err(adev_to_drm(adev),
 						"vfgate is disabled, rlcg failed to program reg: 0x%05x\n", offset);
 				} else if (tmp & AMDGPU_RLCG_WRONG_OPERATION_TYPE) {
-					dev_err(adev->dev,
+					drm_err(adev_to_drm(adev),
 						"wrong operation type, rlcg failed to program reg: 0x%05x\n", offset);
 				} else if (tmp & AMDGPU_RLCG_REG_NOT_IN_RANGE) {
-					dev_err(adev->dev,
+					drm_err(adev_to_drm(adev),
 						"register is not in range, rlcg failed to program reg: 0x%05x\n", offset);
 				} else {
-					dev_err(adev->dev,
+					drm_err(adev_to_drm(adev),
 						"unknown error type, rlcg failed to program reg: 0x%05x\n", offset);
 				}
 			} else {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 					"timeout: rlcg faled to program reg: 0x%05x\n", offset);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index fc6d02d0f047a..bf6bfd14ff2c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -174,7 +174,7 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	ret = drm_crtc_init_with_planes(dev, crtc, primary, cursor,
 					&amdgpu_vkms_crtc_funcs, NULL);
 	if (ret) {
-		DRM_ERROR("Failed to init CRTC\n");
+		drm_err(adev_to_drm(adev), "Failed to init CRTC\n");
 		return ret;
 	}
 
@@ -314,7 +314,7 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 
 	obj = drm_gem_fb_get_obj(new_state->fb, 0);
 	if (!obj) {
-		DRM_ERROR("Failed to get obj from framebuffer\n");
+		drm_err(adev_to_drm(adev), "Failed to get obj from framebuffer\n");
 		return -EINVAL;
 	}
 
@@ -323,13 +323,13 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 
 	r = amdgpu_bo_reserve(rbo, true);
 	if (r) {
-		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
+		drm_err(adev_to_drm(adev), "fail to reserve bo (%d)\n", r);
 		return r;
 	}
 
 	r = dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
 	if (r) {
-		dev_err(adev->dev, "allocating fence slot failed (%d)\n", r);
+		drm_err(adev_to_drm(adev), "allocating fence slot failed (%d)\n", r);
 		goto error_unlock;
 	}
 
@@ -342,13 +342,13 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
 	r = amdgpu_bo_pin(rbo, domain);
 	if (unlikely(r != 0)) {
 		if (r != -ERESTARTSYS)
-			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
+			drm_err(adev_to_drm(adev), "Failed to pin framebuffer with error %d\n", r);
 		goto error_unlock;
 	}
 
 	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
 	if (unlikely(r != 0)) {
-		DRM_ERROR("%p bind failed\n", rbo);
+		drm_err(adev_to_drm(adev), "%p bind failed\n", rbo);
 		goto error_unpin;
 	}
 
@@ -380,14 +380,14 @@ static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
 
 	obj = drm_gem_fb_get_obj(old_state->fb, 0);
 	if (!obj) {
-		DRM_ERROR("Failed to get obj from framebuffer\n");
+		drm_err(plane->dev, "Failed to get obj from framebuffer\n");
 		return;
 	}
 
 	rbo = gem_to_amdgpu_bo(obj);
 	r = amdgpu_bo_reserve(rbo, false);
 	if (unlikely(r)) {
-		DRM_ERROR("failed to reserve rbo before unpin\n");
+		drm_err(plane->dev, "failed to reserve rbo before unpin\n");
 		return;
 	}
 
@@ -449,7 +449,7 @@ static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 	ret = drm_connector_init(dev, connector, &amdgpu_vkms_connector_funcs,
 				 DRM_MODE_CONNECTOR_VIRTUAL);
 	if (ret) {
-		DRM_ERROR("Failed to init connector\n");
+		drm_err(dev, "Failed to init connector\n");
 		goto err_connector;
 	}
 
@@ -457,14 +457,14 @@ static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 
 	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
 	if (ret) {
-		DRM_ERROR("Failed to init encoder\n");
+		drm_err(dev, "Failed to init encoder\n");
 		goto err_encoder;
 	}
 	encoder->possible_crtcs = 1 << index;
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
-		DRM_ERROR("Failed to attach connector to encoder\n");
+		drm_err(dev, "Failed to attach connector to encoder\n");
 		goto err_attach;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b5ddfcbbc9fc9..04609d69222a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1762,7 +1762,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 	tmp = amdgpu_vm_it_iter_first(&vm->va, saddr, eaddr);
 	if (tmp) {
 		/* bo and tmp overlap, invalid addr */
-		dev_err(adev->dev, "bo %p va 0x%010Lx-0x%010Lx conflict with "
+		drm_err(adev_to_drm(adev), "bo %p va 0x%010Lx-0x%010Lx conflict with "
 			"0x%010Lx-0x%010Lx\n", bo, saddr, eaddr,
 			tmp->start, tmp->last + 1);
 		return -EINVAL;
@@ -2234,7 +2234,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 	if (amdgpu_vm_size != -1) {
 		vm_size = amdgpu_vm_size;
 		if (vm_size > max_size) {
-			dev_warn(adev->dev, "VM size (%d) too large, max is %u GB\n",
+			drm_warn(adev_to_drm(adev), "VM size (%d) too large, max is %u GB\n",
 				 amdgpu_vm_size, max_size);
 			vm_size = max_size;
 		}
@@ -2282,7 +2282,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 		adev->vm_manager.root_level = AMDGPU_VM_PDB0;
 		break;
 	default:
-		dev_err(adev->dev, "VMPT only supports 2~4+1 levels\n");
+		drm_err(adev_to_drm(adev), "VMPT only supports 2~4+1 levels\n");
 	}
 	/* block size depends on vm size and hw setup*/
 	if (amdgpu_vm_block_size != -1)
@@ -2300,7 +2300,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 	else
 		adev->vm_manager.fragment_size = amdgpu_vm_fragment_size;
 
-	DRM_INFO("vm size is %u GB, %u levels, block size is %u-bit, fragment size is %u-bit\n",
+	drm_info(adev_to_drm(adev), "vm size is %u GB, %u levels, block size is %u-bit, fragment size is %u-bit\n",
 		 vm_size, adev->vm_manager.num_level + 1,
 		 adev->vm_manager.block_size,
 		 adev->vm_manager.fragment_size);
@@ -2643,7 +2643,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_vm_fini_entities(vm);
 
 	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
-		dev_err(adev->dev, "still active bo inside vm\n");
+		drm_err(adev_to_drm(adev), "still active bo inside vm\n");
 	}
 	rbtree_postorder_for_each_entry_safe(mapping, tmp,
 					     &vm->va.rb_root, rb) {
@@ -2868,7 +2868,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 error_unlock:
 	amdgpu_bo_unreserve(root);
 	if (r < 0)
-		DRM_ERROR("Can't handle page fault (%d)\n", r);
+		drm_err(adev_to_drm(adev), "Can't handle page fault (%d)\n", r);
 
 error_unref:
 	amdgpu_bo_unref(&root);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 6da8994e0469a..511312ac0e860 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -923,7 +923,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 			return err;
 	} else {
 		man->func = &amdgpu_dummy_vram_mgr_func;
-		DRM_INFO("Setup dummy vram mgr\n");
+		drm_info(adev_to_drm(adev), "Setup dummy vram mgr\n");
 	}
 
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 23b6f7a4aa4a1..f0605472c7d5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -261,7 +261,7 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
 	for (i = 1; i < MAX_XCP; i++) {
 		ret = amdgpu_xcp_drm_dev_alloc(&p_ddev);
 		if (ret == -ENOSPC) {
-			dev_warn(adev->dev,
+			drm_warn(adev_to_drm(adev),
 			"Skip xcp node #%d when out of drm node resource.", i);
 			return 0;
 		} else if (ret) {
@@ -401,7 +401,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 
 		if (file_priv->minor == adev->xcp_mgr->xcp[i].ddev->render) {
 			if (adev->xcp_mgr->xcp[i].valid == FALSE) {
-				dev_err(adev->dev, "renderD%d partition %d not valid!",
+				drm_err(adev_to_drm(adev), "renderD%d partition %d not valid!",
 						file_priv->minor->index, i);
 				return -ENOENT;
 			}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index ee23bc96ec1ce..52608452c32a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -540,13 +540,13 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 	/* Create xgmi device id file */
 	ret = device_create_file(adev->dev, &dev_attr_xgmi_device_id);
 	if (ret) {
-		dev_err(adev->dev, "XGMI: Failed to create device file xgmi_device_id\n");
+		drm_err(adev_to_drm(adev), "XGMI: Failed to create device file xgmi_device_id\n");
 		return ret;
 	}
 
 	ret = device_create_file(adev->dev, &dev_attr_xgmi_physical_id);
 	if (ret) {
-		dev_err(adev->dev, "XGMI: Failed to create device file xgmi_physical_id\n");
+		drm_err(adev_to_drm(adev), "XGMI: Failed to create device file xgmi_physical_id\n");
 		return ret;
 	}
 
@@ -569,7 +569,7 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 	if (adev->psp.xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG) {
 		ret = device_create_file(adev->dev, &dev_attr_xgmi_port_num);
 		if (ret)
-			dev_err(adev->dev, "failed to create xgmi_port_num\n");
+			drm_err(adev_to_drm(adev), "failed to create xgmi_port_num\n");
 	}
 
 	/* Create sysfs link to hive info folder on the first device */
@@ -577,7 +577,7 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 		ret = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
 					"xgmi_hive_info");
 		if (ret) {
-			dev_err(adev->dev, "XGMI: Failed to create link to hive info");
+			drm_err(adev_to_drm(adev), "XGMI: Failed to create link to hive info");
 			goto remove_file;
 		}
 	}
@@ -586,7 +586,7 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
 	/* Create sysfs link form the hive folder to yourself */
 	ret = sysfs_create_link(&hive->kobj, &adev->dev->kobj, node);
 	if (ret) {
-		dev_err(adev->dev, "XGMI: Failed to create link from hive info");
+		drm_err(adev_to_drm(adev), "XGMI: Failed to create link from hive info");
 		goto remove_link;
 	}
 
@@ -655,7 +655,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 
 	hive = kzalloc(sizeof(*hive), GFP_KERNEL);
 	if (!hive) {
-		dev_err(adev->dev, "XGMI: allocation failed\n");
+		drm_err(adev_to_drm(adev), "XGMI: allocation failed\n");
 		ret = -ENOMEM;
 		hive = NULL;
 		goto pro_end;
@@ -667,7 +667,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 			&adev->dev->kobj,
 			"%s", "xgmi_hive_info");
 	if (ret) {
-		dev_err(adev->dev, "XGMI: failed initializing kobject for xgmi hive\n");
+		drm_err(adev_to_drm(adev), "XGMI: failed initializing kobject for xgmi hive\n");
 		kobject_put(&hive->kobj);
 		hive = NULL;
 		goto pro_end;
@@ -690,7 +690,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 				amdgpu_reset_create_reset_domain(adev, XGMI_HIVE,
 								"amdgpu-reset-hive");
 			if (!hive->reset_domain) {
-				dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
+				drm_err(adev_to_drm(adev), "XGMI: failed initializing reset domain for xgmi hive\n");
 				ret = -ENOMEM;
 				kobject_put(&hive->kobj);
 				hive = NULL;
@@ -804,7 +804,7 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
 					 atomic_read(&hive->number_devices),
 					 &adev->psp.xgmi_context.top_info);
 	if (ret)
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"XGMI: Set topology failure on device %llx, hive %llx, ret %d",
 			adev->gmc.xgmi.node_id,
 			adev->gmc.xgmi.hive_id, ret);
@@ -833,7 +833,7 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
 			return top->nodes[i].num_hops & num_hops_mask;
 
-	dev_err(adev->dev, "Failed to get xgmi hops count for peer %d.\n",
+	drm_err(adev_to_drm(adev), "Failed to get xgmi hops count for peer %d.\n",
 		peer_adev->gmc.xgmi.physical_node_id);
 
 	return 0;
@@ -875,7 +875,7 @@ int amdgpu_xgmi_get_bandwidth(struct amdgpu_device *adev, struct amdgpu_device *
 	}
 
 	if (num_links == -1) {
-		dev_err(adev->dev, "Failed to get number of xgmi links for peer %d.\n",
+		drm_err(adev_to_drm(adev), "Failed to get number of xgmi links for peer %d.\n",
 			peer_adev->gmc.xgmi.physical_node_id);
 	} else if (num_links) {
 		int per_link_bw = (speed * num_lanes * unit_scale)/BITS_PER_BYTE;
@@ -967,21 +967,21 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp, false, true);
 		if (ret) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"XGMI: Failed to initialize xgmi session\n");
 			return ret;
 		}
 
 		ret = psp_xgmi_get_hive_id(&adev->psp, &adev->gmc.xgmi.hive_id);
 		if (ret) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"XGMI: Failed to get hive id\n");
 			return ret;
 		}
 
 		ret = psp_xgmi_get_node_id(&adev->psp, &adev->gmc.xgmi.node_id);
 		if (ret) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"XGMI: Failed to get node id\n");
 			return ret;
 		}
@@ -993,7 +993,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	hive = amdgpu_get_xgmi_hive(adev);
 	if (!hive) {
 		ret = -EINVAL;
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"XGMI: node 0x%llx, can not match hive 0x%llx in the hive list.\n",
 			adev->gmc.xgmi.node_id, adev->gmc.xgmi.hive_id);
 		goto exit;
@@ -1030,7 +1030,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 			ret = psp_xgmi_get_topology_info(&adev->psp, count,
 						&adev->psp.xgmi_context.top_info, false);
 			if (ret) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 					"XGMI: Get topology failure on device %llx, hive %llx, ret %d",
 					adev->gmc.xgmi.node_id,
 					adev->gmc.xgmi.hive_id, ret);
@@ -1095,11 +1095,11 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 exit:
 	if (!ret) {
 		adev->hive = hive;
-		dev_info(adev->dev, "XGMI: Add node %d, hive 0x%llx.\n",
+		drm_info(adev_to_drm(adev), "XGMI: Add node %d, hive 0x%llx.\n",
 			 adev->gmc.xgmi.physical_node_id, adev->gmc.xgmi.hive_id);
 	} else {
 		amdgpu_put_xgmi_hive(hive);
-		dev_err(adev->dev, "XGMI: Failed to add node %d, hive 0x%llx ret: %d\n",
+		drm_err(adev_to_drm(adev), "XGMI: Failed to add node %d, hive 0x%llx ret: %d\n",
 			adev->gmc.xgmi.physical_node_id, adev->gmc.xgmi.hive_id,
 			ret);
 	}
@@ -1159,7 +1159,7 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_handle *handle, struct aca_ban
 	error_str = ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_code_ext) ?
 		xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
 	if (error_str)
-		dev_info(adev->dev, "%s detected\n", error_str);
+		drm_info(adev_to_drm(adev), "%s detected\n", error_str);
 
 	count = ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]);
 
@@ -1354,7 +1354,7 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 				pcs_ras_fields[i].pcs_err_mask) >>
 				pcs_ras_fields[i].pcs_err_shift;
 		if (ue_cnt) {
-			dev_info(adev->dev, "%s detected\n",
+			drm_info(adev_to_drm(adev), "%s detected\n",
 				 pcs_ras_fields[i].err_name);
 			*ue_count += ue_cnt;
 		}
@@ -1453,7 +1453,7 @@ static void amdgpu_xgmi_legacy_query_ras_error_count(struct amdgpu_device *adev,
 		break;
 	default:
 		if (!supported)
-			dev_warn(adev->dev, "XGMI RAS error query not supported");
+			drm_warn(adev_to_drm(adev), "XGMI RAS error query not supported");
 		break;
 	}
 
@@ -1473,7 +1473,7 @@ static enum aca_error_type xgmi_v6_4_0_pcs_mca_get_error_type(struct amdgpu_devi
 	error_str = ext_error_code < ARRAY_SIZE(xgmi_v6_4_0_ras_error_code_ext) ?
 		xgmi_v6_4_0_ras_error_code_ext[ext_error_code] : NULL;
 	if (error_str)
-		dev_info(adev->dev, "%s detected\n", error_str);
+		drm_info(adev_to_drm(adev), "%s detected\n", error_str);
 
 	switch (ext_error_code) {
 	case 0:
@@ -1555,11 +1555,11 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 				(struct ta_ras_trigger_error_input *)inject_if;
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
-		dev_warn(adev->dev, "Failed to disallow df cstate");
+		drm_warn(adev_to_drm(adev), "Failed to disallow df cstate");
 
 	ret1 = amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_PLPD, XGMI_PLPD_DISALLOW);
 	if (ret1 && ret1 != -EOPNOTSUPP)
-		dev_warn(adev->dev, "Failed to disallow XGMI power down");
+		drm_warn(adev_to_drm(adev), "Failed to disallow XGMI power down");
 
 	ret2 = psp_ras_trigger_error(&adev->psp, block_info, instance_mask);
 
@@ -1568,10 +1568,10 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 
 	ret1 = amdgpu_dpm_set_pm_policy(adev, PP_PM_POLICY_XGMI_PLPD, XGMI_PLPD_DEFAULT);
 	if (ret1 && ret1 != -EOPNOTSUPP)
-		dev_warn(adev->dev, "Failed to allow XGMI power down");
+		drm_warn(adev_to_drm(adev), "Failed to allow XGMI power down");
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
-		dev_warn(adev->dev, "Failed to allow df cstate");
+		drm_warn(adev_to_drm(adev), "Failed to allow df cstate");
 
 	return ret2;
 }
@@ -1600,7 +1600,7 @@ int amdgpu_xgmi_ras_sw_init(struct amdgpu_device *adev)
 	ras = adev->gmc.xgmi.ras;
 	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
 	if (err) {
-		dev_err(adev->dev, "Failed to register xgmi_wafl_pcs ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to register xgmi_wafl_pcs ras block!\n");
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index ae071985f26e1..f5c7f34019f43 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -97,7 +97,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 		ip_blk = AMDGPU_XCP_VCN;
 		break;
 	default:
-		DRM_ERROR("Not support ring type %d!", ring->funcs->type);
+		drm_err(adev_to_drm(adev), "Not support ring type %d!", ring->funcs->type);
 		return;
 	}
 
@@ -212,7 +212,7 @@ static int aqua_vanjaram_select_scheds(
 		atomic_inc(&adev->xcp_mgr->xcp[sel_xcp_id].ref_cnt);
 		DRM_DEBUG("Selected partition #%d", sel_xcp_id);
 	} else {
-		DRM_ERROR("Failed to schedule partition #%d.", sel_xcp_id);
+		drm_err(adev_to_drm(adev), "Failed to schedule partition #%d.", sel_xcp_id);
 		return -ENOENT;
 	}
 
@@ -665,13 +665,13 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	if (mode == AMDGPU_AUTO_COMPUTE_PARTITION_MODE) {
 		mode = __aqua_vanjaram_get_auto_mode(xcp_mgr);
 		if (mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Invalid config, no compatible compute partition mode found, available memory partitions: %d",
 				adev->gmc.num_mem_partitions);
 			return -EINVAL;
 		}
 	} else if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode)) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"Invalid compute partition mode requested, requested: %s, available memory partitions: %d",
 			amdgpu_gfx_compute_mode_desc(mode), adev->gmc.num_mem_partitions);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 9cd63b4177bf2..58fdf903b12f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1396,7 +1396,7 @@ cik_asic_reset_method(struct amdgpu_device *adev)
 		return amdgpu_reset_method;
 
 	if (amdgpu_reset_method != -1)
-		dev_warn(adev->dev, "Specified reset:%d isn't supported, using AUTO instead.\n",
+		drm_warn(adev_to_drm(adev), "Specified reset:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
 	switch (adev->asic_type) {
@@ -1433,10 +1433,10 @@ static int cik_asic_reset(struct amdgpu_device *adev)
 		return 0;
 
 	if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		dev_info(adev->dev, "BACO reset\n");
+		drm_info(adev_to_drm(adev), "BACO reset\n");
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
-		dev_info(adev->dev, "PCI CONFIG reset\n");
+		drm_info(adev_to_drm(adev), "PCI CONFIG reset\n");
 		r = cik_asic_pci_config_reset(adev);
 	}
 
@@ -1552,16 +1552,16 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 		PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
 		if (current_data_rate == 2) {
-			DRM_INFO("PCIE gen 3 link speeds already enabled\n");
+			drm_info(adev_to_drm(adev), "PCIE gen 3 link speeds already enabled\n");
 			return;
 		}
-		DRM_INFO("enabling PCIE gen 3 link speeds, disable with amdgpu.pcie_gen2=0\n");
+		drm_info(adev_to_drm(adev), "enabling PCIE gen 3 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	} else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) {
 		if (current_data_rate == 1) {
-			DRM_INFO("PCIE gen 2 link speeds already enabled\n");
+			drm_info(adev_to_drm(adev), "PCIE gen 2 link speeds already enabled\n");
 			return;
 		}
-		DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
+		drm_info(adev_to_drm(adev), "enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	}
 
 	if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 41f4705bdbbdc..4fe339607853d 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -198,7 +198,7 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev,
 		 * from the last not overwritten vector (wptr + 16). Hopefully
 		 * this should allow us to catchup.
 		 */
-		dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+		drm_warn(adev_to_drm(adev), "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
 			 wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
 		ih->rptr = (wptr + 16) & ih->ptr_mask;
 		tmp = RREG32(mmIH_RB_CNTL);
@@ -385,7 +385,7 @@ static int cik_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 327424d93b461..895cd3f0e05f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1065,7 +1065,7 @@ static int cik_sdma_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -1175,7 +1175,7 @@ static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
 {
 	u8 instance_id;
 
-	DRM_ERROR("Illegal instruction in SDMA command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in SDMA command stream\n");
 	instance_id = (entry->ring_id & 0x3) >> 0;
 	drm_sched_fault(&adev->sdma.instance[instance_id].ring.sched);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 2f891fb846d5e..2eaf8cc34e9b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -209,7 +209,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
 	 * from the last not overwritten vector (wptr + 16). Hopefully
 	 * this should allow us to catchup.
 	 */
-	dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+	drm_warn(adev_to_drm(adev), "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
 		wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
 	ih->rptr = (wptr + 16) & ih->ptr_mask;
 	tmp = RREG32(mmIH_RB_CNTL);
@@ -381,7 +381,7 @@ static int cz_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index df401aded6621..79177c4e1cc1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1203,7 +1203,7 @@ static struct amdgpu_audio_pin *dce_v10_0_audio_get_pin(struct amdgpu_device *ad
 		if (adev->mode_info.audio.pin[i].connected)
 			return &adev->mode_info.audio.pin[i];
 	}
-	DRM_ERROR("No connected audio pins found!\n");
+	drm_err(adev_to_drm(adev), "No connected audio pins found!\n");
 	return NULL;
 }
 
@@ -1248,7 +1248,7 @@ static void dce_v10_0_audio_write_latency_fields(struct drm_encoder *encoder,
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
@@ -1295,13 +1295,13 @@ static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
 	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
 	if (sad_count < 0) {
-		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
+		drm_err(adev_to_drm(adev), "Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
 	}
 
@@ -1365,13 +1365,13 @@ static void dce_v10_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
 	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
 	if (sad_count < 0)
-		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
+		drm_err(adev_to_drm(adev), "Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
 		return;
 	BUG_ON(!sads);
@@ -1708,13 +1708,13 @@ static void dce_v10_0_afmt_setmode(struct drm_encoder *encoder,
 
 	err = drm_hdmi_avi_infoframe_from_display_mode(&frame, connector, mode);
 	if (err < 0) {
-		DRM_ERROR("failed to setup AVI infoframe: %zd\n", err);
+		drm_err(adev_to_drm(adev), "failed to setup AVI infoframe: %zd\n", err);
 		return;
 	}
 
 	err = hdmi_avi_infoframe_pack(&frame, buffer, sizeof(buffer));
 	if (err < 0) {
-		DRM_ERROR("failed to pack AVI infoframe: %zd\n", err);
+		drm_err(adev_to_drm(adev), "failed to pack AVI infoframe: %zd\n", err);
 		return;
 	}
 
@@ -1978,7 +1978,7 @@ static int dce_v10_0_crtc_do_set_base(struct drm_crtc *crtc,
 #endif
 		break;
 	default:
-		DRM_ERROR("Unsupported screen format %p4cc\n",
+		drm_err(adev_to_drm(adev), "Unsupported screen format %p4cc\n",
 			  &target_fb->format->format);
 		return -EINVAL;
 	}
@@ -2213,7 +2213,7 @@ static int dce_v10_0_pick_dig_encoder(struct drm_encoder *encoder)
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
 		return 6;
 	default:
-		DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
+		drm_err(encoder->dev, "invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
 		return 0;
 	}
 }
@@ -2273,7 +2273,7 @@ static u32 dce_v10_0_pick_pll(struct drm_crtc *crtc)
 		return ATOM_PPLL1;
 	if (!(pll_in_use & (1 << ATOM_PPLL0)))
 		return ATOM_PPLL0;
-	DRM_ERROR("unable to allocate a PPLL\n");
+	drm_err(adev_to_drm(adev), "unable to allocate a PPLL\n");
 	return ATOM_PPLL_INVALID;
 }
 
@@ -2385,13 +2385,13 @@ static int dce_v10_0_crtc_cursor_set2(struct drm_crtc *crtc,
 
 	if ((width > amdgpu_crtc->max_cursor_width) ||
 	    (height > amdgpu_crtc->max_cursor_height)) {
-		DRM_ERROR("bad cursor width or height %d x %d\n", width, height);
+		drm_err(crtc->dev, "bad cursor width or height %d x %d\n", width, height);
 		return -EINVAL;
 	}
 
 	obj = drm_gem_object_lookup(file_priv, handle);
 	if (!obj) {
-		DRM_ERROR("Cannot find cursor object %x for crtc %d\n", handle, amdgpu_crtc->crtc_id);
+		drm_err(crtc->dev, "Cannot find cursor object %x for crtc %d\n", handle, amdgpu_crtc->crtc_id);
 		return -ENOENT;
 	}
 
@@ -2406,7 +2406,7 @@ static int dce_v10_0_crtc_cursor_set2(struct drm_crtc *crtc,
 	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 	amdgpu_bo_unreserve(aobj);
 	if (ret) {
-		DRM_ERROR("Failed to pin new cursor BO (%d)\n", ret);
+		drm_err(crtc->dev, "Failed to pin new cursor BO (%d)\n", ret);
 		drm_gem_object_put(obj);
 		return ret;
 	}
@@ -2564,7 +2564,7 @@ static void dce_v10_0_crtc_disable(struct drm_crtc *crtc)
 		abo = gem_to_amdgpu_bo(crtc->primary->fb->obj[0]);
 		r = amdgpu_bo_reserve(abo, true);
 		if (unlikely(r))
-			DRM_ERROR("failed to reserve abo before unpin\n");
+			drm_err(adev_to_drm(adev), "failed to reserve abo before unpin\n");
 		else {
 			amdgpu_bo_unpin(abo);
 			amdgpu_bo_unreserve(abo);
@@ -2993,7 +2993,7 @@ static int dce_v10_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -3153,7 +3153,7 @@ static int dce_v10_0_set_pageflip_irq_state(struct amdgpu_device *adev,
 	u32 reg;
 
 	if (type >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", type);
+		drm_err(adev_to_drm(adev), "invalid pageflip crtc %d\n", type);
 		return -EINVAL;
 	}
 
@@ -3181,7 +3181,7 @@ static int dce_v10_0_pageflip_irq(struct amdgpu_device *adev,
 	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
 
 	if (crtc_id >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
+		drm_err(adev_to_drm(adev), "invalid pageflip crtc %d\n", crtc_id);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 80f01c3989cdf..f6a6e131413a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1235,7 +1235,7 @@ static struct amdgpu_audio_pin *dce_v11_0_audio_get_pin(struct amdgpu_device *ad
 		if (adev->mode_info.audio.pin[i].connected)
 			return &adev->mode_info.audio.pin[i];
 	}
-	DRM_ERROR("No connected audio pins found!\n");
+	drm_err(adev_to_drm(adev), "No connected audio pins found!\n");
 	return NULL;
 }
 
@@ -1280,7 +1280,7 @@ static void dce_v11_0_audio_write_latency_fields(struct drm_encoder *encoder,
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
@@ -1327,13 +1327,13 @@ static void dce_v11_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
 	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
 	if (sad_count < 0) {
-		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
+		drm_err(adev_to_drm(adev), "Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
 	}
 
@@ -1397,13 +1397,13 @@ static void dce_v11_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
 	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
 	if (sad_count < 0)
-		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
+		drm_err(adev_to_drm(adev), "Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
 		return;
 	BUG_ON(!sads);
@@ -1757,13 +1757,13 @@ static void dce_v11_0_afmt_setmode(struct drm_encoder *encoder,
 
 	err = drm_hdmi_avi_infoframe_from_display_mode(&frame, connector, mode);
 	if (err < 0) {
-		DRM_ERROR("failed to setup AVI infoframe: %zd\n", err);
+		drm_err(adev_to_drm(adev), "failed to setup AVI infoframe: %zd\n", err);
 		return;
 	}
 
 	err = hdmi_avi_infoframe_pack(&frame, buffer, sizeof(buffer));
 	if (err < 0) {
-		DRM_ERROR("failed to pack AVI infoframe: %zd\n", err);
+		drm_err(adev_to_drm(adev), "failed to pack AVI infoframe: %zd\n", err);
 		return;
 	}
 
@@ -2028,7 +2028,7 @@ static int dce_v11_0_crtc_do_set_base(struct drm_crtc *crtc,
 #endif
 		break;
 	default:
-		DRM_ERROR("Unsupported screen format %p4cc\n",
+		drm_err(adev_to_drm(adev), "Unsupported screen format %p4cc\n",
 			  &target_fb->format->format);
 		return -EINVAL;
 	}
@@ -2254,7 +2254,7 @@ static int dce_v11_0_pick_dig_encoder(struct drm_encoder *encoder)
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
 		return 6;
 	default:
-		DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
+		drm_err(encoder->dev, "invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
 		return 0;
 	}
 }
@@ -2317,7 +2317,7 @@ static u32 dce_v11_0_pick_pll(struct drm_crtc *crtc)
 			else
 				return ATOM_COMBOPHY_PLL4;
 		default:
-			DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
+			drm_err(adev_to_drm(adev), "invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
 			return ATOM_PPLL_INVALID;
 		}
 	}
@@ -2346,7 +2346,7 @@ static u32 dce_v11_0_pick_pll(struct drm_crtc *crtc)
 			return ATOM_PPLL1;
 		if (!(pll_in_use & (1 << ATOM_PPLL0)))
 			return ATOM_PPLL0;
-		DRM_ERROR("unable to allocate a PPLL\n");
+		drm_err(adev_to_drm(adev), "unable to allocate a PPLL\n");
 		return ATOM_PPLL_INVALID;
 	} else {
 		if (!(pll_in_use & (1 << ATOM_PPLL2)))
@@ -2355,7 +2355,7 @@ static u32 dce_v11_0_pick_pll(struct drm_crtc *crtc)
 			return ATOM_PPLL1;
 		if (!(pll_in_use & (1 << ATOM_PPLL0)))
 			return ATOM_PPLL0;
-		DRM_ERROR("unable to allocate a PPLL\n");
+		drm_err(adev_to_drm(adev), "unable to allocate a PPLL\n");
 		return ATOM_PPLL_INVALID;
 	}
 	return ATOM_PPLL_INVALID;
@@ -2469,13 +2469,13 @@ static int dce_v11_0_crtc_cursor_set2(struct drm_crtc *crtc,
 
 	if ((width > amdgpu_crtc->max_cursor_width) ||
 	    (height > amdgpu_crtc->max_cursor_height)) {
-		DRM_ERROR("bad cursor width or height %d x %d\n", width, height);
+		drm_err(crtc->dev, "bad cursor width or height %d x %d\n", width, height);
 		return -EINVAL;
 	}
 
 	obj = drm_gem_object_lookup(file_priv, handle);
 	if (!obj) {
-		DRM_ERROR("Cannot find cursor object %x for crtc %d\n", handle, amdgpu_crtc->crtc_id);
+		drm_err(crtc->dev, "Cannot find cursor object %x for crtc %d\n", handle, amdgpu_crtc->crtc_id);
 		return -ENOENT;
 	}
 
@@ -2490,7 +2490,7 @@ static int dce_v11_0_crtc_cursor_set2(struct drm_crtc *crtc,
 	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 	amdgpu_bo_unreserve(aobj);
 	if (ret) {
-		DRM_ERROR("Failed to pin new cursor BO (%d)\n", ret);
+		drm_err(crtc->dev, "Failed to pin new cursor BO (%d)\n", ret);
 		drm_gem_object_put(obj);
 		return ret;
 	}
@@ -2648,7 +2648,7 @@ static void dce_v11_0_crtc_disable(struct drm_crtc *crtc)
 		abo = gem_to_amdgpu_bo(crtc->primary->fb->obj[0]);
 		r = amdgpu_bo_reserve(abo, true);
 		if (unlikely(r))
-			DRM_ERROR("failed to reserve abo before unpin\n");
+			drm_err(adev_to_drm(adev), "failed to reserve abo before unpin\n");
 		else {
 			amdgpu_bo_unpin(abo);
 			amdgpu_bo_unreserve(abo);
@@ -3124,7 +3124,7 @@ static int dce_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -3284,7 +3284,7 @@ static int dce_v11_0_set_pageflip_irq_state(struct amdgpu_device *adev,
 	u32 reg;
 
 	if (type >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", type);
+		drm_err(adev_to_drm(adev), "invalid pageflip crtc %d\n", type);
 		return -EINVAL;
 	}
 
@@ -3312,7 +3312,7 @@ static int dce_v11_0_pageflip_irq(struct amdgpu_device *adev,
 	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
 
 	if (crtc_id >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
+		drm_err(adev_to_drm(adev), "invalid pageflip crtc %d\n", crtc_id);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 2d85ea7159de8..4be93b773ffb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1176,7 +1176,7 @@ static struct amdgpu_audio_pin *dce_v6_0_audio_get_pin(struct amdgpu_device *ade
 		if (adev->mode_info.audio.pin[i].connected)
 			return &adev->mode_info.audio.pin[i];
 	}
-	DRM_ERROR("No connected audio pins found!\n");
+	drm_err(adev_to_drm(adev), "No connected audio pins found!\n");
 	return NULL;
 }
 
@@ -1217,7 +1217,7 @@ static void dce_v6_0_audio_write_latency_fields(struct drm_encoder *encoder,
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
@@ -1262,13 +1262,13 @@ static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
 	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
 	if (sad_count < 0) {
-		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
+		drm_err(adev_to_drm(adev), "Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
 	}
 
@@ -1343,13 +1343,13 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
 	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
 	if (sad_count < 0)
-		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
+		drm_err(adev_to_drm(adev), "Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
 		return;
 
@@ -1535,13 +1535,13 @@ static void dce_v6_0_audio_set_avi_infoframe(struct drm_encoder *encoder,
 
 	err = drm_hdmi_avi_infoframe_from_display_mode(&frame, connector, mode);
 	if (err < 0) {
-		DRM_ERROR("failed to setup AVI infoframe: %zd\n", err);
+		drm_err(adev_to_drm(adev), "failed to setup AVI infoframe: %zd\n", err);
 		return;
 	}
 
 	err = hdmi_avi_infoframe_pack(&frame, buffer, sizeof(buffer));
 	if (err < 0) {
-		DRM_ERROR("failed to pack AVI infoframe: %zd\n", err);
+		drm_err(adev_to_drm(adev), "failed to pack AVI infoframe: %zd\n", err);
 		return;
 	}
 
@@ -1743,7 +1743,7 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
@@ -1833,7 +1833,7 @@ static int dce_v6_0_afmt_init(struct amdgpu_device *adev)
 				kfree(adev->mode_info.afmt[j]);
 				adev->mode_info.afmt[j] = NULL;
 			}
-			DRM_ERROR("Out of memory allocating afmt table\n");
+			drm_err(adev_to_drm(adev), "Out of memory allocating afmt table\n");
 			return -ENOMEM;
 		}
 	}
@@ -2005,7 +2005,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 #endif
 		break;
 	default:
-		DRM_ERROR("Unsupported screen format %p4cc\n",
+		drm_err(adev_to_drm(adev), "Unsupported screen format %p4cc\n",
 			  &target_fb->format->format);
 		return -EINVAL;
 	}
@@ -2199,7 +2199,7 @@ static int dce_v6_0_pick_dig_encoder(struct drm_encoder *encoder)
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
 		return 6;
 	default:
-		DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
+		drm_err(adev_to_drm(adev), "invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
 		return 0;
 	}
 }
@@ -2246,7 +2246,7 @@ static u32 dce_v6_0_pick_pll(struct drm_crtc *crtc)
 		return ATOM_PPLL2;
 	if (!(pll_in_use & (1 << ATOM_PPLL1)))
 		return ATOM_PPLL1;
-	DRM_ERROR("unable to allocate a PPLL\n");
+	drm_err(adev_to_drm(adev), "unable to allocate a PPLL\n");
 	return ATOM_PPLL_INVALID;
 }
 
@@ -2358,13 +2358,13 @@ static int dce_v6_0_crtc_cursor_set2(struct drm_crtc *crtc,
 
 	if ((width > amdgpu_crtc->max_cursor_width) ||
 	    (height > amdgpu_crtc->max_cursor_height)) {
-		DRM_ERROR("bad cursor width or height %d x %d\n", width, height);
+		drm_err(adev_to_drm(adev), "bad cursor width or height %d x %d\n", width, height);
 		return -EINVAL;
 	}
 
 	obj = drm_gem_object_lookup(file_priv, handle);
 	if (!obj) {
-		DRM_ERROR("Cannot find cursor object %x for crtc %d\n", handle, amdgpu_crtc->crtc_id);
+		drm_err(adev_to_drm(adev), "Cannot find cursor object %x for crtc %d\n", handle, amdgpu_crtc->crtc_id);
 		return -ENOENT;
 	}
 
@@ -2379,7 +2379,7 @@ static int dce_v6_0_crtc_cursor_set2(struct drm_crtc *crtc,
 	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 	amdgpu_bo_unreserve(aobj);
 	if (ret) {
-		DRM_ERROR("Failed to pin new cursor BO (%d)\n", ret);
+		drm_err(adev_to_drm(adev), "Failed to pin new cursor BO (%d)\n", ret);
 		drm_gem_object_put(obj);
 		return ret;
 	}
@@ -2532,7 +2532,7 @@ static void dce_v6_0_crtc_disable(struct drm_crtc *crtc)
 		abo = gem_to_amdgpu_bo(crtc->primary->fb->obj[0]);
 		r = amdgpu_bo_reserve(abo, true);
 		if (unlikely(r))
-			DRM_ERROR("failed to reserve abo before unpin\n");
+			drm_err(adev_to_drm(adev), "failed to reserve abo before unpin\n");
 		else {
 			amdgpu_bo_unpin(abo);
 			amdgpu_bo_unreserve(abo);
@@ -2931,7 +2931,7 @@ static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -3128,7 +3128,7 @@ static int dce_v6_0_set_pageflip_interrupt_state(struct amdgpu_device *adev,
 	u32 reg;
 
 	if (type >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", type);
+		drm_err(adev_to_drm(adev), "invalid pageflip crtc %d\n", type);
 		return -EINVAL;
 	}
 
@@ -3156,7 +3156,7 @@ static int dce_v6_0_pageflip_irq(struct amdgpu_device *adev,
 	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
 
 	if (crtc_id >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
+		drm_err(adev_to_drm(adev), "invalid pageflip crtc %d\n", crtc_id);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 07358546581fc..71b45994cc108 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1158,7 +1158,7 @@ static struct amdgpu_audio_pin *dce_v8_0_audio_get_pin(struct amdgpu_device *ade
 		if (adev->mode_info.audio.pin[i].connected)
 			return &adev->mode_info.audio.pin[i];
 	}
-	DRM_ERROR("No connected audio pins found!\n");
+	drm_err(adev_to_drm(adev), "No connected audio pins found!\n");
 	return NULL;
 }
 
@@ -1205,7 +1205,7 @@ static void dce_v8_0_audio_write_latency_fields(struct drm_encoder *encoder,
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
@@ -1268,13 +1268,13 @@ static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
 	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
 	if (sad_count < 0) {
-		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
+		drm_err(adev_to_drm(adev), "Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
 	}
 
@@ -1336,13 +1336,13 @@ static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	drm_connector_list_iter_end(&iter);
 
 	if (!amdgpu_connector) {
-		DRM_ERROR("Couldn't find encoder's connector\n");
+		drm_err(adev_to_drm(adev), "Couldn't find encoder's connector\n");
 		return;
 	}
 
 	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
 	if (sad_count < 0)
-		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
+		drm_err(adev_to_drm(adev), "Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
 		return;
 	BUG_ON(!sads);
@@ -1660,13 +1660,13 @@ static void dce_v8_0_afmt_setmode(struct drm_encoder *encoder,
 
 	err = drm_hdmi_avi_infoframe_from_display_mode(&frame, connector, mode);
 	if (err < 0) {
-		DRM_ERROR("failed to setup AVI infoframe: %zd\n", err);
+		drm_err(adev_to_drm(adev), "failed to setup AVI infoframe: %zd\n", err);
 		return;
 	}
 
 	err = hdmi_avi_infoframe_pack(&frame, buffer, sizeof(buffer));
 	if (err < 0) {
-		DRM_ERROR("failed to pack AVI infoframe: %zd\n", err);
+		drm_err(adev_to_drm(adev), "failed to pack AVI infoframe: %zd\n", err);
 		return;
 	}
 
@@ -1917,7 +1917,7 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crtc *crtc,
 #endif
 		break;
 	default:
-		DRM_ERROR("Unsupported screen format %p4cc\n",
+		drm_err(adev_to_drm(adev), "Unsupported screen format %p4cc\n",
 			  &target_fb->format->format);
 		return -EINVAL;
 	}
@@ -2121,7 +2121,7 @@ static int dce_v8_0_pick_dig_encoder(struct drm_encoder *encoder)
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
 		return 6;
 	default:
-		DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
+		drm_err(adev_to_drm(adev), "invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
 		return 0;
 	}
 }
@@ -2181,7 +2181,7 @@ static u32 dce_v8_0_pick_pll(struct drm_crtc *crtc)
 			return ATOM_PPLL2;
 		if (!(pll_in_use & (1 << ATOM_PPLL1)))
 			return ATOM_PPLL1;
-		DRM_ERROR("unable to allocate a PPLL\n");
+		drm_err(adev_to_drm(adev), "unable to allocate a PPLL\n");
 		return ATOM_PPLL_INVALID;
 	} else {
 		/* CI/KV has PPLL0, PPLL1, and PPLL2 */
@@ -2192,7 +2192,7 @@ static u32 dce_v8_0_pick_pll(struct drm_crtc *crtc)
 			return ATOM_PPLL1;
 		if (!(pll_in_use & (1 << ATOM_PPLL0)))
 			return ATOM_PPLL0;
-		DRM_ERROR("unable to allocate a PPLL\n");
+		drm_err(adev_to_drm(adev), "unable to allocate a PPLL\n");
 		return ATOM_PPLL_INVALID;
 	}
 	return ATOM_PPLL_INVALID;
@@ -2304,13 +2304,13 @@ static int dce_v8_0_crtc_cursor_set2(struct drm_crtc *crtc,
 
 	if ((width > amdgpu_crtc->max_cursor_width) ||
 	    (height > amdgpu_crtc->max_cursor_height)) {
-		DRM_ERROR("bad cursor width or height %d x %d\n", width, height);
+		drm_err(adev_to_drm(adev), "bad cursor width or height %d x %d\n", width, height);
 		return -EINVAL;
 	}
 
 	obj = drm_gem_object_lookup(file_priv, handle);
 	if (!obj) {
-		DRM_ERROR("Cannot find cursor object %x for crtc %d\n", handle, amdgpu_crtc->crtc_id);
+		drm_err(adev_to_drm(adev), "Cannot find cursor object %x for crtc %d\n", handle, amdgpu_crtc->crtc_id);
 		return -ENOENT;
 	}
 
@@ -2325,7 +2325,7 @@ static int dce_v8_0_crtc_cursor_set2(struct drm_crtc *crtc,
 	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
 	amdgpu_bo_unreserve(aobj);
 	if (ret) {
-		DRM_ERROR("Failed to pin new cursor BO (%d)\n", ret);
+		drm_err(adev_to_drm(adev), "Failed to pin new cursor BO (%d)\n", ret);
 		drm_gem_object_put(obj);
 		return ret;
 	}
@@ -2483,7 +2483,7 @@ static void dce_v8_0_crtc_disable(struct drm_crtc *crtc)
 		abo = gem_to_amdgpu_bo(crtc->primary->fb->obj[0]);
 		r = amdgpu_bo_reserve(abo, true);
 		if (unlikely(r))
-			DRM_ERROR("failed to reserve abo before unpin\n");
+			drm_err(adev_to_drm(adev), "failed to reserve abo before unpin\n");
 		else {
 			amdgpu_bo_unpin(abo);
 			amdgpu_bo_unreserve(abo);
@@ -2903,7 +2903,7 @@ static int dce_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -3144,7 +3144,7 @@ static int dce_v8_0_set_pageflip_interrupt_state(struct amdgpu_device *adev,
 	u32 reg;
 
 	if (type >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", type);
+		drm_err(adev_to_drm(adev), "invalid pageflip crtc %d\n", type);
 		return -EINVAL;
 	}
 
@@ -3172,7 +3172,7 @@ static int dce_v8_0_pageflip_irq(struct amdgpu_device *adev,
 	amdgpu_crtc = adev->mode_info.crtcs[crtc_id];
 
 	if (crtc_id >= adev->mode_info.num_crtc) {
-		DRM_ERROR("invalid pageflip crtc %d\n", crtc_id);
+		drm_err(adev_to_drm(adev), "invalid pageflip crtc %d\n", crtc_id);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 621aeca538803..d251d3b6c1966 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -244,7 +244,7 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
 
 	ret = device_create_file(adev->dev, &dev_attr_df_cntr_avail);
 	if (ret)
-		DRM_ERROR("failed to create file for available df counters\n");
+		drm_err(adev_to_drm(adev), "failed to create file for available df counters\n");
 
 	for (i = 0; i < AMDGPU_MAX_DF_PERFMONS; i++)
 		adev->df_perfmon_config_assign_mask[i] = 0;
@@ -416,7 +416,7 @@ static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 				hi_base_addr);
 
 	if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
-		DRM_ERROR("[DF PMC] addressing not retrieved! Lo: %x, Hi: %x",
+		drm_err(adev_to_drm(adev), "[DF PMC] addressing not retrieved! Lo: %x, Hi: %x",
 				*lo_base_addr, *hi_base_addr);
 		return -ENXIO;
 	}
@@ -661,7 +661,7 @@ static bool df_v3_6_query_ras_poison_mode(struct amdgpu_device *adev)
 	else if (!v0 && !v1 && !v28 && !v31)
 		return false;
 	else {
-		dev_warn(adev->dev, "DF poison setting is inconsistent(%d:%d:%d:%d)!\n",
+		drm_warn(adev_to_drm(adev), "DF poison setting is inconsistent(%d:%d:%d:%d)!\n",
 				v0, v1, v28, v31);
 		return false;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v4_3.c b/drivers/gpu/drm/amd/amdgpu/df_v4_3.c
index e8b9e19ede2e1..d163d4552cb13 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v4_3.c
@@ -50,7 +50,7 @@ static bool df_v4_3_query_ras_poison_mode(struct amdgpu_device *adev)
 	else if (!v0 && !v1 && !v28 && !v31)
 		return false;
 	else {
-		dev_warn(adev->dev, "DF poison setting is inconsistent(%d:%d:%d:%d)!\n",
+		drm_warn(adev_to_drm(adev), "DF poison setting is inconsistent(%d:%d:%d:%d)!\n",
 				v0, v1, v28, v31);
 		return false;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 17a4f60b7b516..c189ac117d38e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3812,7 +3812,7 @@ static void gfx_v10_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout)
-			dev_err(adev->dev, "fail to wait on hqd deactive\n");
+			drm_err(adev_to_drm(adev), "fail to wait on hqd deactive\n");
 	} else if (queue_type == AMDGPU_RING_TYPE_GFX) {
 		WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX,
 			     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
@@ -3830,9 +3830,9 @@ static void gfx_v10_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout)
-			dev_err(adev->dev, "failed to wait on gfx hqd deactivate\n");
+			drm_err(adev_to_drm(adev), "failed to wait on gfx hqd deactivate\n");
 	} else {
-		dev_err(adev->dev, "reset queue_type(%d) not supported\n", queue_type);
+		drm_err(adev_to_drm(adev), "reset queue_type(%d) not supported\n", queue_type);
 	}
 
 	nv_grbm_select(adev, 0, 0, 0, 0);
@@ -4012,7 +4012,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	WREG32(scratch, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
+		drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring %d (%d).\n",
 			  ring->idx, r);
 		return r;
 	}
@@ -4061,7 +4061,7 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: failed to get ib (%ld).\n", r);
 		goto err1;
 	}
 
@@ -4434,7 +4434,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
 					      &adev->gfx.mec.hpd_eop_gpu_addr,
 					      (void **)&hpd);
 		if (r) {
-			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			drm_warn(adev_to_drm(adev), "(%d) create HDP EOP bo failed\n", r);
 			gfx_v10_0_mec_fini(adev);
 			return r;
 		}
@@ -4458,7 +4458,7 @@ static int gfx_v10_0_mec_init(struct amdgpu_device *adev)
 					      &adev->gfx.mec.mec_fw_gpu_addr,
 					      (void **)&fw);
 		if (r) {
-			dev_err(adev->dev, "(%d) failed to create mec fw bo\n", r);
+			drm_err(adev_to_drm(adev), "(%d) failed to create mec fw bo\n", r);
 			gfx_v10_0_mec_fini(adev);
 			return r;
 		}
@@ -4714,7 +4714,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
 	} else {
 		adev->gfx.ip_dump_core = ptr;
@@ -4727,7 +4727,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
 	} else {
 		adev->gfx.ip_dump_compute_queues = ptr;
@@ -4740,7 +4740,7 @@ static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for GFX Queues IP Dump\n");
 		adev->gfx.ip_dump_gfx_queues = NULL;
 	} else {
 		adev->gfx.ip_dump_gfx_queues = ptr;
@@ -4805,7 +4805,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
 			if (r) {
 				adev->gfx.enable_cleaner_shader = false;
-				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+				drm_err(adev_to_drm(adev), "Failed to initialize cleaner shader\n");
 			}
 		}
 		break;
@@ -4822,7 +4822,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
 			if (r) {
 				adev->gfx.enable_cleaner_shader = false;
-				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+				drm_err(adev_to_drm(adev), "Failed to initialize cleaner shader\n");
 			}
 		}
 		break;
@@ -4872,7 +4872,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (adev->gfx.rlc.funcs->init) {
 			r = adev->gfx.rlc.funcs->init(adev);
 			if (r) {
-				dev_err(adev->dev, "Failed to init rlc BOs!\n");
+				drm_err(adev_to_drm(adev), "Failed to init rlc BOs!\n");
 				return r;
 			}
 		}
@@ -4880,7 +4880,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gfx_v10_0_mec_init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init MEC BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init MEC BOs!\n");
 		return r;
 	}
 
@@ -4926,7 +4926,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
 	if (r) {
-		DRM_ERROR("Failed to init KIQ BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init KIQ BOs!\n");
 		return r;
 	}
 
@@ -5593,7 +5593,7 @@ static int gfx_v10_0_parse_rlc_toc(struct amdgpu_device *adev)
 					&adev->gfx.rlc.rlc_toc_gpu_addr,
 					(void **)&adev->gfx.rlc.rlc_toc_buf);
 	if (ret) {
-		dev_err(adev->dev, "(%d) failed to create rlc toc bo\n", ret);
+		drm_err(adev_to_drm(adev), "(%d) failed to create rlc toc bo\n", ret);
 		return ret;
 	}
 
@@ -5627,7 +5627,7 @@ static uint32_t gfx_v10_0_calc_toc_total_size(struct amdgpu_device *adev)
 
 	ret = gfx_v10_0_parse_rlc_toc(adev);
 	if (ret) {
-		dev_err(adev->dev, "failed to parse rlc toc\n");
+		drm_err(adev_to_drm(adev), "failed to parse rlc toc\n");
 		return 0;
 	}
 
@@ -5655,7 +5655,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_buffer_init(struct amdgpu_device *ade
 				      &adev->gfx.rlc.rlc_autoload_gpu_addr,
 				      (void **)&adev->gfx.rlc.rlc_autoload_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create fw autoload bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create fw autoload bo\n", r);
 		return r;
 	}
 
@@ -5827,13 +5827,13 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	tmp = RREG32_SOC15(GC, 0, mmRLC_HYP_RESET_VECTOR);
 	if (!(tmp & (RLC_HYP_RESET_VECTOR__COLD_BOOT_EXIT_MASK |
 		   RLC_HYP_RESET_VECTOR__VDDGFX_EXIT_MASK))) {
-		DRM_ERROR("Neither COLD_BOOT_EXIT nor VDDGFX_EXIT is set\n");
+		drm_err(adev_to_drm(adev), "Neither COLD_BOOT_EXIT nor VDDGFX_EXIT is set\n");
 		return -EINVAL;
 	}
 
 	tmp = RREG32_SOC15(GC, 0, mmRLC_CNTL);
 	if (tmp & RLC_CNTL__RLC_ENABLE_F32_MASK) {
-		DRM_ERROR("RLC ROM should halt itself\n");
+		drm_err(adev_to_drm(adev), "RLC ROM should halt itself\n");
 		return -EINVAL;
 	}
 
@@ -5862,7 +5862,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_config_me_cache(struct amdgpu_device
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -5899,7 +5899,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_config_ce_cache(struct amdgpu_device
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -5936,7 +5936,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_config_pfp_cache(struct amdgpu_device
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -5973,7 +5973,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_config_mec_cache(struct amdgpu_device
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -6006,7 +6006,7 @@ static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 	}
 
 	if (i >= adev->usec_timeout) {
-		dev_err(adev->dev, "rlc autoload: gc ucode autoload timeout\n");
+		drm_err(adev_to_drm(adev), "rlc autoload: gc ucode autoload timeout\n");
 		return -ETIMEDOUT;
 	}
 
@@ -6055,7 +6055,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	}
 
 	if (i >= adev->usec_timeout)
-		DRM_ERROR("failed to %s cp gfx\n", enable ? "unhalt" : "halt");
+		drm_err(adev_to_drm(adev), "failed to %s cp gfx\n", enable ? "unhalt" : "halt");
 
 	return 0;
 }
@@ -6072,7 +6072,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	pfp_hdr = (const struct gfx_firmware_header_v1_0 *)
 		adev->gfx.pfp_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &pfp_hdr->header);
 
 	fw_data = (const __le32 *)(adev->gfx.pfp_fw->data +
 		le32_to_cpu(pfp_hdr->header.ucode_array_offset_bytes));
@@ -6084,7 +6084,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 				      &adev->gfx.pfp.pfp_fw_gpu_addr,
 				      (void **)&adev->gfx.pfp.pfp_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create pfp fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create pfp fw bo\n", r);
 		gfx_v10_0_pfp_fini(adev);
 		return r;
 	}
@@ -6109,7 +6109,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -6150,7 +6150,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	ce_hdr = (const struct gfx_firmware_header_v1_0 *)
 		adev->gfx.ce_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&ce_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &ce_hdr->header);
 
 	fw_data = (const __le32 *)(adev->gfx.ce_fw->data +
 		le32_to_cpu(ce_hdr->header.ucode_array_offset_bytes));
@@ -6162,7 +6162,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 				      &adev->gfx.ce.ce_fw_gpu_addr,
 				      (void **)&adev->gfx.ce.ce_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create ce fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create ce fw bo\n", r);
 		gfx_v10_0_ce_fini(adev);
 		return r;
 	}
@@ -6187,7 +6187,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -6227,7 +6227,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	me_hdr = (const struct gfx_firmware_header_v1_0 *)
 		adev->gfx.me_fw->data;
 
-	amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &me_hdr->header);
 
 	fw_data = (const __le32 *)(adev->gfx.me_fw->data +
 		le32_to_cpu(me_hdr->header.ucode_array_offset_bytes));
@@ -6239,7 +6239,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 				      &adev->gfx.me.me_fw_gpu_addr,
 				      (void **)&adev->gfx.me.me_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create me fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create me fw bo\n", r);
 		gfx_v10_0_me_fini(adev);
 		return r;
 	}
@@ -6264,7 +6264,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -6303,19 +6303,19 @@ static int gfx_v10_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 
 	r = gfx_v10_0_cp_gfx_load_pfp_microcode(adev);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to load pfp fw\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to load pfp fw\n", r);
 		return r;
 	}
 
 	r = gfx_v10_0_cp_gfx_load_ce_microcode(adev);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to load ce fw\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to load ce fw\n", r);
 		return r;
 	}
 
 	r = gfx_v10_0_cp_gfx_load_me_microcode(adev);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to load me fw\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to load me fw\n", r);
 		return r;
 	}
 
@@ -6340,7 +6340,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	ring = &adev->gfx.gfx_ring[0];
 	r = amdgpu_ring_alloc(ring, gfx_v10_0_get_csb_size(adev) + 4);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
@@ -6390,7 +6390,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 		ring = &adev->gfx.gfx_ring[1];
 		r = amdgpu_ring_alloc(ring, 2);
 		if (r) {
-			DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+			drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring (%d).\n", r);
 			return r;
 		}
 
@@ -6618,7 +6618,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	gfx_v10_0_cp_compute_enable(adev, false);
 
 	mec_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->data;
-	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &mec_hdr->header);
 
 	fw_data = (const __le32 *)
 		(adev->gfx.mec_fw->data +
@@ -6639,7 +6639,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -7509,11 +7509,11 @@ static int gfx_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
-				DRM_ERROR("KGQ disable failed\n");
+				drm_err(adev_to_drm(adev), "KGQ disable failed\n");
 		}
 
 		if (amdgpu_gfx_disable_kcq(adev, 0))
-			DRM_ERROR("KCQ disable failed\n");
+			drm_err(adev_to_drm(adev), "KCQ disable failed\n");
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -7633,7 +7633,7 @@ static int gfx_v10_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		if (grbm_soft_reset) {
 			tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
 			tmp |= grbm_soft_reset;
-			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+			drm_info(adev_to_drm(adev), "GRBM_SOFT_RESET=0x%08X\n", tmp);
 			WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
 			tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
 
@@ -8865,7 +8865,7 @@ static int gfx_v10_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	if (i >= adev->usec_timeout) {
 		r = -EINVAL;
-		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
+		drm_err(adev_to_drm(adev), "ring %d failed to preempt ib\n", ring->idx);
 	}
 
 	/* deassert preemption condition */
@@ -9365,7 +9365,7 @@ static int gfx_v10_0_priv_reg_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal register access in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal register access in command stream\n");
 	gfx_v10_0_handle_priv_fault(adev, entry);
 	return 0;
 }
@@ -9374,7 +9374,7 @@ static int gfx_v10_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal opcode in command stream \n");
+	drm_err(adev_to_drm(adev), "Illegal opcode in command stream \n");
 	gfx_v10_0_handle_priv_fault(adev, entry);
 	return 0;
 }
@@ -9383,7 +9383,7 @@ static int gfx_v10_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal instruction in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in command stream\n");
 	gfx_v10_0_handle_priv_fault(adev, entry);
 	return 0;
 }
@@ -9590,13 +9590,13 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	mutex_unlock(&adev->srbm_mutex);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	if (r) {
-		dev_err(adev->dev, "fail to wait on hqd deactivate\n");
+		drm_err(adev_to_drm(adev), "fail to wait on hqd deactivate\n");
 		return r;
 	}
 
 	r = gfx_v10_0_kcq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "fail to init kcq\n");
+		drm_err(adev_to_drm(adev), "fail to init kcq\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index bfee9eb901b8f..90fe2eb5f70cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -535,7 +535,7 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
 	WREG32(scratch, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
+		drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring %d (%d).\n",
 			  ring->idx, r);
 		return r;
 	}
@@ -702,7 +702,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 				(union amdgpu_firmware_header *)
 				adev->gfx.pfp_fw->data, 2, 0);
 	if (adev->gfx.rs64_enable) {
-		dev_info(adev->dev, "CP RS64 enable\n");
+		drm_info(adev_to_drm(adev), "CP RS64 enable\n");
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP);
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P1_STACK);
@@ -770,7 +770,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	if (adev->gfx.imu.funcs && adev->gfx.imu.funcs->init_microcode) {
 		err = adev->gfx.imu.funcs->init_microcode(adev);
 		if (err)
-			DRM_ERROR("Failed to init imu firmware!\n");
+			drm_err(adev_to_drm(adev), "Failed to init imu firmware!\n");
 		return err;
 	}
 
@@ -947,7 +947,7 @@ static int gfx_v11_0_mec_init(struct amdgpu_device *adev)
 					      &adev->gfx.mec.hpd_eop_gpu_addr,
 					      (void **)&hpd);
 		if (r) {
-			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			drm_warn(adev_to_drm(adev), "(%d) create HDP EOP bo failed\n", r);
 			gfx_v11_0_mec_fini(adev);
 			return r;
 		}
@@ -1233,7 +1233,7 @@ static int gfx_v11_0_rlc_autoload_buffer_init(struct amdgpu_device *adev)
 				      (void **)&adev->gfx.rlc.rlc_autoload_ptr);
 
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create fw autoload bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create fw autoload bo\n", r);
 		return r;
 	}
 
@@ -1525,7 +1525,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
 	} else {
 		adev->gfx.ip_dump_core = ptr;
@@ -1538,7 +1538,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
 	} else {
 		adev->gfx.ip_dump_compute_queues = ptr;
@@ -1551,7 +1551,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for GFX Queues IP Dump\n");
 		adev->gfx.ip_dump_gfx_queues = NULL;
 	} else {
 		adev->gfx.ip_dump_gfx_queues = ptr;
@@ -1628,7 +1628,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
 			if (r) {
 				adev->gfx.enable_cleaner_shader = false;
-				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+				drm_err(adev_to_drm(adev), "Failed to initialize cleaner shader\n");
 			}
 		}
 		break;
@@ -1642,7 +1642,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
 			if (r) {
 				adev->gfx.enable_cleaner_shader = false;
-				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+				drm_err(adev_to_drm(adev), "Failed to initialize cleaner shader\n");
 			}
 		}
 		break;
@@ -1697,13 +1697,13 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gfx_v11_0_rlc_init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init rlc BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init rlc BOs!\n");
 		return r;
 	}
 
 	r = gfx_v11_0_mec_init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init MEC BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init MEC BOs!\n");
 		return r;
 	}
 
@@ -1763,7 +1763,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
 		if (r) {
-			DRM_ERROR("Failed to init KIQ BOs!\n");
+			drm_err(adev_to_drm(adev), "Failed to init KIQ BOs!\n");
 			return r;
 		}
 
@@ -1788,7 +1788,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (amdgpu_gfx_ras_sw_init(adev)) {
-		dev_err(adev->dev, "Failed to initialize gfx ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to initialize gfx ras block!\n");
 		return -EINVAL;
 	}
 
@@ -2429,7 +2429,7 @@ static int gfx_v11_0_config_me_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2473,7 +2473,7 @@ static int gfx_v11_0_config_pfp_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2518,7 +2518,7 @@ static int gfx_v11_0_config_mec_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2575,7 +2575,7 @@ static int gfx_v11_0_config_pfp_cache_rs64(struct amdgpu_device *adev, uint64_t
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2593,7 +2593,7 @@ static int gfx_v11_0_config_pfp_cache_rs64(struct amdgpu_device *adev, uint64_t
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to prime instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to prime instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2655,7 +2655,7 @@ static int gfx_v11_0_config_pfp_cache_rs64(struct amdgpu_device *adev, uint64_t
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate RS64 data cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate RS64 data cache\n");
 		return -EINVAL;
 	}
 
@@ -2697,7 +2697,7 @@ static int gfx_v11_0_config_me_cache_rs64(struct amdgpu_device *adev, uint64_t a
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2716,7 +2716,7 @@ static int gfx_v11_0_config_me_cache_rs64(struct amdgpu_device *adev, uint64_t a
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to prime instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to prime instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2778,7 +2778,7 @@ static int gfx_v11_0_config_me_cache_rs64(struct amdgpu_device *adev, uint64_t a
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate RS64 data cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate RS64 data cache\n");
 		return -EINVAL;
 	}
 
@@ -2842,7 +2842,7 @@ static int gfx_v11_0_config_mec_cache_rs64(struct amdgpu_device *adev, uint64_t
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2861,7 +2861,7 @@ static int gfx_v11_0_config_mec_cache_rs64(struct amdgpu_device *adev, uint64_t
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2985,7 +2985,7 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 	}
 
 	if (i >= adev->usec_timeout) {
-		dev_err(adev->dev, "rlc autoload: gc ucode autoload timeout\n");
+		drm_err(adev_to_drm(adev), "rlc autoload: gc ucode autoload timeout\n");
 		return -ETIMEDOUT;
 	}
 
@@ -3050,7 +3050,7 @@ static int gfx_v11_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	}
 
 	if (i >= adev->usec_timeout)
-		DRM_ERROR("failed to %s cp gfx\n", enable ? "unhalt" : "halt");
+		drm_err(adev_to_drm(adev), "failed to %s cp gfx\n", enable ? "unhalt" : "halt");
 
 	return 0;
 }
@@ -3077,7 +3077,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 				      &adev->gfx.pfp.pfp_fw_gpu_addr,
 				      (void **)&adev->gfx.pfp.pfp_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create pfp fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create pfp fw bo\n", r);
 		gfx_v11_0_pfp_fini(adev);
 		return r;
 	}
@@ -3132,7 +3132,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.pfp.pfp_fw_gpu_addr,
 				      (void **)&adev->gfx.pfp.pfp_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create pfp ucode fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create pfp ucode fw bo\n", r);
 		gfx_v11_0_pfp_fini(adev);
 		return r;
 	}
@@ -3145,7 +3145,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.pfp.pfp_fw_data_gpu_addr,
 				      (void **)&adev->gfx.pfp.pfp_fw_data_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create pfp data fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create pfp data fw bo\n", r);
 		gfx_v11_0_pfp_fini(adev);
 		return r;
 	}
@@ -3186,7 +3186,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -3204,7 +3204,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to prime instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to prime instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -3266,7 +3266,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate RS64 data cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate RS64 data cache\n");
 		return -EINVAL;
 	}
 
@@ -3295,7 +3295,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 				      &adev->gfx.me.me_fw_gpu_addr,
 				      (void **)&adev->gfx.me.me_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create me fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create me fw bo\n", r);
 		gfx_v11_0_me_fini(adev);
 		return r;
 	}
@@ -3350,7 +3350,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.me.me_fw_gpu_addr,
 				      (void **)&adev->gfx.me.me_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create me ucode bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create me ucode bo\n", r);
 		gfx_v11_0_me_fini(adev);
 		return r;
 	}
@@ -3363,7 +3363,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.me.me_fw_data_gpu_addr,
 				      (void **)&adev->gfx.me.me_fw_data_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create me data bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create me data bo\n", r);
 		gfx_v11_0_pfp_fini(adev);
 		return r;
 	}
@@ -3404,7 +3404,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -3423,7 +3423,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to prime instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to prime instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -3485,7 +3485,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate RS64 data cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate RS64 data cache\n");
 		return -EINVAL;
 	}
 
@@ -3506,7 +3506,7 @@ static int gfx_v11_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 	else
 		r = gfx_v11_0_cp_gfx_load_pfp_microcode(adev);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to load pfp fw\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to load pfp fw\n", r);
 		return r;
 	}
 
@@ -3515,7 +3515,7 @@ static int gfx_v11_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 	else
 		r = gfx_v11_0_cp_gfx_load_me_microcode(adev);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to load me fw\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to load me fw\n", r);
 		return r;
 	}
 
@@ -3541,7 +3541,7 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 	ring = &adev->gfx.gfx_ring[0];
 	r = amdgpu_ring_alloc(ring, gfx_v11_0_get_csb_size(adev));
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
@@ -3586,7 +3586,7 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 		ring = &adev->gfx.gfx_ring[1];
 		r = amdgpu_ring_alloc(ring, 2);
 		if (r) {
-			DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+			drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring (%d).\n", r);
 			return r;
 		}
 
@@ -3806,7 +3806,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 					  &adev->gfx.mec.mec_fw_gpu_addr,
 					  (void **)&fw);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mec fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mec fw bo\n", r);
 		gfx_v11_0_mec_fini(adev);
 		return r;
 	}
@@ -3863,7 +3863,7 @@ static int gfx_v11_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.mec.mec_fw_gpu_addr,
 				      (void **)&fw_ucode_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mec fw ucode bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mec fw ucode bo\n", r);
 		gfx_v11_0_mec_fini(adev);
 		return r;
 	}
@@ -3876,7 +3876,7 @@ static int gfx_v11_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.mec.mec_fw_data_gpu_addr,
 				      (void **)&fw_data_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mec fw ucode bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mec fw ucode bo\n", r);
 		gfx_v11_0_mec_fini(adev);
 		return r;
 	}
@@ -3936,7 +3936,7 @@ static int gfx_v11_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -3955,7 +3955,7 @@ static int gfx_v11_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -4680,7 +4680,7 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	    (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
 		r = gfx_v11_0_wait_for_rlc_autoload_complete(adev);
 		if (r) {
-			dev_err(adev->dev, "(%d) failed to wait rlc autoload complete\n", r);
+			drm_err(adev_to_drm(adev), "(%d) failed to wait rlc autoload complete\n", r);
 			return r;
 		}
 	}
@@ -4755,11 +4755,11 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
-				DRM_ERROR("KGQ disable failed\n");
+				drm_err(adev_to_drm(adev), "KGQ disable failed\n");
 		}
 
 		if (amdgpu_gfx_disable_kcq(adev, 0))
-			DRM_ERROR("KCQ disable failed\n");
+			drm_err(adev_to_drm(adev), "KCQ disable failed\n");
 
 		amdgpu_mes_kiq_hw_fini(adev);
 	}
@@ -4897,7 +4897,7 @@ static int gfx_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	r = gfx_v11_0_request_gfx_index_mutex(adev, true);
 	if (r) {
 		mutex_unlock(&adev->gfx.reset_sem_mutex);
-		DRM_ERROR("Failed to acquire the gfx mutex during soft reset\n");
+		drm_err(adev_to_drm(adev), "Failed to acquire the gfx mutex during soft reset\n");
 		return r;
 	}
 
@@ -4913,7 +4913,7 @@ static int gfx_v11_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	r = gfx_v11_0_request_gfx_index_mutex(adev, false);
 	mutex_unlock(&adev->gfx.reset_sem_mutex);
 	if (r) {
-		DRM_ERROR("Failed to release the gfx mutex during soft reset\n");
+		drm_err(adev_to_drm(adev), "Failed to release the gfx mutex during soft reset\n");
 		return r;
 	}
 
@@ -6028,7 +6028,7 @@ static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	if (i >= adev->usec_timeout) {
 		r = -EINVAL;
-		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
+		drm_err(adev_to_drm(adev), "ring %d failed to preempt ib\n", ring->idx);
 	}
 
 	/* deassert preemption condition */
@@ -6500,7 +6500,7 @@ static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal register access in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal register access in command stream\n");
 	gfx_v11_0_handle_priv_fault(adev, entry);
 	return 0;
 }
@@ -6509,7 +6509,7 @@ static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal opcode in command stream \n");
+	drm_err(adev_to_drm(adev), "Illegal opcode in command stream \n");
 	gfx_v11_0_handle_priv_fault(adev, entry);
 	return 0;
 }
@@ -6518,7 +6518,7 @@ static int gfx_v11_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal instruction in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in command stream\n");
 	gfx_v11_0_handle_priv_fault(adev, entry);
 	return 0;
 }
@@ -6614,13 +6614,13 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = gfx_v11_0_kgq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "failed to init kgq\n");
+		drm_err(adev_to_drm(adev), "failed to init kgq\n");
 		return r;
 	}
 
 	r = amdgpu_mes_map_legacy_queue(adev, ring);
 	if (r) {
-		dev_err(adev->dev, "failed to remap kgq\n");
+		drm_err(adev_to_drm(adev), "failed to remap kgq\n");
 		return r;
 	}
 
@@ -6637,18 +6637,18 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
-		dev_err(adev->dev, "reset via MMIO failed %d\n", r);
+		drm_err(adev_to_drm(adev), "reset via MMIO failed %d\n", r);
 		return r;
 	}
 
 	r = gfx_v11_0_kcq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "fail to init kcq\n");
+		drm_err(adev_to_drm(adev), "fail to init kcq\n");
 		return r;
 	}
 	r = amdgpu_mes_map_legacy_queue(adev, ring);
 	if (r) {
-		dev_err(adev->dev, "failed to remap kcq\n");
+		drm_err(adev_to_drm(adev), "failed to remap kcq\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 999bb3cc88b70..afe716d30c875 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -45,7 +45,7 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *adev,
 	rlc_status1 = RREG32(SOC15_REG_OFFSET(GC, 0, regRLC_RLCS_FED_STATUS_1));
 
 	if (!rlc_status0 && !rlc_status1) {
-		dev_warn(adev->dev, "RLC_GC_FED irq is generated, but rlc_status0 and rlc_status1 are empty!\n");
+		drm_warn(adev_to_drm(adev), "RLC_GC_FED irq is generated, but rlc_status0 and rlc_status1 are empty!\n");
 		return 0;
 	}
 
@@ -57,12 +57,12 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *adev,
 		ras_if = adev->gfx.ras_if;
 
 	if (!ras_if) {
-		dev_err(adev->dev, "Gfx or sdma ras block not initialized, rlc_status0:0x%x.\n",
+		drm_err(adev_to_drm(adev), "Gfx or sdma ras block not initialized, rlc_status0:0x%x.\n",
 				rlc_status0);
 		return -EINVAL;
 	}
 
-	dev_warn(adev->dev, "RLC %s FED IRQ\n", ras_if->name);
+	drm_warn(adev_to_drm(adev), "RLC %s FED IRQ\n", ras_if->name);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		ih_data.head = *ras_if;
@@ -71,7 +71,7 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct amdgpu_device *adev,
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
 			adev->virt.ops->ras_poison_handler(adev, ras_if->block);
 		else
-			dev_warn(adev->dev,
+			drm_warn(adev_to_drm(adev),
 				"No ras_poison_handler interface in SRIOV for %s!\n", ras_if->name);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b6a79c7a66ddb..f7459d4598879 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -429,7 +429,7 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_ring *ring)
 	WREG32(scratch, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"amdgpu: cp failed to lock ring %d (%d).\n",
 			ring->idx, r);
 		return r;
@@ -487,7 +487,7 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: failed to get ib (%ld).\n", r);
 		goto err1;
 	}
 
@@ -616,7 +616,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 		if (adev->gfx.imu.funcs->init_microcode) {
 			err = adev->gfx.imu.funcs->init_microcode(adev);
 			if (err)
-				dev_err(adev->dev, "Failed to load imu firmware!\n");
+				drm_err(adev_to_drm(adev), "Failed to load imu firmware!\n");
 		}
 	}
 
@@ -765,7 +765,7 @@ static int gfx_v12_0_mec_init(struct amdgpu_device *adev)
 					      &adev->gfx.mec.hpd_eop_gpu_addr,
 					      (void **)&hpd);
 		if (r) {
-			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			drm_warn(adev_to_drm(adev), "(%d) create HDP EOP bo failed\n", r);
 			gfx_v12_0_mec_fini(adev);
 			return r;
 		}
@@ -1054,7 +1054,7 @@ static int gfx_v12_0_rlc_autoload_buffer_init(struct amdgpu_device *adev)
 				      (void **)&adev->gfx.rlc.rlc_autoload_ptr);
 
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create fw autoload bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create fw autoload bo\n", r);
 		return r;
 	}
 
@@ -1321,7 +1321,7 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
 	} else {
 		adev->gfx.ip_dump_core = ptr;
@@ -1334,7 +1334,7 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
 	} else {
 		adev->gfx.ip_dump_compute_queues = ptr;
@@ -1347,7 +1347,7 @@ static void gfx_v12_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for GFX Queues IP Dump\n");
 		adev->gfx.ip_dump_gfx_queues = NULL;
 	} else {
 		adev->gfx.ip_dump_gfx_queues = ptr;
@@ -1444,13 +1444,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gfx_v12_0_rlc_init(adev);
 	if (r) {
-		dev_err(adev->dev, "Failed to init rlc BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init rlc BOs!\n");
 		return r;
 	}
 
 	r = gfx_v12_0_mec_init(adev);
 	if (r) {
-		dev_err(adev->dev, "Failed to init MEC BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init MEC BOs!\n");
 		return r;
 	}
 
@@ -1506,7 +1506,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
 		if (r) {
-			dev_err(adev->dev, "Failed to init KIQ BOs!\n");
+			drm_err(adev_to_drm(adev), "Failed to init KIQ BOs!\n");
 			return r;
 		}
 
@@ -2256,7 +2256,7 @@ static int gfx_v12_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 	}
 
 	if (i >= adev->usec_timeout) {
-		dev_err(adev->dev, "rlc autoload: gc ucode autoload timeout\n");
+		drm_err(adev_to_drm(adev), "rlc autoload: gc ucode autoload timeout\n");
 		return -ETIMEDOUT;
 	}
 
@@ -2285,7 +2285,7 @@ static int gfx_v12_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 	}
 
 	if (i >= adev->usec_timeout)
-		DRM_ERROR("failed to %s cp gfx\n", enable ? "unhalt" : "halt");
+		drm_err(adev_to_drm(adev), "failed to %s cp gfx\n", enable ? "unhalt" : "halt");
 
 	return 0;
 }
@@ -2320,7 +2320,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.pfp.pfp_fw_gpu_addr,
 				      (void **)&adev->gfx.pfp.pfp_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create pfp ucode fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create pfp ucode fw bo\n", r);
 		gfx_v12_0_pfp_fini(adev);
 		return r;
 	}
@@ -2331,7 +2331,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.pfp.pfp_fw_data_gpu_addr,
 				      (void **)&adev->gfx.pfp.pfp_fw_data_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create pfp data fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create pfp data fw bo\n", r);
 		gfx_v12_0_pfp_fini(adev);
 		return r;
 	}
@@ -2372,7 +2372,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2390,7 +2390,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to prime instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to prime instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2425,7 +2425,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate RS64 data cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate RS64 data cache\n");
 		return -EINVAL;
 	}
 
@@ -2464,7 +2464,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.me.me_fw_gpu_addr,
 				      (void **)&adev->gfx.me.me_fw_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create me ucode bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create me ucode bo\n", r);
 		gfx_v12_0_me_fini(adev);
 		return r;
 	}
@@ -2475,7 +2475,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.me.me_fw_data_gpu_addr,
 				      (void **)&adev->gfx.me.me_fw_data_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create me data bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create me data bo\n", r);
 		gfx_v12_0_me_fini(adev);
 		return r;
 	}
@@ -2516,7 +2516,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2535,7 +2535,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to prime instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to prime instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2570,7 +2570,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate RS64 data cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate RS64 data cache\n");
 		return -EINVAL;
 	}
 
@@ -2590,13 +2590,13 @@ static int gfx_v12_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 
 	r = gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(adev);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to load pfp fw\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to load pfp fw\n", r);
 		return r;
 	}
 
 	r = gfx_v12_0_cp_gfx_load_me_microcode_rs64(adev);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to load me fw\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to load me fw\n", r);
 		return r;
 	}
 
@@ -2762,7 +2762,7 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 	gfx_v12_0_cp_compute_enable(adev, false);
 
 	mec_hdr = (const struct gfx_firmware_header_v2_0 *)adev->gfx.mec_fw->data;
-	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+	amdgpu_ucode_print_gfx_hdr(adev, &mec_hdr->header);
 
 	fw_ucode = (const __le32 *) (adev->gfx.mec_fw->data +
 				le32_to_cpu(mec_hdr->ucode_offset_bytes));
@@ -2778,7 +2778,7 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.mec.mec_fw_gpu_addr,
 				      (void **)&fw_ucode_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mec fw ucode bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mec fw ucode bo\n", r);
 		gfx_v12_0_mec_fini(adev);
 		return r;
 	}
@@ -2791,7 +2791,7 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 				      &adev->gfx.mec.mec_fw_data_gpu_addr,
 				      (void **)&fw_data_ptr);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mec fw ucode bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mec fw ucode bo\n", r);
 		gfx_v12_0_mec_fini(adev);
 		return r;
 	}
@@ -2851,7 +2851,7 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -2870,7 +2870,7 @@ static int gfx_v12_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
 	}
 
 	if (i >= usec_timeout) {
-		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		drm_err(adev_to_drm(adev), "failed to invalidate instruction cache\n");
 		return -EINVAL;
 	}
 
@@ -3578,7 +3578,7 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	    (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
 		r = gfx_v12_0_wait_for_rlc_autoload_complete(adev);
 		if (r) {
-			dev_err(adev->dev, "(%d) failed to wait rlc autoload complete\n", r);
+			drm_err(adev_to_drm(adev), "(%d) failed to wait rlc autoload complete\n", r);
 			return r;
 		}
 	}
@@ -3647,11 +3647,11 @@ static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
-				DRM_ERROR("KGQ disable failed\n");
+				drm_err(adev_to_drm(adev), "KGQ disable failed\n");
 		}
 
 		if (amdgpu_gfx_disable_kcq(adev, 0))
-			DRM_ERROR("KCQ disable failed\n");
+			drm_err(adev_to_drm(adev), "KCQ disable failed\n");
 
 		amdgpu_mes_kiq_hw_fini(adev);
 	}
@@ -3722,7 +3722,7 @@ static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 	    adev->smuio.funcs->get_gpu_clock_counter)
 		clock = adev->smuio.funcs->get_gpu_clock_counter(adev);
 	else
-		dev_warn(adev->dev, "query gpu clock counter is not supported\n");
+		drm_warn(adev_to_drm(adev), "query gpu clock counter is not supported\n");
 
 	return clock;
 }
@@ -4496,7 +4496,7 @@ static int gfx_v12_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	if (i >= adev->usec_timeout) {
 		r = -EINVAL;
-		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
+		drm_err(adev_to_drm(adev), "ring %d failed to preempt ib\n", ring->idx);
 	}
 
 	/* deassert preemption condition */
@@ -4925,7 +4925,7 @@ static int gfx_v12_0_priv_reg_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal register access in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal register access in command stream\n");
 	gfx_v12_0_handle_priv_fault(adev, entry);
 	return 0;
 }
@@ -4934,7 +4934,7 @@ static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal opcode in command stream \n");
+	drm_err(adev_to_drm(adev), "Illegal opcode in command stream \n");
 	gfx_v12_0_handle_priv_fault(adev, entry);
 	return 0;
 }
@@ -4943,7 +4943,7 @@ static int gfx_v12_0_priv_inst_irq(struct amdgpu_device *adev,
 				   struct amdgpu_irq_src *source,
 				   struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal instruction in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in command stream\n");
 	gfx_v12_0_handle_priv_fault(adev, entry);
 	return 0;
 }
@@ -5133,19 +5133,19 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
-		dev_err(adev->dev, "reset via MES failed %d\n", r);
+		drm_err(adev_to_drm(adev), "reset via MES failed %d\n", r);
 		return r;
 	}
 
 	r = gfx_v12_0_kgq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "failed to init kgq\n");
+		drm_err(adev_to_drm(adev), "failed to init kgq\n");
 		return r;
 	}
 
 	r = amdgpu_mes_map_legacy_queue(adev, ring);
 	if (r) {
-		dev_err(adev->dev, "failed to remap kgq\n");
+		drm_err(adev_to_drm(adev), "failed to remap kgq\n");
 		return r;
 	}
 
@@ -5162,18 +5162,18 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
-		dev_err(adev->dev, "reset via MMIO failed %d\n", r);
+		drm_err(adev_to_drm(adev), "reset via MMIO failed %d\n", r);
 		return r;
 	}
 
 	r = gfx_v12_0_kcq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "failed to init kcq\n");
+		drm_err(adev_to_drm(adev), "failed to init kcq\n");
 		return r;
 	}
 	r = amdgpu_mes_map_legacy_queue(adev, ring);
 	if (r) {
-		dev_err(adev->dev, "failed to remap kcq\n");
+		drm_err(adev_to_drm(adev), "failed to remap kcq\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 14b9bae75cd2a..6d70e492465d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1297,7 +1297,7 @@ static void gfx_v6_0_tiling_mode_table_init(struct amdgpu_device *adev)
 		for (reg_offset = 0; reg_offset < num_tile_mode_states; reg_offset++)
 			WREG32(mmGB_TILE_MODE0 + reg_offset, tilemode[reg_offset]);
 	} else {
-		DRM_ERROR("unknown asic: 0x%x\n", adev->asic_type);
+		drm_err(adev_to_drm(adev), "unknown asic: 0x%x\n", adev->asic_type);
 	}
 }
 
@@ -1368,7 +1368,7 @@ static void gfx_v6_0_raster_config(struct amdgpu_device *adev, u32 *rconf)
 		*rconf |= 0x0;
 		break;
 	default:
-		DRM_ERROR("unknown asic: 0x%x\n", adev->asic_type);
+		drm_err(adev_to_drm(adev), "unknown asic: 0x%x\n", adev->asic_type);
 		break;
 	}
 }
@@ -2010,7 +2010,7 @@ static int gfx_v6_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, 7 + 4);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 	amdgpu_ring_write(ring, PACKET3(PACKET3_ME_INITIALIZE, 5));
@@ -2031,7 +2031,7 @@ static int gfx_v6_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, gfx_v6_0_get_csb_size(adev) + 10);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
@@ -2388,7 +2388,7 @@ static int gfx_v6_0_rlc_init(struct amdgpu_device *adev)
 					      &adev->gfx.rlc.clear_state_gpu_addr,
 					      (void **)&adev->gfx.rlc.cs_ptr);
 		if (r) {
-			dev_warn(adev->dev, "(%d) create RLC c bo failed\n", r);
+			drm_warn(adev_to_drm(adev), "(%d) create RLC c bo failed\n", r);
 			amdgpu_gfx_rlc_fini(adev);
 			return r;
 		}
@@ -3026,7 +3026,7 @@ static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id
 static void gfx_v6_0_select_me_pipe_q(struct amdgpu_device *adev,
 				  u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
 {
-	DRM_INFO("Not implemented\n");
+	drm_info(adev_to_drm(adev), "Not implemented\n");
 }
 
 static const struct amdgpu_gfx_funcs gfx_v6_0_gfx_funcs = {
@@ -3081,13 +3081,13 @@ static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gfx_v6_0_init_microcode(adev);
 	if (r) {
-		DRM_ERROR("Failed to load gfx firmware!\n");
+		drm_err(adev_to_drm(adev), "Failed to load gfx firmware!\n");
 		return r;
 	}
 
 	r = adev->gfx.rlc.funcs->init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init rlc BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init rlc BOs!\n");
 		return r;
 	}
 
@@ -3107,7 +3107,7 @@ static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		unsigned irq_type;
 
 		if ((i >= 32) || (i >= AMDGPU_MAX_COMPUTE_RINGS)) {
-			DRM_ERROR("Too many (%d) compute rings!\n", i);
+			drm_err(adev_to_drm(adev), "Too many (%d) compute rings!\n", i);
 			break;
 		}
 		ring = &adev->gfx.compute_ring[i];
@@ -3381,7 +3381,7 @@ static int gfx_v6_0_priv_reg_irq(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal register access in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal register access in command stream\n");
 	gfx_v6_0_fault(adev, entry);
 	return 0;
 }
@@ -3390,7 +3390,7 @@ static int gfx_v6_0_priv_inst_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal instruction in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in command stream\n");
 	gfx_v6_0_fault(adev, entry);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 9a24cfbd14900..aec34b7bc63b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1632,7 +1632,7 @@ gfx_v7_0_raster_config(struct amdgpu_device *adev, u32 *rconf, u32 *rconf1)
 		*rconf1 |= 0x0;
 		break;
 	default:
-		DRM_ERROR("unknown asic: 0x%x\n", adev->asic_type);
+		drm_err(adev_to_drm(adev), "unknown asic: 0x%x\n", adev->asic_type);
 		break;
 	}
 }
@@ -2473,7 +2473,7 @@ static int gfx_v7_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, gfx_v7_0_get_csb_size(adev) + 8);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
@@ -2752,7 +2752,7 @@ static int gfx_v7_0_mec_init(struct amdgpu_device *adev)
 				      &adev->gfx.mec.hpd_eop_gpu_addr,
 				      (void **)&hpd);
 	if (r) {
-		dev_warn(adev->dev, "(%d) create, pin or map of HDP EOP bo failed\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) create, pin or map of HDP EOP bo failed\n", r);
 		gfx_v7_0_mec_fini(adev);
 		return r;
 	}
@@ -2976,7 +2976,7 @@ static int gfx_v7_0_compute_queue_init(struct amdgpu_device *adev, int ring_id)
 				      AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 				      &mqd_gpu_addr, (void **)&mqd);
 	if (r) {
-		dev_warn(adev->dev, "(%d) create MQD bo failed\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) create MQD bo failed\n", r);
 		return r;
 	}
 
@@ -4392,20 +4392,20 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gfx_v7_0_init_microcode(adev);
 	if (r) {
-		DRM_ERROR("Failed to load gfx firmware!\n");
+		drm_err(adev_to_drm(adev), "Failed to load gfx firmware!\n");
 		return r;
 	}
 
 	r = adev->gfx.rlc.funcs->init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init rlc BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init rlc BOs!\n");
 		return r;
 	}
 
 	/* allocate mec buffers */
 	r = gfx_v7_0_mec_init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init MEC BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init MEC BOs!\n");
 		return r;
 	}
 
@@ -4594,7 +4594,7 @@ static int gfx_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		if (grbm_soft_reset) {
 			tmp = RREG32(mmGRBM_SOFT_RESET);
 			tmp |= grbm_soft_reset;
-			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+			drm_info(adev_to_drm(adev), "GRBM_SOFT_RESET=0x%08X\n", tmp);
 			WREG32(mmGRBM_SOFT_RESET, tmp);
 			tmp = RREG32(mmGRBM_SOFT_RESET);
 
@@ -4608,7 +4608,7 @@ static int gfx_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		if (srbm_soft_reset) {
 			tmp = RREG32(mmSRBM_SOFT_RESET);
 			tmp |= srbm_soft_reset;
-			dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+			drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 			WREG32(mmSRBM_SOFT_RESET, tmp);
 			tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -4840,7 +4840,7 @@ static int gfx_v7_0_priv_reg_irq(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal register access in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal register access in command stream\n");
 	gfx_v7_0_fault(adev, entry);
 	return 0;
 }
@@ -4849,7 +4849,7 @@ static int gfx_v7_0_priv_inst_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal instruction in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in command stream\n");
 	// XXX soft reset the gfx block only
 	gfx_v7_0_fault(adev, entry);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index d51d4124edab3..66652eaf67063 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1048,7 +1048,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	if (adev->gfx.ce_feature_version >= 46 &&
 	    adev->gfx.pfp_feature_version >= 46) {
 		adev->virt.chained_ib_support = true;
-		DRM_INFO("Chained IB support enabled!\n");
+		drm_info(adev_to_drm(adev), "Chained IB support enabled!\n");
 	} else
 		adev->virt.chained_ib_support = false;
 
@@ -1209,7 +1209,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		dev_err(adev->dev, "gfx8: Failed to load firmware %s gfx firmware\n", chip_name);
+		drm_err(adev_to_drm(adev), "gfx8: Failed to load firmware %s gfx firmware\n", chip_name);
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
 		amdgpu_ucode_release(&adev->gfx.me_fw);
 		amdgpu_ucode_release(&adev->gfx.ce_fw);
@@ -1331,7 +1331,7 @@ static int gfx_v8_0_mec_init(struct amdgpu_device *adev)
 					      &adev->gfx.mec.hpd_eop_gpu_addr,
 					      (void **)&hpd);
 		if (r) {
-			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			drm_warn(adev_to_drm(adev), "(%d) create HDP EOP bo failed\n", r);
 			return r;
 		}
 
@@ -1536,7 +1536,7 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	r = amdgpu_ib_get(adev, NULL, total_size,
 					AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: failed to get ib (%d).\n", r);
 		return r;
 	}
 
@@ -1631,14 +1631,14 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	/* shedule the ib on the ring */
 	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
 	if (r) {
-		DRM_ERROR("amdgpu: ib submit failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: ib submit failed (%d).\n", r);
 		goto fail;
 	}
 
 	/* wait for the GPU to finish processing the IB */
 	r = dma_fence_wait(f, false);
 	if (r) {
-		DRM_ERROR("amdgpu: fence wait failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: fence wait failed (%d).\n", r);
 		goto fail;
 	}
 
@@ -1964,7 +1964,7 @@ static int gfx_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS30_IV_SRCID_SQ_INTERRUPT_MSG,
 			      &adev->gfx.sq_irq);
 	if (r) {
-		DRM_ERROR("amdgpu_irq_add() for SQ failed: %d\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu_irq_add() for SQ failed: %d\n", r);
 		return r;
 	}
 
@@ -1974,19 +1974,19 @@ static int gfx_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gfx_v8_0_init_microcode(adev);
 	if (r) {
-		DRM_ERROR("Failed to load gfx firmware!\n");
+		drm_err(adev_to_drm(adev), "Failed to load gfx firmware!\n");
 		return r;
 	}
 
 	r = adev->gfx.rlc.funcs->init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init rlc BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init rlc BOs!\n");
 		return r;
 	}
 
 	r = gfx_v8_0_mec_init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init MEC BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init MEC BOs!\n");
 		return r;
 	}
 
@@ -2031,7 +2031,7 @@ static int gfx_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gfx_kiq_init(adev, GFX8_MEC_HPD_SIZE, 0);
 	if (r) {
-		DRM_ERROR("Failed to init KIQ BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init KIQ BOs!\n");
 		return r;
 	}
 
@@ -3227,7 +3227,7 @@ static void gfx_v8_0_tiling_mode_table_init(struct amdgpu_device *adev)
 
 		break;
 	default:
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "Unknown chip type (%d) in function gfx_v8_0_tiling_mode_table_init() falling through to CHIP_CARRIZO\n",
 			 adev->asic_type);
 		fallthrough;
@@ -3487,7 +3487,7 @@ gfx_v8_0_raster_config(struct amdgpu_device *adev, u32 *rconf, u32 *rconf1)
 		*rconf1 |= 0x0;
 		break;
 	default:
-		DRM_ERROR("unknown asic: 0x%x\n", adev->asic_type);
+		drm_err(adev_to_drm(adev), "unknown asic: 0x%x\n", adev->asic_type);
 		break;
 	}
 }
@@ -3842,7 +3842,7 @@ static void gfx_v8_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 				gfx_v8_0_select_se_sh(adev, 0xffffffff,
 						      0xffffffff, 0xffffffff, 0);
 				mutex_unlock(&adev->grbm_idx_mutex);
-				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
+				drm_info(adev_to_drm(adev), "Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
 				return;
 			}
@@ -4165,7 +4165,7 @@ static int gfx_v8_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, gfx_v8_0_get_csb_size(adev) + 4);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
@@ -4337,7 +4337,7 @@ static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)
 		 * generation exposes more than 64 queues. If so, the
 		 * definition of queue_mask needs updating */
 		if (WARN_ON(i >= (sizeof(queue_mask)*8))) {
-			DRM_ERROR("Invalid KCQ enabled: %d\n", i);
+			drm_err(adev_to_drm(adev), "Invalid KCQ enabled: %d\n", i);
 			break;
 		}
 
@@ -4346,7 +4346,7 @@ static int gfx_v8_0_kiq_kcq_enable(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(kiq_ring, (8 * adev->gfx.num_compute_rings) + 8);
 	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		drm_err(adev_to_drm(adev), "Failed to lock KIQ (%d).\n", r);
 		return r;
 	}
 	/* set resources */
@@ -4786,7 +4786,7 @@ static int gfx_v8_0_kcq_disable(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(kiq_ring, 6 * adev->gfx.num_compute_rings);
 	if (r)
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		drm_err(adev_to_drm(adev), "Failed to lock KIQ (%d).\n", r);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
@@ -4811,7 +4811,7 @@ static int gfx_v8_0_kcq_disable(struct amdgpu_device *adev)
 	 */
 	r = amdgpu_ring_test_helper(kiq_ring);
 	if (r)
-		DRM_ERROR("KCQ disable failed\n");
+		drm_err(adev_to_drm(adev), "KCQ disable failed\n");
 
 	return r;
 }
@@ -5035,7 +5035,7 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (grbm_soft_reset) {
 		tmp = RREG32(mmGRBM_SOFT_RESET);
 		tmp |= grbm_soft_reset;
-		dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "GRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmGRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmGRBM_SOFT_RESET);
 
@@ -5049,7 +5049,7 @@ static int gfx_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -5278,7 +5278,7 @@ static int gfx_v8_0_late_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	if (r) {
-		DRM_ERROR("amdgpu_irq_get() failed to get IRQ for EDC, r: %d.\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu_irq_get() failed to get IRQ for EDC, r: %d.\n", r);
 		return r;
 	}
 
@@ -6658,7 +6658,7 @@ static int gfx_v8_0_priv_reg_irq(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal register access in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal register access in command stream\n");
 	gfx_v8_0_fault(adev, entry);
 	return 0;
 }
@@ -6667,7 +6667,7 @@ static int gfx_v8_0_priv_inst_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal instruction in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in command stream\n");
 	gfx_v8_0_fault(adev, entry);
 	return 0;
 }
@@ -6676,7 +6676,7 @@ static int gfx_v8_0_cp_ecc_error_irq(struct amdgpu_device *adev,
 				     struct amdgpu_irq_src *source,
 				     struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("CP EDC/ECC error detected.");
+	drm_err(adev_to_drm(adev), "CP EDC/ECC error detected.");
 	return 0;
 }
 
@@ -6692,7 +6692,7 @@ static void gfx_v8_0_parse_sq_irq(struct amdgpu_device *adev, unsigned ih_data,
 
 	switch (enc) {
 		case 0:
-			DRM_INFO("SQ general purpose intr detected:"
+			drm_info(adev_to_drm(adev), "SQ general purpose intr detected:"
 					"se_id %d, immed_overflow %d, host_reg_overflow %d,"
 					"host_cmd_overflow %d, cmd_timestamp %d,"
 					"reg_timestamp %d, thread_trace_buff_full %d,"
@@ -6747,7 +6747,7 @@ static void gfx_v8_0_parse_sq_irq(struct amdgpu_device *adev, unsigned ih_data,
 				);
 			break;
 		default:
-			DRM_ERROR("SQ invalid encoding type\n.");
+			drm_err(adev_to_drm(adev), "SQ invalid encoding type\n.");
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c4162716a78c7..bd95f2a76a38f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1036,9 +1036,9 @@ static void gfx_v9_0_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t q
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout)
-			dev_err(adev->dev, "fail to wait on hqd deactive\n");
+			drm_err(adev_to_drm(adev), "fail to wait on hqd deactive\n");
 	} else {
-		dev_err(adev->dev, "reset queue_type(%d) not supported\n", queue_type);
+		drm_err(adev_to_drm(adev), "reset queue_type(%d) not supported\n", queue_type);
 	}
 
 	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
@@ -1889,7 +1889,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 					      &adev->gfx.mec.hpd_eop_gpu_addr,
 					      (void **)&hpd);
 		if (r) {
-			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			drm_warn(adev_to_drm(adev), "(%d) create HDP EOP bo failed\n", r);
 			gfx_v9_0_mec_fini(adev);
 			return r;
 		}
@@ -1913,7 +1913,7 @@ static int gfx_v9_0_mec_init(struct amdgpu_device *adev)
 				      &adev->gfx.mec.mec_fw_gpu_addr,
 				      (void **)&fw);
 	if (r) {
-		dev_warn(adev->dev, "(%d) create mec firmware bo failed\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) create mec firmware bo failed\n", r);
 		gfx_v9_0_mec_fini(adev);
 		return r;
 	}
@@ -2039,7 +2039,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		gb_addr_config = VEGA12_GB_ADDR_CONFIG_GOLDEN;
-		DRM_INFO("fix gfx.config for vega12\n");
+		drm_info(adev_to_drm(adev), "fix gfx.config for vega12\n");
 		break;
 	case IP_VERSION(9, 4, 0):
 		adev->gfx.ras = &gfx_v9_0_ras;
@@ -2189,7 +2189,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
 	} else {
 		adev->gfx.ip_dump_core = ptr;
@@ -2202,7 +2202,7 @@ static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
 	} else {
 		adev->gfx.ip_dump_compute_queues = ptr;
@@ -2242,7 +2242,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
 			if (r) {
 				adev->gfx.enable_cleaner_shader = false;
-				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+				drm_err(adev_to_drm(adev), "Failed to initialize cleaner shader\n");
 			}
 		}
 		break;
@@ -2296,7 +2296,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		if (adev->gfx.rlc.funcs->init) {
 			r = adev->gfx.rlc.funcs->init(adev);
 			if (r) {
-				dev_err(adev->dev, "Failed to init rlc BOs!\n");
+				drm_err(adev_to_drm(adev), "Failed to init rlc BOs!\n");
 				return r;
 			}
 		}
@@ -2304,7 +2304,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gfx_v9_0_mec_init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init MEC BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init MEC BOs!\n");
 		return r;
 	}
 
@@ -2352,14 +2352,14 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		r = amdgpu_ring_mux_init(&adev->gfx.muxer, &adev->gfx.gfx_ring[0],
 					 GFX9_NUM_SW_GFX_RINGS);
 		if (r) {
-			DRM_ERROR("amdgpu_ring_mux_init failed(%d)\n", r);
+			drm_err(adev_to_drm(adev), "amdgpu_ring_mux_init failed(%d)\n", r);
 			return r;
 		}
 		for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++) {
 			r = amdgpu_ring_mux_add_sw_ring(&adev->gfx.muxer,
 							&adev->gfx.sw_gfx_ring[i]);
 			if (r) {
-				DRM_ERROR("amdgpu_ring_mux_add_sw_ring failed(%d)\n", r);
+				drm_err(adev_to_drm(adev), "amdgpu_ring_mux_add_sw_ring failed(%d)\n", r);
 				return r;
 			}
 		}
@@ -2393,7 +2393,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
 	if (r) {
-		DRM_ERROR("Failed to init KIQ BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init KIQ BOs!\n");
 		return r;
 	}
 
@@ -2413,7 +2413,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	if (amdgpu_gfx_ras_sw_init(adev)) {
-		dev_err(adev->dev, "Failed to initialize gfx ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to initialize gfx ras block!\n");
 		return -EINVAL;
 	}
 
@@ -2703,7 +2703,7 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 				amdgpu_gfx_select_se_sh(adev, 0xffffffff,
 						      0xffffffff, 0xffffffff, 0);
 				mutex_unlock(&adev->grbm_idx_mutex);
-				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
+				drm_info(adev_to_drm(adev), "Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
 				return;
 			}
@@ -3126,7 +3126,7 @@ static void gfx_v9_0_rlc_start(struct amdgpu_device *adev)
 	/* RLC_GPM_GENERAL_6 : RLC Ucode version */
 	rlc_ucode_ver = RREG32_SOC15(GC, 0, mmRLC_GPM_GENERAL_6);
 	if(rlc_ucode_ver == 0x108) {
-		DRM_INFO("Using rlc debug ucode. mmRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i \n",
+		drm_info(adev_to_drm(adev), "Using rlc debug ucode. mmRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i \n",
 				rlc_ucode_ver, adev->gfx.rlc_fw_version);
 		/* RLC_GPM_TIMER_INT_3 : Timer interval in RefCLK cycles,
 		 * default is 0x9C4 to create a 100us interval */
@@ -3309,12 +3309,12 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 	 */
 	if (adev->flags & AMD_IS_APU &&
 			adev->in_s3 && !pm_resume_via_firmware()) {
-		DRM_INFO("Will skip the CSB packet resubmit\n");
+		drm_info(adev_to_drm(adev), "Will skip the CSB packet resubmit\n");
 		return 0;
 	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
@@ -4153,7 +4153,7 @@ static int gfx_v9_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		if (grbm_soft_reset) {
 			tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
 			tmp |= grbm_soft_reset;
-			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+			drm_info(adev_to_drm(adev), "GRBM_SOFT_RESET=0x%08X\n", tmp);
 			WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
 			tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
 
@@ -4559,7 +4559,7 @@ static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, 7);
 	if (r) {
-		DRM_ERROR("amdgpu: GDS workarounds failed to lock ring %s (%d).\n",
+		drm_err(adev_to_drm(adev), "amdgpu: GDS workarounds failed to lock ring %s (%d).\n",
 			ring->name, r);
 		return r;
 	}
@@ -4648,7 +4648,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	r = amdgpu_ib_get(adev, NULL, total_size,
 					AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: failed to get ib (%d).\n", r);
 		return r;
 	}
 
@@ -4749,14 +4749,14 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	/* shedule the ib on the ring */
 	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
 	if (r) {
-		DRM_ERROR("amdgpu: ib submit failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: ib submit failed (%d).\n", r);
 		goto fail;
 	}
 
 	/* wait for the GPU to finish processing the IB */
 	r = dma_fence_wait(f, false);
 	if (r) {
-		DRM_ERROR("amdgpu: fence wait failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: fence wait failed (%d).\n", r);
 		goto fail;
 	}
 
@@ -6242,7 +6242,7 @@ static int gfx_v9_0_priv_reg_irq(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal register access in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal register access in command stream\n");
 	gfx_v9_0_fault(adev, entry);
 	return 0;
 }
@@ -6251,7 +6251,7 @@ static int gfx_v9_0_bad_op_irq(struct amdgpu_device *adev,
 			       struct amdgpu_irq_src *source,
 			       struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal opcode in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal opcode in command stream\n");
 	gfx_v9_0_fault(adev, entry);
 	return 0;
 }
@@ -6260,7 +6260,7 @@ static int gfx_v9_0_priv_inst_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal instruction in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in command stream\n");
 	gfx_v9_0_fault(adev, entry);
 	return 0;
 }
@@ -6725,7 +6725,7 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 
 	if (!(ras_gfx_subblocks[info->head.sub_block_index].hw_supported_error_type &
 	      info->head.type)) {
-		DRM_ERROR("GFX Subblock %s, hardware do not support type 0x%x\n",
+		drm_err(adev_to_drm(adev), "GFX Subblock %s, hardware do not support type 0x%x\n",
 			ras_gfx_subblocks[info->head.sub_block_index].name,
 			info->head.type);
 		return -EPERM;
@@ -6733,7 +6733,7 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 
 	if (!(ras_gfx_subblocks[info->head.sub_block_index].sw_supported_error_type &
 	      info->head.type)) {
-		DRM_ERROR("GFX Subblock %s, driver do not support type 0x%x\n",
+		drm_err(adev_to_drm(adev), "GFX Subblock %s, driver do not support type 0x%x\n",
 			ras_gfx_subblocks[info->head.sub_block_index].name,
 			info->head.type);
 		return -EPERM;
@@ -6845,14 +6845,14 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = REG_GET_FIELD(data, VM_L2_MEM_ECC_CNT, SEC_COUNT);
 		if (sec_count) {
-			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+			drm_info(adev_to_drm(adev), "Instance[%d]: SubBlock %s, "
 				"SEC %d\n", i, vml2_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
 
 		ded_count = REG_GET_FIELD(data, VM_L2_MEM_ECC_CNT, DED_COUNT);
 		if (ded_count) {
-			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+			drm_info(adev_to_drm(adev), "Instance[%d]: SubBlock %s, "
 				"DED %d\n", i, vml2_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -6865,7 +6865,7 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, VM_L2_WALKER_MEM_ECC_CNT,
 						SEC_COUNT);
 		if (sec_count) {
-			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+			drm_info(adev_to_drm(adev), "Instance[%d]: SubBlock %s, "
 				"SEC %d\n", i, vml2_walker_mems[i], sec_count);
 			err_data->ce_count += sec_count;
 		}
@@ -6873,7 +6873,7 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, VM_L2_WALKER_MEM_ECC_CNT,
 						DED_COUNT);
 		if (ded_count) {
-			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+			drm_info(adev_to_drm(adev), "Instance[%d]: SubBlock %s, "
 				"DED %d\n", i, vml2_walker_mems[i], ded_count);
 			err_data->ue_count += ded_count;
 		}
@@ -6885,7 +6885,7 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = (data & 0x00006000L) >> 0xd;
 		if (sec_count) {
-			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+			drm_info(adev_to_drm(adev), "Instance[%d]: SubBlock %s, "
 				"SEC %d\n", i, atc_l2_cache_2m_mems[i],
 				sec_count);
 			err_data->ce_count += sec_count;
@@ -6898,7 +6898,7 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = (data & 0x00006000L) >> 0xd;
 		if (sec_count) {
-			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+			drm_info(adev_to_drm(adev), "Instance[%d]: SubBlock %s, "
 				"SEC %d\n", i, atc_l2_cache_4k_mems[i],
 				sec_count);
 			err_data->ce_count += sec_count;
@@ -6906,7 +6906,7 @@ static int gfx_v9_0_query_utc_edc_status(struct amdgpu_device *adev,
 
 		ded_count = (data & 0x00018000L) >> 0xf;
 		if (ded_count) {
-			dev_info(adev->dev, "Instance[%d]: SubBlock %s, "
+			drm_info(adev_to_drm(adev), "Instance[%d]: SubBlock %s, "
 				"DED %d\n", i, atc_l2_cache_4k_mems[i],
 				ded_count);
 			err_data->ue_count += ded_count;
@@ -6939,7 +6939,7 @@ static int gfx_v9_0_ras_error_count(struct amdgpu_device *adev,
 				gfx_v9_0_ras_fields[i].sec_count_mask) >>
 				gfx_v9_0_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			dev_info(adev->dev, "GFX SubBlock %s, "
+			drm_info(adev_to_drm(adev), "GFX SubBlock %s, "
 				"Instance[%d][%d], SEC %d\n",
 				gfx_v9_0_ras_fields[i].name,
 				se_id, inst_id,
@@ -6951,7 +6951,7 @@ static int gfx_v9_0_ras_error_count(struct amdgpu_device *adev,
 				gfx_v9_0_ras_fields[i].ded_count_mask) >>
 				gfx_v9_0_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			dev_info(adev->dev, "GFX SubBlock %s, "
+			drm_info(adev_to_drm(adev), "GFX SubBlock %s, "
 				"Instance[%d][%d], DED %d\n",
 				gfx_v9_0_ras_fields[i].name,
 				se_id, inst_id,
@@ -7243,13 +7243,13 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	mutex_unlock(&adev->srbm_mutex);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	if (r) {
-		dev_err(adev->dev, "fail to wait on hqd deactive\n");
+		drm_err(adev_to_drm(adev), "fail to wait on hqd deactive\n");
 		return r;
 	}
 
 	r = gfx_v9_0_kcq_init_queue(ring, true);
 	if (r) {
-		dev_err(adev->dev, "fail to init kcq\n");
+		drm_err(adev_to_drm(adev), "fail to init kcq\n");
 		return r;
 	}
 	spin_lock_irqsave(&kiq->ring_lock, flags);
@@ -7263,7 +7263,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
 	if (r) {
-		DRM_ERROR("fail to remap queue\n");
+		drm_err(adev_to_drm(adev), "fail to remap queue\n");
 		return r;
 	}
 	return amdgpu_ring_test_ring(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index 6028afd81690f..cd78b415af83a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -709,7 +709,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = REG_GET_FIELD(data, VML2_MEM_ECC_CNTL, SEC_COUNT);
 		if (sec_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 vml2_mems[i], sec_count);
 			err_data->ce_count += sec_count;
@@ -717,7 +717,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 
 		ded_count = REG_GET_FIELD(data, VML2_MEM_ECC_CNTL, DED_COUNT);
 		if (ded_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 vml2_mems[i], ded_count);
 			err_data->ue_count += ded_count;
@@ -731,7 +731,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, VML2_WALKER_MEM_ECC_CNTL,
 					  SEC_COUNT);
 		if (sec_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 vml2_walker_mems[i], sec_count);
 			err_data->ce_count += sec_count;
@@ -740,7 +740,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, VML2_WALKER_MEM_ECC_CNTL,
 					  DED_COUNT);
 		if (ded_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 vml2_walker_mems[i], ded_count);
 			err_data->ue_count += ded_count;
@@ -753,7 +753,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 
 		sec_count = REG_GET_FIELD(data, UTCL2_MEM_ECC_CNTL, SEC_COUNT);
 		if (sec_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 utcl2_router_mems[i], sec_count);
 			err_data->ce_count += sec_count;
@@ -761,7 +761,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 
 		ded_count = REG_GET_FIELD(data, UTCL2_MEM_ECC_CNTL, DED_COUNT);
 		if (ded_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 utcl2_router_mems[i], ded_count);
 			err_data->ue_count += ded_count;
@@ -775,7 +775,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, ATC_L2_CACHE_2M_DSM_CNTL,
 					  SEC_COUNT);
 		if (sec_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 atc_l2_cache_2m_mems[i], sec_count);
 			err_data->ce_count += sec_count;
@@ -784,7 +784,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, ATC_L2_CACHE_2M_DSM_CNTL,
 					  DED_COUNT);
 		if (ded_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 atc_l2_cache_2m_mems[i], ded_count);
 			err_data->ue_count += ded_count;
@@ -798,7 +798,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		sec_count = REG_GET_FIELD(data, ATC_L2_CACHE_4K_DSM_CNTL,
 					  SEC_COUNT);
 		if (sec_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, SEC %d\n", i,
 				 atc_l2_cache_4k_mems[i], sec_count);
 			err_data->ce_count += sec_count;
@@ -807,7 +807,7 @@ static int gfx_v9_4_query_utc_edc_status(struct amdgpu_device *adev,
 		ded_count = REG_GET_FIELD(data, ATC_L2_CACHE_4K_DSM_CNTL,
 					  DED_COUNT);
 		if (ded_count) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Instance[%d]: SubBlock %s, DED %d\n", i,
 				 atc_l2_cache_4k_mems[i], ded_count);
 			err_data->ue_count += ded_count;
@@ -841,7 +841,7 @@ static int gfx_v9_4_ras_error_count(struct amdgpu_device *adev,
 		sec_cnt = (value & gfx_v9_4_ras_fields[i].sec_count_mask) >>
 			  gfx_v9_4_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "GFX SubBlock %s, Instance[%d][%d], SEC %d\n",
 				 gfx_v9_4_ras_fields[i].name, se_id, inst_id,
 				 sec_cnt);
@@ -851,7 +851,7 @@ static int gfx_v9_4_ras_error_count(struct amdgpu_device *adev,
 		ded_cnt = (value & gfx_v9_4_ras_fields[i].ded_count_mask) >>
 			  gfx_v9_4_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "GFX SubBlock %s, Instance[%d][%d], DED %d\n",
 				 gfx_v9_4_ras_fields[i].name, se_id, inst_id,
 				 ded_cnt);
@@ -995,7 +995,7 @@ static void gfx_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 				/* SDP read/write error/parity error in FUE_IS_FATAL mode
 				 * can cause system fatal error in arcturas. Harvest the error
 				 * status before GPU reset */
-				dev_warn(adev->dev, "GCEA err detected at instance: %d, status: 0x%x!\n",
+				drm_warn(adev_to_drm(adev), "GCEA err detected at instance: %d, status: 0x%x!\n",
 						j, reg_value);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index d81449f9d8225..e136cffd2975a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -365,7 +365,7 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	r = amdgpu_ib_get(adev, NULL, total_size,
 					AMDGPU_IB_POOL_DIRECT, ib);
 	if (r) {
-		dev_err(adev->dev, "failed to get ib (%d).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r);
 		return r;
 	}
 
@@ -411,7 +411,7 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	/* shedule the ib on the ring */
 	r = amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
 	if (r) {
-		dev_err(adev->dev, "ib submit failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "ib submit failed (%d).\n", r);
 		amdgpu_ib_free(ib, NULL);
 	}
 	return r;
@@ -479,7 +479,7 @@ static int gfx_v9_4_2_wait_for_waves_assigned(struct amdgpu_device *adev,
 		mdelay(1);
 	} while (++loop < 2000 && wait);
 
-	dev_err(adev->dev, "actual wave num: %d, expected wave num: %d\n",
+	drm_err(adev_to_drm(adev), "actual wave num: %d, expected wave num: %d\n",
 		wave_cnt, num_wave);
 
 	gfx_v9_4_2_log_wave_assignment(adev, wb_ptr);
@@ -507,7 +507,7 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	r = amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
 			  AMDGPU_IB_POOL_DIRECT, &wb_ib);
 	if (r) {
-		dev_err(adev->dev, "failed to get ib (%d) for wb\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%d) for wb\n", r);
 		return r;
 	}
 	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
@@ -522,7 +522,7 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 			adev->gfx.cu_info.number,
 			wb_ib.gpu_addr, pattern[0], &fences[0]);
 	if (r) {
-		dev_err(adev->dev, "failed to clear first 224 sgprs\n");
+		drm_err(adev_to_drm(adev), "failed to clear first 224 sgprs\n");
 		goto pro_end;
 	}
 
@@ -532,7 +532,7 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 			adev->gfx.cu_info.number * SIMD_ID_MAX * 2,
 			true);
 	if (r) {
-		dev_err(adev->dev, "wave coverage failed when clear first 224 sgprs\n");
+		drm_err(adev_to_drm(adev), "wave coverage failed when clear first 224 sgprs\n");
 		wb_ib.ptr[0] = 0xdeadbeaf; /* stop waves */
 		goto disp0_failed;
 	}
@@ -547,7 +547,7 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 			adev->gfx.cu_info.number * 2,
 			wb_ib.gpu_addr, pattern[1], &fences[1]);
 	if (r) {
-		dev_err(adev->dev, "failed to clear next 576 sgprs\n");
+		drm_err(adev_to_drm(adev), "failed to clear next 576 sgprs\n");
 		goto disp0_failed;
 	}
 
@@ -556,7 +556,7 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 			pattern[1], adev->gfx.cu_info.number * SIMD_ID_MAX * 6,
 			true);
 	if (r) {
-		dev_err(adev->dev, "wave coverage failed when clear first 576 sgprs\n");
+		drm_err(adev_to_drm(adev), "wave coverage failed when clear first 576 sgprs\n");
 		wb_ib.ptr[0] = 0xdeadbeaf; /* stop waves */
 		goto disp1_failed;
 	}
@@ -566,13 +566,13 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	/* wait for the GPU to finish processing the IB */
 	r = dma_fence_wait(fences[0], false);
 	if (r) {
-		dev_err(adev->dev, "timeout to clear first 224 sgprs\n");
+		drm_err(adev_to_drm(adev), "timeout to clear first 224 sgprs\n");
 		goto disp1_failed;
 	}
 
 	r = dma_fence_wait(fences[1], false);
 	if (r) {
-		dev_err(adev->dev, "timeout to clear first 576 sgprs\n");
+		drm_err(adev_to_drm(adev), "timeout to clear first 576 sgprs\n");
 		goto disp1_failed;
 	}
 
@@ -587,7 +587,7 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 			adev->gfx.cu_info.number,
 			wb_ib.gpu_addr, pattern[2], &fences[2]);
 	if (r) {
-		dev_err(adev->dev, "failed to clear first 256 sgprs\n");
+		drm_err(adev_to_drm(adev), "failed to clear first 256 sgprs\n");
 		goto disp1_failed;
 	}
 
@@ -597,7 +597,7 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 			adev->gfx.cu_info.number * SIMD_ID_MAX * 4,
 			true);
 	if (r) {
-		dev_err(adev->dev, "wave coverage failed when clear first 256 sgprs\n");
+		drm_err(adev_to_drm(adev), "wave coverage failed when clear first 256 sgprs\n");
 		wb_ib.ptr[0] = 0xdeadbeaf; /* stop waves */
 		goto disp2_failed;
 	}
@@ -606,7 +606,7 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 
 	r = dma_fence_wait(fences[2], false);
 	if (r) {
-		dev_err(adev->dev, "timeout to clear first 256 sgprs\n");
+		drm_err(adev_to_drm(adev), "timeout to clear first 256 sgprs\n");
 		goto disp2_failed;
 	}
 
@@ -623,9 +623,9 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	amdgpu_ib_free(&wb_ib, NULL);
 
 	if (r)
-		dev_info(adev->dev, "Init SGPRS Failed\n");
+		drm_info(adev_to_drm(adev), "Init SGPRS Failed\n");
 	else
-		dev_info(adev->dev, "Init SGPRS Successfully\n");
+		drm_info(adev_to_drm(adev), "Init SGPRS Successfully\n");
 
 	return r;
 }
@@ -650,7 +650,7 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	r = amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
 			  AMDGPU_IB_POOL_DIRECT, &wb_ib);
 	if (r) {
-		dev_err(adev->dev, "failed to get ib (%d) for wb.\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%d) for wb.\n", r);
 		return r;
 	}
 	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
@@ -665,14 +665,14 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 			adev->gfx.cu_info.number,
 			wb_ib.gpu_addr, pattern, &fence);
 	if (r) {
-		dev_err(adev->dev, "failed to clear vgprs\n");
+		drm_err(adev_to_drm(adev), "failed to clear vgprs\n");
 		goto pro_end;
 	}
 
 	/* wait for the GPU to finish processing the IB */
 	r = dma_fence_wait(fence, false);
 	if (r) {
-		dev_err(adev->dev, "timeout to clear vgprs\n");
+		drm_err(adev_to_drm(adev), "timeout to clear vgprs\n");
 		goto disp_failed;
 	}
 
@@ -682,7 +682,7 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 			adev->gfx.cu_info.number * SIMD_ID_MAX,
 			false);
 	if (r) {
-		dev_err(adev->dev, "failed to cover all simds when clearing vgprs\n");
+		drm_err(adev_to_drm(adev), "failed to cover all simds when clearing vgprs\n");
 		goto disp_failed;
 	}
 
@@ -693,9 +693,9 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	amdgpu_ib_free(&wb_ib, NULL);
 
 	if (r)
-		dev_info(adev->dev, "Init VGPRS Failed\n");
+		drm_info(adev_to_drm(adev), "Init VGPRS Failed\n");
 	else
-		dev_info(adev->dev, "Init VGPRS Successfully\n");
+		drm_info(adev_to_drm(adev), "Init VGPRS Successfully\n");
 
 	return r;
 }
@@ -741,7 +741,7 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				ARRAY_SIZE(golden_settings_gc_9_4_2_alde_die_1));
 		break;
 	default:
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "invalid die id %d, ignore channel fabricid remap settings\n",
 			 die_id);
 		break;
@@ -1465,7 +1465,7 @@ static int gfx_v9_4_2_get_reg_error_count(struct amdgpu_device *adev,
 		sec_cnt = SOC15_RAS_REG_FIELD_VAL(
 			value, gfx_v9_4_2_ras_fields[i], sec);
 		if (sec_cnt) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "GFX SubBlock %s, Instance[%d][%d], SEC %d\n",
 				 gfx_v9_4_2_ras_fields[i].name, se_id, inst_id,
 				 sec_cnt);
@@ -1475,7 +1475,7 @@ static int gfx_v9_4_2_get_reg_error_count(struct amdgpu_device *adev,
 		ded_cnt = SOC15_RAS_REG_FIELD_VAL(
 			value, gfx_v9_4_2_ras_fields[i], ded);
 		if (ded_cnt) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "GFX SubBlock %s, Instance[%d][%d], DED %d\n",
 				 gfx_v9_4_2_ras_fields[i].name, se_id, inst_id,
 				 ded_cnt);
@@ -1561,7 +1561,7 @@ static void gfx_v9_4_2_log_utc_edc_count(struct amdgpu_device *adev,
 			bank, vml2_way_str[way], mem, sec_cnt, ded_cnt);
 		break;
 	case VML2_WALKER_MEM:
-		dev_info(adev->dev, "GFX SubBlock %s, SED %d, DED %d\n",
+		drm_info(adev_to_drm(adev), "GFX SubBlock %s, SED %d, DED %d\n",
 			 vml2_walker_mems[bank], sec_cnt, ded_cnt);
 		break;
 	case UTCL2_MEM:
@@ -1717,7 +1717,7 @@ static void gfx_v9_4_2_query_ea_err_status(struct amdgpu_device *adev)
 			if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_STATUS) ||
 			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_WRRSP_STATUS) ||
 			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
-				dev_warn(adev->dev, "GCEA err detected at instance: %d, status: 0x%x!\n",
+				drm_warn(adev_to_drm(adev), "GCEA err detected at instance: %d, status: 0x%x!\n",
 						j, reg_value);
 			}
 			/* clear after read */
@@ -1737,19 +1737,19 @@ static void gfx_v9_4_2_query_utc_err_status(struct amdgpu_device *adev)
 
 	data = RREG32_SOC15(GC, 0, regUTCL2_MEM_ECC_STATUS);
 	if (data) {
-		dev_warn(adev->dev, "GFX UTCL2 Mem Ecc Status: 0x%x!\n", data);
+		drm_warn(adev_to_drm(adev), "GFX UTCL2 Mem Ecc Status: 0x%x!\n", data);
 		WREG32_SOC15(GC, 0, regUTCL2_MEM_ECC_STATUS, 0x3);
 	}
 
 	data = RREG32_SOC15(GC, 0, regVML2_MEM_ECC_STATUS);
 	if (data) {
-		dev_warn(adev->dev, "GFX VML2 Mem Ecc Status: 0x%x!\n", data);
+		drm_warn(adev_to_drm(adev), "GFX VML2 Mem Ecc Status: 0x%x!\n", data);
 		WREG32_SOC15(GC, 0, regVML2_MEM_ECC_STATUS, 0x3);
 	}
 
 	data = RREG32_SOC15(GC, 0, regVML2_WALKER_MEM_ECC_STATUS);
 	if (data) {
-		dev_warn(adev->dev, "GFX VML2 Walker Mem Ecc Status: 0x%x!\n", data);
+		drm_warn(adev_to_drm(adev), "GFX VML2 Walker Mem Ecc Status: 0x%x!\n", data);
 		WREG32_SOC15(GC, 0, regVML2_WALKER_MEM_ECC_STATUS, 0x3);
 	}
 }
@@ -1786,7 +1786,7 @@ static void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev)
 	if (amdgpu_watchdog_timer.timeout_fatal_disable &&
 	    (amdgpu_watchdog_timer.period < 1 ||
 	     amdgpu_watchdog_timer.period > 0x23)) {
-		dev_warn(adev->dev, "Watchdog period range is 1 to 0x23\n");
+		drm_warn(adev_to_drm(adev), "Watchdog period range is 1 to 0x23\n");
 		amdgpu_watchdog_timer.period = 0x23;
 	}
 	data = REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, PERIOD_SEL,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 205b44a3108d3..687a454f7e647 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -305,9 +305,9 @@ static void gfx_v9_4_3_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout)
-			dev_err(adev->dev, "fail to wait on hqd deactive\n");
+			drm_err(adev_to_drm(adev), "fail to wait on hqd deactive\n");
 	} else {
-		dev_err(adev->dev, "reset queue_type(%d) not supported\n\n", queue_type);
+		drm_err(adev_to_drm(adev), "reset queue_type(%d) not supported\n\n", queue_type);
 	}
 
 	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
@@ -636,7 +636,7 @@ static int gfx_v9_4_3_mec_init(struct amdgpu_device *adev)
 					      &adev->gfx.mec.hpd_eop_gpu_addr,
 					      (void **)&hpd);
 		if (r) {
-			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			drm_warn(adev_to_drm(adev), "(%d) create HDP EOP bo failed\n", r);
 			gfx_v9_4_3_mec_fini(adev);
 			return r;
 		}
@@ -668,7 +668,7 @@ static int gfx_v9_4_3_mec_init(struct amdgpu_device *adev)
 				      &adev->gfx.mec.mec_fw_gpu_addr,
 				      (void **)&fw);
 	if (r) {
-		dev_warn(adev->dev, "(%d) create mec firmware bo failed\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) create mec firmware bo failed\n", r);
 		gfx_v9_4_3_mec_fini(adev);
 		return r;
 	}
@@ -826,7 +826,7 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
 
 	xcc = hweight8(adev->gfx.xcc_mask & GENMASK(ih_node / 2, 0));
 	if (!xcc) {
-		dev_err(adev->dev, "Couldn't find xcc mapping from IH node");
+		drm_err(adev_to_drm(adev), "Couldn't find xcc mapping from IH node");
 		return -EINVAL;
 	}
 
@@ -1010,7 +1010,7 @@ static void gfx_v9_4_3_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for GFX IP Dump\n");
 		adev->gfx.ip_dump_core = NULL;
 	} else {
 		adev->gfx.ip_dump_core = ptr;
@@ -1023,7 +1023,7 @@ static void gfx_v9_4_3_alloc_ip_dump(struct amdgpu_device *adev)
 
 	ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for Compute Queues IP Dump\n");
 		adev->gfx.ip_dump_compute_queues = NULL;
 	} else {
 		adev->gfx.ip_dump_compute_queues = ptr;
@@ -1045,7 +1045,7 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
 			if (r) {
 				adev->gfx.enable_cleaner_shader = false;
-				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+				drm_err(adev_to_drm(adev), "Failed to initialize cleaner shader\n");
 			}
 		}
 		break;
@@ -1088,13 +1088,13 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = adev->gfx.rlc.funcs->init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init rlc BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init rlc BOs!\n");
 		return r;
 	}
 
 	r = gfx_v9_4_3_mec_init(adev);
 	if (r) {
-		DRM_ERROR("Failed to init MEC BOs!\n");
+		drm_err(adev_to_drm(adev), "Failed to init MEC BOs!\n");
 		return r;
 	}
 
@@ -1123,7 +1123,7 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 		r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, xcc_id);
 		if (r) {
-			DRM_ERROR("Failed to init KIQ BOs!\n");
+			drm_err(adev_to_drm(adev), "Failed to init KIQ BOs!\n");
 			return r;
 		}
 
@@ -1433,7 +1433,7 @@ static void gfx_v9_4_3_xcc_wait_for_rlc_serdes(struct amdgpu_device *adev,
 							    0xffffffff,
 							    0xffffffff, xcc_id);
 				mutex_unlock(&adev->grbm_idx_mutex);
-				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
+				drm_info(adev_to_drm(adev), "Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
 				return;
 			}
@@ -1533,7 +1533,7 @@ static void gfx_v9_4_3_rlc_start(struct amdgpu_device *adev)
 		/* RLC_GPM_GENERAL_6 : RLC Ucode version */
 		rlc_ucode_ver = RREG32_SOC15(GC, GET_INST(GC, i), regRLC_GPM_GENERAL_6);
 		if (rlc_ucode_ver == 0x108) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				 "Using rlc debug ucode. regRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i \n",
 				 rlc_ucode_ver, adev->gfx.rlc_fw_version);
 			/* RLC_GPM_TIMER_INT_3 : Timer interval in RefCLK cycles,
@@ -1569,7 +1569,7 @@ static int gfx_v9_4_3_xcc_rlc_load_microcode(struct amdgpu_device *adev,
 			RLCG_UCODE_LOADING_START_ADDRESS);
 	for (i = 0; i < fw_size; i++) {
 		if (amdgpu_emu_mode == 1 && i % 100 == 0) {
-			dev_info(adev->dev, "Write RLC ucode data %u DWs\n", i);
+			drm_info(adev_to_drm(adev), "Write RLC ucode data %u DWs\n", i);
 			msleep(1);
 		}
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_GPM_UCODE_DATA, le32_to_cpup(fw_data++));
@@ -2267,7 +2267,7 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
 {
 	if (amdgpu_gfx_disable_kcq(adev, xcc_id))
-		DRM_ERROR("XCD %d KCQ disable failed\n", xcc_id);
+		drm_err(adev_to_drm(adev), "XCD %d KCQ disable failed\n", xcc_id);
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* must disable polling for SRIOV when hw finished, otherwise
@@ -2418,7 +2418,7 @@ static int gfx_v9_4_3_soft_reset(struct amdgpu_ip_block *ip_block)
 		if (grbm_soft_reset) {
 			tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
 			tmp |= grbm_soft_reset;
-			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+			drm_info(adev_to_drm(adev), "GRBM_SOFT_RESET=0x%08X\n", tmp);
 			WREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET, tmp);
 			tmp = RREG32_SOC15(GC, GET_INST(GC, 0), regGRBM_SOFT_RESET);
 
@@ -3319,7 +3319,7 @@ static int gfx_v9_4_3_priv_reg_irq(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal register access in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal register access in command stream\n");
 	gfx_v9_4_3_fault(adev, entry);
 	return 0;
 }
@@ -3328,7 +3328,7 @@ static int gfx_v9_4_3_bad_op_irq(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal opcode in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal opcode in command stream\n");
 	gfx_v9_4_3_fault(adev, entry);
 	return 0;
 }
@@ -3337,7 +3337,7 @@ static int gfx_v9_4_3_priv_inst_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal instruction in command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in command stream\n");
 	gfx_v9_4_3_fault(adev, entry);
 	return 0;
 }
@@ -3541,19 +3541,19 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 
 	r = amdgpu_ring_test_ring(kiq_ring);
 	if (r) {
-		dev_err(adev->dev, "kiq ring test failed after ring: %s queue reset\n",
+		drm_err(adev_to_drm(adev), "kiq ring test failed after ring: %s queue reset\n",
 				ring->name);
 		goto pipe_reset;
 	}
 
 	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
 	if (r)
-		dev_err(adev->dev, "fail to wait on hqd deactive and will try pipe reset\n");
+		drm_err(adev_to_drm(adev), "fail to wait on hqd deactive and will try pipe reset\n");
 
 pipe_reset:
 	if(r) {
 		r = gfx_v9_4_3_reset_hw_pipe(ring);
-		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
+		drm_info(adev_to_drm(adev), "ring: %s pipe reset :%s\n", ring->name,
 				r ? "failed" : "successfully");
 		if (r)
 			return r;
@@ -3561,7 +3561,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 
 	r = gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
 	if (r) {
-		dev_err(adev->dev, "fail to init kcq\n");
+		drm_err(adev_to_drm(adev), "fail to init kcq\n");
 		return r;
 	}
 	spin_lock_irqsave(&kiq->ring_lock, flags);
@@ -3576,7 +3576,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 
 	r = amdgpu_ring_test_ring(kiq_ring);
 	if (r) {
-		dev_err(adev->dev, "fail to remap queue\n");
+		drm_err(adev_to_drm(adev), "fail to remap queue\n");
 		return r;
 	}
 	return amdgpu_ring_test_ring(ring);
@@ -4464,7 +4464,7 @@ static void gfx_v9_4_3_inst_enable_watchdog_timer(struct amdgpu_device *adev,
 	if (amdgpu_watchdog_timer.timeout_fatal_disable &&
 	    (amdgpu_watchdog_timer.period < 1 ||
 	     amdgpu_watchdog_timer.period > 0x23)) {
-		dev_warn(adev->dev, "Watchdog period range is 1 to 0x23\n");
+		drm_warn(adev_to_drm(adev), "Watchdog period range is 1 to 0x23\n");
 		amdgpu_watchdog_timer.period = 0x23;
 	}
 	data = REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, PERIOD_SEL,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index f9949fedfbb99..85273f3c3824c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -83,25 +83,25 @@ gfxhub_v11_5_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	u32 cid = REG_GET_FIELD(status,
 				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
 		cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t RW: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 7609b9cecae84..10aae6e31fc64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -85,25 +85,25 @@ gfxhub_v12_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	u32 cid = REG_GET_FIELD(status,
 				GCVM_L2_PROTECTION_FAULT_STATUS_LO32, CID);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
 		cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t RW: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS_LO32, RW));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 793faf62cb073..8906d4e83330b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -79,25 +79,25 @@ gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	u32 cid = REG_GET_FIELD(status,
 				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
 		cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t RW: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index deb95fab02dfe..4b827c09a90ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -82,25 +82,25 @@ gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	u32 cid = REG_GET_FIELD(status,
 				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
 		cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t RW: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index abe30c8bd2bae..0ffcfa23bbf49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -78,25 +78,25 @@ gfxhub_v3_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	u32 cid = REG_GET_FIELD(status,
 				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
 		cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t RW: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index b3ef6e71811f3..693cfc0588cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -81,25 +81,25 @@ gfxhub_v3_0_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	u32 cid = REG_GET_FIELD(status,
 				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
 		cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t RW: 0x%lx\n",
 		REG_GET_FIELD(status,
 		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8ae4c031162bc..625257a3d5db5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -158,20 +158,20 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 		entry->vmid_src ? "mmhub" : "gfxhub",
 		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
 	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
 	if (task_info) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			" in process %s pid %d thread %s pid %d\n",
 			task_info->process_name, task_info->tgid,
 			task_info->task_name, task_info->pid);
 		amdgpu_vm_put_task_info(task_info);
 	}
 
-	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
+	drm_err(adev_to_drm(adev), "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
 			addr, entry->client_id,
 			soc15_ih_clientid_name[entry->client_id]);
 
@@ -302,7 +302,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		}
 
 		if (i >= adev->usec_timeout)
-			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
+			drm_err(adev_to_drm(adev), "Timeout waiting for sem acquire in VM flush!\n");
 	}
 
 	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
@@ -332,7 +332,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	spin_unlock(&adev->gmc.invalidate_lock);
 
 	if (i >= adev->usec_timeout)
-		dev_err(adev->dev, "Timeout waiting for VM flush hub: %d!\n",
+		drm_err(adev_to_drm(adev), "Timeout waiting for VM flush hub: %d!\n",
 			vmhub);
 }
 
@@ -869,7 +869,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
+		drm_warn(adev_to_drm(adev), "amdgpu: No suitable DMA available.\n");
 		return r;
 	}
 
@@ -946,7 +946,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	bool value;
 
 	if (adev->gart.bo == NULL) {
-		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
+		drm_err(adev_to_drm(adev), "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
 
@@ -977,7 +977,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (!adev->in_s0ix)
 		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
-	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 5c91d4445418c..cb83b5b3c1e36 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -128,20 +128,20 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	if (printk_ratelimit()) {
 		struct amdgpu_task_info *task_info;
 
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 			entry->vmid_src ? "mmhub" : "gfxhub",
 			entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
 		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
 		if (task_info) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				" in process %s pid %d thread %s pid %d)\n",
 				task_info->process_name, task_info->tgid,
 				task_info->task_name, task_info->pid);
 			amdgpu_vm_put_task_info(task_info);
 		}
 
-		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
+		drm_err(adev_to_drm(adev), "  in page starting at address 0x%016llx from client %d\n",
 				addr, entry->client_id);
 
 		/* Only print L2 fault status if the status register could be read and
@@ -263,7 +263,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		}
 
 		if (i >= adev->usec_timeout)
-			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
+			drm_err(adev_to_drm(adev), "Timeout waiting for sem acquire in VM flush!\n");
 	}
 
 	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
@@ -298,7 +298,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	spin_unlock(&adev->gmc.invalidate_lock);
 
 	if (i >= adev->usec_timeout)
-		dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
+		drm_err(adev_to_drm(adev), "Timeout waiting for VM flush ACK!\n");
 }
 
 /**
@@ -801,7 +801,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
+		drm_warn(adev_to_drm(adev), "amdgpu: No suitable DMA available.\n");
 		return r;
 	}
 
@@ -884,7 +884,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 	bool value;
 
 	if (adev->gart.bo == NULL) {
-		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
+		drm_err(adev_to_drm(adev), "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
 
@@ -903,7 +903,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
-	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 6e15cff6d5480..efd5713299154 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -121,20 +121,20 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 	if (printk_ratelimit()) {
 		struct amdgpu_task_info *task_info;
 
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 			entry->vmid_src ? "mmhub" : "gfxhub",
 			entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
 		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
 		if (task_info) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				" in process %s pid %d thread %s pid %d)\n",
 				task_info->process_name, task_info->tgid,
 				task_info->task_name, task_info->pid);
 			amdgpu_vm_put_task_info(task_info);
 		}
 
-		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
+		drm_err(adev_to_drm(adev), "  in page starting at address 0x%016llx from client %d\n",
 				addr, entry->client_id);
 
 		/* Only print L2 fault status if the status register could be read and
@@ -233,7 +233,7 @@ static void gmc_v12_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 		}
 
 		if (i >= adev->usec_timeout)
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Timeout waiting for sem acquire in VM flush!\n");
 	}
 
@@ -277,7 +277,7 @@ static void gmc_v12_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (i < adev->usec_timeout)
 		return;
 
-	dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
+	drm_err(adev_to_drm(adev), "Timeout waiting for VM flush ACK!\n");
 }
 
 /**
@@ -866,7 +866,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 	bool value;
 
 	if (adev->gart.bo == NULL) {
-		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
+		drm_err(adev_to_drm(adev), "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
 
@@ -885,7 +885,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	gmc_v12_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
-	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 19b93ee70fffc..2c3162ea1524c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -134,7 +134,7 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 	err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 		       "si_mc: Failed to load firmware \"%s_mc.bin\"\n",
 		       chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
@@ -237,7 +237,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 		return;
 
 	if (gmc_v6_0_wait_for_idle(ip_block))
-		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
+		drm_warn(adev_to_drm(adev), "Wait for MC idle timedout !\n");
 
 	if (adev->mode_info.num_crtc) {
 		u32 tmp;
@@ -264,7 +264,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 
 	if (gmc_v6_0_wait_for_idle(ip_block))
-		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
+		drm_warn(adev_to_drm(adev), "Wait for MC idle timedout !\n");
 }
 
 static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
@@ -421,7 +421,7 @@ static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)
 	u32 tmp;
 
 	if (enable && !adev->gmc.prt_warning) {
-		dev_warn(adev->dev, "Disabling VM faults because of PRT request!\n");
+		drm_warn(adev_to_drm(adev), "Disabling VM faults because of PRT request!\n");
 		adev->gmc.prt_warning = true;
 	}
 
@@ -473,7 +473,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
 	int i;
 
 	if (adev->gart.bo == NULL) {
-		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
+		drm_err(adev_to_drm(adev), "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
 	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
@@ -553,7 +553,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
 		gmc_v6_0_set_fault_enable_default(adev, true);
 
 	gmc_v6_0_flush_gpu_tlb(adev, 0, 0, 0);
-	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)table_addr);
 	return 0;
@@ -564,7 +564,7 @@ static int gmc_v6_0_gart_init(struct amdgpu_device *adev)
 	int r;
 
 	if (adev->gart.bo) {
-		dev_warn(adev->dev, "gmc_v6_0 PCIE GART already initialized\n");
+		drm_warn(adev_to_drm(adev), "gmc_v6_0 PCIE GART already initialized\n");
 		return 0;
 	}
 	r = amdgpu_gart_init(adev);
@@ -620,7 +620,7 @@ static void gmc_v6_0_vm_decode_fault(struct amdgpu_device *adev,
 	mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			      MEMORY_CLIENT_ID);
 
-	dev_err(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
+	drm_err(adev_to_drm(adev), "VM fault (0x%02x, vmid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
 	       protections, vmid, addr,
 	       REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     MEMORY_CLIENT_RW) ?
@@ -841,14 +841,14 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
 	if (r) {
-		dev_warn(adev->dev, "No suitable DMA available.\n");
+		drm_warn(adev_to_drm(adev), "No suitable DMA available.\n");
 		return r;
 	}
 	adev->need_swiotlb = drm_need_swiotlb(40);
 
 	r = gmc_v6_0_init_microcode(adev);
 	if (r) {
-		dev_err(adev->dev, "Failed to load mc firmware!\n");
+		drm_err(adev_to_drm(adev), "Failed to load mc firmware!\n");
 		return r;
 	}
 
@@ -911,7 +911,7 @@ static int gmc_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!(adev->flags & AMD_IS_APU)) {
 		r = gmc_v6_0_mc_load_microcode(adev);
 		if (r) {
-			dev_err(adev->dev, "Failed to load MC firmware!\n");
+			drm_err(adev_to_drm(adev), "Failed to load MC firmware!\n");
 			return r;
 		}
 	}
@@ -1006,11 +1006,11 @@ static int gmc_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 		gmc_v6_0_mc_stop(adev);
 
 		if (gmc_v6_0_wait_for_idle(ip_block))
-			dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
+			drm_warn(adev_to_drm(adev), "Wait for GMC idle timed out !\n");
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -1083,11 +1083,11 @@ static int gmc_v6_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v6_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
+		drm_err(adev_to_drm(adev), "GPU fault detected: %d 0x%08x\n",
 			entry->src_id, entry->src_data[0]);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
+		drm_err(adev_to_drm(adev), "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
 			addr);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
+		drm_err(adev_to_drm(adev), "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
 			status);
 		gmc_v6_0_vm_decode_fault(adev, status, addr, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 18cac87b99fa8..bbe7223ff7627 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -276,7 +276,7 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmHDP_REG_COHERENCY_FLUSH_CNTL, 0);
 
 	if (gmc_v7_0_wait_for_idle(ip_block))
-		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
+		drm_warn(adev_to_drm(adev), "Wait for MC idle timedout !\n");
 
 	if (adev->mode_info.num_crtc) {
 		/* Lockout access through VGA aperture*/
@@ -300,7 +300,7 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
 	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 	if (gmc_v7_0_wait_for_idle(ip_block))
-		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
+		drm_warn(adev_to_drm(adev), "Wait for MC idle timedout !\n");
 
 	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
 
@@ -549,7 +549,7 @@ static void gmc_v7_0_set_prt(struct amdgpu_device *adev, bool enable)
 	uint32_t tmp;
 
 	if (enable && !adev->gmc.prt_warning) {
-		dev_warn(adev->dev, "Disabling VM faults because of PRT request!\n");
+		drm_warn(adev_to_drm(adev), "Disabling VM faults because of PRT request!\n");
 		adev->gmc.prt_warning = true;
 	}
 
@@ -614,7 +614,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
 	int i;
 
 	if (adev->gart.bo == NULL) {
-		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
+		drm_err(adev_to_drm(adev), "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
 	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
@@ -703,7 +703,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
 	}
 
 	gmc_v7_0_flush_gpu_tlb(adev, 0, 0, 0);
-	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)table_addr);
 	return 0;
@@ -777,7 +777,7 @@ static void gmc_v7_0_vm_decode_fault(struct amdgpu_device *adev, u32 status,
 	mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			      MEMORY_CLIENT_ID);
 
-	dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
+	drm_err(adev_to_drm(adev), "VM fault (0x%02x, vmid %d, pasid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
 	       protections, vmid, pasid, addr,
 	       REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     MEMORY_CLIENT_RW) ?
@@ -1024,7 +1024,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v7_0_init_microcode(adev);
 	if (r) {
-		DRM_ERROR("Failed to load mc firmware!\n");
+		drm_err(adev_to_drm(adev), "Failed to load mc firmware!\n");
 		return r;
 	}
 
@@ -1097,7 +1097,7 @@ static int gmc_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!(adev->flags & AMD_IS_APU)) {
 		r = gmc_v7_0_mc_load_microcode(adev);
 		if (r) {
-			DRM_ERROR("Failed to load MC firmware!\n");
+			drm_err(adev_to_drm(adev), "Failed to load MC firmware!\n");
 			return r;
 		}
 	}
@@ -1188,11 +1188,11 @@ static int gmc_v7_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		gmc_v7_0_mc_stop(adev);
 		if (gmc_v7_0_wait_for_idle(ip_block))
-			dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
+			drm_warn(adev_to_drm(adev), "Wait for GMC idle timed out !\n");
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -1275,11 +1275,11 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v7_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
+		drm_err(adev_to_drm(adev), "GPU fault detected: %d 0x%08x\n",
 			entry->src_id, entry->src_data[0]);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
+		drm_err(adev_to_drm(adev), "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
 			addr);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
+		drm_err(adev_to_drm(adev), "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
 			status);
 		gmc_v7_0_vm_decode_fault(adev, status, addr, mc_client,
 					 entry->pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 2594b19235015..828fce5916504 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -365,7 +365,7 @@ static int gmc_v8_0_polaris_mc_load_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	hdr = (const struct mc_firmware_header_v1_0 *)adev->gmc.fw->data;
-	amdgpu_ucode_print_mc_hdr(&hdr->header);
+	amdgpu_ucode_print_mc_hdr(adev, &hdr->header);
 
 	adev->gmc.fw_version = le32_to_cpu(hdr->header.ucode_version);
 	regs_size = le32_to_cpu(hdr->io_debug_size_bytes) / (4 * 2);
@@ -451,7 +451,7 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 		return;
 
 	if (gmc_v8_0_wait_for_idle(ip_block))
-		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
+		drm_warn(adev_to_drm(adev), "Wait for MC idle timedout !\n");
 
 	if (adev->mode_info.num_crtc) {
 		/* Lockout access through VGA aperture*/
@@ -486,7 +486,7 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
 	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 	if (gmc_v8_0_wait_for_idle(ip_block))
-		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
+		drm_warn(adev_to_drm(adev), "Wait for MC idle timedout !\n");
 
 	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
 
@@ -560,7 +560,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	tmp = RREG32(mmCONFIG_MEMSIZE);
 	/* some boards may have garbage in the upper 16 bits */
 	if (tmp & 0xffff0000) {
-		DRM_INFO("Probable bad vram size: 0x%08x\n", tmp);
+		drm_info(adev_to_drm(adev), "Probable bad vram size: 0x%08x\n", tmp);
 		if (tmp & 0xffff)
 			tmp &= 0xffff;
 	}
@@ -764,7 +764,7 @@ static void gmc_v8_0_set_prt(struct amdgpu_device *adev, bool enable)
 	u32 tmp;
 
 	if (enable && !adev->gmc.prt_warning) {
-		dev_warn(adev->dev, "Disabling VM faults because of PRT request!\n");
+		drm_warn(adev_to_drm(adev), "Disabling VM faults because of PRT request!\n");
 		adev->gmc.prt_warning = true;
 	}
 
@@ -829,7 +829,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
 	int i;
 
 	if (adev->gart.bo == NULL) {
-		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
+		drm_err(adev_to_drm(adev), "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
 	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
@@ -935,7 +935,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
 		gmc_v8_0_set_fault_enable_default(adev, true);
 
 	gmc_v8_0_flush_gpu_tlb(adev, 0, 0, 0);
-	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)table_addr);
 	return 0;
@@ -1009,7 +1009,7 @@ static void gmc_v8_0_vm_decode_fault(struct amdgpu_device *adev, u32 status,
 	mc_id = REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			      MEMORY_CLIENT_ID);
 
-	dev_err(adev->dev, "VM fault (0x%02x, vmid %d, pasid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
+	drm_err(adev_to_drm(adev), "VM fault (0x%02x, vmid %d, pasid %d) at page %u, %s from '%s' (0x%08x) (%d)\n",
 	       protections, vmid, pasid, addr,
 	       REG_GET_FIELD(status, VM_CONTEXT1_PROTECTION_FAULT_STATUS,
 			     MEMORY_CLIENT_RW) ?
@@ -1137,7 +1137,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v8_0_init_microcode(adev);
 	if (r) {
-		DRM_ERROR("Failed to load mc firmware!\n");
+		drm_err(adev_to_drm(adev), "Failed to load mc firmware!\n");
 		return r;
 	}
 
@@ -1210,7 +1210,7 @@ static int gmc_v8_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (adev->asic_type == CHIP_TONGA) {
 		r = gmc_v8_0_tonga_mc_load_microcode(adev);
 		if (r) {
-			DRM_ERROR("Failed to load MC firmware!\n");
+			drm_err(adev_to_drm(adev), "Failed to load MC firmware!\n");
 			return r;
 		}
 	} else if (adev->asic_type == CHIP_POLARIS11 ||
@@ -1218,7 +1218,7 @@ static int gmc_v8_0_hw_init(struct amdgpu_ip_block *ip_block)
 			adev->asic_type == CHIP_POLARIS12) {
 		r = gmc_v8_0_polaris_mc_load_microcode(adev);
 		if (r) {
-			DRM_ERROR("Failed to load MC firmware!\n");
+			drm_err(adev_to_drm(adev), "Failed to load MC firmware!\n");
 			return r;
 		}
 	}
@@ -1333,7 +1333,7 @@ static int gmc_v8_0_pre_soft_reset(struct amdgpu_ip_block *ip_block)
 
 	gmc_v8_0_mc_stop(adev);
 	if (gmc_v8_0_wait_for_idle(ip_block))
-		dev_warn(adev->dev, "Wait for GMC idle timed out !\n");
+		drm_warn(adev_to_drm(adev), "Wait for GMC idle timed out !\n");
 
 	return 0;
 }
@@ -1352,7 +1352,7 @@ static int gmc_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -1429,9 +1429,9 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	u32 addr, status, mc_client, vmid;
 
 	if (amdgpu_sriov_vf(adev)) {
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
+		drm_err(adev_to_drm(adev), "GPU fault detected: %d 0x%08x\n",
 			entry->src_id, entry->src_data[0]);
-		dev_err(adev->dev, " Can't decode VM fault info here on SRIOV VF\n");
+		drm_err(adev_to_drm(adev), " Can't decode VM fault info here on SRIOV VF\n");
 		return 0;
 	}
 
@@ -1453,20 +1453,20 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 	if (printk_ratelimit()) {
 		struct amdgpu_task_info *task_info;
 
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
+		drm_err(adev_to_drm(adev), "GPU fault detected: %d 0x%08x\n",
 			entry->src_id, entry->src_data[0]);
 
 		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
 		if (task_info) {
-			dev_err(adev->dev, " for process %s pid %d thread %s pid %d\n",
+			drm_err(adev_to_drm(adev), " for process %s pid %d thread %s pid %d\n",
 				task_info->process_name, task_info->tgid,
 				task_info->task_name, task_info->pid);
 			amdgpu_vm_put_task_info(task_info);
 		}
 
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
+		drm_err(adev_to_drm(adev), "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
 				addr);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
+		drm_err(adev_to_drm(adev), "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
 			status);
 
 		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 783e0c3b86b4c..3f8b6e90cc135 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -634,26 +634,26 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n", hub_name,
 		retry_fault ? "retry" : "no-retry",
 		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
 
 	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
 	if (task_info) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			" for process %s pid %d thread %s pid %d)\n",
 			task_info->process_name, task_info->tgid,
 			task_info->task_name, task_info->pid);
 		amdgpu_vm_put_task_info(task_info);
 	}
 
-	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
+	drm_err(adev_to_drm(adev), "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
 
 	if (gmc_v9_0_is_multi_chiplet(adev))
-		dev_err(adev->dev, "  cookie node_id %d fault from die %s%d%s\n",
+		drm_err(adev_to_drm(adev), "  cookie node_id %d fault from die %s%d%s\n",
 			node_id, node_id % 4 == 3 ? "RSV" : "AID", node_id / 4,
 			node_id % 4 == 1 ? ".XCD0" : node_id % 4 == 2 ? ".XCD1" : "");
 
@@ -690,11 +690,11 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 
 	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 	if (entry->vmid_src == AMDGPU_GFXHUB(0)) {
-		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 			cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" :
 			gfxhub_client_ids[cid],
 			cid);
@@ -728,22 +728,22 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			mmhub_cid = NULL;
 			break;
 		}
-		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+		drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 			mmhub_cid ? mmhub_cid : "unknown", cid);
 	}
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		VM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	drm_err(adev_to_drm(adev), "\t RW: 0x%x\n", rw);
 	return 0;
 }
 
@@ -898,7 +898,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		}
 
 		if (j >= adev->usec_timeout)
-			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
+			drm_err(adev_to_drm(adev), "Timeout waiting for sem acquire in VM flush!\n");
 	}
 
 	if (vmhub >= AMDGPU_MMHUB0(0))
@@ -942,7 +942,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	if (j < adev->usec_timeout)
 		return;
 
-	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
+	drm_err(adev_to_drm(adev), "Timeout waiting for VM flush ACK!\n");
 }
 
 /**
@@ -1858,10 +1858,10 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 				 AMDGPU_PTE_EXECUTABLE;
 
 	if (!adev->gmc.real_vram_size) {
-		dev_info(adev->dev, "Put GART in system memory for APU\n");
+		drm_info(adev_to_drm(adev), "Put GART in system memory for APU\n");
 		r = amdgpu_gart_table_ram_alloc(adev);
 		if (r)
-			dev_err(adev->dev, "Failed to allocate GART in system memory\n");
+			drm_err(adev_to_drm(adev), "Failed to allocate GART in system memory\n");
 	} else {
 		r = amdgpu_gart_table_vram_alloc(adev);
 		if (r)
@@ -2015,7 +2015,7 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *adev,
 
 	} else {
 		if (!adev->gmc.num_mem_partitions) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Not able to detect NPS mode, fall back to NPS1");
 			adev->gmc.num_mem_partitions = 1;
 		}
@@ -2064,7 +2064,7 @@ static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
 		valid = gmc_v9_0_validate_partition_info(adev);
 	if (!valid) {
 		/* TODO: handle invalid case */
-		dev_WARN(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "Mem ranges not matching with hardware config");
 	}
 
@@ -2228,7 +2228,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 				44;
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_bits));
 	if (r) {
-		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
+		drm_warn(adev_to_drm(adev), "amdgpu: No suitable DMA available.\n");
 		return r;
 	}
 	adev->need_swiotlb = drm_need_swiotlb(dma_addr_bits);
@@ -2297,7 +2297,7 @@ static int gmc_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
 	if (!adev->gmc.real_vram_size) {
-		dev_info(adev->dev, "Put GART in system memory for APU free\n");
+		drm_info(adev_to_drm(adev), "Put GART in system memory for APU free\n");
 		amdgpu_gart_table_ram_free(adev);
 	} else {
 		amdgpu_gart_table_vram_free(adev);
@@ -2368,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 		amdgpu_gmc_init_pdb0(adev);
 
 	if (adev->gart.bo == NULL) {
-		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
+		drm_err(adev_to_drm(adev), "No VRAM object for PCIE GART.\n");
 		return -EINVAL;
 	}
 
@@ -2384,12 +2384,12 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	DRM_INFO("PCIE GART of %uM enabled.\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled.\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20));
 	if (adev->gmc.pdb0_bo)
-		DRM_INFO("PDB0 located at 0x%016llX\n",
+		drm_info(adev_to_drm(adev), "PDB0 located at 0x%016llX\n",
 				(unsigned long long)amdgpu_bo_gpu_offset(adev->gmc.pdb0_bo));
-	DRM_INFO("PTB located at 0x%016llX\n",
+	drm_info(adev_to_drm(adev), "PTB located at 0x%016llX\n",
 			(unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 1317ede131b6a..6f85ced7ee4e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -208,7 +208,7 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *adev,
 	 * from the last not overwritten vector (wptr + 16). Hopefully
 	 * this should allow us to catchup.
 	 */
-	dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+	drm_warn(adev_to_drm(adev), "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
 		wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
 	ih->rptr = (wptr + 16) & ih->ptr_mask;
 	tmp = RREG32(mmIH_RB_CNTL);
@@ -375,7 +375,7 @@ static int iceland_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index eb4185dcbd1d4..a40bb06b85b66 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -285,7 +285,7 @@ static int ih_v6_0_enable_ring(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			drm_err(adev_to_drm(adev), "PSP program IH_RB_CNTL failed!\n");
 			return -ETIMEDOUT;
 		}
 	} else {
@@ -453,7 +453,7 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
 	 * this should allow us to catch up.
 	 */
 	tmp = (wptr + 32) & ih->ptr_mask;
-	dev_warn(adev->dev, "IH ring buffer overflow "
+	drm_warn(adev_to_drm(adev), "IH ring buffer overflow "
 		 "(0x%08X, 0x%08X, 0x%08X)\n",
 		 wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 068ed849dbada..0032025c4730b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -257,7 +257,7 @@ static int ih_v6_1_enable_ring(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			drm_err(adev_to_drm(adev), "PSP program IH_RB_CNTL failed!\n");
 			return -ETIMEDOUT;
 		}
 	} else {
@@ -425,7 +425,7 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev,
 	 * this should allow us to catch up.
 	 */
 	tmp = (wptr + 32) & ih->ptr_mask;
-	dev_warn(adev->dev, "IH ring buffer overflow "
+	drm_warn(adev_to_drm(adev), "IH ring buffer overflow "
 		 "(0x%08X, 0x%08X, 0x%08X)\n",
 		 wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 40a3530e04539..d0b794e9bbdf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -257,7 +257,7 @@ static int ih_v7_0_enable_ring(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			drm_err(adev_to_drm(adev), "PSP program IH_RB_CNTL failed!\n");
 			return -ETIMEDOUT;
 		}
 	} else {
@@ -425,7 +425,7 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
 	 * this should allow us to catch up.
 	 */
 	tmp = (wptr + 32) & ih->ptr_mask;
-	dev_warn(adev->dev, "IH ring buffer overflow "
+	drm_warn(adev_to_drm(adev), "IH ring buffer overflow "
 		 "(0x%08X, 0x%08X, 0x%08X)\n",
 		 wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index cfa91d709d499..0db1589f48649 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -75,7 +75,7 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"gfx11: Failed to load firmware \"%s_imu.bin\"\n",
 			ucode_prefix);
 		amdgpu_ucode_release(&adev->gfx.imu_fw);
@@ -94,7 +94,6 @@ static int imu_v11_0_load_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	hdr = (const struct imu_firmware_header_v1_0 *)adev->gfx.imu_fw->data;
-	//amdgpu_ucode_print_rlc_hdr(&hdr->header);
 
 	fw_data = (const __le32 *)(adev->gfx.imu_fw->data +
 			le32_to_cpu(hdr->header.ucode_array_offset_bytes));
@@ -134,7 +133,7 @@ static int imu_v11_0_wait_for_reset_status(struct amdgpu_device *adev)
 	}
 
 	if (i >= adev->usec_timeout) {
-		dev_err(adev->dev, "init imu: IMU start timeout\n");
+		drm_err(adev_to_drm(adev), "init imu: IMU start timeout\n");
 		return -ETIMEDOUT;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index df898dbb746e3..eefcdfe85ae67 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -70,7 +70,7 @@ static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"gfx12: Failed to load firmware \"%s_imu.bin\"\n",
 			ucode_prefix);
 		amdgpu_ucode_release(&adev->gfx.imu_fw);
@@ -129,7 +129,7 @@ static int imu_v12_0_wait_for_reset_status(struct amdgpu_device *adev)
 	}
 
 	if (i >= adev->usec_timeout) {
-		dev_err(adev->dev, "init imu: IMU start timeout\n");
+		drm_err(adev_to_drm(adev), "init imu: IMU start timeout\n");
 		return -ETIMEDOUT;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 9e428e669ada6..b181a14aa339b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -447,7 +447,7 @@ static int jpeg_v1_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -678,7 +678,7 @@ static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
 		}
 
 		if (ret) {
-			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			drm_err(adev_to_drm(adev), "Invalid packet [0x%08x]!\n", ib->ptr[i]);
 			break;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 4cde8a8bcc837..3aaca9ba5f392 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -238,7 +238,7 @@ static int jpeg_v2_0_disable_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_ERROR("amdgpu: JPEG disable power gating failed\n");
+			drm_err(adev_to_drm(adev), "amdgpu: JPEG disable power gating failed\n");
 			return r;
 		}
 	}
@@ -269,7 +269,7 @@ static int jpeg_v2_0_enable_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_ERROR("amdgpu: JPEG enable power gating failed\n");
+			drm_err(adev_to_drm(adev), "amdgpu: JPEG enable power gating failed\n");
 			return r;
 		}
 	}
@@ -756,7 +756,7 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -873,24 +873,24 @@ int jpeg_v2_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
 		case PACKETJ_TYPE0:
 			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START ||
 			    reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				drm_err(adev_to_drm(adev), "Invalid packet [0x%08x]!\n", ib->ptr[i]);
 				return -EINVAL;
 			}
 			break;
 		case PACKETJ_TYPE3:
 			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START ||
 			    reg > JPEG_REG_RANGE_END) {
-				dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+				drm_err(adev_to_drm(adev), "Invalid packet [0x%08x]!\n", ib->ptr[i]);
 				return -EINVAL;
 			}
 			break;
 		case PACKETJ_TYPE6:
 			if (ib->ptr[i] == CP_PACKETJ_NOP)
 				continue;
-			dev_err(adev->dev, "Invalid packet [0x%08x]!\n", ib->ptr[i]);
+			drm_err(adev_to_drm(adev), "Invalid packet [0x%08x]!\n", ib->ptr[i]);
 			return -EINVAL;
 		default:
-			dev_err(adev->dev, "Unknown packet type %d !\n", type);
+			drm_err(adev_to_drm(adev), "Unknown packet type %d !\n", type);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8b39e114f3be1..ba102204d734d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -624,7 +624,7 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 		ip_instance = 1;
 		break;
 	default:
-		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+		drm_err(adev_to_drm(adev), "Unhandled client id: %d\n", entry->client_id);
 		return 0;
 	}
 
@@ -635,7 +635,7 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(adev->jpeg.inst[ip_instance].ring_dec);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -822,7 +822,7 @@ static uint32_t jpeg_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
 	}
 
 	if (poison_stat)
-		dev_info(adev->dev, "Poison detected in JPEG%d sub_block%d\n",
+		drm_info(adev_to_drm(adev), "Poison detected in JPEG%d sub_block%d\n",
 			instance, sub_block);
 
 	return poison_stat;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 2f8510c2986b9..83f22747f7afb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -295,7 +295,7 @@ static int jpeg_v3_0_disable_static_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_ERROR("amdgpu: JPEG disable power gating failed\n");
+			drm_err(adev_to_drm(adev), "amdgpu: JPEG disable power gating failed\n");
 			return r;
 		}
 	}
@@ -330,7 +330,7 @@ static int jpeg_v3_0_enable_static_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_ERROR("amdgpu: JPEG enable power gating failed\n");
+			drm_err(adev_to_drm(adev), "amdgpu: JPEG enable power gating failed\n");
 			return r;
 		}
 	}
@@ -547,7 +547,7 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index f17ec5414fd69..c3e2ce86fcb76 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -534,7 +534,7 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
 		udelay(10);
 		tmp = tmp + 10;
 		if (tmp >= timeout) {
-			DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+			drm_err(adev_to_drm(adev), "failed to init MMSCH. TIME-OUT after %d usec"\
 				" waiting for regMMSCH_VF_MAILBOX_RESP "\
 				"(expected=0x%08x, readback=0x%08x)\n",
 				tmp, expected, resp);
@@ -543,7 +543,7 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
 	}
 	if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
 			&& init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
-		DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init status for jpeg: %x\n", resp, init_status);
+		drm_err(adev_to_drm(adev), "MMSCH init status is incorrect! readback=0x%08x, header init status for jpeg: %x\n", resp, init_status);
 		return -EINVAL;
 	}
 
@@ -828,7 +828,7 @@ static uint32_t jpeg_v4_0_query_poison_by_instance(struct amdgpu_device *adev,
 	}
 
 	if (poison_stat)
-		dev_info(adev->dev, "Poison detected in JPEG%d sub_block%d\n",
+		drm_info(adev_to_drm(adev), "Poison detected in JPEG%d sub_block%d\n",
 			instance, sub_block);
 
 	return poison_stat;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index a8ccae361ec78..c9826974c6af2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -195,7 +195,7 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
 		r = amdgpu_jpeg_ras_sw_init(adev);
 		if (r) {
-			dev_err(adev->dev, "Failed to initialize jpeg ras block!\n");
+			drm_err(adev_to_drm(adev), "Failed to initialize jpeg ras block!\n");
 			return r;
 		}
 	}
@@ -335,7 +335,7 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
 			udelay(10);
 			tmp = tmp + 10;
 			if (tmp >= timeout) {
-				DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+				drm_err(adev_to_drm(adev), "failed to init MMSCH. TIME-OUT after %d usec"\
 					" waiting for regMMSCH_VF_MAILBOX_RESP "\
 					"(expected=0x%08x, readback=0x%08x)\n",
 					tmp, expected, resp);
@@ -344,7 +344,7 @@ static int jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
 		}
 		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE &&
 				init_status != MMSCH_VF_ENGINE_STATUS__PASS)
-			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init status for jpeg: %x\n",
+			drm_err(adev_to_drm(adev), "MMSCH init status is incorrect! readback=0x%08x, header init status for jpeg: %x\n",
 					resp, init_status);
 
 	}
@@ -1274,7 +1274,7 @@ static void jpeg_v4_0_3_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t i;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
-		dev_warn(adev->dev, "JPEG RAS is not supported\n");
+		drm_warn(adev_to_drm(adev), "JPEG RAS is not supported\n");
 		return;
 	}
 
@@ -1296,7 +1296,7 @@ static void jpeg_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
 	uint32_t i;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
-		dev_warn(adev->dev, "JPEG RAS is not supported\n");
+		drm_warn(adev_to_drm(adev), "JPEG RAS is not supported\n");
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 974030a5c03c9..efb07386ab835 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -746,7 +746,7 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 		ip_instance = 1;
 		break;
 	default:
-		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+		drm_err(adev_to_drm(adev), "Unhandled client id: %d\n", entry->client_id);
 		return 0;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
index 1a285b5318815..147535e974cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
@@ -64,7 +64,7 @@ static int lsdma_v6_0_copy_mem(struct amdgpu_device *adev,
 
 	ret = lsdma_v6_0_wait_pio_status(adev);
 	if (ret)
-		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
+		drm_err(adev_to_drm(adev), "LSDMA PIO failed to copy memory!\n");
 
 	return ret;
 }
@@ -96,7 +96,7 @@ static int lsdma_v6_0_fill_mem(struct amdgpu_device *adev,
 
 	ret = lsdma_v6_0_wait_pio_status(adev);
 	if (ret)
-		dev_err(adev->dev, "LSDMA PIO failed to fill memory!\n");
+		drm_err(adev_to_drm(adev), "LSDMA PIO failed to fill memory!\n");
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
index 396262044ea89..297af3ddb471a 100644
--- a/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
@@ -64,7 +64,7 @@ static int lsdma_v7_0_copy_mem(struct amdgpu_device *adev,
 
 	ret = lsdma_v7_0_wait_pio_status(adev);
 	if (ret)
-		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
+		drm_err(adev_to_drm(adev), "LSDMA PIO failed to copy memory!\n");
 
 	return ret;
 }
@@ -96,7 +96,7 @@ static int lsdma_v7_0_fill_mem(struct amdgpu_device *adev,
 
 	ret = lsdma_v7_0_wait_pio_status(adev);
 	if (ret)
-		dev_err(adev->dev, "LSDMA PIO failed to fill memory!\n");
+		drm_err(adev_to_drm(adev), "LSDMA PIO failed to fill memory!\n");
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b469b800119ff..86646bdbaa974 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -290,7 +290,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
-		dev_err(adev->dev, "pm_runtime_get_sync() failed for userqueue mqd create\n");
+		drm_err(adev_to_drm(adev), "pm_runtime_get_sync() failed for userqueue mqd create\n");
 		goto deference_pm;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 16f8bc36afa07..60200e8d5d6fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -243,13 +243,13 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r < 1 || !*status_ptr) {
 
 		if (misc_op_str)
-			dev_err(adev->dev, "MES failed to respond to msg=%s (%s)\n",
+			drm_err(adev_to_drm(adev), "MES failed to respond to msg=%s (%s)\n",
 				op_str, misc_op_str);
 		else if (op_str)
-			dev_err(adev->dev, "MES failed to respond to msg=%s\n",
+			drm_err(adev_to_drm(adev), "MES failed to respond to msg=%s\n",
 				op_str);
 		else
-			dev_err(adev->dev, "MES failed to respond to msg=%d\n",
+			drm_err(adev_to_drm(adev), "MES failed to respond to msg=%d\n",
 				x_pkt->header.opcode);
 
 		while (halt_if_hws_hang)
@@ -263,7 +263,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	return 0;
 
 error_undo:
-	dev_err(adev->dev, "MES ring buffer is full.\n");
+	drm_err(adev_to_drm(adev), "MES ring buffer is full.\n");
 	amdgpu_ring_undo(ring);
 
 error_unlock_free:
@@ -375,7 +375,7 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	if (queue_type == AMDGPU_RING_TYPE_GFX) {
-		dev_info(adev->dev, "reset gfx queue (%d:%d:%d: vmid:%d)\n",
+		drm_info(adev_to_drm(adev), "reset gfx queue (%d:%d:%d: vmid:%d)\n",
 			 me_id, pipe_id, queue_id, vmid);
 
 		mutex_lock(&adev->gfx.reset_sem_mutex);
@@ -401,14 +401,14 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout) {
-			dev_err(adev->dev, "failed to wait on gfx hqd deactivate\n");
+			drm_err(adev_to_drm(adev), "failed to wait on gfx hqd deactivate\n");
 			r = -ETIMEDOUT;
 		}
 
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
-		dev_info(adev->dev, "reset compute queue (%d:%d:%d)\n",
+		drm_info(adev_to_drm(adev), "reset compute queue (%d:%d:%d)\n",
 			 me_id, pipe_id, queue_id);
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
@@ -422,13 +422,13 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout) {
-			dev_err(adev->dev, "failed to wait on hqd deactivate\n");
+			drm_err(adev_to_drm(adev), "failed to wait on hqd deactivate\n");
 			r = -ETIMEDOUT;
 		}
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	} else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
-		dev_info(adev->dev, "reset sdma queue (%d:%d:%d)\n",
+		drm_info(adev_to_drm(adev), "reset sdma queue (%d:%d:%d)\n",
 			 me_id, pipe_id, queue_id);
 		switch (me_id) {
 		case 1:
@@ -449,7 +449,7 @@ static int mes_v11_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout) {
-			dev_err(adev->dev, "failed to wait on sdma queue reset done\n");
+			drm_err(adev_to_drm(adev), "failed to wait on sdma queue reset done\n");
 			r = -ETIMEDOUT;
 		}
 	}
@@ -660,7 +660,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		break;
 
 	default:
-		DRM_ERROR("unsupported misc op (%d) \n", input->op);
+		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d) \n", input->op);
 		return -EINVAL;
 	}
 
@@ -826,7 +826,7 @@ static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
 				      &adev->mes.ucode_fw_gpu_addr[pipe],
 				      (void **)&adev->mes.ucode_fw_ptr[pipe]);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mes fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mes fw bo\n", r);
 		return r;
 	}
 
@@ -854,7 +854,7 @@ static int mes_v11_0_allocate_ucode_data_buffer(struct amdgpu_device *adev,
 	fw_size = le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
 
 	if (fw_size > GFX_MES_DRAM_SIZE) {
-		dev_err(adev->dev, "PIPE%d ucode data fw size (%d) is greater than dram size (%d)\n",
+		drm_err(adev_to_drm(adev), "PIPE%d ucode data fw size (%d) is greater than dram size (%d)\n",
 			pipe, fw_size, GFX_MES_DRAM_SIZE);
 		return -EINVAL;
 	}
@@ -867,7 +867,7 @@ static int mes_v11_0_allocate_ucode_data_buffer(struct amdgpu_device *adev,
 				      &adev->mes.data_fw_gpu_addr[pipe],
 				      (void **)&adev->mes.data_fw_ptr[pipe]);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mes data fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mes data fw bo\n", r);
 		return r;
 	}
 
@@ -924,7 +924,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev, bool enable)
 				lower_32_bits(adev->mes.event_log_gpu_addr + AMDGPU_MES_LOG_BUFFER_SIZE));
 			WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI,
 				upper_32_bits(adev->mes.event_log_gpu_addr + AMDGPU_MES_LOG_BUFFER_SIZE));
-			dev_info(adev->dev, "Setup CP MES MSCRATCH address : 0x%x. 0x%x\n",
+			drm_info(adev_to_drm(adev), "Setup CP MES MSCRATCH address : 0x%x. 0x%x\n",
 				RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI),
 				RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO));
 		}
@@ -1061,7 +1061,7 @@ static int mes_v11_0_allocate_eop_buf(struct amdgpu_device *adev,
 			      &adev->mes.eop_gpu_addr[pipe],
 			      (void **)&eop);
 	if (r) {
-		dev_warn(adev->dev, "(%d) create EOP bo failed\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) create EOP bo failed\n", r);
 		return r;
 	}
 
@@ -1251,7 +1251,7 @@ static int mes_v11_0_kiq_enable_queue(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
 	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		drm_err(adev_to_drm(adev), "Failed to lock KIQ (%d).\n", r);
 		return r;
 	}
 
@@ -1364,7 +1364,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
-		dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
+		drm_warn(adev_to_drm(adev), "failed to create ring mqd bo (%d)", r);
 		return r;
 	}
 
@@ -1373,7 +1373,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 	/* prepare MQD backup */
 	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
 	if (!adev->mes.mqd_backup[pipe]) {
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "no memory to create MQD backup for ring %s\n",
 			 ring->name);
 		return -ENOMEM;
@@ -1433,7 +1433,7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 				    &adev->mes.resource_1_gpu_addr[0],
 				    &adev->mes.resource_1_addr[0]);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mes resource_1 bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mes resource_1 bo\n", r);
 		return r;
 	}
 
@@ -1543,13 +1543,13 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 
 		r = mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE, false);
 		if (r) {
-			DRM_ERROR("failed to load MES fw, r=%d\n", r);
+			drm_err(adev_to_drm(adev), "failed to load MES fw, r=%d\n", r);
 			return r;
 		}
 
 		r = mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE, true);
 		if (r) {
-			DRM_ERROR("failed to load MES kiq fw, r=%d\n", r);
+			drm_err(adev_to_drm(adev), "failed to load MES kiq fw, r=%d\n", r);
 			return r;
 		}
 
@@ -1563,7 +1563,7 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_MES);
 	if (unlikely(!ip_block)) {
-		dev_err(adev->dev, "Failed to get MES handle\n");
+		drm_err(adev_to_drm(adev), "Failed to get MES handle\n");
 		return -EINVAL;
 	}
 
@@ -1619,7 +1619,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 			r = mes_v11_0_load_microcode(adev,
 					     AMDGPU_MES_SCHED_PIPE, true);
 			if (r) {
-				DRM_ERROR("failed to MES fw, r=%d\n", r);
+				drm_err(adev_to_drm(adev), "failed to MES fw, r=%d\n", r);
 				return r;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index bcabebd18fe84..4650bec017c8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -228,13 +228,13 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	if (r < 1 || !*status_ptr) {
 
 		if (misc_op_str)
-			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s (%s)\n",
+			drm_err(adev_to_drm(adev), "MES(%d) failed to respond to msg=%s (%s)\n",
 				pipe, op_str, misc_op_str);
 		else if (op_str)
-			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s\n",
+			drm_err(adev_to_drm(adev), "MES(%d) failed to respond to msg=%s\n",
 				pipe, op_str);
 		else
-			dev_err(adev->dev, "MES(%d) failed to respond to msg=%d\n",
+			drm_err(adev_to_drm(adev), "MES(%d) failed to respond to msg=%d\n",
 				pipe, x_pkt->header.opcode);
 
 		while (halt_if_hws_hang)
@@ -248,7 +248,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	return 0;
 
 error_undo:
-	dev_err(adev->dev, "MES ring buffer is full.\n");
+	drm_err(adev_to_drm(adev), "MES ring buffer is full.\n");
 	amdgpu_ring_undo(ring);
 
 error_unlock_free:
@@ -394,7 +394,7 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	if (queue_type == AMDGPU_RING_TYPE_GFX) {
-		dev_info(adev->dev, "reset gfx queue (%d:%d:%d: vmid:%d)\n",
+		drm_info(adev_to_drm(adev), "reset gfx queue (%d:%d:%d: vmid:%d)\n",
 			 me_id, pipe_id, queue_id, vmid);
 
 		mutex_lock(&adev->gfx.reset_sem_mutex);
@@ -420,14 +420,14 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout) {
-			dev_err(adev->dev, "failed to wait on gfx hqd deactivate\n");
+			drm_err(adev_to_drm(adev), "failed to wait on gfx hqd deactivate\n");
 			r = -ETIMEDOUT;
 		}
 
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
-		dev_info(adev->dev, "reset compute queue (%d:%d:%d)\n",
+		drm_info(adev_to_drm(adev), "reset compute queue (%d:%d:%d)\n",
 			 me_id, pipe_id, queue_id);
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, me_id, pipe_id, queue_id, 0);
@@ -441,13 +441,13 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout) {
-			dev_err(adev->dev, "failed to wait on hqd deactivate\n");
+			drm_err(adev_to_drm(adev), "failed to wait on hqd deactivate\n");
 			r = -ETIMEDOUT;
 		}
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 	} else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
-		dev_info(adev->dev, "reset sdma queue (%d:%d:%d)\n",
+		drm_info(adev_to_drm(adev), "reset sdma queue (%d:%d:%d)\n",
 			 me_id, pipe_id, queue_id);
 		switch (me_id) {
 		case 1:
@@ -468,7 +468,7 @@ static int mes_v12_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_typ
 			udelay(1);
 		}
 		if (i >= adev->usec_timeout) {
-			dev_err(adev->dev, "failed to wait on sdma queue reset done\n");
+			drm_err(adev_to_drm(adev), "failed to wait on sdma queue reset done\n");
 			r = -ETIMEDOUT;
 		}
 	}
@@ -667,7 +667,7 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		break;
 
 	default:
-		DRM_ERROR("unsupported misc op (%d) \n", input->op);
+		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d) \n", input->op);
 		return -EINVAL;
 	}
 
@@ -922,7 +922,7 @@ static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
 				      &adev->mes.ucode_fw_gpu_addr[pipe],
 				      (void **)&adev->mes.ucode_fw_ptr[pipe]);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mes fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mes fw bo\n", r);
 		return r;
 	}
 
@@ -956,7 +956,7 @@ static int mes_v12_0_allocate_ucode_data_buffer(struct amdgpu_device *adev,
 				      &adev->mes.data_fw_gpu_addr[pipe],
 				      (void **)&adev->mes.data_fw_ptr[pipe]);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to create mes data fw bo\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to create mes data fw bo\n", r);
 		return r;
 	}
 
@@ -999,7 +999,7 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 					WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI,
 						     upper_32_bits(adev->mes.event_log_gpu_addr +
 						     pipe * log_size + AMDGPU_MES_LOG_BUFFER_SIZE));
-					dev_info(adev->dev, "Setup CP MES MSCRATCH address : 0x%x. 0x%x\n",
+					drm_info(adev_to_drm(adev), "Setup CP MES MSCRATCH address : 0x%x. 0x%x\n",
 						 RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI),
 						 RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO));
 				}
@@ -1022,7 +1022,7 @@ static void mes_v12_0_enable(struct amdgpu_device *adev, bool enable)
 			data = REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE0_ACTIVE, 1);
 			if (pipe)
 				data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE, 1);
-			dev_info(adev->dev, "program CP_MES_CNTL : 0x%x\n", data);
+			drm_info(adev_to_drm(adev), "program CP_MES_CNTL : 0x%x\n", data);
 
 			WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
 
@@ -1150,7 +1150,7 @@ static int mes_v12_0_allocate_eop_buf(struct amdgpu_device *adev,
 			      &adev->mes.eop_gpu_addr[pipe],
 			      (void **)&eop);
 	if (r) {
-		dev_warn(adev->dev, "(%d) create EOP bo failed\n", r);
+		drm_warn(adev_to_drm(adev), "(%d) create EOP bo failed\n", r);
 		return r;
 	}
 
@@ -1345,7 +1345,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
 	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		drm_err(adev_to_drm(adev), "Failed to lock KIQ (%d).\n", r);
 		return r;
 	}
 
@@ -1353,7 +1353,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_test_ring(kiq_ring);
 	if (r) {
-		DRM_ERROR("kfq enable failed\n");
+		drm_err(adev_to_drm(adev), "kfq enable failed\n");
 		kiq_ring->sched.ready = false;
 	}
 	return r;
@@ -1477,7 +1477,7 @@ static int mes_v12_0_mqd_sw_init(struct amdgpu_device *adev,
 				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
-		dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
+		drm_warn(adev_to_drm(adev), "failed to create ring mqd bo (%d)", r);
 		return r;
 	}
 
@@ -1486,7 +1486,7 @@ static int mes_v12_0_mqd_sw_init(struct amdgpu_device *adev,
 	/* prepare MQD backup */
 	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
 	if (!adev->mes.mqd_backup[pipe])
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "no memory to create MQD backup for ring %s\n",
 			 ring->name);
 
@@ -1532,7 +1532,7 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 						    &adev->mes.resource_1_gpu_addr[pipe],
 						    &adev->mes.resource_1_addr[pipe]);
 			if (r) {
-				dev_err(adev->dev, "(%d) failed to create mes resource_1 bo pipe[%d]\n", r, pipe);
+				drm_err(adev_to_drm(adev), "(%d) failed to create mes resource_1 bo pipe[%d]\n", r, pipe);
 				return r;
 			}
 		}
@@ -1644,13 +1644,13 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 
 		r = mes_v12_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE, false);
 		if (r) {
-			DRM_ERROR("failed to load MES fw, r=%d\n", r);
+			drm_err(adev_to_drm(adev), "failed to load MES fw, r=%d\n", r);
 			return r;
 		}
 
 		r = mes_v12_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE, true);
 		if (r) {
-			DRM_ERROR("failed to load MES kiq fw, r=%d\n", r);
+			drm_err(adev_to_drm(adev), "failed to load MES kiq fw, r=%d\n", r);
 			return r;
 		}
 
@@ -1663,7 +1663,7 @@ static int mes_v12_0_kiq_hw_init(struct amdgpu_device *adev)
 
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_MES);
 	if (unlikely(!ip_block)) {
-		dev_err(adev->dev, "Failed to get MES handle\n");
+		drm_err(adev_to_drm(adev), "Failed to get MES handle\n");
 		return -EINVAL;
 	}
 
@@ -1723,7 +1723,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 			r = mes_v12_0_load_microcode(adev,
 					     AMDGPU_MES_SCHED_PIPE, true);
 			if (r) {
-				DRM_ERROR("failed to MES fw, r=%d\n", r);
+				drm_err(adev_to_drm(adev), "failed to MES fw, r=%d\n", r);
 				return r;
 			}
 
@@ -1755,7 +1755,7 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = mes_v12_0_query_sched_status(&adev->mes, AMDGPU_MES_SCHED_PIPE);
 	if (r) {
-		DRM_ERROR("MES is busy\n");
+		drm_err(adev_to_drm(adev), "MES is busy\n");
 		goto failure;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 243eabda06077..6a6a2c83d7b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -769,7 +769,7 @@ static int mmhub_v1_0_get_ras_error_count(struct amdgpu_device *adev,
 				mmhub_v1_0_ras_fields[i].sec_count_mask) >>
 				mmhub_v1_0_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				"MMHUB SubBlock %s, SEC %d\n",
 				mmhub_v1_0_ras_fields[i].name,
 				sec_cnt);
@@ -780,7 +780,7 @@ static int mmhub_v1_0_get_ras_error_count(struct amdgpu_device *adev,
 				mmhub_v1_0_ras_fields[i].ded_count_mask) >>
 				mmhub_v1_0_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				"MMHUB SubBlock %s, DED %d\n",
 				mmhub_v1_0_ras_fields[i].name,
 				ded_cnt);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 2adee2b94c37d..8dfa7e918b6cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1245,7 +1245,7 @@ static int mmhub_v1_7_get_ras_error_count(struct amdgpu_device *adev,
 				mmhub_v1_7_ras_fields[i].sec_count_mask) >>
 				mmhub_v1_7_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			dev_info(adev->dev, "MMHUB SubBlock %s, SEC %d\n",
+			drm_info(adev_to_drm(adev), "MMHUB SubBlock %s, SEC %d\n",
 				 mmhub_v1_7_ras_fields[i].name,
 				 sec_cnt);
 			*sec_count += sec_cnt;
@@ -1255,7 +1255,7 @@ static int mmhub_v1_7_get_ras_error_count(struct amdgpu_device *adev,
 				mmhub_v1_7_ras_fields[i].ded_count_mask) >>
 				mmhub_v1_7_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			dev_info(adev->dev, "MMHUB SubBlock %s, DED %d\n",
+			drm_info(adev_to_drm(adev), "MMHUB SubBlock %s, DED %d\n",
 				 mmhub_v1_7_ras_fields[i].name,
 				 ded_cnt);
 			*ded_count += ded_cnt;
@@ -1322,7 +1322,7 @@ static void mmhub_v1_7_query_ras_error_status(struct amdgpu_device *adev)
 		if (REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_STATUS) ||
 		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_WRRSP_STATUS) ||
 		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
-			dev_warn(adev->dev, "MMHUB EA err detected at instance: %d, status: 0x%x!\n",
+			drm_warn(adev_to_drm(adev), "MMHUB EA err detected at instance: %d, status: 0x%x!\n",
 					i, reg_value);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 84cde1239ee45..9196f9822752a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -690,7 +690,7 @@ static void mmhub_v1_8_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t i;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
-		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
+		drm_warn(adev_to_drm(adev), "MMHUB RAS is not supported\n");
 		return;
 	}
 
@@ -718,7 +718,7 @@ static void mmhub_v1_8_reset_ras_error_count(struct amdgpu_device *adev)
 	uint32_t i;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
-		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
+		drm_warn(adev_to_drm(adev), "MMHUB RAS is not supported\n");
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index a0cc8e218ca1e..4a98fe3d8f042 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -148,7 +148,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status,
 			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
@@ -167,21 +167,21 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		mmhub_cid = NULL;
 		break;
 	}
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	drm_err(adev_to_drm(adev), "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 5eb8122e27469..6bedd4f5da53c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -87,7 +87,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status,
 			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
@@ -100,21 +100,21 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		mmhub_cid = NULL;
 		break;
 	}
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	drm_err(adev_to_drm(adev), "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v2_3_setup_vm_pt_regs(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 7d5242df58a51..5492815226ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -104,7 +104,7 @@ mmhub_v3_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status,
 			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
@@ -116,21 +116,21 @@ mmhub_v3_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		mmhub_cid = NULL;
 		break;
 	}
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	drm_err(adev_to_drm(adev), "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v3_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 134c4ec108878..351b1bc5ce83a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -104,7 +104,7 @@ mmhub_v3_0_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status,
 			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 
@@ -117,21 +117,21 @@ mmhub_v3_0_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		break;
 	}
 
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	drm_err(adev_to_drm(adev), "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v3_0_1_setup_vm_pt_regs(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index f0f182f033b98..b546f24081568 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -104,26 +104,26 @@ mmhub_v3_0_2_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status,
 			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 
 	mmhub_cid = mmhub_client_ids_v3_0_2[cid][rw];
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	drm_err(adev_to_drm(adev), "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v3_0_2_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index bc3d6c2fc87a4..dd0d062ec053c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -96,7 +96,7 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status,
 			   MMVM_L2_PROTECTION_FAULT_STATUS, RW);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
 
@@ -113,21 +113,21 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		break;
 	}
 
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	drm_err(adev_to_drm(adev), "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v3_3_setup_vm_pt_regs(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
index f2ab5001b4924..649873554e7c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
@@ -105,7 +105,7 @@ mmhub_v4_1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	rw = REG_GET_FIELD(status,
 			   MMVM_L2_PROTECTION_FAULT_STATUS_LO32, RW);
 
-	dev_err(adev->dev,
+	drm_err(adev_to_drm(adev),
 		"MMVM_L2_PROTECTION_FAULT_STATUS_LO32:0x%08X\n",
 		status);
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
@@ -116,21 +116,21 @@ mmhub_v4_1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		mmhub_cid = NULL;
 		break;
 	}
-	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
+	drm_err(adev_to_drm(adev), "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
-	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MORE_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, MORE_FAULTS));
-	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t WALKER_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, WALKER_ERROR));
-	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t PERMISSION_FAULTS: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, PERMISSION_FAULTS));
-	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+	drm_err(adev_to_drm(adev), "\t MAPPING_ERROR: 0x%lx\n",
 		REG_GET_FIELD(status,
 		MMVM_L2_PROTECTION_FAULT_STATUS_LO32, MAPPING_ERROR));
-	dev_err(adev->dev, "\t RW: 0x%x\n", rw);
+	drm_err(adev_to_drm(adev), "\t RW: 0x%x\n", rw);
 }
 
 static void mmhub_v4_1_0_setup_vm_pt_regs(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index fe0710b55c3ac..3adeed9e69b30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -1606,7 +1606,7 @@ static int mmhub_v9_4_get_ras_error_count(struct amdgpu_device *adev,
 				mmhub_v9_4_ras_fields[i].sec_count_mask) >>
 				mmhub_v9_4_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			dev_info(adev->dev, "MMHUB SubBlock %s, SEC %d\n",
+			drm_info(adev_to_drm(adev), "MMHUB SubBlock %s, SEC %d\n",
 				mmhub_v9_4_ras_fields[i].name,
 				sec_cnt);
 			*sec_count += sec_cnt;
@@ -1616,7 +1616,7 @@ static int mmhub_v9_4_get_ras_error_count(struct amdgpu_device *adev,
 				mmhub_v9_4_ras_fields[i].ded_count_mask) >>
 				mmhub_v9_4_ras_fields[i].ded_count_shift;
 		if (ded_cnt) {
-			dev_info(adev->dev, "MMHUB SubBlock %s, DED %d\n",
+			drm_info(adev_to_drm(adev), "MMHUB SubBlock %s, DED %d\n",
 				mmhub_v9_4_ras_fields[i].name,
 				ded_cnt);
 			*ded_count += ded_cnt;
@@ -1688,7 +1688,7 @@ static void mmhub_v9_4_query_ras_error_status(struct amdgpu_device *adev)
 			/* SDP read/write error/parity error in FUE_IS_FATAL mode
 			 * can cause system fatal error in arcturas. Harvest the error
 			 * status before GPU reset */
-			dev_warn(adev->dev, "MMHUB EA err detected at instance: %d, status: 0x%x!\n",
+			drm_warn(adev_to_drm(adev), "MMHUB EA err detected at instance: %d, status: 0x%x!\n",
 					i, reg_value);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f5411b798e111..2859be31824a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -93,7 +93,7 @@ static int xgpu_ai_poll_ack(struct amdgpu_device *adev)
 		timeout -= 5;
 	} while (timeout > 1);
 
-	dev_err(adev->dev, "Doesn't get TRN_MSG_ACK from pf in %d msec\n", AI_MAILBOX_POLL_ACK_TIMEDOUT);
+	drm_err(adev_to_drm(adev), "Doesn't get TRN_MSG_ACK from pf in %d msec\n", AI_MAILBOX_POLL_ACK_TIMEDOUT);
 
 	return -ETIME;
 }
@@ -111,7 +111,7 @@ static int xgpu_ai_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 		timeout -= 10;
 	} while (timeout > 1);
 
-	dev_err(adev->dev, "Doesn't get msg:%d from pf, error=%d\n", event, r);
+	drm_err(adev_to_drm(adev), "Doesn't get msg:%d from pf, error=%d\n", event, r);
 
 	return -ETIME;
 }
@@ -155,7 +155,7 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
 	/* start to poll ack */
 	r = xgpu_ai_poll_ack(adev);
 	if (r)
-		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
+		drm_err(adev_to_drm(adev), "Doesn't get ack from pf, continue\n");
 
 	xgpu_ai_mailbox_set_valid(adev, false);
 }
@@ -173,7 +173,7 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 		req == IDH_REQ_GPU_RESET_ACCESS) {
 		r = xgpu_ai_poll_msg(adev, IDH_READY_TO_ACCESS_GPU);
 		if (r) {
-			dev_err(adev->dev, "Doesn't get READY_TO_ACCESS_GPU from pf, give up\n");
+			drm_err(adev_to_drm(adev), "Doesn't get READY_TO_ACCESS_GPU from pf, give up\n");
 			return r;
 		}
 		/* Retrieve checksum from mailbox2 */
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 5aadf24cb2022..163a6dfe2fd5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -94,7 +94,7 @@ static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
 		timeout -= 5;
 	} while (timeout > 1);
 
-	dev_err(adev->dev, "Doesn't get TRN_MSG_ACK from pf in %d msec \n", NV_MAILBOX_POLL_ACK_TIMEDOUT);
+	drm_err(adev_to_drm(adev), "Doesn't get TRN_MSG_ACK from pf in %d msec \n", NV_MAILBOX_POLL_ACK_TIMEDOUT);
 
 	return -ETIME;
 }
@@ -154,7 +154,7 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
 	/* start to poll ack */
 	r = xgpu_nv_poll_ack(adev);
 	if (r)
-		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
+		drm_err(adev_to_drm(adev), "Doesn't get ack from pf, continue\n");
 
 	xgpu_nv_mailbox_set_valid(adev, false);
 }
@@ -198,7 +198,7 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 				goto send_request;
 
 			if (req != IDH_REQ_GPU_INIT_DATA) {
-				dev_err(adev->dev, "Doesn't get msg:%d from pf, error=%d\n", event, r);
+				drm_err(adev_to_drm(adev), "Doesn't get msg:%d from pf, error=%d\n", event, r);
 				return r;
 			} else /* host doesn't support REQ_GPU_INIT_DATA handshake */
 				adev->virt.req_init_data_ver = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 4cd325149b63e..85fbd8dd9f359 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -281,7 +281,7 @@ static int navi10_ih_enable_ring(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+			drm_err(adev_to_drm(adev), "PSP program IH_RB_CNTL failed!\n");
 			return -ETIMEDOUT;
 		}
 	} else {
@@ -434,7 +434,7 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
 	 * this should allow us to catch up.
 	 */
 	tmp = (wptr + 32) & ih->ptr_mask;
-	dev_warn(adev->dev, "%s ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+	drm_warn(adev_to_drm(adev), "%s ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
 		 amdgpu_ih_ring_name(adev, ih), wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index d5002ff931d84..8ce9f603f0f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -395,19 +395,19 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 			obj->err_data.ce_count += err_data.ce_count;
 
 			if (err_data.ce_count)
-				dev_info(adev->dev, "%ld correctable hardware "
+				drm_info(adev_to_drm(adev), "%ld correctable hardware "
 						"errors detected in %s block\n",
 						obj->err_data.ce_count,
 						get_ras_block_str(adev->nbio.ras_if));
 
 			if (err_data.ue_count)
-				dev_info(adev->dev, "%ld uncorrectable hardware "
+				drm_info(adev_to_drm(adev), "%ld uncorrectable hardware "
 						"errors detected in %s block\n",
 						obj->err_data.ue_count,
 						get_ras_block_str(adev->nbio.ras_if));
 		}
 
-		dev_info(adev->dev, "RAS controller interrupt triggered "
+		drm_info(adev_to_drm(adev), "RAS controller interrupt triggered "
 					"by NBIF error\n");
 
 		/* ras_controller_int is dedicated for nbif ras error,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index f23cb79110d61..8d6c2cb95bd26 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -562,19 +562,19 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 			obj->err_data.ce_count += err_data.ce_count;
 
 			if (err_data.ce_count)
-				dev_info(adev->dev, "%ld correctable hardware "
+				drm_info(adev_to_drm(adev), "%ld correctable hardware "
 						"errors detected in %s block\n",
 						obj->err_data.ce_count,
 						get_ras_block_str(adev->nbio.ras_if));
 
 			if (err_data.ue_count)
-				dev_info(adev->dev, "%ld uncorrectable hardware "
+				drm_info(adev_to_drm(adev), "%ld uncorrectable hardware "
 						"errors detected in %s block\n",
 						obj->err_data.ue_count,
 						get_ras_block_str(adev->nbio.ras_if));
 		}
 
-		dev_info(adev->dev, "RAS controller interrupt triggered "
+		drm_info(adev_to_drm(adev), "RAS controller interrupt triggered "
 					"by NBIF error\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 50e77d9b30afa..4a4e8d8ab26cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -421,7 +421,7 @@ static int nv_asic_mode2_reset(struct amdgpu_device *adev)
 
 	ret = amdgpu_dpm_mode2_reset(adev);
 	if (ret)
-		dev_err(adev->dev, "GPU mode2 reset failed\n");
+		drm_err(adev_to_drm(adev), "GPU mode2 reset failed\n");
 
 	amdgpu_device_load_pci_state(adev->pdev);
 
@@ -449,7 +449,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 		return amdgpu_reset_method;
 
 	if (amdgpu_reset_method != -1)
-		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+		drm_warn(adev_to_drm(adev), "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
@@ -479,19 +479,19 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 
 	switch (nv_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
-		dev_info(adev->dev, "PCI reset\n");
+		drm_info(adev_to_drm(adev), "PCI reset\n");
 		ret = amdgpu_device_pci_reset(adev);
 		break;
 	case AMD_RESET_METHOD_BACO:
-		dev_info(adev->dev, "BACO reset\n");
+		drm_info(adev_to_drm(adev), "BACO reset\n");
 		ret = amdgpu_dpm_baco_reset(adev);
 		break;
 	case AMD_RESET_METHOD_MODE2:
-		dev_info(adev->dev, "MODE2 reset\n");
+		drm_info(adev_to_drm(adev), "MODE2 reset\n");
 		ret = nv_asic_mode2_reset(adev);
 		break;
 	default:
-		dev_info(adev->dev, "MODE1 reset\n");
+		drm_info(adev_to_drm(adev), "MODE1 reset\n");
 		ret = amdgpu_device_mode1_reset(adev);
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 145186a1e48f6..b5560ee02e4a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -129,7 +129,7 @@ static int psp_v10_0_ring_destroy(struct psp_context *psp,
 
 	ret = psp_v10_0_ring_stop(psp, ring_type);
 	if (ret)
-		DRM_ERROR("Fail to stop psp ring\n");
+		drm_err(adev_to_drm(adev), "Fail to stop psp ring\n");
 
 	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
 			      &ring->ring_mem_mc_addr,
@@ -140,7 +140,7 @@ static int psp_v10_0_ring_destroy(struct psp_context *psp,
 
 static int psp_v10_0_mode1_reset(struct psp_context *psp)
 {
-	DRM_INFO("psp mode 1 reset not supported now! \n");
+	drm_info(adev_to_drm(psp->adev), "psp mode 1 reset not supported now! \n");
 	return -EINVAL;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index bb5dfc410a667..36c4fafdeef2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -298,7 +298,7 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 		ring->ring_wptr = 0;
 		ret = psp_v11_0_ring_stop(psp, ring_type);
 		if (ret) {
-			DRM_ERROR("psp_v11_0_ring_stop_sriov failed!\n");
+			drm_err(adev_to_drm(adev), "psp_v11_0_ring_stop_sriov failed!\n");
 			return ret;
 		}
 
@@ -325,7 +325,7 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
 				   0x80000000, 0x80000000, false);
 		if (ret) {
-			DRM_ERROR("Failed to wait for sOS ready for ring creation\n");
+			drm_err(adev_to_drm(adev), "Failed to wait for sOS ready for ring creation\n");
 			return ret;
 		}
 
@@ -364,7 +364,7 @@ static int psp_v11_0_ring_destroy(struct psp_context *psp,
 
 	ret = psp_v11_0_ring_stop(psp, ring_type);
 	if (ret)
-		DRM_ERROR("Fail to stop psp ring\n");
+		drm_err(adev_to_drm(adev), "Fail to stop psp ring\n");
 
 	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
 			      &ring->ring_mem_mc_addr,
@@ -384,7 +384,7 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
 
 	if (ret) {
-		DRM_INFO("psp is not working correctly before mode1 reset!\n");
+		drm_info(adev_to_drm(adev), "psp is not working correctly before mode1 reset!\n");
 		return -EINVAL;
 	}
 
@@ -398,11 +398,11 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
 
 	if (ret) {
-		DRM_INFO("psp mode 1 reset failed!\n");
+		drm_info(adev_to_drm(adev), "psp mode 1 reset failed!\n");
 		return -EINVAL;
 	}
 
-	DRM_INFO("psp mode1 reset succeed \n");
+	drm_info(adev_to_drm(adev), "psp mode1 reset succeed \n");
 
 	return 0;
 }
@@ -455,7 +455,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		DRM_DEBUG("Memory training is not supported.\n");
 		return 0;
 	} else if (ctx->init != PSP_MEM_TRAIN_INIT_SUCCESS) {
-		DRM_ERROR("Memory training initialization failure.\n");
+		drm_err(adev_to_drm(adev), "Memory training initialization failure.\n");
 		return -EINVAL;
 	}
 
@@ -510,7 +510,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		sz = BIST_MEM_TRAINING_ENCROACHED_SIZE;
 
 		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
-			DRM_ERROR("visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
+			drm_err(adev_to_drm(adev), "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
 				  adev->gmc.visible_vram_size,
 				  adev->mman.aper_base_kaddr);
 			return -EINVAL;
@@ -518,7 +518,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 
 		buf = vmalloc(sz);
 		if (!buf) {
-			DRM_ERROR("failed to allocate system memory.\n");
+			drm_err(adev_to_drm(adev), "failed to allocate system memory.\n");
 			return -ENOMEM;
 		}
 
@@ -526,7 +526,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 			ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
-				DRM_ERROR("Send long training msg failed.\n");
+				drm_err(adev_to_drm(adev), "Send long training msg failed.\n");
 				vfree(buf);
 				drm_dev_exit(idx);
 				return ret;
@@ -554,7 +554,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		ret = psp_v11_0_memory_training_send_msg(psp, (amdgpu_force_long_training > 0) ?
 							 PSP_BL__DRAM_LONG_TRAIN : PSP_BL__DRAM_SHORT_TRAIN);
 		if (ret) {
-			DRM_ERROR("send training msg failed.\n");
+			drm_err(adev_to_drm(adev), "send training msg failed.\n");
 			return ret;
 		}
 	}
@@ -622,7 +622,7 @@ static int psp_v11_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc
 done:
 
 	if ((reg_status & 0xFFFF) != 0) {
-		DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = 0x%04x\n",
+		drm_err(adev_to_drm(adev), "Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = 0x%04x\n",
 				reg_status & 0xFFFF);
 		return -EIO;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
index 5697760a819bc..43b7bdf53716e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
@@ -68,7 +68,7 @@ static int psp_v11_0_8_ring_create(struct psp_context *psp,
 	if (amdgpu_sriov_vf(adev)) {
 		ret = psp_v11_0_8_ring_stop(psp, ring_type);
 		if (ret) {
-			DRM_ERROR("psp_v11_0_8_ring_stop_sriov failed!\n");
+			drm_err(adev_to_drm(adev), "psp_v11_0_8_ring_stop_sriov failed!\n");
 			return ret;
 		}
 
@@ -95,7 +95,7 @@ static int psp_v11_0_8_ring_create(struct psp_context *psp,
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
 				   0x80000000, 0x80000000, false);
 		if (ret) {
-			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			drm_err(adev_to_drm(adev), "Failed to wait for trust OS ready for ring creation\n");
 			return ret;
 		}
 
@@ -133,7 +133,7 @@ static int psp_v11_0_8_ring_destroy(struct psp_context *psp,
 
 	ret = psp_v11_0_8_ring_stop(psp, ring_type);
 	if (ret)
-		DRM_ERROR("Fail to stop psp ring\n");
+		drm_err(adev_to_drm(adev), "Fail to stop psp ring\n");
 
 	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
 			      &ring->ring_mem_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index fcd708eae75cc..c654b0bb45f41 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -270,7 +270,7 @@ static int psp_v12_0_ring_destroy(struct psp_context *psp,
 
 	ret = psp_v12_0_ring_stop(psp, ring_type);
 	if (ret)
-		DRM_ERROR("Fail to stop psp ring\n");
+		drm_err(adev_to_drm(adev), "Fail to stop psp ring\n");
 
 	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
 			      &ring->ring_mem_mc_addr,
@@ -290,7 +290,7 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
 
 	if (ret) {
-		DRM_INFO("psp is not working correctly before mode1 reset!\n");
+		drm_info(adev_to_drm(adev), "psp is not working correctly before mode1 reset!\n");
 		return -EINVAL;
 	}
 
@@ -304,11 +304,11 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
 
 	if (ret) {
-		DRM_INFO("psp mode 1 reset failed!\n");
+		drm_info(adev_to_drm(adev), "psp mode 1 reset failed!\n");
 		return -EINVAL;
 	}
 
-	DRM_INFO("psp mode1 reset succeed \n");
+	drm_info(adev_to_drm(adev), "psp mode1 reset succeed \n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index cc621064610f1..0f9ff5f531ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -168,7 +168,7 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_context *psp)
 	}
 
 	if (ret)
-		dev_warn(adev->dev, "Bootloader wait timed out");
+		drm_warn(adev_to_drm(adev), "Bootloader wait timed out");
 
 	return ret;
 }
@@ -387,7 +387,7 @@ static int psp_v13_0_ring_create(struct psp_context *psp,
 	if (amdgpu_sriov_vf(adev)) {
 		ret = psp_v13_0_ring_stop(psp, ring_type);
 		if (ret) {
-			DRM_ERROR("psp_v13_0_ring_stop_sriov failed!\n");
+			drm_err(adev_to_drm(adev), "psp_v13_0_ring_stop_sriov failed!\n");
 			return ret;
 		}
 
@@ -414,7 +414,7 @@ static int psp_v13_0_ring_create(struct psp_context *psp,
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
 				   0x80000000, 0x80000000, false);
 		if (ret) {
-			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			drm_err(adev_to_drm(adev), "Failed to wait for trust OS ready for ring creation\n");
 			return ret;
 		}
 
@@ -452,7 +452,7 @@ static int psp_v13_0_ring_destroy(struct psp_context *psp,
 
 	ret = psp_v13_0_ring_stop(psp, ring_type);
 	if (ret)
-		DRM_ERROR("Fail to stop psp ring\n");
+		drm_err(adev_to_drm(adev), "Fail to stop psp ring\n");
 
 	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
 			      &ring->ring_mem_mc_addr,
@@ -532,7 +532,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 		dev_dbg(adev->dev, "Memory training is not supported.\n");
 		return 0;
 	} else if (ctx->init != PSP_MEM_TRAIN_INIT_SUCCESS) {
-		dev_err(adev->dev, "Memory training initialization failure.\n");
+		drm_err(adev_to_drm(adev), "Memory training initialization failure.\n");
 		return -EINVAL;
 	}
 
@@ -587,7 +587,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 		sz = BIST_MEM_TRAINING_ENCROACHED_SIZE;
 
 		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
-			dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
+			drm_err(adev_to_drm(adev), "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
 				  adev->gmc.visible_vram_size,
 				  adev->mman.aper_base_kaddr);
 			return -EINVAL;
@@ -595,7 +595,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 
 		buf = vmalloc(sz);
 		if (!buf) {
-			dev_err(adev->dev, "failed to allocate system memory.\n");
+			drm_err(adev_to_drm(adev), "failed to allocate system memory.\n");
 			return -ENOMEM;
 		}
 
@@ -603,7 +603,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 			ret = psp_v13_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
-				DRM_ERROR("Send long training msg failed.\n");
+				drm_err(adev_to_drm(adev), "Send long training msg failed.\n");
 				vfree(buf);
 				drm_dev_exit(idx);
 				return ret;
@@ -631,7 +631,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 		ret = psp_v13_0_memory_training_send_msg(psp, (amdgpu_force_long_training > 0) ?
 							 PSP_BL__DRAM_LONG_TRAIN : PSP_BL__DRAM_SHORT_TRAIN);
 		if (ret) {
-			dev_err(adev->dev, "send training msg failed.\n");
+			drm_err(adev_to_drm(adev), "send training msg failed.\n");
 			return ret;
 		}
 	}
@@ -674,7 +674,7 @@ static int psp_v13_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc
 done:
 
 	if ((reg_status & 0xFFFF) != 0) {
-		DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %04x\n",
+		drm_err(adev_to_drm(adev), "Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %04x\n",
 				reg_status & 0xFFFF);
 		return -EIO;
 	}
@@ -717,13 +717,13 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
 				   MBOX_READY_FLAG, MBOX_READY_MASK, false);
 	if (ret) {
-		dev_err(adev->dev, "SPI cmd %x timed out, ret = %d", cmd, ret);
+		drm_err(adev_to_drm(adev), "SPI cmd %x timed out, ret = %d", cmd, ret);
 		return ret;
 	}
 
 	reg_status = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_115);
 	if ((reg_status & 0xFFFF) != 0) {
-		dev_err(adev->dev, "SPI cmd %x failed, fail status = %04x\n",
+		drm_err(adev_to_drm(adev), "SPI cmd %x failed, fail status = %04x\n",
 				cmd, reg_status & 0xFFFF);
 		return -EIO;
 	}
@@ -741,7 +741,7 @@ static int psp_v13_0_update_spirom(struct psp_context *psp,
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
 			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
 	if (ret) {
-		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
+		drm_err(adev_to_drm(adev), "PSP Not ready to start processing, ret = %d", ret);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
index eaa5512a21dac..bcdd0c71aabb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -231,7 +231,7 @@ static int psp_v13_0_4_ring_create(struct psp_context *psp,
 	if (amdgpu_sriov_vf(adev)) {
 		ret = psp_v13_0_4_ring_stop(psp, ring_type);
 		if (ret) {
-			DRM_ERROR("psp_v13_0_ring_stop_sriov failed!\n");
+			drm_err(adev_to_drm(adev), "psp_v13_0_ring_stop_sriov failed!\n");
 			return ret;
 		}
 
@@ -258,7 +258,7 @@ static int psp_v13_0_4_ring_create(struct psp_context *psp,
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
 				   0x80000000, 0x80000000, false);
 		if (ret) {
-			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			drm_err(adev_to_drm(adev), "Failed to wait for trust OS ready for ring creation\n");
 			return ret;
 		}
 
@@ -296,7 +296,7 @@ static int psp_v13_0_4_ring_destroy(struct psp_context *psp,
 
 	ret = psp_v13_0_4_ring_stop(psp, ring_type);
 	if (ret)
-		DRM_ERROR("Fail to stop psp ring\n");
+		drm_err(adev_to_drm(adev), "Fail to stop psp ring\n");
 
 	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
 			      &ring->ring_mem_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 7c49c3f3c3881..f0fc1c033e35f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -275,7 +275,7 @@ static int psp_v14_0_ring_create(struct psp_context *psp,
 	if (amdgpu_sriov_vf(adev)) {
 		ret = psp_v14_0_ring_stop(psp, ring_type);
 		if (ret) {
-			DRM_ERROR("psp_v14_0_ring_stop_sriov failed!\n");
+			drm_err(adev_to_drm(adev), "psp_v14_0_ring_stop_sriov failed!\n");
 			return ret;
 		}
 
@@ -302,7 +302,7 @@ static int psp_v14_0_ring_create(struct psp_context *psp,
 		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
 				   0x80000000, 0x80000000, false);
 		if (ret) {
-			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			drm_err(adev_to_drm(adev), "Failed to wait for trust OS ready for ring creation\n");
 			return ret;
 		}
 
@@ -340,7 +340,7 @@ static int psp_v14_0_ring_destroy(struct psp_context *psp,
 
 	ret = psp_v14_0_ring_stop(psp, ring_type);
 	if (ret)
-		DRM_ERROR("Fail to stop psp ring\n");
+		drm_err(adev_to_drm(adev), "Fail to stop psp ring\n");
 
 	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
 			      &ring->ring_mem_mc_addr,
@@ -420,7 +420,7 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
 		dev_dbg(adev->dev, "Memory training is not supported.\n");
 		return 0;
 	} else if (ctx->init != PSP_MEM_TRAIN_INIT_SUCCESS) {
-		dev_err(adev->dev, "Memory training initialization failure.\n");
+		drm_err(adev_to_drm(adev), "Memory training initialization failure.\n");
 		return -EINVAL;
 	}
 
@@ -475,7 +475,7 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
 		sz = BIST_MEM_TRAINING_ENCROACHED_SIZE;
 
 		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
-			dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
+			drm_err(adev_to_drm(adev), "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
 				  adev->gmc.visible_vram_size,
 				  adev->mman.aper_base_kaddr);
 			return -EINVAL;
@@ -483,7 +483,7 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
 
 		buf = vmalloc(sz);
 		if (!buf) {
-			dev_err(adev->dev, "failed to allocate system memory.\n");
+			drm_err(adev_to_drm(adev), "failed to allocate system memory.\n");
 			return -ENOMEM;
 		}
 
@@ -491,7 +491,7 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
 			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
 			ret = psp_v14_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
-				DRM_ERROR("Send long training msg failed.\n");
+				drm_err(adev_to_drm(adev), "Send long training msg failed.\n");
 				vfree(buf);
 				drm_dev_exit(idx);
 				return ret;
@@ -519,7 +519,7 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
 		ret = psp_v14_0_memory_training_send_msg(psp, (amdgpu_force_long_training > 0) ?
 							 PSP_BL__DRAM_LONG_TRAIN : PSP_BL__DRAM_SHORT_TRAIN);
 		if (ret) {
-			dev_err(adev->dev, "send training msg failed.\n");
+			drm_err(adev_to_drm(adev), "send training msg failed.\n");
 			return ret;
 		}
 	}
@@ -562,7 +562,7 @@ static int psp_v14_0_load_usbc_pd_fw(struct psp_context *psp, uint64_t fw_pri_mc
 done:
 
 	if ((reg_status & 0xFFFF) != 0) {
-		DRM_ERROR("Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %04x\n",
+		drm_err(adev_to_drm(adev), "Address load failed - MP0_SMN_C2PMSG_35.Bits [15:0] = %04x\n",
 				reg_status & 0xFFFF);
 		return -EIO;
 	}
@@ -608,13 +608,13 @@ static int psp_v14_0_exec_spi_cmd(struct psp_context *psp, int cmd)
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
 				MBOX_READY_FLAG, MBOX_READY_MASK, false);
 	if (ret) {
-		dev_err(adev->dev, "SPI cmd %x timed out, ret = %d", cmd, ret);
+		drm_err(adev_to_drm(adev), "SPI cmd %x timed out, ret = %d", cmd, ret);
 		return ret;
 	}
 
 	reg_status = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_115);
 	if ((reg_status & 0xFFFF) != 0) {
-		dev_err(adev->dev, "SPI cmd %x failed, fail status = %04x\n",
+		drm_err(adev_to_drm(adev), "SPI cmd %x failed, fail status = %04x\n",
 				cmd, reg_status & 0xFFFF);
 		return -EIO;
 	}
@@ -632,7 +632,7 @@ static int psp_v14_0_update_spirom(struct psp_context *psp,
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_115),
 			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
 	if (ret) {
-		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
+		drm_err(adev_to_drm(adev), "PSP Not ready to start processing, ret = %d", ret);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index f6b75e3e47ffb..8efd2e62e4a31 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -197,7 +197,7 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
 		ring->ring_wptr = 0;
 		ret = psp_v3_1_ring_stop(psp, ring_type);
 		if (ret) {
-			DRM_ERROR("psp_v3_1_ring_stop_sriov failed!\n");
+			drm_err(adev_to_drm(adev), "psp_v3_1_ring_stop_sriov failed!\n");
 			return ret;
 		}
 
@@ -285,7 +285,7 @@ static int psp_v3_1_ring_destroy(struct psp_context *psp,
 
 	ret = psp_v3_1_ring_stop(psp, ring_type);
 	if (ret)
-		DRM_ERROR("Fail to stop psp ring\n");
+		drm_err(adev_to_drm(adev), "Fail to stop psp ring\n");
 
 	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
 			      &ring->ring_mem_mc_addr,
@@ -314,7 +314,7 @@ static int psp_v3_1_mode1_reset(struct psp_context *psp)
 	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
 
 	if (ret) {
-		DRM_INFO("psp is not working correctly before mode1 reset!\n");
+		drm_info(adev_to_drm(adev), "psp is not working correctly before mode1 reset!\n");
 		return -EINVAL;
 	}
 
@@ -328,11 +328,11 @@ static int psp_v3_1_mode1_reset(struct psp_context *psp)
 	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
 
 	if (ret) {
-		DRM_INFO("psp mode 1 reset failed!\n");
+		drm_info(adev_to_drm(adev), "psp mode 1 reset failed!\n");
 		return -EINVAL;
 	}
 
-	DRM_INFO("psp mode1 reset succeed \n");
+	drm_info(adev_to_drm(adev), "psp mode1 reset succeed \n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 92ce580647cdc..496d8f3adc327 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -964,7 +964,7 @@ static int sdma_v2_4_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -1073,7 +1073,7 @@ static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *adev,
 {
 	u8 instance_id, queue_id;
 
-	DRM_ERROR("Illegal instruction in SDMA command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in SDMA command stream\n");
 	instance_id = (entry->ring_id & 0x3) >> 0;
 	queue_id = (entry->ring_id & 0xc) >> 2;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 1c076bd1cf73e..c8b77752caf83 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1302,7 +1302,7 @@ static int sdma_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -1411,7 +1411,7 @@ static int sdma_v3_0_process_illegal_inst_irq(struct amdgpu_device *adev,
 {
 	u8 instance_id, queue_id;
 
-	DRM_ERROR("Illegal instruction in SDMA command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in SDMA command stream\n");
 	instance_id = (entry->ring_id & 0x3) >> 0;
 	queue_id = (entry->ring_id & 0xc) >> 2;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index e3888d7bdfeea..8bd6664568782 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1915,7 +1915,7 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	if (amdgpu_sdma_ras_sw_init(adev)) {
-		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to initialize sdma ras block!\n");
 		return -EINVAL;
 	}
 
@@ -1924,7 +1924,7 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
-		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocated memory for SDMA IP Dump\n");
 
 	return r;
 }
@@ -2132,7 +2132,7 @@ static int sdma_v4_0_process_illegal_inst_irq(struct amdgpu_device *adev,
 {
 	int instance;
 
-	DRM_ERROR("Illegal instruction in SDMA command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in SDMA command stream\n");
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	if (instance < 0)
@@ -2170,7 +2170,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
-		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
+		drm_err(adev_to_drm(adev), "sdma instance invalid %d\n", instance);
 		return -EINVAL;
 	}
 
@@ -2639,9 +2639,10 @@ static void sdma_v4_0_set_vm_pte_funcs(struct amdgpu_device *adev)
 	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
 }
 
-static void sdma_v4_0_get_ras_error_count(uint32_t value,
-					uint32_t instance,
-					uint32_t *sec_count)
+static void sdma_v4_0_get_ras_error_count(struct amdgpu_device *adev,
+					  uint32_t value,
+					  uint32_t instance,
+					  uint32_t *sec_count)
 {
 	uint32_t i;
 	uint32_t sec_cnt;
@@ -2655,7 +2656,7 @@ static void sdma_v4_0_get_ras_error_count(uint32_t value,
 			sdma_v4_0_ras_fields[i].sec_count_mask) >>
 			sdma_v4_0_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			DRM_INFO("Detected %s in SDMA%d, SED %d\n",
+			drm_info(adev_to_drm(adev), "Detected %s in SDMA%d, SED %d\n",
 				sdma_v4_0_ras_fields[i].name,
 				instance, sec_cnt);
 			*sec_count += sec_cnt;
@@ -2673,8 +2674,7 @@ static int sdma_v4_0_query_ras_error_count_by_instance(struct amdgpu_device *ade
 	reg_value = RREG32_SDMA(instance, mmSDMA0_EDC_COUNTER);
 	/* double bit error is not supported */
 	if (reg_value)
-		sdma_v4_0_get_ras_error_count(reg_value,
-				instance, &sec_count);
+		sdma_v4_0_get_ras_error_count(adev, reg_value, instance, &sec_count);
 	/* err_data->ce_count should be initialized to 0
 	 * before calling into this function */
 	err_data->ce_count += sec_count;
@@ -2691,7 +2691,7 @@ static void sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,  void *r
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (sdma_v4_0_query_ras_error_count_by_instance(adev, i, ras_error_status)) {
-			dev_err(adev->dev, "Query ras error count failed in SDMA%d\n", i);
+			drm_err(adev_to_drm(adev), "Query ras error count failed in SDMA%d\n", i);
 			return;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index 0ddb6955a6d3b..0c340869226d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -184,7 +184,7 @@ static void sdma_v4_4_get_ras_error_count(struct amdgpu_device *adev,
 			sdma_v4_4_ras_fields[i].sec_count_mask) >>
 			sdma_v4_4_ras_fields[i].sec_count_shift;
 		if (sec_cnt) {
-			dev_info(adev->dev, "Detected %s in SDMA%d, SED %d\n",
+			drm_info(adev_to_drm(adev), "Detected %s in SDMA%d, SED %d\n",
 				 sdma_v4_4_ras_fields[i].name,
 				 instance, sec_cnt);
 			*sec_count += sec_cnt;
@@ -255,7 +255,7 @@ static void sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,  void *r
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (sdma_v4_4_query_ras_error_count_by_instance(adev, i, ras_error_status)) {
-			dev_err(adev->dev, "Query ras error count failed in SDMA%d\n", i);
+			drm_err(adev_to_drm(adev), "Query ras error count failed in SDMA%d\n", i);
 			return;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 0613f50715483..5772e1030198f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1495,7 +1495,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
 
 	if (amdgpu_sdma_ras_sw_init(adev)) {
-		dev_err(adev->dev, "fail to initialize sdma ras block\n");
+		drm_err(adev_to_drm(adev), "fail to initialize sdma ras block\n");
 		return -EINVAL;
 	}
 
@@ -1504,7 +1504,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
-		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocated memory for SDMA IP Dump\n");
 
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
@@ -1731,7 +1731,7 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instan
 	}
 
 	if (i == adev->usec_timeout) {
-		dev_err(adev->dev, "timed out waiting for SDMA%d unhalt after reset\n",
+		drm_err(adev_to_drm(adev), "timed out waiting for SDMA%d unhalt after reset\n",
 			ring->me);
 		return -ETIMEDOUT;
 	}
@@ -1834,7 +1834,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struct amdgpu_device *adev,
 {
 	int instance;
 
-	DRM_ERROR("Illegal instruction in SDMA command stream\n");
+	drm_err(adev_to_drm(adev), "Illegal instruction in SDMA command stream\n");
 
 	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
@@ -1872,7 +1872,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 
 	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
-		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
+		drm_err(adev_to_drm(adev), "sdma instance invalid %d\n", instance);
 		return -EINVAL;
 	}
 
@@ -2493,7 +2493,7 @@ static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev,
 		for_each_inst(i, inst_mask)
 			sdma_v4_4_2_inst_query_ras_error_count(adev, i, ras_err_status);
 	} else {
-		dev_warn(adev->dev, "SDMA RAS is not supported\n");
+		drm_warn(adev_to_drm(adev), "SDMA RAS is not supported\n");
 	}
 }
 
@@ -2518,7 +2518,7 @@ static void sdma_v4_4_2_reset_ras_error_count(struct amdgpu_device *adev)
 		for_each_inst(i, inst_mask)
 			sdma_v4_4_2_inst_reset_ras_error_count(adev, i);
 	} else {
-		dev_warn(adev->dev, "SDMA RAS is not supported\n");
+		drm_warn(adev_to_drm(adev), "SDMA RAS is not supported\n");
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 37f094df9518c..395530c976d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1018,7 +1018,7 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate wb slot\n", r);
 		return r;
 	}
 
@@ -1082,7 +1082,7 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
-		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
+		drm_err(adev_to_drm(adev), "(%ld) failed to allocate wb slot\n", r);
 		return r;
 	}
 
@@ -1113,11 +1113,11 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
-		DRM_ERROR("amdgpu: IB test timed out\n");
+		drm_err(adev_to_drm(adev), "amdgpu: IB test timed out\n");
 		r = -ETIMEDOUT;
 		goto err1;
 	} else if (r < 0) {
-		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: fence wait failed (%ld).\n", r);
 		goto err1;
 	}
 
@@ -1404,7 +1404,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
-		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocated memory for SDMA IP Dump\n");
 
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
@@ -1518,7 +1518,7 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	}
 
 	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
+		drm_err(adev_to_drm(adev), "sdma instance not found\n");
 		return -EINVAL;
 	}
 
@@ -1549,7 +1549,7 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (j == adev->usec_timeout) {
 		stat1_reg = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
 		if ((stat1_reg & 0x3FF) != 0x3FF) {
-			DRM_ERROR("cannot soft reset as sdma not idle\n");
+			drm_err(adev_to_drm(adev), "cannot soft reset as sdma not idle\n");
 			r = -ETIMEDOUT;
 			goto err0;
 		}
@@ -1626,7 +1626,7 @@ static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	if (i >= adev->usec_timeout) {
 		r = -EINVAL;
-		DRM_ERROR("ring %d failed to be preempted\n", ring->idx);
+		drm_err(adev_to_drm(adev), "ring %d failed to be preempted\n", ring->idx);
 	}
 
 	/* deassert IB preemption */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 371eb640c9ff9..a399ee81e37ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -906,7 +906,7 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate wb slot\n", r);
 		return r;
 	}
 
@@ -970,7 +970,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
-		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
+		drm_err(adev_to_drm(adev), "(%ld) failed to allocate wb slot\n", r);
 		return r;
 	}
 
@@ -1000,11 +1000,11 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
-		DRM_ERROR("amdgpu: IB test timed out\n");
+		drm_err(adev_to_drm(adev), "amdgpu: IB test timed out\n");
 		r = -ETIMEDOUT;
 		goto err1;
 	} else if (r < 0) {
-		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: fence wait failed (%ld).\n", r);
 		goto err1;
 	}
 
@@ -1307,7 +1307,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->use_doorbell = true;
 		ring->me = i;
 
-		DRM_INFO("use_doorbell being set to: [%s]\n",
+		drm_info(adev_to_drm(adev), "use_doorbell being set to: [%s]\n",
 				ring->use_doorbell?"true":"false");
 
 		ring->doorbell_index =
@@ -1345,7 +1345,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
-		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocated memory for SDMA IP Dump\n");
 
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
@@ -1449,7 +1449,7 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	}
 
 	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
+		drm_err(adev_to_drm(adev), "sdma instance not found\n");
 		return -EINVAL;
 	}
 
@@ -1481,7 +1481,7 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (j == adev->usec_timeout) {
 		stat1_reg = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
 		if ((stat1_reg & 0x3FF) != 0x3FF) {
-			DRM_ERROR("cannot soft reset as sdma not idle\n");
+			drm_err(adev_to_drm(adev), "cannot soft reset as sdma not idle\n");
 			r = -ETIMEDOUT;
 			goto err0;
 		}
@@ -1558,7 +1558,7 @@ static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	if (i >= adev->usec_timeout) {
 		r = -EINVAL;
-		DRM_ERROR("ring %d failed to be preempted\n", ring->idx);
+		drm_err(adev_to_drm(adev), "ring %d failed to be preempted\n", ring->idx);
 	}
 
 	/* deassert IB preemption */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 95adacf386c87..29270cdb2bfdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -679,10 +679,10 @@ static int sdma_v6_0_load_microcode(struct amdgpu_device *adev)
 	use_broadcast = true;
 
 	if (use_broadcast) {
-		dev_info(adev->dev, "Use broadcast method to load SDMA firmware\n");
+		drm_info(adev_to_drm(adev), "Use broadcast method to load SDMA firmware\n");
 		/* load Control Thread microcode */
 		hdr = (const struct sdma_firmware_header_v2_0 *)adev->sdma.instance[0].fw->data;
-		amdgpu_ucode_print_sdma_hdr(&hdr->header);
+		amdgpu_ucode_print_sdma_hdr(adev, &hdr->header);
 		fw_size = le32_to_cpu(hdr->ctx_jt_offset + hdr->ctx_jt_size) / 4;
 
 		fw_data = (const __le32 *)
@@ -712,7 +712,7 @@ static int sdma_v6_0_load_microcode(struct amdgpu_device *adev)
 			WREG32(sdma_v6_0_get_reg_offset(adev, 0, regSDMA0_BROADCAST_UCODE_DATA), le32_to_cpup(fw_data++));
 		}
 	} else {
-		dev_info(adev->dev, "Use legacy method to load SDMA firmware\n");
+		drm_info(adev_to_drm(adev), "Use legacy method to load SDMA firmware\n");
 		for (i = 0; i < adev->sdma.num_instances; i++) {
 			/* load Control Thread microcode */
 			hdr = (const struct sdma_firmware_header_v2_0 *)adev->sdma.instance[0].fw->data;
@@ -924,7 +924,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate wb slot\n", r);
 		return r;
 	}
 
@@ -988,7 +988,7 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
-		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
+		drm_err(adev_to_drm(adev), "(%ld) failed to allocate wb slot\n", r);
 		return r;
 	}
 
@@ -1018,11 +1018,11 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
-		DRM_ERROR("amdgpu: IB test timed out\n");
+		drm_err(adev_to_drm(adev), "amdgpu: IB test timed out\n");
 		r = -ETIMEDOUT;
 		goto err1;
 	} else if (r < 0) {
-		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: fence wait failed (%ld).\n", r);
 		goto err1;
 	}
 
@@ -1334,7 +1334,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	if (amdgpu_sdma_ras_sw_init(adev)) {
-		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
+		drm_err(adev_to_drm(adev), "Failed to initialize sdma ras block!\n");
 		return -EINVAL;
 	}
 
@@ -1343,7 +1343,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
-		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocated memory for SDMA IP Dump\n");
 
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	/* add firmware version checks here */
@@ -1469,7 +1469,7 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	if (i >= adev->usec_timeout) {
 		r = -EINVAL;
-		DRM_ERROR("ring %d failed to be preempted\n", ring->idx);
+		drm_err(adev_to_drm(adev), "ring %d failed to be preempted\n", ring->idx);
 	}
 
 	/* deassert IB preemption */
@@ -1494,7 +1494,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	}
 
 	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
+		drm_err(adev_to_drm(adev), "sdma instance not found\n");
 		return -EINVAL;
 	}
 
@@ -1551,7 +1551,7 @@ static int sdma_v6_0_process_trap_irq(struct amdgpu_device *adev,
 	queue = entry->ring_id & 0xf;
 	instances = (entry->ring_id & 0xf0) >> 4;
 	if (instances > 1) {
-		DRM_ERROR("IH: wrong ring_ID detected, as wrong sdma instance\n");
+		drm_err(adev_to_drm(adev), "IH: wrong ring_ID detected, as wrong sdma instance\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ba132e9ae014a..007c85bed2082 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -705,7 +705,7 @@ static int sdma_v7_0_load_microcode(struct amdgpu_device *adev)
 					      &adev->sdma.instance[i].sdma_fw_gpu_addr,
 					      (void **)&adev->sdma.instance[i].sdma_fw_ptr);
 		if (r) {
-			dev_err(adev->dev, "(%d) failed to create sdma ucode bo\n", r);
+			drm_err(adev_to_drm(adev), "(%d) failed to create sdma ucode bo\n", r);
 			return r;
 		}
 
@@ -740,7 +740,7 @@ static int sdma_v7_0_load_microcode(struct amdgpu_device *adev)
 		}
 
 		if (j >= adev->usec_timeout) {
-			dev_err(adev->dev, "failed to init sdma ucode\n");
+			drm_err(adev_to_drm(adev), "failed to init sdma ucode\n");
 			return -EINVAL;
 		}
 	}
@@ -815,7 +815,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	}
 
 	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
+		drm_err(adev_to_drm(adev), "sdma instance not found\n");
 		return -EINVAL;
 	}
 
@@ -941,7 +941,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
-		dev_err(adev->dev, "(%d) failed to allocate wb slot\n", r);
+		drm_err(adev_to_drm(adev), "(%d) failed to allocate wb slot\n", r);
 		return r;
 	}
 
@@ -1005,7 +1005,7 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
-		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
+		drm_err(adev_to_drm(adev), "(%ld) failed to allocate wb slot\n", r);
 		return r;
 	}
 
@@ -1035,11 +1035,11 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
-		DRM_ERROR("amdgpu: IB test timed out\n");
+		drm_err(adev_to_drm(adev), "amdgpu: IB test timed out\n");
 		r = -ETIMEDOUT;
 		goto err1;
 	} else if (r < 0) {
-		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: fence wait failed (%ld).\n", r);
 		goto err1;
 	}
 
@@ -1256,7 +1256,7 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r) {
-		DRM_ERROR("Failed to init sdma firmware!\n");
+		drm_err(adev_to_drm(adev), "Failed to init sdma firmware!\n");
 		return r;
 	}
 
@@ -1318,7 +1318,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (ptr)
 		adev->sdma.ip_dump = ptr;
 	else
-		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocated memory for SDMA IP Dump\n");
 
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	/* add firmware version checks here */
@@ -1428,7 +1428,7 @@ static int sdma_v7_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	ring->trail_seq += 1;
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("ring %d failed to be allocated \n", ring->idx);
+		drm_err(adev_to_drm(adev), "ring %d failed to be allocated \n", ring->idx);
 		return r;
 	}
 	sdma_v7_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
@@ -1448,7 +1448,7 @@ static int sdma_v7_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	if (i >= adev->usec_timeout) {
 		r = -EINVAL;
-		DRM_ERROR("ring %d failed to be preempted\n", ring->idx);
+		drm_err(adev_to_drm(adev), "ring %d failed to be preempted\n", ring->idx);
 	}
 
 	/* deassert IB preemption */
@@ -1503,7 +1503,7 @@ static int sdma_v7_0_process_trap_irq(struct amdgpu_device *adev,
 	queue = entry->ring_id & 0xf;
 	instances = (entry->ring_id & 0xf0) >> 4;
 	if (instances > 1) {
-		DRM_ERROR("IH: wrong ring_ID detected, as wrong sdma instance\n");
+		drm_err(adev_to_drm(adev), "IH: wrong ring_ID detected, as wrong sdma instance\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 94a6ec162640e..571660e319f72 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1435,7 +1435,7 @@ si_asic_reset_method(struct amdgpu_device *adev)
 		return amdgpu_reset_method;
 	else if (amdgpu_reset_method != AMD_RESET_METHOD_LEGACY &&
 		 amdgpu_reset_method != -1)
-		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+		drm_warn(adev_to_drm(adev), "Specified reset method:%d isn't supported, using AUTO instead.\n",
 			 amdgpu_reset_method);
 
 	return AMD_RESET_METHOD_LEGACY;
@@ -1447,11 +1447,11 @@ static int si_asic_reset(struct amdgpu_device *adev)
 
 	switch (si_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
-		dev_info(adev->dev, "PCI reset\n");
+		drm_info(adev_to_drm(adev), "PCI reset\n");
 		r = amdgpu_device_pci_reset(adev);
 		break;
 	default:
-		dev_info(adev->dev, "PCI CONFIG reset\n");
+		drm_info(adev_to_drm(adev), "PCI CONFIG reset\n");
 		r = si_gpu_pci_config_reset(adev);
 		break;
 	}
@@ -1578,7 +1578,7 @@ static void si_set_pcie_lanes(struct amdgpu_device *adev, int lanes)
 		mask = LC_LINK_WIDTH_X16;
 		break;
 	default:
-		DRM_ERROR("invalid pcie lane request: %d\n", lanes);
+		drm_err(adev_to_drm(adev), "invalid pcie lane request: %d\n", lanes);
 		return;
 	}
 
@@ -1675,7 +1675,7 @@ static int si_uvd_send_upll_ctlreq(struct amdgpu_device *adev,
 	WREG32_P(cg_upll_func_cntl, 0, ~UPLL_CTLREQ_MASK);
 
 	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
-		DRM_ERROR("Timeout setting UVD clocks!\n");
+		drm_err(adev_to_drm(adev), "Timeout setting UVD clocks!\n");
 		return -ETIMEDOUT;
 	}
 
@@ -2258,16 +2258,16 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 		LC_CURRENT_DATA_RATE_SHIFT;
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
 		if (current_data_rate == 2) {
-			DRM_INFO("PCIE gen 3 link speeds already enabled\n");
+			drm_info(adev_to_drm(adev), "PCIE gen 3 link speeds already enabled\n");
 			return;
 		}
-		DRM_INFO("enabling PCIE gen 3 link speeds, disable with amdgpu.pcie_gen2=0\n");
+		drm_info(adev_to_drm(adev), "enabling PCIE gen 3 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	} else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) {
 		if (current_data_rate == 1) {
-			DRM_INFO("PCIE gen 2 link speeds already enabled\n");
+			drm_info(adev_to_drm(adev), "PCIE gen 2 link speeds already enabled\n");
 			return;
 		}
-		DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
+		drm_info(adev_to_drm(adev), "enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	}
 
 	if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 7f18e4875287c..1149bb50e7a6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -584,7 +584,7 @@ static int si_dma_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 static int si_dma_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	DRM_INFO("si_dma_soft_reset --- not implemented !!!!!!!\n");
+	drm_info(adev_to_drm(adev), "si_dma_soft_reset --- not implemented !!!!!!!\n");
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 1df00f8a2406a..dfebf713a798d 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -114,7 +114,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
 
 	if (wptr & IH_RB_WPTR__RB_OVERFLOW_MASK) {
 		wptr &= ~IH_RB_WPTR__RB_OVERFLOW_MASK;
-		dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+		drm_warn(adev_to_drm(adev), "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
 			wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
 		ih->rptr = (wptr + 16) & ih->ptr_mask;
 		tmp = RREG32(IH_RB_CNTL);
@@ -248,7 +248,7 @@ static int si_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "mmSRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "mmSRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 2594467bdd873..ed3ae8d208b78 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -140,7 +140,7 @@ sienna_cichlid_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 
 	r = sienna_cichlid_mode2_reset(adev);
 	if (r) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"ASIC reset failed with error, %d ", r);
 	}
 	return r;
@@ -153,7 +153,7 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 
 	r = psp_rlc_autoload_start(psp);
 	if (r) {
-		dev_err(adev->dev, "Failed to start rlc autoload\n");
+		drm_err(adev_to_drm(adev), "Failed to start rlc autoload\n");
 		return r;
 	}
 
@@ -163,7 +163,7 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 	adev->gfxhub.funcs->init(adev);
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r) {
-		dev_err(adev->dev, "GFXHUB gart reenable failed after reset\n");
+		drm_err(adev_to_drm(adev), "GFXHUB gart reenable failed after reset\n");
 		return r;
 	}
 
@@ -197,7 +197,7 @@ static int sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
 			r = adev->ip_blocks[i].version->funcs->late_init(
 				&adev->ip_blocks[i]);
 			if (r) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 					"late_init of IP block <%s> failed %d after reset\n",
 					adev->ip_blocks[i].version->funcs->name,
 					r);
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index dd2d66090d237..c002124e77747 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -196,7 +196,7 @@ static uint32_t smu_v11_0_i2c_poll_tx_status(struct i2c_adapter *control)
 
 	if (REG_GET_FIELD(reg, CKSVII2C_IC_INTR_STAT, R_TX_ABRT) == 1) {
 		reg_c_tx_abrt_source = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TX_ABRT_SOURCE);
-		DRM_INFO("TX was terminated, IC_TX_ABRT_SOURCE val is:%x", reg_c_tx_abrt_source);
+		drm_info(adev_to_drm(adev), "TX was terminated, IC_TX_ABRT_SOURCE val is:%x", reg_c_tx_abrt_source);
 
 		/* Check for stop due to NACK */
 		if (REG_GET_FIELD(reg_c_tx_abrt_source,
@@ -339,14 +339,14 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 	/* Any error, no point in proceeding */
 	if (ret != I2C_OK) {
 		if (ret & I2C_SW_TIMEOUT)
-			DRM_ERROR("TIMEOUT ERROR !!!");
+			drm_err(adev_to_drm(adev), "TIMEOUT ERROR !!!");
 
 		if (ret & I2C_NAK_7B_ADDR_NOACK)
-			DRM_ERROR("Received I2C_NAK_7B_ADDR_NOACK !!!");
+			drm_err(adev_to_drm(adev), "Received I2C_NAK_7B_ADDR_NOACK !!!");
 
 
 		if (ret & I2C_NAK_TXDATA_NOACK)
-			DRM_ERROR("Received I2C_NAK_TXDATA_NOACK !!!");
+			drm_err(adev_to_drm(adev), "Received I2C_NAK_TXDATA_NOACK !!!");
 	}
 
 	return ret;
@@ -408,13 +408,13 @@ static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
 		/* Any error, no point in proceeding */
 		if (ret != I2C_OK) {
 			if (ret & I2C_SW_TIMEOUT)
-				DRM_ERROR("TIMEOUT ERROR !!!");
+				drm_err(adev_to_drm(adev), "TIMEOUT ERROR !!!");
 
 			if (ret & I2C_NAK_7B_ADDR_NOACK)
-				DRM_ERROR("Received I2C_NAK_7B_ADDR_NOACK !!!");
+				drm_err(adev_to_drm(adev), "Received I2C_NAK_7B_ADDR_NOACK !!!");
 
 			if (ret & I2C_NAK_TXDATA_NOACK)
-				DRM_ERROR("Received I2C_NAK_TXDATA_NOACK !!!");
+				drm_err(adev_to_drm(adev), "Received I2C_NAK_TXDATA_NOACK !!!");
 
 			break;
 		}
@@ -745,7 +745,7 @@ int smu_v11_0_i2c_control_init(struct amdgpu_device *adev)
 
 	res = i2c_add_adapter(control);
 	if (res)
-		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+		drm_err(adev_to_drm(adev), "Failed to register hw i2c, err: %d\n", res);
 
 	return res;
 }
@@ -772,10 +772,10 @@ bool smu_v11_0_i2c_test_bus(struct i2c_adapter *control)
 	uint8_t data[6] = {0xf, 0, 0xde, 0xad, 0xbe, 0xef};
 
 
-	DRM_INFO("Begin");
+	drm_info(adev_to_drm(adev), "Begin");
 
 	if (!smu_v11_0_i2c_bus_lock(control)) {
-		DRM_ERROR("Failed to lock the bus!.");
+		drm_err(adev_to_drm(adev), "Failed to lock the bus!.");
 		return false;
 	}
 
@@ -791,7 +791,7 @@ bool smu_v11_0_i2c_test_bus(struct i2c_adapter *control)
 	smu_v11_0_i2c_bus_unlock(control);
 
 
-	DRM_INFO("End");
+	drm_info(adev_to_drm(adev), "End");
 	return true;
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index 70569ea906bca..3f52cd354f116 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -131,7 +131,7 @@ smu_v13_0_10_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
 
 	r = smu_v13_0_10_mode2_reset(adev);
 	if (r) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"ASIC reset failed with error, %d ", r);
 	}
 	return r;
@@ -160,13 +160,13 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
 
 	r = psp_load_fw_list(psp, ucode_list, ucode_count);
 	if (r) {
-		dev_err(adev->dev, "IMU ucode load failed after mode2 reset\n");
+		drm_err(adev_to_drm(adev), "IMU ucode load failed after mode2 reset\n");
 		return r;
 	}
 
 	r = psp_rlc_autoload_start(psp);
 	if (r) {
-		DRM_ERROR("Failed to start rlc autoload after mode2 reset\n");
+		drm_err(adev_to_drm(adev), "Failed to start rlc autoload after mode2 reset\n");
 		return r;
 	}
 
@@ -198,7 +198,7 @@ static int smu_v13_0_10_mode2_restore_ip(struct amdgpu_device *adev)
 			r = adev->ip_blocks[i].version->funcs->late_init(
 				&adev->ip_blocks[i]);
 			if (r) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 					"late_init of IP block <%s> failed %d after reset\n",
 					adev->ip_blocks[i].version->funcs->name,
 					r);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c457be3a3c56f..160b136befd8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -544,7 +544,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
         }
 
 	if (amdgpu_reset_method != -1)
-		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+		drm_warn(adev_to_drm(adev), "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
@@ -634,19 +634,19 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 asic_reset:
 	switch (soc15_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
-		dev_info(adev->dev, "PCI reset\n");
+		drm_info(adev_to_drm(adev), "PCI reset\n");
 		return amdgpu_device_pci_reset(adev);
 	case AMD_RESET_METHOD_BACO:
-		dev_info(adev->dev, "BACO reset\n");
+		drm_info(adev_to_drm(adev), "BACO reset\n");
 		return soc15_asic_baco_reset(adev);
 	case AMD_RESET_METHOD_MODE2:
-		dev_info(adev->dev, "MODE2 reset\n");
+		drm_info(adev_to_drm(adev), "MODE2 reset\n");
 		return amdgpu_dpm_mode2_reset(adev);
 	case AMD_RESET_METHOD_LINK:
-		dev_info(adev->dev, "Link reset\n");
+		drm_info(adev_to_drm(adev), "Link reset\n");
 		return amdgpu_device_link_reset(adev);
 	default:
-		dev_info(adev->dev, "MODE1 reset\n");
+		drm_info(adev_to_drm(adev), "MODE1 reset\n");
 		return amdgpu_device_mode1_reset(adev);
 	}
 }
@@ -733,7 +733,7 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
 		aldebaran_reg_base_init(adev);
 		break;
 	default:
-		DRM_ERROR("Unsupported asic type: %d!\n", adev->asic_type);
+		drm_err(adev_to_drm(adev), "Unsupported asic type: %d!\n", adev->asic_type);
 		break;
 	}
 }
@@ -1358,7 +1358,7 @@ static int soc15_common_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (soc15_need_reset_on_resume(adev)) {
-		dev_info(adev->dev, "S3 suspend abort case, let's reset ASIC.\n");
+		drm_info(adev_to_drm(adev), "S3 suspend abort case, let's reset ASIC.\n");
 		soc15_asic_reset(adev);
 	}
 	return soc15_common_hw_init(ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ad36c96478a82..f113a81e81261 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -336,15 +336,15 @@ static int soc21_asic_mode1_reset(struct amdgpu_device *adev)
 	amdgpu_device_cache_pci_state(adev->pdev);
 
 	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
-		dev_info(adev->dev, "GPU smu mode1 reset\n");
+		drm_info(adev_to_drm(adev), "GPU smu mode1 reset\n");
 		ret = amdgpu_dpm_mode1_reset(adev);
 	} else {
-		dev_info(adev->dev, "GPU psp mode1 reset\n");
+		drm_info(adev_to_drm(adev), "GPU psp mode1 reset\n");
 		ret = psp_gpu_reset(adev);
 	}
 
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		drm_err(adev_to_drm(adev), "GPU mode1 reset failed\n");
 	amdgpu_device_load_pci_state(adev->pdev);
 
 	/* wait for asic to come out of reset */
@@ -371,7 +371,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 		return amdgpu_reset_method;
 
 	if (amdgpu_reset_method != -1)
-		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+		drm_warn(adev_to_drm(adev), "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
@@ -400,19 +400,19 @@ static int soc21_asic_reset(struct amdgpu_device *adev)
 
 	switch (soc21_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
-		dev_info(adev->dev, "PCI reset\n");
+		drm_info(adev_to_drm(adev), "PCI reset\n");
 		ret = amdgpu_device_pci_reset(adev);
 		break;
 	case AMD_RESET_METHOD_BACO:
-		dev_info(adev->dev, "BACO reset\n");
+		drm_info(adev_to_drm(adev), "BACO reset\n");
 		ret = amdgpu_dpm_baco_reset(adev);
 		break;
 	case AMD_RESET_METHOD_MODE2:
-		dev_info(adev->dev, "MODE2 reset\n");
+		drm_info(adev_to_drm(adev), "MODE2 reset\n");
 		ret = amdgpu_dpm_mode2_reset(adev);
 		break;
 	default:
-		dev_info(adev->dev, "MODE1 reset\n");
+		drm_info(adev_to_drm(adev), "MODE1 reset\n");
 		ret = amdgpu_device_mode1_reset(adev);
 		break;
 	}
@@ -939,7 +939,7 @@ static int soc21_common_resume(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (soc21_need_reset_on_resume(adev)) {
-		dev_info(adev->dev, "S3 suspend aborted, resetting...");
+		drm_info(adev_to_drm(adev), "S3 suspend aborted, resetting...");
 		soc21_asic_reset(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 972b449ab89fa..320b7fc199fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -197,7 +197,7 @@ soc24_asic_reset_method(struct amdgpu_device *adev)
 		return amdgpu_reset_method;
 
 	if (amdgpu_reset_method != -1)
-		dev_warn(adev->dev,
+		drm_warn(adev_to_drm(adev),
 			 "Specified reset method:%d isn't supported, using AUTO instead.\n",
 			 amdgpu_reset_method);
 
@@ -219,19 +219,19 @@ static int soc24_asic_reset(struct amdgpu_device *adev)
 
 	switch (soc24_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
-		dev_info(adev->dev, "PCI reset\n");
+		drm_info(adev_to_drm(adev), "PCI reset\n");
 		ret = amdgpu_device_pci_reset(adev);
 		break;
 	case AMD_RESET_METHOD_BACO:
-		dev_info(adev->dev, "BACO reset\n");
+		drm_info(adev_to_drm(adev), "BACO reset\n");
 		ret = amdgpu_dpm_baco_reset(adev);
 		break;
 	case AMD_RESET_METHOD_MODE2:
-		dev_info(adev->dev, "MODE2 reset\n");
+		drm_info(adev_to_drm(adev), "MODE2 reset\n");
 		ret = amdgpu_dpm_mode2_reset(adev);
 		break;
 	default:
-		dev_info(adev->dev, "MODE1 reset\n");
+		drm_info(adev_to_drm(adev), "MODE1 reset\n");
 		ret = amdgpu_device_mode1_reset(adev);
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 7d17ae56f9019..3e97f2e5e8276 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -212,7 +212,7 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *adev,
 	 * this should allow us to catchup.
 	 */
 
-	dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+	drm_warn(adev_to_drm(adev), "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
 		wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
 	ih->rptr = (wptr + 16) & ih->ptr_mask;
 	tmp = RREG32(mmIH_RB_CNTL);
@@ -431,7 +431,7 @@ static int tonga_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0e404c0749753..c375e608dbd80 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -200,7 +200,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		addr_in->addr_type = TA_RAS_MCA_TO_PA;
 		ret = psp_ras_query_address(&adev->psp, addr_in, paddr_out);
 		if (ret) {
-			dev_warn(adev->dev, "Failed to query RAS physical address for 0x%llx",
+			drm_warn(adev_to_drm(adev), "Failed to query RAS physical address for 0x%llx",
 				err_addr);
 
 			goto out;
@@ -253,7 +253,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 		row = ((column >> 3) << 13) | row_lower;
 
 		if (dump_addr)
-			dev_info(adev->dev,
+			drm_info(adev_to_drm(adev),
 				"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
 				soc_pa, row, col, bank, channel_index);
 
@@ -529,7 +529,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		if (ret == -EEXIST)
 			con->umc_ecc_log.de_queried_count++;
 		else
-			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
+			drm_err(adev_to_drm(adev), "Fail to log ecc error! ret:%d\n", ret);
 
 		kfree(ecc_err);
 		return ret;
@@ -542,7 +542,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 				pa_addr,
 				page_pfn, ARRAY_SIZE(page_pfn));
 	if (count <= 0) {
-		dev_warn(adev->dev, "Fail to convert error address! count:%d\n", count);
+		drm_warn(adev_to_drm(adev), "Fail to convert error address! count:%d\n", count);
 		return 0;
 	}
 
@@ -619,7 +619,7 @@ static void umc_v12_0_query_ras_ecc_err_addr(struct amdgpu_device *adev,
 
 		ret = umc_v12_0_fill_error_record(adev, entries[i], ras_error_status);
 		if (ret) {
-			dev_err(adev->dev, "Fail to fill umc error record, ret:%d\n", ret);
+			drm_err(adev_to_drm(adev), "Fail to fill umc error record, ret:%d\n", ret);
 			break;
 		}
 		radix_tree_tag_clear(ecc_tree,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index a3ee3c4c650fe..79da8bdd1691a 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -64,31 +64,31 @@ static void umc_v6_7_query_error_status_helper(struct amdgpu_device *adev,
 	uint64_t reg_value;
 
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1)
-		dev_info(adev->dev, "Deferred error\n");
+		drm_info(adev_to_drm(adev), "Deferred error\n");
 
 	if (mc_umc_status)
-		dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
+		drm_info(adev_to_drm(adev), "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
 
 	/* print IPID registers value */
 	mc_umc_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
 	reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
 	if (reg_value)
-		dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+		drm_info(adev_to_drm(adev), "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
 
 	/* print SYND registers value */
 	mc_umc_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
 	reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
 	if (reg_value)
-		dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+		drm_info(adev_to_drm(adev), "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
 
 	/* print MISC0 registers value */
 	mc_umc_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
 	reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
 	if (reg_value)
-		dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
+		drm_info(adev_to_drm(adev), "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
 }
 
 static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
@@ -128,7 +128,7 @@ static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device
 			/* The umc channel bits are not original values, they are hashed */
 			SET_CHANNEL_HASH(channel_index, soc_pa);
 
-			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
+			drm_info(adev_to_drm(adev), "Error Address(PA): 0x%llx\n", soc_pa);
 		}
 	}
 }
@@ -207,13 +207,13 @@ void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
 	/* loop for all possibilities of [C4 C3 C2] */
 	for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
 		retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
-		dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+		drm_info(adev_to_drm(adev), "Error Address(PA): 0x%llx\n", retired_page);
 		amdgpu_umc_fill_error_record(err_data, err_addr,
 			retired_page, channel_index, umc_inst);
 
 		/* shift R14 bit */
 		retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
-		dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+		drm_info(adev_to_drm(adev), "Error Address(PA): 0x%llx\n", retired_page);
 		amdgpu_umc_fill_error_record(err_data, err_addr,
 			retired_page, channel_index, umc_inst);
 	}
@@ -329,7 +329,7 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
 			/* The umc channel bits are not original values, they are hashed */
 			SET_CHANNEL_HASH(channel_index, soc_pa);
 
-			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", soc_pa);
+			drm_info(adev_to_drm(adev), "Error Address(PA): 0x%llx\n", soc_pa);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index a32f87992f205..e3978023d9252 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -231,10 +231,10 @@ static void umc_v8_10_convert_error_address(struct amdgpu_device *adev,
 		ret = umc_v8_10_swizzle_mode_na_to_pa(adev, channel_index,
 						na_err_addr, &retired_page_addr);
 		if (ret) {
-			dev_err(adev->dev, "Failed to map pa from umc na.\n");
+			drm_err(adev_to_drm(adev), "Failed to map pa from umc na.\n");
 			break;
 		}
-		dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
+		drm_info(adev_to_drm(adev), "Error Address(PA): 0x%llx\n",
 			retired_page_addr);
 		amdgpu_umc_fill_error_record(err_data, na_err_addr,
 				retired_page_addr, channel_index, umc_inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index ce3bb12e3572e..8761cad8ca481 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -163,7 +163,7 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
 
 	r = SOC15_WAIT_ON_RREG(VCN, 0, regVCN_MES_MSTATUS_LO, 0xAAAAAAAA, 0xFFFFFFFF);
 	if (r) {
-		dev_err(adev->dev, "UMSCH FW Load: Failed, regVCN_MES_MSTATUS_LO: 0x%08x\n",
+		drm_err(adev_to_drm(adev), "UMSCH FW Load: Failed, regVCN_MES_MSTATUS_LO: 0x%08x\n",
 			RREG32_SOC15(VCN, 0, regVCN_MES_MSTATUS_LO));
 		goto err_free_data_bo;
 	}
@@ -317,7 +317,7 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdgpu_umsch_mm *umsch)
 
 	r = amdgpu_umsch_mm_query_fence(umsch);
 	if (r) {
-		dev_err(adev->dev, "UMSCH SET_HW_RESOURCES: Failed\n");
+		drm_err(adev_to_drm(adev), "UMSCH SET_HW_RESOURCES: Failed\n");
 		return r;
 	}
 
@@ -367,7 +367,7 @@ static int umsch_mm_v4_0_add_queue(struct amdgpu_umsch_mm *umsch,
 
 	r = amdgpu_umsch_mm_query_fence(umsch);
 	if (r) {
-		dev_err(adev->dev, "UMSCH ADD_QUEUE: Failed\n");
+		drm_err(adev_to_drm(adev), "UMSCH ADD_QUEUE: Failed\n");
 		return r;
 	}
 
@@ -399,7 +399,7 @@ static int umsch_mm_v4_0_remove_queue(struct amdgpu_umsch_mm *umsch,
 
 	r = amdgpu_umsch_mm_query_fence(umsch);
 	if (r) {
-		dev_err(adev->dev, "UMSCH REMOVE_QUEUE: Failed\n");
+		drm_err(adev_to_drm(adev), "UMSCH REMOVE_QUEUE: Failed\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 5dbaebb592b30..10595f4e1466f 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -391,7 +391,7 @@ static int uvd_v3_1_start(struct amdgpu_device *adev)
 		if (status & 2)
 			break;
 
-		DRM_ERROR("UVD not responding, trying to reset the VCPU!!!\n");
+		drm_err(adev_to_drm(adev), "UVD not responding, trying to reset the VCPU!!!\n");
 		WREG32_P(mmUVD_SOFT_RESET, UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
 				 ~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
 		mdelay(10);
@@ -401,7 +401,7 @@ static int uvd_v3_1_start(struct amdgpu_device *adev)
 	}
 
 	if (r) {
-		DRM_ERROR("UVD not responding, giving up!!!\n");
+		drm_err(adev_to_drm(adev), "UVD not responding, giving up!!!\n");
 		return r;
 	}
 
@@ -636,7 +636,7 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = uvd_v3_1_fw_validate(adev);
 	if (r) {
-		DRM_ERROR("amdgpu: UVD Firmware validate fail (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: UVD Firmware validate fail (%d).\n", r);
 		return r;
 	}
 
@@ -647,13 +647,13 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r) {
-		DRM_ERROR("amdgpu: UVD ring test fail (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: UVD ring test fail (%d).\n", r);
 		goto done;
 	}
 
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("amdgpu: ring failed to lock UVD ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: ring failed to lock UVD ring (%d).\n", r);
 		goto done;
 	}
 
@@ -680,7 +680,7 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 done:
 	if (!r)
-		DRM_INFO("UVD initialized successfully.\n");
+		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 4b96fd5837720..1f08878de75fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -167,7 +167,7 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("amdgpu: ring failed to lock UVD ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: ring failed to lock UVD ring (%d).\n", r);
 		goto done;
 	}
 
@@ -194,7 +194,7 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *ip_block)
 
 done:
 	if (!r)
-		DRM_INFO("UVD initialized successfully.\n");
+		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
 }
@@ -354,7 +354,7 @@ static int uvd_v4_2_start(struct amdgpu_device *adev)
 		if (status & 2)
 			break;
 
-		DRM_ERROR("UVD not responding, trying to reset the VCPU!!!\n");
+		drm_err(adev_to_drm(adev), "UVD not responding, trying to reset the VCPU!!!\n");
 		WREG32_P(mmUVD_SOFT_RESET, UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
 				~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
 		mdelay(10);
@@ -364,7 +364,7 @@ static int uvd_v4_2_start(struct amdgpu_device *adev)
 	}
 
 	if (r) {
-		DRM_ERROR("UVD not responding, giving up!!!\n");
+		drm_err(adev_to_drm(adev), "UVD not responding, giving up!!!\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 71409ad8b7ed1..500cc8dd31ea2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -164,7 +164,7 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("amdgpu: ring failed to lock UVD ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: ring failed to lock UVD ring (%d).\n", r);
 		goto done;
 	}
 
@@ -191,7 +191,7 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 done:
 	if (!r)
-		DRM_INFO("UVD initialized successfully.\n");
+		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
 
@@ -397,7 +397,7 @@ static int uvd_v5_0_start(struct amdgpu_device *adev)
 		if (status & 2)
 			break;
 
-		DRM_ERROR("UVD not responding, trying to reset the VCPU!!!\n");
+		drm_err(adev_to_drm(adev), "UVD not responding, trying to reset the VCPU!!!\n");
 		WREG32_P(mmUVD_SOFT_RESET, UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
 				~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
 		mdelay(10);
@@ -407,7 +407,7 @@ static int uvd_v5_0_start(struct amdgpu_device *adev)
 	}
 
 	if (r) {
-		DRM_ERROR("UVD not responding, giving up!!!\n");
+		drm_err(adev_to_drm(adev), "UVD not responding, giving up!!!\n");
 		return r;
 	}
 	/* enable master interrupt */
@@ -846,7 +846,7 @@ static void uvd_v5_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64
 
 	if (RREG32_SMC(ixCURRENT_PG_STATUS) &
 				CURRENT_PG_STATUS__UVD_PG_STATUS_MASK) {
-		DRM_INFO("Cannot get clockgating state when UVD is powergated.\n");
+		drm_info(adev_to_drm(adev), "Cannot get clockgating state when UVD is powergated.\n");
 		goto out;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 1c07b701d0e4f..4a5b9f06189da 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -406,7 +406,7 @@ static int uvd_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->uvd.inst->irq.num_types = 1;
 		adev->uvd.num_enc_rings = 0;
 
-		DRM_INFO("UVD ENC is disabled\n");
+		drm_info(adev_to_drm(adev), "UVD ENC is disabled\n");
 	}
 
 	ring = &adev->uvd.inst->ring;
@@ -476,7 +476,7 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("amdgpu: ring failed to lock UVD ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "amdgpu: ring failed to lock UVD ring (%d).\n", r);
 		goto done;
 	}
 
@@ -513,9 +513,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 done:
 	if (!r) {
 		if (uvd_v6_0_enc_support(adev))
-			DRM_INFO("UVD and UVD ENC initialized successfully.\n");
+			drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
 		else
-			DRM_INFO("UVD initialized successfully.\n");
+			drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 	}
 
 	return r;
@@ -812,7 +812,7 @@ static int uvd_v6_0_start(struct amdgpu_device *adev)
 		if (status & 2)
 			break;
 
-		DRM_ERROR("UVD not responding, trying to reset the VCPU!!!\n");
+		drm_err(adev_to_drm(adev), "UVD not responding, trying to reset the VCPU!!!\n");
 		WREG32_FIELD(UVD_SOFT_RESET, VCPU_SOFT_RESET, 1);
 		mdelay(10);
 		WREG32_FIELD(UVD_SOFT_RESET, VCPU_SOFT_RESET, 0);
@@ -821,7 +821,7 @@ static int uvd_v6_0_start(struct amdgpu_device *adev)
 	}
 
 	if (r) {
-		DRM_ERROR("UVD not responding, giving up!!!\n");
+		drm_err(adev_to_drm(adev), "UVD not responding, giving up!!!\n");
 		return r;
 	}
 	/* enable master interrupt */
@@ -1208,7 +1208,7 @@ static int uvd_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -1272,7 +1272,7 @@ static int uvd_v6_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (!int_handled)
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 
 	return 0;
@@ -1511,7 +1511,7 @@ static void uvd_v6_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64
 		data = RREG32_SMC(ixCURRENT_PG_STATUS);
 
 	if (data & CURRENT_PG_STATUS__UVD_PG_STATUS_MASK) {
-		DRM_INFO("Cannot get clockgating state when UVD is powergated.\n");
+		drm_info(adev_to_drm(adev), "Cannot get clockgating state when UVD is powergated.\n");
 		goto out;
 	}
 
@@ -1631,10 +1631,10 @@ static void uvd_v6_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	if (adev->asic_type >= CHIP_POLARIS10) {
 		adev->uvd.inst->ring.funcs = &uvd_v6_0_ring_vm_funcs;
-		DRM_INFO("UVD is enabled in VM mode\n");
+		drm_info(adev_to_drm(adev), "UVD is enabled in VM mode\n");
 	} else {
 		adev->uvd.inst->ring.funcs = &uvd_v6_0_ring_phys_funcs;
-		DRM_INFO("UVD is enabled in physical mode\n");
+		drm_info(adev_to_drm(adev), "UVD is enabled in physical mode\n");
 	}
 }
 
@@ -1645,7 +1645,7 @@ static void uvd_v6_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->uvd.num_enc_rings; ++i)
 		adev->uvd.inst->ring_enc[i].funcs = &uvd_v6_0_enc_ring_vm_funcs;
 
-	DRM_INFO("UVD ENC is enabled in VM mode\n");
+	drm_info(adev_to_drm(adev), "UVD ENC is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs uvd_v6_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 9d237b5937fb0..9e84b87c966cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -436,7 +436,7 @@ static int uvd_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 		}
-		DRM_INFO("PSP loading UVD firmware\n");
+		drm_info(adev_to_drm(adev), "PSP loading UVD firmware\n");
 	}
 
 	for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
@@ -540,7 +540,7 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_alloc(ring, 10);
 			if (r) {
-				DRM_ERROR("amdgpu: (%d)ring failed to lock UVD ring (%d).\n", j, r);
+				drm_err(adev_to_drm(adev), "amdgpu: (%d)ring failed to lock UVD ring (%d).\n", j, r);
 				goto done;
 			}
 
@@ -580,7 +580,7 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 	}
 done:
 	if (!r)
-		DRM_INFO("UVD and UVD ENC initialized successfully.\n");
+		drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
 
 	return r;
 }
@@ -776,7 +776,7 @@ static int uvd_v7_0_mmsch_start(struct amdgpu_device *adev,
 	}
 
 	if (!loop) {
-		dev_err(adev->dev, "failed to init MMSCH, mmVCE_MMSCH_VF_MAILBOX_RESP = %x\n", data);
+		drm_err(adev_to_drm(adev), "failed to init MMSCH, mmVCE_MMSCH_VF_MAILBOX_RESP = %x\n", data);
 		return -EBUSY;
 	}
 
@@ -1055,7 +1055,7 @@ static int uvd_v7_0_start(struct amdgpu_device *adev)
 			if (status & 2)
 				break;
 
-			DRM_ERROR("UVD(%d) not responding, trying to reset the VCPU!!!\n", k);
+			drm_err(adev_to_drm(adev), "UVD(%d) not responding, trying to reset the VCPU!!!\n", k);
 			WREG32_P(SOC15_REG_OFFSET(UVD, k, mmUVD_SOFT_RESET),
 					UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
 					~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
@@ -1067,7 +1067,7 @@ static int uvd_v7_0_start(struct amdgpu_device *adev)
 		}
 
 		if (r) {
-			DRM_ERROR("UVD(%d) not responding, giving up!!!\n", k);
+			drm_err(adev_to_drm(adev), "UVD(%d) not responding, giving up!!!\n", k);
 			return r;
 		}
 		/* enable master interrupt */
@@ -1485,7 +1485,7 @@ static int uvd_v7_0_process_interrupt(struct amdgpu_device *adev,
 		ip_instance = 1;
 		break;
 	default:
-		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+		drm_err(adev_to_drm(adev), "Unhandled client id: %d\n", entry->client_id);
 		return 0;
 	}
 
@@ -1503,7 +1503,7 @@ static int uvd_v7_0_process_interrupt(struct amdgpu_device *adev,
 			amdgpu_fence_process(&adev->uvd.inst[ip_instance].ring_enc[1]);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -1604,7 +1604,7 @@ static void uvd_v7_0_set_ring_funcs(struct amdgpu_device *adev)
 			continue;
 		adev->uvd.inst[i].ring.funcs = &uvd_v7_0_ring_vm_funcs;
 		adev->uvd.inst[i].ring.me = i;
-		DRM_INFO("UVD(%d) is enabled in VM mode\n", i);
+		drm_info(adev_to_drm(adev), "UVD(%d) is enabled in VM mode\n", i);
 	}
 }
 
@@ -1620,7 +1620,7 @@ static void uvd_v7_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 			adev->uvd.inst[j].ring_enc[i].me = j;
 		}
 
-		DRM_INFO("UVD(%d) ENC is enabled in VM mode\n", j);
+		drm_info(adev_to_drm(adev), "UVD(%d) ENC is enabled in VM mode\n", j);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index bee3e904a6bc7..34d95b379acf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -126,7 +126,7 @@ static int vce_v2_0_firmware_loaded(struct amdgpu_device *adev)
 			mdelay(10);
 		}
 
-		DRM_ERROR("VCE not responding, trying to reset the ECPU!!!\n");
+		drm_err(adev_to_drm(adev), "VCE not responding, trying to reset the ECPU!!!\n");
 		WREG32_P(mmVCE_SOFT_RESET,
 			VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
 			~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
@@ -265,7 +265,7 @@ static int vce_v2_0_start(struct amdgpu_device *adev)
 	WREG32_P(mmVCE_STATUS, 0, ~1);
 
 	if (r) {
-		DRM_ERROR("VCE not responding, giving up!!!\n");
+		drm_err(adev_to_drm(adev), "VCE not responding, giving up!!!\n");
 		return r;
 	}
 
@@ -289,7 +289,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	if (vce_v2_0_wait_for_idle(ip_block)) {
-		DRM_INFO("VCE is busy, Can't set clock gating");
+		drm_info(adev_to_drm(adev), "VCE is busy, Can't set clock gating");
 		return 0;
 	}
 
@@ -476,7 +476,7 @@ static int vce_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	DRM_INFO("VCE initialized successfully.\n");
+	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
 }
@@ -570,7 +570,7 @@ static int vce_v2_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->vce.ring[entry->src_data[0]]);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 708123899c416..589d00581fe8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -245,7 +245,7 @@ static int vce_v3_0_firmware_loaded(struct amdgpu_device *adev)
 			mdelay(10);
 		}
 
-		DRM_ERROR("VCE not responding, trying to reset the ECPU!!!\n");
+		drm_err(adev_to_drm(adev), "VCE not responding, trying to reset the ECPU!!!\n");
 		WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
 		mdelay(10);
 		WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);
@@ -316,7 +316,7 @@ static int vce_v3_0_start(struct amdgpu_device *adev)
 		WREG32_FIELD(VCE_STATUS, JOB_BUSY, 0);
 
 		if (r) {
-			DRM_ERROR("VCE not responding, giving up!!!\n");
+			drm_err(adev_to_drm(adev), "VCE not responding, giving up!!!\n");
 			mutex_unlock(&adev->grbm_idx_mutex);
 			return r;
 		}
@@ -480,7 +480,7 @@ static int vce_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	DRM_INFO("VCE initialized successfully.\n");
+	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
 }
@@ -681,7 +681,7 @@ static int vce_v3_0_soft_reset(struct amdgpu_ip_block *ip_block)
 
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		drm_info(adev_to_drm(adev), "SRBM_SOFT_RESET=0x%08X\n", tmp);
 		WREG32(mmSRBM_SOFT_RESET, tmp);
 		tmp = RREG32(mmSRBM_SOFT_RESET);
 
@@ -752,7 +752,7 @@ static int vce_v3_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->vce.ring[entry->src_data[0]]);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -841,7 +841,7 @@ static void vce_v3_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64
 		data = RREG32_SMC(ixCURRENT_PG_STATUS);
 
 	if (data & CURRENT_PG_STATUS__VCE_PG_STATUS_MASK) {
-		DRM_INFO("Cannot get clockgating state when VCE is powergated.\n");
+		drm_info(adev_to_drm(adev), "Cannot get clockgating state when VCE is powergated.\n");
 		goto out;
 	}
 
@@ -973,13 +973,13 @@ static void vce_v3_0_set_ring_funcs(struct amdgpu_device *adev)
 			adev->vce.ring[i].funcs = &vce_v3_0_ring_vm_funcs;
 			adev->vce.ring[i].me = i;
 		}
-		DRM_INFO("VCE enabled in VM mode\n");
+		drm_info(adev_to_drm(adev), "VCE enabled in VM mode\n");
 	} else {
 		for (i = 0; i < adev->vce.num_rings; i++) {
 			adev->vce.ring[i].funcs = &vce_v3_0_ring_phys_funcs;
 			adev->vce.ring[i].me = i;
 		}
-		DRM_INFO("VCE enabled in physical mode\n");
+		drm_info(adev_to_drm(adev), "VCE enabled in physical mode\n");
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 335bda64ff5bc..d06c9600128b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -136,7 +136,7 @@ static int vce_v4_0_firmware_loaded(struct amdgpu_device *adev)
 			mdelay(10);
 		}
 
-		DRM_ERROR("VCE not responding, trying to reset the ECPU!!!\n");
+		drm_err(adev_to_drm(adev), "VCE not responding, trying to reset the ECPU!!!\n");
 		WREG32_P(SOC15_REG_OFFSET(VCE, 0, mmVCE_SOFT_RESET),
 				VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
 				~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
@@ -195,7 +195,7 @@ static int vce_v4_0_mmsch_start(struct amdgpu_device *adev,
 	}
 
 	if (!loop) {
-		dev_err(adev->dev, "failed to init MMSCH, mmVCE_MMSCH_VF_MAILBOX_RESP = %x\n", data);
+		drm_err(adev_to_drm(adev), "failed to init MMSCH, mmVCE_MMSCH_VF_MAILBOX_RESP = %x\n", data);
 		return -EBUSY;
 	}
 
@@ -378,7 +378,7 @@ static int vce_v4_0_start(struct amdgpu_device *adev)
 	WREG32_P(SOC15_REG_OFFSET(VCE, 0, mmVCE_STATUS), 0, ~VCE_STATUS__JOB_BUSY_MASK);
 
 	if (r) {
-		DRM_ERROR("VCE not responding, giving up!!!\n");
+		drm_err(adev_to_drm(adev), "VCE not responding, giving up!!!\n");
 		return r;
 	}
 
@@ -455,7 +455,7 @@ static int vce_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].fw = adev->vce.fw;
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		DRM_INFO("PSP loading VCE firmware\n");
+		drm_info(adev_to_drm(adev), "PSP loading VCE firmware\n");
 	} else {
 		r = amdgpu_vce_resume(adev);
 		if (r)
@@ -531,7 +531,7 @@ static int vce_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	DRM_INFO("VCE initialized successfully.\n");
+	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
 }
@@ -798,7 +798,7 @@ static int vce_v4_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->vce.ring[entry->src_data[0]]);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -859,7 +859,7 @@ static void vce_v4_0_set_ring_funcs(struct amdgpu_device *adev)
 		adev->vce.ring[i].funcs = &vce_v4_0_ring_vm_funcs;
 		adev->vce.ring[i].me = i;
 	}
-	DRM_INFO("VCE enabled in VM mode\n");
+	drm_info(adev_to_drm(adev), "VCE enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs vce_v4_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 21b57c29bf7d7..588cf6fc8a4dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -204,7 +204,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for VCN IP Dump\n");
 		adev->vcn.ip_dump = NULL;
 	} else {
 		adev->vcn.ip_dump = ptr;
@@ -931,7 +931,7 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
 		if (status & UVD_STATUS__IDLE)
 			break;
 
-		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
+		drm_err(adev_to_drm(adev), "VCN decode not responding, trying to reset the VCPU!!!\n");
 		WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET),
 				UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
 				~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
@@ -943,7 +943,7 @@ static int vcn_v1_0_start_spg_mode(struct amdgpu_vcn_inst *vinst)
 	}
 
 	if (r) {
-		DRM_ERROR("VCN decode not responding, giving up!!!\n");
+		drm_err(adev_to_drm(adev), "VCN decode not responding, giving up!!!\n");
 		return r;
 	}
 	/* enable master interrupt */
@@ -1799,7 +1799,7 @@ static int vcn_v1_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->vcn.inst->ring_enc[1]);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -1895,7 +1895,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 	mutex_lock(&adev->vcn.inst[0].vcn1_jpeg1_workaround);
 
 	if (amdgpu_fence_wait_empty(ring->adev->jpeg.inst->ring_dec))
-		DRM_ERROR("VCN dec: jpeg dec ring may not be empty\n");
+		drm_err(adev_to_drm(adev), "VCN dec: jpeg dec ring may not be empty\n");
 
 	vcn_v1_0_set_pg_for_begin_use(ring, set_clocks);
 
@@ -2041,7 +2041,7 @@ static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
 
 	addr &= AMDGPU_GMC_HOLE_MASK;
 	if (addr & 0x7) {
-		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
+		drm_err(adev_to_drm(parser->adev), "VCN messages must be 8 byte aligned!\n");
 		return -EINVAL;
 	}
 
@@ -2056,7 +2056,7 @@ static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (r) {
-		DRM_ERROR("Failed to validate the VCN message BO (%d)!\n", r);
+		drm_err(adev_to_drm(parser->adev), "Failed to validate the VCN message BO (%d)!\n", r);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8e7a36f26e9cb..947ba16304ce7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -226,7 +226,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for VCN IP Dump\n");
 		adev->vcn.ip_dump = NULL;
 	} else {
 		adev->vcn.ip_dump = ptr;
@@ -1082,7 +1082,7 @@ static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
 		if (status & 2)
 			break;
 
-		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
+		drm_err(adev_to_drm(adev), "VCN decode not responding, trying to reset the VCPU!!!\n");
 		WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET),
 			UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK,
 			~UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
@@ -1094,7 +1094,7 @@ static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
 	}
 
 	if (r) {
-		DRM_ERROR("VCN decode not responding, giving up!!!\n");
+		drm_err(adev_to_drm(adev), "VCN decode not responding, giving up!!!\n");
 		return r;
 	}
 
@@ -1771,7 +1771,7 @@ static int vcn_v2_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->vcn.inst->ring_enc[1]);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -1901,7 +1901,7 @@ static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
 	}
 
 	if (!loop) {
-		DRM_ERROR("failed to init MMSCH, " \
+		drm_err(adev_to_drm(adev), "failed to init MMSCH, " \
 			"mmMMSCH_VF_MAILBOX_RESP = 0x%08x\n", data);
 		return -EBUSY;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d716510b8dd68..601efbb315229 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -418,7 +418,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for VCN IP Dump\n");
 		adev->vcn.ip_dump = NULL;
 	} else {
 		adev->vcn.ip_dump = ptr;
@@ -1392,7 +1392,7 @@ static int vcn_v2_5_mmsch_start(struct amdgpu_device *adev,
 	}
 
 	if (!loop) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"failed to init MMSCH, mmMMSCH_VF_MAILBOX_RESP = %x\n",
 			data);
 		return -EBUSY;
@@ -2032,7 +2032,7 @@ static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
 		ip_instance = 1;
 		break;
 	default:
-		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+		drm_err(adev_to_drm(adev), "Unhandled client id: %d\n", entry->client_id);
 		return 0;
 	}
 
@@ -2049,7 +2049,7 @@ static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[1]);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -2209,7 +2209,7 @@ static uint32_t vcn_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
 	}
 
 	if (poison_stat)
-		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
+		drm_info(adev_to_drm(adev), "Poison detected in VCN%d, sub_block%d\n",
 			instance, sub_block);
 
 	return poison_stat;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 22ae1939476f0..3eea723eee160 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -299,7 +299,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr == NULL) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		drm_err(adev_to_drm(ip_block->adev), "Failed to allocate memory for VCN IP Dump\n");
 		adev->vcn.ip_dump = NULL;
 	} else {
 		adev->vcn.ip_dump = ptr;
@@ -378,7 +378,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, i)) {
 				ring->sched.ready = false;
 				ring->no_scheduler = true;
-				dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+				drm_info(adev_to_drm(ip_block->adev), "ring %s is disabled by hypervisor\n", ring->name);
 			} else {
 				ring->wptr = 0;
 				ring->wptr_old = 0;
@@ -391,7 +391,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 				if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
 					ring->sched.ready = false;
 					ring->no_scheduler = true;
-					dev_info(adev->dev, "ring %s is disabled by hypervisor\n", ring->name);
+					drm_info(adev_to_drm(ip_block->adev), "ring %s is disabled by hypervisor\n", ring->name);
 				} else {
 					ring->wptr = 0;
 					ring->wptr_old = 0;
@@ -1560,7 +1560,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 		udelay(10);
 		tmp = tmp + 10;
 		if (tmp >= timeout) {
-			DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+			drm_err(adev_to_drm(adev), "failed to init MMSCH. TIME-OUT after %d usec"\
 				" waiting for mmMMSCH_VF_MAILBOX_RESP "\
 				"(expected=0x%08x, readback=0x%08x)\n",
 				tmp, expected, resp);
@@ -1884,14 +1884,14 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	addr &= AMDGPU_GMC_HOLE_MASK;
 	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08Lx\n", addr);
+		drm_err(adev_to_drm(p->adev), "Can't find BO for addr 0x%08Lx\n", addr);
 		return r;
 	}
 
 	start = map->start * AMDGPU_GPU_PAGE_SIZE;
 	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
 	if (addr & 0x7) {
-		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
+		drm_err(adev_to_drm(p->adev), "VCN messages must be 8 byte aligned!\n");
 		return -EINVAL;
 	}
 
@@ -1899,13 +1899,13 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (r) {
-		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
+		drm_err(adev_to_drm(p->adev), "Failed validating the VCN message BO (%d)!\n", r);
 		return r;
 	}
 
 	r = amdgpu_bo_kmap(bo, &ptr);
 	if (r) {
-		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
+		drm_err(adev_to_drm(p->adev), "Failed mapping the VCN message (%d)!\n", r);
 		return r;
 	}
 
@@ -2251,7 +2251,7 @@ static int vcn_v3_0_process_interrupt(struct amdgpu_device *adev,
 		ip_instance = 1;
 		break;
 	default:
-		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+		drm_err(adev_to_drm(adev), "Unhandled client id: %d\n", entry->client_id);
 		return 0;
 	}
 
@@ -2268,7 +2268,7 @@ static int vcn_v3_0_process_interrupt(struct amdgpu_device *adev,
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[1]);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c6f6392c1c20b..03310cf029611 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -121,7 +121,7 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
 				adev->vcn.harvest_config |= 1 << i;
-				dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", i);
+				drm_info(adev_to_drm(ip_block->adev), "VCN%d is disabled by hypervisor\n", i);
 			}
 		}
 	}
@@ -256,7 +256,7 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		drm_err(adev_to_drm(ip_block->adev), "Failed to allocate memory for VCN IP Dump\n");
 		adev->vcn.ip_dump = NULL;
 	} else {
 		adev->vcn.ip_dump = ptr;
@@ -1249,7 +1249,7 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
 			if (status & 2)
 				break;
 
-			dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
+			drm_err(adev_to_drm(adev), "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
 			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
 				 UVD_VCPU_CNTL__BLK_RST_MASK,
 				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
@@ -1263,7 +1263,7 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *vinst)
 	}
 
 	if (r) {
-		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
+		drm_err(adev_to_drm(adev), "VCN[%d] is not responding, giving up!!!\n", i);
 		return r;
 	}
 
@@ -1535,7 +1535,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 		udelay(10);
 		tmp = tmp + 10;
 		if (tmp >= timeout) {
-			DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+			drm_err(adev_to_drm(adev), "failed to init MMSCH. TIME-OUT after %d usec"\
 				" waiting for regMMSCH_VF_MAILBOX_RESP "\
 				"(expected=0x%08x, readback=0x%08x)\n",
 				tmp, expected, resp);
@@ -1546,7 +1546,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 	init_status = ((struct mmsch_v4_0_init_header *)(table_loc))->inst[enabled_vcn].init_status;
 	if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
 	&& init_status != MMSCH_VF_ENGINE_STATUS__PASS)
-		DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init "\
+		drm_err(adev_to_drm(adev), "MMSCH init status is incorrect! readback=0x%08x, header init "\
 			"status for VCN%x: 0x%x\n", resp, enabled_vcn, init_status);
 
 	return 0;
@@ -1734,7 +1734,7 @@ static uint64_t vcn_v4_0_unified_ring_get_rptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(ring->adev), "wrong ring id is identified in %s", __func__);
 
 	return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR);
 }
@@ -1751,7 +1751,7 @@ static uint64_t vcn_v4_0_unified_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(ring->adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
 		return *ring->wptr_cpu_addr;
@@ -1771,7 +1771,7 @@ static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(ring->adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
 		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
@@ -1815,14 +1815,14 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	addr &= AMDGPU_GMC_HOLE_MASK;
 	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
 	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
+		drm_err(adev_to_drm(p->adev), "Can't find BO for addr 0x%08llx\n", addr);
 		return r;
 	}
 
 	start = map->start * AMDGPU_GPU_PAGE_SIZE;
 	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
 	if (addr & 0x7) {
-		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
+		drm_err(adev_to_drm(p->adev), "VCN messages must be 8 byte aligned!\n");
 		return -EINVAL;
 	}
 
@@ -1830,13 +1830,13 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (r) {
-		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
+		drm_err(adev_to_drm(p->adev), "Failed validating the VCN message BO (%d)!\n", r);
 		return r;
 	}
 
 	r = amdgpu_bo_kmap(bo, &ptr);
 	if (r) {
-		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
+		drm_err(adev_to_drm(p->adev), "Failed mapping the VCN message (%d)!\n", r);
 		return r;
 	}
 
@@ -2152,19 +2152,19 @@ static int vcn_v4_0_process_interrupt(struct amdgpu_device *adev, struct amdgpu_
 			ip_instance = 1;
 			break;
 		default:
-			DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+			drm_err(adev_to_drm(adev), "Unhandled client id: %d\n", entry->client_id);
 			return 0;
 		}
 	}
 
-	DRM_DEBUG("IH: VCN TRAP\n");
+	drm_dbg(adev_to_drm(adev), "IH: VCN TRAP\n");
 
 	switch (entry->src_id) {
 	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[0]);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
@@ -2305,7 +2305,7 @@ static uint32_t vcn_v4_0_query_poison_by_instance(struct amdgpu_device *adev,
 	}
 
 	if (poison_stat)
-		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
+		drm_info(adev_to_drm(adev), "Poison detected in VCN%d, sub_block%d\n",
 			instance, sub_block);
 
 	return poison_stat;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 3e176b4b7c69d..4c091ecb26074 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -221,7 +221,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
 		r = amdgpu_vcn_ras_sw_init(adev);
 		if (r) {
-			dev_err(adev->dev, "Failed to initialize vcn ras block!\n");
+			drm_err(adev_to_drm(adev), "Failed to initialize vcn ras block!\n");
 			return r;
 		}
 	}
@@ -229,7 +229,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for VCN IP Dump\n");
 		adev->vcn.ip_dump = NULL;
 	} else {
 		adev->vcn.ip_dump = ptr;
@@ -1134,7 +1134,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 			udelay(10);
 			tmp = tmp + 10;
 			if (tmp >= timeout) {
-				DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+				drm_err(adev_to_drm(adev), "failed to init MMSCH. TIME-OUT after %d usec"\
 					" waiting for regMMSCH_VF_MAILBOX_RESP "\
 					"(expected=0x%08x, readback=0x%08x)\n",
 					tmp, expected, resp);
@@ -1146,7 +1146,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 		init_status = ((struct mmsch_v4_0_3_init_header *)(table_loc))->vcn0.init_status;
 		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
 					&& init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
-			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init "\
+			drm_err(adev_to_drm(adev), "MMSCH init status is incorrect! readback=0x%08x, header init "\
 				"status for VCN%x: 0x%x\n", resp, enabled_vcn, init_status);
 		}
 	}
@@ -1469,7 +1469,7 @@ static uint64_t vcn_v4_0_3_unified_ring_get_rptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	return RREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_RPTR);
 }
@@ -1486,7 +1486,7 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
 		return *ring->wptr_cpu_addr;
@@ -1552,7 +1552,7 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
 		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
@@ -1911,7 +1911,7 @@ static void vcn_v4_0_3_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t i;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
-		dev_warn(adev->dev, "VCN RAS is not supported\n");
+		drm_warn(adev_to_drm(adev), "VCN RAS is not supported\n");
 		return;
 	}
 
@@ -1933,7 +1933,7 @@ static void vcn_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
 	uint32_t i;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
-		dev_warn(adev->dev, "VCN RAS is not supported\n");
+		drm_warn(adev_to_drm(adev), "VCN RAS is not supported\n");
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ba603b2246e2e..a9e0467e62abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -223,7 +223,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for VCN IP Dump\n");
 		adev->vcn.ip_dump = NULL;
 	} else {
 		adev->vcn.ip_dump = ptr;
@@ -1151,7 +1151,7 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 			if (status & 2)
 				break;
 
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"VCN[%d] is not responding, trying to reset VCPU!!!\n", i);
 			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
 				 UVD_VCPU_CNTL__BLK_RST_MASK,
@@ -1166,7 +1166,7 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 	}
 
 	if (r) {
-		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
+		drm_err(adev_to_drm(adev), "VCN[%d] is not responding, giving up!!!\n", i);
 		return r;
 	}
 
@@ -1388,7 +1388,7 @@ static uint64_t vcn_v4_0_5_unified_ring_get_rptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR);
 }
@@ -1405,7 +1405,7 @@ static uint64_t vcn_v4_0_5_unified_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
 		return *ring->wptr_cpu_addr;
@@ -1425,7 +1425,7 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
 		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
@@ -1608,7 +1608,7 @@ static int vcn_v4_0_5_process_interrupt(struct amdgpu_device *adev, struct amdgp
 		ip_instance = 1;
 		break;
 	default:
-		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+		drm_err(adev_to_drm(adev), "Unhandled client id: %d\n", entry->client_id);
 		return 0;
 	}
 
@@ -1622,7 +1622,7 @@ static int vcn_v4_0_5_process_interrupt(struct amdgpu_device *adev, struct amdgp
 		amdgpu_vcn_process_poison_irq(adev, source, entry);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index d99d05f42f1d9..b9887ce4bde9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -123,7 +123,7 @@ void vcn_v5_0_0_alloc_ip_dump(struct amdgpu_device *adev)
 	/* Allocate memory for VCN IP Dump buffer */
 	ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (!ptr) {
-		DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
+		drm_err(adev_to_drm(adev), "Failed to allocate memory for VCN IP Dump\n");
 		adev->vcn.ip_dump = NULL;
 	} else {
 		adev->vcn.ip_dump = ptr;
@@ -892,7 +892,7 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 			if (status & 2)
 				break;
 
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
 			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
 				 UVD_VCPU_CNTL__BLK_RST_MASK,
@@ -907,7 +907,7 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *vinst)
 	}
 
 	if (r) {
-		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
+		drm_err(adev_to_drm(adev), "VCN[%d] is not responding, giving up!!!\n", i);
 		return r;
 	}
 
@@ -1124,7 +1124,7 @@ static uint64_t vcn_v5_0_0_unified_ring_get_rptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	return RREG32_SOC15(VCN, ring->me, regUVD_RB_RPTR);
 }
@@ -1141,7 +1141,7 @@ static uint64_t vcn_v5_0_0_unified_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
 		return *ring->wptr_cpu_addr;
@@ -1161,7 +1161,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
 		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
@@ -1341,7 +1341,7 @@ static int vcn_v5_0_0_process_interrupt(struct amdgpu_device *adev, struct amdgp
 		ip_instance = 1;
 		break;
 	default:
-		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
+		drm_err(adev_to_drm(adev), "Unhandled client id: %d\n", entry->client_id);
 		return 0;
 	}
 
@@ -1355,7 +1355,7 @@ static int vcn_v5_0_0_process_interrupt(struct amdgpu_device *adev, struct amdgp
 		amdgpu_vcn_process_poison_irq(adev, source, entry);
 		break;
 	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
+		drm_err(adev_to_drm(adev), "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 581d8629b9d95..c97d3de17e84f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -702,7 +702,7 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 			if (status & 2)
 				break;
 
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
 			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
 				 UVD_VCPU_CNTL__BLK_RST_MASK,
@@ -717,7 +717,7 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 	}
 
 	if (r) {
-		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
+		drm_err(adev_to_drm(adev), "VCN[%d] is not responding, giving up!!!\n", i);
 		return r;
 	}
 
@@ -879,7 +879,7 @@ static uint64_t vcn_v5_0_1_unified_ring_get_rptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	return RREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_RPTR);
 }
@@ -896,7 +896,7 @@ static uint64_t vcn_v5_0_1_unified_ring_get_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell)
 		return *ring->wptr_cpu_addr;
@@ -916,7 +916,7 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
-		DRM_ERROR("wrong ring id is identified in %s", __func__);
+		drm_err(adev_to_drm(adev), "wrong ring id is identified in %s", __func__);
 
 	if (ring->use_doorbell) {
 		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index eb16916c64738..31a120734d672 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -110,7 +110,7 @@ static int vega10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
+			drm_err(adev_to_drm(adev), "PSP program IH_RB_CNTL failed!\n");
 			return -ETIMEDOUT;
 		}
 	} else {
@@ -225,7 +225,7 @@ static int vega10_ih_enable_ring(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
+			drm_err(adev_to_drm(adev), "PSP program IH_RB_CNTL failed!\n");
 			return -ETIMEDOUT;
 		}
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index faa0dd75dd6d5..ff97cd7fede0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -146,7 +146,7 @@ static int vega20_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
+			drm_err(adev_to_drm(adev), "PSP program IH_RB_CNTL failed!\n");
 			return -ETIMEDOUT;
 		}
 	} else {
@@ -261,7 +261,7 @@ static int vega20_ih_enable_ring(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
-			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
+			drm_err(adev_to_drm(adev), "PSP program IH_RB_CNTL failed!\n");
 			return -ETIMEDOUT;
 		}
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 86d8bc10d90ab..4cd01bb4a93ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -915,7 +915,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
 		return amdgpu_reset_method;
 
 	if (amdgpu_reset_method != -1)
-		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
+		drm_warn(adev_to_drm(adev), "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
 	switch (adev->asic_type) {
@@ -956,10 +956,10 @@ static int vi_asic_reset(struct amdgpu_device *adev)
 		return 0;
 
 	if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		dev_info(adev->dev, "BACO reset\n");
+		drm_info(adev_to_drm(adev), "BACO reset\n");
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
-		dev_info(adev->dev, "PCI CONFIG reset\n");
+		drm_info(adev_to_drm(adev), "PCI CONFIG reset\n");
 		r = vi_asic_pci_config_reset(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
index 45876883bbf37..226f3218e3478 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -149,7 +149,7 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 	vpe_v6_1_set_collaborate_mode(vpe, true);
 	/* setup DPM */
 	if (amdgpu_vpe_configure_dpm(vpe))
-		dev_warn(adev->dev, "VPE failed to enable DPM\n");
+		drm_warn(adev_to_drm(adev), "VPE failed to enable DPM\n");
 
 	/*
 	 * For VPE 6.1.1, still only need to add master's offset, and psp will apply it to slave as well.
@@ -298,7 +298,7 @@ static int vpe_v_6_1_ring_stop(struct amdgpu_vpe *vpe)
 		}
 
 		if (ret)
-			dev_err(adev->dev, "VPE queue reset failed\n");
+			drm_err(adev_to_drm(adev), "VPE queue reset failed\n");
 	}
 
 	vpe->ring.sched.ready = false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba99e0f258aee..171c4420c665a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -364,7 +364,7 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 			&pdd->proc_ctx_cpu_ptr,
 			false);
 		if (r) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 			"failed to allocate process context bo\n");
 			return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b9c82be6ce134..8b4e23e5bf4b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -736,7 +736,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	kfd->num_nodes = amdgpu_xcp_get_num_xcp(kfd->adev->xcp_mgr);
 
 	if (kfd->num_nodes == 0) {
-		dev_err(kfd_device,
+		drm_err(adev_to_drm(kfd->adev),
 			"KFD num nodes cannot be 0, num_xcc_in_node: %d\n",
 			kfd->adev->gfx.num_xcc_per_xcp);
 		goto out;
@@ -751,7 +751,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	    kfd->device_info.needs_pci_atomics &&
 	    (!kfd->device_info.no_atomic_fw_version ||
 	     kfd->mec_fw_version < kfd->device_info.no_atomic_fw_version)) {
-		dev_info(kfd_device,
+		drm_info(adev_to_drm(kfd->adev),
 			 "skipped device %x:%x, PCI rejects atomics %d<%d\n",
 			 kfd->adev->pdev->vendor, kfd->adev->pdev->device,
 			 kfd->mec_fw_version,
@@ -813,20 +813,20 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			kfd->adev, size, &kfd->gtt_mem,
 			&kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
 			false)) {
-		dev_err(kfd_device, "Could not allocate %d bytes\n", size);
+		drm_err(adev_to_drm(kfd->adev), "Could not allocate %d bytes\n", size);
 		goto alloc_gtt_mem_failure;
 	}
 
-	dev_info(kfd_device, "Allocated %d bytes on gart\n", size);
+	drm_info(adev_to_drm(kfd->adev), "Allocated %d bytes on gart\n", size);
 
 	/* Initialize GTT sa with 512 byte chunk size */
 	if (kfd_gtt_sa_init(kfd, size, 512) != 0) {
-		dev_err(kfd_device, "Error initializing gtt sub-allocator\n");
+		drm_err(adev_to_drm(kfd->adev), "Error initializing gtt sub-allocator\n");
 		goto kfd_gtt_sa_init_error;
 	}
 
 	if (kfd_doorbell_init(kfd)) {
-		dev_err(kfd_device,
+		drm_err(adev_to_drm(kfd->adev),
 			"Error initializing doorbell aperture\n");
 		goto kfd_doorbell_error;
 	}
@@ -847,8 +847,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	kfd_cwsr_init(kfd);
 
-	dev_info(kfd_device, "Total number of KFD nodes to be created: %d\n",
-				kfd->num_nodes);
+	drm_info(adev_to_drm(kfd->adev), "Total number of KFD nodes to be created: %d\n",
+		 kfd->num_nodes);
 
 	/* Allocate the KFD nodes */
 	for (i = 0, xcp_idx = 0; i < kfd->num_nodes; i++) {
@@ -873,7 +873,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		}
 
 		if (node->xcp) {
-			dev_info(kfd_device, "KFD node %d partition %d size %lldM\n",
+			drm_info(adev_to_drm(kfd->adev),
+				"KFD node %d partition %d size %lldM\n",
 				node->node_id, node->xcp->mem_id,
 				KFD_XCP_MEMORY_SIZE(node->adev, node->node_id) >> 20);
 		}
@@ -911,7 +912,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 		/* Initialize the KFD node */
 		if (kfd_init_node(node)) {
-			dev_err(kfd_device, "Error initializing KFD node\n");
+			drm_err(adev_to_drm(kfd->adev), "Error initializing KFD node\n");
 			goto node_init_error;
 		}
 
@@ -923,10 +924,10 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	svm_range_set_max_pages(kfd->adev);
 
 	kfd->init_complete = true;
-	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
+	drm_info(adev_to_drm(kfd->adev), "added device %x:%x to kfd\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
 
-	pr_debug("Starting kfd with the following scheduling policy %d\n",
+	drm_dbg(adev_to_drm(kfd->adev), "Starting kfd with the following scheduling policy %d\n",
 		node->dqm->sched_policy);
 
 	goto out;
@@ -940,7 +941,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_gtt_sa_init_error:
 	amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 alloc_gtt_mem_failure:
-	dev_err(kfd_device,
+	drm_err(adev_to_drm(kfd->adev),
 		"device %x:%x NOT added due to errors\n",
 		kfd->adev->pdev->vendor, kfd->adev->pdev->device);
 out:
@@ -1078,7 +1079,7 @@ static int kfd_resume(struct kfd_node *node)
 
 	err = node->dqm->ops.start(node->dqm);
 	if (err)
-		dev_err(kfd_device,
+		drm_err(adev_to_drm(node->adev),
 			"Error starting queue manager for device %x:%x\n",
 			node->adev->pdev->vendor, node->adev->pdev->device);
 
@@ -1097,7 +1098,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 		return;
 
 	if (kfd->device_info.ih_ring_entry_size > sizeof(patched_ihre)) {
-		dev_err_once(kfd_device, "Ring entry too small\n");
+		drm_err_once(adev_to_drm(kfd->adev), "Ring entry too small\n");
 		return;
 	}
 
@@ -1226,7 +1227,8 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 	if (!kfd->gtt_sa_bitmap)
 		return -ENOMEM;
 
-	pr_debug("gtt_sa_num_of_chunks = %d, gtt_sa_bitmap = %p\n",
+	drm_dbg(adev_to_drm(kfd->adev),
+		"gtt_sa_num_of_chunks = %d, gtt_sa_bitmap = %p\n",
 			kfd->gtt_sa_num_of_chunks, kfd->gtt_sa_bitmap);
 
 	mutex_init(&kfd->gtt_sa_lock);
@@ -1270,7 +1272,7 @@ int kfd_gtt_sa_allocate(struct kfd_node *node, unsigned int size,
 	if (!(*mem_obj))
 		return -ENOMEM;
 
-	pr_debug("Allocated mem_obj = %p for size = %d\n", *mem_obj, size);
+	drm_dbg(adev_to_drm(node->adev), "Allocated mem_obj = %p for size = %d\n", *mem_obj, size);
 
 	start_search = 0;
 
@@ -1282,7 +1284,7 @@ int kfd_gtt_sa_allocate(struct kfd_node *node, unsigned int size,
 					kfd->gtt_sa_num_of_chunks,
 					start_search);
 
-	pr_debug("Found = %d\n", found);
+	drm_dbg(adev_to_drm(node->adev), "Found = %d\n", found);
 
 	/* If there wasn't any free chunk, bail out */
 	if (found == kfd->gtt_sa_num_of_chunks)
@@ -1300,12 +1302,12 @@ int kfd_gtt_sa_allocate(struct kfd_node *node, unsigned int size,
 					found,
 					kfd->gtt_sa_chunk_size);
 
-	pr_debug("gpu_addr = %p, cpu_addr = %p\n",
+	drm_dbg(adev_to_drm(node->adev), "gpu_addr = %p, cpu_addr = %p\n",
 			(uint64_t *) (*mem_obj)->gpu_addr, (*mem_obj)->cpu_ptr);
 
 	/* If we need only one chunk, mark it as allocated and get out */
 	if (size <= kfd->gtt_sa_chunk_size) {
-		pr_debug("Single bit\n");
+		drm_dbg(adev_to_drm(node->adev), "Single bit\n");
 		__set_bit(found, kfd->gtt_sa_bitmap);
 		goto kfd_gtt_out;
 	}
@@ -1340,7 +1342,7 @@ int kfd_gtt_sa_allocate(struct kfd_node *node, unsigned int size,
 
 	} while (cur_size > 0);
 
-	pr_debug("range_start = %d, range_end = %d\n",
+	drm_dbg(adev_to_drm(node->adev), "range_start = %d, range_end = %d\n",
 		(*mem_obj)->range_start, (*mem_obj)->range_end);
 
 	/* Mark the chunks as allocated */
@@ -1352,7 +1354,7 @@ int kfd_gtt_sa_allocate(struct kfd_node *node, unsigned int size,
 	return 0;
 
 kfd_gtt_no_free_chunk:
-	pr_debug("Allocation failed with mem_obj = %p\n", *mem_obj);
+	drm_dbg(adev_to_drm(node->adev), "Allocation failed with mem_obj = %p\n", *mem_obj);
 	mutex_unlock(&kfd->gtt_sa_lock);
 	kfree(*mem_obj);
 	return -ENOMEM;
@@ -1366,7 +1368,7 @@ int kfd_gtt_sa_free(struct kfd_node *node, struct kfd_mem_obj *mem_obj)
 	if (!mem_obj)
 		return 0;
 
-	pr_debug("Free mem_obj = %p, range_start = %d, range_end = %d\n",
+	drm_dbg(adev_to_drm(node->adev), "Free mem_obj = %p, range_start = %d, range_end = %d\n",
 			mem_obj, mem_obj->range_start, mem_obj->range_end);
 
 	mutex_lock(&kfd->gtt_sa_lock);
@@ -1477,7 +1479,7 @@ int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id)
 		return 0;
 
 	if (node_id >= kfd->num_nodes) {
-		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
+		drm_warn(adev_to_drm(kfd->adev), "Invalid node ID: %u exceeds %u\n",
 			 node_id, kfd->num_nodes - 1);
 		return -EINVAL;
 	}
@@ -1485,7 +1487,7 @@ int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id)
 
 	ret = node->dqm->ops.unhalt(node->dqm);
 	if (ret)
-		dev_err(kfd_device, "Error in starting scheduler\n");
+		drm_err(adev_to_drm(kfd->adev), "Error in starting scheduler\n");
 
 	return ret;
 }
@@ -1498,7 +1500,7 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
 		return 0;
 
 	if (node_id >= kfd->num_nodes) {
-		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
+		drm_warn(adev_to_drm(kfd->adev), "Invalid node ID: %u exceeds %u\n",
 			 node_id, kfd->num_nodes - 1);
 		return -EINVAL;
 	}
@@ -1515,7 +1517,7 @@ bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id)
 		return false;
 
 	if (node_id >= kfd->num_nodes) {
-		dev_warn(kfd->adev->dev, "Invalid node ID: %u exceeds %u\n",
+		drm_warn(adev_to_drm(kfd->adev), "Invalid node ID: %u exceeds %u\n",
 			 node_id, kfd->num_nodes - 1);
 		return false;
 	}
@@ -1600,12 +1602,12 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu_iv_entr
 int kfd_debugfs_hang_hws(struct kfd_node *dev)
 {
 	if (dev->dqm->sched_policy != KFD_SCHED_POLICY_HWS) {
-		pr_err("HWS is not enabled");
+		drm_err(adev_to_drm(dev->adev), "HWS is not enabled");
 		return -EINVAL;
 	}
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		dev_err(dev->adev->dev, "Inducing MES hang is not supported\n");
+		drm_err(adev_to_drm(dev->adev), "Inducing MES hang is not supported\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c610e172a2b83..fcf3f76393ce5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -246,7 +246,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 
 	queue_type = convert_to_mes_queue_type(q->properties.type);
 	if (queue_type < 0) {
-		dev_err(adev->dev, "Queue type not supported with MES, queue:%d\n",
+		drm_err(adev_to_drm(adev), "Queue type not supported with MES, queue:%d\n",
 			q->properties.type);
 		up_read(&adev->reset_domain->sem);
 		return -EINVAL;
@@ -260,9 +260,9 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	amdgpu_mes_unlock(&adev->mes);
 	up_read(&adev->reset_domain->sem);
 	if (r) {
-		dev_err(adev->dev, "failed to add hardware queue to MES, doorbell=0x%x\n",
+		drm_err(adev_to_drm(adev), "failed to add hardware queue to MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
-		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+		drm_err(adev_to_drm(adev), "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
 	}
 
@@ -291,9 +291,9 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
-		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
+		drm_err(adev_to_drm(adev), "failed to remove hardware queue from MES, doorbell=0x%x\n",
 			q->properties.doorbell_off);
-		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+		drm_err(adev_to_drm(adev), "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
 	}
 
@@ -366,8 +366,8 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
-		dev_err(adev->dev, "failed to suspend gangs from MES\n");
-		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+		drm_err(adev_to_drm(adev), "failed to suspend gangs from MES\n");
+		drm_err(adev_to_drm(adev), "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
 	}
 
@@ -386,8 +386,8 @@ static int resume_all_queues_mes(struct device_queue_manager *dqm)
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
-		dev_err(adev->dev, "failed to resume gangs from MES\n");
-		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+		drm_err(adev_to_drm(adev), "failed to resume gangs from MES\n");
+		drm_err(adev_to_drm(adev), "MES might be in unrecoverable state, issue a GPU reset\n");
 		kfd_hws_hang(dqm);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 05c74887fd6fd..72c4463dabcbb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -74,7 +74,7 @@ int kfd_doorbell_init(struct kfd_dev *kfd)
 	/* Bitmap to dynamically allocate doorbells from kernel page */
 	kfd->doorbell_bitmap = bitmap_zalloc(size / sizeof(u32), GFP_KERNEL);
 	if (!kfd->doorbell_bitmap) {
-		DRM_ERROR("Failed to allocate kernel doorbell bitmap\n");
+		drm_err(adev_to_drm(kfd->adev), "Failed to allocate kernel doorbell bitmap\n");
 		return -ENOMEM;
 	}
 
@@ -87,12 +87,12 @@ int kfd_doorbell_init(struct kfd_dev *kfd)
 				    NULL,
 				    (void **)&kfd->doorbell_kernel_ptr);
 	if (r) {
-		pr_err("failed to allocate kernel doorbells\n");
+		drm_err(adev_to_drm(kfd->adev), "failed to allocate kernel doorbells\n");
 		bitmap_free(kfd->doorbell_bitmap);
 		return r;
 	}
 
-	pr_debug("Doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
+	drm_dbg(adev_to_drm(kfd->adev), "Doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
 	return 0;
 }
 
@@ -259,13 +259,13 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
 					     GFP_KERNEL);
 	if (!qpd->doorbell_bitmap) {
-		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
+		drm_err(adev_to_drm(kfd->adev), "Failed to allocate process doorbell bitmap\n");
 		return -ENOMEM;
 	}
 
 	r = init_doorbell_bitmap(&pdd->qpd, kfd);
 	if (r) {
-		DRM_ERROR("Failed to initialize process doorbells\n");
+		drm_err(adev_to_drm(kfd->adev), "Failed to initialize process doorbells\n");
 		r = -ENOMEM;
 		goto err;
 	}
@@ -279,7 +279,7 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 				    NULL,
 				    NULL);
 	if (r) {
-		DRM_ERROR("Failed to allocate process doorbells\n");
+		drm_err(adev_to_drm(kfd->adev), "Failed to allocate process doorbells\n");
 		goto err;
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 79251f22b7022..179cbd596bd40 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -148,14 +148,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
 			gart_d = svm_migrate_direct_mapping_addr(adev, *vram);
 		}
 		if (r) {
-			dev_err(adev->dev, "fail %d create gart mapping\n", r);
+			drm_err(adev_to_drm(adev), "fail %d create gart mapping\n", r);
 			goto out_unlock;
 		}
 
 		r = amdgpu_copy_buffer(ring, gart_s, gart_d, size * PAGE_SIZE,
 				       NULL, &next, false, true, 0);
 		if (r) {
-			dev_err(adev->dev, "fail %d to copy memory\n", r);
+			drm_err(adev_to_drm(adev), "fail %d to copy memory\n", r);
 			goto out_unlock;
 		}
 
@@ -424,7 +424,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
-		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
+		drm_err(adev_to_drm(adev), "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
 			__func__, r, prange->start, prange->last);
 		goto out_free;
 	}
@@ -638,7 +638,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
-			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
+			drm_err(adev_to_drm(adev), "%s: fail %d dma_map_page\n", __func__, r);
 			goto out_oom;
 		}
 
@@ -727,7 +727,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
 
 	r = migrate_vma_setup(&migrate);
 	if (r) {
-		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
+		drm_err(adev_to_drm(adev), "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
 			__func__, r, prange->start, prange->last);
 		goto out_free;
 	}
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9f5768fa97dd0..4edd1e3a85258 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -605,7 +605,7 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable, 0);
 	if (ret)
-		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+		drm_err(adev_to_drm(adev), "Dpm %s uvd failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
 }
 
@@ -615,7 +615,7 @@ void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, inst);
 	if (ret)
-		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+		drm_err(adev_to_drm(adev), "Dpm %s uvd failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
 }
 
@@ -640,7 +640,7 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable, 0);
 	if (ret)
-		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
+		drm_err(adev_to_drm(adev), "Dpm %s vce failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
 }
 
@@ -650,7 +650,7 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable, 0);
 	if (ret)
-		DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
+		drm_err(adev_to_drm(adev), "Dpm %s jpeg failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
 }
 
@@ -660,7 +660,7 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VPE, !enable, 0);
 	if (ret)
-		DRM_ERROR("Dpm %s vpe failed, ret = %d.\n",
+		drm_err(adev_to_drm(adev), "Dpm %s vpe failed, ret = %d.\n",
 			  enable ? "enable" : "disable", ret);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 922def51685b0..8d0a102c787c9 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2424,7 +2424,7 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 
 	ret = attr_update(adev, attr, mask, &attr_states);
 	if (ret) {
-		dev_err(adev->dev, "failed to update device file %s, ret = %d\n",
+		drm_err(adev_to_drm(adev), "failed to update device file %s, ret = %d\n",
 			name, ret);
 		return ret;
 	}
@@ -2434,7 +2434,7 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 
 	ret = device_create_file(adev->dev, dev_attr);
 	if (ret) {
-		dev_err(adev->dev, "failed to create device file %s, ret = %d\n",
+		drm_err(adev_to_drm(adev), "failed to create device file %s, ret = %d\n",
 			name, ret);
 	}
 
@@ -4387,7 +4387,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 									hwmon_groups);
 		if (IS_ERR(adev->pm.int_hwmon_dev)) {
 			ret = PTR_ERR(adev->pm.int_hwmon_dev);
-			dev_err(adev->dev, "Unable to register hwmon device: %d\n", ret);
+			drm_err(adev_to_drm(adev), "Unable to register hwmon device: %d\n", ret);
 			return ret;
 		}
 	}
@@ -4418,7 +4418,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		if (ret)
 			goto err_out1;
 	} else if (adev->pm.pp_feature & PP_OVERDRIVE_MASK) {
-		dev_info(adev->dev, "overdrive feature is not supported\n");
+		drm_info(adev_to_drm(adev), "overdrive feature is not supported\n");
 	}
 
 	if (amdgpu_dpm_get_pm_policy_info(adev, PP_PM_POLICY_NONE, NULL) !=
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 59fae668dc3f6..4cc9feca73c75 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1242,7 +1242,7 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
 	if (pi->bapm_enable) {
 		ret = amdgpu_kv_smc_bapm_enable(adev, enable);
 		if (ret)
-			DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+			drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
 	}
 }
 
@@ -1266,40 +1266,40 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 
 	ret = kv_process_firmware_header(adev);
 	if (ret) {
-		DRM_ERROR("kv_process_firmware_header failed\n");
+		drm_err(adev_to_drm(adev), "kv_process_firmware_header failed\n");
 		return ret;
 	}
 	kv_init_fps_limits(adev);
 	kv_init_graphics_levels(adev);
 	ret = kv_program_bootup_state(adev);
 	if (ret) {
-		DRM_ERROR("kv_program_bootup_state failed\n");
+		drm_err(adev_to_drm(adev), "kv_program_bootup_state failed\n");
 		return ret;
 	}
 	kv_calculate_dfs_bypass_settings(adev);
 	ret = kv_upload_dpm_settings(adev);
 	if (ret) {
-		DRM_ERROR("kv_upload_dpm_settings failed\n");
+		drm_err(adev_to_drm(adev), "kv_upload_dpm_settings failed\n");
 		return ret;
 	}
 	ret = kv_populate_uvd_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_uvd_table failed\n");
+		drm_err(adev_to_drm(adev), "kv_populate_uvd_table failed\n");
 		return ret;
 	}
 	ret = kv_populate_vce_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_vce_table failed\n");
+		drm_err(adev_to_drm(adev), "kv_populate_vce_table failed\n");
 		return ret;
 	}
 	ret = kv_populate_samu_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_samu_table failed\n");
+		drm_err(adev_to_drm(adev), "kv_populate_samu_table failed\n");
 		return ret;
 	}
 	ret = kv_populate_acp_table(adev);
 	if (ret) {
-		DRM_ERROR("kv_populate_acp_table failed\n");
+		drm_err(adev_to_drm(adev), "kv_populate_acp_table failed\n");
 		return ret;
 	}
 	kv_program_vc(adev);
@@ -1310,39 +1310,39 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 	if (pi->enable_auto_thermal_throttling) {
 		ret = kv_enable_auto_thermal_throttling(adev);
 		if (ret) {
-			DRM_ERROR("kv_enable_auto_thermal_throttling failed\n");
+			drm_err(adev_to_drm(adev), "kv_enable_auto_thermal_throttling failed\n");
 			return ret;
 		}
 	}
 	ret = kv_enable_dpm_voltage_scaling(adev);
 	if (ret) {
-		DRM_ERROR("kv_enable_dpm_voltage_scaling failed\n");
+		drm_err(adev_to_drm(adev), "kv_enable_dpm_voltage_scaling failed\n");
 		return ret;
 	}
 	ret = kv_set_dpm_interval(adev);
 	if (ret) {
-		DRM_ERROR("kv_set_dpm_interval failed\n");
+		drm_err(adev_to_drm(adev), "kv_set_dpm_interval failed\n");
 		return ret;
 	}
 	ret = kv_set_dpm_boot_state(adev);
 	if (ret) {
-		DRM_ERROR("kv_set_dpm_boot_state failed\n");
+		drm_err(adev_to_drm(adev), "kv_set_dpm_boot_state failed\n");
 		return ret;
 	}
 	ret = kv_enable_ulv(adev, true);
 	if (ret) {
-		DRM_ERROR("kv_enable_ulv failed\n");
+		drm_err(adev_to_drm(adev), "kv_enable_ulv failed\n");
 		return ret;
 	}
 	kv_start_dpm(adev);
 	ret = kv_enable_didt(adev, true);
 	if (ret) {
-		DRM_ERROR("kv_enable_didt failed\n");
+		drm_err(adev_to_drm(adev), "kv_enable_didt failed\n");
 		return ret;
 	}
 	ret = kv_enable_smc_cac(adev, true);
 	if (ret) {
-		DRM_ERROR("kv_enable_smc_cac failed\n");
+		drm_err(adev_to_drm(adev), "kv_enable_smc_cac failed\n");
 		return ret;
 	}
 
@@ -1350,7 +1350,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 
 	ret = amdgpu_kv_smc_bapm_enable(adev, false);
 	if (ret) {
-		DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+		drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
 		return ret;
 	}
 
@@ -1358,7 +1358,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 	    kv_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
 		ret = kv_set_thermal_temperature_range(adev, KV_TEMP_RANGE_MIN, KV_TEMP_RANGE_MAX);
 		if (ret) {
-			DRM_ERROR("kv_set_thermal_temperature_range failed\n");
+			drm_err(adev_to_drm(adev), "kv_set_thermal_temperature_range failed\n");
 			return ret;
 		}
 		amdgpu_irq_get(adev, &adev->pm.dpm.thermal.irq,
@@ -1382,7 +1382,7 @@ static void kv_dpm_disable(struct amdgpu_device *adev)
 
 	err = amdgpu_kv_smc_bapm_enable(adev, false);
 	if (err)
-		DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+		drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
 
 	if (adev->asic_type == CHIP_MULLINS)
 		kv_enable_nb_dpm(adev, false);
@@ -1920,7 +1920,7 @@ static int kv_dpm_set_power_state(void *handle)
 	if (pi->bapm_enable) {
 		ret = amdgpu_kv_smc_bapm_enable(adev, adev->pm.ac_power);
 		if (ret) {
-			DRM_ERROR("amdgpu_kv_smc_bapm_enable failed\n");
+			drm_err(adev_to_drm(adev), "amdgpu_kv_smc_bapm_enable failed\n");
 			return ret;
 		}
 	}
@@ -1931,7 +1931,7 @@ static int kv_dpm_set_power_state(void *handle)
 			kv_update_dfs_bypass_settings(adev, new_ps);
 			ret = kv_calculate_ds_divider(adev);
 			if (ret) {
-				DRM_ERROR("kv_calculate_ds_divider failed\n");
+				drm_err(adev_to_drm(adev), "kv_calculate_ds_divider failed\n");
 				return ret;
 			}
 			kv_calculate_nbps_level_settings(adev);
@@ -1947,7 +1947,7 @@ static int kv_dpm_set_power_state(void *handle)
 
 			ret = kv_update_vce_dpm(adev, new_ps, old_ps);
 			if (ret) {
-				DRM_ERROR("kv_update_vce_dpm failed\n");
+				drm_err(adev_to_drm(adev), "kv_update_vce_dpm failed\n");
 				return ret;
 			}
 			kv_update_sclk_t(adev);
@@ -1960,7 +1960,7 @@ static int kv_dpm_set_power_state(void *handle)
 			kv_update_dfs_bypass_settings(adev, new_ps);
 			ret = kv_calculate_ds_divider(adev);
 			if (ret) {
-				DRM_ERROR("kv_calculate_ds_divider failed\n");
+				drm_err(adev_to_drm(adev), "kv_calculate_ds_divider failed\n");
 				return ret;
 			}
 			kv_calculate_nbps_level_settings(adev);
@@ -1972,7 +1972,7 @@ static int kv_dpm_set_power_state(void *handle)
 			kv_set_enabled_levels(adev);
 			ret = kv_update_vce_dpm(adev, new_ps, old_ps);
 			if (ret) {
-				DRM_ERROR("kv_update_vce_dpm failed\n");
+				drm_err(adev_to_drm(adev), "kv_update_vce_dpm failed\n");
 				return ret;
 			}
 			kv_update_acp_boot_level(adev);
@@ -2521,7 +2521,7 @@ static int kv_set_thermal_temperature_range(struct amdgpu_device *adev,
 	if (high_temp > max_temp)
 		high_temp = max_temp;
 	if (high_temp < low_temp) {
-		DRM_ERROR("invalid thermal range: %d - %d\n", low_temp, high_temp);
+		drm_err(adev_to_drm(adev), "invalid thermal range: %d - %d\n", low_temp, high_temp);
 		return -EINVAL;
 	}
 
@@ -2563,7 +2563,7 @@ static int kv_parse_sys_info_table(struct amdgpu_device *adev)
 					      data_offset);
 
 		if (crev != 8) {
-			DRM_ERROR("Unsupported IGP table: %d %d\n", frev, crev);
+			drm_err(adev_to_drm(adev), "Unsupported IGP table: %d %d\n", frev, crev);
 			return -EINVAL;
 		}
 		pi->sys_info.bootup_sclk = le32_to_cpu(igp_info->info_8.ulBootUpEngineClock);
@@ -2579,7 +2579,7 @@ static int kv_parse_sys_info_table(struct amdgpu_device *adev)
 		else
 			pi->sys_info.htc_hyst_lmt = igp_info->info_8.ucHtcHystLmt;
 		if (pi->sys_info.htc_tmp_lmt <= pi->sys_info.htc_hyst_lmt) {
-			DRM_ERROR("The htcTmpLmt should be larger than htcHystLmt.\n");
+			drm_err(adev_to_drm(adev), "The htcTmpLmt should be larger than htcHystLmt.\n");
 		}
 
 		if (le32_to_cpu(igp_info->info_8.ulSystemConfig) & (1 << 3))
@@ -3013,13 +3013,13 @@ static int kv_dpm_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
 	if (amdgpu_dpm == 1)
 		amdgpu_pm_print_power_states(adev);
-	DRM_INFO("amdgpu: dpm initialized\n");
+	drm_info(adev_to_drm(adev), "amdgpu: dpm initialized\n");
 
 	return 0;
 
 dpm_failed:
 	kv_dpm_fini(adev);
-	DRM_ERROR("amdgpu: dpm initialization failed\n");
+	drm_err(adev_to_drm(adev), "amdgpu: dpm initialization failed\n");
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index c7518b13e7879..7a33eaf9683d0 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -699,64 +699,64 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
 			adev->pm.fan_max_rpm = controller->ucFanMaxRPM;
 		}
 		if (controller->ucType == ATOM_PP_THERMALCONTROLLER_RV6xx) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_RV6XX;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_RV770) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_RV770;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_EVERGREEN) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_EVERGREEN;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_SUMO) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_SUMO;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_NISLANDS) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_NI;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_SISLANDS) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_SI;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_CISLANDS) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_CI;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_KAVERI) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_KV;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_EXTERNAL_GPIO) {
-			DRM_INFO("External GPIO thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "External GPIO thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_EXTERNAL_GPIO;
 		} else if (controller->ucType ==
 			   ATOM_PP_THERMALCONTROLLER_ADT7473_WITH_INTERNAL) {
-			DRM_INFO("ADT7473 with internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "ADT7473 with internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_ADT7473_WITH_INTERNAL;
 		} else if (controller->ucType ==
 			   ATOM_PP_THERMALCONTROLLER_EMC2103_WITH_INTERNAL) {
-			DRM_INFO("EMC2103 with internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "EMC2103 with internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_EMC2103_WITH_INTERNAL;
 		} else if (controller->ucType < ARRAY_SIZE(pp_lib_thermal_controller_names)) {
-			DRM_INFO("Possible %s thermal controller at 0x%02x %s fan control\n",
+			drm_info(adev_to_drm(adev), "Possible %s thermal controller at 0x%02x %s fan control\n",
 				 pp_lib_thermal_controller_names[controller->ucType],
 				 controller->ucI2cAddress >> 1,
 				 (controller->ucFanParameters &
@@ -772,7 +772,7 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
 				i2c_new_client_device(&adev->pm.i2c_bus->adapter, &info);
 			}
 		} else {
-			DRM_INFO("Unknown thermal controller type %d at 0x%02x %s fan control\n",
+			drm_info(adev_to_drm(adev), "Unknown thermal controller type %d at 0x%02x %s fan control\n",
 				 controller->ucType,
 				 controller->ucI2cAddress >> 1,
 				 (controller->ucFanParameters &
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index c5db5cb8c44fa..5a3841db894e8 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -1963,7 +1963,7 @@ static void si_update_dte_from_pl2(struct amdgpu_device *adev,
 			dte_data->tdep_r[i] = dte_data->r[4];
 		}
 	} else {
-		DRM_ERROR("Invalid PL2! DTE will not be updated.\n");
+		drm_err(adev_to_drm(adev), "Invalid PL2! DTE will not be updated.\n");
 	}
 }
 
@@ -2025,7 +2025,7 @@ static void si_initialize_powertune_defaults(struct amdgpu_device *adev)
 			break;
 		default:
 			if (si_pi->dte_data.enable_dte_by_default == true)
-				DRM_ERROR("DTE is not enabled!\n");
+				drm_err(adev_to_drm(adev), "DTE is not enabled!\n");
 			break;
 		}
 	} else if (adev->asic_type == CHIP_PITCAIRN) {
@@ -2153,7 +2153,7 @@ static void si_initialize_powertune_defaults(struct amdgpu_device *adev)
 		si_pi->dte_data = dte_data_sun_xt;
 		update_dte_from_pl2 = true;
 	} else {
-		DRM_ERROR("Unknown SI asic revision, failed to initialize PowerTune!\n");
+		drm_err(adev_to_drm(adev), "Unknown SI asic revision, failed to initialize PowerTune!\n");
 		return;
 	}
 
@@ -6390,15 +6390,15 @@ static int si_patch_dependency_tables_based_on_leakage(struct amdgpu_device *ade
 	ret = si_patch_single_dependency_table_based_on_leakage(adev,
 								&adev->pm.dpm.dyn_state.vddc_dependency_on_sclk);
 	if (ret)
-		DRM_ERROR("Could not patch vddc_on_sclk leakage table\n");
+		drm_err(adev_to_drm(adev), "Could not patch vddc_on_sclk leakage table\n");
 	ret = si_patch_single_dependency_table_based_on_leakage(adev,
 								&adev->pm.dpm.dyn_state.vddc_dependency_on_mclk);
 	if (ret)
-		DRM_ERROR("Could not patch vddc_on_mclk leakage table\n");
+		drm_err(adev_to_drm(adev), "Could not patch vddc_on_mclk leakage table\n");
 	ret = si_patch_single_dependency_table_based_on_leakage(adev,
 								&adev->pm.dpm.dyn_state.vddci_dependency_on_mclk);
 	if (ret)
-		DRM_ERROR("Could not patch vddci_on_mclk leakage table\n");
+		drm_err(adev_to_drm(adev), "Could not patch vddci_on_mclk leakage table\n");
 	return ret;
 }
 
@@ -6459,7 +6459,7 @@ static int si_thermal_set_temperature_range(struct amdgpu_device *adev,
 	if (high_temp > max_temp)
 		high_temp = max_temp;
 	if (high_temp < low_temp) {
-		DRM_ERROR("invalid thermal range: %d - %d\n", low_temp, high_temp);
+		drm_err(adev_to_drm(adev), "invalid thermal range: %d - %d\n", low_temp, high_temp);
 		return -EINVAL;
 	}
 
@@ -6557,7 +6557,7 @@ static int si_thermal_setup_fan_table(struct amdgpu_device *adev)
 					  si_pi->sram_end);
 
 	if (ret) {
-		DRM_ERROR("Failed to load fan table to the SMC.");
+		drm_err(adev_to_drm(adev), "Failed to load fan table to the SMC.");
 		adev->pm.dpm.fan.ucode_fan_control = false;
 	}
 
@@ -6838,7 +6838,7 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	if (pi->voltage_control || si_pi->voltage_control_svi2) {
 		ret = si_construct_voltage_tables(adev);
 		if (ret) {
-			DRM_ERROR("si_construct_voltage_tables failed\n");
+			drm_err(adev_to_drm(adev), "si_construct_voltage_tables failed\n");
 			return ret;
 		}
 	}
@@ -6860,64 +6860,64 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	si_program_vc(adev);
 	ret = si_upload_firmware(adev);
 	if (ret) {
-		DRM_ERROR("si_upload_firmware failed\n");
+		drm_err(adev_to_drm(adev), "si_upload_firmware failed\n");
 		return ret;
 	}
 	ret = si_process_firmware_header(adev);
 	if (ret) {
-		DRM_ERROR("si_process_firmware_header failed\n");
+		drm_err(adev_to_drm(adev), "si_process_firmware_header failed\n");
 		return ret;
 	}
 	ret = si_initial_switch_from_arb_f0_to_f1(adev);
 	if (ret) {
-		DRM_ERROR("si_initial_switch_from_arb_f0_to_f1 failed\n");
+		drm_err(adev_to_drm(adev), "si_initial_switch_from_arb_f0_to_f1 failed\n");
 		return ret;
 	}
 	ret = si_init_smc_table(adev);
 	if (ret) {
-		DRM_ERROR("si_init_smc_table failed\n");
+		drm_err(adev_to_drm(adev), "si_init_smc_table failed\n");
 		return ret;
 	}
 	ret = si_init_smc_spll_table(adev);
 	if (ret) {
-		DRM_ERROR("si_init_smc_spll_table failed\n");
+		drm_err(adev_to_drm(adev), "si_init_smc_spll_table failed\n");
 		return ret;
 	}
 	ret = si_init_arb_table_index(adev);
 	if (ret) {
-		DRM_ERROR("si_init_arb_table_index failed\n");
+		drm_err(adev_to_drm(adev), "si_init_arb_table_index failed\n");
 		return ret;
 	}
 	if (eg_pi->dynamic_ac_timing) {
 		ret = si_populate_mc_reg_table(adev, boot_ps);
 		if (ret) {
-			DRM_ERROR("si_populate_mc_reg_table failed\n");
+			drm_err(adev_to_drm(adev), "si_populate_mc_reg_table failed\n");
 			return ret;
 		}
 	}
 	ret = si_initialize_smc_cac_tables(adev);
 	if (ret) {
-		DRM_ERROR("si_initialize_smc_cac_tables failed\n");
+		drm_err(adev_to_drm(adev), "si_initialize_smc_cac_tables failed\n");
 		return ret;
 	}
 	ret = si_initialize_hardware_cac_manager(adev);
 	if (ret) {
-		DRM_ERROR("si_initialize_hardware_cac_manager failed\n");
+		drm_err(adev_to_drm(adev), "si_initialize_hardware_cac_manager failed\n");
 		return ret;
 	}
 	ret = si_initialize_smc_dte_tables(adev);
 	if (ret) {
-		DRM_ERROR("si_initialize_smc_dte_tables failed\n");
+		drm_err(adev_to_drm(adev), "si_initialize_smc_dte_tables failed\n");
 		return ret;
 	}
 	ret = si_populate_smc_tdp_limits(adev, boot_ps);
 	if (ret) {
-		DRM_ERROR("si_populate_smc_tdp_limits failed\n");
+		drm_err(adev_to_drm(adev), "si_populate_smc_tdp_limits failed\n");
 		return ret;
 	}
 	ret = si_populate_smc_tdp_limits_2(adev, boot_ps);
 	if (ret) {
-		DRM_ERROR("si_populate_smc_tdp_limits_2 failed\n");
+		drm_err(adev_to_drm(adev), "si_populate_smc_tdp_limits_2 failed\n");
 		return ret;
 	}
 	si_program_response_times(adev);
@@ -6925,7 +6925,7 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	si_dpm_start_smc(adev);
 	ret = si_notify_smc_display_change(adev, false);
 	if (ret) {
-		DRM_ERROR("si_notify_smc_display_change failed\n");
+		drm_err(adev_to_drm(adev), "si_notify_smc_display_change failed\n");
 		return ret;
 	}
 	si_enable_sclk_control(adev, true);
@@ -7044,12 +7044,12 @@ static int si_dpm_set_power_state(void *handle)
 
 	ret = si_disable_ulv(adev);
 	if (ret) {
-		DRM_ERROR("si_disable_ulv failed\n");
+		drm_err(adev_to_drm(adev), "si_disable_ulv failed\n");
 		return ret;
 	}
 	ret = si_restrict_performance_levels_before_switch(adev);
 	if (ret) {
-		DRM_ERROR("si_restrict_performance_levels_before_switch failed\n");
+		drm_err(adev_to_drm(adev), "si_restrict_performance_levels_before_switch failed\n");
 		return ret;
 	}
 	if (eg_pi->pcie_performance_request)
@@ -7057,56 +7057,56 @@ static int si_dpm_set_power_state(void *handle)
 	ni_set_uvd_clock_before_set_eng_clock(adev, new_ps, old_ps);
 	ret = si_enable_power_containment(adev, new_ps, false);
 	if (ret) {
-		DRM_ERROR("si_enable_power_containment failed\n");
+		drm_err(adev_to_drm(adev), "si_enable_power_containment failed\n");
 		return ret;
 	}
 	ret = si_enable_smc_cac(adev, new_ps, false);
 	if (ret) {
-		DRM_ERROR("si_enable_smc_cac failed\n");
+		drm_err(adev_to_drm(adev), "si_enable_smc_cac failed\n");
 		return ret;
 	}
 	ret = si_halt_smc(adev);
 	if (ret) {
-		DRM_ERROR("si_halt_smc failed\n");
+		drm_err(adev_to_drm(adev), "si_halt_smc failed\n");
 		return ret;
 	}
 	ret = si_upload_sw_state(adev, new_ps);
 	if (ret) {
-		DRM_ERROR("si_upload_sw_state failed\n");
+		drm_err(adev_to_drm(adev), "si_upload_sw_state failed\n");
 		return ret;
 	}
 	ret = si_upload_smc_data(adev);
 	if (ret) {
-		DRM_ERROR("si_upload_smc_data failed\n");
+		drm_err(adev_to_drm(adev), "si_upload_smc_data failed\n");
 		return ret;
 	}
 	ret = si_upload_ulv_state(adev);
 	if (ret) {
-		DRM_ERROR("si_upload_ulv_state failed\n");
+		drm_err(adev_to_drm(adev), "si_upload_ulv_state failed\n");
 		return ret;
 	}
 	if (eg_pi->dynamic_ac_timing) {
 		ret = si_upload_mc_reg_table(adev, new_ps);
 		if (ret) {
-			DRM_ERROR("si_upload_mc_reg_table failed\n");
+			drm_err(adev_to_drm(adev), "si_upload_mc_reg_table failed\n");
 			return ret;
 		}
 	}
 	ret = si_program_memory_timing_parameters(adev, new_ps);
 	if (ret) {
-		DRM_ERROR("si_program_memory_timing_parameters failed\n");
+		drm_err(adev_to_drm(adev), "si_program_memory_timing_parameters failed\n");
 		return ret;
 	}
 	si_set_pcie_lane_width_in_smc(adev, new_ps, old_ps);
 
 	ret = si_resume_smc(adev);
 	if (ret) {
-		DRM_ERROR("si_resume_smc failed\n");
+		drm_err(adev_to_drm(adev), "si_resume_smc failed\n");
 		return ret;
 	}
 	ret = si_set_sw_state(adev);
 	if (ret) {
-		DRM_ERROR("si_set_sw_state failed\n");
+		drm_err(adev_to_drm(adev), "si_set_sw_state failed\n");
 		return ret;
 	}
 	ni_set_uvd_clock_after_set_eng_clock(adev, new_ps, old_ps);
@@ -7115,23 +7115,23 @@ static int si_dpm_set_power_state(void *handle)
 		si_notify_link_speed_change_after_state_change(adev, new_ps, old_ps);
 	ret = si_set_power_state_conditionally_enable_ulv(adev, new_ps);
 	if (ret) {
-		DRM_ERROR("si_set_power_state_conditionally_enable_ulv failed\n");
+		drm_err(adev_to_drm(adev), "si_set_power_state_conditionally_enable_ulv failed\n");
 		return ret;
 	}
 	ret = si_enable_smc_cac(adev, new_ps, true);
 	if (ret) {
-		DRM_ERROR("si_enable_smc_cac failed\n");
+		drm_err(adev_to_drm(adev), "si_enable_smc_cac failed\n");
 		return ret;
 	}
 	ret = si_enable_power_containment(adev, new_ps, true);
 	if (ret) {
-		DRM_ERROR("si_enable_power_containment failed\n");
+		drm_err(adev_to_drm(adev), "si_enable_power_containment failed\n");
 		return ret;
 	}
 
 	ret = si_power_control_set_level(adev);
 	if (ret) {
-		DRM_ERROR("si_power_control_set_level failed\n");
+		drm_err(adev_to_drm(adev), "si_power_control_set_level failed\n");
 		return ret;
 	}
 
@@ -7728,7 +7728,7 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
 	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_smc.bin", chip_name);
 	if (err) {
-		DRM_ERROR("si_smc: Failed to load firmware. err = %d\"%s_smc.bin\"\n",
+		drm_err(adev_to_drm(adev), "si_smc: Failed to load firmware. err = %d\"%s_smc.bin\"\n",
 			  err, chip_name);
 		amdgpu_ucode_release(&adev->pm.fw);
 	}
@@ -7772,13 +7772,13 @@ static int si_dpm_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
 	if (amdgpu_dpm == 1)
 		amdgpu_pm_print_power_states(adev);
-	DRM_INFO("amdgpu: dpm initialized\n");
+	drm_info(adev_to_drm(adev), "amdgpu: dpm initialized\n");
 
 	return 0;
 
 dpm_failed:
 	si_dpm_fini(adev);
-	DRM_ERROR("amdgpu: dpm initialization failed\n");
+	drm_err(adev_to_drm(adev), "amdgpu: dpm initialization failed\n");
 	return ret;
 }
 
@@ -7947,10 +7947,10 @@ static void si_dpm_print_power_state(void *handle,
 
 	amdgpu_dpm_print_class_info(rps->class, rps->class2);
 	amdgpu_dpm_print_cap_info(rps->caps);
-	DRM_INFO("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
+	drm_info(adev_to_drm(adev), "\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
 	for (i = 0; i < ps->performance_level_count; i++) {
 		pl = &ps->performance_levels[i];
-		DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
+		drm_info(adev_to_drm(adev), "\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
 			 i, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
 	}
 	amdgpu_dpm_print_ps_status(adev, rps);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index b48a031cbba08..c6bf45b50970b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -201,7 +201,7 @@ static void pp_reserve_vram_for_smu(struct amdgpu_device *adev)
 						&adev->pm.smu_prv_buffer,
 						&gpu_addr,
 						&cpu_ptr)) {
-		DRM_ERROR("amdgpu: failed to create smu prv buffer\n");
+		drm_err(adev_to_drm(adev), "amdgpu: failed to create smu prv buffer\n");
 		return;
 	}
 
@@ -216,7 +216,7 @@ static void pp_reserve_vram_for_smu(struct amdgpu_device *adev)
 	if (r) {
 		amdgpu_bo_free_kernel(&adev->pm.smu_prv_buffer, NULL, NULL);
 		adev->pm.smu_prv_buffer = NULL;
-		DRM_ERROR("amdgpu: failed to notify SMU buffer address\n");
+		drm_err(adev_to_drm(adev), "amdgpu: failed to notify SMU buffer address\n");
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
index fd79337a35366..759b49e46378a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/common_baco.c
@@ -72,7 +72,7 @@ static bool baco_cmd_handler(struct pp_hwmgr *hwmgr, u32 command, u32 reg, u32 m
 		break;
 
 	default:
-		dev_warn(adev->dev, "Invalid BACO command.\n");
+		drm_warn(adev_to_drm(adev), "Invalid BACO command.\n");
 		ret = false;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index ad1fd3150d03e..443c116e20533 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -218,7 +218,7 @@ static int ci_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 	ret = PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP);
 
 	if (ret != 1)
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			"failed to send message %x ret is %d\n", msg,ret);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
index ac9ec8257f82a..b2a27786791f7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
@@ -87,7 +87,7 @@ static int smu10_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 	smu10_send_msg_to_smc_without_waiting(hwmgr, msg);
 
 	if (smu10_wait_for_response(hwmgr) == 0)
-		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
+		drm_err(adev_to_drm(adev), "Failed to send Message %x.\n", msg);
 
 	return 0;
 }
@@ -108,7 +108,7 @@ static int smu10_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
 
 
 	if (smu10_wait_for_response(hwmgr) == 0)
-		dev_err(adev->dev, "Failed to send Message %x.\n", msg);
+		drm_err(adev_to_drm(adev), "Failed to send Message %x.\n", msg);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
index 5a010cd383037..c6fe582c74677 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
@@ -175,7 +175,7 @@ int smu7_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 	if (ret == 0xFE)
 		dev_dbg(adev->dev, "last message was not supported\n");
 	else if (ret != 1)
-		dev_info(adev->dev,
+		drm_info(adev_to_drm(adev),
 			"\nlast message was failed ret is %d\n", ret);
 
 	cgs_write_register(hwmgr->device, mmSMC_RESP_0, 0);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
index 8c9bf4940dc15..4a259e77dd1a4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
@@ -126,7 +126,7 @@ int smu9_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 
 	ret = smu9_wait_for_response(hwmgr);
 	if (ret != 1)
-		dev_err(adev->dev, "Failed to send message: 0x%x, ret value: 0x%x\n", msg, ret);
+		drm_err(adev_to_drm(adev), "Failed to send message: 0x%x, ret value: 0x%x\n", msg, ret);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
index a5c95b1806729..c0a14c70651fb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
@@ -115,7 +115,7 @@ static int vega20_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 
 	ret = vega20_wait_for_response(hwmgr);
 	if (ret != PPSMC_Result_OK)
-		dev_err(adev->dev, "Failed to send message 0x%x, response 0x%x\n", msg, ret);
+		drm_err(adev_to_drm(adev), "Failed to send message 0x%x, response 0x%x\n", msg, ret);
 
 	return (ret == PPSMC_Result_OK) ? 0 : -EIO;
 }
@@ -143,7 +143,7 @@ static int vega20_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
 
 	ret = vega20_wait_for_response(hwmgr);
 	if (ret != PPSMC_Result_OK)
-		dev_err(adev->dev, "Failed to send message 0x%x, response 0x%x\n", msg, ret);
+		drm_err(adev_to_drm(adev), "Failed to send message 0x%x, response 0x%x\n", msg, ret);
 
 	return (ret == PPSMC_Result_OK) ? 0 : -EIO;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a01b6244d99cd..a770b32de16ac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -177,7 +177,7 @@ int smu_set_gfx_power_up_by_imu(struct smu_context *smu)
 	if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
 		ret = smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
 		if (ret)
-			dev_err(adev->dev, "Failed to enable gfx imu!\n");
+			drm_err(adev_to_drm(adev), "Failed to enable gfx imu!\n");
 	}
 	return ret;
 }
@@ -858,7 +858,7 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 
 	ret = smu_post_init(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to post smu init!\n");
+		drm_err(adev_to_drm(adev), "Failed to post smu init!\n");
 		return ret;
 	}
 
@@ -879,14 +879,14 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
 		ret = smu_set_default_od_settings(smu);
 		if (ret) {
-			dev_err(adev->dev, "Failed to setup default OD settings!\n");
+			drm_err(adev_to_drm(adev), "Failed to setup default OD settings!\n");
 			return ret;
 		}
 	}
 
 	ret = smu_populate_umd_state_clk(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
+		drm_err(adev_to_drm(adev), "Failed to populate UMD state clocks!\n");
 		return ret;
 	}
 
@@ -896,7 +896,7 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 					&smu->max_power_limit,
 					&smu->min_power_limit);
 	if (ret) {
-		dev_err(adev->dev, "Failed to get asic power limits!\n");
+		drm_err(adev_to_drm(adev), "Failed to get asic power limits!\n");
 		return ret;
 	}
 
@@ -911,7 +911,7 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 
 	ret = smu_apply_default_config_table_settings(smu);
 	if (ret && (ret != -EOPNOTSUPP)) {
-		dev_err(adev->dev, "Failed to apply default DriverSmuConfig settings!\n");
+		drm_err(adev_to_drm(adev), "Failed to apply default DriverSmuConfig settings!\n");
 		return ret;
 	}
 
@@ -939,7 +939,7 @@ static int smu_init_fb_allocations(struct smu_context *smu)
 					      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
 					      &tables[SMU_TABLE_PMSTATUSLOG].cpu_addr);
 		if (ret) {
-			dev_err(adev->dev, "VRAM allocation for tool table failed!\n");
+			drm_err(adev_to_drm(adev), "VRAM allocation for tool table failed!\n");
 			return ret;
 		}
 	}
@@ -976,7 +976,7 @@ static int smu_init_fb_allocations(struct smu_context *smu)
 				      &driver_table->mc_address,
 				      &driver_table->cpu_addr);
 	if (ret) {
-		dev_err(adev->dev, "VRAM allocation for driver table failed!\n");
+		drm_err(adev_to_drm(adev), "VRAM allocation for driver table failed!\n");
 		if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
 			amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
 					      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
@@ -1045,7 +1045,7 @@ static int smu_alloc_memory_pool(struct smu_context *smu)
 					      &memory_pool->mc_address,
 					      &memory_pool->cpu_addr);
 		if (ret)
-			dev_err(adev->dev, "VRAM allocation for dramlog failed!\n");
+			drm_err(adev_to_drm(adev), "VRAM allocation for dramlog failed!\n");
 		break;
 	default:
 		break;
@@ -1090,7 +1090,7 @@ static int smu_alloc_dummy_read_table(struct smu_context *smu)
 				      &dummy_read_1_table->mc_address,
 				      &dummy_read_1_table->cpu_addr);
 	if (ret)
-		dev_err(adev->dev, "VRAM allocation for dummy read table failed!\n");
+		drm_err(adev_to_drm(adev), "VRAM allocation for dummy read table failed!\n");
 
 	return ret;
 }
@@ -1298,26 +1298,26 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 
 	ret = smu_smc_table_sw_init(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to sw init smc table!\n");
+		drm_err(adev_to_drm(adev), "Failed to sw init smc table!\n");
 		return ret;
 	}
 
 	/* get boot_values from vbios to set revision, gfxclk, and etc. */
 	ret = smu_get_vbios_bootup_values(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to get VBIOS boot clock values!\n");
+		drm_err(adev_to_drm(adev), "Failed to get VBIOS boot clock values!\n");
 		return ret;
 	}
 
 	ret = smu_init_pptable_microcode(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to setup pptable firmware!\n");
+		drm_err(adev_to_drm(adev), "Failed to setup pptable firmware!\n");
 		return ret;
 	}
 
 	ret = smu_register_irq_handler(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to register smc irq handler!\n");
+		drm_err(adev_to_drm(adev), "Failed to register smc irq handler!\n");
 		return ret;
 	}
 
@@ -1336,7 +1336,7 @@ static int smu_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	ret = smu_smc_table_sw_fini(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to sw fini smc table!\n");
+		drm_err(adev_to_drm(adev), "Failed to sw fini smc table!\n");
 		return ret;
 	}
 
@@ -1396,7 +1396,7 @@ static int smu_wbrf_handle_exclusion_ranges(struct smu_context *smu)
 
 	ret = amd_wbrf_retrieve_freq_band(adev->dev, &wbrf_exclusion);
 	if (ret) {
-		dev_err(adev->dev, "Failed to retrieve exclusion ranges!\n");
+		drm_err(adev_to_drm(adev), "Failed to retrieve exclusion ranges!\n");
 		return ret;
 	}
 
@@ -1504,7 +1504,7 @@ static void smu_wbrf_support_check(struct smu_context *smu)
 							acpi_amd_wbrf_supported_consumer(adev->dev);
 
 	if (smu->wbrf_supported)
-		dev_info(adev->dev, "RF interference mitigation is supported\n");
+		drm_info(adev_to_drm(adev), "RF interference mitigation is supported\n");
 }
 
 /**
@@ -1573,10 +1573,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 0, 12):
 		if (adev->in_suspend && smu_is_dpm_running(smu)) {
-			dev_info(adev->dev, "dpm has been enabled\n");
+			drm_info(adev_to_drm(adev), "dpm has been enabled\n");
 			ret = smu_system_features_control(smu, true);
 			if (ret)
-				dev_err(adev->dev, "Failed system features control!\n");
+				drm_err(adev_to_drm(adev), "Failed system features control!\n");
 			return ret;
 		}
 		break;
@@ -1586,13 +1586,13 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 
 	ret = smu_init_display_count(smu, 0);
 	if (ret) {
-		dev_info(adev->dev, "Failed to pre-set display count as 0!\n");
+		drm_info(adev_to_drm(adev), "Failed to pre-set display count as 0!\n");
 		return ret;
 	}
 
 	ret = smu_set_driver_table_location(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to SetDriverDramAddr!\n");
+		drm_err(adev_to_drm(adev), "Failed to SetDriverDramAddr!\n");
 		return ret;
 	}
 
@@ -1601,7 +1601,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	 */
 	ret = smu_set_tool_table_location(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to SetToolsDramAddr!\n");
+		drm_err(adev_to_drm(adev), "Failed to SetToolsDramAddr!\n");
 		return ret;
 	}
 
@@ -1611,7 +1611,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	 */
 	ret = smu_notify_memory_pool_location(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to SetDramLogDramAddr!\n");
+		drm_err(adev_to_drm(adev), "Failed to SetDramLogDramAddr!\n");
 		return ret;
 	}
 
@@ -1623,7 +1623,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (!adev->in_runpm) {
 		ret = smu_setup_pptable(smu);
 		if (ret) {
-			dev_err(adev->dev, "Failed to setup pptable!\n");
+			drm_err(adev_to_drm(adev), "Failed to setup pptable!\n");
 			return ret;
 		}
 	}
@@ -1641,7 +1641,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		 */
 		ret = smu_write_pptable(smu);
 		if (ret) {
-			dev_err(adev->dev, "Failed to transfer pptable to SMC!\n");
+			drm_err(adev_to_drm(adev), "Failed to transfer pptable to SMC!\n");
 			return ret;
 		}
 	}
@@ -1655,7 +1655,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (smu->wbrf_supported) {
 		ret = smu_enable_uclk_shadow(smu, true);
 		if (ret) {
-			dev_err(adev->dev, "Failed to enable UclkShadow feature to support wbrf!\n");
+			drm_err(adev_to_drm(adev), "Failed to enable UclkShadow feature to support wbrf!\n");
 			return ret;
 		}
 	}
@@ -1667,14 +1667,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (!adev->scpm_enabled) {
 		ret = smu_feature_set_allowed_mask(smu);
 		if (ret) {
-			dev_err(adev->dev, "Failed to set driver allowed features mask!\n");
+			drm_err(adev_to_drm(adev), "Failed to set driver allowed features mask!\n");
 			return ret;
 		}
 	}
 
 	ret = smu_system_features_control(smu, true);
 	if (ret) {
-		dev_err(adev->dev, "Failed to enable requested dpm features!\n");
+		drm_err(adev_to_drm(adev), "Failed to enable requested dpm features!\n");
 		return ret;
 	}
 
@@ -1682,7 +1682,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 
 	ret = smu_feature_get_enabled_mask(smu, &features_supported);
 	if (ret) {
-		dev_err(adev->dev, "Failed to retrieve supported dpm features!\n");
+		drm_err(adev_to_drm(adev), "Failed to retrieve supported dpm features!\n");
 		return ret;
 	}
 	bitmap_copy(feature->supported,
@@ -1690,7 +1690,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		    feature->feature_num);
 
 	if (!smu_is_dpm_running(smu))
-		dev_info(adev->dev, "dpm has been disabled\n");
+		drm_info(adev_to_drm(adev), "dpm has been disabled\n");
 
 	/*
 	 * Set initialized values (get from vbios) to dpm tables context such as
@@ -1699,7 +1699,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	 */
 	ret = smu_set_default_dpm_table(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
+		drm_err(adev_to_drm(adev), "Failed to setup default dpm clock tables!\n");
 		return ret;
 	}
 
@@ -1734,25 +1734,25 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		pcie_width = 1;
 	ret = smu_update_pcie_parameters(smu, pcie_gen, pcie_width);
 	if (ret) {
-		dev_err(adev->dev, "Attempt to override pcie params failed!\n");
+		drm_err(adev_to_drm(adev), "Attempt to override pcie params failed!\n");
 		return ret;
 	}
 
 	ret = smu_get_thermal_temperature_range(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to get thermal temperature ranges!\n");
+		drm_err(adev_to_drm(adev), "Failed to get thermal temperature ranges!\n");
 		return ret;
 	}
 
 	ret = smu_enable_thermal_alert(smu);
 	if (ret) {
-	  dev_err(adev->dev, "Failed to enable thermal alert!\n");
+	  drm_err(adev_to_drm(adev), "Failed to enable thermal alert!\n");
 	  return ret;
 	}
 
 	ret = smu_notify_display_change(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to notify display change!\n");
+		drm_err(adev_to_drm(adev), "Failed to notify display change!\n");
 		return ret;
 	}
 
@@ -1763,14 +1763,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	ret = smu_set_min_dcef_deep_sleep(smu,
 					  smu->smu_table.boot_values.dcefclk / 100);
 	if (ret) {
-		dev_err(adev->dev, "Error setting min deepsleep dcefclk\n");
+		drm_err(adev_to_drm(adev), "Error setting min deepsleep dcefclk\n");
 		return ret;
 	}
 
 	/* Init wbrf support. Properly setup the notifier */
 	ret = smu_wbrf_init(smu);
 	if (ret)
-		dev_err(adev->dev, "Error during wbrf init call\n");
+		drm_err(adev_to_drm(adev), "Error during wbrf init call\n");
 
 	return ret;
 }
@@ -1795,7 +1795,7 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	if (smu->ppt_funcs->check_fw_status) {
 		ret = smu->ppt_funcs->check_fw_status(smu);
 		if (ret) {
-			dev_err(adev->dev, "SMC is not ready\n");
+			drm_err(adev_to_drm(adev), "SMC is not ready\n");
 			return ret;
 		}
 	}
@@ -1824,7 +1824,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
-		dev_err(adev->dev, "SMC engine is not correctly up!\n");
+		drm_err(adev_to_drm(adev), "SMC engine is not correctly up!\n");
 		return ret;
 	}
 
@@ -1857,7 +1857,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 
 	ret = smu_smc_hw_setup(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to setup smc hw!\n");
+		drm_err(adev_to_drm(adev), "Failed to setup smc hw!\n");
 		return ret;
 	}
 
@@ -1870,13 +1870,13 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	ret = smu_init_max_sustainable_clocks(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to init max sustainable clocks!\n");
+		drm_err(adev_to_drm(adev), "Failed to init max sustainable clocks!\n");
 		return ret;
 	}
 
 	adev->pm.dpm_enabled = true;
 
-	dev_info(adev->dev, "SMU is initialized successfully!\n");
+	drm_info(adev_to_drm(adev), "SMU is initialized successfully!\n");
 
 	return 0;
 }
@@ -1966,13 +1966,13 @@ static int smu_disable_dpms(struct smu_context *smu)
 		ret = smu_disable_all_features_with_exception(smu,
 							      SMU_FEATURE_BACO_BIT);
 		if (ret)
-			dev_err(adev->dev, "Failed to disable smu features except BACO.\n");
+			drm_err(adev_to_drm(adev), "Failed to disable smu features except BACO.\n");
 	} else {
 		/* DisableAllSmuFeatures message is not permitted with SCPM enabled */
 		if (!adev->scpm_enabled) {
 			ret = smu_system_features_control(smu, false);
 			if (ret)
-				dev_err(adev->dev, "Failed to disable smu features.\n");
+				drm_err(adev_to_drm(adev), "Failed to disable smu features.\n");
 		}
 	}
 
@@ -1982,7 +1982,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	ret = smu_notify_rlc_state(smu, false);
 	if (ret) {
-		dev_err(adev->dev, "Fail to notify rlc status!\n");
+		drm_err(adev_to_drm(adev), "Fail to notify rlc status!\n");
 		return ret;
 	}
 
@@ -2006,7 +2006,7 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 
 	ret = smu_disable_thermal_alert(smu);
 	if (ret) {
-		dev_err(adev->dev, "Fail to disable thermal alert!\n");
+		drm_err(adev_to_drm(adev), "Fail to disable thermal alert!\n");
 		return ret;
 	}
 
@@ -2014,7 +2014,7 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 
 	ret = smu_disable_dpms(smu);
 	if (ret) {
-		dev_err(adev->dev, "Fail to disable dpm features!\n");
+		drm_err(adev_to_drm(adev), "Fail to disable dpm features!\n");
 		return ret;
 	}
 
@@ -2151,17 +2151,17 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	if (!smu->pm_enabled)
 		return 0;
 
-	dev_info(adev->dev, "SMU is resuming...\n");
+	drm_info(adev_to_drm(adev), "SMU is resuming...\n");
 
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
-		dev_err(adev->dev, "SMC engine is not correctly up!\n");
+		drm_err(adev_to_drm(adev), "SMC engine is not correctly up!\n");
 		return ret;
 	}
 
 	ret = smu_smc_hw_setup(smu);
 	if (ret) {
-		dev_err(adev->dev, "Failed to setup smc hw!\n");
+		drm_err(adev_to_drm(adev), "Failed to setup smc hw!\n");
 		return ret;
 	}
 
@@ -2175,7 +2175,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 
 	adev->pm.dpm_enabled = true;
 
-	dev_info(adev->dev, "SMU is resumed successfully!\n");
+	drm_info(adev_to_drm(adev), "SMU is resumed successfully!\n");
 
 	return 0;
 }
@@ -2685,7 +2685,7 @@ static int smu_load_microcode(void *handle)
 	if (smu->ppt_funcs->load_microcode) {
 		ret = smu->ppt_funcs->load_microcode(smu);
 		if (ret) {
-			dev_err(adev->dev, "Load microcode failed\n");
+			drm_err(adev_to_drm(adev), "Load microcode failed\n");
 			return ret;
 		}
 	}
@@ -2693,7 +2693,7 @@ static int smu_load_microcode(void *handle)
 	if (smu->ppt_funcs->check_fw_status) {
 		ret = smu->ppt_funcs->check_fw_status(smu);
 		if (ret) {
-			dev_err(adev->dev, "SMC is not ready\n");
+			drm_err(adev_to_drm(adev), "SMC is not ready\n");
 			return ret;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 453952cdc353b..1a7d8d8255c62 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1747,7 +1747,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu)
 
 		res = i2c_add_adapter(control);
 		if (res) {
-			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			drm_err(adev_to_drm(adev), "Failed to register hw i2c, err: %d\n", res);
 			goto Out_err;
 		}
 	}
@@ -1789,7 +1789,7 @@ static void arcturus_get_unique_id(struct smu_context *smu)
 
 	/* PPSMC_MSG_ReadSerial* is supported by 54.23.0 and onwards */
 	if (smu->smc_fw_version < 0x361700) {
-		dev_warn(adev->dev, "ReadSerial is only supported by PMFW 54.23.0 and onwards\n");
+		drm_warn(adev_to_drm(adev), "ReadSerial is only supported by PMFW 54.23.0 and onwards\n");
 		return;
 	}
 
@@ -1859,14 +1859,14 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 					    throttling_events > 1 ? " and " : "",
 					    logging_label[throttler_idx].label);
 			if (buf_idx >= sizeof(log_buf)) {
-				dev_err(adev->dev, "buffer overflow!\n");
+				drm_err(adev_to_drm(adev), "buffer overflow!\n");
 				log_buf[sizeof(log_buf) - 1] = '\0';
 				break;
 			}
 		}
 	}
 
-	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
+	drm_warn(adev_to_drm(adev), "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
 			log_buf);
 	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev,
 		smu_cmn_get_indep_throttler_status(throttler_status,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7fad5dfb39c44..3debbbed9c602 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -420,12 +420,12 @@ static int navi10_append_powerplay_table(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	dev_info(adev->dev, "smc_dpm_info table revision(format.content): %d.%d\n",
+	drm_info(adev_to_drm(adev), "smc_dpm_info table revision(format.content): %d.%d\n",
 			smc_dpm_table->table_header.format_revision,
 			smc_dpm_table->table_header.content_revision);
 
 	if (smc_dpm_table->table_header.format_revision != 4) {
-		dev_err(adev->dev, "smc_dpm_info table format revision is not 4!\n");
+		drm_err(adev_to_drm(adev), "smc_dpm_info table format revision is not 4!\n");
 		return -EINVAL;
 	}
 
@@ -3144,7 +3144,7 @@ static int navi10_i2c_control_init(struct smu_context *smu)
 
 		res = i2c_add_adapter(control);
 		if (res) {
-			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			drm_err(adev_to_drm(adev), "Failed to register hw i2c, err: %d\n", res);
 			goto Out_err;
 		}
 	}
@@ -3472,7 +3472,7 @@ static int navi10_post_smu_init(struct smu_context *smu)
 
 	ret = navi10_run_umc_cdr_workaround(smu);
 	if (ret)
-		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
+		drm_err(adev_to_drm(adev), "Failed to apply umc cdr workaround!\n");
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 19a25fdc2f5b4..eff2ce9b1ad4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2646,7 +2646,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu)
 
 		res = i2c_add_adapter(control);
 		if (res) {
-			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			drm_err(adev_to_drm(adev), "Failed to register hw i2c, err: %d\n", res);
 			goto Out_err;
 		}
 	}
@@ -3122,7 +3122,7 @@ static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 	}
 
 	if (!timeout) {
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"failed to send mode2 message \tparam: 0x%08x response %#x\n",
 			SMU_RESET_MODE_2, ret);
 		goto out;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 1d100165ddf98..4be60f1187baa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -326,7 +326,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		version_major = le16_to_cpu(hdr->header.header_version_major);
 		version_minor = le16_to_cpu(hdr->header.header_version_minor);
 		if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
-			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
+			drm_info(adev_to_drm(adev), "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 			switch (version_minor) {
 			case 0:
 				ret = smu_v11_0_set_pptable_v2_0(smu, &table, &size);
@@ -345,7 +345,7 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		}
 	}
 
-	dev_info(adev->dev, "use vbios provided pptable\n");
+	drm_info(adev_to_drm(adev), "use vbios provided pptable\n");
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 						powerplayinfo);
 
@@ -1909,7 +1909,7 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 		return 0;
 	default:
-		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		drm_err(adev_to_drm(adev), "Invalid performance level %d\n", level);
 		return -EINVAL;
 	}
 
@@ -2158,7 +2158,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2166,7 +2166,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_UCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2174,7 +2174,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_FCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2182,7 +2182,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2190,7 +2190,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index a55ea76d73996..7ee42f3bbb4bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2229,12 +2229,12 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
 		if (ret) {
-			dev_err(adev->dev, "Failed to Enable GfxOff!\n");
+			drm_err(adev_to_drm(adev), "Failed to Enable GfxOff!\n");
 			return ret;
 		}
 	} else {
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
-		dev_info(adev->dev, "If GFX DPM or power gate disabled, disable GFXOFF\n");
+		drm_info(adev_to_drm(adev), "If GFX DPM or power gate disabled, disable GFXOFF\n");
 	}
 
 	/* if all CUs are active, no need to power off any WGPs */
@@ -2252,7 +2252,7 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 
 	/* Do not request any WGPs less than set in the AON_WGP_MASK */
 	if (aon_bits > req_active_wgps) {
-		dev_info(adev->dev, "Number of always on WGPs greater than active WGPs: WGP power save not requested.\n");
+		drm_info(adev_to_drm(adev), "Number of always on WGPs greater than active WGPs: WGP power save not requested.\n");
 		return 0;
 	} else {
 		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RequestActiveWgp, req_active_wgps, NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 3d3cd546f0adc..0973fa0b51bc2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -170,7 +170,7 @@ int smu_v12_0_gfx_off_control(struct smu_context *smu, bool enable)
 			msleep(1);
 			timeout--;
 			if (timeout == 0) {
-				DRM_ERROR("disable gfxoff timeout and failed!\n");
+				drm_err(adev_to_drm(smu->adev), "disable gfxoff timeout and failed!\n");
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 83163d7c7f001..8f4eb285ae1d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1341,7 +1341,7 @@ static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
 	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
 		if (!max || (max < dpm_context->dpm_tables.gfx_table.min) ||
 			(max > dpm_context->dpm_tables.gfx_table.max)) {
-			dev_warn(adev->dev,
+			drm_warn(adev_to_drm(adev),
 					"Invalid max frequency %d MHz specified for determinism\n", max);
 			return -EINVAL;
 		}
@@ -1356,7 +1356,7 @@ static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
 					SMU_MSG_EnableDeterminism,
 					max, NULL);
 			if (ret) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 						"Failed to enable determinism at GFX clock %d MHz\n", max);
 			} else {
 				pstate_table->gfxclk_pstate.curr.min = min_clk;
@@ -1579,7 +1579,7 @@ static int aldebaran_i2c_control_init(struct smu_context *smu)
 
 	res = i2c_add_adapter(control);
 	if (res) {
-		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+		drm_err(adev_to_drm(adev), "Failed to register hw i2c, err: %d\n", res);
 		goto Out_err;
 	}
 
@@ -1679,14 +1679,14 @@ static void aldebaran_log_thermal_throttling_event(struct smu_context *smu)
 					    throttling_events > 1 ? " and " : "",
 					    logging_label[throttler_idx].label);
 			if (buf_idx >= sizeof(log_buf)) {
-				dev_err(adev->dev, "buffer overflow!\n");
+				drm_err(adev_to_drm(adev), "buffer overflow!\n");
 				log_buf[sizeof(log_buf) - 1] = '\0';
 				break;
 			}
 		}
 	}
 
-	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
+	drm_warn(adev_to_drm(adev), "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
 		 log_buf);
 	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev,
 		smu_cmn_get_indep_throttler_status(throttler_status,
@@ -1920,14 +1920,14 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 			}
 
 			if (ret != 1) {
-				dev_err(adev->dev, "failed to send mode2 message \tparam: 0x%08x response %#x\n",
+				drm_err(adev_to_drm(adev), "failed to send mode2 message \tparam: 0x%08x response %#x\n",
 						SMU_RESET_MODE_2, ret);
 				goto out;
 			}
 		}
 
 	} else {
-		dev_err(adev->dev, "smu fw 0x%x does not support MSG_GfxDeviceDriverReset MSG\n",
+		drm_err(adev_to_drm(adev), "smu fw 0x%x does not support MSG_GfxDeviceDriverReset MSG\n",
 				smu->smc_fw_version);
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 8c651b7ae0ab2..5063007e22d8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -203,7 +203,7 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
 	/* override pptable_id from driver parameter */
 	if (amdgpu_smu_pptable_id >= 0) {
 		pptable_id = amdgpu_smu_pptable_id;
-		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
+		drm_info(adev_to_drm(adev), "override pptable id %d\n", pptable_id);
 	} else {
 		pptable_id = smu->smu_table.boot_values.pp_table_id;
 	}
@@ -283,11 +283,11 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
-		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+		drm_info(adev_to_drm(adev), "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_info(adev->dev, "SMU driver if version not matched\n");
+		drm_info(adev_to_drm(adev), "SMU driver if version not matched\n");
 	}
 
 	return ret;
@@ -342,7 +342,7 @@ static int smu_v13_0_get_pptable_from_vbios(struct smu_context *smu, void **tabl
 	uint8_t frev, crev;
 	int ret, index;
 
-	dev_info(adev->dev, "use vbios provided pptable\n");
+	drm_info(adev_to_drm(adev), "use vbios provided pptable\n");
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    powerplayinfo);
 
@@ -371,12 +371,12 @@ int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
 	if (!hdr)
 		return -EINVAL;
 
-	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
+	drm_info(adev_to_drm(adev), "use driver provided pptable %d\n", pptable_id);
 
 	version_major = le16_to_cpu(hdr->header.header_version_major);
 	version_minor = le16_to_cpu(hdr->header.header_version_minor);
 	if (version_major != 2) {
-		dev_err(adev->dev, "Unsupported smu firmware version %d.%d\n",
+		drm_err(adev_to_drm(adev), "Unsupported smu firmware version %d.%d\n",
 			version_major, version_minor);
 		return -EINVAL;
 	}
@@ -406,7 +406,7 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 	/* override pptable_id from driver parameter */
 	if (amdgpu_smu_pptable_id >= 0) {
 		pptable_id = amdgpu_smu_pptable_id;
-		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
+		drm_info(adev_to_drm(adev), "override pptable id %d\n", pptable_id);
 	} else {
 		pptable_id = smu->smu_table.boot_values.pp_table_id;
 	}
@@ -1773,7 +1773,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 		return 0;
 	default:
-		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		drm_err(adev_to_drm(adev), "Invalid performance level %d\n", level);
 		return -EINVAL;
 	}
 
@@ -2161,7 +2161,7 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2169,7 +2169,7 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_UCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2177,7 +2177,7 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_FCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2185,7 +2185,7 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2193,7 +2193,7 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev), "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2201,7 +2201,8 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_VCN_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_VCN_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s VCN DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s VCN DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2209,7 +2210,8 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_MP0CLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_MP0CLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s MP0/MPIOCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s MP0/MPIOCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -2217,7 +2219,8 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_MP1CLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_MP1CLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s MP1CLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s MP1CLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5a9711e8cf689..8536dd3328e9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1614,7 +1614,7 @@ static int smu_v13_0_0_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 	default:
-		dev_info(adev->dev, "Invalid table index: %ld\n", input);
+		drm_info(adev_to_drm(adev), "Invalid table index: %ld\n", input);
 		return -EINVAL;
 	}
 
@@ -1638,13 +1638,13 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 	switch (type) {
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
-			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "GFXCLK_LIMITS setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
 			if (i + 2 > size) {
-				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+				drm_info(adev_to_drm(adev), "invalid number of input parameters %d\n", size);
 				return -EINVAL;
 			}
 
@@ -1656,7 +1656,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "GfxclkFmin (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev), "GfxclkFmin (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -1672,7 +1672,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "GfxclkFmax (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev), "GfxclkFmax (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -1682,14 +1682,14 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 				break;
 
 			default:
-				dev_info(adev->dev, "Invalid SCLK_VDDC_TABLE index: %ld\n", input[i]);
-				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
+				drm_info(adev_to_drm(adev), "Invalid SCLK_VDDC_TABLE index: %ld\n", input[i]);
+				drm_info(adev_to_drm(adev), "Supported indices: [0:min,1:max]\n");
 				return -EINVAL;
 			}
 		}
 
 		if (od_table->OverDriveTable.GfxclkFmin > od_table->OverDriveTable.GfxclkFmax) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Invalid setting: GfxclkFmin(%u) is bigger than GfxclkFmax(%u)\n",
 				(uint32_t)od_table->OverDriveTable.GfxclkFmin,
 				(uint32_t)od_table->OverDriveTable.GfxclkFmax);
@@ -1699,13 +1699,13 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
-			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "UCLK_LIMITS setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
 			if (i + 2 > size) {
-				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+				drm_info(adev_to_drm(adev), "invalid number of input parameters %d\n", size);
 				return -EINVAL;
 			}
 
@@ -1717,7 +1717,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "UclkFmin (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev), "UclkFmin (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -1733,7 +1733,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "UclkFmax (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev), "UclkFmax (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -1743,14 +1743,14 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 				break;
 
 			default:
-				dev_info(adev->dev, "Invalid MCLK_VDDC_TABLE index: %ld\n", input[i]);
-				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
+				drm_info(adev_to_drm(adev), "Invalid MCLK_VDDC_TABLE index: %ld\n", input[i]);
+				drm_info(adev_to_drm(adev), "Supported indices: [0:min,1:max]\n");
 				return -EINVAL;
 			}
 		}
 
 		if (od_table->OverDriveTable.UclkFmin > od_table->OverDriveTable.UclkFmax) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Invalid setting: UclkFmin(%u) is bigger than UclkFmax(%u)\n",
 				(uint32_t)od_table->OverDriveTable.UclkFmin,
 				(uint32_t)od_table->OverDriveTable.UclkFmax);
@@ -1760,7 +1760,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_VDDGFX_OFFSET:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
-			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Gfx offset setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1770,7 +1770,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "Voltage offset (%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "Voltage offset (%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1782,7 +1782,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_CURVE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1796,7 +1796,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[1] < minimum ||
 		    input[1] > maximum) {
-			dev_info(adev->dev, "Fan curve temp setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "Fan curve temp setting(%ld) must be within [%d, %d]!\n",
 				 input[1], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1807,7 +1807,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[2] < minimum ||
 		    input[2] > maximum) {
-			dev_info(adev->dev, "Fan curve pwm setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "Fan curve pwm setting(%ld) must be within [%d, %d]!\n",
 				 input[2], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1820,7 +1820,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1830,7 +1830,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "acoustic limit threshold setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "acoustic limit threshold setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1842,7 +1842,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1852,7 +1852,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "acoustic target threshold setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "acoustic target threshold setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1864,7 +1864,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1874,7 +1874,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "fan target temperature setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "fan target temperature setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1886,7 +1886,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1896,7 +1896,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "fan minimum pwm setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "fan minimum pwm setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1908,7 +1908,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
-			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Zero RPM setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1918,7 +1918,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "zero RPM enable setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "zero RPM enable setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1929,7 +1929,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
 		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
-			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Zero RPM setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1939,7 +1939,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "zero RPM stop temperature setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "zero RPM stop temperature setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1977,7 +1977,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
 
 			ret = smu_v13_0_0_upload_overdrive_table(smu, od_table);
 			if (ret) {
-				dev_err(adev->dev, "Failed to upload overdrive table!\n");
+				drm_err(adev_to_drm(adev), "Failed to upload overdrive table!\n");
 				return ret;
 			}
 
@@ -2847,7 +2847,7 @@ static int smu_v13_0_0_i2c_control_init(struct smu_context *smu)
 
 		res = i2c_add_adapter(control);
 		if (res) {
-			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			drm_err(adev_to_drm(adev), "Failed to register hw i2c, err: %d\n", res);
 			goto Out_err;
 		}
 	}
@@ -3066,7 +3066,7 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
 					smu_table->ecc_table,
 					false);
 	if (ret) {
-		dev_info(adev->dev, "Failed to export SMU ecc table!\n");
+		drm_info(adev_to_drm(adev), "Failed to export SMU ecc table!\n");
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index b081ae3e8f43c..eab1c793bb7ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1018,7 +1018,7 @@ static int smu_v13_0_4_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 		return 0;
 	default:
-		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		drm_err(adev_to_drm(adev), "Invalid performance level %d\n", level);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index f5db181ef489a..439d94ad1e625 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -1037,13 +1037,13 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 		smu_v13_0_5_get_dpm_profile_freq(smu, level, SMU_DCLK, &dclk_min, &dclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
-		dev_err(adev->dev, "The performance level profile_min_mclk is not supported.");
+		drm_err(adev_to_drm(adev), "The performance level profile_min_mclk is not supported.");
 		return -EOPNOTSUPP;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 		return 0;
 	default:
-		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		drm_err(adev_to_drm(adev), "Invalid performance level %d\n", level);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9aab77127d888..37ae0e2f0a031 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -571,7 +571,7 @@ static int smu_v13_0_6_select_policy_soc_pstate(struct smu_context *smu,
 					      param, NULL);
 
 	if (ret)
-		dev_err(adev->dev, "select soc pstate policy %d failed",
+		drm_err(adev_to_drm(adev), "select soc pstate policy %d failed",
 			policy);
 
 	return ret;
@@ -605,7 +605,7 @@ static int smu_v13_0_6_select_plpd_policy(struct smu_context *smu, int level)
 			smu, SMU_MSG_SelectPLPDMode, param, NULL);
 
 	if (ret)
-		dev_err(adev->dev,
+		drm_err(adev_to_drm(adev),
 			"select xgmi per-link power down policy %d failed\n",
 			level);
 
@@ -2017,7 +2017,7 @@ static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu,
 			ret = smu_cmn_send_smc_msg_with_param(
 				smu, SMU_MSG_EnableDeterminism, max, NULL);
 			if (ret) {
-				dev_err(adev->dev,
+				drm_err(adev_to_drm(adev),
 					"Failed to enable determinism at GFX clock %d MHz\n",
 					max);
 			} else {
@@ -2357,7 +2357,7 @@ static int smu_v13_0_6_i2c_control_init(struct smu_context *smu)
 
 		res = i2c_add_adapter(control);
 		if (res) {
-			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			drm_err(adev_to_drm(adev), "Failed to register hw i2c, err: %d\n", res);
 			goto Out_err;
 		}
 	}
@@ -2438,14 +2438,14 @@ static void smu_v13_0_6_log_thermal_throttling_event(struct smu_context *smu)
 				"%s%s", throttling_events > 1 ? " and " : "",
 				throttling_logging_label[throttler_idx]);
 			if (buf_idx >= sizeof(log_buf)) {
-				dev_err(adev->dev, "buffer overflow!\n");
+				drm_err(adev_to_drm(adev), "buffer overflow!\n");
 				log_buf[sizeof(log_buf) - 1] = '\0';
 				break;
 			}
 		}
 	}
 
-	dev_warn(adev->dev,
+	drm_warn(adev_to_drm(adev),
 		 "WARN: GPU is throttled, expect performance decrease. %s.\n",
 		 log_buf);
 	kgd2kfd_smi_event_throttle(
@@ -2749,7 +2749,7 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	mutex_unlock(&smu->message_lock);
 
 	if (ret)
-		dev_err(adev->dev, "failed to send mode2 reset, error code %d",
+		drm_err(adev_to_drm(adev), "failed to send mode2 reset, error code %d",
 			ret);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c8f4f6fb40834..62fd384d43430 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1602,7 +1602,7 @@ static int smu_v13_0_7_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 	default:
-		dev_info(adev->dev, "Invalid table index: %ld\n", input);
+		drm_info(adev_to_drm(adev), "Invalid table index: %ld\n", input);
 		return -EINVAL;
 	}
 
@@ -1626,13 +1626,14 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 	switch (type) {
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
-			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "GFXCLK_LIMITS setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
 			if (i + 2 > size) {
-				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+				drm_info(adev_to_drm(adev),
+					"invalid number of input parameters %d\n", size);
 				return -EINVAL;
 			}
 
@@ -1644,7 +1645,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "GfxclkFmin (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev),
+						"GfxclkFmin (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -1660,7 +1662,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "GfxclkFmax (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev),
+						"GfxclkFmax (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -1670,14 +1673,16 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 				break;
 
 			default:
-				dev_info(adev->dev, "Invalid SCLK_VDDC_TABLE index: %ld\n", input[i]);
-				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
+				drm_info(adev_to_drm(adev),
+					"Invalid SCLK_VDDC_TABLE index: %ld\n", input[i]);
+				drm_info(adev_to_drm(adev),
+					"Supported indices: [0:min,1:max]\n");
 				return -EINVAL;
 			}
 		}
 
 		if (od_table->OverDriveTable.GfxclkFmin > od_table->OverDriveTable.GfxclkFmax) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Invalid setting: GfxclkFmin(%u) is bigger than GfxclkFmax(%u)\n",
 				(uint32_t)od_table->OverDriveTable.GfxclkFmin,
 				(uint32_t)od_table->OverDriveTable.GfxclkFmax);
@@ -1687,13 +1692,14 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
-			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "UCLK_LIMITS setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
 			if (i + 2 > size) {
-				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+				drm_info(adev_to_drm(adev),
+					"invalid number of input parameters %d\n", size);
 				return -EINVAL;
 			}
 
@@ -1705,7 +1711,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "UclkFmin (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev),
+						"UclkFmin (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -1721,7 +1728,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "UclkFmax (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev),
+						"UclkFmax (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -1731,14 +1739,16 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 				break;
 
 			default:
-				dev_info(adev->dev, "Invalid MCLK_VDDC_TABLE index: %ld\n", input[i]);
-				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
+				drm_info(adev_to_drm(adev),
+					"Invalid MCLK_VDDC_TABLE index: %ld\n", input[i]);
+				drm_info(adev_to_drm(adev),
+					"Supported indices: [0:min,1:max]\n");
 				return -EINVAL;
 			}
 		}
 
 		if (od_table->OverDriveTable.UclkFmin > od_table->OverDriveTable.UclkFmax) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Invalid setting: UclkFmin(%u) is bigger than UclkFmax(%u)\n",
 				(uint32_t)od_table->OverDriveTable.UclkFmin,
 				(uint32_t)od_table->OverDriveTable.UclkFmax);
@@ -1748,7 +1758,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_VDDGFX_OFFSET:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
-			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Gfx offset setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1758,7 +1768,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "Voltage offset (%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev),
+				"Voltage offset (%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1770,7 +1781,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_CURVE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1784,7 +1795,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[1] < minimum ||
 		    input[1] > maximum) {
-			dev_info(adev->dev, "Fan curve temp setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev),
+				"Fan curve temp setting(%ld) must be within [%d, %d]!\n",
 				 input[1], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1795,7 +1807,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[2] < minimum ||
 		    input[2] > maximum) {
-			dev_info(adev->dev, "Fan curve pwm setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "Fan curve pwm setting(%ld) must be within [%d, %d]!\n",
 				 input[2], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1808,7 +1820,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1818,7 +1830,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "acoustic limit threshold setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev),
+				"acoustic limit threshold setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1830,7 +1843,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1840,7 +1853,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "acoustic target threshold setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev),
+				"acoustic target threshold setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1852,7 +1866,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1862,7 +1876,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "fan target temperature setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev),
+				"fan target temperature setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1874,7 +1889,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1884,7 +1899,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "fan minimum pwm setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev),
+				"fan minimum pwm setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1896,7 +1912,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
-			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Zero RPM setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1906,7 +1922,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "zero RPM enable setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev),
+				"zero RPM enable setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1917,7 +1934,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
 		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
-			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Zero RPM setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -1927,7 +1944,8 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "zero RPM stop temperature setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev),
+				"zero RPM stop temperature setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -1966,7 +1984,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
 
 			ret = smu_v13_0_7_upload_overdrive_table(smu, od_table);
 			if (ret) {
-				dev_err(adev->dev, "Failed to upload overdrive table!\n");
+				drm_err(adev_to_drm(adev), "Failed to upload overdrive table!\n");
 				return ret;
 			}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 73b4506ef5a87..1c72d5b782cbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -274,7 +274,7 @@ static int yellow_carp_post_smu_init(struct smu_context *smu)
 	/* allow message will be sent after enable message on Yellow Carp*/
 	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
 	if (ret)
-		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
+		drm_err(adev_to_drm(adev), "Failed to Enable GfxOff!\n");
 	return ret;
 }
 
@@ -1251,7 +1251,7 @@ static int yellow_carp_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 		return 0;
 	default:
-		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		drm_err(adev_to_drm(adev), "Invalid performance level %d\n", level);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 1271a207956b2..34510be7816c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -180,7 +180,7 @@ int smu_v14_0_init_pptable_microcode(struct smu_context *smu)
 	/* override pptable_id from driver parameter */
 	if (amdgpu_smu_pptable_id >= 0) {
 		pptable_id = amdgpu_smu_pptable_id;
-		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
+		drm_info(adev_to_drm(adev), "override pptable id %d\n", pptable_id);
 	} else {
 		pptable_id = smu->smu_table.boot_values.pp_table_id;
 	}
@@ -256,7 +256,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
 		break;
 	default:
-		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
+		drm_err(adev_to_drm(adev), "smu unsupported IP version: 0x%x.\n",
 			amdgpu_ip_version(adev, MP1_HWIP, 0));
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_INV;
 		break;
@@ -275,11 +275,11 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 	 * of halt driver loading.
 	 */
 	if (if_version != smu->smc_driver_if_version) {
-		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
+		drm_info(adev_to_drm(adev), "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
 			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-		dev_info(adev->dev, "SMU driver if version not matched\n");
+		drm_info(adev_to_drm(adev), "SMU driver if version not matched\n");
 	}
 
 	return ret;
@@ -334,7 +334,7 @@ static int smu_v14_0_get_pptable_from_vbios(struct smu_context *smu, void **tabl
 	uint8_t frev, crev;
 	int ret, index;
 
-	dev_info(adev->dev, "use vbios provided pptable\n");
+	drm_info(adev_to_drm(adev), "use vbios provided pptable\n");
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    powerplayinfo);
 
@@ -363,12 +363,12 @@ int smu_v14_0_get_pptable_from_firmware(struct smu_context *smu,
 	if (!hdr)
 		return -EINVAL;
 
-	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
+	drm_info(adev_to_drm(adev), "use driver provided pptable %d\n", pptable_id);
 
 	version_major = le16_to_cpu(hdr->header.header_version_major);
 	version_minor = le16_to_cpu(hdr->header.header_version_minor);
 	if (version_major != 2) {
-		dev_err(adev->dev, "Unsupported smu firmware version %d.%d\n",
+		drm_err(adev_to_drm(adev), "Unsupported smu firmware version %d.%d\n",
 			version_major, version_minor);
 		return -EINVAL;
 	}
@@ -398,7 +398,7 @@ int smu_v14_0_setup_pptable(struct smu_context *smu)
 	/* override pptable_id from driver parameter */
 	if (amdgpu_smu_pptable_id >= 0) {
 		pptable_id = amdgpu_smu_pptable_id;
-		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
+		drm_info(adev_to_drm(adev), "override pptable id %d\n", pptable_id);
 	} else {
 		pptable_id = smu->smu_table.boot_values.pp_table_id;
 	}
@@ -1324,7 +1324,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 		return 0;
 	default:
-		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		drm_err(adev_to_drm(adev), "Invalid performance level %d\n", level);
 		return -EINVAL;
 	}
 
@@ -1545,7 +1545,8 @@ int smu_v14_0_set_single_dpm_table(struct smu_context *smu,
 						      i,
 						      &clk);
 		if (ret) {
-			dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
+			dev_err(smu->adev->dev,
+				"[%s] failed to get dpm freq by index!\n", __func__);
 			return ret;
 		}
 
@@ -1656,7 +1657,8 @@ int smu_v14_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_GFXCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_GFXCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s GFXCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -1664,7 +1666,8 @@ int smu_v14_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_UCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_UCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s UCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -1672,7 +1675,8 @@ int smu_v14_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_FCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_FCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s FCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -1680,7 +1684,8 @@ int smu_v14_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_SOCCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_SOCCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s SOCCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -1688,7 +1693,8 @@ int smu_v14_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_LCLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_LCLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s LCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -1696,7 +1702,8 @@ int smu_v14_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_VCN_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_VCN_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s VCN DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s VCN DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -1704,7 +1711,8 @@ int smu_v14_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_MP0CLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_MP0CLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s MP0/MPIOCLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s MP0/MPIOCLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
@@ -1712,7 +1720,8 @@ int smu_v14_0_deep_sleep_control(struct smu_context *smu,
 	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DS_MP1CLK_BIT)) {
 		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DS_MP1CLK_BIT, enablement);
 		if (ret) {
-			dev_err(adev->dev, "Failed to %s MP1CLK DS!\n", enablement ? "enable" : "disable");
+			drm_err(adev_to_drm(adev),
+				"Failed to %s MP1CLK DS!\n", enablement ? "enable" : "disable");
 			return ret;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 84f9b007b59f2..0add8a7820bad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1418,7 +1418,7 @@ static int smu_v14_0_common_set_performance_level(struct smu_context *smu,
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 		return 0;
 	default:
-		dev_err(adev->dev, "Invalid performance level %d\n", level);
+		drm_err(adev_to_drm(adev), "Invalid performance level %d\n", level);
 		return -EINVAL;
 	}
 
@@ -1598,14 +1598,14 @@ static int smu_v14_0_1_init_mall_power_gating(struct smu_context *smu, enum smu_
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerController,
 								SMU_MALL_PMFW_CONTROL, NULL);
 		if (ret) {
-			dev_err(adev->dev, "Init MALL PMFW CONTROL Failure\n");
+			drm_err(adev_to_drm(adev), "Init MALL PMFW CONTROL Failure\n");
 			return ret;
 		}
 	} else {
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerController,
 								SMU_MALL_DRIVER_CONTROL, NULL);
 		if (ret) {
-			dev_err(adev->dev, "Init MALL Driver CONTROL Failure\n");
+			drm_err(adev_to_drm(adev), "Init MALL Driver CONTROL Failure\n");
 			return ret;
 		}
 
@@ -1613,14 +1613,14 @@ static int smu_v14_0_1_init_mall_power_gating(struct smu_context *smu, enum smu_
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerState,
 									SMU_MALL_EXIT_PG, NULL);
 			if (ret) {
-				dev_err(adev->dev, "EXIT MALL PG Failure\n");
+				drm_err(adev_to_drm(adev), "EXIT MALL PG Failure\n");
 				return ret;
 			}
 		} else if (pg_config == SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_OFF) {
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_MALLPowerState,
 									SMU_MALL_ENTER_PG, NULL);
 			if (ret) {
-				dev_err(adev->dev, "Enter MALL PG Failure\n");
+				drm_err(adev_to_drm(adev), "Enter MALL PG Failure\n");
 				return ret;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 82c2db972491d..a44a57f2bd4f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2061,7 +2061,7 @@ static int smu_v14_0_2_i2c_control_init(struct smu_context *smu)
 
 		res = i2c_add_adapter(control);
 		if (res) {
-			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			drm_err(adev_to_drm(adev), "Failed to register hw i2c, err: %d\n", res);
 			goto Out_err;
 		}
 	}
@@ -2453,7 +2453,7 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	default:
-		dev_info(adev->dev, "Invalid table index: %ld\n", input);
+		drm_info(adev_to_drm(adev), "Invalid table index: %ld\n", input);
 		return -EINVAL;
 	}
 
@@ -2477,12 +2477,12 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 	switch (type) {
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
-			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "GFXCLK_LIMITS setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
 		if (size != 1) {
-			dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+			drm_info(adev_to_drm(adev), "invalid number of input parameters %d\n", size);
 			return -EINVAL;
 		}
 
@@ -2492,7 +2492,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "GfxclkFoffset must be within [%d, %u]!\n",
+			drm_info(adev_to_drm(adev), "GfxclkFoffset must be within [%d, %u]!\n",
 				 minimum, maximum);
 			return -EINVAL;
 		}
@@ -2503,13 +2503,13 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
-			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "UCLK_LIMITS setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
 		for (i = 0; i < size; i += 2) {
 			if (i + 2 > size) {
-				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+				drm_info(adev_to_drm(adev), "invalid number of input parameters %d\n", size);
 				return -EINVAL;
 			}
 
@@ -2521,7 +2521,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "UclkFmin (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev), "UclkFmin (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -2537,7 +2537,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 								  &maximum);
 				if (input[i + 1] < minimum ||
 				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "UclkFmax (%ld) must be within [%u, %u]!\n",
+					drm_info(adev_to_drm(adev), "UclkFmax (%ld) must be within [%u, %u]!\n",
 						input[i + 1], minimum, maximum);
 					return -EINVAL;
 				}
@@ -2547,14 +2547,14 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 				break;
 
 			default:
-				dev_info(adev->dev, "Invalid MCLK_VDDC_TABLE index: %ld\n", input[i]);
-				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
+				drm_info(adev_to_drm(adev), "Invalid MCLK_VDDC_TABLE index: %ld\n", input[i]);
+				drm_info(adev_to_drm(adev), "Supported indices: [0:min,1:max]\n");
 				return -EINVAL;
 			}
 		}
 
 		if (od_table->OverDriveTable.UclkFmin > od_table->OverDriveTable.UclkFmax) {
-			dev_err(adev->dev,
+			drm_err(adev_to_drm(adev),
 				"Invalid setting: UclkFmin(%u) is bigger than UclkFmax(%u)\n",
 				(uint32_t)od_table->OverDriveTable.UclkFmin,
 				(uint32_t)od_table->OverDriveTable.UclkFmax);
@@ -2564,7 +2564,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_VDDGFX_OFFSET:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
-			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Gfx offset setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -2574,7 +2574,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "Voltage offset (%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "Voltage offset (%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -2586,7 +2586,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_CURVE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -2600,7 +2600,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[1] < minimum ||
 		    input[1] > maximum) {
-			dev_info(adev->dev, "Fan curve temp setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "Fan curve temp setting(%ld) must be within [%d, %d]!\n",
 				 input[1], minimum, maximum);
 			return -EINVAL;
 		}
@@ -2611,7 +2611,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[2] < minimum ||
 		    input[2] > maximum) {
-			dev_info(adev->dev, "Fan curve pwm setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "Fan curve pwm setting(%ld) must be within [%d, %d]!\n",
 				 input[2], minimum, maximum);
 			return -EINVAL;
 		}
@@ -2624,7 +2624,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -2634,7 +2634,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "acoustic limit threshold setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "acoustic limit threshold setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -2646,7 +2646,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_ACOUSTIC_TARGET:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -2656,7 +2656,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "acoustic target threshold setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "acoustic target threshold setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -2668,7 +2668,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -2678,7 +2678,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "fan target temperature setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "fan target temperature setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -2690,7 +2690,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
-			dev_warn(adev->dev, "Fan curve setting not supported!\n");
+			drm_warn(adev_to_drm(adev), "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
 
@@ -2700,7 +2700,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "fan minimum pwm setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "fan minimum pwm setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -2722,7 +2722,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 						  &maximum);
 		if (input[0] < minimum ||
 		    input[0] > maximum) {
-			dev_info(adev->dev, "zero RPM enable setting(%ld) must be within [%d, %d]!\n",
+			drm_info(adev_to_drm(adev), "zero RPM enable setting(%ld) must be within [%d, %d]!\n",
 				 input[0], minimum, maximum);
 			return -EINVAL;
 		}
@@ -2760,7 +2760,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 			ret = smu_v14_0_2_upload_overdrive_table(smu, od_table);
 			if (ret) {
-				dev_err(adev->dev, "Failed to upload overdrive table!\n");
+				drm_err(adev_to_drm(adev), "Failed to upload overdrive table!\n");
 				return ret;
 			}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 80eb1a03b3cac..d5a06c5ca6a36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -316,7 +316,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 		return 0;
 
 	if (smu->smc_fw_state == SMU_FW_HANG) {
-		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
+		drm_err(adev_to_drm(adev), "SMU is in hanged state, failed to send smu message!\n");
 		res = -EREMOTEIO;
 		goto Out;
 	}
@@ -432,7 +432,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	}
 
 	if (smu->smc_fw_state == SMU_FW_HANG) {
-		dev_err(adev->dev, "SMU is in hanged state, failed to send smu message!\n");
+		drm_err(adev_to_drm(adev), "SMU is in hanged state, failed to send smu message!\n");
 		res = -EREMOTEIO;
 		goto Out;
 	} else if (smu->smc_fw_state == SMU_FW_INIT) {
@@ -611,7 +611,7 @@ int smu_cmn_feature_is_enabled(struct smu_context *smu,
 	int feature_id;
 
 	if (__smu_get_enabled_features(smu, &enabled_features)) {
-		dev_err(adev->dev, "Failed to retrieve enabled ppfeatures!\n");
+		drm_err(adev_to_drm(adev), "Failed to retrieve enabled ppfeatures!\n");
 		return 0;
 	}
 
-- 
2.43.0

