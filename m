Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D5ECD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 06:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB5110E07F;
	Wed, 20 May 2026 06:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QDi9YWzf";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AB510E07F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 06:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aP9hEgP/9t5wo7fpf/hc7BlOvaTk/Tly0mAK/wkB1SGqHPKCxsBj2i/HXsm2kIyv9zN5yZ+H1KPzSxVKY/rqKr+ZSa9le7RF18X/0c7g9ZIjq5Z8MoeHfSYF3mVoyWldExtumIXU9rOzLw2U5thVVXMsfgYuzeGLW592bo78tcWtf8xk964Izx3/kSjt3kaV+JgHratE0v/P7109ML03Z7d/IEWKSdLHzMT3MUurfF196n0vDRC/O21I0LSttTl+fOxjDANFJAZetrRT//h7e1ERmqXaCNL8LSSy/fd+yKt5a8fYYzPm2IyYRp2cnXViC16GvScnBFLHGQCui9a0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUgu8cbfftClfuFl3PBIGtoB83LA0GoERz9S381sU20=;
 b=S+HMyq0togGWrKVmh2VmIBeilf6+VmKZNXFbPaPsoUc26BQDNVyjjq/k8KzepWy5wsAS/UjnGF2+5QNwStnChdUVcYGz5gw0AYnTfq61Awn7vcWmh0lFvDhTNUdXj5IZjj4V9C1uPOGR4iaDsNd7p8LXTI7/TXqk9nsiTOMQrzE89wyR5xNaZOfqqCI2Emmfi2jT2OCJ2ZVtB/S9EOhPUYk4Q2+zzRt4YE/su7bvtsyG/St5wxNXYQfCBHQL4+7xbeKLcXFgfkTk335ixAcMOmOs6O2bH4FN6WtRW3QSy/W4BbqjWw/0CQs493x0FbxjSqVqe5Vwl9UJ6Vr99F/tSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUgu8cbfftClfuFl3PBIGtoB83LA0GoERz9S381sU20=;
 b=QDi9YWzfJPolxCMHCv8tq4ohJuj9MOCMoTGkdEzDogFsu28MzZjme76cxiaa8cVW+EADpOOvDmb4uWvYY9POC16kLV0nBqL8x3qAwCnbmpZa21ePtj86Eej66cSATqZ0187HeK5Jj6xwh+ICkiny8BweqSYArkw0WtQi3KeqHG0=
Received: from SJ0PR03CA0353.namprd03.prod.outlook.com (2603:10b6:a03:39c::28)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:39:25 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::35) by SJ0PR03CA0353.outlook.office365.com
 (2603:10b6:a03:39c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 06:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 06:39:25 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 01:39:23 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add userq create and destroy tracepoints
Date: Wed, 20 May 2026 14:38:57 +0800
Message-ID: <20260520063859.15914-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 5997783b-99b7-454a-c857-08deb63a88fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: N+Rpl5S+evgM3sd5UslqPGO/zAjqHmnrYwvWr+9W/gtS0273mp2c23DIeeo22Z0qlKbI1RDnXwZqeVTkBBNKdWdasCcZnmELrXIg69Kk4a2JbFxbDgyk0KDV76xWsu4Y+3qQSJFYUijddlDVPuigcrIqQwX3+EVb7tK0eImmbUAKECgTZ/uIiiY+kIqh5ZFZnE2Kr7o0xYw/beuOzJ3VB6vt9nTiItuBoD11Vo8xBklssek/TbMPZb1ItmKdHUkGwhqfr2JlxE6caYlZTHPFrQ2R7OVUam6TVm7EXv2nh/ZVSXPcKVsuFd+UjfrhkRw6pqj8CERXT+V/cpdNTsp8Z1f66CkCM7kSn+xdhKm9o6FUGqvtAk3xNAZKenJh7WN6a7syGYJO7VwI9R7gKs4eMTbblUwwXW+ejtzNxiRzW1jWpoLdBnX9nnpzN0HrT7/lnCqZ8vAf5EISAUbxugfGPriwDJFc3T9R/M0Jh7MqoIWnMgEaAivFoqE9u/M7sVlQQLpuxa1b8U5WHRWnxo7Zy2fJVlNVtSBE/H4IM/2/nKN+AbACU3Knmb1IljpdWTE9m1+2yh4zW6wEl+3vFfKg7z0s+0vmYoXPPiRXGHh5bOAIp0fN24Vq8DYuLO9U0hTS1iC/oPjAE+oBsldCCBb7ajJe7dUYKGsnGONAV0nG1977915eJLuJdsgEuYAJ7K8Yo7sCT/UBOK1AE5cpFlNcZ+uYNtEILcmzJqXtHaPTCno=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yZIXu8ZEgitmXGNCdCxACewJvEMnUi0WWgqhETfdmIvlYONZyjF9vQu+uV8NHUowh4joPVpeHiU5X0/lKlqhMAjWeAXzitEDn3m1GDpgmNrxhHPcndCJvhDeWNL3wQ53QS6LVIH1c9vXOHnzJlS/4Jvv+2Oeh2Y4M5uleiUOlrSZTUOlJICUBLUuDABMBCBDHOVKRAAmMOxOO+aldbz71jUzf/ledGvgkhL/SHjKoph/Z0QY4iIF5JAh48keZcVw9e34/0NUqOVDje0PHPk/tRHZEeL7UzMf4SSLmb9wOQMgzXAwpVQ2/YqtiVxgU24fm0CIm+DaDKH2pvIMJkFEYXLps0QrqP841IXs8YTxDoN/nJl5HdSiiv8KYkUi4sLZkOkfM4v5EKwshhi3ileSYq5hy7kEDcsEF3kShyjfw1kFWuzCuqr3SQfxewDtyCwa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:39:25.4565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5997783b-99b7-454a-c857-08deb63a88fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d13e64a69e25..5a01f63d1f32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
 		      __entry->value)
 );
 
