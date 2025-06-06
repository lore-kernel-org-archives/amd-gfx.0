Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA2BC61DB2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9858A10E90C;
	Fri,  6 Jun 2025 06:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wQkVBJW7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB1210E8A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAgmgJpi1vrZZ6K8tZJoOPv0myuLQrwXzof1IlWDTnkea5So+eJ71k9oKv1E/PGTRJS3txp7Kz52vxUzs9N2y5mMA49GIBTrMqdmdekBFAuV8Q9KpzSIIuzFJYXKC7hZaxjrOouUTvnDRUZyLkMP0S0xJ8FwxPehNSpH455R7reGAQLpc+BpJOnzMGvNG6DbTYq3p7Hq5Bzsxj/8LV2w7aibbzlyCEB8Wgw/086tPy6YS5F4zgbDwq5Pgy/TMwpVtDC0b6LpkoI6xq0gF4q7j+8M2kJRijdetvDDBIwnoeMEG0X+uPgXsgHsYli5HVjrkNpTiezeuvGbpddx4itJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bkysr/O7l+NxO7r57bL75IkST+rsHiYsXtZqTyk5eI=;
 b=IM9DdIE0xUYHmxPoYDTh4y6QvOK9PqtaQwaAoRaIZ1HGIx2J9qsWRCZt/uAPYUjTorbVLIABouilzEKcdDarG3FsWn9WPWyzo9EYrzZhVMkvCvdT7R63wWPp+KmMwg4FuebLeKkQvYG7sqRUyJa3/iNKu/shtjwldk3ZhM89B7d8gHhwQKCSfSxKvZ9azJdd68BwDDp64Eef6YrKOtTY9Wd/3ph0QX45bCNYRQBE4vOgSM8rkmGKLv2bw7TFysbQareg7dJjYa31sZ8n6F/0lL68B+wFjVvmFhbWJyqhkAKcEIuud5TeJlhodw/yoGclTAAZyjk8nNWCTYFxjMlYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bkysr/O7l+NxO7r57bL75IkST+rsHiYsXtZqTyk5eI=;
 b=wQkVBJW77JBetf6QsZrLKcRStfx3a/QBvdQVOsmn2hQuJMlo3ct8QRUM6ox253nSWO/cPmZqVyYM0rdabFEKi3C5wrmZKAXqSTBJiuqCYkVdfYiglArjnIlGDBMDp55itvhZna/ozorNhKcvbYwp0tM7+YKayWu1Exhi0hwi/qg=
Received: from SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 06:44:20 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::85) by SJ0PR05CA0147.outlook.office365.com
 (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.13 via Frontend Transport; Fri,
 6 Jun 2025 06:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/29] drm/amdgpu/gfx11: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:39 -0400
