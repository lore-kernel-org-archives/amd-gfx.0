Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959FCD46BF6
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 19:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3759C8992E;
	Wed, 28 Jan 2026 19:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="idgciM5q";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 683548992E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 19:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp+Gl6pPQSNO/L3F/PiVS5r0Nji3J/vEjdRNkfIBGxtswS5+S8C77qgXxvi7EZvit5rhAPmYBs4nzf74Ya7AgGqS8QlE72R9EiPtLiU/ymRjg612HlpUUCCrXlMLBe05vFbKldWexe/s5Jz9FiK4DEDiCW90P3fiDpcXaC7CB8cBfw5adjxHczvUcvWj94hUYkVZjCOvxszE5imGuRMVP9IFeetbFyLyzyplwkbp5nAIBPSMF3p0XAjgw6cRGARXzFEy2T0unXHtoYZX2A50w4dsyVBtstJ8HK3X4Yn47d8rPjMPf/X9IifUoDzazTe5ObtLoz3F+McImvVWJFWKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdCp5fVWk81kshg1d6WQvXV05IJ/6RFriDkOXSzKUp4=;
 b=tnqpNb7f4+O0PkJe0RrMtHIc+kmloV6FqznUCUcTJ6UNGQhbweiX4irsLjWUEvC3FCFyi3OCXt62NyVrUJECIM0b/aNdFyqRHG09O9BtSYyPzJ9orWOxdJ+IgvICUq6lcUHO5Cj7mduBu9+0ISmuD9Rz5LIxhRM4owaySKaGh2SYWdBZ7p8Mgtrw1PZL5dDueEadDEbzWw5NrxkPaUdP0L6Od0H9nKMP+xcjXhaixApPF+wF+1zBFUV3G2HIlKo5qu58nK2YVOFqpZNQE5rSuimerjyJKNi/qpeMnQHCAafExvHYXlxM2XfbFeZaCDVs72BrgGQHtW78qVnuBOAQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdCp5fVWk81kshg1d6WQvXV05IJ/6RFriDkOXSzKUp4=;
 b=idgciM5qPGkof9RTFYpka8Ok1XA0sMZKW6YqLayGDtQokExDepPS0ys/3RiIvIchHHkoQt/PDh+S+AY/TEOklrO9VaZuAirVH8OIMz3u/8CiM72Fqg2nhxkZLrrpA4vHwuy1IJD8QvScszjm/TDRx/gRexOuGLVoHzvCZLsuf5s=
