Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0975FC04A6A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 07:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D8110E5AA;
	Thu,  3 Aug 2023 07:25:04 +0000 (UTC)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com
 [115.124.28.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0115210E50D;
 Wed,  2 Aug 2023 07:26:31 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2717956|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.00605419-0.000108826-0.993837; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047193; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6c61oB_1690961182; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6c61oB_1690961182) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 15:26:24 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_trace.h
Date: Wed,  2 Aug 2023 07:26:21 +0000
Message-Id: <20230802072621.13162-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 03 Aug 2023 07:25:02 +0000
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
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: space required after that ',' (ctx:VxV)
ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 525dffbe046a..2fd1bfb35916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -432,7 +432,7 @@ TRACE_EVENT(amdgpu_vm_flush,
 			   ),
 	    TP_printk("ring=%s, id=%u, hub=%u, pd_addr=%010Lx",
 		      __get_str(ring), __entry->vmid,
-		      __entry->vm_hub,__entry->pd_addr)
+		      __entry->vm_hub, __entry->pd_addr)
 );
 
 DECLARE_EVENT_CLASS(amdgpu_pasid,
@@ -494,7 +494,7 @@ TRACE_EVENT(amdgpu_cs_bo_status,
 );
 
 TRACE_EVENT(amdgpu_bo_move,
-	    TP_PROTO(struct amdgpu_bo* bo, uint32_t new_placement, uint32_t old_placement),
+	    TP_PROTO(struct amdgpu_bo *bo, uint32_t new_placement, uint32_t old_placement),
 	    TP_ARGS(bo, new_placement, old_placement),
 	    TP_STRUCT__entry(
 			__field(struct amdgpu_bo *, bo)
-- 
2.17.1

