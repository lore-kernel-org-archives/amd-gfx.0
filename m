Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95512CE8350
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1068310E51F;
	Mon, 30 Sep 2024 14:32:27 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5522010E519
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:32:20 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48UEWEvY2682317; Mon, 30 Sep 2024 20:02:14 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48UEWEnL2682316;
 Mon, 30 Sep 2024 20:02:14 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 00/12] update the handle ptr for reset of the functions
Date: Mon, 30 Sep 2024 20:00:07 +0530
Message-Id: <20240930143019.2682202-1-sunil.khatri@amd.com>
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

*** BLURB HERE ***

Sunil Khatri (12):
  drm/amdgpu: remove the dummy fn acp_early_init
  drm/amdgpu: update the handle ptr in late_fini
  drm/amdgpu: update the handle ptr in prepare_suspend
  drm/amdgpu: update the handle ptr in check_soft_reset
  drm/amdgpu: update the handle ptr in pre_soft_reset
  drm/amdgpu: update the handle ptr in soft_reset
  drm/amdgpu: update the handle ptr in post_soft_reset
  drm/amdgpu: update the handle ptr in wait_for_idle
  drm/amdgpu: update the handle ptr in suspend
  drm/amdgpu: update the handle ptr in resume
  drm/amdgpu: update the handle ptr in hw_init
  drm/amdgpu: update the handle ptr in hw_fini

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       | 33 ++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 45 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       | 17 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 16 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 20 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      | 23 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       | 20 ++++----
 drivers/gpu/drm/amd/amdgpu/cik.c              | 22 ++++----
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           | 30 +++++------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         | 32 +++++-------
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            | 30 +++++------
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 30 +++++------
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 24 ++++-----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 33 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 20 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 28 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 28 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 40 +++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 25 ++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        | 25 ++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        | 25 ++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         | 41 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         | 31 +++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 51 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 25 ++++-----
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       | 30 +++++------
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          | 26 ++++------
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          | 26 ++++------
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          | 26 ++++------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 32 ++++++------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 30 +++++------
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        | 26 ++++------
 drivers/gpu/drm/amd/amdgpu/nv.c               | 24 ++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        | 30 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 40 +++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 26 ++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 30 +++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 32 +++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 32 +++++-------
 drivers/gpu/drm/amd/amdgpu/si.c               | 22 ++++----
 drivers/gpu/drm/amd/amdgpu/si_dma.c           | 31 +++++------
 drivers/gpu/drm/amd/amdgpu/si_ih.c            | 32 +++++-------
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  6 +--
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 24 ++++-----
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 24 ++++-----
 drivers/gpu/drm/amd/amdgpu/soc24.c            | 24 ++++-----
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         | 48 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         | 33 ++++++------
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         | 33 ++++++------
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         | 33 ++++++------
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         | 47 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 45 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         | 35 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         | 51 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 40 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         | 25 +++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 26 +++++-----
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        | 28 ++++------
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        | 26 ++++------
 drivers/gpu/drm/amd/amdgpu/vi.c               | 24 ++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++----
 drivers/gpu/drm/amd/include/amd_shared.h      | 22 ++++----
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 20 ++++----
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 20 ++++----
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 26 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 ++++-----
 89 files changed, 1115 insertions(+), 1332 deletions(-)

-- 
2.34.1

