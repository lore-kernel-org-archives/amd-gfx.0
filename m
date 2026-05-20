Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802F6CD5BAB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 06:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07EB210EEF8;
	Wed, 20 May 2026 06:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sLrQbXKk";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6415C10EEF8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 06:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIQoVQhJhRW3iXgqEe+HXczX7eGL2zGIBeDFr34iFnrdLD+Ed237xHAXUj5mseo0t3YewCoLCtrro1QjQiTygTH4vOEa+exLH3V5iDJgCr4elvaTDDV4PJEr0FtiLAdtH/sHMVGedRVWLFI4Yu3Vo0jgax+omDj5ZNOVeP1Qa5heL+1QEI2g79b74aHWtXKFm6O8yCWBjonLaYVcs1u18ltV1OT8tOufzQkvMIwpRgRxRs2p4dNY7cjr6mHo4wWk/7wLWZSZ2i6H1+IugbyIAI/Tzj7Sj70dzzjxSVUQhRlQajgwDLxBD3I18GZma8oxgKNHoBXOrrt9pGiRMKLftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au8gYzwnigzQv9NFmOkH5fkMXfYksL69XSwsM1x/E0U=;
 b=dgI2eLHlMDimviMZ5QlvyqW3Z6biPpP0Jocr4wWtLWAtl9nsEArEzQWhwQdIsXW9KqpPSIjZB7/Q1xoHo7/0KOPcNuw76VWDA60wt/LAvMUSIt1ZJjXZenxnynuf+441o8SnrLR3dYvvmxkqHY9WMlPcitrBBE5YVfiBmTFQ3lB1Uoo3gLsFtYhIKcGgV7uHRx+L5yMFTtQlcK0csjo7/4nsbZ1+SrjgJP2j9le03RdIQGQZ30c9H+/ZZqXMDuZcGgW5+cGY2cq5VKTOjG8KEg9vVJ2p9/+olWeTB0MLqJVk8vbICgIwTxQ8c0k/TaRIJ2yLHvu0psKEVS6BRBXrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au8gYzwnigzQv9NFmOkH5fkMXfYksL69XSwsM1x/E0U=;
 b=sLrQbXKk4P7YMbYaaz/31BiT8ZcXliyVJ/lVUWHXBx1E+5wf9OdXriaHiGeQdBK3WerQ2RSKwEM7NCfKFMxh8suWB/yRRJKQehI/RQa9E1a/fHO3nVJbr+WzrfYoDDQKx+vxw+EoAw9RF+0pZkS/RrT7nPOob/P/FqYfHyD9Ko4=
Received: from SJ0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:a03:39f::9)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Wed, 20 May
 2026 06:39:30 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::dd) by SJ0PR03CA0214.outlook.office365.com
 (2603:10b6:a03:39f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 06:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 06:39:28 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 01:39:26 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add userq job and state transition trace
 events
Date: Wed, 20 May 2026 14:38:59 +0800
Message-ID: <20260520063859.15914-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520063859.15914-1-Prike.Liang@amd.com>
References: <20260520063859.15914-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d9c37d-502f-4dca-cce2-08deb63a8b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: pv4Eh97lA49VNfoUWv111jC8baBXajxzhpAFkabqh560mRzZqYfq9nPFIVeOUaMU6HJ6Z7pVbk5D+NtFA7El5eH1BsZ+3EGOz3BmhQezFPilvOLey8oCBZpW60XjIlqWPoYLzJk9P0zuLkQrCeOylXYumCdE3u57ZBNTmvJQI6rnIO8zOd5YOoyVoJnZW6loALUpzU9jDmhRIBcDoIbEpDQ5cZBEDP1cAYXX8KZMf+gyHSincXHos4XRsRAteoPHmcpnFmVT9JYKGDsJ6seK6Z+LzkafBjgKisrKcGiCvy2gSaVfW9r0YX5Y7n8jLHKKmbdNKH4qBRmBONZL6NIuJb+1ZJlTlKZIwcmLA0nOOjIKPx9/ocG+z0u9nB7umL4zVcLBvheE45IsmyTbrc54rEC5tiyZYDFcf0AV/NfWRNw4bNv9MCUkmF2YHjlFwU9osjfI3muNI8kZrlm3IJrA5i4MFnf0ytIvXEABfEGhVKbBC47sdBTZyD3IKgR2YzNwyTtUkVkbQoJ+la32ttRyo5/8hkjU9kiIIEB5un/VIuSlyhZuqFKgHySJvIFzzM5lL/Lr3u3pbvrk2OWYnp2fMUBVkAHP8su/UVU0pft2ppeava4E5sSr4S7nGsii7ICIRx9F97Gz8SLOqQUk0gAwKUlxQoUM6CtRXy+RJO2haCLmY6lqHY4Kw9+S/DXNf9kCdu1AJcYjUTzMAOhqL+oxD+auBf2aL/uGt4T3dyUrIDw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VKxHHI2j7FDGwECzhEeO2k21lX0EO74qj6yzEN0/x9zVh0JAONgjGUqe+lH6ORgHZjX3nJqk8x8ELEwrdYuXwBI+V0FVPGTeUUvsvatt5ScBAYUWBlsx3tCVGgfYC3hHMxD4Wt9lYnQZDq8Dy3gxIUK3UYXH6+zkLlYzXXsUZehxX4+FFtY+5Ef8SDocPNlzzVlw3D23ya5CjVmMHVMeyrMwk+pwKO1qGrr2n8BfF0cg85G7i4E2equClRPS0jP6TGL/yI+Jm8TY5MEjgfveIELd/96OKnno24A0WJYii1HBKKsZnyaQU14MpSmUuAjdxFOxf5hc6zieGkezoPpnpvSBoFbL6L920sjqaCV6DS7UwIYU27CTL6bfoMltVM44PvuQ+41yAr3KYWCTl4+GtCKJBZiqWNFjzdWWHDqpV4Po93/wP/Pf9Wi/xrTemcH/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:39:28.8533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d9c37d-502f-4dca-cce2-08deb63a8b00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Add ftrace events for tracking the userq fence emit, signal
and queue state transition.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 129 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 +++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  13 +-
 3 files changed, 160 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 4ff8a4d7bb8b..32d8c36caaf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -28,6 +28,8 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+#include "amdgpu_userq_fence.h"
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM amdgpu
 #define TRACE_INCLUDE_FILE amdgpu_trace
@@ -659,6 +661,133 @@ DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_enable_sig
 DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_signal,
 	    TP_PROTO(u64 context, u64 seqno),
 	    TP_ARGS(context, seqno));
