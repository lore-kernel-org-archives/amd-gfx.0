Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC204D29DE9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 08:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD6810E46B;
	Tue, 13 Jan 2026 08:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3UsQzCA9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010012.outbound.protection.outlook.com
 [52.101.193.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFE010E46B
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 08:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PILV0uE1qf1FO29HZkWYlNoBdceOQrGFC3jtaSqUXmzNDz3oCfhkJL1zVWfdPICPY4GjsWIkG4YsCKmryd13b/ueB2sXMylIgCJgb7GllNR/cJuUCoPb0NA/ucJqPJ70dZyS1jlXMCxyQZz83VmryxzO3XAvYrFDjo1S54MYLotqxINuVMbFlBbLZ2bvbZQHjSmDUZNIfuNz7f8JURbkkuOyrqLNICQSkmSAg5wdI4eVmU3BdWcbZdsejEXDgffE7AsxI4gB5YNOPWjRn7akGj5jdgP8RxZbMZyQKkK2y0JWt5U9SeHKgYYk4mrj6WlspyjKi9f8r3tcaikHLtEW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2Gj1HsPZuYuF1VWJxjQpYSlOkXDGJFTwEo9exWq10s=;
 b=PlrWcmJn0pLgmhLIe7bug+cSKMj2OxnPQ7lou/5ZSIhVbqOG5YLPkP31hUpUsyssSOlDCDqqCeP2ChdUwRooBID7F0VxUYfdkETUKuxBby2f5vKv5lbHsZrBA+bBKceRIZ+c53ejeW+RsMSVSNM1pOHruvNJFoGzFlAnBZ6ROrrHSNm0xtyjN0C8Bvsa66DdIqphb+G32IcZLohSJ+LL76G1Z6Gx4c57zzkxV22SrzFUp5DJqyUy1YWN9CS1CRbDU8u1unhQoejP4Bp1hbZJlTQYTgbIoeHqZN8ydkWFEabK6p8b+Kh7MaU4kinUQJQAeydQpHcGW5/U2dNmqXFuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2Gj1HsPZuYuF1VWJxjQpYSlOkXDGJFTwEo9exWq10s=;
 b=3UsQzCA9pOzZzqDV0Lsy5C1M+DsvyeFzefh569iqCHbeilhU6L+ZWRQmmRdxIrqBKFiNSUf4MirUNLI3o/xMlmFl2mFdEl5oLM93NrWNeQ6H83mWcqVqhB3K6EAlnkyyx6OYETccIuidbJLIT7EFgx5ThtvXQalXGup6wwjt8DQ=
Received: from BY3PR10CA0027.namprd10.prod.outlook.com (2603:10b6:a03:255::32)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 08:22:56 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::f9) by BY3PR10CA0027.outlook.office365.com
 (2603:10b6:a03:255::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 08:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 08:22:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 02:22:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 00:22:53 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 13 Jan 2026 00:22:47 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v4] drm/amd/amdgpu: Add independent hang detect work for user
 queue fence
