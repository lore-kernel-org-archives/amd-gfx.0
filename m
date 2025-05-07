Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E2CC3ABC3
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 15:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4330210E83F;
	Wed,  7 May 2025 15:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CdqhT0Bh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46BE510E83D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 15:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TI7GuLeQTPQOum4hVHRDTEyK5tHPFS1kKuwtKFFs4jYmDzgEirU0Sf9sVGAUbknNrLUfxDwd4zRAr/y5WRhbc4GCGBJuao8DnOA57iS0PcaMKeovdHSwFUfkUqWPuW8wsyWGDY4lT0V2ijCPSakmxSb5hn7RYf5wjqrPZF2fsPavm6rJs5zFsTLHmih0EzemnOyrVEaf3LvSmTJlurUNg7gPwQ5LMqAj98xDdU5tUK6V+luiqxJhSjh+hsT6d9gFFEg8i6Z5BoXlktST2vjaYgL92CI9xp3LWHYa7B4eiv4j3bygJGCAGXsWHZwVRp0zXXeAqiadGz2YXSwNoUFpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NCZpAxY+l2ufXt19B3cCk1s8ws+HbqmAxlYDM2Vg5I=;
 b=VICtBB4LsabER9px1/gmM7tjZIIpW4Ic2LBY/rgTeV6LAe05q4EhJRg99O36i8gNwu5iA1zhGdl0nnXKoi8+xqkxpyTaxxWUgKou0DmvFH4qa0tu2nTQPiENpYvWx/6z+nQGXWv2OXEFgnYnysxXIgMZZQqrz4Fo+jC/2sPAXjklQeTm7D7+4D1bwUSdWSu7Y3VdZniFheYK7pmzD5/U3A+K2PwERFuAzJ50liWyF4+6Fv6hP0HXUy5fPaHcTeiOjzIwQ5oy3eCv+nUHz8iwCfftHvhTuYFoGXHX48MqnqY0m8YMR+PvRaJLqzo9HjpYESeest9MOiq12WYAOzdrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NCZpAxY+l2ufXt19B3cCk1s8ws+HbqmAxlYDM2Vg5I=;
 b=CdqhT0BhoTE6v1M612stAzJ1w+P+sz6N+TannqB40n0YsSEH4uXTZRj7ZQhlF+3+v5caHdr6UT0nmHTy+Sanmy1PeLovvx3jfTrm0BOANGx1cDF8iiiUsy0T0peo3HzhqUnuWXpGYftNr1GNWa4wBdSEIZ3dP+vLy+DaImpKvc8=
Received: from PH7PR17CA0038.namprd17.prod.outlook.com (2603:10b6:510:323::17)
 by BN7PPF521FFE181.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Wed, 7 May
 2025 15:27:25 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::53) by PH7PR17CA0038.outlook.office365.com
 (2603:10b6:510:323::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Wed,
 7 May 2025 15:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 15:27:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 10:27:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] Revert "drm/amdgpu: Use generic hdp flush function"
