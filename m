Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12C7CD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A8810E749;
	Mon, 11 May 2026 13:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v0rsyR7U";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655CC10E749
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIsF+ivpOxjl3n4EeOCyAjnn9BaqxIfRagbQ9I7rEWVmzDz6cs5q0Zg49HMhf/tDQOq6Mo/VrsFHisSFs0EZUB4ysim+KavCBNBkpZwYz2C6K9xHOhkWMFeXhkySQ1UbJtfp/I7bKfSiSnS5Kr5supbx+nUNCNF3Bs7Jzhr8HQgjdpYP+GHg6WnpMdhTyJkBIPmw2kbZ4Rfrqp1H/G+IhFbVimuIRZPWljqYMsHsbGNXsuet44e5HgV2P2F7sLc2F8NfNYJdownspf+tNdEZia4utETqt1bi7Djcwf9CVEr3ITY2X3pGPOu73YsZgRgsE0C4e3ahbznroN4BE2Gl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8tJI1L5XsEeCD1joIN3k+HxIM/tRbcDc/ZFuLe2zrg=;
 b=FNU6gBFlPcJtQRtR6XxdHcZLW3Dlic0NDgyG2N034PTQy1Lda+MiwxOZQR4ISGLBBTWi6BoM/ObFUopZ/vsqGPDtG4D59h8moZGzsXPov/Daw1+OpgzKFKirjwCvgfIr30cFzHVdpgDw9mWYqk8qEV5I17PdIpKkBZ1FU/IUBgD0rtPFxbbC+3lUuP+WFg3Q43szPf/TnSivHRIoo//Yl8KfLUiIz86pEEtv0kmhSu37EwWpcpado3YWBucDVOW90Sbxsku9Kxj/JtpqaZ/ufg2hxdMbKk+tNNneyvptKiJwm98H1zIN/MkqH5JTn1r1BFwqGrtixre1a2uPcCvYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8tJI1L5XsEeCD1joIN3k+HxIM/tRbcDc/ZFuLe2zrg=;
 b=v0rsyR7UiUVllVXJG/nINyZnEjRyxgLeAQtY/6qa1rwvGjU83O0LY3ztzOZRSlEmbUf9BKTGd5PGUcJzVjS2gOzZHTh0uQd7hw5vwBgZ6uR4cpgiCq2GcmClu52EqLiCzczoQWKxDCeqjlw+4wPgua89eWN/77Tec09AShIRGus=
Received: from MN2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:208:1a0::18)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 13:54:50 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::73) by MN2PR07CA0008.outlook.office365.com
 (2603:10b6:208:1a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 13:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 13:54:49 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 08:54:48 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add userq fence emit and signal tracepoints
Date: Mon, 11 May 2026 21:54:34 +0800
Message-ID: <20260511135435.3818345-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511135435.3818345-1-Prike.Liang@amd.com>
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd9881d-6b9c-4093-e655-08deaf64de9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Aj7BOHpFDFlb5o9a+2zd5zUoI9ezo8UlBhoJSaHbo/TAw7keVEU7e+sze68Qulfs0ZcQ+IliIh21FictSj9SHy3ORCwc8XmGiMBEhuzT8WdCEyfxmlez4FfNIHOWA+BcPPdd8o+JCTADqQDmUMt3nw4fZAehWa8CKx/o01vQxI1orBx2A2WxdwNMmSs5diirsfM3U/H4r6IZtbTMV3tS1FiW+Y05AICrlmObhVM6iyDJ7yFpPOFvqOGV7y66uaYPt6Ax9cEQ4NXCF8rxT6nwVFqgWnLYcPZioKyYuy+a+ODpcyhqYh7D6auNTibFZH5TvtNfgmb2cUS0PPRjy054VLPGE3LLRxy9eCGOMGA80Cob7i96G7tz98J7bUXl+WvOejU3numC+/s2oPQ9SbTvodW6bw5UUQm5t2OQ8vPA0gvbfDRoEZRQOkZuexIJGEW19SpUCDDtB4MDpbgQwsFXrMk8wmBEGOhxhIA6WV+03pzW2kwH8Dn+oDugVJ0QcTOC+Do0hALgmZvTkAdQIFH9G/eqFPRb40H06+o3Z/tYjQvp8Zt4GCjuujs8tzPdAgBf9f4FrtLW5lhixZzqf9dw8h7FK6XOwhob8UbHcaKxPTqbUK8Am5lKZIGM3A6KUy5/P5s3TxwYx9x7QHEc/fZwdrD+V6L7w86N0OlKcXE0XhwP4/GE9Zff9Mq4v1A9XfVmGM3xL6mH+jaV4qgGOaVlJiOPDwPQw4P5ahkk/eUxvks=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g2+FOrgCugq0nieifNg5w7Fs1SVOswUc415nsaSalFMDOGl368NuudX9W73m8QvV1AQY5Hsthc7TYIBTILLSqFkP4zWxXjI/s+6PXrmluu4xEMOTxiRJ0QrSAFczSWgDUs8Dt5RblltNXWWjEpPhjiAUa0DJKUn/LF4AePqg8HFBqZeLCKB1UEH7dsvArONtpcQyKOrIGzDCmcAFfikUK3rsFJ3/+33r4/XzS1KkWY4KMMlIIZEVOzcYVyuIWnMvbkkCJX9rp//qqHjJnM2iQ6DdeYaSbtTBfpWaaZjLxcA6IYqnoYbChjZfOfJrxW0z/3+7wLSja0f31M07NgjG1koTn+8/c6eSvGpLZSN3vT5n6KkE8CIA41sI86+yI0VEPWbwhQu5kr5xAUVPaHDFpEmv52Rd5PUoPOaSqqRhSHmnKUuQZpquVG+fvfNoTBX3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:54:49.9240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd9881d-6b9c-4093-e655-08deaf64de9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
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

Add ftrace events for user queue fence emission and completion.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 48 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  8 ++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 484fbb00068b..d421a44ef933 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -661,6 +661,54 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_map_end,
 DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_unmap_end,
 	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
 	     TP_ARGS(queue, result));
