Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F85C28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39C910E734;
	Wed, 12 Mar 2025 08:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FSc30RWp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5632310E734
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzChYynQYm+7fACABawufOuI5gaAVO/vZJXhCJ+AX5kyBC56e9ftUNRMC6m0QK18Fg29r1kRo5WQTgqzu7fiwGOSaaLVKv2wxLYWypRNlqM/GgBPxwAasuJmwhS28PFLERHnJ/jQfiaMujQIgFB5HqwOV8EJmAIvEGBR3rkWi+Xl0G1xzmj+iU0+5VwdAYw/cevjhuOs6ixGehl7eenpZrN3M8TLSiXhU00NboB+u7Kh8alz795669EpDOqBM4Ay493eFvpp9YF1ae/rU+e746gGgsXM3BG7zwGfxSfvU6ayzbvdHxWBrNjJNhoUlr0arUyvzIqmCZj4yNv6wV0NgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcuLJzxBdIjbY6W6ECSJi+/JOGOjcvPVDcskSEaERT0=;
 b=Bqy7ovvlfg90mFmtULfY4gJrLllJRt84ThTO6FvQp/EBwQAXTllcuTc7nOQWpWswrPt6BfHp6qqxTFnFGmWQFtIZGDSyb8TsVIOkEDJPUaddX9ey1OX9zQ5wAGfQS9sCZs5me76ZPzFRej5UqVekYM4f5TfQ4/TMFSXJCqU+eIei7wNNkt8Vpe08vaTUfw6hcMZcFP+EHmEn8NbM0dEy7aApUFhR7uAlXJ9E2T1TKx2bWikFQ1oWTTWkdAIOc/N3cTMJSknF+Vc7rp9gqcw1wlwRXYKjkOkBaBt2vHQ00ISd+Z74Wml/rJNUNGAgKakABWcGVzSAuCtpkhHQqf7aEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcuLJzxBdIjbY6W6ECSJi+/JOGOjcvPVDcskSEaERT0=;
 b=FSc30RWpAdcyiUhp3tnNraccg6/wTmNowzdA0fDAGPNz+jaY0uNs0MP3Rv/kQz5CrFveNMNmLGQttDs6OotDYPgjpHE8q+jpJxJMLi4b9xofEyUiGmC7L1pnaJ33AEv0mH+9gyaLjsrLl7JhgwjUPC2JMrbITXtnYeE+aWKKNO8=
