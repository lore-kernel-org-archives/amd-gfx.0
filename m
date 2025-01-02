Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCBEE7718B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 16:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0723A10E746;
	Thu,  2 Jan 2025 16:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gUeOfAe8";
	dkim-atps=neutral
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1CE10E2DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 05:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1735796546; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=cF1+9udj+vYrKTfcX94XyigNeMyYo+IcX5C9wo1QDao=;
 b=gUeOfAe8eOq3RLRmb9n43s/myCtcb9hkxG4fePnuBJn/XN+ry2aDOBp1h7BeVGEdmJoF2EAj3ekyS1Nz8mX074oi/tDglJE92Hu59d18cnQjhqiD91w5HARuaO1/rwFdgFj89f+3nrb1R4y3QOBtgF4yGK/z126AQyxVJxqzO3w=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WMk35xM_1735796242 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 02 Jan 2025 13:37:23 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: amd-gfx@lists.freedesktop.org, kent.russell@amd.com,
 shuox.liu@linux.alibaba.com
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH 5/6] amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
Date: Thu,  2 Jan 2025 13:36:56 +0800
Message-ID: <4cffa8720810823b92f1a3bb484da499bc0410f8.1735795671.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1735795671.git.gerry@linux.alibaba.com>
References: <cover.1735795671.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jan 2025 16:24:05 +0000
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

Function detects initialization status by checking sched->ops, so set
sched->ops to non-NULL just before return in function drm_sched_init()
to avoid possible invalid memory access on error recover path.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 5adab4b3386c..ce2afdfc0158 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1331,6 +1331,8 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
 	drm_err(sched, "%s: Failed to setup GPU scheduler--out of memory\n", __func__);
+	// amdgpu_fence_driver_sw_fini() checks sched->ops for status.
+	sched->ops = NULL;
 	return -ENOMEM;
 }
 EXPORT_SYMBOL(drm_sched_init);
@@ -1375,6 +1377,7 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 	sched->ready = false;
 	kfree(sched->sched_rq);
 	sched->sched_rq = NULL;
+	sched->ops = NULL;
 }
 EXPORT_SYMBOL(drm_sched_fini);
 
-- 
2.43.5