Date: Tue, 13 Jan 2026 16:21:05 +0800
Message-ID: <20260113082241.291255-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b98782-4476-4ddf-980b-08de527cf387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2IYNVq7ubP5y+aojckrXTRKDr4K5UvOa8M5/Z2zxA4PDbtrtEhEmhWXVKsxL?=
 =?us-ascii?Q?rxHB4XclI/n90PF+7rHlimnba/quPMSZQHq2G6OXNcfId0vK+JyWF3VMrWSL?=
 =?us-ascii?Q?ao/mDTerlPga9yr8RgCOFv/LGy2ZZ/GHLtRnTOlOAggxqlRGtxHvyc5KPZcR?=
 =?us-ascii?Q?fJ8cz6XonpB5cPllvhKW5RffejFNnB6GfCtgTQDeus+YsdDFi6zqC0VZYIMr?=
 =?us-ascii?Q?/SqaA3So7z0MZBMhfBQNQ+x7IPejp/lGOgjbKMohIpgjuJgr44L37Z7DEH2L?=
 =?us-ascii?Q?HegiGtEGhKD0TCO6BmAt6g13QqE1L6GLQ9CySxDpldWymGNfqXOXX89nKLWN?=
 =?us-ascii?Q?shc6lvw7mjkMWDZ6c4x7iDDA5mvhhLmW4J910e0Idi0yGyVLwr1ku8EQbqsh?=
 =?us-ascii?Q?KfkZ5wSlkiRIJB9psceKqckBcTBAViQCe9bMEyWtbgIPvjbr0gIxzkvWYXj8?=
 =?us-ascii?Q?0kdI1fNAAawDAYKL9nt5xSCEwAAmAIz2wOwUz9/C64N/SJEAf6/qq9Su0ikU?=
 =?us-ascii?Q?8wwMclfcAsZmBFO5YJ2f4AN5Ab6n8zCbUSucKrMPj/cawdLAgFuShDIXF1Ix?=
 =?us-ascii?Q?1gAvkliF6mwHv9olvtmTXTHj6zBBQ9KIpLN+jEFbEPoH3jdQLMmc2qiH9ut2?=
 =?us-ascii?Q?PlpHsZUWa81U45LXZg4AZNJNVXGalZqB3stWLNzravf4xNvkckSftm9/2frK?=
 =?us-ascii?Q?vlhRl8U8o1/00DoRHrL8JjldrM3cB/ETQCuIFOdHrcMqfCiawu8N1XcwpxIt?=
 =?us-ascii?Q?h087Q73K8FT7UzEbTOZIwWO4/1hIYo3pVh6Y7j9dO88+aM1pojoKQKvZxCc0?=
 =?us-ascii?Q?LighgTl7iQTHK3QUAaIdzyybehuhlv8jd1oOAuT+TL5J3Bccaaawg9cfNM87?=
 =?us-ascii?Q?m4+Sor6pH3GGD60CezL6TjqX+p13dsLCq/H9MTIFNe00Y2oLcjuJuGoQTc+R?=
 =?us-ascii?Q?HICzfdCvKZ1iE0J6nT1lFkOSRVqwzRp08P4qG/SJMuGtlY90hGISb73fZSCV?=
 =?us-ascii?Q?Hvwxtd4CJBHwnzdxuCiEcoJv6ipAtBAerUnJjLMAQhB1FxCqv5SPpYRz3LFs?=
 =?us-ascii?Q?qep33nFMheJvNOGSpqU0tk5dO3bwcx37XaAPVKiWnOmmUIlLg6xhegv+ym4a?=
 =?us-ascii?Q?S2SFwdtIIYbIEo0IFekQnn9FZqwwCFJcY+B2od+JtX8d7TP2/4UVDxqGg3fM?=
 =?us-ascii?Q?KN/SiFlp41QN0zyWy3DoCMSzEkORrR/Otq66Qoiks3vvWivUMTST2uEZwOTx?=
 =?us-ascii?Q?8KwoLQQXSHX+BZufZ3s8EyVqFDkcQxD8oSRvp71yGPuyMU4J98Ww7Da2++L+?=
 =?us-ascii?Q?Gcw5iQAgwxCzHcH0yulSQvcZHPpEHGJ/qkjKrMqFyBg8ycD34OmvQO1WmP6g?=
 =?us-ascii?Q?CVZfQkFgcxtpi7yx/ufA0JWA7Z2B8YBW3KvHkEUP1bwKMob6CpL6BiuIoKKi?=
 =?us-ascii?Q?JzqwrePLS91CWsgauUH5wdTOqayIrToOADz5Yy827SOxD2ROTlOCIRzoAzdx?=
 =?us-ascii?Q?kn1hHUTDxh5MUlnLRvNB1CjRkmBmBPvFBk/DvY2mAyzGUeczlTdJHQ3qxFxB?=
 =?us-ascii?Q?jiNweH+U4/kBatdnKkc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 08:22:54.7025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b98782-4476-4ddf-980b-08de527cf387
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
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

1. Initialize a hang detect work when creating a user queue (one-time setup)
2. Start the work with queue-type-specific timeout (gfx/compute/sdma) when
       the last fence is created via amdgpu_userq_signal_ioctl (per-fence timing)
