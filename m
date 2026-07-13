Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA5BC44508
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 16:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C5F10E63A;
	Mon, 13 Jul 2026 16:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bDmW6TXM";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FDA110E628
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 16:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1yLyZfs2G+wUc0ivDaMdyB9UWqCpDJjSi6N2cuEZvq1mwUSWLPRblkn/mm6WAAuMO7a7N8V4Alh8Rhc1SRzVcm6lHj1O52yxR7zawhFv7dWfYTC2Msn7JsBO/YwytXqgIdQ7e4Tqb9TEGwA82foH2StiFAuIxRCrxKO5ewa4bpmKALWecTY9IzFzRe7lHJdRx6q6PAfPNsAR7HOog3PAcuJ1uFyOxGet0/HT0mpfbqQqaZ3Rk8RZ01yFlPJKuub2oSKUXFc+AaNQ4lJOdRwSJxzyVOw1jXZcS8TYvZANj7a7CXXreoR9Ko4XoqyEeiKNDbkyaG7qji4spcZA8elfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8xfiUK2d+nVlp0kGfSe6vjja6MNO2Ch07bubfdj9sw=;
 b=B2K7UB9scoJ5J6sehW+Vxj2a+T2QifcDlaS5MUWvuOVeqBaeNPYy1C+ZBHBhXf/JbBuNT9d4IWkstCLrgRkEeIxVxGRwlS/OlrKDET79/KIg8+Cz+IPHAZ2GZB1hL8dxMrdCzZ1CCFof7mDoJrCfrLEli7DfCEeKt76DjKPK4OonuDsqYcOEpw4A8nqvObj+SOzrkd15LVjN2O4VP/4hucY0YUDLz+HTmvMkqV3w7CgGbHpBd93em/Ibs12gNA1UWg67L/GnWckKzZMZdKx7NoxfheqBBdNv7nc7ORHQ2rBw2WeJbNIB27w72FD5m8u7jQLF9XGkXk9bzyhj6vx3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8xfiUK2d+nVlp0kGfSe6vjja6MNO2Ch07bubfdj9sw=;
 b=bDmW6TXMx1DFf3RB1c/YlP3SKdotwIYSmjPr0NLNh4My+wW6J9RAWod5e/LkntBdnqs1ZX+IAe8kUoVvOysqaE9VNAYNPhNn4bggw1AWA4lc6FL4IrB/ztPGQhpgDKMk0znsRswizFRZ2ETCEtRBfz2xZH2vghtgVvUZ7mABSdw=
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 16:27:51 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::39) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 16:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 16:27:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 11:27:47 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
Date: Mon, 13 Jul 2026 21:57:21 +0530
Message-ID: <20260713162722.3349626-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
References: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: c45c66db-730a-40a1-bf9a-08dee0fbaebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZCOufjF35PgULBVNT11KugqUSdO3fSO4qOXjYIJFKLBfrG2gI6HzbBIAQJw92SoQRfJRYfC4Og8ikpfZYmMwPVSat8/XENCdQZN21Ps6mD3943w9Ov+yJOnmgAdLe5RVZSpBIBdK32yxvyYVbN7RbHeSR87UQK+sEZtBKediGSo6zvN14qkN0Oe25DoExiiiUHi/QQErW+wOwpBklbQ3RxTy5fOP79HaTr7t+ISZqfD8aGHhcBJtWWe5xQqyedKk+XD57umBT03PTmtoofHBNmmAjJtFWsinds1WCHdKXMS1Kws5v4slnwYxjBLfzyMj9272B9aS2p65Qi2w5mMby5xDFkBy+f5ylzaRUfU9bynr3FYU6JFfIqAh+qWSQh24GLwflUxAtMOLiWRhdoRLy960Df9wBJKTkNqzL5Mcbf5nzzDXUmaOHXb2wNLVDb40Sg5F3Rh/czgNKXmCTz2XXkNK1DkyrnrQB2DXo5a6tlR7fHesjOZO3QMz0dSNvnxG3Lotq60lEiVRRcHYvMcyKhBannLT7jYa/Rf2fHL948MgrCc3259Pj3ULsMFH+wrNXdYh8XI0wZFIi2jJgVekO8TXGkYgmLgULJCzCm8/RkzFSLDFarIr018YRH390wofUL5s2XJd1LOOYdDI7vTo9RqxSs14Vj5oIu28jWgeRNl8Uv+L/o/COAi1OzwBWAmmAdjl4Skcmq2R6d+HOO/n2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BPqPOLlXsngSBy/OyF87I01K8UAkJG083v5rAVuMANmlFhv5jIOqK/RLc8NRMDEFFHhzeV+g3dGutA+S+t6cMmWlDzZYiMS7fbCxN8PH8Pev/f2SnibjeKeNp0AujVuLB8AkiyEvKmwEg+1/xwFSXFhty2s/NXHgdw8YYKwP/L5KnCyMXqXHNZLhUgWnkNOVm3g3ouBtSspyXVas4orBV1px+s2HwVIhKWKn/l/Tij5hdcLtw2e7HDuH8Or9zv0y9QMCsd+fVlTAAqls0NXE62n5KgtsjW1BqXD4VtiB2fvbZPwgFNPetiK5waO32QOk9VjBqESPNOqXjGhiSiOEx8HBzsq5V29G3aRro/vRblBkAL+ZZXuej5xQQ4oWtirS122V5AlYZNJbEKPwxMVZOC2fZl5FeqFYu5t7mKstb2oLyftJqUUEOKFu9pl5S+HA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:27:50.5128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c45c66db-730a-40a1-bf9a-08dee0fbaebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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

