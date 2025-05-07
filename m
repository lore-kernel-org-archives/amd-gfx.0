Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF143C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 09:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E45010E770;
	Wed,  7 May 2025 09:29:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8516D10E770
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 09:29:43 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 5479TZ8w701134; Wed, 7 May 2025 14:59:35 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 5479TZr1701133;
 Wed, 7 May 2025 14:59:35 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix the indentation
Date: Wed,  7 May 2025 14:59:34 +0530
Message-Id: <20250507092934.701120-1-sunil.khatri@amd.com>
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

fix the indentation
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:6992 gfx_v11_ip_dump

compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202505071619.7sHTLpNg-lkp@intel.com/

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3f4ee4b3b0a4..fe21393e155d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -7094,9 +7094,12 @@ static void gfx_v11_ip_dump(struct amdgpu_ip_block *ip_block)
 				/* ME0 is for GFX so start from 1 for CP */
 				soc21_grbm_select(adev, adev->gfx.me.num_me + i, j, k, 0);
 				for (reg = 0; reg < reg_count; reg++) {
-					if (i && gc_cp_reg_list_11[reg].reg_offset == regCP_MEC_ME1_HEADER_DUMP)
-					adev->gfx.ip_dump_compute_queues[index + reg] =
-						RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC_ME2_HEADER_DUMP));
+					if (i &&
+					    gc_cp_reg_list_11[reg].reg_offset ==
+						    regCP_MEC_ME1_HEADER_DUMP)
+						adev->gfx.ip_dump_compute_queues[index + reg] =
+							RREG32(SOC15_REG_OFFSET(GC, 0,
+							regCP_MEC_ME2_HEADER_DUMP));
 					else
 						adev->gfx.ip_dump_compute_queues[index + reg] =
 							RREG32(SOC15_REG_ENTRY_OFFSET(
-- 
2.34.1