+DECLARE_EVENT_CLASS(amdgpu_userq_queue,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue),
+	    TP_ARGS(queue),
+	    TP_STRUCT__entry(
+			     __field(struct amdgpu_usermode_queue *, queue)
+			     __field(u64, doorbell_index)
+			     __field(int, queue_type)
+			     __field(int, state)
+			     __field(u32, xcp_id)
+			     ),
+	    TP_fast_assign(
+			   __entry->queue = queue;
+			   __entry->doorbell_index = queue ? queue->doorbell_index : 0;
+			   __entry->queue_type = queue ? queue->queue_type : -1;
+			   __entry->state = queue ? queue->state : -1;
+			   __entry->xcp_id = queue ? queue->xcp_id : 0;
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
+			     __field(struct amdgpu_usermode_queue *, queue)
+			     __field(u64, doorbell_index)
+			     __field(int, queue_type)
+			     __field(int, state)
+			     __field(u32, xcp_id)
+			     __field(int, result)
+			     ),
+	    TP_fast_assign(
+			   __entry->queue = queue;
+			   __entry->doorbell_index = queue ? queue->doorbell_index : 0;
+			   __entry->queue_type = queue ? queue->queue_type : -1;
+			   __entry->state = queue ? queue->state : -1;
+			   __entry->xcp_id = queue ? queue->xcp_id : 0;
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
index 3bfb9ae2cb3a..e27f9a76f986 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -33,6 +33,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -613,6 +614,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 
 	int r = 0;
 
+	trace_amdgpu_userq_destroy_start(queue);
+
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
 
 	/* Cancel any pending hang detection work and cleanup */
@@ -621,6 +624,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	r = amdgpu_bo_reserve(vm->root.bo, false);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
+		trace_amdgpu_userq_destroy_end(queue, r);
 		return r;
 	}
 	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
@@ -646,6 +650,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_bo_unpin(queue->wptr_obj.obj);
 	amdgpu_bo_unreserve(queue->wptr_obj.obj);
 	amdgpu_bo_unref(&queue->wptr_obj.obj);
+	trace_amdgpu_userq_destroy_end(queue, r);
 	kfree(queue);
 
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -748,6 +753,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
 
+	trace_amdgpu_userq_create_start(queue);
 	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
 	if (r)
 		goto free_queue;
@@ -807,6 +813,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
+			trace_amdgpu_userq_create_end(queue, r);
 			mutex_unlock(&uq_mgr->userq_mutex);
 			goto erase_doorbell;
 		}
@@ -823,11 +830,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
 
@@ -847,6 +856,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 free_fence_drv:
 	amdgpu_userq_fence_driver_free(queue);
 free_queue:
+	if (queue)
+		trace_amdgpu_userq_create_end(queue, r);
 	kfree(queue);
 err_pm_runtime:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-- 
2.34.1

