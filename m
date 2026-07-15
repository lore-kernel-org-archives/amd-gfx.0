Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF5BC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3592010F0E9;
	Wed, 15 Jul 2026 14:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MptPTAZr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF6DE10F0EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcACpumFIjmByRguMlCRMJuqqM4H5SNRdXNIgjw7qhrTRCV9Us3yCR43YGZ7PaqPw0Fjyun+PZO1/Oo/Nt6kA2dRRsbZQoEqNvhabDDGsrpWI9qps2Ctt5BMh7kIi97xOWXl6QSzghkEPIM5xUCttYGfk4xVQHdVz54B3pqxq0JCkJaY7934Lt0u3V1IS8+tZkyFZjJV+XbpDQWpnqdLwuDU9rCRX1Pk0gRZy/Hpz9Nv9Uc4X85KKo9dDHxXJvkqKghM2hM/rDuN35iKuzbfFE9xbcrr6Yc/9Er6Cs7vFgFAxl6mHDiAV5+F2/UoiDjr4W4Zvnsc+Od65LZtR+Sx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZFRTumygpK5Hokk/JVlug6sw9eIjNskXw30PItwRR0=;
 b=rQNbjO68XF2WcbO7E4NP2XGAz7RMBJXeykTNdSyBA5pGVkk5jylfzqSyXtcTfmYBjE4WcnIMd2pkXyuSHBENAH0aArJAjb08f2NkBihrFkE0P8CNNSBOS8mjt081VEJSHQK1zmkVG6YhshxhlHrNEIT8rMLrlzRGEBYLnA/jmQLJmuXqGnEozybG19Oyq4LukZAxF6swnHEpTla4Bzi1wbqx5mHiHfXdXdosyXWNCgleesWCWgGblcYzaNEsttDcqqnDPa6/g+2dmJxP1Bg8FnOfXQvynI2Sx11fCOlvrSjPBYkcBPXbHp8HVLqM70LpJlH506D4ZWCNwPC+r/Wpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZFRTumygpK5Hokk/JVlug6sw9eIjNskXw30PItwRR0=;
 b=MptPTAZrhiLO0lKGRKIPc47sSLEGSFPMlurq+1eptco735SIefBTyeQtQj5VPDaWlTE862cHE+wlMFmhmPTSux0246szv1l9QU9hAsGQ1HvXjwa4dlzqEmw/eoiYMgoRm8YBJ49wdtTdAQPk8AsdZ7n6osfjbhv28USfSHE1HQs=
Received: from SJ0PR05CA0031.namprd05.prod.outlook.com (2603:10b6:a03:33f::6)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 14:28:45 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::6) by SJ0PR05CA0031.outlook.office365.com
 (2603:10b6:a03:33f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Wed, 15
 Jul 2026 14:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:28:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:28:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 3/4] drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
Date: Wed, 15 Jul 2026 19:58:23 +0530
Message-ID: <20260715142824.3475418-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
References: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 5999458d-414f-4d43-5177-08dee27d60d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HXLCvkbIwv2FI3fGrAEibubEQdU9tPG9cCnqJB4sHZuq5ubIE01Om0J9JEDbAm6UpUfJKOoTg3NsSrgO1B8q6ouDEkbjhNJe3pJB0D4YcnrGBjAprwOFEKASXLe5Kdq44KyH+nVL+0w2buGytYaOxCwPVgCW1wACxivtfHvQhmbOU857T+QBL+pemw8pgIXW7l/yaopZalZdz/+3DZlERXifFqqbTrUVpAb3Nu1wDuG8VgJBBjDjSp6MWB2QE8krP8KhdoPnUEhec4BqHmJo5wLDNCwMfTZvoiZCyu0v7HjPE8dVsFOz3Gu1o50bZgFU3WbmQzXcmnc7atJiol/62eLRNTrxnmti5xAwdVd5yQzOLulNJFiJWrZDknrqKbUouHSn0pkP9uRZwO3vgScRdXtXjehMyFEMPT4RSwP1RG2yS24lvKdu65NtFc2LN1+4uzw4rEv37tjnUf523gYLTGTBG/9mPrUkOo1fe494Et2dIMkxLlsTs2dcE0rjnNOGVBpeHrmIKJk2u7nA0BqJyL2Rh/h9V/HLLfMGZp0JLQHdt1CNKpbufOj8bRgCbBEHHJ9hDPX80QSegJHKtiNM2wrzTeY5bWQcRF+uyAFHwMsrefuNjw0N6myoiHVTvbzES+LIJsVnEt9cSapzzz+3h+Wplpmk337uh9oKemo5BsaJmu5T3ctXkKHcHysa6qSXw6Sd8B1NaDSSxwElasAT2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6mE68zW7S1jN1WdUQZxmgGEvd4EdU49YiiMn7U0WFQn/OhHg2lXjhH/wsM64aFSnHdOpc35gwXRRM9Q0JlDpnSSarKA22nqFgU7TS42Ge+rB09+WXEpd8d8S8Rbfe/nfwVfVAauh0r7z6g8UKvsI6P0QXTQysZoVj2TnxaC2337IFJLW2bovIq+SfQ3VyK3QatfIQyZsub8iXt1Mn/dGyofi1kfd/qha6yeXi82Bq+3n4E4MgDKhgCLQDsEaRTCJQ7zkbfABlj23CNPgVlXP5E2689nmQpd8597+lpzZ7cH4UJO9Fa5wdX5E/Ze90j9Fee+UrWEfPWUJMQCEMVfN2MWro+wccBh8jZkwmYKX3KZE7eDPuVZI3mLskIPTEKcQjB8NkQLEuHBI5QOjTs2BVMiWHPOOWM1A6fVHUjM83LBwdj8TyR9bpND4Tn8IPPbp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:28:45.5440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5999458d-414f-4d43-5177-08dee27d60d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
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