+TRACE_EVENT(amdgpu_userq_job_run,
+	    TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *fence),
+	    TP_ARGS(device, queue, fence),
+	    TP_STRUCT__entry(
+			     __field(u64, fence_context)
+			     __field(u64, fence_seqno)
+			     __string(dev, dev_name(device))
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     ),
+	    TP_fast_assign(
+			   __entry->fence_context = fence->base.context;
+			   __entry->fence_seqno = fence->base.seqno;
+			   __assign_str(dev);
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->queue_type = queue->queue_type;
+			   ),
+	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, fence=%llu:%llu",
+		      __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index,
+		      __entry->fence_context,
+		      __entry->fence_seqno)
+);
+
+TRACE_EVENT(amdgpu_userq_job_done,
+	    TP_PROTO(struct amdgpu_userq_fence *fence),
+	    TP_ARGS(fence),
+	    TP_STRUCT__entry(
+			     __field(u64, fence_context)
+			     __field(u64, fence_seqno)
+			     ),
+	    TP_fast_assign(
+			   __entry->fence_context = fence->base.context;
+			   __entry->fence_seqno = fence->base.seqno;
+			   ),
+	    TP_printk("fence=%llu:%llu",
+		      __entry->fence_context,
+		      __entry->fence_seqno)
+);
+
+TRACE_EVENT(amdgpu_userq_job_queue,
+	    TP_PROTO(struct device *device,
+		     struct amdgpu_usermode_queue *queue),
+	    TP_ARGS(device, queue),
+	    TP_STRUCT__entry(__field(u64, context)
+			     __string(dev, dev_name(device))
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     ),
+	    TP_fast_assign(__assign_str(dev);
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->context = queue->fence_drv->context;
+			  ),
+	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu",
+		      __get_str(dev), __entry->client_id, __entry->queue_type,
+		      __entry->doorbell_index, __entry->context)
+);
+
+TRACE_EVENT(amdgpu_userq_job_add_dep,
+	    TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *dep),
+	    TP_ARGS(device, queue, dep),
+	    TP_STRUCT__entry(
+			     __field(u64, context)
+			     __field(u64, dep_context)
+			     __field(u64, dep_seqno)
+			     __string(dev, dev_name(device))
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     ),
+	    TP_fast_assign(
+			   __assign_str(dev);
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->context = queue->fence_drv->context;
+			   __entry->dep_context = dep->base.context;
+			   __entry->dep_seqno = dep->base.seqno;
+			   ),
+	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu depends on fence=%llu:%llu",
+		      __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->context,
+		      __entry->dep_context,
+		      __entry->dep_seqno)
+);
+
+TRACE_EVENT(amdgpu_userq_state_start,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue),
+	    TP_ARGS(queue),
+	    TP_STRUCT__entry(
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     __field(u32, from)
+			     ),
+	    TP_fast_assign(
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->from = queue->state;
+			   ),
+	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, from=%d",
+		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->from)
+);
+
+TRACE_EVENT(amdgpu_userq_state_changed,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue, enum amdgpu_userq_state new_state),
+	    TP_ARGS(queue, new_state),
+	    TP_STRUCT__entry(
+			     __field(u64, doorbell_index)
+			     __field(u64, client_id)
+			     __field(u32, queue_type)
+			     __field(u32, to)
+			     ),
+	    TP_fast_assign(
+			   __entry->doorbell_index = queue->doorbell_index;
+			   __entry->queue_type = queue->queue_type;
+			   __entry->client_id = queue->userq_mgr->file->client_id;
+			   __entry->to = new_state;
+			   ),
+	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, to=%d",
+		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e27f9a76f986..60d1186af286 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -329,11 +329,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
 	int r;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		trace_amdgpu_userq_state_start(queue);
