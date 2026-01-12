Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666D1D2502E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 03:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0689010E06F;
	Mon, 12 Jan 2026 03:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SMunoj9f";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A9410E06F
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 03:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCdo6+/eaO3025fNIq2dYzGyLNTfQ6mqRM91AN1xKX+U591w5mrelptO2L2gu9jtQW/BaLFlIYLzPhjJzvs9UMg9Eq6yRs+GvhYd5Jrwqqh2h0oP2BkZg+rCFJcb29QfP+9khO8AXEXwOlG91qsMLzzszge3PHV6kpli30H/UcMa7rfGO42GBmyK9FKhjw8c3D12nZpyDwbk3y+zux8zvbrPTQlh9azbcPF/oG1gIbdQlZs8+9iIQi6qv+yasvMO4So4sCJr9fgiLwsRU53Ihb7dwrnoi20Og6YeG4IUli//DHhuJRORNU+gv+Pk/1wzde+aXf8QzvN6Lhn49sbGXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RltnIyLNdwlqyGbDrNs/w+dfD6CH+YyGResAb1R6Idc=;
 b=A7aYSQfpj2cyo0xV2p7m1SyrtCp7iZF0zmeIQXdd9DYV4nixQOkw2N7kVTj/bCi46dCfMVQg6gmg+hvuV0QbXr1MhLBcZEBBM3mgDY5OPkYKW+nBNE6s9IL8sXmYtUTBTBNbDryw6o/M8+3RSFEAE81v9in7RacdhywVhfHuUx4WGi5NJ21aviIfexO4Y7NOoGH+2UGPtgGmKwASGjPX/W1/d18rPe6o2UFz9Bb1zaYZCaFD83aR99avb9YSSIoRBEZY4SdjwoOQo3OoQVEmV9+K63fptJeshOQYVSxQC3zHOH9kw6AW1YJoMvsDRB4tXCzrx522p09lxpWj+E3GkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RltnIyLNdwlqyGbDrNs/w+dfD6CH+YyGResAb1R6Idc=;
 b=SMunoj9fUdXYVvGzHVpMPhnwG1+FqcqZQY3pWeIVFcnbceYZB/ff1xXA6H7gRgXQHGA24mJIAW2KlLOKgRo+J47NsWKWkUZeK/MlQXpukr4mUY29bg+RnwAYZtqxHQJHAuFkQ0sCUKIN6YPvH7QomYQ97C81YeELOrcazyMo1ro=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 03:34:30 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::1c) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 03:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 03:34:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 11 Jan
 2026 21:34:28 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 11 Jan 2026 19:34:22 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH V3] drm/amd/amdgpu: Add independent hang detect timer for user
 queue fence
