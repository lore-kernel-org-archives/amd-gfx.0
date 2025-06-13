Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1869C71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80FE710EA52;
	Fri, 13 Jun 2025 21:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SUla/EUz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E614710EA63
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8rX3g1X2xywAwFPF/0cAsCDeUHXhL4VTAnsaN18FcdDWTzbMQRsc25oYjvYrsmOJpy8nNl6H2M6yiPEUkH3uML4YsfLBZ3lCBkZpWRNphRV0tOBnnM0B+CsShxzIBYNb9UEdKasCOzmYOQInc1jt+6fsQRgx06wVZG8D7Y0sTfoJjN5erQnJIi5vjkcYMpybVIJ6sKZAfS+vGJcdFPrKv6K5RCN9MLLX9ttUaDeLLCDU7wu+lMoz4Tan/4PP+XnCILDG8ZKTYDD6QbYR5viYXlF3sjOkNRzjMqUTnjhgOKoxP1vzI/EmS3yQKk3LJCte2dbB5JOnL7b5LzmfIdFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AXIBX40lr3V4IKJfqMLctiLEdTpC7HJMUdEOshfVsE=;
 b=lMMLBWA563HGV5CIQ7bm1OZY6vrJ07yk+CnJsW/82P+30igK9pNjYmW/wJc7imvZAmKiOVo/fGl6BWv2vcJ54JgrWzrd4ov8azAWZob8nsUn6w0uQZtoELTYfewC82UdcZsm3y/l+BYXgdoI7TXiJCuN+gzmzvgWoXzyPhWeI/lhow0irlMXHevoyLQ2ih1ne0lbv1W2IqJnermlTKKj8PBd5enynox/ebDfMrbWB5jss45RrUizU0t2o1oDMTtOiMegD+FHJnEkCGO2kQwqc2kvssH2dlQpmxm8Ti9iZxNfNjLNT8uULLPIBcvbshMuTH2vPvoEdsp61vt049p6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AXIBX40lr3V4IKJfqMLctiLEdTpC7HJMUdEOshfVsE=;
 b=SUla/EUzuXX0ReC1SqFiX0uN57sAe1oNcd65+4HLyJsKoWP64b8JfxJWkpEON8+f9g30NWG2PtBWSqCEX4dPwiQ7l21mbWVZmRArXDyxQCrOLK+8vnVLAJo8yKR3t+RG8UV7/34JjX9uR6P9eTt1RF6SQ5NpBElNR44rEIGrVCY=
Received: from CH5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:1f4::23)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.23; Fri, 13 Jun 2025 21:48:11 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::3e) by CH5PR04CA0023.outlook.office365.com
 (2603:10b6:610:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/27] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Fri, 13 Jun 2025 17:47:32 -0400