Signal QUEUE_RESET EVENTFD subscriptions when hung user queues are
detected.

MES reports the doorbell indices of hung queues. Use the existing
doorbell-to-queue mapping to find the affected queue and notify matching
EVENTFD subscribers.

Move the queue reset handling into amdgpu_userq.c so the queue lookup
and queue handling are performed in one place. This avoids scanning all
queues to find a matching doorbell.

EVENTFD remains notification-only.

v2: (per Christian)
 - Use the doorbell xarray to look up affected queues instead of scanning
   all queues.
 - Move queue reset handling into amdgpu_userq.c.
 - Consolidate queue state updates, EVENTFD signaling, and fence
   completion in a single helper.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 33 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 73 ++++++++++++++--------
 3 files changed, 83 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ab3ef3a9f655..5bf231d7a630 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -242,7 +242,40 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 	xa_unlock_irqrestore(xa, flags);
 }
 
+/**
+ * amdgpu_userq_handle_hung_queue - handle a successfully reset hung queue
+ * @adev: AMDGPU device
+ * @queue: affected user queue
+ *
+ * Mark the queue as hung, notify matching QUEUE_RESET EVENTFD
+ * subscribers, force-complete its fences, and send the DRM wedged event.
+ *
+ * Return:
+ * true when the queue was handled, false for an invalid queue.
+ */
+bool
+amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
+			       struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_eventfd_mgr *eventfd_mgr;
 
+	if (!queue)
+		return false;
+
+	queue->state = AMDGPU_USERQ_STATE_HUNG;
+
+	eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+	amdgpu_eventfd_signal(eventfd_mgr,
+			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
+			      queue);
+
+	amdgpu_userq_fence_driver_force_completion(queue);
+
+	drm_dev_wedged_event(adev_to_drm(adev),
+			     DRM_WEDGE_RECOVERY_NONE, NULL);
+
+	return true;
+}
 
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index b69621311b80..187bfd66eb13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -180,7 +180,8 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
-
+bool amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
+				    struct amdgpu_usermode_queue *queue);
 /*
  * CP packs the per-process doorbell_id of the queue in
  * CTXID0[9:0] on priv-fault (same encoding KFD uses via
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3fad95199e0c..4b546613c024 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_userq_internal.h"
 #include "amdgpu_cwsr.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
@@ -238,34 +239,56 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 			  unsigned int queue,
 			  unsigned int db)
 {
+	struct xarray *xa = &adev->userq_doorbell_xa;
 	struct amdgpu_usermode_queue *uq;
 	bool use_mmio = adev->gfx.mec.use_mmio_for_reset;
-	unsigned long uq_id;
-	int r;
+	unsigned long flags;
+	int r = 0;
 
-	xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
-		if (uq->queue_type == queue_type) {
-			if (uq == guilty_uq)
-				continue;
-			if (uq->doorbell_index == db) {
-				uq->state = AMDGPU_USERQ_STATE_HUNG;
-				if (use_mmio)
-					r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue, 0);
-				else
-					r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
-				if (r)
-					return r;
-				r = mes_userq_unmap(uq);
-				if (r)
-					return r;
-				atomic_inc(&adev->gpu_reset_counter);
-				amdgpu_userq_fence_driver_force_completion(uq);
-				drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
-				break;
-			}
-		}
-	}
-	return 0;
+	/*
+	 * Resolve the doorbell directly to the affected queue instead of
+	 * scanning all user queues.
+	 */
+	xa_lock_irqsave(xa, flags);
+
+	uq = xa_load(xa, db);
+	if (uq)
+		kref_get(&uq->refcount);
+
+	xa_unlock_irqrestore(xa, flags);
+
+	if (!uq)
+		return 0;
+
+	/*
+	 * The guilty queue is handled separately by the caller.
+	 */
+	if (uq == guilty_uq)
+		goto out_put_queue;
+
+	if (uq->queue_type != queue_type)
+		goto out_put_queue;
+
+	if (use_mmio)
+		r = amdgpu_mes_reset_queue_mmio(adev, queue_type,
+						0, 1, pipe, queue, 0);
+	else
+		r = amdgpu_mes_reset_user_queue(adev, queue_type, db, 0);
+
+	if (r)
+		goto out_put_queue;
+
+	r = mes_userq_unmap(uq);
+	if (r)
+		goto out_put_queue;
+
+	if (amdgpu_userq_handle_hung_queue(adev, uq))
+		atomic_inc(&adev->gpu_reset_counter);
+
+out_put_queue:
+	amdgpu_userq_put(uq);
+
+	return r;
 }
 
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
-- 
2.34.1

