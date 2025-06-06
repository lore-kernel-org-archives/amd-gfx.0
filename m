Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0D5C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9D410E8B7;
	Fri,  6 Jun 2025 06:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G8TjESYn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54BDB10E84B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYppL8GS2/qTZZ3d9rQGrQhMs7HQVm2HohnB1Y7cYlfNIc3IYGeZxfz0BPIoMYfqJKHwyqeWcq1vZY6HftFTbmnVAW+FcptFfE0yCD9sVXWt5lwxWMwVKYC+I2mh+GgbZkgI0wVdtTI3RFMSXV3EdgguY/In0V7ty3lDyYmwAVU9/qqiIvDR9zMs6xFKagGETTiEPKivLPfZw68ba4H6XWSPUoW2sp46pbwPeVSiGqHhW2jelHrC+VAx0dJtWGwANzy+ZVzmYWK6yA00aod7tf5U1/SvcUgqGKXZnWdjxyQ/wJif0DEBM+CLRXnzlBf5yeImmTNCcrFNIVgM7CaZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=cqlEC+GOujl4GJukpx6cQTqnUZxJmPCvPoe6BOl9Sh6l3lh004UmHe3nnDHz3isIobyfaj8U3Pe8554GJo58B6DVWnh47Aqim6ZMgBqDBF4Tbtuv7mGLjBW4RN0nHmE7/2Lw58tUj1aqXEpPpN/vff9H7tj9oTlxKaMOfhh6SaXjqmLasrafTmymIpVoHStHBZgbQYJosb638FHzdw+naUqdx6ipLDthhJS4LKpt0sIBhvuxC1j28v3J3GS0PEogn9oh2YwI2Sab6joid56RxzQb2415V7D0C2Mw4iW/V60qYKwNzq/IpUIInGLd6sczdmSnNDNsi09M6uI8q16zUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=G8TjESYnqXCgI83pjRWiCb/TKroC9uZaLt4LyuYpcADzNe04grbammkk0tzFy/33oTecn5cNZSI/mKjwZJZTZpQDl/zYhrMopQbyNkREOAz9ZOKNFFXyaBtfKcaiYEw+If6MBAUjv+Ua8f/L/OHtPoOzRoW5BjmGIFH+Cv9yP8k=
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:12 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::5d) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.10 via Frontend Transport; Fri,
 6 Jun 2025 06:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/29] drm/amdgpu/gfx8: drop reset_kgq
