Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD683C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 21 May 2022 12:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A1710E18A;
	Sat, 21 May 2022 12:58:38 +0000 (UTC)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABE010E06B;
 Sat, 21 May 2022 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inria.fr; s=dc;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DBF9ohV4otpuGSHfHZntI72hMP00p782/T0/NTleeqA=;
 b=DMwrt9IZ7FU5osZ7B893TE650+L6ZQd5ywFX7cDfiJ/2Z6WHkwvG6cBx
 BhZu/txqRZYM+NL6AumAtl2XwjxXM/rGXP5Rj//0SWHcdk+6z6AEVQQJ6
 QKnB6GOuNjYdobpG4E0WM1I30KfKffu12cWxZhvOYMQzDfT3Jy7EAxxr5 o=;
Authentication-Results: mail3-relais-sop.national.inria.fr;
 dkim=none (message not signed) header.i=none;
 spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr;
 dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; d="scan'208";a="14727969"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:03 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx: fix typos in comments
Date: Sat, 21 May 2022 13:11:14 +0200
Message-Id: <20220521111145.81697-64-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 May 2022 12:58:37 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |    2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  |    4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 02754ee86c81..c5f46d264b23 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5111,7 +5111,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   acccess. These should be enabled by FW for target VMIDs. */
+	   access. These should be enabled by FW for target VMIDs. */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fb9302910742..7f0b18b0d4c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3714,7 +3714,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   acccess. These should be enabled by FW for target VMIDs. */
+	   access. These should be enabled by FW for target VMIDs. */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
@@ -5815,7 +5815,7 @@ static void gfx_v8_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev
 		/* wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
 		gfx_v8_0_wait_for_rlc_serdes(adev);
 
-		/* write cmd to Set CGCG Overrride */
+		/* write cmd to Set CGCG Override */
 		gfx_v8_0_send_serdes_cmd(adev, BPM_REG_CGCG_OVERRIDE, SET_BPM_SERDES_CMD);
 
 		/* wait for RLC_SERDES_CU_MASTER & RLC_SERDES_NONCU_MASTER idle */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f12ae6e2359a..5349ca4d19e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2535,7 +2535,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 	mutex_unlock(&adev->srbm_mutex);
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   acccess. These should be enabled by FW for target VMIDs. */
+	   access. These should be enabled by FW for target VMIDs. */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);

