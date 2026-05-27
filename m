Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4938ACD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 12:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D293D10E171;
	Wed, 27 May 2026 12:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQruPYQ4";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F2010E171
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 12:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmOe3ZhjsKfiZ6+oqkCimdn0l/U7ec8/d6k1YyCD0t6I07OHJtya/ty9rDSTHsU8ZiBBSvPn+GHsMll7vHav2YcwzzAz++xpfXePaxEiaEY89C25/w+/y/0DGr7cA69jVygj24cYkeMWItoziF80PzFjglB64uzjK1ococ4numX65rAuKvFt/y7sRSeETFWr8gmFoOZrdYWPAX68sCiupjiXRVbj653ZuPpKzY4Np0/PIKAOEyVKiFb//JOX+hTMK/Xy7lRN8m09By+FYwEQDjM2moVSTixVXb8Efw3PL3puNvc/l91oflbWNZOb6I5gJ36sVeTwTVeHBuFv40nwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBr+xZcoc4dZNmYbYzL0YKCvM/T6enW4HMikmrwZ2oI=;
 b=CBcQFa4qJ7FkaNnkSKFCAFrmEvfiD65hO6p94oc14MOIj+F1gAeF6LsUWe7e4VCPzcxwDtkn1nkhEHmyTT3IwT363f1gOh/V/PFmZEe5zOyZ9PQGSQNXZ4nrXiqg5Q4zbZ2t+i/pRD7w6VQaM7TwOKzwYGgruD+wP39hxusbbzKZYTtch+deS0UD6SPki/TKKUavg94O5Sdcsk0iYFNTaUtzrFp/6F7Ge9nc95QGUapiy0OLnt6xYEfbNtMHYza7tjuSSKqhf2RPQGsv8JAAzAZmGCrettJVDmQ25+Si8TBMdIPtEUEEregjfXWnHRHDAJQrqnbWKY6Z8+wTm3LCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBr+xZcoc4dZNmYbYzL0YKCvM/T6enW4HMikmrwZ2oI=;
 b=RQruPYQ4O1zP2JvwPopedqhq01aKRJGOil0Z1AEMACoZfZM0lI1GIJvoz1nm3+uQCFiu/A73RcIt3gPtUZFeotVMBel21r95At96VM5aMJhkMTm9nOnQAHPMnJPyFgx9nhsneKVKzo1zRSdOx3j7Oh2ynGxs2ApJT37LJSNN0io=
Received: from SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::12)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 12:20:13 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::60) by SA1P222CA0169.outlook.office365.com
 (2603:10b6:806:3c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 12:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:20:13 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 07:20:10 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add userq create and destroy tracepoints
Date: Wed, 27 May 2026 20:20:00 +0800
Message-ID: <20260527122001.69831-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 96701cd3-09ee-4f0d-d136-08debbea4db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: nRkCUXbKb4I9BHtF5lPe7xZv4Bosjhn1sVQYNW8WI+niihTJWq9ignv4a2zHHqgIH91Ywy+5MrHCyW1iUhhkVyq0iCKDx0HJH20bAg4VjCMYDCFRQKpiZbSN0VOd6B/RBgz8U7ELGIoc+1NjgCDToAKJzlKdoSlvEatF3KzJ20hvhN+RKx63yS8W+TdAozmOexeoZi6ymWtsU8XHBAIaDV0YBcK70ZkSz/cO7ORROhP6ll4PsPhSH6iJbtaxK8XLgz9JtfNIrppWn2xu4A6ZZ8XeZIhePM0cQLRGY2DRjt9mkFLVmKzVOxv3qorkoS1hDW6uobLi1Ys+CVVPfDGtwUC/PgrdCfxhOJmJLwhZJn427Ftci9BVpQR0JYS6DK4O4wUKOi+12LXwP/5hyNmORQC/C4AJMUCGlXTwLVmb7O9ZpwicvrfbTJ8MP7i06K0R1G8RGlHPYkJYiSaK5kXZRFHCnJDYDx7UWZc717j8+S2/VVeO31r+qosozyjzkKMfMp2kPhtfLSlGgAUQWtdmamyqr0vEzZZYEvDy1gb8F5y6PH4xg2i8zwPoEb9TIIpK7uGBmP3M6Z/nOKfIqZUjKzcxMbqz8KcYIryjg9/EZFa1KQfn301c4tiXGl51gs2gy8TRKohzbywIhDS1m03g//qCMUfrZHFD4H11dH2SOB1Dn9Qar/vmONa6g8WP/s7k3pCRdHIsJQAk7dTtQviU51I6cmkqmiQvm+mA5qJj99A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uAlTlK1/TGYKd6fttYL6X/FlCnlpUxvlZdIOr96vqxNU9v5xaGjxT3DdNmyD1Bq8zchQpDIwH4LM7lktLWJg3JaZcXngVq3AhbbfviMoaHfiIIhKzciei/d9HBmKOGU7js9NldM7FlvLryEa0Kmq2R8H6Xq4CusRxera3nyDvm3Dp0pNOjuHXv29K9B1zG1WxYzhXR9omxgpQYQhylo2Md+bqTeh55VMoqU2HfOObk5a4cTmJmAv3f22p5Mj9Ekjp6u86anMciNHzjLtGBmNHfJPAqKjQZFFZeKsFdvSbThl4PjhLVavOYZcdESZZfKb3xG5HsRWJJjqhhVwZ0SPhck1jTUKO8OUbkNYnt+fnYfTTK34+/JJO+eZDUHF4MXfEIOEjRoXovrftnviCAcARf5YrmHS5sWKLKNBf31rrtdgvEIlYVUAwj9P0mFeEbGS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:20:13.2859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96701cd3-09ee-4f0d-d136-08debbea4db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
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

Add ftrace events around user queue creation and destruction to profile
queue setup and teardown latency.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 58 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  9 ++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d13e64a69e25..df98be22f1f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
 		      __entry->value)
 );
 
