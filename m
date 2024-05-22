Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0355EC25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 07:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B4010F413;
	Wed, 22 May 2024 07:30:43 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE5BD10F3B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 07:30:25 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 44M7UJFc009414; Wed, 22 May 2024 13:00:19 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 44M7UJGM009413;
 Wed, 22 May 2024 13:00:19 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 05/10] drm/amdgpu: add more device info to the devcoredump
Date: Wed, 22 May 2024 12:59:45 +0530
Message-Id: <20240522072950.9162-6-sunil.khatri@amd.com>
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

Adding more device information:
a. PCI info
b. VRAM and GTT info
c. GDC config

Also correct the print layout and section information for
in devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index c1cb62683695..f0a44d0dec27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -224,12 +224,29 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 			   coredump->reset_task_info.process_name,
 			   coredump->reset_task_info.pid);
 
-	/* GPU IP's information of the SOC */
-	drm_printf(&p, "\nIP Information\n");
+	/* SOC Information */
+	drm_printf(&p, "\nSOC Information\n");
+	drm_printf(&p, "SOC Device id: %d\n", coredump->adev->pdev->device);
+	drm_printf(&p, "SOC PCI Revision id: %d\n", coredump->adev->pdev->revision);
 	drm_printf(&p, "SOC Family: %d\n", coredump->adev->family);
 	drm_printf(&p, "SOC Revision id: %d\n", coredump->adev->rev_id);
 	drm_printf(&p, "SOC External Revision id: %d\n", coredump->adev->external_rev_id);
 
+	/* Memory Information */
+	drm_printf(&p, "\nSOC Memory Information\n");
+	drm_printf(&p, "real vram size: %llu\n", coredump->adev->gmc.real_vram_size);
+	drm_printf(&p, "visible vram size: %llu\n", coredump->adev->gmc.visible_vram_size);
+	drm_printf(&p, "visible vram size: %llu\n", coredump->adev->mman.gtt_mgr.manager.size);
+
+	/* GDS Config */
+	drm_printf(&p, "\nGDS Config\n");
+	drm_printf(&p, "gds: total size: %d\n", coredump->adev->gds.gds_size);
+	drm_printf(&p, "gds: compute partition size: %d\n", coredump->adev->gds.gds_size);
+	drm_printf(&p, "gds: gws per compute partition: %d\n", coredump->adev->gds.gws_size);
+	drm_printf(&p, "gds: os per compute partition: %d\n", coredump->adev->gds.oa_size);
+
+	/* HWIP Version Information */
+	drm_printf(&p, "\nHW IP Version Information\n");
 	for (int i = 1; i < MAX_HWIP; i++) {
 		for (int j = 0; j < HWIP_MAX_INSTANCE; j++) {
 			ver = coredump->adev->ip_versions[i][j];
-- 
2.34.1

