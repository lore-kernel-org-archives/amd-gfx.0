Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1B8C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A017310E73E;
	Wed, 12 Mar 2025 08:00:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4CqDJ0IB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1EB10E738
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZri9iQbVrKh60tpVXUJdah7P/PG/WsrhdPvEdzJ0Lw2A9WUtQUD+E8CJytFwgM2jsrP7eVUi9gX45hLLtvjuh+8eBphmJEd/aqhUTCFIvQoZrhhLgEZG0GM1In60ZV3Zv+MqFU7lpzaIzC0h7sSqmBgJEHGwqAiAH2qu9DRU8EJ081EUUdFhC3W/fnbV/4aEnNw7hW6iZ+wt32qK2sFGL+k7TxD2ko6AHE9l88w6303LUOjnqUW2lHEw9CadM7+3XShke4VBOLvsmCnh4Pi7CcZs0qZnHrTbfMyP62ZH1lLD7+AWZwupxYoaC/v/htVQNKynY+mXG7gPIk2DWWD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C4LtN9dlV6hQGhRDmwEoSj2TAK3tY3kEkr72KwDBWE=;
 b=DXkfWm8NSxWf8czklSQblWeyAWGWKkIXj1z5YEMMEE089DjiasQFHK0RdyrhTWm16o/AlJa+bsH2LgEnKqXBd4WF2IlkJv7lVAvbX7x9d8UIzamWfA8JrXXH7iGQe9D/dBy0XxFElefk06EV96W1gjIuBj27IlPLI9K10plHdVQ22fTBmBHrY9deT7CVy9+dc2MapkjHMPO3y1oQQgZ0OvE+B2eMDHLe5LnVFh48JeJCM0hn5UDms+aqJ8bow+zG2r2k0jzJIOqB80JvDdX0SkVheupqA/a2tAB25etGROsGnMtPDnurRRBsfrwGQ1ivPC3bZnXeuvk9SBHD/QSrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C4LtN9dlV6hQGhRDmwEoSj2TAK3tY3kEkr72KwDBWE=;
 b=4CqDJ0IBnDiR8ItsYcft0sKaU94O/NTwFW9SGssIMT54uWTh1vKjUxw+s/s+Kz8l/pKWTU4cbTX5oNTsInxxlFpBg4y7Npp7xPKM297ZahDHhCXOVd6Fs/tWYAlW5fvlDwB71yZ6kIA7cw4kGQQJRZAyo7H58zwW/7YVC0KoocA=