+
 		r = userq_funcs->preempt(queue);
 		if (r) {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			return r;
 		} else {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_PREEMPTED);
 			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
 		}
 	}
@@ -349,10 +353,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		trace_amdgpu_userq_state_start(queue);
+
 		r = userq_funcs->restore(queue);
 		if (r) {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 		} else {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
@@ -370,12 +378,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
+		trace_amdgpu_userq_state_start(queue);
 
 		r = userq_funcs->unmap(queue);
 		if (r) {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			return r;
 		} else {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
 		}
 	}
@@ -392,11 +403,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 	int r;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
+		trace_amdgpu_userq_state_start(queue);
+
 		r = userq_funcs->map(queue);
 		if (r) {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
 			return r;
 		} else {
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
@@ -1007,6 +1022,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
 			continue;
 		}
@@ -1502,12 +1518,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
 			continue;
 
+		trace_amdgpu_userq_state_start(queue);
 		userq_funcs = adev->userq_funcs[queue->queue_type];
 		userq_funcs->unmap(queue);
 		/* just mark all queues as hung at this point.
 		 * if unmap succeeds, we could map again
 		 * in amdgpu_userq_post_reset() if vram is not lost
 		 */
+		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
 		queue->state = AMDGPU_USERQ_STATE_HUNG;
 		amdgpu_userq_fence_driver_force_completion(queue);
 	}
@@ -1526,6 +1544,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+			trace_amdgpu_userq_state_start(queue);
+
 			userq_funcs = adev->userq_funcs[queue->queue_type];
 			/* Re-map queue */
 			r = userq_funcs->map(queue);
@@ -1533,6 +1553,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
 				continue;
 			}
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 008330a0d852..00cc7194321c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -30,7 +30,7 @@
 #include <drm/drm_syncobj.h>
 
 #include "amdgpu.h"
-#include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
 
@@ -169,6 +169,7 @@ amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 		fence = &userq_fence->base;
 		list_del_init(&userq_fence->link);
 		dma_fence_signal(fence);
+		trace_amdgpu_userq_job_done(userq_fence);
 		/* Drop fence_drv_array outside fence_list_lock
 		 * to avoid the recursion lock.
 		 */
@@ -528,6 +529,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	/* Create the new fence */
 	amdgpu_userq_fence_init(queue, fence, wptr);
 
+	trace_amdgpu_userq_job_run(dev->dev, queue, fence);
+
 	mutex_unlock(&userq_mgr->userq_mutex);
 
 	/*
@@ -701,7 +704,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
 }
 
 static int
-amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
+amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *filp,
 				    struct drm_amdgpu_userq_wait *wait_info,
 				    u32 *syncobj_handles, u32 *timeline_points,
 				    u32 *timeline_handles,
@@ -835,6 +838,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 		goto free_fences;
 	}
 
+	trace_amdgpu_userq_job_queue(dev->dev, waitq);
+
 	for (i = 0, cnt = 0; i < num_fences; i++) {
 		struct amdgpu_userq_fence_driver *fence_drv;
 		struct amdgpu_userq_fence *userq_fence;
@@ -869,6 +874,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 
 		amdgpu_userq_fence_driver_get(fence_drv);
 
+		trace_amdgpu_userq_job_add_dep(dev->dev, waitq, userq_fence);
+
 		/* Store drm syncobj's gpu va address and value */
 		fence_info[cnt].va = fence_drv->va;
 		fence_info[cnt].value = fences[i]->seqno;
@@ -968,7 +975,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 						   gobj_write,
 						   gobj_read);
 	} else {
-		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
+		r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
 							syncobj_handles,
 							timeline_points,
 							timeline_handles,
-- 
2.34.1