Received: from PH8P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::11)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 19:53:37 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::c6) by PH8P220CA0010.outlook.office365.com
 (2603:10b6:510:345::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 19:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 19:53:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 13:53:36 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 28 Jan 2026 13:53:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
Date: Wed, 28 Jan 2026 14:53:27 -0500
Message-ID: <20260128195327.2158888-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e81b7c1-1963-4453-3e7d-08de5ea6ecf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p9+3ZyaacKQu2SSjww3ys+rBNurzS9PGK8YkrN2niXrhr3eb+kJv2yKMhKzy?=
 =?us-ascii?Q?0LymgqJsmbEyBz/UgINdqBu0Hfghzr1pl6wB1O6ljTtqjrsEJ8nXhnANf/h9?=
 =?us-ascii?Q?Jv5JFcHNHNmD/vqQWRDJNXhjrOsOFym0ypTVZJXtHqgNMmAvAZw03GVreRKs?=
 =?us-ascii?Q?dpstS13pkMLmA5Oj5ps5AZhTvEw6hwH44Tqe+tolb8pNOpPCk1P7ccNGYGOK?=
 =?us-ascii?Q?VH8/382R7s3RFG6ivJ+3iVveMugy9X0g+fNOlV822OwaJzJE0OsOgZ4E4Jtc?=
 =?us-ascii?Q?sOxPUHUzCmZd4EQ3Tfm3K0xfwyzFV8yK1DWdP1w5OsWDJVwKxuN+aft3DKiK?=
 =?us-ascii?Q?dZdYxYeaCmlYtTkKqFtKVSPI9Xp+0WawyGWZibGIHcRzo4XgB+Sr9kfeCZxz?=
 =?us-ascii?Q?ALtcZsUcL1kK32b5sT2GINr4QhkwkVTRYWJjnQwLB9BowTcRChmm+zBwDL4l?=
 =?us-ascii?Q?k8S2LjmD4d/TCW1JD8SaunseJ2bBOQd5zAyFQ9qLUvyPd+QZamknEevtVrK6?=
 =?us-ascii?Q?w75k/5fJXMCcES1OzUYplm63UHVqxcnTfIWuU4vflAIDKKtj2qTWi8dsSmvS?=
 =?us-ascii?Q?iTyJm2j0IWwr56XOll1gmElzAERSHCcyQHyjiGjEz1lQKiYUJQO83CHNUmzF?=
 =?us-ascii?Q?jxd+6Alg6cxd27yiUP7X6qTLLhIJoKEnLWKskBqXhlnwHHFePSjd14ursgOR?=
 =?us-ascii?Q?vhkMAivg+liNpYfx5ytE+8ye8+rIClveIXtIrS/2WyyNePkGscJ3AAK+D0GS?=
 =?us-ascii?Q?zyn1A9jwwSzprRG5NX3fXRJwP6REW2AVY8e75TGC4f0+VtkmMmQMOszuTv4T?=
 =?us-ascii?Q?Wo0CWxQRaP1+W52RjGnEQE6miqyJ7Y5RN/YMO/vpLthv23u8DLDTJK/4p+MP?=
 =?us-ascii?Q?/6r7+67Nb6oG4Inc6ev8ULRCosjQndKgX6lkfRbHfWHG2NDYOGGjmTj0FdWa?=
 =?us-ascii?Q?M6dGSgE962SmWVtzY3Ana4kitOrIBgJRtTAHA11ewKlBLZ34TQnYQrr3Jn50?=
 =?us-ascii?Q?n3nbs0HV17fdeje/9eIR+m01qvj3KJfLAx4F0nnJ5Ik6aFIEQcsI1zi0rRQQ?=
 =?us-ascii?Q?yAzEaIvar0uFqHtsR9qAVuNw4Fv6GJvSZItpG2f6mp3NYDUvynCa50rtDb3/?=
 =?us-ascii?Q?+MTqzLK2WlWWjkLSJvxxD+YLZw3ng+lIaFtGyrvX/3cLd9nDWydzqWVmR3gj?=
 =?us-ascii?Q?W0pcf9ot6APaQAgmGUjrFy2h9fqkMX6qgjbHHTCNgl74H+uos/xzwuoK8HKp?=
 =?us-ascii?Q?9DM7RrJwrwNdKtWDvhWNjTTOk+oD/wmMoWYI3+SqApiXc/Fa5OICY3z5tIOd?=
 =?us-ascii?Q?GcCpxyScMLatpKaZS1NqAdHlTcY1Y38MbA6/vwNrD2UQPLfK71npickKGHbb?=
 =?us-ascii?Q?wPcw/EoewhtdksZJWXD+VZHR6TKxCppeeVNHIgD75IE/iyLzzBQuFU1bAbVe?=
 =?us-ascii?Q?1uBIp7HjQRssF0Cs+PnMCPq4gpbqmhjSW4xic/kp5VRO5wI246FzXvXIl0wL?=
 =?us-ascii?Q?qj3Wzp2eWmlcI9lwI5YCxUsRbDp5hNicRzLV1OlDnjXp3UcPu1qjerpZ/jWj?=
 =?us-ascii?Q?3g/bSCCFZvXkbtJA3o/Tqxbp33TZuTkemXACPxvttSFlXup1IuFPr9Z2nDFP?=
 =?us-ascii?Q?dMHmo3R5zJRAOm0F/e7IplwuwkDZeTrFpt5kN86X89A2UGEFRUvp3185IDHX?=
 =?us-ascii?Q?ivMmXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 19:53:36.5615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e81b7c1-1963-4453-3e7d-08de5ea6ecf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
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

Plumb in support for disabling kernel queues and make it
the default.  For testing, kernel queues can be re-enabled
by setting amdgpu.user_queue=0

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 109 +++++++++++++++++++------
 1 file changed, 82 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 08ae50a6313f3..f93ee275ce398 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1155,11 +1155,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
-	/* recalculate compute rings to use based on hardware configuration */
-	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
-			     adev->gfx.mec.num_queue_per_pipe) / 2;
-	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
-					  num_compute_rings);
+	if (adev->gfx.num_compute_rings) {
+		/* recalculate compute rings to use based on hardware configuration */
+		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
+				     adev->gfx.mec.num_queue_per_pipe) / 2;
+		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
+						  num_compute_rings);
+	}
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
@@ -2794,6 +2796,36 @@ static void gfx_v12_1_xcc_fini(struct amdgpu_device *adev,
 	gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
 }
 
+static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	unsigned int irq_type;
+	int m, p, r, x, num_xcc;
+
+	if (adev->gfx.disable_kq) {
+		num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+		for (x = 0; x < num_xcc; x++) {
+			for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+				for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+					irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+						+ (m * adev->gfx.mec.num_pipe_per_mec)
+						+ p;
+					if (enable)
+						r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+								   irq_type);
+					else
+						r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+								   irq_type);
+					if (r)
+						return r;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -2801,6 +2833,7 @@ static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	gfx_v12_1_set_userq_eop_interrupts(adev, false);
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
@@ -2868,10 +2901,26 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+
+	switch (amdgpu_user_queue) {
+	case -1:
+	default:
+		adev->gfx.disable_kq = true;
+		adev->gfx.disable_uq = true;
+		break;
+	case 0:
+		adev->gfx.disable_kq = false;
+		adev->gfx.disable_uq = true;
+		break;
+	}
+
 	adev->gfx.funcs = &gfx_v12_1_gfx_funcs;
 
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq)
+		adev->gfx.num_compute_rings = 0;
+	else
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
 
 	gfx_v12_1_set_kiq_pm4_funcs(adev);
 	gfx_v12_1_set_ring_funcs(adev);
@@ -2898,6 +2947,10 @@ static int gfx_v12_1_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = gfx_v12_1_set_userq_eop_interrupts(adev, true);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -3719,29 +3772,31 @@ static void gfx_v12_1_handle_priv_fault(struct amdgpu_device *adev,
 	if (xcc_id == -EINVAL)
 		return;
 
-	switch (me_id) {
-	case 0:
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-			ring = &adev->gfx.gfx_ring[i];
-			/* we only enabled 1 gfx queue per pipe for now */
-			if (ring->me == me_id && ring->pipe == pipe_id)
-				drm_sched_fault(&ring->sched);
-		}
-		break;
-	case 1:
-	case 2:
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring
+	if (!adev->gfx.disable_kq) {
+		switch (me_id) {
+		case 0:
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				/* we only enabled 1 gfx queue per pipe for now */
+				if (ring->me == me_id && ring->pipe == pipe_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring
 					[i +
 					 xcc_id * adev->gfx.num_compute_rings];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		default:
+			BUG();
+			break;
 		}
-		break;
-	default:
-		BUG();
-		break;
 	}
 }
 
-- 
2.52.0

