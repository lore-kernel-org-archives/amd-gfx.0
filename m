Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC824C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A56010EC54;
	Tue, 14 Jul 2026 08:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pjXay0Fe";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7773F10EC45
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF9J7tvwFDSHMnNHpslAwCsGtGDz8UI8wb/mdL1UqG4q5txAa9BHTdxCP1EyMQTsEo/WN786xg4r3bZj+B9bidLuX13qClbUBSnlMn/IX7K7oBqT+0UYvr31R88nOivHxW0xwS+aRuPeXf+klnaZC3ygdDKqbNP55Ip+o+WVyx0tPJivDsMWJD4aRHWTMQyDJrEtMGBqPZZjy3mB+UnwtXSDtRRoc74xSNd9pNJSBYDP4v0rclFDjibzQ4HwbeipFKQUkcWKdO5nfeEn4OhrCw9vxVTq4WCUQShEcg+k5BzzIgtUuUT34eACVCPQEdrYfiEbJXqh9+nalLsY4P8rBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgz2GbT4RzRH7AvaAlnbv8VqlGo3YQkYGb4aNoTSGKI=;
 b=H6ewxruDMgK8Y+94pjuDwARtIwTn2YMOdoebQmbPNoh8KKZTFEsLqrPh7yo2tQhGarNVtL0QhBbs/qLmx7iAmDQEKPo1Lh1L4tNRi0ZkKBQ5GaRcgKFeLpNl7ej126ZTN/J3/Ryw5KjZIzTsRzS6m17xjyPyX001jzO7gRxkrFgZOm0hpxw44gjhI/MtzIvtYDx9dBGZBLQvhb1kRIht3JeSnfbNIlmE4K2j9wAUfnMJKt4p87NUGDMy+upRKBebI07tzv9yTb2W8UFg2ftb9GM7DmdjTr7DANolm8M57xDYhQI0nPDZEBpn4yxf9BNgVGEWhArKRN4OPYHdEMXm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgz2GbT4RzRH7AvaAlnbv8VqlGo3YQkYGb4aNoTSGKI=;
 b=pjXay0FeoD5fI8bC3vBAKpkhLmM834KiKYZZ9aWT2loecet6SDkw8pLUJhVaOumUS86r2UoDydalYXGPox4HOtEvjQEcFt4VBQqLc46zs2REbj9IFF2LRjMu+Kkz/7hMnSriWjxaECqe9lqD2g9blGtLmpwg7/euKsPQmyz5hE0=
Received: from SJ0PR13CA0209.namprd13.prod.outlook.com (2603:10b6:a03:2c3::34)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 08:02:40 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::63) by SJ0PR13CA0209.outlook.office365.com
 (2603:10b6:a03:2c3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 08:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:02:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:02:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 3/4] drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
Date: Tue, 14 Jul 2026 13:32:19 +0530
Message-ID: <20260714080220.3395155-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
References: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc00f1a-3cd1-4eb6-6101-08dee17e471a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jYwCBkEFu2OCzRWx6g40Siwi6K2peCgPODs+x0dCiZdELEceAXjbameU1NdoFDkL3ykOAwQIcmFS2cL7VygrfXOpdXcv3Ecng3i/tilBqDwbA9MhQOrVVM7B8xDgx++lSU2f7/sN6o92HUYhial3DN9tq3T8QIoYb4g+V9lgorq8NAt8PBtfPHYN9CrWMYMkoE2RzkkO86KaXvUqAGUtC0zAeGrKMIDAoH12iH92PsONedRrxKEx1zstzB17z7XKEAsOcflDyXjPsoeiQBaRYuB37KzNkpdOVXVcSXEQU7dvL9sFcKgoxXAHID2O1WuphMO8ECQExzu7Npwm9cvaMhhWU9ztAMyquwWezpG1n5Y4VFAOY3OafTfAGu5Ipht0PDc5VP1POzuDFaAhxWg0AymZGQHHHhk19SZNKs8ZwLU167EGRdC7tkBibrpi9rfABi6AjRztEHMbQ6TSW5CJVK/833jmAKDFa832JHPkNRMAbOsVNZ1OsBMYPg1YmgbEeommu0B4JaSNxpkUYRpNDemws54b4XUKqI0KbObuSpdhNSkfAHGJBjYGu2lrGtsajMzk19/REafKZfCvb1PaMkmG5+ShAw59iwqnkoE7OTRxZGO6cx8Zm4fZzjO9chUo633kFlgmRH+5dsFUnLAGmQ9R9nCHlwkqLoXFYH3oKDWNEYIWSkEokFy4UMIyPIU+0JPfCsDh0uWgnpAhojAEAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LpGEQ64zNRtCg0qFpOaCjM4oy/n/gHQ9QSAQ9kVTe7aeSkpF8kcvjXzImrNHJnWeKj+ub7DXDuNhVNlG3ODuucLUuQSIJpeHWUkpCar6ecSOJk08M353/TyzDTWbr7+lYZktZCekQoWgVToKy5BnGwjv1CXY6HCjA/xfwQRrVFSJ76Fa23LT7X6lFN2WDiPRrJPAnjkeriW0r1I52zhghcCpcRbDhK2q47hVgZ5DB6iiJIiKc5rRHTyBUU4lsLwCoJ7SAYS7BMGlYOTPPyNSSR2VJ4J6HWdGx2r4ATo9L86+J80ud6dIyY2u8N96G1PYDCGk435bkkTxZdI2BLW3d2ptNNftwUg4Zil+2+3A9zXJ1jn4uya6fOoTOifpiSiGBruS2tgCwn12FpsG6XeHlV1z0S/z9PvauRZTiGOZA9rRigfCkR2HEBqoYhTTCZPa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:02:40.7205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc00f1a-3cd1-4eb6-6101-08dee17e471a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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
doorbell-to-queue mapping to resolve the affected queue without scanning
all user queues.

