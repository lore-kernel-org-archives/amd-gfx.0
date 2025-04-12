Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C599AC369B1
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 20:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B5010E3F3;
	Sat, 12 Apr 2025 20:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hoX+xrg1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E8A410E3E8
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kY1sZ+p+TL3EoomzS7WdsAR+qBGI2zvrWknoHjpaKLI=; b=hoX+xrg1Bu48H0ah3mtm4HXD2Q
 IV90Z+fo1JP3siC2Q8CU5YUJ9anLEr2V1hbyL5xiuDKW2H7ET6scZSbjajWH1Mt98hyJuD3DuuFJ+
 E6LINmP9AOpcybMnEDe1Nu3Hg+uxuQZUI4GRwjfrhByHwNkCnwJ8gdT0nZ5p4rmfCwJnsrU53XmKk
 z5S5pU5Osy97rvwlieMcycZ2tNcdPUgaGKs7ipMLFTp6E9Nd46Agc/rJPjPsqMqAKqGLkQPopJ2+x
 BnkAFq4m/+idvTdR9TKCau6rwX+soot+KsP/mSqe2ga1jFktr3AgWrvZTeA5+kTlJmEhG0skCMoeN
 ll8UA5yg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u3hMJ-00Fepq-O7; Sat, 12 Apr 2025 22:21:48 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 1/9] drm/amdgpu/gfx: Introduce helpers for CSB manipulation
Date: Sat, 12 Apr 2025 14:21:06 -0600
Message-ID: <20250412202134.3025051-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250412202134.3025051-1-siqueira@igalia.com>
References: <20250412202134.3025051-1-siqueira@igalia.com>
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

From GFX6 to GFX11, there is a function for getting the CSB buffer to be
put into the hardware. Three common parts are duplicated in all of these
GFX functions:

1. Prepare the CSB preamble.
2. Parser the CS data.
3. End the CSB preamble.

This commit creates helpers to be used from GFX6 to GFX11.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 69 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7fc4e62536e1..b86ebbba59aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -33,6 +33,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
+#include "nvd.h"
 
 /* delay 0.1 second to enable gfx off feature */
 #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
@@ -2241,6 +2242,74 @@ void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
 	schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
 }
 
+/**
+ * amdgpu_gfx_csb_preamble_start - Set CSB preamble start
+ *
+ * @buffer: This is an output variable that gets the PACKET3 preamble setup.
+ *
+ * Return:
+ * return the latest index.
+ */
+u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer)
+{
+	u32 count = 0;
+
+	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
+	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STATE);
+
+	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1));
+	buffer[count++] = cpu_to_le32(0x80000000);
+	buffer[count++] = cpu_to_le32(0x80000000);
+
+	return count;
+}
+
+/**
+ * amdgpu_gfx_csb_data_parser - Parser CS data
+ *
+ * @adev: amdgpu_device pointer used to get the CS data and other gfx info.
+ * @buffer: This is an output variable that gets the PACKET3 preamble end.
+ * @count: Index to start set the preemble end.
+ *
+ * Return:
+ * return the latest index.
+ */
+u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 *buffer, u32 count)
+{
+	const struct cs_section_def *sect = NULL;
+	const struct cs_extent_def *ext = NULL;
+	u32 i;
+
+	for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
+		for (ext = sect->section; ext->extent != NULL; ++ext) {
+			if (sect->id == SECT_CONTEXT) {
+				buffer[count++] = cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
+				buffer[count++] = cpu_to_le32(ext->reg_index - PACKET3_SET_CONTEXT_REG_START);
+
+				for (i = 0; i < ext->reg_count; i++)
+					buffer[count++] = cpu_to_le32(ext->extent[i]);
+			}
+		}
+	}
+
+	return count;
+}
+
+/**
+ * amdgpu_gfx_csb_preamble_end - Set CSB preamble end
+ *
+ * @buffer: This is an output variable that gets the PACKET3 preamble end.
+ * @count: Index to start set the preemble end.
+ */
+void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count)
+{
+	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
+	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
+
+	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
+	buffer[count++] = cpu_to_le32(0);
+}
+
 /*
  * debugfs for to enable/disable gfx job submission to specific core.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index caaddab31023..c359530e530e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -598,6 +598,9 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
 void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
+u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer);
+u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 *buffer, u32 count);
+void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count);
 
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
-- 
2.49.0