v5: (per Alex)
 - Rebase on Alex's v2 "drm/amdgpu: properly account for resets with
   user queues".
 - Keep gpu_reset_counter and drm_dev_wedged_event() in the top-level
   guilty-queue reset path.
 - Limit the common helper to queue state, fence completion, and
   QUEUE_RESET EVENTFD signaling.
 - Continue to notify both the guilty queue and collateral queues.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 41 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 75 +++++++++++++++-------
 3 files changed, 87 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 20bc15ad55f4..cc30e07a4aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -135,6 +135,31 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }
 
+/**
+ * amdgpu_userq_handle_hung_queue - handle a successfully reset hung queue
+ * @queue: affected user queue
+ *
+ * Mark the queue as hung, force-complete its fences, and notify matching
+ * QUEUE_RESET EVENTFD subscribers.
+ *
+ * Device-level reset accounting and wedged-event notification are handled
+ * separately by the top-level guilty-queue reset path.
+ */
+void
+amdgpu_userq_handle_hung_queue(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_eventfd_mgr *eventfd_mgr;
+
+	queue->state = AMDGPU_USERQ_STATE_HUNG;
+
+	amdgpu_userq_fence_driver_force_completion(queue);
+
+	eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+	amdgpu_eventfd_signal(eventfd_mgr,
+			      DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
+			      queue);
+}
+
 static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 {
 	struct amdgpu_usermode_queue *queue =
@@ -155,7 +180,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 
 	/*
 	 * If GPU recovery feature is disabled system-wide,
-	 * skip all reset detection logic
+	 * skip all reset detection logic.
 	 */
 	if (!amdgpu_gpu_recovery)
 		return;
@@ -177,21 +202,25 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 							 queue, NULL, NULL);
 		else
 			r = userq_funcs->reset(queue);
+
 		if (r) {
 			gpu_reset = true;
 		} else {
 			atomic_inc(&adev->gpu_reset_counter);
-			amdgpu_userq_fence_driver_force_completion(queue);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
+			amdgpu_userq_handle_hung_queue(queue);
+			drm_dev_wedged_event(adev_to_drm(adev),
+					     DRM_WEDGE_RECOVERY_NONE, info);
 		}
 	} else {
 		gpu_reset = true;
 	}
+
 	amdgpu_vm_put_task_info(ti);
 
 	/*
-	 * Don't schedule the work here! Scheduling or queue work from one reset
-	 * handler to another is illegal if you don't take extra precautions!
+	 * Don't schedule the work here! Scheduling or queue work from one
+	 * reset handler to another is illegal if you don't take extra
+	 * precautions.
 	 */
 	if (gpu_reset)
 		amdgpu_userq_mgr_reset_work(&queue->userq_mgr->reset_work);
@@ -258,8 +287,6 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 	xa_unlock_irqrestore(xa, flags);
 }
 
-
-
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index b69621311b80..fa4df8d135eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -180,6 +180,7 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
+void amdgpu_userq_handle_hung_queue(struct amdgpu_usermode_queue *queue);
 
 /*
  * CP packs the per-process doorbell_id of the queue in
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 3d27d2aa2cd0..4eeac5a664bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_userq_internal.h"
 #include "amdgpu_cwsr.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
@@ -238,32 +239,60 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
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
-				amdgpu_userq_fence_driver_force_completion(uq);
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
+	 * The guilty queue is reset and notified separately by the caller.
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
+	/*
+	 * Handle the collateral queue itself. Device-level reset accounting
+	 * and the wedged event are emitted only by the top-level guilty-queue
+	 * recovery path.
+	 */
+	amdgpu_userq_handle_hung_queue(uq);
+
+out_put_queue:
+	amdgpu_userq_put(uq);
+
+	return r;
 }
 
 static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
-- 
2.34.1

