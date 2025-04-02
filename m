Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45259C36014
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 09:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F9E10E723;
	Wed,  2 Apr 2025 09:14:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LwMfNJ+I";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6246210E723
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 09:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkcGdAkxLEu31AzZOjnyDTZILtlSbtqjGzD0JdasxRRFfu7CdnTIQV/EIySb4AqadKEm4y/i0UvvFUiH9jbypZQqeDzrUnR3XA3OHIz7XrzxlvGlYjnpFAXLjk4bG3rg5BoPglY4LX0W2wwlJMXJaY1M3FzjptZffJXAv4CGmo024kSELMs5DK1d6+SiGFBxIbtADeJLd+Nk8Q3lDpl7AZC0IAp4Ewh6WAqzJtw/NgyNLNjwj+KR12TntRuyIjcDZig/uN7+Sg8lKWFpye5kKOE/Z6TKG1AyqhGh/+yn/AVlUtGrMWKtYHhR87yGTBJZ2E7EkKdSRJ2ax1uEQ8L8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TicdVB5L0dObWfm3aHGrXizAAkb+AGJjHOAq7YNzZWM=;
 b=VDcP44+c5ITQG4H/Z7mAIVVeaoXziNe4zwTAR5K5JGbDlmwNAj4vqls1+jWxEvpYDK7oF4bOq7UCWHte4i823wGiw9mR8d6hEAScJ8CX1zD5B5Md+VeI+NedHDWLOliB8HalppAPOKkX7OrXX8EDaXfnAMC8ERYprKMc1Y7mMumGCHr9JN+DQzv4EKVwIiCbrasekOUeM1wb72lWhGmqVNM/4nTDORgoZGE2AknDyohVmbdsXC9r3z112LXr8KWMXVgeHtP6VDY7WbaXaDO1OUdSbPAjYUQoXtOMUwSv/nwdRLkYbz6kjsRoyRDR3sSNDqVKBQ5t8GMcUAqt9Q9bUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TicdVB5L0dObWfm3aHGrXizAAkb+AGJjHOAq7YNzZWM=;
 b=LwMfNJ+Ipjs5Vmstg9GgdHNv+x8Ce0b60b78UdRLkVmfqHyvgiFw5dpbcpae3+XNziP2dPYtCnMrrDyVN34gQHNLtKahFu0r/KgWJ52mVhiridJD4jyhnK+0VT291o9Vbz/p2bajKryUEuPu5iZYI7AOpDp71OW9/r7dt78Mwrk=