Received: from SA0PR11CA0167.namprd11.prod.outlook.com (2603:10b6:806:1bb::22)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 08:00:51 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::25) by SA0PR11CA0167.outlook.office365.com
 (2603:10b6:806:1bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Wed,
 12 Mar 2025 08:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 08:00:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:49 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Mar 2025 03:00:43 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: Optimize SDMA v5.2 queue reset and stop logic
Date: Wed, 12 Mar 2025 16:00:01 +0800
Message-ID: <20250312080003.3224976-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312080003.3224976-1-jesse.zhang@amd.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b8eec5-c398-4591-6e15-08dd613c0197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e288heL2g5jPXjR2qjcqoLAVZrBYyyq/KN48h/0KNVnPesJ6CTNZVemv86Ur?=
 =?us-ascii?Q?rxkPliRutP4o7Cq7cXTGlMxSGtH6V3jHPqbQK3vixf1gd2jePKAsuVccP7bt?=
 =?us-ascii?Q?bYgcAfbQibmQkKGWekeHEqbH1SaMDn//5wlL5Fc66ioQRJVB4pSMrOay0QEU?=
 =?us-ascii?Q?aY+nAhODhxCp72HaXvg55Hzb1gXugnl7DRIgdKkmpYlZdh053h7XqGmsOi9Y?=
 =?us-ascii?Q?3t6oqswybehhyEcOBZcyEWJGq+OiJyn40WWEBx53j3sgGSEJiSLR9CXVo9es?=
 =?us-ascii?Q?IEN5sA78UghOaSphSYq+oDW9TUF99nG56Cm8113aLLpQRzEC5YOl39BKMlzt?=
 =?us-ascii?Q?16Uwd5+K9BlaS3Ahss9UEtmgQ2rXHDxfz8PPQM16HaESTL7OORc6r8KGMkvR?=
 =?us-ascii?Q?y3qLRBdjnPqLG729ho8Grz8/ULCKIVl82t8u4Ojwh9FSQXaIC7TPrAK2CFzY?=
 =?us-ascii?Q?V1SJ2Yk1ONg3bMbInqoo87BtCiRdVVnLZo8Qnp+T0pRsJBFPxqZrJ2uoKKBM?=
 =?us-ascii?Q?GoSW4B1YddyJQC8hR4DvafrVuOLhFN4QdNbgvYhZORh+Mbs9Wbi3dxVgmp1t?=
 =?us-ascii?Q?nLDvzySHMUU+wl1Pc2PdL9Zsm+qsLz3Idtf4UHK8xrfzDv6g04Ln6/gHIDFp?=
 =?us-ascii?Q?ilkhlKqrfmrzsGyOpP2waWCcxyx5GEOPZVV6KCWvWXvsMtVqeIf+gXDN/aUX?=
 =?us-ascii?Q?xx9N8bpfyfbbaAyOR9ZpmYlsZkqdDiaMkm8jh9hYJucSOHd7eHph2PkdZHqw?=
 =?us-ascii?Q?Fe/NRL97UAUh28OGueMDAAcPhLeZxAMAsBAB29eISKMIJYtl1Boi+Q8oi0rd?=
 =?us-ascii?Q?lRywb+5ZXGnmbzkOrlilnStbK1OUrTnAsGSQPp4cnXe6MfnVTb9tatZ0D6hB?=
 =?us-ascii?Q?d20HhW6vYNsNzxnHU9KIHfQnZsEHGgAu704og+2wqYLrJQqqqgvjH1PfQnc3?=
 =?us-ascii?Q?bTQ5AhSAZDy21WYvoevApVkm/olsL78JY2p5foy/Gc7TzbqeXaaBqTz0nEzw?=
 =?us-ascii?Q?khYsRmggtiBjzjXP0XaaiAkSDQpOa9Jl+WINTODbQlZ4GGjnbs1/FrEBJQVE?=
 =?us-ascii?Q?5DMovY3WPp4f8bGodnA94h4ZXmycSHfyVwEQgObrEkekr0+s8DoRlKDuSu4P?=
 =?us-ascii?Q?u9Fsp4xwcKqexVpxGEAaU0Q3gjOLfFofq2SJ49tjcF1ZnL8uA7gmfWtRYBOW?=
 =?us-ascii?Q?W9S+NK+f045RMtu+8R1W7dALDprP3+8ac/DsejfWZ3kIDgj3G2Nh+sdQDywh?=
 =?us-ascii?Q?5vGuNVuRS9FWJsHr194EwXDXDErdztZ9XEZXi1Sn2iQemyJi2eeZX/H9aWhO?=
 =?us-ascii?Q?mWTBj3NUmrcWA2/6L32BjeoaW/mJ+N7TXZyeW5C5VJvwzPjjVFZ262TCsHvS?=
 =?us-ascii?Q?5plFAyAqf3hdeCFH7ywaDH1e4fNhBMtbP7bumhqjWVwAe5pyKO+WZ2k2JTku?=
 =?us-ascii?Q?j/kbRkFZoXO7C9xdC8tZTrIpm5CiGuShnuhQgjFd3TrCqQMf7zeLaFJWu/G0?=
 =?us-ascii?Q?QSNasUoWo5+WKgM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:00:50.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b8eec5-c398-4591-6e15-08dd613c0197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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
index 2b39a03ff0c1..267110725b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -407,15 +407,15 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
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
@@ -506,9 +506,11 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
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
 
@@ -1472,40 +1474,26 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -1514,7 +1502,7 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 
 	if (j == adev->usec_timeout) {
-		stat1_reg = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
+		stat1_reg = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_STATUS1_REG));
 		if ((stat1_reg & 0x3FF) != 0x3FF) {
 			DRM_ERROR("cannot soft reset as sdma not idle\n");
 			r = -ETIMEDOUT;
@@ -1522,37 +1510,37 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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

