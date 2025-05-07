Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97425C3ABC6
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D2810E83E;
	Wed,  7 May 2025 15:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="su36Z49z";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE5710E83D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAGJwjoQ64gk2q1OsvOQvexnKDYkRBEYdOdsVnC+uamkus6lBT7y7V8EcEeX0c4MzI9ZFIE5P1EjnYxKcO+/xEoBod6bydbeX6x6qT04rHrVHBp6Q169FbRrZohsyzUFx4qkCnr5/33DHTiqibyhgBP23trUVyVQvZAkgzAEouA3T+COmlmlvpCeGzlxirEfCSGF6E/+mv+I+K68AhEehiRTOIWRkpxMNdVwOyGWBmEVipknOC0xg9AUNzju3lE1mCmMIfzrLE67FY8x442SfoGao9dlbVeqGHXPcfY/q1FsyWgElOrzLys6eih5mR3j6910ABjlcX/g4x+MgDisaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZBt7fR6O7TAFM5sKabuQkApacKVzNNCOKC6/SOBDhM=;
 b=GJwzDqYBmxilEuC2dvmbmMFogIMISA3117sXS3Ec73rgmwuCZDtEtBVUq75jkYN25hGM4CYF1F25b+YndfCfDVnemBGpDWUat/QnJ5QXJNxoeUHlcd7YoHJWBOlvVHFA3FxZ8ZZVTBXzqexMtWtmRiHbWRdCxHlJz57s/HYrYQVQolPCZcWA3by6XFhsZuIVWz6e2m5QzXVvWEnmroCeXY8rtsFKz0QrgTqHF1z7pLBK4gnwmhRr5v0lNNyyQqFsbyyf98tLNE9Vi4xf4pubPNVcvDPZ74PJAHP9u2djhqYgU9s9lA8BFLgHEy4NXPfFOsLTqtnsAqLROSOpdTTUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZBt7fR6O7TAFM5sKabuQkApacKVzNNCOKC6/SOBDhM=;
 b=su36Z49zpf2fgZEUTrAmgxG9XTTuEh9oo3IkHq/BGQqq1CkAlnSNh1R6+VpQ6CyOTqshHj9VH/ekT83vkpDF56wVuRT2Ts6XOYvXK3/wwfHal0hRUnECed6izyNFfwaHnReaK4aiG+EDEkh4i5ZSamb5XP5AEMWooeWy4MLpSNQ=
Received: from PH7PR17CA0037.namprd17.prod.outlook.com (2603:10b6:510:323::28)
 by PH0PR12MB7981.namprd12.prod.outlook.com (2603:10b6:510:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 15:27:29 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::ec) by PH7PR17CA0037.outlook.office365.com
 (2603:10b6:510:323::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 7 May 2025 15:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 15:27:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 10:27:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 7/7] Reapply: drm/amdgpu: Use generic hdp flush function
Date: Wed, 7 May 2025 11:27:10 -0400
Message-ID: <20250507152710.234881-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507152710.234881-1-alexander.deucher@amd.com>
References: <20250507152710.234881-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH0PR12MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: d96dff29-c861-4fed-0db7-08dd8d7bae0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?88jSOVuLUuxw5H+5ntX+Lmog3ugfjP0uSjbz4NRRp/zHlwlbwWdU3BsMxJqy?=
 =?us-ascii?Q?QdTbp3InraXIyRWUdhf5hXChU9UCWcQg1MFUB63tHvlRE7CwSX1yO/B9r6VS?=
 =?us-ascii?Q?OoUvM1ntR8kTfz2NLnZYm1O4Ej8ZbgCLbQwQQQAKt2w29uCg5mEhoWtzd3u0?=
 =?us-ascii?Q?3oUjifJZwfylA6jdmRcLm4lC/Zj3jYXoQTPuPHnP0au/ZEAQXuYXuDeLJ9Dp?=
 =?us-ascii?Q?/9XbegenqZHonTb4qj0vCxauD34IDPklxnL4pZjLQl3pe+ShS6IkjY3tDWet?=
 =?us-ascii?Q?/Bpl0P8LdKVDZbWyyYTioAc8wkYv24UtIRChueayzmzXZwJIBtC1gT4eibYe?=
 =?us-ascii?Q?3E2mKHodXQQaYwuBFizDw6Ymwnxzk/KwMu6L5c4RaA8N0p3aNInneoVMyh30?=
 =?us-ascii?Q?mOGHCy6NM+zeO6BHHgX+hiz5b9H8iDzITPY/ZiDBcwzMoyuwUYqgr3QzoWPC?=
 =?us-ascii?Q?omwiTX/sgzZqmp9dYVp+/FQkggEAWU8WjV8EcgOzRy2Qe0aO7ypY2eYejW1u?=
 =?us-ascii?Q?cXOez2bU21/b7jk4hSNjbmbT1j9gm7zAa5d3NfP35V92pZ7U4ulvF4WgPJot?=
 =?us-ascii?Q?w7pP85VrBdhjGc5GOilQ7uuBWi5NgD54nymdO8p3GVmoVopYHALeB0qLHDX8?=
 =?us-ascii?Q?wysy/XgoEit24YwIJz1FCNbIG7VawpwTR+4uedPT1uNI7S54ZjzyDHHyp2ZD?=
 =?us-ascii?Q?iHr/J3hw5Kb+fkuV7/AAMQyQ0TaLN0LHYc1in77otsJ+dc1VnPwV7uV8onmt?=
 =?us-ascii?Q?zgLBcWaIp9xXqF5LMqx3ZUn6FSCbGkTeyza0YuUAMqr/0coXG5Jf6Eo72nP8?=
 =?us-ascii?Q?GGyduwKc5RiKAWP10oyATtuM9lzVbkSSBYSaG13U5sHVVjeEdb9oihTtmE5u?=
 =?us-ascii?Q?Px60OR2qHMw67GcYkqERerXgY7a02emfh1p1v85riVZ1JfY3+LQtLd3scgSw?=
 =?us-ascii?Q?IjzP+yD3QzB/EcMbLOtx6b1sXAmw0A36EvL7cGQC9E7RSyi1yQGapdwBL1P3?=
 =?us-ascii?Q?bmwvvj/BsSZ/DdC0g97GQoiG8lyJoXypHAe0DQKrcIZNgDWvmUhAMnNuuw5N?=
 =?us-ascii?Q?jSTvnjU+FuqgfHMoJoY5q9MG74X5Anf49tdi90PbXZdOpQraG9aLQe3PlpHs?=
 =?us-ascii?Q?rXPvHcbwV2ui3cTwyXIfH///dr6RRABiwNNrnHy1tMaUz/7pwc5zJONz7M2q?=
 =?us-ascii?Q?28KHyV43W2pmpvicYUm4hI8S2M+Mzvbc4591UeIrejegBL94aiaSGu1+Sb6z?=
 =?us-ascii?Q?HMNg+0uODuWykV/TAL6uSzQO+G6UE4z7XV0K0+/4abLDrpSNRuFVodUY5YqZ?=
 =?us-ascii?Q?PqNgv8kqq/bfwZfhClUnoVdB/LYuXdKgHzmwezIt7uNqUJ6Vw8sNSIzqQZK8?=
 =?us-ascii?Q?fnfPJF8vnLAuBmQscYT9jmPDUEClNEvtV3n44UAXKLbNPTCHm3ebZbVV/Gn8?=
 =?us-ascii?Q?xAO61V+t46wO/41QtKv6tTcuonCCh6ALOb+MCttDkrBBSli3Kz6fZnTW/K0g?=
 =?us-ascii?Q?Gh5dvS2rhKKnMJBOmqYayjDP7s9r+RNWMIFo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:27:29.6199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96dff29-c861-4fed-0db7-08dd8d7bae0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7981
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

