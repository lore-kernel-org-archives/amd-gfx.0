Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B505EC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 16:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2538D10EE91;
	Fri, 12 Apr 2024 16:54:30 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D4C10EE6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 16:54:24 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 43CGsKe7132965; Fri, 12 Apr 2024 22:24:20 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 43CGsKW9132964;
 Fri, 12 Apr 2024 22:24:20 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: Add ip dump support in devcoredump
Date: Fri, 12 Apr 2024 22:24:12 +0530
Message-Id: <20240412165412.132876-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412165412.132876-1-sunil.khatri@amd.com>
References: <20240412165412.132876-1-sunil.khatri@amd.com>
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

Add support of dumping the IP registers for
debugging purposes in devcoredump.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 1129e5e5fb42..c6eea58d137d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -261,6 +261,19 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 	drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
 	drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
 
+	/* Add IP dump for each ip */
+	if (coredump->adev->ip_dump != NULL) {
+		struct reg_pair *pair;
+
+		pair = (struct reg_pair *)coredump->adev->ip_dump;
+		drm_printf(&p, "IP register dump\n");
+		drm_printf(&p, "Offset \t Value\n");
+		for (int i = 0; i < coredump->adev->num_regs; i++)
+			drm_printf(&p, "0x%04x \t 0x%08x\n", pair[i].offset,
+				   pair[i].value);
+		drm_printf(&p, "\n");
+	}
+
 	/* Add ring buffer information */
 	drm_printf(&p, "Ring buffer information\n");
 	for (int i = 0; i < coredump->adev->num_rings; i++) {
@@ -299,6 +312,11 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 
 static void amdgpu_devcoredump_free(void *data)
 {
+	struct amdgpu_coredump_info *temp = data;
+
+	kfree(temp->adev->ip_dump);
+	temp->adev->ip_dump = NULL;
+	temp->adev->num_regs = 0;
 	kfree(data);
 }
 
@@ -337,6 +355,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 
 	coredump->adev = adev;
 
+	/* Trigger ip dump here to capture the value of registers */
+	for (int i = 0; i < adev->num_ip_blocks; i++)
+		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
+			adev->ip_blocks[i].version->funcs->dump_ip_state((void *)adev);
+
 	ktime_get_ts64(&coredump->reset_time);
 
 	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
-- 
2.34.1

