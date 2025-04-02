Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6A8C36010
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 03:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A83010E1B1;
	Wed,  2 Apr 2025 03:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r1tyno4T";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB1B10E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 03:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8hQq47ItN4Iglnn4/fweTrtZ40vHHZjTXnXeX33h6itGx5LhzVBQ3B+too7UaOs6B0FMDvFDDhASyLaMZC6EDX3GyeL+cZvPC+OVfuRHfQ7RJOBYOLN19PZ+A/5aYlX00e9+LSbe9p4KhaQJlnNULqi3SSIN0DxvJdst6NIKrExV5tcbei5eDlGC2WhaZPcWha1pZ/uO+QNkTkhi1uEcfSobvh3dnhhRtXCiFQOS5OetdtHxWEMdVNRFUd1QUl+iJZR68wHhsq8ACQoS47Zv3E3Mnr3V3aMHFBReEMHGYNO8k89Z79cEczECp2fK9Z70BrYgATn2TFs8OrinV621g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33zxrB2kQJ1dW1RDGGheyOG6h8vlUU1AtEKjjRLPHws=;
 b=vDOpuuMzGTzvZ4IXgMe6xKpjlAFh24AzU5w315qJmCRTEQ9jiNTqqstTjd01wNNPomX3Cba6AnyFlhkl16PMcQwNusPHNMXsitPozMyAySzYrrh+Klg6fgKJGJcYsatrdLE6Tl7mbQbc3rXDDVwgoSd0zDpj1SQJ3RKobJ6PNWgu5iuX65P0TUKSuy8s2LBM0qi2WEu5zpD1YKrkXFxWSqQSRAl7dzdgpqKnIiuSIiJfDj4vyPbHPUyngABm0YASHW2mFny8N8fUPLJGAPI9P2OQHscBHrR6Pccvp6RYFrlSofeknn5LBaCFwNJySA99IYeucCWI9Ys+g8zJzKRn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33zxrB2kQJ1dW1RDGGheyOG6h8vlUU1AtEKjjRLPHws=;
 b=r1tyno4TT86eYYMBcHPsgJGe6cK2KmyvBWcNIL3YpL7642/vZDfKN5D95dy+3RUFzss2g7R//H81VELPkabymG5SX6mcedh439S2kIYF4/tBwSvaCZejgaocpDHJsQgDy9lHApSg+t+q88e7y1MOY8WwGym+EmYO60fc8NklMNQ=
Received: from MN0P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::15)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Wed, 2 Apr
 2025 03:02:48 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::ba) by MN0P222CA0007.outlook.office365.com
 (2603:10b6:208:531::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 03:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 03:02:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:02:47 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 1 Apr 2025 22:02:40 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/7 V2] drm/amdgpu: Optimize SDMA v5.0 queue reset and stop
 logic
Date: Wed, 2 Apr 2025 11:02:11 +0800
Message-ID: <20250402030215.1074975-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402030215.1074975-1-jesse.zhang@amd.com>
References: <20250402030215.1074975-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: df2cfc7d-49c2-40f2-e6ac-08dd7192d941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5572CCthfGhr71CIJ5pap3qqIr78itctdTrklgFBxVzW0VSvg/XacewV+Eeo?=
 =?us-ascii?Q?7undLByUDc8RjEgrsSUe/IebzP8OU4utED9vt/s982mHG1GJD6E/e065m6EI?=
 =?us-ascii?Q?4bXp3nLyukdvQ5nTGwN/pVpwaMOQLBTw6nJsOrm3odfsKDeApuAqDa9ofztE?=
 =?us-ascii?Q?SWGqs7SgTSosT/j5EN8FxKOBcAbaWrctXFlJrQz3GoS1/uz8kjBCsrNtFivm?=
 =?us-ascii?Q?8tN4Ja6UB4kRpmsiuaXXfP44BUyxsblxlO5FFbMLwBGgL5tQutyxqpeUk9t7?=
 =?us-ascii?Q?MvwDFfsq1PeNHZ9X/0sEVXtJhakAjkrGmGyw5NDACxhZ/YWhapK4tFpP8LEp?=
 =?us-ascii?Q?mqb+i+u7OOToupZFShImr5AmJim+PE8fTief1p6Xmmm0bzYRtwGMdW6zrzvx?=
 =?us-ascii?Q?vF6itKKq+avsGdbi/ge6ec0BrgHpZKYbvRbUJg73UUl3HsXUp0Qiouqf9IgA?=
 =?us-ascii?Q?w5//RfogHNGvds4hj5dmRh3qcWv3/8xvu6N7Evbp09LTD79ME6RB0NJr8shK?=
 =?us-ascii?Q?TnNbi7PLLSALfBbpQI4sz47y+XWbQ5t6cUd47EjoUEsIKZBuDvcee/cY+tCi?=
 =?us-ascii?Q?YIXAOr9JnyuDTjBerWKjPaemeBX2tXv4iU1Jem1n4aII2ZrCH6XJ+ZJKbCTL?=
 =?us-ascii?Q?NsTdGe1mxKcIoHvocm30GDF3qbBKwtF+l50MxzxhX7FK//jCw9J0CNmSVais?=
 =?us-ascii?Q?YAUJB6o+kswWlPc0fKCIYGUL78rLHfH87nGc7bNxZqsmyDt9/uOrnQwGe/ts?=
 =?us-ascii?Q?sAKHba1dAITVuOxqdp84MLg7/l8ebhAdjkm3uEIr+NIZBs0667PEebiHyhtt?=
 =?us-ascii?Q?4J6VGXXgnjvoTrWBaJ11RkJJtFqajZuENpFzvZ+wK+YdKQsdP5ptJpctHzCy?=
 =?us-ascii?Q?S4wLNNpgEis6pi1IEw6lf7wuf2fOVSSUgXCm0Eln1slYUOcq3aTP9k6v9aXv?=
 =?us-ascii?Q?7ClsKr1ggu/G+/hcS20Ub65lkS8vmVp4D1UOz1/ExwL4jzk35wYbU+rswT6n?=
 =?us-ascii?Q?a+Z5zMBuZEsybf0+S2B46Gbgi5Q4tvwA2JlkX95jZKYMTpZSO49aKKxUkvET?=
 =?us-ascii?Q?W7Z9K29Yw9NSO5L1ruCxBQPZNs8Cp7aPVLVZFOwNkQJ/s/7IBM8BUIi1eiE8?=
 =?us-ascii?Q?C/VXABua/+zt2s0ZUrKwva6Em3yyyZFlhwGwyAx9tjNnWvTcKnRmVLGktF2q?=
 =?us-ascii?Q?9cI0zJllrgc0fRnC1ySkBA4k86eO4PI31QgO0WvFNzeGK5rc0VzI6SQe1wfm?=
 =?us-ascii?Q?SzWLBXr7lLVY5Y1PtvrSFl2iVDe92Pz8li0yripzIHLW8nUHmvcOq/dnGWs9?=
 =?us-ascii?Q?JJkT8LSWb5FhTetJSa/u59Up8dl7qqIjEN/CEbw9fiN2XlNq/Dn8mQTCyHhU?=
 =?us-ascii?Q?GQTecNQ9RPC+odqpH2rRAdDV0nVugI+h4NMQyph/2WckuF/xtic0Mgvfol80?=
 =?us-ascii?Q?mPCjmeNRyQ5OGf4oC2HvQGXk+L3SViLN4gp584lAu4KMQSumXv0Mhw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 03:02:48.0148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2cfc7d-49c2-40f2-e6ac-08dd7192d941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the SDMA v5.0 queue reset and stop logic to improve