From: Lijo Lazar <lijo.lazar@amd.com>

Except HDP v5.2 all use a common logic for HDP flush. Use a generic
function. HDP v5.2 forces NO_KIQ logic, revisit it later.

Reapply after fixing up an HDP regression.

v2: merge the fix

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 18 +-----------------
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 18 +-----------------
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 18 +-----------------
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 18 +-----------------
 6 files changed, 26 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index b6cf801939aa5..6e02fb9ac2f67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 {
@@ -46,3 +47,22 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 	/* hdp ras follows amdgpu_ras_block_late_init_default for late init */
 	return 0;
 }
+
+void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
+			      struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset +
+			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
+			       2,
+		       0);
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
+	} else {
+		amdgpu_ring_emit_wreg(ring,
+				      (adev->rmmio_remap.reg_offset +
+				       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
+					      2,
+				      0);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 7b8a6152dc8d9..4cfd932b7e91e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,4 +44,6 @@ struct amdgpu_hdp {
 };
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
+void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
+			      struct amdgpu_ring *ring);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index cbbeadeb53f72..e6c0d86d34865 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -36,22 +36,6 @@
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
 #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
 
-static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		/* We just need to read back a register to post the write.
-		 * Reading back the remapped register causes problems on
-		 * some platforms so just read back the memory size register.
-		 */
-		if (adev->nbio.funcs->get_memsize)
-			adev->nbio.funcs->get_memsize(adev);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -185,7 +169,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 };
 
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
-	.flush_hdp = hdp_v4_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
 	.update_clock_gating = hdp_v4_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 086a647308df0..8bc001dc9f631 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -27,22 +27,6 @@
 #include "hdp/hdp_5_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
-static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		/* We just need to read back a register to post the write.
-		 * Reading back the remapped register causes problems on
-		 * some platforms so just read back the memory size register.
-		 */
-		if (adev->nbio.funcs->get_memsize)
-			adev->nbio.funcs->get_memsize(adev);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -222,7 +206,7 @@ static void hdp_v5_0_init_registers(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_hdp_funcs hdp_v5_0_funcs = {
-	.flush_hdp = hdp_v5_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.invalidate_hdp = hdp_v5_0_invalidate_hdp,
 	.update_clock_gating = hdp_v5_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v5_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index 6ccd31c8bc692..ec20daf4272c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -30,22 +30,6 @@
 #define regHDP_CLK_CNTL_V6_1	0xd5
 #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
 
-static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		/* We just need to read back a register to post the write.
-		 * Reading back the remapped register causes problems on
-		 * some platforms so just read back the memory size register.
-		 */
-		if (adev->nbio.funcs->get_memsize)
-			adev->nbio.funcs->get_memsize(adev);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -154,7 +138,7 @@ static void hdp_v6_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v6_0_funcs = {
-	.flush_hdp = hdp_v6_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.update_clock_gating = hdp_v6_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v6_0_get_clockgating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index 2c9239a22f398..ed1debc035073 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -27,22 +27,6 @@
 #include "hdp/hdp_7_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
-static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		/* We just need to read back a register to post the write.
-		 * Reading back the remapped register causes problems on
-		 * some platforms so just read back the memory size register.
-		 */
-		if (adev->nbio.funcs->get_memsize)
-			adev->nbio.funcs->get_memsize(adev);
-	} else {
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	}
-}
-
 static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -142,7 +126,7 @@ static void hdp_v7_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v7_0_funcs = {
-	.flush_hdp = hdp_v7_0_flush_hdp,
+	.flush_hdp = amdgpu_hdp_generic_flush,
 	.update_clock_gating = hdp_v7_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v7_0_get_clockgating_state,
 };
-- 
2.49.0

