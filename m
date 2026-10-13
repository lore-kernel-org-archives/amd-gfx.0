Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5369CC6B14
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2913110F629;
	Tue, 13 Oct 2026 08:49:46 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A191410F629
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:49:44 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69D8nduN972552; Tue, 13 Oct 2026 14:19:39 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69D8ndTo972550;
 Tue, 13 Oct 2026 14:19:39 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 10/14] drm/amdgpu: use spm_vmid for the default RLC SPM VMID
Date: Tue, 13 Oct 2026 14:19:33 +0530
Message-Id: <20261013084937.972181-10-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013084937.972181-1-sunil.khatri@amd.com>
References: <20261013084937.972181-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The RLC bring-up paths programmed the RLC_SPM_VMID field to a hardcoded
0xf as the idle default. Now that the dedicated SPM VMID is tracked in
vm_manager.spm_vmid, use it directly so the idle default matches the
VMID the reservation path hands out.

No functional change: spm_vmid is the top VMID (0xf) on all affected
generations (gfx7 through gfx12).

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e791bf86ad571..fce651d9bc613 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5575,7 +5575,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 
 		gfx_v10_0_init_csb(adev);
 
-		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
+		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
 
 		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
 			gfx_v10_0_rlc_enable_srm(adev);
@@ -5607,7 +5607,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 
 		gfx_v10_0_init_csb(adev);
 
-		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
+		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
 
 		adev->gfx.rlc.funcs->start(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1caecf26c4589..1f2ad47adb9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a5151e15e1011..72ceb113689e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 4ceb3c0aa3322..b44f5ec68714d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1861,7 +1861,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
 	int r;
 
 	/* init spm vmid with 0xf */
-	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
+	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		gfx_v12_1_xcc_init_csb(adev, xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2eaea0e4864dd..91ce21425126f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 696558f6f30d3..479480e39fe47 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
 
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3fb51417ebee5..8afcdb54a0f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3233,7 +3233,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
 		break;
 	}
 
-	gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
+	gfx_v9_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
 
 	adev->gfx.rlc.funcs->start(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 3572eb9b5758a..1d1973fd8f677 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
 
 	return 0;
 }
-- 
2.34.1