+
+TRACE_EVENT(amdgpu_userq_fence_emit,
+	    TP_PROTO(struct amdgpu_usermode_queue *queue, u64 seqno,
+		     unsigned int num_read_handles,
+		     unsigned int num_write_handles,
+		     unsigned int num_syncobj_handles),
+	    TP_ARGS(queue, seqno, num_read_handles, num_write_handles,
+		    num_syncobj_handles),
+	    TP_STRUCT__entry(
+			     __field(struct amdgpu_usermode_queue *, queue)
+			     __field(u64, doorbell_index)
+			     __field(int, queue_type)
+			     __field(u64, seqno)
+			     __field(unsigned int, num_read_handles)
+			     __field(unsigned int, num_write_handles)
+			     __field(unsigned int, num_syncobj_handles)
+			     ),
+	    TP_fast_assign(
+			   __entry->queue = queue;
+			   __entry->doorbell_index = queue ? queue->doorbell_index : 0;
+			   __entry->queue_type = queue ? queue->queue_type : -1;
+			   __entry->seqno = seqno;
+			   __entry->num_read_handles = num_read_handles;
+			   __entry->num_write_handles = num_write_handles;
+			   __entry->num_syncobj_handles = num_syncobj_handles;
+			   ),
+	    TP_printk("queue=%p, doorbell=%llu, type=%d, seqno=%llu, read=%u, write=%u, syncobj=%u",
+		      __entry->queue, __entry->doorbell_index,
+		      __entry->queue_type, __entry->seqno,
+		      __entry->num_read_handles, __entry->num_write_handles,
+		      __entry->num_syncobj_handles)
+);
+TRACE_EVENT(amdgpu_userq_fence_signal,
+	    TP_PROTO(u64 context, u64 seqno, u64 rptr),
+	    TP_ARGS(context, seqno, rptr),
+	    TP_STRUCT__entry(
+			     __field(u64, context)
+			     __field(u64, seqno)
+			     __field(u64, rptr)
+			     ),
+	    TP_fast_assign(
+			   __entry->context = context;
+			   __entry->seqno = seqno;
+			   __entry->rptr = rptr;
+			   ),
+	    TP_printk("context=%llu, seqno=%llu, rptr=%llu",
+		      __entry->context, __entry->seqno, __entry->rptr)
+);
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 369914cab555..50d1c3627279 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -31,6 +31,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_trace.h"
 
 #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
 
@@ -168,6 +169,9 @@ amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
 		fence = &userq_fence->base;
 		list_del_init(&userq_fence->link);
+		trace_amdgpu_userq_fence_signal(fence_drv->context,
+						userq_fence->base.seqno,
+						rptr);
 		dma_fence_signal(fence);
 		/* Drop fence_drv_array outside fence_list_lock
 		 * to avoid the recursion lock.
@@ -530,6 +534,10 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	/* Create the new fence */
 	amdgpu_userq_fence_init(queue, fence, wptr);
+	trace_amdgpu_userq_fence_emit(queue, fence->base.seqno,
+				      num_read_bo_handles,
+				      num_write_bo_handles,
+				      num_syncobj_handles);
 
 	mutex_unlock(&userq_mgr->userq_mutex);
 
-- 
2.34.1

