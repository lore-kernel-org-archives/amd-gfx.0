Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3092C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453A810E169;
	Thu, 27 Mar 2025 20:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kSQWU8Y0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB4110E942
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A2F561129;
 Thu, 27 Mar 2025 20:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A3DC4CEDD;
 Thu, 27 Mar 2025 20:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107948;
 bh=0RmU19BSy7B1QY0+iLZrTdvWtWmjCA/8JRQuqcYY2vY=;
 h=From:To:Cc:Subject:Date:From;
 b=kSQWU8Y0ohxzUNF5u0Bk+z7g6fYsdF52evOAPKPgck1URs1X0DwOuWGNBi1879OCJ
 2i8ez0hGBfS0p5OQ4PsQa7Ph8L4SyvO9NvZCJIAJba/aFAHcIuyqMsW69DwR05oTri
 o5UO64Le9qDzzrvOOj+lbnd0QPdG2G+VNTJUFkmIpi4vCfeWIygqvCoeu2jkLGcwLI
 6zDi6h68flfcmNFZPB7BrS10RdzgVn44JEslIRXd07xHPBXkYyx3dZOKKtL5MCmHXJ
 nZGOZjuIlVdlq7V7e+31hdazz60Nkm1zprnq32NjDBtN0+2Sv77NjKpZzOLhPjnK1W
 zE2x3MFEOJ3cQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 00/14] Convert more of amdgpu to drm_*() macros
Date: Thu, 27 Mar 2025 15:38:44 -0500
Message-ID: <20250327203858.3796086-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

Several commits have gone in various parts of the driver already to
convert from DRM_*() and pr_*() to drm_*() macros, but a lot of places
are also still missing.

This updates a lot more of the driver. Patch 13 is the biggest one,
others are small tidbits and changes to some of of specific callers
to make sure that they have struct amdgpu_device* or similar available
to be able to use drm_*() macros.

Mario Limonciello (14):
  drm/amd: Use ACPI macros for amdgpu_acpi
  drm/amd: Avoid showing an error about memory allocation in
    amdgpu_acpi_enumerate_xcc()
  drm/amd: Convert dev_err_once() messages to drm_err_once()
  drm/amd: Adjust amdgpu_vpe messages from dev_*() to drm_*()
  drm/amd: Adjust atombios parser messages from DRM_*() to drm_*()
  drm/amd: Drop prototype for amdgpu_ucode_print_imu_hdr()
  drm/amd: Add a 'struct amdgpu_device' argument to all header printers
  drm/amd: Use drm_*() macros for all amdgpu_ucode prints
  drm/amd: Adjust amdgpu connector messages from DRM_*() to drm_*()
  drm/amd: Adjust amdgpu_atombios messages from DRM_*() to drm_*()
  drm/amd: Add struct amdgpu_device into amdgpu_gfx_parse_disable_cu()
  drm/amd: Add struct amdgpu_device argument to
    amdgpu_reset_create_reset_domain()
  drm/amd: Convert DRM_*() and dev_*() macros to drm_*()
  drm/amd: Drop 'amdgpu' from pr_fmt()

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  12 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  22 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   2 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |  16 +-
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 284 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 102 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  81 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  21 +-
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    |  14 +-
 .../drm/amd/amdgpu/amdgpu_fw_attestation.c    |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  78 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  58 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  56 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 236 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c    |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  96 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  48 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c  |  34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |   8 +-
 .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c     |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  58 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 480 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  62 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  42 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  57 ++-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   8 +-
 drivers/gpu/drm/amd/amdgpu/atom.c             |  62 ++-
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c    |  16 +-
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c      |  18 +-
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  30 +-
 drivers/gpu/drm/amd/amdgpu/atombios_i2c.c     |   5 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |  14 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  36 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  40 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  40 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  38 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c          |   6 +-
 drivers/gpu/drm/amd/amdgpu/df_v4_3.c          |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 106 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 140 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  96 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  32 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  34 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  56 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  92 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c         |  26 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       |  60 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  56 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c   |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c     |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c      |  14 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c    |  14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  16 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  16 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  34 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  28 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  40 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  48 +-
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
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  48 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  52 +-
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
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  24 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  18 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  20 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  26 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |  26 +-
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  34 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  16 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c       |  10 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |   6 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c         |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  60 +--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  18 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  10 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  10 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   8 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  56 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  26 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  86 ++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c    |   2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   4 +-
 .../drm/amd/pm/powerplay/hwmgr/common_baco.c  |   2 +-
 .../gpu/drm/amd/pm/powerplay/inc/pp_debug.h   |   2 +-
 .../drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |   2 +-
 .../amd/pm/powerplay/smumgr/smu10_smumgr.c    |   4 +-
 .../drm/amd/pm/powerplay/smumgr/smu7_smumgr.c |   2 +-
 .../drm/amd/pm/powerplay/smumgr/smu9_smumgr.c |   2 +-
 .../amd/pm/powerplay/smumgr/vega20_smumgr.c   |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 106 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   8 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   8 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |   2 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  14 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  37 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  70 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |   2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |   4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  16 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  84 +--
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   4 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  47 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  10 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  54 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   6 +-
 242 files changed, 2886 insertions(+), 2767 deletions(-)

-- 
2.43.0