Date: Mon, 12 Jan 2026 11:33:35 +0800
Message-ID: <20260112033416.188527-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b20de5-00f6-47d1-1521-08de518b7e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7EqfziVVdlRC2Il1B4yfv94XCc0uQ+smfzRGfSihX9iriEg3qB6tpNt8aggq?=
 =?us-ascii?Q?SMBlnPNfn+Un6Bw5JUys0loJ3RrqT3KxiqFMrNQIu+nbJpjqtcfNuAqsMtJQ?=
 =?us-ascii?Q?aOQ0yKJn8WH5oonW7kdb9MFNhIWYQ4WcILlS5O1CN4IaXi9QtDDr1qqi9Amf?=
 =?us-ascii?Q?hggkqqrhDykwYJuujQ34vtft8e1l1oZEjI9E51eWxABBYPJR+gObqO2W0Hl5?=
 =?us-ascii?Q?x4gMqtEBbNWtuwDLkLSGDucGfwjAnYusuI9PVJhiMpnZ+gdj7XGF1DjKgMlj?=
 =?us-ascii?Q?teY1dq1+hp4aTU+fLD3gWUqF+lFelZRnxJMMMYBZSdl53OBrLOmh5fsr4Hxe?=
 =?us-ascii?Q?QIiOyOdIr1k+6LV24MGyT6D/OvmrLpdglmNFOBkYp1vsRl/G1F446qAVV+WN?=
 =?us-ascii?Q?X6nm8eNw2TTzFRjoClU3pAIDx1wBRic0nU2R6HJ/u0algW+140F9ROuVGoYZ?=
 =?us-ascii?Q?WSu9MBtgdIF8Fgpya1V+d9GdPbnN/HYGaAIqvoZUq14/Z3poKuuc45xV8eXV?=
 =?us-ascii?Q?cfO6fWI5XX7QPvXc1f9Yd2lhXFc0v72Z/46JwzXydhjIvxgHimfcEbsT8MnP?=
 =?us-ascii?Q?BUpW3BpJzeczBLbMpmbNbnuUbGqCMbmMbDrhWS5PR98Q8skcA7aibdqVd5wD?=
 =?us-ascii?Q?Pw6yEVRIuqgYnMAZI9E9uvsJG5RwxjJH757ogzjN2LBZXUzRZp94lBEg4qFx?=
 =?us-ascii?Q?fGoDhDzdTzyL4WNY4779lPfpoKgWO16NfzJDzXfg2+WS1PYRbLsjewnE6pfZ?=
 =?us-ascii?Q?PBW0QApaiHYhwDZtcga3EyjVaL5xBO6MnND9rNlGSaOW+qQfYCIVJwK3Iz4h?=
 =?us-ascii?Q?oKfWYEwlmiWV/cvbDcuWMZQCN1IeR4cKHiTMob7dC3dto7n9jc94DxydO5Nd?=
 =?us-ascii?Q?koNAyjJYnIEZkMZo7IZkSWiI+uzb4mm3zY1IFqPCXGwB10gATK6mMJvfLPzC?=
 =?us-ascii?Q?E+veg3PWnxf7x4XK07iqlUORDS3Eu9tGV6PyI8K7J4kXcOIcY3lJLEPR8oyj?=
 =?us-ascii?Q?4fM8PNNUg5MYhl17RXmnc85HtqM81U9OoEjLA4Q+JlCcFwELKElPCNTzz6Ju?=
 =?us-ascii?Q?t2zELtHuuI0u2njSvN21UORnxmAzRNBHg21dMwQozJ5iIjBVZqkqPAzCnLKJ?=
 =?us-ascii?Q?VB8jnz4Sx7ShOqg27Uw27oawdxI423viQwpR8J7vVfNhC4628849F5Up+lm3?=
 =?us-ascii?Q?hCcp4KgeVU7iZf49LzDxwge3iw3LkAEVQv8aWmC1qq1HmJa8KjT5PBvZR2F1?=
 =?us-ascii?Q?VBmKZXZblKdZU6rYm8yBOF8TCC1Pllc8TcYN/w7O8/uLOjdoVse+H1kzkDoZ?=
 =?us-ascii?Q?VanknIa4eRGBFmEjaZaBxlk0w962wa8udbe0dZw092ORY3IG732UdJ/UnjB5?=
 =?us-ascii?Q?SdhJk8k9VQkx0jRspB0QNTB9zsqLtyItkHVtIAlb9lXGxJT/YftjIPbf+Fpj?=
 =?us-ascii?Q?qDJKHNJLVjvyAR7dANU3ILf8vAOnPZKo5l5c4m2bWVF97jX4C/LDpBSfOOhw?=
 =?us-ascii?Q?GLRXVxpcrephEYLxDAKXO7bi8DnwjF9ev4UfGbH6wM+I/hGiggZAhj/oo1BM?=
 =?us-ascii?Q?NHnwLAEBvxVvQeGdgw0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 03:34:29.7022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b20de5-00f6-47d1-1521-08de518b7e80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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

In error scenarios (e.g., malformed commands), user queue fences may never
be signaled, causing processes to wait indefinitely. To address this while
preserving the requirement of infinite fence waits, implement an independent
timeout detection mechanism:

1. Initialize a hang detect timer when creating a user queue (one-time setup)
2. Start the timer with queue-type-specific timeout (gfx/compute/sdma) when
   the last fence is created via amdgpu_userq_signal_ioctl (per-fence timing)