Received: from CH0PR03CA0392.namprd03.prod.outlook.com (2603:10b6:610:11b::31)
 by CH1PPFF9270C127.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 09:14:48 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::64) by CH0PR03CA0392.outlook.office365.com
 (2603:10b6:610:11b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 09:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 09:14:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:14:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:14:46 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 2 Apr 2025 04:14:39 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [v3 5/7] drm/amdgpu: Optimize SDMA v5.2 queue reset and stop logic
Date: Wed, 2 Apr 2025 17:14:04 +0800
Message-ID: <20250402091406.1641643-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402091406.1641643-1-jesse.zhang@amd.com>
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 849302cc-5c89-441a-2f89-08dd71c6d10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y72dwszEI5cwZ1lJKdabiluV0uKo9WahBUvT48yrxu46MC/gOGeV3l3T4Y4J?=
 =?us-ascii?Q?SnLkirjVKjfwwswRgigPNrAZ5FxIQ1WehmdzdTDKbI85HHp10Z0In54t/fnn?=
 =?us-ascii?Q?ttfBJMr4GuWSzyehVzjdbCWNO7W74rcQ1Joh6J6MlpUTfqcivT45mpZfJWGe?=
 =?us-ascii?Q?IiMkgjv/eRb9AtT/FBwWVvslRogYmeQO+mQWryY7IZFONFTr/QC3CTA7Aanq?=
 =?us-ascii?Q?mkifKwhdx6s3hsZ973wcXN5AW9DP2YUN6HuTDGA0sDSW5LpUWpg+4WP6D7EI?=
 =?us-ascii?Q?qKoJVbRPQJrZCDbvhgHg1swAjW89JEsvq4KyIhTxYsYWVlDbhZsRp+02Yxp9?=
 =?us-ascii?Q?xqACLI5zVIZTq6224SToQoLw6BD/6v+m6aRLjG0AXSRkdeTXm3SJJmHq9ZL2?=
 =?us-ascii?Q?t1jUxdxyD03fLE6r/Qgm937q5RL1KalSo1VbYlzeKT6HCPl++3fTCKW6iAVO?=
 =?us-ascii?Q?tYifzQUHpOVeAD/IIUgkPQwxSp38gUdxoBuXBj/NvUmM2hYoYRs0q+mtEYto?=
 =?us-ascii?Q?V0yXrUhKGfSTE8qraTmanHVDzb/Lnj9qSkuey0WkpeGxNlmuNbFojrMRBOTh?=
 =?us-ascii?Q?F0xznDezIWKqszKw5ACEHy2iLq8LAazYKnbi2wZds6tEZcn4tPIbTheTZVGf?=
 =?us-ascii?Q?HYn0iVOuW2acZ+QnDzKHqtfuLaw7uw1Xy7MDTSgXPxiE0A/sHMJtsfhSlLn7?=
 =?us-ascii?Q?NZCelRvPyt31tkNlastJ+9aArpjmbxVrt1eZPpGkKd5s7sRCm/U5BTp25384?=
 =?us-ascii?Q?NOfGBvBHDsVEL8GrGAd7Hk0+TRUSJWZsYgZT3BA8o6aVKgi0pjfu54r/K+81?=
 =?us-ascii?Q?+awG+YQlYcmtPTpw20XB3lKhJb0SlFKdyefo7DFrO70+NinPqDnaBlZ4Vwbx?=
 =?us-ascii?Q?wA5YgT/iu6JYAmajnbkvmpe2iY/Ft9oRV99TYcrkSZof/enUC60/Yl4EWT+b?=
 =?us-ascii?Q?lVpAM6WU9cLpWXkefu/ZpkikCX62Bg5IjTILHvlNs/kFsVtig9h6gf0v2TmH?=
 =?us-ascii?Q?BWoQDAa+e5LEVeX+gBjiusdqlqmUqKBk8K5r8+Fo+ctx+cYKvj/62/bq4MyR?=
 =?us-ascii?Q?kVLREPVlEyiG7luENp9O4W5qRVUs8Buuy/JrkU7CetdGtzLp/WOKXzw8C8BD?=
 =?us-ascii?Q?iV0c4FhYcizfrY3Oz7ZP1QcMFNw/i1u2J5rIo5z8LYbok/3E9WnUD+RaftW1?=
 =?us-ascii?Q?vkUzuRZTDVuq2ux1u6BcK3KZvJKx2SHiz+xuEwj9cGn0RbO3d/2TQwNtJwhg?=
 =?us-ascii?Q?LqFoXeX4idvCzECnqoxKMUNCp6hSOsMiP6Meuj+3UZj8t/v+3w6LNbWFdNpR?=
 =?us-ascii?Q?fPXazwona1K3cEjfrDM+8s7z0n5pjlBoQSunO5xaVPh7tjgJrrb9gPV9T+3P?=
 =?us-ascii?Q?mG0d/ijQf2pI2Q7OEzd1+ghhcurkFrQJrpcVeJcVD4XIpxok7IZI/rZ0oNcp?=
 =?us-ascii?Q?KEIo40GvsSJc0LumlTCSq/G9UOyMIeZjeHO4LFyA5bzj8Wx/yhoaLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:14:48.0553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 849302cc-5c89-441a-2f89-08dd71c6d10c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127
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