Received: from SA9P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::15)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:00:38 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::4c) by SA9P221CA0010.outlook.office365.com
 (2603:10b6:806:25::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 08:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 08:00:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:35 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Mar 2025 03:00:28 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: Optimize SDMA v5.0 queue reset and stop logic
Date: Wed, 12 Mar 2025 15:59:59 +0800
Message-ID: <20250312080003.3224976-3-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312080003.3224976-1-jesse.zhang@amd.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 5509c38e-3220-49cc-ac3f-08dd613bf99e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HcMIBJNlWlGZTezps6Eua5FM6VkbbsGTuDTWsff/Exsp7yzHDLcfa7Wx8eoX?=
 =?us-ascii?Q?lOjQlZwxn1hT4YiF+QkkstuWDoLTNlNxQoJTix2ezM3g+TBOdQIUthud3uk4?=
 =?us-ascii?Q?KwI7KRcRC7K7T9M8eBgM+TH9hR/QodLE4CwlZathHJ8tUiVXaDmegoJ8UjCF?=
 =?us-ascii?Q?QE2fJgs+9CjOcdiVfEdcBoUiD2WR8DzXRGBRbnIYJSPsfHbU9abwBv3CLnsf?=
 =?us-ascii?Q?ji6Hy9BhOHhGLeAdCnXRSNuvTUKJLtzaUZY8L9wqE029Q3KRnQpLCRA3Jjxd?=
 =?us-ascii?Q?59J0Ftqrfy+2rne/YD+OkTW7q+3xlJiRZtWcN4Gy3cWC6i5XjfgZJCQbjQ1M?=
 =?us-ascii?Q?xIOzhdPUTlH/ipA2S4MQtkvc2E6kfwOxfi7l2xO5A1i+fRKj33XJDJyrX03Y?=
 =?us-ascii?Q?SGAMZY4YJ9USOyXoQ30udCRmxxBecEy3reE0ZFOETZoUWzMd7YkJiWBZafsZ?=
 =?us-ascii?Q?c3Zd9zptXp18OLSov+K/XgGIb894Po3vVUnOEiK+SWVwysnwDUk5yEzFE+pk?=
 =?us-ascii?Q?W8MCv2/C7SM0Yzfq7an5xG7rs03GQI0RJkOfdm3mkbv/KaTg5HtyE1UnjVbx?=
 =?us-ascii?Q?pcN6OL/r/ACAAYDFKkO4TKsLeKqf2IvuyX3VEcfAg5KCy740a3f1viQ80/9J?=
 =?us-ascii?Q?n4+YR+qMYH6sQEMQOOt0jW7MWRKOCbGjoOIVKMwksZr6oa07nbi/xh034AUG?=
 =?us-ascii?Q?hlOWhiymvTI32+onzwbzpaF1eJsqCxOAfIexvJdzgcEqsd+uojYFYT/YXI3p?=
 =?us-ascii?Q?d3grR85c3jj74OFi9SPIYk/HlOve7bWEhl2EvD04ywqFAVhrF121LfL+8MnZ?=
 =?us-ascii?Q?uqZj3Av2HlsnrHTkeXPVJyMigy7rxzlUT10LuKFNFfu7xCebSfBwP3Rf8dm2?=
 =?us-ascii?Q?uqVuUKrCld00T3BAFB0CK0bsd6W6m6TxFWYkz2Wek3KlGZ+VZiVYjzPVfObe?=
 =?us-ascii?Q?prFP74VN8gB5TThLtvUIfYYxQjGR+ncMT1y8XJTrTKgElh6fn4hX5Y3Slx3C?=
 =?us-ascii?Q?K8dLgm1qap8+Zzl/o9KmT9d2b9wP+bA26Uf4hGCRS5XiSd84u4Mq8sxMGCI5?=
 =?us-ascii?Q?oZeGp2ZETQgpXKp4JdFqnFnCy48uHxpiKNOzwVvFde6NErVsuxKHda+VGw5w?=
 =?us-ascii?Q?YLzdo/QvI1xcyvobQaE8qWeFFFpjz2zi7e+kB8mPju3Um1844zB5JWa6a/Lz?=
 =?us-ascii?Q?I5PLGrcqOZ9sEtrT8vhc4HmKIuZVFBX5m8yaaUL4Qh73oykNM0gdAHLwcKTB?=
 =?us-ascii?Q?/496oXLNXvjzcPqrOZqxTQXoczLlSdmOWDqXIfOzTAVWzIeTPZQDL14Jtsjv?=
 =?us-ascii?Q?kb58PsMSagXSgOvqmI4msAS57hNhbRj7NHkvZr80FIMLYwDbC3Gt2VmsEA4H?=
 =?us-ascii?Q?7E4Oq8YIYgrNd6Kjl60m/CaVYI6FX6MIEd3rWT500lB2Az0+Iq6v6U+/wDWZ?=
 =?us-ascii?Q?dkVV/M54GNr5T+UpvCRzzyr3BvsqcG0+ZEHbOKE4+FYSsAGYgzysYF9lNyqT?=
 =?us-ascii?Q?NCrDrRHDmdoQZN8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:00:37.4431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5509c38e-3220-49cc-ac3f-08dd613bf99e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
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
index 0dce59f4f6e2..387a626936b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -588,15 +588,15 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
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
@@ -688,9 +688,11 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
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
 
@@ -1572,40 +1574,25 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
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
@@ -1613,7 +1600,7 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	/* check sdma copy engine all idle if frozen not received*/
 	if (j == adev->usec_timeout) {
-		stat1_reg = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
+		stat1_reg = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_STATUS1_REG));
 		if ((stat1_reg & 0x3FF) != 0x3FF) {
 			DRM_ERROR("cannot soft reset as sdma not idle\n");
 			r = -ETIMEDOUT;
@@ -1621,35 +1608,35 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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

