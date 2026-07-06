Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AEDC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 19:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C21610EA6D;
	Mon,  6 Jul 2026 19:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YIx/15Cl";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3FE10EA6D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 19:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/P33bL/c+Gu/CZIsbLqpBYPyVS7OAo74No7Mugf85JUliJcZtgos+1PElzdEcmFIy2PE49/8ZVN9lye4KuOFUtz1PCsdneZqWAygTakTWibghErrRUK6r0vRITvOYYd71i1KmHNM6L3YEDwcphf2vo8UwQW+Zm0HliKbqcIVRWwiP9JVJch9DzZtPpWrCpjUIQ7gNK5R9xtLZnLPX4rYB6SrpzNsAiXmI7hP3h6zUQpWUyHtvwF1IaRQqAaaWHNtP5mHFjIsOss0rOi+YmIuespPyt2V0eNdW0dP0zzSgL7eSb7DFmo6/KJjvQDjoCDCpS5Poc513zA8XOwcNNBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0DQaLAA94jEuEuIY/PbALWP37N5eQ7x+kqlpFJwCNc=;
 b=uKEw9hTs/SA7kKsvCTtWrIkPtnQihdJKQXrjGzyw1NatB9J9i/tPH0p5rThCTvLs5ka1qMX1Wm/faP7sxmxnEHoP0jr6xeQ7LMWeFbTaKh8tLJq2MRKEbQCvXwurDeYEPw1TkZdL0ZCBxIKKRbdNL55B+f7oabO0CA+3etBl3MSkfzF3+V5vpaSb/cMTxtLuyFUEN7OxTWWBym13ieHm5YkB+9WCa75fZixJ4AkbHjczPu/mk+TwK/kCpUX/MjXx8Aix15C2k2YP6d0/PY3ppvpL9k9QdkIxh0xGhIG+J0joy6EyY3QmiMaaLL7QXNexVLXjqEZS9GznM2o5ltk8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0DQaLAA94jEuEuIY/PbALWP37N5eQ7x+kqlpFJwCNc=;
 b=YIx/15Clkvi1Ka4UnPlwA7+8VOB+uTGSCrcK9ULr9sFkRpoSHC6yoYDwdrXTl5sHjCoTCWZcXtqAuxZAbMfTqpGLK64mBdWsRT6pmJHitnCjPdgORtYgKeHsr9iQDbDU7l+MkBVtAkJ1D0aDpVntN6puPSzydJHpjek/qsfALhA=
Received: from SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 19:23:06 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::7e) by SN7PR04CA0165.outlook.office365.com
 (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 19:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 19:23:05 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 6 Jul 2026 14:23:04 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: fix integer overflow in CWSR buffer size
 validation
Date: Mon, 6 Jul 2026 15:22:52 -0400
Message-ID: <20260706192252.2081323-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f23fc7-1b00-42ac-8b0b-08dedb940106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vwqCMYFDcwj0JUStB4kaSPZBRhHT7vGpUHlk2LXDBZ0LrMP3hPDH/ZCZdYhzj4VRbNNTrUHfBJBz1pG0mMkchc4eN2iHEEUmhTEU5NJ0kEVvH8cTJKcs6Yzo7gW03X+W435w4xPuGi/8aiWZLvfq4VD3rp19Bxfx3OEnsc/DMANps7Y94CR4pkvX6D/5UmnkgGye5bLHs8w4HWAHzEIZqJlVwBbhaLCZ3f6GFl7pu8e9hSqGV5aye9A+W+72in8YismfrY+zkV60Jbr982wkWHpUSAV0shSF3S6imaiKgv7Ztocvcjx62FHKDZKlB4bXLdToDOuMF68Q3gOaxBzG/DpCXFnhP/yLpkCEEBvqU3GhAP+siCCTtAADnevfjeNy7deD3qUAsyffcVpcgOQ7IlXXu1+v4ycdfQInFidmzNC4cgFC/2ITn/Il0rf1nboHFtsWXS6PVB3g36N2fzQRrNm7NwumCxGbuETbCvEteAQj++yfGrJEpi1fFilG8xbm3ph3wV/b8ez9jxeSJ9/JQMInH91S/YejrrccazELGW+KNSxcaSVBSLxuoBIpG9cewFuS5usZBkzM0Lk06+9SWDi5iLHMeXznQCS46dMs/jYb4c6BhYP825056pJJj6m+Qxxv+RZP24Y5c2QOnulucQ4w1V+k1YMKXnQv9CaompVEQ2FnO7/+XdBeRsk9FLBkRq9z+H34jqTnxha+JMN7Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rZ1JOcNgabC+6omr91Ku4LkCuDrmoxOLLEj8pl+E/oTkuON6hOLtpdwaxT89HnySm4Ca5+Fq2nYnh9VHrf6OwkYUCW1CQF7pjS/XunOuxGyKorEXfFa7PfkBmN1XsafZfClARpPYZgoorFt+sXxy+tCHj+8P+WE9N8puQIbO4hEqtGETd5OhjPbtQ0El7OgD0TOuHwqUF39n1PYu+cZTEGwGbdS+db3Z2SNFPz+mQKZUHh/ddFePNdiqX8iSnjHeNLc7Qzr11BlrkL+/gGj9OCRbYfBhwasIvwcI7OUSiy9faeXStU6SXBue9Y626+JDSDSmHAyW6uTLhosf9YrvP4+ZLFlXSA2IM88dk++sHg/tsaGGvDFNXQmA1omnQKNaLlKBCT5FEtKf8UffbIi9c/lSZHJkQlrum6/cPfOQfQVKKr2FO+Qci11blbQxx8Ll
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 19:23:05.1421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f23fc7-1b00-42ac-8b0b-08dedb940106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772
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
index 415e9d8130cf..0dc5e6acb5dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -737,7 +737,8 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 		 * and CWSR area is allocated in thunk
 		 */
 		if (mm->dev->kfd->cwsr_enabled &&
-		    q->ctx_save_restore_area_address) {
+		    q->ctx_save_restore_area_address &&
+		    !WARN_ON_ONCE(!kfd_queue_cwsr_xcc_in_bounds(q, xcc))) {
 			xcc_ctx_save_restore_area_address =
 				q->ctx_save_restore_area_address +
 				(xcc * q->ctx_save_restore_area_size);
@@ -928,6 +929,11 @@ static int get_wave_state_v9_4_3(struct mqd_manager *mm, void *mqd,
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
index 6e559aab4009..ef6d1c8aa780 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -541,6 +541,14 @@ struct queue_properties {
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
@@ -553,6 +561,29 @@ struct queue_properties {
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

