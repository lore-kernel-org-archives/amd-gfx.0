Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3987CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705E01120EB;
	Wed,  3 Jun 2026 16:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ivSpKuVH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F5C1120EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXYor1gGWzf3IOVIeBcfPls2OP0kuEIFCopiQU4KMoxwWfRSoD8ZgHcP42Vnosnhbg98Ecx7DKjrAD1qFCYpxXYlXLa5v6NAue8388TuV5MO/xex7QWKrTdVkBeKcbIgbxHSOzgLsN2Ia/ohmM6tiMT3VBOBVBAE4Bhj8clcs+yYnOZ5b25omqUAsuE5xDo7iOCA+8FI1oU5y+nXqaa0XbFICcG+N2KlSqxd7DfQNTzCmJr1br9rKneXbkZyJ+hCYP2pf35fiEOJIGdxHJe9cPYV1+qp3lwLD4NiT0tAzJOevPsh5mA3WE4ZDO6jQYb0WOtfLmw5YQLi6dzePDxIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkwhQDZUTJpUVVOrADe3XSdOjQEJ5nBLt1NxmBFqdq4=;
 b=MWzSEvyFdQjJv0faJ1Ua8huT2rCl/ckmUb/YZof9DjKZGUvr7JRyDQnvTyprC1r/sm9d4oN0tO1nSgwjV54+NOHTnt8JW8ASej9X/vLnKi8hqozNFi387kE3bf1vLKJrBPadF1qCBNtTada1nzW95fQcX3s6E0dDkYF6Nr3SrYUBQt5k/7guATKFTbMI5doDtEkyBWw13AlYJ/ptQoIBCjBVHBVZWpmHHsw6sFR+uKAkKfoWzYrz5gmiHjM2PXtn7uputRYPSVpLeLZslGwp3CWBy0ohvOWfoxz2cDjIbU/oT5tVKKwxgRPWqoLz6yodeaKHd+WZXOkMcVjHLvBCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkwhQDZUTJpUVVOrADe3XSdOjQEJ5nBLt1NxmBFqdq4=;
 b=ivSpKuVH0MX/tmxdNzWLdy4lS/kyYr5R7xQWG3XdMPy0fMMuAmrSJFKQtJf439vWf64P8nhaukdMRKmlBgLTeelhc9Ow5hzMhniRbmi9iuGl+kSTkWOg5Gy9OUJARSwQpDLpJmC8htr/ITOmlP331WSwRiz8VlxKHrvbS/cfulo=
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:36:21 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::c) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:36:21 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:36:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Route events through debugger
Date: Wed, 3 Jun 2026 22:06:02 +0530
Message-ID: <20260603163602.2678435-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
References: <20260603163602.2678435-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: ffba2a87-455d-4135-6502-08dec18e3ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RAHAC/5NCMNlGViz7M6Q+u+NIsJR531pN4ycv7JNhKNUKYx6agXUqDO99IcZuvUJlG0Ew5geAt5j23hb3IFw5g+5quGWx6ehqgEzSSQ2Edu+JyFxxGJhxnP4LLmbh/bAADWCDhPXsF0Yn6apizgAI7lDTugfA9g9xmXGebmdIz4bnsb2sinI5KPkctQcklYq/esKluPf/zIaY5+amDVgBJN/EscIeYF/q0Ou3alTpiSKpYTzn2jLelx2pi034jKKZ9vZ0+BfFcxnBfMkVkA9qQdir3+iv0zikQjvvyhLX3zMCRXeTjOi006gcdRCwnDe/1DEsrL5Ds1yJvWJtyjcvSWlFqqjpoQ56zBQi36vyOe/fXbM2Ztvy2H9LbD8jEgg5zdn49N67i09HVkYmGIPQ4JpXYrItdFxOsnaVMaEASom6fUjMJhpxUSMUj+NrzB2+COg3Ru87BuelefE79HI+cPslLGlABFxArq2v/koXTiSBGk8wTYj2a7rWy+Ab/pDJ9P9qVsnnd9ZlBjTTd2h/6sMt6VphdL+7lHuaCoJUO/PnEnKJ6T0nC47eFYLKwYMG1I6jQZNruBZ+OJuCCeX6F5CXpyGh5VV8XSrMOy6c/agLfw3zjfIO6MDXO7rFY3a1JkPo9BqtlCurrpO4aP5+fTxmSNJoveq8sndhEzha3Mc/kY0vfKWb8MWUjCyeTNNNNcKCg6fh8WxirsWDy1W/phYPWCYGdVaVdy9atkYvuw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z9IK/aaHFvOUqqGWTcz48JMnClr6Cj3yC4dXKCUkmw8Pb5En7EjuwxSc/QZHK+oodKhODAqVUezToECxwQo2sWGe112KI4N/NmZcfwScMx4IS0qvq8+/AD4AaQ/eNAtc4E7doeQ0WlbUt0bT2UkGEHAdYOptSFsAunme26ExbUaHbuo3tRe7RQW9VOZFuKQQvhXYbAVyflP1dHTIIdOZC7Z+mFreTXfTuwGLVYWqmu36bcKMfjmoYeAGFMTUHit/WCYXIrgbukGIJ+wHxjWImjplgxArB2nYprC/M2RPpNd+KQpgO+1rDepGo5wVGx1ZOwXB3d89IJgrLYrMNK0LcwO3a4D3VVQF0LaPGfUDS6l1Geo9A0BsxIRkqXB2IKz9XpOZ5c1e081TXqvsaYy7G3ZBZ4wna0jfqVxkXFBciQGyuxVc50l7V2xsPyYC1sKa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:36:21.7689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffba2a87-455d-4135-6502-08dec18e3ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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

