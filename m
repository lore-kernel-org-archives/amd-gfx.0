Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997D9C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 12:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27668112C10;
	Tue, 16 Apr 2024 12:08:13 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0998112C01
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 12:08:11 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 43GC86UE607316; Tue, 16 Apr 2024 17:38:06 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 43GC86K3607315;
 Tue, 16 Apr 2024 17:38:06 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 0/6] Infrastructure to dump ip registers in devcoredump
Date: Tue, 16 Apr 2024 17:37:58 +0530
Message-Id: <20240416120804.607272-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

starting with gfx 10 registers here we add the complete infra for ip
dump needed in devcoredump.

Sunil Khatri (6):
  drm/amdgpu: add prototype for ip dump
  drm/amdgpu: add support of gfx10 register dump
  drm/amdgpu: add protype for print ip state
  drm/amdgpu: add support for gfx v10 print
  drm/amdgpu: dump ip state before reset for each ip
  drm/amdgpu: add ip dump for each ip in devcoredump

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  15 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/cik.c              |   2 +
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   2 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 146 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   2 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   2 +
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |   4 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |   2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   2 +
 drivers/gpu/drm/amd/amdgpu/si.c               |   2 +
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   2 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |   4 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/vi.c               |   2 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   3 +
 .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   2 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   2 +
 69 files changed, 327 insertions(+)

-- 
2.34.1

