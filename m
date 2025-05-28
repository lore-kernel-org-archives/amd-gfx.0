Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C648AC5B554
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05B110E6B4;
	Wed, 28 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="081+0g+Y";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 648D110E65E
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyWYCqla/vIiCgSsobPOqp06nO+VivRs2I78MWDXrF3lh14TfcMNeQyPAMWbEcRv+1xowfdmf8+pAPmK2xkvwuxHM44J6ibYQ4osukSJc7Os4etMOojSP4cCBzPkSKBabZ74KOIxj5jfNGLg2xEZTB0euXbRvbN5lUkK2GIoCrOD69xNHR5DrAM0i9wNlzKHGWhRuDhJwVqJUA+GBEFvY1ejL5AIHmSl65EUW/tpI9SUejC8RpHkhOO4H4sohMFaQ2Qm3++Asuu0LPZ9ltSsLu2CX3DjVcLHzoEES4xbdcJvjfOFa7jeIdJQpGMl29+usbEJmlJvidk3t8QgvIReyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9ZM7WDnMMyJDEIR3k1oCTPbLS2ykuRKzkskBGxUjCc=;
 b=GBz4uOINOORoI+6k1CPwK5tbnJcF5m+QpBdfvvSb/yHiqmL5XCEsFhSiL2MayYx7Tpdh/bjbcsldfnmp5SDrTyIOn8uxgkanL0Av49WWdpZjOUuR6eWk3WPEYL9E2jdd0czSND1KpVCxuec7UFZMtRKWqEXZMpWp/ByTQYMst3K9r8U6dxDuuB5a+7wPD/XR2nHwRB6jMdABtapFHuYU7fwsMdLefNAeDFj0ypYHDhk2KD77mXaSVsh983zLkh3BYlrxPAa8QI2HgEasb7F174IuiOiwtFUDfWH3/dLXol+9PZZV+iwOhvEFHTd1R6O/UaJOG41B2V8AwcFU7u4hbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9ZM7WDnMMyJDEIR3k1oCTPbLS2ykuRKzkskBGxUjCc=;
 b=081+0g+YGbsmXgR1y+I12FNI9t5o5yYm7QiS8PDMl+RTIhUZ7L8yqyTFLdRPc6wbdRyREXfmFeu0T4m/3ac2O8fH7ub5sZelYO52zjBvoQ9gB7Q8NX5jOudDpnC2SCLuxszvjuck6tK1aN2VK1vGZ3n1fscWO/wSTIFayiXjVR0=
Received: from BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::6)
 by DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 17:28:23 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::d4) by BL1P222CA0001.outlook.office365.com
 (2603:10b6:208:2c7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 17:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/16] drm/amdgpu/gfx10: re-emit unprocessed state on kgq reset