Date: Wed, 7 May 2025 11:27:04 -0400
Message-ID: <20250507152710.234881-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4f4757-bf2c-4624-4b75-08dd8d7bab29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OBCb2SWyg5pzdvZ2rx9YAzvegvhDhR3MMagpkMqGgUNVdCe53nYM9+Qp7nPB?=
 =?us-ascii?Q?DRcaJ8NSMgh0NWAFpbSM/Zri220voAvqjqUKSL23TmtUJaLsVt+Qzm4/nAC3?=
 =?us-ascii?Q?ZoK8O/HbeC+6/+ibnvhy3v6HvbJvSWUizV5tAud3V4iUdJjHCpqR2TIdPwjV?=
 =?us-ascii?Q?HzhRA/h3ORxFsRYx1XC+zQspeWgA7c1OXDGpI2X+E26QRoXSxkYmAdcNpBoT?=
 =?us-ascii?Q?AuEAybALHm8vNv4Rri0ONg8DO7ga6JjBH9RT3goDkpsd5go1h4QMv7cDflKp?=
 =?us-ascii?Q?d4SmNFA0bGCRuXVdUntWLlJh4BS+DXP6tGsHP6v6XNNomj108TIoKDY5OTCQ?=
 =?us-ascii?Q?3jRP6orrINPy0s/pr+v1sJ/GZT/X8ejxQHvyF01MstkEProJTvrlp75gsU+K?=
 =?us-ascii?Q?xBPczhzQXjIu7FEOtYRjA82sot+SfbDnyugwxcNT4pz067q2YE5WTpw6gdQp?=
 =?us-ascii?Q?oHrvGkRTzr+dfMGftJymOwFS2BbeTrPb24fJn2QsJ68oLWKhYMri9W9mUlIW?=
 =?us-ascii?Q?acA6I9lme8D4ttF+7HJk1zjwLldM1vxFM0R4W0kD+pVb8o1lhMQu27IBoPfT?=
 =?us-ascii?Q?AtMZTGPRd8eY4UEtE6GJNJq/8w+nCPivczluJyUNwvFfRBXBOt1oyzwujxOw?=
 =?us-ascii?Q?Ij997UjB6CKs2vYTaydW/BMms03sCyS7GVB2MfH714JAxr/4D31ImsoXm+IM?=
 =?us-ascii?Q?lXpqPChv3r2J6NpIdWn8en0xXpzH6fb8TtyzAzyUga7lJXcDiYe44L0NPd8w?=
 =?us-ascii?Q?XDIpSerotLsfsrpW6T+us/6L54c0o1uN39Q0iWkmUIv52V/4ASTqwEdnK0wi?=
 =?us-ascii?Q?y4aoRKqScbCk8iYAiqNmiTT/Ku6RDn7unfIrMiOVDufzGOaL7Zb/zqBveIN+?=
 =?us-ascii?Q?zPBaXzT5en+EIXnFPEWzB5cuWfvFyePZtrV3fpuBpWXuH66f4yNyDWmDzYOG?=
 =?us-ascii?Q?rb/VKHfK2wkEHwxjFHDD8d6eYiWCdq3X+3ufwVMc84rP13cPN/ZDX4P2Efg9?=
 =?us-ascii?Q?L3uoNWK8JF9mmPQ8A+MTaspKuFsL2Dzxl2pNFb7alL+t8HRCsgzQk8yPt1Ca?=
 =?us-ascii?Q?h4VEzmyDaZ1VQT8Q7oEQBsBkqQKzzTVd4vCe9Vjzw8Vidmb/zn2EqR7P7PJb?=
 =?us-ascii?Q?jpzv812z0qt2qO1fSHlVNoMBFfeY2MJJ8ZqW2z/D1qi+bsJP1CmEf4AQgRWO?=
 =?us-ascii?Q?owPt8ph2bih/Z3CWM9kDgdce/n8LbvpPrYPTEiTm/0V0GSj/442u+E3k8TrC?=
 =?us-ascii?Q?030p5NqGJxhnLMxlhrsn0mGhcJwXonjDzSt9kaL2spLVX6E2lsHj11EGO5BC?=
 =?us-ascii?Q?23+WyXZRF3mXYAJvFHgpVjGOKGh+2Y3TGJyuv2clw1Y+oV6lq62TJEDx2hHU?=
 =?us-ascii?Q?/9Tff9nHYoIOKs2+2mQQZ5o6ADRQtrKzL5oMAMnegHjdyg6a8MTIERD4pFKT?=
 =?us-ascii?Q?y0DV0tDLdv/WutM1VFOYLWIXHnBXJUNBQJHRkyqD2a7czsUbxVfSZ48USyCw?=
 =?us-ascii?Q?Frwu6yyqU2tVMeNjXBX/7OhZHukBh897tBUg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:27:24.7936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4f4757-bf2c-4624-4b75-08dd8d7bab29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
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

This reverts commit 18a878fd8aef0ec21648a3782f55a79790cd4073.

Revert this temporarily to make it easier to fix a regression
in the HDP handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 21 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 --
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 13 ++++++++++++-
 6 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 7fd8f09c28e66..b6cf801939aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -22,7 +22,6 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
-#include <uapi/linux/kfd_ioctl.h>
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 {
@@ -47,23 +46,3 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 	/* hdp ras follows amdgpu_ras_block_late_init_default for late init */
 	return 0;
 }
-
-void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
-			      struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset +
-			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
-			       2,
-		       0);
-		RREG32((adev->rmmio_remap.reg_offset +
-			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
-		       2);
-	} else {
-		amdgpu_ring_emit_wreg(ring,
-				      (adev->rmmio_remap.reg_offset +
-				       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
-					      2,
-				      0);
-	}
-}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 4cfd932b7e91e..7b8a6152dc8d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,6 +44,4 @@ struct amdgpu_hdp {
 };
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
-void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
-			      struct amdgpu_ring *ring);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index e6c0d86d34865..f1dc13b3ab38e 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -36,6 +36,17 @@
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
 #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
 
+static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
+}
+
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -169,7 +180,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 };
 
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
-	.flush_hdp = amdgpu_hdp_generic_flush,
+	.flush_hdp = hdp_v4_0_flush_hdp,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
 	.update_clock_gating = hdp_v4_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 8bc001dc9f631..43195c0797480 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -27,6 +27,17 @@
 #include "hdp/hdp_5_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
+}
+
 static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -206,7 +217,7 @@ static void hdp_v5_0_init_registers(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_hdp_funcs hdp_v5_0_funcs = {
-	.flush_hdp = amdgpu_hdp_generic_flush,
+	.flush_hdp = hdp_v5_0_flush_hdp,
 	.invalidate_hdp = hdp_v5_0_invalidate_hdp,
 	.update_clock_gating = hdp_v5_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v5_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index ec20daf4272c5..a88d25a06c29b 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -30,6 +30,17 @@
 #define regHDP_CLK_CNTL_V6_1	0xd5
 #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
 
+static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
+}
+
 static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -138,7 +149,7 @@ static void hdp_v6_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v6_0_funcs = {
-	.flush_hdp = amdgpu_hdp_generic_flush,
+	.flush_hdp = hdp_v6_0_flush_hdp,
 	.update_clock_gating = hdp_v6_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v6_0_get_clockgating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index ed1debc035073..49f7eb4fbd117 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -27,6 +27,17 @@
 #include "hdp/hdp_7_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
+}
+
 static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -126,7 +137,7 @@ static void hdp_v7_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v7_0_funcs = {
-	.flush_hdp = amdgpu_hdp_generic_flush,
+	.flush_hdp = hdp_v7_0_flush_hdp,
 	.update_clock_gating = hdp_v7_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v7_0_get_clockgating_state,
 };
-- 
2.49.0