Consolidate the queue state update, reset accounting, EVENTFD signaling,
fence completion, and wedged event notification in a common helper. Use
the helper for both the original guilty queue and additional affected
queues.

EVENTFD remains notification-only.

v2: (per Christian)
 - Use the doorbell xarray to look up affected queues instead of scanning
   all queues.
 - Move queue reset handling into amdgpu_userq.c.
 - Consolidate queue state updates, EVENTFD signaling, and fence
   completion in a single helper.

v3: Rebase only.

v4: (per Alex)
 - Rebase on Alex's "drm/amdgpu/userq: properly account for resets".
 - Preserve the reset counter update in the common hung queue helper.
 - Use amdgpu_userq_handle_hung_queue() for both successful queue reset
   paths.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 39 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 72 ++++++++++++++--------
 3 files changed, 80 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index fb0d335875af..65b20d7a4b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -135,6 +135,34 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }
 
+/**
+ * amdgpu_userq_handle_hung_queue - handle a successfully reset hung queue
+ * @adev: AMDGPU device
+ * @queue: affected user queue
+ *
+ * Mark the queue as hung, account for the reset, force-complete its
+ * fences, notify matching QUEUE_RESET EVENTFD subscribers, and send
+ * the DRM wedged event.
+ */
+void amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
+				    struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_eventfd_mgr *eventfd_mgr;
+
+	queue->state = AMDGPU_USERQ_STATE_HUNG;
+	atomic_inc(&adev->gpu_reset_counter);
+
+	amdgpu_userq_fence_driver_force_completion(queue);
+
+	eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+	amdgpu_eventfd_signal(eventfd_mgr,
+			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
+			      queue);
+
+	drm_dev_wedged_event(adev_to_drm(adev),
+			     DRM_WEDGE_RECOVERY_NONE, NULL);
+}
+
 static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 {
 	struct amdgpu_usermode_queue *queue =
@@ -167,13 +195,10 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 							 queue, NULL, NULL);
 		else
 			r = userq_funcs->reset(queue);
-		if (r) {
+		if (r)
 			gpu_reset = true;
-		} else {
-			atomic_inc(&adev->gpu_reset_counter);
-			amdgpu_userq_fence_driver_force_completion(queue);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
-		}
+		else
+			amdgpu_userq_handle_hung_queue(adev, queue);
 	} else {
 		gpu_reset = true;
 	}
@@ -247,8 +272,6 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 	xa_unlock_irqrestore(xa, flags);
 }
 
-
-
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index b69621311b80..526e007e300e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -180,6 +180,8 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
+void amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
+				    struct amdgpu_usermode_queue *queue);
 
 /*
  * CP packs the per-process doorbell_id of the queue in
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3fad95199e0c..27adcea7b9a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_userq_internal.h"
 #include "amdgpu_cwsr.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
@@ -238,34 +239,55 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
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
+	amdgpu_userq_handle_hung_queue(adev, uq);
+
+out_put_queue:
+	amdgpu_userq_put(uq);
+
+	return r;
 }
 
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
-- 
2.34.1

