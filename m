Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D093E77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3986D10E8A7;
	Wed,  8 Jan 2025 14:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lC5D/vb0";
	dkim-atps=neutral
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B0810E8A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344811; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=McATYrg/2jHbGCoXf2U65QMaAWSi3FfG+kX8OW2Uul8=;
 b=lC5D/vb0wwuEBgIFIwHqUW+1WKEZguEH+JkFj9O7ywtHqYivT83YY+BnoL49PWxixb0gRab7u3J0w6K56k+NmqAVQbQltHjK4NfOlRUg5yPnOODEDwCmzuw3SlIPhX1OKILQMxoHwj/jOszkUgJuOUTMLDj1PKSkT0UyJRNWDoI=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXDJ_1736344810 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:10 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 02/13] drm/admgpu: add helper functions to track status
 for ras manager
Date: Wed,  8 Jan 2025 21:59:54 +0800
Message-ID: <d0c71b35557b276a42ad5cbab3c6e82815580ba6.1736344725.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736344725.git.gerry@linux.alibaba.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10 +++++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e4b13e729770..32941f29507c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -367,12 +367,29 @@ bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 
 #define AMDGPU_MAX_IP_NUM 16
 
+enum amdgpu_marker {
+	// shared by ip blocks and ras blocks
+	AMDGPU_MARKER_IRQ0		= 0,
+	AMDGPU_MARKER_IRQ1		= 1,
+	AMDGPU_MARKER_IRQ2		= 2,
+	AMDGPU_MARKER_IRQ3		= 3,
+	AMDGPU_MARKER_IRQ4		= 4,
+	AMDGPU_MARKER_IRQ5		= 5,
+	AMDGPU_MARKER_IRQ6		= 6,
+	AMDGPU_MARKER_IRQ7		= 7,
+	AMDGPU_MARKER_IRQ_MAX		= 47,
+	AMDGPU_MARKER_DEBUGFS		= 63,
+};
+
+#define AMDGPU_MARKER_INDEX_IRQ(idx)		(AMDGPU_MARKER_INDEX_IRQ0 + (idx))
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
@@ -400,6 +417,27 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
 int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 			       const struct amdgpu_ip_block_version *ip_block_version);
 
+static inline void amdgpu_ip_block_set_marker(struct amdgpu_ip_block *ip_block,
+					      enum amdgpu_marker marker)
+{
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
+	if ((ip_block->status.markers & value) != 0 ) {
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
index 71e8eafbbfbc..6d52e22691f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5007,3 +5007,41 @@ bool amdgpu_ras_is_rma(struct amdgpu_device *adev)
 
 	return con->is_rma;
 }
+
+bool amdgpu_ras_test_marker(struct amdgpu_device *adev,
+			    struct ras_common_if *head, int marker)
+{
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
+
+	if (obj && obj->markers & (0x1ull << marker)) {
+		return true;
+	}
+
+	return false;
+}
+
+void amdgpu_ras_set_marker(struct amdgpu_device *adev,
+			   struct ras_common_if *head, int marker)
+{
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
+
+	WARN_ON(obj->markers & (0x1ull << marker));
+	if (obj) {
+		obj->markers |= 0x1ull << marker;
+	}
+}
+
+bool amdgpu_ras_test_and_clear_marker(struct amdgpu_device *adev,
+				      struct ras_common_if *head, int marker)
+{
+	bool set = false;
+	uint64_t value = 0x1ull << marker;
+	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
+
+	if (obj && (obj->markers & value) != 0 ) {
+		obj->markers &= ~value;
+		set = true;
+	}
+
+	return set;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index b13debcf48ee..bc7377eaf819 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -632,6 +632,8 @@ struct ras_manager {
 	struct ras_common_if head;
 	/* reference count */
 	int use;
+	/* Flags for status tracking */
+	uint64_t markers;
 	/* ras block link */
 	struct list_head node;
 	/* the device */
@@ -975,4 +977,12 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
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