Date: Fri, 6 Jun 2025 02:43:28 -0400
Message-ID: <20250606064354.5858-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 376eb878-0360-425e-6ae9-08dda4c58bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?laFsDUvDq4C4xwJmG9EUPHke27P4RKvcZazUK1i8Dm21bywX98aNXqSK8xsK?=
 =?us-ascii?Q?j0aAZYFWjyLJzwCcMR1i6Vje1hdCblEoa0teyMUdruAdS+rCxKH99rZ4l2k5?=
 =?us-ascii?Q?lA0Xj9O4u/j1KryUMN+A2OadvinKjJ4ynUZwLRSOjNzx0dqt6fDlChux2Ryi?=
 =?us-ascii?Q?Uo0p7M93KrVQXds8lvVbt3rRsNOcyA/ODSfpBzrX9pTA85peu+J11X1vS+ua?=
 =?us-ascii?Q?5ZVd7Tb5mkeX0YLXLUR3Qo/NbjfEtlCSmFzPI0HjsOhncjfeAtDkM7phct5/?=
 =?us-ascii?Q?jKPDIJZrtiqCSz//SspDMt4jLyjCj7+56ubB5zG1f9xIsqPzCtSfXS1/C22K?=
 =?us-ascii?Q?gi8cRX8ZY+qB5zHNTwzhtWCaLgssJnVQcw48HXsk/dIYLBu3eiM+H1yZ3a3u?=
 =?us-ascii?Q?MH4W2kjdf4/PSB6jLbCobNOc5+t8CVZLyF8zA0M7W2JFIXoYZnBh9aQ9Pf2J?=
 =?us-ascii?Q?Hh/olrmO4qKx7dRDbfyzU+25eRVd2HxJ99zEeB5P3wWCExQkID2Cy6DkFZ8A?=
 =?us-ascii?Q?3FfioiDG87OFmKzWID5KTYC6cvFtduAQSIKZ5Ei0bCdLsZe6PtBMYgxQKrnP?=
 =?us-ascii?Q?b5Mg32WvMCNEZ2w6VAm+pWIt2IdPBVC6TJnlqgW+/SzFtU2yzhfuliM0YZNo?=
 =?us-ascii?Q?+P/NhjZr0+crH4tbvbt1YA41iakPSccYdJoBbNl3EYWFoAdP24Tx6o5qrkN1?=
 =?us-ascii?Q?7vqQnO+cTK2hF46j47+d2Q1jQt5Hz7fOO+zN/Q2qAx11u/KGX2gKl4pwDLBB?=
 =?us-ascii?Q?dT2Xh/XKiXkuHgvadvUApVvxhtXnxyT2IgdGCOZMJE1btH2HPvEYXNdzayDf?=
 =?us-ascii?Q?raiV2TlBSqsk0Qsi8tA1X7GzMTJMnF6CD1ahqQhaTgaMq2au/jfp0ML8i/+A?=
 =?us-ascii?Q?unS5eGDyJe8xejHKej/7YfuabmFqTxOJMVKK2/0mRcEr7p1b3zcfy0koYmzg?=
 =?us-ascii?Q?QdhYyGpm8p2liLVTJRjrSJeRuYrFNcmvbZgtXJwrfBK6psj4rVoD7XQAL9KA?=
 =?us-ascii?Q?1B+O4Be9havBfWfxUIddpSXx+fSMh+os03UHbd6movWTfd3QDZhOx8I7yStX?=
 =?us-ascii?Q?Vl1BlCbF/+ceR5dxKr0ILVHn1GTYHyHaVrOEzPQWZ51itMCu72DpG/rxQQTT?=
 =?us-ascii?Q?XsIB2DbG+04F/r/aP7SYP4ZcPlxetvJi/HhknwYQkkP70W9xfrpHRRJGDVTl?=
 =?us-ascii?Q?vh93I4diYelNyXtBx2SUask63qQLH6RpO8s85GTxhzu1d4NLLhO0Y0HRiXS0?=
 =?us-ascii?Q?ddS+3vyCJU4v11Nv3vMRqrzhqgMyp6TsOW3Sc+mLRWaTpYcLvJH/mhVoUXB2?=
 =?us-ascii?Q?yFSqj3Q7SFROZlxoidzvpvjz3Bm4MEdrV8Pza6NUT/IrtM12HAOdtGL13G2E?=
 =?us-ascii?Q?UVnUpvDLxuoypA34/nKwMUaytS9Jo+S3PNjMx/bTRS69+GaRjkrdPy9CmH+F?=
 =?us-ascii?Q?HYj5RCeVZMkv5jU/cRUYOETgjunRrE6jXssxzyvaqvOv3J/fvMrhAXaRfMEN?=
 =?us-ascii?Q?X8A7Os8EvaVJRnaoChlL8fEWtEc0XO5AbJDP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:11.7210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376eb878-0360-425e-6ae9-08dda4c58bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

It doesn't work reliably and we have soft recover and
full adapter reset so drop this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 71 ---------------------------
 1 file changed, 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5ee2237d8ee8f..68c401ecb3eca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6339,34 +6339,6 @@ static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 	amdgpu_ring_write(ring, val);
 }
 
-static void gfx_v8_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
-				  int mem_space, int opt, uint32_t addr0,
-				  uint32_t addr1, uint32_t ref, uint32_t mask,
-				  uint32_t inv)
-{
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
-	amdgpu_ring_write(ring,
-			  /* memory (1) or register (0) */
-			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
-			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
-			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
-			   WAIT_REG_MEM_ENGINE(eng_sel)));
-
-	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
-	amdgpu_ring_write(ring, addr0);
-	amdgpu_ring_write(ring, addr1);
-	amdgpu_ring_write(ring, ref);
-	amdgpu_ring_write(ring, mask);
-	amdgpu_ring_write(ring, inv); /* poll interval */
-}
-
-static void gfx_v8_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-					uint32_t val, uint32_t mask)
-{
-	gfx_v8_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
-}
-
 static void gfx_v8_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6843,48 +6815,6 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 
 }
 
-static int gfx_v8_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-	u32 tmp;
-	int r;
-
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, 5)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
-	gfx_v8_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
-		return -ENOMEM;
-	gfx_v8_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
-				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
-	gfx_v8_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
-
-	return amdgpu_ring_test_ring(ring);
-}
-
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -6950,7 +6880,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync,
-	.reset = gfx_v8_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
-- 
2.49.0