Message-ID: <20250613214748.5889-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: d844fc9e-2b48-4093-c14f-08ddaac3fe16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j6xLo88jHV97E0BeyST6SnZskYddg+lsXfRwTdzljs9N3C1v0RcANf5yyLx5?=
 =?us-ascii?Q?cJaT7MhbC5JtPTlLZIZ9RRrwg88ic4AW45NoopFcpM/8RW1luy+ZcxV2LG14?=
 =?us-ascii?Q?pknlWNn8E6i5xd+o6WU/C/GOwDrqDy7prmY1HekRMj4jWg/KFr8SRVtAsssc?=
 =?us-ascii?Q?s5JpjDWpfkamnJayew1+AurNkWMMTdMkxW7DVihoIurmJEbh0DnSVvZR+7m/?=
 =?us-ascii?Q?Vbvzr0oxnaG0+SyiouVqvxRk5XHPBPewoNZ6UBVw3bwSpQtpco8JaWNd/cTY?=
 =?us-ascii?Q?rKwyLDXlm+yNNXj0HdIu57pOJWmDVkuiCbzltusqawCMri6iLBKK9KxzN57q?=
 =?us-ascii?Q?xS1VQPRFZHNgNSuPmaapJiP/BkTx8qCrPpmzsljnRMInQ5T1xSXJhb6BikxX?=
 =?us-ascii?Q?/dCkjpNipv+vWuSZXUhfW0MVOjsGhUwlz/3XMotXF0JUkHSXKUOsoKqKqPmT?=
 =?us-ascii?Q?iH5H5ViTbPXFjdJuL9+tOfmQgOOSgqGL2hRyELVHKhPxd7oMQ6M+bw++zYrH?=
 =?us-ascii?Q?y0XmujCY5b492lpJnNM761HpfKQ0oJanqqrdeKF+ZZRCYNBHa4bRmlH75DOz?=
 =?us-ascii?Q?4KARLwX4XNsIxPJYUN0yUNYgIoQ8TVYUBt2R4zBLq/Notf6oUtwqufei/qV7?=
 =?us-ascii?Q?acQERfawQYgmEycP48B3ifTI1yRYTGq3v2RulbBIueQ0JhK94RqkN20bIsTb?=
 =?us-ascii?Q?/lUr6sEPwqALYKFvdzaSiHSSNiRXNfulaKgfCIM2ak3uq0FdWMNjpjcyF01T?=
 =?us-ascii?Q?f3WTJPQ7YRH6R0w557LSvQbRnuB8Ym/q01i7ISOIgS2gvThFN1/wh9T+Ro75?=
 =?us-ascii?Q?xPmNYAMNQ+az+MMHoH+YQ+hwFBRcpY2i+Tw7pUoGE1PH0iuAJbgvkRWtoLfS?=
 =?us-ascii?Q?FmtXbsSNsB3HVP23Q3B/14xqiF9RzpwPzHPan7711Cv/ppZFfAy0fUO87Q21?=
 =?us-ascii?Q?UEvhEOMW9sSykXo0QNa5LRlyGi72vjhKSRyZFt33FtyuJYWMIbUkHFZQJ8MQ?=
 =?us-ascii?Q?CerXKSI2tkbPRjtahN+oFueRsCKxJJ06RoOOIwxYqpi5WfMJFDBFoHZ1151v?=
 =?us-ascii?Q?9YFP7YsxED8OleowQn33QW/GfMIFSKPuK5MkGakk7uiC+DSIgEfZbxnVLI+3?=
 =?us-ascii?Q?Fg7rc36rMANDO3uc/nn1dVkFU4qfGRSbCbFnqSaiecKo/OvhrgpO0O6Dg+Ic?=
 =?us-ascii?Q?/18B6UD2mmmL/MNRGSWcy6LJJaf4LvH6h35A/lrm8/Dfc1qHeX4IS55KffWm?=
 =?us-ascii?Q?3HEZts85MJm3eEyYVoQGlcQBwC1Fspc/pRzzvpLmRs2qCI6nZ58q4DXSjRCt?=
 =?us-ascii?Q?VtLy+Nkp5T/Zr4gy/27gl/Aj99laWIkfWqZQR5zhzFPV17Y1/ZKwyminPq65?=
 =?us-ascii?Q?ywo6pjau1lo4bvnxZLXaWJ2V8m7pg+7I20nd/aU5YzNPH1Q8SA2JolO4Yfv6?=
 =?us-ascii?Q?VN6la05ek5aKNOltFj9swmc5TWtEvgFqYZXenksS35rDY/QfMEXQtNzn9Fvq?=
 =?us-ascii?Q?ACqAAFzgt9bV+sSWdjZkHgJZ5jJREFGWNyCW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:11.4173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d844fc9e-2b48-4093-c14f-08ddaac3fe16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 49 ++++++++++++--------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a9d26d91c8468..6402736a87c64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9046,21 +9046,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9540,6 +9525,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, 5 + 7 + 7 + kiq->pmf->map_queues_size)) {
@@ -9564,10 +9551,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9580,8 +9565,15 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
@@ -9601,6 +9593,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
@@ -9611,9 +9605,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9649,17 +9642,23 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
@@ -9895,7 +9894,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9936,7 +9934,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