3. Trigger queue reset logic if the timer expires before the fence is signaled
4. Clean up the timer when destroying the user queue to avoid leaks

v2: make timeout per queue type (adev->gfx_timeout vs adev->compute_timeout vs adev->sdma_timeout) to be consistent with kernel queues. (Alex)
v3: The timeout detection must be independent from the fence, e.g. you don't wait for a timeout on the fence
    but rather have the timeout start as soon as the fence is initialized. (Christian)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 53 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  4 ++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  1 +
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 98110f543307..6e04286a707e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -148,6 +148,56 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	return r;
 }
 
+static void amdgpu_userq_hang_detect_timer_cb(struct timer_list *t) {
+	struct amdgpu_usermode_queue *queue = timer_container_of(queue, t, hang_detect_timer);
+	struct dma_fence *fence = queue->timer_fence;
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+
+	/* Fence already signaled – no action needed */
+	if (!fence || dma_fence_is_signaled(fence)) {
+		return;
+	}
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
+/* Start hang detection timer for a user queue fence */
+void amdgpu_userq_start_hang_detect_timer(struct amdgpu_usermode_queue *queue) {
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	unsigned long timeout_ms;
+
+	/* Determine timeout based on queue type */
+	switch (queue->queue_type) {
+	case AMDGPU_RING_TYPE_GFX:
+	    timeout_ms = adev->gfx_timeout;
+	    break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+	    timeout_ms = adev->compute_timeout;
+	    break;
+	case AMDGPU_RING_TYPE_SDMA:
+	    timeout_ms = adev->sdma_timeout;
+	    break;
+	default:
+	    timeout_ms = adev->gfx_timeout;
+	    break;
+	}
+
+	/* Link timer to the queue and set expiration */
+	queue->timer_fence = queue->last_fence;
+	mod_timer(&queue->hang_detect_timer, jiffies + msecs_to_jiffies(timeout_ms));
+}
+
+static void amdgpu_userq_init_hang_detect_timer(struct amdgpu_usermode_queue *queue) {
+	timer_setup(&queue->hang_detect_timer, amdgpu_userq_hang_detect_timer_cb, 0);
+}
+/* Clean up hang detection timer */
+static void amdgpu_userq_cleanup_hang_detect_timer(struct amdgpu_usermode_queue *queue) {
+	timer_delete_sync(&queue->hang_detect_timer);
+	queue->timer_fence = NULL;
+}
+
 static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
 					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
 {
@@ -580,6 +630,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		return -EINVAL;
 	}
 	amdgpu_userq_wait_for_last_fence(queue);
+	amdgpu_userq_cleanup_hang_detect_timer(queue);
 	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
 	if (!r) {
 		amdgpu_bo_unpin(queue->db_obj.obj);
@@ -818,8 +869,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
 	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
 #endif
+	amdgpu_userq_init_hang_detect_timer(queue);
 	kfree(queue_name);
-
 	args->out.queue_id = qid;
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 1eaa94f8a291..605aa5e5a915 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -25,6 +25,7 @@
 #ifndef AMDGPU_USERQ_H_
 #define AMDGPU_USERQ_H_
 #include "amdgpu_eviction_fence.h"
+#include <linux/timer.h>
 
 #define AMDGPU_MAX_USERQ_COUNT 512
 
@@ -72,6 +73,8 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
+	struct timer_list hang_detect_timer;
+	struct dma_fence *timer_fence;
 
 	struct list_head	userq_va_list;
 };
@@ -146,6 +149,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+void amdgpu_userq_start_hang_detect_timer(struct amdgpu_usermode_queue *queue);
 
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 25f178536469..9cf3991ad6d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -569,6 +569,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	dma_fence_put(queue->last_fence);
 	queue->last_fence = dma_fence_get(fence);
+	amdgpu_userq_start_hang_detect_timer(queue);
 	mutex_unlock(&userq_mgr->userq_mutex);
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
-- 
2.49.0

