Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F980CDB471
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 18:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C3410E179;
	Tue, 23 Jun 2026 18:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="joVVtMI2";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 966A610E179
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 18:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgNdtFe8qwMFaOujeZyn1nYBKTrT8m8K9dxGjhpjibn2MtcYpWqSRyDnSEc8IoIKz8EQ9FmajASYcNukfjByVrJBJ91MOk5yR/rsAfWovmcGaqfzoVWm6ivPsYGOj29+IwElwvwlqi8lPQnmfM1YyZUROK7tTXHdsM9BiG3tuItZivkxAvQapyOQiwkBJzB3IYGEnKOBzF8YrM2bx8NYANztQE7os3caOuAd+9W8zR1wsB2RWOmw7IfyNZiEjCjeIrRulIFGsytS6NOTwz09uZqtHW4/2ebYQzJtl33P5TWfLGXU50H0RbGbVYOHeOP1Km4T4CaMkuMyrJU3E/e1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnjZ78x1UHxGbj4Mvo0Mlr9pTieUPjW7rN49saxFQ2M=;
 b=IejJGIsNal6us+E/magk7pr6yRoEXKXlZo527d1YtK+pyeP5YJdtNIFuGI8j88/yQ3OzTvS9A1LkINJPFRMl08uSZ4XwzNXyo2M2YUxNoDO0cV3/WWIi7WTwaoAAySZVvqmYN0f731W3toO+Gqj/Sp376r8un4It7Owl1AtEUBo9KwmwIWBScxKbncSFIh/P38CM2f6csZtYDgEAgKDyInLkCFssdAp+5QVcYFwxLyZZ5MXCNQiQOosjdH2+KdS5LDG8ZdP97VmxEwk8+BAVO9OIhg7GS0kdhLhYPoiUzk1ja58y0llpD6+Y16kvUnS2HieMY1IkAVhQ7ImbrmbHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnjZ78x1UHxGbj4Mvo0Mlr9pTieUPjW7rN49saxFQ2M=;
 b=joVVtMI2la3ShxCK0b9XnuEjr/EDdBHHmTm6e4NnOJbR3RZXhaKe1SJ63cDEuPD/OB3uhRuPg6v/fTleAOk7n9KEN6mruIfRbpmWy6QEbUSMWGgJtVHGjtqxYADY3cyibIr8Gwz1YmA4tRZr/vwPHL1QWXI8+unlKim4WIyKA48=
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 18:28:13 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::60) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 18:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 18:28:12 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 23 Jun 2026 13:28:11 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: fix integer overflow in CWSR buffer size
 validation
Date: Tue, 23 Jun 2026 14:27:56 -0400
Message-ID: <20260623182756.4163267-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 825dd28f-1dfd-46f0-3077-08ded1552f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: VIOc9N9MAeEC+Fp1hxkU20pCvPK8ys550orNk59tiydj7kgncwHASPd1t83RGvIP/kNDqPV4t6mROdhDO4v8V+sIscMaHK3IQllCU3bnIwOxLILKRtxnluEnUq/PGO8wgeXJjJS+XkLCpDxhWtnqWRtKvYeV3K+cVsyDusDrmbugexeMGBnqFhAERtUQmV+UWw/axd6ayO4xESx9z7j//yyI/UnIhK7ykrzQeK0zXSzXsGaRtohmaNsM5j9WWy5ZMNVAVfBBreCpYrXX/HukiYMyj5M0FnFYxBfg1jfGKFoRByy/4HjrnZ1sjpD3gJCJpNspcO3T+eaoh4V4FHuZi97dtdieRIWArfiFX7ULDf8l1wspJX/5kv/UeNhU1Jw8KAoeQz4ht96zwAZN3OpTlUxsLZmwSkeA1wO7DtTcECzULNgqNNMZiCVbR4NCMzJGbolkmR7DNqMloJHQKCUbKU8UBTjxS4ECSGsUccmD7vepBSmClQg3eH30EmKvB2Vn8nfQQLZ5oEp+1Vqp/yIwoV1wyDdUo4ONZ30sgluGly7oG9S8kxGZQo5gkcaDXjlbSt5kS62i4f96h0Xj9GHB1Jc5XVLAZ76y5qKfD55GkppvitjoWLZpUl1DRDz5Jedxzq+ot+4LADT5qVXU/FT04OylH+RmbFcF7dBiKyTUbyrz4ArCJt7kqYrf5m93Of/uYfKqmKBzRcucC51pmYORGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fLqtfrbj3KZZ6K3rjTo8+lKN3Z8tFf9cSZzhGUeFrgemgQGNneRJtaVjYm0mM5XYkf1Hv6KOI1cUjr6+DZr03hoiJv9284CyudCT2WDRgiPHFi11fglZBGzgMF3ElT17Ve75JCFPFAoLhJHzVQ5dj6inbJfzJfc/2g5PygHU4IN/7jEnWa5DGknvgIOBUz3XolgTC82UnZhneE1tdRt7IMyRCVBF1hWe9Kh+RxMlcw4AFZSkOgsN81+ujW6WhBFQH3wf1k6eQMygv1br/eUJuu3lAzTmFuqEOO7YdDZtmwYf7MaMXLrohcOHVIctflpluz+Js6PLX4a5KXwJxIwcK4H/G0IFsQQhwsZ8/QjKo+9JgP2xMDc0DOmG+yIjr7OuApCg9a+hfMH33GIAVhU33vDc6rTT0Q3A48fuFuBgzlzf6TSJX93n2yMBnSxU7HR8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 18:28:12.4311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825dd28f-1dfd-46f0-3077-08ded1552f0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
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