3. Trigger queue reset logic if the timer expires before the fence is signaled

v2: make timeout per queue type (adev->gfx_timeout vs adev->compute_timeout vs adev->sdma_timeout) to be consistent with kernel queues. (Alex)
v3: The timeout detection must be independent from the fence, e.g. you don't wait for a timeout on the fence
        but rather have the timeout start as soon as the fence is initialized. (Christian)
v4: replace the timer with the `hang_detect_work` delayed work.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 70 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  1 +
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 98110f543307..664a15278c1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -148,6 +148,69 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	return r;
 }
 
+static void amdgpu_userq_hang_detect_work(struct work_struct *work)
+{
+	struct amdgpu_usermode_queue *queue = container_of(work,
+							  struct amdgpu_usermode_queue,
+							  hang_detect_work.work);
+	struct dma_fence *fence;
+	struct amdgpu_userq_mgr *uq_mgr;
+
+	if (!queue || !queue->userq_mgr)
+		return;
+
+	uq_mgr = queue->userq_mgr;
+	fence = READ_ONCE(queue->hang_detect_fence);
+	/* Fence already signaled – no action needed */
+	if (!fence || dma_fence_is_signaled(fence))
+		return;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
+/*
+ * Start hang detection for a user queue fence. A delayed work will be scheduled
+ * to check if the fence is still pending after the timeout period.
+*/
+void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev;
+	unsigned long timeout_ms;
+
+	if (!queue || !queue->userq_mgr || !queue->userq_mgr->adev)
+		return;
+
+	adev = queue->userq_mgr->adev;
+	/* Determine timeout based on queue type */
+	switch (queue->queue_type) {
+	case AMDGPU_RING_TYPE_GFX:
+		timeout_ms = adev->gfx_timeout;
+		break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		timeout_ms = adev->compute_timeout;
+		break;
+	case AMDGPU_RING_TYPE_SDMA:
+		timeout_ms = adev->sdma_timeout;
+		break;
+	default:
+		timeout_ms = adev->gfx_timeout;
+		break;
+	}
+
+	/* Store the fence to monitor and schedule hang detection */
+	WRITE_ONCE(queue->hang_detect_fence, queue->last_fence);
+	schedule_delayed_work(&queue->hang_detect_work,
+		     msecs_to_jiffies(timeout_ms));
+}
+
+static void amdgpu_userq_init_hang_detect_work(struct amdgpu_usermode_queue *queue)
+{
+	INIT_DELAYED_WORK(&queue->hang_detect_work, amdgpu_userq_hang_detect_work);
+	queue->hang_detect_fence = NULL;
+}
+
 static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
 					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
 {
@@ -572,7 +635,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 
 	cancel_delayed_work_sync(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
-
 	queue = amdgpu_userq_find(uq_mgr, queue_id);
 	if (!queue) {
 		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
@@ -580,6 +642,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		return -EINVAL;
 	}
 	amdgpu_userq_wait_for_last_fence(queue);
+	/* Cancel any pending hang detection work and cleanup */
+	if (queue->hang_detect_fence) {
+		cancel_delayed_work_sync(&queue->hang_detect_work);
+		queue->hang_detect_fence = NULL;
+	}
 	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
 	if (!r) {
 		amdgpu_bo_unpin(queue->db_obj.obj);
@@ -818,6 +885,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
 	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
 #endif
+	amdgpu_userq_init_hang_detect_work(queue);
 	kfree(queue_name);
 
 	args->out.queue_id = qid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 1eaa94f8a291..06a06272b41a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -72,6 +72,8 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
+	struct delayed_work hang_detect_work;
+	struct dma_fence *hang_detect_fence;
 
 	struct list_head	userq_va_list;
 };
@@ -146,6 +148,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 25f178536469..374fbd0e859a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -569,6 +569,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	dma_fence_put(queue->last_fence);
 	queue->last_fence = dma_fence_get(fence);
+	amdgpu_userq_start_hang_detect_work(queue);
 	mutex_unlock(&userq_mgr->userq_mutex);
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
-- 
2.49.0

