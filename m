Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46586C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 09:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDB310E720;
	Wed,  2 Apr 2025 09:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uzo7qUw7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D9F10E720
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 09:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CK0pnE7D/GIKT8gM9UO8w3Jms9/XV6rIPvP0miGxPXtHNnIDZCJNeRAnDkIRUrF9gjOTSjpdhPS/yhshPrgVIwc+Y0hv2zeO+zVGpyeK38SMk4oDvCoRFMQPdIEV6FzgWTRlMvGR9Smn9bT1bwPTfHdPqY6lmE+CzU4GyiFj329evKJ55gX0LPOeXknINF1aNTSWsseKb9/ZWQ2mZuse2G8Z82nyga7wh7TyOjLDSlqDhPZzLub6fLvcKB+AzZwNExW0lbjjGrW9Cjugn771tMG16iUtUZCd3Z1f++XACfTrOnksdU0Wi0vnXHMuOkVW2qyzIdQgk+s7zFHmjijc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33zxrB2kQJ1dW1RDGGheyOG6h8vlUU1AtEKjjRLPHws=;
 b=RgNnqQuRRmvNuUTU8UqsEt5FRF+CIbL15x0O3HO3wf3eXRVt/iIx9yOXkF45odL2S7fBvgvTUZXcxawXfizDLoIIC2A8SoRGpiq+WdpJ5/Ojn7Jgwo0zFJNyQNdi4hCh0Rr+00yPs+eF0cXiLU5rK14YgGIsA55gB8V7Uk89pCtutiAnm7uakFMwVinWLVxyESbeuYDD9lzAayUuTWskD8VrB2l7Bw5M0Fkzz5sGbRdhEq7L1ay9Y+eEUVWmAC1Be6Gbxvc5QplvvBvoBOdEugld/K57WSbmuNjAfMLEyL5l/TPzWzqGk9qWvDso/4/W3x7lybRVQ8GMzFFO+vm1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33zxrB2kQJ1dW1RDGGheyOG6h8vlUU1AtEKjjRLPHws=;
 b=Uzo7qUw7SYgH2zonVs0ZVg4wBnu1Al/wd2BtPlVl0JwVW6ofbyFI0j8BP0PVA0Iqb7UlvQIqe7nfRfv7Xeu3EWr7rRzDW2t1M3xbjwcr7W0omOkbPO9SGEcIF5RC9z0kGmn9g81mDvYr+aHJhqbmCJ802igGQmX0XJnBlQIPl2A=
Received: from PH7PR17CA0016.namprd17.prod.outlook.com (2603:10b6:510:324::19)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 09:14:36 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::5c) by PH7PR17CA0016.outlook.office365.com
 (2603:10b6:510:324::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 09:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 09:14:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:14:32 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 2 Apr 2025 04:14:25 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [v3 3/7] drm/amdgpu: Optimize SDMA v5.0 queue reset and stop logic
Date: Wed, 2 Apr 2025 17:14:02 +0800
Message-ID: <20250402091406.1641643-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402091406.1641643-1-jesse.zhang@amd.com>
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be87fc9-5a9d-4a56-66d0-08dd71c6c971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eBWk3rnsq4dCmHqSh2QS1d0Pl1ycB/zi0/45ZedqbKqble43zQ30wphRsDpf?=
 =?us-ascii?Q?1Lh/SRFi+5Oxr7ZSbkeGbNN7SDXhGDtNyMD5x9Lp8deroH81TJz7k0BpjDH5?=
 =?us-ascii?Q?ReBFYArrbz21xhDQWJyefE7T+bbR8lZ0JhUFD/Wsa92ymDa7EasUMWaggPDO?=
 =?us-ascii?Q?bnnh/4Lw4J7DtYNoYq0c9hfgPV3vQl/gMRz0HVb4IuLftERKVSKaCYQZ8yN7?=
 =?us-ascii?Q?+lyinOFBFVxISXpNe2nBM29Y4z+LWH09HMzXcEy/bMWEjCxkln0nT/hwYVqd?=
 =?us-ascii?Q?jb9ysEAyJQ9e9wJR681nESogaboa1zbL9aeYUA61epodhJDdUsyl2Uz3OcB/?=
 =?us-ascii?Q?IWWD6t2jvxqNT3rnb4nIExMVksA+b1NW56Xc08rg3GuUpWb0ZVmT1HVuefNT?=
 =?us-ascii?Q?YvmYZshrOMRCq4uwhTuz9Qzi5pjhriWiXy/ozKiUabWx2EFn4x8l5zf8CnKA?=
 =?us-ascii?Q?BAIbj+7lobnTYEsRPAldTNDEtuzpW90XqZN1TJRuwa/mDFKlj/gIGz6v4xah?=
 =?us-ascii?Q?opAFdkpym/13nBRk+GxhwhkGy5EzejjI9U61ev7rWFVNOjf1GQtCZqhJ36QQ?=
 =?us-ascii?Q?g4bEl64wjC2W3RJNubWkbRsfcxMcg39Db5Trw3BFJuWQPRM5Palj2JU2p5An?=
 =?us-ascii?Q?GRO1ADOQPOT8Bwxz0YijOXJHIQGMGm9VTcujMYzzxLeEBNciPT87z9+BIWXe?=
 =?us-ascii?Q?WIG9Yxl27k2GWp2DBN0Ldhwt2TjR2buaZ+6oE3COYvvo+aULl0Aln2DrJBof?=
 =?us-ascii?Q?aOt+06R22Fi3NMTTcdncqwE4DaInCnrYpdZ8pfgxRJlljSalpfqsAcWA5qCN?=
 =?us-ascii?Q?cckoJulGmxpyz7DDadNWh7dJgO2WmPhJEjt/w8CWciuwyZnFyG9rdr5BzqIn?=
 =?us-ascii?Q?7OtUHFvYzBDoeCyV82CnYVSdiY0oVDJWSN7g+g9vvM0J5j8RL44mO4q8HqZO?=
 =?us-ascii?Q?4XbtvgRso9KXu4cszwIg7IM5/HJATqP+kQABLpx2xkvrQ1qTz+gbyuaGDhSn?=
 =?us-ascii?Q?h0HCHpnrH6V6JhCDEcQUnJ2vzZBM7zepX8vGn3RzDKhojIwQs4mvhNIWnJFd?=
 =?us-ascii?Q?YYT8igVR4osRg+8dS4jWsgIC3XGICo5XO6ExQWtC3FmW5H3s7ooKmmhLir/s?=
 =?us-ascii?Q?PbV3hMS7jhj8pWjDMaaptCzIv8M9TEJ2h7uk0w32RQXgYIg8UBrTEq5Rbdx5?=
 =?us-ascii?Q?khHOjolhCwJddtzvcIZ451V9Xz4ZNKamy53lPwKNi7RDGPstBlyRGK6YuaPi?=
 =?us-ascii?Q?6oWghD788GlYrbcm7VoUMWAl7tlfzKEslP4K+nZg4BNnP8EoauptZMusQS6q?=
 =?us-ascii?Q?6ssxCnfG1K170OcrYlwyT/WoSUYq7S5/9xJtapgED94LIKXJw9owDywo9vR6?=
 =?us-ascii?Q?btvXw08M5HSOltVY/5psc45MwEdEAGEx3xA8Q5VWbVzkBeyNcFzXoSNTaw/M?=
 =?us-ascii?Q?s1sLovxcXsPhsCw1ZCUe8cD0Memw5ALXZctttluuOGRLR1GuqzJfBQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:14:35.2031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be87fc9-5a9d-4a56-66d0-08dd71c6c971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