CREATE_QUEUE takes an unprivileged, only lower-bounded
ctx_save_restore_area_size. kfd_queue_acquire_buffers() computes the
total CWSR size as (ctx_save_restore_area_size + debug_memory_size) *
NUM_XCC() in a u32 with no overflow check. On multi-XCC parts (NUM_XCC
up to 8) a large size wraps to a small value, so an undersized BO passes
validation while init_mqd_v9_4_3() still strides by the raw size -- a
GPU-side out-of-bounds write from an unprivileged /dev/kfd caller.

Compute the total with check_add/mul_overflow() and reject on overflow,
and bound-check the per-XCC CWSR stride in the MQD managers.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  8 ++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 31 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 49 ++++++++++++++++---
 4 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index a6fff8032dce..d45b3fc3baec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -473,7 +473,8 @@ static void init_mqd_v12_1(struct mqd_manager *mm, void **mqd,
 		 * and CWSR area is allocated in thunk
 		 */
 		if (mm->dev->kfd->cwsr_enabled &&
-		    q->ctx_save_restore_area_address) {
+		    q->ctx_save_restore_area_address &&
+		    !WARN_ON_ONCE(!kfd_queue_cwsr_xcc_in_bounds(q, xcc))) {
 			xcc_ctx_save_restore_area_address =
 				q->ctx_save_restore_area_address +
 				(xcc * q->ctx_save_restore_area_size);
@@ -596,6 +597,11 @@ static int get_wave_state_v12_1(struct mqd_manager *mm, void *mqd,
 	u32 tmp_ctl_stack_used_size = 0, tmp_save_area_used_size = 0;
 
 	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
+		if (WARN_ON_ONCE(!kfd_queue_cwsr_xcc_in_bounds(q, xcc))) {
+			err = -EINVAL;
+			break;
+		}
+
 		xcc_mqd = mqd + mqd_stride_size * xcc;
 		xcc_ctl_stack = (void __user *)((uintptr_t)ctl_stack +
 					q->ctx_save_restore_area_size * xcc);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index ce379ab17916..83a4cb67c01f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -727,7 +727,8 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 		 * and CWSR area is allocated in thunk
 		 */
 		if (mm->dev->kfd->cwsr_enabled &&
-		    q->ctx_save_restore_area_address) {
+		    q->ctx_save_restore_area_address &&
+		    !WARN_ON_ONCE(!kfd_queue_cwsr_xcc_in_bounds(q, xcc))) {
 			xcc_ctx_save_restore_area_address =
 				q->ctx_save_restore_area_address +
 				(xcc * q->ctx_save_restore_area_size);
@@ -918,6 +919,11 @@ static int get_wave_state_v9_4_3(struct mqd_manager *mm, void *mqd,
 	u32 tmp_ctl_stack_used_size = 0, tmp_save_area_used_size = 0;
 
 	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
+		if (WARN_ON_ONCE(!kfd_queue_cwsr_xcc_in_bounds(q, xcc))) {
+			err = -EINVAL;
+			break;
+		}
+
 		xcc_mqd = mqd + mqd_stride_size * xcc;
 		xcc_ctl_stack = (void __user *)((uintptr_t)ctl_stack +
 					q->ctx_save_restore_area_size * xcc);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ad4897f094a2..f227942f50ec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -540,6 +540,14 @@ struct queue_properties {
 	uint32_t eop_ring_buffer_size;
 	uint64_t ctx_save_restore_area_address;
 	uint32_t ctx_save_restore_area_size;
+	/*
+	 * Total, overflow-checked size of the CWSR buffer across all XCCs as
+	 * validated against the pinned BO in kfd_queue_acquire_buffers(). The
+	 * MQD managers use this as an upper bound when programming the per-XCC
+	 * CWSR save base so the raw per-XCC stride can never index past the
+	 * validated allocation.
+	 */
+	uint32_t cwsr_area_total_size;
 	uint32_t ctl_stack_size;
 	uint64_t tba_addr;
 	uint64_t tma_addr;
@@ -552,6 +560,29 @@ struct queue_properties {
 	struct amdgpu_bo *cwsr_bo;
 };
 
+/*
+ * Bound-check a per-XCC CWSR save area against the validated total CWSR buffer
+ * size. The MQD managers program the per-XCC CWSR base using the raw
+ * ctx_save_restore_area_size as the stride; this confirms the save area for
+ * @xcc lies within the allocation that kfd_queue_acquire_buffers() validated.
+ *
+ * Returns true when the access is in bounds. A false return indicates a kernel
+ * bug (the overflow-checked validation in kfd_queue_acquire_buffers() should
+ * have already rejected the queue), and the caller must not program an
+ * out-of-bounds CWSR base. When no validated size was recorded
+ * (cwsr_area_total_size == 0, e.g. non-CWSR queues) the legacy behavior is
+ * preserved.
+ */
+static inline bool kfd_queue_cwsr_xcc_in_bounds(const struct queue_properties *q,
+						unsigned int xcc)
+{
+	if (!q->cwsr_area_total_size)
+		return true;
+
+	return (u64)(xcc + 1) * q->ctx_save_restore_area_size <=
+	       q->cwsr_area_total_size;
+}
+
 #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
 			    (q).queue_address != 0 &&	\
 			    (q).queue_percent > 0 &&	\
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9d4838461168..6bb7aa0fdf1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/overflow.h>
 #include "kfd_priv.h"
 #include "kfd_topology.h"
 #include "kfd_svm.h"
@@ -230,6 +231,40 @@ void kfd_queue_buffer_put(struct amdgpu_bo **bo)
 	amdgpu_bo_unref(bo);
 }
 
+/*
+ * Compute the total CWSR buffer size across all XCCs.
+ *
+ * The per-XCC size and the NUM_XCC multiply are both attacker-influenced
+ * (ctx_save_restore_area_size comes straight from the CREATE_QUEUE ioctl and
+ * is only lower-bounded), so the arithmetic must be overflow-checked. A wrapped
+ * result would let an undersized BO pass the exact-match validation in
+ * kfd_queue_buffer_get() while the per-XCC CWSR hardware stride still uses the
+ * raw user size, causing a GPU-side out-of-bounds write on multi-XCC parts.
+ */
+static int kfd_queue_compute_cwsr_size(struct kfd_process_device *pdd,
+				       struct kfd_topology_device *topo_dev,
+				       struct queue_properties *properties,
+				       u32 *total_cwsr_size)
+{
+	u32 per_xcc_size;
+
+	if (check_add_overflow(properties->ctx_save_restore_area_size,
+			       topo_dev->node_props.debug_memory_size,
+			       &per_xcc_size))
+		return -EINVAL;
+
+	if (check_mul_overflow(per_xcc_size, NUM_XCC(pdd->dev->xcc_mask),
+			       total_cwsr_size))
+		return -EINVAL;
+
+	/* PAGE_ALIGN() must not wrap either. */
+	if (*total_cwsr_size > U32_MAX - (PAGE_SIZE - 1))
+		return -EINVAL;
+	*total_cwsr_size = ALIGN(*total_cwsr_size, PAGE_SIZE);
+
+	return 0;
+}
+
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
@@ -308,9 +343,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 	}
 
-	total_cwsr_size = (properties->ctx_save_restore_area_size +
-			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
-	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+	err = kfd_queue_compute_cwsr_size(pdd, topo_dev, properties, &total_cwsr_size);
+	if (err)
+		goto out_err_unreserve;
+
+	/* Carry the validated size to the MQD managers as a per-XCC bound. */
+	properties->cwsr_area_total_size = total_cwsr_size;
 
 	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
 				   &properties->cwsr_bo, total_cwsr_size);
@@ -355,9 +393,8 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
 	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
 	if (!topo_dev)
 		return -EINVAL;
-	total_cwsr_size = (properties->ctx_save_restore_area_size +
-			   topo_dev->node_props.debug_memory_size) * NUM_XCC(pdd->dev->xcc_mask);
-	total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
+	if (kfd_queue_compute_cwsr_size(pdd, topo_dev, properties, &total_cwsr_size))
+		return -EINVAL;
 
 	kfd_queue_buffer_svm_put(pdd, properties->ctx_save_restore_area_address, total_cwsr_size);
 	return 0;
-- 
2.43.0

