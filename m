Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBCEE7719E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4420D10E3E9;
	Mon, 13 Jan 2025 01:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TqPfWkZ0";
	dkim-atps=neutral
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B54E010E37A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732552; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=+Pnu7CmjeRmlE9HY/YW+kivoahJN09QeMf0huzx9l6c=;
 b=TqPfWkZ0KGOo62raC2kK4jAsdsoeJg+NgEg1PQfBlyYjiQpFz+2ZEBQ6ZHbQp9QoKo1xpQJHRD3ZQdbyeMTLqaLI3FFAJh2JGQbCN7uS4HXvaNUjyDjX5fnXZsMYRHqVFbXkriZoL3ZxoGxC0I9yZulFKOFRopIq+BIYc6C0IW8=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NH-_1736732550 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:31 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 14/15] drm/amdgpu/nbio: improve the way to manage irq
 reference count
Date: Mon, 13 Jan 2025 09:42:19 +0800
Message-ID: <7db1ad99c8f18e31dcef7248eb24a2557a948657.1736732063.git.gerry@linux.alibaba.com>
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

Refactor nbio related code to improve the way to manage irq reference
count. Originally amdgpu_irq_get() is called from ip_blocks[].late_init
and amdgpu_irq_put is called from ip_blocks[].hw_fini. The asymmetric
design may cause issue under certain conditions. So
1) introduce amdgpu_nbio_ras_early_fini() to undo work done by
   amdgpu_nbio_ras_late_init().
2) remove call of amdgpu_irq_put in xxxx_hw_fini().
3) record the status where reference count is held for specific irq.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 16 ----------------
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index c75ce91f94ab..b8a69ceec2e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -64,13 +64,27 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 		r = amdgpu_irq_get(adev, &adev->nbio.ras_controller_irq, 0);
 		if (r)
 			goto late_fini;
+		amdgpu_ras_set_marker(adev, ras_block, AMDGPU_MARKER_IRQ0);
 		r = amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 		if (r)
 			goto late_fini;
+		amdgpu_ras_set_marker(adev, ras_block, AMDGPU_MARKER_IRQ1);
 	}
 
 	return 0;
 late_fini:
-	amdgpu_ras_block_early_fini(adev, ras_block);
+	amdgpu_nbio_ras_early_fini(adev, ras_block);
 	return r;
 }
+
+void amdgpu_nbio_ras_early_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	if (amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
+		if (amdgpu_ras_test_and_clear_marker(adev, ras_block, AMDGPU_MARKER_IRQ0))
+			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
+		if (amdgpu_ras_test_and_clear_marker(adev, ras_block, AMDGPU_MARKER_IRQ1))
+			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+	}
+
+	amdgpu_ras_block_early_fini(adev, ras_block);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 79c2f807b9fe..e1edf75602c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -117,6 +117,7 @@ struct amdgpu_nbio {
 
 int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
+void amdgpu_nbio_ras_early_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 u64 amdgpu_nbio_get_pcie_replay_count(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index a26a9be58eac..c27d0fbf9cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -665,6 +665,7 @@ struct amdgpu_nbio_ras nbio_v7_4_ras = {
 		},
 		.hw_ops = &nbio_v7_4_ras_hw_ops,
 		.ras_late_init = amdgpu_nbio_ras_late_init,
+		.ras_early_fini = amdgpu_nbio_ras_early_fini,
 	},
 	.handle_ras_controller_intr_no_bifring = nbio_v7_4_handle_ras_controller_intr_no_bifring,
 	.handle_ras_err_event_athub_intr_no_bifring = nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 8a0a63ac88d2..684a38a16247 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -703,6 +703,7 @@ struct amdgpu_nbio_ras nbio_v7_9_ras = {
 		},
 		.hw_ops = &nbio_v7_9_ras_hw_ops,
 		.ras_late_init = amdgpu_nbio_ras_late_init,
+		.ras_early_fini = amdgpu_nbio_ras_early_fini,
 	},
 	.handle_ras_controller_intr_no_bifring = nbio_v7_9_handle_ras_controller_intr_no_bifring,
 	.handle_ras_err_event_athub_intr_no_bifring = nbio_v7_9_handle_ras_err_event_athub_intr_no_bifring,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a59b4c36cad7..5aabb55d2d25 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1328,22 +1328,6 @@ static int soc15_common_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_put_irq(adev);
 
-	/*
-	 * For minimal init, late_init is not called, hence RAS irqs are not
-	 * enabled.
-	 */
-	if ((!amdgpu_sriov_vf(adev)) &&
-	    (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
-	    adev->nbio.ras_if &&
-	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
-		if (adev->nbio.ras &&
-		    adev->nbio.ras->init_ras_controller_interrupt)
-			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
-		if (adev->nbio.ras &&
-		    adev->nbio.ras->init_ras_err_event_athub_interrupt)
-			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
-	}
-
 	return 0;
 }
 
-- 
2.43.5

