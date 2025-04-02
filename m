Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B416EC36018
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 03:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC7410E6AF;
	Wed,  2 Apr 2025 03:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pq6J2PrJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736F410E6AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 03:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dwl2ccE2164k8CrGnltOc4LQ3mc8OOMDbIjn+VhuX9QNgoOC6/EMqknd5hcjdftFsdXTjF8QUo0F7VoWixkPgIfZ3MMLYI1d9/r0f8dHxxLbXm63LDm3H+Qhq/CCSgZ1gM7shPqrepFvj66FlLOm1gLdUpt0zv3XlWrqGkDssAcmwSx9z3hjJFWal+SXGgtaWk9/v6QH+Qs2M94TgoKqtViNHnW+US24GXPppbuBBNNmijkcK20SLVqVvTPSECjh+jerj+N+Z/EmPXQf8MFKMl1bhFUiSyVwQggENcMPoBcluGPB2SHan+Z4h3tnG0nGN3/rU1YZ6ZCt2aYxxLQ+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TicdVB5L0dObWfm3aHGrXizAAkb+AGJjHOAq7YNzZWM=;
 b=gi4yHIrhCp79AgJkxo0UlwRPiX/jD4Ew5d4C1C7UhviDUqfMemIZo9cgtv2PXu/vHw/Zt2P/j0J0eW5Ter6gplMVNtkdBLRglqadDCaP4Gw4O85JsaxaiBvTwByDnL2a4XC2TVm1bVcZRpJd49IQqFhgLfl8TVUSRUu+R08EM4XIBFzpPxZCDEAzxTQRTKJEp3bBhzTzY1TZDFQxRnhmpCTl51IYrc7lMTMCs28Sj6UUEM04Gkj92Qlw+bDtDzv1N97Mdiu/I6tkIMCtEAfykIodVR357sKtYKaRj6d9qMdx6M6d9pfyJzHEcj0p3cjixwbJ7QeFsEowuyN6eLbQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TicdVB5L0dObWfm3aHGrXizAAkb+AGJjHOAq7YNzZWM=;
 b=pq6J2PrJp0vTOsDmEgGXCwATeYzb7BQq12krX8ZbN9yalCSChMD5CanKYt1hRrGXJDq6Qlptb8jy+RmNFsYYXcalTGZXdzZKoOE931cwGrA/9+qk0GwZcaSFBm5Gcq/8PnfhDL3l7YIcIO3j0Wanw0axlsfNWRIv3kD8lRdOPmo=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Wed, 2 Apr
 2025 03:03:10 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::b1) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.52 via Frontend Transport; Wed,
 2 Apr 2025 03:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 03:03:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:03:01 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 1 Apr 2025 22:02:55 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 5/7 V2] drm/amdgpu: Optimize SDMA v5.2 queue reset and stop
 logic