Route existing render-node events through the debug event layer.

Without an attached debugger, the helper immediately delivers the event
to the normal EVENTFD and WAIT_EVENT paths. With an attached debugger,
the event is queued to the debug fd first and is delivered to the
application only when the debugger forwards it.

This keeps EVENTFD notification-only and keeps WAIT_EVENT as the
metadata path, while adding the debugger as an optional routing layer on
top of both.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 94 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 14 ++--
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 27 ++++---
 3 files changed, 71 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1bd1eee77262..053e20c1e27b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6480,57 +6480,61 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-        struct amdgpu_usermode_queue *queue = NULL;
-        struct amdgpu_userq_mgr *mgr = NULL;
-        struct xarray *xa = &adev->userq_doorbell_xa;
-        u32 queue_key = 0;
-        unsigned long flags;
-
-        amdgpu_userq_process_fence_irq(adev, doorbell_offset);
-
-        xa_lock_irqsave(xa, flags);
-        queue = xa_load(xa, doorbell_offset);
-        if (queue) {
-                mgr = queue->userq_mgr;
-                queue_key = queue->qid;
-        }
-
-        if (mgr && mgr->eventfd_mgr)
-                amdgpu_eventfd_signal(mgr->eventfd_mgr,
-                                      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
-                                      queue_key);
-
-	if (mgr && mgr->wait_event_mgr)
-		amdgpu_wait_event_push_userq_eop(mgr->wait_event_mgr,
-						 queue_key, 0, 0, 0);
-
-        xa_unlock_irqrestore(xa, flags);
+		struct amdgpu_usermode_queue *queue = NULL;
+		struct amdgpu_userq_mgr *mgr = NULL;
+		struct xarray *xa = &adev->userq_doorbell_xa;
+		u32 queue_key = 0;
+		unsigned long flags;
+
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
+
+		xa_lock_irqsave(xa, flags);
+		queue = xa_load(xa, doorbell_offset);
+		if (queue) {
+			mgr = queue->userq_mgr;
+			queue_key = queue->qid;
+		}
+
+		if (mgr && mgr->file) {
+			struct amdgpu_fpriv *fpriv = mgr->file->driver_priv;
+			struct drm_amdgpu_wait_event_data data = {};
+
+			data.event_type = DRM_AMDGPU_EVENT_TYPE_USERQ_EOP;
+			data.queue_id = queue_key;
+			data.u.queue.queue_id = queue_key;
+			data.u.queue.status = 0;
+			data.u.queue.data0 = 0;
+			data.u.queue.data1 = 0;
+
+			amdgpu_debug_event_route(fpriv, &data);
+		}
+		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
 		queue_id = (entry->ring_id & 0x70) >> 4;
 
 		switch (me_id) {
-		case 0:
-			if (pipe_id == 0)
-				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
-			else
-				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
-			break;
-		case 1:
-		case 2:
-			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-				ring = &adev->gfx.compute_ring[i];
-				/* Per-queue interrupt is supported for MEC starting from VI.
-				 * The interrupt can only be enabled/disabled per pipe instead
-				 * of per queue.
-				 */
-				if ((ring->me == me_id) &&
-				    (ring->pipe == pipe_id) &&
-				    (ring->queue == queue_id))
-					amdgpu_fence_process(ring);
-			}
-			break;
+			case 0:
+				if (pipe_id == 0)
+					amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
+				else
+					amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
+				break;
+			case 1:
+			case 2:
+				for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+					ring = &adev->gfx.compute_ring[i];
+					/* Per-queue interrupt is supported for MEC starting from VI.
+					 * The interrupt can only be enabled/disabled per pipe instead
+					 * of per queue.
+					 */
+					if ((ring->me == me_id) &&
+					    (ring->pipe == pipe_id) &&
+							(ring->queue == queue_id))
+						amdgpu_fence_process(ring);
+				}
+				break;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4136f2a8e31c..1af5f1289897 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -142,17 +142,19 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 
 			list_for_each_entry(file, &adev_to_drm(adev)->filelist, lhead) {
 				struct amdgpu_fpriv *fpriv = file->driver_priv;
+				struct drm_amdgpu_wait_event_data data = {};
 
 				if (!fpriv)
 					continue;
 
-				amdgpu_eventfd_signal(&fpriv->eventfd_mgr,
-						      DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION,
-						      0);
+				data.event_type = DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION;
+				data.queue_id = 0;
+				data.u.memory.queue_id = 0;
+				data.u.memory.fault_status = status;
+				data.u.memory.va = addr;
+				data.u.memory.data0 = 0;
 
-				amdgpu_wait_event_push_memory_exception(
-					&fpriv->wait_event_mgr,
-					0, status, addr, 0);
+				amdgpu_debug_event_route(fpriv, &data);
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index cdbd732ee7ef..3e3ee1b0b5dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -241,19 +241,20 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 					if (queue->doorbell_index == db_array[i]) {
 						queue->state = AMDGPU_USERQ_STATE_HUNG;
 
-						if (queue->userq_mgr &&
-						    queue->userq_mgr->eventfd_mgr)
-							amdgpu_eventfd_signal(
-								queue->userq_mgr->eventfd_mgr,
-								DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
-								queue->qid);
-
-						if (queue->userq_mgr &&
-						    queue->userq_mgr->wait_event_mgr)
-							amdgpu_wait_event_push_queue_reset(
-								queue->userq_mgr->wait_event_mgr,
-								queue->qid,
-								0, 0, 0);
+						if (queue->userq_mgr && queue->userq_mgr->file) {
+							struct amdgpu_fpriv *fpriv =
+								queue->userq_mgr->file->driver_priv;
+							struct drm_amdgpu_wait_event_data data = {};
+
+							data.event_type = DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET;
+							data.queue_id = queue->qid;
+							data.u.reset.queue_id = queue->qid;
+							data.u.reset.reset_cause = 0;
+							data.u.reset.data0 = 0;
+							data.u.reset.data1 = 0;
+
+							amdgpu_debug_event_route(fpriv, &data);
+						}
 
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
-- 
2.34.1

