Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA268E7719E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE18510E331;
	Mon, 13 Jan 2025 01:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="la1edcjT";
	dkim-atps=neutral
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CACEF10E331
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732544; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Sy/Hv4UjQ2SzN4sXb0xSQkSgYTKjn0q5CCHDjw6tuZY=;
 b=la1edcjTA8j6Va/oBi/3eES7DNL5IOY7okSjdbKo0UKDREbEqiDGQLewtIK2e7fcVtiH9p2M/H/dIcfYACkjf6/wnfGy0DvxDHc0ZwUQRT+ITePiZ2LodgnfPyvDR4WvGwO5ki6yrtMNLF/7l9PgwrvwxuMqB4AoNOlUf4lCNxQ=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NE3_1736732543 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:23 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 01/15] drm/amdgpu: add helper functions to track status for
 ras manager
Date: Mon, 13 Jan 2025 09:42:06 +0800
Message-ID: <789f547f5101fe763a9244d1bda560dd562cb604.1736732062.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736732062.git.gerry@linux.alibaba.com>
References: <cover.1736732062.git.gerry@linux.alibaba.com>
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

Add helper functions to track status for ras manager and ip blocks.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 38 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10 +++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5e55a44f9eef..f0f773659faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -377,12 +377,28 @@ int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
 
 #define AMDGPU_MAX_IP_NUM 16
 
+enum amdgpu_marker {
+	// Markers for IRQs, used for both ip blocks and ras blocks.
+	AMDGPU_MARKER_IRQ0 = 32,
+	AMDGPU_MARKER_IRQ1,
+	AMDGPU_MARKER_IRQ2,
+	AMDGPU_MARKER_IRQ3,
+	AMDGPU_MARKER_IRQ4,
+	AMDGPU_MARKER_IRQ5,
+	AMDGPU_MARKER_IRQ6,
+	AMDGPU_MARKER_IRQ7,
+	AMDGPU_MARKER_IRQ_MAX = 63,
+};
+
+#define AMDGPU_MARKER_IRQ(idx)		(AMDGPU_MARKER_IRQ0 + (idx))
+
 struct amdgpu_ip_block_status {
 	bool valid;
 	bool sw;
 	bool hw;
 	bool late_initialized;
 	bool hang;
+	uint64_t markers;
 };
 
 struct amdgpu_ip_block_version {
@@ -410,6 +426,28 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
 int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 			       const struct amdgpu_ip_block_version *ip_block_version);
 
+static inline void amdgpu_ip_block_set_marker(struct amdgpu_ip_block *ip_block,
+					      enum amdgpu_marker marker)
+{
+	WARN_ON(marker > 63);
+	WARN_ON(ip_block->status.markers & (0x1ull << marker));
+	ip_block->status.markers |= 0x1ull << (int)marker;
+}
+
+static inline bool amdgpu_ip_block_test_and_clear_marker(struct amdgpu_ip_block *ip_block,
+							 enum amdgpu_marker marker)
+{
+	bool set = false;
+	uint64_t value = 0x1ull << (int)marker;
+
+	if ((ip_block->status.markers & value) != 0) {
+		ip_block->status.markers &= ~value;
+		set = true;
+	}
+
+	return set;
+}
+
 /*
  * BIOS.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f0924aa3f4e4..5e19d820ab34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5207,3 +5207,40 @@ bool amdgpu_ras_is_rma(struct amdgpu_device *adev)
 
 	return con->is_rma;
 }
+
+bool amdgpu_ras_test_marker(struct amdgpu_device *adev,
+			    struct ras_common_if *head, int marker)
+{
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
+
+	if (obj && obj->markers & (0x1ull << marker))
+		return true;
+
+	return false;
+}
+
+void amdgpu_ras_set_marker(struct amdgpu_device *adev,
+			   struct ras_common_if *head, int marker)
+{
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
+
+	WARN_ON(marker > 63);
+	WARN_ON(obj->markers & (0x1ull << marker));
+	if (obj)
+		obj->markers |= 0x1ull << marker;
+}
+
+bool amdgpu_ras_test_and_clear_marker(struct amdgpu_device *adev,
+				      struct ras_common_if *head, int marker)
+{
+	bool set = false;
+	uint64_t value = 0x1ull << marker;
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
+
+	if (obj && (obj->markers & value) != 0) {
+		obj->markers &= ~value;
+		set = true;
+	}
+
+	return set;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 82db986c36a0..35881087b17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -634,6 +634,8 @@ struct ras_manager {
 	struct ras_common_if head;
 	/* reference count */
 	int use;
+	/* Flags for status tracking */
+	uint64_t markers;
 	/* ras block link */
 	struct list_head node;
 	/* the device */
@@ -977,4 +979,12 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
 				const char *fmt, ...);
 
 bool amdgpu_ras_is_rma(struct amdgpu_device *adev);
+
+bool amdgpu_ras_test_marker(struct amdgpu_device *adev,
+			    struct ras_common_if *head, int marker);
+void amdgpu_ras_set_marker(struct amdgpu_device *adev,
+			   struct ras_common_if *head, int marker);
+bool amdgpu_ras_test_and_clear_marker(struct amdgpu_device *adev,
+				      struct ras_common_if *head,
+				      int marker);
 #endif
-- 
2.43.5