+DECLARE_EVENT_CLASS(amdgpu_userq_queue,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue),
+	    TP_ARGS(queue),
+	    TP_STRUCT__entry(
+			     __field(void *, queue)
+			     __field(u64, doorbell_index)
+			     __field(int, queue_type)
+			     __field(int, state)
+			     __field(u32, xcp_id)
+			     ),
+	    TP_fast_assign(
+			   __entry->queue = queue;
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->state = queue->state;
+			   __entry->xcp_id = queue->xcp_id;
+			   ),
+	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u",
+		      __entry->queue, __entry->doorbell_index,
+		      __entry->queue_type, __entry->state, __entry->xcp_id)
+);
+DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_create_start,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue),
+	     TP_ARGS(queue));
+DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_destroy_start,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue),
+	     TP_ARGS(queue));
+DECLARE_EVENT_CLASS(amdgpu_userq_queue_result,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	    TP_ARGS(queue, result),
+	    TP_STRUCT__entry(
+			     __field(void *, queue)
+			     __field(u64, doorbell_index)
+			     __field(int, queue_type)
+			     __field(int, state)
+			     __field(u32, xcp_id)
+			     __field(int, result)
+			     ),
+	    TP_fast_assign(
+			   __entry->queue = queue;
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->state = queue->state;
+			   __entry->xcp_id = queue->xcp_id;
+			   __entry->result = result;
+			   ),
+	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u, result=%d",
+		      __entry->queue, __entry->doorbell_index,
+		      __entry->queue_type, __entry->state,
+		      __entry->xcp_id, __entry->result)
+);
+DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_create_end,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	     TP_ARGS(queue, result));
+DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
+	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
+	     TP_ARGS(queue, result));
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 38e310a8694d..9dc6cb579ac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -33,6 +33,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -509,6 +510,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 	int r = 0;
 
+	trace_amdgpu_userq_destroy_start(queue);
+
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
 
 	/* Cancel any pending hang detection work and cleanup */
@@ -538,6 +541,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_bo_unpin(queue->wptr_obj.obj);
 	amdgpu_bo_unreserve(queue->wptr_obj.obj);
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
+	trace_amdgpu_userq_destroy_end(queue, r);
 	kfree(queue);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -639,6 +643,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
 
+	trace_amdgpu_userq_create_start(queue);
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r)
 		goto free_queue;
@@ -700,6 +705,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
+			trace_amdgpu_userq_create_end(queue, r);
 			mutex_unlock(&uq_mgr->userq_mutex);
 			goto erase_doorbell;
 		}
@@ -716,11 +722,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		 * This drops the last reference which should take care of
 		 * all cleanup.
 		 */
+		trace_amdgpu_userq_create_end(queue, r);
 		amdgpu_userq_put(queue);
 		return r;
 	}
 
 	amdgpu_debugfs_userq_init(filp, queue, qid);
+	trace_amdgpu_userq_create_end(queue, 0);
 	args->out.queue_id = qid;
 	return 0;
 
@@ -736,6 +744,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_fence_drv:
 	amdgpu_userq_fence_driver_free(queue);
 free_queue:
+	trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.34.1