Date: Wed, 28 May 2025 13:27:54 -0400
Message-ID: <20250528172801.34424-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DS2PR12MB9615:EE_
X-MS-Office365-Filtering-Correlation-Id: f856daf8-8a8a-47df-3e74-08dd9e0d0bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZUGGp+BZqy7xep6eDBl5GYpmJQ4k619yeXGZZMkZzzvSYUk3DQDLwHKFRARy?=
 =?us-ascii?Q?E3JShwJAZK9lUG1y0L/E2pSy/VZTbHXfkau7gb/MlscRd8Dbr+DXZwFOaq8O?=
 =?us-ascii?Q?xP6XscIEoGrml82ZksX7uPKjq1IOnF9FnvRxiR0TAa2RS2FqTvA06I+ujr9U?=
 =?us-ascii?Q?tdJTWxZ34LLRRwoi8LmPPUmVPU1kb1O7tNp2kaG/cZBi3PmDyGQ8kZAUzO0o?=
 =?us-ascii?Q?VoaRSODPdk8HH9cagwJT+o3ZxNXoXt0hys8qc1vfszWYI5zNZz68Xoo/MCSu?=
 =?us-ascii?Q?sUbyHe05cnsMs6f/WQ3YE3s4F2+w9RmuGZTSi9GUNNt73j9UAm5G2yGRx+1O?=
 =?us-ascii?Q?/dPPGWTL7KgJPj11+b2XRYquftJzVIxF3f96OFOemMG/qqxQ04FpWNGlE150?=
 =?us-ascii?Q?8pliPbE8KRyjl5fFiDHlJRIGo8x02dp8PGypa1heR/ae671JlfYi5LvZG72l?=
 =?us-ascii?Q?bxDtYB8IKiFz3+MAdMkw1JQqJ+XUAJL1v2qbRBWHf07YFCTJZ2PMXOLo99+L?=
 =?us-ascii?Q?CWHwvJFlGuzcYVmhZQuHLKoHoSt3snB6mU6P3NtBchE7xQC+DhLpH4kpenU4?=
 =?us-ascii?Q?Ei+Fm9bZcFvSc/o1RNOmorUNyJ5e6/yDRrqjEdNYYf2sNz9S5R2gZYmB4aY8?=
 =?us-ascii?Q?6ICFSK7F69CbYkhu8613lBrK2ld8DMC+lIIUCRhTLkBPnic7ambkcZ2qkVjz?=
 =?us-ascii?Q?Bj89lk57mRj7NFlJYpWYsoQ7E2VTbBhBUYMqtN8TAfToKnMhA0Srhj8aTFyE?=
 =?us-ascii?Q?WW8FnhPwxLW5Ryz27vU73d6qy5YeBEKWu/wRfiGn8i94DoxSgFV0mVaunpBV?=
 =?us-ascii?Q?n4caoqn1dJmVFpz4e1zHVWe96F83ZEBdLd7njAKEYxUbJmrksvqjS+ewgypj?=
 =?us-ascii?Q?wPClCDL57Ew56Cgu6qz91KcLLtqjmJt1/gIlJguc2cvhG6stg69FbW3qTFd5?=
 =?us-ascii?Q?beJecFi8jUrImbAh8s4AjveFD3nGXZmUiX9lo9ZUBvoofeLoP4kMj8IQz8OK?=
 =?us-ascii?Q?a0HNAAJGBvB8LIf95KReM9HHf1CZly2KqQ3OiXkxDfY6TLzT9eAhYrOMANWY?=
 =?us-ascii?Q?pRMI2bkqXfuCYregcB9M4XRfXo/uEy6o3eOfE/co06yCYUiwfsUbt4btOJrs?=
 =?us-ascii?Q?CsCT/R2CBDd0LvK2x9dNgzWfxxTMdobAtt960A+qPR4sU3gkMlzmG1vxD7WO?=
 =?us-ascii?Q?P33mRuPb/pLwm9ZwQLI5EVM4AnLbsIspvE9weElTOp+ZpLVtDynHYgUDO5L+?=
 =?us-ascii?Q?WzmxsS2cuzUZinXarISUVNg/oCbbQXK8UkgswQ7KE16OZOPODiHY2DRiSPbC?=
 =?us-ascii?Q?yuC9zrvAefMotZUMuntSRKP20vp50vBtyv4BWj+he0DBxZlAVOXb72lPeFmn?=
 =?us-ascii?Q?jKc0ciXL/NK+naQN0vkamNtx4X5xjV/NzTxykWEXfgMNjqfePjYo6c8pOA1M?=
 =?us-ascii?Q?vNg0BU0uKTLhF5ilPpWC+5tUHdzE36/L6WTVRDIrwYr4cM+BDbXKv7TVzJ9o?=
 =?us-ascii?Q?Q/gHHk4ZeUiNp993+1amjd7So3nMOF2Td6Hd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:22.8961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f856daf8-8a8a-47df-3e74-08dd9e0d0bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9615
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3193eb88b6889..eb69ab4256c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9537,6 +9537,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
+	unsigned int i;
 	u32 tmp;
 	u64 addr;
 	int r;
@@ -9571,10 +9572,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
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
 
@@ -9584,7 +9583,21 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->ring_backup_seq, 0);
+	amdgpu_ring_commit(ring);
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
+		return -ENOMEM;
+	for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+		amdgpu_ring_write(ring, ring->ring_backup[i]);
+	amdgpu_ring_commit(ring);
+
+	return r;
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9612,9 +9625,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9891,7 +9903,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