code readability, maintainability, and performance. The key changes include:

1. **Generalized `sdma_v5_0_gfx_stop` Function**:
   - Added an `inst_mask` parameter to allow stopping specific SDMA instances
     instead of all instances. This is useful for resetting individual queues.

2. **Simplified `sdma_v5_0_reset_queue` Function**:
   - Removed redundant loops and checks by directly using the `ring->me` field
     to identify the SDMA instance.
   - Reused the `sdma_v5_0_gfx_stop` function to stop the queue, reducing code
     duplication.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 65 +++++++++++---------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index e1348b6d9c6a..9501652f903d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -555,15 +555,15 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
  * sdma_v5_0_gfx_stop - stop the gfx async dma engines
  *
  * @adev: amdgpu_device pointer
- *
+ * @inst_mask: mask of dma engine instances to be disabled
  * Stop the gfx async dma ring buffers (NAVI10).
  */
-static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
+static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev, uint32_t inst_mask)
 {
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for_each_inst(i, inst_mask) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
@@ -655,9 +655,11 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
 {
 	u32 f32_cntl;
 	int i;
+	uint32_t inst_mask;
 
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	if (!enable) {
-		sdma_v5_0_gfx_stop(adev);
+		sdma_v5_0_gfx_stop(adev, 1 << inst_mask);
 		sdma_v5_0_rlc_stop(adev);
 	}
 
@@ -1506,40 +1508,25 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, j, r;
-	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+	int j, r;
+	u32 f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+	u32 inst_id;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (ring == &adev->sdma.instance[i].ring)
-			break;
-	}
-
-	if (i == adev->sdma.num_instances) {
-		DRM_ERROR("sdma instance not found\n");
-		return -EINVAL;
-	}
-
+	inst_id = ring->me;
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* stop queue */
-	ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
-	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
-
-	rb_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
-	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+	sdma_v5_0_gfx_stop(adev, 1 << ring->me);
 
 	/* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
-	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
 	for (j = 0; j < adev->usec_timeout; j++) {
-		freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+		freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 		if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
 			break;
 		udelay(1);
@@ -1547,7 +1534,7 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	/* check sdma copy engine all idle if frozen not received*/
 	if (j == adev->usec_timeout) {
-		stat1_reg = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
+		stat1_reg = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_STATUS1_REG));
 		if ((stat1_reg & 0x3FF) != 0x3FF) {
 			DRM_ERROR("cannot soft reset as sdma not idle\n");
 			r = -ETIMEDOUT;
@@ -1555,35 +1542,35 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 		}
 	}
 
-	f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+	f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_F32_CNTL));
 	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_F32_CNTL), f32_cntl);
 
-	cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
+	cntl = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_CNTL));
 	cntl = REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_CNTL), cntl);
 
 	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0 mmGRBM_SOFT_RESET.SOFT_RESET_SDMA0/1 = 1 */
-	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT));
+	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT));
 	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), preempt);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT), preempt);
 
 	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i;
+	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id;
 
 	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
 
 	udelay(50);
 
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i);
+	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id);
 	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
 
 	/* unfreeze*/
-	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
-	r = sdma_v5_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 
 err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-- 
2.25.1

