Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD091CEDDA0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 14:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B6010E74D;
	Wed,  9 Oct 2024 14:25:29 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68AA910E73C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 14:25:18 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 499EPAlu891912; Wed, 9 Oct 2024 19:55:10 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 499EP9Rl891911;
 Wed, 9 Oct 2024 19:55:09 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 00/13] Code clean up for function pointers
Date: Wed,  9 Oct 2024 19:54:49 +0530
Message-Id: <20241009142502.891864-1-sunil.khatri@amd.com>
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

Validate the function pointers and clean up the unused or dummy
functions.

Sunil Khatri (13):
  drm/amdgpu: validate sw_init before function call
  drm/amdgpu: clean the dummy sw_init functions
  drm/amdgpu: validate sw_fini before function call
  drm/amdgpu: clean the dummy sw_fini functions
  drm/amdgpu: validate hw_fini before function call
  drm/amdgpu: validate suspend before function call
  drm/amdgpu: validate resume before function call
  drm/amdgpu: validate wait_for_idle before function call
  drm/amdgpu: clean the dummy resume functions
  drm/amdgpu: clean the dummy suspend functions
  drm/amdgpu: clean the dummy hw_fini functions
  drm/amdgpu: clean the dummy wait_for_idle functions
  drm/amdgpu: clean the dummy soft_reset functions

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  38 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  12 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 131 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  34 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  21 +--
 drivers/gpu/drm/amd/amdgpu/cik.c              |  30 +---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   6 -
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   6 -
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   6 -
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   6 -
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   6 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   6 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   6 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   6 -
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  11 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  18 ---
 drivers/gpu/drm/amd/amdgpu/si.c               |  37 -----
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  43 +++---
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  29 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  12 --
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  18 ---
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  18 ---
 drivers/gpu/drm/amd/amdgpu/vi.c               |  18 ---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  13 --
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   6 -
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  12 --
 27 files changed, 150 insertions(+), 411 deletions(-)

-- 
2.34.1

