Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A13C25B79
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 07:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D51510F411;
	Wed, 22 May 2024 07:30:42 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A1C10F3E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 07:30:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 44M7UJnC009394; Wed, 22 May 2024 13:00:19 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 44M7UJuZ009393;
 Wed, 22 May 2024 13:00:19 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 01/10] drm/amdgpu: rename the ip_dump to ip_dump_core
Date: Wed, 22 May 2024 12:59:41 +0530
Message-Id: <20240522072950.9162-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522072950.9162-1-sunil.khatri@amd.com>
References: <20240522072950.9162-1-sunil.khatri@amd.com>
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

Rename the memory pointer from ip_dump to ip_dump_core
to make it specific to core registers and rest other
registers to be dumped in their respective memories.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 109f471ff315..a28462643b00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -435,7 +435,7 @@ struct amdgpu_gfx {
 	bool				mcbp; /* mid command buffer preemption */
 
 	/* IP reg dump */
-	uint32_t			*ip_dump;
+	uint32_t			*ip_dump_core;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1f516466ac13..73149150fe2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4603,9 +4603,9 @@ static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
 	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr == NULL) {
 		DRM_ERROR("Failed to allocate memory for IP Dump\n");
-		adev->gfx.ip_dump = NULL;
+		adev->gfx.ip_dump_core = NULL;
 	} else {
-		adev->gfx.ip_dump = ptr;
+		adev->gfx.ip_dump_core = ptr;
 	}
 }
 
@@ -4815,7 +4815,7 @@ static int gfx_v10_0_sw_fini(void *handle)
 
 	gfx_v10_0_free_microcode(adev);
 
-	kfree(adev->gfx.ip_dump);
+	kfree(adev->gfx.ip_dump_core);
 
 	return 0;
 }
@@ -9292,13 +9292,13 @@ static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
 	uint32_t i;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
 
-	if (!adev->gfx.ip_dump)
+	if (!adev->gfx.ip_dump_core)
 		return;
 
 	for (i = 0; i < reg_count; i++)
 		drm_printf(p, "%-50s \t 0x%08x\n",
 			   gc_reg_list_10_1[i].reg_name,
-			   adev->gfx.ip_dump[i]);
+			   adev->gfx.ip_dump_core[i]);
 }
 
 static void gfx_v10_ip_dump(void *handle)
@@ -9307,12 +9307,12 @@ static void gfx_v10_ip_dump(void *handle)
 	uint32_t i;
 	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
 
-	if (!adev->gfx.ip_dump)
+	if (!adev->gfx.ip_dump_core)
 		return;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	for (i = 0; i < reg_count; i++)
-		adev->gfx.ip_dump[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
+		adev->gfx.ip_dump_core[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
-- 
2.34.1

