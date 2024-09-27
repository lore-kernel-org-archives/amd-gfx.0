Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863F4CEBF8D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 09:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 109C310ECA9;
	Fri, 27 Sep 2024 09:57:57 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7F910ECAA
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 09:57:55 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 48R9voqC2191272; Fri, 27 Sep 2024 15:27:50 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 48R9vnnN2191271;
 Fri, 27 Sep 2024 15:27:49 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 0/5] Update the *handle with ip_block ptr
Date: Fri, 27 Sep 2024 15:27:39 +0530
Message-Id: <20240927095744.2191253-1-sunil.khatri@amd.com>
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

Update for function ptrs early_init, late_init, sw_init, sw_fini,
early_fini



Sunil Khatri (5):
  drm/amdgpu: update the handle ptr in early_init
  drm/amdgpu: update the handle ptr in late_init
  drm/amdgpu: update the handle ptr in sw_init
  drm/amdgpu: update the handle ptr in sw_fini
  drm/amdgpu: update the handle ptr in early_fini

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       | 10 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 14 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  9 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/cik.c              |  8 +++----
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 22 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.h        |  6 ++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/nv.c               | 14 ++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/si.c               |  8 +++----
 drivers/gpu/drm/amd/amdgpu/si_dma.c           | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/si_ih.c            | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 16 +++++++-------
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 14 ++++++------
 drivers/gpu/drm/amd/amdgpu/soc24.c            | 14 ++++++------
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         | 18 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        | 12 +++++-----
 drivers/gpu/drm/amd/amdgpu/vi.c               | 14 ++++++------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++++++----------
 drivers/gpu/drm/amd/include/amd_shared.h      | 10 ++++-----
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 17 +++++++-------
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 16 +++++++-------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 17 +++++++-------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 18 +++++++--------
 90 files changed, 579 insertions(+), 578 deletions(-)

-- 
2.34.1