Message-ID: <20250606064354.5858-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: c43bf574-b9c8-4e25-c006-08dda4c590a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6UWJao8vwOK8MD2x19qtFSIJaIG8WN5cGUcLjb32BqjElOXFOdUYp4YMCnZH?=
 =?us-ascii?Q?10TU5IwPcT++1IvpPncRwyI3sU441lPI1WBL941VT0L6jtg3h+o3hKGy+pBW?=
 =?us-ascii?Q?MtGO5KvBp6CCrFvxnjBHG04OCMAvImBKPLlt0eq5Dt3I1zvBPBUudx0xgN0V?=
 =?us-ascii?Q?l4u9wliGcwtCuszPScWG1ITlodEeo+F3xXEiSDoTXlzTIsG4/AndPAbJioyU?=
 =?us-ascii?Q?7guQtjGGrek7R8xI5HWh8abJI4xUJOw+D6Wj6X19XtmCdjP8rG8YIAE1tArF?=
 =?us-ascii?Q?FW/8odHb74JbQbWLi8uaQjE8kwvIG5Qg+qjoKBj7pxotfwNg9RJX7kgvwpb6?=
 =?us-ascii?Q?WPlLFTaImrbA1+U6fbbbj9oI7HYyUhjunJ4kNDSSsOJcBaGJN5mA4KENE0hI?=
 =?us-ascii?Q?AKyt685icAaARxr7jXLHBEzom3+rPjTpHS+U/lgD+dk8xs+O8fnRNjbFzQL6?=
 =?us-ascii?Q?9luMr+O1lqGjr2JXnXWQX2rBMG93hwCXlwR4/VEFBhG1FtgX4uq/t3oBvyDi?=
 =?us-ascii?Q?JTpt3KZYTt5cCOjMzHNALFbGP/UH2Z4k5wbVAi9fdBDi5wek24LlDMwV9/SH?=
 =?us-ascii?Q?2Il/A6QWFxAvvIiS1n3hn8bDClyBOgFPNtMaPgVRTrYGTRA8yoi4AGVVkY+f?=
 =?us-ascii?Q?iPw1Tv0gG28Fc2udo5xrHtjbvFMoDKC9zgmATr0T4i/LYAhCN1YWshgmRK2n?=
 =?us-ascii?Q?EAaJDq3miZY9MYr7F2/tgALtQ0vLxuUmfc9/fF4/zjlmtXKjp2nYNNVB5ZMq?=
 =?us-ascii?Q?Ix7i9RRw75RNO4wOLw1+jYbroQQFIfZsH7tj1ZFKaisUasgpWqYeTfzUqOlP?=
 =?us-ascii?Q?Gm4a2nXF2fvAqsZwQNgqGCR2dfG1VDpiwtSIATKaS+otj4uJ1pGpUO+l9Idz?=
 =?us-ascii?Q?RG34Zfm4ZKLa4qmQIKdPI+eRbOaZ7wkY2cuzJxxbabdUwyh2hNFXSJrCSTJF?=
 =?us-ascii?Q?PnV/1pAJu7ZR15RShWnDts+rMI3Qyj8BoD0sEzYrkltnnZrsB43N7j1Hokoh?=
 =?us-ascii?Q?zMHKUjNeE+MS6+uYvSBxlzTw5LeqvT+jjgn7ypgQRV+W/R6pbAfhz8DkWeZS?=
 =?us-ascii?Q?E/E6OBAi/f+wd8wDJEsYjkjVF6Jmoi76SUBnwiExxE3N8ru+A1GzDntHpNKt?=
 =?us-ascii?Q?bzRrYE0udhMd4aA4ZytkXfAlVxcS8gto/A0Yq+Hj3Wadu5jymgbaEsq5kDsR?=
 =?us-ascii?Q?MHW9zKZQqahhgL679UkspvlHp8FHm+J0CSBmSbmRbxQg395ajbeUiiyDI0Ti?=
 =?us-ascii?Q?7GK53Y8tIkMgCpYl4xg6CbvdZvU/CGK8mHSSlPsyDVugHCbGSOTUqWl0/5XT?=
 =?us-ascii?Q?ac/BfRanAIQTs6rN9KYpiip7KAgTZloFKhZbMjLu0sWtR4bSmwGw+UIHIQYJ?=
 =?us-ascii?Q?ioetufvXRMqkgjgOlB/G5flctuWrqDimzfKwYt+VSnXHrdNvl0Xym5FTpB5F?=
 =?us-ascii?Q?0EzWnh2ixGFQHRDn8vMCgteiPNdgzlR8HFG1k/0Y4MolN+7+Rn0CHL8rnEcm?=
 =?us-ascii?Q?Jf56PBegDx76iJJgbeABhnDJX8y6d7eJoWAJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:19.7254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c43bf574-b9c8-4e25-c006-08dda4c590a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 39 +++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 02022c7b4de78..a68e1fe3a7d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6278,21 +6278,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v11_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -6815,6 +6800,8 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
 	if (r) {
 
@@ -6839,9 +6826,16 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
@@ -6984,6 +6978,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
@@ -7006,9 +7002,16 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
@@ -7245,7 +7248,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7287,7 +7289,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

