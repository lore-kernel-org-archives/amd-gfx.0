Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58128C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 08:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBAE410EB30;
	Fri, 11 Apr 2025 08:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M5tDqK4z";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6DB10EB30
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUiu9fcwi3jUkXd+ENKI42bnjertwiAZIeLXK2GmIOtw6vzZg0bKMODrtyVjRiyqfCGuqV1BwTr8VZ7PTJdJ/7dp80PPzSHkPnfSjS8aJbFDuZGICykG5mHTF9uJeAJDnFi/zu5CAwDnua/L3TYtXijvdq4VeQ8gPzP4FK9UnZzPpfJq5fkfu/yOKDtsTEN2Rx9z8+BrX8tPBI7eom0dhB2MRfomVIf5x/3rXo8/sl6cEuPZqLi9W7deSLb8pRjyaW9bpOriuFiun3iE9mXm7t01wH2xNpwG5rjVT6KALDvyKlBk4CgNB2X5l/o5RwG0lVeCk1JpCerXJGPLzPlRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpBdIyXy8YKUUHBOzBrv6xAWiIR9eP9HE+f+lAPidT4=;
 b=dLuKpa7jaUz2Bc9N5dz1uz3fS3Jaf0Jl/mYWQGo2f0j1nlHNGe/kYhtV2NJf3oFrjt8BTz4qWypKB7syWv2nUqdrApMfg9nJUfH7Mq3TJmlWDDBlzg3zeZk7T2fdEliVRi4PTDcQEO4J6Ba+opdv1xCfJYySIxM4p2bctw7w+YNPeV8D8TLIUZ0hpnM/ydmz0TD43DeMNwLj7Zg5lT7Y6qbPAQzujFZ/cm07RURGw7vMwZoRZTCxLc0rKv+enlI4j15/4SrfyEDqDnRefDxry/TqtDLUs3WLK8y58YgaliOak5gY0yPi1VggyoaivLlYCnN2aXY6wgJKGnyqKnqYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpBdIyXy8YKUUHBOzBrv6xAWiIR9eP9HE+f+lAPidT4=;
 b=M5tDqK4zm7WXMrgfSBar0SKL+qOSxJB4PuDEKny8qTad20fkc6YbxuMzNf/O3Xi7Y87rRX0audG0IhqmRnHBJLAJ9P8Hs4MbV8ZL3o9uajBSvzevHv8CRM25C3YPWG+2j+yTMa71KnE5qYiKBL3zbx5zYeAAN6eS9Apx9xLVivk=
