Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08197C369A1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 08:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF5E10E612;
	Tue,  8 Apr 2025 08:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tn9AEzyC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B80010E612
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 08:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q40BloneQGGJXGhQS3cqbKONQCCdcBZ3AHkboxLugqFwhyj1zQYEqj5sHIZpHWyBn1yIZ3reZHkH9tR10R+RNcd7SGx3ZuKjPAg0UIOyUHCOFkZLeZHgNhQCzGd+ZJdkNdvA2Hu6q4xN4hQyVFJgJwZzMnk8ECagy+Bis7cy3z4Zn185KXQRgtnFx9jdsEWiomJgAPaKH0Qbl23yBiaoNBY2zNtclYYrnelLkqAyjDKWDNQIqGPkBelG/OK9zDlkmNk2PJMizGiYkCG3vxQ7IMuMgiGzeAb6+8cM5Zq+k7LAUoqYgROnByDHUzXn+uqdNu2nmfN3NKP1ON/l5H62xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIbPqrkoltpeQu/6+wZvaJnsa3VHXPxoMsEgqVigKDg=;
 b=tZrdv/6T9iuQ89WVrB4s8ezEyjikUglFCQXPMcb2Gs4+KhT0Suk1o0EWhGfFBVpS8AzrX9dWW3ARuiYOJZIv30GOHCrnVof9rfPjI3gki5bDqkOY0ohqphmLFKsWGKSQ/JiPqVMT+SjHO5uQHuwg9N0/LdpsuKjp/FjHhItX943Gru6r0JVu+RsRvWVBZJoN23nKLFWlk49wgl6sf+vXtlfBHCCtBcynvqfAnurj/AcL10o6fuHmH1gu018eh/W4GXK9V1H0+S5j++a7fg8mlW2HprucJNXnfnNg63Y1jF2AYHX/O9/zNrpEV51gpH6ArlhFmZegBfLV3VCc2rxAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIbPqrkoltpeQu/6+wZvaJnsa3VHXPxoMsEgqVigKDg=;
 b=Tn9AEzyCQUyriVl9ejqnVDAljjPrP+XHQQsJXDR8TltkLnL6eEdnX0/sJbuHmwqykDVZOmbUq25IXWLa1Vm4ypGUES5Xrh6ShMtk5e2QAFe2RPdKq22/7FTg14+K28qkNAjYysQ81DsbJZSEVLsNqHnf1NeuSSNPDgYiD8cP+x4=
