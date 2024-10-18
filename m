Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF33D3000A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 13:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C60E10E91B;
	Fri, 18 Oct 2024 13:23:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D4C10E915
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 13:23:43 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 49IDNdxM1638273; Fri, 18 Oct 2024 18:53:39 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 49IDNcgn1638272;
 Fri, 18 Oct 2024 18:53:38 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v6 00/12] validate/clean the functions of ip funcs
Date: Fri, 18 Oct 2024 18:53:15 +0530
Message-Id: <20241018132327.1638247-1-sunil.khatri@amd.com>
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

v6: Fixed the missing return statement on suspend and update the code
    with V5 comments.

v5: Fixed review comments. Dropped hw_fini patch and need to look
    further why such functions exists. hw_init/hw_fini are mandatory
    functions and we should have a valid definition.

v4: hw_init/hw_fini functions are mandatory and raise error message if
    these functions are not defined.

v3: Added 2 new patches to clean get_clocking_state and hw_init
    validation.

Sunil Khatri (12):
  drm/amdgpu: validate hw_fini before function call
  drm/amdgpu: return error if phase2 suspend fails
  drm/amdgpu: return error on suspend failure
  drm/amdgpu: validate suspend before function call
  drm/amdgpu: validate resume before function call
  drm/amdgpu: validate wait_for_idle before function call
  drm/amdgpu: clean the dummy resume functions
  drm/amdgpu: clean the dummy suspend functions
  drm/amdgpu: clean the dummy wait_for_idle functions
  drm/amdgpu: clean the dummy soft_reset functions
  drm/amdgpu: Clean the functions pointer set as NULL
  drm/amdgpu: clean unused functions of uvd/vcn/vce

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  16 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 150 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  25 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   2 -
 drivers/gpu/drm/amd/amdgpu/cik.c              |  15 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   3 -
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   3 -
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   3 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   9 -
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   9 -
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   9 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   9 -
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   9 -
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   2 -
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   6 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   6 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   6 -
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 -
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 -
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   3 -
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   3 -
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   3 -
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   3 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   7 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  14 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   7 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   7 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   7 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   7 -
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   7 -
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 -
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   3 -
 drivers/gpu/drm/amd/amdgpu/nv.c               |  14 -
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   3 -
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   3 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   1 -
 drivers/gpu/drm/amd/amdgpu/si.c               |  21 --
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   3 -
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   3 -
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  30 +-
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  20 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  14 -
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  14 -
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  12 -
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   3 -
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   3 -
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   3 -
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   3 -
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   3 -
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 275 ------------------
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   3 -
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   3 -
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 274 -----------------
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   5 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   5 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  10 -
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   5 -
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   5 -
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   5 -
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   5 -
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   5 -
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   1 -
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   1 -
 drivers/gpu/drm/amd/amdgpu/vi.c               |  14 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 -
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  15 -
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   8 -
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  14 -
 78 files changed, 114 insertions(+), 1122 deletions(-)

-- 
2.34.1