Received: from SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::14)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 11 Apr
 2025 08:30:12 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::5d) by SJ0P220CA0010.outlook.office365.com
 (2603:10b6:a03:41b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 08:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 08:30:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 03:30:10 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 11 Apr 2025 03:29:59 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [v5 4/6] drm/amdgpu: optimize queue reset and stop logic
Date: Fri, 11 Apr 2025 16:29:19 +0800
Message-ID: <20250411082921.3228498-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250411082921.3228498-1-jesse.zhang@amd.com>
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 66905a73-5320-41a4-048e-08dd78d313be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1ukdQxUSZQZzEBLVdDxOI6vnxScoI7VNCbURl5JP0pszcspycT4KTRW1mCWr?=
 =?us-ascii?Q?NQCCOEUvyicDhnClmPH748NshZLxUoLPvkokLey7EVEPcTyNXDKOzxXy9zWD?=
 =?us-ascii?Q?XnyJtTMSdZbrwJcu8uj+KjQZaxGEMr2goUH/FJFyrEk2lXgtZXLOUWc8kNDY?=
 =?us-ascii?Q?3B+VkLVwYYpFiLDzPTTmjgpxBHohCJKxyYS16aI9srXCofeUkJ0Dx3I/BNwj?=
 =?us-ascii?Q?rRY6VDw+zyyq9xTQX3ZKYckAEelY7RAXAyidb07fk4F7s+Y4TrxOs4aFk26i?=
 =?us-ascii?Q?9dsJgoYv+nt1hUlK0cBC75uId6FswoXMxhPr7n+G1/QyzYUYpkBn0BS+mnQ1?=
 =?us-ascii?Q?aV0w9jAw6pjTchpquYUEarbN+HtjwCbpUzeXn95Aglw45yFt3r4GNMtT/a1I?=
 =?us-ascii?Q?66fliELPGKwgo02Fer2I80/5U4shy7GHPaqTBcEoedyCZfY3oblHjCdtX9H7?=
 =?us-ascii?Q?IGyrmelCpvNgBkx2uwhTc1DMqdO0O4ndryLKQNh94Z+EvmARYiMH1dGraVaF?=
 =?us-ascii?Q?ceUp+axs06PhN951j9tcQ6VftKF7qSm+FHTEeV3lQFXF9pfrJq034QiFMQGD?=
 =?us-ascii?Q?nmHHRCU2QZ0nQ2Qp6Ncc8UGsLIi/AgTXCxEnFRCOVULJDke6abPFNYQAP3nG?=
 =?us-ascii?Q?Ve1wND9R4qrxyqxADOHwlJDjmqTgT/ELm9P6wBItRCUaCTK6GGFDOo8rrpj4?=
 =?us-ascii?Q?ZU0VnMV4/1RfTpVa8mKF1ngcDZCd9RNT2iZrj1SHAb3pf2UenwpzFCChDdlo?=
 =?us-ascii?Q?dSYLd2pcyVEfhGNPKRBUpkYPfR/dmdLrjiV3kYJKUGMT8XjOTW9yuvq//4kW?=
 =?us-ascii?Q?psmw48pX46/GbrLdAYu63ldxgjDZ3+GAXFGjAG/IyVLK7SOqlAuwxc5691m3?=
 =?us-ascii?Q?I1ehTbQmmafD3cWHMEpRfo7h6ya5z7E51eNENzbYXvnyNTRovR6N3wne2VLE?=
 =?us-ascii?Q?r8jmcar++aekwrUqOXyblGx2KS747Pe/Efc2jRRauuwDqfvz2LGNYVC1POoW?=
 =?us-ascii?Q?qU82bbjWCwB/Cj2/jBaMCR8HbaEwm25eyhC3p8ViagyCRaQ1UkUPUapBYKF5?=
 =?us-ascii?Q?zSfy0HnPeZSUXIIjfWqWNRxG1882cAFhwZaW9BnUACBcLpYRi8tyc2FvXCje?=
 =?us-ascii?Q?Zc2CaryeSVznTivE7wJeVCL2YEc/cbUDl+m8Fj21oYo6NTjkc/aurovQc1Go?=
 =?us-ascii?Q?opMSPmKGuhrvQJlBsBW69j+UOUOX6dT0FADHvcq6V0x1O/Khiipst2wj+/vO?=
 =?us-ascii?Q?4zHKjqZOE2S88Rv3YIIb/2plRyG32gVO8XM29jrYJf+PvtmQGu1iXLZ1plWR?=
 =?us-ascii?Q?khVWyia83k8HmmshiI/3orB7EqnzE7NXRHddGNtRn3pLvvZkKHgtusTCv8kQ?=
 =?us-ascii?Q?D+D7avONtOU6MQ2VsKS3/VIWzhc9mjZyMQTStxS/ZhlOtmWfSidDxbvbNhSO?=
 =?us-ascii?Q?G8wwlxGcBmHD2EMIM1QAQXc0cHJqDC7ZdLB0XBhh134ONeZTGzsKjCmguT35?=
 =?us-ascii?Q?ZOVaB+jAPQq7NRO7mn2fYSEp9xVsnTFFUEZs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:30:11.9881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66905a73-5320-41a4-048e-08dd78d313be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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

This patch refactors the SDMA v5.x queue reset and stop logic to improve
code readability, maintainability, and performance. The key changes include:

1. **Generalized `sdma_v5_x_gfx_stop` Function**:
   - Added an `inst_mask` parameter to allow stopping specific SDMA instances
     instead of all instances. This is useful for resetting individual queues.

2. **Simplified `sdma_v5_x_reset_queue` Function**:
   - Removed redundant loops and checks by directly using the `ring->me` field
     to identify the SDMA instance.
   - Reused the `sdma_v5_x_gfx_stop` function to stop the queue, reducing code
     duplication.

v1: The general coding style is to declare variables like "i" or "r" last. E.g. longest lines first and short lasts. (Chritian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 31 ++++++++------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 27 ++++++++--------------
 2 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index bef80b318f8e..11dfa0b7544d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -557,15 +557,15 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
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
@@ -657,9 +657,11 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
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
 
@@ -1546,33 +1548,18 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
 {
-	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, stat1_reg;
+	u32 f32_cntl, freeze, cntl, stat1_reg;
 	struct amdgpu_device *adev = ring->adev;
 	int i, j, r;
 
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
+	i = ring->me;
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* stop queue */
-	ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
-	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
-
-	rb_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
-	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+	sdma_v5_0_gfx_stop(adev, 1 << i);
 
 	/* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
 	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 4cd7010ad0d7..db6630c3f30a 100644
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
 
@@ -1459,29 +1461,18 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
 {
+	u32 rb_cntl, f32_cntl, freeze, cntl, stat1_reg;
 	struct amdgpu_device *adev = ring->adev;
 	int i, j, r;
-	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, stat1_reg;
 
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
+	i = ring->me;
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* stop queue */
-	ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
-	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-	WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+	sdma_v5_2_gfx_stop(adev, 1 << i);
 
 	rb_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
 	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-- 
2.25.1