Received: from BN8PR04CA0011.namprd04.prod.outlook.com (2603:10b6:408:70::24)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 08:37:32 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::41) by BN8PR04CA0011.outlook.office365.com
 (2603:10b6:408:70::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Tue,
 8 Apr 2025 08:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 08:37:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:29 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 8 Apr 2025 03:37:23 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [v4 5/7] drm/amdgpu: Optimize SDMA v5.2 queue reset and stop logic
Date: Tue, 8 Apr 2025 16:36:31 +0800
Message-ID: <20250408083633.2300420-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408083633.2300420-1-jesse.zhang@amd.com>
References: <20250408083633.2300420-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: dae3286d-a34e-41c0-8708-08dd76789a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LYXlXkw5Fow3/I/hJQY5p7f8WAN3xhuM6lFAx0V1ORHMMKR8ziVwMkRT1g4i?=
 =?us-ascii?Q?G6DoCjg2k7+KhPs04as1AObsYT0NHO7PFtins87O2dX+fxFYjuKwNBZglct8?=
 =?us-ascii?Q?2CXM51MtVIn6imrK8IHPc9Gd1ioa3EgKTVXOYPPhZMoaOO6z4XpDM3RLWHOf?=
 =?us-ascii?Q?ERK6Ll5wK/0KrsDmlLI8MNePOhhaw2eU2YlVQlTUyxjiWmJrbz0OXrTDPaDE?=
 =?us-ascii?Q?V8UsaFYl/iv82iniwsaV606qPCeYklfyXYP2ACIZbkKpsDIFoGZpBC+4F0sZ?=
 =?us-ascii?Q?V5K/GnR0E7qLhAP8L/S53FewLV9tZLzFY975tenl7hdXWO3MKrPs9OU2BMYi?=
 =?us-ascii?Q?JbjPrM5bRvrzjvDjfKAZvATbRkP9TKdlQPXyGukNZtTSxI/kGZagvj2YG5hy?=
 =?us-ascii?Q?3FmpRgqd/5X8ehkVaL2rSTBUkLIZLnwTrMkQhqApmlti5FuzIpaimRxNL2kk?=
 =?us-ascii?Q?SkxIskFrPGZwh/MKbJbHEXhbwPxjZ/a49BbGJuaqmZjBoOrjsg+tm2dOiXq1?=
 =?us-ascii?Q?MEylBH0yjdTK4uq96Kgd5Ru/aCelbjhMaaBveJLTzvRdlc8ANw/0U4URtdQV?=
 =?us-ascii?Q?ikzSHBa7q/FkyNse0Wp3WlFQap/htnrPeh1YtvKgfDzUH+OLjXY4cyIsauc2?=
 =?us-ascii?Q?JSjmSNwYYppwBonE2EQQxrzUfEPTSsDXFtJlkeVOuYXZFlQeZ1IkSZSzziQq?=
 =?us-ascii?Q?VZoXr/RnycAdyFn2owu0rW+My4Eq/JI1B4usuHSPzXm3guVCJkQUIQB+nkhJ?=
 =?us-ascii?Q?QITJrPZXOgSUoYcMNkkvvdfuGMlAbsLFA9S5ckbdgvWpyLlQS3Xo2wiGa94J?=
 =?us-ascii?Q?Qd89zQDtRZgfFZ3LdKnc6Xcf5mVjPLUsGhkB0vWjjSuwNtb80fcLv9hQPffh?=
 =?us-ascii?Q?aQfgWqHDckZASxeWk2gwuAiS2JWJFqwZQegf/FOzLtZs8ViriuKrafKL+Fbc?=
 =?us-ascii?Q?H/NYn4UqTpP4uNvqXxjC06uW0k84jI8q2lk7ueiGs2meetCMoH8SPLXWF0m1?=
 =?us-ascii?Q?K+UeVmJrDYPKTm6P9/TSOJNymckSeZ2OwMYt/PmCs5a4q6JozV/HCO1SX7a/?=
 =?us-ascii?Q?v8r/LVHnY+S7r35/DbZRpWUIPQw9m3MuDJ6jS0ilJEgX4EDsYelivnn4m3ms?=
 =?us-ascii?Q?03rM6a0NmTAujcTp2F/mS0gMrWLz7OgxF8a58M56ZaIpv8gq7yEjDhC14wEk?=
 =?us-ascii?Q?9Xe9MkVQPwMwnyqhZ+bXG7nUJkmGsvonBBlb7Sfzl71uPhZV0n7n65UtNAgm?=
 =?us-ascii?Q?z3J5KFCHHAw89qFXMWXNkikBqeOW47UF/XfEUcZEpa5Qdo5Se3fIvlqN91ja?=
 =?us-ascii?Q?B4b7kAI8aNNFcvjUzLYou8h7FfpKi7u0m2mXTxIL8xHQRyAaLCH0sKfeC7Av?=
 =?us-ascii?Q?BdQkHzqmy8lRXveQ6PR6W9L6aQR8xHtR4wu8io3WY5RzBnq4Vc6x16p38AfX?=
 =?us-ascii?Q?lWN8hJct+xvnB6gVw+KE/Xv2ET04GGE7goA62S9WTyf/Q2rLnUTcuN5GIpxb?=
 =?us-ascii?Q?lYIzq6k6fwo+d9I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:37:31.7260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae3286d-a34e-41c0-8708-08dd76789a8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
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

This patch refactors the SDMA v5.2 queue reset and stop logic to improve
code readability, maintainability, and performance. The key changes include:

1. **Generalized `sdma_v5_2_gfx_stop` Function**:
	- Added an `inst_mask` parameter to allow stopping specific SDMA instances
	  instead of all instances. This is useful for resetting individual queues.

2. **Simplified `sdma_v5_2_reset_queue` Function**:
	- Removed redundant loops and checks by directly using the `ring->me` field
	  to identify the SDMA instance.
	- Reused the `sdma_v5_2_gfx_stop` function to stop the queue, reducing code
	  duplication.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 64 +++++++++++---------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 6f9a5ff7880e..6972f5dd63ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -405,15 +405,15 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
  * sdma_v5_2_gfx_stop - stop the gfx async dma engines
  *
  * @adev: amdgpu_device pointer
- *
+ * @inst_mask: mask of dma engine instances to be disabled
  * Stop the gfx async dma ring buffers.
  */
-static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev)
+static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev,  uint32_t inst_mask)
 {
 	u32 rb_cntl, ib_cntl;
 	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
+	for_each_inst(i, inst_mask) {
 		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
 		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
@@ -504,9 +504,11 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 {
 	u32 f32_cntl;
 	int i;
+	uint32_t inst_mask;
 
+	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	if (!enable) {
-		sdma_v5_2_gfx_stop(adev);
+		sdma_v5_2_gfx_stop(adev, inst_mask);
 		sdma_v5_2_rlc_stop(adev);
 	}
 
@@ -1448,40 +1450,26 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, j, r;
-	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+	int j, r;
+	u32 f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+	u32 inst_id;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
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
-	ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
-	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
-
-	rb_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
-	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+	sdma_v5_2_gfx_stop(adev, 1 << ring->me);
 
 	/*engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
-	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
 	for (j = 0; j < adev->usec_timeout; j++) {
-		freeze = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+		freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 
 		if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
 			break;
@@ -1490,7 +1478,7 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 
 	if (j == adev->usec_timeout) {
-		stat1_reg = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
+		stat1_reg = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_STATUS1_REG));
 		if ((stat1_reg & 0x3FF) != 0x3FF) {
 			DRM_ERROR("cannot soft reset as sdma not idle\n");
 			r = -ETIMEDOUT;
@@ -1498,37 +1486,37 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 		}
 	}
 
-	f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+	f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_F32_CNTL));
 	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_F32_CNTL), f32_cntl);
 
-	cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+	cntl = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_CNTL));
 	cntl = REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
+	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_CNTL), cntl);
 
 	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0 mmGRBM_SOFT_RESET.SOFT_RESET_SDMA0/1 = 1 */
-	preempt = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT));
+	preempt = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT));
 	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), preempt);
+	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT), preempt);
 
 	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i;
+	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id;
 
 
 	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
 
 	udelay(50);
 
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i);
+	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id);
 
 	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
 
 	/* unfreeze and unhalt */
-	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
-	r = sdma_v5_2_gfx_resume_instance(adev, i, true);
+	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
 err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-- 
2.25.1