Date: Wed, 2 Apr 2025 11:02:13 +0800
Message-ID: <20250402030215.1074975-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402030215.1074975-1-jesse.zhang@amd.com>
References: <20250402030215.1074975-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fea4c9-fe3f-4c9e-cb6b-08dd7192e570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8AZTdHVu8wC0JeYBXvJeCV46eHbaDQVlyz+DvhBPUzq0Ld/aldd/hvlFLFsN?=
 =?us-ascii?Q?sLdP7HBrradgL+DotePy8jEhoviIZ6syLylbBA/LovV+/BSf6o+8NBQi1uLb?=
 =?us-ascii?Q?dbUoMjxi3soqDv6Km8tdeqASZ/jbpdOlf7JHaN1DhxwtTFlyQf0AuNGpN7Cb?=
 =?us-ascii?Q?4BnQRo3A6VxH7zsEiGKRaaPQtqcjn239FIu4hFEoHV+kijhb6Hy7PD4uL3+y?=
 =?us-ascii?Q?yyIQAWepAmi9TgxW2kfJ0s7W3vqHMinKgPcqDS1RmUzFlW7w3rwq6dTLM4Kx?=
 =?us-ascii?Q?u8IcKL+nni+fsmDY6d0EnjUjmfgqJN8b2h0zS/rG17o5EudYvbF52gVBPXOB?=
 =?us-ascii?Q?Hgwwx9Co/otKbtvXslXw8+f0eEbSIM5qd69KenOBeFA3RC6VpXlt7bTAucfw?=
 =?us-ascii?Q?90iYckaWH78xKS+dZ9TFRRt7MPUyjVYsWoXVqZdpBeYGAW6P0srh+AAkd4OI?=
 =?us-ascii?Q?VXYc5Cq5F+LD0UVBmmppZQUriXw/RXXDIoxpgutZdd4qpL2y+UELuLhdcF+O?=
 =?us-ascii?Q?8MUhaQ5JHF4v67wodoBnvV26IbWbeUrnbtnbYNPxNX86wBUd+pUnMg+phCov?=
 =?us-ascii?Q?8ihy7FK9I4Gx19OcdzavtvWMb2bWSAk/vMG/dqZZhOuM/zqVAhaJ0tSMvNkh?=
 =?us-ascii?Q?GtJZCSCtSLX4dBzVrbo5CezN+wWjHWUn29iGLjEA3KWIdxFFR8ll50s6Qp+l?=
 =?us-ascii?Q?+qvq1qFwAAV9YgUlgFl/cbrdDdW8/mR2+fEA/6WLaHI5KETPORCo+AFuzWbL?=
 =?us-ascii?Q?RB0CHV4gb/dHKd1CEUWosMYefuz+hm5TjBZo4/wIJKD/skcXDxZjIwJlMwa8?=
 =?us-ascii?Q?jXb3Fv9Bomo5YFidAALHXyt8n40xsnNlUMG4DOVmFwXTkJ2lYNgxylq8mKM1?=
 =?us-ascii?Q?aqk+6Rb1QL93WZNFA7ks6436lnyu3mZTYOgs5/k99uXMTAtodGzrg43xEiXm?=
 =?us-ascii?Q?fj3bzbZQFcwkvGYF5UCIrVAOTrTYPzuZMN//lmGh4Nh14h/R0YM8/pPv6ta5?=
 =?us-ascii?Q?ceZlChvZByuNm05Pkb5xk1Ow29HwPtAIdekvGzZyKZCIQnpKL2OBZKmWzdQQ?=
 =?us-ascii?Q?NVMseCZXp7Z57xoGMX2zhvmIKWBaORVCzsaCpEQlUO4+8+aetWRvANHc1A9Q?=
 =?us-ascii?Q?mNU/5m+5rEpYmQMFqU+AZHuVBgvEQJL4TvzXD/bJuiuxuafJvSeJbmZM/u1D?=
 =?us-ascii?Q?OSN9oNKVCgUL3+ogKBs0GM9bv2pfzArwmRKzNkyGoD7lQGkeShKXBvNx+5D0?=
 =?us-ascii?Q?YFATSGZcSN+hmNpHAIT15qYtSa3jgNSW6YwOb8cvH4lZ7gW9j9ZKrBpl3TGd?=
 =?us-ascii?Q?mOdgclhWhKwtUiCOyXBpcR0HrTaLNLoFFQPsVy9flMfj10dqhfayzwGWM7Rr?=
 =?us-ascii?Q?+F6uE3iVRmYGBHD9LKrWOJnLUVbJTTCZTExzo2clBsoV20elanoc2CwxWthQ?=
 =?us-ascii?Q?kyVDCAm+R6FkHRR2XHCyTapMAHCWjtG9Z//nLiPbQNnxkAV8yo5SGkVexnrw?=
 =?us-ascii?Q?ftjawudO77XF7rppnO3K1DHtwl6A4VhrPFyp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 03:03:08.3610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fea4c9-fe3f-4c9e-cb6b-08dd7192e570
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
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
index 964f12afac9e..96b02c3e4993 100644
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
 
@@ -1437,40 +1439,26 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -1479,7 +1467,7 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 
 	if (j == adev->usec_timeout) {
-		stat1_reg = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
+		stat1_reg = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_STATUS1_REG));
 		if ((stat1_reg & 0x3FF) != 0x3FF) {
 			DRM_ERROR("cannot soft reset as sdma not idle\n");
 			r = -ETIMEDOUT;
@@ -1487,37 +1475,37 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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

